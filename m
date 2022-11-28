Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2FE63B0B3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 19:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiK1SHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiK1SGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 13:06:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451DF58BE3;
        Mon, 28 Nov 2022 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669657910; x=1701193910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W6IrZ/8bGVrH3jH1rhZvl21yo0uj8ope8p+0Md2pCZc=;
  b=ZAwj+ynPSVBlGprTf0+zFY5T/PAlqz96jLsOuDGJCrAv8FS2DrcIsl31
   NrulcKcI438wUHnf4feXvt0VRg4WBXoidfZf6YYiMDh6sdN6FpxqvWVHD
   xc875lh0QzNdfj+Dkjhu6T2mdVpNduW9Ow70C0b0VdsRTjNAU4CEN9LRZ
   dMJdzLr33X/sEXwwmaeTpp3VFfzdchmR/MYHc/Jcf9aQadZyg+LcGTy9V
   IVsVN5wfLbwpYq1mYZdwTeK8dukztU/69Y6BUVdeOtMnfJf0C8JXPH7Y2
   mZ9VwedVn/rCLOjbzsqzrEnZIhTTa3PE2tagLypZGo5fszYFqdOcpnQ4v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377050405"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="377050405"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:51:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="621140222"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="621140222"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.3.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:51:49 -0800
Date:   Mon, 28 Nov 2022 09:51:47 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <Y4T1M7vAuHdMcNiy@aschofie-mobl2>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
 <20221128040338.1936529-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128040338.1936529-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 27, 2022 at 08:03:37PM -0800, Ira Weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> pci_doe_flush_mb() does not work and is currently unused.
> 
> It does not work because each struct doe_mb is managed as part of the
> PCI device.  They can't go away as long as the PCI device exists.
> pci_doe_flush_mb() was set up to flush the workqueue and prevent any
> further submissions to the mailboxes when the PCI device goes away.
> Unfortunately, this was fundamentally flawed.  There was no guarantee
> that a struct doe_mb remained after pci_doe_flush_mb() returned.
> Therefore, the doe_mb state could be invalid when those threads waiting
> on the workqueue were flushed.
> 
> Fortunately the current code is safe because all callers make a
> synchronous call to pci_doe_submit_task() and maintain a reference on
> the PCI device.  Therefore pci_doe_flush_mb() is effectively unused.
> 
> Rather than attempt to fix pci_doe_flush_mb() just remove the dead code
> around pci_doe_flush_mb().

The commit message says "Remove ...." and the commit log only
talks about removing code, yet an msleep() is added.
Can those be clearer?

> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V2:
> 	Lukas
> 		Clarify commit message.
> 	Jonathan
> 		Add comment for changed poll interval.
> ---
>  drivers/pci/doe.c | 49 +++++------------------------------------------
>  1 file changed, 5 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e402f05068a5..685e7d26c7eb 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -24,10 +24,10 @@
>  
>  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
>  #define PCI_DOE_TIMEOUT HZ
> -#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> +/* Interval to poll mailbox status */
> +#define PCI_DOE_POLL_INTERVAL_MSECS	8
>  
> -#define PCI_DOE_FLAG_CANCEL	0
> -#define PCI_DOE_FLAG_DEAD	1
> +#define PCI_DOE_FLAG_DEAD	0
>  
>  /**
>   * struct pci_doe_mb - State for a single DOE mailbox
> @@ -53,15 +53,6 @@ struct pci_doe_mb {
>  	unsigned long flags;
>  };
>  
> -static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
> -{
> -	if (wait_event_timeout(doe_mb->wq,
> -			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> -			       timeout))
> -		return -EIO;
> -	return 0;
> -}
> -
>  static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
>  {
>  	struct pci_dev *pdev = doe_mb->pdev;
> @@ -82,12 +73,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
>  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
>  
>  	do {
> -		int rc;
>  		u32 val;
>  
> -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> -		if (rc)
> -			return rc;
> +		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
>  		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
>  
>  		/* Abort success! */
> @@ -278,11 +266,7 @@ static void doe_statemachine_work(struct work_struct *work)
>  			signal_task_abort(task, -EIO);
>  			return;
>  		}
> -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> -		if (rc) {
> -			signal_task_abort(task, rc);
> -			return;
> -		}
> +		msleep_interruptible(PCI_DOE_POLL_INTERVAL_MSECS);
>  		goto retry_resp;
>  	}
>  
> @@ -383,21 +367,6 @@ static void pci_doe_destroy_workqueue(void *mb)
>  	destroy_workqueue(doe_mb->work_queue);
>  }
>  
> -static void pci_doe_flush_mb(void *mb)
> -{
> -	struct pci_doe_mb *doe_mb = mb;
> -
> -	/* Stop all pending work items from starting */
> -	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> -
> -	/* Cancel an in progress work item, if necessary */
> -	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> -	wake_up(&doe_mb->wq);
> -
> -	/* Flush all work items */
> -	flush_workqueue(doe_mb->work_queue);
> -}
> -
>  /**
>   * pcim_doe_create_mb() - Create a DOE mailbox object
>   *
> @@ -450,14 +419,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  		return ERR_PTR(rc);
>  	}
>  
> -	/*
> -	 * The state machine and the mailbox should be in sync now;
> -	 * Set up mailbox flush prior to using the mailbox to query protocols.
> -	 */
> -	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
>  	rc = pci_doe_cache_protocols(doe_mb);
>  	if (rc) {
>  		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> -- 
> 2.37.2
> 
