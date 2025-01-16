Return-Path: <linux-pci+bounces-20000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C291A14097
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3944F188DB3C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B25153808;
	Thu, 16 Jan 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MzdTtpm1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30414EC4E
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047940; cv=none; b=ZKZZgXQ3Kr3x9V2qETLoTghQ58rAIgsDRPBxKeEwttYaupSsV50RAHPMPV7+lMnFXc7XhW41p9cEWCY2fRCFDL7iBQ6kCLZVxY9mM1qbYhUsbhepx29OhdUrbtrmTDJrTFEdpqJps484R9JT/ze3JUmKk/dnadM6ASWIXi22Sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047940; c=relaxed/simple;
	bh=2+q4mMd5CeJHNtlmgq3TekKV1k910DHE4hnXsE47bJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1ASUQpZzk+2BzXoqp8Jk0gwpD9bt5aAsSAHA9sirDlJOvfslzcneDbNPWaEGiZ43cktW7cIGG5bDZ4dmmtAM01HKgo3DDzCgoJBf9DmbVE+D0fSoFGlTRLhPF5SE4lW+2BFxr6CmRQIU7/lNuQg+oQ7BEUJc7gHojMIw3t/xZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MzdTtpm1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8ece4937fso10114136d6.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737047937; x=1737652737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHZEoCwfZqbi29Qd3grleSzQjUTVQMXLRSzfE6Se5rI=;
        b=MzdTtpm10GgjKR3YCd22Vue+jKPLEGIjTzotUVlgg31uVMKC/6O/hWZ/DgisPwzoOb
         zuPAty7fWYsBNv4/IbFacrjWzroVFLqrb3Vvtu+wPZjU2S5z5Tj4vI1LSxycxTrORpG+
         8bPHCi4H6Ba8H1OiNszQhegXUi8xFrg1Rghk2qXHxKKEKKpA1JKcjdvetg08FzPI1BMN
         sxn7f02MNPF3GiGR2IKk8hBZeYp7RNzMTb43v9URSe9DzVLQkqtKwkMtxo8ONMHi++Xa
         5XxXYsIP842WU2iZP0tqAfoRofefIqBeJaXGSmRYi7ffZ3YTDd8I2AhllRsGAamCpmPN
         TfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047937; x=1737652737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHZEoCwfZqbi29Qd3grleSzQjUTVQMXLRSzfE6Se5rI=;
        b=ufAeMqApxImckuQSz24RSniELzia4qkOs7uqmOIOcvEj4uZ957xjJKBE7iIKJ9IHqg
         fJjZ2rRDAtueDzSSsZhkzVWPIQXIVcQERK7vW+IKxqKd4523NxNf2e/w7WogEHn6CYq7
         FqyWPfB+dQ/2VbGMO9z0neg2UDuYIpO9N0YTmE8AxW9LjfP3gehQcrEBCJuBz9ejtvH5
         kFJ3DWQnlqReN7VMRbZi+C8LFTZVY1C1d4kFOL3mNO7sMc3/2C/R52v3OS+J/f3Tscr0
         7P7NbV8PsFotfd9Vyg37V9Gz/OT5wFyRQWD/Yq0XAl2C0P8itWMlYNPdll/hgsS1+zgV
         ibxg==
X-Forwarded-Encrypted: i=1; AJvYcCXCQrKhsltChwc5cl+zDzE+QeVmLN/8FOxZ8S6ecyKHQWgN6+S0NLrOL8sw5Rc5Sp7+92kdYNetIu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuF9PYQzEZkjxw7owznwhl7D0KwzkdjNWH7HK3E5dB02sTggw
	SLO4CUT+uM0WKbjj85p7V7jz2QytwlJRDNG7E3w9XYxLexTiRsQRZ9/5KyKXARkU2ORMTfTUpgv
	Pd1doTVMfAyPdwKeSqRrq7gK2F6iuA0a1TtlBgYeray0UV07e9Q==
X-Gm-Gg: ASbGncsUs1eW6kT9V8jN9x7KWMu9F9iPNw1YNc65X1O8KfqP9bzDYwRAqG5/vM6zS1A
	0Xp9ljjHyrIxrrnWd9LYvnCTaS8BGkbF9xZkqcSBLf0SNKFw10sbC5UG4WkVxlOrm
X-Google-Smtp-Source: AGHT+IGMr/M8p0pPr4at+0Z2thpxl/j5HJTomEz6ZWm0RksInxepiCICIdF8tzaYvnODyYo+XxrUzW6FfBG4Znj7jmY=
X-Received: by 2002:a05:6214:1948:b0:6d8:a84b:b50d with SMTP id
 6a1803df08f44-6df9b2ad2fcmr582933226d6.33.1737047936905; Thu, 16 Jan 2025
 09:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-9-pandoh@google.com>
 <620bbbde-35a9-4232-9cf9-a1fa1e899f8a@oracle.com>
