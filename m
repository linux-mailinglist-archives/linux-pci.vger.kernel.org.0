Return-Path: <linux-pci+bounces-5608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86443896A5F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5B01C24D52
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2466F06D;
	Wed,  3 Apr 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbIFSyD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610F45008
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136084; cv=none; b=LlO23Z3SUVmr+qBrJdqZWMfCGfeRSEPoiF2OlmD3b+3yhczMmsHcsNof5hfhseGwjOTiV0A0urI8NNVB/JFqBV14pshfDlyJ9YOuz2dty2xRlM5eEYE7eDyt9CBtiiARWvHxouc0W91QO3/dNCBp5kJNmvyFLt5GHVqPjZ+GwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136084; c=relaxed/simple;
	bh=H5d8DlzGND/H/f1KN3Yf4Lvv14SA1lkHDdHDkosRGD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccyk2Kqq4c5WnW1sLyioMJ7u3ySGVvBK+Y1YZxgqP379FCxrJvfFraE2ly8XmZ9PQrGs3Lyptl6U5IAQWQT8B5hAVl5sXjRDX29a60jfdtYgLW28otmp1Ab9evG5iqxXxeMqFy/WtH6gGgw57pwoX1/T9kgIw2HYDbDfW9k5fvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbIFSyD5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso2467413b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712136082; x=1712740882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vtLqEmydzrCNnRTSENhA+AKBW/+wQJ0+bubWJxgXh7o=;
        b=rbIFSyD5ctdxcZva8oXACTINt88ARST4xLi7z4YPRUHD8j4D02O8VUadGBWMwPZ8gN
         zF7J3lHfdz+sEjMm1XcD62KWDae5mwA+wxiVLMisGNyG4IFwduVisstvQw9oAHv+7+PG
         kTpYUg77xl/MbeAVLQ4bLPIN/axilV4dq3pOJ7Wp0pQNz480ILFmNJQZx61FwUf/nnts
         t3jlQfDjmm4kALVRX2tEl/2FKexf3NLfHdO9YgVgUtEgPe8mQp0AYLOGOcubNJzflghM
         2Wqho9+ANeGCJv7Uw2kqNp+kkmpvkXCnjd3XYNlVFL6Od09V6zxqXAx3rEY/ScM2pMOC
         IS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712136082; x=1712740882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtLqEmydzrCNnRTSENhA+AKBW/+wQJ0+bubWJxgXh7o=;
        b=qnKgBevxtj0x02tSLliOV6O7/DKNU8tuywFxNdyeXL69BC83Ig36pL3o7qor+B7yHo
         rTbcIUsa3Mc8zDBBPADBjrNdu9F6578Ne20sFhsA4C6tx2IY99lPeTEsYPcMrTUwpCq+
         qkv8M0puEuCHEuGWoH0m+qjXGp95Crl7RU2p1FsauW8Jh830ebJN1W/f1VJMrgRFvAJF
         f6uIl/VZBmaFtVI8UFqf6S6aX1nlmIDU6kkM0D7oeHQJRIxbptNgURE866wzHKlFFk4U
         corv9QUd8teYXRu8gbuifQ+653KqUJ/GApL9WksU+iD0HIPL7aUEDGi8H7r1DiYjIAvX
         dQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCWO/fYDN8EZbNpVZJZET0NHpMoXjT14udqljZzde/Aj64d+qus2yXk51B/dAN10ckUDukwIZM142eaRhRFojsC7HS40eE0PzwD6
X-Gm-Message-State: AOJu0Yye5xMRjlJe7ylyr6E7RBEuwgK5fXaSnFMfmZaud8UoSTMFoQDU
	2xVfaazX8v6ASwhlgt/OZrQIsuFFgIRM/xP1xEwgstp/KIHAwzV6ZeGMgX+mCQ==
X-Google-Smtp-Source: AGHT+IHI/Dy9/VZiFVNF4MsqF+YXBPtwtdyt2Oqfn6ZAyRQOCFBvez6QTVmfCs6rxrt5RobVKu/RUw==
X-Received: by 2002:a05:6a00:391b:b0:6ea:b690:f146 with SMTP id fh27-20020a056a00391b00b006eab690f146mr16024936pfb.15.1712136081817;
        Wed, 03 Apr 2024 02:21:21 -0700 (PDT)
