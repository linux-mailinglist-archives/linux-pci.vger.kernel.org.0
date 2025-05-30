Return-Path: <linux-pci+bounces-28745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A61AC9837
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC937B301E
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979828B501;
	Fri, 30 May 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SuBlRXAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C421772B;
	Fri, 30 May 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648394; cv=none; b=ZwasMMZDhHlgkM3A8Koch37Ev1xHNy8kmyqu5p1MXFhnqTPB10SvWVd1ReR6GMJ4IuErYOtTVlUooic/cA6x6tUvNnH0zRgtRh7OW9DEJ1L7UdfUOEu5pZt8A6N3q3BSJ24Rob7lXaHVSFwdbT6ZZqbPAuhAIRSk7rrhPpF/2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648394; c=relaxed/simple;
	bh=HQLL6oy8ZRg5FLSlf5MShpJ+lnIP0MZVXprcCEo99V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la/l+Fy3fQHzOuMHhzJQl5owc4he/cXo8s7SMTMShhBGE1p1DkbeDwbkoH84kr1POI8JIqG3HmYOQ0Ge8KhAiffrHsQj9Jf6M8X0UtZnFmJ9W1yipF4lmmp8roOEczzzwm7HMmFt89eci3/dGY5tBHO/ypfh9DFf6E0d8REl00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SuBlRXAw; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C8130C00034B;
	Fri, 30 May 2025 16:39:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C8130C00034B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1748648370;
	bh=HQLL6oy8ZRg5FLSlf5MShpJ+lnIP0MZVXprcCEo99V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuBlRXAw1BC0PHXwmqdbyJtiVaTuxhMuFStPEkuRbDydcgL1Ep9qcgSePjyxgpu9r
	 5Hm8Fy7VPQ/AcqRkpude4nhNLrr65rEsCbzDSBOV0LM42e+gioj/51QofO3jOpCgHQ
	 5puLZoUTWiV/NTC8qkeLcxaAGe15oSxPuFwSszmo=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 4947E18000530;
	Fri, 30 May 2025 16:39:30 -0700 (PDT)
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v12 02/13] dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
Date: Fri, 30 May 2025 16:39:29 -0700
Message-ID: <20250530233929.464957-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529135052.28398-2-andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com> <20250529135052.28398-2-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 29 May 2025 15:50:39 +0200, Andrea della Porta <andrea.porta@suse.com> wrote:
> Add device tree bindings for the gpio/pin/mux controller that is part of
> the RP1 multi function device, and relative entries in MAINTAINERS file.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

