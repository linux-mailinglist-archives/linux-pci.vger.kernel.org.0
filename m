Return-Path: <linux-pci+bounces-12455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53708964BFD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B3F1C22CCA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A01B5EDD;
	Thu, 29 Aug 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pffm/He+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83518C331;
	Thu, 29 Aug 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950286; cv=none; b=lgnHID7DTqnvdalPJCUH5nyd/vCgjOBDe6KD0QAFsBhYXXgctC5wrrzt477GnqpP6/1GqOHHfaXWm9QDmXcCVkO7SEMJTgxnrjZQn8zgIeLvQxL1hYCMHZTsEJyJ/3uuXi/yDhxZwKhDGFOYCTwe8tq16oDC1I1SRTxuPt65C7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950286; c=relaxed/simple;
	bh=VHEUvglnJc7OOAt4hBIE5an9rfbpzsV2UAGYEkqJGvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sIyrkLxkHRmdGN1ul6LFSs4PG2rQJnKBY50HI73jYoylhiR/u2/vWo5L08Nnd9+Fvk0le29y+3i+4oiYM9DZPvX9HGJmRk0gtKo1y8VWdqWSi1PdYqfIW3DUS4GX4L+20t0SRY81yuuSVGUII8SHufQgSefjyG9S9B57LFAP46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pffm/He+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D144C4CEC8;
	Thu, 29 Aug 2024 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950286;
	bh=VHEUvglnJc7OOAt4hBIE5an9rfbpzsV2UAGYEkqJGvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pffm/He+fX4OTon9jN6Dv1qXOc9vrQZJDCTuzyY18nPEcDRviXFyafje/fAg1sogG
	 pMd2G69XA2v+NvGI94C+4tlmJMDNHW+odCivkusXydpzPDMR10PaAUA9kf7IMF8bdt
	 4W9rCSNhsZfWl8YVLqhkpHjq5hRZuDAlzykucre6u+MHBnV71KyEYKqSNg1IaHG9ND
	 vOsE9PZ7SyukQrI4qjA0ZrkibYVT3bJZnHOEx2DwvB758Nj0fLpmMcanzYwV6gzhsh
	 KwAWNK3EQGc/Fp1xouWnrvGDcbh5jwdUTtJ70aPFPO82FPkIWMvMuDXwZvwvmoDdTL
	 Ma46qKZlKQpLg==
Date: Thu, 29 Aug 2024 11:51:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: WangYuli <wangyuli@uniontech.com>, mathias.nyman@intel.com,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, guanwentao@uniontech.com,
	zhanjun@uniontech.com, Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: Re: [PATCH] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
Message-ID: <20240829165124.GA66576@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99754b01-51a0-29d3-6022-4e25130ff36a@gmail.com>

On Thu, Aug 29, 2024 at 12:38:58PM +0300, Sergei Shtylyov wrote:
> On 8/29/24 10:30 AM, WangYuli wrote:
> > +	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM ||
> 
>    Hm, ||, not &&?
> 
> > +	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
> > +		xhci->quirks |= XHCI_RESET_ON_RESUME;

Definitely a bug, thanks for spotting it!  Must check both Vendor
*and* Device ID.  There are likely unrelated devices from other
vendors using the PCI_DEVICE_ID_PHYTIUM_XHCI Device ID value.

