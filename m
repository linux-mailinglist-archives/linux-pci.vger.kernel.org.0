Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5544CDF00
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 22:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiCDUlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 15:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiCDUlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 15:41:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A25229C87
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646426418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wr1j0Q9GrEu/M997PaXJG90KOpK/+p0oOfneHb/0ilg=;
        b=XY51GsmaKD7u4NoarW+XNIiw5ma/y/MaEOwjWylTux4vsleJJpcJLhZgYG4rU8PeVeOL23
        MnUNX2k9oIjF67dQ+2s7DLU5WeK6LqqfuyYgsmHWDrYz1fmRZ19UcWLQgk9aK3kjpAJOoD
        3aOE6zRKTI+CSYq0/pxYzTVmvDxNl8U=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-yE8g2Q8mOYyUQphAHKc9FA-1; Fri, 04 Mar 2022 15:40:18 -0500
X-MC-Unique: yE8g2Q8mOYyUQphAHKc9FA-1
Received: by mail-ot1-f70.google.com with SMTP id w21-20020a056830061500b005adc1eb0013so6722549oti.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 12:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Wr1j0Q9GrEu/M997PaXJG90KOpK/+p0oOfneHb/0ilg=;
        b=dnCc2nGpVospSSGWcaG3SEPk2mamUjQ8AER5gyfQLTWZcrgZ7ysmK4JDA+x6xQnERD
         1x9rJ7FtOO7TxnY1KF0UM/acixdvsYmk5w5uDKCw6bVkfVpmeHliESviD5ulK2sj3Jt+
         FVbPVNNx/Qtz8womcfcpokKbEzYGZg5RKWaHzBtbuV0hgdndyZak2cTDPJo5uOTOWxm4
         HY+dvtN9r0h7aKwPiKgjZKOp6REbOKo47Gc0bH3jKjbOZgNc/SZVV980yvRZgLiimdEJ
         FhKeBofE58cSdXKpSfPGXL1kwwQjW5kM4WBEgSzM01cHzkMlAbhegR9vpnxigUwg+hl4
         3Ekg==
X-Gm-Message-State: AOAM532nJlSIUMVopkmYn7+r25oOzud3HkOtqDn1z1oBj9Fcy0z6y0rW
        ZSviktBWTZqfDgHI2YguxX18FjeE1GjtdJwatGF4a/o8kH4PZqAtzvwHbqZcRtdy755kDAonwcR
        hcDHhIvHyzq9XqU1FzSMV
X-Received: by 2002:a9d:2a:0:b0:5af:7c41:60e5 with SMTP id 39-20020a9d002a000000b005af7c4160e5mr219197ota.263.1646426416042;
        Fri, 04 Mar 2022 12:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybtTT/cPPYByvp1wxcuk0IX2gHFMWqWtsv+GxS/bDKSvfwUQjODSvmnJ0jx7kprIQUvq7aWQ==
X-Received: by 2002:a9d:2a:0:b0:5af:7c41:60e5 with SMTP id 39-20020a9d002a000000b005af7c4160e5mr219191ota.263.1646426415832;
        Fri, 04 Mar 2022 12:40:15 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e23-20020a056808111700b002d98a3c1e56sm2461814oih.16.2022.03.04.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:40:15 -0800 (PST)
Date:   Fri, 4 Mar 2022 13:40:14 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        liulongfang <liulongfang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v8 8/9] hisi_acc_vfio_pci: Add support for VFIO live
 migration
