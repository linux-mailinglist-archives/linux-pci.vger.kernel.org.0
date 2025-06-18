Return-Path: <linux-pci+bounces-30131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9200EADF730
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A02A167A55
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72633219A97;
	Wed, 18 Jun 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="ukt6ydpv"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124016B3B7;
	Wed, 18 Jun 2025 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276213; cv=none; b=nKImttBosMJ1UDGR7sVFFjgw9fhnaw72wDlFmolcn31919sEZQaTwZiHU9cFngnbCT7ZVbz9sNAaCOJxFV7W6sZEc8xBNDlRFxrbtgCdq3gpWG0uctW1KLvWe8PKKCFaI7gLwVqBp/At0Ee0afXca/Ua5bu9688rbfXRwFIyqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276213; c=relaxed/simple;
	bh=aBchKFwWyd0GBQrBmRwyjrarHmeV8MYL0+Muw8PbLVc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sPPQ2LKtKymIM0DL2ckTlY5Ha3iIb0GOupD2xJSoUKRDALd4uQt2kGag7g+fvPxQjsgVz5xM1aV+ykG+V0hdPTPmien0w3So8cxQM5zb4jZjF856PrV4qdh04fRakvWDrUlxzmCR/vBhcxt7YB66Dx3KaYtM3F+LiHI+rOFswSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=ukt6ydpv; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8755B82885CC;
	Wed, 18 Jun 2025 14:50:10 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Cw-X6kyH1lKl; Wed, 18 Jun 2025 14:50:07 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8C6468288C8B;
	Wed, 18 Jun 2025 14:50:07 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 8C6468288C8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750276207; bh=Z2GNqX+0k7pSprsF3zD6eUV76u17QucYwCVB/IypEPg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ukt6ydpvmsUs2h/99SLAygWrJTQV0Ww6DXrosK8GMRLMAerec2PGtn9yFicY4Jg7n
	 aLvcdn0yDsl7P566v8caiKvJlkMp7ugpGCRe0D3vwPChJvq8sseALw4qMB9QMPMIu5
	 vbhjym68Cv4y1g3DhNg2OwHReQLe2nBGDL53GYbQ=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aOfRNJqAxjHk; Wed, 18 Jun 2025 14:50:07 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 11E5E828884B;
	Wed, 18 Jun 2025 14:50:07 -0500 (CDT)
Date: Wed, 18 Jun 2025 14:50:04 -0500 (CDT)
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
Message-ID: <1957898084.1311382.1750276204022.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250618194400.GA1219576@bhelgaas>
References: <20250618194400.GA1219576@bhelgaas>
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
Thread-Index: ea0P+zxqpWPDRHdRnJt8G7RzFtnFrw==



----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Wednesday, June 18, 2025 2:44:00 PM
> Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with broken

> [+cc Lukas, pciehp expert]
> 
> On Wed, Jun 18, 2025 at 11:56:54AM -0500, Timothy Pearson wrote:
>>  presence detection
> 
> (subject/commit wrapping seems to be on all of these patches)
> 
>> The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
>> was observed to incorrectly assert the Presence Detect Set bit in its
>> capabilities when tested on a Raptor Computing Systems Blackbird system,
>> resulting in the hot insert path never attempting a rescan of the bus
>> and any downstream devices not being re-detected.
> 
> Seems like this switch supports standard PCIe hotplug?  Quite a bit of
> this driver looks similar to things in pciehp.  Is there some reason
> we can't use pciehp directly?  Maybe pciehp could work if there were
> hooks for the PPC-specific bits?

While that is a good long term goal that Raptor is willing to work toward, it is non-trivial and will require buy-in from other stakeholders (e.g. IBM).  If practical, I'd like to get this series merged first, to fix the broken hotplug on our hardware that is deployed worldwide, then in parallel see what can be done to merge PowerNV support into pciehp.  Would that work?

