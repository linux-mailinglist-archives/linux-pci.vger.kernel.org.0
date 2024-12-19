Return-Path: <linux-pci+bounces-18813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971F9F8592
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F2C1897DA7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77C1A08CC;
	Thu, 19 Dec 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aas/DPTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFC19FA92;
	Thu, 19 Dec 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639023; cv=none; b=qUu6SVdtsZecxUh0hDxrbHga3A8uf/HeGB4q4G67mrWxY9Hkfb1epqEwwAwo5ppvRpnznVUf5+7p5spWspMIeMAL0wVs+PDCoT/8kIvzQPTcep7fQJTFIRB+l11Gft5K4j6mGPVI6VmfCNcdPsuQkPSr1akXN0UarhSfTmqQ844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639023; c=relaxed/simple;
	bh=Mnnb+rYLxKMgvKB3JLV0A+iSR/Plp14zPx6cxIbIn8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKFZJs3ACkf0uNhWgbr4XOFaE2zib677hzILY5OWQnQ8z2pkoghhAIbwBu1v2uyNpfcmB80tCWe9hK8qB/HLvMLzP8eeK5swKJQ1vvSipnwCcl6YqQsVdiSLVqIUoFvgX+Qfsx9FizFKJw6mrcHKDxx8vz3ISRMoojgob+Yxz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aas/DPTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551D9C4CECE;
	Thu, 19 Dec 2024 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639023;
	bh=Mnnb+rYLxKMgvKB3JLV0A+iSR/Plp14zPx6cxIbIn8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aas/DPTnV/tYWX8qsv2YyScKUtB1C+I8dq6XFS6KjTHe3K78zTV3cuqSb3JOmrLGg
	 KIykwCGpgXPsHid1JvwU8cqOs1bW2x1wKlNXjQczyt8tlvU7wtsdTFIh6ketSL/hDT
	 j/OO4YnBnaDYCETAFlt23MnYElpoHUTgH9tzE1G0nntOKoYROLRMGozFzpsI23X8RD
	 EYS6qtDvVMkiB0pIDjlYaqLDKbk83p5CkcJrbsFnA2X7z5uU8JFs/2UC0a+DU8HDE5
	 SwxodYNlkuOi/Vcrd4d9glvIthIRht/0KStPyLGThnmaknxQCU/nLDnPk4zyFTgpFF
	 9u0RruLpexJmQ==
Date: Thu, 19 Dec 2024 21:10:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z2R9qPmAyTcc5mtg@ryzen>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>

On Thu, Dec 19, 2024 at 12:02:02PM -0500, Frank Li wrote:
> On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> > On Wed, 18 Dec 2024 23:08:39 +0000,

[...]

> If use latest ITS MSI64 should be simple, only need descript it at DTS
> (I have not hardware to test this case yet).
> pci-ep {
> 	...
> 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> 			      ^, ctrl ID.
> 	msi-mask = <0xff>;
> 	...
> }

[...]

> This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
> who use another dwc controller, which they already implemented
> "implementation-specific" by only update dts to provide hardware
> information.(I guest he use ITS's MSI64)
> 
> Because it is new patches, I have not added Niklas's test-by tag. There
> are not big functional change since Nikas test. The major change is make
> msi part better align current MSI framework according to Thomas's
> suggestion.

Frank, I tested this series (a few revisions back) on the rockchip rk3588,
which just like imx95, uses a DWC based PCIe EP controller, and ARM GIC ITS,
but unlike imx95, it does not require any additional look up table registers
to be configured.


While the rk3588 PCIe host controller node has:
msi-map = <0x0000 &its1 0x0000 0x1000>;
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi?h=v6.13-rc3#n164

The rk3588 PCIe endpoint controller node, which is the only one relevant
in this case, only has:
msi-parent = <&its1 0x0000>;
no msi-map.
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.14-armsoc/dts64&id=b6f09f497b07008aa65c31341138cecafa78222c


Kind regards,
Niklas

