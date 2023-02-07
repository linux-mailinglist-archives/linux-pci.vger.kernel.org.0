Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D468D3E8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 11:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjBGKRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 05:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjBGKR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 05:17:27 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4323138
        for <linux-pci@vger.kernel.org>; Tue,  7 Feb 2023 02:17:26 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id 9so397550vkq.9
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2023 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPrtilAJKVUhxbrBamxio2CjQmx+CrJRcxuPGVzs45k=;
        b=pssdcCwvP27quF2aTGuKZzmApPpisR2l632+QyiiP68had1rAPT5eRROk7FWjFJeMc
         uwMDwWP4rUj9cZ5XQGiLH0gYdVNev8DBDLvN4qdw6blaN2MJoI7V/e2A+Xho2jMqxPdf
         akpeQAPksniPJOz59KARWsf0U92ZvolJ44lrRt1/taSFAnlqNgyiAQhk7J2d2/a4fwTj
         B4teXgtKIZjLSGwjeEuHWJZTzgxjiZfGi1v1elusTIGFRZnRXGLplEkIYR7J5ALqll8d
         zXe5kS88lmBHMR3AK58Q3l1IRHFghxIHavMnNoP8+T/yyVzLbvAq3uLqISme4aFMwfas
         KwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPrtilAJKVUhxbrBamxio2CjQmx+CrJRcxuPGVzs45k=;
        b=nRCUpGKAE7HcRLcwIU0lpBFQ7Wjl63P1JbPBPzxg4bkQhhn5l8WH4zHb8IdCMGB/om
         sZrfL5x97cGnMkVCDBr7ZOzWfY5TDladZUKH3m5gXceyV1XvjICQ+a0XhOTyH9p4EIWY
         xD4i34WnA33zRFM0Z55JzW38pX0vpkuNVEYHz0VwErTMtlsmgjCIu3oucsfiH6NapjjB
         nWX682WIvN8P+y+bgNTpR7SEq5yg4nJlQjePAcRUlSUm/Sdm0rGkv8+Ow4oJuBZIKcxy
         evbmwuOzKKZzbUo7c9rWMUqDGcsboSmeHxgGhfKSe55Rsh5AWBDyK6wZ3HEWEDastjtA
         iLYg==
X-Gm-Message-State: AO0yUKVWswCXazR1RfFrbykMtgilRYRYwwTIhYFXrCK+dgcKw+P+L+H7
        s1fWcySdB8/aSxWiyHhlyKZjYBNYQKcoLAMmQNxXEw==
X-Google-Smtp-Source: AK7set+9OKX9NitD6L8UNyZEvBjr/8igyirMEC8nb/njn0S4M5nhl04teC5aADC0Ic8fO43SlijMven9RIQ74gvPu1A=
X-Received: by 2002:a05:6122:5ab:b0:3ea:135:e0bd with SMTP id
 w11-20020a05612205ab00b003ea0135e0bdmr350219vko.21.1675765045579; Tue, 07 Feb
 2023 02:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <20230205050122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230205050122-mutt-send-email-mst@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 19:17:14 +0900
Message-ID: <CANXvt5q_qgLuAfF7dxxrqUirT_Ld4B=POCq8JcB9uPRvCGDiKg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2023=E5=B9=B42=E6=9C=885=E6=97=A5(=E6=97=A5) 19:02 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Fri, Feb 03, 2023 at 07:04:14PM +0900, Shunsuke Mie wrote:
> > This patchset introduce a virtio-net EP device function. It provides a
> > new option to communiate between PCIe host and endpoint over IP.
> > Advantage of this option is that the driver fully uses a PCIe embedded =
DMA.
> > It is used to transport data between virtio ring directly each other. I=
t
> > can be expected to better throughput.
> >
> > To realize the function, this patchset has few changes and introduces a
> > new APIs to PCI EP framework related to virtio. Furthermore, it device
> > depends on the some patchtes that is discussing. Those depended patchse=
t
> > are following:
> > - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
> > link: https://lore.kernel.org/dmaengine/20221223022608.550697-1-mie@ige=
l.co.jp/
> > - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> > link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@ig=
el.co.jp/
> > - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> > link: https://lore.kernel.org/virtualization/20230202090934.549556-1-mi=
e@igel.co.jp/
> >
> > About this patchset has 4 patches. The first of two patch is little cha=
nges
> > to virtio. The third patch add APIs to easily access virtio data struct=
ure
> > on PCIe Host side memory. The last one introduce a virtio-net EP device
> > function. Details are in commit respectively.
> >
> > Currently those network devices are testd using ping only. I'll add a
> > result of performance evaluation using iperf and etc to the future vers=
ion
> > of this patchset.
>
>
> All this feels like it'd need a virtio spec extension but I'm not 100%
> sure without spending much more time understanding this.
> what do you say?
This patch shows the virtio-net device as pcie device. Could you tell
me what part
of the spec are you concerned about?

> > Shunsuke Mie (4):
> >   virtio_pci: add a definition of queue flag in ISR
> >   virtio_ring: remove const from vring getter
> >   PCI: endpoint: Introduce virtio library for EP functions
> >   PCI: endpoint: function: Add EP function driver to provide virtio net
> >     device
> >
> >  drivers/pci/endpoint/Kconfig                  |   7 +
> >  drivers/pci/endpoint/Makefile                 |   1 +
> >  drivers/pci/endpoint/functions/Kconfig        |  12 +
> >  drivers/pci/endpoint/functions/Makefile       |   1 +
> >  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
> >  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
> >  drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
> >  drivers/virtio/virtio_ring.c                  |   2 +-
> >  include/linux/pci-epf-virtio.h                |  25 +
> >  include/linux/virtio.h                        |   2 +-
> >  include/uapi/linux/virtio_pci.h               |   2 +
> >  13 files changed, 1590 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
> >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
> >  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
> >  create mode 100644 include/linux/pci-epf-virtio.h
> >
> > --
> > 2.25.1
>

Best,
Shunsuke
