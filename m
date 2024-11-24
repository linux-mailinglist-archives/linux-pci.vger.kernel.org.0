Return-Path: <linux-pci+bounces-17266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14A9D77E5
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 20:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CAF162BCF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FE155A52;
	Sun, 24 Nov 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PknNvkSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E722500A6;
	Sun, 24 Nov 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732476383; cv=none; b=CbFG4sh5Nhfem4Is/OJJisgVKUI8t9RCbV1Oz9Hn7yEdUm35lTjcv+shfnf+pYqdjow8GnrTTfGjpYBOZ9ghJx+s3jhDrbtbsvDQPi3MBKnHSXCZKPMJqjd6dacK4UtXB3ndV6bothIckzYl8fWOv280BPH6Ig7xjrUGRGLUlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732476383; c=relaxed/simple;
	bh=1qIuIvpK2MuhI/SQRLZVbgKJw5u3DWeW/6z9aow2UFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j80rMhWZy638JeCQv7zjRBniX5IT5/1C0F9OIbCvmWrC2SnR7IkoHw1aU+yERvflJu2cheZy1otZ815SqJGXGb8IucKFUFEQygzM9YKoy1PXMVkEG63ueMbjUUUWi9FWTav+eeqh8jezB+VkhPVYHQPufNhkjz0ptuOWtSOpRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PknNvkSM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i3bP0t16qsr90BwN1tiQOKPDR7z/6lXOBhQWdTBTAaU=; b=PknNvkSMC52LiAhA92txLc/aKX
	447dPAd8ahF9BHssahwaLfnKSsifKDkUd4TYXyjF4o6JEW4XQQFdhGrop/Qf/mwgGR0oNpvHs7xh2
	GcH42RuOLGW36Dks561K1Eb7Vf4RK/3p4gB49E1sC7CMYd+mADqhuVEbWT3QVXisIBZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFIF7-00EJWL-1B; Sun, 24 Nov 2024 20:26:01 +0100
Date: Sun, 24 Nov 2024 20:26:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <22e08939-fa89-4781-824e-1ea01648fb1b@lunn.ch>
References: <cover.1732444746.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732444746.git.andrea.porta@suse.com>

> This patchset is also a first attempt to be more agnostic wrt hardware
> description standards such as OF devicetree and ACPI, where 'agnostic'
> means "using DT in coexistence with ACPI", as been already promoted
> by e.g. AL (see [4]). Although there's currently no evidence it will also
> run out of the box on purely ACPI system, it is a first step towards
> that direction.

When combined with CONFIG_PCI_DYNAMIC_OF_NODES and this patch series:

https://patchwork.kernel.org/project/linux-pci/cover/20241114165446.611458-1-herve.codina@bootlin.com/

It probably does work, or is very near to working. Bootlin appear to
have the LAN966x working on an ACPI system, and what you are adding is
not very different.

I'm also currently playing around in this area, trying to instantiate
some complex networking hardware using DT overlays on an ACPI system.

     Andrew

