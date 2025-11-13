Return-Path: <linux-pci+bounces-41031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC16C55328
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D2FA345C1F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989B15ADB4;
	Thu, 13 Nov 2025 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW5ozZ0l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521A155389
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995562; cv=none; b=dnjNs89CJbRS98F0pgkKxBE469P5SGJ3AmwA7ZIgUcjd+bLpidbqTmgB8pbfebacU027OdUZkvH/z1Rda7Q4Zqk/QFOduVWZNTMUoOLAJFD38+XzOrbepRVxiEhQflEP0mdfxpgm9nwCVuF9ujlqkcqDehKia70shHF2xISPh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995562; c=relaxed/simple;
	bh=/NhYVfoREEoik+IFHGdwALRB4hxMwDvKUzIjWbWQK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fa16WqlhVdk/W9mLyRkCKL74UBoYtsdoph5repaLlNIWWUwTZd/EjQESNVXuMI9CpoeuRGlE9nev235UAtuG/tb1a7H1qm/kzpLBMPjf2cBZv9rP1OuAub1KgKSYeXAs0YwqUa9a2IM3R1EK+YiYJp5yJZElq7dbNywShBLtshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW5ozZ0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C6FC4CEF1;
	Thu, 13 Nov 2025 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762995561;
	bh=/NhYVfoREEoik+IFHGdwALRB4hxMwDvKUzIjWbWQK8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nW5ozZ0lLRTRbP6vmBNRJ23M6PAEiXeE+JE6upsbwDvCE2byfdVCrKgF1PAqmTg3d
	 axNLQb7d13Awm6Of4L6t/gVBp3dGXPsa6I1cXYvDL6+/3OtKvDKic1NZU9tdIl36RD
	 EgN073FdRnTkyp0CWj/zy5fEo0++ZLkNmP5MnYhPYxtRVyeZ8A6iHPtId1PwGVusB5
	 I2tKYLDKFj30VZQllBq4WKRXZaYtwNT2tnTF23iz4LbzR5SNgr9ORGui/wMSyJFBJI
	 Mdx7bBSeVZxGgw5/2joRe8eQfNHEwcQ72LSFMbZ63W9YktaLvsFClDvkwlQ0gNGvxG
	 Y0jGwDXlF++6A==
Date: Wed, 12 Nov 2025 18:59:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
Message-ID: <20251113005920.GA2257273@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762916319-139532-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Nov 12, 2025 at 10:58:39AM +0800, Shawn Lin wrote:
> This Wi-Fi advertises the L0s and L1 capabilities but actually
> it doesn't support them. This's comfirmed by Hisilicon team in
> actual productization.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/for-linus, planning for v6.18.

> ---
> 
> Changes in v2:
> - rebase on linux-next
> - use DECLARE_PCI_FIXUP_HEADER(Bjorn)
> 
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44e7807..24c2788 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2536,6 +2536,7 @@ static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
>  	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
>  
>  /*
>   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> -- 
> 2.7.4
> 

