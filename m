Return-Path: <linux-pci+bounces-28993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2DACE3AA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850441894DC0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A118C02E;
	Wed,  4 Jun 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzhMZbfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258481AC8
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058275; cv=none; b=sMpwZ5zoncKk5ZIUzgc9hVwDOJGRiw1152LCq1g1KeqDSJQPsDoy8pHQAJHV3HpIqTLhmCO2dWx3lFFWJCy0b+R4vVZ3+HvYtvaQAvygSn7LLe7at8iuPgRQ60bp6w2smVjPnuHwu4w2wDb9BcUeXCu8Rl4kL0rWUoybqmwfErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058275; c=relaxed/simple;
	bh=q3sM5ckkqu3S1pmAwhJML99ONUvr7j4/sHrWjEGrst4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1N8lHD+gzbyn2hkQbdfjO6ZWH/6oTzQN3/uWgmo3p8eQSjWGpD0XaEslk3s93aE9EEPFJKJKyENAW+YTtwn8UbAoxByNQf4c789hc5f8JKca928RXhm63BojwRWOJTAW0GhUhpRBq7YHZ9i++rYFT+Ru10mg8DwSpfTShAGCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzhMZbfn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e1d4cba0so927345ad.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749058273; x=1749663073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xOObWxm0mCeJEpZwglb2CEVZr9rm6jEf/VR9UY9bUP8=;
        b=JzhMZbfnuYM+p039M/njIQ0ic2qUG/QZfO9DZZS7yP0TmyXg7knaNKGmUC11M4ZWMM
         iMb7psbuW29PNZR2Ekai5Y4wLJ3qCjI2dDD/i5IR5PknNt3uW7wRk4cu/GXz/Uxbm01k
         qK8QW0dKDejMbE1/FUNJmTDcEInqhO0unPHfkjvILPAwL2ktLpvxhQekeRSulqKWAzaO
         1dyKiQk1ah5ULVN6LhGsQdFpX+Gn0arGYCCSfaevyO4W1NFUARfD3GR+1mgoVNFRLOeO
         7sQWg6dJjTGI54eFoo1aZSp5zGMa93ZgA0eDnGTcl+Us/FZo0evtpcGY+oRQLVllNXD6
         M1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058273; x=1749663073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOObWxm0mCeJEpZwglb2CEVZr9rm6jEf/VR9UY9bUP8=;
        b=e8yrQKQQpFW8dqgF9xS0ofaNSc4cyJl1mWZMHxQrrhnM+sQ8RL8vfmNj92eq86XnQI
         dmIHWh5otWhO5Exm2IWKK2M1NHZ/6N/yyNUhNci6sn1uzlnYSo1eh2+tfXb+Nf5BUGkb
         u4stc3T4Gl6jywldnc+gd5j4JDY9gE/ll/2ew6tD1jqD34h/aVaWzqY2hKN71KOZwHeZ
         60jPJAKAc7yW6/P6eAhKFw4N7MYymhk77RXV7S7ufajPggba+qtFLr+L8exXfpROM4eI
         2cjVdyNTkAz05GRzp3Ma/IthbSwGN+/TCkLCmWuAalkLO6Ghue8+myp35UW97V8guED1
         jM2g==
X-Forwarded-Encrypted: i=1; AJvYcCVWw8if0q4Ww0PJlBUTf8BnOSSpHQ/NPyLsp3Tr3heSeOSd4eTiuW6a8fxr8VX34/cyKyRKk3ryLpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SiHrJfHuA5UR1jmDYeBd3AB7jaV9fbBBpx6CaXjKGYkCR8ts
	I321xBTpm0bZNt/7ECQeVQfKQES1crjvBL2bI+rxyPRbuLT0t5yEO0Yh6AWaAFbvTQ==
X-Gm-Gg: ASbGncuutJUmVFsWMq15xTarRIstNgjWpfBkRqnBCeK2x0XH5TZ9B0M0XOrMwonavTJ
	pVm3J4SpQ6FT6isVWIJo9A/CKyFdWNXhe3OIVY5teyVVgLUC3JlPpYU0PKjHXIkWvZOmm3IO9+K
	30YOF3oeEcJq6ZGtG3N/Gv0JlMKTA11TzzImcNbwP0t6ATydL+Goxp+Uob99a7SCmj1Ff+z9/e8
	oPiEfiKJxN02Qud3kqKVkLpkGzfIxyoo9Cg4g6Hu+wTuUb4zRJ3uuzQl3B/wmCCV5o+h6Irt45G
	V+CVYJxQ6rHdq66RfG8fZihHmcxa25n0jygqpSPymkuXI5TwaWN6gN8Qv/DGzg==
X-Google-Smtp-Source: AGHT+IGIJbSx2qDc2q2Gt3qbCZCgqmWW4FPwxtFTdbgDTBwo3IdO7XqHuYRl/uF5BzOmzUrf40UoSQ==
X-Received: by 2002:a17:903:1c9:b0:235:6e7:8df2 with SMTP id d9443c01a7336-235e11fcb67mr57141715ad.41.1749058273586;
        Wed, 04 Jun 2025 10:31:13 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf50c9sm106668185ad.162.2025.06.04.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:31:13 -0700 (PDT)
Date: Wed, 4 Jun 2025 23:01:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r8a779g3: Describe split
 PCIe clock on V4H Sparrow Hawk
Message-ID: <egtsvxsfc5c2s4hrwucsqk3s5dv7xsi6ghrnf6jd3mvf3zvskb@z7hvehbd33t5>
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
 <20250530225504.55042-3-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUVYzaUyP=OUOST8SK66_BpubOh0WCXcaVWBy=RxBrquA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUVYzaUyP=OUOST8SK66_BpubOh0WCXcaVWBy=RxBrquA@mail.gmail.com>

On Wed, Jun 04, 2025 at 11:24:17AM +0200, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sat, 31 May 2025 at 00:55, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > The V4H Sparrow Hawk board supplies PCIe controller input clock and PCIe
> > bus clock from separate outputs of Renesas 9FGV0441 clock generator chip.
> > Describe this split bus configuration in the board DT. The topology looks
> > as follows:
> >
> >  ____________                    _____________
> > | R-Car PCIe |                  | PCIe device |
> > |            |                  |             |
> > |    PCIe RX<|==================|>PCIe TX     |
> > |    PCIe TX<|==================|>PCIe RX     |
> > |            |                  |             |
> > |   PCIe CLK<|======..  ..======|>PCIe CLK    |
> > '------------'      ||  ||      '-------------'
> >                     ||  ||
> >  ____________       ||  ||
> > |  9FGV0441  |      ||  ||
> > |            |      ||  ||
> > |   CLK DIF0<|======''  ||
> > |   CLK DIF1<|==========''
> > |   CLK DIF2<|
> > |   CLK DIF3<|
> > '------------'
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Thanks for your patch!
> 
> > V2: Use pciec0_rp/pciec1_rp phandles to refer to root port moved to core r8a779g0.dtsi
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I understand this has a hard dependency on [PATCH v2 1/3] (and on
> enabling CONFIG_PCI_PWRCTRL_SLOT), so I cannot apply this before that
> patch is upstream?
> 

TBH, this patch is describing the binding properly. So even though the driver
change is necessary to make the device functional, I don't see it as a hard
dependency. But since people care about functionality, if both driver and DTS
changes go into the same release, it should be fine IMO.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

