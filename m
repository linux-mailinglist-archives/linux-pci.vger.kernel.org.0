Return-Path: <linux-pci+bounces-16317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103229C1A44
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C331C22CB0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE11E261A;
	Fri,  8 Nov 2024 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y44aBSah"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F871E1C2A
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060876; cv=none; b=d+QjUeZgf4GqVaXKC/3oN5seBMBwbtjlKciVJipehBL2TIKawfujD/4hGllIYwqo/YrJoOHDMh03RTjwP6uRPfhyrzAztDUQL37aNy8yjPHYKYxDYSwenyRq/PtTJ0a516leZzRU/w5uNCGYPkkafoMSpN9OZd70jY8muli2NQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060876; c=relaxed/simple;
	bh=XkGgv5eX9hGP/+6vsdILQJodcuwb2z/IVmUjUdqJ/2g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjZeFfyDhRn+KDVtan1LO7eGgHNcC871w7LDdR4CSOLz6dv48XShoOeKvzLgYCazLowkMBj8LIKvBssqrUgb9uY/ZDOQvmWBnejZvQar0LJzb5q2yPd82KaPxyZOnvZJcM+Av3dRhB1YpDgcAGGbUU5Z71XnL7D76KLA+l3UEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y44aBSah; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so5304032a12.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Nov 2024 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731060873; x=1731665673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnVZ0emV6bVkYUAc532QwJ4he0bCKDKGP+zZEkPy81k=;
        b=Y44aBSahMuLEW64kUDU8e5oWPxHX1p3+jAw2IQ+FDwJah7gKRz1KHXo5GAwFdlxy38
         ejBhlWG2pwG3x/RFPbF+gHpv3heebEVwAG1jqgJzUP7Vi3IDeP+zqc1xwtn3jO/+WkNG
         5lfE9hyQUoAwSgaCY/Eq5oB0FD5uDyCARVECCzN/zovWJAVed5P8cQ9/07gZxrqfmt7y
         HbRTXNZNfbPg9BzfuqxCkuFFEYP85FJbRTe9g1xblZnEQ8ZMv5U7CsLRLYKyWdZZzPUw
         QZYjNdeGhnBTwsgxJjs6FM879C+80DX6VT8jDLS1rxnZgdjLgGqF/kBB/hkEUzJ0t2j1
         nRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060873; x=1731665673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnVZ0emV6bVkYUAc532QwJ4he0bCKDKGP+zZEkPy81k=;
        b=INSGXdcWrEfnfaS+9Vs1xNE0QnR1q+HZnfv82YHEgDhf22XBGlVl1DPBQD5A2pUr2Y
         KfFVKjmPYL5o7YvEQD1obiqZ4lwR6iImOnvc+ICvIkWWtnRmUSjyy6oBLnyiMQO1NgPR
         DkblDTShELtR9ORWavFgEVJlKSn0ApIdeWS0Y73n/E64LX/Sy/D+C+5YNGc3ShGPb9ee
         g8IfaJbT4jPmNTRUBw7XBYse+CtpK2tl2W/XCtYZFaaHnr0Yvm/isjipJFg02odJyp+s
         73lKWnVW30Fh8MgxPosgKH/yO3vrBPmQLkSgNGsf7rOrJtaxybD81z3tntJzfAV1NeCg
         b4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP2y0YOF490ho2uS8BMhXY/CHDWEIvz9NUQDtfq16ROsUffm0lW76Ei7ZEV9joPPMIb5M+VoZ/acM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXpQcMpSU7BKsO+C1US3emhC8aX7L4woSAwmaxw2b4vn5Vyex
	I8UGzqS+PfFQEw0yRXNV+dnBslD5D6EILXqMj7+knkj1Xgjd4npjqOzK9itHcnw=
X-Google-Smtp-Source: AGHT+IGMkZNj149mgtvYpa+dcdi+Hv2GUHkHisgCOmyCoj4UxPuG3y0YVKFRG6NnyfhzAQT2cBQMhA==
X-Received: by 2002:a17:907:9455:b0:a9a:b818:521d with SMTP id a640c23a62f3a-a9eec9cf03dmr279872866b.18.1731060872701;
        Fri, 08 Nov 2024 02:14:32 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c7asm210184166b.96.2024.11.08.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:14:32 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 8 Nov 2024 11:14:59 +0100
To: Herve Codina <herve.codina@bootlin.com>
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
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Assign PCI instead of CPU bus address
 to dynamic PCI nodes
Message-ID: <Zy3koxz4KnV39__V@apocalypse>
References: <20241108094256.28933-1-andrea.porta@suse.com>
 <20241108110938.622014f5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108110938.622014f5@bootlin.com>

Hi herve,

On 11:09 Fri 08 Nov     , Herve Codina wrote:
> Hi Andrea,
> 
> On Fri,  8 Nov 2024 10:42:56 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > When populating "ranges" property for a PCI bridge or endpoint,
> > of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> > In such PCI nodes, the window should instead be in PCI address space. Call
> > pci_bus_address() on the resource in order to obtain the PCI bus
> > address.
> > 
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> > This patch, originally preparatory for a bigger patchset (see [1]), has
> > been splitted in a standalone one for better management and because it
> > contains a bugfix which is probably of interest to stable branch.
> 
> Nothing to say for the patch itself.
> 
> Just here, you mentioned "see [1]" but you didn't provide the link.
> 
> IMHO, this is not blocking for applying the patch but, just for other people
> looking at this email in the mailing list, can you reply providing the link?

Thanks for pointing that out, sorry about that. Here it is:

[1] - https://lore.kernel.org/all/f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com/

Many thanks,
Andrea

> 
> Best regards,
> Hervé

