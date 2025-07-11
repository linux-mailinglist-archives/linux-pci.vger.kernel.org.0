Return-Path: <linux-pci+bounces-31965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001F9B0273D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60C3E7A0567
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32AD20D4F9;
	Fri, 11 Jul 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tethera.net header.i=@tethera.net header.b="FDH6Y9Oh"
X-Original-To: linux-pci@vger.kernel.org
Received: from phubs.tethera.net (phubs.tethera.net [192.99.9.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B16BFCE;
	Fri, 11 Jul 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.99.9.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274468; cv=none; b=K92Piz2JJscy/c2OLjFPVqYJuK3CRF39qd5b8x1Gn1HAe50rGiiuvDBtoLuCs4PawV1toaJR6GV7w9fN8UktaaHFeaGFK1QHTjZ1wWe50jvtVCHSksvLY3g83VqxMSebIMn1CON+nKFuXoxUCOn6nIpDTeAsuIJDKpZHleHNPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274468; c=relaxed/simple;
	bh=zEL+d6XlXqEpa9OVBskMukB3A3gQTghEOyqrGTQsvC8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=fRXY5sNpusYBa43/mHbLGJjbJjJhA3v/zW8MsSA67SOsaEd7dJMKO2nEZjErZCGJmGIJHlQd3t4bxQrpEqZSCPL/YNf2qi2KZCcTlOY5VN7goZXvjH3EyjhNxxET3+Kx/1Aug1N75oLsoHpxYFclpFiDJvfR4D3jgyRGLv6juss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tethera.net; spf=pass smtp.mailfrom=tethera.net; dkim=pass (2048-bit key) header.d=tethera.net header.i=@tethera.net header.b=FDH6Y9Oh; arc=none smtp.client-ip=192.99.9.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tethera.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tethera.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tethera.net;
 i=@tethera.net; q=dns/txt; s=2024; t=1752274112; h=from : to : cc :
 subject : in-reply-to : date : message-id : mime-version :
 content-type : from; bh=zEL+d6XlXqEpa9OVBskMukB3A3gQTghEOyqrGTQsvC8=;
 b=FDH6Y9OhJ/oMZ74hq3OD/Q2WnQ6E+FFQrNVmbRncYQtSVN08ThXiP4TnGgfLl8YlWCqAI
 csO+/ITQ7aaRoYFlwx++63/H5SnVVglEh4t2im+WxDyWbvX3VOTApD2lEVyt344JlL5I11P
 SlwDrTsFMZaqY8c8IpBS8i8Idi8/eLOWM5WpTC+FMfU+gkkA3zAMXxINgfKR2xGEGNZUCzR
 TQZ5Mq71NXKwNy4wFXIx8I2dbedeRv2/N3UFoapIh3WZ9KdmALfKvZDHw1ZjVj+/Arc/39D
 FTt1Lt4LKDItiUoGAKYSIHM/W94u+S41PugrZgis8+kUuL+4ArmqgyHbS4jQ==
Received: from tethera.net (fctnnbsc51w-159-2-211-58.dhcp-dynamic.fibreop.nb.bellaliant.net [159.2.211.58])
	by phubs.tethera.net (Postfix) with ESMTPS id 820DD18006D;
	Fri, 11 Jul 2025 19:48:32 -0300 (ADT)
Received: (nullmailer pid 155084 invoked by uid 1000);
	Fri, 11 Jul 2025 22:48:32 -0000
From: David Bremner <david@tethera.net>
To: wilfred.opensource@gmail.com
Cc: alistair@alistair23.me, bhelgaas@google.com, cassel@kernel.org, dlemoal@kernel.org, heiko@sntech.de, kw@linux.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de, robh@kernel.org, wilfred.mallawa@wdc.com
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
In-Reply-To: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>
Date: Fri, 11 Jul 2025 19:48:31 -0300
Message-ID: <87cya6wdhc.fsf@tethera.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


What is the current status of this patch (and the pre-requisites) with
respect to mainline linux?

I'm wondering if it might be relevent to the problems [1] I've been
having with rk3588 resume, but it isn't clear to me what I need to apply
to e.g. v6.16~rc1 to test it.

[1]: https://www.cs.unb.ca/~bremner/blog/posts/hibernate-pocket-4/

