Return-Path: <linux-pci+bounces-30135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E83BCADF78C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6021C1BC312E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370391FCF41;
	Wed, 18 Jun 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOARzafB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA33085BA;
	Wed, 18 Jun 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277845; cv=none; b=bKKJQLlLArXv1M7K8sMryueZ5pIr1H9LzMFLSUuKyi2HVYfsam3KK3a14bhYXq+Xek86yYFqhiDmsic6ScOdWYm2yKiYlqaD0PnoQoFJJ9u/7qFtONZOYqBNi9KBMbKL+rqpeZCkYM6PxxzyAHTcPjtrRBX4di4uyQaHPMq0jZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277845; c=relaxed/simple;
	bh=xt8r64iKztaGluvYHQ+nEmHkrlN0zD8k22lRNBw+eZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b03cQu5u08v4Nt2cBCaBvhj2CRDQuH9YKGUy/FT4Ylkv7Ei6rGfeiupMU5scW/3hMLdsgrOsZqCDTZXAJgRZMtsBfS542+FxUYU4j80dpIDRl8giDqep7kh9o4INAf72GscRDsdosnKy+yK/3ocv891Jr/fbgeM0TYvUUbPMa44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOARzafB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB27C4CEE7;
	Wed, 18 Jun 2025 20:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750277844;
	bh=xt8r64iKztaGluvYHQ+nEmHkrlN0zD8k22lRNBw+eZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FOARzafBQCH4mhbZUSX3MH98F55tLlayT4MS64DrQ26ru2cMm/M+yF+FscGystMAK
	 0CQma9JT95xIs7U+K1HMp/Z/U9ZfclyD935P5ZdedHfyuuVMdWfGxcjMxVNDL3VZtq
	 kLYIts2/TIO9aXT4ITDKOIVP7tvcnQnttyhvDkyBX0uRIX6cu8hEVbW11K6/nJVLXU
	 TYCHVddc6BvT/c1MJHUMD20a7ia6cvoqPypNfuKOeSqB50zMSq1UHzbSgjEKU5yZEN
	 /uBRVpWVWLcm5YfhOu/Ug21FEc722Jpq7hOGt8MX4XOpYNYWhXfg3DIgM4PzHSPIPD
	 tf7OpPfRTsrcQ==
Date: Wed, 18 Jun 2025 15:17:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Message-ID: <20250618201722.GA1220739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957898084.1311382.1750276204022.JavaMail.zimbra@raptorengineeringinc.com>

On Wed, Jun 18, 2025 at 02:50:04PM -0500, Timothy Pearson wrote:
> ----- Original Message -----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
> > Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> > <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> > "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> > <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>, "Lukas Wunner" <lukas@wunner.de>
> > Sent: Wednesday, June 18, 2025 2:44:00 PM
> > Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with broken
> 
> > [+cc Lukas, pciehp expert]
> > 
> > On Wed, Jun 18, 2025 at 11:56:54AM -0500, Timothy Pearson wrote:
> >>  presence detection
> > 
> > (subject/commit wrapping seems to be on all of these patches)
> > 
> >> The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
> >> was observed to incorrectly assert the Presence Detect Set bit in its
> >> capabilities when tested on a Raptor Computing Systems Blackbird system,
> >> resulting in the hot insert path never attempting a rescan of the bus
> >> and any downstream devices not being re-detected.
> > 
> > Seems like this switch supports standard PCIe hotplug?  Quite a bit of
> > this driver looks similar to things in pciehp.  Is there some reason
> > we can't use pciehp directly?  Maybe pciehp could work if there were
> > hooks for the PPC-specific bits?
> 
> While that is a good long term goal that Raptor is willing to work
> toward, it is non-trivial and will require buy-in from other
> stakeholders (e.g. IBM).  If practical, I'd like to get this series
> merged first, to fix the broken hotplug on our hardware that is
> deployed worldwide, then in parallel see what can be done to merge
> PowerNV support into pciehp.  Would that work?

Yeah, it wouldn't make sense to switch horses at this stage.

I guess I was triggered by this patch, which seems to be a workaround
for a defect in a device that is probably also used on non-PPC
systems, and pciehp would need a similar workaround.  But I guess you
go on to say that pciehp already does something similar, so it guess
it's already covered.

Bjorn

