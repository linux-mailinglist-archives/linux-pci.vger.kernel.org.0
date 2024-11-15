Return-Path: <linux-pci+bounces-16831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB99CD9F2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0934C28247D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58C1714C0;
	Fri, 15 Nov 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByiC8ZiP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFA10F2
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655878; cv=none; b=udzg2xVgujqSuuThtHuxbfry8lQSMu07wCpXcGh8BXqjtf6fuzhNfw/vhAwQYogI7eZE/7WtAjpzfUiTemVmQ+09+TWvT3q0Q/nmi9gg4kZdO5c+mVGVFxK3Ab6LBPhO8i1oOfUfv5vbxrYbqBdWvx9r0Ay4meOhQmMV8xjB5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655878; c=relaxed/simple;
	bh=DEsujF0MhaoMw1D2S+efwZQTlULtnKNa5uC7aR9wgK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5sUxvsxKDrgSqERgcwpScengX/Z61D0BvhLs5GCr5Zq21aZp7vOH5E5wQ7ma6YSvxcZB7/Vq+U/wLD2BxpCAdiav7CQP1J2QKivtUZuQSkBltGVztLZwnTQryJg6dKZ+0QR2BfI7h/zV1BYd9xY5B49PjBP/CQY4NOKdqp6gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ByiC8ZiP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c6f492d2dso16996525ad.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 23:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731655876; x=1732260676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZktoj+DIyt/M5en/E9U1CXLfcta4k31BJ3MRv9v+lA=;
        b=ByiC8ZiP2x0719d6do/v64i5dyCkYsWcbX7cOl3jh6w1+KSOEMvp7gqL1vuVIRY3O1
         JkHB1f1hCqCJ5WulTj8UVa5q8Vmjnvr+eSNfcYaRrFMcKaA9S4XDHhaxqQgA3lsF31O0
         zLfS2IlW9NeKYDrJ48I4zj3Bo+hEs+FLTlc0Wjkt2a4Mu3oEzLAtCWWAvLXCAhgDDIRb
         PPPewAY8VAoJ4/GRCDYRN6WztolLMJU8RaYJMwVPn7zjWWgBgTsssZMbZxKpqonLUo8+
         SLTL0YFdXdCMebsc5bxcRrIrIYuHihVSgDQmQpI5g1SCo3nmpJMRddF3jzVdMrxR+1Wm
         2TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655876; x=1732260676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZktoj+DIyt/M5en/E9U1CXLfcta4k31BJ3MRv9v+lA=;
        b=o4sYJdWqI5S+EgvDWYsYsJ9lso8XuFoCkuW4AOdAbPENHSIPpiMSMqavuxR+OzBuVz
         5J6QjAOdGUn2DOJZu3a6Gaxk35aFmY+k65T1Ivg6/J/II63JBdr8wasKL1DuaQfPRJ2/
         ni/iUuzgeYP1kQWTD9+w15w/4CUfftWVMsfFoh9Exbch4cBRBzQnWFF3Ez4Azpwgf2QQ
         ftb0RkZrkJUZkXU1gg0KFkxjCQDMv5B1BN3knhiqsIp6l2zJ4QNLaHzVtAUXWFmOaMTl
         noxt6cTfuKVuMxUzcfRkvz+ACulYh7yB09H7/Ylb1T4EAKglTttC1Qa2FERhiKHs44zM
         a5gw==
X-Forwarded-Encrypted: i=1; AJvYcCVc1+m0ge0ccJSQsZtiNdpn2wg4sITgli10hYXSWjd3PGjBanTCgmmz3gA/76nYLcn7JT9mKmM8YeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUyZzusWDNAjK+aVs3NGGUNfUYVHMu4bLiWmBXorSCduvmxKu
	Li5/K3LnHDAdIDxw6jEeEgp6O+sJmQ0WHc+0MpA5HYXbteyvd5MFFinxk6jzbw==
X-Google-Smtp-Source: AGHT+IGqasFmOrneoq4IblHicWacSTw8Y/GAFQYAAdde1mcCZ45w9edIxU/G+UXSRE3e1ost0zYZXQ==
X-Received: by 2002:a17:903:22c4:b0:20b:861a:25c7 with SMTP id d9443c01a7336-211d0f1183dmr24007255ad.54.1731655876340;
        Thu, 14 Nov 2024 23:31:16 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc3281sm6839075ad.30.2024.11.14.23.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:31:15 -0800 (PST)
Date: Fri, 15 Nov 2024 13:01:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing
 "ranges"
Message-ID: <20241115073104.gsgf3xfbv4gg67ut@thinkpad>
References: <20241107153255.2740610-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107153255.2740610-1-robh@kernel.org>

On Thu, Nov 07, 2024 at 09:32:55AM -0600, Rob Herring (Arm) wrote:
> The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> but it's still just normal "ranges" as far as parsing is concerned.
> Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> instead of open coding the parsing.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

LGTM!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Could someone please verify it on mvebu machine?

- Mani

> ---
> Compile tested only.
> ---
>  drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 29fe09c99e7d..d4e3f1e76f84 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1179,37 +1179,29 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  			      unsigned int *tgt,
>  			      unsigned int *attr)
>  {
> -	const int na = 3, ns = 2;
> -	const __be32 *range;
> -	int rlen, nranges, rangesz, pna, i;
> +	struct of_range range;
> +	struct of_range_parser parser;
>  
>  	*tgt = -1;
>  	*attr = -1;
>  
> -	range = of_get_property(np, "ranges", &rlen);
> -	if (!range)
> +	if (of_pci_range_parser_init(&parser, np))
>  		return -EINVAL;
>  
> -	pna = of_n_addr_cells(np);
> -	rangesz = pna + na + ns;
> -	nranges = rlen / sizeof(__be32) / rangesz;
> -
> -	for (i = 0; i < nranges; i++, range += rangesz) {
> -		u32 flags = of_read_number(range, 1);
> -		u32 slot = of_read_number(range + 1, 1);
> -		u64 cpuaddr = of_read_number(range + na, pna);
> +	for_each_of_range(&parser, &range) {
>  		unsigned long rtype;
> +		u32 slot = upper_32_bits(range.bus_addr);
>  
> -		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
> +		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
>  			rtype = IORESOURCE_IO;
> -		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
> +		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
>  			rtype = IORESOURCE_MEM;
>  		else
>  			continue;
>  
>  		if (slot == PCI_SLOT(devfn) && type == rtype) {
> -			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
> -			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
> +			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
> +			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
>  			return 0;
>  		}
>  	}
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

