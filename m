Return-Path: <linux-pci+bounces-25551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C7A82159
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BEE1BA02C0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474F25D21B;
	Wed,  9 Apr 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HC8AvnhI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="m3kLtg1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3626ACD;
	Wed,  9 Apr 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192329; cv=none; b=DzeHwX8d93+0zoxcp/WVa47VTwZhRniffIAWwn2nBSZHwMBgngnW9uaPTWYvhmJQHWd6ZZvsFdJkCwETcg6G03O9UANVFPmbD4djD9iJUmLWTtoSVIDdJrkXY8zQF/o7WMPmfuM2bMLGqXK/orfPpL7qXWgsfoz11jCKAFwPHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192329; c=relaxed/simple;
	bh=9HfoOow1u3OlQ99nimInZ/BXdlpsvS+JF1uWNYbbCMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUh5i8dWrt8oLgkL3F0RLZTBb0ORgHiWFFmAdPXQt8DTPV5qsurecP0H2fCgQP1bCN4eInDkt2+Xb4QNqphtY0A21OBDCUbgFO5Fd236EiWoKu/6oKEVTgupwyCd54nomTi9cPySz5skqWGCPlqF83zZt/5XGSRriAYGhSWKz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HC8AvnhI; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=m3kLtg1v reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744192325; x=1775728325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwJ4JjVuW0owDIj4lhQZlNw78vzSAnna/M+1aYgN5Ps=;
  b=HC8AvnhI077XiuSmgFAr+xU+r+gqFg8ummRNntbLkEvff1U/I34BlTtg
   lAOameIJCKw9rTsl7fLV2l1kXBSSsTbKaVSXCrYkFm8hgvtfwWGySApsD
   vEkKmek6kz6UOgJY32gBQ3flWnyWAxj95jnj4mLVoq5+gdHfSaUsFPGJa
   Cy8qnUiJWHSJiBNO2OnBT7jo8mtBmIQK14V2WVEnaVdE1XNTCHbkK98ge
   MgR7djaZbTbk+bKDuwHKS2rqo5fUwPBHGnABwWu1W77k68Ifzj1iO+5g/
   nOoQExaBKM0qLBXFz/yaZav6xGaVdvw7oVy2hvS1lTKu/Q6OzzjAOJznw
   w==;
X-CSE-ConnectionGUID: Oz1g1cdlSxCyk3H/RQxwwg==
X-CSE-MsgGUID: s+m6D76ZTvW8PCwplIMQ+g==
X-IronPort-AV: E=Sophos;i="6.15,200,1739833200"; 
   d="scan'208";a="43425007"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Apr 2025 11:52:01 +0200
X-CheckPoint: {67F64341-30-DC4DC9A0-F4F29281}
X-MAIL-CPID: 40F2E6F11F590AF8BB2A12417A0B3E0A_0
X-Control-Analysis: str=0001.0A006376.67F64345.0015,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC7421654E8;
	Wed,  9 Apr 2025 11:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744192316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwJ4JjVuW0owDIj4lhQZlNw78vzSAnna/M+1aYgN5Ps=;
	b=m3kLtg1vBRoGo0pR0MXT0M8ZSUwba+jbDz1IMwSPGBjId/gF8IE86yru8BpBXkk+DIt85W
	SDKLZeyBByFKQBs7E9gNrPJtx0PmM2bd+RipFes0x8kzB4iqxfjRFcNU2qYksVPuerP1/N
	+ZgTIKD7AikoGY0utgvP5QXoHrce8loqv2mRPVx6qY5fywABfYzUhgO+/BMWVmN8I3wMHd
	aL+tJV7ZL5TDTAG2+ztEVXSkCCu2QJgJHpZDEDw0c1XPODc3H8zmpXFzk4bHxlHnPMcly7
	0gjDCZziULkjEV9Xau0kEXJqNHbyVdXgabnndPDhUGPXv1uxTXwFg9jyFe2e3A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Wed, 09 Apr 2025 11:51:53 +0200
Message-ID: <2989817.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250408025930.1863551-4-hongxing.zhu@nxp.com>
References:
 <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Dienstag, 8. April 2025, 04:59:26 CEST schrieb Richard Zhu:
> Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequenc=
y.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index c5871c3d4194..7c60b712480a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -71,6 +71,9 @@
>  #define IMX95_SID_MASK				GENMASK(5, 0)
>  #define IMX95_MAX_LUT				32
> =20
> +#define IMX95_PCIE_RST_CTRL			0x3010
> +#define IMX95_PCIE_COLD_RST			BIT(0)
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> =20
>  enum imx_pcie_variants {
> @@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *im=
x_pcie, bool assert)
>  	return 0;
>  }
> =20
> +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	u32 val;
> +
> +	if (assert) {
> +		/*
> +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> +		 * should be complete after power-up by the following sequence.
> +		 *                 > 10us(at power-up)
> +		 *                 > 10ns(warm reset)
> +		 *               |<------------>|
> +		 *                ______________
> +		 * phy_reset ____/              \________________
> +		 *                                   ____________
> +		 * ref_clk_en_______________________/
> +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> +		 */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				IMX95_PCIE_COLD_RST);
> +		/*
> +		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
> +		 * hardware by doing a read. Otherwise, there is no guarantee
> +		 * that the write has reached the hardware before udelay().
> +		 */
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(15);
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				  IMX95_PCIE_COLD_RST);
> +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> +				     &val);
> +		udelay(10);
> +	}
> +
> +	return 0;
> +}
> +
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
> @@ -1739,6 +1779,7 @@ static const struct imx_pcie_drvdata drvdata[] =3D {
>  		.ltssm_mask =3D IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  =3D IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] =3D IMX95_PCIE_DEVICE_TYPE,
> +		.core_reset =3D imx95_pcie_core_reset,
>  		.init_phy =3D imx95_pcie_init_phy,
>  	},
>  	[IMX8MQ_EP] =3D {
> @@ -1792,6 +1833,7 @@ static const struct imx_pcie_drvdata drvdata[] =3D {
>  		.mode_off[0]  =3D IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] =3D IMX95_PCIE_DEVICE_TYPE,
>  		.init_phy =3D imx95_pcie_init_phy,
> +		.core_reset =3D imx95_pcie_core_reset,
>  		.epc_features =3D &imx95_pcie_epc_features,
>  		.mode =3D DW_PCIE_EP_TYPE,
>  	},
>=20

This change introduces an invalid memory access on my platform. There is not
even a PCIe device attached to it.

