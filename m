Return-Path: <linux-pci+bounces-32414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B3CB091EE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C215E1752BF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00037202F87;
	Thu, 17 Jul 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVPc1gZQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90F2BE039;
	Thu, 17 Jul 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770012; cv=none; b=L13TljbaxYDLZonS0t6ll0ihymsiwmk07o6bqnJ9M4gGZyVt0Yig+Lzb0+mGMmDMKP//5yAMhAWHjZKr+VZUVxk1+r4SEB9+ATHw6kG1lWw7bddpniLK1n9Bop29o6FJCM2xwwLyQwZu8oSfrNmSHvPbW/pzJhwsZXAx+CDYuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770012; c=relaxed/simple;
	bh=8cGy3rOFQhggaRs7+L7QQgfN8e97UiNOshL8Qb9oGnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLjimAhwuVfTEIg2j3tmqhMBYx6kk8ak4j4FUjWlgvJfz/HbSo1KMvS2HduVwV0PpQgotNQKp6lZkyihII6pPnqC1yOO+hRUB/1cr0tviXlewt1zQS1LXYZcpcZQF1LJKXXQ88Rv0tx4PluE7SZo9auLvlJBCaA64eUwvONXUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVPc1gZQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aba19f4398so15486631cf.1;
        Thu, 17 Jul 2025 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770010; x=1753374810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRoDyvAfnO4BnLzN0aqdlFvObbEyzc9rfB0EpRqTEso=;
        b=TVPc1gZQ0dJZUS92aiAMFTBcXNEuXhnUrVFMfLeBej0ddH2nc++UcUYaOy4AKV1A/H
         zESBMiOn6KPmI3rjshz74vcRbmye5BdtTWAEPdiNTdtBQlRLxcmgIpMOUNlvCzgoaxTk
         KYTkCbfbgttdR/0NfoZdvBkLJpeWDJrzGASV+2JJe7VUAMzdF04EwVsM0b5MDaztHFQo
         7gL3BaQHE5sjHY96yZzKoeGr374MDd8M0bXmbFxR2ehW8qPn+kYOQRMAqc5EtUun0Sr1
         9oRllMVN512c8Xq6mAackKQGhhfpukZsNr+5zzm/8u8v9aOyIQ+2jhty2zAB88d8jRlu
         jXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770010; x=1753374810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRoDyvAfnO4BnLzN0aqdlFvObbEyzc9rfB0EpRqTEso=;
        b=T7RMlHg0aE2riza0gqEwuEeqR90oU1zwUcqYvQD4bUNUycNspYpvH3EGHqA3vo22hK
         HDozCzNTxbbH3Q8evh4b56lbPKIUb+7E4RkJOy5QquDW5MjIcnMS4JVc4WgWieffxRcQ
         WXIFHN21siwlHUGy9suY/PoDn0zviMl1h9wudcJh8Z2anaE/9cIaFNN+Yy2Hqr77OPjZ
         ZW30sb4ApIEVpsmLn7DTqjgyHim33qi8O5qY/BeIZBooIztvS32jxaPQINa6BFqdQRv3
         1Y2MwlziAGwbacIYm8OVPvM2onxOOpA0+2vfpiqO7UQ4irJlex9qFDlsfmqDu8wVQKZF
         pj+w==
X-Forwarded-Encrypted: i=1; AJvYcCVelARVgvy1dxhSjvGZUKux2sPMUWmQ8CPlj9EABB/hWpkPKW2pL7J2UnF34UaE7G9wA1ezlenOjaa06XA=@vger.kernel.org, AJvYcCWHp3K01xZhoqPW+3V2SRszAB9Mk+3XnTetMz3GUZmajh1PmKPiHYMFa8NDZppuCn8GCi9PdUNGXzbm@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQOchSrTKuIlMDgqOkIxXBsJNP3FxMjGoP4QntIAcu50eIQtj
	3MLOoJmrMy9Fhy7/qw52eF6kSkqQGrYHjzxSfuSKfwmhh5W/hSyc0lef938xqMkmpxKm5sikOaC
	GfVU1zza65B5yceko95Wd+A73zbGKAeU=
X-Gm-Gg: ASbGncvZFga0jLcQzy0Cnz2LG5GkknMgJmQYBj+IBf8TmDL2rngkuJZ70opJHvMq6Ow
	6QaDrDwLz0xEs1ui9J7Yq6sbQdu+ggxz4e/dOw8FIelrmlxnykyS5UjvpmacypNEOninx+XFro0
	dU2gtD0aJUkPBFwAi8MaEdTySGmmKwCU32ONlY2x/KvsO8UR/KrdukqmO8a0AzIQgcxfNhGvVaD
	MX7HBXXIsNauOFGishxAos=
