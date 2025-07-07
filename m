Return-Path: <linux-pci+bounces-31646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31237AFBE7E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02D07A5869
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC821D3CA;
	Mon,  7 Jul 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOggz5a0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6071373;
	Mon,  7 Jul 2025 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929500; cv=none; b=kGCfz0mpr0AhlwOhL0mbVMi/jzRNQjiibzH9Gnz8SVZyedrZLwxPj4jtqufwtFV9+eqWESEYgFO1NBR6nJlsxom0/VDpj4fdhP/PuDdpVCO33P5bxfLj5MbRBY667Bz++YqaxHVnu7mTsQ3X+2AfGZe7vxz+VsgxOKsEiFhrlQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929500; c=relaxed/simple;
	bh=2HWDfffSof63G+DuZ3lzxxmk0RyHBGuL6LI7jyOBbik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa7cd+LYXaddivbh9ejRXFwN5PEHb4r9ZpZhWk2CRvpwxVV5Cj102IocF8rRd4gmuH3/4FxERnHItVzqH0hEuQAQL7rYkelixVeUXXyV2XNVXtqGFOULK1C+Lvyz0iWWJJW7HMoVnhVvt5p85R6pDltSNp9ghE4XBxlWBEPOaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOggz5a0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a43d2d5569so44189291cf.0;
        Mon, 07 Jul 2025 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751929498; x=1752534298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AgefRmwWFnLKksEjR/mE3fDGyeNnfCLVBN4aw7Do+mU=;
        b=eOggz5a0/mMoqScpjgbY2dapPUKd/0tCQWHkAaxCt6rzQHxlwJxuwNk89oWwYvxgEi
         X4dm8MPmIhvG/SY1EhCYvbvqeHcJfDl21hfkrQngG4DLwuD7OtNRNTceoorR1XJU+HBW
         nU/jP3ZK1teoqNW2RVisfuCIv9IRR1O1G99yn+udvIpVU5Hi5K5yc1yjcKpJoi5+wvYP
         2S0E/Ori1J3SDxId7WF4rswwvpkpO/reyg8Bib6YuuB8DnJDPdKINROnrelAKkAOEEXw
         fpl6Ws2b9w82GGfkLeVIJl01u8KnhZzeABb8Yb5IIDE1pTXm+GITZminyKzEoC0Ih1tP
         tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751929498; x=1752534298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgefRmwWFnLKksEjR/mE3fDGyeNnfCLVBN4aw7Do+mU=;
        b=IWEydWEQp2uYmlVbpQSFXpb8ixpmn74MfE/6LSuc0Pvg0LsqG5sOUOZAVxBFALmKMk
         Jiw/iTGbEYCwyNTbDZLS4UiZ7AWAwlrPzA3aTsCvdbam2l3+qndHAVlB8XOS3qBioNRG
         EIzYNRkecvobH97Mc1HhZYEzt0rN2iAw1yXtfqGVHg4thhMDOhQTjDo1YfsQnTA3dfZ+
         RcNMIw3FHcfAll1Mj/JJn8Z/yczdls4K0EqIElxqt+YTTkv+kLk5x0cjGgm5X6G2ZFv4
         Pj9HXmcuclweY0ZN/vCHlag/zVldCllMdIB7JahyXL7qZrTgV4GyL82IFG/IsOmqqKZy
         +45A==
X-Forwarded-Encrypted: i=1; AJvYcCUwoRqXImFnl6jRPvs4pz/tdrKfjo5v7y6Sibb+B815tGPok1du6HrrRH0VWd8v3kPYGYe+yHq1LM9K@vger.kernel.org, AJvYcCXD424JCccKcoakU9Clh8HOlWnCBpzwkgp+rQgFebncHpAYJgr8aGM7OY9AWM78TKETf6lxZKTkqXCA0V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0N1DGepUzZLzaCvpfKlt6gM2TKztoFZ72Sao74zXYB98g6VOx
	cvs39A8nWTMd4XCBgavoWduOyLRUHUV8HOrRCoxJblaVxvEzvz6saOegR3c0/xbYu0h7Fc3r
X-Gm-Gg: ASbGncvvFgZNTBxku00qs+QUVgEmqwoGViJ2XFYeDFcfn6A45XOTuFR+FGVZrbBmoK0
	kjxE4PKDoxbsj0LsQEVH9gTcnRBoLyDR9a12QGaxpMlm83OOFZD0gk1APZjvpyFtCef29PRkDup
	EBW34waIiUGMYV9uDYx7nniBqXEVK1lCB6C+oaw0fGZ4DiplVEAtm6fnkMnwbnlsz+U88BNyI89
	FJeOCvlO2ddgehkWI6dIGB5AzHrcE1iW7y1C1q7NvNifricG3u7qe+FMcuJl6FH7Q50XTug6KI1
	qRQmKjoW91k1oB2ElxPpW2u/q27Hub+Z1oz+/hrOEOrG1YdOSCUIvpgJr1ij
X-Google-Smtp-Source: AGHT+IEt38/qMtWKaR5SjIM0klOgkEeJMtKfunHHkkfEhSFc7UanZ5qQT5SVRGp91gGzCD3coMx+HA==
X-Received: by 2002:a05:622a:255:b0:4a5:8387:8b9f with SMTP id d75a77b69052e-4a99647dcebmr219861971cf.15.1751929497497;
        Mon, 07 Jul 2025 16:04:57 -0700 (PDT)
Received: from geday ([2804:7f2:800b:a5e6::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949fbe79sm71274421cf.31.2025.07.07.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:04:56 -0700 (PDT)
Date: Mon, 7 Jul 2025 20:04:45 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v9 1/4] PCI: rockchip: Use standard PCIe defines
Message-ID: <aGxSjb17kz2--_Sf@geday>
References: <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
 <20250707222210.GA2114615@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707222210.GA2114615@bhelgaas>

On Mon, Jul 07, 2025 at 05:22:10PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 30, 2025 at 07:24:41PM -0300, Geraldo Nascimento wrote:
> > Current code uses custom-defined register offsets and bitfields for
> > standard PCIe registers. Change to using standard PCIe defines. Since
> > we are now using standard PCIe defines, drop unused custom-defined ones,
> > which are now referenced from offset at added Capabilities Register.
> 
> > @@ -278,10 +278,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
> >  		power = power / 10;
> >  	}
> >  
> > -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
> > -	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
> > -		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
> > -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> > +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
> > +	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
> > +	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
> 
> Added #include <linux/bitfield.h> for this:
> 
>   CC      drivers/pci/controller/pcie-rockchip-host.o
> drivers/pci/controller/pcie-rockchip-host.c: In function ‘rockchip_pcie_set_power_limit’:
> drivers/pci/controller/pcie-rockchip-host.c:272:24: error: implicit declaration of function ‘FIELD_MAX’ [-Werror=implicit-function-declaration]
>   272 |         while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
>       |                        ^~~~~~~~~
> drivers/pci/controller/pcie-rockchip-host.c:282:19: error: implicit declaration of function ‘FIELD_PREP’ [-Werror=implicit-function-declaration]
>   282 |         status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
>       |                   ^~~~~~~~~~
>

Hi Bjorn,

Ugh, what a miss! Thank you for taking care of this!

Geraldo Nascimento

