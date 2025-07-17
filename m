Return-Path: <linux-pci+bounces-32452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB2B095A3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC24A7CDF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955120FAB6;
	Thu, 17 Jul 2025 20:23:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F82B2D7;
	Thu, 17 Jul 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783802; cv=none; b=VB0iMO90Kwo/9pEOT6s4AqxweSSBdg/KvYSxQCtW05cbnR5zxjoM9huaZSWqVIkuMEvu3h/AzgIfLcQ6qwP1O1Rzua4NLRm8K3FZDr1ucFqm0JTA/hEwHdtdptSEzPjIiheO0vWk1p2gIJPZhPy7/KmQnhIhF86ftlNHOI+YVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783802; c=relaxed/simple;
	bh=XqY5p7zDA5kravuWtxORVPxfgTEVUyJsSIe9PVxcZso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP+xsJncSYoqvvdr5QKRMAL+QJAmMgLsEI/Muawo5yJ7OoEx58Jy9YL1QrzGUUhz5TNfkfmo7eslv2hlQ84myGbQnNaA4gWOZxMsyfqvjDDmveruE3lhkxmc76Sr1SCYaKZsXXdUqv6/dsY7IIhvOWgsRtvtvCk1O4OHxVpHuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A990D2C0646D;
	Thu, 17 Jul 2025 22:23:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 70A2444C264; Thu, 17 Jul 2025 22:23:17 +0200 (CEST)
Date: Thu, 17 Jul 2025 22:23:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew W Carlis <mattc@purestorage.com>, xueshuai@linux.alibaba.com,
	anil.s.keshavamurthy@intel.com, bhelgaas@google.com, bp@alien8.de,
	davem@davemloft.net, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	naveen@kernel.org, oleg@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <aHlbtTxO7mR9XfGX@wunner.de>
References: <20250717172826.22120-1-mattc@purestorage.com>
 <20250717190750.GA2592519@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717190750.GA2592519@bhelgaas>

On Thu, Jul 17, 2025 at 02:07:50PM -0500, Bjorn Helgaas wrote:
> and IIUC, it would be helpful for you to add:
> 
>   - DSP Vendor/Device ID (the Root Port or Switch Downstream Port,
>     which is relatively static, so seems less useful to me than the
>     USP/EP would be)

Right, this is already logged in dmesg upon enumeration of the hotplug port,
as well as available via lspci.

>   - USP/EP Vendor/Device ID

There's no 1:1 relation between link or presence events on the one hand,
and enumeration of hotplugged components on the other hand:  The link
may go up but the kernel may fail to enumerate the component, e.g. because
it was yanked before it could be enumerated, or because the kernel has run
out of MMIO space or bus numbers.

Hence this would have to be logged through a separate tracepoint in
pciehp_configure_device(), not by changing the tracepoints added here.

Thanks,

Lukas

