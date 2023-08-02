Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221276DAFE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 00:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjHBWxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 18:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHBWw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 18:52:57 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA329127;
        Wed,  2 Aug 2023 15:52:50 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 438CA30010DFE;
        Thu,  3 Aug 2023 00:52:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 357C2D6B89; Thu,  3 Aug 2023 00:52:48 +0200 (CEST)
Date:   Thu, 3 Aug 2023 00:52:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230802225248.GA19409@wunner.de>
References: <20230801121824.174556-1-alistair.francis@wdc.com>
 <2023080152-disobey-widen-65a4@gregkh>
 <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
 <20230801170739.000048cb@Huawei.com>
 <CAKmqyKND01=xaiB-VFVsi3+KRbxu4dBKfh_RhCN-jric5VzNpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKND01=xaiB-VFVsi3+KRbxu4dBKfh_RhCN-jric5VzNpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 02:24:24PM -0400, Alistair Francis wrote:
> On Tue, Aug 1, 2023 at 12:07???PM Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > On Tue, 1 Aug 2023 09:48:13 -0400 Alistair Francis <alistair23@gmail.com> wrote:
> > > On Tue, Aug 1, 2023 at 9:28???AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:
> > > > > +What:                /sys/bus/pci/devices/.../doe_proto

The PCISIG published the DOE r1.1 ECN in September 2022.

It replaced all occurrences of the term "protocol" with either "feature"
or "data object type".  Please adhere to the terms used by the spec so
that it is easy for an uninitiated reader to make the connection between
the spec and the implementation.

DOE r1.1 was merged into the PCIe Base Spec r6.1.  It wasn't merged into
r6.0.1 yet.


> > > > > +             This file contains a list of the supported Data Object Exchange (DOE)
> > > > > +             protocols. The protocols are seperated by newlines.
                                                     ^^^^^^^^^
s/seperated/separated/


> > > > > +             The value comes from the device and specifies the vendor and
> > > > > +             protocol supported. The lower byte is the protocol and the next
> > > > > +             two bytes are the vendor ID.
> > > > > +             The file is read only.

I kind of like the approach of exposing a list which can be grep'ed,
even though it may go against the rule of having just one datum per
attribute.  I'd prefer a representation that's human-readable though,
e.g. "0001:01" for CMA-SPDM.


> > > > So this is going to be a lot of data, what is ensuring that you didn't
> > > > truncate it?  Which again, is the reason why this is not a good idea for
> > > > sysfs, sorry.

For all practical purposes, the maximum size which can be returned
by a sysfs attribute (PAGE_SIZE, i.e. 4 kByte on x86) ought to be
sufficient.  I'd say a mailbox typically doesn't support more than,
say, 10 protocols.


> > > I was hoping to avoid the kernel needing to know the protocols. This
> > > list can include vendor specific protocols, as well as future
> > > protocols that the running kernel doesn't yet support, so I wanted to
> > > directly pass it to userspace without having to parse it in the
> > > kernel.

Right, just expose raw numbers and let lspci print them in beautified
(parsed) form.


> A directory per vid and files for each protocol sounds good to me.
> I'll update the patch to do that. If anyone doesn't like that idea let
> me know

Since you intend to expose an interface for interacting with mailboxes,
on top of just exposing a list of supported data types (protocols),
I think you should first come up with a plan how to do that instead
of kicking the can down the road.  The sysfs ABI is sort of set in
stone, you can't easily change it if you realize after the fact
that it has deficiencies for your use case.

sysfs is not suitable for interaction with DOE mailboxes because the
filesystem imposes a size restriction of PAGE_SIZE per read.  DOE
allows up to 1 MByte per request or response, so way bigger than the
puny 4 kByte PAGE_SIZE on x86.  Splitting response reception into
multiple reads of the same attribute would be an awful kludge.
So I think you need to resort to devfs or procfs for mailbox interaction,
instead of sysfs.

Question is, if you use devfs/procfs for mailbox interaction, maybe it
makes sense to expose the list of supported data types there as well,
instead of in sysfs?

If you do expose a list of supported protocols, you should definitely
have one sysfs attribute per mailbox, e.g. "doe_123" or "doe@123" if
the mailbox is located at offset 123 in config space.


> I think we will need to at least expose a few parts of SPDM to
> userspace. It could either be the kernel passing data back (like the
> measurements for example) or userspace orchestrating the
> communication. That's a future problem at the moment though

I envision that we'll provide a higher-level ABI for things like
measurement retrieval, either through IMA or maybe sysfs, but not
low-level access to the SPDM session.

In fact, I think if you do implement mailbox interaction, you may
want to blacklist certain data types that are handled in-kernel,
such as CMA-SPDM.

And you should constrain the whole thing to
!security_locked_down(LOCKDOWN_PCI_ACCESS).

FWIW, an experimental in-kernel implementation of SPDM measurement
retrieval already exists (it goes on top of my doe branch that I
linked to previously):

https://github.com/debox1/spdm/commits/measurement

Thanks,

Lukas
