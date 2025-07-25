Return-Path: <linux-pci+bounces-32931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E6B11C0F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 12:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6DD7A4549
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AB2E92BC;
	Fri, 25 Jul 2025 10:13:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E32E88AB;
	Fri, 25 Jul 2025 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438420; cv=none; b=k0ZMxnI/zwlVWtCV3L7LKA6RUTAfS3woyASzRKlhu1vzin+fIrsaYHacWL/tu9fYnLwefaYAXIPt/HSgxFR6Ow/hHIpOIlmYRTXFxfD51pwcIVDDfmhbf5+GFooM+TMVhKBsX54A14mcoufcYJdp7iOeA3crx/txUhptATl9NuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438420; c=relaxed/simple;
	bh=RAnkZnhZCXuW/VC8m+XbUyNTZpL7NiZbvl4UuVb0rbI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8hAhqx30000kfr5Q9ul0/7UWCd6fj0Sf6JMiURN8o9wPy3TIpy6VzorqrnjdQNZSAJCVRIergb5bHjX4TU0a2KbacJDiVhJewYTk3kC+/Fz4lxWiIR/5LckjaLN725tWgVX2jZfiMUIpqO9pdgluE798QmHknf0PNzGjxr0yBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpNrq2wNvz6D8Ww;
	Fri, 25 Jul 2025 18:09:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1C5C1400DC;
	Fri, 25 Jul 2025 18:13:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 12:13:29 +0200
Date: Fri, 25 Jul 2025 11:13:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Salah Triki <salah.triki@gmail.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Pali =?UTF-8?Q?Roh=C3=A1r?=
	<pali@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Use devm_add_action_or_reset()
Message-ID: <20250725111327.0000346f@huawei.com>
In-Reply-To: <aIMAkbdOyHsiPeph@pc>
References: <aHsgYALHfQbrgq0t@pc>
	<20250724164217.GA2942464@bhelgaas>
	<aIMAkbdOyHsiPeph@pc>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Jul 2025 04:57:05 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> On Thu, Jul 24, 2025 at 11:42:17AM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 19, 2025 at 05:34:40AM +0100, Salah Triki wrote:
> > 
> >   ret = devm_add_action_or_reset(dev, clk_put, port->clk)
> >   
> The second argument of devm_add_action_or_reset() is of type void (*)(void *)
> and the argument of clk_put() is of type struct clk *, so I think a cast is
> needed:
> 
> ret = devm_add_action_or_reset(dev, (void (*)(void *)) clk_put, port->clk)

Can you use devm_get_clk_from_child() here?  If not add a similar variant.


> 
> Best regards,
> Salah Triki
> 


