Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2E25B8E95
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiINSIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiINSIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 14:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1F7EFD9;
        Wed, 14 Sep 2022 11:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C5061E53;
        Wed, 14 Sep 2022 18:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A65C433D7;
        Wed, 14 Sep 2022 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663178919;
        bh=q3lo6oX6Adw+l/aUZsSyNgyDa03KID4HkHE0P0JrSxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NNDmoiwVz4L5wIWHF8ajqUmcu/xx3YnLkVN0vtlOSfWVsmnx1mM6rY9p0ehiTtSiI
         f3Gu4rvzgOBp4oM21e0o1byq04h1rkOKi4M8eRL+RWW3+rWbQKaIhSk2vfOZcAvl/x
         mNM1oN+TFgGkDJtYCJrILLAkewkBOSLVYBKx9psnvLsTEjiGckhNK2VLauzqC9XJ15
         Ax6idRcIks31L6Hw4WQNQ4FU/1aeqbZJn6gEyODng0NI4oAU3Uv2YKHfblxD5kn3hU
         RaLJRFy8GUJmZZhiTTB5QE2MzVc3nVsyXQr3oYpcWdwgTZDaBmojqKQYekxGlGkGFU
         BNtHv8fDndveg==
Received: by mail-vk1-f169.google.com with SMTP id g185so7858306vkb.13;
        Wed, 14 Sep 2022 11:08:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo19EJUIUKs3KSPV0RyiSIaXRY2GvjUySflUnYKQ0OHs6bnWRygE
        kt1VQEDTt0sCMgML5VSt8tldUOR+Cvn97G4aqA==
X-Google-Smtp-Source: AA6agR56p/Zoyk5JDNjqFjD+eS6WCbPqja/Ej889pLyBHGKPJcCXLE8GTZmxuug9cCFfWKPkI9PSnh8bxhtIzQE3ex0=
X-Received: by 2002:ac5:c77a:0:b0:3a2:1e50:bc11 with SMTP id
 c26-20020ac5c77a000000b003a21e50bc11mr6296626vkn.19.1663178918916; Wed, 14
 Sep 2022 11:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com> <20220914133513.GA26840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220914133513.GA26840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Sep 2022 13:08:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJMJccbwH7tR0FwZpuxMgwmAt8ZmWCbt=rOLaM4RtH9wg@mail.gmail.com>
Message-ID: <CAL_JsqJMJccbwH7tR0FwZpuxMgwmAt8ZmWCbt=rOLaM4RtH9wg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, PCI <linux-pci@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        "Zhen, Max" <max.zhen@amd.com>,
        "Santan, Sonal" <sonal.santan@amd.com>,
        "Liu, Larry" <larry.liu@amd.com>, "Xu, Brian" <brian.xu@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 8:35 AM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> On Mon, Aug 29, 2022 at 02:43:35PM -0700, Lizhi Hou wrote:
> > This patch series introduces OF overlay support for PCI devices which
> > primarily addresses two use cases. First, it provides a data driven method
> > to describe hardware peripherals that are present in a PCI endpoint and
> > hence can be accessed by the PCI host. An example device is Xilinx/AMD
> > Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
> > driver -- often used in SoC platforms -- in a PCI host based system. An
> > example device is Microchip LAN9662 Ethernet Controller.
> >
> > This patch series consolidates previous efforts to define such an
> > infrastructure:
> > https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
> > https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> >
> > Normally, the PCI core discovers PCI devices and their BARs using the
> > PCI enumeration process. However, the process does not provide a way to
> > discover the hardware peripherals that are present in a PCI device, and
> > which can be accessed through the PCI BARs. Also, the enumeration process
> > does not provide a way to associate MSI-X vectors of a PCI device with the
> > hardware peripherals that are present in the device. PCI device drivers
> > often use header files to describe the hardware peripherals and their
> > resources as there is no standard data driven way to do so. This patch
> > series proposes to use flattened device tree blob to describe the
> > peripherals in a data driven way. Based on previous discussion, using
> > device tree overlay is the best way to unflatten the blob and populate
> > platform devices. To use device tree overlay, there are three obvious
> > problems that need to be resolved.
>
> Hi Lizhi,
>
> We all *love* "have you thought about xxx" questions but I would really like to
> get your thoughts on this. An approach to this problem that I have seen in
> various devices is to emulate a virtual pcie switch, and expose the "sub
> devices" behind that. That way you can carve up the BAR space, each device has
> its own config space and mapping of MSI-X vector to device becomes clear. This
> approach also integrates well with other kernel infrastructure (IOMMU, hotplug).
>
> This is certainly possible on reprogrammable devices but requires some more
> FPGA resources - though I don't believe the added utilization would be
> significant. What do you think of this kind of solution?

It would integrate easily unless the sub-devices you are targeting
have drivers already which are not PCI drivers. Sure, we could add PCI
support to them, but that could be a lot of churn.

There are also usecases where we don't get to change the h/w.

Rob
