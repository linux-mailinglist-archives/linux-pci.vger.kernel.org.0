Return-Path: <linux-pci+bounces-17464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F49DEB7A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262641635CD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2D155382;
	Fri, 29 Nov 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bDOwkwrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0A155393
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900284; cv=none; b=JyZqjBTrIzBPoO5qQBxoZs3WswzF4mw8s+CJ53YRXpYVTrkUIs5Wi33d6U80MWGLsTNotV7CEHEWY4zxYH03yPiYgCId0dHJKi7p8EPRxzTD4OH0cTK8sWB7WhEjkPgb66bUoZ+OXx1/e42ONppAa79sxfwWalfPv+wIPANMnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900284; c=relaxed/simple;
	bh=u4VeqDNvTWRAhnRMPvx5ZxHgDaIe1hpfxIJoqfWrVgE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faIIEEMg8T92sT2m1IlVH2lQudyK+5iwQPKjZCpT+7l7mt7i+ahdVIVwJGtXjEpyIM9ObWEXVH+3uyVB2U6PgqXgGxLO5EXbHEQXX4htQYa76wM9xUmvfoal9We9EyUvratuRWiJCXyGOTDcmvZXCJ7jKrzOLE61m4tBxZp7jQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bDOwkwrp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df1e0641fso2521422e87.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 09:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732900281; x=1733505081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKStJ4JMYm6/f7jAdkMonmjOHy/XStYH3AHNh9QPw+k=;
        b=bDOwkwrp57+hdJuQM2yuTXFuR2uJQz4KquU51t8PIHqO8eQiDyD9aQNlzcorNorPaT
         xp7YOLadRHiHqNeLg9IJY6J/ulFR/j/syM1NdPODXmEbzVOl5mUR/WOlAKf2q/W7pRWF
         OVISodhH2VoKdzyWp6LX1fXe+h47Uvf/jzI/K4qJMK0C/xvuS5ytvS7xf5oYa3VTLyd7
         VWtiSLzoTH2KjPpjC534rVGaPgyoky1fRIlQrXwp05orw95J08DpqUP7G6xtWuVpeMBw
         wDC8XOyxR1Qfs1jSuK0KTWCb5rsWjIdgrxuwVXnYBHN2hXoRrC0USPiYqn3iDJLpFYf4
         VHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900281; x=1733505081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKStJ4JMYm6/f7jAdkMonmjOHy/XStYH3AHNh9QPw+k=;
        b=CzDcJmdc09e4qsbURJ+lYIAIIHgPc8Ud1Gs95zCFyvpAY/phE8O6Ce8ddDwUca/jvj
         3tgiAyMyrei6Yfu9YmQQ8Wo7GsMpkWcGvQDbD3O3UN6CesH4n9jI0E3OEP8dIjKUqGoU
         aoSYy2id7tQKLzLB/t/EFF0C5tUeSHgIx6/7wuyb3SCqn26JYO1B+AUbWcpBjJ/a2OVk
         ZNFmY3w44RvpcvCTDxBjfvCmT+jvdreaOGqfnuM8LMZWsDbubpE+SppqJer55DWKIirC
         I1fyzj3qyGjCtA1Mli4i9tLopAfp3QpPqxT1gxh4dhMjnkBdBKD4kDfNWrX3d5Gqm7VN
         J3ig==
X-Forwarded-Encrypted: i=1; AJvYcCWipAitKDdANZEXLihDhWWjlozijYepVAE7U2Mr3ikQiXRm+No3Ncu4CUhhYpEQtEOfUAXo/BuEI0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXovtdW5rKJBEghQSV85DjRywRB7Ow5pBnRx2771OlhmdZLeZ
	p8mDwRYu+hrdHGlekmuUPoZZy0McqTK5f9U8iw+TAtDcnqxNoH89TvybANbyB/8=
X-Gm-Gg: ASbGncvEmxFDrUnZs5siE54kZ5Xo95RiR/uNK5EGeAlScdHZCiv0AiMOGLSZCRX++4l
	IT10E7LfmmLW78IPT3nhZbVbm+UAr09Zg0kg+O2T8b0jXkU2FSdd4aWEibk4lE7N/CuL5PmRGNy
	XH/PEsUDkd9Om/xMjrsPLJagR8bdl6UkujqdwZ2sPLJ++yDC8wBzPHRxiZLr1YTKLv2opdwl9Wn
	mDTGvjQqNNP/+7i/9LVx3nBroGaXZ/o+JkRop1IQcDqqkx27O8VmDrnUGxe6jx4NFC3k0uvEmV/
	mQZdpTHj89f7TkqeSObO
X-Google-Smtp-Source: AGHT+IHZ3oTCh7gVSsmHhrZ3fiOp7cXkhyrNMHuydkCIk2tz2qxDfVIno+QP7oK2bTxacMEqt16MJg==
X-Received: by 2002:a05:6512:39d2:b0:53d:ec9a:138f with SMTP id 2adb3069b0e04-53df0112687mr8431697e87.57.1732900280754;
        Fri, 29 Nov 2024 09:11:20 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e63a2sm192130166b.113.2024.11.29.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 09:11:20 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 29 Nov 2024 18:11:53 +0100
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 02/10] dt-bindings: pinctrl: Add RaspberryPi RP1
 gpio/pinctrl/pinmux bindings
Message-ID: <Z0n12a6irbXQomdD@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <9b83c5ee8345e4fe26e942f343305fdddc01c59f.1732444746.git.andrea.porta@suse.com>
 <4ufubysv62v7aq53qfzxmup5agmqypdvemd24vm6eentph46qq@3kveluud3zd3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ufubysv62v7aq53qfzxmup5agmqypdvemd24vm6eentph46qq@3kveluud3zd3>

Hi Krzysztof,

On 08:55 Wed 27 Nov     , Krzysztof Kozlowski wrote:
> On Sun, Nov 24, 2024 at 11:51:39AM +0100, Andrea della Porta wrote:
> > +  '#interrupt-cells':
> > +    description:
> > +      Specifies the Bank number [0, 1, 2] and Flags as defined in
> > +      include/dt-bindings/interrupt-controller/irq.h.
> > +    const: 2
> > +
> > +  interrupt-controller: true
> > +
> > +patternProperties:
> > +  "-state$":
> > +    oneOf:
> > +      - $ref: "#/$defs/raspberrypi-rp1-state"
> > +      - patternProperties:
> > +          "-pins$":
> > +            $ref: "#/$defs/raspberrypi-rp1-state"
> > +        additionalProperties: false
> > +
> > +$defs:
> > +  raspberrypi-rp1-state:
> > +    allOf:
> > +      - $ref: pincfg-node.yaml#
> > +      - $ref: pinmux-node.yaml#
> > +
> > +    description:
> > +      Pin controller client devices use pin configuration subnodes (children
> > +      and grandchildren) for desired pin configuration.
> > +      Client device subnodes use below standard properties.
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          List of gpio pins affected by the properties specified in this
> > +          subnode.
> > +        items:
> > +          pattern: "^gpio([0-9]|[1-5][0-9])$"
> 
> You have 54 GPIOs, so up to 53.

Ack.

> 
> Use also consistent quotes, either ' or ".

Ack.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

