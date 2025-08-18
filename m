Return-Path: <linux-pci+bounces-34215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86758B2AF40
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5DA1961D62
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A1F266B41;
	Mon, 18 Aug 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TGnmXPWw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C725FA05
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537560; cv=none; b=HpkLRCVL+pHzr0LgXUTAtWGpdzrOZAmcTrGXiPTwWcGV80hiRVscKid6m2mJZ1IVEQetSCpcX0yW1lTJmmeQEpPJCDUc2yS4ll+zHetrklJ5Gz7+CFuXAbhGEljJkcwbPnV//ALbkYvyexlGGcVbvjyE184OMVSg+ybYGsKcvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537560; c=relaxed/simple;
	bh=auDcc8POxGdUglYbsUf2KJAYFFjvbXura9oOyvF+Jo8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=k43fNvUHsJGWdBI8pBKrJsvBDxfSjn+eFBCV9hP6sUdkRvFeYCfJyMw9H1nRb5HwNoVTPl3JM7Iut4uJooZsdA1icXwtHy0Cao8c1/9nmtQjFSQtTvnWYKwmmNkwN5X7yJJu3f+b7/IRImKb+fbiEd6Cf4RHrAnKnlQ/1ST4NhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TGnmXPWw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250818171916epoutp03df3dc46789c619faaf8589aef1152c3a~c7BtFWr4o2183621836epoutp03K
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 17:19:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250818171916epoutp03df3dc46789c619faaf8589aef1152c3a~c7BtFWr4o2183621836epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755537556;
	bh=RP2yA5MEhaqxhoH+gVDmsv00FKB2mOwlfQHcTXbYEOE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=TGnmXPWwB5xXV9w1wRLWryg35S4Xw2TeqlANsWJUrT6M/NLqnOEFlb2BCMSPIKQSs
	 gWUHGswOGwzpX81YAyrEcQXOtfd4zr+asG7jDVuIhR2qdajhH2EtW4cW31D5oP0IXt
	 KaKuOYCtEoS1sOhVKN4ihMhNAeiJks79pdclQrrg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250818171915epcas5p3fda06f50b251c0e3ea18d58c37f0d1af~c7BsVktPW0774307743epcas5p3t;
	Mon, 18 Aug 2025 17:19:15 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c5KFZ6Nmgz3hhT3; Mon, 18 Aug
	2025 17:19:14 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250818093004epcas5p4c46fe2d6fc7c91374cf77db02bf234cb~c0oCDGq7H2540125401epcas5p49;
	Mon, 18 Aug 2025 09:30:04 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250818093001epsmtip194aa4c1a2b5b3c72a857795443a3da04~c0n-VJYuJ2375823758epsmtip1C;
	Mon, 18 Aug 2025 09:30:01 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20250813230744.GA299971@bhelgaas>
Subject: RE: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Date: Mon, 18 Aug 2025 15:00:00 +0530
Message-ID: <000d01dc1022$ad8c0740$08a415c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHOko1UmKBgSR8l8U+0sy0UMlp1MAHKE5YvtHTNStA=
Content-Language: en-in
X-CMS-MailID: 20250818093004epcas5p4c46fe2d6fc7c91374cf77db02bf234cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813230750epcas5p2101d8bb07332cde1beabe70ca6227aca
References: <CGME20250813230750epcas5p2101d8bb07332cde1beabe70ca6227aca@epcas5p2.samsung.com>
	<20250813230744.GA299971@bhelgaas>

> On Mon, Aug 11, 2025 at 09:16:37PM +0530, Shradha Todi wrote:
> > Add host and endpoint controller driver support for FSD SoC.
> 
> I think this might be easier if you added host mode first, then added
> endpoint mode with a separate patch.
> 

Will do.

> It's kind of unfortunate that the driver uses "ep" everywhere for
> struct exynos_pcie pointers.  It's going to be confusing because "ep"
> is also commonly used for endpoint-related things, e.g., struct
> dw_pcie_ep pointers.  Maybe it's not worth changing; I dunno.
> 

