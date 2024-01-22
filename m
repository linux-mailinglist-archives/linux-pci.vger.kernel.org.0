Return-Path: <linux-pci+bounces-2446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07301837607
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 23:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E151C26815
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA643487A7;
	Mon, 22 Jan 2024 22:17:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D784878F;
	Mon, 22 Jan 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961861; cv=none; b=L/c8ipRS7v2sY2kD3YmQyZdqDVe6cgRp+4AfJ3ZP2M/rOSiH4O/4zNUOjzR6VsSbmLtYgn0NSrx0Oc+Sa+NHup67BAsqjh6/T4SW4YXHy6ZJtXBZxlP46E2GCYRtEDM5AvNi6tdm10xX/zujvVElt3Aq0VPFikqC5wVA/8xNZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961861; c=relaxed/simple;
	bh=VXI2zyva/FA7xQVMN8/hQAUXyYWMmB149msEZZUc1/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLAPQwlAvwMV6HOL4evE0DT4GDHmlzBeEx/xg6Ai3JOWTtuShgCyqlUNyutkNuOAU3mIYysdDs62fjP9MmS7VuUjRCc72kSN5vU/vcWwYmYP4ZuTATqhNvAm42U4boKB75phOnH2BTJ/9DDyNGjAWaAsdYsc6c7imbyx9bY5liQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2230F300002D2;
	Mon, 22 Jan 2024 23:17:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1681A30501F; Mon, 22 Jan 2024 23:17:30 +0100 (CET)
Date: Mon, 22 Jan 2024 23:17:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, eric.auger@redhat.com,
	mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
	Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240122221730.GA16831@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
 <20230803171233.3810944-3-alex.williamson@redhat.com>
 <20240118115049.3b5efef0.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118115049.3b5efef0.alex.williamson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:
> On Thu,  3 Aug 2023 11:12:33 -0600 Alex Williamson <alex.williamson@redhat.com wrote:
> > Testing that a device is not currently in a low power state provides no
> > guarantees that the device is not immenently transitioning to such a state.
> > We need to increment the PM usage counter before accessing the device.
> > Since we don't wish to wake the device for PME polling, do so only if the
> > device is already active by using pm_runtime_get_if_active().
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/pci.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> Resurrecting this patch (currently commit d3fcd7360338) for discussion
> as it's been identified as the source of a regression in:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218360
> 
> Copying Mika, Lukas, and Rafael as it's related to:
> 
> 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> 
> where we skip devices in D3cold when processing the PME list.
> 
> I think the issue in the above bz is that the downstream TB3/USB4 port
> is in D3 (presumably D3hot) and I therefore infer the device is in state
> RPM_SUSPENDED.  This commit is attempting to make sure the device power
> state is stable across the call such that it does not transition into
> D3cold while we're accessing it.
> 
> To do that I used pm_runtime_get_if_active(), but in retrospect this
> requires the device to be in RPM_ACTIVE so we end up skipping anything
> suspended or transitioning.

How about dropping the calls to pm_runtime_get_if_active() and
pm_runtime_put() and instead simply do:

			if (pm_runtime_suspended(&pdev->dev) &&
			    pdev->current_state != PCI_D3cold)
				pci_pme_wakeup(pdev, NULL);

Thanks,

Lukas

