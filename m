Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C273E5D0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjFZQvn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFZQvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 12:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D2E53;
        Mon, 26 Jun 2023 09:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7924460EA5;
        Mon, 26 Jun 2023 16:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D619DC433BA;
        Mon, 26 Jun 2023 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687798299;
        bh=qIUv4Fe+3WugCwIM1o3REC8yj3q1DXIElw4pe0hsbUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bbq3fEukXVqtCwxMNaTsFsz6mjT6vkG/i5TkDXhYxOSB7H0CKtw3CygtSjvCM+/Zl
         m2sB6Zj7vROASggyXPb6g1zznnRyyq/1V9ml3TdJ5Ynle493UbdxbqXgjBpouwmreb
         BacmKDMgIfWV96IjNN5v4Tp4tj8wnyFTbBFUKWAkNcYBvzsFMY1MYbIuP6Xb3ZRzr4
         0157gTulF63YNzWY/Ztqj/VKdzLPnrMZHBrqN+jgWj3NT76SaMj6+PB7ewUrmWq2Ms
         vd9jxbVqmBwqh2pBtTZSvF6JCKMZvykQrb7n1W+54/fzfK+ab0/TD3kd2MpwRvM9Te
         HMtbzZxc78lkw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b69a48368fso27071731fa.0;
        Mon, 26 Jun 2023 09:51:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDyqwdfwJgdsZ8HXDwB8V6AetKjYWvCtsPugIIMseFrA/a36KDPl
        T+Nv5XmWMo/ZRiNB9Q8esIPCZAgHSwboo95uIQ==
X-Google-Smtp-Source: ACHHUZ6lj2aMlI2b0GlWuJAeCaXXp/x3AoWj41EMlST4hTYj9y8SSHwszu+D4w6NFOEutOWZC9gvpFKRQ3sk/XdWO60=
X-Received: by 2002:a2e:8443:0:b0:2b1:edfe:8171 with SMTP id
 u3-20020a2e8443000000b002b1edfe8171mr17644357ljh.36.1687798297868; Mon, 26
 Jun 2023 09:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
 <1687368849-36722-6-git-send-email-lizhi.hou@amd.com> <20230622122742.379a34d2@bootlin.com>
In-Reply-To: <20230622122742.379a34d2@bootlin.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Jun 2023 10:51:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnShsngeq+9_Y24rQSCmAJ3uqP0kKB3UoG4+2TT8MOsQ@mail.gmail.com>
Message-ID: <CAL_JsqKnShsngeq+9_Y24rQSCmAJ3uqP0kKB3UoG4+2TT8MOsQ@mail.gmail.com>
Subject: Re: [PATCH V9 5/5] of: unittest: Add pci_dt_testdrv pci driver
To:     Herve Codina <herve.codina@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 4:27=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi all,
>
> On Wed, 21 Jun 2023 10:34:09 -0700
> Lizhi Hou <lizhi.hou@amd.com> wrote:
>
> > pci_dt_testdrv is bound to QEMU PCI Test Device. It reads
> > overlay_pci_node fdt fragment and apply it to Test Device. Then it
> > calls of_platform_default_populate() to populate the platform
> > devices.
> >
> > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > ---
> >  drivers/of/unittest-data/Makefile             |   3 +-
> >  .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
> >  drivers/of/unittest.c                         | 188 ++++++++++++++++++
> >  drivers/pci/quirks.c                          |   1 +
> >  4 files changed, 213 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
>
> Did the test under QEMU with the instructions that Lizhi provided at
>   https://github.com/houlz0507/xoclv2/blob/pci-dt-0329/pci-dt-patch-0329/=
README

Instructions need to be in the tree, not living somewhere else. Don't
need the full QEMU setup, but just stating 'add "-device pci-testdev"'
somewhere. Probably in the test failure messages would be the most
helpful location.

