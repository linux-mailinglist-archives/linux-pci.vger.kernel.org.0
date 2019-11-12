Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E728FF8500
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 01:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLARO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 19:17:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKLARO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 19:17:14 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1134620840;
        Tue, 12 Nov 2019 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573517833;
        bh=Kk1bpUfJbrw8Yuc6Dy5J8f/fMli5NfvcrZp5hOVBoBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s1hAzH0WnZ3iOuSUD1Co8FyXq7hWtX4kiOBtxlKaJal7t+zBvf2HwFLBTLx54snbm
         LqZzaOH3WmxYDK/kcNpuJejxLk1zZB42l78aop0wWf3Qbh5Ejd50es4iElQw15tnNG
         JKOv/54HF/P6JaaCSk7ZaogKHqEIe9nPzfFj5oMI=
Date:   Mon, 11 Nov 2019 18:17:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v2] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
Message-ID: <20191112001710.GA78003@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108111855.85866-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 08, 2019 at 01:18:55PM +0200, Andy Shevchenko wrote:
> Infinite timeout loops are hard to read. Refactor it
> to plausible 'do {} while ()'.
> 
> Note, the supplied timeout can't be negative for current use,
> though if it's not dividable to 10, we may go below 0,
> that's why type of the parameter is int. And thus, we may move
> the check to the loop condition.
> 
> No functional changes implied.
> 
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/hotplug for v5.5, thanks!

> ---
> - corrected loop conditional to include 0 comparison (Keith)
> - added Rb (Andrew)
>  drivers/pci/hotplug/pciehp_hpc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 86d97f3112f0..764384153c7d 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -68,7 +68,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	u16 slot_status;
>  
> -	while (true) {
> +	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  		if (slot_status == (u16) ~0) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
> @@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  						   PCI_EXP_SLTSTA_CC);
>  			return 1;
>  		}
> -		if (timeout < 0)
> -			break;
>  		msleep(10);
>  		timeout -= 10;
> -	}
> +	} while (timeout >= 0);
>  	return 0;	/* timeout */
>  }
>  
> -- 
> 2.24.0.rc1
> 
