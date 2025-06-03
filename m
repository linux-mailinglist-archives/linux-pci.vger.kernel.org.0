Return-Path: <linux-pci+bounces-28849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C12ACC387
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0179C3A6DEA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245112A1D1;
	Tue,  3 Jun 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpJ5NwwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B7664C6;
	Tue,  3 Jun 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944196; cv=none; b=U81P1CBqQZXpSvVseurRus0syd/uEDoDJLXf/0XbMcKoNn91YPftKtYAuT7tBbVTKIS84Aiu1QrpzouSwFg91QDvrO+liZh3CtWrtckSn3xFMVDt29BKmEZ50KF73PsH3YReJwNOQoQa62BpHmtZ584JccLh4ZXN52RXq8DO6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944196; c=relaxed/simple;
	bh=Cq3iAIbDIPRXsvj5tTO6QxgYALKUdXHjNtXPv++etbw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mh/Y3tHPYoPNkh6gZXG0i5X03YRPGLc1V0SxxILeS1MuYBIY6zY56Yopc6os7SD/3mvELBAZmc/fzA5EQAZuy6A+1AJsXV6UJZqXxECB0I4UMTNHWrO/1WcIIsm2q37AN0GAVcdUDXleorvnMkMt4uDThW1t9ew433iEYsa9MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpJ5NwwT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748944194; x=1780480194;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Cq3iAIbDIPRXsvj5tTO6QxgYALKUdXHjNtXPv++etbw=;
  b=LpJ5NwwTjA/55BALx8CH5918rVxbkYXBSwrq9DNbeP85fC6cxkbBakf6
   O5W23Yxr7Fxb1xNUCT2oZy5SNpRBDFPzz2M4C8i4pvMLPHrwO1FszQC2m
   9W88CGAXVQoKPRMN8F5MPhbRieJ34C4tjR74RSdO53ZZl7lHPbq14az/B
   0Bo8pSDZElrj1UDSelmQxP7GFXCT3o8Y2JNqLNVnzN3URgz+vnruH8tUj
   +5mr4PdzOm+ktImPFd2oxgtgVeLEO/kw503NboTu40EReT8Cx2YDFR3BM
   j/JjJL9I6Zk9R/hCRjxspgUHxnYQMB7DSIQZ2XLN/zXeadcXna4gm15DK
   w==;
X-CSE-ConnectionGUID: ITEVMounQAum3EBArMeicA==
X-CSE-MsgGUID: EgKA5GOoRkiaqohveUKjSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53604874"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="53604874"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:49:53 -0700
X-CSE-ConnectionGUID: LDax2RMbQxStaK28DFv38Q==
X-CSE-MsgGUID: KpjRsEuwRkCw3OooTBNTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145141773"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:49:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:49:46 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 6/6] PCI: cadence: Use cdns_pcie_find_*capability to
 avoid hardcode.
In-Reply-To: <20250514161258.93844-7-18255117159@163.com>
Message-ID: <828b30f5-93f9-bcae-296b-0a9aadde9e4f@linux.intel.com>
References: <20250514161258.93844-1-18255117159@163.com> <20250514161258.93844-7-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-779561234-1748944186=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-779561234-1748944186=:937
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 May 2025, Hans Zhang wrote:

> The PCIe capability/extended capability offsets are not guaranteed to be
> the same across all SoCs integrating the Cadence PCIe IP. Hence, use the
> cdns_pcie_find_{ext}_capability() APIs for finding them.

A minor point perhaps, but IMO, controller drivers should use the core's=20
capability search regardless of the offset being same or not. :-)

