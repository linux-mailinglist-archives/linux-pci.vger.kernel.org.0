Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4908709AEF
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjESPK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjESPKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 11:10:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB299E52;
        Fri, 19 May 2023 08:10:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN9Gq38kWz67fpR;
        Fri, 19 May 2023 23:09:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 16:10:15 +0100
Date:   Fri, 19 May 2023 16:10:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     LiuLele <liu.lele@qq.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <bhelgaas@google.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <helgaas@kernel.org>, <ira.weiny@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <rostedt@goodmis.org>, <vishal.l.verma@intel.com>
Subject: Re: CXL memory device not created correctly
Message-ID: <20230519161014.00003002@Huawei.com>
In-Reply-To: <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
References: <cec6a8f5-a284-4f46-1ada-4edd625a9a2e@intel.com>
        <tencent_D9D9D358330CA573E23D490C6EE13E0DC105@qq.com>
        <gbsxrcjtnf67jxpqmbn57nqoslpmjtuk2ycatmau3vfsmpvbrd@c2umpofn2hti>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 May 2023 18:38:46 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 19 May 2023, LiuLele wrote:
> 
> >In my testing CXL device /sys/bus/cxl/devices/mem0  not created, and the get error messages :
> >
> >```
> >cxl_pci 0000:0d:00.0: Failed to get interrupt for event Info log
> >```
> >
> >My test environment is a qemu CXL emulator with qemu v8.0.0, Linux kernel v6.3.0.
> >While with kernel 5.9.13,  /sys/bus/cxl/devices/mem0  can be created.  
> 
> Yes, this can be annoying and would argue the probe should not error out.
> Regardless, the actual qemu support is in Jonathan's tree:
> 
> https://gitlab.com/jic23/qemu/-/commit/a04e6476df363d1f6bc160577b30dda6564d3f67

That just failed to make it into an upstream pull request today due to some
bugs in a the poison list set that came before it :( 

v6 or poison list and events support are both on list now and hopefully will make
this QEMU cycle so be in 8.1

Jonathan


> 
> Thanks,
> Davidlohr

