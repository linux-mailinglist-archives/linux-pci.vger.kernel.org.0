Return-Path: <linux-pci+bounces-18465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84B9F2633
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 22:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA43F1648BB
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86A2110E;
	Sun, 15 Dec 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB98uQwo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E0A41
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297470; cv=none; b=ZCAZniiDbx5CgahQmaGw4c0pH6R/9VXGcs6llKpFgAbPnhijgx6TSelEsr/7/+c+2WHPzISmEDR2YtKFfUEyDjYg6bKLS+Q02YOG+Wc91HyEcyZRgoNTnbNpcf7RpLcuSV50ann7JFClM9NoL2nMuUaQUEjgDM7XM/5FwHc7pl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297470; c=relaxed/simple;
	bh=q1uJJk+KavMVIi9DxiJRpKbFbMEPLJC4DThzG7G3tz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EA0EYD4TscK7Kp7zyjct9b3eVsVxgW5XbNF75HdjN9aabV0Kyw7FuxGbLZ8xR3Mzw0+tSebP4XYiWvVxjXEPYfYjo5p7IJ/mgnFYLIQ9IzdtLpT7tJjVEiq7VmYtt4hF7edlajb+TUW76+35aAClqDH21YsTrks7TgiBxYWNzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB98uQwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976F7C4CECE;
	Sun, 15 Dec 2024 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734297470;
	bh=q1uJJk+KavMVIi9DxiJRpKbFbMEPLJC4DThzG7G3tz4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vB98uQwoAkxVCqhvCU6E4YfSvE/7wpqtP+yerVE3/tOwSgxwKWrknXc/8j2BElIXw
	 QQBNyY2CBhjM0gE4tB4ncBpv5MWZL2CYOaSM5zgCn8j3/iU7BPmpr2pA1TDWShT13Y
	 0MchpIcfWK93v+Myu4Wgqj0b2x0tRtY6R8zHY12TVI0BNdmAajyKPIBGjYQc9Ga7sQ
	 1gWoLtrm2QiRgOAbxa5/SVjocphTJvSLqhAYwFDKqaHhgrkVIYM/XrNJkv8onINw6p
	 Dy0GoNZCs8iu/Asqar/wy5jU0fhhGPyAQgrkR2xtEuiUte/2+b4p6Mknc77o/l7rPO
	 XxvHJRxQ0yMjw==
Message-ID: <6ccb04cb47da39770e62ebf3f540698e4412ae0a.camel@kernel.org>
Subject: Re: [PATCH for-linus v2 1/3] PCI: Assume 2.5 GT/s if Max Link Speed
 is undefined
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Mario Limonciello <mario.limonciello@amd.com>
Date: Sun, 15 Dec 2024 22:17:46 +0100
In-Reply-To: <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
	 <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-12-15 at 11:20 +0100, Lukas Wunner wrote:
> Broken PCIe devices may not set any of the bits in the Link Capabilities
> Register's "Max Link Speed" field.  Assume 2.5 GT/s in such a case,
> which is the lowest possible PCIe speed.  It must be supported by every
> device per PCIe r6.2 sec 8.2.1.
>=20
> Emit a message informing about the malformed field.  Use KERN_INFO
> severity to minimize annoyance.  This will help silicon validation
> engineers take note of the issue so that regular users hopefully never
> see it.
>=20
> There is currently no known affected product, but a subsequent commit
> will honor the Max Link Speed field when determining supported speeds
> and depends on the field being well-formed.  (It uses the Max Link Speed
> as highest bit in a GENMASK(highest, lowest) macro and if the field is
> zero, that would result in GENMASK(0, lowest).)
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35dc9f249b86..ab0ef7b6c798 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6233,6 +6233,13 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	u32 lnkcap2, lnkcap;
>  	u8 speeds;
> =20
> +	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
> +		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");
> +		return PCI_EXP_LNKCAP2_SLS_2_5GB;
> +	}
> +
>  	/*
>  	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
>  	 * Speeds Vector to allow using SLS Vector bit defines directly.
> @@ -6244,8 +6251,6 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
>  	if (speeds)
>  		return speeds;
> =20
> -	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> -
>  	/* Synthesize from the Max Link Speed field */
>  	if ((lnkcap & PCI_EXP_LNKCAP_SLS) =3D=3D PCI_EXP_LNKCAP_SLS_5_0GB)
>  		speeds =3D PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;

I feel like this patch goes a bit against the idea of this being more
future proof. Personally, I kind of expect that any future devices
which may skip support for lower speeds would start with skipping 2.5
GT/s and a future PCIe spec might allow this.

In that case with the above code we end up assuming 2.5 GT/s which
won't work while the Supported Link Speeds Vector could contain
supported speeds with the assumption that when in doubt software relies
on that (PCIe r6.2 sec 7.5.3.18) and it might even be future spec
conformant.=C2=A0

So I think instead of assuming 2.5 GT/s I was thinking of something
like the diff below (on top of this series).

Thanks
Niklas

----
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ef5c48bda012..cfb34fa96f81 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6223,14 +6223,11 @@ EXPORT_SYMBOL(pcie_bandwidth_available);
 u8 pcie_get_supported_speeds(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
-	u8 speeds;
+	u8 speeds, max_bits;
=20
 	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
-		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");
-		return PCI_EXP_LNKCAP2_SLS_2_5GB;
-	}
+	max_bits =3D lnkcap & PCI_EXP_LNKCAP_SLS;
=20
 	/*
 	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
@@ -6238,10 +6235,11 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	speeds =3D lnkcap2 & PCI_EXP_LNKCAP2_SLS;
-
 	/* Ignore speeds higher than Max Link Speed */
-	speeds &=3D GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS,
-			  PCI_EXP_LNKCAP2_SLS_2_5GB);
+	if (max_bits)
+		speeds &=3D GENMASK(max_bits, PCI_EXP_LNKCAP2_SLS_2_5GB);
+	else
+		pci_info(dev, "Undefined Max Link Speed; relying on LnkCap2\n");
=20
 	/* PCIe r3.0-compliant */
 	if (speeds)


