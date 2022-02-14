Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7BE4B5C33
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 22:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiBNVMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 16:12:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiBNVMF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 16:12:05 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA3111941D
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 13:11:57 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso20808808oop.9
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LNIIAz3zQQaMmzK3Lz7n5biZPq3E2euYGu1gGCUEiUU=;
        b=e+9/aIcapobLzUjuzWwCgjtrECD4Nz67ZklJZLlhaJiox8qfEoUy+GU7FMZlc9tQKf
         70XobxmHxms3p+b3cX1vPLmpMzFtT4TUxGpxDFVgIsD1tIcgAidU7NyTOhAPOvtWOOOL
         trGD4b8Z6qqdEiHjjhgqr21N2vFoaCE3/fgG4Wh6mNqpZLb+OIGpnaXP37C5FH3V44Nc
         3SxQUaw7z7VJb3t8wRiidTg9AXs/QyF4FNIIvKuYzseQDibK2D4jwHdkgpSqWN1+UJ6C
         7PaeNPx+1C6E06lXbGybY0/do0xzLQHhRBwrNTxzgB3KagOb9AUR7u2K0azCw4YX3nvJ
         hDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LNIIAz3zQQaMmzK3Lz7n5biZPq3E2euYGu1gGCUEiUU=;
        b=VpNrvKgnWEnpcC2dX467RmGxYCo+l6JTCo5BTvmjqqcACzBjrs9IDu3PLHesnTVg5L
         gBYwizN6xyD2QLv6HN2BjyzBYKziPqJl0nC0GOGi0QMiPEBwRTk60t0trFQkC/4Iaqah
         euN0fF0rYCPX6wGBOFXZlvbAKk6tsbGZKJ4L52/C1tJMB+/5pBRr9RhKQdiZ40VFI/xj
         EBJJAU4aFjmjw0soIMBunfpMq4G9aycxUwT0v41EaCw5SCAvIxXvpOlqN7Rfp38aDJx9
         9Gmg4HpX+I5MjN6bpHzgMNmRMDZSSn7IKVcNguNPm7xSHIVDggE4xIwbvoXthrign5iI
         8RKg==
X-Gm-Message-State: AOAM530X4w0+LIcAk2u/JduM4nsrQJKrRcxA1+U3p1hOvWNhbixZI6xq
        BXuw6fCG9lzehQtvNvtzBFmad9r4VkaWgouht4ilDYL4cUw=
X-Google-Smtp-Source: ABdhPJxVTF5h08NSNXTHrXWdDbPywfICYCIAA4dvceyfHnC11SOo3zAin7e+e2W6f7vCUWzlvI+mSWTgxqtkOna79vk=
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr94342pjb.220.1644866060312;
 Mon, 14 Feb 2022 11:14:20 -0800 (PST)
MIME-Version: 1.0
References: <164298430609.3018233.3860765171749496117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164386092069.765089.14895687988217608642.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220214174521.00003b84@Huawei.com>
In-Reply-To: <20220214174521.00003b84@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Feb 2022 11:14:13 -0800
Message-ID: <CAPcyv4g++ishMNkSLYAq3ss_qMXv-gabubVG_q2H9ed+C7KW-A@mail.gmail.com>
Subject: Re: [PATCH v4 35/40] cxl/core/port: Add endpoint decoders
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 9:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 02 Feb 2022 20:02:06 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > Recall that a CXL Port is any object that publishes a CXL HDM Decoder
> > Capability structure. That is Host Bridge and Switches that have been
> > enabled so far. Now, add decoder support to the 'endpoint' CXL Ports
> > registered by the cxl_mem driver. They mostly share the same enumeratio=
n
> > as Bridges and Switches, but witout a target list. The target of
> > endpoint decode is device-internal DPA space, not another downstream
> > port.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > [djbw: clarify changelog, hookup enumeration in the port driver]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> ...
>
> > index f5e5b4ac8228..990b6670222e 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -346,6 +346,7 @@ struct cxl_decoder *cxl_root_decoder_alloc(struct c=
xl_port *port,
> >  struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> >                                            unsigned int nr_targets);
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> > +struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
> >  int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
> >  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cx=
ld);
> >  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port =
*endpoint);
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 4d4e23b9adff..d420da5fc39c 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -40,16 +40,17 @@ static int cxl_port_probe(struct device *dev)
> >               struct cxl_memdev *cxlmd =3D to_cxl_memdev(port->uport);
> >
> >               get_device(&cxlmd->dev);
> > -             return devm_add_action_or_reset(dev, schedule_detach, cxl=
md);
> > +             rc =3D devm_add_action_or_reset(dev, schedule_detach, cxl=
md);
> > +             if (rc)
> > +                     return rc;
> > +     } else {
> > +             rc =3D devm_cxl_port_enumerate_dports(port);
> > +             if (rc < 0)
> > +                     return rc;
> > +             if (rc =3D=3D 1)
> > +                     return devm_cxl_add_passthrough_decoder(port);
>
> This is just a convenient place to ask a question rather that really bein=
g
> connected to this patch.
>
> 8.2.5.12 in CXL r2.0
>
> "A CXL Host Bridge is identified as an ACPI device with Host Interface ID=
 (HID) of
> =E2=80=9CACPI0016=E2=80=9D and is associated with one or more CXL Root po=
rts. Any CXL 2.0 Host
> Bridge that is associated with more than one CXL Root Port must contain o=
ne instance
> of this capability structure in the CHBCR. This capability structure reso=
lves the target
> CXL Root Ports for a given memory address."
>
> Suggests to me that there may be an HDM decoder in the one port case and =
it may need
> programming.
>
> Hitting this in QEMU but I suspect it'll occur in real systems as well.

It seems reasonable to wait for a real system like that to arrive. If
someone is cheap enough to build a one-port host bridge would they
spend the silicon gates on these unnecessary registers?
