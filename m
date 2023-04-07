Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBB46DAF69
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbjDGPHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbjDGPHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 11:07:31 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B09CC10;
        Fri,  7 Apr 2023 08:06:35 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id n6-20020a4abd06000000b0053b59893660so6643125oop.0;
        Fri, 07 Apr 2023 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680879978; x=1683471978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIrhmcIO3ShBrxPOokKqqO9vW72VgVDZYa/LDSCO/yE=;
        b=BEPkqHQLR4fGInU/bLiO6aYsrzf8I7yOKRZdQYkzNEW2xl2GmuwFiyrsBDrdw8DV1d
         B+rDC2Vv4tYnJ6DcHVvWJXKWCwGy+ETOiSnczMGpdjBBEGs3nXcMxHSh/MBYY1hlMrNR
         lam9L9y+vUNPwgvFc4lmCfOo62Oz5NjypNdmqBMZ/u2Rizhv0EBe2AC2fX7tn344s12R
         h1QsvdzoGvlKUQ6QdtCIDhn7je3qKPVHh1r9qjHg5r/VXwv/aYybL029S4RBBFQ+xIFC
         gEyHWmgWLEk7tebT+bz1F3OkX+dpR0mW1pDGLU7rdRTjkcW4RKN7fQnY9NJ30GbXi8SM
         hhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879978; x=1683471978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIrhmcIO3ShBrxPOokKqqO9vW72VgVDZYa/LDSCO/yE=;
        b=AsRm5Pn+dd3G/HEHIksdvunTvEYSwf9bSSctwaKcWgeLVMzDmdkiUNxpe+2bSvXBfs
         bR4ILSP/SpnmGMlXETRR7njgbTq53Nz/oDPt2sFTlHJRY1C6TsS+ba1Uz4cbUI44Jw/C
         x9yWpwYjcswb2mc+JUTtl9nejYOc//qZwZo6w6XJ4zL82O7NBMFre1ladQWd2Lz4R6uq
         +1IveYId+olwVUJjc8Z0zEe4FfrCAVSk9zhPds5fWpooYcvdOAd9dvdnRxcRbz7KLuh7
         W5NpNlvNgiBDRRv0I28j7I8ofTBnsIbmxHg44Mq2R0Pmq6GD3jE7rm4dO2drU1bDcLbW
         aHVg==
X-Gm-Message-State: AAQBX9dRCz5Xy3TODYX5ygGbCnKxIFsu30PFZxkYV8AFybaNNCTBBj49
        da0iQLFlmJOc+z8toZxq8x6fftMeH/aUjJwSODQ=
X-Google-Smtp-Source: AKy350ZbbPlnSS1gfLGKCh+j04duOZnmfyN8lIA1Y0JYiTnNbsVFDfqLt451BAOl/qHUT2qv0pbTKgVYTfj/HhSlhHY=
X-Received: by 2002:a4a:b404:0:b0:53e:944:8896 with SMTP id
 y4-20020a4ab404000000b0053e09448896mr589061oon.0.1680879977728; Fri, 07 Apr
 2023 08:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230406124625.41325-1-jim2101024@gmail.com> <20230406213123.wcztrbmhdpukoby2@mraw.org>
In-Reply-To: <20230406213123.wcztrbmhdpukoby2@mraw.org>
From:   Hank Barta <hbarta@gmail.com>
Date:   Fri, 7 Apr 2023 10:06:19 -0500
Message-ID: <CABTDG88MNmMmha96j0ABU4Q3-NKcLfx58wgQ2_GpyLgtAm1bxw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] PCI: brcmstb: Clkreq# accomodations of downstream device
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apologies to anyone who is seeing this for the second time. I forgot
to format as plain text on the first transmission.

Cyril Brulebois kindly provided me with Debian packages for the two
kernels he built and I tested them as well. I can confirm that the one
without the three patches still had the panic on power up and when a
PCIe device is present. Otherwise it booted without difficulty. The
kernel with three patches booted successfully on all tries both cold
and warm with a PCIe/NVME installed. I was also able to mount
partitions on the NVME driver and copy data off.

My hardware

CM4 with WiFi/BT, 8GG RAM and no eMMC.
(Official) I/O board
PCIe/NVME adapter card with Intel 670p SSD installed
32GB Samsung EVO Select SD card (boot device.)

Thanks to all who contributed to this fix.


On Thu, Apr 6, 2023 at 4:31=E2=80=AFPM Cyril Brulebois <kibi@debian.org> wr=
ote:
>
> Hi Jim,
>
> Jim Quinlan <jim2101024@gmail.com> (2023-04-06):
> > The current driver assumes the downstream devices can provide clkreq# f=
or
> > ASPM.  These commits accomodate devices w/ or w/o clkreq# and also hand=
le
> > L1SS-capable devices.
> >
> > The Raspian Linux folks have already been using a PCIe RC property
> > "brcm,enable-l1ss".  These commits use the same property, in a
> > backward-compatible manner, and the implementaion adds more detail and =
also
> > automatically identifies devices w/o a clkreq# signal, i.e. most device=
s
> > plugged into an RPi CM4 IO board.
> >
> > Jim Quinlan (3):
> >   dt-bindings: PCI: brcmstb: Add two optional props
> >   PCI: brcmstb: Clkreq# accomodations of downstream device
> >   PCI: brcmstb: Allow setting the completion timeout
> >
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 12 +++
> >  drivers/pci/controller/pcie-brcmstb.c         | 93 +++++++++++++++++--
> >  2 files changed, 95 insertions(+), 10 deletions(-)
> >
> >
> > base-commit: 99ddf2254febae9eab7fb0bcc02c5322243f5c49
>
> I've just verified with the exact same hardware as in Bugzilla#217276
> that latest master (v6.3-rc5-137-gf2afccfefe7b) still gets a kernel
> panic at boot, which goes away once those 3 patches are applied. Do you
> need any extra information, log excerpt, or something like that?
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant



--=20
Beautiful Sunny Winfield
