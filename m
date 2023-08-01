Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CAD76B967
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHAQHu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 1 Aug 2023 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHAQHt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 12:07:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E96C3;
        Tue,  1 Aug 2023 09:07:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RFg0W553vz6J6Nl;
        Wed,  2 Aug 2023 00:04:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 17:07:41 +0100
Date:   Tue, 1 Aug 2023 17:07:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alistair Francis <alistair23@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
        <alex.williamson@redhat.com>, <christian.koenig@amd.com>,
        <kch@nvidia.com>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230801170739.000048cb@Huawei.com>
In-Reply-To: <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
References: <20230801121824.174556-1-alistair.francis@wdc.com>
        <2023080152-disobey-widen-65a4@gregkh>
        <CAKmqyKMEqrfP8BrXd9pVd4a5Aodipty-8bAkxK5xcGSewsC9JA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Aug 2023 09:48:13 -0400
Alistair Francis <alistair23@gmail.com> wrote:

> On Tue, Aug 1, 2023 at 9:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 01, 2023 at 08:18:24AM -0400, Alistair Francis wrote:  
> > > The PCIe 6 specification added support for the Data Object Exchange (DOE).
> > > When DOE is supported the Discovery Data Object Protocol must be
> > > implemented. The protocol allows a requester to obtain information about
> > > the other DOE protocols supported by the device.
> > >
> > > The kernel is already querying the DOE protocols supported and cacheing
> > > the values. This patch exposes the values via sysfs. This will allow
> > > userspace to determine which DOE protocols are supported by the PCIe
> > > device.
> > >
> > > By exposing the information to userspace tools like lspci can relay the
> > > information to users. By listing all of the supported protocols we can
> > > allow userspace to parse and support the list, which might include
> > > vendor specific protocols as well as yet to be supported protocols.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-pci | 11 ++++++
> > >  drivers/pci/doe.c                       | 52 +++++++++++++++++++++++++
> > >  drivers/pci/pci-sysfs.c                 |  8 ++++
> > >  include/linux/pci-doe.h                 |  2 +
> > >  4 files changed, 73 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > > index ecf47559f495..ae969bbfa631 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > @@ -500,3 +500,14 @@ Description:
> > >               console drivers from the device.  Raw users of pci-sysfs
> > >               resourceN attributes must be terminated prior to resizing.
> > >               Success of the resizing operation is not guaranteed.
> > > +
> > > +What:                /sys/bus/pci/devices/.../doe_proto
> > > +Date:                July 2023
> > > +Contact:     Linux PCI developers <linux-pci@vger.kernel.org>
> > > +Description:
> > > +             This file contains a list of the supported Data Object Exchange (DOE)
> > > +             protocols. The protocols are seperated by newlines.
> > > +             The value comes from the device and specifies the vendor and
> > > +             protocol supported. The lower byte is the protocol and the next
> > > +             two bytes are the vendor ID.
> > > +             The file is read only.  
> >
> > Sorry, but sysfs files are "one value per file", you can't have a "list
> > of protocols with new lines" in a one value-per-file rule.
> >
> >  
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index 1b97a5ab71a9..70900b79b239 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -563,6 +563,58 @@ static bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > >       return false;
> > >  }
> > >
> > > +#ifdef CONFIG_SYSFS
> > > +/**
> > > + * pci_doe_sysfs_proto_supports() - Write the supported DOE protocols
> > > + *                        to a sysfs buffer
> > > + * @doe_mb: DOE mailbox capability to query
> > > + * @buf: buffer to store the sysfs strings
> > > + * @offset: offset in buffer to store the sysfs strings
> > > + *
> > > + * RETURNS: The number of bytes written, 0 means an error occured
> > > + */
> > > +static unsigned long pci_doe_sysfs_proto_supports(struct pci_doe_mb *doe_mb,
> > > +                                               char *buf, ssize_t offset)
> > > +{
> > > +     unsigned long index;
> > > +     ssize_t ret = offset;
> > > +     ssize_t r;
> > > +     void *entry;
> > > +
> > > +     xa_for_each(&doe_mb->prots, index, entry) {
> > > +             r = sysfs_emit_at(buf, ret, "0x%08lX\n", xa_to_value(entry));
> > > +  
> >
> > No need for a blank line.
> >  
> > > +             if (r == 0)
> > > +                     return ret;  
> >
> >
> >  
> > > +
> > > +             ret += r;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +ssize_t doe_proto_show(struct device *dev, struct device_attribute *attr,
> > > +                    char *buf)
> > > +{
> > > +     struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +     unsigned long index;
> > > +     ssize_t ret = 0;
> > > +     ssize_t r;
> > > +     struct pci_doe_mb *doe_mb;
> > > +
> > > +     xa_for_each(&pci_dev->doe_mbs, index, doe_mb) {
> > > +             r = pci_doe_sysfs_proto_supports(doe_mb, buf, ret);
> > > +
> > > +             if (r == 0)
> > > +                     return ret;
> > > +
> > > +             ret += r;
> > > +     }  
> >
> > So this is going to be a lot of data, what is ensuring that you didn't
> > truncate it?  Which again, is the reason why this is not a good idea for
> > sysfs, sorry.  
> 
> Hmm... That's a pain.
> 
> I was hoping to avoid the kernel needing to know the protocols. This
> list can include vendor specific protocols, as well as future
> protocols that the running kernel doesn't yet support, so I wanted to
> directly pass it to userspace without having to parse it in the
> kernel.
> 
> Does anyone have any thoughts on a better way to expose the information?

File per protocol or better yet a directory per protocol vid and prot as files?
Files are cheap(ish) :) + expectation is probably a few protocols at
most per DOE and a few DOEs per device.

Bit similar to listing out end points for USB devices.

> 
> >
> > What userspace tool wants this information?  
> 
> pciutils (lspci) is the first user [1], but I suspect more userspace
> tools will want to query the DOE protocols as SPDM catches on more.
> Eventually I would like to expose the DOE mailboxes to userspace (but
> that's a separate issue).

You may find it tricky to get anyone to move on that as I think we
had a fairly strong consensus behind a per protocol interface only.
One of the early DOE patch sets had a generic interface but we ripped
it out based on discussions at the time.

One avenue discussed (after SPDM lands in kernel) was to provide some
hooks for some parts of the exchange to be pushed to userspace, but
it was never totally clear to me which bits make sense.  If this
happens it will probably be the AMD SEV-SNP or similar usecase that
drives it with a tightly defined interface for this purpose (not
a generic DOE one).

> 
> 1: https://github.com/pciutils/pciutils/pull/152
> 
> >
> > thanks,
> >
> > greg k-h  

