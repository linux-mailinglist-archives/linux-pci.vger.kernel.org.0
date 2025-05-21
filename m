Return-Path: <linux-pci+bounces-28198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC1ABF0A1
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358151BA0D21
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398825A358;
	Wed, 21 May 2025 09:59:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1025A2B5;
	Wed, 21 May 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821556; cv=none; b=SHyGbj8ypx6bayODhwZ2egXyBTEDX5lxKfCwzQ9/sBbufupHcCoNJbtvbedmaiygaIIB/p5Jo6d9iU5Gfb3wmOxchhNdqsRuOnDOE/ICf0OcCU0XCKU3z/HaCUxbAExyCKAaZ9J1nva0KqFdJblRJBJrEYGSbLdCw1RAlkA0mAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821556; c=relaxed/simple;
	bh=aVKNovIlIgiN/Yt2TbWAYza/i7PM9bMGgpl9JyNT0kQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQjoJO9pzVqEjo6U7W1kiO1Bx316fM9O0jYeLgRfLPrTC6P9thJTFd8Ro7JJX0djUXnnmg4gbVd3ReGPUJ8ous1NBOgDfV/W0PK6j95L3CT/CWWpm4IaNCfqG4y7USvoEJ9zxzi4PShWC4WIHHDI3tu7Tl1tc/nGFDmRXP3Suz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2RbJ47krz6D9XP;
	Wed, 21 May 2025 17:54:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D13AE140557;
	Wed, 21 May 2025 17:59:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 11:59:10 +0200
Date: Wed, 21 May 2025 10:59:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Jon Pan-Doh <pandoh@google.com>, "Karolina
 Stolarek" <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller
	<ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, "Anil
 Agrawal" <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Sathyanarayanan
 Kuppuswamy" <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver
 O'Halloran" <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, "Keith
 Busch" <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 14/17] PCI/AER: Rename struct aer_stats to aer_info
Message-ID: <20250521105908.0000622b@huawei.com>
In-Reply-To: <20250520215047.1350603-15-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-15-helgaas@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 16:50:31 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>=20
> Update name to reflect the broader definition of structs/variables that a=
re
> stored (e.g. ratelimits). This is a preparatory patch for adding rate lim=
it
> support.
>=20
> [bhelgaas: "aer_report" -> "aer_info"]
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

