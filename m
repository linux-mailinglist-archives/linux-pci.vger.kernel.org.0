Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88D150BBC1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383428AbiDVPjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355408AbiDVPjo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 11:39:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EABB5AECC
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:36:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r83so7621799pgr.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PMbulN97CYDSXiy6rlGtEqPLYRsGNjGkTOQ1u6MbCUo=;
        b=pZ1bA39TGLaiHVrzdNsKBtrfl3A4spKvQzMHrKC8SySqOgDeEHssnwfBvZ63WwTCuj
         sXwzbWUQInfS1tzWTI/8pj6zDz9OpYxw/hpx4zwfuIUlhBnF+rmBF4rX5Dbvn+40vcxk
         MVFzhEM+T30vA5+OUrcrlIwORslFhzyIOgqvVo32hxqnjlAjFyAixPXkr5zdeYV4Thre
         vRWyCcvNQRt3TQkJNcgkjEZ9l/pYLguvowu/aYI54tCMs13OO99yMM6dYP3Y7RUAVhfv
         zuESyPTwfMZVf4SFYiH+zvlXavL8H092ojdyJzDg3QVKObm9N7nE6q1a8Okbd6Vh8kln
         1s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PMbulN97CYDSXiy6rlGtEqPLYRsGNjGkTOQ1u6MbCUo=;
        b=NU2bjk3Db8x6Vd+VLvsUE3r80UQApqT3S2Hn+kHkhVZUD6M5OTw5krEnUyd3GvStqZ
         hzMuZqkjjELzsAxGxcoVCQdsonrezBd3d4UFSrYxkkY4Cmm5h9/3D12iqHqQw371wG6B
         s6iE1I3/dchF9cdtApCzcGZ7/2JPqktDbBY7FrfdZTRUQobzfET9e+SHCFwWcMYHIfVR
         /rQYjTQxcgGtDKB3bDuhoLFoXBcGR6E2DM7Nuj/z7HGj9+m2AeL5tRsf/wwiZZdI9jDj
         sznGs5GeF8zqYiE+wCsJR/CmdNKeuj2M9n+bGm7OfUwBKPla0PbQjUSFeHYDK7zs4nSc
         3mXg==
X-Gm-Message-State: AOAM532rUpbGOWMvzDtZIAdkIj/iLZn5X/chH1easiJAJgzbGQ74ViDb
        P5OJiN1SG6QJb0Cr6Krk/Qk+HSfsmxOosLfVlMg=
X-Google-Smtp-Source: ABdhPJyFTiNc23Y4Vt8UUiXnLITNsvtgXHsJrhvgF8ZL9tZbbYlkwUXWx/0WwabzfAd/IQgSOtyk5Gu1RL2sTxxXf1o=
X-Received: by 2002:a63:c22:0:b0:39d:a9ed:ebc6 with SMTP id
 b34-20020a630c22000000b0039da9edebc6mr4402917pgl.350.1650641809922; Fri, 22
 Apr 2022 08:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220222162355.32369-1-Frank.Li@nxp.com> <fa2ab3cf-1508-bbeb-47af-8b2d47904b20@ti.com>
 <CAHrpEqT2zwWiiiTUDAu9JNPXmzP1zELF7YDERWjdOohGMFRBnA@mail.gmail.com>
 <CAHrpEqSceNNQNAzCwbfiJc2Zk9fYCo5KqKmLZqHAG-7teSqF0Q@mail.gmail.com> <0407f63c-b422-bcfa-999a-5ef31a2afedf@ti.com>
In-Reply-To: <0407f63c-b422-bcfa-999a-5ef31a2afedf@ti.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Fri, 22 Apr 2022 10:36:38 -0500
Message-ID: <CAHrpEqRsOVs-MyTu2LcAwEGtC6V=n4-xURPZdESnR1rCTzzo0g@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
        lorenzo.pieralisi@arm.com, kw@linux.com,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 10:15 AM Kishon Vijay Abraham I <kishon@ti.com> wro=
te:
>
> Hi Frank,
>
> On 21/04/22 1:52 am, Zhi Li wrote:
> > On Tue, Apr 5, 2022 at 10:35 AM Zhi Li <lznuaa@gmail.com> wrote:
> >>
> >> On Tue, Apr 5, 2022 at 5:34 AM Kishon Vijay Abraham I <kishon@ti.com> =
wrote:
> >>>
> >>> Hi Frank Li,
> >>>
> >>> On 22/02/22 9:53 pm, Frank Li wrote:
> >>>> This implement NTB function for PCIe EP to RC connections.
> >>>> The existed ntb epf need two PCI EPs and two PCI Host.
> >>>
> >>> As I had earlier mentioned in [1], IMHO ideal solution would be build=
 on virtio
> >>> layer instead of trying to build on NTB layer (which is specific to R=
C<->RC
> >>> communication).
> >>>
> >>> Are there any specific reasons for not taking that path?
> >>
> >> 1. EP side work as vHOST mode.  vHost suppose access all memory of vir=
tual io.
> >> But there are only map windows on the EP side to access RC side
> >> memory. You have to move
> >> map windows for each access.  It is quite low efficiency.
>
> I'm not sure I quite get this. EP HW has limited outbound memory to acces=
s RC
> memory irrespective of how we implement it. This is not a SW framework
> limitation AFAICS.

