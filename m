Return-Path: <linux-pci+bounces-40559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BEC3E891
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 06:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740243AD153
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B922520487E;
	Fri,  7 Nov 2025 05:43:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3EF50F;
	Fri,  7 Nov 2025 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494205; cv=none; b=SVmh+fIE/AZUhuAje2CxDl5o7ClTnbgHBSrU76wnAwvkrLUWhRNs9Uu39HM9VCVsE3uyku0RIa0lC25JyXde/Yllg1TpQiTZW6oKwkXmUQBRo1buoMOGY8+TrzC2Fs0m1+baWVLKUUaE3BZ7BH4PJyLdSBMDOokQbweenn3aWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494205; c=relaxed/simple;
	bh=rjcYOEIzpSd5gitYOoZZ4sIdSL+ADsW9OmULB+qwICE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7eCNXYoaXBSEAyJyS07H2IwgiPUGSi4iHhp1dbHSle3H4G0s4yF/GtRYuT2UohpCsOX2yL31gBIX2cyZIQt6pUqYDpeEkvSUfvAPMgTe7/6cV5mdZK5Se7RKkAYewsHSTfhK3A9jOKys43okFjOmnOR4XVZkfdMAsBYQw8iFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2FCBC20083CF;
	Fri,  7 Nov 2025 06:35:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 18CF2469; Fri,  7 Nov 2025 06:35:49 +0100 (CET)
Date: Fri, 7 Nov 2025 06:35:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Message-ID: <aQ2FNfdDPUdA27rS@wunner.de>
References: <20251106183643.1963801-1-helgaas@kernel.org>
 <20251106183643.1963801-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106183643.1963801-3-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:39PM -0600, Bjorn Helgaas wrote:
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>  
> +/*
> + * Remove ASPM L0s and L1 support from cached copy of Link Capabilities so
> + * aspm.c won't try to enable them.
> + */
> +static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
> +{
> +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +	dev->lnkcap &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
> +

Hm, I liked the nice generic pcie_aspm_disable_cap() helper that
you had in this earlier version:

https://lore.kernel.org/all/20251105220925.GA1926619@bhelgaas/

Thanks,

Lukas

