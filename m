Return-Path: <linux-pci+bounces-24783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31BA71B9C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 17:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7C3A5C99
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA791DFD9A;
	Wed, 26 Mar 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej9pISPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4C1B3950
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005846; cv=none; b=Cvpou6c8moZ3FIFuyqHGfHhtF4jOKe5rJqu4FTES0FE0mOw14VgaKRajlMGHar49UrRaDixFhm/orkrkHu7Nb/nwWY46LoKhrWQwgcrTXN9VcRJNOhlyDAdMOHWMAQt6YZCmxDLxEpk31G9UqIKsakMRdktRfY9e7Jh5kHs1cd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005846; c=relaxed/simple;
	bh=5dcvWL0iv/YaAYmkZr+LjyM4VLOwQbeplg5heNV1dA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCzcxyZkXFOe+V+XptsJ6TDhYNdXf4gL86encdi3Sta9XSpG9KyzSVxFL2Pre0c/IkZr8fpg2h2DWOJle+SMhJCsZXmK5oMmisze9gvO0uY+hjgGt+nikwcvgE3rfU6KPoQ/VA6XcyW+AK1bOfigcOgnzx1XSVhdBFJbDKTeN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ej9pISPs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso9617342a91.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743005844; x=1743610644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Aij6vHYIvM5QmFLX/dAv4+rIw9rL3EbRlodr4UNRjM=;
        b=Ej9pISPsnhPhs5gFunEzYX8Q2UtaqYRxQW/nL59DroV1crInZpo1zzGRONUe1kv8TW
         Nr2hGgxteB2ASDykwWNknhLqHMQGUJlBfqDzapke3vvr0U52uRRLmLUzf5lIKgVPdtr3
         nJCfiu7COFOjhCs2IA5XMZOHphQlK6E/Mh40KHJZomp538RtAZ4Ic1WbN8UxvBBmgfsw
         9GK4gXyx+QTjBAAGHjtno9brcgPKblU8SQFi3oIKbd0pglaftzk2RhMWjbFGVupRFdro
         DMLGlEgVt26FenGAUGx0aa5oOALXkECH3R8eulSv2FP2+8dp12JDnTfRR8ZszYbZ456/
         N0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743005844; x=1743610644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Aij6vHYIvM5QmFLX/dAv4+rIw9rL3EbRlodr4UNRjM=;
        b=urxZlepXvRi48urYo6We0PzxnNNn1wEJ07U+DYOwSi+/g4mDSUQ2AEe8Q16fSmvCm/
         qS3b1+XpfUL9lKt/y9F86i5UDmH+gxyCb7YkK0kiXPoAfjeCLyvZHOu4NffnY8alkfSm
         J/ofkodA1NFRJ2jk2n/LabHltCst1Bp+KvEgg0EnxVP6EAi6emC2cntc0xylWA5vNIWr
         Uhb2Y6Fh6TUgmSbr07ho132Qb0Ia8yZBvald2dWaah9Hnx5FKV3wiiELuL+0FvpYxexl
         r3ZXD3fyWRMW0DzamBPeytp1rcJKoOlL09Qsv4ee/yQS3DRzpvTx2Fb7rcSmSqrm1F4I
         5OXA==
X-Forwarded-Encrypted: i=1; AJvYcCVMZMl1iJYJvmyCx7/6OWJrWGJTT4SzYmmPjn9DYMti1y6xwCZgPWYvL1JbuJSIclIe+mzpQLvcQsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/oCCe62u1IkuUDnwycHM4CPYIm53nLMVx7XjIEze1U+uTVsm
	9+D/0KnMrwRi3RJQv/3AaYA0ZARbcRNdoWsXMzSulgPBhlhTk4/ESNgJ5p+U7g==
X-Gm-Gg: ASbGncsg7qINS9Yx8pHQrhM4BhoCOyoswUSMdlVG4mX5tvoKaWD1Bx4Q09CXya2puvX
	5077x4npJKnkt0vpGDEwhmQW8faKxxsCGzfxGzfhfMQakfn4S46U9+CS0rvpLsBUWFb8z5vQUeH
	mj+ZyXb3cdRSoPScxxmT0hjdfLQZCVc2318Xduxez8ENfs/qV5cDcvKvaxXtWTfSdv5nUIvutp3
	kInr7HkBIPTZtHIxp41oaByVgiyKBNrd1z1mGVLa9Oec++prJIZDZR9r1Qczy/dTgXeZ0Xdzq+x
	8kPiGJ+CdX/HaYHOwDsShKCeeFgDgvh12YeDwNsc9iDPJXpeoFlmnibr
X-Google-Smtp-Source: AGHT+IHR+lhKok0xp2x62D8UsEz/nljlJhHUm/J5q1AnittbIxiiXDEI0qf0hYbR0KxG+XBx0egPRg==
X-Received: by 2002:a17:90b:5403:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-303a7d6a72dmr425268a91.10.1743005843941;
        Wed, 26 Mar 2025 09:17:23 -0700 (PDT)
Received: from thinkpad ([120.60.135.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dfd380asm408792a91.3.2025.03.26.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:17:23 -0700 (PDT)
Date: Wed, 26 Mar 2025 21:47:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <bbgwy44nxf4h4hiycyue56uzfktfqzzwvw73bovtz42uklhuri@ejqrp5kjqbqh>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
 <20250320152732.l346sbaioubb5qut@thinkpad>
 <Z91pRhf50ErRt5jD@x1-carbon>
 <20250322022450.jn2ea4dastonv36v@thinkpad>
 <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
 <01676177-4757-41D3-BEC2-F61C0C7C3F69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01676177-4757-41D3-BEC2-F61C0C7C3F69@kernel.org>

On Wed, Mar 26, 2025 at 10:39:50AM -0400, Niklas Cassel wrote:
> 
> 
> Hello Mani,
> 
> On 22 March 2025 01:31:44 GMT-04:00, Niklas Cassel <cassel@kernel.org> wrote:
> >
> >BTW, can all Qcom platform raise INTx interrupts in EP mode?
> >
> >Bjorn did not like that I added intx_capable to epc_features without having any platform that sets it to true. I'm quite sure that many platforms can raise INTx interrupts.
> >If all Qcom platforms can raise INTx interrupts,
> >then I could set intx_capable to true in epc_features in qcom-ep.c, to address Bjorns comment.
> 
> Can all Qcom platforms raise INTx in EP mode?
> 

Yes, all Qcom platforms support INTx. But if we start setting the flag to true,
there is no need to set it to false as that would be the default value. So let's
just set 'true' for INTx capable platforms and assume others as not supported. I
know that you had added justification in the commit message, but I think we'd
have to drop the below commit:

PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts

- Mani

-- 
மணிவண்ணன் சதாசிவம்

