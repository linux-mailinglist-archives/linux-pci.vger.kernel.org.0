Return-Path: <linux-pci+bounces-20092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD5A15AF8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 02:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAECA188C07A
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 01:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683417C61;
	Sat, 18 Jan 2025 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QcKjBtm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A217548
	for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165570; cv=none; b=cji47SKs67zuV9A5WZhFBn6cLNydZobhITCoPI7zFxQFf3yoO3FQkkWH/UJpIcKlDLSd4BCIkhBCCzkTxpUA4zxGOMTn28ve0zVz9rgUxMthdDXtj4ErJbvMEI9kITq34Sh2dxC6aBd2QbJsw2n/BqfNv/nSRAk3D34w1KN+kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165570; c=relaxed/simple;
	bh=DHXVGLWSl01DFSWqxFiE0fP9V3qdgcT7BohnIF24BDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBGkoiTzpCUSdPoMFU7iynXsKjWAR2X+S/GfM79/kUPiw+cmg4Bs+At7yH5XDjlko5qceaxahH51h8KIr62mvPHfkF9AW6aNIjZlZOWu2mqDmsn5fsF6iEJK+w6KGJEGr3ZyliCcxen3mni03ZgwQl4eh2GU6dftrOz1LXlxeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QcKjBtm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso416411466b.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 17:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737165566; x=1737770366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUZ+u9pm90bd20V0uaqrbBbrTCK5mCDNNONr5HWIpFo=;
        b=2QcKjBtmGcmjpoBQDMsFNzVu8/s7R6WD+Vf0dE/lF7kawaczMTg54pwhwXWM01FaSh
         ftUyA2Uguuf5ZN4bfWLvRH5c4syjh9LcWOvCH7KIxJnaxNq8z1lpAWPaInDoCJEeaXih
         19iWVFRlFHLM8F0u5ZjWOowKiBbLKeL+MYG7R/XiZgB0gKzNbTi+YpjhN+48knScZgcg
         M3wWp0ct4k570m1V0scOS3QPg74P+Piih6nLmy9c0GvcBCKKPcPDOgupHTMRkvnihBt3
         xamqJNK7QKVEyo8NOBAM7Ez/kkWxfBRbylInFWxQNL1+03fKl1l6mKNJAtax7B8GeuGH
         fTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165566; x=1737770366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUZ+u9pm90bd20V0uaqrbBbrTCK5mCDNNONr5HWIpFo=;
        b=N9wpCIg57jhCYyclGb1HYwUiacSPg/oJqsT1YkEncakGR+PQrrcyRmAuAO3mwJ7PZc
         rR/3G6zwWVwd+WYBJhOa1oma8Cb02Vc8rvL6m/PKmpzWLSLnL0j459Ch+BixjeLgumBk
         LFkqFpFWpFw9MhFl91br5SItT77uDjxLcj6mfTdt6ljA4DsNwQLhMk11pxCJPtwVg6Gv
         mv+REA6W4ERiZ7DTblDDh6bxYRuaqAGqI0A383ZDFSV7vZjyv+RiPR3hLdRoiwj+FsoJ
         OEb2Prwa8o60Fgh7NwJ/IkFvBYsMnh2WoDYdAkJ0VqnRhw0R7UZxHS2t+MgAXSLNryT4
         9ZPA==
X-Forwarded-Encrypted: i=1; AJvYcCV5YguA+9/n71MdW1/lAApmZfJVJqLRnJwd+PHCZ0oWqtpzAPVoJTTzsnv6O6zhimpoH1tXwsn1fNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0HiA7GY5/mXtJBeO7m0pXJ366Hvysx9XDsS1etsjdWDk0lIL
	2rVas2faejuXDu7N15+jEXDYxyu6qODRRgTdSkXaH4KifIMvy42Rrn0/eRi7WL4WfJALYfXD6np
	L6KSeW+d7Zjp5AInEelbrv+cvNtOZAxO1bcsHF6/5xiezfq2p2A==
X-Gm-Gg: ASbGncusjKmJ/2dQYNjMu1bgnSkYYilgGn+8+fcFv3kkyMdpLE+3mHp5HddyqMNpwX6
	myvkn6Vnrr/qNlftwD+4RsBnkDsJyu5zVQTgBKEuZPGN3Xd5SsVFnNW5/V+y5f2pVFmM0Kmm0mY
	bKW9aGzg==
