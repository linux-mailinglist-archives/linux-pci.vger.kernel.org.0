Return-Path: <linux-pci+bounces-35982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253CB543CD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EBA1C8743D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D62C0262;
	Fri, 12 Sep 2025 07:26:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45728726D;
	Fri, 12 Sep 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661986; cv=none; b=jNvib9zfEp+bRRqAkukdWIsviaRLUm8YHRkvwDSD6357MLfjDB4qLdz7RH26Aztjmk+Dm+pa3BAbxylOGtCJhT/D6+rrkXywr8+rVrWSgnbfKS0gedFEPqwXl+xnbZC7W+lLW5i6psDhRtK9+gsS3b+CxJzL3EJT58DqsBiLk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661986; c=relaxed/simple;
	bh=8nuinajrhFNvduXuneZuWtF6AEKEMnItNe5WjWRWBOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCyW9oHkV1/sphGRWg7eMM2cxblhQjSfnPlSnCuS5gk9K8//bvhzlWqiPa6PvdfhUc9uBoGq2Xq/jvd58Dun1WgOD/IEnHzuI2YxxSFMFEyAF1pzDrZEIpj4gUKjE79ABG3S8hw3PCGqNya48W7dKj32FikGfv/LSg+Pk+r8kVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1D864201D1B8;
	Fri, 12 Sep 2025 09:26:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 08C831F4A8; Fri, 12 Sep 2025 09:26:04 +0200 (CEST)
Date: Fri, 12 Sep 2025 09:26:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Timo Jyrinki <timo.jyrinki@gmail.com>,
	Ernst Persson <ernstp@gmail.com>, Steven Harms <sjharms@gmail.com>,
	James Ettle <james@ettle.org.uk>, Nick Coghlan <ncoghlan@gmail.com>,
	Weng Xuetian <wengxt@gmail.com>,
	Andrey Rahmatullin <wrar@wrar.name>,
	Boris Barbour <boris.barbour@ens.fr>,
	Vlastimil Zima <vlastimil.zima@gmail.com>,
	David Banks <amoebae@gmail.com>, Chris Moeller <kode54@gmail.com>,
	Daniel Fraga <fragabr@gmail.com>, Javier Marcet <jmarcet@gmail.com>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
Message-ID: <aMPLDLYpeVXO1y6R@wunner.de>
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
 <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org>

On Thu, Sep 11, 2025 at 08:34:56AM -0500, Mario Limonciello wrote:
> On 9/11/25 8:11 AM, Lukas Wunner wrote:
> > pci_disable_device() does not clear I/O and Memory Space Enable, although
> > its name suggests otherwise.  The kernel has never disabled these bits
> > once they're enabled.  Doing so would avoid the need for the quirk, but it
> > is unclear what will break if this fundamental behavior is changed.
> 
> It's too late for this cycle to do so, but how would you feel about making
> this change at the start of the next cycle so it had a whole cycle to bake
> in linux-next and see if there is a problem in doing so?

I can look into it.

The change could be justified as a security enhancement to prevent
unauthorized traffic between devices through peer-to-peer transactions.

pci_disable_device() was introduced with v2.4.3.5 in 2002:
https://git.kernel.org/tglx/history/c/9102e0eb3e9e

I suspect back in the day, clearing Bus Master Enable seemed sufficient
because the only concern was to prevent DMA (and by extension MSIs)
from broken devices.  Attacks *between* devices were probably not
considered realistic.

ACS is meant to prevent such attacks, but is an optional capability
and might be configured incorrectly.  A zero trust, defense in depth
approach as is common today requires not leaving doors open without need.

If the kernel would clear Memory Space Enable, a malicious device could
not re-enable it on its own because "propagation of Configuration Requests
from Downstream to Upstream as well as peer-to-peer are not supported"
(PCIe r7.0 sec 7.3.3).

It seemed too risky to make such a sweeping change only to get rid of
the EHCI quirk.  The present patch is meant as a low-risk refactoring,
but we can consider clearing IO + Memory Space Enable as a long-term
solution.  I've cc'ed all the people who reported issues with ASUS
machines back in 2012 in the hope that some of them still have the
(now 13 years old) hardware to test the patch.  They might also be
able to test whether the long-term change doesn't regress anything.

Thanks,

Lukas

