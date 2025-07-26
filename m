Return-Path: <linux-pci+bounces-32964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3DB129AC
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 09:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF83A63DA
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jul 2025 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC91EF389;
	Sat, 26 Jul 2025 07:55:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BB258A;
	Sat, 26 Jul 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516535; cv=none; b=deVx8K7RZ8R8yQV353dCII6oEphyfegS5vg4DedD/HxLe9hP1MzP20fSATD/t+xEN0ssHXIWRqI+Pz3gP57xjpXPa3x5GNlBpuOawbfA5EXoVpie46+gtXdcOhpD6eNS1EIwE8PuK+i5nwcEWXyHdyaXug2k1xTFOTc9gNWOiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516535; c=relaxed/simple;
	bh=KsSC6tscOO6pxZLOiKZD54JjV+mZXJxDUbIzS32S1cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4LVjlO3QW+gcyWy/waiTaQ/DTBCLcrzAXhi5DxYF+nkoOhkIZxrDIQqi/IL5vQpqsekfbOejtm9cqZCzUXLdwR9qlxbT346tyaPQs9M+OqIdmVMwvuvlDCFiJJ7NKrPtf++BJatNZQsi/rO6Klcz/lsQOxWPdrFmrJs05+2Kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id CC3C82C0710F;
	Sat, 26 Jul 2025 09:55:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 924F02ED3D9; Sat, 26 Jul 2025 09:55:24 +0200 (CEST)
Date: Sat, 26 Jul 2025 09:55:24 +0200
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
Message-ID: <aISJ7MG3zbMRuc_Q@wunner.de>
References: <20250718163532.GA2700834@bhelgaas>
 <fc0ded97-8643-4faa-a606-732bcd4ce4a1@linux.alibaba.com>
 <aHtFG3QsdohG466k@wunner.de>
 <25285fbd-ffab-49e5-a8be-e3a1c8e70d3c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25285fbd-ffab-49e5-a8be-e3a1c8e70d3c@linux.alibaba.com>

On Mon, Jul 21, 2025 at 09:17:55PM +0800, Shuai Xue wrote:
> 2025/7/19 15:11, Lukas Wunner :
> > PCI links can be tunneled over Thunderbolt, in this case the
> > link speed is fixed to 2.5 GT/s (USB4 v1.0 sec 11.2.1), but
> > in reality is governed by the speed of the Thunderbolt fabric
> > (which can even be asymmetric).  Do we want to report the
> > virtual 2.5 GT/s in this case or the actual Thunderbolt speed?
> > Or do we want a separate trace event for Thunderbolt?
> 
> I'm not a user of Thunderbolt, which way do you prefer?

Keep reporting the virtual 2.5 GT/s in the PCI tracepoint and
maybe add a separate tracepoint later in the thunderbolt driver
to report the Thunderbolt speed.

Thanks,

Lukas

