Return-Path: <linux-pci+bounces-32311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591DEB07C3A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571CA3B0CF8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04F2F6F80;
	Wed, 16 Jul 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmsABY9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06092F549E;
	Wed, 16 Jul 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687805; cv=none; b=DAAqkECNOQ2rgRIfdor2QSPpvYF6baaJ1P31DaA/X1jnbZGsEixWcUaJOTYFyQC4Zye9pgjM4yL1KEELJe64lq8OrY8Uyc3NN3MJS+UmKU52VHISCCadHigjO2VW7TwwBtVC1h1VeDHPZRBgaSTOm/07siPMFFre2v/Pac8b7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687805; c=relaxed/simple;
	bh=WNnVrZTyjfQ0iCokOmrNWmhV5/HpncUmCFT0sgwfs4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTRCldZHB7yjWZG/hu1QWn+XyD6VTzzI04i6eiABiPqgi8XLX4msa3KJz0mMH8o1lScobUXaDpxKJa0RQoMkXXYuSn++s9qSmBB4N7Xeekp5UTKI4QaFjTfWg4onjWtbbEgTpH/XQSuZ3upl90gPOQVJ8lL9ClaaoZjpSGwhu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmsABY9h; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab814c4f2dso2726921cf.1;
        Wed, 16 Jul 2025 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687802; x=1753292602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA5/tCiuP2JLJTNlACta44IlmdwORZsKRaxa7XE2CPs=;
        b=RmsABY9hVdLaHmIu4ZlrY1qBr1g63u27X+EbUzE1Svlu1tvzWWTdchK9j0z/Di/ht4
         0CDkssdUshAfw28gcXP/LAUgpiZcSVK26AIf2c1ogYGr897mj4b7WpqxdanbvqivDNCg
         ZXHnWcmSPCLwA7aAo4oku3pFfZi6mhl8L/Pum+rcaG2Qi9oYxxpySQJNVWoo4qJ2Vwfp
         zOBAf2pOWpmwq53Xy2n1Qr5Lq+Z4LGsSJs2j991HjcIYBshkl/UZ7BSATxN441NOKPfH
         lYfYoYqQLG06J6udI7luTsVRt8xWwAu2PHlvSORBXiYGphrmNl7vQaryk4PryMAxA2no
         07OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687802; x=1753292602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA5/tCiuP2JLJTNlACta44IlmdwORZsKRaxa7XE2CPs=;
        b=pQ0VnnQ/+PHKsNK+WflZRIE2boEFw7vkJihlsRqmbDV42U7CiQXZeFDJ0j0FY4yup7
         qaiqfw79jbmF+s+8cEUzSONfyFscQxh/xOBkuRD93nUZyjV5X+mcx5vZ/seMpNCqAEYN
         on/gO8e+94Y67i8W9IrlRf9vR1vrJWOLZfsGGcT6wsQsX44cesuzPg3XCQrAc7XEVPIC
         kMl8ueY3VVJFAoyCzWoj9ix3T3BkYdRcaAhXmMkXNWYND3ST9d0fU6906Ucrh2KvdPlU
         0Yw7hsYlK7lLHeIwikX0Fs586BESwMzn3wfZlzydvIzPGXU2BTytX+BjhxX95qdmJlM6
         49tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVspXWZglK5Y4wXl3DeU94ZuNAkVsZX9ZQdYthKqvvCxrb2d8hWrexsBkXzQ0Rw3wmxyWhDzQrOFYl@vger.kernel.org, AJvYcCXjTAHMHTrZkmaMd7RCrYIj6jyPhFcVSfO736BnPzg+MtycrqRyoprAlyLOiQZmzgGJxkYK+02kfH0Chuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfpnYe6XLqNTnypanDQRiqBko/HTkxHrI1KdlRvZ2Si9E2Xnb
	kXfvZyxG/mW2QcNxdmhNDnUQsttsf8ess6KHA7HEUZ7n9oJDprWMgEIDIfuB1cADGGW+g2ZNlvs
	7BHuQJXxlXwY2b6rptEaqMB595vrgBSk=
X-Gm-Gg: ASbGncvUzhgeC8xgc9j+d9UbYrjPaLl6x09zo/xwv0JtnN3EYlpWMZRPFYMVPdbn4tc
	zScZMNedycySPINinQ0+jAGv6PBmFEuP2Dav0LDYgVNfjEXy/yW36EyFFqGsecWRDN7tV3odCGb
	lB+Lkc1km+MbYlJxvFxgRtXmt/JtEjQbtECJmODUpkmyFWYKKtFeOirWYXkXpAQdXQ6iUcH+r7F
	uq0ZGzSVYeD4g+iN/T2nA==
