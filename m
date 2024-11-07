Return-Path: <linux-pci+bounces-16193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEA69BFD68
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 05:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874A1B222D3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 04:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703C185B5F;
	Thu,  7 Nov 2024 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XkS3s5av"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6916F84F;
	Thu,  7 Nov 2024 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954416; cv=none; b=X4h28LXMP2zNlHVCcfiYsSrsYGyIYJzFRH7hSlOsvRa77DHCyBzvqw2cFzS7aluCo4qndmQTr3V2LIUYclQayV9xRrJ8+exwfMcsVrFVNuxUkZPm8P1zricG8q9T2F7RQPtN6mdawAmcU76yWBmnWe5591HdQg1XFoGPCnrMUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954416; c=relaxed/simple;
	bh=BfAEohdM0vDwKb9sgDnbFHLUvNH+sE4GWLdTjMmb2p8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzVsv4JybyAyVnKcgH1SfMwUrKP3kBDEK8GT8OauNUZWMSRT+wCxl7foABN2HF96z1o1sPfzKnI45kmWoSEYMeQyz38DAEFsq7LiEUfFzzQIYzDwoS0H8A80+Ufwt2mJVtxh7YI8rU8bIDrg1OiXiPQQGllVj5ptXf9f2Biopik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XkS3s5av; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A74duqZ038732;
	Wed, 6 Nov 2024 22:39:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730954396;
	bh=Smefj2JoEA0WPG52LM77apkAI/T2PGFdONYOL+motPc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XkS3s5aviT4YQUW9oziQzJW6u7Bro4/lKQu+nhITyJ3FWeMMBgKHPdiCvf3XfYk0F
	 OG92pn/kgYNHmm3ixrduzFui++aQrBOqt4o6ehwYFFtnnd4pPrvvd7ZUi4W28gXSp/
	 onx1CA9J309HF8s+B05TVJjqb/atwEU5K2hvIHTY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A74duqG023536
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 22:39:56 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 22:39:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 22:39:55 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A74dsnc005772;
	Wed, 6 Nov 2024 22:39:55 -0600
Date: Thu, 7 Nov 2024 10:09:54 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <kishon@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <4fc87e39-ae2f-4ac9-ace3-26b2b79e2297@ti.com>
References: <5983ad5e-729d-4cdc-bdb4-d60333410675@ti.com>
 <20241106154945.GA1526156@bhelgaas>
 <20241106160520.GD2745640@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106160520.GD2745640@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Nov 07, 2024 at 01:05:20AM +0900, Krzysztof Wilczyński wrote:

Hello Krzysztof,

> Hello,
> 
> [...]
> > > I suppose that "data->mode" will default to zero for v3.65a prior to
> > > this commit, corresponding to "DW_PCIE_UNKNOWN_TYPE" rather than the
> > > correct value of "DW_PCIE_RC_TYPE". Since I don't have an SoC with the
> > > v3.65a version of the controller, I cannot test it out, but I presume
> > > that the "INVALID device type 0" error will be displayed. Though the probe
> > > will not fail since the "default" case doesn't return an error code, the
> > > controller probably will not be functional as the configuration associated
> > > with the "DW_PCIE_RC_TYPE" case has been skipped. Hence, I believe that
> > > this fix should be backported.
> > 
> > I guess nobody really cares too much since it's been broken for almost
> > four years.
> > 
> > But indeed, sounds like it should have a stable tag and maybe a commit
> > log hint about what the failure looks like.
> 
> Added Cc for stable releases.  Siddharth, let me know how to update the
> commit log per Bjorn feedback, so I can do it directly on the branch.

The existing commit message could be replaced by the following:

------------------------------------------------------------------------
commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
device data ("struct ks_pcie_of_data"). However it failed to set the mode
for "ti,keystone-pcie" compatible.

Since the mode defaults to "DW_PCIE_UNKNOWN_TYPE", the following error
message is displayed:
	"INVALID device type 0"
for the v3.65a controller. Despite the driver probing successfully, the
controller may not be functional in the Root Complex mode of operation.

So, set the mode as Root Complex for "ti,keystone-pcie" compatible to fix
this.
------------------------------------------------------------------------

Regards,
Siddharth.

