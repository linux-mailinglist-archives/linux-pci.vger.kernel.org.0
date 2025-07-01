Return-Path: <linux-pci+bounces-31164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16662AEF7B1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B2B1885360
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9827511A;
	Tue,  1 Jul 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFqTf1yY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA6275112;
	Tue,  1 Jul 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371060; cv=none; b=jY9P10gzHzxvszybhA9YptJgARBRcQydcFG6NWA1rVuKbgh32P686K2z66l//XXq5JplzNcDDiTLg3qsc11e+dKBdFhsXrB7Ywd1DVwOl2NBMlyNKSS7sjdy2EcI/jCtBEGoamlIkIgM5G3Z8xxwbaEMIVa/LM5+tjo6PRQaRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371060; c=relaxed/simple;
	bh=VwRW6iX/Igy0SBU1tuHE4cuDIm18Y4pVZANCC4AQf9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC7AmClBYHQIwfx446mkjhhoeeolqqFWHJW6SXEeh0EbDF41cqE2ElWFgvjwsZP7mVF7P0edditeFiRI/8ncnyIL2Xpwt6D/IPVtXggc0vicERLJO2kcrcP5WdEPH97UWRqxQmVDUhwH9J95b59wkFRNVFHpg6QhIkh6BX/all0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFqTf1yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8643C4CEEB;
	Tue,  1 Jul 2025 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371060;
	bh=VwRW6iX/Igy0SBU1tuHE4cuDIm18Y4pVZANCC4AQf9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFqTf1yYmp7A9KHA0f3w4oB5yY4QmKC7ykrvXpG3u/okaLZARyB7R8lwtSpKbayyS
	 QdcB1x0XHjp2pTF+E0bFSwZhRmHLV2z8Wz8edBrWRX2uVWo8WA6Sciiq+PjZnbvOkR
	 1k02W/Eiq2QqP/c3/SM/dQrB9oLVei4BYx+tgeMDzrlnjXkGSCULvwAd/kp7lUj+P1
	 ILV2Wb/wcKHJwf9Qhfg6ZfsL/4dyXwozQwRzh72xM8l3dH1iL/mRnETviOeMxChxzc
	 gAOnyoyBkLNaVOmZrQl2qf5JJr6aH7beIqtnmLTAGcpKV5FrTbj9LbKdzCCkisdpY4
	 oSFyDQ8ceGipw==
Date: Tue, 1 Jul 2025 17:27:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <n23tedrmgzfo7bxe4mbde2rrsayalcz4jya5yopoeahlll3qaw@mpz4oemtyern>
References: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>
 <aGOHkmG1jnDistgh@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGOHkmG1jnDistgh@wunner.de>

On Tue, Jul 01, 2025 at 09:00:34AM GMT, Lukas Wunner wrote:
> On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2508,6 +2508,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  }
> >  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
> >  
> > +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> >  static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> >  {
> 
> Hm, why does pci_pwrctrl_create_device() return a pointer, even though the
> sole caller doesn't make any use of it?  Why not return a negative errno?
> 
> Then you could just do this:
> 
> 	if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
> 		return 0;
> 
> ... at the top of the function and you don't need the extra LoC for the
> empty inline stub.
> 

This is what I initially submitted [1] though that returned NULL, but the idea
was the same. But Bjorn didn't like that.

> Another option is to set "struct pci_dev *pdev = NULL;" and #ifdef the body
> of the function, save for the "return pdev;" at the bottom.
> 

This is similar to what Bjorn submitted [2], but you were in favor of providing
a stub instead [3]. It also looked better to my eyes.

> Of course you could also do:
> 
> 	if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
> 		return NULL;
> 
> ... at the top of the function, but again, the caller doesn't make any
> use of the returned pointer.
> 

Right. I could make it to return a errno, but that's not the scope of this
patch. Bjorn wanted to have the #ifdef to be guarded to make the compiled out
part more visible [4], so I ended up with this version.

But whatever the style is, we should make sure that the patch lands in 6.16-rcS.
It is taking more time than needed.

- Mani

[1] https://lore.kernel.org/all/20250522140326.93869-1-manivannan.sadhasivam@linaro.org/
[2] https://lore.kernel.org/linux-pci/20250523201935.1586198-1-helgaas@kernel.org/
[3] https://lore.kernel.org/linux-pci/aDFnWhFa9ZGqr67T@wunner.de/
[4] https://lore.kernel.org/linux-pci/20250629190219.GA1717534@bhelgaas/

> Thanks,
> 
> Lukas
> 

-- 
மணிவண்ணன் சதாசிவம்

