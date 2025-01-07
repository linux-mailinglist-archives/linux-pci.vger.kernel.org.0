Return-Path: <linux-pci+bounces-19408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD2DA03FE5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD64D1676A2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6401DB362;
	Tue,  7 Jan 2025 12:53:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5828E37;
	Tue,  7 Jan 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254418; cv=none; b=majj2ikaios/XdXlNq+N6VQE2MpZD3pU70U5BDPvfxus1uCmFENe/sOWNGTtJpMnEdIwlJ2MilOeoabmhsTj4Hm5IsyBk1xJ4K3bIL0QK4o0JYhtYf+/Djw0ArJCG/4z8ekjeOHH8NB0uoVDHvii3NnYAq1VrtzBNKFC+qjBDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254418; c=relaxed/simple;
	bh=BDTvApfGbAxj+ppZtAF2VY2l6m6QqvN1N5lRRGacslc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APenw02VB730vn6ZFivZZREB11jPSzFCm0zlY1PsCqe6VfoghMqZWfkoJ6hIOCoOFVXag1Jo2IkJa9meqvKA1CWAcjSbpflKlY4C4QZtSDD5TeOnJ+INbNZbBrT3FohaQyudKUBMCg21DnWl03KcrEdlXqkoAR+lYbaq8kH6XHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2D88D30008F1A;
	Tue,  7 Jan 2025 13:53:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 168D0558D1A; Tue,  7 Jan 2025 13:53:26 +0100 (CET)
Date: Tue, 7 Jan 2025 13:53:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <Z30jxlgo63Js6G74@wunner.de>
References: <20241123113108.29722-1-xueshuai@linux.alibaba.com>
 <f77669b5-c174-48c7-8f0f-187d1f54ea91@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77669b5-c174-48c7-8f0f-187d1f54ea91@linux.alibaba.com>

On Tue, Jan 07, 2025 at 07:30:28PM +0800, Shuai Xue wrote:
> 2024/11/23 19:31, Shuai Xue:
> > To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> > tracepoint for hotplug event to help healthy check, and generate
> > tracepoints for pcie hotplug event. To monitor these tracepoints in
> > userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
> > header.
[...]
> I would like to inquire that if there are any further actions required
> from my end to proceed for this patch?
> 
> Additionally, I would appreciate if you could inform me about who will be
> pick up this patch.

I'm fine with this patch, as indicated by the Reviewed-by,
so no actions required from you for now.  This will be
picked up by Bjorn once he gets to it (assuming he's happy with it).
A lot of folks were on holidays and are catching up on e-mails,
so please be patient.

Thanks,

Lukas

