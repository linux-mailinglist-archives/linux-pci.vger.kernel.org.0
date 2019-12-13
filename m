Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619ED11EE0F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 23:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLMW5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 17:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfLMW5M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 17:57:12 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29954214D8;
        Fri, 13 Dec 2019 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576277831;
        bh=/MKZRMvHFkfSFH1MtIj77e5HD9MhKycHLQ4u7/662i4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R2/9MoNiBGApJC2tx0ShiQ4OM5cQOdUKCgEqhOaLn0m5PRDtRPqNxBxS4cKoNYMJY
         rEdNI3Ch4FHJ491vK0ZKuqZ60iCJlLLpx2F/95/Q+ZMiw4JEv6DTvD9uM6Bg4bWMyt
         E4DwlNs60wlfgc8j6DuZvMKUEJRhOW4v3NrhOkJU=
Date:   Fri, 13 Dec 2019 16:57:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Patch]PCI:AER:Notify which device has no error_detected callback
Message-ID: <20191213225709.GA213811@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576237474-32021-1-git-send-email-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 07:44:34PM +0800, Yicong Yang wrote:
> The PCI error recovery will fail if any device under
> root port doesn't have an error_detected callback.
> Currently only failure result is printed, which is
> not enough to determine which device leads to the
> failure and the detailed failure reason.
> 
> Add print information if certain device under root
> port has no error_detected callback.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Applied to pci/aer for v5.6, thanks!

I also added a trivial follow-on patch to factor out the "AER: "
prefix (attached below).  This code is now used by DPC as well as AER,
so "AER: " might not be exactly the correct prefix, but I didn't try
to untangle that.

> ---
>  drivers/pci/pcie/err.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index b0e6048..ec37c33 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -61,8 +61,10 @@ static int report_error_detected(struct pci_dev *dev,
>  		 * error callbacks of "any" device in the subtree, and will
>  		 * exit in the disconnected error state.
>  		 */
> -		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> +			pci_info(dev, "AER: Device has no error_detected callback\n");
> +		}
>  		else
>  			vote = PCI_ERS_RESULT_NONE;
>  	} else {
> --
> 2.8.1
> 

commit 9694ef043ea4 ("PCI/AER: Factor message prefixes with dev_fmt()")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Dec 13 16:46:05 2019 -0600

    PCI/AER: Factor message prefixes with dev_fmt()
    
    Define dev_fmt() with the common prefix of log messages so we don't have to
    repeat it in every printk.  No functional change intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index abde5e000f5d..747ef8b41d1f 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -10,6 +10,8 @@
  *	Zhang Yanmin (yanmin.zhang@intel.com)
  */
 
+#define dev_fmt(fmt) "AER: " fmt
+
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -64,7 +66,7 @@ static int report_error_detected(struct pci_dev *dev,
 		 */
 		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
 			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
-			pci_info(dev, "AER: Driver has no error_detected callback\n");
+			pci_info(dev, "driver has no error_detected callback\n");
 		} else {
 			vote = PCI_ERS_RESULT_NONE;
 		}
@@ -236,12 +238,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 
 	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
-	pci_info(dev, "AER: Device recovery successful\n");
+	pci_info(dev, "device recovery successful\n");
 	return;
 
 failed:
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
-	pci_info(dev, "AER: Device recovery failed\n");
+	pci_info(dev, "device recovery failed\n");
 }