> imx6q-pcie 4c380000.pcie: host bridge /soc/pcie@4c380000 ranges:
> imx6q-pcie 4c300000.pcie: host bridge /soc/pcie@4c300000 ranges:
> imx6q-pcie 4c380000.pcie:       IO 0x088ff00000..0x088fffffff -> 0x000000=
0000
> imx6q-pcie 4c300000.pcie:       IO 0x006ff00000..0x006fffffff -> 0x000000=
0000
> imx6q-pcie 4c380000.pcie:      MEM 0x0a10000000..0x0a1fffffff -> 0x001000=
0000
> imx6q-pcie 4c300000.pcie:      MEM 0x0910000000..0x091fffffff -> 0x001000=
0000
> imx6q-pcie 4c380000.pcie: config reg[1] 0x880100000 =3D=3D cpu 0x880100000
> ; no fixup was ever needed for this devicetree
> imx6q-pcie 4c300000.pcie: config reg[1] 0x60100000 =3D=3D cpu 0x60100000
> ; no fixup was ever needed for this devicetree
> Unable to handle kernel paging request at virtual address ffff800081dc5010
> Unable to handle kernel paging request at virtual address ffff8000821bd010
> Mem abort info:
>=20
> Mem abort info:
>   ESR =3D 0x0000000096000007
>   ESR =3D 0x0000000096000007
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>=20
> fsl_enetc_mdio 0003:01:00.0: enabling device (0000 -> 0002)
>=20
>   SET =3D 0, FnV =3D 0
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x07: level 3 translation fault
>   FSC =3D 0x07: level 3 translation fault
>=20
> Data abort info:
>=20
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
>   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>=20
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000091a47000
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000091a47000
> [ffff800081dc5010] pgd=3D1000000092002003
> [ffff8000821bd010] pgd=3D1000000092002003
> , p4d=3D1000000092002003
> , p4d=3D1000000092002003
> , pud=3D1000000092003003
> , pud=3D1000000092003003
> , pmd=3D1000000092008003
> , pmd=3D100000009299f403
> , pte=3D0000000000000000
> , pte=3D0000000000000000
>=20
>=20
> Internal error: Oops: 0000000096000007 [#1]  SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 63 Comm: kworker/u24:4 Tainted: G                T =20
> 6.15.0-rc1-next-20250409+ #3009 PREEMPT=20
> f6bd3cc6346487744ae55f6115e728ff2bc7088b Tainted: [T]=3DRANDSTRUCT
> Hardware name: TQ-Systems i.MX95 TQMa95xxSA on MB-SMARC-2 (DT)
> Workqueue: async async_run_entry_fn
> pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : regmap_mmio_read32le+0x1c/0x3c
> lr : regmap_mmio_read+0x40/0x68
> sp : ffff80008223b860
> x29: ffff80008223b860 x28: ffff00001000c800 x27: ffff8000818679c0
> x26: ffff000013340410 x25: 0000000000000001 x24: 0000000000000000
> x23: ffff000012f5e400 x22: ffff80008223b934 x21: ffff80008223b934
> x20: ffff000012fc4900 x19: 0000000000003010 x18: 00000000a7aa953f
> x17: 3e2d206666666666 x16: 666631393078302e x15: 2e30303030303030
> x14: 3139307830204d45 x13: 3030303030303031 x12: 30307830203e2d20
> x11: 6666666666666631 x10: 393078302e2e3030 x9 : 4d2020202020203a
> x8 : 656963702e303030 x7 : 205d313236353838 x6 : ffff0000134e0000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000809bf028
> x2 : ffff8000809bfb0c x1 : 0000000000003010 x0 : ffff800081dc5010
>=20
> Call trace:
>  regmap_mmio_read32le+0x1c/0x3c (P)
>  regmap_mmio_read+0x40/0x68
>  _regmap_bus_reg_read+0x58/0x9c
>  _regmap_read+0x70/0x1c4
>  _regmap_update_bits+0xe4/0x174
>  regmap_update_bits_base+0x60/0x90
>  imx95_pcie_core_reset+0x78/0xd0
>  imx_pcie_assert_core_reset+0x38/0x50
>  imx_pcie_host_init+0x68/0x4a0
>  dw_pcie_host_init+0x16c/0x500
>  imx_pcie_probe+0x2f4/0x71c
>  platform_probe+0x64/0x100
>  really_probe+0xc8/0x3bc
>  __driver_probe_device+0x84/0x16c
>  driver_probe_device+0x40/0x160
>  __device_attach_driver+0xcc/0x1a0
>  bus_for_each_drv+0x88/0xe4
>  __device_attach_async_helper+0xac/0x108
>  async_run_entry_fn+0x30/0x144
>  process_one_work+0x14c/0x3e0
>  worker_thread+0x2f0/0x3fc
>  kthread+0x128/0x1ec
>  ret_from_fork+0x10/0x20
>=20
> Code: aa0003f4 2a0103f3 f9400280 8b334000 (b9400000)
> ---[ end trace 0000000000000000 ]---
> note: kworker/u24:4[63] exited with irqs disabled
> Internal error: Oops: 0000000096000007 [#2]  SMP
> Modules linked in:
> note: kworker/u24:4[63] exited with preempt_count 1
>=20
> CPU: 4 UID: 0 PID: 52 Comm: kworker/u24:1 Tainted: G      D         T =20
> 6.15.0-rc1-next-20250409+ #3009 PREEMPT=20
> f6bd3cc6346487744ae55f6115e728ff2bc7088b Tainted: [D]=3DDIE, [T]=3DRANDST=
RUCT
> Hardware name: TQ-Systems i.MX95 TQMa95xxSA on MB-SMARC-2 (DT)
> Workqueue: async async_run_entry_fn
> pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : regmap_mmio_read32le+0x1c/0x3c
> lr : regmap_mmio_read+0x40/0x68
> mmc0: new HS400 Enhanced strobe MMC card at address 0001
> sp : ffff8000821e3860
> mmcblk0: mmc0:0001 DG4016 14.7 GiB
> x29: ffff8000821e3860 x28: ffff00001000c800 x27: ffff8000818679c0
> mmcblk0boot0: mmc0:0001 DG4016 4.00 MiB
> x26: ffff00001333fc10 x25: 0000000000000001 x24: 0000000000000000
> x23: ffff000013895400 x22: ffff8000821e3934 x21: ffff8000821e3934
> x20: ffff0000134672c0
> mmcblk0boot1: mmc0:0001 DG4016 4.00 MiB
>=20
>  x19: 0000000000003010 x18: 0000000038868210
>=20
> x17: 3038387830207570 x16: 63203d3d20303030 x15: 3030313038387830
> x14: 205d315b67657220
> mmcblk0rpmb: mmc0:0001 DG4016 4.00 MiB, chardev (237:0)
>=20
>  x13: 6565727465636976 x12: 6564207369687420
>=20
> x11: 726f662064656465 x10: 656e207265766520 x9 : 7420726f66206465
> x8 : 6465656e20726576 x7 : 205d303033353938 x6 : ffff000013371280
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000809bf028
> x2 : ffff8000809bfb0c x1 : 0000000000003010 x0 : ffff8000821bd010
>=20
> Call trace:
>  regmap_mmio_read32le+0x1c/0x3c (P)
>  regmap_mmio_read+0x40/0x68
>  _regmap_bus_reg_read+0x58/0x9c
>  _regmap_read+0x70/0x1c4
>  _regmap_update_bits+0xe4/0x174
>  regmap_update_bits_base+0x60/0x90
>  imx95_pcie_core_reset+0x78/0xd0
>  imx_pcie_assert_core_reset+0x38/0x50
>  imx_pcie_host_init+0x68/0x4a0
>  dw_pcie_host_init+0x16c/0x500
>  imx_pcie_probe+0x2f4/0x71c
>  platform_probe+0x64/0x100
>  really_probe+0xc8/0x3bc
>  __driver_probe_device+0x84/0x16c
>  driver_probe_device+0x40/0x160
>  __device_attach_driver+0xcc/0x1a0
>  bus_for_each_drv+0x88/0xe4
>  __device_attach_async_helper+0xac/0x108
>  async_run_entry_fn+0x30/0x144
>  process_one_work+0x14c/0x3e0
>  worker_thread+0x2f0/0x3fc
>  kthread+0x128/0x1ec
>  ret_from_fork+0x10/0x20
>=20
> Code: aa0003f4 2a0103f3 f9400280 8b334000 (b9400000)
> ---[ end trace 0000000000000000 ]---

Is this series dependent on any other series/patches?

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



