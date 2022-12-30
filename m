Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB6659636
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 09:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiL3ITD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 03:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiL3ITB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 03:19:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD421A05C;
        Fri, 30 Dec 2022 00:19:00 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBAbQ-0003Oo-SD; Fri, 30 Dec 2022 09:18:56 +0100
Message-ID: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
Date:   Fri, 30 Dec 2022 09:18:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: =?UTF-8?Q?=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0216865?=
 =?UTF-8?Q?_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_with_AM?=
 =?UTF-8?Q?D_IOMMU_enabled?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672388340;85de40be;
X-HE-SMSGID: 1pBAbQ-0003Oo-SD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216865 :

>  Matt Fagnani 2022-12-29 18:39:56 UTC
> 
> I booted the Fedora Rawhide KDE Plasma live image
> Fedora-KDE-Live-x86_64-Rawhide-20221227.n.0.iso
> https://koji.fedoraproject.org/koji/buildinfo?buildID=2104562 from a USB
> flash drive written with Fedora Media Writer on an hp laptop with an
> integrated Radeon R5 GPU. The system froze with a black screen when
> amdgpu started during 6.2-rc1 kernel boot. When I booted with quiet rhgb
> removed from the kernel command line the last line shown before the
> black screen was
>
> kernel: [drm] amdgpu kernel modesetting enabled.
> 
> This problem happened each of several boots when using the amdgpu
> driver (the default). This problem didn't happen when I booted the same
> image using Troubleshooting > Boot Fedora-KDE-Plasma-live in basic
> graphics mode which used the simpledrm driver and started Plasma on X
> normally. This problem also didn't happen when I booted the image in a
> QEMU/KVM VM in GNOME Boxes with 3 GB RAM using the virtio-gpu driver.
> 
> The data from the previous boots using live images aren't saved by
> default so I couldn't get the journal that way as far as I knew. I
> installed kernel-6.2.0-0.rc1.14.fc38 in my Fedora 37 KDE Plasma
> installation and reproduced the problem 3 times with quiet rhgb removed
> from the kernel command line and sysrq_always_enabled drm.debug=14 added
> to it. I used sysrq+alt+r,s,u,b which rebooted the system so the kernel
> wasn't completely frozen. The journals from the boots with the problem
> weren't shown in journalctl. I booted with amdgpu.dc=0 on the kernel
> command line and the screen froze with the last line
> kernel: [drm] amdgpu kernel modesetting enabled. and the black
> screen
> didn't happen. I booted with drm.debug=94 on the kernel command line and
> the screen's drm settings were shown repeatedly until I rebooted after
> 2-3 minutes.
> 
> This problem didn't happen with kernel-6.1.0-65.fc38 or earlier in
> the
> Fedora Rawhide live image
> Fedora-KDE-Live-x86_64-Rawhide-20221217.n.0.iso. The first Fedora
> Rawhide kernel with this problem was
> 6.2.0-0.rc0.20221215git041fae9c105a.5.fc38, while
> 6.2.0-0.rc0.20221214gite2ca6ba6ba01.3.fc38 was the last one without the
> problem. I bisected the mainline kernel between e2ca6ba6ba01 and
> 041fae9c105a. The first bad commit was the following involving PCI and
> IOMMUs.
> 
> 201007ef707a8bb5592cd07dd46fc9222c48e0b9 is the first bad commit
> commit 201007ef707a8bb5592cd07dd46fc9222c48e0b9
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Mon Oct 31 08:59:08 2022 +0800
> 
>     PCI: Enable PASID only when ACS RR & UF enabled on upstream path
>     
>     The Requester ID/Process Address Space ID (PASID) combination
>     identifies an address space distinct from the PCI bus address space,
>     e.g., an address space defined by an IOMMU.
>     
> [...]
> 
> My system has an AMD IOMMU enabled. When I booted 6.2-rc1 with
> amd_iommu=off on the kernel command line, the problem didn't happen and
> the boot completed. There were IOMMU-related errors when amdgpu started
> with amd_iommu=off. So the problem appears to involve amdgpu not
> starting properly when the IOMMU is enabled after that change. When I
> booted with quiet rhgb removed from the kernel command line, I noted
> that the AMD IOMMU started about 3 seconds before the problem happened
> when amdgpu started with a line like kernel: AMD-Vi: AMD IOMMUv2 loaded
> and initialized
> 
> I reported this problem at
> https://gitlab.freedesktop.org/drm/amd/-/issues/2319 where Alex Deucher
> wrote "Please report this upstream to the IOMMU subsystem:
> https://bugzilla.kernel.org/" I reported it for Fedora at
> https://bugzilla.redhat.com/show_bug.cgi?id=2156691

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 201007ef707a8bb
https://bugzilla.kernel.org/show_bug.cgi?id=216865
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
