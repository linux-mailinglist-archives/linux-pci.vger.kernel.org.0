Return-Path: <linux-pci+bounces-30263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B39FAE1E95
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 17:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6161C3A5EA2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330CA2EBB80;
	Fri, 20 Jun 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2EjNPdF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC802EB5B1;
	Fri, 20 Jun 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433033; cv=none; b=nhTfTdbESa1dzTwtcmAErVFDVGvFQcLlk8viyS4tWNnMAnMZURrSMX7dPKzbxIgsBJmvAPEdMhYLyR1UTpvlIZrrM9vnF2NgEyicL6pR9b7j1IqOIa7VEfZ2tTuEm6wJO1URCM4OQDwGjzHcaL2qZiQ/AFqhoXvhxcddP5oqSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433033; c=relaxed/simple;
	bh=iwq/+Q/e7kBxQ3rjoWEiPb6qPn9I4cQn1Lure4idRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0nYlu51SNKjHxUp1YCncO8YAtdSyQNZYiklgZu0l2N4dBlM8Y9iShLdECodNNFX3pcQdg+quOe632BaSaM//bR2bm3bDOIT633Pt7HWE8lw3Jdx9vFIt7MZLNqHq71fD9aU9yVREKXjDvatHmlQdZYdz+PxRZHD6yEarPm5Ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2EjNPdF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313b6625cf1so1419561a91.0;
        Fri, 20 Jun 2025 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750433031; x=1751037831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJwPe4Na7egNR42KB/ME0LulyT8UQ11yNNRgw9O2r5I=;
        b=S2EjNPdF1L2C1VhkdzG3ek56EFqgOGO/TUz6EEmUb1Ly+dllMcJp+nJDDEyQQOzi8T
         SSVnOJ2n7hztm4SsA9hDri3n5dDV/YpsnSyex7yIrs2QSbO9WBtIzfVfOPVYUH7qiXNR
         Qf9m56p2szME7hVIdfwj/qvCmUASNV9CEixgS/louUAiJ6D0Dm12hj8q8BmXj37cOndq
         ZzHPMtvIgPhp/wAptP5jDIBsqd2n0CLY33P5OBvspewVQQJ6/VTtWwKUALkmE0wdivxm
         yew8dAbq5iuep5LqtVGo6JBJ25f+uJL91Ir/ixOSlQhOV7mliLFJcYTzneSnzFU739Ks
         zcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750433031; x=1751037831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJwPe4Na7egNR42KB/ME0LulyT8UQ11yNNRgw9O2r5I=;
        b=wwYHwlbAGswDQkVYd1X86gMWlCG2FQrK/VjmcRVvA8qi0EhNbw23FhWzpTgHHZEKED
         ZLsCQwKyX/+KwhA4J7iYiUspwWq1TW9jTJlnE+VqEoFwpR3605byhp93H4AWxcLBEh5N
         JU59KOAHXDygHTSrrkz6PUI/dre/QdLYj11FeIwo2RQ1dvaIhsumfUQsegH0b7UtoKqX
         /QUFGnr8jIC8AyT2qtVPbnvvfeyF2c8YHuUp3piIovM8e0LTZc82HGxb0TpranCwIQpv
         AFMWpnC7DX1BndDTfZ8PUF6jpghdtDP0fCTiR02zkPzoj/DqSrJ9hY/96Q/wkzTcx3aN
         lKYA==
X-Forwarded-Encrypted: i=1; AJvYcCV4tFYVKoHT/aukBT9nRLFjMhjKt4DQizXNkHRXM9gwqIg4+ZqaM/uGruhtqe9VhvRFyYyAtFNSZcx5wBo=@vger.kernel.org, AJvYcCVPXFRYB+bDCgIfhNbzUMBqZ4vTWKckCEVcye61bJWWqayEN3wExqHIhP4QJmLlgOPnnqxONzqNtMX0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qIS4WSDAh0Lu5E37Q4BkRrjBd6KTQ7CaPLY3s8hdv4YWtsLn
	HqVlxM7Atx7pOCDOFXrvnYF/2WdXqix/yTCqrY5tYuOROrW6/Tle3IEHGs/tGbJN
