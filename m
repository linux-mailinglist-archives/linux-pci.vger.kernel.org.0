Return-Path: <linux-pci+bounces-8961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451990E688
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22C51F21972
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59F78281;
	Wed, 19 Jun 2024 09:08:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD47770F5
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788118; cv=none; b=mxcC4GlHVA6xRVYbYxWh6omypVLTyje5q0kaLEYc1Q5CNW288I1toOu5Idfke4DUd3KZRCQx2HRzTDFuXlEb2BAMYXqtRgA9txYy/qRYAFLyG3hBrU84fKzGAMkTeQULtVtOdfHDs4YR/2paj7b4suyZpDAEkmJeaaffNKTrS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788118; c=relaxed/simple;
	bh=6uV3pkHmFPwbrkcWHqRpg87sZK4r6vAnptiBPwOdYrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoNX3JCwxlKQEt4btf5qUrcWk4qe+fE10CgC2atKWokGaJUB5D9s/SwdZ38upEN2W8rhk8UBJCZ/7l+aeRxxLvE88/jFUv82gwHmKTo6mCzF1tuoEAgc7KclSm3rBSQZQgi3wmKC7jY+vrNQmFWFsqbUty7S3DK1VBmVmwu+1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AF22B28008786;
	Wed, 19 Jun 2024 11:08:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9E685393EEB; Wed, 19 Jun 2024 11:08:26 +0200 (CEST)
Date: Wed, 19 Jun 2024 11:08:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: stuart hayes <stuart.w.hayes@gmail.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <ZnKgCos9ZwVzcKuS@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
 <Zm1uCa_l98yFXYqf@wunner.de>
 <20240618105653.0000796d@linux.intel.com>
 <20ba8352-c1ce-45ba-8cb7-7ef4c02b3352@gmail.com>
 <6671e0d13f20_31012949a@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6671e0d13f20_31012949a@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jun 18, 2024 at 12:32:33PM -0700, Dan Williams wrote:
> It strikes me that playing these initcall games is a losing battle and
> that this case would be best served by late loading of NPEM
> functionality.
> 
> Something similar is happening with PCI device security where the
> enabling depends on a third-party driver for a platform
> "security-manager" (TSM) to arrive.
> 
> The approach there is to make the functionality independent of
> device-discovery vs TSM driver load order. So, if the TSM driver is
> loaded early then pci_init_capabilities() can immediately enable the
> functionality. If the TSM driver is loaded *after* some devices have already
> gone through pci_init_capabilities(), then that event is responsible for
> doing for_each_pci_dev() to catch up on devices that missed their
> initial chance to turn on device security details.
> 
> So, for NPEM, the thought would be to implement the same rendezvous
> flow, i.e. s/TSM/NPEM/.

A different viewpoint is that these issues are caused by the
"division of labor" between OS kernel and platform firmware.

In the NPEM case, Dell servers require the OS to call firmware
to change LEDs.  But before OS can do that, OS has to initialize
a certain other interface with firmware.

In the TSM case, Intel TDX Connect or AMD SEV-TIO require OS to
ask firmware to perform certain authentication steps with devices,
wherefore OS has to provide another interface to facilitate
communication with the device.

It's a complexity nightmare exacerbated by vendor-specific quirks.

Which is why I'm arguing that firmware functionality (e.g. TDX module)
should be constrained to the absolute minimum and the OS should be
in control of as much as possible.  That's the approach Apple has
been following as it's the only way to achieve their close interplay
between hardware and software without making things too complex.

It seems what's keeping this series from working on Dell servers is
primarily that the driver wants to read out LED status on probe.
So I've recommended to Mariusz off-list to do that lazily if possible,
i.e. on first read of a LED's status.

Then if users do try to read or write LED status on Dell servers without
loading IPMI modules first, they get to keep the pieces, sorry. :(


> I am an overdue for a refresh of the TSM patches

No hurry, there's a refresh of the OS-owned PCI device authentication
coming up before end of this month.

I'm taking my "TDX Connect heretic" hat off now. :)

Thanks,

Lukas

