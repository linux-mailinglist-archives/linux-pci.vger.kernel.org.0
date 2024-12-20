Return-Path: <linux-pci+bounces-18868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8E9F8E66
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1571896FA0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06373259499;
	Fri, 20 Dec 2024 08:57:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C91A707D
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685033; cv=none; b=MWoYhlIK2///PU2CgmXEX/Qliuo2zK45LBGVdvDuPB2z30Zml4WFHRZ3TUPiv6B1XaC44/vkiwOeZ/G8sE/UAWvNW3zp2IYR+HsOOcDXBVcrgemvDW8y3UH0SHY/ZJD1/4JYrgKr7l/Ol+Tf4EGU4+0evPtdys2zWfyIoQxTTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685033; c=relaxed/simple;
	bh=7oQGSCHPXhAotVkgPoE3UmX97AIswMENC5wQFs6smHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXk94EBrdGRFJMGfdcJy+KfkyQX3PRtckSrnquu/LOZZVXEEOmJVlAHAawQfSIxYI5rnX9aMUoCBEBMsvgeEwP6DIs/PeHgmgXmjPYQDx25SyYOej6IwyMl76sMGV3SglJBlgNYW/1dZkT9Vo5L6zLURsGi6RPeJmHBkc6MEVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3EC642800B1A3;
	Fri, 20 Dec 2024 09:57:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 28E0D992F94; Fri, 20 Dec 2024 09:57:07 +0100 (CET)
Date: Fri, 20 Dec 2024 09:57:07 +0100
From: Lukas Wunner <lukas@wunner.de>
To: bjorn@helgaas.com
Cc: Krzysztof Wilczy??ski <kw@linux.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Niklas Schnelle <niks@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when
 determining supported speeds
Message-ID: <Z2UxY1dT4zj-h1bI@wunner.de>
References: <cover.1734428762.git.lukas@wunner.de>
 <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
 <7bbd48eb-efaf-260f-ad8d-9fe7f2209812@linux.intel.com>
 <20241218234357.GA1444967@rocinante>
 <Z2POKvvGX7HZmqtP@wunner.de>
 <f4b43cee-b029-1c78-2412-7a952e8e83a1@linux.intel.com>
 <20241219163705.GA623969@rocinante>
 <CABhMZUWP1LN2ZX7oAaW4oJywC+Zfo4Y0p4ep7NJkkgGcVsM+hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUWP1LN2ZX7oAaW4oJywC+Zfo4Y0p4ep7NJkkgGcVsM+hg@mail.gmail.com>

On Thu, Dec 19, 2024 at 12:50:59PM -0500, Bjorn Helgaas wrote:
> On Thu, Dec 19, 2024, 11:37AM Krzysztof Wilczynski <kw@linux.com> wrote:
> > > > > > I'd also add reference to r6.2 section 7.5.3 which states those
> > > > > > registers are required for RPs, Switch Ports, Bridges, and
> > > > > > Endpoints _that are not RCiEPs_. My reading is that implies
> > > > > > they're not required from RCiEPs.
> 
> Don't have the spec with me, but I don't know what link-related registers
> would even mean for RCiEPs. Why would we look at them at all?

We don't:  pcie_capability_read_dword() checks whether the register
being read is actually implemented by the device:

pcie_capability_read_dword()
  pcie_capability_reg_implemented()
    pcie_cap_has_lnkctl()

And pcie_cap_has_lnkctl() returns false for PCI_EXP_TYPE_RC_END,
in which case pcie_capability_read_dword() just returns zero
without accessing Config Space.

Likewise accesses to PCI_EXP_LNKCAP2_SLS are short-circuited to zero
if the device only conforms to PCIe r1.1 or earlier and thus doesn't
implement the Link Capabilities 2 Register.  (Recognizable by
PCI_EXP_FLAGS_VERS being 1 instead of 2.)

So pcie_get_supported_speeds() returns zero for such devices and
that's the value assigned to dev->supported_speeds for RCiEPs on probe.

Thanks,

Lukas

