Return-Path: <linux-pci+bounces-18164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A99ED2E7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35D81885EE2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8B1DE2C2;
	Wed, 11 Dec 2024 16:58:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706D1D63CA;
	Wed, 11 Dec 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936306; cv=none; b=cGp9cA5W+yevGBulXQs77ObRCmmy0M3asHlHW1aioZQ9Xgy9iGj9muFK1VFCjlwlK9Ls+bV6fKmLCyWn0A8olN5t0cmsQ2OMIcDTrt5e7yOX9rHRb+9Yp4B+OWu/FWTP+cEsfYgHEWY1gtjsEYq44VVY64WTBNZ/wLaBYdI8B9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936306; c=relaxed/simple;
	bh=YsSQ5PWOqY1DjPncfWijRqa6XfvetZCZqlLKKbI1uIE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fufbd8TM7Ga521X3h42Af1HVDrKh7TLUWk4HW/4F+50d4sQfBa63vbwuSEglLrfxJnjhijqIgywzusEldoW9SSWc1k108TN0oXp3JyiIG5HCfUm8cmrzA3ptXPIvPnZdfHsIMrCV4t0ajuDLneNwwlztFSVoRlL7ogguBeyxYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7hWX3H1Hz6K6KJ;
	Thu, 12 Dec 2024 00:53:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EB781400CA;
	Thu, 12 Dec 2024 00:58:22 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 17:58:21 +0100
Date: Wed, 11 Dec 2024 16:58:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/8] PCI/AER: Add prefixes to printouts
Message-ID: <20241211165820.000014fe@huawei.com>
In-Reply-To: <20240913143632.5277-9-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 17:36:32 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Only part of the AER diagnostic printouts use "AER:" prefix because
> they use low-level pci_printk() directly to allow selecting level.
>=20
> Add "AER:" prefix to lines that are printed with pci_printk().
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
Makes sense.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