X-Gm-Gg: ASbGncsRtPFWPMDWGy78M9tzbmQn15wjEmuW9Ps2Td3oQiDWr1Rphq6UmkQL3I0jEFh
	gyXNDv5QJtYJp3iITC76PoYS1ucXYnVhmquh8nN4YHco03k0ivrPQXa8JEM+FjfTnTqJ9XhwY7t
	TujSe2rv4b6BS+bdfMPsCr2t0UAkHU6nysd0oL90muEd6GcsY3M4Cf2mc8RTUusy+3Ap98Am7Rt
	GmnDUQnSbQ5eIaSr3z1PVJLk57Ek/oc5dEIB4wixPmC+2Zz3cQNX6TTGloGSwAHAlH+QpcQIkvT
	ZVhAg+OIjesicVBrmba/xsmb36raSjMDlJgo4q8DjBHTjz8U/A==
X-Google-Smtp-Source: AGHT+IHFRRH/nR58cuUa9CJCW89Y1XthgS4quVstWRXVLKvN5X1n1m1ZpPRMW8SNJyW5hNR+qXcUTg==
X-Received: by 2002:a17:90b:54c6:b0:312:dbcd:b94f with SMTP id 98e67ed59e1d1-3159f503790mr4589404a91.11.1750433030516;
        Fri, 20 Jun 2025 08:23:50 -0700 (PDT)
Received: from geday ([2804:7f2:800b:cd3b::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e07d027sm1904055a91.43.2025.06.20.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:23:49 -0700 (PDT)
Date: Fri, 20 Jun 2025 12:23:42 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 4/4] phy: rockchip-pcie: Adjust read mask and write
Message-ID: <aFV8_k4vne-m3Rzh@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <7068a941037eca8ef37cc65e8e08a136c7aac924.1749833987.git.geraldogabriel@gmail.com>
 <d52fce68-d01e-4b92-825f-f7408df2ca18@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52fce68-d01e-4b92-825f-f7408df2ca18@arm.com>

On Fri, Jun 20, 2025 at 03:19:06PM +0100, Robin Murphy wrote:
> On 2025-06-13 6:04 pm, Geraldo Nascimento wrote:
> > Section 17.6.10 of the RK3399 TRM "PCIe PIPE PHY registers Description"
> > defines asynchronous strobe TEST_WRITE which should be enabled then
> > disabled and seems to have been copy-pasted as of current. Adjust it.
> 
> FWIW that's a bit hard to make sense of, given that it bears no relation 
> whatsoever to the naming used in the code :/
> 
> (Not least because the mapping of register fields to phy signals here is 
> really a property of GRF_SOC_CON8 rather than the phy itself)

Hi Robin,

will adjust for a better commit message, thank you.

> 
> > While at it, adjust read mask which should be the same as write mask.
> 
> Which write mask? Certainly not PHY_CFG_WR_MASK... However as this 
> definition is unused since 64cdc0360811 ("phy: rockchip-pcie: remove 
> unused phy_rd_cfg function"), I don't see much point in touching it 
> other than to remove it entirely. If it is the case that only the 
> address field is significant for whatever a "read" operation actually 
> means, well then that's just another job for ADDR_MASK (which I guess is 
> what the open-coded business with PHY_CFG_PLL_LOCK is actually doing...)

Oh, I already had agreed on Bjorn's suggestion to drop PHY_CFG_RD_MASK
for good from code, but I appreciate your input too.

Thanks,
Geraldo Nascimento

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >   drivers/phy/rockchip/phy-rockchip-pcie.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> > index 48bcc7d2b33b..35d2523ee776 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> > @@ -30,9 +30,9 @@
> >   #define PHY_CFG_ADDR_SHIFT    1
> >   #define PHY_CFG_DATA_MASK     0xf
> >   #define PHY_CFG_ADDR_MASK     0x3f
> > -#define PHY_CFG_RD_MASK       0x3ff
> > +#define PHY_CFG_RD_MASK       0x3f
> >   #define PHY_CFG_WR_ENABLE     1
> > -#define PHY_CFG_WR_DISABLE    1
> > +#define PHY_CFG_WR_DISABLE    0
> >   #define PHY_CFG_WR_SHIFT      0
> >   #define PHY_CFG_WR_MASK       1
> >   #define PHY_CFG_PLL_LOCK      0x10
> 