Almost all EP HW have limited outbound memory windows to access RC.
We face transfer efficiency problems if we stick into vhost.

> >>
> >> 2. So far as I know, virtio is still not DMA yet.  CPU access PCI
> >> can't generate longer PCI TLP,
> >> So the speed is quite slow.  NTB already has DMA support.  If you use
> >> system level DMA,
> >> no change is needed at NTB level.  If we want to use a PCI controller
> >> embedded DMA,  some small
> >> changes need if based on my other Designware PCI eDMA patches, which
> >> are under review.
>
> Adding dmaengine API to do memcopy should be simple to add in vhost/virti=
o
> interface.
> >>
> >> 3. All the major data transfer of NTB is using write.  Because TLP
> >> write needn't wait for complete,  write
> >> performance is better than reading.  On our platform,  write
> >> performance is about 10% better than  read.
> >>
> >> Frank
> >
> > Any Comments or rejection? @Kishon Vijay Abraham I
>
> I'd strongly recommend going with virtio/vhost based approach and standar=
dizing
> it IMO.

But No progress in recent years on this path.  At least, my patches make PC=
Ie EP
work as enet with minimized change.
And NTB don't conflict with virtio/vhost solution.

Frank
>
> Thanks,
> Kishon
>
> >
> > best regards
> > Frank Li
> >
> >>
> >>>
> >>> Thanks,
> >>> Kishon
> >>>
> >>> [1] -> https://lore.kernel.org/r/459745d1-9fe7-e792-3532-33ee9552bc4d=
@ti.com
> >>>>
> >>>> This just need EP to RC connections.
> >>>>
> >>>>     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> >>>>     =E2=94=82            =E2=94=82         =E2=94=82                =
                     =E2=94=82
> >>>>     =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=
=94=82                      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
> >>>>     =E2=94=82 NTB        =E2=94=82         =E2=94=82                =
      =E2=94=82 NTB          =E2=94=82
> >>>>     =E2=94=82 NetDev     =E2=94=82         =E2=94=82                =
      =E2=94=82 NetDev       =E2=94=82
> >>>>     =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=
=94=82                      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
> >>>>     =E2=94=82 NTB        =E2=94=82         =E2=94=82                =
      =E2=94=82 NTB          =E2=94=82
> >>>>     =E2=94=82 Transfer   =E2=94=82         =E2=94=82                =
      =E2=94=82 Transfer     =E2=94=82
> >>>>     =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=
=94=82                      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
> >>>>     =E2=94=82            =E2=94=82         =E2=94=82                =
      =E2=94=82              =E2=94=82
> >>>>     =E2=94=82  PCI NTB   =E2=94=82         =E2=94=82                =
      =E2=94=82              =E2=94=82
> >>>>     =E2=94=82    EPF     =E2=94=82         =E2=94=82                =
      =E2=94=82              =E2=94=82
> >>>>     =E2=94=82   Driver   =E2=94=82         =E2=94=82                =
      =E2=94=82 PCI Virtual  =E2=94=82
> >>>>     =E2=94=82            =E2=94=82         =E2=94=9C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=82 NTB D=
river   =E2=94=82
> >>>>     =E2=94=82            =E2=94=82         =E2=94=82 PCI EP NTB    =
=E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82   =
           =E2=94=82
> >>>>     =E2=94=82            =E2=94=82         =E2=94=82  FN Driver    =
=E2=94=82      =E2=94=82              =E2=94=82
> >>>>     =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=
=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4=
      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >>>>     =E2=94=82            =E2=94=82         =E2=94=82               =
=E2=94=82      =E2=94=82              =E2=94=82
> >>>>     =E2=94=82  PCI BUS   =E2=94=82 =E2=97=84=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BA =E2=94=82  PCI EP BUS   =E2=94=82      =E2=
=94=82  Virtual PCI =E2=94=82
> >>>>     =E2=94=82            =E2=94=82  PCI    =E2=94=82               =
=E2=94=82      =E2=94=82     BUS      =E2=94=82
> >>>>     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >>>>         PCI RC                        PCI EP
> >>>>
> >>>>
> >>>>
> >>>> Frank Li (4):
> >>>>   PCI: designware-ep: Allow pci_epc_set_bar() update inbound map add=
ress
> >>>>   NTB: epf: Allow more flexibility in the memory BAR map method
> >>>>   PCI: endpoint: Support NTB transfer between RC and EP
> >>>>   Documentation: PCI: Add specification for the PCI vNTB function de=
vice
> >>>>
> >>>>  Documentation/PCI/endpoint/index.rst          |    2 +
> >>>>  .../PCI/endpoint/pci-vntb-function.rst        |  126 ++
> >>>>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  167 ++
> >>>>  drivers/ntb/hw/epf/ntb_hw_epf.c               |   48 +-
> >>>>  .../pci/controller/dwc/pcie-designware-ep.c   |   10 +-
> >>>>  drivers/pci/endpoint/functions/Kconfig        |   11 +
> >>>>  drivers/pci/endpoint/functions/Makefile       |    1 +
> >>>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1424 ++++++++++++++=
+++
> >>>>  8 files changed, 1775 insertions(+), 14 deletions(-)
> >>>>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
> >>>>  create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
> >>>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c
> >>>>
