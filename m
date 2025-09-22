Return-Path: <linux-pci+bounces-36662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08906B9137B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04A94E2267
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672E309EF7;
	Mon, 22 Sep 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jFe4iueY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90162309DCB;
	Mon, 22 Sep 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545408; cv=none; b=V/5i5nT1vUyw3eWRCysTF4B018lKW2nrFg+y6seB7De9ZiJPXQ05zoVyPvcJa81SFbp1pa2VpC1GO7Q4LN7XdG0D3lZnyhGd0ufacoPaSBtkUZGoGXVP1gAlKhENzsjnmFD3IoUorfM1CQhqsrTdPa8T8FUJG1xA5qn48EwUHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545408; c=relaxed/simple;
	bh=VI4qb+7ORhPC8rfhAoQgmbpKjqZBELdqWcIE+1RpSbc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TERQqoSh+rNPSltKuuTOVOvsvkHtcLA4myUp86gfEBptFe9f4b9TyGmU+xYy1uHNkxSBB3XljQajn0o9pA4RODcYrdr+x7nWw9Ac2YX8PCSmk+C8S47CQQPwQ7DhXXxHFhyXMVWYN8SbkyJSrWsBmp8MOrWYUVH+sbq03v9OMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jFe4iueY; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58MCniHm769321;
	Mon, 22 Sep 2025 07:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758545384;
	bh=bqfgHpqX6xpJyIh8oA4nP8Mt4sI9T2ISK4uYWV4kOHA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jFe4iueYEbSpH28gEP0gSwgMLiGmAblpjy+gVu1TvDhxNAX0lcfD0RxTgeTrClguo
	 TLzgyz9bCZhIJoAASS/OjMyzPMbxaSFoT6smDWfbiJuZkB1xkIUqkDStIkOkhESYrv
	 GXILySHOWBf3yH0RM0h4DuPNRqL85Lr8N8W5sT/8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58MCniLi305129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 07:49:44 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 07:49:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 07:49:43 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58MCng6Y2793569;
	Mon, 22 Sep 2025 07:49:43 -0500
Date: Mon, 22 Sep 2025 18:19:42 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <christian.bruel@foss.st.com>,
        <quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3 0/4] PCI: Keystone: Enable loadable module support
Message-ID: <0e664051-8bc8-4640-ad00-ef041ea5dee6@ti.com>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
 <175852954905.18749.5091036983349477093.b4-ty@kernel.org>
 <3sjuplupmdoxqhyz2i2p4he5vw7krqokixoy6ddoiox6p536n6@xzfcyhwjx3hv>
 <590d183c-8971-4728-9aa3-4e02bd3d0845@ti.com>
 <qdz2d57q3hyosmvh7xzxy2qdhpjyxkl2mh6dr4or4nj4qakpoh@gg6ihzpaynst>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <qdz2d57q3hyosmvh7xzxy2qdhpjyxkl2mh6dr4or4nj4qakpoh@gg6ihzpaynst>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 22, 2025 at 04:47:39PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 22, 2025 at 02:55:05PM +0530, Siddharth Vadapalli wrote:
> > On Mon, Sep 22, 2025 at 02:02:43PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Hello Mani,
> > 
> > > On Mon, Sep 22, 2025 at 01:56:08PM +0530, Manivannan Sadhasivam wrote:
> > > > 
> > > > On Mon, 22 Sep 2025 12:42:12 +0530, Siddharth Vadapalli wrote:
> > > > > This series enables support for the 'pci-keystone.c' driver to be built
> > > > > as a loadable module. The motivation for the series is that PCIe is not
> > > > > a necessity for booting Linux due to which the 'pci-keystone.c' driver
> > > > > does not need to be built-in.
> > > > > 
> > > > > Series is based on commit
> > > > > dc72930fe22e Merge branch 'pci/misc'
> > > > > of pci/next.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
> > > >       commit: c514ba0fa8938ae09370beecb77257868c1568a7
> > > > [2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
> > > >       commit: db9ff606a5535aee94bf41682f03aba500ff3ad6
> > > > [3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
> > > >       commit: 76d23c87a3e06af003ae3a08053279d06141c716
> > > > [4/4] PCI: keystone: Add support to build as a loadable module
> > > >       commit: e82d56b5f3844189f2b2240b1c3eaeeafc8f1fd2
> > > > 
> > > 
> > > I just noticed the build dependency mentioned in the cover letter after applying
> > > the series. This is problematic since there is no guarantee that the dependent
> > > commit will reach mainline first. So if this series gets applied by Linus first,
> > > then building this driver as module will break the build. We should not have the
> > > build error at any cost.
> > 
> > As feedback for the future, is there a better way that I could have
> > highlighted the build dependency? I agree that a build failure is
> > unacceptable which is why I tried to highlight the dependency, but, it
> > probably wasn't the best approach to point it out by mentioning it in
> > the cover letter. Please let me know if I could make it easier for you
> > and other Maintainers to notice such stated dependencies.
> > 
> 
> Mentioning the build dependency in the cover letter is the right thing to do.
> But somehow I failed to spot it as it was not highlighted enough (just for my
> eyes).
> 
> Maybe you could mention the dependencies under a sub-section. Like,
> 
> Dependency
> ==========

I will follow this format in the future. Thank you for the suggestion.

Regards,
Siddharth.

