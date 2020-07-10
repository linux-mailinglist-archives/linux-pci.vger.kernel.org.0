Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD021ABE2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 02:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGJALF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 20:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGJALF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 20:11:05 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3DD2065F;
        Fri, 10 Jul 2020 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594339864;
        bh=zjtQl0zJdRLAoPslwauIn4hY5qrh4R5fGBwA/jfVB3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i5Ht+NQkFU6WDbFOgD27hnMeIlHHDypgYQfNgtwIMhzX4nFu5e+cC4LAhzpZvcgqw
         tRvFvNsExcRCG1BZwc+ilVRRcnJct5krKpehbyS2jo9E+HjljqUXpevmkL+Us6sMeo
         X3vLlhpQu3sZLXuKtjyht+WP7cAC5QFVi9eQ5kk8=
Date:   Thu, 9 Jul 2020 19:11:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/11 RFC] PCI: Remove "*val = 0" from
 pcie_capability_read_*()
Message-ID: <20200710001102.GA29833@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706093121.9731-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cc list is really screwed up.  Here's what I got:

  Cc: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
	  bjorn@helgaas.com,
	  skhan@linuxfoundation.org,
	  linux-pci@vger.kernel.org,
	  linux-kernel-mentees@lists.linuxfoundation.org,
	  linux-kernel@vger.kernel.org,
	  Russell Currey <ruscur@russell.cc>,
	  Sam Bobroff <sbobroff@linux.ibm.com>,
	  "Oliver O'Halloran" <oohall@gmail.com>,
	  linuxppc-dev@lists.ozlabs.org,
	  "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	  Len Brown Lukas Wunner <lenb@kernel.orglukas@wunner.de>,
	  linux-acpi@vger.kernel.org,
	  Mike Marciniszyn <mike.marciniszyn@intel.com>,
	  Dennis Dalessandro <dennis.dalessandro@intel.com>,
	  Doug Ledford <dledford@redhat.com>,
	  Jason Gunthorpe <jgg@ziepe.ca>,
	  linux-rdma@vger.kernel.org,
	  Arnd Bergmann <arnd@arndb.de>,
	  "Greg Kroah-Hartman linux-rdma @ vger . kernel . org" <gregkh@linuxfoundation.org>

The addresses for Len Brown and Lukas Wunner are corrupted, as is Greg
KH's.  And my reply-all didn't work -- it *should* have copied this to
everybody in the list, but Mutt apparently couldn't interpret the cc
list at all, so it left the cc list of my reply empty.

I added linux-pci by hand just so this will show up on the list.

On Mon, Jul 06, 2020 at 11:31:10AM +0200, Saheed Olayemi Bolarinwa wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> *** BLURB HERE ***

This series isn't structured quite right.  You should replace the
"BLURB HERE" above with an actual description of the series.

> Bolarinwa Olayemi Saheed (9):
>   IB/hfi1: Confirm that pcie_capability_read_dword() is successful
>   misc: rtsx: Confirm that pcie_capability_read_word() is successful
>   PCI/AER: Use error return value from pcie_capability_read_*()
>   PCI/ASPM: Use error return value from pcie_capability_read_*()
>   PCI: pciehp: Fix wrong failure check on pcie_capability_read_*()
>   PCI: pciehp: Prevent wrong failure check on pcie_capability_read_*()
>   PCI: pciehp: Make "Power On" the default in pciehp_get_power_status()
>   PCI/ACPI: Prevent wrong failure check on pcie_capability_read_*()
>   PCI: Prevent wrong failure check on pcie_capability_read_*()
>   PCI: Remove "*val = 0" fom pcie_capability_read_*()

And the subject claims 11 patches ("PATCH 0/11"), the header above
claims 9, the list actually contains 10, and only 8 seem to have made
it to the mailing list:

$ b4 am -om/ https://lore.kernel.org/r/20200706093121.9731-1-refactormyself@gmail.com
Looking up https://lore.kernel.org/r/20200706093121.9731-1-refactormyself%40gmail.com
Grabbing thread from lore.kernel.org/linux-kernel-mentees
Analyzing 9 messages in the thread
---
Thread incomplete, attempting to backfill
Grabbing thread from lore.kernel.org/linuxppc-dev
Grabbing thread from lore.kernel.org/lkml
Server returned an error: 404
Grabbing thread from lore.kernel.org/linux-acpi
Server returned an error: 404
Grabbing thread from lore.kernel.org/linux-pci
Server returned an error: 404
Grabbing thread from lore.kernel.org/linux-rdma
Server returned an error: 404
---
Writing m/20200706_refactormyself_pci_remove_val_0_from_pcie_capability_read.mbx
  ERROR: missing [1/11]!
  [PATCH 2/11 RFC] misc: rtsx: Confirm that pcie_capability_read_word() is successful
  [PATCH 3/11 RFC] PCI: pciehp: Validate with the return value of pcie_capability_read_*()
  [PATCH 4/11 RFC] PCI: pciehp: Validate with the return value of pcie_capability_read_*()
  [PATCH 5/11 RFC] PCI: pciehp: Make "Power On" the default
  ERROR: missing [6/11]!
  [PATCH 7/11 RFC] PCI: Validate with the return value of pcie_capability_read_*()
  [PATCH 8/11 RFC] PCI/PM: Use error return value from pcie_capability_read_*()
  ERROR: missing [9/11]!
  [PATCH 10/11 RFC] PCI/ASPM: Use error return value from pcie_capability_read_*()
  [PATCH 11/11 RFC] PCI: Remove "*val = 0" from pcie_capability_read_*()
---
Total patches: 8
---
WARNING: Thread incomplete!

