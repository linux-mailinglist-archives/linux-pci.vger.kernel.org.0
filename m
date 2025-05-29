Return-Path: <linux-pci+bounces-28625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9AAC7DBB
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CC93B5A02
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596401B21BF;
	Thu, 29 May 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V7sr5hko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB42222BE
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521844; cv=none; b=oiYcHceJvu1meXZB2eJr2s7VPyZE42jIzATOMslX3H8OL8YpT83284fITb/iF9VfSSrQd0I4JC1x6QkWBKvSou8taLsu6Yc7f+S0WZSmemfeIEXX0RCByWD61n1YXNRpet32vpItbpy9G3GadQ57K41vBs16Upm2kzyTenibbsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521844; c=relaxed/simple;
	bh=Yve1y1r49ecQDnwvQsVX/ck6yFvbc6vKX1qjrxYEKpI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUrUXVlSMJxxV4/LKYfbknLR2b2t4KQTJJ71Njo3o1qNu82qiwaOwAbS2VUP6KoX88mkfkjj8uBGOFX7ixG3+vwbQqZ2MjxSd+jqXgZzJDbBBj1NKAm5oVkvyQ61pkyzmnPsaOLatoRkv72VHSGsJEU3KkPkcTbIfdm1Bs8m6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V7sr5hko; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad55d6aeb07so134185566b.0
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748521840; x=1749126640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suszitiSJbZS8iWXXXVjI9GrivMQ+RVo/o+nLw7sB/M=;
        b=V7sr5hkoBzvHJosQbML2fvSaGT8F1aWaY5uwjPFVi73sxMDGwi0WvH3AByv2TZOb8k
         /2yWOtPohAsyoflr0uMYnffj2u7p4ujuqVxt36PQcLKh+retBoJPLEnqS8KvcGfoYk9b
         g2FhbWcDjepAbrUJrzGlQGo0cl1D6Lu2Yxe4jFcbCZydWb8m1EsyMnBk9Yho/9PzQHQp
         8OzMvtatqE95YuoDfyXM/kXDB+2Xg4TnMLPK77oEuTK5MIiRID9z0bi/tUnNy96Ygxao
         olB+OvBVgypYJhHXYpU5w1KOtF0UEeoqWVa+t262MPDyujWyR6QhU6vsqqZ/bUPDwT/g
         /n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748521840; x=1749126640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suszitiSJbZS8iWXXXVjI9GrivMQ+RVo/o+nLw7sB/M=;
        b=Qei0edPciXRJZiXAQ/ut016oZSoxMv0a4Bu0UBObRyqcqF/5y873DEfyceNbfCS2rK
         6+pgDjAifUi0Ia0JxFl5gBHIYImKIov8ejMAB/2fdEvdFqBhs06se7vOuiX3xowh/6VG
         HlhTFFDA3LIphD2epdukgjmGNs99x4E7H3+wxSnNbBcilHsGmBHEY1puVkItLLxXe39c
         z4gu7GoKDucIS8RigD5qu3SOVMxCtXZo1NOf6n+cdKUgcH9ddzLw36WZ27KHgvaskDah
         UeAj4/1wXS2pmEaM1ILAyBMds9vCPKPK47koFw9aMnUqY11hZOx3xNinmc5omcOiW+Go
         1xmw==
X-Forwarded-Encrypted: i=1; AJvYcCWvA8UojoWmxtSRp2TWWnvEtzDE/1WhfKc6EDFQD/hq/HFr1vLoJ7bRVxTjhKWJZbjgHX+3WegrmC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9yE2dhuDF6QkIUXoZeddZ5CTs+jpLQUpbCm2crYnl5JudqN0
	e3qiFQ+sG6fn94vzMOx799eDFFqj6RlisY/p6LZIEcv0WFmoW93KbH4aCKmNjcsvVX8=
X-Gm-Gg: ASbGncugSCGrqvbecr9N1D8n2IdOp/K6eRsMj6U3AdCahPnyiZ0RE1K1r141snQDhgd
	98RYHCt68fZkHljbKoSWTVg3mM9xRiX2idsF9fxJqy3FWm9DvN83g00T15tBw3zsZbkqnfeGxnX
	vgCbpt1a+dqx85yQ/0oilkvGVoyTWlhZ9cyRkbN0X6QVtbxsk6m6m2QeWGY2KCO1ZhXczUW/WZe
	17tJ7cgaQtLs0U9aJMzbYjHn9kmb3k6aCVedrci772iSIsiVyFXTSZvZY7qgYttsIS68E7kVkRY
	HOf4k+PG5XFtAWcVKvNQEtVuTGAKnpTZV81o8MngTfIKEaQEmJxEFKLxTImHngROiN9hiIv3qnu
	0FtTpzv4aWm/SKu8qoKC7Og==
X-Google-Smtp-Source: AGHT+IGh83QJllCl4ga2r5TeFVA+yFVEjbebpA/nYkqIF9yNbUhm17ow5NrnSrfH88Ym8gPqVxFW9Q==
X-Received: by 2002:a17:907:1c21:b0:ad8:adf5:f7f2 with SMTP id a640c23a62f3a-ad8adf5f9camr383908066b.31.1748521839767;
        Thu, 29 May 2025 05:30:39 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d850d88sm134258766b.77.2025.05.29.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:30:39 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 29 May 2025 14:32:14 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v10 0/13] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <aDhTzqMLM5wR09y2@apocalypse>
References: <cover.1748516814.git.andrea.porta@suse.com>
 <2025052908-goldmine-ramp-b865@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025052908-goldmine-ramp-b865@gregkh>

> On Thu, May 29, 2025 at 01:23:35PM +0200, Andrea della Porta wrote:
> > *** RESENDING PATCHSET SINCE LAST ONE HAS CLOBBERED SEQUENCE NUMBER ***
> 
> Then it needs to be a new version, not the same one please.

Sending V11 in a moment.

Thanks,
Andrea

> 
> thanks,
> 
> greg k-h

