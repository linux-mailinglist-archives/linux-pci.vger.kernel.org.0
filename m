Return-Path: <linux-pci+bounces-18738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD59F711A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5806916206A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311B198845;
	Wed, 18 Dec 2024 23:44:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63935956
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565441; cv=none; b=Mta34R2BjHgVuASTFJABqlJ5OyhcMnKHLMr8BL8iwuns34XlfaCCmJDcXFnFC9+9eO5HXQfsQr0rz0MTlRJXUvypVEjrpD4VFvYVqYJqpDRQturOQHexVNWq8tNERaJFOlAc24rKuEe/Pep6cHgpClo14soXBDIOr5ABBM5lgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565441; c=relaxed/simple;
	bh=W0MwN3h2JUI8ekmw1ruBai/jTtierv5du7hD+TRQO3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxfb2cPMhnpLgQ6jax6oqQNg5v1JjqloW8Ce4UyHNZY0k9mtJDBFJwaNsSDynKtZaFCYH5fYj9A44QBYhox+wNns1UBzelimUZMUunx+vp7F28Vq2XeGDuk8lmkv80npClSrojyznF0xFw4og8MNuTxTHw+9TkK9ApMd12V4AbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2162c0f6a39so12595435ad.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 15:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734565439; x=1735170239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9yf7928fZMYbRQAPvUkDr+K5B0xiWhnjzZrwy0SqIU=;
        b=H5HtU/yaAwl+rKtw8MJutsTUdNw9PKb0AdNyXwY3ZD5ZulVGGYSU/t684FvotYr3Fy
         sC2f9tnwun0AWRwHPmKgpPRucaW8pJq+rX+fRBPGu4VLv4+9oHLg+yRSWXFP4vTBu0Z6
         NpSD2nrNSE9PkpjG8nZcREFvFryBHpMk9fFo9EZ5SwtcHezMzmgN3twJRzDVDspiRIk+
         ZUwbHNRe6+w6tC+A8+ULCIYFcBNkMODOU9RyfjJuGbmm1Q/cPrW28cMQZYfjtmuGd3+D
         yTmqxfdp04Ekv2SRJbNQvjT20cR6sZJolTzYGw9bpTTy9ABuhVvZ96qUkdGfi2itl81n
         0dRw==
X-Forwarded-Encrypted: i=1; AJvYcCWTpT4uvDksHsRzbdkxB6+zFm03mbz8BGEGXu3XTLAym/gbMHtpsy6FJs0aJ8KHMGeKWlJZGYrhXcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvRnk/4YEp34HK03SMC4mRL7tHam2GtVCJr8rezvN2LeNVUSFK
	XTMkgDA5yAUtOWRrYaYkdaZtBYRRES9PHUK/FEY5ZqMK+y62F8+I
X-Gm-Gg: ASbGncumk/l2mYMbUYHspFN8sra9C98zLkonJgzOkrlFt4wGIo2QP2goBXQiGfUYeAL
	GbRQ2p34icGk2ZP6uxrgjoNbxTndwIqQXMBSkqwYlN2Yb4BTye84iApUt77KvjgJNlDE5gIzeFJ
	BZhP4WwmuDpHoZ0efXGp26IsiRKhKJuvzRwkRwX7Uqn9F3HY4FQR7B1fEoTE2Mr4pGy5ITco+60
	Flt2p/Q4FOlxNCUHYWK1nV26h4MtCOFZE2i8PET7bBphBCd8M9OXyp4ko4+YMugNIDWNWUwfpyg
	2cFp+s13p0sUp5U=
X-Google-Smtp-Source: AGHT+IFCHGXG4Z5AEbyVZS/C7OyPyVSd45vTWdb3h+NBgHmD6oJWHnfa6FFTy1+xjT7nPC8BWodXgQ==
X-Received: by 2002:a17:903:903:b0:215:7287:67bb with SMTP id d9443c01a7336-219da253542mr19836555ad.0.1734565439481;
        Wed, 18 Dec 2024 15:43:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdd88sm856295ad.122.2024.12.18.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:43:58 -0800 (PST)
Date: Thu, 19 Dec 2024 08:43:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when
 determining supported speeds
Message-ID: <20241218234357.GA1444967@rocinante>
References: <cover.1734428762.git.lukas@wunner.de>
 <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
 <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com>

Hello,

> > One user-visible issue addressed here is an incorrect value in the sysfs
> > attribute "max_link_speed".
> > 
> > But the main motivation is a boot hang reported by Niklas:  Intel JHL7540
> > "Titan Ridge 2018" Thunderbolt controllers supports 2.5-8 GT/s speeds,
> > but indicate 2.5 GT/s as maximum.  Ilpo recalls seeing this on more
> > devices.  It can be explained by the controller's Downstream Ports
> > supporting 8 GT/s if an Endpoint is attached, but limiting to 2.5 GT/s
> > if the port interfaces to a PCIe Adapter, in accordance with USB4 v2
> > sec 11.2.1:
> > 
> >    "This section defines the functionality of an Internal PCIe Port that
> >     interfaces to a PCIe Adapter. [...]
> >     The Logical sub-block shall update the PCIe configuration registers
> >     with the following characteristics: [...]
> >     Max Link Speed field in the Link Capabilities Register set to 0001b
> >     (data rate of 2.5 GT/s only).
> >     Note: These settings do not represent actual throughput. Throughput
> >     is implementation specific and based on the USB4 Fabric performance."
> > 
> > The present commit is not sufficient on its own to fix Niklas' boot hang,
> > but it is a prerequisite:  A subsequent commit will fix the boot hang by
> > enabling bandwidth control only if more than one speed is supported.
> > 
> > The GENMASK() macro used herein specifies 0 as lowest bit, even though
> > the Supported Link Speeds Vector ends at bit 1.  This is done on purpose
> > to avoid a GENMASK(0, 1) macro if Max Link Speed is zero.  That macro
> > would be invalid as the lowest bit is greater than the highest bit.
> > Ilpo has witnessed a zero Max Link Speed on Root Complex Integrated
> > Endpoints in particular, so it does occur in practice.
> 
> Thanks for adding this extra information.
> 
> I'd also add reference to r6.2 section 7.5.3 which states those registers 
> are required for RPs, Switch Ports, Bridges, and Endpoints _that are not 
> RCiEPs_. My reading is that implies they're not required from RCiEPs.

Let me know how you would like to update the commit message.  I will do it
directly on the branch.

Thank you!

	Krzysztof

