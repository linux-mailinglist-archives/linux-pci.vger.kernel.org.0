Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5762F5E726C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 05:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiIWD1e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 22 Sep 2022 23:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIWD1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 23:27:31 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BC8BEBBDD;
        Thu, 22 Sep 2022 20:27:30 -0700 (PDT)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28N3LWpA028633;
        Thu, 22 Sep 2022 22:21:33 -0500
Message-ID: <14c592e1d0a6126a66cfab1851d52d097023b74f.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc/pci: Prefer PCI domain assignment via DT
 'linux,pci-domain' and alias
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 23 Sep 2022 13:21:30 +1000
In-Reply-To: <874jyevz2g.fsf@mpe.ellerman.id.au>
References: <20220706102148.5060-1-pali@kernel.org>
         <20220706102148.5060-2-pali@kernel.org>
         <20220813135735.GA3413265@roeck-us.net> <874jyevz2g.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2022-08-15 at 15:46 +1000, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> > On Wed, Jul 06, 2022 at 12:21:48PM +0200, Pali Rohár wrote:
> > > Other Linux architectures use DT property 'linux,pci-domain' for specifying
> > > fixed PCI domain of PCI controller specified in Device-Tree.
> > > 
> > > And lot of Freescale powerpc boards have defined numbered pci alias in
> > > Device-Tree for every PCIe controller which number specify preferred PCI
> > > domain.
> > > 
> > > So prefer usage of DT property 'linux,pci-domain' (via function
> > > of_get_pci_domain_nr()) and DT pci alias (via function of_alias_get_id())
> > > on powerpc architecture for assigning PCI domain to PCI controller.
> > > 
> > > Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > This patch results in a number of boot warnings with various qemu
> > boot tests.
> 
> Thanks for the report.
> 
> I have automated qemu boot tests to catch things like this, they even
> have DEBUG_ATOMIC_SLEEP enabled ... but I inadvertantly broke my script
> that checks for "BUG:" in the console log. Sometimes you just can't
> win.

So the problem is

 	spin_lock(&hose_spinlock);

get_phb_number() relies on it for the phb_bitmap allocation. You can
move it out of the lock but you'll have to either:

 - Take the lock inside it to protect the allocation

 - Turn find_first_zero_bit/set_bit into a loop of
find_first_zero_bit+test_and_set_bit() which wouldn't require a lock.

Note about the other "reg" numbering conversation ... I'm pretty sure
that breaks some old PowerMac crap which shows nobody really uses these
things considering how long the patch has been there :-)

I'm pretty sure something somewhere assumes the primary bus is 0. Some
old userspace definitely does though that might no longer be relevant.
The whole business with "domain 0" being special and avoiding domain
numbers in /proc relies on this too...

Cheers,
Ben.
