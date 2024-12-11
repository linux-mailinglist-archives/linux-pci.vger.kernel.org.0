Return-Path: <linux-pci+bounces-18158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51A9ED161
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F55164059
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B891DC1B7;
	Wed, 11 Dec 2024 16:26:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB81494CC;
	Wed, 11 Dec 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934364; cv=none; b=SFr3BtNwRehlDeNB3++xM6Zpvk4TargTvucxX+BbtFKodFa/kvQ+kicgkbt8E5xVwusabqM9T+Loe02ynSkRKeDVclaQhWTpCcm/w8Rd8M70gNO9CYl3UKQTDbxjb2TWTw82uwFXbe+K0FX4pnrx+He49tI9EvsM/L5MNCz/24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934364; c=relaxed/simple;
	bh=hPQ8VXlwA8GOB1w3iWzAiNzFcsHRJ+KDLPEtj88gxF8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZcyvEzO1oxoVDnPAh2UrikGcl3zHh9qrKpXMK5tWQKeS1k1DX1GInJwBK+mLXqIFoEcsKm5+iP2pye4uBQbrHoxXefcXQnGdeilMRO+96YI674Up+tYJ97cn0zsDXkcrlCxjOlscNkd9X8OKrmfksYLJ60LA+Jgn1iZ4vP1Pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7gqj1gmpz6D8c1;
	Thu, 12 Dec 2024 00:22:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F071B140AB8;
	Thu, 12 Dec 2024 00:25:57 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 17:25:57 +0100
Date: Wed, 11 Dec 2024 16:25:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 2/8] PCI: Move TLP Log handling to own file
Message-ID: <20241211162555.00000968@huawei.com>
In-Reply-To: <20240913143632.5277-3-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-3-ilpo.jarvinen@linux.intel.com>
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

On Fri, 13 Sep 2024 17:36:26 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> TLP Log is PCIe feature and is processed only by AER and DPC.
> Configwise, DPC depends AER being enabled. In lack of better place, the
> TLP Log handling code was initially placed into pci.c but it can be
> easily placed in a separate file.
>=20
> Move TLP Log handling code to own file under pcie/ subdirectory and
> include it only when AER is enabled.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Can sort of see this might get used outside AER sometime in the future
but for now this seems sensible.

Jonathan

