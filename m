Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F46FD41C
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 05:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjEJDTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 23:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEJDTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 23:19:04 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683BA3AB6
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 20:19:02 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4501f454581so2948335e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 09 May 2023 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1683688741; x=1686280741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7gD7+x3M2lMQt2g9rV9OyZXiOG/DE38IBsOisXuZLY=;
        b=KvWydDMnRtJdsKe4qf+mMK78hgIVcJbnCIuEGwuLWD0HDDHLUFJ6ue0n3u1wGl3Sxx
         nniF0EBWidPaRiv0P8NoqkgBX9aV/j42Ph6I/hLd3zRFrkcEqEYpi5Uet4EEO6be2DJ/
         gZlSacl5KDJ8cAVfj/Cg6wJ8sVoh2IPCKYCaM/eb2ER12Zef8HrUr2bEzgA3vCeyS3jz
         JWLIFAX3CVkPt/mA4Kwr02oXSvRpXDBSoHrPW2kjeiNPyea5QiO85jNkQXKV5w4nDjvD
         41J+I/gmQo6bLF2vQz2V6z1dvK8AvDl+AnmmZhzv9c18+ToJuWNS6cduB+zVgBBTWosk
         3iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688741; x=1686280741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7gD7+x3M2lMQt2g9rV9OyZXiOG/DE38IBsOisXuZLY=;
        b=DoRuM2/wLgOQH9ESw+avSe3B4Gz5IsW81kQE9dRgz5xf/cMdZtyF3ED89QgQ1rmmCl
         oz6rT4d/Gd4ZxzxVhqNmaMUvDmiNEmZKrh8VMyuYvcmQ0iANXUBmdeODdM7d1nmYnShE
         ERtSzt36rtXNLTkf1cBfcNIAmhxv250LXHxNyshD+cYqg1aMmH2gUuTLhW9q45QjVGAt
         RDOgHi4jLOnPj3FaPzZDmP66x2TTjyzWnRyYKiNZL9O9ZKXzXbVUdlM6GZ8SZNWKw1uk
         XO+T64yqmdQui8YXfVxjbtqgKS692deKLfWut0EJYTD3tyZ2bQDETVM4A4tBptPBFSWb
         R9ig==
X-Gm-Message-State: AC+VfDwa4XLM770qSWV/yyt332tJGb2OAXz40aGYPiKBeOwB9qItlv/R
        gBV5k5seHtAt0i1QzyQjzlYVBoNdwnJyYC+h/l3WuA==
X-Google-Smtp-Source: ACHHUZ4xa0pjOL/MRK6V5HCQcHf21QDMVpxZto7sJzmA2wwxXLLifwws8q4of4vZWLZHoQcIk1ms5Si1mq4sbgxwlfc=
X-Received: by 2002:a1f:4b83:0:b0:44f:cf0e:dbcf with SMTP id
 y125-20020a1f4b83000000b0044fcf0edbcfmr4739973vka.11.1683688741398; Tue, 09
 May 2023 20:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp> <20230427104428.862643-3-mie@igel.co.jp>
 <CACGkMEsOw08UWdNfhVd8q2-SwCt+jwMbeYwYQ+OMN+2RiHBZag@mail.gmail.com>
In-Reply-To: <CACGkMEsOw08UWdNfhVd8q2-SwCt+jwMbeYwYQ+OMN+2RiHBZag@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 10 May 2023 12:18:50 +0900
Message-ID: <CANXvt5oKCoqzp8PfA7A1aTomEG3ycWNFok0YAMp2xCFgAGBbBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] virtio_pci: add a definition of queue flag in ISR
To:     Jason Wang <jasowang@redhat.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2023=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=9C=88) 12:59 Jason Wang <jasowang@red=
hat.com>:
>
> On Thu, Apr 27, 2023 at 6:44=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wro=
te:
> >
> > Already it has beed defined a config changed flag of ISR, but not the q=
ueue
>
> Typo should be "been".
Thanks for pointing that out.
> > flag. Add a macro for it.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>
> Other than this,
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> > ---
> >  include/uapi/linux/virtio_pci.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virti=
o_pci.h
> > index f703afc7ad31..d405bea27240 100644
> > --- a/include/uapi/linux/virtio_pci.h
> > +++ b/include/uapi/linux/virtio_pci.h
> > @@ -94,6 +94,9 @@
> >
> >  #endif /* VIRTIO_PCI_NO_LEGACY */
> >
> > +/* Bits for ISR status field:only when if MSI-X is disabled */
> > +/* The bit of the ISR which indicates a queue entry update. */
> > +#define VIRTIO_PCI_ISR_QUEUE           0x1
> >  /* The bit of the ISR which indicates a device configuration change. *=
/
> >  #define VIRTIO_PCI_ISR_CONFIG          0x2
> >  /* Vector value used to disable MSI for queue */
> > --
> > 2.25.1
> >
>
