Return-Path: <linux-pci+bounces-11388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BDE949906
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 22:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159EB1C21C62
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C3B1547DE;
	Tue,  6 Aug 2024 20:27:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3540875;
	Tue,  6 Aug 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976073; cv=none; b=EdloIc9FBGc6GGs2biVVgzCo4F1ITXREEe9adkyHsP1qFkTVC4KxuqcQpM6jfmBvX4RW8SSXWN1LC2QR0aoq3zuFYG6hPEg163NGdJdIH4te/e5XcKOm8pe16g5bDmWOjr2UGb+OmAcyU8CSGn0zuBFBxVLFzzfyj5sCA/q61to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976073; c=relaxed/simple;
	bh=hviKw2gsMRb17vKpnsMoBwOyTh4jnXdi7myuXldoCP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieH2916N38xQbteDFNxjZOkMm8y54tRvbdUCeGuFBL9NsZ0JToGWEaMURe0tQ8WVK/PUV2zr3CW4hei4OWcIzJDS4ObfU3J0mvqAVqeszAkqWuFXjK5IW9+hTPP9qrdXARx0rTHlNTE7KPpJNetPJdXDSYR/3J93tFTRgx8Ke9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 962C4300002D5;
	Tue,  6 Aug 2024 22:20:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8EA124D196; Tue,  6 Aug 2024 22:20:39 +0200 (CEST)
Date: Tue, 6 Aug 2024 22:20:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <ZrKFl-dvNSNCWd8e@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad>
 <ZrHITXLkKrDbQKQp@wunner.de>
 <20240806124107.GB2968@thinkpad>
 <ZrIe70Z7uFven8HH@wunner.de>
 <20240806143918.GC2968@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806143918.GC2968@thinkpad>

On Tue, Aug 06, 2024 at 08:09:18PM +0530, Manivannan Sadhasivam wrote:
> Regarding your comment on patch 3/4, we already have the sysfs attribute
> to control whether the device can be put into D3Cold or not and that is
> directly coming from userspace. So there is no guarantee to assume that
> D3Hot support is considered.

If a device is not allowed to be suspended to D3cold, it will only be
suspended to D3hot.

If a port is put into anything deeper than D0, its secondary bus is
no longer in B0 (PCI-PM r1.2 table 6-1) and children are inaccessible,
so they're "effectively" in D3cold.  Hence if a device cannot be
suspended to D3cold, it will block all parent bridges from being
suspended.  That's what the logic in pci_bridge_d3_update() and
pci_dev_check_d3cold() is doing.

The d3cold_allowed attribute in sysfs is just one of several reasons
why a device may not go to D3cold (see pci_dev_check_d3cold() for
details).

The d3cold_allowed attribute was originally intended to disable D3cold
on devices where it was known to not work.  Nowadays this should all
be handled automatically, which is why we've discussed moving the
attribute to debugfs:

https://lore.kernel.org/all/20230918132424.GA11357@wunner.de/
https://lore.kernel.org/all/20231002181025.82746-1-mario.limonciello@amd.com/

Thanks,

Lukas

