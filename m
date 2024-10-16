Return-Path: <linux-pci+bounces-14681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C69A10BA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F25EB23854
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0981210196;
	Wed, 16 Oct 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IiXfwICt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pt5w5zxS"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68F18660A;
	Wed, 16 Oct 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100121; cv=none; b=toyDl8Ny3zA81yjo3vrH+POy1E1Xj6VpKS10TfVVP7ICNfgSgnwZ82jkCCHhB/aTdZPM73IEoUF4UjJdvtoixRVG0P3xVpS39/r0KKU5juJ2czoBfI9yU67w0AvpZffurEK8jq6CUCj2ahs+2gJJwZPU15kziot/FBgOwi0PV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100121; c=relaxed/simple;
	bh=p8bgC4HdVsPKF33YDC5yBWtaY+EH5NkSqt0VYV41+z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DjhKy3sYihnNZ9AilDYcA3ySJIQoW/XoCMgdBTz2scof9UH4+IbFxfBQjKamB+eBzeNbbOXeWWPW2Oe+6zK0N0N56vhQRr7ElIAdE5rKBXuAv4m8GMcLt0AMykFKhuX2mXLL4pritYyzKo6di4HnLSGpalVJopwwh/tmyFQwg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IiXfwICt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pt5w5zxS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729100118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftTHX3aDbfuhiYSSswl8jerjMR2AN5shXO76BX64Gd8=;
	b=IiXfwICtg/N2j4ik+acBkLZu4hcfivG9UaAZT4lwsYowMXC4x7fey68HwgK4hEqBTWk2r8
	6pd5j/k0VSTyO+m6evv3vh4BTNTr1piMfzuVHsnM4diEtvAuzvZ0YpdvC8VjbjwGf67sYq
	A0VOJYtTOV93eLoDi5LXZvccSVRIr5Dfuf/xK7j12li9Qb5XzqLEVC8MaUls+K6HQi/Wc9
	lT2KJpqO/9QGeUpTRxxMByBzi2fnSN4u7Mb+kHea4kELOlDAG1eLrwUe1tFQ0keGUAVPcb
	y37nRFCrF5I8KJHKtasj9O5m3bqImu8y/hHsqfzRIvkjo6+/cudduDn/GoqVWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729100118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftTHX3aDbfuhiYSSswl8jerjMR2AN5shXO76BX64Gd8=;
	b=Pt5w5zxS+TQS7IMz5uzUZuPv9FrURkwOuTrvihz0w4BQ0fafiMk2K0s/0MOckFGoSNUf6/
	PC5LAaa0PHVgckBw==
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, imx@lists.linux.dev, Niklas Cassel
 <cassel@kernel.org>, dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us
Subject: Re: [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
In-Reply-To: <Zw/vq4EweR+yTphB@lizhi-Precision-Tower-5810>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com> <87bjzkau33.ffs@tglx>
 <Zw/vq4EweR+yTphB@lizhi-Precision-Tower-5810>
Date: Wed, 16 Oct 2024 19:35:17 +0200
Message-ID: <87wmi89ciy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 16 2024 at 12:54, Frank Li wrote:
> On Wed, Oct 16, 2024 at 06:30:40PM +0200, Thomas Gleixner wrote:
>> > +	scoped_guard(msi_descs, dev)
>> > +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
>>
>> That's just wrong. Nothing in this code has to fiddle with MSI
>> descriptors or the descriptor lock.
>>
>>         for (i = 0; i < num_db; i++) {
>>             virq = msi_get_virq(dev, i);
>
> Thanks, Change to msi_for_each_desc() is based on comments on
> https://lore.kernel.org/imx/20231017183722.GB137137@thinkpad/
>
> So my original implement is correct.

Yes, very much so.

Thanks,

        tglx

