Return-Path: <linux-pci+bounces-29807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A74AD9A96
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FB97AA251
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578092AE99;
	Sat, 14 Jun 2025 07:14:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA62E11D0
	for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2025 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885266; cv=none; b=pZ2CbbjGpstZFKeze++ew8tQ5qcx6t8dPMj5NvmgkgAK5+GSqdxmJjG2ZOQXGSN6R8U4pPhIki4kEBBGzjr/jNxIcwG7fkkIAKLKbGNhLCb5g7bel5Meg6XV0BI62YsVIfdwqIcbhk2DnTodjqx/HI0Yvc5vrn8aKJ20jCtmdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885266; c=relaxed/simple;
	bh=ciwRAkbNQT0IVznPOp0s5K6vS7087i/WKAQdOyRf7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzBKzuXS98ZpEGSihm3WxoHRmzcmOGmw2NCuRa8A0IjXhg9zyr/XCjAir8Xq1LbFsTuJOrSDLRjiUheBywIgkN2pKqjypP193QS+Wf4rILyX+aqfwmvmEBlx19xoHG56VxbjTxzYdv0SgDZySCVuo/A8wIsIivuAifGZa1n4Dtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AB02A2C0C6F5;
	Sat, 14 Jun 2025 09:04:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7E52B20D6A0; Sat, 14 Jun 2025 09:04:52 +0200 (CEST)
Date: Sat, 14 Jun 2025 09:04:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Dadap <ddadap@nvidia.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mario.limonciello@amd.com, bhelgaas@google.com,
	Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
Message-ID: <aE0fFIxCmauAHtNM@wunner.de>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com>

On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
> Ideally we'd be able to actually query which GPU is connected to the panel
> at the time we're making this determination, but I don't think there's a
> uniform way to do this at the moment. Selecting the integrated GPU seems
> like a reasonable heuristic, since I'm not aware of any systems where the
> internal panel defaults to dGPU connection, since that would defeat the
> purpose of having a hybrid GPU system in the first place

Intel-based dual-GPU MacBook Pros boot with the panel switched to the
dGPU by default.  This is done for Windows compatibility because Apple
never bothered to implement dynamic GPU switching on Windows.

The boot firmware can be told to switch the panel to the iGPU via an
EFI variable, but that's not something the kernel can or should depend on.

MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
switched to the dGPU on boot, but the kernel is now unhiding it since
71e49eccdca6.

I don't pretend to fully understand the consequences of the proposed
patch, just want to highlight the regression potential on Apple machines
and probably others.

Thanks,

Lukas

