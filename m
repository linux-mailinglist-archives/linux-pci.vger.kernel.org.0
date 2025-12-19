Return-Path: <linux-pci+bounces-43445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F4CD1D44
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751BF30AD680
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83412D9EE7;
	Fri, 19 Dec 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cRys4NeC"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B622C21FE;
	Fri, 19 Dec 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177228; cv=none; b=eh505jUIG7Gv3k+lBluY45vtoZ74o5QJhv3ZW4RBmYCD4GDuLpMKKIDfyaa4abEtykGdqYwhEKfZ0r7EVDvW9AZfZ0XmzgISExRSEoql9cSyUuUeDO9qqsQwJCKO7qWKlOq9/sFOrcJVpWjZr/lAj+c2MXMVVpLHnyVQYeQv16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177228; c=relaxed/simple;
	bh=lZ0bxC35naE5+wUog0cgqIFR4ld8pJimi6uVMVZ57Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ/ZuIaX1HNKLxH624KWKXba8UqGXXBMjM2HIfuYEqeGdEEcEZ2lVY8H4uN6VodkjcNJghbJn29OKqUMuVzKw6TtptaMV8tQarOuSxQoNJDVb4D4H2mdbCkCSONJGnB1SbYL7OkS9jwSLUdJ/xBLHGRGXo11xa7sQdFQqgiqoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cRys4NeC; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B992DC000C85;
	Fri, 19 Dec 2025 12:41:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B992DC000C85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1766176917;
	bh=lZ0bxC35naE5+wUog0cgqIFR4ld8pJimi6uVMVZ57Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRys4NeCPx6M6/fxqgmh571+lNk3oKoaXsmnkKrunE1LmpaCBpZIwtwkjNa9b+CuQ
	 R+Hc3vVxTpEeULcrHiBih8YSTVhQsAxRIIViETdQmBBaAEqwMH6k8q4qFkAyTS6wos
	 H/9d2znu9giDTH0vOnwIs6S5sGltwF5jMQfteUSM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 49451867F;
	Fri, 19 Dec 2025 12:41:27 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/4] misc: rp1: drop overlay support
Date: Fri, 19 Dec 2025 12:41:27 -0800
Message-ID: <20251219204127.1015395-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4b0aa7160877cf128b9bc713776bcac73c46eb24.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com> <4b0aa7160877cf128b9bc713776bcac73c46eb24.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 18 Dec 2025 20:09:07 +0100, Andrea della Porta <andrea.porta@suse.com> wrote:
> The RP1 driver can load an overlay at runtime to describe the inner
> peripherals. This has led to a lot of confusion regarding the naming
> of nodes, their topology and the reclaiming of related node resources.
> 
> Since the overlay is currently not fully functional, drop its support
> in the driver in favor of the fully described static DT.
> 
> This also means that this driver does not depend on CONFIG_PCI_DYNAMIC_OF_NODES
> and no longer requires PCI quirks to dynamically create the intermediate
> PCI nodes.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/fixes, thanks!
--
Florian

