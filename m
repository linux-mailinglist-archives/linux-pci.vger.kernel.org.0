Return-Path: <linux-pci+bounces-28748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A85AC9847
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C890F5061CA
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C728DB53;
	Fri, 30 May 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F+nhaIP2"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386728D85F;
	Fri, 30 May 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648430; cv=none; b=Xk9npGlejzvuOfOF7ZUFs5BD2CXvZ01sGY4GQwRXxTvakYAJuswRWCW3VxKmatBBYJKGwbeWLRhRih9Xa1y8XfmnfGxjbsET/TPw+p+PFxJP18f+YgDt9idLA5rgpdjiwNKAJ2ljDUBTDx3K2I7zyfbbQ+q//rL0BqW8PKGEyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648430; c=relaxed/simple;
	bh=T1ohdffHOsv4b9JTLNJUeOA9slqM1AlruRXgmQZnb98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx/xPvRtmilYrvFKnOYihDVOuQNhE6lRtY5n305Um5mcTUUzgy56aFuJWY80/UYIk8jDCcyooTD0bySuOcmNfzdT5akTDGizjKyknCISShKX4eUCD1QxP3fRrsICQ3Ij7PKvXC6Iia1okEl4EVMfprIzeKi73kMbtLN9kVCjltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F+nhaIP2; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5FF82C00054D;
	Fri, 30 May 2025 16:40:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5FF82C00054D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1748648428;
	bh=T1ohdffHOsv4b9JTLNJUeOA9slqM1AlruRXgmQZnb98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+nhaIP21q5osUynz/UqGqFQQu5bO7cZ3iM0jDibkxLZeuLtS4fLZF3LlPoZnCSFI
	 pY9Y8bKJZCqnzulkV9x2Lqs1v5Z0ImgDHjDr1kFsnai1NF5Ey4UagDHv8RCT0k3PkF
	 uXjG9lIzx3Tu+LHUEjeRdXaskkrtWoq4fpanZ13M=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 03FC918000530;
	Fri, 30 May 2025 16:40:28 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v12 09/13] arm64: dts: broadcom: Add board DTS for Rpi5 which includes RP1 node
Date: Fri, 30 May 2025 16:40:27 -0700
Message-ID: <20250530234027.465367-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529135052.28398-9-andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com> <20250529135052.28398-9-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 29 May 2025 15:50:46 +0200, Andrea della Porta <andrea.porta@suse.com> wrote:
> Add the fully populated DTS for RaspberryPi 5 which includes
> the RP1 node definition. The inclusion tree is as follow (the
> arrow points to the includer):
> 
> rp1-common.dtsi ----> rp1-nexus.dtsi ----> bcm2712-rpi-5-b.dts
>                                                ^
>                                                |
>                                            bcm2712-rpi-5-b-ovl-rp1.dts
> 
> This is designed to maximize the compatibility with downstream DT
> while ensuring that a fully defined DT (one which includes the RP1
> node as opposed to load it from overlay at runtime) is present
> since early boot stage.
> 
> Since the preferred board DT is the fully populated one, name it
> bcm2712-rpi-5-b.dts and move the previous one into
> bcm2712-rpi-5-b-ovl-rp1.dts.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

