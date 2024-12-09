Return-Path: <linux-pci+bounces-17964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AADAD9E9FD9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 20:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D608318868CD
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77171991A5;
	Mon,  9 Dec 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGqLICAW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PYFXlDr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B11990C1;
	Mon,  9 Dec 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773918; cv=none; b=h8xHEqMKzSN6JVtHtAp0E51DgjRmuSEjooUdMpQn4JkpT2wS6cyhAgN+5Wk8oq8PLBbnGAbkDw7K1Te1TaZ5Qbn+q8jQ8y4Z9gqy+SuzoBqElBnwHt8y9+5ZUlmn9eKSJkj+7qs0iRmgNFnuvJOtU4yq67vsmFEBmHVJCDz8Qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773918; c=relaxed/simple;
	bh=OSFj0uGte+4Djui3/eCX/wUJv+i1wrlJzzJviMsoiB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQ1mMCcTZopAGxkRe2egg/c2cSCh/FbHkdQ/D4jbu6MBntmWGKZdNeZylgxK48dSnDb8xdQq7nt0gDen6Upx51WrRTW4AdzBT6nE4kHEINbXeELm7+POhrmYBG3FX3epOk2M2yxuVX3VNl/Uk+wDqdy2zKpoZ/6Lw086gJpEPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGqLICAW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PYFXlDr7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733773913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXb9Qlvpqf8UvXDokFX4BzJKnQj1O029xwrLhZM3PY4=;
	b=QGqLICAWiFEGv1iAiUxnwN5MX5gFQ4eujqYD2p6hki0dgNaV9CGWmIqKBw4yv8DhklBNzx
	pNL1aNghvs8S797J9vMctMalLNpkRF0kBs4liT52l5Nj3AvafHhH4DVVK2kNG7ijzKARnP
	rJfgtGymN24m6vLSasEfaVZm5Phcc2olqkQJ0ci9yvHwoejqvbD1A4jIcONEjMMxihYUvZ
	frdgQgqWWXbhTsyoc9qP4vp4QUhHC7e/Uy14h42KWgJD9uJUC7w+tKjFDgUzmYuAptX2U4
	b8FywB/zf+4KyehgNqiK68jjK8IWyf3Wlg61WQHyaEqvEPkHruF2tKy5ewkWhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733773913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXb9Qlvpqf8UvXDokFX4BzJKnQj1O029xwrLhZM3PY4=;
	b=PYFXlDr7DTnByaFHHuqwY4MCTGNP7Zqnly7+IhtKetDJzgwQHFlQ/FlwpauJFWmubiKxHO
	cIZRO7e5htu0CICQ==
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
Subject: Re: [PATCH v11 3/7] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
In-Reply-To: <20241209-ep-msi-v11-3-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
 <20241209-ep-msi-v11-3-7434fa8397bd@nxp.com>
Date: Mon, 09 Dec 2024 20:51:52 +0100
Message-ID: <87h67cprc7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frank!

On Mon, Dec 09 2024 at 12:48, Frank Li wrote:

> Some MSI controller change address/data pair when irq_set_affinity().
> Current PCI endpoint can't support this type MSI controller. So add flag
> MSI_FLAG_MSG_IMMUTABLE in include/linux/msi.h, set this flags in ARM GIC
> ITS MSI controller and check it when allocate doorbell.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v9 to v11
> - new patch
> ---
>  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 1 +
>  drivers/pci/endpoint/pci-ep-msi.c           | 8 ++++++++
>  include/linux/msi.h                         | 2 ++

This is not how it works and I explained that you to more than once in
the past.

The change to the interrupt code is standalone and has nothing to do
with PCI endpoint. The latter is just a user of this.

So this want's to be split into several patches:

   1) add the new flag and a helper function which checks for the flag.

   2) add the flag to GICv3 ITS with a proper explanation

   3) Check for it in the PCI endpoint code

>  
> +	if (!dom->msi_parent_ops)
> +		return -EINVAL;

irq_domain_is_msi_parent()

> +	if (!(dom->msi_parent_ops->supported_flags & MSI_FLAG_MSG_IMMUTABLE)) {

Want's a helper.

Thanks,

        tglx

