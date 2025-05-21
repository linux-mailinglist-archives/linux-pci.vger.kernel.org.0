Return-Path: <linux-pci+bounces-28179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CAABEF82
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E971768B0
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE423D294;
	Wed, 21 May 2025 09:21:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E523506D;
	Wed, 21 May 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819318; cv=none; b=QV47Y4VPcdOYQiAFWg3ssgvazZmla0Lef4sLLPc6Nvv12UCi778jzRVOfKuxo7R213psh6EUkdu1dLeKumcpHt5nNLKRaUXOzKieG8L/X08qPHtov3L7BUbGQehXBU5dRGtPiR9hCJMeQ1sMgbjpNTXj18A1k3ytn/vYNd/ToHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819318; c=relaxed/simple;
	bh=NNP13idsOMoxEThWHCNTUsdIfyVNjNlm15eK1mVBuDc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eY/Cs8Td+upxTOhEgwBThwwBI6MiThaniHg4qmP5Sx3djBrZ7tzqt0ywEdqo/Xf+OULfqzWnUYTDJjMFqxbORAZpH44aTtBrp5wfIAx3HYK4Zn3FI0ivRtebuBjcSNScGwj1oFiXZO2XTgUjlaU/4dymRYg9WS+QYkzWmorLgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2QpD1LGkz6L4rt;
	Wed, 21 May 2025 17:18:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 17A841402C3;
	Wed, 21 May 2025 17:21:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 11:21:54 +0200
Date: Wed, 21 May 2025 10:21:52 +0100
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
Subject: Re: [PATCH v7 05/17] PCI/AER: Extract bus/dev/fn in
 aer_print_port_info() with PCI_BUS_NUM(), etc
Message-ID: <20250521102152.0000569c@huawei.com>
In-Reply-To: <20250520215047.1350603-6-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-6-helgaas@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 16:50:22 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Use PCI_BUS_NUM(), PCI_SLOT(), PCI_FUNC() to extract the bus number,
> device, and function number directly from the Error Source ID.  There's no
> need to shift and mask it explicitly.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

