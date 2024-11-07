Return-Path: <linux-pci+bounces-16212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E69C00D0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 10:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9E91C21636
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19F1D7E4E;
	Thu,  7 Nov 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VFb274S8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC01DF75E
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970390; cv=none; b=NV6A+DYtLpldyvxkdNfDSBltVn9GhmENWfdYD9fJmbnAgQvv2AHuHjs/Xs85baOqpLpzDLiNuh+e/0M+crsEnQ4Ur6armWKKzUxQshqhUzTYs9QGHq5sCajLgcVYOyVeBXMCMeFYcynb5IFOVoIjt5Lg+KJ2AGNh5OZmq0IUKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970390; c=relaxed/simple;
	bh=itIxTccP1xTFO0inuTIAI+RJnFggZSY/uZsDkw9QLY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5wu7yPnL4Gd371v5CbwCIeDa4DuRpNoBZrvZDk0P5fa/hAMh7ubuwZzpQrbmboC8soumwzOt2U3wuDOwX/o4yihMcSGssm/2Lj0J7iHPzG9SMBQEoiB1K050bqodOnhHBEgtNCLB/VTGnb7rBpjK7f0yv2dwY44+UqyC5F+wV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VFb274S8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso3170382a12.0
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730970387; x=1731575187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LDS79c1EbW77w8pj3qSP6QnMmTuMvK8jjpykFUSlOEE=;
        b=VFb274S8b7C0+FttbgbYKHMQPTf/hv449FgXGcyFaN6oYkT7K7dPV5LDvGgvThZ1KC
         2Gt7c6kqnTBOO6XcrpwzUo9ayIY2leQ+8+dnlB77/MXy79wOPRsqkAbQIsqJRJDCmGCy
         KmOfIBnhj/7fR1FOo2zQlFC8zIrBkg+NQps9GEpkAn6xYTw7Gm4voVPaB40xeWPaBiWi
         FO2MZZ9Vwoyh4sEfWAmioNSR5IpoKwJ8PVlLIiFZtDLh2Rwa3uz45q27NcQu3KoJ+oKj
         rdkO7l9O4vy+o0V7cEsllJ/YBqvDLf2n0QH14uMTXmouUfTW4ZnJmuFEaP/bPImVnQFT
         RjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730970387; x=1731575187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDS79c1EbW77w8pj3qSP6QnMmTuMvK8jjpykFUSlOEE=;
        b=TUDS4OG9JEL2Nu9oo/MBuL4hdWBmZ8T87zPkpR/PGJ3gfU3q9g8mbjaANy/YbEjHxm
         PgtoCMZmcAEEFYuSBkQb22XQk0ImQV48iDcORxgJuPjSPjNGWxSN9vUOD7Bsc6IlbFJM
         M9P+VEPC/DhktwAbzur4gYGFoePRd2Rv0hg/1kHarnVMx3lLS44e/yQbI7psm7VHmGh3
         ItABYHvppr78a5zn0kaBQY4swphL3ofXIdovK4FJK4fdFDE8yni5DEu2Z6lGDQm7hXqQ
         ZZ5WPnMbHBZdNKrjcqn0bczTjYKklckGXsaBkrqWXEBw0kFgGCIfXwZJwAIybv4qWCr2
         GjDA==
X-Forwarded-Encrypted: i=1; AJvYcCUSdAT8BErxak71tfbvnGACS3DGECMCJ8+/tMRXd3tMkKB5mgC34LmLOhr8SroP2Q684yHqxRh8hhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPNeOCA0w8gqI9Vf3NQLQ5rBctYqXYCL7IMnn5q10EB+RbE8a
	gENqehrKF43u4xb4ImFeZzdYzB7uqKU6MduxhMC7kIG2Ylt9TqXXVTmLpQXkDQE=
X-Google-Smtp-Source: AGHT+IFON3UoYGa4dZUjWhusmO+MQQIyUIBnD4omw89HENTEvvSMRWoF17W5/XTmfi7sq10ML4ePGw==
X-Received: by 2002:a17:907:930d:b0:a9a:ca:4436 with SMTP id a640c23a62f3a-a9ed4cb3071mr214594766b.13.1730970387092;
        Thu, 07 Nov 2024 01:06:27 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defba9sm63637066b.165.2024.11.07.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:06:26 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 7 Nov 2024 10:06:53 +0100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
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
Subject: Re: [PATCH v3 05/12] PCI: of_property: Assign PCI instead of CPU bus
 address to dynamic bridge nodes
Message-ID: <ZyyDLaWsikcNw4wT@apocalypse>
References: <20241104150521.r4hbsurw4dbzlxpg@thinkpad>
 <20241104234937.GA1446920@bhelgaas>
 <20241106143511.2ao7nwjrxi3tiatt@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106143511.2ao7nwjrxi3tiatt@thinkpad>

Hi Manivannan,

On 14:35 Wed 06 Nov     , Manivannan Sadhasivam wrote:
> On Mon, Nov 04, 2024 at 05:49:37PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 04, 2024 at 08:35:21PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Nov 04, 2024 at 09:54:57AM +0100, Andrea della Porta wrote:
> > > > On 22:39 Sat 02 Nov     , Manivannan Sadhasivam wrote:
> > > > > On Mon, Oct 28, 2024 at 03:07:22PM +0100, Andrea della Porta wrote:
> > > > > > When populating "ranges" property for a PCI bridge, of_pci_prop_ranges()
> > > > > > incorrectly use the CPU bus address of the resource. Since this is a PCI-PCI
> > > > > > bridge, the window should instead be in PCI address space. Call
> > > > > > pci_bus_address() on the resource in order to obtain the PCI bus
> > > > > > address.
> > > > > 
> > > > > of_pci_prop_ranges() could be called for PCI devices also (not just PCI
> > > > > bridges), right?
> > > > 
> > > > Correct. Please note however that while the PCI-PCI bridge has the parent
> > > > address in CPU space, an endpoint device has it in PCI space: here we're
> > > > focusing on the bridge part. It probably used to work before since in many
> > > > cases the CPU and PCI address are the same, but it breaks down when they
> > > > differ.
> > > 
> > > When you say 'focusing', you are specifically referring to the
> > > bridge part of this API I believe. But I don't see a check for the
> > > bridge in your change, which is what concerning me. Am I missing
> > > something?
> > 
> > I think we want this change for all devices in the PCI address
> > domain, including PCI-PCI bridges and endpoints, don't we?  All those
> > "ranges" addresses should be in the PCI domain.
> > 
> 
> Yeah, right. I was slightly confused by the commit message. Maybe including a
> sentence about how the change will work fine for endpoint devices would help.
> Also, why it went unnoticed till now (ie., both CPU and PCI addresses are same
> in many SoCs).

Sorry for the (admittedly) confusing explanation from my side. What I would
have really liked to convey is that although the root complex (that is itself
a bridge) is the ultimate 'translator' between CPU and PCI addresses, all the
other entities are of course under PCI address space. In fact, any resource
submitted to of_pci_set_address() is intended to be a PCI bus address,
and this is valid for both sub-bridges and EPs.

> 
> Also there should be a fixes tag (also CC stable) since this is a potential bug
> fix.

Sure. I think it could be better to resend this specific patch (and maybe also the 
patch "of: address: Preserve the flags portion on 1:1 dma-ranges mapping", which
is also a kind of bugfix) as standalone ones instead of prerequisites for the RP1
patchset, if it's not a concern to anyone...

Regards,
Andrea

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

