Return-Path: <linux-pci+bounces-27466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDFBAB0559
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 23:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6010A522633
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4C221555;
	Thu,  8 May 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aQUaSnwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF7221267
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746739645; cv=none; b=EistTZbSQ3wQszHp5e+oLMwV7QZDP7qERdVq/pYv7ZvvmH4/wuQVCB7NUC1S1QBbAYE6ylkIl595GYIWAxBrFw9LRRBT9s7DS0xRUvKQKrAgcMMY+Pv+u7boz8dYuJkbREDnhV1dZZdUNeXZj7o9A2ntgHOs/2deZlzKs32p4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746739645; c=relaxed/simple;
	bh=fCzAeA+bsdzOPRTHwXZH+gYz6BbrIA210lvJ88aZzEk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVLoGt0lH1qpCWEHT7Q6eAgoB13nQsAOqDPk86/kOexbqaLORxBzU7AleIT6JjBbysziYPq69cs2jHJIyOtsscIEpUQ7OSd9ue7oCboW7a5kLgCtsV+udXGDNzY2Tz4vbrgkrLTrLwo749RvY17HJMax2SqbvNIXHSUzeiQFkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aQUaSnwq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac345bd8e13so201650566b.0
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746739641; x=1747344441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RsP3zSsWFA5v6LbTV5x///CFgvw9t5S4qJvm6DV5CyA=;
        b=aQUaSnwq9CZ+ghu5lwdeZf3CVaUza4v3M66f/vZsmQa2M4eBHo78p2Jf3eswNRTbYk
         LO229eIjv6aeOXdg+wor6Ma7aiBPLMTYki2Z8gqg1cWK4WHZH6HOAhb8C8LVWDwi1qkh
         x4ALBKyO0iGrgQtFDzHZ5tDZYOHxTFRgAwuBnsRTSAuOIf4XQ1qF47P+Y32ZFY0j4vWs
         9WRJGmUKMG8udAvmbA2jd/+d8nQe0sW46lMGiv1KkmYvey8HOvTri/wvlqJhG20noN91
         P26uEVOWal5F6SzgCyetReQCISBrvoYKFTznR+Y1qV7JNn9VTwEC7hqJpi01q/NedTTI
         XSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746739641; x=1747344441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsP3zSsWFA5v6LbTV5x///CFgvw9t5S4qJvm6DV5CyA=;
        b=HdwVQJExKzzZWBZ3O1W7r16DP4D0S2m/yBShHGELUBbiqapaDDUdXKn6MvbCiwvt+1
         6hWTxKfP0PZVWfR84Va3RAfTMLdzRu9Vcpm5QRFG8geagCxEXZMhDUH5VRHXiN8+ZkbY
         Mkf6AWTm6XVMic5HPxXG0rBvyFmar/EHQQsAlmJgPQpsmvYXgZnaBUBfNv5HqCaVB5O/
         kPTisStr5kqiaaC99L2wi0C2x6D6A1/hmiOBqSW7dtYNvqdARcjTOQkDbY9m8J+R+8/R
         Fb6CTHoSgLfM0vFBpUmlkv5S4FblKplz1J4RRpdCWMLQdBW/niTxiXxoK9XrYRLyVNYG
         mNyA==
X-Forwarded-Encrypted: i=1; AJvYcCUYW4vLuK0LQZQU3T+wau18udPhruH5gXyiJxSdMUReCIGasmWDcBpKrwzaj4pUnr3JqdrWtn7kk5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6GYYMP3X5f6ladQIBku0tw1t9yuAfF0zlEkOseqJ1IpkJFm3
	6HMjQEC/WKils8cpDtoozGciFgm32CKtQkPRzB/Gzeodj4L46vd2fZgWZg0hjiw=
X-Gm-Gg: ASbGncsCERSaWwofzu5DXvsoRkbZO2jHMvzKaZq6su4aPR2qu3przdrVEAo2fcz0UfD
	wARZIS5J0Ea6e7D/gADn/7sIcZcQqy1L6SIyCPcL5KbGjKCvby1SwSbjIvdfttbHoCUl4DXGgKX
	5qBbbAsyNjCnxb3qI8Am9OJuC4NTtCYsuIshjgseNP9a/PtoxAI/7YTjlH1BkKG3L7C4p2+8hbz
	upnxsbAu693ynEWrJyL5jPQfHOD5do5ALs9VOf+83hBQ2OYoWQMCtSRClXwxQhhEHR5Gaus98/J
	DCEQCyY2xxmaggMO4DYuWJBpv13SR6bybY/QE9rL2mr1yIWcwD8JsC5iI03Zyq7HxLP3Ay8=
X-Google-Smtp-Source: AGHT+IGwowNKNf6YdL0s+pZvYQ6xsCLedq0Pezu/34sukHINlGhsBSD9rVYZ5MZsMsdJMGy3cL3uig==
X-Received: by 2002:a17:907:1b05:b0:ac3:3e40:e183 with SMTP id a640c23a62f3a-ad218e48fe4mr115728366b.3.1746739640793;
        Thu, 08 May 2025 14:27:20 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192d4a1dsm46249766b.17.2025.05.08.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 14:27:20 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 8 May 2025 23:28:48 +0200
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthias Brugger <mbrugger@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Phi l Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 -next 04/12] clk: rp1: Add support for clocks provided
 by RP1
Message-ID: <aB0iEHqYmNxXQd8c@apocalypse>
References: <cover.1745347417.git.andrea.porta@suse.com>
 <e8a9c2cd6b4b2af8038048cda179ebbf70891ba7.1745347417.git.andrea.porta@suse.com>
 <a61159b7b34c29323cdc428bb34acfa1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61159b7b34c29323cdc428bb34acfa1@kernel.org>

Hi Stephen,

On 13:01 Wed 07 May     , Stephen Boyd wrote:
> Quoting Andrea della Porta (2025-04-22 11:53:13)
> > diff --git a/drivers/clk/clk-rp1.c b/drivers/clk/clk-rp1.c
> > new file mode 100644

...

> > +
> > +       /* There must be a gap for the AUX selector */
> > +       if (WARN_ON_ONCE(clock_data->num_std_parents > AUX_SEL &&
> > +                        desc->hw.init->parent_data[AUX_SEL].index != -1))
> 
> Why is there a gap? Can't the parents that the clk framework sees be
> 
> 	[0, num_std_parents) + [num_std_parents, num_aux_parents + num_std_parents)
> 
> without an empty parent in the middle?
> 

The pos 1 in the parent index array is used to select one of the AUX clocks. 
Besides this, the index maps directly to the value that should be written in hw,
avoiding remapping. It's possible to use a numbering scheme like the one you
proposed, but in this case we need to complicate the code adding the renumbering
where the index is written in hw.

...

> > +
> > +static const struct clk_parent_data clk_sys_parents[] = {
> > +       { .index = 0 },
> > +       { .index = -1 },
> 
> Why is there a gap here?
>

Same answer as above.

Many thanks,
Andrea 

