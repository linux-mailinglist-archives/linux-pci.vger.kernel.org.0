Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8A72495C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbjFFQkr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbjFFQkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 12:40:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3667E62;
        Tue,  6 Jun 2023 09:40:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbGPv1FYGz67Q5S;
        Wed,  7 Jun 2023 00:38:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 17:40:41 +0100
Date:   Tue, 6 Jun 2023 17:40:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH v4 2/5] hwtracing: hisi_ptt: Add support for dynamically
 updating the filter list
Message-ID: <20230606174041.00005a90@Huawei.com>
In-Reply-To: <20230606142244.10939-3-yangyicong@huawei.com>
References: <20230606142244.10939-1-yangyicong@huawei.com>
        <20230606142244.10939-3-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Tue, 6 Jun 2023 22:22:41 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PCIe devices supported by the PTT trace can be removed/rescanned by
> hotplug or through sysfs.  Add support for dynamically updating the
> available filter list by registering a PCI bus notifier block. Then user
> can always get latest information about available tracing filters and
> driver can block the invalid filters of which related devices no longer
> exist in the system.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

You've addressed everything I raised on v3, so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

