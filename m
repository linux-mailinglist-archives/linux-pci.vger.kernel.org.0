Return-Path: <linux-pci+bounces-11107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20866944A4C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 13:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45291F2269F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59380189B9B;
	Thu,  1 Aug 2024 11:26:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEC189B8C
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511561; cv=none; b=s+aDQSMGJ7PvEaGofKXaqz4RgDQgCdOkrZ3+WtiY8BZYibekop1oP3U0fnlz47epWWBVOOqpzpNrDw5oByvQttbs81QwquezIXYzjzJUso77qgE2YnTBfs9zrdeYrbVDLM0Cmn23WvDf2+21byhOSqO+Vza+sPf0zWDk8Jx04u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511561; c=relaxed/simple;
	bh=/0dossKx5ywew7cei/w9fnOqC4SSY82lDaJgie0JUW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYe78wCnZCoCJMWN2jB6r3LZYdffPrwWRb6ZigkX73KmYtuvnYFNkyOKzewDRtVwXiWJSog/rr382KttzRsTE3mznmrsqJLoxKw9DVuNxcPWusgV49OCTjnN4yC/MfZEG4WzBYMkQKckEL1gDYfM3BVhwZ622QtTKqNBHV/KQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 244AF28141E80;
	Thu,  1 Aug 2024 13:15:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 13C5B70E469; Thu,  1 Aug 2024 13:15:59 +0200 (CEST)
Date: Thu, 1 Aug 2024 13:15:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <ZqtubzCKhDKFwVXM@wunner.de>
References: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>
 <20240711083009.5580-3-mariusz.tkaczyk@linux.intel.com>
 <p6fjcdsvy74hrq7zgar4spyujnbs5rdhyizk7cymqhlmmeuhvt@4imcfutonal6>
 <20240731135117.00004ddf@linux.intel.com>
 <2pkbi2lc46hlpwaemujtxf4rm3hokmynp6rf3vnd6vb6biatp3@qhqmeuv3lbgi>
 <Zqpd0ZgkyQtbrkfd@wunner.de>
 <xarpkxhakscp4zgynu2xy67de7dlb6zk7myzmuh3htja7evose@nrtr46gkyni3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xarpkxhakscp4zgynu2xy67de7dlb6zk7myzmuh3htja7evose@nrtr46gkyni3>

On Thu, Aug 01, 2024 at 11:06:26AM +0200, Marek Behún wrote:
> It is not my intention to be unreasonable, I am just asking questions.
> I am sorry for getting into this discussion this late.

Thanks for your understanding!

> On Wed, Jul 31, 2024 at 05:52:49PM +0200, Lukas Wunner wrote:
> > "Blinking" in the rx/tx activity context means that the LED is turned on
> > when traffic is flowing and off when it is not flowing.  Because traffic
> > is usually not flowing constantly, the LED is "blinking".
> > 
> > In the NPEM context, my understanding is "blinking" means the LED turns
> > on or off *in a regular interval* to indicate that the corresponding
> > NPEM bit has been set.
> 
> Ah! So the LEDs states is not supposed to be managed by hardware,
> but by software? From the userspace?

Yes the LEDs will be controlled through ledmon(8), which is
maintained by Mariusz.

Though conceivably any other piece of software will do as well.

Basically the PCIe Base Spec defines registers to set/get LED states
(NPEM).  And the PCI Firmware Spec defines an alternative ACPI _DSM
interface to control the same LEDs.  The spec says ACPI _DSM shall
be preferred over direct register access (NPEM) whenever _DSM is
available.  The idea apparently being that a portion of the LEDs
is under control of platform firmware and the remaining LEDs are
under OS control.  And by using the _DSM interface, there are no
conflicting register accesses by firmware and OS.

The enclosure vendor is free to use e.g. LEDs which are on
continuously, or they may choose to let certain LEDs blink in a
regular interval.  E.g. the enclosure vendor may decide that the
"failure" LED is red and blinks in a regular interval when its
corresponding register bit is set so that it's easier for an
administrator to identify the faulty drive in a rack full of
other drives with tons of LEDs.

Conceivably we could one day add a led_trigger for some or all
of these LEDs.  Question is whether it makes sense.  Maybe if the
nvme driver can detect a faulty drive it could trigger that the
failure LED is lit up.  The design to use one led_classdev per
register bit was chosen precisely to allow for such future
extensions.

Thanks,

Lukas

