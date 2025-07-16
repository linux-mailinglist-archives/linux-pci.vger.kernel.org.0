Return-Path: <linux-pci+bounces-32260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAD6B07656
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39F17ACD80
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB785626;
	Wed, 16 Jul 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tethera.net header.i=@tethera.net header.b="MR9kmxwY"
X-Original-To: linux-pci@vger.kernel.org
Received: from phubs.tethera.net (phubs.tethera.net [192.99.9.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64D28C2CA;
	Wed, 16 Jul 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.99.9.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670549; cv=none; b=MhQMP/YXozhn9kIfDJFLoLM2NvcjdpBi6izxJ4cdhHzELPdEfvsbRRHnRoHnZoTP7h+2xapY9KDsOzMPw8TRl8H/F64DLrXVQtWd9cmwoqeJyaBxG09XDIHqXD39Z+UrbEX+uERJ2EgFjaK5PjGHB60TTJhj6iUl5bMnQBKFWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670549; c=relaxed/simple;
	bh=Ia9GyGbk8B9rjMX/RPITkTLboZkRzYcVoZFfzz+/9ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQcgXoxQLp09FUwtARKtNg3PJM4hhelgzmJhUB2dv0+s9wj31sNpA4JxS+gZhIXClXilMwV/sxaexeh20qGJfLikXL6leIpeErnq6pXj7CYPEDCFcSn8cHjCRQPfLqanEq5qecw16CBAGjrFoFupT0a3rPSRC1P3YmuaP56TU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tethera.net; spf=pass smtp.mailfrom=tethera.net; dkim=pass (2048-bit key) header.d=tethera.net header.i=@tethera.net header.b=MR9kmxwY; arc=none smtp.client-ip=192.99.9.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tethera.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tethera.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tethera.net;
 i=@tethera.net; q=dns/txt; s=2024; t=1752670540; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version
 : content-type : from;
 bh=Ia9GyGbk8B9rjMX/RPITkTLboZkRzYcVoZFfzz+/9ho=;
 b=MR9kmxwYKgoB6qvgTWe3XASPi1F6c62HiYwIBJY1Dvg0Tk2YovQguaaJ7sFv+f/USkCV+
 cnyR39/CZ5fvL6Z5D52jKrP0gEQug6JbX9TK/AuKThrXmmA3EEe2V3+MUqdqukW4EkQ+C5H
 BKV4bFVRuSJQ/V8TH2/H/B0bv4LHwUMjYQchBjYu6TOQJaPnjm+I2DhXwlZGFyZotwqTyto
 otGcMWlzXuUmLOGrhs0ntxhQwsNmfo4NQ0s9a+YqSs/DN4jccWFFGyfHWtdoef6hVd5tOCJ
 fZz2v1+IitN+g9Q32K/amKtTL+C8yiEOLWmB/rqs9tFqoFTVM2fBsL6+eE+Q==
Received: from tethera.net (fctnnbsc51w-159-2-211-58.dhcp-dynamic.fibreop.nb.bellaliant.net [159.2.211.58])
	by phubs.tethera.net (Postfix) with ESMTPS id 9AD4118006D;
	Wed, 16 Jul 2025 09:55:39 -0300 (ADT)
Received: (nullmailer pid 2675178 invoked by uid 1000);
	Wed, 16 Jul 2025 12:55:39 -0000
From: David Bremner <david@tethera.net>
To: Niklas Cassel <nks@flawful.org>
Cc: wilfred.opensource@gmail.com, alistair@alistair23.me, bhelgaas@google.com, cassel@kernel.org, dlemoal@kernel.org, heiko@sntech.de, kw@linux.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, lpieralisi@kernel.org, mani@kernel.org, p.zabel@pengutronix.de, robh@kernel.org, wilfred.mallawa@wdc.com, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
In-Reply-To: <aHSs6ZF8rQIqEOyR@flawful.org>
References: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>
 <87cya6wdhc.fsf@tethera.net> <aHSs6ZF8rQIqEOyR@flawful.org>
Date: Wed, 16 Jul 2025 09:55:39 -0300
Message-ID: <87zfd41eic.fsf@tethera.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Niklas Cassel <nks@flawful.org> writes:


> That said, if you have problems with suspend/resume, perhaps you want to
> try this patch instead:
> https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
>
> I don't know if Shawn intends to send a new version or not.

Thanks for the suggestion. In fact the hardware vendor (mnt research)
ships a version of this patch with a 6.15.x kernel. An updated version
would be helpful, as the previous version(s) no longer apply (with git
am). Failing that I can have a go at manually rebasing the patch.

d

