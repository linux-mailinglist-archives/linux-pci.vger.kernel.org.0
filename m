Return-Path: <linux-pci+bounces-30209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF71CAE0E08
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 21:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18F64A3B0F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 19:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BA21FF3B;
	Thu, 19 Jun 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="okERvjuA"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AD244699;
	Thu, 19 Jun 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750361378; cv=none; b=VVWqTrcYgwO8MNcNzZIybpbCqnhLiwx6cAGVcnWI8zE2ayjgFCcA5Nv3wnmdB6vuRwCNKykRAUtvcaeLptB1cNifMXGl4+4szR/PPZQimCR2x2pYsx9gj8SGQEU0Rqg+bVAQ9ERtyP2lZ32fG/TOScTVqw5ClBz+Qo+vnj/mtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750361378; c=relaxed/simple;
	bh=V2qQyRszvZoY3v298FOrv1bwHvikJ5OUj4mvjFGRdAY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QMNp13+m7dqtdgYr9AJYH7qtTh3hyJXGqS//eQHYm+gWdlujtSW4A2tnQYqfRRCuXg5IC2PGBrkCwCBM7tQkEzVskfP4B8AsT1U0cRXfMABaPYiQ55QnG+mChlxnm4d24dBN/KrVPmZwkrIFMih/9kJOlrLDLxOGSVVxJfpo8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=okERvjuA; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 697D78286F37;
	Thu, 19 Jun 2025 14:29:35 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id kDfBiWNVoCZQ; Thu, 19 Jun 2025 14:29:34 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 146358288ADA;
	Thu, 19 Jun 2025 14:29:34 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 146358288ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750361374; bh=fv7jthCvgTDyikGnfNvnPJOjHiDNeeJUYLlc2LyLdGU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=okERvjuAVQE1NnPz1/LUszGYbnc5gBPXxzMF/eE18zXf4SW1rBeNA4wyL1j0oKjDa
	 W6bZSSgPBwrq3qJ9bIJynpJMhpB4Z1Q5RKuGisW1Dl37Bb/cTDuruGZO1O1Gh7oTxz
	 L+3VGPCQNIt2BAp4ZlaDBcLhNjM891lKExnTfaqo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R2rVL0rBaTqR; Thu, 19 Jun 2025 14:29:33 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A74768286F37;
	Thu, 19 Jun 2025 14:29:33 -0500 (CDT)
Date: Thu, 19 Jun 2025 14:29:33 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <1155677312.1313623.1750361373491.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250618201722.GA1220739@bhelgaas>
References: <20250618201722.GA1220739@bhelgaas>
Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Work around switches with broken
Thread-Index: QJ8OUVEQgO1djYf5DjG5ikGLe2LBIQ==



----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Wednesday, June 18, 2025 3:17:22 PM
> Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with broken

> On Wed, Jun 18, 2025 at 02:50:04PM -0500, Timothy Pearson wrote:
>> ----- Original Message -----
>> > From: "Bjorn Helgaas" <helgaas@kernel.org>
>> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> > Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel"
>> > <linux-kernel@vger.kernel.org>, "linux-pci"
>> > <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
>> > "Michael Ellerman" <mpe@ellerman.id.au>,
>> > "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao"
>> > <naveen@kernel.org>, "Bjorn Helgaas"
>> > <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>,
>> > "Lukas Wunner" <lukas@wunner.de>
>> > Sent: Wednesday, June 18, 2025 2:44:00 PM
>> > Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
>> > broken
>> 
>> > [+cc Lukas, pciehp expert]
>> > 
>> > On Wed, Jun 18, 2025 at 11:56:54AM -0500, Timothy Pearson wrote:
>> >>  presence detection
>> > 
>> > (subject/commit wrapping seems to be on all of these patches)
>> > 
>> >> The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
>> >> was observed to incorrectly assert the Presence Detect Set bit in its
>> >> capabilities when tested on a Raptor Computing Systems Blackbird system,
>> >> resulting in the hot insert path never attempting a rescan of the bus
>> >> and any downstream devices not being re-detected.
>> > 
>> > Seems like this switch supports standard PCIe hotplug?  Quite a bit of
>> > this driver looks similar to things in pciehp.  Is there some reason
>> > we can't use pciehp directly?  Maybe pciehp could work if there were
>> > hooks for the PPC-specific bits?
>> 
>> While that is a good long term goal that Raptor is willing to work
>> toward, it is non-trivial and will require buy-in from other
>> stakeholders (e.g. IBM).  If practical, I'd like to get this series
>> merged first, to fix the broken hotplug on our hardware that is
>> deployed worldwide, then in parallel see what can be done to merge
>> PowerNV support into pciehp.  Would that work?
> 
> Yeah, it wouldn't make sense to switch horses at this stage.
> 
> I guess I was triggered by this patch, which seems to be a workaround
> for a defect in a device that is probably also used on non-PPC
> systems, and pciehp would need a similar workaround.  But I guess you
> go on to say that pciehp already does something similar, so it guess
> it's already covered.

No problem, I completely understand.  To be perfectly frank the existing code quality in this driver (and the associated EEH driver) is not the best, and it's been a frustrating experience trying to hack it into semi-stable operation.  I would vastly prefer to rewrite / integrate into the pciehp driver, and we have plans to do so, but that will take an unacceptable amount of time vs. trying to fix up the existing driver as a stopgap.

As you mentioned, pciehp already has this fix, so we just have to deal with the duplicated code until we (Raptor) figures out how to merge PowerNV support into pciehp.

