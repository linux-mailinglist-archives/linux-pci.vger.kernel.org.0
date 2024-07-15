Return-Path: <linux-pci+bounces-10267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BAB93156A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 15:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA77CB230BD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5018C165;
	Mon, 15 Jul 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WSq8aOIB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzoQ0Bha"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF843172BA6;
	Mon, 15 Jul 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049047; cv=none; b=GW/JTReyHS5hbwpcvHjpLBvrke520AIN3KtNlcC9JAuCQ7QaqmYEo8Mf3vIL6klj/g6+GCKK/lB34vexC4bBAIhhxP+eB6p87dbBIFO7ZRN2kKbGDFfs5gZx40wkOWeuo70D3SylJP+ibsRVmbiJe/e68T2J7aRxF5Kqapsg22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049047; c=relaxed/simple;
	bh=UmP/6oGPkxLmRM9fmFAuSNEiJfqgkcYp6Uf+h9C9IDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DL7QGEX+TRZ86Q8AblFm/mc0gur2zJwPZVXIVfYHVFNfFZb5UXp3unr7JlWOxLnP7CP7klPX3jF6Uce70K4pyF9zZzkBwja2xUAjRPc/yBNuwh48H5bPgVkuBuBcmELcN/z5k8ieNnlM6yj0agGn9h/5Zl7Fjm5j/3cE0XsBn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WSq8aOIB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzoQ0Bha; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z29gLTnxJJfibIOg6sYyZHGrlffN7zx2NoIm/VXWxOs=;
	b=WSq8aOIBTY/u9yizAu721UO4ktbPNfB87XJEcYJjkeuwQrv8OrqeYyHoF7PKTj9YUDFzcJ
	WJEB+eWywZTwelC9/kdSgXrGQRYvzGMNQkjuxRVUr4l15ex8ENv+p0vBLvYbBoIg8ozv3y
	VCsX5iR8B/lvwDlManIz40nRfoyKtjHe7ryG1fNx5cu8TXScqSAn/flnqgkNBaM+ov7z89
	IWTdh9XC4Kp+T11PdRdKPZ4awU8+PSr9Q9S+aBmfU2s3QXQnmZsqfFT4jOEb+AMnbrTzSZ
	C7BU/g+wcPcjfAyH20MwyOix65BzjAp2lu2ikncyiRH3i1evcZQqZKjusHy6VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z29gLTnxJJfibIOg6sYyZHGrlffN7zx2NoIm/VXWxOs=;
	b=yzoQ0Bhar0E6eApzJz7QjACBdC4qXe+LMP+xeVBkrOzD92HCtl3GOdQtwxCK6VQNiR4pQz
	kWWnQw8x6p3ZhfBw==
To: Johan Hovold <johan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
 rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com,
 den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
 lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
 vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
 andersson@kernel.org, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 00/21] genirq, irqchip: Convert ARM MSI handling to
 per device MSI domains
In-Reply-To: <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
References: <20240623142137.448898081@linutronix.de>
 <ZpUFl4uMCT8YwkUE@hovoldconsulting.com>
Date: Mon, 15 Jul 2024 15:10:43 +0200
Message-ID: <87le22reb0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 15 2024 at 13:18, Johan Hovold wrote:
> I've applied the series (21 commits from linux-next) on top of 6.10 and
> can confirm that the breakage is caused by commits:
>
> 	3d1c927c08fc ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
> 	233db05bc37f ("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
>
> Applying the series up until the change before 3d1c927c08fc unbreaks the
> wifi on one machine:
>
> 	ath11k_pci 0006:01:00.0: failed to enable msi: -22
> 	ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22

3d1c927c08fc converts the platform MSI stuff over which is unrelated to
PCI/MSI. I'm confused how this affects PCI/MSI of the WIFI card.

> and backing up until the commit before 233db05bc37f makes the NVMe come
> up again during boot on another.

So that undoes the PCI/MSI change. Hrm.

> I have not tried to debug this further.

Any hint would be appreciated.

Thanks,

        tglx

