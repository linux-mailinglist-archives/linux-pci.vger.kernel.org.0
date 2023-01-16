Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73466CFC2
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjAPTtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 14:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAPTtG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 14:49:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDB22A0F;
        Mon, 16 Jan 2023 11:49:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673898543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsQIYS8Reb5+JjRsIyy9SKu5zYksjmBvIj9vz87cqIA=;
        b=heEkt7NaYvIze8aJGQVSQyHNSN98z+Wfxq09MbTTdqrC+XKiOY0rDosjUd0z1XsSIluw/P
        Cr2Q5VCIR8uXtuiK6mYkB9j8V15SmnDnNd8MoO3oU3y7irPN42IRU27Jh4H/8wglTGEH25
        9Om5jylGiPoSEa68SE/xeQLD4UTAezrquPJe+NbYT4vogs55O4A6M/3mLcrXBt9/Z0vmdW
        /zROGTl2f7ioJ0ivQfFu0FFh7UFomXQK/1HkCSm7uVxq64vpQlA1SwezuakhBjKTLuBmk7
        6vupSlP1XINVTJeEQoKgecPdHcR9dTYuuWNP5NIzbbxbWCCMdpieSqhH0Bk9kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673898543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsQIYS8Reb5+JjRsIyy9SKu5zYksjmBvIj9vz87cqIA=;
        b=bfhTZB4zqL0K6JB8VZXUJnVxNs2r97QdIbh0E82HuZsZVNPSxYCPU420T4qGOhJ+vpVXFQ
        NsX/lhRHJD/orPDQ==
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
In-Reply-To: <57f3f757aaceccf866172faaf48ab62916f24d8b.camel@infradead.org>
References: <20221124225331.464480443@linutronix.de>
 <20221124230314.337844751@linutronix.de>
 <1901d84f8f999ac6b2f067360f098828cb8c17cf.camel@infradead.org>
 <875yd6o2t7.ffs@tglx> <871qnunycr.ffs@tglx>
 <e12002af82e9554e42e876d7b9e813b90e673330.camel@infradead.org>
 <87h6wqmgio.ffs@tglx>
 <57f3f757aaceccf866172faaf48ab62916f24d8b.camel@infradead.org>
Date:   Mon, 16 Jan 2023 20:49:02 +0100
Message-ID: <87edrumf9t.ffs@tglx>
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

On Mon, Jan 16 2023 at 19:28, David Woodhouse wrote:
> On Mon, 2023-01-16 at 20:22 +0100, Thomas Gleixner wrote:
>> > Tested-by: David Woodhouse <dwmw@amazon.co.uk>
>> >=20
>> > Albeit only under qemu with
>> > https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xen=
fv
>> > and not under real Xen.
>>=20
>> Five levels of emulation. What could possibly go wrong?
>
> It's the opposite =E2=80=94 this is what happened when I threw my toys ou=
t of
> the pram and said, "You're NOT doing that with nested virtualization!".
>
> One level of emulation. We host guests that think they're running on
> Xen, directly in QEMU/KVM by handling the hypercalls and event
> channels, grant tables, etc.
>
> We virtualised Xen itself :)

Groan. Can we please agree on *one* hypervisor instead of growing
emulators for all other hypervisors in each of them :)

> Now you have no more excuses for breaking Xen guest mode!

No cookies, you spoilsport! :)

        tglx
