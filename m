Return-Path: <linux-pci+bounces-19845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B02A11B44
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80BA168D07
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800A1F9413;
	Wed, 15 Jan 2025 07:51:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E681ADC64;
	Wed, 15 Jan 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927474; cv=none; b=COBe0wRkq1gAaitDnVvT4wd4JUGC839/zN4Or6jShOhGmfm1qWC0ml7cB+aFhvIcuUjGzvvYcCR9haxHbgIoWD3NQVTS8TreIhWL+jnWua/wnOADcsS6dihOLmp13zP02XcLK9+H+GXSxzbFG5bLb4OrEAAoCnH/YzQQjLulDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927474; c=relaxed/simple;
	bh=OdibwhNYcB2STR06CnAdBOT+C31ilkUuugeRy5I9muc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNlWQBG6uqM0iCuktQdhtPm/u53ooySBZmnb/FWZQ5zIxGLob7znrRPBuU6fVsvcxoKDdlb0zMXRbk+c3Zhb1+Qlq77uHaJAEcVgiILyuoNPBuoG4dgGPAhHLzfBztC0JoRiVTgVXbbX4dpN9X6TcnRZVUOmvXgxKMeI+CshYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso112153705ad.3;
        Tue, 14 Jan 2025 23:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927472; x=1737532272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drCh1pRCCuVVCI4fn8N9RmOugnbPrEsMkgW0vT+Cabs=;
        b=UVPEpPjr8oyZNYrvCIbpb/PoWAy8AYf4OI3fA8BNgAA/JcRKxEqHFEeHpsmM+iGHKz
         RLKaSQA/B+lcFgWwIJ5xGZWbzHgYbH8OTFPyRHlFTr18Byn55C2Tg4t4tDsk4xqH2aTM
         7aPI4E3Il4vj3TCCJFJEv9YQTZ1zAvJlSwIaoBIrEYL/kmHxSx1+o3K+fB/V7shKFpKw
         gIKX7RKWrQgHypY9UXOymYQ8Ud3OJiGXN6Ay9YHFW4/D5AAJnJys/YMyUztXEoBoCQeR
         U86I9xWiJFWSu2M1uGb31PGxo0vEnWqIhUFXhdqLLdrgrWJFMUeUUzyc8OH4vCR/pyHx
         YRhA==
X-Forwarded-Encrypted: i=1; AJvYcCUX7FGGpvPzjfBFTEmCCVfGLwe/GGSep/5/vAq+SkUbiN3CazAEitt4Td7n0cn27pJKaLK00eOVqIcD@vger.kernel.org, AJvYcCX+6mLOhJOFNGU23Ku0Rx/c5OopSJvLMfZV6Q5ZAO4BRAYTmjajW68AeFmhPrHGSdfAB/OvSrDyXgPHrcrlT64=@vger.kernel.org, AJvYcCX4JJ9AsXGQ924a+uwhWCh7sA1ZBMEGoHyuvB7tudF67Ms5Ei5UlLlT+ayYEEs3b10eJ4lvIjeBjMj9blzx@vger.kernel.org
X-Gm-Message-State: AOJu0YwJi0SgPWkNzILdWT4T1aY2NwWlZrPXSSs3SLcloLjphAhLVvVK
	LJGt3Cx6ro3zfe/fUq3xsnocgIbYfKTypZTj30p1inWMUC+W/FnL
X-Gm-Gg: ASbGncthiiqGHPHNl6H7BB/cv9RSadkoZ1V3g2pDHxla1aHtKIE/HGrxdrQYd2vplCI
	URgTtRdtxA8lvaAPvwWH3zPTZajPAOPQGYWLEi/OdoYeyqGUBGSDZWm5OZCDjmHSwQu0eFJKBQF
	jdZwt69OrvpXVjd2z2EJmGN7PlMdXYOt60b4cq5gUo1kpDAIChFuSzHjclfEtcsAyzFYiQ/+ONK
	93iv/ZoNwEU+1TDP6SdQxfirgKqfphsg2+r0Rcbmby/WuAfV6EKS6LP8xaCdkksQmfOl4tX7YLZ
	zfmYoaLqZekAYWc=
X-Google-Smtp-Source: AGHT+IF9TnngdOrqXrmwB55byFeDNpcjUAho4KzCQx6WWCHOh/pLidGszCFWm7Pw0uVlfLtCKp9MvA==
X-Received: by 2002:a17:902:f60e:b0:215:522d:72d6 with SMTP id d9443c01a7336-21a83fd2383mr432105685ad.38.1736927472073;
        Tue, 14 Jan 2025 23:51:12 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21bb316b825sm48453045ad.237.2025.01.14.23.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:51:11 -0800 (PST)
Date: Wed, 15 Jan 2025 16:51:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] PCI: rockchip: Clean up on error in
 rockchip_pcie_init_port()
Message-ID: <20250115075109.GA2704262@rocinante>
References: <7da6ac56-af55-4436-9597-6af24df8122c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da6ac56-af55-4436-9597-6af24df8122c@stanley.mountain>

Hello,

> Call phy_exit() before returning on this error path.
> 
> Fixes: 853c711e2caf ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")

I squashed this together with the code this fixes.  Thank you a bunch!

	Krzysztof

