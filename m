Return-Path: <linux-pci+bounces-16310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5709C15DC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 06:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66B9B23ED0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 05:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D286126BE1;
	Fri,  8 Nov 2024 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rn2hkYvF"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF159CA6F;
	Fri,  8 Nov 2024 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042383; cv=none; b=BI+JiNMspGOSNs/N+LQhswP0M6IgpZPGJ1yGMfM4E+uA8ZtNB9n+ELHebFcNbRB1R7HANW2XZ+5UWzGu1Eh9g6iO/ODrji3NZDxa7FPY31Voz+r0quGbwjxIMEAvc7YmKhv+VXoYRuXOPjXYUG2/gpSga7HigB3fGzZDvLezQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042383; c=relaxed/simple;
	bh=OJArgu0xE2/lQeE0J0xckqURWJohssppDrv7PNXDZNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLU8eQ+MD5IcZKvHPmXl2UrOLUQAeuEmi3gVM4YV4IgptODmZVZ9RL2pLpi2MkCvB4VwLX3bYJkzVcUQYwh8sGTI01H6UNIKZvCilcK0612DlhYC8Aaw60IT52vyUsKiaD1HszgvlH+6qWmd5eJMI8q5C4EzkGj0C+0z5gI1sLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rn2hkYvF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A855S67060913;
	Thu, 7 Nov 2024 23:05:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731042328;
	bh=exMs8dRJNb40qSDWYqjC7kbZHKIwFJKbmdXtVqWShjw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Rn2hkYvF7K7KgeuKuGTVmUpRIHCIamFuw5xKvt4LWWRSeXQPxN1Oz2aGwd7C1PYUB
	 j5+CR7S2ATyiTGqzjtR/hrgHTTxIftKTpaAkKbxSvue9y3tqtJ1PNDmDLaiLnShGHi
	 jEYIMzpC8sjKXM2vVmqYab3T2kk4imjwmucXCsGs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A855SUd030448
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 23:05:28 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 23:05:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 23:05:28 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A855R5C011753;
	Thu, 7 Nov 2024 23:05:27 -0600
Date: Fri, 8 Nov 2024 10:35:26 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Bjorn Helgaas
	<helgaas@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>,
        <manivannan.sadhasivam@linaro.org>, <kishon@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <cassel@kernel.org>,
        <dlemoal@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <97561a54-8d80-4786-9171-5208128c3a2f@ti.com>
References: <5983ad5e-729d-4cdc-bdb4-d60333410675@ti.com>
 <20241106154945.GA1526156@bhelgaas>
 <20241106160520.GD2745640@rocinante>
 <4fc87e39-ae2f-4ac9-ace3-26b2b79e2297@ti.com>
 <20241107155144.GB1297107@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107155144.GB1297107@rocinante>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Nov 08, 2024 at 12:51:44AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > > Added Cc for stable releases.  Siddharth, let me know how to update the
> > > commit log per Bjorn feedback, so I can do it directly on the branch.
> > 
> > The existing commit message could be replaced by the following:
> > 
> > ------------------------------------------------------------------------
> > commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
> > Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
> > device data ("struct ks_pcie_of_data"). However it failed to set the mode
> > for "ti,keystone-pcie" compatible.
> > 
> > Since the mode defaults to "DW_PCIE_UNKNOWN_TYPE", the following error
> > message is displayed:
> > 	"INVALID device type 0"
> > for the v3.65a controller. Despite the driver probing successfully, the
> > controller may not be functional in the Root Complex mode of operation.
> > 
> > So, set the mode as Root Complex for "ti,keystone-pcie" compatible to fix
> > this.
> > ------------------------------------------------------------------------
> 
> Done.  See the following:
> 
>   - https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/keystone&id=5a938ed9481b0c06cb97aec45e722a80568256fd

LGTM. Thank you for updating the commit message :)

Regards,
Siddharth.