Message-ID: <20220304134014.32ba4360.alex.williamson@redhat.com>
In-Reply-To: <7a1802e00d1a4741bbf9978b960bfa06@huawei.com>
References: <20220303230131.2103-1-shameerali.kolothum.thodi@huawei.com>
        <20220303230131.2103-9-shameerali.kolothum.thodi@huawei.com>
        <0dc03eab33b74e6ea95f2ac0eb39cc83@huawei.com>
        <20220304124410.02423606.alex.williamson@redhat.com>
        <7a1802e00d1a4741bbf9978b960bfa06@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 4 Mar 2022 20:36:24 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: 04 March 2022 19:44
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org; linux-pci@vger.kernel.org; jgg@nvidia.com;
> > cohuck@redhat.com; mgurtovoy@nvidia.com; yishaih@nvidia.com;
> > liulongfang <liulongfang@huawei.com>; Zengtao (B)
> > <prime.zeng@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>
> > Subject: Re: [PATCH v8 8/9] hisi_acc_vfio_pci: Add support for VFIO live
> > migration
> > 
> > On Fri, 4 Mar 2022 08:48:27 +0000
> > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > wrote:
> >   
> > > Hi Alex,
> > >  
> > > > -----Original Message-----
> > > > From: Shameerali Kolothum Thodi
> > > > Sent: 03 March 2022 23:02
> > > > To: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > linux-crypto@vger.kernel.org
> > > > Cc: linux-pci@vger.kernel.org; alex.williamson@redhat.com;  
> > jgg@nvidia.com;  
> > > > cohuck@redhat.com; mgurtovoy@nvidia.com; yishaih@nvidia.com;  
> > Linuxarm  
> > > > <linuxarm@huawei.com>; liulongfang <liulongfang@huawei.com>;  
> > Zengtao (B)  
> > > > <prime.zeng@hisilicon.com>; Jonathan Cameron
> > > > <jonathan.cameron@huawei.com>; Wangzhou (B)  
> > <wangzhou1@hisilicon.com>  
> > > > Subject: [PATCH v8 8/9] hisi_acc_vfio_pci: Add support for VFIO live  
> > migration  
> > > >
> > > > From: Longfang Liu <liulongfang@huawei.com>
> > > >
> > > > VMs assigned with HiSilicon ACC VF devices can now perform live  
> > migration if  
> > > > the VF devices are bind to the hisi_acc_vfio_pci driver.
> > > >
> > > > Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> > > > Signed-off-by: Shameer Kolothum  
> > <shameerali.kolothum.thodi@huawei.com>  
> > >
> > > [...]  
> > > > +
> > > > +static int vf_qm_check_match(struct hisi_acc_vf_core_device  
> > *hisi_acc_vdev,  
> > > > +			     struct hisi_acc_vf_migration_file *migf) {
> > > > +	struct acc_vf_data *vf_data = &migf->vf_data;
> > > > +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> > > > +	struct hisi_qm *pf_qm = &hisi_acc_vdev->vf_qm;  
> > >
> > > Oops, the above has to be,
> > >   struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
> > >
> > > This was actually fixed in v6, but now that I rebased mainly to v5, missed it.
> > > Please let me know if you want a re-spin with the above fix(in case there are  
> > no further  
> > > comments) or this is something you can take care.  
> > 
> > To confirm, you're looking for this change:
> > 
> > diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > index aa2e4b6bf598..f2a0c046413f 100644
> > --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> > @@ -413,7 +413,7 @@ static int vf_qm_check_match(struct
> > hisi_acc_vf_core_device *hisi_acc_vdev,
> >  {
> >  	struct acc_vf_data *vf_data = &migf->vf_data;
> >  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> > -	struct hisi_qm *pf_qm = &hisi_acc_vdev->vf_qm;
> > +	struct hisi_qm *pf_qm = &hisi_acc_vdev->pf_qm;
> >  	struct device *dev = &vf_qm->pdev->dev;
> >  	u32 que_iso_state;
> >  	int ret;
> > 
> > Right?   
> 
> Not really. pf_qm is a pointer. This is the change,
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index 53e4c5cb3a71..54813772a071 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -413,7 +413,7 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  {
>  	struct acc_vf_data *vf_data = &migf->vf_data;
>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> -	struct hisi_qm *pf_qm = &hisi_acc_vdev->vf_qm;
> +	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
>  	struct device *dev = &vf_qm->pdev->dev;
>  	u32 que_iso_state;
>  	int ret;
> 

Got it.  Thanks,

Alex

