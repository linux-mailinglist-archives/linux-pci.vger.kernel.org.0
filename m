Return-Path: <linux-pci+bounces-1009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662B813AA5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA991F216AC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AFA69795;
	Thu, 14 Dec 2023 19:22:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CD6978C;
	Thu, 14 Dec 2023 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so306268a12.0;
        Thu, 14 Dec 2023 11:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581756; x=1703186556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZivT5uacU+xOHWiCIt8oRdGqidGMJvFHmm2wETKK50=;
        b=JX7M9f2HbdoEYOGOxQDDw7ju8qmxBefyY06eAFiFriGIh3WXGPmKmz0fBFXw/Q/osa
         n33wq5+dFHRXs8tS/omr7m+Kw83OgPvmFJkYOUaSkBOdLOoZHo1x6K+qG2CYnpcUH9fd
         ZsU+UEAD3cPmGz4RAcOi7OkUKeXEzTPdv4BVF08IFnQvCNe4PuIcSVy22s0eeWmftAuE
         Ettmh5W4AU9+gIRvl2uOkzciVFXzFfyV3NWW6KPm7hmNw8i0lYGs8oG8O4Q24C8sr4jK
         vZMApYKIrDv3HBdUP9XBo6kyu+shgejhoeris0fyKM/W47KngtWk1azQNZ1zP/AQL7yI
         blaw==
X-Gm-Message-State: AOJu0YycQvN3B6BVVLbHctc97zRP0Y33ROCgLmV//PpCK96Njj7JnwfF
	V4xL4BZmYMsJyTtaSfOfdew=
X-Google-Smtp-Source: AGHT+IHmh1Bcu1oBb6OQh05N+VMiYP3JbB7nRH3l2TaV79NN+yEElf9ysJ2DsldOt+ChSCF2kVwTag==
X-Received: by 2002:a17:902:654a:b0:1d3:5b35:543a with SMTP id d10-20020a170902654a00b001d35b35543amr2401248pln.109.1702581756035;
        Thu, 14 Dec 2023 11:22:36 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001d0b3c4f5fbsm12830736pld.63.2023.12.14.11.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:22:35 -0800 (PST)
Date: Fri, 15 Dec 2023 04:22:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Rob Herring <robh@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: rcar-gen4: Replace of_device.h with explicit of.h
 include
Message-ID: <20231214192234.GC2079458@rocinante>
References: <20231207165251.2855783-1-robh@kernel.org>
 <20231214013316.GA1462914@rocinante>
 <TYBPR01MB53415F2C51CB51A0ADFBD278D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB53415F2C51CB51A0ADFBD278D88CA@TYBPR01MB5341.jpnprd01.prod.outlook.com>

Hello,

> > > The DT of_device.h and of_platform.h date back to the separate
> > > of_platform_bus_type before it was merged into the regular platform bus.
> > > As part of that merge prepping Arm DT support 13 years ago, they
> > > "temporarily" include each other. They also include platform_device.h
> > > and of.h. As a result, there's a pretty much random mix of those include
> > > files used throughout the tree. In order to detangle these headers and
> > > replace the implicit includes with struct declarations, users need to
> > > explicitly include the correct includes.
> > 
> > Applied to controller/rcar, thank you!
> > 
> > [1/1] PCI: rcar-gen4: Replace of_device.h with explicit of.h include
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=263714f5fcf8
> 
> Thank you! I completely overlooked this patch. Maybe it's too late, but I also reviewed this patch, so
> 
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> It's up to you whether my tag is added to the commit or not :)

No worries.  Never too late for a good review. :)

As such, I added your Reviewed-by, so it should be there, per:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar&id=ec215237480478ca5523ea12f58803d9b7a8a0ea

	Krzysztof

