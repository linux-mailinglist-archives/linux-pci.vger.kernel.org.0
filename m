Return-Path: <linux-pci+bounces-17740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A89E563C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 14:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74693284B6A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92D218847;
	Thu,  5 Dec 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SSecgSoJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TF6tbNwZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B8E56C;
	Thu,  5 Dec 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404267; cv=none; b=fQcor+n5gKTZaoNiQbs0TDq5zAieweWswrDD1azxGJl16fZhQl/RnEvv8AZNBgXaW+Snt6BCmqXGbp+FICJwlrWW+IpMAT/tYwgpbi6+zxhFYRkQJztM+gVdNdxg0zeE6NKWRx2KYFZEURyP5esbBmkzrPFzKgWr9K9FR8GLR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404267; c=relaxed/simple;
	bh=8OwUNqW2vG7Kp0Vngd/eTUDgtb2xVKzL1mxTLPnP8PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZw4zBNh46ZqqPI2tY3K5k9PKj29lBO51vkW5QBDXIcP0reqdMazMGfE2tNoFj2snf6GEvZGuSVoAsbdc3MonUuqFWIc5MTDEpqYWjABCobS/8niPtNfvnXuQFqBLUxi4aj1aYqQp6oKZdFy4jojaZG5dg17WINT6zC5l6fJK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SSecgSoJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TF6tbNwZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733404256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r5ZSOC+jMK+Pn41a+KdPBf5Tp8LhGYfDQCBVqyptSw=;
	b=SSecgSoJaTW4GK3OxeSbVglrdiNuLnmzjVRYetQUMbKN9YgTDPUJKRPT2xBYIFSFUPXkU9
	iL545q3NwhxiwKrJ9Kj14INBRUO3VqNClhU2zZ7NkgeiWmFzxONN7HnrxI8c5hJdXJ4qsS
	EZ5Kb+Tx4a42G8/+/wmvIG3g3GiTJ/oXZvc3QOeJM/NWD0pEgedh1c8gM5zAXiuEBREd5a
	m4rTBF3EQiWMdBj7XAhjSNnZe4fHph/13dd/m6Rhxo2TOUn4pr1Kl8kydS2Z8e1UpewYv5
	gnNbECNnBH37KBm9FozVwUygpXr3DcjAZbAuEDlMXhEnaac/6tfV3p8OISq0jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733404256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r5ZSOC+jMK+Pn41a+KdPBf5Tp8LhGYfDQCBVqyptSw=;
	b=TF6tbNwZIKHNI5y92mqJbv4JxvZqe0fERVOSlkTSDhw6+5AqZuIK7VX1meXEl6Q8c1huFY
	zk4IFSFIUV+rekBQ==
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, jdmason@kudzu.us,
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v10 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
In-Reply-To: <20241204-ep-msi-v10-3-87c378dbcd6d@nxp.com>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
 <20241204-ep-msi-v10-3-87c378dbcd6d@nxp.com>
Date: Thu, 05 Dec 2024 14:10:55 +0100
Message-ID: <87ttbiqnq8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 04 2024 at 18:25, Frank Li wrote:
> Some MSI controller change address/data pair when irq_set_affinity().
> Current PCI endpoint can't support this type MSI controller. So add flag
> MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
> doorbell.

Q: Who is going to annotate the affected domains with that flag?

A: Nobody.

Q: What's the value of the flag?

A: Zero, as as it prevents exactly nothing.

You want a MSI_FLAG_MSG_IMMUTABLE and set that on the domains which
provide it. That way you ensure that someone looked at the domain to
validate it.

Thanks,

        tglx

