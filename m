Return-Path: <linux-pci+bounces-37297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAD9BAE928
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553B77A5AC0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96137286D40;
	Tue, 30 Sep 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JuIum8uk"
X-Original-To: linux-pci@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283B4C81;
	Tue, 30 Sep 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265452; cv=none; b=gFgblOTtDqvL3bqYfCBMyQmRO3c38aE0Q3TUGb5qJIppdoEuZygA09v1F8VXnsek+nTDP187PGnqleHggcYqO1/LGY5ilHCiuL7EAyJGXzwsWqZOnfLvvR8P+L9RWycR5BK5dyVceEHZn9e/VSXyJl6Rr6Lg8tu7YwSieE3ty2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265452; c=relaxed/simple;
	bh=ACcXPbe5NMl26PPR9Llchzmw0KCS84dSQ3O+3lah1Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXVEHkZGO/QivrewfvNIZhiCiuL0TgiAKFLpoxTa5FE3CaTbduSTw9VUGfqI9tBhDr6u8LcuNFwJj2d8kbXyhcRQfrfxo2fSo0skudlwD5tgBlZR78taYCUC04F6QtkigK6Kklog8mxiHe+GisItsQosZvKrq6leUknNce645zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JuIum8uk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oWMiHblyc1nac+1JY++WRrU7ggN2MiZoA9VBM+9/ciQ=; b=JuIum8ukiSTaC1+InRNlCaIT23
	AmY9Nod/PQSuuqB5s8rFmyFhod3tsRSZcYgyI9aoiksKsn3EFUanH5ClAtCdgZtqPmCCU7J4YxnrS
	F2FJUUO0JQPKiVoTJibJ+/+Vv88KZGq8St4qFERQ5Je9S1EsOJ3+Y5fwKUJqGOmIVAFO/WBce4keN
	DpfN/NFG5/bbOHUOtIBgZ7JVj6vJaFXT1GYzVOoijv51rJP0u5HqRI7OX2zzLI6ZmhoXqUC8XysJB
	5u/wIIbSTiJBdKOuLRB/mdeEO3zjeCJFoVq5ixmWjk88WWubAfhSFZkk2Bhih8UVWDwrV4gEXY2fB
	cXTa4ktQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v3hJ4-000000008BO-2jEJ;
	Tue, 30 Sep 2025 21:50:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v3hJ2-000000004oU-3EHs;
	Tue, 30 Sep 2025 21:50:40 +0100
Date: Tue, 30 Sep 2025 21:50:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
Message-ID: <aNxCoN2fP4aEAH2i@shell.armlinux.org.uk>
References: <20250925202738.2202195-1-helgaas@kernel.org>
 <CACRpkdZFy2Kb0BaEkMiTi3j89H-6G=chuZSijtRRg7QCCktLDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZFy2Kb0BaEkMiTi3j89H-6G=chuZSijtRRg7QCCktLDA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 30, 2025 at 08:59:36PM +0200, Linus Walleij wrote:
> On Thu, Sep 25, 2025 at 10:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > hook_fault_code() is an ARM32-specific API.  Guard it and related code with
> > CONFIG_ARM #ifdefs so the driver can be compile tested on other
> > architectures.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> It looks OK to me
> Acked-by: Linus Walleij <linus.walleij@linar.org>
> 
> I see some other ARM32 drivers use it too, but we surely do
> not have a arch-agnostic way of handling bus errors so perhaps it
> need to be like this.
> 
> I think Russell created the fault hooks originally so CC:ing him
> in.

I wonder what the point of compile testing if it needs code to be
#ifdef'd out.

Wouldn't it be better to add something like:

#ifndef CONFIG_ARM
static inline void hook_fault_code(int n, int (*fn)(unsigned long, unsigned int,
						    struct pt_regs *),
				   int sig, int code, const char *name)
{
}
#endif

maybe to a local header that pci-imx6, pci-keystone, pcie-rcar-host
and pci-ixp4xx can all share?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

