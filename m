Return-Path: <linux-pci+bounces-11521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB494C9A4
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F50DB23016
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A116C687;
	Fri,  9 Aug 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxYIZ3+C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DE167265
	for <linux-pci@vger.kernel.org>; Fri,  9 Aug 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723181595; cv=none; b=OznMGG7tjXZJfsmcXjljzKr0NH8ActwDV54NYAVavjIKCtggmH3GV/OAgaJHPPPyuieNhNRy6bkGR+Q8oK7P5p7xR9ayz0j2kd128roeenGXqm6ay4k0YSsiQ0Mm5Gh2/y/fXzXoIr0wkRpI5KSucHqwa3mu3E/3kxkfwPLgdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723181595; c=relaxed/simple;
	bh=pnz4pn2aIuI7q35aQCwWQSEhHuiNUdJUQyIwuU/LSLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD0rq8UIM1Ran5nO8beKoPDmNo/X0W+K7JsmPmr+Sg7repejjV5Wi79rftHwLamyO6ayW+S6z4e0a4F6n6DLnlLRB349bOmWTaA8pEA5re9spoQtAKCZh+/WGtdtGjUdxoud4nWSu/I7HqFvbppej5Jp76uCIh1YzxUW4bopkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxYIZ3+C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d18112b60so1118410b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Aug 2024 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723181593; x=1723786393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rpcp7sNOdXCekWfh56WPO6OMCeZXKdG+njZ3Axxp7Y8=;
        b=gxYIZ3+CwZ4w1gVCNA/mqBAaXC53cvrQZGls5BPrVQ45oaK18T8Br91zEat6YzRx3u
         044HV59tJM4kDzTLq7U4AJnNbI0d4PwzF9Uo0sJWobgNA212Y1dyS5Am+bYM0vSE9+kK
         nVRxtmKLz30eodpi4aiFRGhkRGqStsqiDA4o9XQb9j7uZef3VmtN4K1ZJ7jo0Xt2SkYq
         8c+ideIfz46vCdON5S+rMfSUW05L+SpI/AtBB7R0BQijYvcqQqyU4oKasG2oR5EdXeLT
         98mazfh/3ZzwLFDvFu9AJzprpwPfhEjqfZPLolFs7r8e5Z5q0fP2x3fa3PeSNjEJ2ueQ
         azuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723181593; x=1723786393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpcp7sNOdXCekWfh56WPO6OMCeZXKdG+njZ3Axxp7Y8=;
        b=vP2tGnTYMdJ1TnoFX3d+jHEedE+vtE2kfnFFTp2b9o/parEveCv02rFD+LGFmvX5t6
         p18QwtyHViN5tWl54TPaDxtsGmz4PYO8cLXCMQQ8jVoCYXZ3GzRqSWLbiFFIWnjosoOF
         AAu0d7J0X+RAEP29LRAY2adSIEK1zCpPfkBNz8RvsknuorxBKKtZ6RbjPnlNs8K85GdM
         8R1+GWXrh1yhkyVXYGAeNYJXnLJiCWgp0ELId0yEZ1LQO1A89iIlnxDTpl6P6X4f3kWb
         IKpdhjyIK2Q+JvqTSJUKJsZW2NPHVW+7GmTTNEMjB6jrrmC8gSG8WFDfw6GHSDIcMJbQ
         FyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkmo3VhWBYikB256AG2QZz+1kROssiy6fe+9ZLcw9ugGw1ot7P3vUzdrlOR+LJGUMeOiPsIwlg8041CevPcf42Nam7aTCS1KD9
X-Gm-Message-State: AOJu0YyV7WBXfEs0fRkI4cHN9ml7uovsSH6gXRAxCViYsEOs4m7EaDS1
	IXBtt5N315b1CaOXlBjs4dcj9Y3A208BJc94p19ID6uWkCUGPcvwMjskkT34qg==
X-Google-Smtp-Source: AGHT+IHjsR+odVk/XFoa4hO6BfS6oiJfnTEktUyDC4vLxB+lplkufKntidsEa0rknzxBQC+JIgXZTA==
X-Received: by 2002:a05:6a00:b8e:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-710dcd5c457mr847790b3a.7.1723181592792;
        Thu, 08 Aug 2024 22:33:12 -0700 (PDT)
Received: from thinkpad ([117.213.100.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e7416sm1934529b3a.158.2024.08.08.22.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 22:33:12 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:03:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240809053304.GB2826@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad>
 <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
 <20240726115609.GF2628@thinkpad>
 <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
 <20240805164519.GF7274@thinkpad>
 <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>
 <wr2z74wsqhitisgp4qsfrmuvvhw3cpp3bdzkp5batawv6btfyd@xcyhug7jyfxg>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wr2z74wsqhitisgp4qsfrmuvvhw3cpp3bdzkp5batawv6btfyd@xcyhug7jyfxg>

On Thu, Aug 08, 2024 at 03:56:10PM -0500, Andrew Halaney wrote:

[...]

> > There's a lot of history and the interrupt parsing is fragile due to
> > all the "interesting" DT interrupt hierarchies. So while I think it
> > would work, that's just a guess. I'm open to trying it and seeing.
> 
> Would something like this be what you're imagining? If so I can post a
> patch if this patch is a dead end:
> 
>     diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>     index dacea3fc5128..4e4ecaa95599 100644
>     --- a/drivers/pci/of.c
>     +++ b/drivers/pci/of.c
>     @@ -512,6 +512,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>                             if (ppnode == NULL) {
>                                     rc = -EINVAL;
>                                     goto err;
>     +                       } else if (!of_get_property(ppnode, "interrupt-map", NULL)) {
>     +                               /* No interrupt-map on a host bridge means we're done here */
>     +                               rc = -ENOENT;
>     +                               goto err;
>                             }
>                     } else {
>                             /* We found a P2P bridge, check if it has a node */
> 

This is a reasonable change if the parent is the host bridge. But if parent is a
PCI bridge node (note the else condition), then of_irq_parse_raw() will get
called and we will hit the same issue.

IMO, either we need to fix of_irq_parse_raw() or come up with another
implementation that does the right thing i.e., travese upto the host bridge and
check for the 'interrupt-map'. Currently it goes till the top level interrupt
controller.

> I must admit that you being nervous has me being nervous since I'm not all
> that familiar with PCI... but if y'all think this is ok then I'm for it.
> I'm sure I'm not picturing all the cases here so would appreciate
> some scrutiny.
> 
> You still end up with warnings, which kind of sucks, since as I
> understand it the lack of INTx interrupts on this platform is
> *intentional*:
> 
>     [    3.342548] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
>     [    3.346716] pcieport 0000:00:00.0: of_irq_parse_pci: no interrupt-map found, INTx interrupts not available
>     [    3.346721] PCI: OF: of_irq_parse_pci: possibly some PCI slots don't have level triggered interrupts capability
> 

I propose to demote these prints to debug as these are not warnings by any
means.

> You could have a combo of both this patch (to indicate that a specific driver (even further
> limited to a match data based on compatible) doesn't support these) as well as
> the above diff (to improve the message printed in the situation where a driver
> *does* claim to support these interrupts but fails to describe them properly).
> 

Again, I don't think we need to have the change in the driver. DT already
indicated that there is no INTx support, so why should driver duplicate the same
info?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

