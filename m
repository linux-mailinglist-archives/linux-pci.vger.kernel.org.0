Return-Path: <linux-pci+bounces-7317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4B8C1D42
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 05:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E6C1C20F95
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 03:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5951149DF9;
	Fri, 10 May 2024 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WJuCOWjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29513B787
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 03:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715313360; cv=none; b=R2/Q+v/3cR4w8ER6cy7OnQtw0KCCw6V1p0vCBZvJ99ukImWj8aGEYhNiSZrCrpXASnqojQvotbfh9EnOZ6r/4nmt3iGoTI7HcUdvRTa24gR0xtmX92MWc73ziBbWtHqYuwMhLYbmq5pKHQ1njI862uH8DqWCca1bEEVjVgjFwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715313360; c=relaxed/simple;
	bh=tNLvZ04h+fM4ceH+bEa17S4eBWCA/3X5d35atJYVNPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hy2xxnYmgNB9ByKLXMo1+fGRAzn7OJsS9halbPHY7KP3r6+EhZztAihH/UbeYiiIYhRQ+fouUxL3v6Crgn1klHXo8//t+GHVweKze3sS0ii/CXCTrPUtgfjQsoV7gEAG7e28+nP26YwxaK9bWdcHHiyBpQoDQzqhnVYb1iTpkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WJuCOWjL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1290039a12.3
        for <linux-pci@vger.kernel.org>; Thu, 09 May 2024 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715313357; x=1715918157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=00tenaUJmkxYqrXAfoI4m9u6wT4ztKoDhbEaKuvuY9E=;
        b=WJuCOWjL8Zhjtb3orjA0F4fo0KkQUaa2fPXMadxjL6RQDEDxGqMahwU8KxzLYr0Q+m
         Uvked0ynDhYn6txRvRJxZr/NhXWWU277D88ymlioKNs1UzVip476uViWY0WicKGo2zY2
         Ds8fiK9IhlK2rfapZIiPU6KTm3CIzm9CdYu2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715313357; x=1715918157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00tenaUJmkxYqrXAfoI4m9u6wT4ztKoDhbEaKuvuY9E=;
        b=PUGOOTMWRKGd0KdhQfk2ZtFMV496hraOVct4BvPEsNhR7myIL1LKBQhW4p0YL3BgP2
         3v6dVXYTF4oSR3JhuVzC2vVK9HRanc0yUOD8XOV9CQR41uZxMGVsZI5s0o3R3eU1OzMf
         CbBkpjrVlXPdstEg/cIcP99jfHngRbPIk6RTd3duUxbm/K8YW/50VMHQim3p3di9shFN
         ImLsDmkZFT34PhXNZQM82T59LIkOAyfbFuyRFyQBjarJSkLVZhQJ2NibFcsKYQtOO2Mo
         qyo68/1G+tWgnExBEHwbAuD36bZru6eow6RGJV04bIkr5/T+ia4PUwlC6IAhu6lO5rz8
         Rd1A==
X-Forwarded-Encrypted: i=1; AJvYcCWX4Y4vEgy0qJfsjqMWXx/6C9GiEufBXtryqrzclA/KoKHYlq4RT6F+VGgTGWTM5xdLvXp0FxkLfi9Qwkm5xmCCiS4PyvlYflU3
X-Gm-Message-State: AOJu0YzC1itQnf//BbHfo6mgMmcdpZCb3mKn8wX8fmw2b30QQZmoE0Ns
	SUs4PBOdw2WamCWuFYS3x04cLgUZlG4csZTuqMpHqhaenWjVSd6qWlUbhekCYodbc75UJcVhGID
	17PHQ78wpSGHFjOh8uC0WWLBXzM1Il1YT8vkqc7HCLgVxyHlfnT2m
X-Google-Smtp-Source: AGHT+IFJOehPbmZkaqlNrXh1ID19oQluYLarmVqIut2VGat0+rCUCNc1ELWs+axvjYkChlh96sgJn0FzAz2QpRZxnXo=
X-Received: by 2002:a17:90a:17ef:b0:2b6:ab87:5434 with SMTP id
 98e67ed59e1d1-2b6ccd9ec2amr1659245a91.35.1715313357387; Thu, 09 May 2024
 20:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509162741.1937586-1-wei.huang2@amd.com> <20240509162741.1937586-9-wei.huang2@amd.com>
 <868a4758-2873-4ede-83e5-65f42cb12b81@linux.dev>
