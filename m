Return-Path: <linux-pci+bounces-26160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E186A93102
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 05:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159477AC6D7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 03:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CD12512FB;
	Fri, 18 Apr 2025 03:55:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E041A0730
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948511; cv=none; b=i1MZOLXtDfX2pRrPvUMy+9/G/VWAUollvLD1Juo/SnPWUVvHXIf0ym1ikjP/wTVACtZmdFn03s1Vj1UmPDfNQwb6tanw/sdCBQDD5tsVohvEZYHU0V/LPPkajhmiHuJbH9No9vO2Dsvo2Q/B3JUPEEc+c5IgSDMz0DsWjAzydrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948511; c=relaxed/simple;
	bh=6AP0PKLSwfD10E8cCiEDRjPWV5GtrFi3tKh3JiRZ1JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5p5w/+kVNEcx3mZoQV/dJXbi40nc1eh9tmoC3S4fLN5ECUHr0bW4k+Hpgg56VxHy0cYDDn3aPrKj6/SNKtyW+n6j28ZKXWTvlLeI8B28Nrm4lGMK+h/uf5wwxtVeBHU2ONqvBqKyzu6MCdBlBI+Uce6vuOuNqYcsPBd32tzK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 265BE2C4C3C8;
	Fri, 18 Apr 2025 05:54:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 36457224E6; Fri, 18 Apr 2025 05:55:05 +0200 (CEST)
Date: Fri, 18 Apr 2025 05:55:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Keith Busch <kbusch@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
	Christoph Hellwig <hch@lst.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 09/10] PCI: Unify device inaccessible
Message-ID: <aAHNGT60lleXqnW6@wunner.de>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-10-keith.busch@intel.com>
 <e0606dfcf8780bf994432dc373581fdf0af18f8e.camel@kernel.crashing.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0606dfcf8780bf994432dc373581fdf0af18f8e.camel@kernel.crashing.org>

[cc += PowerPC / EEH maintainers]

Hi Ben,

On Tue, Sep 25, 2018 at 11:10:01AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-09-18 at 17:57 -0600, Keith Busch wrote:
> > + * pci_dev_set_io_state - Set the new error state if possible.
> > + *
> > + * @dev - pci device to set new error_state
> > + * @new - the state we want dev to be in
> > + *
> > + * Must be called with device_lock held.
> 
> Any reason why you don't do cmpxchg as I originally suggested (sorry
> I've been away and may have missed some previous emails)
> 
> This won't work for PowerPC EEH. We will change the state from a
> readl() so at interrupt time or any other context.
> 
> We really need the cmpxchg variant.

Independently from your request, pci_dev_set_io_state() was
converted to cmpxchg() in 2023 with commit 74ff8864cc84
("PCI: hotplug: Allow marking devices as disconnected during
bind/unbind").

So you may now amend EEH to use pcie_do_recovery() or whatever
you needed this for.

I had kept your e-mail in my inbox as a reminder that there's a
remaining issue here and just came across it while clearing out
other messages.

Thanks,

Lukas

