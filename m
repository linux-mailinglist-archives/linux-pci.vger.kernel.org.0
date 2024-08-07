Return-Path: <linux-pci+bounces-11455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA52C94AF5F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8AA1F228C7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1013D533;
	Wed,  7 Aug 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bEIv1RQm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68021F937;
	Wed,  7 Aug 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054105; cv=none; b=ghj2CSJ8Deh0BwLOTeRAIfTz3U/O6Kbbe6U0rkHudX6X6bw65sNcg1O7yYgfTO1ue6RXehcYS2lWIj+2OanmFrjL8xj3IQ5XIGHqAPJjlC2EaKuJHJiXoaDj+YC7QWvszlN+1Pv/0hrvOnnxc8oFAJwo7yN/jI+hcOJ8fdKCm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054105; c=relaxed/simple;
	bh=xgCFE3PtfqqbnhE3y53CX2u6Fqvwohu8qFDD3jwnrJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO2fDYGY5oGbWjUKT6R4L83Ixd+ZPHMhypBNpJ6elBeBqvy7Bx7s7o8UePNHZnS7m/xFle5g4XM7Eu0xeqa7oiZPS+fDp5MQGuWVj1TjGleADLwZNHbixsJbqizs/SCLTEGsTllnzMLoDI5OpAim1JEe5bpjA6duV4KkFDKT3S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bEIv1RQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2410AC32781;
	Wed,  7 Aug 2024 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723054104;
	bh=xgCFE3PtfqqbnhE3y53CX2u6Fqvwohu8qFDD3jwnrJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEIv1RQmGCCH5e6CuB/fgqgc3AlpRWXiDTl5FQeLPJ7tHajzCp43zTdbh0+fzkb5t
	 1Ka7pCM4AfV2wouRxzirerquSql/30XwKW3YwrrCOxqKNUaS/gNdvwZy6rZ8Vikgsk
	 QTSmwI87OsqvlCstSHDVRCFEmSsw3F04+gNwU+kU=
Date: Wed, 7 Aug 2024 14:08:23 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-pci@vger.kernel.org, Alistair Francis <alistair23@gmail.com>, 
	Jonathan.Cameron@huawei.com, alex.williamson@redhat.com, christian.koenig@amd.com, 
	kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com, 
	chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH] s390/pci: Stop usurping pdev->dev.groups
Message-ID: <20240807-grinning-nostalgic-orca-4c73b6@lemur>
References: <7b970f7923e373d1b23784721208f93418720485.1722870934.git.lukas@wunner.de>
 <20240806193055.GA73910@bhelgaas>
 <ZrJ_uqL-2wf3wV9d@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrJ_uqL-2wf3wV9d@wunner.de>

On Tue, Aug 06, 2024 at 09:55:38PM GMT, Lukas Wunner wrote:
> [cc += Konstantin]
> 
> On Tue, Aug 06, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 05, 2024 at 05:24:05PM +0200, Lukas Wunner wrote:
> > > Bjorn suggests using pdev->dev.groups for attribute_groups constructed
> > > on PCI device enumeration:
> > > 
> > >    "Is it feasible to build an attribute group in pci_doe_init() and
> > >     add it to dev->groups so device_add() will automatically add them?"
> > >     https://msgid.link/20231019165829.GA1381099@bhelgaas
> > 
> > Huh, another new archive link format.  I guess I need to be educated
> > about this.  I see 127734e23aed ("Documentation: best practices for
> > using Link trailers"), which added the only mentions in the tree,
> > although it only mentions "https://patch.msgid.link" and specifically
> > in the context of the origin of a patch, which leaves it clear as mud
> > for me.
> 
> I merely chose that because it's shorter than lore.kernel.org and makes
> it more obvious that it's a Message-ID link to the mailing list archive.
> 
> I'm not sure whether that goes against any best practices associated
> with the msgid.link domain and whether it's going to work as long as
> lore.kernel.org.  Hopefully Konstantin can comment on that.

I think it's perfectly fine to use msgid.link URLs for general links to
mailing list archives. The reason we introduced patch.msgid.link was
specifically to distinguish general links to discussions from links pointing
at the origin of the commit.

-K

