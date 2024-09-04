Return-Path: <linux-pci+bounces-12740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4ED96B813
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BCE1F22642
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EFE188590;
	Wed,  4 Sep 2024 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YV+mZJVh"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A861EBFEB;
	Wed,  4 Sep 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445032; cv=none; b=hWZahFA84Wzlqkidc1JDj7tHyR8p/U5Q+wPcYXKyhOrcI3ns1k7MWPuGHNYhS3UDva3v93HqS3MMmgLoq1Di8Ikq/d4liEG1RMP+lTkpRhG91LIRnxa/E9TyaIj8WxKZPr61Xna2bB4uRxnO00g8ik7tVCOTTUXiAmD38HfD10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445032; c=relaxed/simple;
	bh=FnEjqY4BG/8kvJMrNnmifTj76ikhWyHxBitrNTqF1K4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfMWfXhd2T6pvHgO8f4emCELLvOpuixaYuVuu+J3GEutql628hNk8/UdcmtCeCAT7ZdM1gL1N8Z9Zyi40vwoz8lDWVnjS4OSIwG/z6x6O7to74mA3ns8SlOufiunhBGHIE2GOlbLBQruDkYeEdf27H/WPSa92C0sMCX5ZXx7YIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YV+mZJVh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484AGwMr021180;
	Wed, 4 Sep 2024 05:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725445018;
	bh=u4MwSTXsohCD+Bwq1qmj42jZwugtsKWFnbQOJvseaGo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YV+mZJVhnAyqUI2XKuUDiaqi8JdCwHsZf4VaDoe8qqDXuscKYC5tqw1xqm7Eygh8Y
	 82gMZvUYpPBx7L4vV0zbk6xqac3OSF7mWJMXp9rDmCgeA/JN4vHEunT/WlMy+Crcj7
	 yuKyhnjAT7BrLO5+zVLk8qZDWYbb+N5ltv5HXDZc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 484AGv32029998
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Sep 2024 05:16:58 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 05:16:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 05:16:57 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484AGuOH041850;
	Wed, 4 Sep 2024 05:16:57 -0500
Date: Wed, 4 Sep 2024 15:46:56 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
        Bao
 Cheng Su <baocheng.su@siemens.com>,
        Hua Qian Li <huaqian.li@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <6d722868-271a-485b-a7af-e2449adc83ca@ti.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
> to specific regions of host memory. Add the optional property
> "memory-regions" to point to such regions of memory when PVU is used.
> 
> Since the PVU deals with system physical addresses, utilizing the PVU
> with PCIe devices also requires setting up the VMAP registers to map the
> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
> mapped to the system physical address. Hence, describe the VMAP
> registers which are optionally unless the PVU shall used for PCIe.

The last line above seems to be accidentally modified when compared to
the one at:
https://lore.kernel.org/r/ada462d5-157a-4e11-ba25-d412a2bb678f@ti.com/
"Hence, describe the VMAP registers which are optionally
configured whenever PVU is used for PCIe."

If you intended to modify it, then the sentence appears distorted.

Regards,
Siddharth.

