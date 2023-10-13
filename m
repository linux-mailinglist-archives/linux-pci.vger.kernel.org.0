Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8C7C808B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJMIlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJMIlT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 04:41:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B50B8;
        Fri, 13 Oct 2023 01:41:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S6Kg01Yz1z6H6pg;
        Fri, 13 Oct 2023 16:39:08 +0800 (CST)
Received: from localhost (10.126.172.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 13 Oct
 2023 09:41:14 +0100
Date:   Fri, 13 Oct 2023 09:41:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <chengyou@linux.alibaba.com>,
        <kaishen@linux.alibaba.com>, <yangyicong@huawei.com>,
        <will@kernel.org>, <baolin.wang@linux.alibaba.com>,
        <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>,
        <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH v7 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231013094113.00003d72@Huawei.com>
In-Reply-To: <a2265967-5088-7f17-35e5-29bf1c85c15f@linux.alibaba.com>
References: <20231012162512.GA1069387@bhelgaas>
        <a2265967-5088-7f17-35e5-29bf1c85c15f@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.172.163]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> >   
> >> +	depends on (ARM64 && PCI)  
> > 
> > I don't see any actual ARM64 dependency in the code, so maybe omit
> > ARM64 (as PCIE_DW_PLAT_HOST does) or add "|| COMPILE_TEST"?  
> 
> I will remove the ARM64 dependency and add COMPILE_TEST.
don't do both.  That makes no sense. either

	depends on PCI && (ARM64 || COMPILE_TEST)
or
	depends on PCI

