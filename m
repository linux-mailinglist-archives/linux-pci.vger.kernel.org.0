Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7A659203
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 22:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiL2VKA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 16:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL2VJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 16:09:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67A10C1
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 13:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Ovp2fqpSf9X2ykkbdYTb37HQpmr59niPo1yHR1K8p6o=; b=snN47Z8sxmwVyu6SA73F3pmJtZ
        OkdS0hCSiYtr2CqZT+qac6GzIBlJKT4+AkRVXM8kaPXMDAQlakqGMtsfBvOtBeZU6C+xam5yKFRtA
        AsRat1jKszeKzeU/EfCjhLvbz2de+H+YG6dA/bKczqrl0g8Cuku6GDgtfhbWvp4Ycqx2SqF1GXOhJ
        fSQyWR/mxZs1g/yCMQ0gmlHpsbZ/Ge4VuyBflLXOe1ExaLhcL6w9wdGkY5un8mAvbEk4Yo/sOHVMC
        sveEMCC3e3lJyiG+YsD/yAhnvNLzhPcJhzXNGaXzS6Brb/HtcDrOuyJ+nLjVM2YfB+X5K0NXnbZYU
        hTk2ukpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pB0A0-00A7Q0-PK; Thu, 29 Dec 2022 21:09:56 +0000
Date:   Thu, 29 Dec 2022 21:09:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <Y64CJLnU2WGhPY3O@casper.infradead.org>
References: <Y5+R7DUZFaFNEeza@casper.infradead.org>
 <20221229181258.GA616291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221229181258.GA616291@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 29, 2022 at 12:12:58PM -0600, Bjorn Helgaas wrote:
> On Sun, Dec 18, 2022 at 10:19:24PM +0000, Matthew Wilcox wrote:
> > On Sun, Dec 18, 2022 at 03:21:39PM +0300, Alexey V. Vissarionov wrote:
> > > On 2022-12-18 19:57:02 +0900, Krzysztof Wilczyński wrote:
> > ...
> 
> > > Although unlikely, the 'id' value may be as big as 4294967295
> > > (uint32_max) and "virtfn4294967295\0" would require 17 bytes
> > > instead of 16 to make sure that buffer has enough space to
> > > properly NULL-terminate the ID string.
> > 
> > Wait, what?  How can we get to a number that large for the virtual
> > function ID?  devfn is 8 bits, bus is a further 8 bits.  Sure, domain
> > is an extra 16 bits on top of that but I'm pretty sure that virtual
> > functions can't span multiple domains.  Unless that's changed recently?
> > 
> > Even if they can, we'd need to span 2^14 domains to get up to a billion
> > IDs.  That's a hell of a system and I think overflowing here is the
> > least of our problems.
> > 
> > So while this is typed as u32, I don't think it can get anywhere close.
> 
> Is there an argument *against* this patch (as opposed to "this is
> probably unnecessary and it requires a lot of analysis to prove that
> we don't need it")?

It consumes additional stack space?  It's an example of changing code
to shut up a tool that is of dubious value?
