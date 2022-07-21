Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8F57D266
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 19:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiGURXA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 21 Jul 2022 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGURW6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 13:22:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872AE2F3B3;
        Thu, 21 Jul 2022 10:22:56 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LpfSX1xQnz6J66g;
        Fri, 22 Jul 2022 01:19:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 19:22:54 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Jul
 2022 18:22:53 +0100
Date:   Thu, 21 Jul 2022 18:22:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/28] CXL PMEM Region Provisioning
Message-ID: <20220721182252.0000227f@huawei.com>
In-Reply-To: <62d97efa7ec7a_17f3e8294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <20220721155907.0000708c@huawei.com>
        <62d97efa7ec7a_17f3e8294b4@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Jul 2022 09:29:46 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 14 Jul 2022 17:00:41 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > 
> > Hi Dan,
> > 
> > I'm low on time unfortunately and will be OoO for next week,
> > But whilst fixing a bug in QEMU, I set up a test to exercise
> > the high port target register on the hb with
> > 
> > CFMWS interleave ways = 1
> > hb with 8 rp with a type3 device connected to each.
> > 
> > The resulting interleave granularity isn't what I'd expect to see.
> > Setting region interleave to 1k (which happens to match the CFMWS)
> > I'm getting 1k for the CFMWS, 2k for the hb and 256 bytes for the type3
> > devices.  Which is crazy...  Now there may be another bug lurking
> > in QEMU so this might not be a kernel issue at all.  
> 
> Potentially, I will note that there seems to be a QEMU issue, that I
> have not had time to dig into, that is preventing region creation
> compared to other environments, maybe this is it...
> 

Fwiw, proposed QEMU fix is this.  One of those where I'm not sure how
it gave the impression of working previously.

From 64c6566601c782e91eafe48eb28711e4bb85e8d0 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 21 Jul 2022 13:29:59 +0100
Subject: [PATCH] hw/cxl: Fix wrong query of target ports.

Two issues in this code:
1) Check on which register to look in was inverted.
2) Both branches read the _LO register.

Whilst here moved to extract32() rather than hand rolling
the field extraction as simpler and hopefully less error prone.

Fixes Coverity CID: 1488873

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index faa68ef038..1adf61231a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -104,7 +104,6 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     uint32_t ctrl;
     uint32_t ig_enc;
     uint32_t iw_enc;
-    uint32_t target_reg;
     uint32_t target_idx;

     ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
@@ -116,14 +115,13 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
     target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);

-    if (target_idx > 4) {
-        target_reg = cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO];
-        target_reg >>= target_idx * 8;
+    if (target_idx < 4) {
+        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO],
+                            target_idx * 8, 8);
     } else {
-        target_reg = cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO];
-        target_reg >>= (target_idx - 4) * 8;
+        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_HI],
+                            (target_idx - 4) * 8, 8);
     }
-    *target = target_reg & 0xff;

     return true;
 }
--
2.32.0



> > For this special case we should be ignoring the CFMWS IG
> > as it's irrelevant if we aren't interleaving at that level.
> > We also know we don't have any address bits used for interleave
> > decoding until the HB.  
> 
> ...but I am certain that the drvier implementation is not accounting for
> the freedom to specify any granularity when the CFMWS interleave is x1.
> Will craft an incremental fix.

