Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAA5F6A53
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJFPK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJFPKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 11:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1A3FEE0;
        Thu,  6 Oct 2022 08:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCDD6B82035;
        Thu,  6 Oct 2022 15:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBF3C433B5;
        Thu,  6 Oct 2022 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665069051;
        bh=EsOcPnG6SrdA7Pq8LqofCWapCMsw29KW3LBWaXqh73E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IUXNQtJWFwyZgl6PZkiE5pSsvdmyq6/Mq8wgk6gwe3Eg3TyCCXP7E2AcRoS6iRaim
         5WGDl3umltMsU2Qod6Rf0yoh9xtQp6J6ooFYG/cANd/RxbmFe9MkpJOov5b7qtbukx
         5Z4W6VUPLErAE0qPdTCGffMsfl16uirOj2RP2GFWvzEQ6KQslrnekWm2+LrvmzCjTV
         BDFAtDTvoR7parUWBkVbwQeUPDhCyyDdmSIA5EAL4KV1cUcYqjymkQnUE4gS0bNGXl
         NbCpe+YYUmGdfhyNiNbLclSG3/9SEAdbba8lTcf33AFHKDIgO3u+o7cvI8j8cZVeOB
         WE/PZotbbhBPQ==
Received: by mail-ua1-f51.google.com with SMTP id p89so728639uap.12;
        Thu, 06 Oct 2022 08:10:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf1hknNtz2A4x9uH1JXJrj2+oVrDz9fcXnjriFKSI3iyP0vfHx3M
        eTfXCm06IJEZbUetXQqscHUUlx184YPd5hmBCw==
X-Google-Smtp-Source: AMsMyM5EMjw94DkinhMIy3TgxlR6A1EG+W79KwecYmw4NBP3HOUDgfdpeYVtkJB5wNhODUSNoXtrxa7HoEvV+g5VmAw=
X-Received: by 2002:ab0:25d4:0:b0:3c1:c353:31cb with SMTP id
 y20-20020ab025d4000000b003c1c35331cbmr339075uan.63.1665069050451; Thu, 06 Oct
 2022 08:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com> <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
 <8ea70992-d4e9-8bbd-0fca-d5700f84e071@amd.com>
In-Reply-To: <8ea70992-d4e9-8bbd-0fca-d5700f84e071@amd.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Oct 2022 10:10:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJA8K0nKO=O2QjyHdue6=EHYNqCTw6pKUsBKwrdrYGePA@mail.gmail.com>
Message-ID: <CAL_JsqJA8K0nKO=O2QjyHdue6=EHYNqCTw6pKUsBKwrdrYGePA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
To:     Sonal Santan <sonal.santan@amd.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 30, 2022 at 2:29 PM Sonal Santan <sonal.santan@amd.com> wrote:
>
> On 9/26/22 15:44, Rob Herring wrote:
> > On Fri, Sep 16, 2022 at 6:15 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 8/29/22 16:43, Lizhi Hou wrote:
> >>> This patch series introduces OF overlay support for PCI devices which
> >>> primarily addresses two use cases. First, it provides a data driven method
> >>> to describe hardware peripherals that are present in a PCI endpoint and
> >>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
> >>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
> >>> driver -- often used in SoC platforms -- in a PCI host based system. An
> >>> example device is Microchip LAN9662 Ethernet Controller.
> >>>
> >>> This patch series consolidates previous efforts to define such an
> >>> infrastructure:
> >>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
> >>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
> >>>
> >>> Normally, the PCI core discovers PCI devices and their BARs using the
> >>> PCI enumeration process. However, the process does not provide a way to
> >>> discover the hardware peripherals that are present in a PCI device, and
> >>> which can be accessed through the PCI BARs. Also, the enumeration process
> >>> does not provide a way to associate MSI-X vectors of a PCI device with the
> >>> hardware peripherals that are present in the device. PCI device drivers
> >>> often use header files to describe the hardware peripherals and their
> >>> resources as there is no standard data driven way to do so. This patch> series proposes to use flattened device tree blob to describe the
> >>> peripherals in a data driven way.
> >>
> >>> Based on previous discussion, using
> >>> device tree overlay is the best way to unflatten the blob and populate
> >>> platform devices.
> >>
> >> I still do not agree with this statement.  The device tree overlay
> >> implementation is very incomplete and should not be used until it
> >> becomes more complete.  No need to debate this right now, but I don't want
> >> to let this go unchallenged.
> >
> > Then we should remove overlay support. The only way it becomes more
> > complete is having actual users.
> >
> > But really, whether this is the right solution to the problem is
> > independent of the state of kernel overlay support.
> >
> >> If there is no base system device tree on an ACPI based system, then I
> >> am not convinced that a mixed ACPI / device tree implementation is
> >> good architecture.
> >
> > Most/all of this series is needed for a DT system in which the PCI
> > devices are not populated in the DT.
> >
> >>   I might be more supportive of using a device tree
> >> description of a PCI device in a detached device tree (not linked to
> >> the system device tree, but instead freestanding).  Unfortunately the
> >> device tree functions assume a single system devicetree, with no concept
> >> of a freestanding tree (eg, if a NULL device tree node is provided to
> >> a function or macro, it often defaults to the root of the system device
> >> tree).  I need to go look at whether the flag OF_DETACHED handles this,
> >> or if it could be leveraged to do so.
> >
> > Instead of worrying about a theoretical problem, we should see if
> > there is an actual problem for a user.
> >
> > I'm not so worried about DT functions themselves, but places which
> > have 'if ACPI ... else (DT) ...' paths.
> >
>
> Bringing this thread back into focus. Any thoughts on how to move forward?

Reviewers raise concerns/issues and the submitters work to address
them or explain why they aren't an issue. The submitter has to push
things forward. That's how the process works.

As I noted, much of this is needed on a DT system with PCI device not
described in DT. So you could split out any ACPI system support to
avoid that concern for example. Enabling others to exercise these
patches may help too. Perhaps use QEMU to create some imaginary
device.

Rob
