Return-Path: <linux-pci+bounces-824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04980FA93
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 23:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E348B20E84
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 22:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E26446A2;
	Tue, 12 Dec 2023 22:54:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92BAD;
	Tue, 12 Dec 2023 14:54:29 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5910b21896eso1452165eaf.0;
        Tue, 12 Dec 2023 14:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421668; x=1703026468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5NwUkIFVAwuS2EenXpIdBy2emTYtGW416XNOQPH6X4=;
        b=aTSsP205w7KVb3m610wA0g56QZj6Du+wzFSiM2HSJE2MhywyFYAZ30mc+a1iCGE3d+
         dSRJvRkNPVcjND3z2PxxlQbQgPjFrz08l1RWz5aUMBmonfvrtNhx20/u4IbE0BKjf5jw
         5vYhXqmyMESDxffdX79StZwByy5aj7IrVQh9N+BCqVtK+rPCIsAvefHuCWglz75dPXjA
         yB0flxOKMlL4KTVMDpr/CVe7mEMGwe+N0eBUGqFz3aPi9wak/sWCCR33LGdt0e4dIQVZ
         RnUqfN93U6ulknE5VOmaKlarmZqJ1bSGS5UyATX2XnZeTjiN7/WESsB3umkZr4Si88nL
         hDBw==
X-Gm-Message-State: AOJu0YwFbRko8FDJIxSQ+wYelHG7kzMUDedGC95u2cyaaW4tUslnhF0R
	s4UiC6CkbP6n/L3fsJ8Qpw==
X-Google-Smtp-Source: AGHT+IFzLdaSyhioYEUVyZxgKPKO9o5dwpl0nsUD9DOjNA+IvyXXKGZuJpGQqD2LpMJvNefy/yZI9Q==
X-Received: by 2002:a4a:ae86:0:b0:590:8d58:f70a with SMTP id u6-20020a4aae86000000b005908d58f70amr3603134oon.18.1702421668420;
        Tue, 12 Dec 2023 14:54:28 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a4a7609000000b0058d76e8ce0dsm2688293ooc.36.2023.12.12.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:54:27 -0800 (PST)
Received: (nullmailer pid 2979434 invoked by uid 1000);
	Tue, 12 Dec 2023 22:54:26 -0000
Date: Tue, 12 Dec 2023 16:54:26 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 01/13] PCI: imx6: Simplify clock handling by using
 HAS_CLK_* bitmask
Message-ID: <20231212225426.GB2948988-robh@kernel.org>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-2-Frank.Li@nxp.com>
 <20231212164913.GA21240@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212164913.GA21240@thinkpad>

On Tue, Dec 12, 2023 at 10:19:13PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Dec 11, 2023 at 04:58:30PM -0500, Frank Li wrote:
> > Refactors the clock handling logic in the imx6 PCI driver by adding
> > HAS_CLK_* bitmask define for drvdata::flags . Simplifies the code and makes
> > it more maintainable, as future additions of SOC support will only require
> > straightforward changes. The drvdata::flags and a bitmask ensures a cleaner
> > and more scalable switch-case structure for handling clocks.
> > 
> 
> Is there any necessity to validate each clock in the driver? I mean, can't you
> just rely on devicetree to provide enough clocks for the functioning of the PCIe
> controller?
> 
> If you can rely on devicetree (everyone should in an ideal world), then you can
> just use devm_clk_bulk_get_all() to get all available clocks for the SoC and
> just enable/disable whatever is available.

Or just use the *_get_optional() variants of functions. They return NULL 
such that subsequent calls are just NOPs if the resource is not present. 
Of course, they aren't really optional on any given platform in this 
case, but does that really matter.

There isn't an optional variant for phys, but it can be added.

> 
> This will greatly simplify the code.
> 
> Only downside of this approach is, if the devicetree is not supplying enough
> clocks, then it will be difficult to find why PCIe is not working. But this also
> means that the devicetree is screwed.

A sufficient schema should prevent that... That's what they're for, not 
just torturing people to learn json-schema. :)

Rob