>
> The unittest results were:
> --- 8< ---
> [    1.107378] ### dt-test ### pass of_unittest_lifecycle():3273
> [    1.110068] ### dt-test ### pass of_unittest_pci_node():3909
> [    1.110401] ### dt-test ### pass unittest_pci_probe():3840
> [    1.110618] ### dt-test ### pass of_unittest_pci_node():3914
> [    1.110759] ### dt-test ### pass of_unittest_pci_node_verify():3870
> [    1.110894] ### dt-test ### pass of_unittest_pci_node_verify():3877
> [    1.110985] ### dt-test ### pass of_unittest_pci_node_verify():3884
> [    1.111088] ### dt-test ### pass of_unittest_pci_node():3926
> [    1.111171] ### dt-test ### pass of_unittest_pci_node():3927
> [    1.112056] ### dt-test ### pass of_unittest_pci_node_verify():3870
> [    1.112201] ### dt-test ### pass of_unittest_pci_node_verify():3890
> [    1.112326] ### dt-test ### pass of_unittest_pci_node_verify():3892
> [    1.112489] ### dt-test ### pass of_unittest_check_tree_linkage():271
> --- 8< ---
>
> Based on the test provided, no failure detected.
>
> Tested-by: Herve Codina <herve.codina@bootlin.com>
>
> Further more, I dumped the dt (PCI related nodes) available on the target=
.
> If someone needs to look at it:

Thanks!

> --- 8< ---
> # cat /tmp/dt.dts
> /dts-v1/;
>
> / {
>         #address-cells =3D <0x02>;
>         #size-cells =3D <0x02>;
>         interrupt-parent =3D <0x8002>;
>         compatible =3D "linux,dummy-virt";
>         name =3D [00];
> [...]
>         pcie@10000000 {
>                 #address-cells =3D <0x03>;
>                 dma-coherent;
>                 bus-range =3D <0x00 0xff>;
>                 interrupt-map =3D <0x00 0x00 0x00 0x01 0x8002 0x00 0x00 0=
x00 0x03 0x04 0x00 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x04 0x04 0x00 0x00=
 0x00 0x03 0x8002 0x00 0x00 0x00 0x05 0x04 0x00 0x00 0x00 0x04 0x8002 0x00 =
0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x04 0x04 0x=
800 0x00 0x00 0x02 0x8002 0x00 0x00 0x00 0x05 0x04 0x800 0x00 0x00 0x03 0x8=
002 0x00 0x00 0x00 0x06 0x04 0x800 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x0=
3 0x04 0x1000 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x05 0x04 0x1000 0x00 0x=
00 0x02 0x8002 0x00 0x00 0x00 0x06 0x04 0x1000 0x00 0x00 0x03 0x8002 0x00 0=
x00 0x00 0x03 0x04 0x1000 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x04 0x04 0x=
1800 0x00 0x00 0x01 0x8002 0x00 0x00 0x00 0x06 0x04 0x1800 0x00 0x00 0x02 0=
x8002 0x00 0x00 0x00 0x03 0x04 0x1800 0x00 0x00 0x03 0x8002 0x00 0x00 0x00 =
0x04 0x04 0x1800 0x00 0x00 0x04 0x8002 0x00 0x00 0x00 0x05 0x04>;
>                 #size-cells =3D <0x02>;
>                 device_type =3D "pci";
>                 interrupt-map-mask =3D <0x1800 0x00 0x00 0x07>;
>                 compatible =3D "pci-host-ecam-generic";
>                 ranges =3D <0x1000000 0x00 0x00 0x00 0x3eff0000 0x00 0x10=
000 0x2000000 0x00 0x10000000 0x00 0x10000000 0x00 0x2eff0000 0x3000000 0x8=
0 0x00 0x80 0x00 0x80 0x00>;
>                 #interrupt-cells =3D <0x01>;
>                 reg =3D <0x40 0x10000000 0x00 0x10000000>;
>                 linux,pci-domain =3D <0x00>;
>                 msi-parent =3D <0x8003>;
>                 name =3D "pcie";
>
>                 pci@3,0 {
>                         #address-cells =3D <0x03>;
>                         #size-cells =3D <0x02>;
>                         device_type =3D "pci";
>                         compatible =3D "pci1b36,c\0pciclass,060400\0pcicl=
ass,0604";
>                         ranges =3D <0x81001800 0x00 0x1000 0x81001800 0x0=
0 0x1000 0x00 0x2000 0x82001800 0x00 0x10000000 0x82001800 0x00 0x10000000 =
0x00 0x200000 0xc3001800 0x80 0x00 0xc3001800 0x80 0x00 0x00 0x200000>;
>                         reg =3D <0x1800 0xffff6d76 0xc2b23600 0xffff6d76 =
0x3fbf63a0>;

Something looks wrong with the values here. I found this running it thru dt=
c.

<stdout>: Warning (pci_device_reg): /pcie@10000000/pci@3,0:reg: PCI
reg config space address cells 2 and 3 must be 0

Rob
