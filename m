Return-Path: <linux-pci+bounces-27787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B274AB8651
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80E716407B
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19521FF46;
	Thu, 15 May 2025 12:26:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E661F0E20;
	Thu, 15 May 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312017; cv=none; b=ry7DsHtw6V/oSpNgajpi9hKskLT4MmAWgRQTF7rfAV9LKXNRxLWhlk9pm4XzjWnFeDsrCxFLMbffTfm1t4drREH4ZQPaHVysXyfoknHXQ2rjRWSZGfxNecSLvEh0EKkoe1wU/mlInrU2GOby8+GlWY1KqxWInNwZC5TNuKBWvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312017; c=relaxed/simple;
	bh=6pAnn+UekFJZ8a8ublbvD3EYf+TORa8O6LbEZm5kWbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqNr7VMKntR8pxsTCX/fGKHI0tdWt5UkS5DqTMT2VKTYoooELWRyTP9+jkm+JeR+W29VMPBkHSsSvyi3MjZiP6Mi/2DWO8w7WEi13hsL6sJX2RQNJsHzctjYQDHmMHnGNEGAJE33vBo4UdVvb+k64UyZ1Dl/bLJRUuRT1iJW6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 265132C00584;
	Thu, 15 May 2025 14:26:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 11D3844E5A; Thu, 15 May 2025 14:26:53 +0200 (CEST)
Date: Thu, 15 May 2025 14:26:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <superm1@kernel.org>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCXdjWaKpHST79ZO@wunner.de>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
 <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
 <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>
 <aCXW4c-Ocly4t6yF@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCXW4c-Ocly4t6yF@black.fi.intel.com>

On Thu, May 15, 2025 at 02:58:25PM +0300, Raag Jadav wrote:
> On Wed, May 14, 2025 at 11:25:36PM +0200, Denis Benato wrote:
> > I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.
> >
> > You can see the dmesg here: https://pastebin.com/Um7bmdWi
> 
> Thanks for the report. From logs it looks like a hotplug event is triggered
> for presence detect which is disabling the slot and in turn loosing the
> device on resume. The cause of it is unclear though (assuming it is not
> a manual intervention).

When an Endpoint transitions to D3cold, the link to the Endpoint goes
down.  If the Downstream Port above the Endpoint is hotplug-capable,
it will see a Data Link Layer State Changed event as a side effect.
If it doesn't support out-of-band presence detect, it will also see
a Presence Detect Changed event as a side effect.

As a workaround, graphics drivers invoke pci_ignore_hotplug() and that
will cause pciehp and acpiphp to permanently ignore any hotplug events.

In v6.16 there will be a new pci_hp_ignore_link_change() and
pci_hp_unignore_link_change() API to tell PCI hotplug drivers that
DLLSC and PDC events shall be ignored temporarily:

https://git.kernel.org/pci/pci/c/2af781a9edc4

I intend to replace pci_ignore_hotplug() with this new approach,
as explained here:

https://lore.kernel.org/r/Z_nfuGrVh_CO7vbe@wunner.de

I'm not sure though if that will help with the issue at hand.

Thanks,

Lukas