I did try to rename the structure and the pointers 
(https://lore.kernel.org/all/20230214121333.1837-9-shradha.t@samsung.com/)
But the intention was different back then and so the idea was rejected.
I could add a patch to only rename the pointers to something less
confusing like "exy_pci"

> > +static irqreturn_t fsd_pcie_irq_handler(int irq, void *arg)
> > +{
> > +	u32 val;
> > +	struct exynos_pcie *ep = arg;
> > +	struct dw_pcie *pci = &ep->pci;
> > +	struct dw_pcie_rp *pp = &pci->pp;
> > +
> > +	val = readl(ep->elbi_base + FSD_IRQ2_STS);
> > +	if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
> > +		val &= FSD_IRQ_MSI_ENABLE;
> > +		writel(val, ep->elbi_base + FSD_IRQ2_STS);
> 
> This looks weird because FSD_IRQ_MSI_ENABLE sounds like an *enable*
> bit, but here you're treating it as a *status* bit.
> 
> As far as I can tell, you set FSD_IRQ_MSI_ENABLE once at probe-time in
> fsd_pcie_msi_init(), then you clear it here in an IRQ handler, and it
> will never be set again.  That seems wrong; am I missing something?
> 

Actually the status IRQ and enable IRQ registers are different offsets
but the bit position for MSI remains same in both cases so I just reused
the macro. But I understand that it's confusing so I will add another
macro for FSD_IRQ_MSI_STATUS or just rename the macro to
FSD_IRQ_MSI to re-use.

> > +		dw_handle_msi_irq(pp);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void fsd_pcie_msi_init(struct exynos_pcie *ep)
> > +{
> > +	int val;
> > +
> > +	val = readl(ep->elbi_base + FSD_IRQ2_EN);
> > +	val |= FSD_IRQ_MSI_ENABLE;
> > +	writel(val, ep->elbi_base + FSD_IRQ2_EN);
> > +}
> > +
> > +static void __iomem *fsd_atu_setting(struct dw_pcie *pci, void __iomem *base)
> 
> The "setting" name suggests that this merely returns an address
> without side effects, but in fact it actively *sets* the view.
> 
> In this case there's no locking around:
> 
>   addr = fsd_atu_setting(pci, base);
>   dw_pcie_read(addr + reg, size, &val);
> 
> even though concurrent calls would cause issues, but I think that's OK
> because we only get there via the driver, and I assume multiple DBI or
> DBI2 accesses never happen because they're not used in asynchronous
> paths like interrupt handlers.
> 

Yes, there is no concurrent access to this function and hence I have
not added locking mechanism.

> But I think a name that hints at the fact that this does have side
> effects would be helpful as a reminder in the callers that they must
> not be used concurrently.
> 

Sure, I will change the name and also add comment as a reminder.

> > +static const struct pci_epc_features fsd_pcie_epc_features = {
> > +	.linkup_notifier = false,
> > +	.msi_capable = true,
> > +	.msix_capable = false,
> 
> I think we should omit features we do *not* support instead of calling
> them out explicitly, e.g., we don't need .linkup_notifier or
> .msix_capable.
> 
> We've added them in the past, but they're unnecessary and they lead to
> either pervasive changes (adding ".new_feature = false" to all
> existing drivers when adding the feature) or inconsistency (new
> drivers include ".new_feature = false" but existing drivers do not).
> 

Will remove

> > +	if (ep->pdata->soc_variant == FSD) {
> > +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> > +		if (ret)
> > +			return ret;
> > +
> > +		ep->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +				"samsung,syscon-pcie");
> > +		if (IS_ERR(ep->sysreg)) {
> > +			dev_err(dev, "sysreg regmap lookup failed.\n");
> > +			return PTR_ERR(ep->sysreg);
> > +		}
> > +
> > +		ret = of_property_read_u32_index(dev->of_node, "samsung,syscon-pcie", 1,
> > +						 &ep->sysreg_offset);
> > +		if (ret) {
> > +			dev_err(dev, "couldn't get the register offset for syscon!\n");
> > +			return ret;
> > +		}
> > +	}
> 
> This is a good example of a complicated set of things where I think
> you should either add a SoC-specific function pointer to do this or
> test a property, e.g., "DMA width", instead of testing for a specific
> SoC.
> 

Got your point and it makes sense. In future, other drivers could also
want to set DMA width, etc. Will make properties to replace soc_variant:
 - DMA_width
 - has_syscon
 - function pointer to assert_core_reset and deassert_core_reset

Any suggestions or is this approach okay?

-Shradha


