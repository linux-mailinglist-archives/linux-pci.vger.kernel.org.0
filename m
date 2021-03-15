Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FC33C1C8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhCOQa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232124AbhCOQ35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 12:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615825796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzbk2N/+IjCMMwtklLd0wUDwTbWk4sEAedTIBn0fl1A=;
        b=CNfwF9RI2HCUZ8uIZIEQ1H1c9ni19PGjIJVs3LwfRBJfl+rzleSUPWRI5L01ftqKK7p2vO
        G/HHi4qzCMwA2Ao5RBo0kUw/+zzTQrtl0a3Ch+7Y8dSBPUk+hHmtCqisBCwYc6Oo4T0jGl
        M+zILMhxqKBz8TPBrGJ2LXTkkBJg/Do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-0Q5yoXykNbm-jMx5na5oDw-1; Mon, 15 Mar 2021 12:29:52 -0400
X-MC-Unique: 0Q5yoXykNbm-jMx5na5oDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA9780006E;
        Mon, 15 Mar 2021 16:29:51 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B305D9C0;
        Mon, 15 Mar 2021 16:29:50 +0000 (UTC)
Date:   Mon, 15 Mar 2021 10:29:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, raphael.norwitz@nutanix.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210315102950.230de1d6@x1.home.shazbot.org>
In-Reply-To: <20210315153341.miip637z35mwv7fv@archlinux>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
        <20210312173452.3855-5-ameynarkhede03@gmail.com>
        <20210314235545.girtrazsdxtrqo2q@pali>
        <20210315134323.llz2o7yhezwgealp@archlinux>
        <20210315135226.avwmnhkfsgof6ihw@pali>
        <20210315083409.08b1359b@x1.home.shazbot.org>
        <YE94InPHLWmOaH/b@unreal>
        <20210315153341.miip637z35mwv7fv@archlinux>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Mar 2021 21:03:41 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote: =20
> > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > =20
> > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote: =20
> > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > warm reset respectively. =20
> > > >
> > > > No. PCI secondary bus reset =3D PCIe Hot Reset. Slot reset is just =
another
> > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > bridges and for PowerPC PowerNV platform and it just call PCI secon=
dary
> > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > kernel and therefore drivers do not export this type of reset via a=
ny
> > > > kernel function (yet). =20
> > >
> > > Warm reset is beyond the scope of this series, but could be implement=
ed
> > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > defined here.  Note that with this series the resets available through
> > > pci_reset_function() and the per device reset attribute is sysfs rema=
in
> > > exactly the same as they are currently.  The bus and slot reset
> > > methods used here are limited to devices where only a single function=
 is
> > > affected by the reset, therefore it is not like the patch you proposed
> > > which performed a reset irrespective of the downstream devices.  This
> > > series only enables selection of the existing methods.  Thanks, =20
> >
> > Alex,
> >
> > I asked the patch author here [1], but didn't get any response, maybe
> > you can answer me. What is the use case scenario for this functionality?
> >
> > Thanks
> >
> > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal
> > =20
> Sorry for not responding immediately. There were some buggy wifi cards
> which needed FLR explicitly not sure if that behavior is fixed in
> drivers. Also there is use a case at Nutanix but the engineer who
> is involved is on PTO that is why I did not respond immediately as
> I don't know the details yet.

And more generally, devices continue to have reset issues and we
impose a fixed priority in our ordering.  We can and probably should
continue to quirk devices when we find broken resets so that we have
the best default behavior, but it's currently not easy for an end user
to experiment, ie. this reset works, that one doesn't.  We might also
have platform issues where a given reset works better on a certain
platform.  Exposing a way to test these things might lead to better
quirks.  In the case I think Pali was looking for, they wanted a
mechanism to force a bus reset, if this was in reference to a single
function device, this could be accomplished by setting a priority for
that mechanism, which would translate to not only the sysfs reset
attribute, but also the reset mechanism used by vfio-pci.  Thanks,

Alex

