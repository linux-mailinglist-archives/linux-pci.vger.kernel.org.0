Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D713A37B4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFJXSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFJXSN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:18:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C094613E1;
        Thu, 10 Jun 2021 23:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623366976;
        bh=XUovVZsRI31kLc844mPjPH0FdbCw3NU/Yktf/+7780c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UzTQio7UDDAAp2llDejLuH2Dssj1rV/uIMpEDrT/Ssf2EW7K4RaLqk6iMZzdW+Y0o
         vhfxRNVTig2D5Zt0L4NTKYQua5mW19rvF6ydCBE5TaP4RD4mr8gvgBPLvgwqnVxiLb
         ebTa1gR+UVgexGEGg9DVtXJt/utYclmK3dg+DHgRTdPZADbQnXug/iI7HzFhIiR3n6
         Cx48moeScAuQ9ugWW97U9gFIy7enNiHj3OCcLzxdJiD1qbnoKb+V3yQ/wPFQKpRoNd
         Br5xq5GRT05wvEH/0hxNp9QDe+c+1Tnd2MM/+skuNplNlqRdK21ne/ZqSz+ZHFRLLN
         vc5zm7kabTT7g==
Date:   Thu, 10 Jun 2021 18:16:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210610231615.GA2792521@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608054857.18963-8-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 11:18:56AM +0530, Amey Narkhede wrote:
> From: Shanker Donthineni <sdonthineni@nvidia.com>
> 
> On select platforms, some Nvidia GPU devices do not work with SBR.

Interesting that you say "on select platforms."  Apparently SBR does
work for some of these GPUs, but not on all platforms?  If you have
any clarification here, I can still update the commit log.

> Triggering SBR would leave the device inoperable for the current
> system boot. It requires a system hard-reboot to get the GPU device
> back to normal operating condition post-SBR. For the affected
> devices, enable NO_BUS_RESET quirk to fix the issue.
> 
> This issue will be fixed in the next generation of hardware.
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>

This patch doesn't seem to have any dependencies or particular
connection to the rest of the reset series, so I applied this patch by
itself to for-linus for v5.13 and marked it for stable.

If that's not right, let me know.

> ---
>  drivers/pci/quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e86cf4a3b..45a8c3caa 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3546,6 +3546,18 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
>  	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
>  }
>  
> +/*
> + * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
> + * prevented for those affected devices.
> + */
> +static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> +{
> +	if ((dev->device & 0xffc0) == 0x2340)
> +		quirk_no_bus_reset(dev);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			 quirk_nvidia_no_bus_reset);
> +
>  /*
>   * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
>   * The device will throw a Link Down error on AER-capable systems and
> -- 
> 2.31.1
> 
