Return-Path: <linux-pci+bounces-36139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6EB5757A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668B817DBFC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CB2ED163;
	Mon, 15 Sep 2025 10:03:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF442F39B5;
	Mon, 15 Sep 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930607; cv=none; b=IvaMjuYHlv2qI076v0O18DOlfnaxqlB444Wzl07FwuHvUXTt6W3SiALPU+pW+7RhlDiX8tl17Tnx/EjMmPYyTHwTFlAZvfXIaxs18ChxaTY9h9aD0B88wlb98QYj8hCDgDPDD8ljkBfeA+I3P+1IoDl4eCFR+ZpbMsjSnVQxP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930607; c=relaxed/simple;
	bh=QPAozO9IPCmM9NuB4KSm+9RLT4V7i/cbQWE5o+mkTiw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8mTBe6jweUzMDpdS/nZIgPzo71mzi6zMZJx6xBCK0PSmcqrq1ZLHn2CEH4o1HfVveJxmqrxt1CdikSx6hl5uiIUDTEnrdfcV+PZKVZKvFQV1wyM78Z7dRfQfAGhDsqbieDwUbVRpFaorwFSOPO3qF35YCn6ybcOEvRmXCM4UIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQLD25tk5z6K9GM;
	Mon, 15 Sep 2025 18:01:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B2ABF1402FB;
	Mon, 15 Sep 2025 18:03:21 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 12:03:21 +0200
Date: Mon, 15 Sep 2025 11:03:20 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC: Keith Busch <kbusch@kernel.org>, Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello <superm1@kernel.org>,
	Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial
 number
Message-ID: <20250915110320.0000602f@huawei.com>
In-Reply-To: <20250913061720.GA1992308@rocinante>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
	<20250821232239.599523-2-thepacketgeek@gmail.com>
	<aK9e_Un3fWMWDIzD@kbusch-mbp>
	<20250913061720.GA1992308@rocinante>
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

On Sat, 13 Sep 2025 15:17:20 +0900
Krzysztof Wilczy=C5=84ski <kw@linux.com> wrote:

> Hello,
>=20
> > Can we get a ruling on this one? It's pretty straight forward
> > implementation exposing a useful attribute. =20
>=20
> Who needs this?  Why is this useful?  Why hasn't there been a need for
> exposing serial number in past decades, and suddenly we need it so
> desperately?
>=20
> We probably wouldn't want to add this if there is only a single user that
> needs this, especially give that userspace tools like lspci already expose
> this when someone needs it.
>=20
> Also, we were reluctant to expose some types of information, like serial
> numbers and such, via the VPD recently, so why exposing any serial numbers
> via sysfs would be any different?

I'll note that we already expose these serial numbers for CXL type3 devices
because they are really useful when you have a bunch of identical devices
as they turn in RAS error records and other places.

I pushed back on adding this same sysfs attribute to other CXL types
on basis we could just get it from the associated PCI device (assuming this
series lands).

https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/cxl/core/memdev.c=
#L113

Note that we don't do is_visible magic for this particular attribute in CXL
because it is mandated as present by the CXL spec.  We do that for a lot
of other stuff though as it keeps the interface clean.

Jonathan


>=20
> Thank you,
>=20
> 	Krzysztof


