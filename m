Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C166CC0F4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjC1NcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjC1NcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 09:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404ECA2A;
        Tue, 28 Mar 2023 06:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA6B1616F0;
        Tue, 28 Mar 2023 13:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC97C4339C;
        Tue, 28 Mar 2023 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680010305;
        bh=nrDhBG7YSqdUTZAK8NjLiILzcTDoY0sT0uFjd2gzc+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CKeT2tkeXkhFB8flK0TF45FmW3lWHiWhzKVjRFb+QteA3qYX9mfo+OcTDzcym58P9
         h3hM2ScsbHSByx+xRt6pctMZf8ntPkKVUgkHLiU4MpwtFKiYQ7Im0/LcPG5cEUvLE6
         BHxzSWGn4MQ4EYiMD6wBdaNgOhK6tU6YZ/GpK4wg3iny+2MZgJwmjuZ6DS7GN+DUuw
         uAO7vFL1NjPil37dZ8beI1qhvy3zrKwTK5qB4ljVQUhnOAZ3QkAiAz/g83u5HTkhCg
         AQGnnWF5zQwyYJTnuJNVPk9UVjWwMJQRYmhAtv17yF9zc4RgSTwlzCJhRfzdnNf0KT
         O2ZXao2sjQeUw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5419d4c340aso229506597b3.11;
        Tue, 28 Mar 2023 06:31:45 -0700 (PDT)
X-Gm-Message-State: AAQBX9clt73CEmyV7Z1BpykTQdfaVZW4Ssu1ZtorZxjeAk6pOL1N8Yat
        /geAzU3t7N2wGwhIMYGUSYyIO+nanv2n1La4vQ==
X-Google-Smtp-Source: AKy350adGUM1TIDE6jPN4w068hh35P4yTPslWKdtfQlrHglx6bkc9oWCDCOPHeOWPWU+0UuYolz0WEMJpGIHwbzfryI=
X-Received: by 2002:a81:a908:0:b0:545:7164:49ac with SMTP id
 g8-20020a81a908000000b00545716449acmr7116719ywh.5.1680010304089; Tue, 28 Mar
 2023 06:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220702204737.7719-1-pali@kernel.org> <20220714184130.5436-1-pali@kernel.org>
 <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com> <20230320205936.wd6pj3trljsduj5c@pali>
 <993ca7dc-1d39-6ae9-1033-838d81aeb076@nvidia.com> <3414723d-7d79-809f-e63f-35243d945b50@nvidia.com>
