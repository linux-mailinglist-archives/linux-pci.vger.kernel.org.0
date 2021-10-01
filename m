Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2822241F639
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJAUUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 16:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhJAUUI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 16:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFB5C61247;
        Fri,  1 Oct 2021 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633119504;
        bh=c46j00fAmuNM9GFAqS4+ixKscZuoTge9mONuCRSHgsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nIhV2tJkthXGldr92MDC8V8Vd3hHGUc4XtcFJB3sNakNLzBiKsDlexSr0wgusKGso
         Y0KTbKE9QhCt97FiRWA6Ma7fcyWYGYwERIN9G36Ks38Oq1dYOKOMUQ7SrSbvhTXXmT
         qBKkUMCoEguMuMggNAd5YQnFcgX4yt+zlJd1I1eBKvDSVDeVXySBlFpzO398G8s4sH
         U2OecUFb6EY4ysIt7ysp7AKMnIKrsSRRIEHjnUkZf9Ii0DH1xv7dmxGjOKB8RBqY9w
         UVsXg1wNm+qOFbHoduW2hROH/+CRaPl5IhtjjVFVID0vQITJEXIV49PBhjqe/1QlEA
         dlfGa6/77K52w==
Date:   Fri, 1 Oct 2021 15:18:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211001201822.GA962472@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924110842.6323-2-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:08:38AM +0000, kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> After a firmware hard reset, MRPC command executions, which are based
> on the PCI BAR (which Microchip refers to as GAS) read/write, will hang
> indefinitely. This is because after a reset, the host will fail all GAS
> reads (get all 1s), in which case the driver won't get a valid MRPC
> status.

Trying to write a merge commit log for this, but having a hard time
summarizing it.  It sounds like it covers both Switchtec-specific
(firmware and MRPC commands) and generic PCIe behavior (MMIO read
failures).

This has something to do with a firmware hard reset.  What is that?
Is that like a firmware reboot?  A device reset, e.g., FLR or
secondary bus reset, that causes a firmware reboot?  A device reset
initiated by firmware?

Anyway, apparently when that happens, MMIO reads to the switch fail
(timeout or error completion on PCIe) for a while.  If a device reset
is involved, that much is standard PCIe behavior.  And the driver sees
~0 data from those failed reads.  That's not part of the PCIe spec,
but is typical root complex behavior.

But you said the MRPC commands hang indefinitely.  Presumably MMIO
reads would start succeeding eventually when the device becomes ready,
so I don't know how that translates to "indefinitely."

Weird to refer to a PCI BAR as "GAS".  Maybe expanding the acronym
would help it make sense.

What does "host" refer to?  I guess it's the switch (the
switchtec_dev), since you say it fails MMIO reads?

Naming comment below.

> Add a read check to GAS access when a MRPC command execution doesn't
> response timely, error out if the check fails.
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> ---
>  drivers/pci/switch/switchtec.c | 59 ++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 0b301f8be9ed..092653487021 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -45,6 +45,7 @@ enum mrpc_state {
>  	MRPC_QUEUED,
>  	MRPC_RUNNING,
>  	MRPC_DONE,
> +	MRPC_IO_ERROR,
>  };
>  
>  struct switchtec_user {
> @@ -66,6 +67,13 @@ struct switchtec_user {
>  	int event_cnt;
>  };
>  
> +static int check_access(struct switchtec_dev *stdev)
> +{
> +	u32 device = ioread32(&stdev->mmio_sys_info->device_id);
> +
> +	return stdev->pdev->device == device;
> +}

Didn't notice this before, but the "check_access()" name is not very
helpful because it doesn't give a clue about what the return value
means.  Does 0 mean no error?  Does 1 mean no error?  From reading the
implementation, I can see that 0 is actually the error case, but I
can't tell from the name.

>  static struct switchtec_user *stuser_create(struct switchtec_dev *stdev)
>  {
>  	struct switchtec_user *stuser;
> @@ -113,6 +121,7 @@ static void stuser_set_state(struct switchtec_user *stuser,
>  		[MRPC_QUEUED] = "QUEUED",
>  		[MRPC_RUNNING] = "RUNNING",
>  		[MRPC_DONE] = "DONE",
> +		[MRPC_IO_ERROR] = "IO_ERROR",
>  	};
>  
>  	stuser->state = state;
> @@ -184,6 +193,21 @@ static int mrpc_queue_cmd(struct switchtec_user *stuser)
>  	return 0;
>  }
>  
> +static void mrpc_cleanup_cmd(struct switchtec_dev *stdev)
> +{
> +	/* requires the mrpc_mutex to already be held when called */
> +	struct switchtec_user *stuser = list_entry(stdev->mrpc_queue.next,
> +						   struct switchtec_user, list);
> +
> +	stuser->cmd_done = true;
> +	wake_up_interruptible(&stuser->cmd_comp);
> +	list_del_init(&stuser->list);
> +	stuser_put(stuser);
> +	stdev->mrpc_busy = 0;
> +
> +	mrpc_cmd_submit(stdev);
> +}
> +
>  static void mrpc_complete_cmd(struct switchtec_dev *stdev)
>  {
>  	/* requires the mrpc_mutex to already be held when called */
> @@ -223,13 +247,7 @@ static void mrpc_complete_cmd(struct switchtec_dev *stdev)
>  		memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
>  			      stuser->read_len);
>  out:
> -	stuser->cmd_done = true;
> -	wake_up_interruptible(&stuser->cmd_comp);
> -	list_del_init(&stuser->list);
> -	stuser_put(stuser);
> -	stdev->mrpc_busy = 0;
> -
> -	mrpc_cmd_submit(stdev);
> +	mrpc_cleanup_cmd(stdev);
>  }
>  
>  static void mrpc_event_work(struct work_struct *work)
> @@ -246,6 +264,23 @@ static void mrpc_event_work(struct work_struct *work)
>  	mutex_unlock(&stdev->mrpc_mutex);
>  }
>  
> +static void mrpc_error_complete_cmd(struct switchtec_dev *stdev)
> +{
> +	/* requires the mrpc_mutex to already be held when called */
> +
> +	struct switchtec_user *stuser;
> +
> +	if (list_empty(&stdev->mrpc_queue))
> +		return;
> +
> +	stuser = list_entry(stdev->mrpc_queue.next,
> +			    struct switchtec_user, list);
> +
> +	stuser_set_state(stuser, MRPC_IO_ERROR);
> +
> +	mrpc_cleanup_cmd(stdev);
> +}
> +
>  static void mrpc_timeout_work(struct work_struct *work)
>  {
>  	struct switchtec_dev *stdev;
> @@ -257,6 +292,11 @@ static void mrpc_timeout_work(struct work_struct *work)
>  
>  	mutex_lock(&stdev->mrpc_mutex);
>  
> +	if (!check_access(stdev)) {
> +		mrpc_error_complete_cmd(stdev);
> +		goto out;
> +	}
> +
>  	if (stdev->dma_mrpc)
>  		status = stdev->dma_mrpc->status;
>  	else
> @@ -544,6 +584,11 @@ static ssize_t switchtec_dev_read(struct file *filp, char __user *data,
>  	if (rc)
>  		return rc;
>  
> +	if (stuser->state == MRPC_IO_ERROR) {
> +		mutex_unlock(&stdev->mrpc_mutex);
> +		return -EIO;
> +	}
> +
>  	if (stuser->state != MRPC_DONE) {
>  		mutex_unlock(&stdev->mrpc_mutex);
>  		return -EBADE;
> -- 
> 2.25.1
> 
