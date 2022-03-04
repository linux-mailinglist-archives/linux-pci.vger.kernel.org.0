Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EB4CDE45
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiCDUDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 15:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiCDUCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 15:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04F212BBC10
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646423674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pM1F1/T2x1AGJPbHCgjIb2A2+Vv+D8cNuQhS+x4EuMs=;
        b=RoU35dzahap1VPkPWktktHX6NYXWTjGDNDqwOMl0QPkIoro1bzWJ0LZ4MxRnDcqQmTnBZu
        fYWXH0yLfg9e/OzIMDigf9X1//1dFybLdFrz718orYRcUTE+0hw5bHyoNyOAqZxazFPoCQ
        yK3UBBD1BKUpdYzkrwqaJGtRvJlo65U=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-hkW9jkmtNBiRSiofVY2hXA-1; Fri, 04 Mar 2022 14:44:13 -0500
X-MC-Unique: hkW9jkmtNBiRSiofVY2hXA-1
Received: by mail-oo1-f69.google.com with SMTP id j18-20020a4ae852000000b003181c031d81so6406954ooj.22
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 11:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pM1F1/T2x1AGJPbHCgjIb2A2+Vv+D8cNuQhS+x4EuMs=;
        b=yKIRMxoU4thzkOnSE+0r+PNGLUsN+A5B+WXECn35CrV8POn4MsB7JE0Q5AR07juyd7
         wE6JOO/r9bXdE4gA1j2vhE/8zgfkEAVKXqeeNWr2KC9T12Ix21T2Tvm3SjR7s/dFP+nq
         PbMos1Gb2qkhmmvZPE3AVdP+njNHoCB7fg1yQ4BETiH9lVRhkn0yTMmjTHe4rjwSWzjh
         QNQJFA6vGG6zPkITCuzfAz9ln+cnY4qCGo6LUsfQ/HhdBWMLjPIsZFxf5ylvABKyY+j4
         8zYoPvSgJeLaLwGqgd2v3owrpWDugwoGd91Xr4C9e19EkL60StgWWI+PGhbdkP+j4hj3
         r2GQ==
X-Gm-Message-State: AOAM53258ipMjooTXSeZp9ZDGWDqkNc8HAQgaEQw1DifZkO/P/d7c4UK
        EFM9nFxPoxVpJyy09w/IAUpCE4IhXY8YNLgCqIirTlR2H0ZZiDZAVsZ8LHSY753JISPTIrZXzva
        TL7b5BdqV4MbZuv2/O8yV
X-Received: by 2002:a05:6870:f144:b0:da:b3f:2b88 with SMTP id l4-20020a056870f14400b000da0b3f2b88mr469559oac.295.1646423052405;
        Fri, 04 Mar 2022 11:44:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLx1Oo2HmRahYyTM2fzwk1l6MYz7YP18iY6J/yREFpr5YIXwj0jeNtz5EMM11fBL1czktGLg==
X-Received: by 2002:a05:6870:f144:b0:da:b3f:2b88 with SMTP id l4-20020a056870f14400b000da0b3f2b88mr469546oac.295.1646423052181;
        Fri, 04 Mar 2022 11:44:12 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g2-20020a9d5f82000000b005af678c9cfdsm2749709oti.41.2022.03.04.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 11:44:11 -0800 (PST)
Date:   Fri, 4 Mar 2022 12:44:10 -0700
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
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v8 8/9] hisi_acc_vfio_pci: Add support for VFIO live
 migration
Message-ID: <20220304124410.02423606.alex.williamson@redhat.com>
In-Reply-To: <0dc03eab33b74e6ea95f2ac0eb39cc83@huawei.com>
References: <20220303230131.2103-1-shameerali.kolothum.thodi@huawei.com>
        <20220303230131.2103-9-shameerali.kolothum.thodi@huawei.com>
        <0dc03eab33b74e6ea95f2ac0eb39cc83@huawei.com>
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

On Fri, 4 Mar 2022 08:48:27 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Alex,
> 
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: 03 March 2022 23:02
> > To: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org; alex.williamson@redhat.com; jgg@nvidia.com;
> > cohuck@redhat.com; mgurtovoy@nvidia.com; yishaih@nvidia.com; Linuxarm
> > <linuxarm@huawei.com>; liulongfang <liulongfang@huawei.com>; Zengtao (B)
> > <prime.zeng@hisilicon.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>
> > Subject: [PATCH v8 8/9] hisi_acc_vfio_pci: Add support for VFIO live migration
> > 
> > From: Longfang Liu <liulongfang@huawei.com>
> > 
> > VMs assigned with HiSilicon ACC VF devices can now perform live migration if
> > the VF devices are bind to the hisi_acc_vfio_pci driver.
> > 
> > Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>  
> 
> [...]
> > +
> > +static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> > +			     struct hisi_acc_vf_migration_file *migf) {
> > +	struct acc_vf_data *vf_data = &migf->vf_data;
> > +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> > +	struct hisi_qm *pf_qm = &hisi_acc_vdev->vf_qm;  
> 
> Oops, the above has to be,
>   struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
> 
> This was actually fixed in v6, but now that I rebased mainly to v5, missed it.
> Please let me know if you want a re-spin with the above fix(in case there are no further
> comments) or this is something you can take care.

To confirm, you're looking for this change:

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index aa2e4b6bf598..f2a0c046413f 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -413,7 +413,7 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 {
 	struct acc_vf_data *vf_data = &migf->vf_data;
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
-	struct hisi_qm *pf_qm = &hisi_acc_vdev->vf_qm;
+	struct hisi_qm *pf_qm = &hisi_acc_vdev->pf_qm;
 	struct device *dev = &vf_qm->pdev->dev;
 	u32 que_iso_state;
 	int ret;

Right?  I can roll that in assuming there are no further comments that
would generate a respin.  Thanks,

Alex

