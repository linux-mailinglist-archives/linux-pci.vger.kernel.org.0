Return-Path: <linux-pci+bounces-24689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B9A707DB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859F616C281
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79741E5B9E;
	Tue, 25 Mar 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSmUM0SX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BA2E339B
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923026; cv=none; b=ieP/vCMVifvGq81uONFcziKGNDjs1SZGVGzLGjthgwqytWvP9Y1VNqhYbeIjeO/59K5OVUEP/Zg5LG7Sx71rdNQ3Q1oV+nmRZ11j/r62obGiCw6yHRr0qD0Rtc/bM8ZErFlBqjlraFt+bglRXG7cFo1YZ2QqOjLoSMLVO+tlRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923026; c=relaxed/simple;
	bh=9mcoMDyBWFl0a/dOp+AqVBoRDr3yZZEYgEx53/56OwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtLAV/F2fIf8C1UhCxXJgV5T0QLMqhsLw6Niodu5s0i8xKdiaQMIyJwhZiTmsxpvmmtIRBQs2xcLm47asxiXyHKyM+PFxhVGpRnF85HA1Bk4cXwb8NWAnyL/exs7/dEifJRrFI58DLYXsOyGnH+Ym77ycPIDYWyNDKaW5/R8804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSmUM0SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBEAC4CEEA;
	Tue, 25 Mar 2025 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742923026;
	bh=9mcoMDyBWFl0a/dOp+AqVBoRDr3yZZEYgEx53/56OwI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GSmUM0SXBQyjpep0aTp7L6pU7HePL5WDLo3WtLMP8uqAJLj9CQQMKghqLx6hnIVh8
	 0e5seIUj8yRSk7koUNpB0ej92GNlbijyuOoWl64IBZIehbaXEamPr8sDbL3y0ot++0
	 SrKF5L+yXSyyOJRoVof46jk7XqTDT3lBxzoNE/TxCJyRiBv1kZXQVZ6lKwKxug1skR
	 60rAJjqg+rmmDyDLFdToSoexq2CocUai4rQ2ucMTMnKGvtjZd7dBoKlx++h6edIZfc
	 EH6VogVgcmQ+zRyYwVrTlIoK/AYG+gugFWeSWOSLw/ewWS+uOQ6FAeVxIDHG0yGxg9
	 MGINpBL+t3onA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6393CE0843; Tue, 25 Mar 2025 10:17:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:17:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <614abb3f-fd4f-40e1-8e22-3c58bc2314b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250321015806.954866-1-pandoh@google.com>
 <20250321015806.954866-7-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321015806.954866-7-pandoh@google.com>

On Thu, Mar 20, 2025 at 06:58:04PM -0700, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).
> 
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reported-by: Sargun Dhillon <sargun@meta.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Just taking a closer look.  There are some things that I would do
differently, but I don't see any show-stoppers here.

I don't see this patch series in -next, which is fine:  This is not
so urgent that I would want to drive it into the current merge window.
I am hoping that it goes into -next as soon as v6.14-rc1 comes out.

> ---
>  drivers/pci/pci.h      |  4 +-
>  drivers/pci/pcie/aer.c | 87 ++++++++++++++++++++++++++++++++----------
>  drivers/pci/pcie/dpc.c |  2 +-
>  3 files changed, 71 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9d63d32f041c..f709290e9e00 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>  
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> +	bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];

In my stop-the-bleeding patch, I pass this as an argument to the functions
needing it, but this works fine too.  Yes, this approach does consume
a bit more storage, but I doubt that it is enough to matter.

The main concern is that either all information for a given error is
printed or none of it is, to avoid confusion.  (There will of course be
the possibility of partial drops due to buffer overruns further down
the console-log pipeline, but no need for additional opportunities
for confusion.)

For this boolean array to provide this property, the error path for a
given device must be single threaded, for example, only one interrupt
handler at a time.  Is this the case?

>  	int error_dev_num;
>  
>  	unsigned int id:16;
> @@ -552,7 +553,8 @@ struct aer_err_info {
>  
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> +		     const char *level, bool ratelimited);

And here you do pass it in.

>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f657edca8769..e0f526960134 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/kfifo.h>
> +#include <linux/ratelimit.h>
>  #include <linux/slab.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> @@ -88,6 +89,10 @@ struct aer_report {
>  	u64 rootport_total_cor_errs;
>  	u64 rootport_total_fatal_errs;
>  	u64 rootport_total_nonfatal_errs;
> +
> +	/* Ratelimits for errors */
> +	struct ratelimit_state cor_log_ratelimit;
> +	struct ratelimit_state uncor_log_ratelimit;

Separate per-device rate limiting for correctable and uncorrectable
errors, very good!

