Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4691033FCB0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 02:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCRBbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCRBaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 21:30:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D842C06175F
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 18:30:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so4603005eds.7
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xw7oYSjjp9oS+nwtaFUBwvJyGYHFUWxpmI1ewSADgIw=;
        b=BZrGew9/oWoJA2obgfBVdQagf+0A5ehE894LTII2q8NytJOasNPw01gCoODT8Auvpm
         C5y9r0O3DSTT3dwDuObSXaYWkJJN+9RROyZ5vO0BeOhokrvimFnJT1AXw9aaRt1HE9RE
         WxnEDrGqSu4icUPLmIB7l/7+O2QtwHjJm4XzElaAomC8Nd8SuzVwDiTM3zM8uSMZcksE
         vX5v0ark5Cublx+wxqlgP4a+pSWjIwiKoxfNccWMPaXYGiW3BTQzP5gIBpFgZfFAZx+2
         lZqI6494e15c6Fu90bLlUuGGrURf3MK5J0wnelSWH4lPHK6M+rD+iuWIYhQDODr+aMD9
         4hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xw7oYSjjp9oS+nwtaFUBwvJyGYHFUWxpmI1ewSADgIw=;
        b=V9LsZbmuRgVxVU2k2BrCC06lbNAhUd1DHQRKgNKlzSKpbuYe4OFnlRXaewTU1PzKey
         SFlaoclHR1PHYdRtQBvZO1HK/aJ74HZ7ivQtmC1EgdnKzuGMiRwDGS345KEgCVUKtUAb
         BpeTXDJaNv1HCOMTAwAaBAmBIKwzd/o98JIqltFnD/XJLEzSy+WaKXTNPzMmbD7cUQH6
         j7Z55PG105hL1kYGX/5TSyt9BnPkXQLuzFtcTk0efqDDsNpZBIXZsziPun833qrHWcIO
         /BjY9Cu8+p/DOLcSMVdkQDA00Ttk4u3H1F6RQ/Ikx5NbZJpl1r3xKKGaXa80bh/0W5c+
         i9SQ==
X-Gm-Message-State: AOAM532LnNBL10aGSVMePcakF2w8/1TyQUVbvIbrvDA2kmPlYxBBuLNv
        nbNCSCDe3qSBUprWAHC8+5B5KzZJTq3Ssc3F3o/Kag==
X-Google-Smtp-Source: ABdhPJx1mCZ8Hl5YSv0C5/KWJ35gquENslnXEiug6CmPW+mNiqmJODmAUbzLLiwIDYTp+495NS7WR/bwk+B28+IHcjU=
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr640087edw.354.1616031033201;
 Wed, 17 Mar 2021 18:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com>
 <20210310180306.1588376-2-Jonathan.Cameron@huawei.com> <CAPcyv4gG-==Vj9w3d7=gRRSPaoD5eZHZZ2hAA0h3c07eMT_x1A@mail.gmail.com>
 <20210316162952.00001ab7@Huawei.com> <CAPcyv4h6hHCuO=0vHbPz2m4qw6-0=wW9swBrWimBsz6_GJu4Aw@mail.gmail.com>
 <6F0B8DDD-E661-40C8-839B-1B77998EFF23@avery-design.com>
In-Reply-To: <6F0B8DDD-E661-40C8-839B-1B77998EFF23@avery-design.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Mar 2021 18:30:26 -0700
Message-ID: <CAPcyv4hJG08RaksW3jH_Q5ASqpzX5MtfNFcLqMxAH5jwTidk=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PCI/doe: Initial support PCI Data Object Exchange
To:     Chris Browy <cbrowy@avery-design.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Btw your mailer does something odd with the "In-Reply-To:" field, I
need to fix it up manually to include your address.

On Tue, Mar 16, 2021 at 4:28 PM Chris Browy <cbrowy@avery-design.com> wrote=
:
>
> Please address and clarify 2 queries below...
>
>
> > On Mar 16, 2021, at 2:14 PM, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> >
> > On Tue, Mar 16, 2021 at 9:31 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >>
> >> On Mon, 15 Mar 2021 12:45:49 -0700
> >> Dan Williams <dan.j.williams@intel.com> wrote:
> >>
> >>> Hey Jonathan, happy to see this, some comments below...
> >>
> >> Hi Dan,
> >>
> >> Thanks for taking a look!
> >>
> >>>
> >>> On Wed, Mar 10, 2021 at 10:08 AM Jonathan Cameron
> >>> <Jonathan.Cameron@huawei.com> wrote:
> >>>>
> >>>> Introduced in an ECN to the PCI 5.0, DOE provides a config space
> >>>> based mailbox with standard protocol discovery.  Each mailbox
> >>>> is accessed through a DOE PCIE Extended Capability.
> >>>>
> >>>> A device may have 1 or more DOE mailboxes, each of which is allowed
> >>>> to support any number of protocols (some DOE protocols
> >>>> specifications apply additional restrictions).  A given protocol
> >>>> may be supported on more than one DOE mailbox on a given function.
> >>>
> >>> Are all those protocol instances shared?
> >>> I'm trying to mental model
> >>> whether, for example, an auxiliary driver instance could be loaded pe=
r
> >>> DOE mailbox, or if there would need to be coordination of a given
> >>> protocol no matter how many DOE mailboxes on that device implemented
> >>> that protocol.
> >>
> >> Just to check I've understood corectly, you mean multiple instances of=
 same
> >> protocol across different DOE mailboxes on a given device?
> >>
> >
> > Right.
>
> Could you confirm this case for clarity?  A CXL device may have multiple =
VF/PF.
> For example, PF=3D0 could have one or more DOE instances for CDAT protoco=
l.
> The driver will scan PF=3D0 for all DOE instances and finding one or more=
 of CDAT
> protocol will combine/manage them.  I had not considered multiple CDAT ta=
bles
> for single PF.  For CXL devices with multiple PF=E2=80=99s the same proce=
ss would be
> carried out on PF=3D1-N.

This patch has nothing to do with CXL. This is a general discussion of
how a PCIE device implements a DOE mailbox or set of mailboxes. The
DOE definition is PF-only afaics from the DOE specification.

The CXL specification only says that a device can implement a CDAT per
DOE capability instance, so the CXL spec does not limit the number of
DOE instances to 1, but I can't think of a practical reason to support
more than one.

[..]
> >>> https://cfp.osfc.io/media/osfc2020/submissions/ECQ88N/resources/An_op=
en_source_SPDM_implementation_for_secure_devi_kmIgAQe.pdf
> >>
> >> Nice!  Looking at CMA / IDE emulation was on my todo list and that loo=
ks like
> >> it might make that job a lot easier.
>
> Would it be useful to integrate the openspdm=E2=80=99s SpdmResponderEmu.c=
 onto the QEMU=E2=80=99s CXL Type3 Device=E2=80=99s
> DOE backend for CMA/IDE testing?  Doesn=E2=80=99t look hard to do.

Yes, I do think it would be useful.
