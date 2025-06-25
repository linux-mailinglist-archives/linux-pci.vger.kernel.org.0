Return-Path: <linux-pci+bounces-30579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4AAE798B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25A817C105
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959520CCE5;
	Wed, 25 Jun 2025 08:08:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F31E5B95;
	Wed, 25 Jun 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838895; cv=none; b=FLD3X6a6UCKFArcfciaI9ZTe2MUjtTuN4RRBPZKORr7uIeqeOMIe2TLibOB28rbOfLsZJYFSFYRQHcyp9xRNqAjvwC+b7HuHlCCkVRlkzBv8jo4drUuRJ6hfTCh4Qw+/ROQ9UKJF/QB0rOyP4s/OYZIVc03uxSmyobgcv3ZkjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838895; c=relaxed/simple;
	bh=EYBnaryO2t2j1TYPtDQ15vC+AkkaRRLZ5JYRisv3DBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyEbyVwky626ke6q3vBUvZAXE/RbEdOFd5xtwrjcNwnFfmtMZFkdCKU57tuV2HFZVNQH+Soy3lGKSch0jaOuWBX5j341Ow2F/wPpoW1NXgdP7nog+NvNMA4BXcxwENaefvDElDVbgH1Niclr2hjUd0+4Z+c9M006xFawgz0ZwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id E93BD2C06E33;
	Wed, 25 Jun 2025 10:08:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E3CED3B708B; Wed, 25 Jun 2025 10:08:02 +0200 (CEST)
Date: Wed, 25 Jun 2025 10:08:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Kumar <krishnak@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"\"linux-pci\"," <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	"\"Bjorn Helgaas\"," <bhelgaas@google.com>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Message-ID: <aFuuYq0m0hDAdPRF@wunner.de>
References: <20250618190146.GA1213349@bhelgaas>
 <1469323476.1312174.1750293474949.JavaMail.zimbra@raptorengineeringinc.com>
 <19689b53-ac23-4b48-97c7-b26f360a7b75@linux.ibm.com>
 <aFaCfYre9N52ARWH@wunner.de>
 <f13a2d2b-af52-4934-b4fa-66bc1e5ece32@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13a2d2b-af52-4934-b4fa-66bc1e5ece32@linux.ibm.com>

On Wed, Jun 25, 2025 at 09:38:19AM +0530, Krishna Kumar wrote:
> On 6/21/25 3:29 PM, Lukas Wunner wrote:
> > On Fri, Jun 20, 2025 at 02:56:51PM +0530, Krishna Kumar wrote:
> > > 5. If point 3 and 4 does not solve the problem, then only we should
> > > move to pciehp.c. But AFAIK, PPC/Powernv is DT based while pciehp.c
> > > may be only supporting acpi (I have to check it on this). We need to
> > > provide PHB related information via DTB and maintain the related
> > > topology information via dtb and then it can be doable.
> > 
> > pciehp is not ACPI-specific.  The PCIe port service driver in
> > drivers/pci/pcie/portdrv.c binds to any PCIe port, examines the
> > port's capabilities (e.g. hotplug, AER, DPC, ...) and instantiates
> > sub-devices to which pciehp and the other drivers such as aer bind.
> 
> 1. If we get PHB info from mmcfg via acpi table in x86 and create a
>    root port from there with some address/entity and if this Acpi and
>    associated entity is not present for PPC, then it can be a problem.
> 
> 2. PPC is normally based on DTB entity and it identifies PHB and pcie
>    devices from there. If this all the information is correctly map
>    via portdrv.c then there is no problem and whatever you are telling
>    is correct and it will work.
> 
> 3. But if point 2 is not handled correctly we need to just aligned with
>    port related data structure to make it work.

PCI devices do not have to be enumerated in the devicetree (or in ACPI
DSDT) because PCI is an enumerable bus (like USB).  Only the host bridge
has to be enumerated in the devicetree or DSDT.  The kernel can find the
PCI devices below the host bridge itself.  Hot-plugged devices are
usually not described in the devicetree or DSDT because one doesn't
know their properties in advance.

pnv_php.c seems to search the devicetree for hotplug slots and
instantiates them.  My expectation would be that any hotplug-capable
PCIe Root Port or Downstream Port, which is *not* described in the
devicetree such that pnv_php.c creates a slot for it, is handled by
pciehp.

Timothy was talking about a Microsemi PCIe switch below the Root Port.
My understanding is that the Downstream Ports of that switch are
hotplug-capable.  So unless you've disabled CONFIG_HOTPLUG_PCI_PCIE,
I'd expect those ports to be handled by pciehp.  Assuming they're not
described as a "ibm,ioda2-phb" compatible device in the devicetree,
but why would they?

Thanks,

Lukas

