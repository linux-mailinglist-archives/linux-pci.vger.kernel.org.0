Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D857A2A1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiGSPHW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Jul 2022 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGSPHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 11:07:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000AD5005C;
        Tue, 19 Jul 2022 08:07:16 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnMWl0Fm3z67ykV;
        Tue, 19 Jul 2022 23:02:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 17:07:14 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 16:07:13 +0100
Date:   Tue, 19 Jul 2022 16:07:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <20220719160711.000078f9@Huawei.com>
In-Reply-To: <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
        <20220705154932.2141021-9-ira.weiny@intel.com>
        <62d043d8bd04c_16fb9729422@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
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

On Thu, 14 Jul 2022 09:27:04 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT read may fail for a number of reasons but mainly it is possible
> > to get different parts of a valid state.  The checksum in the CDAT table
> > protects against this.  
> 
> I don't know what "different parts of a valid state" means. The CDAT
> should not be changing as it is being read unless someone is issuing a
> set-partition while the DOE operation is happening.

Unfortunately not true. The device is allowed to change it with no input
from OS software at all.

From CDAT spec

"For Revision=1, the following changes are permitted during the
runtime
• Changes to the latency and bandwidth fields in DSLBIS
• Changes to the latency and bandwidth fields in SSLBIS
• Changes to the number of DSEMTS instances and their
contents
The changes to latency and bandwidth may represent events such
as failover or degradation that are internal to a component."

> Rather than
> arbitrary retries, block out set-partition while CDAT is being read.

Blocking that out is still useful even though we probably still need retries.

> 
> You can use {set,clear}_exclusive_cxl_commands() to temporarily lock out
> set-partition while the CDAT read is happening.
> 
> ...and since this series is only for enabling 

