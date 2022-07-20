Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4DD57BCA6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiGTR3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiGTR3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 13:29:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2D6EEAC;
        Wed, 20 Jul 2022 10:29:48 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp2hw1yRjz67ms2;
        Thu, 21 Jul 2022 01:28:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Jul 2022 19:29:45 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 18:29:45 +0100
Date:   Wed, 20 Jul 2022 18:29:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@lst.de>, <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 23/28] cxl/region: Attach endpoint decoders
Message-ID: <20220720182941.00004300@Huawei.com>
In-Reply-To: <165784337277.1758207.4108508181328528703.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <165784337277.1758207.4108508181328528703.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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

On Thu, 14 Jul 2022 17:02:52 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL regions (interleave sets) are made up of a set of memory devices
> where each device maps a portion of the interleave with one of its
> decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
> As endpoint decoders are identified by a provisioning tool they can be
> added to a region provided the region interleave properties are set
> (way, granularity, HPA) and DPA has been assigned to the decoder.
> 
> The attach event triggers several validation checks, for example:
> - is the DPA sized appropriately for the region
> - is the decoder reachable via the host-bridges identified by the
>   region's root decoder
> - is the device already active in a different region position slot
> - are there already regions with a higher HPA active on a given port
>   (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)
> 
> ...and the attach event affords an opportunity to collect data and
> resources relevant to later programming the target lists in switch
> decoders, for example:
> - allocate a decoder at each cxl_port in the decode chain
> - for a given switch port, how many the region's endpoints are hosted
>   through the port
> - how many unique targets (next hops) does a port need to map to reach
>   those endpoints
> 
> The act of reconciling this information and deploying it to the decoder
> configuration is saved for a follow-on patch.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
All the review comment resolutions from v1 look good to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