In-Reply-To: <620bbbde-35a9-4232-9cf9-a1fa1e899f8a@oracle.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 16 Jan 2025 09:18:20 -0800
X-Gm-Features: AbW1kvZwlO-Nt0QhjZSnkbf3vsLbUso5qexakWvIikghCLFZAqq4A8zqZNI571g
Message-ID: <CACK8Z6Hyx4D3d=BK15f55muYu7kMLYV7fEusc7dTiUJJ3G5KuQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] PCI/AER: Move AER sysfs attributes into separate directory
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 16, 2025 at 2:26=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
>
> On 15/01/2025 08:43, Jon Pan-Doh wrote:
> > Prepare for the addition of new AER sysfs attributes (e.g. ratelimits)
> > by moving them into their own directory. Update naming to reflect
> > broader definition and for consistency.
> >
> > /sys/bus/pci/devices/<dev>/aer_dev_correctable
> > /sys/bus/pci/devices/<dev>/aer_dev_fatal
> > /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > /sys/bus/pci/devices/<dev>/aer_rootport_total_err_cor
> > /sys/bus/pci/devices/<dev>/aer_rootport_total_err_fatal
> > /sys/bus/pci/devices/<dev>/aer_rootport_total_err_nonfatal
> > ->
> > /sys/bus/pci/devices/<dev>/aer/err_cor
> > /sys/bus/pci/devices/<dev>/aer/err_fatal
> > /sys/bus/pci/devices/<dev>/aer/err_nonfatal
> > /sys/bus/pci/devices/<dev>/aer/rootport_total_err_cor
> > /sys/bus/pci/devices/<dev>/aer/rootport_total_err_fatal
> > /sys/bus/pci/devices/<dev>/aer/rootport_total_err_nonfatal
> >
> > Tested using aer-inject[1] tool. Sent 1 AER error. Observed AER stats
> > correctedly logged (cat /sys/bus/pci/devices/<dev>/aer/dev_err_cor).
>
> I'm not a sysfs expert but my understanding is that we shouldn't do
> major changes in the existing hierarchies.
>
> On one hand, I think it would be nice to extract out AER-specific info
> and knobs into a subdirectory (e.g., using attribute_group with name
> "aer"), but on the other this would be disruptive to the userspace. I
> can imagine that there are tools that watch these values that would
> break after this change.

Thank you. This is the right guidance.

As the original author to introduce these attributes, I just wanted to
chime in from the ChromeOS team's perspective (who originally
introduced these attributes). I can say that we have used these
attributes for debugging mostly manually, and do not have tools yet
with hardcoded hierarchy / paths. So we wouldn't be opposed to it, if
changes to the hierarchy have wider acceptance and it seems better in
general.

Thanks & Best Regards,

Rajat


>
> All the best,
> Karolina
>
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-injec=
t.git
> >
> > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > ---
> >   .../ABI/testing/sysfs-bus-pci-devices-aer     | 18 +++---
> >   drivers/pci/pci-sysfs.c                       |  1 -
> >   drivers/pci/pci.h                             |  1 -
> >   drivers/pci/pcie/aer.c                        | 64 +++++++-----------=
-
> >   4 files changed, 32 insertions(+), 52 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Docu=
mentation/ABI/testing/sysfs-bus-pci-devices-aer
> > index c680a53af0f4..e1472583207b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > @@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and=
 not the
