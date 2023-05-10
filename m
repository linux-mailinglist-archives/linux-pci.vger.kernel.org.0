Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42466FD495
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjEJDtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 23:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjEJDtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 23:49:46 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B92106
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 20:49:45 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43479152cd0so1827784137.1
        for <linux-pci@vger.kernel.org>; Tue, 09 May 2023 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1683690584; x=1686282584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI3dcKXw4MhS4ti0/DI9c0u69YLYabnxg/e6vkj4TDk=;
        b=3eLCbR86w+2RQbTKOZka2AFvBx7g3Zj+idJSXkQMLalMFcGXeUz+XfvSjS5T3uv4tC
         ipbYKnmAnxFqtIVoYb9RRc5rWc8sSZhMBetTu/C84ZGz+xO5n46P7DxYAjCWVKh/bbB6
         zQ7X8BJpXXEa5XKfssyss21KSZ2HVUbaWfYmpNAR+B9M1rfFQrCE33GyKnSywu0Srhcy
         wlA6oN61GpbDDJunhNaEKhWlN2tYP9Cvy7flCv1W+OC1dPkdup2MESB1tUqfcZBxCqdI
         AwXrCWE2QhMWEc+DDu0ix4QKDbYBsc/wFjMoh7T7VtmDSWtwZi63QsOKmJzpVGp9lmaD
         x4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683690584; x=1686282584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI3dcKXw4MhS4ti0/DI9c0u69YLYabnxg/e6vkj4TDk=;
        b=LllnBIgDPfK2gHTP3gMZO2DqsD0lg++8XyFyh9VqlmjfEgeKcv3sBGK5GgdjIUalZx
         GWTvw33RhTOGfPwQSlmKgjhjtx9UDHHZZ3nCm08MKNsRoL/d4kfXCecKlogW1y+VzLvO
         2crgrUgbpv9WAOwpbzDCAa1fifZCcuuVJlStwNOSaNg15x1Y0MJasnBoQLorB2WBCV5m
         rxBQJaXY2Qhml1L6vS07KqoUyc6bFubBV51JUbe+Z3gfTij4HP4uqGqlnSC/cQMxuc3N
         YMwBc9EBvyeDFfOf/57lybPYsPUUpqk1/tJ8hH4Sp7KAYKUckfM/+rrgkmDFBVtFPBHZ
         qfew==
X-Gm-Message-State: AC+VfDzLqb0hnG5kRexWSlsHI2PR6legpcCuYoY3bQ4Lm7XmkYA82Fpi
        n0nH1HnKgTHllH66cecT66k7FxEVfwB18nq4oRmD5bn71aY5bcTiIPg=
X-Google-Smtp-Source: ACHHUZ5W4HIi6OHBDK+zBBO2lQH7G6noO4SUmFIUN+gOf8a5U8CeUgGQGiYpYu38azJw/nTo5dfKqporeqDX0nEv7wI=
X-Received: by 2002:a67:f9c2:0:b0:435:5255:a1fd with SMTP id
 c2-20020a67f9c2000000b004355255a1fdmr3666179vsq.3.1683690584107; Tue, 09 May
 2023 20:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-2-mie@igel.co.jp> <20230427182812.GA262399@bhelgaas>
In-Reply-To: <20230427182812.GA262399@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 10 May 2023 12:49:33 +0900
Message-ID: <CANXvt5oYq3CL9gPFZevAx30_Q=Ad1rsG2oCp7p9aNhNZaHvN+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: endpoint: introduce a helper to implement
 pci ep virtio function
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Ren Zhijie <renzhijie2@huawei.com>,
        Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'll fix the typo and some styles you mentioned.
