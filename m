Return-Path: <linux-pci+bounces-26033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B6A90A51
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 19:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB067A41BB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E331C27;
	Wed, 16 Apr 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="INIiMUlm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC921771A
	for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825316; cv=none; b=DbWzNpOQjog+FyHg8Wk7FBbrMvHOfT07TwpOU5G1GaJncJN0IORJm4F9PeygqI/zvWtKnrojuHKtwSl6Sxohd9z1kZmgsxzbPXQP7LLyKW6RDzndYpIcwlwYPhmkyIKsdt6HECVFN7HFlmYZspXInwvtJTtXtIEmym8Z6GoFutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825316; c=relaxed/simple;
	bh=W7bBtLlluteHP/1dAH+Ya9l7v9aR1LVZvIfTf+Z30DM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLqRsTNsLWkxdXLUSJBDllfxIzaSedIA20IwpW+4sDhSo30mrUrN29gdzad+CCY8i0AcjNqby56I7xiIl/qhxLMKt0Fqxb7VDUpnkJpX1Dc+avDIQQmo+RQ+gmMO/zd+nmuXjQjLvSXgPVTjbVyzy0+KK7wUvgld1kcSlh6phvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=INIiMUlm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac297cbe017so192255566b.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744825312; x=1745430112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/+k1VaPPfC6JjSP1qAD5erxrr3Ql1dchYoION8KrN4=;
        b=INIiMUlmJ16tGuQVFvdcInPU6DmNXr6/gZ3TDNQYNZyfPLyYsAZ6uurwWn+a/23ZF+
         mSctnYE022rQOVZmUfG09MDSJvraPebPxuar3yb72otY6H1gBxmogVJ1W/zwiKQo+j5+
         m4v8CyDvTfY+oSmHpSb9CfoBrH629D6U/27hrPrtGWoyta9raQXVbEBIdVAiOABvdm87
         0zTU0hpSm/CoCDis6b9J3OoDmj0BY7EsrYFwDREd/1oBT/dq7gZ+ZbX+BkPXezPR9PTa
         igWPjF/Ky1UmyVu1wPICDR+6cxvPjLMmnQbQRU3cq5Cp/aYWcJezuVFZtwv1VlwQfVkm
         CBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744825312; x=1745430112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/+k1VaPPfC6JjSP1qAD5erxrr3Ql1dchYoION8KrN4=;
        b=Qi+v4bA9ITBY31FPm0iwC9jUXiGG8WXaa40WyxOffKJv1FUEREsZkcowJZBHSV9ecK
         +dlIojiDhrjINVSyndR6Fpr+rVSY7w82lge3Hyj0Ryq81nuXbwOo/3hABDTTEJLllbar
         BG/Rd4wxWrJKH+JWT8TVwhsnUU46Hfdy+7FAaXwkiymJlTHivBR2c4XzXuzJ2Ib9y99J
         ZOXecveqJ75DvpVqPQFn8yNpl0Q+pG7pkXF3qXMmXNw0bltT7aU6ITpI5t0vPGT9oMwb
         NfZCkVPq8mQpB/A1WeTHqaM/oGkf3G0cB2CxGChsutZYFUAJfcmjDZSbXNlLB1mZNrbm
         UR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRwQFD9QNnKhIoSq66ToiWFV+AMJjSVmTk8n1S63MWBYCYK06YqskQCjCdCYwueV64YjV7fhYflW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BRxHV57n8d0wemURaWm+2lymJ2qFp9rc72O2Ai20bpAKm1ew
	/4bvPt5jzumoqRWg2qhmxV0VMKr3Ug1SsZBae9nIJuFSGsUtuNwVMgZGk7C3/AY=
X-Gm-Gg: ASbGnct2AYmXA/vCqak1KkIsRtEkSk9AEuRZG9wCnBBA3nSOJmJs94jV/UmAsHCqzxd
	C2Wl4FkN/hxMUHz2fdCwCdTu73asQwQgTrrTgdk5/MJ/MOGKeDYC5nFjZC9v0uk1cP9XjQdcGrS
	3UmqTS+N0P18FjUwFNGDvDHvIHM30cfA5NYrcxiJvLJlE9ZBwi/rSEM94C/7nqYVOak/QrUrEcr
	52jOWIRpcOq8ynv3rxXlYoasOTV91xOYcdCOgVW1G00ZSg1XZZunICUFmS6bfaB1a447kskrfof
	lfptfvBIgkR+KwUjSiW8zW8hyi+VDAXmeinf+jDiZdAdlrHMBENrQ2O3gWJaIcUyUn9VFcI=