In-Reply-To: <868a4758-2873-4ede-83e5-65f42cb12b81@linux.dev>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Thu, 9 May 2024 20:55:39 -0700
Message-ID: <CACZ4nhuBMOX8s1ODcJOvvCKp-VsOPHShEUHAsPvB75Yv2823qA@mail.gmail.com>
Subject: Re: [PATCH V1 8/9] bnxt_en: Add TPH support in BNXT driver
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com, 
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005e3f16061811831b"

--0000000000005e3f16061811831b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:50=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 09/05/2024 17:27, Wei Huang wrote:
> > From: Manoj Panicker <manoj.panicker2@amd.com>
> >
> > As a usage example, this patch implements TPH support in Broadcom BNXT
> > device driver by invoking pcie_tph_set_st() function when interrupt
> > affinity is changed.
> >
> > Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > Reviewed-by: Wei Huang <wei.huang2@amd.com>
> > Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 ++++++++++++++++++++++=
+
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
> >   2 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 2c2ee79c4d77..be9c17566fb4 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -55,6 +55,7 @@
> >   #include <net/page_pool/helpers.h>
> >   #include <linux/align.h>
> >   #include <net/netdev_queues.h>
> > +#include <linux/pci-tph.h>
> >
> >   #include "bnxt_hsi.h"
> >   #include "bnxt.h"
> > @@ -10491,6 +10492,7 @@ static void bnxt_free_irq(struct bnxt *bp)
> >                               free_cpumask_var(irq->cpu_mask);
> >                               irq->have_cpumask =3D 0;
> >                       }
> > +                     irq_set_affinity_notifier(irq->vector, NULL);
> >                       free_irq(irq->vector, bp->bnapi[i]);
> >               }
> >
> > @@ -10498,6 +10500,45 @@ static void bnxt_free_irq(struct bnxt *bp)
> >       }
> >   }
> >
> > +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
> > +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
> > +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notif=
y,
> > +                                  const cpumask_t *mask)
> > +{
> > +     struct bnxt_irq *irq;
> > +
> > +     irq =3D container_of(notify, struct bnxt_irq, affinity_notify);
> > +     cpumask_copy(irq->cpu_mask, mask);
> > +
> > +     if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
> > +                          cpumask_first(irq->cpu_mask),
> > +                          TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> > +             pr_err("error in configuring steering tag\n");
> > +
> > +     if (netif_running(irq->bp->dev)) {
> > +             rtnl_lock();
> > +             bnxt_close_nic(irq->bp, false, false);
> > +             bnxt_open_nic(irq->bp, false, false);
> > +             rtnl_unlock();
> > +     }
>
> Is it really needed? It will cause link flap and pause in the traffic
> service for the device. Why the device needs full restart in this case?

In that sequence only the rings are recreated for the hardware to sync
up the tags.

Actually its not a full restart. There is no link reinit or other
heavy lifting in this sequence.
The pause in traffic may be momentary. Do IRQ/CPU affinities change frequen=
tly?
Probably not?

>
>
> > +}
> > +
> > +static void bnxt_irq_affinity_release(struct kref __always_unused *ref=
)
> > +{
> > +}
> > +
> > +static inline void __bnxt_register_notify_irqchanges(struct bnxt_irq *=
irq)
>
> No inlines in .c files, please. Let compiler decide what to inline.
>
> > +{
> > +     struct irq_affinity_notify *notify;
> > +
> > +     notify =3D &irq->affinity_notify;
> > +     notify->irq =3D irq->vector;
> > +     notify->notify =3D bnxt_irq_affinity_notify;
> > +     notify->release =3D bnxt_irq_affinity_release;
> > +
> > +     irq_set_affinity_notifier(irq->vector, notify);
> > +}
> > +
> >   static int bnxt_request_irq(struct bnxt *bp)
> >   {
> >       int i, j, rc =3D 0;
> > @@ -10543,6 +10584,7 @@ static int bnxt_request_irq(struct bnxt *bp)
> >                       int numa_node =3D dev_to_node(&bp->pdev->dev);
> >
> >                       irq->have_cpumask =3D 1;
> > +                     irq->msix_nr =3D map_idx;
> >                       cpumask_set_cpu(cpumask_local_spread(i, numa_node=
),
> >                                       irq->cpu_mask);
> >                       rc =3D irq_set_affinity_hint(irq->vector, irq->cp=
u_mask);
> > @@ -10552,6 +10594,15 @@ static int bnxt_request_irq(struct bnxt *bp)
> >                                           irq->vector);
> >                               break;
> >                       }
> > +
> > +                     if (!pcie_tph_set_st(bp->pdev, i,
> > +                                          cpumask_first(irq->cpu_mask)=
,
> > +                                          TPH_MEM_TYPE_VM, PCI_TPH_REQ=
_TPH_ONLY)) {
> > +                             netdev_err(bp->dev, "error in setting ste=
ering tag\n");
> > +                     } else {
> > +                             irq->bp =3D bp;
> > +                             __bnxt_register_notify_irqchanges(irq);
> > +                     }
> >               }
> >       }
> >       return rc;
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index dd849e715c9b..0d3442590bb4 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -1195,6 +1195,10 @@ struct bnxt_irq {
> >       u8              have_cpumask:1;
> >       char            name[IFNAMSIZ + 2];
> >       cpumask_var_t   cpu_mask;
> > +
> > +     int             msix_nr;
> > +     struct bnxt     *bp;
> > +     struct irq_affinity_notify affinity_notify;
> >   };
> >
> >   #define HWRM_RING_ALLOC_TX  0x1
>

