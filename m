Return-Path: <linux-pci+bounces-39352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB0C0BCDF
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 06:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 028C14E9ADC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 05:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF7246770;
	Mon, 27 Oct 2025 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fPaUHYyP"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05442200BBC;
	Mon, 27 Oct 2025 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761541956; cv=none; b=EZz3inUCwiPzgFtBNpKeH6vbBsOnrLhwAZNt5KQajq56ILMXvy178gTYoP8Ks6HIrGt4URs9xki6EK0V/04q7LSWjEAV1X/fYDX5qpAg8C/FekQbA8QGlB0y3yhLIVCjBMqWsa+5ZmqoWMTrg35yeVGMwq66i8jrMNaE7ps+i6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761541956; c=relaxed/simple;
	bh=wUpe5ltraqyYrDwlyIwTsTZJBWU48Nn/vnRzO+dB504=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SpeZhJYItqdNl5cPwcs4dpcvl/0PC0OAXalkFDich/HlzCF6S5IXWH60j8shhrzpQOH/tbVsP5iEvYCQUIVkn+z5dA3xyuT9a42Y1iYhYrPfZe2Ov09uLoWbabc6oj+/twzwHpT254Z1RYHKAIqEIHCgRnWMYPIPRSh6YyG1Nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fPaUHYyP; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59R5CBCh2335172;
	Mon, 27 Oct 2025 00:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761541931;
	bh=SKZpUop+FVVFZo/GRFyiI1DacY+YwtXsqrnvM06cm/4=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=fPaUHYyPDXj37YA7gTyR/FehcVjwtLlFyuvlYugi9syluqsTBk4N2HWOOO8zFGJif
	 Zn1hJFIh5Qy5f1GqZXJ2mSanS140og4rF/uDKhpvnv0yMscMJHOYGZK94lwuzw3qPI
	 QPJXkTx/rZzbKwOEQdgsz3ARW4lbshSPIppJmuN4=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59R5CAI91432776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 00:12:10 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 00:12:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 00:12:10 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59R5C66j102620;
	Mon, 27 Oct 2025 00:12:07 -0500
Message-ID: <bef3d7015012c4004d21cd829892ca942496a6dd.camel@ti.com>
Subject: Re: [PATCH v2 1/2] PCI: j721e: Use devm_clk_get_optional_enabled()
 to get the clock
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Anand Moon <linux.amoon@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "open
 list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
        "open
 list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
        "moderated
 list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Markus Elfring
	<Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
Date: Mon, 27 Oct 2025 10:42:17 +0530
In-Reply-To: <CANAwSgQ2PH1TJLEBVPFJ-RdaNFxn=eTzRYfEmbjx=EYq_YOeQw@mail.gmail.com>
References: <20251025074336.26743-1-linux.amoon@gmail.com>
	 <20251025074336.26743-2-linux.amoon@gmail.com>
	 <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com>
	 <CANAwSgQ2PH1TJLEBVPFJ-RdaNFxn=eTzRYfEmbjx=EYq_YOeQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, 2025-10-25 at 14:07 +0530, Anand Moon wrote:
> Hi Siddharth,
>=20
> Thanks for your review comments,
>=20
> On Sat, 25 Oct 2025 at 13:20, Siddharth Vadapalli <s-vadapalli@ti.com> wr=
ote:
> >=20
> > On Sat, 2025-10-25 at 13:13 +0530, Anand Moon wrote:
> > > Use devm_clk_get_optional_enabled() helper instead of calling
> > > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > > the clk_prepare_enable() and clk_disable_unprepare() with proper erro=
r
> > > handling and makes the code more compact.
> > > The result of devm_clk_get_optional_enabled() is now assigned directl=
y
> > > to pcie->refclk. This removes a superfluous local clk variable,
> > > improving code readability and compactness. The functionality
> > > remains unchanged, but the code is now more streamlined.
> > >=20
> > > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v2: Rephase the commit message and use proper error pointer
> > >     PTR_ERR(pcie->refclk) to return error.
> > > v1: Drop explicit clk_disable_unprepare as it handled by
> > >     devm_clk_get_optional_enabled, Since devm_clk_get_optional_enable=
d
> > >     internally manages clk_prepare_enable and clk_disable_unprepare
> > >     as part of its lifecycle, the explicit call to clk_disable_unprep=
are
> > >     is redundant and can be safely removed.
> > > ---
> > >  drivers/pci/controller/cadence/pci-j721e.c | 21 +++++---------------=
-
> > >  1 file changed, 5 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci=
/controller/cadence/pci-j721e.c
> > > index 5bc5ab20aa6d..b678f7d48206 100644
> > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> >=20
> > [TRIMMED]
> >=20
> > > @@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device=
 *dev)
> > >=20
> > >       if (pcie->mode =3D=3D PCI_MODE_RC) {
> > >               gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > > -             clk_disable_unprepare(pcie->refclk);
> >=20
> > j721e_pcie_resume_noirq() contains clk_enable_prepare().
> Ok I will drop the clk_prepare_enable and clk_disable_unprepare in
> this function?

The clock needs to be disabled on Suspend and enabled on Resume.

The reasoning behind replacing:
devm_clk_get_optional()  + clk_prepare_enable()
with:
devm_clk_get_optional_enabled()
is clear to me, but the removal of the 'clk_disable_unprepare()' on the
Suspend path isn't.

Removing 'clk_disable_unprepare()' in the driver's remove path makes sense
because the
devm() API will automatically disable and unprepare the clock when the
device is "unbound".
However, to the best of my understanding, the device is not "unbound"
during Suspend.
Can you clarify why 'clk_disable_unprepare()' should be removed in
j721e_pcie_suspend_noirq()?

Regards,
Siddharth.

