Return-Path: <linux-pci+bounces-35300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063CBB3F423
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 07:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07EE3B29C4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 05:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A562274B31;
	Tue,  2 Sep 2025 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g2UQ3clM"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CD635;
	Tue,  2 Sep 2025 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756789512; cv=none; b=gZQ9U7o5WXXEvN12shv9zkQRJn2+StmoCCwGCW2ywZd8WHSJy5jn+YXYu8xc5mRkFEEm8FDv8LcY32z+chuERslIl7gajd+BfqNycrfuBz1xlGkoxLnI62LorBjpDhQUCrgzTJQUHrCX47rrMuTWouvvEsv9UVDFWUYiZjfAzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756789512; c=relaxed/simple;
	bh=4Uoz/TuOXbA3W3vKtblJsBp1uKjF8Y65YHLvdHQ3NrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMVuNksFitIGlULsrlcnMaJEO+kduMUVPT4bMddJ/+liYrCYgYbAo/heTyTwjiqyfAH7YrEVdbDszB09FEKWSB0fjIikF1Bs5O2tb/ljAaQYwbzSJ1+4S6qTa5DcJPZNtm62qbrQtXJyZKb8UTTFm4+XnJNxcvI8ULYWH/sj+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g2UQ3clM; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58254rTF2907370;
	Tue, 2 Sep 2025 00:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756789493;
	bh=KiCSG+FWn7wT91Kqc9IfCxj4YVRksH0HnJ9uZhIZXZk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=g2UQ3clMuq7E4+YaBXRfrQeyFcjGu2XGZ63cr/Xa9Fb7qmAGyBug0jrL9nyc6FQ1/
	 lnTgJ3XrhmFo+SGzGz3iz6j3JLAjy1NMVZ8SHv2jvomzWMDRraCrZ2g0zb4CtPFw47
	 ccfjCfrVzsrftizgbk2+JUbIhLXj8aOc7R99tdhU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58254rhf3227998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 00:04:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 00:04:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 00:04:53 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58254pJh3519022;
	Tue, 2 Sep 2025 00:04:52 -0500
Date: Tue, 2 Sep 2025 10:34:51 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <helgaas@kernel.org>, <kishon@kernel.org>, <vigneshr@ti.com>,
        <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <08b87b5f-838b-4f40-ae90-10ded134356e@ti.com>
References: <20250829091707.2990211-1-s-vadapalli@ti.com>
 <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
 <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
 <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
 <48e9d897-2cd3-48ef-b46a-635ae75f5ac6@ti.com>
 <3wc3t6y5gzzspgfeklsqo3bupfp6gsfy6mls6t66hflcqlqsfk@cu26wv3sow4y>
 <9d2bba15-52e4-432a-8f7f-a0f5d7c2e4ad@ti.com>
 <7hxdcjm7evlphkldct7seytno4is7rjkx5vquvtfhpdkzxdhu6@yocrjgzciwu3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7hxdcjm7evlphkldct7seytno4is7rjkx5vquvtfhpdkzxdhu6@yocrjgzciwu3>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 01, 2025 at 08:15:24PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 01, 2025 at 04:50:02PM GMT, Siddharth Vadapalli wrote:
> > On Mon, Sep 01, 2025 at 12:14:51PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Sep 01, 2025 at 11:51:33AM GMT, Siddharth Vadapalli wrote:

[...]

> > > > 
> > > > If I understand correctly, are you suggesting the following?
> > > > 
> > > > j721e_pcie_probe()
> > > > 	pm_runtime_set_active()
> > > > 	pm_runtime_enable()
> > > > 	ret = j721e_pcie_ctrl_init(pcie);
> > > > 		/*
> > > > 		 * PCIe Controller should be powered off here, but is there
> > > > 		 * a way to ensure that it has been powered off?
> > > > 		 */
> > > > 		=> Program the strap settings and return to
> > > > 		j721e_pcie_probe()
> > > > 	/* Power on the PCIe Controller now */
> > > > 	ret = pm_runtime_get_sync(dev);
> > > 
> > > This pm_runtime_get_sync() should be part of j721e_pcie_ctrl_init() where you
> > > do power off, program strap and power on.
> > > 
> > > This should not be part of probe() as by that time, controller is already
> > > powered on. So pm_runtime_set_active() and pm_runtime_enable() should be enough
> > > to convey the state of the device to PM core.
> > 
> > I have tried out the suggestion in the following manner:
> > 
> > 	j721e_pcie_probe()
> > 		...
> > 		pm_runtime_set_active(dev);
> > 		pm_runtime_enable(dev);
> > 		ret = j721e_pcie_ctrl_init(pcie);
> > 			... within j721e_pcie_ctrl_init()
> > 			ret = pm_runtime_put_sync(dev);
> > 			/* Program Strap Settings */
> > 			ret = pm_runtime_get_sync(dev);
> > 			...
> > 		...
> > 		exit probe
> > 
> > Since a 'pm_runtime_get_sync()' hasn't yet been invoked prior to the
> > section where 'pm_runtime_put_sync()' is invoked, it leads to a ref-count
> > underflow error at runtime. Please let me know if I am missing
> > something.
> > 
> 
> Doh... At the start of probe(), device PM usage_count will be 0. So we cannot
> decrement it without incrementing it.
> 
> Could you try below sequence?
> 
> 	probe()
> 	...
> 	pm_runtime_set_active()
> 	pm_runtime_enable()
> 	j721e_pcie_ctrl_init()
> 		...
> 		pm_runtime_get() /* Just increment usage_count */
> 		pm_runtime_put_sync() /* ask PM core to turn off */
> 		/* program strap setting */
> 		pm_runtime_get_sync() /* ask PM core to turn on */
> 		pm_runtime_put_noidle() /* balance the usage_count without
> 						suspending the device */
> 	...

The above sequence powers off the controller at the point in time that
the strap settings are programmed. 'pm_runtime_get_sync()' is powering
on the controller afterwards. However, the 'pm_runtime_put_noidle()'
at the end is causing the controller to be powered off again leading to
a crash. Removing 'pm_runtime_put_noidle()' results in a functional
sequence.

Please consider the existing sequence prior to this patch:

probe()
	...
	pm_runtime_enable()
	pm_runtime_get_sync() => usage_count is 1
	...
	exit probe

With the suggested sequence above, we have:

probe()
	...
	pm_runtime_set_active()
	pm_runtime_enable()
	j721e_pcie_ctrl_init()
		...
		pm_runtime_get() => usage_count is 1
		pm_runtime_put_sync() => usage_count is 0
		/* Controller is powered off now */
		/* Strap settings are programmed */
		pm_runtime_get_sync() => usage_count is 1
		/* Controller is powered on now */
		pm_runtime_put_noidle() => usage_count is 0
		/* Controller is powered off in a while */
	...
	/* Crash is observed aroung this point before probe finishes */

Please let me know if the fix is to drop 'pm_runtime_put_noidle()'
from the above sequence.

Regards,
Siddharth.

