Return-Path: <linux-pci+bounces-7411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CAB8C3B02
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 07:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32971F210EA
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216E146006;
	Mon, 13 May 2024 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="YVkG6mJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F271CD3D;
	Mon, 13 May 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579014; cv=none; b=IoD9VWKUHMML5WpjTfaFYu5ZYVR4NUwmo8IlBQm6FjvuZvljnQCVTJChWBOpm9pAtI0kvKs6cteDIBWM7UgY/NZxD54FeCxyy6JKd1MmiqPlWsQjcYy6XSxuKYTXdHsJvYjnrFc+r1ucfi6sY86PiYfMUj7ZoJV5tCADsURiuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579014; c=relaxed/simple;
	bh=FSWuB8V/ziHZXymqKaREbNvUpk0luMlL6NoUqq2UHIQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZBnHi+tGEyxEbIayFTU/tHwXYveNblq9BMiJ0mREK2tJazfAMr0ZSt1aQRPv3qZEOZ8P2kLeSAEjgWFZuBvU3iNfHZqRe8jcAbhlvXlLhCLniIKU98tHUOE4VY6q2v68z7ydTE+QhWTKlXkCuRIkJRm+04j0fdpr/dHK1WU0NxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=YVkG6mJA; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4Vd7Fk1wslzDRb;
	Mon, 13 May 2024 01:24:10 -0400 (EDT)
Received: from xps-9320 (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Vd7FQ3sSlzFhw;
	Mon, 13 May 2024 01:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1715577836; bh=FSWuB8V/ziHZXymqKaREbNvUpk0luMlL6NoUqq2UHIQ=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=YVkG6mJAcCDWq9LZch2Xv+mEpNd/ogPeCa6xG0YBPZ/EmtfS2n1y2mJWIhLL8JZDW
	 i3ENakYG/ZWVMXB2pCouZWDaM8ycJKhJq3DmrDR0yrhiyjMptAEuPNz6m3tRXNThko
	 sNZzBIK2J670YfkM9fRXiGJaV/hyOI1yiWIMP+yY=
Date: Sun, 12 May 2024 22:23:53 -0700 (PDT)
From: "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: "David E. Box" <david.e.box@linux.intel.com>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, vidyas@nvidia.com, 
    bhelgaas@google.com, kai.heng.feng@canonical.com, 
    andrea.righi@canonical.com, vicamo.yang@canonical.com, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Ricky WU <ricky_wu@realtek.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org, 
    linux-pci@vger.kernel.org, Thomas Witt <kernel@witt.link>, 
    Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
In-Reply-To: <20231227000338.GA1484308@bhelgaas>
Message-ID: <7288cce6-288e-7e13-ca9-865e69287e48@panix.com>
References: <20231227000338.GA1484308@bhelgaas>
Errors-To: kenny@panix.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Sat, 4 Nov 2023, Kenneth R. Crudup wrote:

> I'd bisected it to the following commits (in this order):
> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programming

So the good news is the above two have made it into (the recently-released) 6.9!

Now I'm rooting for these last three:

> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead

Applying (refactored for 6.8+ versions) of these last three enable full power
savings for 6.9 .

        -Kenny, fingers crossed

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

