Return-Path: <linux-pci+bounces-22006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CABA3FC03
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91117A5DB4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED721129A;
	Fri, 21 Feb 2025 16:50:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558C2101AD;
	Fri, 21 Feb 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156640; cv=none; b=oFG5PTixBN5OCDmzzgmnQ00URov+SD3fHu83fDIrukD40+CNJTpsM93JvAR9HCyUGYJnPN/ws5n391PoKfEshYoiVk2MZkgLaKW20a8h7cvja3LEErg5mUOXT6zmBlagR2L6yuFQV94deAjB3IPT4OfTp239PknOt0D/Yhx8X2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156640; c=relaxed/simple;
	bh=8Qa4ZK+UPeBMoFRXK0NogERaRJ8srvnRZA+a9P6JX1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKwKlY2k6kE1Fu6pJvcyFhOyzY977SHATvSrUGAV7qYrE/h+FXrKdbgSTmROTJPFJueUeiQhJ8q1tm1+fgpixXAr0jA46RMCFUaT7hmMeQTAIzo4qUKrgPIiCvJx4QzXvCpB9LQAfz/41MtHZ5VxVO0HOdueZIhTelAR10UY16k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2211cd4463cso48463085ad.2;
        Fri, 21 Feb 2025 08:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156638; x=1740761438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRTsnqJOcW9dv6K1o7IPoOwJKef7SDuchvpYt2J5j+s=;
        b=E4viJ3KWz2zHbonOAnaKzvdvBSAaiZd/IlksyBYKZPDW6izuwVcwy9+0PPc9F36vQI
         DBG8FNTIwSR68uokr0RvU7ymbTXy+wwJ2esvGvZVWCsJRlX4iV5nAeo350FU9znd7yNo
         xzGgVx8BwuzuvtfxURstN/yyZukJLeK1iRukbDSAz1bJkXv0oEWqPl37oR41mwo4/J18
         ebUQhi7TLnbUKCZhblJgHzEG4Mb/ept255NegpsPU8OJC2q5u1dY9BhhPGcHjaLAG0Ft
         gdyY8YgvjEU+SMrvI84jfrQTa+xRXrt0Z9sxsQ+W32sCS44j0o2KR+muntOi9DOsDZ8s
         rhCA==
X-Forwarded-Encrypted: i=1; AJvYcCUOMejDYToas9CDDF7Dj0D4CXgriD8PxiaDyrQEzJnVeP7aiTuxsoxjzN9wjOX1zmI2nL+30QSoZtYy@vger.kernel.org, AJvYcCUvwGyQDrHRi0d57sOya2c+4BKbExVoYgXnac1R0VG/w78XzkZHBin/E/5b5z7b9wRRceszkW6wQqKt@vger.kernel.org, AJvYcCV1lnXXq5/p3Y7dBPFJ4VskhwsaSsixE+ZCWiogiI5zEj9aV/xSgDU8Bu0zsoMH4sWE0NTg92ej9csIJv8T@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8dN+Sm5MUdXWsZo29DbOwNneJXV+nHNdnGD8W2PmooF3yEHc
	nGJweYD4DSmHgMNT500M4yRHiKP34XlXCfL6qfnW0A5T5MUQEcet
X-Gm-Gg: ASbGncvK2alTRYxFu7Qd2PqlSA3pVaYTEEY1nvhgo15BZ6ZcQ+Wu/uBIDWV5mR37Uj2
	aN4l6fgDgWkx9TAmZH6IAMhdqi9DKhbnklAeDqQafd2iam705SEY2BVy9PnE4KgJharGvQK6gCP
	Jmn+88f6trrfrqBeB17Y44mZ73VIaQsY5vdto3ruB3nwCtpbX3GMIufaRbjoim85q5aLWoPdjmP
	c32UpN7c1r2XkLDqBZfEcZKPmZ8q2ZSV+15ZrAjGVWCDRaFRLu5bl+ZkoL5DIB3Z9NSY2NtvyiA
	nwbr2YYFiCZ7E71KHUME/kXfdE5NB68bRJauaXpf3tIvRdlc4P2H72+mktB6
X-Google-Smtp-Source: AGHT+IFBRf1rTI77c48n4yI4p8/OZKA2ivHDEkKmOMpEqskAZG83w/3TIK2ogD7dfLzN3Nx/aKujfw==
X-Received: by 2002:a05:6a20:8426:b0:1ee:ab62:c37 with SMTP id adf61e73a8af0-1eef3c88ae2mr6789123637.11.1740156637946;
        Fri, 21 Feb 2025 08:50:37 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add21f2149fsm12375099a12.1.2025.02.21.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:50:37 -0800 (PST)
Date: Sat, 22 Feb 2025 01:50:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 04/11] PCI: brcmstb: Reuse config structure
Message-ID: <20250221165035.GA3992086@rocinante>
References: <20250120130119.671119-1-svarbanov@suse.de>
 <20250120130119.671119-5-svarbanov@suse.de>
 <CANCKTBsm6o9yaSenj-wft+n0uX-HNRjpJjkZaQcn4t474fXtow@mail.gmail.com>
 <CANCKTBuMOk9ASfPydcKHQgaQF4p7m7ryYezcLPdBEM2ao3LY3g@mail.gmail.com>
 <a2f6ab00-7b51-483e-ad10-0ea7ef9bfd90@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2f6ab00-7b51-483e-ad10-0ea7ef9bfd90@suse.de>

Hello,

> > Sorry for the late notice but I get a compilation error on this commit:
> > 
> > drivers/pci/controller/pcie-brcmstb.c: In function 'brcm_pcie_turn_off':
> > drivers/pci/controller/pcie-brcmstb.c:1492:14: error: 'struct
> > brcm_pcie' has no member named 'bridge_sw_init_set'; did you mean
> > 'bridge_reset'?
> >   ret = pcie->bridge_sw_init_set(pcie, 1);
> >               ^~~~~~~~~~~~~~~~~~
> >               bridge_reset
> > make[5]: *** [scripts/Makefile.build:194:
> > drivers/pci/controller/pcie-brcmstb.o] Error 1
> > 
> > It appears to be fixed with the subsequent commit "PCI: brcmstb: Add
> > bcm2712 support".
> > 
> > Can you please look into this and see if you get the same results?
> 
> Ah, it is my fault. Thanks for spotting this. This must have happened
> when moving this patch earlier in the series.

No worries.  Things happen.  We can fix everything. :)

> Krzystof,
> 
> I could send a new version of the series or the other option could be to
> rework those two patches in controller/brcmstb?

Happy to modify things on the branch directly.  But if it's easier to send
a new version, then feel free.  Either approach would work. :)

> I will post later the fixes here if you choose the second option.

Thank you, sir, for a prompt reply!  Appreciated.

	Krzysztof

