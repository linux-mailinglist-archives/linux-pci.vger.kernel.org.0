Return-Path: <linux-pci+bounces-27374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BBAAE2B4
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82C898773C
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0A288C31;
	Wed,  7 May 2025 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RW72+a1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011928A1DC
	for <linux-pci@vger.kernel.org>; Wed,  7 May 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627122; cv=none; b=gL3Ml/YiGKvBlB/Kcx1e+ao6RobxgRYJvWKQYqXxb7wcrkMX1qr0oHhkeh04odhaZWnCH28tTbN/JmYfD0thsVt3+0l6rxK4f6kLq62BhuKp/Zxe3oZcpAJsx4O9tEAlBGz/xsuf0nzf5dbZDIlaWUYT9ytPsh39KHctGZGETgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627122; c=relaxed/simple;
	bh=WyCz/ArAVmQO+g1cZbQC9HYihMwNLT5tXWBdJxpyI3o=;
	h=From:Date:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGMcdiY3syRMJzIpEOsvZy/OfVj/yOvQfu0ivE99SwwRBwSQ8XRmSJA+Slnb2zFvSzhkZRd9ja7a214RL1jleFyCfk2jTcMUg/julp66ctjQT5P2m3QCJln03NReUlEE6Wa0a9LMBxacBJYSZD1vunKkqxlr0d7tEb7sULDjW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RW72+a1q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fbeadf2275so1755937a12.2
        for <linux-pci@vger.kernel.org>; Wed, 07 May 2025 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746627117; x=1747231917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp53MoIMHo7AsEpO8Qe4lYIdt8fxx6H0xofmt5rFOgc=;
        b=RW72+a1qzFrEk8+0g5TjeMhM3Seef2Ya9K9OUP1ZZ0+9GQUAM6+XEp3Lry/LNcW1la
         tL2hdZ5FcbCJlJ6OIdHxsXbVs3RcJI5IKfLczh+qAEOfivvlCl5iFIAJTU0t6vxp8Oz6
         /ywZV3oxlC/LPAQP3cSkJkdrEy/qIeW/ESNhnfNnxv71sHdR3cNZ5cIFwLZ9bXuBMGLZ
         5LwjGDLUIbwQSrnfprunfLqdRiDCWUil/m74yw+WGTHD0GUa4Ht0qIsPB/NUL9BFMIH+
         cFIW/+KXbYJoK4LU98SrKGAsJsuMI70r3ps2K7y4LHIwyqTXX0OWEQiB1v6WRgEHo6c1
         mdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627117; x=1747231917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp53MoIMHo7AsEpO8Qe4lYIdt8fxx6H0xofmt5rFOgc=;
        b=BCuKkIe7SnrP79oKX0eZc+K/tngr+sZPagfgsy42OEdZ2bIk+z4dP3WpX3kAVAG45p
         8rQDhmU6OO2YuhdWbQEYQWvF0ZJw5L8kXg3dY+vPDvxHQLOR7alf5Kgyun3HO09VQzAs
         7FiyEBNib6OqmGhd9UNU9u/IqeAgPvpYuDoSUtxMzwokmyeqAODoq3fS+JsCb3D4ALxX
         QHWj4U8iAhLJfrOAue8elnOFxFkE67bQbzJLfsWuFJ7kxTGjAwaCvqCikEuPfRin3YlZ
         uatzmXT9XEyS9Cnv+XzxqRkhvok2KNIOuzVRbMhQJEJe6HK5n1Or0zviL/BDYw40jBNQ
         HvnA==
X-Forwarded-Encrypted: i=1; AJvYcCXpjX3NbFjiGrLhsQdDwCWv4H4RALVY7AwISe8QC1qFO8MQ8Fxqb6pcSWyQmbK6nq90wk6mMoXjBj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALxYAsmF3DZA6cDivgrXJW4+XKLGwcm6tWkYEIAPqy/2WyJkU
	Aa5nLXiY2VUEsljuGvHEoBiNYnC11y1V+AkimhGEJubcyDNBvUJo/h4mCaMVF18=