>  };
>  
>  #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> @@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
>  
>  	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
>  
> +	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +
>  	/*
>  	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>  	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -668,6 +678,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  	}
>  }
>  
> +static bool aer_ratelimited(struct pci_dev *dev, unsigned int severity)
> +{
> +	struct ratelimit_state *ratelimit;
> +
> +	if (severity == AER_CORRECTABLE)
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
> +	else
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
> +
> +	return !__ratelimit(ratelimit);
> +}

Initialization and single is-it-ratelimited function, good.

> +
>  static void __aer_print_error(struct pci_dev *dev,
>  			      struct aer_err_info *info,
>  			      const char *level)
> @@ -693,11 +715,17 @@ static void __aer_print_error(struct pci_dev *dev,
>  }
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> -		     const char *level)
> +		     const char *level, bool ratelimited)
>  {
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
>  
> +	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +			info->severity, info->tlp_header_valid, &info->tlp);

Unconditional tracing, as before.  I cannot imagine that moving this to
the top of the function hurts anything.

> +	if (ratelimited)
> +		return;
> +
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>  			aer_error_severity_string[info->severity]);
> @@ -722,21 +750,31 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>  out:
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>  		pci_err(dev, "  Error of this Agent is reported first\n");
> -
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> -			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
>  static void aer_print_rp_info(struct pci_dev *rp, struct aer_err_info *info)
>  {
>  	u8 bus = info->id >> 8;
>  	u8 devfn = info->id & 0xff;
> +	struct pci_dev *dev;
> +	bool ratelimited = false;
> +	int i;
>  
> -	pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +	/* extract endpoint device ratelimit */
> +	for (i = 0; i < info->error_dev_num; i++) {
> +		dev = info->dev[i];
> +		if (info->id == pci_dev_id(dev)) {
> +			ratelimited = info->ratelimited[i];
> +			break;
> +		}
> +	}

I cannot resist noting that passing a "ratelimited" argument to this
function would make it unnecessary to search this array.  This would
require doing rate-limiting checks in aer_isr_one_error(), which looks
like it should work.  Then again, I do not claim to be familiar with
this AER code.

The "ratelimited" arguments would need to be added to
aer_print_port_info(), aer_process_err_devices(), and aer_print_error().
Maybe some that I have missed.  Or is there some handoff to
softirq or workqueues that I missed?

> +	if (!ratelimited)
> +		pci_info(rp, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +			 info->multi_error_valid ? "Multiple " : "",
> +			 aer_error_severity_string[info->severity],
> +			 pci_domain_nr(rp->bus), bus, PCI_SLOT(devfn),
> +			 PCI_FUNC(devfn));
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -784,6 +822,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	pci_dev_aer_stats_incr(dev, &info);
>  
> +	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +			aer_severity, tlp_header_valid, &aer->header_log);
> +
> +	if (aer_ratelimited(dev, aer_severity))
> +		return;

PCIe suffices for our use case, but symmetry is not a bad thing.

>  	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>  	__aer_print_error(dev, &info, level);
>  	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -795,9 +839,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	if (tlp_header_valid)
>  		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> -
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>  
> @@ -808,8 +849,12 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   */
>  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  {
> -	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> -		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> +	int dev_idx = e_info->error_dev_num;
> +	unsigned int severity = e_info->severity;
> +
> +	if (dev_idx < AER_MAX_MULTI_ERR_DEVICES) {
> +		e_info->dev[dev_idx] = pci_dev_get(dev);
> +		e_info->ratelimited[dev_idx] = aer_ratelimited(dev, severity);
>  		e_info->error_dev_num++;
>  		return 0;
>  	}
> @@ -1265,7 +1310,8 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
>  			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
> -			aer_print_error(e_info->dev[i], e_info, level);
> +			aer_print_error(e_info->dev[i], e_info, level,
> +					e_info->ratelimited[i]);
>  		}
>  	}
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> @@ -1299,10 +1345,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  			e_info.multi_error_valid = 1;
>  		else
>  			e_info.multi_error_valid = 0;
> -		aer_print_rp_info(pdev, &e_info);
>  
> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_rp_info(pdev, &e_info);
>  			aer_process_err_devices(&e_info, KERN_WARNING);
> +		}
>  	}

And here we are in the interrupts handler.

>  	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1318,10 +1365,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  		else
>  			e_info.multi_error_valid = 0;
>  
> -		aer_print_rp_info(pdev, &e_info);
> -
> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_rp_info(pdev, &e_info);
>  			aer_process_err_devices(&e_info, KERN_ERR);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 81cd6e8ff3a4..42a36df4a651 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -290,7 +290,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
>  		pci_dev_aer_stats_incr(pdev, &info);
> -		aer_print_error(pdev, &info, KERN_ERR);
> +		aer_print_error(pdev, &info, KERN_ERR, false);

And we don't throttle DPC errors.  No opinion on this one.

>  		pci_aer_clear_nonfatal_status(pdev);
>  		pci_aer_clear_fatal_status(pdev);
>  	}
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

