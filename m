Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4FD4D0735
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 20:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiCGTGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 14:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiCGTGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 14:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83FC46E56C
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646679918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFEWa/6PSx4goDhoAD+s+E7K76HqDwXbpSO9oJJ8Gys=;
        b=Vw8c5kuOYTCtjjvQC+3n2ckPQcXqnbsF+Eu2J6z7FLaJwurR9iu/MnaJ/pUS7xivDMN9dr
        l6cB7MKZvbcGD+204YPCzprmhSjwbh6kI1ZYBjQi4JEvkR9Zfuzc+VzqurlpL7f+o93tEr
        ML5dBGEdtZt/f8u3cfr+QxCYuQv1B1A=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-WG2OKVfCNz62G_DPpbo3BQ-1; Mon, 07 Mar 2022 14:05:17 -0500
X-MC-Unique: WG2OKVfCNz62G_DPpbo3BQ-1
Received: by mail-oo1-f71.google.com with SMTP id 7-20020a4a0007000000b0031d5b7742c6so12183218ooh.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Mar 2022 11:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFEWa/6PSx4goDhoAD+s+E7K76HqDwXbpSO9oJJ8Gys=;
        b=pU5c9ynKT3CtKQVBWXfyCuiGjlntf0TLJDS75qdqYuxVA9qmpFXRJQ0hTQBidgvl+u
         Z1E6r0WyKdbBVn390kInDCz0cRE4+QVNR3L5wFqDDkz4bJosdjjvw4jJnTovBHONNCSQ
         wUPtZUEWx5b1QntVeXMY9F+6nC4vncEv2EoU790y+/WMgUoNr3A41iP3vMSTeJq8yxuw
         YdtCjrnf51dSTXYN4kDJktn4vL8H2BZTJcdB50LpGUodW5kkfS2T6IO26yjTXZ9MOxjC
         d3DdQjeW/saLDYik5iv/2zJi6++31dAJFd+jKoEYRPY+Xhrd/HDdTjUS/uopNpPh4EZW
         YD4Q==
X-Gm-Message-State: AOAM531R5zaICL4OiFtR0A8gZmDxKpNuEbtja/GEuuRkASiC827d8Ysv
        9DurWMNaefbDwOxSdp8zdeeq+85ixyG6/QaSs0fJDa9iRYzQdsJaZcjkxjjEPf/qb5wN9EKNY7S
        8GC/h6rwq6z3eBz1oxu+E
X-Received: by 2002:a4a:b186:0:b0:320:6fed:ff00 with SMTP id c6-20020a4ab186000000b003206fedff00mr5367545ooo.37.1646679916761;
        Mon, 07 Mar 2022 11:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCZC9SZR/CfAe0ChYOs3ipoBLwx7pGJ4MxpIqADLw3KrjmiUbv10w8kPX5WmDjXpA1nz8uDQ==
X-Received: by 2002:a4a:b186:0:b0:320:6fed:ff00 with SMTP id c6-20020a4ab186000000b003206fedff00mr5367525ooo.37.1646679916525;
        Mon, 07 Mar 2022 11:05:16 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 68-20020a9d0a4a000000b005ad3287033csm6707612otg.44.2022.03.07.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:05:16 -0800 (PST)
Date:   Mon, 7 Mar 2022 12:05:13 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
        cohuck@redhat.com, mgurtovoy@nvidia.com, yishaih@nvidia.com,
        linuxarm@huawei.com, liulongfang@huawei.com,
        prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v8 8/9] hisi_acc_vfio_pci: Add support for VFIO live
 migration
Message-ID: <20220307120513.74743f17.alex.williamson@redhat.com>
In-Reply-To: <20220304205720.GE219866@nvidia.com>
References: <20220303230131.2103-1-shameerali.kolothum.thodi@huawei.com>
        <20220303230131.2103-9-shameerali.kolothum.thodi@huawei.com>
        <20220304205720.GE219866@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Mar 2022 16:57:20 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 03, 2022 at 11:01:30PM +0000, Shameer Kolothum wrote:
> > From: Longfang Liu <liulongfang@huawei.com>
> >=20
> > VMs assigned with HiSilicon ACC VF devices can now perform live migrati=
on
> > if the VF devices are bind to the hisi_acc_vfio_pci driver.
> >=20
> > Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/vfio/pci/hisilicon/Kconfig            |    7 +
> >  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 1078 ++++++++++++++++-
> >  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  114 ++
> >  3 files changed, 1181 insertions(+), 18 deletions(-)
> >  create mode 100644 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> >=20
> > diff --git a/drivers/vfio/pci/hisilicon/Kconfig b/drivers/vfio/pci/hisi=
licon/Kconfig
> > index dc723bad05c2..2a68d39f339f 100644
> > --- a/drivers/vfio/pci/hisilicon/Kconfig
> > +++ b/drivers/vfio/pci/hisilicon/Kconfig
> > @@ -3,6 +3,13 @@ config HISI_ACC_VFIO_PCI
> >  	tristate "VFIO PCI support for HiSilicon ACC devices"
> >  	depends on ARM64 || (COMPILE_TEST && 64BIT)
> >  	depends on VFIO_PCI_CORE
> > +	depends on PCI && PCI_MSI =20
>=20
> PCI is already in the depends from the 2nd line in
> drivers/vfio/pci/Kconfig, but it is harmless
>=20
> > +	depends on UACCE || UACCE=3Dn
> > +	depends on ACPI =20
>=20
> Scratching my head a bit on why we have these

Same curiosity from me, each of the CRYPTO_DEV_HISI_* options selected
also depend on these so they seem redundant.

I think we still require acks from Bjorn and Zaibo for select patches
in this series.

=46rom me, I would request a MAINTAINERS entry similar to the one the
mlx5 folks added for their driver.  This should be in patch 4/9 where
the driver is originally added.  Thanks,

Alex

