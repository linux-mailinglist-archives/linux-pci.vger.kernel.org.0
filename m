Return-Path: <linux-pci+bounces-30237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93586AE153E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53A37AC22C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180F230BE9;
	Fri, 20 Jun 2025 07:53:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941322F750;
	Fri, 20 Jun 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405981; cv=none; b=owbroF8XyDd6gucC0fC2Az2kC4GEE8ydd6Gk7iYV7DZVtKk4SdFPqo9NNFkx8yzUXEYUCrwzLy8Pd5JuuZrhHN+hqzuPbmXaTnUz9rVVAT9HQtaE1jSoBojYAzN2682LGLH5su+qc0LBIYEni0vSD5QShw4f0664SgzxLSZz5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405981; c=relaxed/simple;
	bh=Wx7tLA436v23x17RKluO3lN8P/SGvVuUDUQzA1ZeXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEFpH5TBZsFjIp6lgf5Xcx+Xrs4Agwqenv6bqmmlURAwVUkoLRYHQzw61X9dvhLRcQnq+3YGj8FQZzF5VCXOrVH9KWErLND6igfpH7k9GOw1ONxs9YUoYep+M2tDxCVbetLhIhnEkdY17BL1l7QpwnX/q2d2Ix4MsuTUv1n5PQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 35B212C06671;
	Fri, 20 Jun 2025 09:52:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2FD183A0857; Fri, 20 Jun 2025 09:52:55 +0200 (CEST)
Date: Fri, 20 Jun 2025 09:52:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v2 2/6] pci/hotplug/pnv_php: Work around switches with
 broken
Message-ID: <aFUTV87SMdpHRbt8@wunner.de>
References: <20250618201722.GA1220739@bhelgaas>
 <1155677312.1313623.1750361373491.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155677312.1313623.1750361373491.JavaMail.zimbra@raptorengineeringinc.com>

On Thu, Jun 19, 2025 at 02:29:33PM -0500, Timothy Pearson wrote:
> To be perfectly frank the existing code quality in this driver
> (and the associated EEH driver) is not the best, and it's been
> a frustrating experience trying to hack it into semi-stable
> operation.
> 
> I would vastly prefer to rewrite / integrate into the pciehp driver,
> and we have plans to do so, but that will take an unacceptable amount
> of time vs. trying to fix up the existing driver as a stopgap.
> 
> As you mentioned, pciehp already has this fix, so we just have to
> deal with the duplicated code until we (Raptor) figures out how to
> merge PowerNV support into pciehp.

I don't know how much PCIe hotplug on PowerNV differs from native,
spec-compliant PCIe hotplug.  If the differences are vast (and I
get the feeling they might be if I read terms like "PHB" and
"EEH unfreeze", which sound completely foreign to me), it might
be easier to refactor pnv_php.c and copy patterns or code from
pciehp, than to integrate the functionality from pnv_php.c into
pciehp.

pciehp does carry some historic baggage of its own (such as poll mode),
which you may not want to deal with on PowerNV.

One thing I don't quite understand is, it sounds like you've
attached a PCIe switch to a Root Port and the hotplug ports
are on the PCIe switch.  Aren't those hotplug ports just
bog-standard ones that can be driven by pciehp?  My expectation
would have been that a PowerNV-specific hotplug driver would
only be necessary for hotplug-capable Root Ports.

Thanks,

Lukas

