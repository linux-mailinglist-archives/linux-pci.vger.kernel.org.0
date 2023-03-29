Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEEA6CEE6E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC2QBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjC2QB2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 12:01:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661765AF;
        Wed, 29 Mar 2023 09:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CECAFB82381;
        Wed, 29 Mar 2023 16:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF53C4339E;
        Wed, 29 Mar 2023 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105600;
        bh=rjQxDxCR/O6zKa08+oV1tEr6vgekeh2UeTJ+FndCkzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z7EDsclj0fBD8N3wk/EsFLwjrE3gVBO6o8hUfImuFxQIyMgY2RYBcR4tqr+oqRI37
         Z4bI9n0TEYD9jff2WrBl/WAYj34egYCIylADWRTXSLpKvsGPaAUxeCKdCxH3eNTIIc
         fjcvop67uQVEAZVFFFRVrSqa3hBvdNemQANFucTXUf1L09TWClec7Ys6QogTjFpiyp
         giDAX5SQ7ChmFfsrparBg8hyzNUKKN6TPY9MasRGLp546ukXB47w5xBSXK2YYYgWs/
         McMUiL0T/cuHvsGl4FuL+ezY6nKDw0AwHJeMtJD7W7C23FAt64aM65uoTMCl/g6iWB
         mgHOfvJr2vXSw==
Received: by mail-yb1-f178.google.com with SMTP id e65so19887236ybh.10;
        Wed, 29 Mar 2023 09:00:00 -0700 (PDT)
X-Gm-Message-State: AAQBX9e+qxs6Yu1J/WcMZyrg9QqaO5Zt9WM7R0GK/cKIWX9//B/ZKzUM
        GgpKH7JvbG915W01D+XKEjxW8ztQd3vNo0HdUg==
X-Google-Smtp-Source: AKy350bNMRrNnhD+9tcWZMsoKhxrrm0S91c7XAydl/YjKZVnxQbMwJ7oUt7Xe/yyPeIXq4nCu/SBUnBC2EOMFaWxRdk=
X-Received: by 2002:a05:6902:1204:b0:b77:ae4b:1b27 with SMTP id
 s4-20020a056902120400b00b77ae4b1b27mr9713848ybu.8.1680105599372; Wed, 29 Mar
 2023 08:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230329123835.2724518-1-robh@kernel.org> <ef81c9cf-afc6-a186-1984-073030be9b5d@linux.intel.com>
