Return-Path: <linux-pci+bounces-26452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A2A97DFA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 07:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316D43BDE88
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B54212FBF;
	Wed, 23 Apr 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mvL4O6fg"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD281F4CB6;
	Wed, 23 Apr 2025 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745384663; cv=none; b=TcEy4+w5FZN80CJ27TG2H+u0kTk9ScaChPQbWL3sdlp9q6LP93uhzIWb9yDUjPAL61z1AttUooBHlJCknMn+6fyAhkqNw9lHrV9F9LbWcyQggd2qJIcZVig70v3sPvLokmei6EahxDsyNeB3se3trC01cj8JpFvAIlSRFmlPwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745384663; c=relaxed/simple;
	bh=LCa5nSU+RimloJrjqyLxUqNkPx8DVPcIknbTh9dronI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl9HfH1rbJwy/PqeeoVoXClHSl3vTlLzDmAbbXSPSF2Wozvq/wrTghgapnjKTi6tBd9S0FFhisYLlt7lCbT9tRA0uudgltN/7V+0lbe56VOTiv6cSA37UVJkbMdxTImMyPraBSSQ/QSd7/tOb9IXVEcoKOzZ1ymv56oALpu/fP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mvL4O6fg; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53N53tB42199968
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 00:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745384635;
	bh=Kne9B5HdCuOKeWEfCSxnIK/Om9pYT1tA2Pc21Izdsiw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mvL4O6fgv/vy8vu+JMpi+BywPYZeqxNja0WbcKaRNcZOKYWeY5c+epfkzyLSQ8XYb
	 Pz0Y6g58h8N5RByhEzaXX+EgwQ8bkPTjA8dDYSMn5GuxWlWNu11LQrLincMdJD9paC
	 cIgorh3DsLgzMUdEstxHd//toEhVLAbC4bz91QuA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53N53tAE016440
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Apr 2025 00:03:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 00:03:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 00:03:54 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53N53rgV084408;
	Wed, 23 Apr 2025 00:03:54 -0500
Date: Wed, 23 Apr 2025 10:33:53 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <18255117159@163.com>, <cassel@kernel.org>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>,
        <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v4 2/4] PCI: cadence-host: Introduce
 cdns_pcie_host_disable helper for cleanup
Message-ID: <35d14093-85b1-4273-810c-2dbeaa3acc4e@ti.com>
References: <20250417124408.2752248-3-s-vadapalli@ti.com>
 <20250422164934.GA333709@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250422164934.GA333709@bhelgaas>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Apr 22, 2025 at 11:49:34AM -0500, Bjorn Helgaas wrote:

Hello Bjorn,

> On Thu, Apr 17, 2025 at 06:14:06PM +0530, Siddharth Vadapalli wrote:
> > Introduce the helper function cdns_pcie_host_disable() which will undo
> > the configuration performed by cdns_pcie_host_setup(). Also, export it
> > for use by existing callers of cdns_pcie_host_setup(), thereby allowing
> > them to cleanup on their exit path.
> 
> For the merge commit log and eventual pull request, can you give me a
> hint about the motivation for this?  Based on the other patches in
> this series, my guess is that this is required for making the j721e
> driver buildable as a module and removable?

I have described the motivation in the cover-letter of this series in
detail. I am sharing the same below for your reference:

"The motivation for this series is that PCIe is not a necessity
for booting the SoC, due to which it doesn't have to be a built-in
module. Additionally, the defconfig doesn't enable the PCIe Cadence
Controller drivers and the PCI J721E driver, due to which PCIe is not
supported by default. Enabling the configs as of now (i.e. without this
series) will result in built-in drivers i.e. a bloated Linux Image for
everyone who doesn't have the PCIe Controller. Therefore, with this
series, after enabling support for building the drivers as loadable
modules, the driver configs can be enabled in the defconfig to build
the drivers as loadable modules, thereby enabling PCIe."

In brief, in order to enable the driver configs, the driver needs to be
a loadable module. Else, the patch for the configs will be rejected:
https://lore.kernel.org/linux-arm-kernel/20250122145822.4ewsmkk6ztbeejzf@slashing/

Regards,
Siddharth.

