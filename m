Return-Path: <linux-pci+bounces-43381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9790CCFBDA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521EC3095E7F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82915539A;
	Fri, 19 Dec 2025 12:11:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016E2D061D
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146304; cv=none; b=ayB3ej4ZYU0rT/aqFtpi79kIbnPYEYl4v2fVSHrN77sMfGwwgXbPt5lmXPUVe50/b8wEHTUEw+99pJL6Mq4pqm0jMAmo4k/MzYo3zJIaNfds6dOeObLNQ4Okr7Fix7UXyIGIp7W13042Bx4TUHSis1lyq+T5CmbasJJUmbe85Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146304; c=relaxed/simple;
	bh=Pwn+F6orkstHSvHBfDo/ISY0IdCd87/GLubqGQoPOxM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGylSK60CJIb/DlRIThb0wLSlQc52G/ifKzbzrI8c+YlkI6Y0FedN5Obhle1k3XWG9Eg+lLKtmhmRoUwsLqlG/UynliyX45Ijv+ijN1aVK6/4h8K2ARyovPzXYl0rnyWrwOLyAer4AnYoZ0IbglyF0Cof2Le3DXNqV/iMMtEWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXmbM2JzxzHnH4m;
	Fri, 19 Dec 2025 20:11:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 670F24056A;
	Fri, 19 Dec 2025 20:11:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:11:39 +0000
Date: Fri, 19 Dec 2025 12:11:38 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/6] PCI/portdrv: Don't check for the driver's and
 device's bus
Message-ID: <20251219121138.0000676f@huawei.com>
In-Reply-To: <09ca261912a37d2b253f43359a5dfeec42c016dc.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
	<09ca261912a37d2b253f43359a5dfeec42c016dc.1764688034.git.u.kleine-koenig@baylibre.com>
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

On Tue,  2 Dec 2025 16:13:51 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> The driver core ensures that the match function is only called for
> drivers and devices of the right bus. So drop the useless check.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

A lot of stuff would be broken if match functions were called=20
on wrong types of devices :(


