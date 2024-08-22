Return-Path: <linux-pci+bounces-11987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9D95B11D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 11:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D581F22A51
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757217B4EC;
	Thu, 22 Aug 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="frr5c5aB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE6170A2B
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317540; cv=none; b=XlMWZdndmLJ5rmegeLrw1MI++eg7eRHJVhHyPEc9RFMSdMQuyIJG+coeEFj8fupZg70KBPE1tVH7nvdbmwB5oHCuBmKnmO1DWyTe6ph+lZ2e+1eTqaTB4iRf0SmCtHQaT6sq9exyI5ex7U1AMkrZ3tbU+8WxuNxLh1MgJR7j+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317540; c=relaxed/simple;
	bh=iW8L90qW73Zksm1242gGF6/N3NxsJTz9FHLGPMnz1xc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/32WuXZlh1cmPYBlcXPHLR8v5m3moIPkKbmbWT9mFJqm76Y1y9meMwFmSj1qimi/Czt0c9/pS0B/tKpNKFe/NExFi5lTO/2ZZia94dIlWzsAry7TqS0tnzhMtvt4vdlIQPRG3HIxofneC4Vc0sK1EwuwQMIcz4RtBmBwlM0N8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=frr5c5aB; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so55679866b.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724317536; x=1724922336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oblCwReJRzdkWpeyjSuzACUpr6vesaxftcVWxVJUhw=;
        b=frr5c5aBI9sy2ew0/b43XWpraPs7EBe1sYCXKpWKrWEaAdjEQMwVvA3dzAqkb4Hdgy
         n9ueclanmhqM8EyQSXLYpYtQofTUQDi5FLqeIAZNqrXM2uAvCv5bZ6Lv8vnRzG/+oKEU
         B0bWbkYDHI/Tja9vXHUhBdcRtQHVRKfGXLoA5Y2EPW96S5z21xp+VXGAR654CYIG9aQ1
         9LLXvB/yQ1plLTTlrYitaEdEVytHl7FVqKZC15ml9hEIyaU/iHn2zYeJpYn0lpRoPfiO
         tOWjSFbG0iz6dn4qWpc7n/XLgMpULGkO3TXHPWbHu4SZ1ISVhwz5niSzPeuUbXSZTn+G
         Is2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317536; x=1724922336;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oblCwReJRzdkWpeyjSuzACUpr6vesaxftcVWxVJUhw=;
        b=utzTd1vIn0Qs5H5qVupPr24JHEhthMML6cG9pQ2BTMMW0ISgtCNZn0epiVTsg9HNMf
         FVll+kSc0FRpJ8MAGjsPFaI39SoZyX9k4rLXP/0o4Db2ndyFAtYD3J20U9J7XWurJqUq
         YhfxmdAqlxmnXHR+UJtNjP6r9hpaOCn365T6W6VnvfS3FbqYF4BlUh+A3hhTrtEm3Exn
         2+oyImf5tkgQZ5yUTAZhnN8NJ0WElTrS6pDezxXkC1ffhxOUofRwQp3h1kz3TYMTMD1q
         KRdFjaIzA+dSA6JhI33vsdoqLjTMgW0UNIrjASddo94QtI4se33DmKL/EE+JGlev6OBO
         SZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVTXXP8lI3tpVIYEqhkFWcRwj3JV5RZxDIZNTIyLdq+zTrAZIK0KzYwSHJ1d2QG6KpUtyg2R3HLXPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcMsq4mPcJT00sqjCnraSbi1oHPfEjrOYXAVnJYBUhyDrhoqb
	n2G4WjpM2M8r798NY4xKb2VQ0zG2CHjonQvKhi3gDyMidieMiw76+vNYLVWmX3Y=
X-Google-Smtp-Source: AGHT+IEDA43nqM23aA/1yK3IamBiUXMJrrIWIEhSqX0acpw/Zxi+tAITW+WPbPymdPgb8Cc2UqJi4g==
X-Received: by 2002:a17:907:e65b:b0:a77:c6c4:2bb7 with SMTP id a640c23a62f3a-a866f0fd40cmr439215466b.1.1724317535872;
        Thu, 22 Aug 2024 02:05:35 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47d17bsm89109166b.148.2024.08.22.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:05:35 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 22 Aug 2024 11:05:41 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/11] Add support for RaspberryPi RP1 PCI device using a
 DT overlay
Message-ID: <Zsb_ZeczWd-gQ5po@apocalypse>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14990d25-40a2-46c0-bf94-25800f379a30@kernel.org>

Hi Krzysztof,

On 15:42 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> On 20/08/2024 16:36, Andrea della Porta wrote:
> > RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting
> > a pletora of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM, 
> > etc.) whose registers are all reachable starting from an offset from the
> > BAR address.  The main point here is that while the RP1 as an endpoint
> > itself is discoverable via usual PCI enumeraiton, the devices it contains
> > are not discoverable and must be declared e.g. via the devicetree.
> > 
> > This patchset is an attempt to provide a minimum infrastructure to allow
> > the RP1 chipset to be discovered and perpherals it contains to be added
> > from a devictree overlay loaded during RP1 PCI endpoint enumeration.
> > Followup patches should add support for the several peripherals contained
> > in RP1.
> > 
> > This work is based upon dowstream drivers code and the proposal from RH
> > et al. (see [1] and [2]). A similar approach is also pursued in [3].
> 
> Looking briefly at findings it seems this was not really tested by
> automation and you expect reviewers to find issues which are pointed out
> by tools. That's not nice approach. Reviewer's time is limited, while
> tools do it for free. And the tools are free - you can use them without
> any effort.

