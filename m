Return-Path: <linux-pci+bounces-18157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6329ED131
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA93285135
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD971BEF82;
	Wed, 11 Dec 2024 16:22:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3311494CC;
	Wed, 11 Dec 2024 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934136; cv=none; b=K24+hQpFdIbng7q0B3Tomn+YKvhZlcuIBDG3qCAwXhALknEclSthq0YxAtYoO/vgAg2MXQcgaNeR/zLfCQfSqlzVbXTGtBYTBmQua7EFExpWYZ2x2nLgFT4bSgPalFZfvDmLQo5+LnubiXppp7ZvZvnZGSsvrtqyAgdjCP2brJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934136; c=relaxed/simple;
	bh=FUC8BJaJFGh4VNJK9vqN8iQhdGWQbLwg1ZUHVW/gigA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfWczewpgIKeEocwojOfJF69uC2HviVwS/rGL+LsqbP/sYRppmLWz2gUztn3sqc1OXaPPEBVrL3APwIMl62g9eg6QsaF7b+i0XEJ6b9ZmPFctMNpsqcedIBeWTmWRUsBLWHVDc6jSkEOdcXTibkcGuqFTrSakl+AEYVwh/jW7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7gp42hL9z6D9Cn;
	Thu, 12 Dec 2024 00:21:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BABF21400CA;
	Thu, 12 Dec 2024 00:22:10 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 17:22:10 +0100
Date: Wed, 11 Dec 2024 16:22:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 1/8] PCI: Don't expose pcie_read_tlp_log() outside of
 PCI subsystem
Message-ID: <20241211162207.00004bd6@huawei.com>
In-Reply-To: <20240913143632.5277-2-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 17:36:25 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> pcie_read_tlp_log() was exposed by the commit 0a5a46a6a61b ("PCI/AER:
> Generalize TLP Header Log reading") but this is now considered a
> mistake. No drivers outside of PCI subsystem should build their own
> diagnostic logging but should rely on PCI core doing it for them.
>=20
> There's currently one driver (ixgbe) doing it independently which was
> the initial reason why the export was added but it was decided by the
> PCI maintainer that it's something that should be eliminated.
>=20
> Remove the unwanted EXPORT of pcie_read_tlp_log() and remove it from
> include/linux/aer.h.
>=20
> Link: https://lore.kernel.org/all/20240322193011.GA701027@bhelgaas/
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
FWIW LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

