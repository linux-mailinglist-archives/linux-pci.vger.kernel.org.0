Return-Path: <linux-pci+bounces-36643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C405B8FBE5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E91898A6D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450514D2B7;
	Mon, 22 Sep 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cNBGb2pj"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B812C544;
	Mon, 22 Sep 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533142; cv=none; b=Jpj2Va+vDz5qU/o4Pw2/UWXfhb52UQS9VkxUauWn7/WIi6emQECNvynen5tIYCimZQXHhYCNKbze4cf6c9ltskrYoJ6x6HEdwmo8nTRYSRd/RkTrud5+wH6uwew2nUhi7D7yEYiV0Q/QQ6cYC3fo4bgmoP43UYsm0FdkemWu66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533142; c=relaxed/simple;
	bh=IswDfjZP5vwod6mAKpJYVT2TBfGGvqPnluT4nSXXVYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+IAB5SgmFQvXBkiYGu8u55F07P4fraffyP2cgB2lFJ7hKz9fOjnjCBK5iBovcXfAKpe955DkaceDSAyFxI5hwfnjyfn3xP+05dirbzKYPSC5D9kmn+mvc6YcfX2ZGv4rv2GoljTfMsSXEuVVTPh7KVxO5rFvVu2sQOi6cUE8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cNBGb2pj; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58M9P7lO740019;
	Mon, 22 Sep 2025 04:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758533107;
	bh=+SHXzfaOEdg6X115/K//Il5mPpamyh8qQbk6ql+nf3Y=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cNBGb2pjqzD1D/ubVZfXWMp7ZEFEV/ZGs6lYlUh21xaV3tJqZtLAVFaavMFZ2X/SA
	 HZU/ORT3S5PGzcI/gj2xViYH+JeLhmie0Zz3PyZNjcBR2eyOtVdWmcqzqgSVDfurf8
	 OiO8kSDdEyncPiYyL2+BqAMxB9hYGu7le4vGLDpg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58M9P7MG1067900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 04:25:07 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 04:25:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 04:25:07 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58M9P6vQ2274743;
	Mon, 22 Sep 2025 04:25:06 -0500
Date: Mon, 22 Sep 2025 14:55:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <inochiama@gmail.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v3 0/4] PCI: Keystone: Enable loadable module support
Message-ID: <590d183c-8971-4728-9aa3-4e02bd3d0845@ti.com>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
 <175852954905.18749.5091036983349477093.b4-ty@kernel.org>
 <3sjuplupmdoxqhyz2i2p4he5vw7krqokixoy6ddoiox6p536n6@xzfcyhwjx3hv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3sjuplupmdoxqhyz2i2p4he5vw7krqokixoy6ddoiox6p536n6@xzfcyhwjx3hv>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon, Sep 22, 2025 at 02:02:43PM +0530, Manivannan Sadhasivam wrote:

Hello Mani,

> On Mon, Sep 22, 2025 at 01:56:08PM +0530, Manivannan Sadhasivam wrote:
> > 
> > On Mon, 22 Sep 2025 12:42:12 +0530, Siddharth Vadapalli wrote:
> > > This series enables support for the 'pci-keystone.c' driver to be built
> > > as a loadable module. The motivation for the series is that PCIe is not
> > > a necessity for booting Linux due to which the 'pci-keystone.c' driver
> > > does not need to be built-in.
> > > 
> > > Series is based on commit
> > > dc72930fe22e Merge branch 'pci/misc'
> > > of pci/next.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/4] PCI: Export pci_get_host_bridge_device() for use by pci-keystone
> >       commit: c514ba0fa8938ae09370beecb77257868c1568a7
> > [2/4] PCI: dwc: Export dw_pcie_allocate_domains() and dw_pcie_ep_raise_msix_irq()
> >       commit: db9ff606a5535aee94bf41682f03aba500ff3ad6
> > [3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
> >       commit: 76d23c87a3e06af003ae3a08053279d06141c716
> > [4/4] PCI: keystone: Add support to build as a loadable module
> >       commit: e82d56b5f3844189f2b2240b1c3eaeeafc8f1fd2
> > 
> 
> I just noticed the build dependency mentioned in the cover letter after applying
> the series. This is problematic since there is no guarantee that the dependent
> commit will reach mainline first. So if this series gets applied by Linus first,
> then building this driver as module will break the build. We should not have the
> build error at any cost.

As feedback for the future, is there a better way that I could have
highlighted the build dependency? I agree that a build failure is
unacceptable which is why I tried to highlight the dependency, but, it
probably wasn't the best approach to point it out by mentioning it in
the cover letter. Please let me know if I could make it easier for you
and other Maintainers to notice such stated dependencies.

> 
> So I'm dropping this series now. Please repost once the fix is in mainline
> (which will be next cycle).

Sure, I will repost the series. I had posted the v3 series right away
to make it easier for you and other reviewers to provide feedback before
people lose context. Thank you for actively reviewing this series and
sharing your valuable feedback :)

Regards,
Siddharth.