X-Google-Smtp-Source: AGHT+IEBJTOLnwa6pIqFR+/7Y/RR/3pZaSn+4ZqDSZgVhVlccBjYcawshyxRtb1StiEXqguL2zK87O919AkknWZUd9Q=
X-Received: by 2002:a17:907:7e91:b0:ab2:ea29:b6 with SMTP id
 a640c23a62f3a-ab38b37cf5amr491011466b.35.1737165566279; Fri, 17 Jan 2025
 17:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-5-pandoh@google.com>
 <b0eb4417-600b-4b70-ae5f-d51ccbd5ef2c@oracle.com>
In-Reply-To: <b0eb4417-600b-4b70-ae5f-d51ccbd5ef2c@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 17 Jan 2025 17:59:14 -0800
X-Gm-Features: AbW1kvZHLLZlHfyfxfil3_MFX3AoKobb4LdaDr0kPgvgFduNGhdSUOJJ6Fty47s
Message-ID: <CAMC_AXV00AU2UHw1h2WVE+GV8YqTNOsrC85-fWSLrqSu2efWPA@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI/AER: Introduce ratelimit for error logs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:11=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> On 15/01/2025 08:42, Jon Pan-Doh wrote:
> > @@ -374,6 +379,12 @@ void pci_aer_init(struct pci_dev *dev)
> > +     ratelimit_set_flags(&dev->aer_info->cor_log_ratelimit, RATELIMIT_=
MSG_ON_RELEASE);
> > +     ratelimit_set_flags(&dev->aer_info->uncor_log_ratelimit, RATELIMI=
T_MSG_ON_RELEASE);
>
> In some cases, it would be beneficial to keep the "X callbacks
> suppressed" to give an idea of how prevalent the errors are. On some
> devices, we could see just 11 Correctable Errors per 5 seconds, but on
> others this would be >1k (seen such a case myself).
>
> As it's not immediately clear what the defaults are, could you add a
> comment for this?

It seems like the convention is not to use RATELIMIT_MSG_ON_RELEASE (I
was unfamiliar :)). I'll omit this in the next version. Let me know if
you'd still like the comment in that case.

> > @@ -709,11 +721,20 @@ void aer_print_error(struct pci_dev *dev, struct
> > +     if (!__ratelimit(ratelimit))
> > +             return;
> > +
>
> Maybe it's just me but I found "!__ratelimit(..)" expression confusing.
> At first, I read this "if there is not ratelimit", whereas the function
> returns 0 ("hey, you can't fire at this point of time") and we negate
> it. My series attempted to communicate this via a variable, but maybe
> that was too wordy/complicated, so I'm not pushy about introducing a
> similar solution here.

I see your point. I'm not particularly attached to it, but the
alternatives seem equally unappealing :/:
- put rest of function inside conditional: if
(__ratelimit(ratelimit))) { log errors }
    - another print helper?
