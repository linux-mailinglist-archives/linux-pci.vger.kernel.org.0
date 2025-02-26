Return-Path: <linux-pci+bounces-22416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDA6A459AD
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 10:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33A7177D1D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15A226CF3;
	Wed, 26 Feb 2025 09:10:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3B22423B;
	Wed, 26 Feb 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561055; cv=none; b=tLgGlTWabYzmnmhSuhfaJBH76S0gagv5wRmi6405HEMexOKiAOLGXrGTa8zgws6EkCZps/4PbW+q3OkbxJfhOoaut5woCtpplExWbpUcLjgu8Yq7hPe+rHFM2DzOW5Tz4e7NGy9n2jMvmq1kU7blJIwHVndTyYI71Ob3BuMdAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561055; c=relaxed/simple;
	bh=rcMqlFYxtJSC7BnsHuZqlms/0j16JvJJLK/QKfFC4VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSeyyLmr9to6nP3ML2d0W4e/tCsD/PSWiO5n+RL5am0CHBf8dHYBw9hZ4TkCJEp7MbtPEnH8jsnoY9jfItLKFe7407QuavIw1beFvd7svkSFhMekTPbvqZ0vDJLrqEOWrpVishHtFLbfx7OHV0ZHpfEgYI760IG+I35o4xOhGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3D7E82800C7D0;
	Wed, 26 Feb 2025 10:10:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3780ECC668; Wed, 26 Feb 2025 10:10:43 +0100 (CET)
Date: Wed, 26 Feb 2025 10:10:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <Z77ak-4YsdAKXbHr@wunner.de>
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226084404.GM3713119@black.fi.intel.com>

On Wed, Feb 26, 2025 at 10:44:04AM +0200, Mika Westerberg wrote:
>   [Meteor Lake host] <--> [TB 4 dock] <--> [TB 3 NVMe]
[...]
> I added "no_console_suspend" to the command line and the did sysrq-w to
> get list of blocked tasks. I've attached it just in case it is needed.
[...]

This looks like the deadlock we've had for years when hot-removing
nested hotplug ports.

If you attach only a single device to the host, I guess the issue
does not occur, right?

Previous attempts to fix this:

https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/

https://lore.kernel.org/all/20240612181625.3604512-1-kbusch@meta.com/

Thanks,

Lukas

