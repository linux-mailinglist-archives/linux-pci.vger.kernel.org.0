Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D833C06
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFCXlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 19:41:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:43976 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCXlf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 19:41:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x53NfGPf015895;
        Mon, 3 Jun 2019 18:41:17 -0500
Message-ID: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
Subject: [RFC] ARM64 PCI resource survey issue(s)
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Tue, 04 Jun 2019 09:41:16 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks !

I'd like to revive the discussion around Ard's old patch:

https://patchwork.kernel.org/patch/9675707/

We (Amazon) need that sorted one way or another ASAP since we have
setups coming where we must not let Linux change the FW assignments
under some host bridges.

In fact it's a reasonable thing to require for other reasons. The EFI
framebuffer is an example, there can be others where FW/ACPI/EL3 etc...
might have assumptions based on where some system devices were located
by the boot FW and will break if we move them (such things are common
on x86 and powerpc).

Taking a step back I think (and I suspect we generally agree based on
followup discussions I've seen) that the "right" thing to do is to have
our default behaviour be:

   - Claim what the FW established if it's not obviously broken

   - Call pci_assign_unassigned_resources() to assign what the FW
didn't assign

Which is more or less what powerpc and x86 do today, but using a
different mechanism than what's in pci_bus_claim_resources() (they are
similar to each other, I wrote the current powerpc one loosely based on
the x86 one at the time). That leads to a side question (which we
should probably discuss in a separate thread) of whether we want to
consolidate all that.

That said, we also know this is going to break *some* existing
platforms that have known broken FW assignment. The question is then
can we sufficiently detect the breakage and re-assign in those cases
(like x86 does fairly successfully in a number of cases), or do we need
to add some board/platform quirks to force the full re-assigment on
known broken platforms ?

Even if all arm64 platforms are found to be broken today, I would still
like to have our default be to use the FW setup, if anything as an
incentive for newer platforms to get it right. At the very least on
ACPI.

We can use DSM#5 when it exists to force one way or another (ideally on
a per bus basis but that's harder, so let's start with host bridges
maybe ?)

Thoughts ? I'm happy to do some of the work here. We have an emergency
to get the AZ case solved, and Ard old patch does that...

Cheers,
Ben.


