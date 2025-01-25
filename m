Return-Path: <linux-pci+bounces-20354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38829A1C219
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 09:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA90B3AB74A
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FBF207DF5;
	Sat, 25 Jan 2025 08:07:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5719E997
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737792471; cv=none; b=qWjykCOIDnwVD584CcmSIFQ9JzUoLu0iECahZ4VOAhpORQqcCm4LlzT45XBocpv+fWjQmLYk1jw+41i0yizF+e9IxjmileyRq7V/gR2Ka/It4cjNcBFUxHl3N6YE23mo/asiWhkr8JNxH3PvabCqQVeeG1mK+HtXD973RJk1n+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737792471; c=relaxed/simple;
	bh=ZKQcgBZc7Lh9Hx2BAtf0TeE3mb7h3SVbTJINOjK6tXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcW0mEEsZw/666/j+zqTCxM0LrnakAp8vLky9+VRb5CfJe3Urrs76gT6RElHilddAgxPvmqjvnHof4M5wwuNYoqiKewAyhiCOf+MTEkXaV34RYaXCGgeT+rG1pZoxwOCH15Iv+QKBd+rusvx1mEf047WBQXSGfuHoAabtH3DKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 07E173001234A;
	Sat, 25 Jan 2025 08:59:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E159D3B7078; Sat, 25 Jan 2025 08:59:32 +0100 (CET)
Date: Sat, 25 Jan 2025 08:59:32 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jon Pan-Doh <pandoh@google.com>
Cc: "Bowman, Terry" <terry.bowman@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
Message-ID: <Z5SZ5CJuxSf6YItY@wunner.de>
References: <20250115074301.3514927-1-pandoh@google.com>
 <0817690d-900d-4f42-9d93-97da9018f517@amd.com>
 <CAMC_AXW62emCMzbGoAFvzHA-v=uuaNcjEB9-u8DAzxdt-kYuJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMC_AXW62emCMzbGoAFvzHA-v=uuaNcjEB9-u8DAzxdt-kYuJg@mail.gmail.com>

On Thu, Jan 23, 2025 at 10:46:29PM -0800, Jon Pan-Doh wrote:
> On Thu, Jan 23, 2025 at 7:18AM Bowman, Terry <terry.bowman@amd.com> wrote:
> > Can you share the base commit used here? I would like to try the patchset.
> 
> Sure, it's 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2 ("Merge tag
> 'pci-v6.13-fixes-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci").
> 
> As Karolina pointed out[1], there is a chance of conflicts (e.g. TLP
> log/print consolidation series) with pci/err and pci-next branches.
> The next version will be rebased on top of one of those branches.

Patch sets that are intended to be applied to pci.git should generally
be based on the most recent -rc1 release because pci.git contains
a collection of topic branches (each based on rc1) which are then
merged together to form the pull request for Linus.

Note that there are several other patch sets in flight which target AER:

Terry's CXL error handling (now at v5):
https://lore.kernel.org/linux-pci/20250107143852.3692571-1-terry.bowman@amd.com/

Shuai's endpoint error reporting (now at v2):
https://lore.kernel.org/linux-pci/20241112135419.59491-1-xueshuai@linux.alibaba.com/

You may want to double-check that your changes do not collide with
these other in-flight patch sets.  Terry's is most far along and
may be applied in the upcoming cycle, though it's unclear to me
whether that'll be through the pci or cxl tree.  Probably the former
to avoid merge conflicts?

Thanks,

Lukas

