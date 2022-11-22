Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC8633E20
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 14:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiKVNwE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 08:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiKVNwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 08:52:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97557B66;
        Tue, 22 Nov 2022 05:52:00 -0800 (PST)
Received: from frapeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGlwz39M5z67NKF;
        Tue, 22 Nov 2022 21:49:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:51:56 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 13:51:55 +0000
Date:   Tue, 22 Nov 2022 13:51:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Update the entries for HiSilicon PTT
 device driver
Message-ID: <20221122135152.0000040a@Huawei.com>
In-Reply-To: <20221122120209.25682-2-yangyicong@huawei.com>
References: <20221122120209.25682-1-yangyicong@huawei.com>
        <20221122120209.25682-2-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.88]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Tue, 22 Nov 2022 20:02:09 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Add missing entries for the perf userspace part of this driver.
> Also add Jonathan as the maintainer for his expertise on this
> driver and PCIe stuffs.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2585e7edc335..de3d0a5d9cb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9263,11 +9263,15 @@ F:	drivers/perf/hisilicon/hns3_pmu.c
>  
>  HISILICON PTT DRIVER
>  M:	Yicong Yang <yangyicong@hisilicon.com>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-devices-hisi_ptt
>  F:	Documentation/trace/hisi-ptt.rst
>  F:	drivers/hwtracing/ptt/
> +F:	tools/perf/arch/arm64/util/hisi-ptt.c
> +F:	tools/perf/util/hisi-ptt*
> +F:	tools/perf/util/hisi-ptt-decoder/*
>  
>  HISILICON QM DRIVER
>  M:	Weili Qian <qianweili@huawei.com>

