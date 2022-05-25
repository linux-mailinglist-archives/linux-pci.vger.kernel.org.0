Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE6534226
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbiEYRZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbiEYRY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 13:24:57 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C4AE271;
        Wed, 25 May 2022 10:24:56 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l9-20020a056830268900b006054381dd35so14747569otu.4;
        Wed, 25 May 2022 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea2AJnAQZS/A6ChJ1W/Yj3ePGq4t096s8H5w6Mo387I=;
        b=T8flkpaKVH2ZBWiwC5hXfHGmWAeRM9c4SKmeVnzlqSv9pqWiMyl1bM+QRbGXoXN9ya
         57gNH3BPAVArsHm00h1/dpedz/w6jxzjFSZrZ+AxxMxF/GHcHHOKUtMBmPKbTyzc8QC/
         ZklJJeC7ZmWBkAZ33TEF3dxTQyyR8pt9CUeoAaHCRAzelowjnYNGHd2I04Zazkp6VEhw
         8LPWUodrvtptFvA4nxftzZNaDtb9WJkifm5YvDa6LjLXLOQ/HQNtkmzQG2or0Z/TCq2F
         NHo2zmnLx0Sg8yc1YD4Xs67Yn7GzQSz3LHEFMRJjN7/347aYNMMMTsfTXwuk1CpOCcLA
         c74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea2AJnAQZS/A6ChJ1W/Yj3ePGq4t096s8H5w6Mo387I=;
        b=6mnQCPEiYSwdZ+t64q54R6ieoIS62YZWT51ercPB57JJNmiu7cyo5pPqWMYIcm96H7
         f4IGNdhVl7K1M4/cN+997v95y5himR5b0r5NRbckyCI1AkNbS/RUXYhEWaVU/G56kVYC
         pc/kthqk3SHF+SDefseO1ksFNmzbhurEKvWqSOjBiPASMmNniy34Zf+CnZvQPQN7YjQI
         g0kwFyE+IlvPIUajlzhLQHBtqS0v+lTYcgUCRmFItTn67LJ53Jqn6ZKV6bKx0iFofsQ+
         jh4ts8dPTfGTlOrK9e07dUYB9g5HQi1gEyFVmVU5Tdca0icf6mPlOd9Ix9V+MJ24D7HC
         fDuQ==
X-Gm-Message-State: AOAM532VN5Dn/Uw38V6yGfC8sqOk6ES3BRCTtfLY/3xVDgzKJ7z4f7De
        eoADggOq8qNloCd9kCLnLRLp8qH8NjJjMv8phFI=
X-Google-Smtp-Source: ABdhPJw3KKWi4/d0UTn8/KsQbVAJGCSIKzcJPTMwai66hjj67x9zs2oVK/CFfvCgnavXAz/iueK3HW9VxzfUJi6t9FM=
X-Received: by 2002:a9d:4c11:0:b0:60b:2d85:d232 with SMTP id
 l17-20020a9d4c11000000b0060b2d85d232mr2467246otf.245.1653499495714; Wed, 25
 May 2022 10:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
 <20220523221036.GA130515@bhelgaas> <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
 <427974aa-2152-8397-65df-6808de3d3b5e@i2se.com>
In-Reply-To: <427974aa-2152-8397-65df-6808de3d3b5e@i2se.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 25 May 2022 13:24:43 -0400
Message-ID: <CANCKTBuJHXG+fQR0oLfTpP_oDJJEhSZxUmc342gUPtEai8bLnA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 3:21 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Jim,
>
> Am 24.05.22 um 18:54 schrieb Jim Quinlan:
> > On Mon, May 23, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> >>> On Sat, May 21,
> >>> 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> >>> at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>>> On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> >>>>> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
> >>>>> voltage regulators")
> >>>>>
> >>>>> introduced a regression on the PCIe RPi4 Compute Module.  If the
> >>>>> PCIe endpoint node described in [2] was missing, no linkup would
> >>>>> be attempted, and subsequent accesses would cause a panic
> >>>>> because this particular PCIe HW causes a CPU abort on illegal
> >>>>> accesses (instead of returning 0xffffffff).
> >>>>>
> >>>>> We fix this by allowing the DT endpoint subnode to be missing.
> >>>>> This is important for platforms like the CM4 which have a
> >>>>> standard PCIe socket and the endpoint device is unknown.
> >>>> I think the problem here is that on the CM, we try to enumerate
> >>>> devices that are not powered up, isn't it?  The commit log should
> >>>> say something about that power situation and how the driver learns
> >>>> about the power regulators instead of just pointing at an DT
> >>>> endpoint node.
> >>> This is incorrect.  The regression occurred because the code
> >>> mistakenly skips PCIe-linkup if the PCI portdrv DT node does not
> >>> exist. With our RC HW, doing a config space access to bus 1 w/o
> >>> first linking up results in a CPU abort.  This regression has
> >>> nothing to do with EP power at all.
> >> OK, I think I'm starting to see, but I'm still missing some things.
> >>
> >> 67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev
> >> regulators") added pci_subdev_regulators_add_bus() as an .add_bus()
> >> method.  This is called by pci_alloc_child_bus(), and if the DT
> >> describes any regulators for the bridge leading to the new child bus,
> >> we turn them on.
> >>
> >> Then 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
> >> regulators") added brcm_pcie_add_bus() and made *it* the .add_bus()
> >> method.  It turns on the regulators and brings the link up, but it
> >> skips both if there's no DT node for the bridge to the new bus.
> > Hi Bjorn,
> >
> > Yes, I meant it to skip the turning on of the regulators if the DT
> > node was missing
> > but I failed to notice that it would also skip the pcie linkup as well.  As you
> > may have guessed, all of my test systems have the PCIe root port
> > DT node.
> >
> >> I guess RPi4 CM has no DT node to describe regulators, so we skip both
> >> turning them on *and* bringing the link up?
> > Yes. One repo did not have this node (Cyril/debina?), one did
> > (https://github.com/raspberrypi/firmware/tree/master/boot).
> > Of course there is nothing wrong with omitting the node; it should
> > have pcie linkup regardless.
> Please ignore the vendor tree, because you only have to care about
> mainline kernel and DT here.
Okay, good to know.

> >
> >> But above you say it's the *endpoint* node that doesn't exist.  The
> >> existing code looks like it's checking for the *bridge* node
> >> (bus->dev->of_node).  We haven't even enumerated the devices on the
> >> child bus, so we don't know about them at this point.
> > You are absolutely correct and I must change the commit message
> > to say the "root port DT node".   I'm sorry; this mistake likely did not
> > help you understand the fix. :-(
> >
> >> What happens if there is a DT node for the bridge, but it doesn't
> >> describe any regulators?  I assume regulator_bulk_get() will fail, and
> >> it looks like that might still keep us from bringing the link up?
> > The regulator_bulk_get()  func does not fail if the regulators are not
> > present.  Instead it "gets"
> > a dummy device and issues a warning per missing regulator.
> > A version of my pullreq submitted code to prescan the DT node and call
> > regulator_bulk_get() with
> > only the names of the regulators present, but IIRC this was NAKd.
> > Hopefully I will not be swamped with RPi developers'  emails when they
> > think these warnings are an issue.
>
> This won't be the first driver complaining about missing regulators and
> won't be the last one. So don't expect an email from me ;-)
Perhaps I complain too much :-)

Cheers,
Jim Quinlan
Broadcom STB
>
> Best regards
>
