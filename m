Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614462C5FB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKPRKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiKPRKW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:10:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36251C12B;
        Wed, 16 Nov 2022 09:10:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=riVKy3FDYSWFZXezY9fdBLCxdKgItHsmQy7l+uUGAWE=;
        b=lgI5LXzVSOQg0YtaEQV7S5feQFXgrbI2VX9q3gya/BA3P/P7T4Yb6qTGNn/Q2Whhla+j3A
        dTKHyZm6BWVMVm/kClkGMZe0+EnCSpbScLrjOctVuK/uAo1SiO6pLjsMFQaPjAsRZ11CYU
        zY8Y7lX1K4sdVzZ7Jv5+UR4l9vFjqhnd6zQzgePYXjWVr2escDWgl85m1S3R+f9FZN+InK
        Poi0NaG9nNgpx/Zz4ng7tHOT/wNfVgMZNVgDyfCUO02tr6FV7D5VlVX/9iwAUxi9q1Dm+o
        Ye6W+iEaF1tz8T/H/5oP/jycdNqlmxLKjuWkbDvmgyYp5Ck2pxVzWA7lxzlgKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=riVKy3FDYSWFZXezY9fdBLCxdKgItHsmQy7l+uUGAWE=;
        b=R8/73oLDty+DVbGH+E1r4hJfOKQQpHEGsRnr533DbvEUFQz6IfkgvdJ8iIqCj6vuaiXCrE
        g5cMgNVvIHM0pHDg==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 32/39] PCI/MSI: Reorder functions in msi.c
In-Reply-To: <20221116162843.GA1116077@bhelgaas>
References: <20221116162843.GA1116077@bhelgaas>
Date:   Wed, 16 Nov 2022 18:10:18 +0100
Message-ID: <87bkp6q0zp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 10:28, Bjorn Helgaas wrote:

> On Fri, Nov 11, 2022 at 02:55:06PM +0100, Thomas Gleixner wrote:
>> From: Ahmed S. Darwish <darwi@linutronix.de>
>> 
>> There is no way to navigate msi.c without banging the head against the wall
>> every now and then because MSI and MSI-X specific functions are
>> intermingled and the code flow is completely non-obvious.
>> 
>> Reorder everthing so common helpers, MSI and MSI-X specific functions are
>> grouped together.
>
> s/everthing/everything/
>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I assume this is pure code movement, so I didn't even look at the
> text below.

It is.
