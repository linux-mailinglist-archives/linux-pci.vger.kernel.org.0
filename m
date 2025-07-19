Return-Path: <linux-pci+bounces-32589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C90B0AE58
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0E116B302
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CBC22DFB8;
	Sat, 19 Jul 2025 07:11:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A631EB3D;
	Sat, 19 Jul 2025 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752909095; cv=none; b=lxfM6tRHWjLWoXeWSupvn3q4c97OJK+v2tIJcSV/JA7krEk/OmGXji55Ie6vYbau4vwAblviEzJ4Uunj4Yz5SUzAQdd1SRq5uCU2WGQ9eUJ5Ln3M0aRR34E46g+oi+THYxos+QzW/bY6QyAuZGEMzT28tHE0XX3hcjrP/mGFESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752909095; c=relaxed/simple;
	bh=6YgL7snu0W4hOdOcQqIYhKMjSngfymntUynFt4Pl4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iehsUpkbNoZaExlD8xZuny7lsYcFLGonD4xNi31fTa907yNIBB9Aff5BRnvy4nPkTh0Uh9XR0PSfstkaAFdXZVTdox2dqNmIvHZDqWQFWGgOTSvOa400q6wXRTLAQinxMR85iST9uOOKVosvNffwtBl8mdyT1EbD44uqO0ADyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9CDA62C1997E;
	Sat, 19 Jul 2025 09:11:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 70E6640DB9; Sat, 19 Jul 2025 09:11:23 +0200 (CEST)
Date: Sat, 19 Jul 2025 09:11:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Matthew W Carlis <mattc@purestorage.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	anil.s.keshavamurthy@intel.com, bhelgaas@google.com, bp@alien8.de,
	davem@davemloft.net, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	naveen@kernel.org, oleg@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tianruidong@linux.alibaba.com,
	tony.luck@intel.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <aHtFG3QsdohG466k@wunner.de>
References: <20250718163532.GA2700834@bhelgaas>
 <fc0ded97-8643-4faa-a606-732bcd4ce4a1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0ded97-8643-4faa-a606-732bcd4ce4a1@linux.alibaba.com>

On Sat, Jul 19, 2025 at 01:23:28PM +0800, Shuai Xue wrote:
>            <...>-120     [002] .....   104.864051: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_CARD_PRESENT
>            <...>-120     [002] .....   104.864081: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_LINK_UP

Somehow I liked the simple "Link Up" and "Card present" strings more
than this. :)

The PCI_HOTPLUG substring repeats what pci_hp_event already betrays,
that this is a hotplug event.

>    irq/57-pciehp-120     [002] .....   104.990434: pci_link_event: 0000:00:03.0 cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, reason:5
>    irq/57-pciehp-120     [002] .....   104.992377: pci_link_event: 0000:00:03.0 cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, reason:0

This contains a lot of terminology specific to PCI *Express*
(versus Conventional PCI or PCI-X).  Either it needs to be
"pcie_link_event" or we need to come up with a structure that
works for non-PCIe as well.

PCI links can be tunneled over Thunderbolt, in this case the
link speed is fixed to 2.5 GT/s (USB4 v1.0 sec 11.2.1), but
in reality is governed by the speed of the Thunderbolt fabric
(which can even be asymmetric).  Do we want to report the
virtual 2.5 GT/s in this case or the actual Thunderbolt speed?
Or do we want a separate trace event for Thunderbolt?

For Root and Downstream Ports, the physical "port" points "downstream",
whereas for Upstream Ports and Endpoints, the physical "port" points
"upstream".  Software interpreting the trace event may want to know
the direction (or whatever one wants to call it) because it cannot
tell from the address 0000:00:03.0 what the PCIe type is.  Having to
look this up in lspci seems cumbersome.  So it may be worthwhile to
include either the port's direction or the device's PCIe type in the
trace event.

Of course, hotplug only exists at Root or Downstream Ports, so any
trace event generated from the PCIe hotplug driver will pertain to
a downstream-facing port.  But the bandwidth controller also binds
to Upstream Ports and its trace events may thus pertain to link speed
changes at an upstream-facing port.

Thanks,

Lukas

