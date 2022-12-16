Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE364EB63
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 13:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiLPMZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 07:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPMZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 07:25:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2514D19;
        Fri, 16 Dec 2022 04:25:35 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NYSsX4n5Fz6J6J6;
        Fri, 16 Dec 2022 20:22:24 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 12:25:32 +0000
Date:   Fri, 16 Dec 2022 12:25:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 0/9] CXL: Process event logs
Message-ID: <20221216122531.00001bef@huawei.com>
In-Reply-To: <20221212070627.1372402-1-ira.weiny@intel.com>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Sun, 11 Dec 2022 23:06:18 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> This code has been tested with a newer qemu which allows for more events to be
> returned at a time as well an additional QMP event and interrupt injection.
> Those patches will follow once they have been cleaned up.
> 
> The series is now in 3 parts:
> 
> 	1) Base functionality including interrupts
> 	2) Tracing specific events (Dynamic Capacity Event Record is defered)
> 	3) cxl-test infrastructure for basic tests
> 
> Changes from V3
> 	Feedback from Dan
> 	Spit out ACPI changes for Bjorn
> 
> - Link to v3: https://lore.kernel.org/all/20221208052115.800170-1-ira.weiny@intel.com/

Because I'm in a grumpy mood (as my colleagues will attest!)...
This is dependent on the patch that moves the trace definitions and
that's not upstream yet except in cxl/preview which is optimistic
place to use for a base commit.  The id isn't the one below either which
isn't in either mailine or the current CXL trees.

Not that I actually checked the cover letter until it failed to apply
(and hence already knew what was missing) but still, please call out
dependencies unless they are in the branches Dan has queued up to push.

I just want to play with Dave's fix for the RAS errors so having to jump
through these other sets.

Thanks,

Jonathan

> 
> 
> Davidlohr Bueso (1):
>   cxl/mem: Wire up event interrupts
> 
> Ira Weiny (8):
>   PCI/CXL: Export native CXL error reporting control
>   cxl/mem: Read, trace, and clear events on driver load
>   cxl/mem: Trace General Media Event Record
>   cxl/mem: Trace DRAM Event Record
>   cxl/mem: Trace Memory Module Event Record
>   cxl/test: Add generic mock events
>   cxl/test: Add specific events
>   cxl/test: Simulate event log overflow
> 
>  drivers/acpi/pci_root.c       |   3 +
>  drivers/cxl/core/mbox.c       | 186 +++++++++++++
>  drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h             |  16 ++
>  drivers/cxl/cxlmem.h          | 171 ++++++++++++
>  drivers/cxl/cxlpci.h          |   6 +
>  drivers/cxl/pci.c             | 236 +++++++++++++++++
>  drivers/pci/probe.c           |   1 +
>  include/linux/pci.h           |   1 +
>  tools/testing/cxl/test/Kbuild |   2 +-
>  tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++
>  11 files changed, 1452 insertions(+), 1 deletion(-)
> 
> 
> base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e

