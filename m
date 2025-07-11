Return-Path: <linux-pci+bounces-31901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F63B0120B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA931C26EF4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F81ADC90;
	Fri, 11 Jul 2025 04:13:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D8179A7;
	Fri, 11 Jul 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207194; cv=none; b=nI7tJKwg1+IjyfXfEY42+6BsXK+IdBp9y+9/iqQJuaLSynrP/2UEJU9WPWP02zuebBsQMSMaXhdoqPGEHqhRQESsJtglAONu4P/eKuJxZF6ifTHl8nJWdARSgOk8ll2q9rrEIpyCI/Ebao4wbvYyCmbWGy7Z4+knX0ld/Ygr1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207194; c=relaxed/simple;
	bh=ksyuVyqwNXYpFBRt5bG5z9VRMwMuXpfYOXJ+fsiKDtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EompsWmRMrzjVdK+3kHo80Cq8QaMBzS7w2pmrWzVttG96erQXrgEqZcqL+halmLNRm3C/oFeeRPZz4zvKvpeGxKRA7e8lBvZ9cklDCj4PRBYF/4dX2Q1b1D0dAFQ3v2Y7ns6JAEcTTbvBB7CiqIhXNy7HsBahz0txK17QLU8WDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 69729200B1E3;
	Fri, 11 Jul 2025 06:13:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 585484D436; Fri, 11 Jul 2025 06:13:01 +0200 (CEST)
Date: Fri, 11 Jul 2025 06:13:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hongbo Yao <andy.xu@hj-micro.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jemma.zhang@hj-micro.com, peter.du@hj-micro.com
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
Message-ID: <aHCPTU03s-SkAsPs@wunner.de>
References: <20250707103014.1279262-1-andy.xu@hj-micro.com>
 <24dfe8e2-e4b3-40e9-b9ac-026e057abd30@linux.intel.com>
 <b9b64b4f-dcec-4ab1-b796-54d66ec91fc5@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b64b4f-dcec-4ab1-b796-54d66ec91fc5@hj-micro.com>

On Fri, Jul 11, 2025 at 11:20:15AM +0800, Hongbo Yao wrote:
> 2025/7/8 1:04, Sathyanarayanan Kuppuswamy:
> > On 7/7/25 3:30 AM, Andy Xu wrote:
> > > Setting timeout to 7s covers both devices with safety margin.
> > 
> > Instead of updating the recovery time, can you check why your device
> > recovery takes
> > such a long time and how to fix it from the device end?
> 
> I fully agree that ideally the root cause should be addressed on the
> device side to reduce the DPC recovery latency, and that waiting longer
> in the kernel is not a perfect solution.
> 
> However, the current 4 seconds timeout in pci_dpc_recovered() is indeed
> an empirical value rather than a hard requirement from the PCIe
> specification. In real-world scenarios, like with Mellanox ConnectX-5/7
> adapters, we've observed that full DPC recovery can take more than 5-6
> seconds, which leads to premature hotplug processing and device removal.

I think Sathya's point was:  Have you made an effort to talk to the
vendor and ask them to root-cause and fix the issue e.g. with a firmware
update.

> To improve robustness and maintain flexibility, I???m considering
> introducing a module parameter to allow tuning the DPC recovery timeout
> dynamically. Would you like me to prepare and submit such a patch for
> review?

We try to avoid adding new module parameters.  Things should just work
out of the box without the user having to adjust the kernel command
line for their system.

So the solution is indeed to either adjust the delay for everyone
(as you've done) or introduce an unsigned int to struct pci_dev
which can be assigned the delay after reset for the device to be
responsive.

For comparison, we're allowing up to 60 sec for devices to become
available after a Fundamental Reset or Conventional Reset
(PCIE_RESET_READY_POLL_MS).  That's how long we're waiting in
dpc_reset_link() -> pci_bridge_wait_for_secondary_bus() and
we're not consistent with that when we wait only 4 sec in
pci_dpc_recovered().

I think the reason is that we weren't really sure whether this approach
to synchronize hotplug with DPC works well and how to choose delays.
But we've had this for a few years now and it seems to have worked nicely
for people.  I think this is the first report where it's not been
working out of the box.

Thanks,

Lukas

