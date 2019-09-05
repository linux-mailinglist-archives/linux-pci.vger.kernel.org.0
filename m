Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C09AAEBC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 00:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfIEWx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 18:53:59 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60700 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfIEWx7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 18:53:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i60dH-0003db-Tc; Fri, 06 Sep 2019 08:53:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Sep 2019 08:53:32 +1000
Date:   Fri, 6 Sep 2019 08:53:32 +1000
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
Message-ID: <20190905225332.GA4123@gondor.apana.org.au>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <20190904122600.GA28660@gondor.apana.org.au>
 <20190905210722.GH103977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905210722.GH103977@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 04:07:22PM -0500, Bjorn Helgaas wrote:
>
> > This patch adds stub functions pci_alloc_irq_vectors_affinity and
> > pci_irq_vector when CONFIG_PCI is off so that drivers can use them
> > without resorting to ifdefs.
> > 
> > It also moves the PCI_IRQ_* macros outside of the ifdefs so that
> > they are always available.
> > 
> > Fixes: 625f269a5a7a ("crypto: inside-secure - add support for...")
> 
> I don't see this commit in Linus' tree yet.
> 
> I'd like to include the actual reason for this patch in the commit
> log.  I assume it's fixing a build issue, but I'd like to be a little
> more specific about it.

The patch in question is

https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=625f269a5a7a3643771320387e474bd0a61d9654

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