In-Reply-To: <ef81c9cf-afc6-a186-1984-073030be9b5d@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:59:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLLx4chuYDV8eZUTHqCLJ1AbAWg8Ow7w6k2h76FzqEOZw@mail.gmail.com>
Message-ID: <CAL_JsqLLx4chuYDV8eZUTHqCLJ1AbAWg8Ow7w6k2h76FzqEOZw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix use-after-free in pci_bus_release_domain_nr()
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 29, 2023 at 10:13=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 3/29/23 5:38 AM, Rob Herring wrote:
> > Commit c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > introduced a use-after-free bug in the bus removal cleanup. The issue
> > was found with kfence:
> >
> > [   19.285870] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   19.293351] BUG: KFENCE: use-after-free read in pci_bus_release_doma=
in_nr+0x10/0x70
> >
> > [   19.302817] Use-after-free read at 0x000000007f3b80eb (in kfence-#11=
5):
> > [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
> > [   19.309691]  dw_pcie_host_deinit+0x28/0x78
> > [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
> > [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
> > [   19.309752]  platform_probe+0x90/0xd8
> > [   19.309764]  really_probe+0xb8/0x298
> > [   19.309777]  __driver_probe_device+0x78/0xd8
> > [   19.309788]  driver_probe_device+0x38/0x120
> > [   19.309799]  __device_attach_driver+0x94/0xe0
> > [   19.309812]  bus_for_each_drv+0x70/0xc8
> > [   19.309822]  __device_attach+0xfc/0x188
> > [   19.309833]  device_initial_probe+0x10/0x18
> > [   19.309844]  bus_probe_device+0x94/0xa0
> > [   19.309854]  deferred_probe_work_func+0x80/0xb8
> > [   19.309864]  process_one_work+0x1e0/0x348
> > [   19.309882]  worker_thread+0x48/0x410
> > [   19.309891]  kthread+0xf4/0x110
> > [   19.309904]  ret_from_fork+0x10/0x20
> >
> > [   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, size=
=3D1072, cache=3Dkmalloc-2k
> >
> > [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
> > [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
> > [   19.311571]  kmalloc_trace+0x24/0x30
> > [   19.311580]  pci_alloc_bus+0x24/0xa0
> > [   19.311590]  pci_register_host_bridge+0x48/0x4b8
> > [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
> > [   19.311613]  pci_host_probe+0x18/0xc0
> > [   19.311623]  dw_pcie_host_init+0x2c0/0x568
> > [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
> > [   19.311647]  platform_probe+0x90/0xd8
> > [   19.311653]  really_probe+0xb8/0x298
> > [   19.311663]  __driver_probe_device+0x78/0xd8
> > [   19.311672]  driver_probe_device+0x38/0x120
> > [   19.311682]  __device_attach_driver+0x94/0xe0
> > [   19.311694]  bus_for_each_drv+0x70/0xc8
> > [   19.311702]  __device_attach+0xfc/0x188
> > [   19.311713]  device_initial_probe+0x10/0x18
> > [   19.311724]  bus_probe_device+0x94/0xa0
> > [   19.311733]  deferred_probe_work_func+0x80/0xb8
> > [   19.311743]  process_one_work+0x1e0/0x348
> > [   19.311753]  worker_thread+0x48/0x410
> > [   19.311763]  kthread+0xf4/0x110
> > [   19.311771]  ret_from_fork+0x10/0x20
> >
> > [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
> > [   19.311799]  release_pcibus_dev+0x30/0x40
> > [   19.311808]  device_release+0x30/0x90
> > [   19.311814]  kobject_put+0xa8/0x120
> > [   19.311832]  device_unregister+0x20/0x30
> > [   19.311839]  pci_remove_bus+0x78/0x88
> > [   19.311850]  pci_remove_root_bus+0x5c/0x98
> > [   19.311860]  dw_pcie_host_deinit+0x28/0x78
> > [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
> > [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
> > [   19.311900]  platform_probe+0x90/0xd8
> > [   19.311906]  really_probe+0xb8/0x298
> > [   19.311916]  __driver_probe_device+0x78/0xd8
> > [   19.311926]  driver_probe_device+0x38/0x120
> > [   19.311936]  __device_attach_driver+0x94/0xe0
> > [   19.311947]  bus_for_each_drv+0x70/0xc8
> > [   19.311956]  __device_attach+0xfc/0x188
> > [   19.311966]  device_initial_probe+0x10/0x18
> > [   19.311976]  bus_probe_device+0x94/0xa0
> > [   19.311985]  deferred_probe_work_func+0x80/0xb8
> > [   19.311995]  process_one_work+0x1e0/0x348
> > [   19.312005]  worker_thread+0x48/0x410
> > [   19.312014]  kthread+0xf4/0x110
> > [   19.312022]  ret_from_fork+0x10/0x20
> >
> > [   19.313579] CPU: 10 PID: 96 Comm: kworker/u24:2 Not tainted 6.2.0 #4
> > [   19.320171] Hardware name:  /, BIOS 1.0-d7fb19b 08/10/2022
> > [   19.325852] Workqueue: events_unbound deferred_probe_work_func
> > [   19.331919] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The stack trace is a bit misleading as dw_pcie_host_deinit() doesn't
> > directly call pci_bus_release_domain_nr(). The issue turns out to be in
> > pci_remove_root_bus() which first calls pci_remove_bus() which frees th=
e
> > struct pci_bus when its struct device is released. Then
> > pci_bus_release_domain_nr() is called and accesses the freed
> > struct pci_bus. Reordering these fixes the issue.
>
> Since time log is not useful, remove it and just add stack trace.

Actually, it was useful. It told me that the use-after-free happened
pretty much right after the free.

Bjorn likes to edit commit messages so I'll leave it up to him to
leave or change.

> Change looks good to me. But I am not sure whether pci_remove_bus()
> directly frees struct pci_bus or just removes the bus resources?

struct pci_bus embeds a struct device. The struct device is put which
causes the free of the struct pci_bus. So indirect in that the
refcounting triggers the free, but direct in that pci_remove_bus()
causes it.

Rob
