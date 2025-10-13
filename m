Return-Path: <linux-pci+bounces-37893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C9BD2C3A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 13:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2D13A743A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC4251793;
	Mon, 13 Oct 2025 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EFMaufMy"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2324A078;
	Mon, 13 Oct 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354566; cv=none; b=bk0cPnnCRpUf+dNm9/VGq/QBQmXEk3So7qen1QU6ZP8sGHO3RaEi9gnn1QdE15c4yO4KvXrzM2f91yxDl1BNMm9890cgS7rtOlJmOk+CrwfqqGTE51BNn8NbMBqgs63ou3Yx5YG1Dl82dovYSDU4z5I0WgIJJXQ+IriK3uOuJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354566; c=relaxed/simple;
	bh=Rvt11bS7Q0WGAMjsegNSqMlzJoBkVoYheDKqU7sA+jI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilAEi4YzrUwVLtMlc+ErfeD/M5OoeQALXKg8m7D2TdrM8SM5bNtTsYo/rRkbwIfc9sC2S4hojtxA5ywrsNz+0tR+oNjmNP3vu5o6j+SGEk8cLXXlawIHrVwBY7lxGXoO/P94CfbGF9IN+thk+XduiNwcUDNrXzJJgEE3+SjsHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EFMaufMy; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59DBMbP6809985;
	Mon, 13 Oct 2025 06:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760354557;
	bh=MnFF+a8BD8U8x2Sq8mYCuzT9ALRYLFSqBHsEqtzzUfY=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=EFMaufMyJ/5V6nQXWS//kLmveHdQgtOzK2F7H4tvUBk10Xh11Bq5rolLcHpX2id9H
	 GY3f0cOwfCo1ajVRhOMMMAywpv/VUCEXQtu39UBTqmIEpCNlr2+T47KggPhL1ZTohm
	 zAMBVmfG1LS3DVDEsmXD7z3HuvVZwNVbeYooMeYQ=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59DBMbsQ2922316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 06:22:37 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 06:22:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 06:22:36 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59DBMXxD1969614;
	Mon, 13 Oct 2025 06:22:33 -0500
Message-ID: <3c0f63162783f6eaa811901dbff9fbb4fe52c107.camel@ti.com>
Subject: Re: [RFC v1 2/2] PCI: j721e: Use inline reset GPIO assignment and
 drop local variable
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
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Date: Mon, 13 Oct 2025 16:52:38 +0530
In-Reply-To: <20251013101727.129260-3-linux.amoon@gmail.com>
References: <20251013101727.129260-1-linux.amoon@gmail.com>
	 <20251013101727.129260-3-linux.amoon@gmail.com>
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

On Mon, 2025-10-13 at 15:47 +0530, Anand Moon wrote:
> Change removes the unnecessary local gpiod variable and assigns the resul=
t
> of the devm_gpiod_get_optional() call directly to pcie->reset_gpio.
> This makes the code more concise and readable without changing the
> behavior.
>=20
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

[TRIMMED]

I have also tested the series (despite my feedback on the first patch).
Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/ca82a16e15a892b3349396be1=
7b37643

Please address the feedback on the first patch.

Regards,
Siddharth.

