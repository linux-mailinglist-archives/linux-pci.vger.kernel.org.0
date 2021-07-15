Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4E3CAF82
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhGOXIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 19:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhGOXIB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 19:08:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 875CB61006;
        Thu, 15 Jul 2021 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626390307;
        bh=hB4j2xcSGpeH2RlXkelUF8IH0MSw0nn8IqEFlfYWtIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DFdBVLi2s90MMjbgkz1U4SsmBZxSTM+pitUyIWNC8QjZjKqe6eTlmgV0K9wwIGbux
         UlQHibgxIAdwlKh4dyomk8vquF6QnwLlbJSa8gm8BOgMJuSUgeyxwo9EX1VRnC3DkL
         DhrEVEWlyOCFSspV7/vBYuqZ+qgZboflq6iIQkO1kpRQ/gpBueI34JimP6pIPe7DCc
         E8ma4tnxEAjaiovO4iBdvxW1N8/A0JWUdaPgsORLESUfXyWUgEAUs5t6aB+2frm4ra
         APYCx2Y5mcQW3yv4HoAfvExqtEeFNAscghkWG/Kx9Ulbx3ZoslfxVQkzPGy4Ckp17W
         sBg+V8tNgzwsg==
Date:   Thu, 15 Jul 2021 18:05:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ruben <rubenbryon@gmail.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [question]: BAR allocation failing
Message-ID: <20210715230506.GA2014923@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALdZjm6iDnCR7OWzfCuKOALAtN-FoVvTdxUB=XcAFqHg5Aumpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 11:39:54PM +0300, Ruben wrote:
> Thanks for the response, here's a link to the entire dmesg log:
> https://drive.google.com/file/d/1Uau0cgd2ymYGDXNr1mA9X_UdLoMH_Azn/view
> 
> Some entries that might be of interest:

ACPI tells us the host bridge windows are:

  acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
  acpi PNP0A08:00: host bridge window [mem 0x80000000-0xafffffff window] (ignored)
  acpi PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff window] (ignored)
  acpi PNP0A08:00: host bridge window [mem 0x800000000-0xfffffffff window] (ignored)

The 0xc0000000 window is about 1GB and is below 4GB.
The 0x800000000 window looks like 32GB.

But "pci=nocrs" means we ignore these windows ...

> pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]

and instead use this 1TB of address space, from which DRAM is
excluded.  I think this is basically everything the CPU can address,
and I *think* it comes from this in setup_arch():

  iomem_resource.end = (1ULL << boot_cpu_data.x86_phys_bits) - 1;

But you have 8 GPUs, each of which needs 128GB + 32MB + 16MB, so you
need 1TB + 384MB to map them all, and the CPU can't address that much.

Since you're running this on qemu, I assume x86_phys_bits is telling
us about the capabilities of the CPU qemu is emulating.  Maybe there's
a way to tell qemu to emulate a CPU with more address bits?

Bjorn
