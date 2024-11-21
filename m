Return-Path: <linux-pci+bounces-17148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9E9D49F8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8793E1F2147D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7521BC091;
	Thu, 21 Nov 2024 09:27:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712AAD2C;
	Thu, 21 Nov 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181240; cv=none; b=L+NnK7pdNdUkpIyFzPSMlpmq3XcFWyxSL/xg0piM/usq51S09TedxHfXCpU9ukQMSO68QhUIn6ea3rAVZsWqBWEwVdZYqZnoyeZs9MfmGBWtV31mdewl5CjVoBEVCXC5cDPeOTcSkUqTAZsrAaqbQt1X+ALG/u69bncAAvh5ABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181240; c=relaxed/simple;
	bh=itz1z2Kf6Or5Wz88cu8QAKzATnozXj4IcRuUexJj8Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7STbnmeRNu47k+mm2R/+ytNRaWpDtIh7PrC0+vbbIFH59aXR+obfcpcOQi4C9HYZGgREgO8JdjWwGzp8XI1C0+jGZos4M4gnTbU5fGFyHbo8OURRvEVbJq6s8VzpP27mATt0WVk1qfkNlQJtn8RiKdmfiqy9VPh9I9hbQsNBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 17D3C300097C8;
	Thu, 21 Nov 2024 10:27:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ECF6944680; Thu, 21 Nov 2024 10:27:07 +0100 (CET)
Date: Thu, 21 Nov 2024 10:27:07 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <Zz786zZljAy2J5i7@wunner.de>
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120124328.19111-1-xueshuai@linux.alibaba.com>

On Wed, Nov 20, 2024 at 08:43:28PM +0800, Shuai Xue wrote:
> $ echo 1 > /sys/kernel/debug/tracing/events/hotplug/pci_hp_event/enable
                                              ^^^^^^^
I think this should now be "pci_hotplug" because you've renamed the
TRACE_SYSTEM in v3.

I'm wondering if we'll have other categories besides "pci_hp_event"
below "pci_hotplug".  Maybe not.  Is it possible to omit the "pci_hotplug"
and make "pci_hp_event" top level?  Or should this be grouped below "pci"
instead of "pci_hotplug"?  I'm somewhat at a loss here as I'm not
familiar with the conventions used in the tracing subsystem.

From a PCI hotplug perspective, this patch LGTM, so:

Reviewed-by: Lukas Wunner <lukas@wunner.de>