X-Gm-Gg: ASbGncu0HC+YaDJfE8zKgRJuBeYgpJn3s7TDBWE0UJeVuDUbPXnwJ1tLoskOOrOzpSy
	2Sx6IyAWj5bYvhZFuqJ/Ig2hsVTLFY6sbkvUk7TyUZe6vaVf+3oTRbt4byntxomlbicqxZAJF3e
	YDp55GWPgbfilZbn1cHgLGL0/huTkyAJayHydRionjARdFaD1nrzxF845SuLkrMaRuxSwIX907/
	B2bmIkwWb9M8ogA1ajPHm4zxsEJyVGpIJa/q5gM+f7D2F9FYcwFxnc9QvZgGPegjejoq9lQyNHn
	6ZoSR8jCwlzXqWc7D8OziiZXquEzmsMw1zAB6RSd8XpduLWHSgewng6g7UTFwFAid7iKjA08tLg
	mlBgqGA==
X-Google-Smtp-Source: AGHT+IEAIOFFJLOZCm96czkAy45BL7wcAh0Bc4vKalFIoRDdZw1taF3C6vTBolVNjObPDoUwRAM9aw==
X-Received: by 2002:a05:6402:5c9:b0:5e7:8501:8c86 with SMTP id 4fb4d7f45d1cf-5fbe9f46ef0mr2916040a12.22.1746627117121;
        Wed, 07 May 2025 07:11:57 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbf761f95esm806596a12.63.2025.05.07.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:11:56 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 7 May 2025 16:13:24 +0200
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v9 -next 08/12] arm64: dts: bcm2712: Add external clock
 for RP1 chipset on Rpi5
Message-ID: <aBtqhCc-huQ8GzyK@apocalypse>
References: <cover.1745347417.git.andrea.porta@suse.com>
 <38514415df9c174be49e72b88410d56c8de586c5.1745347417.git.andrea.porta@suse.com>
 <aBp1wye0L7swfe1H@apocalypse>
 <96272e42-855c-4acc-ac18-1ae9c5d4617f@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96272e42-855c-4acc-ac18-1ae9c5d4617f@broadcom.com>

Hi Florian

On 09:32 Wed 07 May     , Florian Fainelli wrote:
> 
> 
> On 5/6/2025 10:49 PM, Andrea della Porta wrote:
> > Hi Florian,
> > 
> > On 20:53 Tue 22 Apr     , Andrea della Porta wrote:
> > > The RP1 found on Raspberry Pi 5 board needs an external crystal at 50MHz.
> > > Add clk_rp1_xosc node to provide that.
> > > 
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > 
> > A gentle reminder for patches 8 through 12 of this series, which I guess
> > would ideally be taken by you. Since the merge window is approaching, do
> > you think it's feasible to iterate a second pull request to Arnd with my
> > patches too?
> > 
> > With respect to your devicetree/next branch, my patches have the following
> > conflicts:
> > 
> > PATCH 9:
> > - arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts: &pcie1 and &pcie2
> >    reference at the end, my patch was rebased on linux-next which has them
> >    while your devicetree branch has not. This is trivial to fix too.
> > 
> > PATCH 9 and 10:
> > - arch/arm64/boot/dts/broadcom/Makefile on your branch has a line recently
> >    added by Stefan's latest patch for RPi2. The fix is trivial.
> > 
> > PATCH 11 and 12:
> > - arch/arm64/configs/defconfig: just a couple of fuzz lines.
> > 
> > Please let me know if I should resend those patches adjusted for your tree.
> 
> Yes please resend them today or tomorrow so I can send them the following
> day. Thanks

Sorry, what's the best wasy to provide the updated patch 8 to 12 to you? 

1) Resend the entire patchset (V10) with relevant patches updated
2) Send only updated patches 8 through 12 (maybe as an entirely new patchset with
   only those specific patches)
3) Asking you to pull teh relevant commit from my own git repo

Many thanks,
Andrea


> -- 
> Florian
> 

