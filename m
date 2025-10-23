Return-Path: <linux-pci+bounces-39126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC166C003F7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581FE4FF506
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6696F308F13;
	Thu, 23 Oct 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F5Xi9F95"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA1308F0B;
	Thu, 23 Oct 2025 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211853; cv=none; b=n7Y4Ph3aKELnxm1oH2ShSVwacJ9EShdGAa/wVl/hIGIPq0FeSEA0UQiJKwNCSVSZXTR0Ofr1ygvL9N+AbaFNUbgdxKeR3YU1raktBHUXDV9Pu9aaz4g99VKqETD/NMPj+UVrRIylLIo7zwsVIxrHg3dJJTC7xgwQkaRp30ul+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211853; c=relaxed/simple;
	bh=oorMr3OL1HxVI9uAYh/f+Fad6W0DVA3ddaEhO1SCEO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS5vHjww3RuLVWE4/h5oRcuX5ZwFpIrkwBIUQf+iWrUeCRICWFC1tU348UpOfosbjUBJ5ZAnMLUXRhYIYYmz2TedTPuQYOji/GuqPUn3mDCBSbXstK9zhw7F2501DB++jbTTX9DVz2WkA0Sd5UP8aROuZwxWkYj31SZsyGuHRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F5Xi9F95; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1753D4E412A0;
	Thu, 23 Oct 2025 09:30:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DBF576062C;
	Thu, 23 Oct 2025 09:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A056102F245C;
	Thu, 23 Oct 2025 11:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761211848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=88pDVkrbzXLWUMF+6eEu2ubK5cD6gW9j9QnD38550iE=;
	b=F5Xi9F95xMaK6NgEKPwqvC/kfJL5COPl5Ifj29T/GULYo2wdEUO9izF85NnMDOcvstmGJy
	7Ak8+EhQ3zdu4mAPXIrFbtgJeO0C1UDGJFOTFGCFaIvxznCGL52QoUPJvOcB1uzxtPyFYt
	oMHikxhksEF8shT87TeS0lLCScyiUV33KRQuOF1x48CfTsp39DWPDlPlLoRz2nw+q1sOoN
	WNmJUZstvcX1yr7sXmWdBO6141WN9i8Mu6r3PHG7OS82XO1q2dSmjHvATIsjAaDqkqsl2N
	iDZyyep+WhPb1Vynl6o1IpjxH4nSCDZDMDF+KZxHrAgwGFkQyOdyL509cLBADA==
Date: Thu, 23 Oct 2025 11:30:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@oss.qualcomm.com>, Christian Zigotzky
 <chzigotzky@xenosoft.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org
Subject: Re: [RESEND] Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for
 devicetree platforms
Message-ID: <20251023113043.2caffec9@bootlin.com>
In-Reply-To: <B08A289028EE2F0D+c2d1f2e5-d7c6-497a-82bd-92ae477e1016@radxa.com>
References: <20251022191313.GA1265088@bhelgaas>
	<340D76D438E6105B+58e7f834-75f7-40c5-a46a-677cb279a02d@radxa.com>
	<B08A289028EE2F0D+c2d1f2e5-d7c6-497a-82bd-92ae477e1016@radxa.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Thu, 23 Oct 2025 14:01:59 +0900
FUKAUMI Naoki <naoki@radxa.com> wrote:

...

> 
> maybe https://lore.kernel.org/all/20251015101304.3ec03e6b@bootlin.com/
> (then +Cc: linux-arm-kernel@lists.infradead.org?)
> 

For information, I tested the patch and I can confirm that my issue is
still there with the patch applied.

The only way to fix it seems to either fully disable ASPM or move to
performance ASPM policy.

Maybe my issue is simply a broken ASPM either on my host or my endpoint.

Best regards,
Hervé