- separate variable (as you suggested

FYI the majority of existing usage seems to be split between
__ratelimit() and !__ratelimit() (though majority doesn't always
indicate the right thing). The only instance I see of a variable is in
drivers/iommu/intel/dmar.c:dmar_fault where the variable is used in
repeated conditionals.

Thanks,
Jon


On Thu, Jan 16, 2025 at 3:11=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
>
> On 15/01/2025 08:42, Jon Pan-Doh wrote:
> > Spammy devices can flood kernel logs with AER errors and slow/stall
> > execution. Add per-device ratelimits for AER errors (correctable and
> > uncorrectable). Set the default rate to the default kernel ratelimit
> > (10 per 5s).
> >
> > Tested using aer-inject[1] tool. Sent 11 AER errors. Observed 10 errors
> > logged while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correcta=
ble)
> > show true count of 11.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-injec=
t.git
> >
> > Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> > ---
> >   Documentation/PCI/pcieaer-howto.rst |  6 ++++++
> >   drivers/pci/pcie/aer.c              | 31 +++++++++++++++++++++++++++-=
-
> >   2 files changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pc=
ieaer-howto.rst
> > index f013f3b27c82..5546de60f184 100644
> > --- a/Documentation/PCI/pcieaer-howto.rst
> > +++ b/Documentation/PCI/pcieaer-howto.rst
> > @@ -85,6 +85,12 @@ In the example, 'Requester ID' means the ID of the d=
evice that sent
> >   the error message to the Root Port. Please refer to PCIe specs for ot=
her
> >   fields.
> >
> > +AER Ratelimits
> > +-------------------------
> > +
> > +Error messages are ratelimited per device and error type. This prevent=
s spammy
> > +devices from flooding the console.
> > +
>
> Nit: I would create a separate commit for the documentation updates.
> Also, I think it would be good to mention the default interval and,
> maybe, explain why such rate-limiting was introduced in the first place.
> If you don't feel like writing about it, let me know and we can work it
> out together.
>
> >   AER Statistics / Counters
> >   -------------------------
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 5ab5cd7368bc..025c50b0f293 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -27,6 +27,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/delay.h>
> >   #include <linux/kfifo.h>
> > +#include <linux/ratelimit.h>
> >   #include <linux/slab.h>
> >   #include <acpi/apei.h>
> >   #include <acpi/ghes.h>
> > @@ -84,6 +85,10 @@ struct aer_info {
> >       u64 rootport_total_cor_errs;
> >       u64 rootport_total_fatal_errs;
> >       u64 rootport_total_nonfatal_errs;
> > +
> > +     /* Ratelimits for errors */
> > +     struct ratelimit_state cor_log_ratelimit;
> > +     struct ratelimit_state uncor_log_ratelimit;
>
> My comment for 3/8 applies here as well.
>
> >   };
> >
> >   #define AER_LOG_TLP_MASKS           (PCI_ERR_UNC_POISON_TLP|        \
> > @@ -374,6 +379,12 @@ void pci_aer_init(struct pci_dev *dev)
> >               return;
> >
> >       dev->aer_info =3D kzalloc(sizeof(struct aer_info), GFP_KERNEL);
> > +     ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
> > +                          DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMI=
T_BURST);
> > +     ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
> > +                          DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMI=
T_BURST);
> > +     ratelimit_set_flags(&dev->aer_info->cor_log_ratelimit, RATELIMIT_=
MSG_ON_RELEASE);
> > +     ratelimit_set_flags(&dev->aer_info->uncor_log_ratelimit, RATELIMI=
T_MSG_ON_RELEASE);
>
> In some cases, it would be beneficial to keep the "X callbacks
> suppressed" to give an idea of how prevalent the errors are. On some
> devices, we could see just 11 Correctable Errors per 5 seconds, but on
> others this would be >1k (seen such a case myself).
>
> As it's not immediately clear what the defaults are, could you add a
> comment for this?
>
> >
> >       /*
> >        * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> > @@ -702,6 +713,7 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info)
> >       int layer, agent;
> >       int id =3D pci_dev_id(dev);
> >       const char *level;
> > +     struct ratelimit_state *ratelimit;
> >
> >       if (!info->status) {
> >               pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3DInacc=
essible, (Unregistered Agent ID)\n",
> > @@ -709,11 +721,20 @@ void aer_print_error(struct pci_dev *dev, struct =
aer_err_info *info)
> >               goto out;
> >       }
> >
> > +     if (info->severity =3D=3D AER_CORRECTABLE) {
> > +             ratelimit =3D &dev->aer_info->cor_log_ratelimit;
> > +             level =3D KERN_WARNING;
> > +     } else {
> > +             ratelimit =3D &dev->aer_info->uncor_log_ratelimit;
> > +             level =3D KERN_ERR;
> > +     }
> > +
> > +     if (!__ratelimit(ratelimit))
> > +             return;
> > +
>
> Maybe it's just me but I found "!__ratelimit(..)" expression confusing.
> At first, I read this "if there is not ratelimit", whereas the function
> returns 0 ("hey, you can't fire at this point of time") and we negate
> it. My series attempted to communicate this via a variable, but maybe
> that was too wordy/complicated, so I'm not pushy about introducing a
> similar solution here.
>
> All the best,
> Karolina
>
> >       layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
> >       agent =3D AER_GET_AGENT(info->severity, info->status);
> >
> > -     level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_WARNING =
: KERN_ERR;
> > -
> >       pci_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=3D%s,=
 (%s)\n",
> >                  aer_error_severity_string[info->severity],
> >                  aer_error_layer[layer], aer_agent_string[agent]);
> > @@ -755,11 +776,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_s=
everity,
> >       int layer, agent, tlp_header_valid =3D 0;
> >       u32 status, mask;
> >       struct aer_err_info info;
> > +     struct ratelimit_state *ratelimit;
> >
> >       if (aer_severity =3D=3D AER_CORRECTABLE) {
> > +             ratelimit =3D &dev->aer_info->cor_log_ratelimit;
> >               status =3D aer->cor_status;
> >               mask =3D aer->cor_mask;
> >       } else {
> > +             ratelimit =3D &dev->aer_info->uncor_log_ratelimit;
> >               status =3D aer->uncor_status;
> >               mask =3D aer->uncor_mask;
> >               tlp_header_valid =3D status & AER_LOG_TLP_MASKS;
> > @@ -776,6 +800,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_sev=
erity,
> >
> >       pci_dev_aer_stats_incr(dev, &info);
> >
> > +     if (!__ratelimit(ratelimit))
> > +             return;
> > +
> >       pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, ma=
sk);
> >       __aer_print_error(dev, &info);
> >       pci_err(dev, "aer_layer=3D%s, aer_agent=3D%s\n",
>