X-Google-Smtp-Source: AGHT+IEymyKQNaMFw0eF8MZSgPvegQrsnRfLpSmDn+6Ms/U9LBdfFIFC6jvitRU+fPd2ZS91ceM2SNmPQHXolE3AuF0=
X-Received: by 2002:ac8:5cc4:0:b0:4ab:6de9:46af with SMTP id
 d75a77b69052e-4abb107529dmr5643401cf.11.1752770009619; Thu, 17 Jul 2025
 09:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717162240.512045-1-thepacketgeek@gmail.com>
 <20250717162240.512045-2-thepacketgeek@gmail.com> <8a4d8f82-dd9b-41bb-b883-231a78cdc1e1@kernel.org>
In-Reply-To: <8a4d8f82-dd9b-41bb-b883-231a78cdc1e1@kernel.org>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Thu, 17 Jul 2025 09:33:18 -0700
X-Gm-Features: Ac12FXyPR52qpZ2YmRkOMBw_r_iao5Suv1nTU5awI0D40jiCqFayV2OdBm8PFXg
Message-ID: <CADvopvY5_RO62h2FE5f-F3f4r+LgOVVeNm6mWAuioFwzwsZyDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] PCI/sysfs: Expose PCIe device serial number
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:29=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 7/17/25 11:22 AM, Matthew Wood wrote:
> > Add a single sysfs read-only interface for reading PCIe device serial
> > numbers from userspace in a programmatic way. This device attribute
> > uses the same hexadecimal 1-byte dashed formatting as lspci serial numb=
er
> > capability output. If a device doesn't support the serial number
> > capability, the device_serial_number sysfs attribute will not be visibl=
e.
>
> You didn't update the commit message here for 'serial_number'.
>
> >
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
>
> With the commit and below comment fixed you can add this to your next spi=
n.

Thank you Mario, I'll send out another v5 soon with these changes.

>
> Reviewed-by: Mario Limonciello <superm1@kernel.org>
>
> > ---
> >   Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
> >   drivers/pci/pci-sysfs.c                 | 26 ++++++++++++++++++++++--=
-
> >   2 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/AB=
I/testing/sysfs-bus-pci
> > index 69f952fffec7..4da41471cc6b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -612,3 +612,12 @@ Description:
> >
> >                 # ls doe_features
> >                 0001:01        0001:02        doe_discovery
> > +
> > +What:                /sys/bus/pci/devices/.../serial_number
> > +Date:                July 2025
> IIRC this should be the date that this is first introduced into the
> kernel.  So if this is 6.17 material it should be October 2025 and if
> it's 6.18 material it should be December 2025.
>
> It's getting close to the merge window so I'm not sure right now which
> Bjorn would prefer.
>
> I would say make it October 2025 and if it slips it just gets updated
> for the next spin.
>
> > +Contact:     Matthew Wood <thepacketgeek@gmail.com>
> > +Description:
> > +             This is visible only for PCIe devices that support the se=
rial
> > +             number extended capability. The file is read only and due=
 to
> > +             the possible sensitivity of accessible serial numbers, ad=
min
> > +             only.
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 268c69daa4d5..bc0e0add15d1 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct devi=
ce *dev,
> >   }
> >   static DEVICE_ATTR_RO(current_link_width);
> >
> > +static ssize_t serial_number_show(struct device *dev,
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
> > +static DEVICE_ATTR_ADMIN_RO(serial_number);
> > +
> >   static ssize_t secondary_bus_number_show(struct device *dev,
> >                                        struct device_attribute *attr,
> >                                        char *buf)
> > @@ -660,6 +676,7 @@ static struct attribute *pcie_dev_attrs[] =3D {
> >       &dev_attr_current_link_width.attr,
> >       &dev_attr_max_link_width.attr,
> >       &dev_attr_max_link_speed.attr,
> > +     &dev_attr_serial_number.attr,
> >       NULL,
> >   };
> >
> > @@ -1749,10 +1766,13 @@ static umode_t pcie_dev_attrs_are_visible(struc=
t kobject *kobj,
> >       struct device *dev =3D kobj_to_dev(kobj);
> >       struct pci_dev *pdev =3D to_pci_dev(dev);
> >
> > -     if (pci_is_pcie(pdev))
> > -             return a->mode;
> > +     if (!pci_is_pcie(pdev))
> > +             return 0;
> >
> > -     return 0;
> > +     if (a =3D=3D &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> > +             return 0;
> > +
> > +     return a->mode;
> >   }
> >
> >   static const struct attribute_group pci_dev_group =3D {
>

