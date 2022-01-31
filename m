Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207814A5259
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 23:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiAaW2L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 17:28:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:33652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbiAaW2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 17:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643668091; x=1675204091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9WLB85i0owrYX8M10oRGSSx6TtdTOtxPK//pnDqDdY0=;
  b=LHATsvKZni0aITeMldpTXpwWRtacq3mvOejLCyiXyrNBIVQgYlxj6w6e
   fOB5RnPIg+6X8eJ3+XIw/7Dmmo2RwrCfQ6TSnohgxc9VOcb5KEceFnGVg
   P7nu+EWftjab7cA4Oq1sQ+S12WKSW8OKWbJXDcoV3+h7kIIWTTKISLD4a
   ixAZ915N6WAppvMq+sufsjKJGPK+EATYityYbPdFymXXQHrrrruX62eDD
   +ZdSlBsSkcJfG/QrNYCEac8O7smhYwzEDo6LEz51PnXgjU6X9Du9hxuhI
   JOb+G99ru7Rk1KPdBJHmMyhAhQXtio4IEhawU/RCOyZ/yy4beU8+ySN/6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247333552"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247333552"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:28:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="534328236"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:28:10 -0800
Date:   Mon, 31 Jan 2022 14:28:08 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 03/40] cxl/pci: Defer mailbox status checks to command
 timeouts
