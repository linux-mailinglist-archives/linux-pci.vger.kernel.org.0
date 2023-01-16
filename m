Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE37266CF79
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 20:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjAPTWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 14:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjAPTWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 14:22:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6E222ED;
        Mon, 16 Jan 2023 11:22:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673896928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xRPy2lFgYzK4rQRIIVFPLcqwpR0bB+GwT9J43FZdpM=;
        b=QEUWF6j5u+1NhckWuR+mgr9v4hj2n0zEuXyboXvSn34zuMH1NDWqp4x6Xg37XzsjC0c5Rh
        WNoqv2l0pCMKKpQoBJu2TKmmvAIXzgWRljRu/CIoDjyrZgmK2O/SS8C2jkWdZmD8z+MS8y
        ThiN1BHGg9HCjqTI2lt1qvuZtYXLjoey+DmgRW1YNIRYN4NHKQwUlOjl5UQB7epv1l2got
        a1K2kj/oN+trWA842lnDJBZpXS0PtXW6DlqtMM84oj7pCcQ2IUTzqVGq694zdIopstvcDf
        o2c3pySEeDJ5TNbmmyS1E/TLtub1svpU7wex62TMvnlDDi1VL5ktKdYL1zSOIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673896928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xRPy2lFgYzK4rQRIIVFPLcqwpR0bB+GwT9J43FZdpM=;
        b=E3CY56ng5AjvLJnjTeTH/SIcAG7tQAejOTkhid6gy/IkjDhcsvcKeMNKlUgyuzP3Bg4btY
        oLWtXOUok+0V71BA==
To:     David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xen.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 16/22] genirq/msi: Provide new domain id based
 interfaces for freeing interrupts
In-Reply-To: <e12002af82e9554e42e876d7b9e813b90e673330.camel@infradead.org>
References: <20221124225331.464480443@linutronix.de>
 <20221124230314.337844751@linutronix.de>
 <1901d84f8f999ac6b2f067360f098828cb8c17cf.camel@infradead.org>
 <875yd6o2t7.ffs@tglx> <871qnunycr.ffs@tglx>
 <e12002af82e9554e42e876d7b9e813b90e673330.camel@infradead.org>
Date:   Mon, 16 Jan 2023 20:22:07 +0100
Message-ID: <87h6wqmgio.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

David!

On Mon, Jan 16 2023 at 18:58, David Woodhouse wrote:

> On Mon, 2023-01-16 at 19:11 +0100, Thomas Gleixner wrote:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.flags=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
> =C2=A0
> That doesn't apply on top of
> https://lore.kernel.org/all/4bffa69a949bfdc92c4a18e5a1c3cbb3b94a0d32.came=
l@infradead.org/
> and doesn't include the | MSI_FLAG_PCI_MSIX either.

Indeed. I saw that patch after my reply. :)

> With that remedied,
>
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Albeit only under qemu with
> https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xenfv
> and not under real Xen.

Five levels of emulation. What could possibly go wrong?
