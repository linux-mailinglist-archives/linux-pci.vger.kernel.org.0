Return-Path: <linux-pci+bounces-28105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76FABD907
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECFC4A78A9
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53622D781;
	Tue, 20 May 2025 13:11:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819A101F2;
	Tue, 20 May 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746677; cv=none; b=Uf6D17HcrFct4U9OnOF6aOBGLPbxqSnneXKhZOm15pfuk9LaHReJ0LJD0+3JE88uBBvnlhpA3POOixIEze3AZouSMWGBT8TjZoPwi1tuM6R8i1n9Y4tUmeAaWZZ47tE9nYjcFYJJ4Y6eOyQFlY+5UkHF95/j3dvFZWEgqaNpDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746677; c=relaxed/simple;
	bh=lnhhPRrsOk4MPxnSZJQvFL1yIitI5QzXVX9Hhlx1fa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWjr5oSZe7xBcl5deiwEV3UIdXd4oHBsoNnLKwOBPxvXZJpGEbrAiVF0YSn444+Ivg2tVKgiaaoaxgT74HKLjJnc7/ntxLkOOXc8fJY6pP+QqIvuVi2KFTffjFzhqYrKAyE/v/WwiDslBe0nH/XuzmEs+c6cTUBw+1S9wgo9TWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 040CB20091A5;
	Tue, 20 May 2025 15:11:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CDE601B8296; Tue, 20 May 2025 15:11:05 +0200 (CEST)
Date: Tue, 20 May 2025 15:11:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com,
	bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <aCx_aXy9MEs6XKZE@wunner.de>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
 <aCxdFm_BpgOTFFUv@wunner.de>
 <aCxxA-4HEnZ-O2W0@wunner.de>
 <9b46a12b-90e2-c1ba-9394-5caa23a5cad7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b46a12b-90e2-c1ba-9394-5caa23a5cad7@linux.intel.com>

On Tue, May 20, 2025 at 03:52:56PM +0300, Ilpo Järvinen wrote:
> On Tue, 20 May 2025, Lukas Wunner wrote:
> > A link speed event could contain a "reason" field
> > which indicates why the link speed changed,
> > e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
> > 
> > In other words, instead of mixing the infomation for hotplug
> > and link speed events together in one event, a separate link
> > speed event could point to hotplug as one possible reason for
> > the new speed.
> 
> It will be somewhat challenging to link LBMS into what caused it, 
> especially in cases where there is more than one LBMS following a single 
> Link Retraining.
> 
> Do you have opinion on should the event be only recorded from LBMS/LABS 
> if the speed changed from the previous value? The speed should probably 
> also be reported also for the first time (initial enumeration, hotplugging 
> a new board).

One idea would be to amend struct pcie_bwctrl_data with an
enum member describing the reason.

pcie_bwnotif_irq() uses that reason when reporting the speed change
in a trace event.

After an Endpoint has been removed, the Downstream Port or Root Port
above resets the reason to "hotplug", so that the next link event
is assigned that reason.

Similarly pcie_set_target_speed() could be amended with an enum argument
for the reason and it would set that in struct pcie_bwctrl_data before
calling pcie_bwctrl_change_speed().

Thanks,

Lukas

