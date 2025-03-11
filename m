Return-Path: <linux-pci+bounces-23439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE803A5C774
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B413A7786
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC1325E831;
	Tue, 11 Mar 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x3k55r90"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82F25B69D;
	Tue, 11 Mar 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706976; cv=none; b=TyBnhCbAYss5CX16dIq5P85s5aVZsOazXpbThvPy+JUtp3xEdnXaBHVBDdtla3q5DOEv3RU71F+1mIN0mrd+k79dlt44t3JO8s9fkOsemP43LKuZVd1X8jH3NLRR8BYbHy91XRIwTxZVANWI1E1EfCcZdYStruNYKMsvWwNP67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706976; c=relaxed/simple;
	bh=qbsyL+UEeBCHOjUpWQIpphC96Qt1s7uj+6YFkvQVOuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3q97+pgsiDH8XugNZzhC7u+ZY8LLl+xIBJqCa2qBVxxkZ+5cl2CzoqEI2e08llXIkX2ZMNac6iv5zbjveRHprVs14FuNc7CGsMW4cMTJ/r0oaiXKSdt2zr0Y1jNJZry8xm5flx83L1FXdz0+db6cCBjnSmje9bukH5G73A6DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x3k55r90; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFTNKP1221695
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 10:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741706963;
	bh=WaIUReCTcoh94jk11jEfjg06go62dK/AeBJ/ZKOUjCc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=x3k55r90Ny5iSVvvY6DGis99lOaOFRjbcemB+DWEmOnmPme+Y4b0T6Je8gMsSvmK8
	 ZqAIkpn5zd47QXlKoJCDXXpya8b7T+Fzm9kAechpBUK8B2OTDTaoXNkwDMab2Q/KKl
	 KvL8p9j3QGyrHI7zkd4eqztaPIIqHfd4Oz/QYCqY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52BFTNgY124191
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 10:29:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 10:29:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 10:29:22 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52BFTLT3014640;
	Tue, 11 Mar 2025 10:29:22 -0500
Date: Tue, 11 Mar 2025 20:59:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <rogerq@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250311152921.cwb7obw5bmlrhvsi@uda0492258>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
 <20250310210746.GA2377483@rocinante>
 <20250311051806.smcu4o4dxpngimth@uda0492258>
 <20250311072546.GA277060@rocinante>
 <20250311073216.ynw7rzmu36dwywij@uda0492258>
 <20250311152133.GC1381004@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311152133.GC1381004@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Mar 12, 2025 at 12:21:33AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > No need to send a new version.
> > > 
> > > I will update the branch directly when I pull the patch.  Not to worry.
> > 
> > Thank you Krzysztof :)
> 
> Done.  Have a look at:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/j721e&id=01d04dcd6e80f63ca5e97324ec17c20553947e35
> 
> Let me know if there is anything else to update.

The changes look good to me. There seems to be a minor typo in the
commit message:
[kwilczynski: add a issing .linkdown_irq_regfield member set to

You probably meant "missing".

Thank you once again for fixing it without the need for a new patch.

Regards,
Siddharth.

