Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA8618720
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiKCSJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKCSJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 14:09:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77C10B5;
        Thu,  3 Nov 2022 11:09:20 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3BW24vbXz67xV0;
        Fri,  4 Nov 2022 02:05:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:09:17 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 18:09:17 +0000
Date:   Thu, 3 Nov 2022 18:09:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <bwidawsk@kernel.org>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221103180916.00000bae@Huawei.com>
In-Reply-To: <20221103001833.n2gsoflnji3pcsfr@offworld>
References: <20221024133633.00000467@huawei.com>
        <20221025232535.GA579167@bhelgaas>
        <20221102171524.thsz2kwtirhxn7ee@offworld>
        <Y2MAdaCES+aUc2QH@iweiny-desk3>
        <20221103001833.n2gsoflnji3pcsfr@offworld>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2 Nov 2022 17:18:33 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 02 Nov 2022, Ira Weiny wrote:
> 
> >On Wed, Nov 02, 2022 at 10:15:24AM -0700, Davidlohr Bueso wrote:  
> >> Most CXL features that can have irqs will normally use only the first 16,
> >> with the exception of isolation (cxl 3.0), which per the spec is up to 32.  
> >
> >Dan, Dave, and I were discussing this and we agree.  For now the only things
> >people are working on are within the first 16 so why not just request 16 as the
> >max for now?  
> 
> It is a fair compromise, yes.

works for me.
