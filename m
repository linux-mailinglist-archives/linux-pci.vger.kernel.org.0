Return-Path: <linux-pci+bounces-10815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB193CAF8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 00:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F3E1C21761
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42383143738;
	Thu, 25 Jul 2024 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9DZquRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D07347D;
	Thu, 25 Jul 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721948038; cv=none; b=jBrDP+Ku62Fj/5Z2l2jlk4nDa6hdBtes5b9CMADX1AsuLP4kU9U86faIssqY8g2gNgPw3002he34YuDUpsm7lY7NiA8jSWS0CmI3WRc5/xUwqMfAv1tod+7Vlt5/cUQMvn22zFzB+eKb2ZCWoFpEKoHputPCTxCDJY7VBQhmeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721948038; c=relaxed/simple;
	bh=R6S9gXXCvFcEEnFGDPjRLt+pSR9174oFmWMbGbEGKuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYCsEEzVHVpwsNdyQaYDKC4APvs4gq4T0bI2xnqUdLQ60DOwT84YLhesjGbfL1RLudvCQG8HmeEM2j5ps9Rk4fTqzLqo8k355ukM+okLrPL9hHEj1cnipuN1vf77PY/N1oI9K4xYZsKw5k62ji38IVrXO9/31DWmluD1lBEw6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9DZquRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2790C116B1;
	Thu, 25 Jul 2024 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721948037;
	bh=R6S9gXXCvFcEEnFGDPjRLt+pSR9174oFmWMbGbEGKuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o9DZquRbn6zpoY2VcT/cxuQlGzlixJq9mn94I96j9tBCMqVJwaR4rXU5PM9sZRe4k
	 EU8FdjpXKx3vcolwK+CR0yi24vrZbQTNaFAuZMhbyqepoB2IiWEIA9M+2CkUBujnPh
	 mMF4E6xTXCSY6B1n2jjNu/jnsiRNad8+Ts14QUEDocsnP+FX9kFpqh6uCNTU7QjSiK
	 mNW3cI5Ec11jxNYP1p5Fmm8vUGlYNl+gRUFv00saQ6qliubm9IQ9tA16V6sC1PuX84
	 mklYzhrZZfwCgdRRwqg5ELz29qDsxricp7HPWpSCiff9O17gGDnbTulAlZMLA+Ane+
	 tbXh+ShG5tuEw==
Message-ID: <9c76b9b4-9983-4389-bacb-ef4a5a8e7043@kernel.org>
Date: Fri, 26 Jul 2024 07:53:54 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan> <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <ZqJeX9D0ra2g9ifP@ryzen.lan> <20240725163652.GD2274@thinkpad>
 <ZqLJIDz1P7H9tIu9@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZqLJIDz1P7H9tIu9@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 06:52, Niklas Cassel wrote:
> On Thu, Jul 25, 2024 at 10:06:52PM +0530, Manivannan Sadhasivam wrote:
>>
>> I vary with you here. IMO EPF drivers have no business in knowing the BAR
>> location as they are independent of controller (mostly except drivers like MHI).
>> So an EPF driver should call a single API that just allocates/configures the
>> BAR. For fixed address BAR, EPC core should be able to figure it out using the
>> EPC features.
>>
>> For naming, we have 3 proposals as of now:
>>
>> 1. pci_epf_setup_bar() - This looks good, but somewhat collides with the
>> existing pci_epc_set_bar() API.
>>
>> 2. pci_epc_alloc_set_bar() - Looks ugly, but aligns with the existing APIs.
>>
>> 3. pci_epc_get_bar() - Also looks good, but the usage of 'get' gives the
>> impression that the BAR is fetched from somewhere, which is true for fixed
>> address BAR, but not for dynamic BAR.
> 
> pci_epc_configure_bar() ?
> we could name the 'struct pci_epf_bar *' param 'conf'

+1

But let's spell this out: pci_epc_configure_bar(), to be sure to avoid any
possible confusion (config could mean configure or configuration...).

-- 
Damien Le Moal
Western Digital Research


