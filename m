Return-Path: <linux-pci+bounces-3702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5653859CE8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9212824B2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F370208D7;
	Mon, 19 Feb 2024 07:32:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067A200A8;
	Mon, 19 Feb 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327928; cv=none; b=i4/FGh3SISnWXo6cO64UG0S+NcpKNK1a8nqdfqlm//PtqPBxkR1XvXvNH35N1Ps7nUjpo9p86ZnjeZBxFZxhr7cySJgNr73+yxn8T11eXz3gEFDqrd3lXNDuVql/J00oUUU9hVPVUPGYZ26Y45y3/EfZcLaLjPPxqSfysUBgsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327928; c=relaxed/simple;
	bh=OVaJs/InAwdK7XdqMcucVtZCJd/vYk0GtP9ub565uFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxzrLcBUOFl1crhu979cUFwJCkamEYdVZeUJT0AA2gGbvmLJkyxKuiRvUqGv5vLp3IlBezcXFO8hhMwyLuEF+Po/Bi/S7J+fU3WmmaJeTak/txRf64CKrIpgTXKHeW5xRoj+Or76ZX5YLuLGsMGyq3AyPHyVgFJ0hqCY1hHQvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 62FDA300000A1;
	Mon, 19 Feb 2024 08:31:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4A7462F50C; Mon, 19 Feb 2024 08:31:57 +0100 (CET)
Date: Mon, 19 Feb 2024 08:31:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jeremy Allison <jra@samba.org>, Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: jallison@ciq.com, rafael@kernel.org, tansuresh@google.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	djeffery@redhat.com, hch@lst.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] async device shutdown support
Message-ID: <20240219073157.GA32010@wunner.de>
References: <ZcPqr+9hqH1UXdwr@jeremy-HP-Z840-Workstation>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcPqr+9hqH1UXdwr@jeremy-HP-Z840-Workstation>
User-Agent: Mutt/1.10.1 (2018-07-13)

[cc += Stuart, linux-pci; start of thread:
 https://lore.kernel.org/lkml/20240207184100.18066-1-djeffery@redhat.com/
]

On Wed, Feb 07, 2024 at 12:40:15PM -0800, Jeremy Allison wrote:
> On Wed, Feb 07, 2024 at 1:40:54PM -0500 David Jeffery wrote:
> > This is another attempt to implement an acceptable implementation of async
> > device shutdown, inspired by a previous attempt by Tanjore Suresh. For
> > systems with many disks, async shutdown can greatly reduce shutdown times
> > from having slow operations run in parallel.
> 
> It may have escaped your notice that I was shepherding a newer version
> of Tanjore's original patchset through the nvme lists already. Please
> look at version 5 here (I am working on version 6 currently).

Stuart Hayes has also been working on async shutdown and his approach
is much leaner than yours.  He needs testers.  Maybe you can give his
patch a spin and report back if it works for you, so that you guys can
collaborate instead of working on separate approaches?

Here's Stuart's v5:
https://lore.kernel.org/all/20231128210436.506510-1-stuart.w.hayes@gmail.com/

Thanks,

Lukas

