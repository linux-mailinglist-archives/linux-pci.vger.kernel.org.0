Return-Path: <linux-pci+bounces-11206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6468946439
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4853E28365F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED614C61B;
	Fri,  2 Aug 2024 20:07:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF69D272;
	Fri,  2 Aug 2024 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722629266; cv=none; b=iMwV0bo/TfZz3w9qszsT2shsbHp1Mg6CR9cgm44qgnLKjU4by+wYHCvuJW0q09VqzlLlFNGH4kcGoCwQyqZopDNkjlNcxSjef0gxW9L0ompQz5VYM/zgcZdkK2msZMGq6Bs/gFJpj+lTN4UOHUhkzoUX3T1rpE9E31+qHDe+ORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722629266; c=relaxed/simple;
	bh=wE8OKquMMv91cO1Ouu4ZnPCZSFtMagofbn0AEBj1D1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LimPK22QL/kj3VmOb9n6Bknla58cNdkVztF+dHzE7uyFqmGOnOuPSbSbZOS1VbekEQQvJlkEpJgjpOy6QAgqAhC5WEgKcac9qIWLlBbIYcEaOO6kHwCjHLg76ixXf0iEwDirjMwrtRzuTocLbSDpQ/VTxucKWYnJ5Kg+IaAYsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 93F63100DA1A1;
	Fri,  2 Aug 2024 22:07:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5E13017601E; Fri,  2 Aug 2024 22:07:39 +0200 (CEST)
Date: Fri, 2 Aug 2024 22:07:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Message-ID: <Zq08i2i_ETHsJiKW@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>
 <Zqyro5mW-1kpFGQd@wunner.de>
 <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>

On Fri, Aug 02, 2024 at 01:19:24PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 2, 2024 at 11:49AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Aug 02, 2024 at 11:25:00AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > PCI core is already caching the value of pci_bridge_d3_possible() in
> > > pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going to
> > > change,
> 
> Is that really the case?
> 
> Have you seen pci_bridge_d3_update()?

Okay the value may change at runtime, e.g. due to user space
manipulating d3cold_allowed in sysfs.

> > I don't know if there was a reason to call pci_bridge_d3_possible()
> > (instead of using the cached value) on probe, remove and shutdown.
> >
> > The change is probably safe but it would still be good to get some
> > positive test results with Thunderbolt laptops etc to raise the
> > confidence.
> 
> If I'm not mistaken, the change is not correct.

You're right.  Because the value may change, different code paths
may be chosen on probe, remove and shutdown.  Sorry for missing that.

Thanks,

Lukas

