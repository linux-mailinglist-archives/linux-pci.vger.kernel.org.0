Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568162EF6A7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 18:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbhAHRmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 12:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbhAHRmj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 12:42:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0AB123A61;
        Fri,  8 Jan 2021 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610127718;
        bh=GFtKttkqbdi9rYoH152XnHzKYvTSzHQHnqBH//h/mdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IUIanDAa/QqWP856QxDi8Ry4gOTDDoMSWt3E+21fwLlU/NpIFxAtz554DVs9hc4S6
         MHpIPYM3+YPyytKQR/ciIE5ulHu2yXfl9TxlDyDUkKMVJjM9ZBgYPzm1uPftDc7UOE
         LDl5tc/ctLYxiQKg9v/btnJ66RyZ6WUpQrwbAVwqv7w2w7W3MbowNtgHHmn+E7OXOT
         hg043KOVgQUkLTnVj8A0GRk1d9rm6BThgqFLR3SUV1lH5c/hcJ2PxTmrIKZelEQ/45
         Kp+hUtuHxM/2uSOz+gKoOo9o8l1hJkA11JllQJG7lSQcEpMCjwPPEiUGRag47zJ0PM
         CwnPGy5AaTXbQ==
Date:   Fri, 8 Jan 2021 11:41:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     lvying6 <lvying6@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        fanwentao@huawei.com, Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH] AER: add ratelimit for PCIe AER corrected error storm
 log print
Message-ID: <20210108174156.GA1453200@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610111940-5972-1-git-send-email-lvying6@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Loic]

On Fri, Jan 08, 2021 at 09:19:00PM +0800, lvying6 wrote:
> PCIe AER corrected error storm will flush effective system log. System
> log will hold only the same PCIe AER correted error info. Add ratelimit
> for PCIe AER corrected error make system log hold other more effective
> system log info.
> 
> Signed-off-by: lvying6 <lvying6@huawei.com>

Needs a real name, see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n361

For general tips, see https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

For my response to similar patch, see https://lore.kernel.org/r/20201204180615.GA1754610@bjorn-Precision-5520

TL;DR: we need to figure out and fix the root cause rather than
applying a band-aid.

> ---
>  drivers/pci/pcie/aer.c | 113 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 77b0f2c..ba20bb05 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -114,6 +114,76 @@ bool pci_aer_available(void)
>  	return !pcie_aer_disable && pci_msi_enabled();
>  }
>  
> +/* Not more than 2 messages every 5 seconds */
> +static DEFINE_RATELIMIT_STATE(ratelimit_aer, 5*HZ, 2);
> +
> +/*
> + * aer_ratelimit - AER log ratelimit
> + * @rs: ratelimit_state data
> + * @log_start: first aer log print statement
> + *
> + * a complete aer log is composed of log from several functions
> + * use printk_ratelimit for each aer log print statement will lose part
> + * of the aer log cause the log to be incomplete
> + *
> + * RETURNS:
> + * 0 means callbacks will be suppressed.
> + * 1 means go ahead and do it.
> + */
> +static int aer_ratelimit(struct ratelimit_state *rs, bool log_start)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!rs->interval)
> +		return 1;
> +
> +	/*
> +	 * If we contend on this state's lock then almost
> +	 * by definition we are too busy to print a message,
> +	 * in addition to the one that will be printed by
> +	 * the entity that is holding the lock already:
> +	 */
> +	if (!raw_spin_trylock_irqsave(&rs->lock, flags))
> +		return 0;
> +
> +	if (!rs->begin)
> +		rs->begin = jiffies;
> +
> +	if (time_is_before_jiffies(rs->begin + rs->interval)) {
> +		if (rs->missed) {
> +			if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
> +				printk_deferred(KERN_WARNING
> +						"%s: %d callbacks suppressed\n",
> +						__func__, rs->missed);
> +				rs->missed = 0;
> +			}
> +		}
> +		rs->begin   = jiffies;
> +		rs->printed = 0;
> +	}
> +	if (rs->burst && log_start) {
> +		rs->printed++;
> +		if (rs->burst >= rs->printed) {
> +			/* The first log is in burst range */
> +			ret = 1;
> +		} else {
> +			/* The first log is out of  burst range, account miss times */
> +			rs->missed++;
> +			ret = 0;
> +		}
> +	} else if (rs->burst && rs->burst >= rs->printed && !log_start) {
> +		/* The remaining log is in burst range */
> +		ret = 1;
> +	} else {
> +		/* The remaining log is out of burst range */
> +		ret = 0;
> +	}
> +	raw_spin_unlock_irqrestore(&rs->lock, flags);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_PCIE_ECRC
>  
>  #define ECRC_POLICY_DEFAULT 0		/* ECRC set by BIOS */
> @@ -683,14 +753,15 @@ static void __aer_print_error(struct pci_dev *dev,
>  		level = KERN_ERR;
>  	}
>  
> -	for_each_set_bit(i, &status, 32) {
> -		errmsg = strings[i];
> -		if (!errmsg)
> -			errmsg = "Unknown Error Bit";
> +	if (aer_ratelimit(&ratelimit_aer, false))
> +		for_each_set_bit(i, &status, 32) {
> +			errmsg = strings[i];
> +			if (!errmsg)
> +				errmsg = "Unknown Error Bit";
>  
> -		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
> -				info->first_error == i ? " (First)" : "");
> -	}
> +			pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
> +					info->first_error == i ? " (First)" : "");
> +		}
>  	pci_dev_aer_stats_incr(dev, info);
>  }
>  
> @@ -701,8 +772,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	const char *level;
>  
>  	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> -			aer_error_severity_string[info->severity]);
> +		if (aer_ratelimit(&ratelimit_aer, false))
> +			pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +				aer_error_severity_string[info->severity]);
>  		goto out;
>  	}
>  
> @@ -711,20 +783,23 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>  
> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> -		   aer_error_layer[layer], aer_agent_string[agent]);
> +	if (aer_ratelimit(&ratelimit_aer, false)) {
> +		pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +			   aer_error_severity_string[info->severity],
> +			   aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> -		   dev->vendor, dev->device, info->status, info->mask);
> +		pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +			   dev->vendor, dev->device, info->status, info->mask);
> +	}
>  
>  	__aer_print_error(dev, info);
>  
> -	if (info->tlp_header_valid)
> +	if (info->tlp_header_valid && aer_ratelimit(&ratelimit_aer, false))
>  		__print_tlp_header(dev, &info->tlp);
>  
>  out:
> -	if (info->id && info->error_dev_num > 1 && info->id == id)
> +	if (info->id && info->error_dev_num > 1 && info->id == id
> +			&& aer_ratelimit(&ratelimit_aer, false))
>  		pci_err(dev, "  Error of this Agent is reported first\n");
>  
>  	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> @@ -924,7 +999,8 @@ static bool find_source_device(struct pci_dev *parent,
>  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num) {
> -		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
> +		if (aer_ratelimit(&ratelimit_aer, false))
> +			pci_info(parent, "can't find device of ID%04x\n", e_info->id);
>  		return false;
>  	}
>  	return true;
> @@ -1131,7 +1207,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  			e_info.multi_error_valid = 1;
>  		else
>  			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
> +		if (aer_ratelimit(&ratelimit_aer, true))
> +			aer_print_port_info(pdev, &e_info);
>  
>  		if (find_source_device(pdev, &e_info))
>  			aer_process_err_devices(&e_info);
> -- 
> 1.8.3.1
> 