X-Google-Smtp-Source: AGHT+IG7VChiUUBXbPZt2UsOsnvfmMZv1kTPdmKDqxu0K/iyE0OKTXPbM6G10YQaE7vDg/k0DkFp+g==
X-Received: by 2002:a17:907:1b2a:b0:ac7:b1eb:8283 with SMTP id a640c23a62f3a-acb5220ab4dmr51498666b.17.1744825311718;
        Wed, 16 Apr 2025 10:41:51 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d1ce081sm159581866b.154.2025.04.16.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:41:51 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 16 Apr 2025 19:43:14 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 09/13] arm64: dts: Add board DTS for Rpi5 which
 includes RP1 node
Message-ID: <Z__sMg-RJ6B-3OL4@apocalypse>
References: <cover.1742418429.git.andrea.porta@suse.com>
 <c6498d8cf8dfade1980b566e99a9a91551fd8b53.1742418429.git.andrea.porta@suse.com>
 <526751d2-c7e8-4097-9454-c9049b880225@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526751d2-c7e8-4097-9454-c9049b880225@gmx.net>

Hi Stefan,

On 13:48 Mon 14 Apr     , Stefan Wahren wrote:
> Hi Andrea,
> 
> Am 19.03.25 um 22:52 schrieb Andrea della Porta:
> > Add the board 'monolithic' DTS for RaspberryPi 5 which includes
> > the RP1 node definition.  The inclusion treeis as follow (the
> > arrow points to the includer):
> > 
> > rp1-common.dtsi ----> rp1-nexus.dtsi ----> bcm2712-rpi-5-b-monolithic.dts
> >                                                 ^
> >                                                 |
> >                                             bcm2712-rpi-5-b.dts
> sorry for the delay. I'm not happy with the monolithic appendix.
> 
> How about bcm2712-rpi-5-b-rp1.dts or something more self-explaining?Regards

Sure, good catch. I'd go even further saying that we can rename (or merge if
the destination file already exists) as:

bcm2712-rpi-5-b.dts             ->  bcm2712-rpi-5-b-norp1.dts (or some better suffix other than -norp1)
bcm2712-rpi-5-b-monolithic.dts  ->  bcm2712-rpi-5-b.dts

so the monolithic one, which seems to be the 'safest' option as of now,
would be the default dtb. Do you think it could be ok?

> > This is designed to maximize the compatibility with downstream DT
> > while ensuring that a fully defined DT (one which includes the RP1
> > node as opposed to load it from overlay at runtime) is present
> > since early boot stage.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> > Right now bcm2712-rpi-5-b.dts is the overlay-ready DT which will make
> > the RP1 driver to load the RP1 dtb overlay at runtime, while
> > bcm2712-rpi-5-b-monolithic.dts is the fully defined one (i.e. it
> > already contains RP1 node, so no overlay is loaded nor needed).
> > Depending on which one we want to be considered the default, we can
> > swap the file names to align with downstream naming convention that
> > has only the fully defined DT called bcm2712-rpi-5-b.dts.
> Could you please move some of this good explanation into this dts file as
> comment?

Sure.

Thanks,
Andrea

> > ---
> >   arch/arm64/boot/dts/broadcom/Makefile                     | 1 +
> >   .../boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts      | 8 ++++++++
> >   2 files changed, 9 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts
> > 
> > diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> > index 3d0efb93b06d..4836c6da5bee 100644
> > --- a/arch/arm64/boot/dts/broadcom/Makefile
> > +++ b/arch/arm64/boot/dts/broadcom/Makefile
> > @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
> >   			      bcm2711-rpi-4-b.dtb \
> >   			      bcm2711-rpi-cm4-io.dtb \
> >   			      bcm2712-rpi-5-b.dtb \
> > +			      bcm2712-rpi-5-b-monolithic.dtb \
> >   			      bcm2712-d-rpi-5-b.dtb \
> >   			      bcm2837-rpi-3-a-plus.dtb \
> >   			      bcm2837-rpi-3-b.dtb \
> > diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts
> > new file mode 100644
> > index 000000000000..3aeee678b0bc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/dts-v1/;
> > +
> > +#include "bcm2712-rpi-5-b.dts"
> > +
> > +&pcie2 {
> > +	#include "rp1-nexus.dtsi"
> > +};
> 

