Return-Path: <linux-pci+bounces-921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945C8124A0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198AC282676
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 01:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFF63D;
	Thu, 14 Dec 2023 01:33:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C0F4;
	Wed, 13 Dec 2023 17:33:20 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so116676b3a.0;
        Wed, 13 Dec 2023 17:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517599; x=1703122399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTDqfs/xpXbeTqhhiS0RXQWRiBAFOfATWckEZsTas7k=;
        b=mLmFZrSp8bGK4osXFo3/XVFm/PtQgpqG66bgtEfVEmDa9Tw+0zjm80U+Dv4r6JVHBV
         BxSGDAUs+naRRFN0Fi6JP7LMyVl29VvLonJkeeglo+alBp8/EOxv9z6NgPj7WPIMGsE6
         QOlOgC2I8G/mW27GoQpN9KB8bbkGmWoATOhBCMHptpS4cSN+nbM8UCgZPSoaVXEzBJx6
         rN4fw2FctJHHEgSF9vSTtSlMhRJ+NBhN9s5ACX+hK8gql7LTmGVR6e1W5SUmEooQtR2Z
         cMH9P4HCH0ekQ8kJ5DUyvLNGvyP6+fil5/SthIgyBOcdu+XKnMNqri2nuCxkJB0MIx6a
         QYOA==
X-Gm-Message-State: AOJu0YybmiKOSjMcVZR4KWmD38qHZe8FJGam1hf73prxiZwOz8B+tEAr
	9FErFkRregbMkOOUnR6i49Y=
X-Google-Smtp-Source: AGHT+IGAIN9gY4DiS0U84Eu9n8KQJC8+FtTi/0mWx/rE/bLHHnUHj+tFBkH+GnNJV6exxFjVLVUDEg==
X-Received: by 2002:a05:6a00:310d:b0:6ce:f62c:dc66 with SMTP id bi13-20020a056a00310d00b006cef62cdc66mr7341604pfb.30.1702517599451;
        Wed, 13 Dec 2023 17:33:19 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a0023cc00b006cde2889213sm11002760pfc.14.2023.12.13.17.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:33:18 -0800 (PST)
Date: Thu, 14 Dec 2023 10:33:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Rob Herring <robh@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: rcar-gen4: Replace of_device.h with explicit of.h
 include
Message-ID: <20231214013316.GA1462914@rocinante>
References: <20231207165251.2855783-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207165251.2855783-1-robh@kernel.org>

Hello,

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.

Applied to controller/rcar, thank you!

[1/1] PCI: rcar-gen4: Replace of_device.h with explicit of.h include
      https://git.kernel.org/pci/pci/c/263714f5fcf8

	Krzysztof

