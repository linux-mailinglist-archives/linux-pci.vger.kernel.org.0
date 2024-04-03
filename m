Return-Path: <linux-pci+bounces-5637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC87897A98
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 23:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78349288B6F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177E156650;
	Wed,  3 Apr 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="aqkX3Oh5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AB2C683;
	Wed,  3 Apr 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179404; cv=none; b=Xrpt8nfBstkSz7Eg2pJWS8aOUXEFKLoucoR/VMYsLtXF7Tiu2TFbgfezHHumotlLjkjGQdiC8LVku9beZxvQOypG3REKf/1wZ7xK/Rlf9i14LqEqUcGFi2ziTrIUiWeEf9jtAk+UFgHNc4jKqSjwjjUi9hzFMuns4MKerND2JyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179404; c=relaxed/simple;
	bh=zKcfJEWPy8TF6EjCWJ8BJL0m/4Wc3HUSGtpaiggXuiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JECmoHCpMay2ThjuYCYCikpwcHTEeH3juyIdT3zVR0c6reYY1Lo+NJnXabzvFoy+BI7CzhGUsSajxjiVMKJEjzSm/Qu2c6ABE7skSmvsbPmJOI2lJUyblMSiXcWgx/9Q+MmK0XbKIGr4dZOcwDZwNWodpjEiOPdk1yHSVqwL5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=aqkX3Oh5; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1712179389; bh=zKcfJEWPy8TF6EjCWJ8BJL0m/4Wc3HUSGtpaiggXuiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aqkX3Oh5oUQ9Pj917Fpw6OxxRrxAvxIwZNg6WEu/GatO06cG1Rbj2M4W1knXjL/I9
	 WbYkGl9CfL4FZ5UKL4ouYaD2WSk/coLw1TN7CmGCKayWuFLDo5coaPWpMBSauRCA52
	 vRGBN4nUU/9Z4FiylTkv9jF53Dx4pGaGLEOIAzzhwmmR3RkSMWOBpROyM9vsplJKJz
	 knPyqjQjZAJjoD+K1JYQr6dDRxuXqBNK43pPU+Q1VAsaWXWTRTXmZy2udmTTyqKoZP
	 oAwrMisu1sWEZWpbtqYG1fkRKj6P2MIzsm7v5LmzY9sbQe/1V1JTpQ7bRv/1ds1L59
	 yTHTawT+o9WCQ==
To: Heiner Kallweit <hkallweit1@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader
In-Reply-To: <cd66af0c-835e-4222-b362-e2e9cafdeb40@gmail.com>
References: <cd66af0c-835e-4222-b362-e2e9cafdeb40@gmail.com>
Date: Wed, 03 Apr 2024 23:23:08 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y19ukuo3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Using the device-managed versions has no benefit here, because
> resources are released as part of the asynchronous fw loading.
>
> Actual reason why I got here is that I was looking for places with
> dubious use of pcim_pin_device().

Could you please expand the commit message to explain what this means in
a bit more detail? That will be helpful to someone who wants to
understand what the difference between these versions is and why this
change makes sense, but who is not that familiar with how these internal
bits are really supposed to work. Someone like myself, in other words :)

-Toke

