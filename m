Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3854D640BC1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiLBRHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 12:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiLBRHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 12:07:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64B13D6C
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 09:07:44 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNzrY3Qpjz67yFy;
        Sat,  3 Dec 2022 01:07:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 18:07:40 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 17:07:39 +0000
Date:   Fri, 2 Dec 2022 17:07:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] PCI: Distribute resources for root buses
Message-ID: <20221202170738.000053d8@Huawei.com>
In-Reply-To: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
References: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Nov 2022 13:22:19 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi all,
> 
> This is third iteration of the patch series trying to solve the problem
> reported by Chris Chiu [1]. In summary the current resource
> distribution code does not cover the initial device enumeration so if we
> find unconfigured bridges they get the bare minimum.
> 
> This one tries to be slightly more generic and deal with PCI devices in
> addition to PCIe. I've tried this on a system with Maple Ridge
> Thunderbolt controller (the same as in the orignal bug report), on QEMU
> with similar PCI topology using following parameters:
> 
> 	-device pcie-pci-bridge,id=br1					\
> 	-device e1000,bus=br1,addr=2					\
> 	-device pci-bridge,chassis_nr=1,bus=br1,shpc=off,id=br2,addr=3	\
> 	-device e1000,bus=br1,addr=4					\
> 	-device e1000,bus=br2
> 
> Then on a QEMU similar to what Jonathan used when he found out the
> regression with multifunction devices:
> 
> 	-device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
> 	-device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
> 	-device e1000,bus=root_port13,addr=0.1				\
> 	-device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
> 	-device e1000,bus=fun1
> 
> The previous versions of the series can be found:
> 
> v2: https://lore.kernel.org/linux-pci/20221114115953.40236-1-mika.westerberg@linux.intel.com/
> v1: https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/
> 
> Changes from v2:
>   * Make both patches to work with PCI devices too (do not expect that
>     the bridge is always first device on the bus).
>   * Allow distribution with bridges that do not have all resource
>     windows programmed (thereofore the pathch 2/2 is not revert anymore)

patch

>   * I did not add the tags from Rafael and Jonathan because the code is
>     not exactly the same anymore so was not sure if they still apply.

Fair enough - guess it's time for another look.

> 
> Changes from v1:
>   * Re-worded the commit message to hopefully explain the problem better
>   * Added Link: to the bug report
>   * Update the comment according to Bjorn's suggestion
>   * Dropped the ->multifunction check
>   * Use %#llx in log format.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216000
> 
> Mika Westerberg (2):
>   PCI: Take other bus devices into account when distributing resources
>   PCI: Distribute available resources for root buses too
> 
>  drivers/pci/setup-bus.c | 122 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 117 insertions(+), 5 deletions(-)
> 