In-Reply-To: <3414723d-7d79-809f-e63f-35243d945b50@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 08:31:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+3j60WK0HSr0rFQYwPkMbs=ZW=mifd7ggeNQA8+iuaA@mail.gmail.com>
Message-ID: <CAL_JsqJ+3j60WK0HSr0rFQYwPkMbs=ZW=mifd7ggeNQA8+iuaA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 22, 2023 at 9:36=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 21/03/2023 18:44, Jon Hunter wrote:
> >
> > On 20/03/2023 20:59, Pali Roh=C3=A1r wrote:
> >> Hello!
> >>
> >> On Monday 20 March 2023 20:26:05 Jon Hunter wrote:
> >>> Hi Pali,
> >>>
> >>> After this change was made we are seeing the following bug
> >>> report on a Tegra234 Jetson Orin board ...
> >>>
> >>> [   17.172346] tegra194-pcie 141a0000.pcie: host bridge
> >>> /pcie@141a0000 ranges:
> >>> [   17.172470] tegra194-pcie 141a0000.pcie:      MEM
> >>> 0x2800000000..0x2b27ffffff -> 0x2800000000
> >>> [   17.172519] tegra194-pcie 141a0000.pcie:      MEM
> >>> 0x2b28000000..0x2b2fffffff -> 0x0040000000
> >>> [   17.172548] tegra194-pcie 141a0000.pcie:       IO
> >>> 0x003a100000..0x003a1fffff -> 0x003a100000
> >>> [   17.173449] tegra194-pcie 141a0000.pcie: iATU: unroll T, 8 ob, 2
> >>> ib, align 64K, limit 32G
> >>> [   18.279048] tegra194-pcie 141a0000.pcie: Phy link never came up
> >>> [   19.279285] tegra194-pcie 141a0000.pcie: Phy link never came up
> >>> [   19.279599] tegra194-pcie 141a0000.pcie: PCI host bridge to bus
> >>> 0005:00
> >>> [   19.279613] pci_bus 0005:00: root bus resource [bus 00-ff]
> >>> [   19.279622] pci_bus 0005:00: root bus resource [mem
> >>> 0x2800000000-0x2b27ffffff pref]
> >>> [   19.279631] pci_bus 0005:00: root bus resource [mem
> >>> 0x2b28000000-0x2b2fffffff] (bus address [0x40000000-0x47ffffff])
> >>> [   19.279639] pci_bus 0005:00: root bus resource [io
> >>> 0x200000-0x2fffff] (bus address [0x3a100000-0x3a1fffff])
> >>> [   19.279687] pci 0005:00:00.0: [10de:229a] type 01 class 0x060400
> >>> [   19.279886] pci 0005:00:00.0: PME# supported from D0 D3hot
> >>> [   19.283256] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
> >>> [   19.283590] pcieport 0005:00:00.0: Adding to iommu group 26
> >>> [   19.283991] pcieport 0005:00:00.0: PME: Signaling with IRQ 174
> >>> [   19.284429] pcieport 0005:00:00.0: AER: enabled with IRQ 174
> >>> [   19.285003] pci_bus 0005:01: busn_res: [bus 01-ff] is released
> >>> [   19.285591] pci 0005:00:00.0: Removing from iommu group 26
> >>> [   19.285751] pci_bus 0005:00: busn_res: [bus 00-ff] is released
> >>> [   19.285870]
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> [   19.293351] BUG: KFENCE: use-after-free read in
> >>> pci_bus_release_domain_nr+0x10/0x70
> >>>
> >>> [   19.302817] Use-after-free read at 0x000000007f3b80eb (in
> >>> kfence-#115):
> >>> [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
> >>> [   19.309691]  dw_pcie_host_deinit+0x28/0x78
> >>> [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194=
]
> >>> [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
> >>> [   19.309752]  platform_probe+0x90/0xd8
> >>> [   19.309764]  really_probe+0xb8/0x298
> >>> [   19.309777]  __driver_probe_device+0x78/0xd8
> >>> [   19.309788]  driver_probe_device+0x38/0x120
> >>> [   19.309799]  __device_attach_driver+0x94/0xe0
> >>> [   19.309812]  bus_for_each_drv+0x70/0xc8
> >>> [   19.309822]  __device_attach+0xfc/0x188
> >>> [   19.309833]  device_initial_probe+0x10/0x18
> >>> [   19.309844]  bus_probe_device+0x94/0xa0
> >>> [   19.309854]  deferred_probe_work_func+0x80/0xb8
> >>> [   19.309864]  process_one_work+0x1e0/0x348
> >>> [   19.309882]  worker_thread+0x48/0x410
> >>> [   19.309891]  kthread+0xf4/0x110
> >>> [   19.309904]  ret_from_fork+0x10/0x20
> >>>
> >>> [   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8,
> >>> size=3D1072, cache=3Dkmalloc-2k
> >>>
> >>> [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
> >>> [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
> >>> [   19.311571]  kmalloc_trace+0x24/0x30
> >>> [   19.311580]  pci_alloc_bus+0x24/0xa0
> >>> [   19.311590]  pci_register_host_bridge+0x48/0x4b8
> >>> [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
> >>> [   19.311613]  pci_host_probe+0x18/0xc0
> >>> [   19.311623]  dw_pcie_host_init+0x2c0/0x568
> >>> [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
> >>> [   19.311647]  platform_probe+0x90/0xd8
> >>> [   19.311653]  really_probe+0xb8/0x298
> >>> [   19.311663]  __driver_probe_device+0x78/0xd8
> >>> [   19.311672]  driver_probe_device+0x38/0x120
> >>> [   19.311682]  __device_attach_driver+0x94/0xe0
> >>> [   19.311694]  bus_for_each_drv+0x70/0xc8
> >>> [   19.311702]  __device_attach+0xfc/0x188
> >>> [   19.311713]  device_initial_probe+0x10/0x18
> >>> [   19.311724]  bus_probe_device+0x94/0xa0
> >>> [   19.311733]  deferred_probe_work_func+0x80/0xb8
> >>> [   19.311743]  process_one_work+0x1e0/0x348
> >>> [   19.311753]  worker_thread+0x48/0x410
> >>> [   19.311763]  kthread+0xf4/0x110
> >>> [   19.311771]  ret_from_fork+0x10/0x20
> >>>
> >>> [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
> >>> [   19.311799]  release_pcibus_dev+0x30/0x40
> >>> [   19.311808]  device_release+0x30/0x90
> >>> [   19.311814]  kobject_put+0xa8/0x120
> >>> [   19.311832]  device_unregister+0x20/0x30
> >>> [   19.311839]  pci_remove_bus+0x78/0x88
> >>> [   19.311850]  pci_remove_root_bus+0x5c/0x98
> >>> [   19.311860]  dw_pcie_host_deinit+0x28/0x78
> >>> [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194=
]
> >>> [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
> >>> [   19.311900]  platform_probe+0x90/0xd8
> >>> [   19.311906]  really_probe+0xb8/0x298
> >>> [   19.311916]  __driver_probe_device+0x78/0xd8
> >>> [   19.311926]  driver_probe_device+0x38/0x120
> >>> [   19.311936]  __device_attach_driver+0x94/0xe0
> >>> [   19.311947]  bus_for_each_drv+0x70/0xc8
> >>> [   19.311956]  __device_attach+0xfc/0x188
> >>> [   19.311966]  device_initial_probe+0x10/0x18
> >>> [   19.311976]  bus_probe_device+0x94/0xa0
> >>> [   19.311985]  deferred_probe_work_func+0x80/0xb8
> >>> [   19.311995]  process_one_work+0x1e0/0x348
> >>> [   19.312005]  worker_thread+0x48/0x410
> >>> [   19.312014]  kthread+0xf4/0x110
> >>> [   19.312022]  ret_from_fork+0x10/0x20
> >>
> >> Based on the above trace it looks like a double free of "pp->bridge"
> >> structure.
> >>
> >> Also, which kernel version are you using? Because from above third
> >> trace it looks like that dw_pcie_host_deinit() calls first
> >> pci_remove_root_bus() function and then (from first strace) it also
> >> calls pci_bus_release_domain_nr() function.

It's all the same stack trace. The struct pci_bus is a struct device
which is released first and then accessed by
of_pci_bus_release_domain_nr().

> > I have definitely seen this with v6.2. I was doing some more testing an=
d
> >   now it appears that the issue is somewhat intermittent. So now I am n=
o
> > longer confident that reverting this change does fix it. The backtrace
> > made it seem like this is a likely candidate, but I need to do more
> > testing.
>
>
> OK, so I have done some more testing. I found that if I build the
> Tegra194 PCIe driver into the kernel, then I can reproduce the above
> 100%. I guess by loading early there is more chance of a probe deferral.
> With that I verified that the issue is seen on v6.2 (as I previously
> observed) and on v6.3-rc3. Reverting this commit on top of v6.3-rc3
> fixes this and I no longer see the problem.
>
> Let me know if you have any thoughts on how to fix this.

Does this fix it?:

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 0145aef1b930..22d39e12b236 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -157,8 +157,6 @@ void pci_remove_root_bus(struct pci_bus *bus)
        list_for_each_entry_safe(child, tmp,
                                 &bus->devices, bus_list)
                pci_remove_bus_device(child);
-       pci_remove_bus(bus);
-       host_bridge->bus =3D NULL;

 #ifdef CONFIG_PCI_DOMAINS_GENERIC
        /* Release domain_nr if it was dynamically allocated */
@@ -166,6 +164,9 @@ void pci_remove_root_bus(struct pci_bus *bus)
                pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
 #endif

+       pci_remove_bus(bus);
+       host_bridge->bus =3D NULL;
+
        /* remove the host bridge */
        device_del(&host_bridge->dev);
 }