Message-ID: <20220131222808.kipxr7ezpyhw2y5p@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298413480.3018233.9643395389297971819.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298413480.3018233.9643395389297971819.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:28:54, Dan Williams wrote:
> Device status can change without warning at any point in time. This
> effectively means that no amount of status checking before a command is
> submitted can guarantee that the device is not in an error condition
> when the command is later submitted. The clearest signal that a device
> is not able to process commands is if it fails to process commands.
> 
> With the above understanding in hand, update cxl_pci_setup_mailbox() to
> validate the readiness of the mailbox once at the beginning of time, and
> then use timeouts and busy sequencing errors as the only occasions to
> report status.
> 
> Just as before, unless and until the driver gains a reset recovery path,
> doorbell clearing failures by the device are fatal to mailbox
> operations.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |  134 +++++++++++++----------------------------------------
>  1 file changed, 33 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ed8de9eac970..91de2e4aff6f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -73,14 +73,16 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> -static void cxl_pci_mbox_timeout(struct cxl_dev_state *cxlds,
> -				 struct cxl_mbox_cmd *mbox_cmd)
> -{
> -	struct device *dev = cxlds->dev;
> +#define cxl_err(dev, status, msg)                                        \
> +	dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
> +			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> +			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>  
> -	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> -		mbox_cmd->opcode, mbox_cmd->size_in);
> -}
> +#define cxl_cmd_err(dev, cmd, status, msg)                               \
> +	dev_err_ratelimited(dev, msg " (opcode: %#x), device state %s%s\n",    \
> +			    (cmd)->opcode,                                     \
> +			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> +			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>  
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
> @@ -134,7 +136,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  
>  	/* #1 */
>  	if (cxl_doorbell_busy(cxlds)) {
> -		dev_err_ratelimited(dev, "Mailbox re-busy after acquiring\n");
> +		u64 md_status =
> +			readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> +			    "mailbox queue busy");
>  		return -EBUSY;
>  	}
>  
> @@ -160,7 +166,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	/* #5 */
>  	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
>  	if (rc == -ETIMEDOUT) {
> -		cxl_pci_mbox_timeout(cxlds, mbox_cmd);
> +		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status, "mailbox timeout");
>  		return rc;
>  	}
>  
> @@ -198,98 +206,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> -/**
> - * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
> - * @cxlds: The device state to gain access to.
> - *
> - * Context: Any context. Takes the mbox_mutex.
> - * Return: 0 if exclusive access was acquired.
> - */
> -static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> -{
> -	struct device *dev = cxlds->dev;
> -	u64 md_status;
> -	int rc;
> -
> -	mutex_lock_io(&cxlds->mbox_mutex);
> -
> -	/*
> -	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> -	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> -	 * bit is to allow firmware running on the device to notify the driver
> -	 * that it's ready to receive commands. It is unclear if the bit needs
> -	 * to be read for each transaction mailbox, ie. the firmware can switch
> -	 * it on and off as needed. Second, there is no defined timeout for
> -	 * mailbox ready, like there is for the doorbell interface.
> -	 *
> -	 * Assumptions:
> -	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> -	 *    it for every command.
> -	 *
> -	 * 2. If the doorbell is clear, the firmware should have first set the
> -	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> -	 *    to be ready is sufficient.
> -	 */
> -	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> -	if (rc) {
> -		dev_warn(dev, "Mailbox interface not ready\n");
> -		goto out;
> -	}
> -
> -	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> -	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> -		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> -		rc = -EBUSY;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Hardware shouldn't allow a ready status but also have failure bits
> -	 * set. Spit out an error, this should be a bug report
> -	 */
> -	rc = -EFAULT;
> -	if (md_status & CXLMDEV_DEV_FATAL) {
> -		dev_err(dev, "mbox: reported ready, but fatal\n");
> -		goto out;
> -	}
> -	if (md_status & CXLMDEV_FW_HALT) {
> -		dev_err(dev, "mbox: reported ready, but halted\n");
> -		goto out;
> -	}
> -	if (CXLMDEV_RESET_NEEDED(md_status)) {
> -		dev_err(dev, "mbox: reported ready, but reset needed\n");
> -		goto out;
> -	}
> -
> -	/* with lock held */
> -	return 0;
> -
> -out:
> -	mutex_unlock(&cxlds->mbox_mutex);
> -	return rc;
> -}
> -
> -/**
> - * cxl_pci_mbox_put() - Release exclusive access to the mailbox.
> - * @cxlds: The device state to communicate with.
> - *
> - * Context: Any context. Expects mbox_mutex to be held.
> - */
> -static void cxl_pci_mbox_put(struct cxl_dev_state *cxlds)
> -{
> -	mutex_unlock(&cxlds->mbox_mutex);
> -}
> -
>  static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
>  	int rc;
>  
> -	rc = cxl_pci_mbox_get(cxlds);
> -	if (rc)
> -		return rc;
> -
> +	mutex_lock_io(&cxlds->mbox_mutex);
>  	rc = __cxl_pci_mbox_send_cmd(cxlds, cmd);
> -	cxl_pci_mbox_put(cxlds);
> +	mutex_unlock(&cxlds->mbox_mutex);
>  
>  	return rc;
>  }
> @@ -310,11 +233,20 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	} while (!time_after(jiffies, timeout));
>  
>  	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
> -		dev_err(cxlds->dev,
> -			"timeout awaiting mailbox ready, device state:%s%s\n",
> -			md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
> -			md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
> -		return -EIO;
> +		cxl_err(cxlds->dev, md_status,
> +			"timeout awaiting mailbox ready");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/*
> +	 * A command may be in flight from a previous driver instance,
> +	 * think kexec, do one doorbell wait so that
> +	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
> +	 * source for future doorbell busy events.
> +	 */

Does this mean for background commands? Does kexec run if the current kernel is
holding a mutex?

> +	if (cxl_pci_mbox_wait_for_doorbell(cxlds) != 0) {
> +		cxl_err(cxlds->dev, md_status, "timeout awaiting mailbox idle");
> +		return -ETIMEDOUT;

It might be useful to post the return code in the mailbox status register should
this event happen.

It would be ideal if we reset the device at this point, however, it could be
actively decoding and we wouldn't know until cxl_mem driver comes up, which it
can't because this would have failed. I'm not sure how to deal with that
dependency, but it seems non-optimal to me. Perhaps it does make sense to
continue with binding the binding the driver and just removing mailbox
functionality?

>  	}
>  
>  	cxlds->mbox_send = cxl_pci_mbox_send;
> 
