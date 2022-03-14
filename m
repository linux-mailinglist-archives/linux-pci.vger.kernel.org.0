Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC04D8B0A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 18:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiCNRrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 13:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiCNRrd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 13:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00141DEDC
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647279982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEJG0IObRkUr69r2f7J23FXjPgRCTJSeRdoCwh8LUrA=;
        b=aX8Gca1od9CKrcMZCSEIq1dtSzhKK6daGwLaZHND6vNN5BzcXY9N1nBT8JjXK9xD7UfPDo
        97hpsJa+HqY31JEWLGflMaiLYXSX+KMQOZTETB+xv+EiBFYVQYhbM6qMOH7k9YrmRw9cgb
        2Gdki35/Dytcn33dHjJiod4lUfJp0Yk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-NjDQFxn_NCaF4gWmWejG9g-1; Mon, 14 Mar 2022 13:46:06 -0400
X-MC-Unique: NjDQFxn_NCaF4gWmWejG9g-1
Received: by mail-il1-f198.google.com with SMTP id r16-20020a92ac10000000b002c1ec9fa8edso9699885ilh.23
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 10:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEJG0IObRkUr69r2f7J23FXjPgRCTJSeRdoCwh8LUrA=;
        b=aAVzYCG12QkBKqIGDKkYn7d4LzOW642Yj0D0dtpURF8+KUxkG/agF/5QdTwqk0z7o9
         ACmMwO7JK3/FbjDfHu3oFdNLfm+BJ61X8WRfvntdNbYVPtc9kzYs/E+zktxJiL2bzexU
         fRiQbD7yKkvD2sDdWpQHvGla/yS5TJScCqTmtPjEfekZE1BDqnPYyOiQCgFEKnfNFX8b
         Oam9l4sKaeYW51SxuxYp4UYSCY5R84uJNKvj2tAEMmEPhYsedcb/6lQZzd3Sn3j8+qYL
         p7yOvrinIMcCc1mmRLleOVFxk+y8wS63Wk7r4lPOxeOHXO7WhSAGIM6cSOgTboiCtzOe
         I4DA==
X-Gm-Message-State: AOAM530olFYkVq5Hzu+jUNd5D8PYXcQTuZL70Kt0SnJLGRt93h12WGUq
        0dPlurAq+t4fPT5JJTLhfKVgfyOmYrCIZYl4bB01L35/M9Xgd2hVr+fQL/wAkAp8oxLd+a0pJuy
        iPHdP8X8YxtcT9QElXni9
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr20675134iov.161.1647279961385;
        Mon, 14 Mar 2022 10:46:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZJJA4WojvmGdmtZ74f1wNxVgekXaAUaGHvuviIsQF6/0w1VCSMfKnNrXxBYkfIXxrO2Rn+w==
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr20675084iov.161.1647279960174;
        Mon, 14 Mar 2022 10:46:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b2-20020a923402000000b002c25b16552fsm9227068ila.14.2022.03.14.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 10:45:59 -0700 (PDT)
Date:   Mon, 14 Mar 2022 11:45:58 -0600
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
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        liulongfang <liulongfang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 0/9] vfio/hisilicon: add ACC live migration driver
Message-ID: <20220314114558.2cdd57fc.alex.williamson@redhat.com>
In-Reply-To: <df217839a41b47dc94ef201dfe379e4e@huawei.com>
References: <20220308184902.2242-1-shameerali.kolothum.thodi@huawei.com>
        <df217839a41b47dc94ef201dfe379e4e@huawei.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 14 Mar 2022 17:26:59 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Alex,
>=20
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: 08 March 2022 18:49
> > To: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-crypto@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org; alex.williamson@redhat.com; jgg@nvidia.c=
om;
> > cohuck@redhat.com; mgurtovoy@nvidia.com; yishaih@nvidia.com;
> > kevin.tian@intel.com; Linuxarm <linuxarm@huawei.com>; liulongfang
> > <liulongfang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>; Wangzhou (B)
> > <wangzhou1@hisilicon.com>
> > Subject: [PATCH v9 0/9] vfio/hisilicon: add ACC live migration driver
> >=20
> > Hi,
> >=20
> > This series attempts to add vfio live migration support for HiSilicon
> > ACC VF devices based on the new v2 migration protocol definition and
> > mlx5 v9 series discussed here[0].
> >=20
> > v8 --> v9
> > =C2=A0- Added acks by Wangzhou/Longfang/Yekai
> > =C2=A0- Added R-by tags by Jason.
> > =C2=A0- Addressed comments=C2=A0by Alex on v8.
> > =C2=A0- Fixed the pf_queue pointer assignment error in patch #8.
> > =C2=A0- Addressed=C2=A0comments from Kevin,
> >  =C2=A0 =C2=A0-Updated patch #5 commit log msg with a clarification tha=
t VF
> > =C2=A0 =C2=A0 =C2=A0migration BAR assignment is fine if migration suppo=
rt is not there.
> >  =C2=A0 =C2=A0-Added QM description to patch #8 commit msg. =20
>=20
> Hope there is nothing pending for this series now to make it to next.
> I know ack from Bjorn is still pending for patch #3, and I have
> sent a ping last week and also CCd him on that patch.
>=20
> Please let me know if there is anything I missed.=20

Hi Shameer,

Nothing still pending from my end, as soon as we can get an ack on
patch #3 and barring issues in the interim, I'll merge it.  Thanks,

Alex

