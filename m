Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4118239AF31
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 02:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFDAtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 20:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhFDAts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jun 2021 20:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622767683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BitxT5tZd4f8j5gNs+PbsKvYviNSEzsQJo5hojB/JcQ=;
        b=DbxQCmYteabvE70eGu2n2c01PPVmhrgU61GCzHBR0XUL+0OZ761keRbZJ2z/cPvnFs+f9Q
        LHM8QlqgwjLHtaCYu4DOS0ST5A8WKv+JOuqBbeT19PsxlfiZ7+5WcLMpdWsR6O6eVJMxIM
        0U2VYJiXqHTMbwSOY71cXV119jeTj0c=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-DtvdzLX3MFSGw3DuLp67ow-1; Thu, 03 Jun 2021 20:48:01 -0400
X-MC-Unique: DtvdzLX3MFSGw3DuLp67ow-1
Received: by mail-oi1-f198.google.com with SMTP id w15-20020acac60f0000b02901e5b6e8f60fso3853487oif.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jun 2021 17:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=BitxT5tZd4f8j5gNs+PbsKvYviNSEzsQJo5hojB/JcQ=;
        b=MqEQ5oim/+oJzNOqhqfjrlQm5/Vko74XNGGRCRl4F9yT9vdfosMdmNLaPvzsO2vFQJ
         aBuX5/J8XqJdHEQM7qgEG575pqOTRCOCkNzVlfmehKxABFgwjZmqKU939cVY27CFc4uq
         WcsZpENXu18fTkkT3kVtzsvVfqULiKb0OnPc33HQApR3I/US6rRAsWnNTZU/my3oFMIM
         UZKxxp8EDnx1K0I8eUi8JlPwZqEhkJE5fCDxOTkcQddh+HpV0hKf2RNHoVaRCZpt2iv8
         nayeglF82ZbD1luw1rWZFfKCvRRjazJLQA58wm5w8cG42eAM9fx8lQb0SY1CixMyNRtG
         9YaQ==
X-Gm-Message-State: AOAM531YUEeuePPV5j4BCVYkUZa3mnFPtCWeAOduROaHgmHBaJcAaJPM
        0RwBzaXOOA19r1W34h97fFNk3xshmtg8Nw8uM0l9WHCig699As6CEJGIWxJyBWMZMU6anrUOrdu
        0PFomWfls9Gz0Ir/ruByG
X-Received: by 2002:a4a:d6c8:: with SMTP id j8mr1539547oot.81.1622767681107;
        Thu, 03 Jun 2021 17:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+KiqMpmaF3JheH7ttAX+6wvqpytu/i603SHgm/OMdNmTiCv3OThsVASTbxPU785CU1gUO+w==
X-Received: by 2002:a4a:d6c8:: with SMTP id j8mr1539534oot.81.1622767680907;
        Thu, 03 Jun 2021 17:48:00 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id f16sm116804oop.6.2021.06.03.17.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 17:48:00 -0700 (PDT)
Date:   Thu, 3 Jun 2021 18:47:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override
 is not NULL
Message-ID: <20210603184759.45c51682.alex.williamson@redhat.com>
In-Reply-To: <20210603232334.GA2153375@bjorn-Precision-5520>
References: <20210603000112.703037-6-kw@linux.com>
        <20210603232334.GA2153375@bjorn-Precision-5520>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Jun 2021 18:23:34 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, FYI]
>=20
> On Thu, Jun 03, 2021 at 12:01:11AM +0000, Krzysztof Wilczy=C5=84ski wrote:
> > Only expose the value of the "driver_override" variable through the
> > corresponding sysfs object when a value is actually set. =20
>=20
> This changes the attribute contents from "(null)" to an empty
> (zero-length) file when no driver override has been set.
>=20
> There are a few other driver_override_show() functions.  Most don't
> check the pointer so they'll show "(null)".  One (spi.c) checks and
> shows an empty string ("", file containing a single NULL character)
> instead of an empty (zero-length) file.

Yeah, "(null)" was the expected output in this case.  It looks like
this might break driverctl.  Thanks,

Alex
=20
> > Signed-off-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5d63df7c1820..4e9f582ca10f 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -580,10 +580,11 @@ static ssize_t driver_override_show(struct device=
 *dev,
> >  				    struct device_attribute *attr, char *buf)
> >  {
> >  	struct pci_dev *pdev =3D to_pci_dev(dev);
> > -	ssize_t len;
> > +	ssize_t len =3D 0;
> > =20
> >  	device_lock(dev);
> > -	len =3D sysfs_emit(buf, "%s\n", pdev->driver_override);
> > +	if (pdev->driver_override)
> > +		len =3D sysfs_emit(buf, "%s\n", pdev->driver_override);
> >  	device_unlock(dev);
> >  	return len;
> >  }
> > --=20
> > 2.31.1
> >  =20
>=20