> >   problematic endpoint itself (which may report all counters as 0 as it=
 never
> >   saw any problems).
> >
> > -What:                /sys/bus/pci/devices/<dev>/aer_dev_correctable
> > +What:                /sys/bus/pci/devices/<dev>/aer/err_cor
> >   Date:               July 2018
> >   KernelVersion:      4.19.0
> >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > @@ -19,7 +19,7 @@ Description:        List of correctable errors seen a=
nd reported by this
> >               TOTAL_ERR_COR at the end of the file may not match the ac=
tual
> >               total of all the errors in the file. Sample output::
> >
> > -                 localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat =
aer_dev_correctable
> > +                 localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # =
cat err_cor
> >                   Receiver Error 2
> >                   Bad TLP 0
> >                   Bad DLLP 0
> > @@ -30,7 +30,7 @@ Description:        List of correctable errors seen a=
nd reported by this
> >                   Header Log Overflow 0
> >                   TOTAL_ERR_COR 2
> >
> > -What:                /sys/bus/pci/devices/<dev>/aer_dev_fatal
> > +What:                /sys/bus/pci/devices/<dev>/aer/err_fatal
> >   Date:               July 2018
> >   KernelVersion:      4.19.0
> >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > @@ -40,7 +40,7 @@ Description:        List of uncorrectable fatal error=
s seen and reported by this
> >               TOTAL_ERR_FATAL at the end of the file may not match the =
actual
> >               total of all the errors in the file. Sample output::
> >
> > -                 localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat =
aer_dev_fatal
> > +                 localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # =
cat err_fatal
> >                   Undefined 0
> >                   Data Link Protocol 0
> >                   Surprise Down Error 0
> > @@ -60,7 +60,7 @@ Description:        List of uncorrectable fatal error=
s seen and reported by this
> >                   TLP Prefix Blocked Error 0
> >                   TOTAL_ERR_FATAL 0
> >
> > -What:                /sys/bus/pci/devices/<dev>/aer_dev_nonfatal
> > +What:                /sys/bus/pci/devices/<dev>/aer/err_nonfatal
> >   Date:               July 2018
> >   KernelVersion:      4.19.0
> >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > @@ -70,7 +70,7 @@ Description:        List of uncorrectable nonfatal er=
rors seen and reported by this
> >               TOTAL_ERR_NONFATAL at the end of the file may not match t=
he
> >               actual total of all the errors in the file. Sample output=
::
> >
> > -                 localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat =
aer_dev_nonfatal
> > +                 localhost /sys/devices/pci0000:00/0000:00:1c.0/aer # =
cat err_nonfatal
> >                   Undefined 0
> >                   Data Link Protocol 0
> >                   Surprise Down Error 0
> > @@ -100,19 +100,19 @@ collectors) that are AER capable. These indicate =
the number of error messages as
> >   device, so these counters include them and are thus cumulative of all=
 the error
