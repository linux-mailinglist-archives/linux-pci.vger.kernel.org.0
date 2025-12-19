Return-Path: <linux-pci+bounces-43443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95305CD1CF6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 21:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A73D30111AB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F32EB862;
	Fri, 19 Dec 2025 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hN3SPY4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11A2DD608;
	Fri, 19 Dec 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176902; cv=none; b=Xe0aWCW1Uz17EPT4RS1y/k7B4SSv05WzY+Mz32xbGmwB537fZ7eydXPAh83aYw+OJ9KtVEN03/PnScIMiRGy7cYCW7Q2mq0n+0dIhp4pKx9DL4LavFbJVQUG8eDS6nB29vUYplz8q3cyaMebScwFcjYYbnQZfI5AT6UNH87J0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176902; c=relaxed/simple;
	bh=F6AvpRw/MS+EMd7zNmk9+zup2u4TQEOBAZJYKN+n5mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbdQIuoX+VpqQoEcmIWYNaIA+t6fjW0DMPZqcH5ndl2/x2Yk7NuC6ErzjmsUByAjU0azwTFz/ra5uKBBdxvy/YqEpdNN1T+i2NFu89q9knvN4AJpD1S/JUUFlPaqPQdn9n1uYsTMfE2dUF/xDp4zxr06dIT6uNLybNS9YBnDMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hN3SPY4V; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6B375C00153A;
	Fri, 19 Dec 2025 12:41:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6B375C00153A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1766176899;
	bh=F6AvpRw/MS+EMd7zNmk9+zup2u4TQEOBAZJYKN+n5mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN3SPY4VMQFePNoId8up7rtjSG/XVnq48CvD6yIfl8w1JS1pagUq8WbAxhbObSU/f
	 D8U1UdEXDgAGWV7luud3TXbyRPx2yQOZKzEnj4XwvIWCeY3pMr5KCHoF+txcflBv/N
	 qYbT+0X0o/B2/O9TBKdz1mfhnhJXziYRZ/IKHPoE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 019B5A340;
	Fri, 19 Dec 2025 12:41:38 -0800 (PST)
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
Subject: Re: [PATCH 3/4] arm64: dts: broadcom: bcm2712: fix RP1 endpoint PCI topology
Date: Fri, 19 Dec 2025 12:41:38 -0800
Message-ID: <20251219204138.1015487-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <827b12ba48bb47bc77a0f5e5617aea961c8bc6b5.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com> <827b12ba48bb47bc77a0f5e5617aea961c8bc6b5.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Thu, 18 Dec 2025 20:09:08 +0100, Andrea della Porta <andrea.porta@suse.com> wrote:
> The node describing the RP1 endpoint currently uses a specific name
> ('rp1_nexus') that does not correctly reflect the PCI topology.
> 
> Update the DT with the correct topology and use generic node names.
> 
> Additionally, since the driver dropped overlay support in favor of a
> fully described DT, rename '...-ovl-rp1.dts' to '...-base.dtsi' for
> inclusion in the board DTB, as it is no longer compiled as a
> standalone DTB.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/fixes, thanks!
--
Florian

