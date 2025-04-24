Return-Path: <linux-pci+bounces-26655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B4A9A066
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE525A7CC4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB41A23B0;
	Thu, 24 Apr 2025 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZA9NLSwz"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533F35963;
	Thu, 24 Apr 2025 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745471974; cv=none; b=MH9GTP8452dGVjxF0cQJdM2ikSHRhFP9j0xmCw9wPHd1LjFb+DWni0KokgM094pGT5alA2FTh9a9rmYDcrZnWn7J7xqm1NCbNayB/w0BOA3P1CtSoUIdWV1zK6IfuVQAltYE8I13QQyRRz6jxGPriv9AcgspD3KeqE7vhIyNZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745471974; c=relaxed/simple;
	bh=4ryzhcUAeRnEsFAHV5+kuidBXWoDMlQmTIfVZyXdDEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU/FK1vtu9SXl+OnnqRP/ggOJbPOhvMcJih9wqE3Bl//E8C+rQNBi9Tes+5qJzqo/lyha/PZXNWODFSwbglt9/Rf0fRyMMnsV062p3G8lexu6i8N7W6bCdl696WD6avHsuqy9hjZFe1AScLljLj/DcF16gIwBwdGJxi2R/x5vjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZA9NLSwz; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5JAvq1756408
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745471950;
	bh=AlHahpXnp8IJeAHPagZczFwQdB2gTDNHE9Q1Zh7iQoM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ZA9NLSwzw4l+T1crMjoGLiAMzSUx1V07zKqDk+BL6ZeDY1f+AHsiUvPWZZzaL2scP
	 +/KD3ycD23xEnj1CD8W6UBS7BRXBmunBtTpYw0h7QOHHQSAz9gCizXg2QyhJAs4VbP
	 cUYR8DE/hTkrfiUSLHPjZVJojedvakxIfs7aFIUw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5JAgn022471
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Apr 2025 00:19:10 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 00:19:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 00:19:10 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O5J8Ux080258;
	Thu, 24 Apr 2025 00:19:09 -0500
Date: Thu, 24 Apr 2025 10:49:08 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob
 Herring <robh@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Kishon
 Vijay Abraham I <kishon@kernel.org>,
        Thomas Richard
	<thomas.richard@bootlin.com>,
        =?utf-8?B?VGjDqW8=?= Lebrun
	<theo.lebrun@bootlin.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] pci: j721e: fix host/endpoint dependencies
Message-ID: <573c92aa-f891-47c9-9ea8-c71e89694a11@ti.com>
References: <20250423162523.2060405-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423162523.2060405-1-arnd@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Apr 23, 2025 at 06:25:16PM +0200, Arnd Bergmann wrote:

Hello Arnd,

Thank you for the Fix.

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The j721e driver has a single platform driver that can be built-in or
> a loadable module, but it calls two separate backend drivers depending
> on whether it is a host or endpoint.
> 
> If the two modes are not the same, we can end up with a situation where
> the built-in pci-j721e driver tries to call the modular host or endpoint
> driver, which causes a link failure:
> 
> ld.lld-21: error: undefined symbol: cdns_pcie_ep_setup
> >>> referenced by pci-j721e.c
> >>>               drivers/pci/controller/cadence/pci-j721e.o:(j721e_pcie_probe) in archive vmlinux.a
> 
> ld.lld-21: error: undefined symbol: cdns_pcie_host_setup
> >>> referenced by pci-j721e.c
> >>>               drivers/pci/controller/cadence/pci-j721e.o:(j721e_pcie_probe) in archive vmlinux.a
> 
> Rework the dependencies so that the 'select' is done by the common
> Kconfig symbol, based on which of the two are enabled. Effectively
> this means that having one built-in makes the other either built-in
> or disabled, but all configurations will now build.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

