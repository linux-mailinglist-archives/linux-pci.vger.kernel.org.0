Return-Path: <linux-pci+bounces-25801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD0A87B50
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7327D3B2849
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB1B264FAE;
	Mon, 14 Apr 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BWt7J/s9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C96261580
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621303; cv=none; b=HJ6QUCybmWPpvu3vlMUsSMaarfAITnO26gmF+Z6A15hkGmgzr9ac0ef8qh5rpRo1AH99VrC3uB4krs4K5V7ahnJGcI9Zd9v5F2OoxW4G2ol5dmYAPhe5B4XYbW4TZfvP5vHeOrkiNwufuVz5WC+C6KN+XbVmdX9MgabPGhizRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621303; c=relaxed/simple;
	bh=NL2TGpDIJnKJLRnd23h9LgHRVuBV+Ktt+8xcaN6KIFI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEqIUBB+bafNjWsswbzElQE7oSGEsspkJlyVgseBy7BwKUJ6/2s579RE9ES4TZlpQL/6H8wt8zYmoMCVXjWHGHD41D3jNMsp5iBvpOYfmGhu88b4ADPOrlLFE7mW+sg0AcDufRpn01OVHepjyyEe7E5fSglGeEtmtQgxYm/kATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BWt7J/s9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so684044466b.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744621296; x=1745226096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPOEfxN91t6VGg4utPDevtYddqW0HAL5VO9JP2cPRZo=;
        b=BWt7J/s9YV/VAOEc7OQF2YUju7YbYeIpodRYNsYtyweNtzkQWUaNq6rFFh0nNbpv9L
         idr0VZ9J78Nl8S34s9+ZJtl7DFyE3vNr8SEZ87JdZy4hImG1WlnI2RjpSfkHs6BmWW2B
         87Wm1xcJ2Wz+zjLBnPYAhMQ+C6P8/+PlGIpysxb2v5mGH4VIPIOGSSMxh5Ag8LA3jLk3
         RVdaghf11CqCg6skFuM+3LaigbGU9f7Uiy6T6rqIYeiUrI8xlj9mi6m5xyUYNUKRVlfr
         UqRV6QgDzRXAt5ulhv68I7aDg41Sh4eoJiGIOijRHIEaJ5W2tAstR4nYmEFNvUqCY9Dl
         iBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744621296; x=1745226096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPOEfxN91t6VGg4utPDevtYddqW0HAL5VO9JP2cPRZo=;
        b=X9TNA5O9fAUWPZiWC8rLR7olvkUmqi7Oxme4fxezoropqQRdj9RiLAV+iMr3Jv6b+M
         DZY8F8ZkZZamxXRu9sbP3tXET+lq9yh4ART+/k09lsf6sT9UmlFnX2wdsgr8oyxKftn9
         M6wrVVsvwJSaMoBER4FDESk5Ipsz4BT1ISs7wEaOaY1zSfjsyz13LViCuDKN6q3HqXSz
         HYcPO8JPfLFhBm8UN2T3SFWrENLfj97tm/FyNJ3rLji8NRRlERrWeyK3d7qBnvNGkDxF
         sQPAYBbewSvJPTaDX+vzdGocL2am7Gf47jXLb/2SXRmllfyrJqMsjlxl98n4wIeygbD2
         yPmA==
X-Forwarded-Encrypted: i=1; AJvYcCVU7QOJ3cWTOdknGvJWZlE99kGrj4YdSnSY9VXA9HaWLx+dT5Un/6YzLoO/y60aJZf8ZAx7XIwkhqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAS7cKWUb3mPDbpxMiYdX1fSBjk/c/MpzUNO+HY4z7owmWBLH
	BXYXew3s0RThGNIb1TyoM+KqruV7LQDFi4Hv12vVTx9s+gDQmCu9zanb6VQmb0k=
X-Gm-Gg: ASbGncv3WGgw5OmoTJY4Y+O/MECqZdOAW+TrESpjZPB+cYyk1WuOwKGRFJiXo3mEhu3
	KK6swH3fDoYNPPXy8M+Ya92slUKj3yh8+jN9U78r+ageWCDKt32J7yRHndRHPkUTPzidQeeJD4T
	QPE9GrypEN7KB0TDv0A5lx7hx+ztW5r0mKDkpZPWE6o1eBM3Bi/pudyBv3vsU5dWGZU4M2v4ccG
	mooc3CicX7xtbOI3EUWGU5pUVC76ZYSHCZxoAy2Zzup9uH1tiViyv+3PW8D4nUMVUGmKir4y3Ow
	RveESmd8UyRmLQw0qxmdydoonVyTXaasDCWa97ZC2i4yAaXISR5cASfRTo8BKqO5QSRs/FdAnd4
	EG+UHZg==
X-Google-Smtp-Source: AGHT+IFmbGr9kZB05oV1EN/0KfR241wQsclfRn1B+/FEvNm78/Bf5RFw5+zsFio1fzhhJ8sSkqIJlQ==
X-Received: by 2002:a17:906:730e:b0:ac4:4d2:3867 with SMTP id a640c23a62f3a-acad3499ff8mr901526366b.23.1744621296460;
        Mon, 14 Apr 2025 02:01:36 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7fdcsm883504566b.176.2025.04.14.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 02:01:36 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 14 Apr 2025 11:02:58 +0200
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 00/13] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <Z_zPQpyjZXzVxroB@apocalypse>
References: <cover.1742418429.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742418429.git.andrea.porta@suse.com>

Hi,

On 22:52 Wed 19 Mar     , Andrea della Porta wrote:
> RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting
> a pletora of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM,
> etc.) whose registers are all reachable starting from an offset from the
> BAR address.  The main point here is that while the RP1 as an endpoint
> itself is discoverable via usual PCI enumeraiton, the devices it contains
> are not discoverable and must be declared e.g. via the devicetree.
> 
...

since there has been no feedback for a while, a gentle reminder about this
patchset. 
Several patches have at least one Reviewed-by tag, with the exception of:

- PATCH 5, 8: those are, respectively, the driver for RP1 clock and misc core
  which have no major rework since the inception.

- PATCH 9, 10: those are new patches, where the most relevant change is a
  rearrangement of the dts include hierarchy to be flexible enough to support
  both the dtb overlay approach and the monolithic dtb.

- PATCH 13: just enables OF_OVERLAY config option. Some metric data have been
  added to help evaluating the impact.

Many thanks,

Andrea

