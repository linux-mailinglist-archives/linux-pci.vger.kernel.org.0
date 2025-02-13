Return-Path: <linux-pci+bounces-21374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC224A34CAE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B1D3A4B4D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F110221725;
	Thu, 13 Feb 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="cJCGrLX+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9B28A2C3
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469659; cv=none; b=qKNrp+0WkhXNcOBOVRcR7c/TfTbOdZJQETA+Xt22Cj/Mgxo3W0Cqv8l28iLD3etn68ZWG/Ko2NZPWE9SjSVML7FL6QMmysXOijh9pT+usCf/mIqHwGiX6RN/oixAAS22x3iBeaRkUdqcshe+qVoyRVVCQlviy9yiunUTg0QTumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469659; c=relaxed/simple;
	bh=4abGwX6CzCq8We7SpM6V7/PXsy+lszV/t7IY70ml+U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIXUlpsUv8P8oXiiWiw33sdF8GxFiQBm6GASvUcDtFoT7yotwZ4koRCcM74m+rD9WQ6SWcY0+3PacwhlgynfBSG723iY/q0R1ezEOyGs4BWQe0kIEHeVQaDNYMccLgdZuAvhI5YtSHnFmWnswhneqYcMmZens9ErrqfPrKO2iKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=cJCGrLX+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso212027266b.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1739469656; x=1740074456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4abGwX6CzCq8We7SpM6V7/PXsy+lszV/t7IY70ml+U4=;
        b=cJCGrLX+wDKWARKqV36CmQ8v+Y8fjyp2liuM+b6HHeROpMu51/0IkJyyX9+E78Edx8
         8BXOOyB8smbNCYf7SGv8GpQ6RN02D19CjPfSQn8vXnZhR0gFSFPRqf+OrbfzzdKwh+0R
         VMlvu5+gB5geyZ+YsYgzBwrNBp6rE0BtISkAKInDyjNy6EQpEB6gFOyUGreWJ3LaeQsd
         zd9fRqW+ErWYIBZeFeg+sGiwOyi3qvVWWw5aYY0JMvDCJFHkpB6VqBj6EJTfPFs17L5j
         apV2zGKzMeMZaLDxTDfZh/BLXpPfEa2Qoooa/yYVgK7RNkUTYmHUac9MajCY5eyI9qSb
         sbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469656; x=1740074456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4abGwX6CzCq8We7SpM6V7/PXsy+lszV/t7IY70ml+U4=;
        b=JqXEADSt8jccc7xaflHPblvlclJlRQAh+Neb2wwy9KVdEhgorOTv/UklYmKNpgwWhA
         QYU6ikg4m0Y/mXmJjWaJ9+3iftN2GIWAMt9Bw+Wbk+/p1/OqGXoWzmLrJHm2zTW6IUje
         cxUbAIUnWm9plGNTQBQ8Y4uySiYF+ywnMQ6tKZgViEUZhdu0+E3U13E6hSxSVUMs/Aku
         Zk9C3+mwYLD71dmOCyLWHviSx9akutS0mevuf71L4WNMXu+zdOXq/MAXHY/AkmCwrusu
         FZy+xRtAd/ZDLUPHy4aCWfwJ+h2lSt9+l/xsFzWzAV0PCx4Prz1Hz62YnvwhTxVClZ6N
         PVmA==
X-Forwarded-Encrypted: i=1; AJvYcCXrcwZLPXbftXYXygMJ5dHU6R1CTr9Er6zt4VfGg7ww+TqBS+Rxt6tLUBmQ7NqMVDPYT8wpzVGKUZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZWdZbbBcWKyAJZIzzPP+e1yNgcbkh+C6VvZTpD2TnRqC7bpQ
	z9YOMrvLjnsbHfGbe8DPq+zIXLEUwFD+joVUU8RQuRUp/EItfHvBpV2ZaTdnY/7QIwKSuG9YDrp
	exLPqRNF7g+7bS3ofhhcAbXYu7GpzDVjthMbXYg==
X-Gm-Gg: ASbGnct0mDgl/te8Mu+1g5sy7bqXkW3TxTAGasKmYxxJ9OKBmPLUJMfTJ2gszxzJEkV
	M2fwteb6GqDd6u67J2wx4eOH8W9lbBbIz55Ytg8QnYu28+2wA6BcLH4oLB2Qr5pdEGpy6MvJb5V
	SvcTpuJGxfNzjvLoaIxU5wj5l4nmbD
X-Google-Smtp-Source: AGHT+IEPn1vehWPEneMvy4h+MekCpIWgHCiWfjunKXP/Rg/zGzFsLUQXgBKZUi6VnPclc10evNFU6A3yPAiro3jiL5E=
X-Received: by 2002:a17:906:7807:b0:ab7:6369:83fc with SMTP id
 a640c23a62f3a-ab7f34af3d5mr742379366b.38.1739469655305; Thu, 13 Feb 2025
 10:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com> <a3c5103c-829a-4301-ba53-6ef9bd1e74e7@lunn.ch>
 <CAMEGJJ3-JXhin_Ht76EqUNAwLiNisa9PrCrdUzCgj=msGZfb5A@mail.gmail.com>
 <20250213180733.11999e07@bootlin.com> <CAMEGJJ2FB-wwyOtjjCmPJ-vUDpZaV-8MMXxV13qXnKxYSzt9pw@mail.gmail.com>
 <07b973c1-4e35-440c-9009-85302a455912@lunn.ch>
In-Reply-To: <07b973c1-4e35-440c-9009-85302a455912@lunn.ch>
From: Phil Elwell <phil@raspberrypi.com>
Date: Thu, 13 Feb 2025 18:00:44 +0000
X-Gm-Features: AWEUYZk57dt7oMdE7oJWluEUSR6yrcUWkxTlMHydzKGl0ZQ5NYeC-9oOiQGkrQw
Message-ID: <CAMEGJJ3++pZtOEvjAm2zMPVrLxQPtuzBWh4QQzGAt3NWuyyrJQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device using
 a DT overlay
To: Andrew Lunn <andrew@lunn.ch>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrea della Porta <andrea.porta@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, bhelgaas@google.com, brgl@bgdev.pl, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com, 
	devicetree@vger.kernel.org, dragan.cvetic@amd.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org, kw@linux.com, 
	Linus Walleij <linus.walleij@linaro.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, lpieralisi@kernel.org, 
	luca.ceresoli@bootlin.com, manivannan.sadhasivam@linaro.org, 
	masahiroy@kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, saravanak@google.com, Stephen Boyd <sboyd@kernel.org>, 
	thomas.petazzoni@bootlin.com, Stefan Wahren <wahrenst@gmx.net>, 
	Will Deacon <will@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 17:51, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > etc. The same problem would exist for U-boot. Even though RP1 has a
> > standard XHCI controller
>
> Although it is a standard XHCI controller, i assume it is not a PCIe
> XHCI controller which can just be enumerated as a PCIe device?

There are too many sub-devices in RP1 for them each to get their own
function. Instead, they all share a single function, with DT to
declare them.

Phil

