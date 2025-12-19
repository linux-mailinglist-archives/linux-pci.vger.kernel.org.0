Return-Path: <linux-pci+bounces-43380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E7CCFC5F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5E9310BC5E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BF4333750;
	Fri, 19 Dec 2025 12:08:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969493346A7
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146086; cv=none; b=W6ReOrStP/kZEfez4SXC5p/Zd/hzR0dgVNERkx+x9BCDmLRdsnmCDWkJyJWl+vo6H+osm5rHIVTC7PgEHqFxPJJn8/LMH6qrHbGnw6tQ1MEFicngzTNeC7YzdRPrpnZYU9xhM17rgW1l7nLJBNdcb+jFk5xboPLfnrWrWhJCWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146086; c=relaxed/simple;
	bh=5AtZvdMb5gAa3yA6In+INwAJU5fFW04GGWxWgckuKCU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGnjoSML5HqLaMUEtfmteOExahUZZ9PlneY+Qpm2j8kzVOH1cQRDQbIkO2GAUGBB5dL7msq7bTyLmM+MLERlQ0kaCA5fvDIxOLHUdzQuFYocvDDgK20k7EBmeWdpbgflbGKvDPJ+u8LvL9RSkkcaUO1CFERyyH43unPCs+3blfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXmW93fs6zHnGdn;
	Fri, 19 Dec 2025 20:07:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EF8F4056C;
	Fri, 19 Dec 2025 20:08:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:08:01 +0000
Date: Fri, 19 Dec 2025 12:08:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, Uwe =?UTF-8?Q?Kl?= =?UTF-8?Q?eine-K=C3=B6nig?=
	<ukleinek@kernel.org>
Subject: Re: [PATCH 2/6] PCI/portdrv: Drop empty shutdown callback
Message-ID: <20251219120800.00001595@huawei.com>
In-Reply-To: <283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
	<283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>
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

On Tue,  2 Dec 2025 16:13:50 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> .shutdown() is an optional callback and the core only calls it if the
> pointer in struct device_driver is non-NULL. So make nothing in a bit
> shorter time and remove the empty function.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

