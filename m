Return-Path: <linux-pci+bounces-15958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544109BB625
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4901F22E4A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC45175A5;
	Mon,  4 Nov 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ztIZqAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hiAB4aDT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ztIZqAK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hiAB4aDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738A1805E;
	Mon,  4 Nov 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726983; cv=none; b=hV3vNuVCnG2ZFWXVsfuy5/xkVO0Od6OgRkavzOMsnhJgeGyfMjS6/V67R+KRVC/w5nocpHAmEyJwxnjKwgKRNEPuuS6pBGhgYT1oPBApq+x1KTVVGVSDXjWoeEMc+XTaK5Wi9CMjWHCuydJuFaSfBV8y5HtW/VwDL+2/rQAWPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726983; c=relaxed/simple;
	bh=RSoG8d8jv7cGDi6rq3kBLWw5c7e8Q/DJ5QhwqPOT1wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KVnI3lfs4xf1AfE4oksqxCoIBSUSmAVHsSg5UZ+LACfajUqavsQVT0Bb/IPn63wA+xdncdM9YNM+vVPZPwyJsHv05Y6uWvrktF+5Qr1YmvinfMebnNGZHVA5K90bt1+vk+ngS3vj9y8xFlEfDwzDAGbHaHTtCR8UaH5dF5bsno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ztIZqAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hiAB4aDT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ztIZqAK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hiAB4aDT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC4F51FF36;
	Mon,  4 Nov 2024 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKHcMQ+F+3c9KRnL5ZzCKvMuehzzc0PImZ7peshW9ic=;
	b=0ztIZqAK7c+mZUeNBdVOS3QcjKZ+gTkbiiThbV3uCT0qdfhhLQzUICYrNxg0ISCzCRiUlh
	FWlQp+MH7IKelwTpTbszyGFxqUnIW0z3L1+1/hQxJKMplwOV4Nf/4SQtKc7goU+gZsp9CD
	MJcyZ7QH4oYpYRwXPV5G53L/tQ0dv6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKHcMQ+F+3c9KRnL5ZzCKvMuehzzc0PImZ7peshW9ic=;
	b=hiAB4aDT3eWLY4chbO4o/9B+i0qLDs4/0lkJTQOSYSpj41i3RklBPyf2wd8QgBPcr25i0B
	fnuVbXEhHM/QBICg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730726978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKHcMQ+F+3c9KRnL5ZzCKvMuehzzc0PImZ7peshW9ic=;
	b=0ztIZqAK7c+mZUeNBdVOS3QcjKZ+gTkbiiThbV3uCT0qdfhhLQzUICYrNxg0ISCzCRiUlh
	FWlQp+MH7IKelwTpTbszyGFxqUnIW0z3L1+1/hQxJKMplwOV4Nf/4SQtKc7goU+gZsp9CD
	MJcyZ7QH4oYpYRwXPV5G53L/tQ0dv6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730726978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKHcMQ+F+3c9KRnL5ZzCKvMuehzzc0PImZ7peshW9ic=;
	b=hiAB4aDT3eWLY4chbO4o/9B+i0qLDs4/0lkJTQOSYSpj41i3RklBPyf2wd8QgBPcr25i0B
	fnuVbXEhHM/QBICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AE641373E;
	Mon,  4 Nov 2024 13:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pEglAUHMKGdhawAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 04 Nov 2024 13:29:37 +0000
Message-ID: <4a474dae-6669-4678-87dd-e0e9692a749b@suse.de>
Date: Mon, 4 Nov 2024 15:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] arm64: dts: rp1: Add support for RaspberryPi's
 RP1 device
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <1f4cec50493ec5d3168735c0a005771787e5cd59.1730123575.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <1f4cec50493ec5d3168735c0a005771787e5cd59.1730123575.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[suse.com,baylibre.com,kernel.org,broadcom.com,linux.com,linaro.org,google.com,arm.com,bgdev.pl,amd.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org,gmx.net,bootlin.com,lunn.ch];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLuy4kgthhwuicx86wgtwa6dww)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Andrea,

On 10/28/24 16:07, Andrea della Porta wrote:
> RaspberryPi RP1 is a multi function PCI endpoint device that
> exposes several subperipherals via PCI BAR.
> Add a dtb overlay that will be compiled into a binary blob
> and linked in the RP1 driver.
> This overlay offers just minimal support to represent the
> RP1 device itself, the sub-peripherals will be added by
> future patches.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
> NOTE: this patch should be taken by the same maintainer that will take
> "[PATCH v3 10/12] misc: rp1: RaspberryPi RP1 misc driver", since they
> are closely related in terms of compiling.
> 
>  MAINTAINERS                           |  1 +
>  arch/arm64/boot/dts/broadcom/rp1.dtso | 61 +++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06277969a522..510a071ede78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19383,6 +19383,7 @@ F:	include/uapi/linux/media/raspberrypi/
>  RASPBERRY PI RP1 PCI DRIVER
>  M:	Andrea della Porta <andrea.porta@suse.com>
>  S:	Maintained
> +F:	arch/arm64/boot/dts/broadcom/rp1.dtso
>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>  F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
>  F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> new file mode 100644
> index 000000000000..8d1bbf207a30
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +	fragment@0 {
> +		target-path="";
> +		__overlay__ {
> +			compatible = "pci1de4,1";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			pci_ep_bus: pci-ep-bus@1 {
> +				compatible = "simple-bus";
> +				ranges = <0xc0 0x40000000
> +					  0x01 0x00 0x00000000
> +					  0x00 0x00400000>;
> +				dma-ranges = <0x10 0x00000000
> +					      0x43000000 0x10 0x00000000
> +					      0x10 0x00000000>;
> +				#address-cells = <2>;
> +				#size-cells = <2>;
> +
> +				rp1_clocks: clocks@c040018000 {
> +					compatible = "raspberrypi,rp1-clocks";
> +					reg = <0xc0 0x40018000 0x0 0x10038>;

shouldn't this be:

	rp1_clocks: clocks@18000 {
		reg = <0x00 0x00018000 0x0 0x10038>;
		...
	}

?

And for other nodes too...

~Stan

> +					#clock-cells = <1>;
> +					clocks = <&clk_rp1_xosc>;
> +					clock-names = "xosc";
> +					assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
> +							  <&rp1_clocks RP1_PLL_SYS>,
> +							  <&rp1_clocks RP1_CLK_SYS>;
> +					assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
> +							       <200000000>,  // RP1_PLL_SYS
> +							       <200000000>;  // RP1_CLK_SYS
> +				};
> +
> +				rp1_gpio: pinctrl@c0400d0000 {
> +					compatible = "raspberrypi,rp1-gpio";
> +					reg = <0xc0 0x400d0000  0x0 0xc000>,
> +					      <0xc0 0x400e0000  0x0 0xc000>,
> +					      <0xc0 0x400f0000  0x0 0xc000>;
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
> +						     <1 IRQ_TYPE_LEVEL_HIGH>,
> +						     <2 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +		};
> +	};
> +};


