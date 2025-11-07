Return-Path: <linux-pci+bounces-40558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF5C3E885
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 06:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10646188B9A6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 05:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977B21770A;
	Fri,  7 Nov 2025 05:40:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D2F50F;
	Fri,  7 Nov 2025 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494058; cv=none; b=e8qdg9pNV95IVRA4aG7ex8LSccY/OZ41CeEqD8Hwxpp3dhbFvNqYQIST47eY755Strx3Wj7XQPQplJuw+uTx125DEfgdUMg1RF86bNCMVV2TjppbRaoXZDQNbb0D9OHsTMXwbXgx4Lgpq8W+k/h/57BwkdL++MflbsvKBnwDl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494058; c=relaxed/simple;
	bh=yCQqcXPylAJSVA6F49cJItfhjz96aSIGaTzjb2bolhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnTUZVjd++C5lFng9F1vearGv1e2yfdZkH2jV4QNo/iyHDtELNEUFJWc3sbaWxMon3P4UQsCzUsR/Tnmydk/Yvif0BiXFB55JZ/EDCSg3fy0MCwfbKi6gtni7wppPP3qATU5qWYExSi3HDCvvCI1/F18b28zeylSRWdxoR9286s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B9D872C06417;
	Fri,  7 Nov 2025 06:32:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A8078444; Fri,  7 Nov 2025 06:32:14 +0100 (CET)
Date: Fri, 7 Nov 2025 06:32:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Cache Link Capabilities so quirks can
 override them
Message-ID: <aQ2EXqDvnxjyXq_7@wunner.de>
References: <20251106183643.1963801-1-helgaas@kernel.org>
 <20251106183643.1963801-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106183643.1963801-2-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:38PM -0600, Bjorn Helgaas wrote:
> Cache the PCIe Link Capabilities register in struct pci_dev so quirks can
> remove features to avoid hardware defects.  The idea is:
> 
>   - set_pcie_port_type() reads PCIe Link Capabilities and caches it in
>     dev->lnkcap
> 
>   - HEADER quirks can update the cached dev->lnkcap to remove advertised
>     features that don't work correctly
> 
>   - pcie_aspm_cap_init() relies on dev->lnkcap and ignores any features not
>     advertised there

I realize that memory is cheap, but it still feels a bit wasteful
to cache the entire 32-bit register wholesale.  It contains
reserved bits as of PCIe r7.0, various uninteresting bits and
portions of it are already cached elsewhere and thus now duplicated.
I'm wondering if it would make sense to instead only cache the ASPM bits
that are relevant here?  That's the approach we've followed so far.

You're initializing the link_active_reporting bit from the newly
cached lnkcap register, I'd prefer having a static inline instead
which extracts the bit from the cached register on demand,
thus obviating the need to have a duplicate cached copy of the bit.

pci_set_bus_speed() caches bus->max_bus_speed from the Link
Capabilities register and isn't converted by this patch to use
the cached register.  There are various others, e.g.
get_port_device_capability() in drivers/pci/pcie/portdrv.c
could also get PCI_EXP_LNKCAP_LBNC from the cached lnkcap
register.  Same for pcie_get_supported_speeds().  If the
intention is to convert these in a separate step in v6.19,
it would be good to mention that in the changelog.

Thanks,

Lukas

