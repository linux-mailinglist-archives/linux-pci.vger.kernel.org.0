Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4EC629930
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKOMt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 07:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKOMt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 07:49:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394827FCF;
        Tue, 15 Nov 2022 04:49:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z14so23927504wrn.7;
        Tue, 15 Nov 2022 04:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vA5+0mCCYTIsaoxSUD4t74U1oJb0G7LU66XEZty9pDY=;
        b=bWGpBF52oDY7yLZf//SeiaT9PoxV2Ckt9RJcH7gLkUVAGUaUmS/fd1zMggAhKs5DkE
         X09qkoic8bE7JZBqpxw82GBnL217znnsEz/nUNptrTJUfL1sHemV60xq4zS55hKh+kbZ
         EIh/+86PWmH9UfG32f+ib7X9trCctZyPQad3dAuEVcA66ysyVxKyoTYNQ77ed2hGWDeA
         Ofg7ETPkycnuRYA1nWQQXwRIuyqu7g0G9I5HTfQe1Fm7qgKUWo97r0a7CQzK7gSa8JcN
         lFkAtOsfW91BwkUtnYGfSLRBORBOV54/HV3lujFkkqVrmXG0le/iIwtuZs2/6bOCHJxB
         JuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA5+0mCCYTIsaoxSUD4t74U1oJb0G7LU66XEZty9pDY=;
        b=uVgpVRSJyt885KxTEKL4pvKJN4WIRMtX12SRZkyQGb/gL+2C9C0FO2aY1/LwSx12EH
         a0q9AreWP/E0ZDWJwn02OFjkHNSrdf60Jhnui92B/RhIXDz1H/gYZUaWbIat1Ayqnxss
         scFAj6IskbP7KrkjBDwPMdQ7+VuoTvDok/SL/Z0cirNq4Iza5VvSiIBU+bE29RtDXN8v
         utNAsEBgpDLnB8mlsdxV+dl3f7UipIdbuKe9VFBjf8E10UtXRSgKk66LegSNWa/q4OxD
         AJHILHzEmDncpt5BhI12s+9vnTGIDp0N1fOWPqes6vg3NyVRqE89APV4tdvYTg1LNbLz
         ICfw==
X-Gm-Message-State: ANoB5plGwwUUy7IoheqpTBGYZeARjFYuNUhIieePwnmrTRsx1nE3T/TG
        VBKJLme9AyX8CpI5yWNcIZvQ1/5josu12K/rq4s=
X-Google-Smtp-Source: AA0mqf5nAPubHOXWmgG9YWV6ZaPZ7Zki4ub80ozH9abj8R9jmaCd64wcxPgPRiSfAfq0LSeEJotQU+AawZ0vQYT2LG0=
X-Received: by 2002:adf:ea06:0:b0:236:6d77:b6be with SMTP id
 q6-20020adfea06000000b002366d77b6bemr10835243wrm.246.1668516564534; Tue, 15
 Nov 2022 04:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20221111142722.1172-1-longpeng2@huawei.com> <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com> <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com> <Y3I+Fs0/dXH/hnpL@unreal>
 <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com> <Y3JOvTfBwpaldtZJ@unreal>
 <CAOSf1CG+VGdeXGQetfMArwpafAx2yj3nmA_y7rN4SNdt=1=08w@mail.gmail.com> <Y3NOo3DaLKb219IV@unreal>
In-Reply-To: <Y3NOo3DaLKb219IV@unreal>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 15 Nov 2022 23:49:13 +1100
Message-ID: <CAOSf1CGLM7wpN3=RwU+osy46jX9iWTi3TWDNyaCnBFOTyBiKpg@mail.gmail.com>
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianjay.zhou@huawei.com, zhuangshengen@huawei.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, xiehong@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 7:32 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Nov 15, 2022 at 12:50:34PM +1100, Oliver O'Halloran wrote:
> > On Tue, Nov 15, 2022 at 1:27 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > *snip*
> > >
> > > Anyway, I'm aware of big cloud providers who are pretty happy with live
> > > migration in production.
> >
> > I could see someone sufficiently cloudbrained deciding that rebooting
> > the hypervisor is fine provided the downtime doesn't violate any
> > customer uptime SLAs. Personally I'd only be brave enough to do that
> > for a HV hosting internal services which I know are behind a load
> > balancer, but apparently there are people at Huawei far braver than I.
>
> My main point in this discussion that Huawei team doesn't actually
> provide any meaningful justification why it is great idea to add new
> sysfs file.

All their arguments seem to be based on trying to reduce the
time-to-VMs when a hypervisor is kexec()ed, which is a pretty
reasonable justification IMO.  I do have some reservations about the
numbers they're claiming since 250ms for initializing struct pci_dev's
for the VFs seems excessive. Unfortunately, I don't have any hardware
that supports 2048 VFs on hand so I can't verify that claim.

> They use HPC as an argument but in that world, you won't
> see many VMs on one server, as it is important to provide separate MSI-X
> vectors and CPUs to each VM.

I don't think HPC has come up in this thread, but assuming it has: In
the cloud "HPC" usually means "it has timesliced access to GPUs".
Having 2k VMs sharing one or more GPUs on a single system isn't
necessarily advisable, but if we assume only a subset of those VMs
will actually need access to a GPU at any given time it's sort of
reasonable.

> They ask from us optimization (do not add device hierarchy for existing HW)
> that doesn't exist in the kernel.
>
> I would say that they are trying to meld SIOV architecture of subfunctions
> (SFs) into PCI and SR-IOV world.

I don't know what asks you're referring to, but they're not present in
this thread. I'm going to give Longpeng the benefit of the doubt and
assume that this series is an attempt to fix a problem he's facing
with actual hardware that exists today. To say they should have
implemented the device with SIOV (proprietary to Intel until March
this year) rather than SR-IOV (standardised by PCI-SIG over a decade
ago) is not terribly helpful to anyone. Additionally, SIOV exists
largely to solve a problem that's an issue because Intel decided that
all PCI devices should exist within a single PCI domain. If you don't
have that problem SIOV is a lot less compelling.
