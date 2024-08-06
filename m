Return-Path: <linux-pci+bounces-11384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE049498AA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682C02831E9
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4050C81AC8;
	Tue,  6 Aug 2024 19:55:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6A83CC7;
	Tue,  6 Aug 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974151; cv=none; b=QnpSfDJ3hb2NbogzuCCD6iaftLvR25NkHpW+FkGnuiHCBQ6Tmnk13Mdim0EE3HYJ4sPu64dZJcZZQZiPqiDyNzJUBMj2+W1WT2e40bjL1LY3j0HZCbvjF50pDYG4L5A4nkcIZPHZ0q3Eri+72Fi/agRcl/tKkO1QwT2YFHyfca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974151; c=relaxed/simple;
	bh=dL2N3yb65R/Dn4NmNYogk6zxi7X0vIRCP39vrKB1QT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2P3fgWPAfwZ3JuOnRKyu21TiLe6ce25wOz7P/jbK/xuVQL9T+iQPUlMlURbJd+fcBiX8X44VrLFrQ4ZT5XIGDON5RERfTDI2jNJq3MYb4qvBr5fEZh9UfCiGSf19mzeqa7q55tocCUOlofW+xCJPlRp+8getlGre15Vq0ralk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id CEAA0100DA1D9;
	Tue,  6 Aug 2024 21:55:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8B9104F18D; Tue,  6 Aug 2024 21:55:38 +0200 (CEST)
Date: Tue, 6 Aug 2024 21:55:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, Alistair Francis <alistair23@gmail.com>,
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH] s390/pci: Stop usurping pdev->dev.groups
Message-ID: <ZrJ_uqL-2wf3wV9d@wunner.de>
References: <7b970f7923e373d1b23784721208f93418720485.1722870934.git.lukas@wunner.de>
 <20240806193055.GA73910@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806193055.GA73910@bhelgaas>

[cc += Konstantin]

On Tue, Aug 06, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 05, 2024 at 05:24:05PM +0200, Lukas Wunner wrote:
> > Bjorn suggests using pdev->dev.groups for attribute_groups constructed
> > on PCI device enumeration:
> > 
> >    "Is it feasible to build an attribute group in pci_doe_init() and
> >     add it to dev->groups so device_add() will automatically add them?"
> >     https://msgid.link/20231019165829.GA1381099@bhelgaas
> 
> Huh, another new archive link format.  I guess I need to be educated
> about this.  I see 127734e23aed ("Documentation: best practices for
> using Link trailers"), which added the only mentions in the tree,
> although it only mentions "https://patch.msgid.link" and specifically
> in the context of the origin of a patch, which leaves it clear as mud
> for me.

I merely chose that because it's shorter than lore.kernel.org and makes
it more obvious that it's a Message-ID link to the mailing list archive.

I'm not sure whether that goes against any best practices associated
with the msgid.link domain and whether it's going to work as long as
lore.kernel.org.  Hopefully Konstantin can comment on that.

Otherwise feel free to replace when applying.

Thanks,

Lukas