X-Google-Smtp-Source: AGHT+IFfxo82ulTnxyDyRWmwoZFor5eUkdLV4oDsU70TChHIlz7F1ILwbmGB0C+lsP2g0aLBdvwTTjLbIlZa2ca9ZV0=
X-Received: by 2002:a05:622a:41:b0:4ab:8d13:7151 with SMTP id
 d75a77b69052e-4ab93c43046mr59074561cf.7.1752687802445; Wed, 16 Jul 2025
 10:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716163213.469226-1-thepacketgeek@gmail.com>
 <20250716163213.469226-2-thepacketgeek@gmail.com> <7cae9919-4ccd-41ed-a899-0e97ee2c0250@kernel.org>
In-Reply-To: <7cae9919-4ccd-41ed-a899-0e97ee2c0250@kernel.org>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Wed, 16 Jul 2025 10:43:09 -0700
X-Gm-Features: Ac12FXwaWGrawL8h0ydexMi8_5v2a909eZYO8ejVbzSWLKEuJ-ZNdpsAGIt5t4c
Message-ID: <CADvopvZD+daGD2S-eGPe3Dh+Ot2Oq-tEsBBK83vF7QDgaaUtFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] PCI/sysfs: Expose PCIe device serial number
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:02=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 7/16/25 11:32 AM, Matthew Wood wrote:
> > Add a single sysfs read-only interface for reading PCIe device serial
> > numbers from userspace in a programmatic way. This device attribute
> > uses the same hexadecimal 1-byte dashed formatting as lspci serial numb=
er
> > capability output. If a device doesn't support the serial number
> > capability, the device_serial_number sysfs attribute will not be visibl=
e.
> >
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > ---
> >   Documentation/ABI/testing/sysfs-bus-pci |  7 +++++++
> >   drivers/pci/pci-sysfs.c                 | 27 ++++++++++++++++++++++--=
-
> >   2 files changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/AB=
I/testing/sysfs-bus-pci
> > index 69f952fffec7..f7e84b3a4204 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -612,3 +612,10 @@ Description:
> >
> >                 # ls doe_features
> >                 0001:01        0001:02        doe_discovery
> > +
> > +What:                /sys/bus/pci/devices/.../device_serial_number
> > +Date:                July 2025
> > +Contact:     Matthew Wood <thepacketgeek@gmail.com>
> > +Description:
> > +             This is visible only for PCIe devices that support the se=
rial
> > +             number extended capability. The file is read only.
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 268c69daa4d5..b7b52dea6e31 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct devi=
ce *dev,
> >   }
> >   static DEVICE_ATTR_RO(current_link_width);
> >
> > +static ssize_t device_serial_number_show(struct device *dev,
> > +                                    struct device_attribute *attr, cha=
r *buf)
> > +{
> > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +     u64 dsn;
> > +
> > +     dsn =3D pci_get_dsn(pci_dev);
> > +     if (!dsn)
> > +             return -EIO;
> > +
> > +     return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx=
-%02llx-%02llx\n",
> > +             dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >=
> 32) & 0xff,
> > +             (dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff=
, dsn & 0xff);
> > +}
> > +static DEVICE_ATTR_RO(device_serial_number);
>
> The serial number /could/ be considered sensitive information.  I think
> it's better to use DEVICE_ATTR_ADMIN_RO.

That makes sense, thanks for the suggestion.

>
> Also, as this is a "device" attribute is it really necessary to encode
> the extra word and "number"?

Another good point. I will remove the device_ prefix however I think
"serial_number" is helpful to keep as "serial" alone is too easy to
conflate with any of the other usages of the serial word.

>
> > +
> >   static ssize_t secondary_bus_number_show(struct device *dev,
> >                                        struct device_attribute *attr,
> >                                        char *buf)
> > @@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] =3D {
> >       &dev_attr_current_link_width.attr,
> >       &dev_attr_max_link_width.attr,
> >       &dev_attr_max_link_speed.attr,
> > +     &dev_attr_device_serial_number.attr,
> >       NULL,
> >   };
> >
> > @@ -1749,10 +1766,14 @@ static umode_t pcie_dev_attrs_are_visible(struc=
t kobject *kobj,
> >       struct device *dev =3D kobj_to_dev(kobj);
> >       struct pci_dev *pdev =3D to_pci_dev(dev);
> >
> > -     if (pci_is_pcie(pdev))
> > -             return a->mode;
> > +     if (!pci_is_pcie(pdev))
> > +             return 0;
> > +
> > +     if (a =3D=3D &dev_attr_device_serial_number.attr && !pci_get_dsn(=
pdev))
> > +             return 0;
> > +
> > +     return a->mode;
> >
> > -     return 0;
> >   }
> >
> >   static const struct attribute_group pci_dev_group =3D {
>

