Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5ADB99FC
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2019 01:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393850AbfITXRU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 19:17:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34726 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391290AbfITXRT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 19:17:19 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iBS8o-0002ql-AR; Sat, 21 Sep 2019 09:16:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Sep 2019 09:16:34 +1000
Date:   Sat, 21 Sep 2019 09:16:34 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci@vger.kernel.org,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCI: Add stub pci_irq_vector and others
Message-ID: <20190920231634.GA31195@gondor.apana.org.au>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <20190904122600.GA28660@gondor.apana.org.au>
 <20190920194216.GB226476@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920194216.GB226476@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 20, 2019 at 02:42:16PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 04, 2019 at 10:26:00PM +1000, Herbert Xu wrote:
> > On Wed, Sep 04, 2019 at 05:10:34AM -0700, Ard Biesheuvel wrote:
> > >
> > > This is the reason we have so many empty static inline functions in
> > > header files - it ensures that the symbols are declared even if the
> > > only invocations are from dead code.
> > 
> > Does this patch work?
> > 
> > ---8<---
> > This patch adds stub functions pci_alloc_irq_vectors_affinity and
> > pci_irq_vector when CONFIG_PCI is off so that drivers can use them
> > without resorting to ifdefs.
> > 
> > It also moves the PCI_IRQ_* macros outside of the ifdefs so that
> > they are always available.
> > 
> > Fixes: 625f269a5a7a ("crypto: inside-secure - add support for...")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: YueHaibing <yuehaibing@huawei.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Since you've already sent your crypto pull request for v5.4, would you
> like me to include this in mine?

That would be great.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
