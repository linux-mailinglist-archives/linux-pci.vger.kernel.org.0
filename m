Return-Path: <linux-pci+bounces-15910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86309BACF8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A4A2821D8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BDA18FC7C;
	Mon,  4 Nov 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s5xFpAYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5018C91E;
	Mon,  4 Nov 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704132; cv=none; b=r9fqCkLPKE4zcTvyc85tHi01iJYLBZtxibWphRBeiAApNmvDSiPC+kLg2+D29H1dCFc+Obtr3rnKBGGv7Cb1SzUCzNuIWM2Rm5sci9RXt3zcEX4/qXeL1LXHdRjmxLuDnwaNLytOtQBP2CeRXlThmrWOpKS1liDwP4A/FKwPbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704132; c=relaxed/simple;
	bh=78dbEaDmmE2c/pfPzbqF7TCsLAdRn7fUv12BsV3tLmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp23W+KNGRwb+s6RQ0E3CsanOBaIYAy2wTdGYH/uiSYjzfc7245xUfm+BQQ6mTIN8Y8toSo8rFrhJw2sJDjVNWbiGkfk/EY2DbwsyH59ngjOeE1wtWyDk4xuZJys6gxQmJxhaTgEQv+OC3LF3eXRDwJ2kJp8Mb3xFF7xkWCY4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s5xFpAYw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A478MPl070079;
	Mon, 4 Nov 2024 01:08:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730704102;
	bh=3ytsICwmTbJhe85HPhytqFuyJa0/WkZiLuqCFnEPxn0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=s5xFpAYwqov6w9bqiEVDICYvep4sREnxXz8Fw6lR2kSGs1cjNSkRVo801ESLL+cFy
	 mnSajd+duQpzSHmvMeXychgOlCxTZry4THM9mxAyEn8y0uLwTlu9Eh7EEIzYpdrmfk
	 H2aNAq+AtESPh2JjHTvkjcXBtFP0EfMWN31lCaH0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A478MmU096909
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Nov 2024 01:08:22 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Nov 2024 01:08:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Nov 2024 01:08:22 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A478L0p003184;
	Mon, 4 Nov 2024 01:08:21 -0600
Date: Mon, 4 Nov 2024 12:38:20 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <thomas.richard@bootlin.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Deassert PERST# after a delay of
 PCIE_T_PVPERL_MS ms
Message-ID: <f2af6cea-8365-42eb-be53-634eb0fe7cab@ti.com>
References: <20241022083147.2773123-1-s-vadapalli@ti.com>
 <20241102141914.GA3440781@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102141914.GA3440781@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Nov 02, 2024 at 11:19:14PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > According to Section 2.2 of the PCI Express Card Electromechanical
> > Specification (Revision 5.1), in order to ensure that the power and the
> > reference clock are stable, PERST# has to be deasserted after a delay of
> > 100 milliseconds (TPVPERL). Currently, it is being assumed that the power
> > is already stable, which is not necessarily true. Hence, change the delay
> > to PCIE_T_PVPERL_MS to guarantee that power and reference clock are stable.
> [...]
> > This patch is based on commit
> > c2ee9f594da8 KVM: selftests: Fix build on on non-x86 architectures
> > of Mainline Linux.
> 
> Why KVM?  Do you have the link to this commit handy?

Since this is a fix, I had based the patch on the latest Mainline Linux
with the head corresponding to the aforementioned commit. Link:
https://github.com/torvalds/linux/commit/c2ee9f594da8

> 
> [...]
> >  		if (pcie->reset_gpio) {
> > -			fsleep(PCIE_T_PERST_CLK_US);
> > +			msleep(PCIE_T_PVPERL_MS);
> 
> fsleep() with the same macro and for the same reason is also used in the
> j721e_pcie_probe() callback.  I think, we would want both changed.

Thank you for pointing this out. I will update it in the v2 patch.

Regards,
Siddharth.

