Return-Path: <linux-pci+bounces-40538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB890C3D479
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE0C04E4587
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF2C3502BC;
	Thu,  6 Nov 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVVZZRUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C51D516C
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458659; cv=none; b=USiNt38vVL4UC7iYft79blkm6M3hKT0WrfSZlu6jhXDrrizIu/fiHxqyTE5Y5K2heT6eAxCiFhojYQ8+dQ/EG8GDKDLHoeK6/x70zfV944fViHt3NwZA8avj5vQJkF7/fpGhBhuEraSE9Qq4W/JDUfe1kRo+/RlHvUJRDMm2rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458659; c=relaxed/simple;
	bh=1lB3DZzZMhqcI9NwkXLNHHcsV1/W9B3qgHsM67aLrrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f5liuqTa8QJGBBpnJpKnmmL8znI+W96kDu1wLgPWgGYPa3KK5xDH2EemtYz/CNmAtRACLm+HBxt4Xc5UTuU1Emn/MTomyr8E65QdWEr9J4sUbgZJaZoFMLFeZUOG0t9joS5rSrAYC5tOzvbSzFWToGxrkTPNDLIOLaqH/VKoGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVVZZRUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D2C113D0;
	Thu,  6 Nov 2025 19:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762458658;
	bh=1lB3DZzZMhqcI9NwkXLNHHcsV1/W9B3qgHsM67aLrrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZVVZZRUtFy+4HxR/aMNXvbPN2iz63KQ5m5A7eMbPT3B8SKM9kCa+I9r5NKT3yMyU1
	 t3Oc/50oCHl0hpLwkW7IxqCSZZWNeRcfORKPECk7th0o98TfYmxkb5njHf8soDxDyb
	 I3yjQJnzmcQbvEDTo2GJ98MNHAAMwCFVKttpl8hCH8w2Bphlgq06oo19PhumC3tonH
	 upXVIy3mpu6YPW2jKIt7Fg6js1d/DWmSeulBTyDQFM8OyUKizJ7+Gn9kqTebEj09Bi
	 Iibocqgq0ncOAoXP8JPpv4qAgSgn9G60OA+Ql/kvNgWVaj0gTjzF+6zVh0a4dgx+ox
	 U2qbsQSpIaBUg==
Date: Thu, 6 Nov 2025 13:50:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
Message-ID: <20251106195057.GA1965757@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762401119-232631-1-git-send-email-shawn.lin@rock-chips.com>

On Thu, Nov 06, 2025 at 11:51:59AM +0800, Shawn Lin wrote:
> This Wi-Fi advertises the L0s and L1 capabilities but actually
> it doesn't support them. This's comfirmed by Hisilicon team in
> actual productization.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed06..67250d4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2526,6 +2526,12 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
>  /*
> + * The Hi1105 PCIe Wi-Fi doesn't support L0s and L1 but advertise the capability.
> + * Disable both L0s and L1 for now.
> + */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);

PCI_VENDOR_ID_HUAWEI is 0x19e5.  Is there an upstream driver that
matches [19e5:1105]?  I didn't find anything.

I think quirk_disable_aspm_l0s_l1() might be a problem because the new
strategy is to enable ASPM early (in pcie_aspm_init_link_state(),
called from pci_scan_slot(), which happens before FINAL fixups are run
during pci_bus_add_device().

So I think we will enable L0s and L1 briefly before
quirk_disable_aspm_l0s_l1() runs, and it's possible we'd see a problem
then.

But if you apply this series:
  https://lore.kernel.org/r/20251106183643.1963801-1-helgaas@kernel.org

and then the patch below on top, I think we should avoid enabling L0s
and L1 at all:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44e780718953..24c278857159 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2536,6 +2536,7 @@ static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
 	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

