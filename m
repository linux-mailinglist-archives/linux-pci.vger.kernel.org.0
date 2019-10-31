Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2185EEB216
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfJaOFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 10:05:45 -0400
Received: from mail.gnudd.com ([77.43.112.34]:47462 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfJaOFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 10:05:45 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 10:05:45 EDT
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id x9VDx046011812;
        Thu, 31 Oct 2019 14:59:00 +0100
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.4/8.14.4/Submit) id x9VDx0vL011811;
        Thu, 31 Oct 2019 14:59:00 +0100
Date:   Thu, 31 Oct 2019 14:59:00 +0100
From:   Alessandro Rubini <rubini@gnudd.com>
To:     nsaenzjulienne@suse.de
Cc:     hch@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/PCI: sta2x11: use default DMA address
 translation
Message-ID: <20191031135900.GA11804@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <51101de0f3b0fc5a3678c1ee0c723b131471f1b6.camel@suse.de>
References: <51101de0f3b0fc5a3678c1ee0c723b131471f1b6.camel@suse.de>
  <20191018110044.22062-1-nsaenzjulienne@suse.de>
  <20191018110044.22062-3-nsaenzjulienne@suse.de>
  <20191030214548.GC25515@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>> But I can't tested it either, and kinda wonder if this code is actually
>> still used by anyone..

I wonder too.
 
> Maybe Alessandro can shine some light on this (though I wonder his
> mail is stil valid).

Yes, the mail is valid, and I'm busy as usual.

Now, this STA2X11 is a chipset by ST-Ericcson that was bringing the
AMBA peripherals to the PC world. It was meant to be used as an I/O
device in the automotive sector, as far as I know (the audio part had
features aimed at automotive installations).  I'm sure the chip was
never used in standard PC's -- the eval board was a PCIe slot, but
that's it.

So, I can't test and I don't know if there are users of this chip.
If there are users, they are big numbers.  I think we can accept any
clean-up patch on the code base: if anything goes wrong, the users
will surface with a fix when they'll consider an upgrade to their
installed systems.

/alessndro
