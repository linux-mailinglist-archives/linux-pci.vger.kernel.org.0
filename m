Return-Path: <linux-pci+bounces-43383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B7CCFC01
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AFD30CAC93
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4D330D5E;
	Fri, 19 Dec 2025 12:14:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A477330B21
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146443; cv=none; b=sPImenitS+9K2Yvrv3i004T6nreTfsEDKji6Lq/0koy/p+BzkWc6jdTreJSnsU1TtZY1od/g0Od2sA4N+O5X4cgeDbSkxcMsPaiB0jmcnDw8M0KP1NJOaa430i4Ovu9EUtIPRkHYKRk5T/qdayUVI8hqfBeiZAReMK3e/gfPuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146443; c=relaxed/simple;
	bh=ondyMXeHFLGE/cwedMt8dhZj4NFg35HBa24K38L4DBQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4xENNaYCmW38B/8peyiqWNzVy0vdgrBVXlIvYAYeEsq2AVj0bUGTb0UUvRl3/5vHDOOQ7NP0tLIKZeLBmaj2YP2aOSJY8RtwBxwhJZtUDXpDchx73UsVkQcfTFNcVCr3pF6XMPPdkPo5CLbpo2mMsIxJzS0Ul2Cxjn1GMZlZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXmdy0LwyzJ46cC;
	Fri, 19 Dec 2025 20:13:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 96B0C4056C;
	Fri, 19 Dec 2025 20:13:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:13:57 +0000
Date: Fri, 19 Dec 2025 12:13:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 6/6] PCI/portdrv: Use bus-type functions
Message-ID: <20251219121356.00000129@huawei.com>
In-Reply-To: <83d1edc7d619423331fa6802f0e7da3919a308a9.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
	<83d1edc7d619423331fa6802f0e7da3919a308a9.1764688034.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  2 Dec 2025 16:13:54 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> Instead of assigning the probe function for each driver individually,
> use .probe and .remove from the pci_express bus. Rename the functions
> for consistency.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Makes sense.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Nice little cleanup series.  Thanks!

