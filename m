Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8962D1E2F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 00:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgLGXOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 18:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgLGXOk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 18:14:40 -0500
Date:   Mon, 7 Dec 2020 17:13:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607382839;
        bh=cXfHp8rY0otTmdq70U0JaHFS3z/C6N9ZE5vVO206Cp8=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=qbNB9JoW4ZS/8QtEILp4RhBYsRb5HjzhEjioX48IF8m3VrzOcJ8ezW4i+tUFQ4as9
         O4ZUxrjn5HKeeV8mh/UxEAysDRXW00fqrTKwnb8P9rba6Oa2NfAQ6lWapsr4KR2jHL
         vu65r0vWyZJaU+FOyC9+Grr205v6na0HZPuLJSTJ9Waf17DnMHo0Dwc1i5VaHGIZt3
         Qza1Jy+dZ+30XgpAtzgXwiLXjHEXmpg7PRZSqHNjKZ8r01ERCjdVs54v05skU4Va1c
         RoSX/wHf2WWkriqdgzFht8so6P0E0B+C6Lt70Pbh5E8B4/AD46w1572ctuqEGXOD+x
         v3dTYO7TyKsnA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
Message-ID: <20201207231357.GA2310757@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672a0bc2-717a-2545-6a19-8ca7e209c523@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 07, 2020 at 09:44:20AM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 12/7/20 5:08 AM, Paul Menzel wrote:
> > [Bringing the issue up on the list in case the Linux Bugzilla is not monitored/used.]
> > 
> > 
> > Dear Linux folks,
> > 
> > 
> > On Intel Tiger Lake Dell laptop, Linux logs the error below [1].
> > 
> >      [    0.507307] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
> >      [    0.508835] pci 0000:00:07.2: DPC: RP PIO log size 0 is invalid
> > 
> >      $ lspci -nn -s 00:07
> >      00:07.0 PCI bridge [0604]: Intel Corporation Tiger Lake-LP
> > Thunderbolt PCI Express Root Port #0 [8086:9a23] (rev 01)
> >      00:07.2 PCI bridge [0604]: Intel Corporation Tiger Lake-LP
> > Thunderbolt PCI Express Root Port #2 [8086:9a27] (rev 01)
> > 
> > Commit 2700561817 (PCI/DPC: Cache DPC capabilities in
> > pci_init_capabilities()) [1] probably introduced it in Linux 5.7.
> > 
> > What does this error actually mean?
> > 
> >      pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
> >      if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> >          pci_err(pdev, "RP PIO log size %u is invalid\n",
> >              pdev->dpc_rp_log_size);
> >          pdev->dpc_rp_log_size = 0;
> As per PCIe spec r5.0, sec 7.9.15.2, valid RP log size is 4 or greater. Please see
> the text copied from spec
> 
> - - - -
> RP PIO Log Size - This field indicates how many DWORDs are allocated for the RP
> PIO log registers, comprised by the RP PIO Header Log, the RP PIO ImpSpec Log,
> and RP PIO TLP Prefix Log. If the Root Port supports RP Extensions for DPC, the
> value of this field must be 4 or greater; otherwise, the value of
> this field must be 0. See Section 7.9.15.11 , Section 7.9.15.12 , and Section 7.9.15.13 .
> - - - -
> 
> In this case, since "(!(cap & PCI_EXP_DPC_CAP_RP_EXT))" condition is false, RP
> EXT is supported. If RP EXT is supported, valid log size should be at-least 4.
> 
> 
> >      }
> > 
> > (I guess `cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE` is zero too?)
> > 
> > Is it a firmware issue or a hardware issue?
> I think this could be hardware issue.

I agree, it looks like a hardware issue.  I posted this to the
bugzilla before I saw this email:

  I assume the only problem is the "DPC: RP PIO log size 0 is invalid"
  message itself?

  It sure looks like the device is out of spec because PCIe r5.0, sec
  7.9.15.2, says

    RP PIO Log Size - This field indicates how many DWORDs are
    allocated for the RP PIO log registers, comprised by the RP PIO
    Header Log, the RP PIO ImpSpec Log, and RP PIO TLP Prefix Log. If
    the Root Port supports RP Extensions for DPC, the value of this
    field must be 4 or greater; otherwise, the value of this field
    must be 0.

  Maybe we just need to tone down the message to pci_info()?  It looks
  like dpc_process_rp_pio_error() would do the right thing even when
  dpc_rp_log_size == 0.

  In the attached messages, the firmware retains control of AER, so
  Linux never tries to use DPC itself anyway.

> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=209943
> >       "pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid"
> > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27005618178ef9e9bf9c42fd91101771c92e9308
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
