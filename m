Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0767BA3BF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjJEP6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 11:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbjJEP51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 11:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE8165A8
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696514115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8FnzjHBE5EOyFgL2R5kZRhAxL9Ra2YWa3jEQV7PDUY=;
        b=e2Z91JfY9B0JD7zvrI9KY6Hv3VRX9BM2BXxJqnEXDKauMnhHr6cdROar9SC1VEHu97S6eu
        XwXVH8WQfNA9rhXLUHGojqu+offDBZz7RFo6rJEErOk5YM7JzO0P5XYt00t+4XEKtpoOqi
        6pb1nQtajjeWlFCtwtfNNKoHy8ZdhAE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ksqDsfROPYycwIoqNoGDWA-1; Thu, 05 Oct 2023 08:54:52 -0400
X-MC-Unique: ksqDsfROPYycwIoqNoGDWA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27756e0e4d8so844284a91.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Oct 2023 05:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510491; x=1697115291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8FnzjHBE5EOyFgL2R5kZRhAxL9Ra2YWa3jEQV7PDUY=;
        b=uD8nR8qojc14bsCPOf34DMpP7VNMfjYkDUgTHOAVvfrCzEJ5Ge32xkv3WTNZxw3/cn
         yeNPBIZwh7rublRBXyn3S6AzWypuBi+/KXaP+vHEBHqZcLJk85UI9W6E4AIJBlZsKYZz
         qIczFJ88aKipcE2huM6DnFK4N2mYee+D1WhRMLK9qVEcoIHy4hcazkdeQ3OTq1Atn19z
         4jtLWd/E+260x0dodYXu3Gy7CDTd3tbKtkQahU9jnyptEbBnwDohk5Kh1OYC0wJozrBJ
         hZhg6veLH28pGKKOF5xIvN4gQ4Nmy8PymCM6mhjTnUfW6GXvLq8JeuI+LtmnaaIhcsNW
         zmdA==
X-Gm-Message-State: AOJu0YzR4khz5/KDFYNnXhXtwWBSWr2Rokhh6AzM8/b5KAuiXbIJYEKY
        Pn/beFZLmjUW8aDfNVuXdA9lmL5kj9uNAHgcUTYqvgDmX5+pY3QUPPx+eKhxa2J1hFqZCIJTS+4
        vPYTK/f6ii37FUb4fNwYHtbrS2UBa4dYB+Icln4ZQ+8978A==
X-Received: by 2002:a17:90a:4ec3:b0:274:84a2:f0d8 with SMTP id v3-20020a17090a4ec300b0027484a2f0d8mr5221954pjl.25.1696510490758;
        Thu, 05 Oct 2023 05:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcYgRZ3g9ugJyDEXZ+o2uh/VNC6urawc/m9Q8Xhjnb3KyySGrMPNhWT9qVeAunp4rh394LMoha3asVQfoH5EU=
X-Received: by 2002:a17:90a:4ec3:b0:274:84a2:f0d8 with SMTP id
 v3-20020a17090a4ec300b0027484a2f0d8mr5221937pjl.25.1696510490503; Thu, 05 Oct
 2023 05:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230925141930.GA21033@wunner.de> <20230926175530.GA418550@bhelgaas>
 <20230927051602.GX3208943@black.fi.intel.com> <CA+cBOTds9k1Q2haC_gTpsUvjP02dHOv9vSconFEAu-Fsxwf36A@mail.gmail.com>
 <20230927135346.GJ3208943@black.fi.intel.com> <CA+cBOTfCy-KOptir9yfkVz1=bfOTPQanqe9ofX-jphm7oeBEXg@mail.gmail.com>
In-Reply-To: <CA+cBOTfCy-KOptir9yfkVz1=bfOTPQanqe9ofX-jphm7oeBEXg@mail.gmail.com>
From:   Kamil Paral <kparal@redhat.com>
Date:   Thu, 5 Oct 2023 14:54:23 +0200
Message-ID: <CA+cBOTdzp+6whm=Sj5nE2=MC4a+45y0CFtk4hDGq0XgF6f0f2A@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 27, 2023 at 4:12=E2=80=AFPM Kamil Paral <kparal@redhat.com> wro=
te:
>
> On Wed, Sep 27, 2023 at 3:53=E2=80=AFPM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > If you apply the patch from here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=
=3Dpm&id=3D6786c2941fe1788035f99c98c932672138b3fbc5
> >
> > Does the problem go away with the disconnect case too (and so that you
> > have "secure" enabled)?
>
> Thanks, I'll test it, but I can't do it this week. I'll reply next week.

Hello Mika, sorry for taking me so long. The URL above gives me a "Bad
commit reference" error, but I found a patch mentioned in a different
thread, so I used that one, and I hope it's the correct one :-) It's
quoted below.

With the patch applied, I can confirm that disconnecting and
reconnecting the cable during suspend is no longer a problem. I tested
both "user" and "secure" Thunderbolt security levels. The resume is
fast in all cases, and I've found no issues. Thanks for working on it!

The patch I used:

> ---
>  drivers/pci/pci-driver.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a79c110c7e51..51ec9e7e784f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -572,7 +572,19 @@ static void pci_pm_default_resume_early(struct pci_d=
ev *pci_dev)
>
>  static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
>  {
> -     pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
> +     int ret;
> +
> +     ret =3D pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
> +     if (ret) {
> +             /*
> +              * The downstream link failed to come up, so mark the
> +              * devices below as disconnected to make sure we don't
> +              * attempt to resume them.
> +              */
> +             pci_walk_bus(pci_dev->subordinate, pci_dev_set_disconnected=
,
> +                          NULL);
> +             return;
> +     }
>
>       /*
>        * When powering on a bridge from D3cold, the whole hierarchy may b=
e
> --

