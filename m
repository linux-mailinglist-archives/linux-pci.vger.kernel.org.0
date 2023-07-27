Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECD764E6B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjG0I7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjG0I7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 04:59:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B781230D6;
        Thu, 27 Jul 2023 01:39:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RBPHM1ttYz6J6k7;
        Thu, 27 Jul 2023 16:35:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 09:38:58 +0100
Date:   Thu, 27 Jul 2023 09:38:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Alistair Francis <alistair23@gmail.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alistair Francis" <alistair.francis@wdc.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230727093857.000017aa@Huawei.com>
In-Reply-To: <20230725163046.GA23990@wunner.de>
References: <20230725035755.2621507-1-alistair.francis@wdc.com>
        <20230725163046.GA23990@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jul 2023 18:30:46 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Jul 25, 2023 at 01:57:55PM +1000, Alistair Francis wrote:
> > The PCIe 6 specification added support for the Data Object Exchange (DOE).
> > When DOE is supported the Discovery Data Object Protocol must be
> > implemented. The protocol allows a requester to obtain information about
> > the other DOE protocols supported by the device.
> > 
> > The kernel is already querying the DOE protocols supported and cacheing
> > the values. This patch exposes the values via sysfs. This will allow
> > userspace to determine which DOE protocols are supported by the PCIe
> > device.  
> 
> Just dumping the list of supported protocols into dmesg might be simpler,
> unless you intend to add mechanisms to actually use certain DOE mailboxes
> from user space or expose the information in lspci.  Do have plans for
> either of that or what's the motivation to use sysfs?
> 

I can answer this one in rather than waiting for Alastair to see it
(given I was involved in shooting down the earlier proposal :(

At least partly motivated by providing the info for lspci which
I agree with being a useful addition for debug etc.
https://github.com/pciutils/pciutils/pull/152

I can see it would also be useful for things that will poke from
userspace because they aren't expected to run in production (and hence
hopefully don't care about potential races etc). CXL compliance
comes to mind - I don't think we ever want to carry kernel code for that.

Jonathan



> I think I'd rather want everything in doe.c (#ifdef'ed to CONFIG_SYSFS)
> and only make dev_attr_doe_proto public.
> 
> Thanks,
> 
> Lukas
> 

