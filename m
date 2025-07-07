Return-Path: <linux-pci+bounces-31615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E61EAFB2C6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 14:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309CE4216FF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F92951BD;
	Mon,  7 Jul 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J/CH2BNN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DEF1E0E14
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889669; cv=none; b=KtQI2HJIkq4vXVo6DcASjFx4j6gU1uX+LqmJpMI4SUGBSQHGahOdXF/iW15ykxNMWZzXCnR/zZCo5i9FElvhBTm+IPG4UtdvREB+BNhq5ZdomDDholALY1bKykuTA0TXkXCtXmnIeY382UyI+CvSOr4apPd6lv/sGKwCTI4FXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889669; c=relaxed/simple;
	bh=NYE1/zwxWHmOulQ+HuKvBZEAn3rmUhfmFV+pVMZCm9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PALfq2KX7lDplku1ehhykVE/vSJUyFXKVu58RaCDnJb0K6o8gLhS9GFVu5hMBXsxOj+J3wqbf29Tg5NQK6FrR3RxZanMuFAdZmXjg2jraH/AlFoTnNn1S11AIJaO0xHfxofuYpRHPVbJB6am3MpnT0cLq2P1/K3ERWgekWKLEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J/CH2BNN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=v6Qu
	fareNLNn3UFYbV8ntusgGG8AMzvapPp5xVg2a8Q=; b=J/CH2BNNwBz/INtXzqUi
	JzXmw4WYqaSpUAAl5/1nQT8ew9Vcj/uHeuDY4/TlaHIbmUr9vu3C9v4iGTMpG77P
	5GzWM/Aa2pn3kjxwcRSglh8NniQese4kdaoTP/O6J1V8y2kIFx2uo/NN5MgDvycW
	mX1ZNLG7AQUH1NisBz+5EdQVI5YmboE4V6rOALT7OaECyDBRR9Ywe99FCWm5jdbQ
	mSlt21SJ9K+ib9+P2+HsOAe8oyJywIL6IREQsxZ5wXBH2dcRbmbUT73lnc2ltXlg
	5h5l9EVJBJdbSP4R4ga7P5iTqAna5b89jaFCM2o1gF4bzyqI0BxWwNewC1eIQkTv
	8Q==
Received: (qmail 1234705 invoked from network); 7 Jul 2025 14:01:05 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2025 14:01:05 +0200
X-UD-Smtp-Session: l3s3148p1@ksEpmVU5CsIgAwDPXxVOAFK6vZd9m4LR
Date: Mon, 7 Jul 2025 14:01:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, lizhi.hou@amd.com,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 0/9] PCI: rzg3s-host: Add PCIe driver for Renesas
 RZ/G3S SoC
Message-ID: <aGu3AJHIEYgHVRQQ@shikoro>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <aGtsM22QYqekuiQA@shikoro>
 <96af5f63-dbaf-4177-95e2-a6cc24019dc0@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96af5f63-dbaf-4177-95e2-a6cc24019dc0@tuxon.dev>

On Mon, Jul 07, 2025 at 11:05:30AM +0300, Claudiu Beznea wrote:
> Hi, Wolfram,
> 
> On 07.07.2025 09:41, Wolfram Sang wrote:
> > 
> >> Please provide your feedback.
> > 
> > What is this based on? I tried v6.16-rc4 and renesas-driver/master. Or
> > is there a branch I could pull?
> > 
> 
> This is based on next-20250703. I pushed it here, as well:
> https://github.com/claudiubeznea/linux/commits/claudiu/rzg3s/pcie-v3/

Thank you, I doubled checked and tested again. Still works, great!


