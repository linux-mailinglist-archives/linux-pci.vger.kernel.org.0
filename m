Return-Path: <linux-pci+bounces-36109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF13B56FB9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 07:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2084D174314
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392A17BEBF;
	Mon, 15 Sep 2025 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3yzoMuo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0AD531;
	Mon, 15 Sep 2025 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757914384; cv=none; b=Rho2DuBicgZK0a2IDmVaDcctIQx9zp/J2T2WcGgZjptXaK5iG7WuihQ1HVaFEfcey4nr+pnHIpy+QaIcSXKPUnbI8fk0Mw5Z8mn98xeQ00qJ9UITBqhXuYTavEWMJrqyJxNk/gvvf8z5cf44cM/A2rvVSkFNdFV5CTM4H4rAUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757914384; c=relaxed/simple;
	bh=HpmCJ4eFATmTDRYAdApBmGoVoQoMc+eFYQfE4ORRlhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkNTocGZhgSXfKztNxX65LJZYFtQDbE+wvKsAfDr56fB/4RnNwbt9j4C95KbkNO5/VteOBsr3hA0I1oyvF0mb/YEY/6zO02U0exDFug+O5xrGDDsqAn7GnrJD0mvgC+5iDrEcMnpL7qJlbh2J0J01iB/dSuSl6kuPie/KTjQnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3yzoMuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBBCC4CEF1;
	Mon, 15 Sep 2025 05:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757914381;
	bh=HpmCJ4eFATmTDRYAdApBmGoVoQoMc+eFYQfE4ORRlhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3yzoMuoTRz8orTbe/nvMZ5FEGX3xT0f/GK+Etiiy0sui/ukz+wEDLGOQFsYI6rf5
	 2DxXG8oAjgwTK/jWwZeyECyyQfixkiUs2GtMS0TyPQ2QAOjFvfG5eTMNv+O0p6W6Ec
	 NzRUBr+JSNJioUi9wzC16EWrfjEH45+e6HgkoBSzu7gcUBNYsxNlhPkLFBDyOgBfdk
	 YIIevvDNiPXJsySAxt0geT8VMfLyWPeybZatG5Vn9Ls6996+p6FkUrk5fi9KeRrgkk
	 Sv64u7N5R2cJssYVxJEG2VxxoNQpGIpGZAeueLc7xcso3gmitWRB2JKHJb3qmNHXpm
	 MjkR2rhFlcaZA==
Date: Mon, 15 Sep 2025 11:02:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>, 
	"guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>, "peter.chen@cixtech.com" <peter.chen@cixtech.com>, 
	"cix-kernel-upstream@cixtech.com" <cix-kernel-upstream@cixtech.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 03/14] PCI: cadence: Add register definitions for High
 Perf Architecture (HPA)
Message-ID: <3j6x2df3k2e7bvofjpd4m5m3hdq46h2igkz6u4fu4awnvaxfh2@jhofj7oiqd74>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
 <20250901092052.4051018-4-hans.zhang@cixtech.com>
 <ilpurwleklzj5dskokypmepizwqixycyvk52qsocgwhpmyy2hz@2wvalkxquari>
 <CH2PPF4D26F8E1C0A1FADD4357EBF526BAAA20CA@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH2PPF4D26F8E1C0A1FADD4357EBF526BAAA20CA@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Mon, Sep 08, 2025 at 11:02:04AM GMT, Manikandan Karunakaran Pillai wrote:
> 
> 
> >
> >EXTERNAL MAIL
> >
> >
> >On Mon, Sep 01, 2025 at 05:20:41PM GMT, hans.zhang@cixtech.com wrote:
> >> From: Manikandan K Pillai <mpillai@cadence.com>
> >>
> >> Add the register offsets and register definitions for High Performance
> >> Architecture (HPA) PCIe controllers from Cadence.
> >>
> >> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> >> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> >> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> >
> >No need to split this into a separate patch. Squash it with the patch that adds
> >the code consuming these.
> >
> >- Mani
> 
> Some of the earlier comments on the same patch set required that moves/splitting of a file be in a separate patch and also the size of the patch be kept to a manageable size.  Please let me know if you would still like this patch to be clubbed into a bigger patch.
> 

