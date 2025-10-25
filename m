Return-Path: <linux-pci+bounces-39309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E887C08D93
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 09:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2B4E2776
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8A327AC21;
	Sat, 25 Oct 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TrVOj+BH"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33B212B31;
	Sat, 25 Oct 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761378676; cv=none; b=Q36+p/rRfs8y9G8X5fnP9z1PWd41UUKLEkDLcci08uOxffkkhgpJEIwvcauecjFSuZdKNgCh35k8IDGItgboHI2FpvydS0wMWBnVLEdOc4WIR6ovxMP9V1gL68kmhJOgLOuJWw+Pw82jhWWLI83HJlRU4/bt5Zg+Jlq//wwUsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761378676; c=relaxed/simple;
	bh=GHJY2yv8NzIagnpIZevFQktBs51HIgkXzFGlQiHX7Q8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZSS8Gq4zYUk6djTzbDocjkwiKHipoJZJXDfO19VsCNcaCbtbyR11GHepUujHS0tjzSJLGqBJLwOSQFRLgR++bpmMp3XE2YQf9j2VOevBTVjd/luXLcx1swh7Hjt1WA01zv4MPsYl/GFF0+/0y71sWmy+12G4WgazY9SzoWX4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TrVOj+BH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59P7owZm2039353;
	Sat, 25 Oct 2025 02:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761378658;
	bh=RbdeyP+eDVCA00Q0ivESHkryAn8CRzx/dtn5+VRV56o=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=TrVOj+BH9xRNybAjg8fw4lwtU/K9UAAE3YIutcuI8xne/E8EjESIWlft8NvYT4iLf
	 UxBKSqY9ysRpeRtVMv7rBu5NFafRtqMhP66CetvpCxdBNJAFZm/aTOgiaibDrMV0ec
	 8sJ72sFqVMztFZyXr5yByHwYg8W+9n7F8N/aNRzE=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59P7oviI239962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 25 Oct 2025 02:50:57 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Oct
 2025 02:50:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Oct 2025 02:50:57 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59P7orDT1595972;
	Sat, 25 Oct 2025 02:50:54 -0500
Message-ID: <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com>
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
Date: Sat, 25 Oct 2025 13:21:03 +0530
In-Reply-To: <20251025074336.26743-2-linux.amoon@gmail.com>
References: <20251025074336.26743-1-linux.amoon@gmail.com>
	 <20251025074336.26743-2-linux.amoon@gmail.com>
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

On Sat, 2025-10-25 at 13:13 +0530, Anand Moon wrote:
> Use devm_clk_get_optional_enabled() helper instead of calling
> devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> the clk_prepare_enable() and clk_disable_unprepare() with proper error
> handling and makes the code more compact.
> The result of devm_clk_get_optional_enabled() is now assigned directly
> to pcie->refclk. This removes a superfluous local clk variable,
> improving code readability and compactness. The functionality
> remains unchanged, but the code is now more streamlined.
>=20
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: Rephase the commit message and use proper error pointer
>     PTR_ERR(pcie->refclk) to return error.
> v1: Drop explicit clk_disable_unprepare as it handled by
>     devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
>     internally manages clk_prepare_enable and clk_disable_unprepare
>     as part of its lifecycle, the explicit call to clk_disable_unprepare
>     is redundant and can be safely removed.
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/con=
troller/cadence/pci-j721e.c
> index 5bc5ab20aa6d..b678f7d48206 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c

[TRIMMED]

> @@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device *de=
v)
> =20
>  	if (pcie->mode =3D=3D PCI_MODE_RC) {
>  		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> -		clk_disable_unprepare(pcie->refclk);

j721e_pcie_resume_noirq() contains clk_enable_prepare().

>  	}
> =20
>  	cdns_pcie_disable_phy(pcie->cdns_pcie);

Regards,
Siddharth.

