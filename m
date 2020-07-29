Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8B2325B3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 21:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2T6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 15:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2T6K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 15:58:10 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCB920658;
        Wed, 29 Jul 2020 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052690;
        bh=iGzz7rQ/5qZp9DO6zE6accMYxJGaMPhuoTKjf6mZI1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kPLwqdflDcRM81w2WKbe4c+9PQaukq++cwHLQBZhZ+G5YNVgjKWFfRWAfE5QL3/EM
         Mq7OtpUo1nK7THDOzpN5jbpHagndqaQbNMfnKF0aony5cZAgS7kML9CPlNMxVdZnkj
         azil1Rzgxi9SI83ZECbcJR7OEB7iBMv3b84OPQnw=
Date:   Wed, 29 Jul 2020 14:58:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Alex Deucher <alexander.deucher@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken
Message-ID: <20200729195808.GA1962849@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728104554.28927-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 06:45:53PM +0800, Kai-Heng Feng wrote:
> We are seeing AMD Radeon Pro W5700 doesn't work when IOMMU is enabled:
> [    3.375841] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> [    3.375845] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01c0]
> 
> The error also makes graphics driver fail to probe the device.
> 
> It appears to be the same issue as commit 5e89cd303e3a ("PCI: Mark AMD
> Navi14 GPU rev 0xc5 ATS as broken") addresses, and indeed the same ATS
> quirk can workaround the issue.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208725
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied with Alex's ack to pci/virtualization for v5.9, thanks!

I also added a stable tag since we did that for 5e89cd303e3a.  Let me
know if you *don't* want that.

> ---
>  drivers/pci/quirks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 812bfc32ecb8..052efeb9f053 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5192,7 +5192,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
>   */
>  static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  {
> -	if (pdev->device == 0x7340 && pdev->revision != 0xc5)
> +	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
> +	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
>  		return;
>  
>  	pci_info(pdev, "disabling ATS\n");
> @@ -5203,6 +5204,8 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
>  /* AMD Iceland dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
> +/* AMD Navi10 dGPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
>  /* AMD Navi14 dGPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
>  #endif /* CONFIG_PCI_ATS */
> -- 
> 2.17.1
> 
