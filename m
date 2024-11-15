Return-Path: <linux-pci+bounces-16863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55B9CDD09
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6643D1F218AD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7371B4F3F;
	Fri, 15 Nov 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LxD2iVQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA51B3957
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668027; cv=none; b=Rjdg/25ZpggYR95tRBm+EZWulRR8DQb7A4SmFznvmDHBq4R/qOipBiMr942J1eTQMLlljKyfaOk1HkWBOLhx/zVQop3vDvURmYB7iX/a69KIe0YV7Vr9PvcXWqMP1y3ja3eKdM2ywrRjEF+tb94IRq3Zjv+O6rHl390yjXFyeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668027; c=relaxed/simple;
	bh=Aze8ubsJfw20CCAheENnV0TxOaVpLIudKLyqB1mUmWs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki8INDZGV3q+Mff1mRFvB/8zLJ2eENjRj+jdym2aV2rLgvN92ox7SUOY2ubJiUZIm0zQsl0vPIr+wwKbnWbge6FiI4ES2tZKpnmsDqcBYTBY+SqugNL4mUUbTLSJrn2hqRn86llgNWZ/wA2Jy/F9qxUcl/UBbuWN5vgyquFNMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LxD2iVQS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso534848e87.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731668023; x=1732272823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kqEZZaXWIaNRK9OLE5Wx827F0bUtvaOZcgVtTnimPxg=;
        b=LxD2iVQSWDliHa7Qm3U3T/EF+DEPxdk9Ry8F7GTgz3VvaNne5Bk1xmuxG6LqbmMXDz
         5rlp5x3XY53Lq88fHFqXPax4sm/eWCl63dMf8NDRiPHsqBmsRNFtnIaJS9g7oygJahmr
         yOXnNQlESkzsmaTIhRvy97jxtpiq4j8KaBGB/cREmFctrM/vwQzXRsKMoMV9q46oy8gz
         miY6W2t5FL5k1Xzc6cQ1NVZEzOOn17TiwTYFlTubfSdjVbzgWUPzhfMeXCOLE2ULq2HA
         WyCXiqEGTDgOU277xMcpAN87RLgbLg5KBgZ6NI90hAMsIuBXhXrWI9+t7wkIVZ9nBY0y
         sgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668023; x=1732272823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqEZZaXWIaNRK9OLE5Wx827F0bUtvaOZcgVtTnimPxg=;
        b=J6p1/65IrTzvAfq/0rkJOnE68DzIr2nVQ6U/skulqy+eF3QbWz7+8ol/WPWJBQYQrc
         37i157Y3N5D1AdGoRvycPfP57PXPRdF7wOe1gUvFKTzo8iwBQlqYW+0RGpy+gvCUnyUk
         WffKRfcpB4GqTDHddD90H1XijqpyR70mE+Ev/LcNhS5r3AD5VmwcStL4vz1c7VKo5C6y
         dhBBhNOvCudMiSxg0Z3NNHkd4xRhfLgzFSI27ZG8Q6KPo4UwPURX1b2XXubP+lUJRAfu
         sIaih8RmTI9GLL4QyJjl8+yC/3T3biOi67OgS0/RCQ9Hij9e5JFP+k6qQn8/CoUE2+BJ
         Y6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUpRWtDKrcYzcFOYP2wCPnptotDY959UcvW6iTDTTRcP6U+anaInhuMTqqR1JFrEdkeggpon2ZOVZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkaa6RTjtqCA+0oZ3u5vnoPHY4S+bYZLmKEtJ/LA1rYzApOf6L
	vJStlptznh4uuRmlbz2wWKyez6EsM157og+E3tW6o6kiSbNDJlt3ukh3Ayfvh3s=
X-Google-Smtp-Source: AGHT+IFHVLZ9JHkGOvekL5vmiZxKEfDLHTUYv8vjzg0FSLM0sIjZA/dYE3eiUJZBbLbHkNSDwDDmVw==
X-Received: by 2002:a05:651c:245:b0:2fa:c59d:1af3 with SMTP id 38308e7fff4ca-2ff606933a3mr12846531fa.20.1731668023447;
        Fri, 15 Nov 2024 02:53:43 -0800 (PST)
Received: from localhost (host-79-19-144-50.retail.telecomitalia.it. [79.19.144.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf9010b12bsm531260a12.41.2024.11.15.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:53:43 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 15 Nov 2024 11:54:11 +0100
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <ZzcoU8ckE7wXWC8w@apocalypse>
References: <ae3363eb212b356d526e9cfa7775c6dfea33e372.1731060031.git.andrea.porta@suse.com>
 <20241108165654.GA1665761@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108165654.GA1665761@bhelgaas>

Hi Bjorn,

On 10:56 Fri 08 Nov     , Bjorn Helgaas wrote:
> On Fri, Nov 08, 2024 at 11:39:21AM +0100, Andrea della Porta wrote:
> > A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> > translations. In this specific case, the current behaviour is to zero out
> > the entire specifier so that the translation could be carried on as an
> > offset from zero.  This includes address specifier that has flags (e.g.
> > PCI ranges).
> > Once the flags portion has been zeroed, the translation chain is broken
> > since the mapping functions will check the upcoming address specifier
> > against mismatching flags, always failing the 1:1 mapping and its entire
> > purpose of always succeeding.
> > Set to zero only the address portion while passing the flags through.
> 
> Add blank lines between paragraphs.

Ack.

> 
> > Fixes: dbbdee94734b ("of/address: Merge all of the bus translation code")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/of/address.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 286f0c161e33..72b6accff21c 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -455,7 +455,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
> >  	}
> >  	if (ranges == NULL || rlen == 0) {
> >  		offset = of_read_number(addr, na);
> > -		memset(addr, 0, pna * 4);
> > +		/* copy the address while preserving the flags */
> 
> Not knowing the surrounding code, it seems strange to say "copy the
> address" when the memset() fills with zero and does no copying.
> 
> The commit log says "set address to zero, pass flags through," and I
> could believe *that* matches the memset().

Ack.

Many thanks,
Andrea

> 
> > +		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
> >  		pr_debug("empty ranges; 1:1 translation\n");
> >  		goto finish;
> >  	}
> > -- 
> > 2.35.3
> > 

