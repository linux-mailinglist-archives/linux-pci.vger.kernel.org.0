Return-Path: <linux-pci+bounces-28196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E9ABF07F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90C1188C22B
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051BC24467B;
	Wed, 21 May 2025 09:52:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CCD235BFB;
	Wed, 21 May 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821168; cv=none; b=alCY3zh4R2IvengY2ojFzk3eSYYyeVOmmpDmQp3fOK5GdME9tRSsxdD3PmcjG2AvMY3gDWs345qB6shyh+mFEzX0fPB4XlcuK+c0OajFUwV9ZlpFSlq7IKqdlFFhHOEv3LnXA2gGCqdxYftyCMEzaQAEJ/0QFtZTFtAxPBN5hvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821168; c=relaxed/simple;
	bh=GcPYFTL8JSDRKl+sCR+HiupBT7i2RDpba44+j5oe9VQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0iWEH4N7oIipwm3QeKkxuByRz57DMinBHJ1ynL/7E5LRWnp6YjHoUvRPvJ4tffhGg57FmHqzAiUvFByd4MXpAJ7VI3PtlSNyVcBsV3FFH2/VBeYBNCPf5rtjmk+IpQ3Ekv+qd8ovtMz0Ui9iBRhsMyUstdM22879yZy8XSKA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2RRr4sDdz6D9cm;
	Wed, 21 May 2025 17:47:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E52981402FC;
	Wed, 21 May 2025 17:52:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 11:52:42 +0200
Date: Wed, 21 May 2025 10:52:40 +0100
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
Subject: Re: [PATCH v7 12/17] PCI/AER: Check log level once and remember it
Message-ID: <20250521105240.000016c8@huawei.com>
In-Reply-To: <20250520215047.1350603-13-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-13-helgaas@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 16:50:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>=20
> When reporting an AER error, we check its type multiple times to determine
> the log level for each message. Do this check only in the top-level
> functions (aer_isr_one_error(), pci_print_aer()) and save the level in
> struct aer_err_info.
>=20
> [bhelgaas: save log level in struct aer_err_info instead of passing it
> as a parameter]
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