Sorry if I gave you that impression, but this is not obviously the case.
I've spent quite a bit of time in trying to deliver a patchset that ease
your and others work, at least to the best I can. In fact, I've used many
of the checking facilities you mentioned before sending it, solving all
of the reported issues, except the ones for which there are strong reasons
to leave untouched, as explained below.

> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

#> make W=1 dt_binding_check DT_SCHEMA_FILES=raspberrypi,rp1-gpio.yaml
   CHKDT   Documentation/devicetree/bindings
   LINT    Documentation/devicetree/bindings
   DTEX    Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.example.dts
   DTC_CHK Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.example.dtb

#> make W=1 dt_binding_check DT_SCHEMA_FILES=raspberrypi,rp1-clocks.yaml
   CHKDT   Documentation/devicetree/bindings
   LINT    Documentation/devicetree/bindings
   DTEX    Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.example.dts
   DTC_CHK Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.example.dtb

I see no issues here, in case you've found something different, I kindly ask you to post
the results.

#> make W=1 CHECK_DTBS=y broadcom/rp1.dtbo
   DTC     arch/arm64/boot/dts/broadcom/rp1.dtbo
   arch/arm64/boot/dts/broadcom/rp1.dtso:37.24-42.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/clk_xosc: missing or empty reg/ranges property
   arch/arm64/boot/dts/broadcom/rp1.dtso:44.26-49.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_pclk: missing or empty reg/ranges property
   arch/arm64/boot/dts/broadcom/rp1.dtso:51.26-56.7: Warning (simple_bus_reg): /fragment@0/__overlay__/rp1@0/macb_hclk: missing or empty reg/ranges property
   arch/arm64/boot/dts/broadcom/rp1.dtso:14.15-173.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property 

I believe that These warnings are unavoidable, and stem from the fact that this
is quite a peculiar setup (PCI endpoint which dynamically loads platform driver
addressable via BAR).
The missing reg/ranges in the threee clocks are due to the simple-bus of the
containing node to which I believe they should belong: I did a test to place
those clocks in the same dtso under root or /clocks node but AFAIK it doesn't
seems to work. I could move them in a separate dtso to be loaded before the main
one but this is IMHO even more cumbersome than having a couple of warnings in
CHECK_DTBS.
Of course, if you have any suggestion on how to improve it I would be glad to
discuss.
About the last warning about the address/size-cells, if I drop those two lines
in the _overlay_ node it generates even more warning, so again it's a "don't fix"
one.

> 
> Please run standard kernel tools for static analysis, like coccinelle,
> smatch and sparse, and fix reported warnings. Also please check for
> warnings when building with W=1. Most of these commands (checks or W=1
> build) can build specific targets, like some directory, to narrow the
> scope to only your code. The code here looks like it needs a fix. Feel
> free to get in touch if the warning is not clear.

I didn't run those static analyzers since I've preferred a more "manual" aproach
by carfeully checking the code, but I agree that something can escape even the
more carefully executed code inspection so I will add them to my arsenal from
now on. Thanks for the heads up.

> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
>

Again, most of checkpatch's complaints have been addressed, the remaining
ones I deemed as not worth fixing, for example:

#> scripts/checkpatch.pl --strict --codespell tmp/*.patch

WARNING: please write a help paragraph that fully describes the config symbol
#42: FILE: drivers/clk/Kconfig:91:
+config COMMON_CLK_RP1
+       tristate "Raspberry Pi RP1-based clock support"
+       depends on PCI || COMPILE_TEST
+       depends on COMMON_CLK
+       help
+         Enable common clock framework support for Raspberry Pi RP1.
+         This mutli-function device has 3 main PLLs and several clock
+         generators to drive the internal sub-peripherals.
+

I don't understand this warning, the paragraph is there and is more or less similar
to many in the same file that are already upstream. Checkpatch bug?


CHECK: Alignment should match open parenthesis
#1541: FILE: drivers/clk/clk-rp1.c:1470:
+       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
+           strcmp("-", clock_data->parents[AUX_SEL])))

This would have worsen the code readability.


WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#673: FILE: drivers/pinctrl/pinctrl-rp1.c:600:
+                               return -ENOTSUPP;

This I must investigate: I've already tried to fix it before sending the patchset
but for some reason it wouldn't work, so I planned to fix it in the upcoming 
releases.


WARNING: externs should be avoided in .c files
#331: FILE: drivers/misc/rp1/rp1-pci.c:58:
+extern char __dtbo_rp1_pci_begin[];

True, but in this case we don't have a symbol that should be exported to other
translation units, it just needs to be referenced inside the driver and
consumed locally. Hence it would be better to place the extern in .c file.


Apologies for a couple of other warnings that I could have seen in the first
place, but honestly they don't seems to be a big deal (one typo and on over
100 chars comment, that will be fixed in next patch version). 
 
> 
> Best regards,
> Krzysztof
>

Many thanks,
Andrea 

