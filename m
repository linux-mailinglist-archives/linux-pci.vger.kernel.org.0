Return-Path: <linux-pci+bounces-24396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC352A6C362
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDEC3B8D47
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E801E5B6D;
	Fri, 21 Mar 2025 19:36:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7118FC75
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585764; cv=none; b=mjQ0OVDFtyJICqBmH7B8IRs4V73Bx2uj4xttLcUoRRBn4Nej+E9a9pGwM9D+zO8UMRx7sQdmgKE0BNaPDY1sK6WdFJh1eUkrKoU1cD0pNQlri10auU/svqhFJbU06LhFjZIM/2Ek0ay5cBj0F4Ldgzro5MjUp8l0NXb7ukeDbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585764; c=relaxed/simple;
	bh=49QAv/XnT35N2WyePIVmBcYLvTskiGWE6YeOHQsfbOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDty2kWU9egiKVwjj3Wr7zhaO3mmayZvxFr+8Xah/ztWCaWv4U400fErDfFVQMx3ithueANB0hor/XG1CctyboYEPnoDzCeXSQ/+zZ5xm56pRLnaqzJjAeVM3fXu9+rWEZwC6/4LzuyeBfYFpQlFWW7tUSZosHEcCP51BqhdeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 02527102B7B0E;
	Fri, 21 Mar 2025 20:35:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AE1BB2642B; Fri, 21 Mar 2025 20:35:52 +0100 (CET)
Date: Fri, 21 Mar 2025 20:35:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [Bug 219906] New: Kernel Oops in pcie_update_link_speed when
 hotplugging TB4 dock on x870e / kernel 6.14.0-rc7
Message-ID: <Z92_mHU3CcTXdaKV@wunner.de>
References: <bug-219906-41252@https.bugzilla.kernel.org/>
 <20250321191504.GA1139362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321191504.GA1139362@bhelgaas>

On Fri, Mar 21, 2025 at 02:15:04PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 21, 2025 at 06:30:40PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=219906
> > 
> >             Bug ID: 219906
> >            Summary: Kernel Oops in pcie_update_link_speed when hotplugging
> >                     TB4 dock on x870e / kernel 6.14.0-rc7
> 
> Do you know whether this is a regression?  Does any kernel work
> correctly on the system in question?

This is a regression caused by

    commit 665745f274870c921020f610e2c99a3b1613519b
    Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    Date:   Fri Oct 18 17:47:52 2024 +0300

    PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller

which went into v6.13-rc1.  It can be overcome by duplicating

    commit 62e4492c3063048a163d238cd1734273f2fc757d
    Author: Andreas Noever <andreas.noever@gmail.com>
    Date:   Mon Jun 9 23:03:32 2014 +0200

    PCI: Prevent NULL dereference during pciehp probe

in the bandwidth controller driver.

I can submit a patch tomorrow unless you or Ilpo beat me to it.
(Sorry, I'm still a little sleep deprived today after OSPM Summit.)

Thanks,

Lukas

