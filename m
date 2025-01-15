Return-Path: <linux-pci+bounces-19864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D601CA11E26
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25A916A1CD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3EB24169D;
	Wed, 15 Jan 2025 09:33:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FD241690;
	Wed, 15 Jan 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933632; cv=none; b=K/nJzbI0GrusO5HoVdNW3rXE1QC6E3rD1p0z9ik0PdrDFNKJBmraV+p1YdzmGNgIIp40uJ62f1CY9hDy/UNpiXj7Cm4PFL7ai8viIcmv02Ks5b0ws8c6kmpPFsJTbBqaOQHyb5MRMMeG4B8Vl0mycnbw5DuHiY5CxBSWv3dGriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933632; c=relaxed/simple;
	bh=rPedh11dT0oJwg/Xb4ToTc99PKg9NVbmT6XR5tCk/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP7abd2A8LAgyNtw4wPCrM9SSusyXXWL86YWz3Apj7sZYdd8J382Z9pd1di/S5Ma3amjlnE+kYkruckAY3wZqy9aNnKc+b/7wNLMhM9+hUcyG1CUdl6fznH3BJOu62Q4ZxLQKiAsLaFV2mC+CVXf04DXg0E7gTbrp5Ov3tV/41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id DBFEA2800BB78;
	Wed, 15 Jan 2025 10:33:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CAD094EE5E5; Wed, 15 Jan 2025 10:33:39 +0100 (CET)
Date: Wed, 15 Jan 2025 10:33:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
	bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <Z4eA866i9eup6os3@wunner.de>
References: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
 <20250114214103.6b45d30d@gandalf.local.home>
 <7b482de1-fa19-45d6-bd05-f1c3ebb77192@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b482de1-fa19-45d6-bd05-f1c3ebb77192@linux.alibaba.com>

On Wed, Jan 15, 2025 at 11:59:13AM +0800, Shuai Xue wrote:
> 2025/1/15 10:41, Steven Rostedt:
> > On Wed, 15 Jan 2025 09:37:53 +0800 Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> > > +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> > > +					   slot_name(ctrl),
> > > +					   PCI_HOTPLUG_LINK_DOWN);
> > 
> > Hmm, can't you just pass in the ctrl pointer to the tracepoint?
> > 
> > 			trace_pci_hp_event(ctrl, PCI_HOTPLUG_LINK_DOWN);
> > 
> > Then the above would be:
> > 
> > 	TP_PROTO(struct controller *ctrl, int event),
> > 
> > 	TP_ARGS(ctrl, event),
> > 
> > 	TP_STRUCT__entry(
> > 		__string(	port_name,	pci_name(ctrl->pcie->port)	)
> > 		__string(	slot,		slot_name(ctrl)			)
> > 		__field(	int,		event				)
> > 
> > and everything else could be the same.
> 
> Maybe it's not a good idea.
> 
> I think pci_hp_event is a generic event for pciehp, shpchp, octep_hp, etc.
> But each hotplug driver has different `struct controller` and slot_name().
[...]
> So, IMHO, pass port_name and slot_name from each driver is more simple.
> 
> + @Lukas for hotplug part.

You're right Shuai, there's several hotplug drivers in drivers/pci/hotplug/
and pciehp is just one of them.  It's quite possible that other drivers
besides pciehp will want to add trace points as well.  For consistency,
the trace event definitions need to work for all drivers.

Thanks,

Lukas