> >   messages on the PCI hierarchy originating at that root port.
> >
> > -What:                /sys/bus/pci/devices/<dev>/aer_rootport_total_err=
_cor
> > +What:                /sys/bus/pci/devices/<dev>/aer/rootport_total_err=
_cor
> >   Date:               July 2018
> >   KernelVersion:      4.19.0
> >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> >   Description:        Total number of ERR_COR messages reported to root=
port.
> >
> > -What:                /sys/bus/pci/devices/<dev>/aer_rootport_total_err=
_fatal
> > +What:                /sys/bus/pci/devices/<dev>/aer/rootport_total_err=
_fatal
> >   Date:               July 2018
> >   KernelVersion:      4.19.0
> >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> >   Description:        Total number of ERR_FATAL messages reported to ro=
otport.
> >
> > -What:                /sys/bus/pci/devices/<dev>/aer_rootport_total_err=
_nonfatal
> > +What:                /sys/bus/pci/devices/<dev>/aer/rootport_total_err=
_nonfatal
> >   Date:               July 2018
> >   KernelVersion:      4.19.0
> >   Contact:    linux-pci@vger.kernel.org, rajatja@google.com
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 41acb6713e2d..e16b92edf3bd 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1692,7 +1692,6 @@ const struct attribute_group *pci_dev_attr_groups=
[] =3D {
> >       &pci_bridge_attr_group,
> >       &pcie_dev_attr_group,
> >   #ifdef CONFIG_PCIEAER
> > -     &aer_stats_attr_group,
> >       &aer_attr_group,
> >   #endif
> >   #ifdef CONFIG_PCIEASPM
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 9d0272a890ef..a80cfc08f634 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -880,7 +880,6 @@ static inline void of_pci_remove_node(struct pci_de=
v *pdev) { }
> >   void pci_no_aer(void);
> >   void pci_aer_init(struct pci_dev *dev);
> >   void pci_aer_exit(struct pci_dev *dev);
> > -extern const struct attribute_group aer_stats_attr_group;
> >   extern const struct attribute_group aer_attr_group;
> >   void pci_aer_clear_fatal_status(struct pci_dev *dev);
> >   int pci_aer_clear_status(struct pci_dev *dev);
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index e48e2951baae..68850525cc8d 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -569,13 +569,13 @@ static const char *aer_agent_string[] =3D {
> >   }                                                                   \
> >   static DEVICE_ATTR_RO(name)
> >
> > -aer_stats_dev_attr(aer_dev_correctable, dev_cor_errs,
> > +aer_stats_dev_attr(err_cor, dev_cor_errs,
> >                  aer_correctable_error_string, "ERR_COR",
> >                  dev_total_cor_errs);
> > -aer_stats_dev_attr(aer_dev_fatal, dev_fatal_errs,
> > +aer_stats_dev_attr(err_fatal, dev_fatal_errs,
> >                  aer_uncorrectable_error_string, "ERR_FATAL",
> >                  dev_total_fatal_errs);
> > -aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
> > +aer_stats_dev_attr(err_nonfatal, dev_nonfatal_errs,
> >                  aer_uncorrectable_error_string, "ERR_NONFATAL",
> >                  dev_total_nonfatal_errs);
> >
> > @@ -589,47 +589,13 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal=
_errs,
> >   }                                                                   \
> >   static DEVICE_ATTR_RO(name)
> >
> > -aer_stats_rootport_attr(aer_rootport_total_err_cor,
> > +aer_stats_rootport_attr(rootport_total_err_cor,
> >                        rootport_total_cor_errs);
> > -aer_stats_rootport_attr(aer_rootport_total_err_fatal,
> > +aer_stats_rootport_attr(rootport_total_err_fatal,
> >                        rootport_total_fatal_errs);
> > -aer_stats_rootport_attr(aer_rootport_total_err_nonfatal,
> > +aer_stats_rootport_attr(rootport_total_err_nonfatal,
> >                        rootport_total_nonfatal_errs);
> >
> > -static struct attribute *aer_stats_attrs[] __ro_after_init =3D {
> > -     &dev_attr_aer_dev_correctable.attr,
> > -     &dev_attr_aer_dev_fatal.attr,
> > -     &dev_attr_aer_dev_nonfatal.attr,
> > -     &dev_attr_aer_rootport_total_err_cor.attr,
> > -     &dev_attr_aer_rootport_total_err_fatal.attr,
> > -     &dev_attr_aer_rootport_total_err_nonfatal.attr,
> > -     NULL
> > -};
> > -
> > -static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
> > -                                        struct attribute *a, int n)
> > -{
> > -     struct device *dev =3D kobj_to_dev(kobj);
> > -     struct pci_dev *pdev =3D to_pci_dev(dev);
> > -
> > -     if (!pdev->aer_info)
> > -             return 0;
> > -
> > -     if ((a =3D=3D &dev_attr_aer_rootport_total_err_cor.attr ||
> > -          a =3D=3D &dev_attr_aer_rootport_total_err_fatal.attr ||
> > -          a =3D=3D &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
> > -         ((pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ROOT_PORT) &&
> > -          (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_EC)))
> > -             return 0;
> > -
> > -     return a->mode;
> > -}
> > -
> > -const struct attribute_group aer_stats_attr_group =3D {
> > -     .attrs  =3D aer_stats_attrs,
> > -     .is_visible =3D aer_stats_attrs_are_visible,
> > -};
> > -
> >   #define aer_ratelimit_attr(name, ratelimit)                         \
> >       static ssize_t                                                  \
> >       name##_show(struct device *dev, struct device_attribute *attr,  \
> > @@ -662,6 +628,14 @@ aer_ratelimit_attr(ratelimit_cor_log, cor_log_rate=
limit);
> >   aer_ratelimit_attr(ratelimit_uncor_log, uncor_log_ratelimit);
> >
> >   static struct attribute *aer_attrs[] __ro_after_init =3D {
> > +     /* Stats */
> > +     &dev_attr_err_cor.attr,
> > +     &dev_attr_err_fatal.attr,
> > +     &dev_attr_err_nonfatal.attr,
> > +     &dev_attr_rootport_total_err_cor.attr,
> > +     &dev_attr_rootport_total_err_fatal.attr,
> > +     &dev_attr_rootport_total_err_nonfatal.attr,
> > +     /* Ratelimits */
> >       &dev_attr_ratelimit_cor_irq.attr,
> >       &dev_attr_ratelimit_uncor_irq.attr,
> >       &dev_attr_ratelimit_cor_log.attr,
> > @@ -670,13 +644,21 @@ static struct attribute *aer_attrs[] __ro_after_i=
nit =3D {
> >   };
> >
> >   static umode_t aer_attrs_are_visible(struct kobject *kobj,
> > -                                  struct attribute *a, int n)
> > +                                        struct attribute *a, int n)
> >   {
> >       struct device *dev =3D kobj_to_dev(kobj);
> >       struct pci_dev *pdev =3D to_pci_dev(dev);
> >
> >       if (!pdev->aer_info)
> >               return 0;
> > +
> > +     if ((a =3D=3D &dev_attr_rootport_total_err_cor.attr ||
> > +          a =3D=3D &dev_attr_rootport_total_err_fatal.attr ||
> > +          a =3D=3D &dev_attr_rootport_total_err_nonfatal.attr) &&
> > +         ((pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ROOT_PORT) &&
> > +          (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_RC_EC)))
> > +             return 0;
> > +
> >       return a->mode;
> >   }
> >
>
>

