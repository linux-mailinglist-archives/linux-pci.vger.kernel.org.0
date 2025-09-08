Return-Path: <linux-pci+bounces-35648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4ADB4865C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D887A3BA0E5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF562E8B8F;
	Mon,  8 Sep 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qCVR9Clp"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AD1D63EF;
	Mon,  8 Sep 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318785; cv=none; b=TdKpZeCNEaPzaC1P6X1EOJ28TnLcKW/tAkF+gkySYbL21O1bATiDxkf9Q4e27keWoby2FMAgCFPE7avYS/l4360fd9kuT0bL4w21zYeNQGEnUnsdgs3xTdp3E2cCE4285hh9+ZLffETvy5QXSLlbT3UU7i9xU0Il9PXzhYEtOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318785; c=relaxed/simple;
	bh=AADTfuXK3QYcRRdYSB8hq9lZrJCS1ZTo9xHteQZpwig=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObwekjLn7rzvrJ0fpnkU1gcbGd64AWkOb99Gba9s5x06HJyj/lii1JqEkWbC7ojrFc9nFziBt+ZA9Lqi2yXAsfsB9tEZNEimUzmlovABm3nVW4RM/I7OQ46mmiZxpzQJ/4kSTqn46QbOiOA9a08JXVS6l4vWKFFc4lvbTFa7fZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qCVR9Clp; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58886BF8009467;
	Mon, 8 Sep 2025 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757318771;
	bh=5100fgc6dG24IM2sWni8imeShu+6586F+2SnyRoG2QM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qCVR9ClpjJQu9QVcDplCWEXMZM6+VSGyNZRyzZ9Tfx9I3VLcDobIhc117PBYWVPMz
	 VUZFOqc8U2vqfgHV0fxKRM86qLVnMMEx/jjtXtA+91lUptuRcSTn0b3jTljOQ+/kk2
	 wtRtEyoU0+B7jjVmOxgWNZQ6qje5RrsQ/lzYHCi8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58886BHa3621244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 03:06:11 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 03:06:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 03:06:11 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58886AW6553673;
	Mon, 8 Sep 2025 03:06:10 -0500
Date: Mon, 8 Sep 2025 13:36:09 +0530
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
Message-ID: <578e5125-21d8-40c8-aaeb-389599cdd32b@ti.com>
References: <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
 <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
 <48e9d897-2cd3-48ef-b46a-635ae75f5ac6@ti.com>
 <3wc3t6y5gzzspgfeklsqo3bupfp6gsfy6mls6t66hflcqlqsfk@cu26wv3sow4y>
 <9d2bba15-52e4-432a-8f7f-a0f5d7c2e4ad@ti.com>
 <7hxdcjm7evlphkldct7seytno4is7rjkx5vquvtfhpdkzxdhu6@yocrjgzciwu3>
 <08b87b5f-838b-4f40-ae90-10ded134356e@ti.com>
 <whinfqhjgqbbvlnuzgbukklqi6gocjji4gakqyycovrse4qq6s@6xq5imqbzvux>
 <a0e1d273-239b-44e5-8ccc-0ba83b2b5839@ti.com>
 <wvrouqouhrpoexmggwbc6vjz4xflnylzxrb2ffw3ai7656ehrt@keb53gb2tm2o>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <wvrouqouhrpoexmggwbc6vjz4xflnylzxrb2ffw3ai7656ehrt@keb53gb2tm2o>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 08, 2025 at 12:58:51PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 04, 2025 at 11:33:00AM GMT, Siddharth Vadapalli wrote:
> > On Wed, Sep 03, 2025 at 06:51:14PM +0530, Manivannan Sadhasivam wrote:
> > 
> > [...]
> > 
> > > 
> > > I thought put_noidle() will just reduce the refcount and not invoke the
> > > idle/suspend callbacks, but I seem to be wrong here.
> > > 
> > > Anyway, I guess we have no option here other than to drop the
> > > pm_runtime_put_noidle() call. This will keep refcount as 1 and will prevent the
> > > parent (genpd) to not enter runtime suspend, but we have to live with it (this
> > > was also the previous beahvior as well).
> > > 
> > > Btw, pm_runtime_set_active/enable change belongs to a separate patch.
> > 
> > I will work on and post the v4 patch with the following change:
> > - The commit message and the comment in the code will be updated to
> >   indicate that the runtime PM APIs are used to cause 'genpd' to power off
> >   and power on the controller.
> > 
> > I assume that the driver changes can remain as they are in this patch given
> > that the existing behavior has to be preserved. As j721e_pcie_ctrl_init()
> > programs the strap settings, powering off the controller via
> > pm_runtime_put_sync() and powering it on via pm_runtime_get_sync() shall
> > be implemented within j721e_pcie_ctrl_init() itself leaving the rest of the
> > probe function as-is. To summarize, the driver changes will be:
> > 
> > 	j721e_pcie_ctrl_init()
> > 		...Existing code...
> > 	+	Add pm_runtime_put_sync() here to power off controller
> > 		...Existing code to program strap settings...
> > 	+	Add pm_runtime_get_sync() here to power on controller
> > 		...Existing code...
> > 
> > Please let me know what you think.
> 
> I would've preferred changing the runtime PM calls as I suggested initially, but
> still we would keep it incremented which brings the net effect to the same.
> 
> So you can drop my initial comment and post just this patch with improved patch
> description.

Thank you for the clarification. I will implement the above in the v4
patch.

Regards,
Siddharth.

