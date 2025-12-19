Return-Path: <linux-pci+bounces-43382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AB5CCFEBE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D065D3049B2B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC72DF13E;
	Fri, 19 Dec 2025 12:12:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BF2F60CD
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146374; cv=none; b=NwaOdeVYMSzu3eo40SQrmj0cAyNFzk7y9WvWS3YdLfvbFIvLGsHk5VPQgClDtwCmFhx9SQGXesnfwFXq/y9eGuXHNfPUdSM82YCTXJNu8yT0Ks+WZh7xZHqoKi7v3HcPkoplcTseG/aqlb8x19uh05xnwQ6W+q85slqlESAy4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146374; c=relaxed/simple;
	bh=vxvltlfPrCf3GJyIfXiihDO0abe3J+X2xsEFlBcmUkA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEnunZzq7CmaCqUvvXtovadjwm2lI9pLYyzpa9za7Fb5S/LqX/TDarweXJo64ETg0ysRS0k7z8BlHZdQcTGA6GPv+ylukTAZidbKZ3vruAguxmRjyMlXi5PMkzuoxzF+VVCM05Kw5p1glaiS9KptQAEiDvNYtZInYRiUhrBwwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXmcc65s5zJ46cC;
	Fri, 19 Dec 2025 20:12:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DEF340569;
	Fri, 19 Dec 2025 20:12:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 12:12:48 +0000
Date: Fri, 19 Dec 2025 12:12:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Ilpo
 =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/6] PCI/portdrv: Don't check for valid device and
 driver in bus callbacks
Message-ID: <20251219121247.00006799@huawei.com>
In-Reply-To: <2cc2e15e05318b9f0d7b6a2b69b3169d2a6f0bd3.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
	<2cc2e15e05318b9f0d7b6a2b69b3169d2a6f0bd3.1764688034.git.u.kleine-koenig@baylibre.com>
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

On Tue,  2 Dec 2025 16:13:53 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> The driver core ensures that in .probe() and .remove() both dev and
> dev->driver are valid. So drop the respective check.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

