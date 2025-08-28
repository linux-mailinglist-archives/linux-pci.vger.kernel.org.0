Return-Path: <linux-pci+bounces-34993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C1B39C24
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23F818854F0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBB30E840;
	Thu, 28 Aug 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GgWj1biV"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28130801;
	Thu, 28 Aug 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382676; cv=none; b=svasUMaLBkn9ttiuRgQ37/SjPAvD2vSGrRWRp36i30W1u5kTs95Kdu2ERAhaaJIYOvBUVLmwBVGoPydj4A3VmYx4PY/XNpDprVNVG2TJ3mSMUlYpFlET3V+LT8gUKoAtsR35daa05G+WlWlSqLbyczT9SkGAb1o86QH+tnnZnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382676; c=relaxed/simple;
	bh=ZG9u2u7bKZkymBcTx/Gt+AldiV9hwBFMAEDP2AObum4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXlPhOYSd4w4K2LNJuzJ67c5fMcaSmS2EqHfos5bc5I5TKACD2ffQ28da8Hy/KCUQRC7Tp0h5RgJvXFgcRYEYjUr1sWIXEon0XRS0RdO60DxDaVz0fgnHmaVTnDatPmn7U8xE5/2nc1sIDjufxZPOdb4rj94y2sNhkxafajvwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GgWj1biV; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57SC45LF2000489;
	Thu, 28 Aug 2025 07:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756382645;
	bh=q9G+kMKaEAMkwP/BhuP5u5wT04WjwEoiyWlNSJLDnQU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GgWj1biVWL5DARFBUTJ1hBxtBXfo2T79G/u/UAhrMbnweVzxOOV4nrh+tEQQefzR/
	 xOaP6X4YMcaf+UA1EEXN8IPEgkD4SDIi5ZqSYmZdsqMCyN67TOZ2JWL1A/xOGoOZ4Z
	 PuAxSJPguHW57k4Ln6vSzUAuAOl6ASwVG0c9CUjQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57SC45243444468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 07:04:05 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 07:04:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 07:04:04 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57SC44W6298429;
	Thu, 28 Aug 2025 07:04:04 -0500
Date: Thu, 28 Aug 2025 07:04:04 -0500
From: Nishanth Menon <nm@ti.com>
To: <huaqian.li@siemens.com>
CC: <mani@kernel.org>, <arnd@arndb.de>, <baocheng.su@siemens.com>,
        <bhelgaas@google.com>, <christophe.jaillet@wanadoo.fr>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <diogo.ivo@siemens.com>, <helgaas@kernel.org>,
        <jan.kiszka@siemens.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <kw@linux.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lkp@intel.com>, <lpieralisi@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <robh@kernel.org>,
        <s-vadapalli@ti.com>, <ssantosh@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v12 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
Message-ID: <20250828120404.dtg5n7owgsot6uzf@tightwad>
References: <yhbjfg7dqx3xud75rhwlhq7ayqa4d6wrsan2j7ki7ri3uynpeu@hdv2o33x4hdn>
 <20250828112434.2310936-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250828112434.2310936-1-huaqian.li@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 19:24-20250828, huaqian.li@siemens.com wrote:
> Hi Mani,
> 
> Thanks for your offer to help with the patch series. Yes, let's proceed
> with splitting the submission:
> 
> Please go ahead and take the dt-bindings through the PCI tree. That would
> be helpful to get them established early.
> 
> Hi Arnd,
> 
> Could you please take care of the driver code with the cross-dependencies
> through the arm-soc tree? The PCI controller driver has the API dependency
> with the SoC driver as Mani pointed out. Could you let me know which specific
> components of the series you would be willing to take?

I assume you have seen my reply [1] - I don't intent to carry code
that we don't at least build and let bitrot over time, and we do not
want to enable non-essential drivers as "y" in arm64 defconfig (you can
find enough references in the list on the topic).

[1] https://lore.kernel.org/all/20250729162338.so7evngndnysg4ui@cinnamon/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

