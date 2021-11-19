Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B1457849
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 22:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhKSVqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 16:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhKSVqI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 16:46:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5DC261AFF;
        Fri, 19 Nov 2021 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637358186;
        bh=LK8t2KpV+SC3gzht77RJ7YzUOtHsij629DK8RvTIS1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dqDeAStixRThTahKNsaLwebOmGWEHs6A5/z6AOSv8flMtKnD2KcyRRoPKnPzHQszL
         3A0/2Se4HZX6YyyCGW6WymUHBLn9eZTPohC2nmg9IA6gWr84vJNafxBGf+xnGZnD5i
         jwb/l8nBXyPSlNiIbCLgpCXQ0QT/tJ5XRq4xy7ENdvPyzWnuoPKcMMEOiJEGd2v80q
         6xN9B0eN/T5XvhZNtfQRdn/Ndt5yyKXxvLQxSpxgP0EzeUaVY5QCTk5rTPC1zjnnOF
         jCMXBrFIy87ba9o1BAdUOTKtYydu1pT7RhgqiQscAAFY5VYv1qvJL37LHSkmBrwjRV
         GF1mSw2R5OBcA==
Date:   Fri, 19 Nov 2021 15:43:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Update BAR # and window messages
Message-ID: <20211119214304.GA1963177@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106115831.GA7452@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 06, 2021 at 12:58:31PM +0100, Lukas Wunner wrote:
> On Sat, Nov 06, 2021 at 04:56:05PM +0530, Puranjay Mohan wrote:
> > +		switch (i) {
> > +		case 0: return "BAR 0";
> > +		case 1: return "BAR 1";
> > +		case 2: return "BAR 2";
> > +		case 3: return "BAR 3";
> > +		case 4: return "BAR 4";
> > +		case 5: return "BAR 5";
> > +		case PCI_ROM_RESOURCE: return "ROM";
> > +		#ifdef CONFIG_PCI_IOV
> > +		case PCI_IOV_RESOURCES + 0: return "VF BAR 0";
> > +		case PCI_IOV_RESOURCES + 1: return "VF BAR 1";
> > +		case PCI_IOV_RESOURCES + 2: return "VF BAR 2";
> > +		case PCI_IOV_RESOURCES + 3: return "VF BAR 3";
> > +		case PCI_IOV_RESOURCES + 4: return "VF BAR 4";
> > +		case PCI_IOV_RESOURCES + 5: return "VF BAR 5";
> > +		#endif
> > +		}
> 
> Use a static const array of char * instead of a switch/case ladder
> to reduce LoC count and improve performance.
> 
> See pcie_to_hpx3_type[] or state_conv[] in drivers/pci/pci-acpi.c
> for an example.

I tried converting this and came up with the below.  Is that the sort
of thing you're thinking?  Gcc *does* generate slightly smaller code
for it, but Puranjay's original source code is smaller and IMO a
little easier to read.

And I just noticed that Puranjay's code nicely returns "unknown" for
BAR 2-5 of bridges, while my code below does not.  Could be fixed, of
course, but would take a little more code.

  const char *pci_resource_name(struct pci_dev *dev, int i)
  {
	  static const char *bar_name[] = {
		  "BAR 0",
		  "BAR 1",
		  "BAR 2",
		  "BAR 3",
		  "BAR 4",
		  "BAR 5",
		  "ROM",
  #ifdef CONFIG_PCI_IOV
		  "VF BAR 0",
		  "VF BAR 1",
		  "VF BAR 2",
		  "VF BAR 3",
		  "VF BAR 4",
		  "VF BAR 5",
  #endif
		  "bridge I/O window",
		  "bridge mem window",
		  "bridge mem pref window",
	  };
	  static const char *cardbus_name[] = {
		  "BAR 0",
		  "unknown",
		  "unknown",
		  "unknown",
		  "unknown",
		  "unknown",
		  "unknown",
  #ifdef CONFIG_PCI_IOV
		  "unknown",
		  "unknown",
		  "unknown",
		  "unknown",
		  "unknown",
		  "unknown",
  #endif
		  "CardBus bridge I/O 0 window",
		  "CardBus bridge I/O 1 window",
		  "CardBus bridge mem 0 window",
		  "CardBus bridge mem 1 window",
	  };

	  if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS &&
	      i < ARRAY_SIZE(cardbus_name))
		  return cardbus_name[i];
	  else if (i < ARRAY_SIZE(bar_name))
		  return bar_name[i];

	  return "unknown";
  }
