Return-Path: <linux-pci+bounces-44164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1DCFD1A9
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 548F43066317
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3AD2FC024;
	Wed,  7 Jan 2026 09:56:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D642FD66B;
	Wed,  7 Jan 2026 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779797; cv=none; b=ImmW551Ub5SHCFJoyIdOHsEBp16BzzpbYWpkqUMKUdiBcrJvtaIF+q8CHZa1ILohiD79x3bexsJnBkc59/OClEnSlKfnOyEEzBrLyMMXNulxTXi45ZqQ6aPHf2jLPpu5MyXQB6J0b4KphA7kNmjeCh7nQxp345Dcmg7AhbEILr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779797; c=relaxed/simple;
	bh=4jah5ShiW0G5kntQ3TGfKtlNKyk4veYxZYc5uOy2ONY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4n4F80bekkBSwIpBSHeZ3u6E7U3eZ6CkrHyEGGjLAozWspO2q0Ndh6F+iy9Fq+lcGniaPR83c9aWVp1Br8qEJfHw998j1r3BxFYNHpWoiRe6FltLmo7OSc5cZMArlvAowrx+G8+9zhoCm2z1IsoXTKhIAitPjU8gHvSQ+LFgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id EDF682C06A86;
	Wed,  7 Jan 2026 10:56:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D862D30996; Wed,  7 Jan 2026 10:56:24 +0100 (CET)
Date: Wed, 7 Jan 2026 10:56:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <aV4tyKPGioCqXTRr@wunner.de>
References: <20260107081445.1100-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107081445.1100-1-atharvatiwarilinuxdev@gmail.com>

On Wed, Jan 07, 2026 at 08:14:35AM +0000, Atharva Tiwari wrote:
> Changes since v1:
> 	Transferred logic to drivers/pci/quicks.c

This should go below the line with the three dashes
so that it's not included in the commit when the patch
is applied to the maintainer's git tree.

> Disable AER for Intel Titan Ridge 4C 2018
> (used in T2 iMacs, where the warnings appear)
> that generate continuous pcieport warnings. such as:
> 
> pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
> pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
> pcieport 0000:07:00.0:    [ 7] BadDLLP
> 
> (see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)

Use a Link: or Closes: tag for the bugzilla URL.

> macOS also disables AER for Thunderbolt devices and controllers in their drivers.

Could you provide a link to the xnu source code
so that we can double-check what they're doing and why?

> +++ b/drivers/pci/quirks.c
> @@ -6340,4 +6340,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
> +
> +static void pci_disable_aer(struct pci_dev *pdev)
> +{
> +	pdev->no_aer = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EA, pci_disable_aer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EB, pci_disable_aer);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15EC, pci_disable_aer);
> +

This will disable AER on all arches for all users, yet you've claimed
that the issue is confined to T2 Macs and caused by their firmware.

The proper approach would be to move this quirk to arch/x86/pci/fixups.c
so that it's not compiled on other arches.  Moreover you need a DMI check
to constrain this to T2 Macs so that AER stays enabled on other machines.

Since this is a discrete Thunderbolt controller, it is important to cc
Thunderbolt maintainers to get their feedback, yet your v2 patch wasn't
cc'ed to them.  Please be sure to include them in any follow-up submissions.

Thanks,

Lukas

