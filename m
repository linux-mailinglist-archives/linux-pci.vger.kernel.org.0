Return-Path: <linux-pci+bounces-24729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0521A71117
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB91896173
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D3E1990D8;
	Wed, 26 Mar 2025 07:08:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E5C8FE;
	Wed, 26 Mar 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972909; cv=none; b=lQ2Q3VlttynLhcUEkXXWRoOt9buhGN35ZzA2eY66COtGD0xRlnpexGN4YIFKHtMyyp7nLDDec2lWi/DsC3bP0a3aDiSZO9F+UMZzOPHDBvfpIxnvpVtyb3YugxIRaEwDt6sfJ7G+6z4BngZfqNWIDiK6SSBNBO/8gs3Ix/uV4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972909; c=relaxed/simple;
	bh=7umMe/owTqkQYNzQvn99o/BkcrVTlBwCps7KAJeuZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmFuJ9WgsIy1Z4x4e4sJH1pLd+pINFEyAlf6QZaBZoe9l44+ZIcrn4MijW/i3t/jFizT1PiSgxT3+H4HQqWI+kl2PNN+aMdEw1TNEz72oYFUpF+9cJYAhNY4+xPp0amZqgOk/phl4tXPyvi8Hz0wWyY3/IHR7GXE2Ts+W9we9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223a7065ff8so74535275ad.0;
        Wed, 26 Mar 2025 00:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742972907; x=1743577707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usze/Hu/f9NyhQihXYEPOZpxjmRJBiCjP4S9p3//eDA=;
        b=bP+ZXSoWioknnbmBlcB3ubm9613K1QbgsVKCRVzrg3lFE8KKby45PCniI63Fdqr+Fb
         WVBpfOZq8hwwYvtYE1xhWNdD4thZrCEVOcAYBoN/REuRxUMAzeA2rTLgnB4pBBi2KSxc
         yZ8FRzHQpH+k1R455aCTXwwtaEG3mNGII2WV5FZusssbFXylCfApy1BZJZ6z5Vf8slWz
         WTX9mh0ms6HlRbD1ewzibZh2vdAqJGlZidat4zGKtMVA0ott42nUJiwvNbOfpJXYiZXH
         k0FqQdlQqJrWexHg1baXTEPMlN++RbpEYCiQqFkv+Vr7HkGvfqLPfQL5izhpnvpcsYxB
         d2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUPPscDKY3vEAP8Mcr9yC6oVgEu17+5c6CqQQLdKxLUA5g/znpTrvkGgRPzwHYuh7IwM1s3eP1/OsM6+w==@vger.kernel.org, AJvYcCWBgyA6jQ3X/LN3+aea/CrUKLfiuuMz1g99xSODVwu7pQJd5UVWB1mUvszAqaWo24kSSh+xpDZa@vger.kernel.org, AJvYcCX/6Q8gQYeiPZS2GrC8bDEPkyjisfKCURtA7PxAUhC35MzSwoFTWtUYWgabRQniuKbRU2TXRs2XrJpx@vger.kernel.org, AJvYcCXcZOVvQF6AF0hDWKgJ3CUpWbH4GZV2JoY/3EGOvBEpnz3Vf1SfktOZ9n7fjcpmNC1FBwwBSb505lsRi8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5Ch70/G1ah3B5V0cCdNGHkEZzj2WGYSnu9zyu8B/Dbt0zqfv
	yvqzhovQr2R84hnHPmBFiwOdWTwe2/yyHJo/8PzVd8a9vv22HoOjJoyIuenT
X-Gm-Gg: ASbGncv7BX7Ug600WmNxEJwsmZB8WbkQs7Q9NpRKt73Gl+b4QrUQDJfhcy0aftL/qBe
	9pxuNXBdOFGAdqeUR4jT16avpw2BZBBahGYN8ym/foXwuha2phoRh90citBHMXrppZkN+OrEJWm
	Y5qHjEiDpY5pmb+d0Do/d7AOeX7uplVZF0crJ7fyawx2J0YcHZwADEacpwdswMZVXWRgl1M3HJS
	sSv4DJTp/tGmFKfzLH7AjVqyom46teiMQOJoL/1AR5J+M49vXqysB2aGd0dcYM7OPGuR0oJam71
	jhixC/JGkVI/xD7s0qaYBIsUK2ZEqtu5o+iE+PJtSzEO7a9yBrjzlkS9EKog0dcqKEwkg0GZFLr
	VUcc=
X-Google-Smtp-Source: AGHT+IGyEsepOSz9UoNKc7Y22NXljw4tUhAHspFeSHM2qES1d+egW2qdQZ6cpo8lCD4d3eJlrT4aQQ==
X-Received: by 2002:a17:902:e54a:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22780c79888mr292422165ad.15.1742972906946;
        Wed, 26 Mar 2025 00:08:26 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f50c80sm102359315ad.104.2025.03.26.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:08:26 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:08:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
	vigneshr@ti.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250326070825.GD2822343@rocinante>
References: <20250313055519.j3bpvsm6govd5ytk@uda0492258>
 <20250313160215.GA736346@bhelgaas>
 <20250314041705.v5j2fjulol5ywvyq@uda0492258>
 <20250326065447.GC2822343@rocinante>
 <20250326070124.boluxjcid4ouszqk@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326070124.boluxjcid4ouszqk@uda0492258>

Hello,

[...]
> > > > So I guess without this patch, we incorrectly ignore link-down
> > > > interrupts on J784S4.  It's good to have a one-sentence motivation
> > > > like that somewhere in the commit log that we can pull out and include
> > > > in the merge commit log and the pull request.
> > > 
> > > Yes, we can prepend the following to the existing commit message:
> > > "Link down interrupts on J784S4 SoC are missed because..."
> > > 
> > > resulting in the following updated paragraph in the commit message:
> > > Link down interrupts on J784S4 SoC are missed because commit under Fixes
> > > assigned the value of 'linkdown_irq_regfield' for the....
> > 
> > How does this look like?
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/j721e&id=b97b5b8cb603a4ba6b3f7f1b6065fa76e69bdb56
> > 
> > Let me know if you want any changes.
> 
> I will suggest minor changes to the first paragraph of the commit
> message resulting in the following paragraph:
> 
> Commit under Fixes assigned the value of .linkdown_irq_regfield for the
> J784S4 SoC as the "LINK_DOWN" macro corresponding to BIT(1), and as a
> result, the Link Down interrupts on J784S4 SoC are missed.

OK.  Updated.  We are going to meet there half-way. :)

Thank you!

	Krzysztof

