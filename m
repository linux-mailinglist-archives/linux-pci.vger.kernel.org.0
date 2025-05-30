Return-Path: <linux-pci+bounces-28747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE97AC9842
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 01:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A2BA45F5F
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBC28D85A;
	Fri, 30 May 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xau7hgHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC428D836;
	Fri, 30 May 2025 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648429; cv=none; b=cwskxcwHjRIguyLSrO5I52gNrw8N7EAMAptWQ2HfLUBKKvmqucV6SE+xPtaVi7sqJiHXPWH+bYnt7FszDuIC7pV+IRVJeQOVUQInUXc0ej7to5uynWcxC3Ccf0nviLHNpOspPwEgpy9MKdW3e2aXHfkz1/yy/gzwd8b3Y4Mpn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648429; c=relaxed/simple;
	bh=HFiVtogORiAI/oF4a+jzZLzZYQ+/3mOas55PYUhzW9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhvVIagJEKio+idbKBMXkwpZexuPmEc6A/qZqVEQXcNaMkDbS/b01p8zV27o4cj3wYJVsSMifVfH4DSTaTZPctVX5sjtK7EX+0yBBBqSiuMFIF+yld9K7nCBBVgyijGObIU+180bd+vz70m3vwQOLxVllcR2Vj7qpBlb3fWjhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xau7hgHN; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B1AA2C003AB8;
	Fri, 30 May 2025 16:40:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B1AA2C003AB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1748648426;
	bh=HFiVtogORiAI/oF4a+jzZLzZYQ+/3mOas55PYUhzW9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xau7hgHNWZ/bUsjnADjxg13st9ZnP1ECq6XKHIdiZ6Uj/0aS/POb5yDLG55eUKwjh
	 5dYiccTqa6Sl3s+K7owrmJSZT6FAxkijkif2Lg/DMK1nUxpRK7MQ++iYniFbfDMUnn
	 qDsBKxxPXOwOrpjwT0skAxSmiqzm6PQ/S9yHxdg8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 2749B18000530;
	Fri, 30 May 2025 16:39:56 -0700 (PDT)
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
Subject: Re: [PATCH v12 06/13] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Fri, 30 May 2025 16:39:55 -0700
Message-ID: <20250530233955.465160-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529135052.28398-6-andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com> <20250529135052.28398-6-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 29 May 2025 15:50:43 +0200, Andrea della Porta <andrea.porta@suse.com> wrote:
> RaspberryPi RP1 is a multi function PCI endpoint device that
> exposes several subperipherals via PCI BAR.
> 
> Add a dtb overlay that will be compiled into a binary blob
> and linked in the RP1 driver.
> 
> This overlay offers just minimal support to represent the
> RP1 device itself, the sub-peripherals will be added by
> future patches.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

