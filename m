Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F622B25CF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKMUtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 15:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgKMUtB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 15:49:01 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE0D22201;
        Fri, 13 Nov 2020 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605300540;
        bh=V8CUFfeb4EQi81SuCDO7tdlAWKl1AreBu4pyYW1OYKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TS6toXQyBXM1eLEDwMjRxXO4J9T3L2zzvoNWTKUwq4hukPxIYJtzG2bAWt8GfsRQy
         iGIl7OFzizo3Q8homLJB9dZ0OutO0cxJQjZ6Wl7TlH+VCilerB5fQsTwEo1byLfwYg
         tdUHt0YjqEbqk3bk46QSZ6NymntdrmsXDDdHcTV4=
Date:   Fri, 13 Nov 2020 14:48:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     John Smith <LK7S2ED64JHGLKj75shg9klejHWG49h5hk@protonmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for Marvell 9215
 SATA controller
Message-ID: <20201113204859.GA1134115@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110220516.697934-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 04:05:16PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add function 1 DMA alias quirk for Marvell 88SS9215 PCIe SSD Controller.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c135
> Reported-by: John Smith <LK7S2ED64JHGLKj75shg9klejHWG49h5hk@protonmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to for-linus for v5.10.

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692ac79c5..4d683a28b29f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3998,6 +3998,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
>  			 quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c135 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9215,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c127 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
>  			 quirk_dma_func1_alias);
> -- 
> 2.25.1
> 