In this e-mail, I reply to the other comments.
2023=E5=B9=B44=E6=9C=8828=E6=97=A5(=E9=87=91) 3:28 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> Simple typos, don't repost until there's more substantive feedback.
>
> On Thu, Apr 27, 2023 at 07:44:26PM +0900, Shunsuke Mie wrote:
> > The Linux PCIe Endpoint framework supports to implement PCIe endpoint
> > functions using a PCIe controller operating in endpoint mode.
> > It is possble to realize the behavior of PCIe device, such as virtio PC=
I
> > device. This patch introduces a setof helper functions and data structu=
res
> > to implement a PCIe endpoint function that behaves as a virtio device.
>
> s/possble/possible/
> s/setof/set of/
>
> > Those functions enable the implementation PCIe endpoint function that
> > comply with the virtio lecacy specification. Because modern virtio
> > specifications require devices to implement custom PCIe capabilities, w=
hich
> > are not currently supported by either PCIe controllers/drivers or the P=
CIe
> > endpoint framework.
>
> s/implementation PCIe endpoint function/implementation of PCIe endpoint f=
unctions/
> s/lecacy/legacy/ (What does "legacy" mean?  Is there a spec for this?)
Yes, it is defined in spec.
> I guess "legacy virtio" devices need not implement custom PCIe
> capabilities, but "modern virtio" devices must implement them?
That I wanted to explain here.
> Capitalize "Endpoint framework" consistently; sometimes it's
> "Endpoint", other times it's "endpoint".
I'll take care to be consistent.
> > While this patch provides functions for negotiating with host drivers a=
nd
> > copying data, each PCIe function driver must impl ement operations that
> > depend on each specific device, such as network, block, etc.
>
> s/impl ement/implement/
>
> > +#include <linux/virtio_pci.h>
> > +#include <linux/virtio_config.h>
> > +#include <linux/kthread.h>
>
> Typically the header includes would be alphabetized if possible.
I'll try to reorder them.
> > +     vq_virt =3D pci_epc_map_addr(epf->epc, epf->func_no, epf->vfunc_n=
o,
> > +                                vq_pci_addr, vq_phys, vq_size);
> > +     if (IS_ERR(vq_virt)) {
> > +             pr_err("Failed to map virtuqueue to local");
>
> s/virtuqueue/virtqueue/
>
> I know you probably don't have any way to use dev_err(), but this
> message really needs some context, like a driver name and instance or
> something.
I'll try to use the dev_* function appropriately If possible.
> > +#define VIRTIO_PCI_LEGACY_CFG_BAR 0
>
> What makes this a "legacy cfg BAR"?  Is there some spec that covers
> virtio BAR usage?
Yes. Virtio Legacy interface defines the PCI BAR number to use.
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html=
#x1-14500010

> > + * epf_virtio_init - initialize struct epf_virtio and setup BAR for vi=
rtio
> > + * @evio: struct epf_virtio to initialize.
> > + * @hdr: pci configuration space to show remote host.
> > + * @bar_size: pci BAR size it depends on the virtio device type.
>
> s/pci/PCI/ (there were also a few more instances above in messages or
> comments)
>
> > + * epf_virtio_final - finalize struct epf_virtio. it frees bar and mem=
ories
> > + * @evio: struct epf_virtio to finalize.
>
> s/bar/BAR/
>
> > +static void epf_virtio_monitor_qnotify(struct epf_virtio *evio)
> > +{
> > +     const u16 qn_default =3D evio->nvq;
> > +     u16 tmp;
> > +
> > +     /* Since there is no way to synchronize between the host and EP f=
unctions,
> > +      * it is possible to miss multiple notifications.
>
> Multi-line comment style.
>
> > +     err =3D epf_virtio_negotiate_vq(evio);
> > +     if (err < 0) {
> > +             pr_err("failed to negoticate configs with driver\n");
>
> s/negoticate/negotiate/
>
> > + * epf_virtio_reset - reset virtio status
>
> Some of the function descriptions end with a period (".") and others
> don't.  Please figure out what the most common style is and use that
> consistently.
I agree. I'll fix to be consistent.
> > +                     dst =3D pci_epc_map_addr(epf->epc, epf->func_no,
> > +                                            epf->vfunc_no, dbase, &phy=
s,
> > +                                            slen);
> > +                     if (IS_ERR(dst)) {
> > +                             pr_err("failed to map pci mmoery spact to=
 local\n");
>
> s/pci/PCI/
> s/mmoery/memory/
> s/spact/space/ ?
>
> Also below.
>
> IIRC some previous messages started with a capital letter.  Please
> make them all consistent.
Sure.
> > +             if (dir =3D=3D DMA_MEM_TO_DEV) {
> > +                     pci_epc_unmap_addr(epf->epc, epf->func_no,
> > +                                        epf->vfunc_no, phys, dst, slen=
);
> > +             } else {
> > +                     pci_epc_unmap_addr(epf->epc, epf->func_no,
> > +                                        epf->vfunc_no, phys, src, slen=
);
> > +             }
> > +     }
> > +
> > +     return 1;
>
> I guess this function returns either a negative error code or the
> value 1?  That seems sort of weird (I think "negative error code or
> *zero* is more typical), but maybe you're following some convention?
It has to be 0. It is my mistake.

Some vringh functions return 0 (data does not exist), 1 (it exists),
or error. But this functions is not related.
> > +#include <linux/pci-epf.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/vringh.h>
> > +#include <linux/dmaengine.h>
>
> Alpha order if possible
Yes.
> > +     /* Virtual address of pci configuration space */
>
> s/pci/PCI/
>
> > +     /* Callback function and parameter for queue notifcation
> > +      * Note: PCI EP function cannot detect qnotify accurately, theref=
ore this
> > +      * callback function should check all of virtqueue's changes.
> > +      */
>
> Multi-line comment style.
>
> Bjorn

Best regards,
Shunsuke
