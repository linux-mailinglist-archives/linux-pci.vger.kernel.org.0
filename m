Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150E072496A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjFFQna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbjFFQnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 12:43:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160110EA;
        Tue,  6 Jun 2023 09:43:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbGSg50v1z6D8rj;
        Wed,  7 Jun 2023 00:41:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 17:43:06 +0100
Date:   Tue, 6 Jun 2023 17:43:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH v4 5/5] hwtracing: hisi_ptt: Fix potential sleep in
 atomic context
Message-ID: <20230606174305.00005a10@Huawei.com>
In-Reply-To: <20230606142244.10939-6-yangyicong@huawei.com>
References: <20230606142244.10939-1-yangyicong@huawei.com>
        <20230606142244.10939-6-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 6 Jun 2023 22:22:44 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> We're using pci_irq_vector() to obtain the interrupt number and then
> bind it to the CPU start perf under the protection of spinlock in
> pmu::start(). pci_irq_vector() might sleep since [1] because it will
> call msi_domain_get_virq() to get the MSI interrupt number and it
> needs to acquire dev->msi.data->mutex. Getting a mutex will sleep on
> contention. So use pci_irq_vector() in an atomic context is problematic.
> 
> This patch cached the interrupt number in the probe() and uses the
> cached data instead to avoid potential sleep.
> 
> [1] commit 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

