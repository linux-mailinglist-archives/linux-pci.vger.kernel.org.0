Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B762F4E0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiKRMeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiKRMeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:34:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19EB239;
        Fri, 18 Nov 2022 04:34:16 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:34:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668774854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC43CUGHQ/5Kf6dfYdK3BkocoYb1pAZJ53OoTDcNf8Y=;
        b=HlA1H0xw89I6mNXZxJfbzjZ9tZMqyfafZ+aFSsNCpLNVFZG4Syb23GWBxogyjR8JsPjoz+
        VaJuo4yvuubjsDScFNOYEhnvI/JnS50bh59eCBKM3N2Hq305ykQSGUWvNmepJIi6ASnhEc
        Egre6BUTheWsCqNBhLfaHD5mXybAE0gZ+FrjXOTtPkHjlj1OyuGGhfr+5pqAEy+A0dS6jh
        kcjwSSW9Tqj8sV8GpamJiaL4VlNH9fNu7sKS2Z78pFtMLjks7075EQmH7e+rMAWL9esRD6
        dFYnvxDpqSenJCJPs1AmOrXBDZqyETwBR2olcWtWGEx6Ik89o+rGvcZQw37D4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668774854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC43CUGHQ/5Kf6dfYdK3BkocoYb1pAZJ53OoTDcNf8Y=;
        b=54xzcv2ka0wlcFsUA4oLtl2S4yVRp9s6mDU2H/QJ/HHTk3ITsJRt1buBfx5tYa3HRGPopw
        Vlw+RnH01UQJ2kAg==
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 23/39] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to
 api.c
Message-ID: <Y3d7xJ5hvhxlRrOE@lx-t490>
References: <20221111122014.927531290@linutronix.de>
 <20221116162322.GA1115421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116162322.GA1115421@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 10:23:22AM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:54:51PM +0100, Thomas Gleixner wrote:
...
> > +
> > +/**
> > + * pci_alloc_irq_vectors_affinity() - Allocate multiple device interrupt
> > + *                                    vectors with affinity requirements
> > + * @dev:      the PCI device to operate on
> > + * @min_vecs: minimum required number of vectors (must be >= 1)
> > + * @max_vecs: maximum desired number of vectors
> > + * @flags:    allocation flags, as in pci_alloc_irq_vectors()
> > + * @affd:     affinity requirements (can be %NULL).
> > + *
> > + * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
> > + * Check that function docs, and &struct irq_affinity, for more details.
>
> Is "&struct irq_affinity" some kernel-doc syntax, or is the "&"
> superfluous?
>

Hmmm, I stole it from Documentation/doc-guide/kernel-doc.rst. htmldoc
parses it and generates a link to the referenced structure's kernel-doc.

But, yeah, this was literally the first usage of such a doc pattern in
the entire kernel's C code :)

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
