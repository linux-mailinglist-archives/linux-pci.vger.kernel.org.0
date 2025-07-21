Return-Path: <linux-pci+bounces-32644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94372B0C3BB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 13:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D103AB18E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683152BE053;
	Mon, 21 Jul 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WW4XaBqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2c5Y8E2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20527FB22;
	Mon, 21 Jul 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098959; cv=none; b=VJVM+NN5hewqy7AygDrXQygsJ8rn7vMj8ymoI7lOrdwA2wZeLtw9i2x3ds5/nogq36CfIRZS4hYc+qirLNIHt2nW506IFvpahJSRCQsLySPlPmvnkEAYTWNslJGXy+9BxI3daasLbS90Ttd4vC7YT4/v8P1minS1Z/CjHOuAi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098959; c=relaxed/simple;
	bh=p5TbwrytaIHOjZ2/i48Y09L2DtvqwntaSaz6jsr//jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeO/G7K/jZzJpzP+J0GYfzkF26U3bMrUIBDhXrynn9RJZP/BPINxcN2PD28fIzuYe+W+gjTsnjedLBFmCrAzYLYv7Lc4QsbERmPkXGBunvYcpVNfUEg3SWuDafo7MpPD10cCPK2BUTiqVkVMW9hSX7jVwKGHdJPsvw+baQPbwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WW4XaBqc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2c5Y8E2H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 21 Jul 2025 13:55:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753098955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBB7Vt0KsL1Zl/na85sfbzXNBtElxrLVoZ6pNK0+vYo=;
	b=WW4XaBqcbtaFWW4iweN1JB9noFuamMtHoX8yFEmTyp7sssWYlaxasMRmy2mJB/rndgLjXa
	oEr3pNQ2nnGUVbQixY3nsS9LoisVNFoqGKUYTYMX28wxq4+nrpoeUM4dUi7e3MugFkpkbZ
	DW/WZkxfpcYktY59KBh3N6eDlSQYSyL7ziIlfVgy+USXjxhlKn70N3/lLe/A4CSZJSNtpx
	P3nJXoBNWlqKs/fluGXFV4Y9A51wMSrEj1JiYirSc8jSFQAaXHYxiyY6mWA2mNO2DkF+7V
	ACCPKscLhmAQEbi9p6igTvUz/JxC3NAuRq2OayBo+lV5AmLhAAaLw08Rh3Uubw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753098955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBB7Vt0KsL1Zl/na85sfbzXNBtElxrLVoZ6pNK0+vYo=;
	b=2c5Y8E2HhmVftBE78dkL9Lp5GsEXjOUHgP7Z/LwQA3PVPCSbainG1vNbodP8JbyzPQMVj0
	tpPNStjsqcYXzqCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Mario Limonciello <superm1@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250721135540-2e295c9b-2032-4139-83cc-ad904d73dc41@linutronix.de>
References: <20250718193230.300055-1-thepacketgeek@gmail.com>
 <20250718193230.300055-2-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718193230.300055-2-thepacketgeek@gmail.com>

On Fri, Jul 18, 2025 at 12:32:29PM -0700, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>  drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++---
>  2 files changed, 33 insertions(+), 3 deletions(-)

(...)

