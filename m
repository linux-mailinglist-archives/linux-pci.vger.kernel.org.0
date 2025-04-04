Return-Path: <linux-pci+bounces-25290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3664A7BCFB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36313B74D0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9E1EBFF0;
	Fri,  4 Apr 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWmDEqUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C461EA7E7
	for <linux-pci@vger.kernel.org>; Fri,  4 Apr 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771153; cv=none; b=emVIx262qIHtzrNYQfA2mBkz+KElpcDEdSiGJKiL3ma8//aPttXIlPNRYOmRU5cehUYrLvFwQJ+EJT4KEC2JP6WRT62HPohEaCH5kGVcg0bRRlnADhQUtCaTk0xJ8HaUY+K/W6ujupgEsPVEq46vjPo+j5hufh6/N6HyUAM+o4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771153; c=relaxed/simple;
	bh=rSyWljWgOpiiMEZiTLykd/9NqgJXQ9olRcNpovHlunI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnRHDGqOQmGJE/LUOydOYNePuc66rWwI3qPVqIZ7VqcejDoWmoQbSuZAXsf4Ve9P/1WUPs4fPfM+D/0UH5eSKBuWjPtG7dV79jpt8/0iSDayBYMUgsDOn9b81nS9X1iMxgpHIlbO6hAUsHiBMoRzBLBRxCCghaeeG3xVlWwsaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWmDEqUS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22403cbb47fso20995765ad.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2025 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743771150; x=1744375950; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DKMhv36eTVwOYBrxUb1Bibo3iK9Aa6oEo/P/njWpUJg=;
        b=MWmDEqUSbYWhhgRpkle05339KsKoXTCsJTBPaQXGvIuEKzgxwswQ1PJ68KMLWh5ysR
         J/+lEPz5Jieb3P1YuIMIY1Q+E7Xj1wtTOXsoWN6c+x99pCqNsZ4JFNWnsMk/2pzAdwg2
         wCe/6rrKOYbWzyzeQTaTnMoH+hl2h4JXS3kqrtnRvEhDBlybgruNQEmO5pqFjjY3UrIN
         TM7B74LZIuAfUSpU4NFded5j2NDbmbySH3DQzcmGqX7kOrkqakZSNdg8Zm5k89Pm2vZY
         rvK5rHo/bRHgtG3IA03qwjnubNWdnE940OvDh1VDMZAfw5bj7pI7OyB9owhrtxMFB5R+
         /lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743771150; x=1744375950;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKMhv36eTVwOYBrxUb1Bibo3iK9Aa6oEo/P/njWpUJg=;
        b=hzMSs97RN1/nff3k8luT1sDfyJ04NxbHta5TEsS3zRcP0R57OUdz4njTemUMarLRdJ
         BmPaeJGi3f2H42mQC8G4dJ3+nPYQrZJ2LZYJnM7Buci0GDjnCfrt8GX89eQfU+tqwtne
         9z5BEvFdQhVye0MsKwmcSGKq0BQrwesMF7icp/ZcFxRfxE4zpFYygfPmRDKYuzM6v+9E
         LfUak5xbht+yjUToz9LIt8z0bBGtmnmuEwYu9xdJU7KHjWFzjbzF9u49LSB94c5dUxF3
         53Gq+mmCqRm3P3ayylvVszKDQfe1v2l8Ec+fm/ClkSFD6uf4Zki6118inIJuNjtgj5xS
         sqTg==
X-Forwarded-Encrypted: i=1; AJvYcCWZB30t6E/02OMyAp1LQnTtw1gRuJhHR9TFQq4MRHLkZRPn1gABGM3KIKwDBIRkFwjuw8xmG/7v1cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dX/mP+aQPSxwaDEBjr/hUN/09SX2cM/TMDVXcWZi9rj/Yyo5
	4hUwamdVN8aqI4zAYE46sAwsgY3yYL/BRJShLgatSHNRa3LY9t4BHkQ7amZVGw==
X-Gm-Gg: ASbGnctFln9NA04P6Y8yhKsYuIHaKfgXfnNQHlF8Mu2L6hFwTQK/vtNXty56hsnH+Rl
	unjgIAp8BLD8l983tA1r84FVEI6sTS+2eijpZo/HQsY2oeFjNm2SRFQPaVNVpZDfE35riLydUke
	xE+OOMdF5M5LCv55RbbCa8yFCD6AUHEOOH9KXUArVpR2hPVvOpgdWaZ83mo/TD6bxCnHG0z8xv3
	H1UgHUv9WW0q5UU3YfgX+sPZcVnqhw6qsilxmoChqXIXd8NmPetoBB/We19hm+kCLyY27XzxY/a
	V66pl04Sy+QTgS2D6h9BDQCPT34pxAKm1yuP9yzFjlkSgmhYhOeXibHqNzaL4vIvDw==
X-Google-Smtp-Source: AGHT+IERCFn6js6qeVXEwdJZjCbdeV3RjyphuuYpeMmQ+ZbwSxAgINay3FYEHGIrYESdCmhtl9xeVQ==
X-Received: by 2002:a17:902:d4c7:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-22a8a85a18dmr40259765ad.2.1743771150028;
        Fri, 04 Apr 2025 05:52:30 -0700 (PDT)
Received: from thinkpad ([120.60.75.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad83esm31289735ad.20.2025.04.04.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 05:52:29 -0700 (PDT)
Date: Fri, 4 Apr 2025 18:22:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: shao.mingyin@zte.com.cn, shawn.lin@rock-chips.com, 
	yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, ye.xingchen@zte.com.cn, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	heiko@sntech.de, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, zhang.enpei@zte.com.cn
Subject: Re: [PATCH] drivers: pci: controller: pcie-rockchip: Use
 dev_err_probe()
Message-ID: <4mbdugltwhiaw5kgg2d44jq4yz4mpdrscjiomp2kmnv5gk5i22@hid72rovi2oj>
References: <20250403154326411S4luMrK8A5RXovincATzF@zte.com.cn>
 <03d12cd2-c719-4703-a0eb-2a32ef41af92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03d12cd2-c719-4703-a0eb-2a32ef41af92@kernel.org>

On Fri, Apr 04, 2025 at 08:09:40AM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2025 09:43, shao.mingyin@zte.com.cn wrote:
> > From: Zhang Enpei <zhang.enpei@zte.com.cn>
> > 
> > Replace the open-code with dev_err_probe() to simplify the code.
> > 
> > Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> > ---
> Considering zte is sending untested patches from poor automation (or AI
> generated), this might be correct or might not be because it does not
> look like probe path.
> 
> Anyway, don't send patch by patch and line by line. Why you did not
> decide to fix all of the places in these drivers?
> 

To bump up the contribution maybe :P

But to reiterate what Krzysztof said, please send patches only after fixing all
identical issues in the driver. Patches should be split only when the fixes are
non-identical.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

