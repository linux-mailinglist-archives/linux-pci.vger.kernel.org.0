Return-Path: <linux-pci+bounces-17272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD419D7CF8
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 09:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556C9B23378
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D531891AA;
	Mon, 25 Nov 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DDIv0taD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE22A1BA
	for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523683; cv=none; b=Z9IJVKbWi/rOGH2JVSsk93metvqK+cQ+oxydL0L/AR83qc5ysJxK5YfCculbwzrOkhn1XxuE9dHZug5hHtmaOms8N//2dJMAZS5SEQv68FSrDGCcQWodAtebFYkgnAPTxHbrSpez1KHmFfAhOO6biBqwx0Bus/No7ZDwFDeMSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523683; c=relaxed/simple;
	bh=5Nhv1Mm0+fbxtk2KdzQJbKFpjj2DWs2QHyapg7sOW0E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3QZv+nv3dBlGigmZ4ulSNwDr+IxWHKsmbNsZDcK3G7n1SkQx8jHt3EmJ0oCU+UCB0tOSxJG/UnVMKDjw6g/+8Q4x6ZCwm7dPIimqW1spdWT64Kj5ZMTsDGkpUcoCIAuQYDZBViBvljDqVG67DhOAnOuFY32bnLnI7YSDJQes98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DDIv0taD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfcd99846fso5510783a12.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732523680; x=1733128480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vg0D/GXC726IE1EJTMsV29mWCwy+CAcBXGOGjtO3CHw=;
        b=DDIv0taDA8NxOu9j0vaARHXUXN4/MCxzDydDyuQWYRsU6gz+vewnPcxNbF5zL0IQUy
         qBwx06I22FYw0quLmSmGeCa46iLIfjgp7JD+lcl+HAPlFLsBk6Ln4ZF8AGjC5iyBYbFy
         gqp2M9QOQJY/OtQYJoRLyFJL3EPUYc+kCmwnbkfWl5TfRImvmS6ntM3BftwNAWDiQTws
         9zy90N3EpUfI6BJBEh59TNYWyH56oSdrtTpUp8jG2m3TTaGd45+H4miYskgztd+fSZi0
         8oVkI98JzMyUzc30rRJTLJQOoUmCYv6sLWr0j/GmAeMsOY+mmKo69aM7HoYritTbnsWu
         BtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732523680; x=1733128480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg0D/GXC726IE1EJTMsV29mWCwy+CAcBXGOGjtO3CHw=;
        b=tQGLVCVIhSh5U1Zp/Bob/1R2dzH0nesbRpsy19ZKf0ksWOrsy/XHeERsUOn0l9xL6n
         VmYYks1YguK56IvKLb6ccY/HKGVt6jfP8h8+E0ZJ+M9Qp8wMlWnLVlB5j6TGsJeKc7+X
         fmBDaiXBMfA3HSeAbphyjN0TewAeeOYXLlFl2ZRcBikC1i3iTsi++UH5Rb1uVIikC6HW
         kRf9nrHdu62hOTb98fGjLxXPM+/JuvoYR/wZkhR5F8TQYYzC8gFXUFxvxrJ6+GG7kvvR
         rhTBmXgHTvg39nqvqJQ4wXZYyEyrG9TWYJUTBIthhUMVeZhcnGwkFChvA+ZmcxVM2YCy
         ZkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vGkA1redAv76JhbKyRIwMTJZUwlN7YLrfXMKXHlV0w1BYriEAN3t0FomYOLcdoYVznCbTFF3btM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+FVgfe22WqJZBK33b1Cf8hNuYeoUqvEL01F94ZPygbN1uC/2
	31Gxtf6jRUFkdCM/1EtyqCprPds0TWtA4kBPcrRb6GPzknmyswvYnu6RoWiXy/w=
X-Gm-Gg: ASbGncsBJETFvi4VjFj+NZ0YlXerlKyKVHV7dC23Nu04VUv/A+s4cCYtNxWflilndHm
	lHDOWCSEZkLoKzdgcz95Zzrtp4gZNA6GLwGV4naQHUlUWIneBjukXiphMZRDjT/3hH+AD+dclln
	Q1WxSUMj1rQg5EjlvJbvA0BxGUC70qC2rqrAZTKUwO8S/DxTaEYnc3H991qd8SLxdssvL4XxHcZ
	CO3TzSVUknK1XmYw8zkkCDrYeohV3ydbELkmYpJzUsD5UpmuTCcip5Znj1EsJzr4RyhYOOHVHYS
	yJQaMN1ecWHOKkEfOgR5
X-Google-Smtp-Source: AGHT+IHTcfEoEYoZ9eKBklAA7GYxZ5kMOqK2yZ8KaAw01uPI3MZswrc9AVeFlfapHP8sHh0b3gsj9A==
X-Received: by 2002:a17:906:3096:b0:aa5:1d0c:3671 with SMTP id a640c23a62f3a-aa51d0c36femr719670166b.23.1732523679890;
        Mon, 25 Nov 2024 00:34:39 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57c19esm433460966b.154.2024.11.25.00.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:34:39 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 25 Nov 2024 09:35:12 +0100
To: Andrew Lunn <andrew@lunn.ch>
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z0Q2wJBMdN1dyJWA@apocalypse>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <c48e6b9b178cdaa01b92ae82e8fd24c2ba5f170c.1732444746.git.andrea.porta@suse.com>
 <e57c9c8b-2534-4d3a-b762-ca9c1f7dac40@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e57c9c8b-2534-4d3a-b762-ca9c1f7dac40@lunn.ch>

Hi Andrew,

On 20:33 Sun 24 Nov     , Andrew Lunn wrote:
> > +++ b/drivers/misc/rp1/rp1-pci.dtso
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +
> > +/* the dts overlay is included from the dts directory so
> > + * it can be possible to check it with CHECK_DTBS while
> > + * also compile it from the driver source directory.
> > + */
> > +
> > +#include "arm64/broadcom/rp1.dtso"
> 
> This is probably O.K, for now, but really the tooling should be
> extended so that DT files can be checked anywhere in the tree. I can
> see more such embedded DT overlays appearing with time, and there is
> nothing actually arm64 specific here, it is architecture agnostic. It
> is just a PCIe device, there is no reason it could not be used on a
> S390, Risc-V, or loongarch.

I completely agree with you.

Regards,
Andrea

> 
>       Andrew

