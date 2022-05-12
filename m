Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518B5524A19
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351065AbiELKPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 06:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiELKPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 06:15:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C11ACF91;
        Thu, 12 May 2022 03:15:32 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KzSG90PzVz6H7Ps;
        Thu, 12 May 2022 18:10:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 12:15:30 +0200
Received: from localhost (10.81.210.133) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 11:15:29 +0100
Date:   Thu, 12 May 2022 11:15:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Jonathan Lemon <jonathan.lemon@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Len Brown <lenb@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] : Revert "ACPI: Remove side effect of partly creating a
 node in acpi_get_node()"
Message-ID: <20220512111525.0000570e@Huawei.com>
In-Reply-To: <CAJZ5v0hSJExYtxEZuw-+ZUf1YoZesOtS+x9UbdoBNXtTKPiYxg@mail.gmail.com>
References: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
        <CAJZ5v0jHDNBqCfmgyLUOs7yUZaEjQ96m5HVZKHP3x7_uamH5zQ@mail.gmail.com>
        <7A00774E-13F2-4FB4-9979-D7827C92F5B8@gmail.com>
        <CAJZ5v0hSJExYtxEZuw-+ZUf1YoZesOtS+x9UbdoBNXtTKPiYxg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.133]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 May 2022 19:44:14 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, May 11, 2022 at 7:42 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
> >
> > On 11 May 2022, at 10:33, Rafael J. Wysocki wrote:
> >  
> > > On Wed, May 11, 2022 at 7:24 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:  
> > >>
> > >> This reverts commit a62d07e0006a3a3ce77041ca07f3c488ec880790.
> > >>
> > >> The change calls pxm_to_node(), which ends up returning -1
> > >> (NUMA_NO_NODE) on some systems for the pci bus, as opposed
> > >> to the prior call to acpi_map_pxm_to_node(), which returns 0.
> > >>
> > >> The default numa node is then inherited by all pci devices, and is
> > >> visible in /sys/bus/pci/devices/*/numa_node
> > >>
> > >> The prior behavior shows:
> > >>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
> > >>      122 0
> > >>
> > >> While the new behavior has:
> > >>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
> > >>        1 0

Curious, which device is turning up in node 0?

> > >>      121 -1
> > >>
> > >> While arguably NUMA_NO_NODE is correct on single-socket systems which
> > >> have only one numa domain, this breaks scripts that attempt to read the
> > >> NIC numa_node and pass that to numactl in order to pin memory allocation
> > >> when running applications (like iperf).  E.g.:
> > >>
> > >>   # numactl -p -1 iperf3
> > >>   libnuma: Warning: node argument -1 is out of range
> > >>   <-1> is invalid
> > >>
> > >> Reverting this change restores the prior behavior.  
> > >
> > > Well, that's not a recent commit and it fixed a real and serious issue.
> > >
> > > Isn't there a way to fix this other than reverting it?  
> >
> > The userspace behavior changed - is there another way to fix things
> > so that a valid numa_node is returned?  
> 
> Well, that's my question.

As Rafael noted, we don't want to change the internal kernel representation because
previous kernel behavior resulting in several paths where you could
get NULL pointer de-references, but maybe we could special case
it at the userspace boundary.

e.g. override dev_to_node() return value here
https://elixir.bootlin.com/linux/v5.18-rc6/source/drivers/pci/pci-sysfs.c#L358

What's problematic is we missed this being being an issue until now and hence
have shipping kernels with both behaviors.

+CC Bjorn and linux-pci

Jonathan



