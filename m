Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1509C4B69
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfJBK2F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 2 Oct 2019 06:28:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfJBK2E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Oct 2019 06:28:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F24E300C76A;
        Wed,  2 Oct 2019 10:28:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7943A5C226;
        Wed,  2 Oct 2019 10:28:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190930121313.GV32742@smile.fi.intel.com>
References: <20190930121313.GV32742@smile.fi.intel.com> <20190827151823.75312-1-andriy.shevchenko@linux.intel.com> <20190927123913.GA32321@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dhowells@redhat.com, Bjorn Helgaas <helgaas@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/AER: Use for_each_set_bit()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11308.1570012079.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 02 Oct 2019 11:27:59 +0100
Message-ID: <11309.1570012079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 02 Oct 2019 10:28:04 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > but I confess to being a little ambivalent.  It's
> > arguably a little easier to read,
> 
> I have another opinion here. Instead of parsing body of for-loop, the name of
> the function tells you exactly what it's done. Besides the fact that reading
> and parsing two lines, with zero conditionals, is faster.
> 
> > but it's not nearly as efficient
> > (not a great concern here)
> 
> David, do you know why for_each_set_bit() has no optimization for the cases
> when nbits <= BITS_PER_LONG? (Actually find_*bit() family of functions)

I've not had anything to do with for_each_set_bit() itself.

By 'nbits', I presume you mean the size parameter - max in the sample bit of
code.

It would need per-arch optimisation.  Some arches have an instruction to find
the next bit and some don't.

Using for_each_set_bit() like this is definitely suboptimal, since
find_first_bit() and find_next_bit() may well be out of line.

It should probably be using something like __ffs() if size <= BITS_PER_LONG.

David
