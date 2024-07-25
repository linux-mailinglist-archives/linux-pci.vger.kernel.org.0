Return-Path: <linux-pci+bounces-10802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40F93C956
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF401C2101F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 20:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2C446D2;
	Thu, 25 Jul 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEK+8hNF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDFE11711
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938102; cv=none; b=vFOvIyqhdb5l57e/dO6XEX45WmXsIOMm1riD1UMpsy4k0Qqutg+qQzUBllvKjfkAFm0vHqLWkbeLTBUmRTnK6WFrG281oPjF0Ku7t8ATlfBf6k+ah6zfmWaM/cHtiunMwIElpQhmNkda6VC0CmkhhhujsbXgv+borA1lLrWlpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938102; c=relaxed/simple;
	bh=b9D+xZo2oOLW/bUzEkWWrSsvP+IeKlJswqVxzDr3rco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YmG/NXPaHL4oI2iomUu1gjMfOyPwY5E9iK+rvyfO/aT2Zg6hhTdN0qdg671Rx4eJ+PBQ80FFxITaAHdQCRzWVPYDix47H8lmamKXh//uL3ycOGdKLkFZjgJrzG42v+SfYiY5nwqfuaDDRjqptRhNPAahxvN7eD5E2PqLGcUmZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEK+8hNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97861C116B1;
	Thu, 25 Jul 2024 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721938101;
	bh=b9D+xZo2oOLW/bUzEkWWrSsvP+IeKlJswqVxzDr3rco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iEK+8hNFGliZYPw3AzqoFfXI8EKg2RZlPcNBV+sk/w+3O/E8MqCA3cLV4Vlu7j4Lz
	 M9mMUsxHvaRkTwIUeYUHJw30MI1WLElAokYLcelH71lyV/nfpgao9oHq2JTaeE8gaX
	 rhJRzxRRzCsKIQOlgfARpDDJ9By/orwhahWkPGJTu8aa2QJeTDxTdxNcnWI6Pnj/aa
	 IHCCmNypjR3yZdeYBU4S+Moi//JjKmKVsrF4Z8d0oKADD3kSTvynlLt9fYJWO8JXlg
	 +o458vVwWbjE9UnzeQHsvTJ7KKg4J2S4sqXbz5PhLibfc98ALDciN1IJRg4UrumaKs
	 hBhjbpNErePuA==
Date: Thu, 25 Jul 2024 15:08:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Blazej Kucman <blazej.kucman@intel.com>
Subject: Re: [PATCH v4 0/3] PCIe Enclosure LED Management
Message-ID: <20240725200819.GA856133@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083009.5580-1-mariusz.tkaczyk@linux.intel.com>

[+cc Blazej]

On Thu, Jul 11, 2024 at 10:30:06AM +0200, Mariusz Tkaczyk wrote:
> Patchset is named as PCIe Enclosure LED Management because it adds two features:
> - Native PCIe Enclosure Management (NPEM)
> - PCIe SSD Status LED Management (DSM)
> 
> Both are pattern oriented standards, they tell which "indication" should blink.
> It doesn't control physical LED or pattern visualization.
> 
> Overall, driver is simple but it was not simple to fit it into interfaces
> we have in kernel (We considered leds and enclosure interfaces). It reuses
> leds interface, this approach seems to be the best because:
> - leds are actively maintained, no new interface added.
> - leds do not require any extensions, enclosure needs to be adjusted first.
> 
> There are trade-offs:
> - "brightness" is the name of sysfs file to control led. It is not
>   natural to use brightness to set patterns, that is why multiple led
>   devices are created (one per indication);
> - Update of one led may affect other leds, led triggers may not work
>   as expected.

I see the sysfs interface (/sys/.../leds/10000:02:05.0:enclosure:fail,
etc).  I assume this is intended for things like ledmon?  I think this
should be documented somewhere in Documentation/ABI/ if it's not
already there.

I think that sysfs interface is the same for NPEM and _DSM?

I guess this is basically a newer, better, more generic approach to
the pciehp functionality added by 576243b3f9ea ("PCI: pciehp: Allow
exclusive userspace control of indicators") for NVMe behind VMD?

I suppose it's too late for any hope of unifying all these things in
terms of the user interface?  I guess we're stuck with maintaining
576243b3f9ea regardless since users are using it, but the VMD stuff in
ledmon seems like kind of an ugly special case.

Bjorn

