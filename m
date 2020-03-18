Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB11893B1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 02:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRBef convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 17 Mar 2020 21:34:35 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:57290 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgCRBef (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 21:34:35 -0400
Received: from glidewell.localnet (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 12BC73D9E7;
        Tue, 17 Mar 2020 21:34:34 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH RESEND v2 2/2] PCI: Use ioremap(), not phys_to_virt() for platform ROM
Date:   Tue, 17 Mar 2020 21:34:33 -0400
Message-ID: <49518530.5kixuQOrMm@glidewell>
In-Reply-To: <20200317144731.GG23471@infradead.org>
References: <20200313222258.15659-1-mikel@mikelr.com> <20200313222258.15659-3-mikel@mikelr.com> <20200317144731.GG23471@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

Thanks for your comments. I'm also replying here to your comments on the 
previous series.

On Tuesday, March 17, 2020 10:28:35 AM EDT Christoph Hellwig wrote:
> Any reason drivers can't just use pci_map_rom insteadἅ which already
> does the right thing?

Some machines don't expose the video BIOS in the PCI BAR and instead only make 
it available via EFI boot services calls. So drivers need to be able to use 
the ROM provided by EFI calls, but only if they can't find a valid one anywhere 
else.

At one point, the EFI provided ROM in pdev->rom *was* exposed via 
pci_map_rom(). However it had to be split out into a separate function so that 
drivers could have more control over which sources were preferred.

On Tuesday, March 17, 2020 10:29:13 AM EDT Christoph Hellwig wrote:
> This and the next patch really need to be folded into the previous
> one to avoid regressions (assuming my other suggestion doesn't work
> for some reason).

Addressed in v2

On Tuesday, March 17, 2020 10:47:31 AM EDT Christoph Hellwig wrote:
> What is the value of this helper over just open coding an ioremap
> of pdev->rom in the callers?

I think the direct access to pdev->rom you suggest makes sense, especially 
because users of the pci_platform_rom() are exposed to the fact that it just 
calls ioremap().

I decided against wrapping the iounmap() with a pci_unmap_platform_rom(), but 
I didn't apply the same consideration to the existing function.

How about something like this (with pci_platform_rom() removed)?

static bool radeon_read_platform_bios(struct radeon_device *rdev)
{
	phys_addr_t rom = rdev->pdev->rom;
	size_t romlen = rdev->pdev->romlen;
	void __iomem *bios;

	rdev->bios = NULL;

	if (!rom || romlen == 0)
		return false;

	rdev->bios = kzalloc(romlen, GFP_KERNEL);
	if (!rdev->bios)
		return false;

	bios = ioremap(rom, romlen);
	if (!bios)
		goto free_bios;

	memcpy_fromio(rdev->bios, bios, romlen);
	iounmap(bios);

	if (rdev->bios[0] != 0x55 || rdev->bios[1] != 0xaa)
		goto free_bios;

	return true;
free_bios:
	kfree(rdev->bios);
	return false;
}

If this is preferred, I'll send an updated series. I'm assuming that the 
removal of pci_platform_rom() and updating of all the callers should be 
combined into this patch.

Thanks,
Mikel