> This avoids hardcoding the offsets in the driver.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v8 ~ v11:
> - None
>=20
> Changes since v7:
> - Resolve compilation errors.
>=20
> Changes since v6:
> https://lore.kernel.org/linux-pci/20250323164852.430546-4-18255117159@163=
=2Ecom/
>=20
> - The patch commit message were modified.
>=20
> Changes since v5:
> https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163=
=2Ecom
>=20
> - Kconfig add "select PCI_HOST_HELPERS"
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++++++++--------
>  drivers/pci/controller/cadence/pcie-cadence.h |  5 ---
>  2 files changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/p=
ci/controller/cadence/pcie-cadence-ep.c
> index 599ec4b1223e..5c4b2151d181 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -19,12 +19,13 @@
> =20
>  static u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vf=
n)
>  {
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
>  =09u32 first_vf_offset, stride;
> +=09u16 cap;
> =20
>  =09if (vfn =3D=3D 0)
>  =09=09return fn;
> =20
> +=09cap =3D cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SRIOV);
>  =09first_vf_offset =3D cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_V=
F_OFFSET);
>  =09stride =3D cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE=
);
>  =09fn =3D fn + first_vf_offset + ((vfn - 1) * stride);
> @@ -36,10 +37,11 @@ static int cdns_pcie_ep_write_header(struct pci_epc *=
epc, u8 fn, u8 vfn,
>  =09=09=09=09     struct pci_epf_header *hdr)
>  {
>  =09struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
>  =09u32 reg;
> +=09u16 cap;
> =20
> +=09cap =3D cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SRIOV);
>  =09if (vfn > 1) {
>  =09=09dev_err(&epc->dev, "Only Virtual Function #1 has deviceID\n");
>  =09=09return -EINVAL;
> @@ -224,9 +226,10 @@ static int cdns_pcie_ep_set_msi(struct pci_epc *epc,=
 u8 fn, u8 vfn, u8 mmc)
>  {
>  =09struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>  =09u16 flags;
> +=09u8 cap;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>  =09fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> =20
>  =09/*
> @@ -246,9 +249,10 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc,=
 u8 fn, u8 vfn)
>  {
>  =09struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>  =09u16 flags, mme;
> +=09u8 cap;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>  =09fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> =20
>  =09/* Validate that the MSI feature is actually enabled. */
> @@ -269,9 +273,10 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no)
>  {
>  =09struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>  =09u32 val, reg;
> +=09u8 cap;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
>  =09func_no =3D cdns_pcie_get_fn_from_vfn(pcie, func_no, vfunc_no);
> =20
>  =09reg =3D cap + PCI_MSIX_FLAGS;
> @@ -290,9 +295,10 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc=
, u8 fn, u8 vfn,
>  {
>  =09struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>  =09u32 val, reg;
> +=09u8 cap;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
>  =09fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> =20
>  =09reg =3D cap + PCI_MSIX_FLAGS;
> @@ -378,11 +384,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pc=
ie_ep *ep, u8 fn, u8 vfn,
>  =09=09=09=09     u8 interrupt_num)
>  {
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>  =09u16 flags, mme, data, data_mask;
> -=09u8 msi_count;
>  =09u64 pci_addr, pci_addr_mask =3D 0xff;
> +=09u8 msi_count, cap;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>  =09fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> =20
>  =09/* Check whether the MSI feature has been enabled by the PCI host. */
> @@ -430,14 +436,14 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc =
*epc, u8 fn, u8 vfn,
>  =09=09=09=09    u32 *msi_addr_offset)
>  {
>  =09struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
>  =09u64 pci_addr, pci_addr_mask =3D 0xff;
>  =09u16 flags, mme, data, data_mask;
> -=09u8 msi_count;
> +=09u8 msi_count, cap;
>  =09int ret;
>  =09int i;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSI);
>  =09fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> =20
>  =09/* Check whether the MSI feature has been enabled by the PCI host. */
> @@ -480,16 +486,16 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc =
*epc, u8 fn, u8 vfn,
>  static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8=
 vfn,
>  =09=09=09=09      u16 interrupt_num)
>  {
> -=09u32 cap =3D CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
>  =09u32 tbl_offset, msg_data, reg;
>  =09struct cdns_pcie *pcie =3D &ep->pcie;
>  =09struct pci_epf_msix_tbl *msix_tbl;
>  =09struct cdns_pcie_epf *epf;
>  =09u64 pci_addr_mask =3D 0xff;
>  =09u64 msg_addr;
> +=09u8 bir, cap;
>  =09u16 flags;
> -=09u8 bir;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);
>  =09epf =3D &ep->epf[fn];
>  =09if (vfn > 0)
>  =09=09epf =3D &epf->epf[vfn - 1];
> @@ -563,7 +569,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  =09int max_epfs =3D sizeof(epc->function_num_map) * 8;
>  =09int ret, epf, last_fn;
>  =09u32 reg, value;
> +=09u8 cap;
> =20
> +=09cap =3D cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
>  =09/*
>  =09 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>  =09 * and can't be disabled anyway.
> @@ -587,12 +595,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  =09=09=09=09continue;
> =20
>  =09=09=09value =3D cdns_pcie_ep_fn_readl(pcie, epf,
> -=09=09=09=09=09CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
> -=09=09=09=09=09PCI_EXP_DEVCAP);
> +=09=09=09=09=09=09      cap + PCI_EXP_DEVCAP);
>  =09=09=09value &=3D ~PCI_EXP_DEVCAP_FLR;
> -=09=09=09cdns_pcie_ep_fn_writel(pcie, epf,
> -=09=09=09=09=09CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
> -=09=09=09=09=09PCI_EXP_DEVCAP, value);
> +=09=09=09cdns_pcie_ep_fn_writel(pcie, epf, cap + PCI_EXP_DEVCAP,
> +=09=09=09=09=09       value);
>  =09=09}
>  =09}
> =20
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/=
controller/cadence/pcie-cadence.h
> index 0a4a8bfd3174..e7c108f6e0b2 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -125,11 +125,6 @@
>   */
>  #define CDNS_PCIE_EP_FUNC_BASE(fn)=09(((fn) << 12) & GENMASK(19, 12))
> =20
> -#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET=090x90
> -#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET=090xb0
> -#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET=090xc0
> -#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET=090x200
> -
>  /*
>   * Endpoint PF Registers
>   */
>=20

Nice to see these go away.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-779561234-1748944186=:937--

