Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD162F56D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiKRM7N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiKRM7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:59:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FE714D2E;
        Fri, 18 Nov 2022 04:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J4CE2a9Srvxn0Qx3Ispk4fD7htx4Z++quEKnuvxGERg=; b=TnXvNVBFJrO4X+NPoheahskMC3
        tdIvrpbH20MV6vs8DNk/2yox4p5BwykAU45N5JBs/OXr4rt5jVqWlbGibk7w3kTRu6rWTPiYoTVXw
        2xmDhGjgWc+ifw7WAuA7/VYB73/Njtsce/UekGqh2B1pXZo27sO1m10JuJ5C2JHQufZDT6vEpMT8o
        H+VfDp2wYbo9rsl3z7w3v6GVduCqZQQ2+K3Cfy0JL+bfVjnUn0s2QTqAAnEf6EE04m1NwNXE5X41W
        we8Z2dj1uKp3H9AuQg5os2rA6TNrHXb6pfsuW+DGewM+9vK9Xf0yf5ayBwGLyagPu0/q+1CUROjMY
        z9Npe2iQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ow0wr-001zY7-5L; Fri, 18 Nov 2022 12:58:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9EB0300422;
        Fri, 18 Nov 2022 13:58:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FE562D2BCFED; Fri, 18 Nov 2022 13:58:22 +0100 (CET)
Date:   Fri, 18 Nov 2022 13:58:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, corbet@lwn.net
Subject: Re: [patch 23/39] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to
 api.c
Message-ID: <Y3eBbgjOq5EXnBQB@hirez.programming.kicks-ass.net>
References: <20221111122014.927531290@linutronix.de>
 <20221116162322.GA1115421@bhelgaas>
 <Y3d7xJ5hvhxlRrOE@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3d7xJ5hvhxlRrOE@lx-t490>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 18, 2022 at 01:34:12PM +0100, Ahmed S. Darwish wrote:
> On Wed, Nov 16, 2022 at 10:23:22AM -0600, Bjorn Helgaas wrote:
> > On Fri, Nov 11, 2022 at 02:54:51PM +0100, Thomas Gleixner wrote:
> ...
> > > +
> > > +/**
> > > + * pci_alloc_irq_vectors_affinity() - Allocate multiple device interrupt
> > > + *                                    vectors with affinity requirements
> > > + * @dev:      the PCI device to operate on
> > > + * @min_vecs: minimum required number of vectors (must be >= 1)
> > > + * @max_vecs: maximum desired number of vectors
> > > + * @flags:    allocation flags, as in pci_alloc_irq_vectors()
> > > + * @affd:     affinity requirements (can be %NULL).
> > > + *
> > > + * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
> > > + * Check that function docs, and &struct irq_affinity, for more details.
> >
> > Is "&struct irq_affinity" some kernel-doc syntax, or is the "&"
> > superfluous?
> >
> 
> Hmmm, I stole it from Documentation/doc-guide/kernel-doc.rst. htmldoc
> parses it and generates a link to the referenced structure's kernel-doc.
> 
> But, yeah, this was literally the first usage of such a doc pattern in
> the entire kernel's C code :)

Perhaps then not start with it and instead try and convince John to make
his script more clever -- this same script already recognises functions
by their () suffix, might as well also key off the 'struct' keyword, no?

This is a Code comment, to be read in a text editor. That & is a syntax
error.

