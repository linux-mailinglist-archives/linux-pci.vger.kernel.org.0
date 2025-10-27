Return-Path: <linux-pci+bounces-39434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4FC0E1DC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 665D734E362
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BD301011;
	Mon, 27 Oct 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T/jNZQi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4C212562;
	Mon, 27 Oct 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572386; cv=none; b=JtvOLvo8fr/xfhNhEAmQAXvEYZL2ABb3lbe32ya0wGFS8+Rln3KYrCNoCMEjOOZy6OeGeQ8lXZFpPGlzUFQEh9q4JdUOhVZLF4ShA36CI3U2LwI1r8TesVv9SMZ86AnezZos11US1fy8mPxi0+qihQOctMorPStAS/17UAFX8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572386; c=relaxed/simple;
	bh=F88Mqi1IYE4ZB8FjWzZRJOZCliQhSjDt6+Vbvnc0pWc=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=So7zP+2tukfRgjmmXMbi7M856uwFYoTj8eOkZnSWS2ghO5cWKahxXQ/9I2RPWfnNwcfcWXB6t4qy33zU0g3/SspzEC8aNBEInaypApnHl/WeGscTv34esbpWQUygC5SXkwUsRoLyA5HzrQWDaAipB8hYCFHUVgZya66G+OkCXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T/jNZQi3; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RDdGXM1290306;
	Mon, 27 Oct 2025 08:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761572356;
	bh=F88Mqi1IYE4ZB8FjWzZRJOZCliQhSjDt6+Vbvnc0pWc=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=T/jNZQi3mz7QMv2F/V60x7xSZb6IaRnpxcYW0MkCdJxOIAdTGJdl3aAcdHvAXm7XF
	 QjeJAhFl+1LoJ7cz/bCmKb/diHLTLEL+XIDC3cD/u6YHfRkktNa8CnhSzP2dpwss/B
	 3gN8CwXFE8P5s/7ULIsvUF/1ry5D7F5LY4QvauKk=
Received: from DFLE200.ent.ti.com (dfle200.ent.ti.com [10.64.6.58])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RDdG3K1265503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Oct 2025 08:39:16 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:39:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:39:16 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RDdC6R727568;
	Mon, 27 Oct 2025 08:39:13 -0500
Message-ID: <c2a22a2b7fa709349c509b685f7c050957d3b5d3.camel@ti.com>
Subject: Re: [PATCH v3 1/2] PCI: j721e: Use devm_clk_get_optional_enabled()
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
Date: Mon, 27 Oct 2025 19:09:23 +0530
In-Reply-To: <20251027090310.38999-2-linux.amoon@gmail.com>
References: <20251027090310.38999-1-linux.amoon@gmail.com>
	 <20251027090310.38999-2-linux.amoon@gmail.com>
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

On Mon, 2025-10-27 at 14:33 +0530, Anand Moon wrote:
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
> v3: Clock needs to be disabled on Suspend and enabled on Resume.

Thank you for updating the patch.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

