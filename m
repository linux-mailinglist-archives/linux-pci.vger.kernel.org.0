Return-Path: <linux-pci+bounces-10812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070393CA59
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1044328251E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7813A40C;
	Thu, 25 Jul 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAfghAQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5ED299;
	Thu, 25 Jul 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944358; cv=none; b=eRxSMwxsVIIU2qQIziJSx0t5JManFT6LR08hHHT2VEWIeMXRmKLsgyYg1ibwqqFyzYgzNKr3/wdRnqDFMewXTEI1SOXQDN+r3JKXrOmksMl7FQrRket41vO4UNV4yf5G5CliFxeA045v5zOnhfqufJdc9Fq6L6uMFfwdayh7tNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944358; c=relaxed/simple;
	bh=IrKpiaN+b3wtsI7hGiuRsiFfXgfzj2Kw2qeYLtR/EAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz0mQMQWqNomGRVqYt5dTr5WUebRBxcvJSY8t2RqOFc7NlwcrxeO8MD0UHvkYpZC+53utqoR6iwLRe30961wpNnRjTmUzQI+ReIeXb88fM3tLQpOklIZHNNTGDE/y5nv7U+MsQUhh1/b8Jk/fvtMyDY4jAXDNr/WgiWMkmiANdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAfghAQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56654C116B1;
	Thu, 25 Jul 2024 21:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721944358;
	bh=IrKpiaN+b3wtsI7hGiuRsiFfXgfzj2Kw2qeYLtR/EAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAfghAQscxZAHGMvCanaZGsw+VGQXmV2AXwRtEC2FSqa2rS2dSt0Wyh7jbJI8ZP3O
	 bzb65Zjwnu0BFFkTueINPN0dMf2E/jlqkmbnav064oaOIiL9yGDyR7suNWsr0Hrft3
	 YmZmJvyeDRVwFvNG3uyLWAM0NVA8iEVUFSPyShPH0X7RBJXf7mC6pZ7UJRA04gFvsa
	 nJVtNUkJcS6s4cnDUH6Mi4NR92mNPNyQLwypZT5suxezyt4saR1crxcCy5kNFUIVZU
	 ZwcSK4YcExUmH8FoCl586VeBq7hIfW9Mq4+o8jK3Q0dd4TL5ufJAaCIY/eB7aIaua/
	 7A5tTYWqKw5Hw==
Date: Thu, 25 Jul 2024 23:52:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <ZqLJIDz1P7H9tIu9@ryzen.lan>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <ZqJeX9D0ra2g9ifP@ryzen.lan>
 <20240725163652.GD2274@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725163652.GD2274@thinkpad>

On Thu, Jul 25, 2024 at 10:06:52PM +0530, Manivannan Sadhasivam wrote:
> 
> I vary with you here. IMO EPF drivers have no business in knowing the BAR
> location as they are independent of controller (mostly except drivers like MHI).
> So an EPF driver should call a single API that just allocates/configures the
> BAR. For fixed address BAR, EPC core should be able to figure it out using the
> EPC features.
> 
> For naming, we have 3 proposals as of now:
> 
> 1. pci_epf_setup_bar() - This looks good, but somewhat collides with the
> existing pci_epc_set_bar() API.
> 
> 2. pci_epc_alloc_set_bar() - Looks ugly, but aligns with the existing APIs.
> 
> 3. pci_epc_get_bar() - Also looks good, but the usage of 'get' gives the
> impression that the BAR is fetched from somewhere, which is true for fixed
> address BAR, but not for dynamic BAR.

pci_epc_configure_bar() ?
we could name the 'struct pci_epf_bar *' param 'conf'


Kind regards,
Niklas

