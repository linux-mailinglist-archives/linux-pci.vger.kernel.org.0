Return-Path: <linux-pci+bounces-35482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE0B44957
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 00:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AD1C2593F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 22:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C02E6CCF;
	Thu,  4 Sep 2025 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="jj5agdIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597052DCC13;
	Thu,  4 Sep 2025 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024174; cv=none; b=W0SuS4ozE76t//dhgzDDVDHtImvLCESBiqGxlg7UZJFiPEOFgpvr11o/sL/lsGpqhSMVIcJIeSL9dVthuHu9m2FxAW2MCURiu92tihNeq2ySddGwNvUFzdmniEcuQsZUPohfDoK8bz+zfpCrLrOaB5nDkiDlsE4IWCJW1LnwyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024174; c=relaxed/simple;
	bh=FfkRI+Thfq9FLWdeGquE+YXJSXWp3aWZQCznOMbITyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSdt4NF4hsbdyljBC3XjvYx369F/iArlgRjvwiiUJvVPqNpvU09jz1IhyZdoGp/mPu6FdbWhoj0muvIJXRfZkBZHHX6VmESNYtm8N9pAMib1/MftfKKGDuLKAlvzVVzXHrhxakff8ocW9N6VpovYGNIrNdEnWn2AU+t0lNDQuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=jj5agdIu; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 00813C00151A;
	Thu,  4 Sep 2025 15:16:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 00813C00151A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1757024165;
	bh=FfkRI+Thfq9FLWdeGquE+YXJSXWp3aWZQCznOMbITyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jj5agdIupuNpfglCUEa2dAc3pRYIR+M/3P1yNtjfospVkOl8dfiOPDXtFcjcZc0sl
	 eArjms3P9QmpLWWz9ORrwX30AtSoOAraPOsvB//vvB6dy32Khkc8G+s3384E8r85bd
	 e9z4/294XS+ibqTGk0Y2m9N0FdrJIZhZb1BgLxlg=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 58A7C18000530;
	Thu,  4 Sep 2025 15:15:34 -0700 (PDT)
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
	Matthias Brugger <mbrugger@suse.com>,
	iivanov@suse.de,
	svarbanov@suse.de
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: broadcom: amend the comment about the role of BCM2712 board DTS
Date: Thu,  4 Sep 2025 15:15:33 -0700
Message-ID: <20250904221533.227156-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <47f6368a77d6bd846c02942d20c07dd48e0ae7df.1754914766.git.andrea.porta@suse.com>
References: <cover.1754914766.git.andrea.porta@suse.com> <47f6368a77d6bd846c02942d20c07dd48e0ae7df.1754914766.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Mon, 11 Aug 2025 16:12:35 +0200, Andrea della Porta <andrea.porta@suse.com> wrote:
> Current board DTS for Raspberry Pi5 states that bcm2712-rpi-5-b.dts
> should not be modified and all declarations should go in the overlay
> board DTS instead (bcm2712-rpi-5-b-ovl-rp1.dts).
> 
> There's a caveat though: there's currently no infrastructure to reliably
> reference nodes that have not been declared yet, as is the case when
> loading those nodes from a runtime overlay. For more details about
> these limitations see [1] and follow-ups.
> 
> Change the comment to make it clear which DTS file will host specific
> nodes, especially the RP1 related nodes which should be customized
> outside the overlay DTS.
> 
> Link
> [1] - https://lore.kernel.org/all/CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com/
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