Received: from thinkpad ([103.28.246.48])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a00244c00b006ecd9cb9035sm216831pfj.177.2024.04.03.02.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:21:21 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:51:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 02/18] PCI: endpoint: Introduce pci_epc_map_align()
Message-ID: <20240403092114.GG25309@thinkpad>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-3-dlemoal@kernel.org>
 <20240403074520.GC25309@thinkpad>
 <eb580d64-1110-479a-9a0b-c2f1eacd23e7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb580d64-1110-479a-9a0b-c2f1eacd23e7@kernel.org>

On Wed, Apr 03, 2024 at 04:54:32PM +0900, Damien Le Moal wrote:
> On 4/3/24 16:45, Manivannan Sadhasivam wrote:
> > On Sat, Mar 30, 2024 at 01:19:12PM +0900, Damien Le Moal wrote:
> >> Some endpoint controllers have requirements on the alignment of the
> >> controller physical memory address that must be used to map a RC PCI
> >> address region. For instance, the rockchip endpoint controller uses
> >> at most the lower 20 bits of a physical memory address region as the
> >> lower bits of an RC PCI address. For mapping a PCI address region of
> >> size bytes starting from pci_addr, the exact number of address bits
> >> used is the number of address bits changing in the address range
> >> [pci_addr..pci_addr + size - 1].
> >>
> >> For this example, this creates the following constraints:
> >> 1) The offset into the controller physical memory allocated for a
> >>    mapping depends on the mapping size *and* the starting PCI address
> >>    for the mapping.
> >> 2) A mapping size cannot exceed the controller windows size (1MB) minus
> >>    the offset needed into the allocated physical memory, which can end
> >>    up being a smaller size than the desired mapping size.
> >>
> >> Handling these constraints independently of the controller being used in
> >> a PCI EP function driver is not possible with the current EPC API as
> >> it only provides the ->align field in struct pci_epc_features.
> >> Furthermore, this alignment is static and does not depend on a mapping
> >> pci address and size.
> >>
> >> Solve this by introducing the function pci_epc_map_align() and the
> >> endpoint controller operation ->map_align to allow endpoint function
> >> drivers to obtain the size and the offset into a controller address
> >> region that must be used to map an RC PCI address region. The size
> >> of the physical address region provided by pci_epc_map_align() can then
> >> be used as the size argument for the function pci_epc_mem_alloc_addr().
> >> The offset into the allocated controller memory can be used to
> >> correctly handle data transfers. Of note is that pci_epc_map_align() may
> >> indicate upon return a mapping size that is smaller (but not 0) than the
> >> requested PCI address region size. For such case, an endpoint function
> >> driver must handle data transfers in fragments.
> >>
> > 
> > Is there any incentive in exposing pci_epc_map_align()? I mean, why can't it be
> > hidden inside the new alloc() API itself?
> 
> I could drop pci_epc_map_align(), but the idea here was to have an API that is
> not restrictive. E.g., a function driver could allocate memory, keep it and
> repetedly use map_align and map() function to remap it to different PCI
> addresses. With your suggestion, that would not be possible.
> 

Is there any requirement currently? If not, let's try to introduce it when the
actual requirement comes.

> > 
> > Furthermore, is it possible to avoid the map_align() callback and handle the
> > alignment within the EPC driver?
> 
> I am not so sure that this is possible because handling the alignment can
> potentially result in changing the amount of memory to allocate, based on the
> PCI address also. So the allocation API would need to change, a lot.
> 

Hmm, looking at patch 11/18, I think it might become complicated.

- Mani

> >> +	/*
> >> +	 * Assume a fixed alignment constraint as specified by the controller
> >> +	 * features.
> >> +	 */
> >> +	features = pci_epc_get_features(epc, func_no, vfunc_no);
> >> +	if (!features || !features->align) {
> >> +		map->map_pci_addr = pci_addr;
> >> +		map->map_size = size;
> >> +		map->map_ofst = 0;
> > 
> > These values are overwritten anyway below.
> 
> Looks like "return" got dropped. Bug. Will re-add it.
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

-- 
மணிவண்ணன் சதாசிவம்

