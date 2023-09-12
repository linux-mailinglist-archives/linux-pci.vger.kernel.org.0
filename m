Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FDF79D95D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjILTMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjILTMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 15:12:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645EFE50;
        Tue, 12 Sep 2023 12:12:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C6C433C9;
        Tue, 12 Sep 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694545938;
        bh=ZUqNcVFP2YsCnPCuq9+9HC+Xhdgu+7zaDoHoj+ZEStY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CGPXL/wuRrbNORoLjjtLuyfvL1e0D3sJM7eshi+1nEeMV0u95vFCzs8sST2sXqasc
         oicR5jLTrZpyh1r5icM9C+jEuFjtqNI0mFbRyKFtXERbj2jERBmj6lFZrLDmC2gU0y
         bCoCkXNxQ0us9hpj+ehMa4ioZZzKrR8OlqhQS4TO2fGGTt99RrQcgyxzqLYu03ckLg
         Fidx239sVgBiSJ4NelDrlRsdTymzS+0ppeyq2eoNEqp1uaxNZ4+ezpPTzZKzbpUcv+
         hiRJ8/d56mmKhD0fBgrnZns5wmHtBS59P/cxFreT8nvGJk+TsCe9xOBsuixdy109Or
         8+ujWy7g5RYvQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-501cef42bc9so9860160e87.0;
        Tue, 12 Sep 2023 12:12:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YyH9VRQ5i0KPXqR1favNAazwAIRCKSm4L9I3BXmooXVvwJMSTCG
        SZB3aVeYZkiepa0ZUyM6y6Ft718Yujz7F+4/zQ==
X-Google-Smtp-Source: AGHT+IGYLguwjOafV6zaD9hG6eJnYMUjeQqWWTEiBeuLOANCZ7akM40kZq41oikseMMfO4WgWofzezXn4ytW1TvEZfI=
X-Received: by 2002:ac2:599c:0:b0:4ff:8f45:ab86 with SMTP id
 w28-20020ac2599c000000b004ff8f45ab86mr333033lfn.25.1694545937160; Tue, 12 Sep
 2023 12:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com> <ZP96feVs2ev7098Y@smile.fi.intel.com>
In-Reply-To: <ZP96feVs2ev7098Y@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Sep 2023 14:12:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKfQJFrd8MOdjW55cYdEb8yyPyR+P3ran9+X3dCwUgdyA@mail.gmail.com>
Message-ID: <CAL_JsqKfQJFrd8MOdjW55cYdEb8yyPyR+P3ran9+X3dCwUgdyA@mail.gmail.com>
Subject: Re: [PATCH V13 0/5] Generate device tree node for pci devices
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 3:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Aug 15, 2023 at 10:19:55AM -0700, Lizhi Hou wrote:
> > This patch series introduces OF overlay support for PCI devices which
> > primarily addresses two use cases. First, it provides a data driven met=
hod
> > to describe hardware peripherals that are present in a PCI endpoint and
> > hence can be accessed by the PCI host. Second, it allows reuse of a OF
> > compatible driver -- often used in SoC platforms -- in a PCI host based
> > system.
> >
> > There are 2 series devices rely on this patch:
> >
> >   1) Xilinx Alveo Accelerator cards (FPGA based device)
>
> >   2) Microchip LAN9662 Ethernet Controller
>
> I believe you should Cc this to Andrew Lunn for the comments.
> IIRC something similar was tried to being solved for DSA (?)
> devices where SFP hotpluggable hardware can be attached or
> detached at run-time (sorry if I messes / mixing up things,
> I wrote this from my memory, might be completely wrong).

Could be similar in the sense that this problem exists on any
discoverable bus with non-discoverable devices downstream.

The LAN9662 case is that it's an SoC that can run Linux. Standard
stuff there. You have a DT and a bunch of drivers and SoC support in
the kernel. Now take that same SoC with the CPU cores disabled and
expose the whole (or part of) SoC via PCIe to Linux running on another
host. How to reuse all the drivers? Yes, you could define swnode
stuff, but then the PCI driver becomes a board file (or multiple). In
fact that's what they started doing at one point. It doesn't scale.

> >      Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-c=
lement.leger@bootlin.com/
> >
> > Normally, the PCI core discovers PCI devices and their BARs using the
> > PCI enumeration process. However, the process does not provide a way to
> > discover the hardware peripherals that are present in a PCI device, and
> > which can be accessed through the PCI BARs. Also, the enumeration proce=
ss
> > does not provide a way to associate MSI-X vectors of a PCI device with =
the
> > hardware peripherals that are present in the device. PCI device drivers
> > often use header files to describe the hardware peripherals and their
> > resources as there is no standard data driven way to do so. This patch
> > series proposes to use flattened device tree blob to describe the
> > peripherals in a data driven way. Based on previous discussion, using
> > device tree overlay is the best way to unflatten the blob and populate
> > platform devices. To use device tree overlay, there are three obvious
> > problems that need to be resolved.
> >
> > First, we need to create a base tree for non-DT system such as x86_64. =
A
> > patch series has been submitted for this:
> > https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmai=
l.com/
> > https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.c=
om/
>
> Can you point out to the ACPI excerpt(s) of the description of anything r=
elated
> to the device(s) in question?

I don't understand what you are asking for.

Rob