--0000000000005e3f16061811831b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pZEyqKnwS1lKCzjX7mV5W955rFsFxChdAKfw0HilwtqdY24mhy62+GeaEkD0gYIj1tCmw9gnQToc
K+0s7xEunfR9pBrzmOwS3OQbcP0nJ8SmQ8R+reroH6LYuFpaqK1rgQIDAQABo4IB2zCCAdcwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAlBgNVHREEHjAcgRphaml0LmtoYXBhcmRlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUbrcTuh0mr2qP
xYdtyDgFeRIiE/gwDQYJKoZIhvcNAQELBQADggEBALrc1TljKrDhXicOaZlzIQyqOEkKAZ324i8X
OwzA0n2EcPGmMZvgARurvanSLD3mLeeuyq1feCcjfGM1CJFh4+EY7EkbFbpVPOIdstSBhbnAJnOl
aC/q0wTndKoC/xXBhXOZB8YL/Zq4ZclQLMUO6xi/fFRyHviI5/IrosdrpniXFJ9ukJoOXtvdrEF+
KlMYg/Deg9xo3wddCqQIsztHSkR4XaANdn+dbLRQpctZ13BY1lim4uz5bYn3M0IxyZWkQ1JuPHCK
aRJv0SfR88PoI4RB7NCEHqFwARTj1KvFPQi8pK/YISFydZYbZrxQdyWDidqm4wSuJfpE6i0cWvCd
u50xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwM2Vrj
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOOsd5ecXZGoMm5/mYqH
uqLJk5/9Q1OmDcsOG+V24ZfaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI0MDUxMDAzNTU1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAYiGjAD5c1e+7x42AFctCDxizucdgHfQKDYJP6
n2Qc7n0uIR6OwVBot2J5sn6eKHUN/LjeK54NObsDMLxd91ubqczeDKUiByZwkDJSJVkMN66bTd+b
Rgd9AWGkKF0jHvjpfP7ISj6F4ajq7oNWHvasS9rt8EBUzd+A5LqSmCk88mVNmNIhagm/0YDdZik6
tixK+Jx621Jit8ZBHT7b63fcuvTzzeAb+A48LIzQqZl9iZL1q62ro1jYSr3UoW9CCA2AdPMuX5My
cQiB6U2QSpx7MhG0ZT5hl1gODladeo7sOi+9BRNhLFllWv+Fa6oonlAMNPmLWMuvyv99zydb4fXT
--0000000000005e3f16061811831b--