Please wrap your replies to 80 columns.

It is generally recommended to split the patches in a logical chunk to help with
the reviews. But splitting the header definitions and the actual code that makes
use of them into separate patches are not logical chunks.

- Mani

> Manikandan Pillai
> >
> >> ---
> >>  .../cadence/pcie-cadence-hpa-regs.h           | 192 ++++++++++++++++++
> >>  drivers/pci/controller/cadence/pcie-cadence.h |   1 +
> >>  2 files changed, 193 insertions(+)
> >>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
> >b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
> >> new file mode 100644
> >> index 000000000000..7ef87cf96836
> >> --- /dev/null
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
> >> @@ -0,0 +1,192 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Cadence PCIe controller driver.
> >> + *
> >> + * Copyright (c) 2019, Cadence Design Systems
> >> + * Author: Manikandan K Pillai <mpillai@cadence.com>
> >> + */
> >> +#ifndef _PCIE_CADENCE_HPA_REGS_H
> >> +#define _PCIE_CADENCE_HPA_REGS_H
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/pci-epf.h>
> >> +#include <linux/phy/phy.h>
> >> +#include <linux/bitfield.h>
> >> +
> >> +/* High Performance Architecture (HPA) PCIe controller registers */
> >> +#define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
> >> +#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
> >> +#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x01020000
> >> +
> >> +/* Address Translation Registers */
> >> +#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
> >> +#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
> >> +
> >> +/* Root Port register base address */
> >> +#define CDNS_PCIE_HPA_RP_BASE			0x0
> >> +
> >> +#define CDNS_PCIE_HPA_LM_ID			0x1420
> >> +
> >> +/* Endpoint Function BARs */
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
> >> +	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
> >> +			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) +
> >0x04)
> >> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
> >> +	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
> >> +			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
> >> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) +
> >0x08)
> >> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) +
> >0x0C)
> >> +#define
> >CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
> >> +	(GENMASK(9, 4) << ((f) * 10))
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
> >> +	(((a) << (4 + ((b) * 10))) &
> >(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
> >> +	(GENMASK(3, 0) << ((f) * 10))
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
> >> +	(((c) << ((b) * 10)) &
> >(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
> >> +
> >> +/* Endpoint Function Configuration Register */
> >> +#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02C0
> >> +
> >> +/* Root Complex BAR Configuration Register */
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG                        0x14
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK
> >GENMASK(9, 4)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
> >> +
> >	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MA
> >SK, a)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK
> >GENMASK(3, 0)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK
> >GENMASK(19, 14)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
> >> +
> >	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MA
> >SK, a)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK
> >GENMASK(13, 10)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
> >> +
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE
> >BIT(20)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS
> >BIT(21)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
> >> +#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
> >> +
> >> +/* BAR control values applicable to both Endpoint Function and Root
> >Complex */
> >> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
> >> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
> >> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
> >> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS
> >0x9
> >> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
> >> +#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS
> >0xD
> >> +
> >> +#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
> >> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) *
> >10))
> >> +#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
> >> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) *
> >10))
> >> +#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
> >> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar)
> >* 10))
> >> +#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
> >> +
> >	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS <<
> >((bar) * 10))
> >> +#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
> >> +		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar)
> >* 10))
> >> +#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
> >> +
> >	(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS <<
> >((bar) * 10))
> >> +#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
> >> +		(((aperture) - 7) << ((bar) * 10))
> >> +
> >> +#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
> >> +#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
> >> +
> >> +/* Root Port Registers PCI config space for root port function */
> >> +#define CDNS_PCIE_HPA_RP_CAP_OFFSET	0xC0
> >> +
> >> +/* Region r Outbound AXI to PCIe Address Translation Register 0 */
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r)            (0x1010 +
> >((r) & 0x1F) * 0x0080)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK
> >GENMASK(5, 0)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
> >> +	(((nbits) - 1) &
> >CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK
> >GENMASK(23, 16)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
> >> +
> >	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_M
> >ASK, devfn)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK
> >GENMASK(31, 24)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
> >> +
> >	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK
> >, bus)
> >> +
> >> +/* Region r Outbound AXI to PCIe Address Translation Register 1 */
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r)            (0x1014 +
> >((r) & 0x1F) * 0x0080)
> >> +
> >> +/* Region r Outbound PCIe Descriptor Register */
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)                (0x1008 + ((r)
> >& 0x1F) * 0x0080)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK
> >GENMASK(28, 24)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK,
> >0x0)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK,
> >0x2)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK,
> >0x4)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK,
> >0x5)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK,
> >0x10)
> >> +
> >> +/* Region r Outbound PCIe Descriptor Register */
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)        (0x100C + ((r) &
> >0x1F) * 0x0080)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK
> >GENMASK(31, 24)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK,
> >bus)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK
> >GENMASK(23, 16)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK,
> >devfn)
> >> +
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r)         (0x1018 + ((r) &
> >0x1F) * 0x0080)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
> >> +
> >> +/* Region r AXI Region Base Address Register 0 */
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r)     (0x1000 + ((r) &
> >0x1F) * 0x0080)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK
> >GENMASK(5, 0)
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
> >> +	(((nbits) - 1) &
> >CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
> >> +
> >> +/* Region r AXI Region Base Address Register 1 */
> >> +#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r)     (0x1004 + ((r) &
> >0x1F) * 0x0080)
> >> +
> >> +/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
> >> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar)              (((bar) *
> >0x0008))
> >> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK
> >GENMASK(5, 0)
> >> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
> >> +	(((nbits) - 1) & CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
> >> +#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar)              (0x04 + ((bar)
> >* 0x0008))
> >> +
> >> +/* AXI link down register */
> >> +#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
> >> +
> >> +/*
> >> + * Physical Layer Configuration Register 0
> >> + * This register contains the parameters required for functional setup
> >> + * of Physical Layer.
> >> + */
> >> +#define CDNS_PCIE_HPA_PHY_LAYER_CFG0               0x0400
> >> +#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26,
> >24)
> >> +#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
> >> +	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK,
> >delay)
> >> +#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
> >> +
> >> +#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0             0x0420
> >> +
> >> +#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
> >> +#define CDNS_PCIE_HPA_MAX_OB        15
> >> +
> >> +/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register
> >*/
> >> +#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) (((fn) *
> >0x0040) + ((bar) * 0x0008))
> >> +#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) (0x4 + ((fn)
> >* 0x0040) + ((bar) * 0x0008))
> >> +
> >> +/* Miscellaneous offsets definitions */
> >> +#define CDNS_PCIE_HPA_TAG_MANAGEMENT        0x0
> >> +#define CDNS_PCIE_HPA_SLAVE_RESP            0x100
> >> +
> >> +#define I_ROOT_PORT_REQ_ID_REG              0x141c
> >> +#define LM_HAL_SBSA_CTRL                    0x1170
> >> +
> >> +#define I_PCIE_BUS_NUMBERS                  (CDNS_PCIE_HPA_RP_BASE +
> >0x18)
> >> +#endif /* _PCIE_CADENCE_HPA_REGS_H */
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
> >b/drivers/pci/controller/cadence/pcie-cadence.h
> >> index 79df86117fde..ddfc44f8d3ef 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/pci-epf.h>
> >>  #include <linux/phy/phy.h>
> >>  #include "pcie-cadence-lga-regs.h"
> >> +#include "pcie-cadence-hpa-regs.h"
> >>
> >>  enum cdns_pcie_rp_bar {
> >>  	RP_BAR_UNDEFINED = -1,
> >> --
> >> 2.49.0
> >>
> >
> >--
> >மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

