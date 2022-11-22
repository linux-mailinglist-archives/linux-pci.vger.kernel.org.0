Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4BA633E24
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 14:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiKVNxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 08:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiKVNxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 08:53:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390C654EB;
        Tue, 22 Nov 2022 05:53:31 -0800 (PST)
Received: from frapeml500001.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGlvz3CzMz67Dr3;
        Tue, 22 Nov 2022 21:48:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500001.china.huawei.com (7.182.85.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:53:29 +0100
Received: from localhost (10.45.149.88) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 13:53:28 +0000
Date:   Tue, 22 Nov 2022 13:53:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH 1/2] hwtracing: hisi_ptt: Only add the supported devices
 to the filters list
Message-ID: <20221122135327.000004d8@Huawei.com>
In-Reply-To: <20221122120209.25682-1-yangyicong@huawei.com>
References: <20221122120209.25682-1-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.88]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Tue, 22 Nov 2022 20:02:08 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PTT device can only support the devices on the same PCIe core,
> within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
> the devices on the root bus are from the same PCIe core, there are
> cases that root ports from different PCIe core are sharing the same
> bus. So add the checking when initialize the filters list.
> 
> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Make sense to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 5d5526aa60c4..30f1525639b5 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -356,8 +356,18 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>  
>  static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>  {
> +	struct pci_dev *root_port = pcie_find_root_port(pdev);
>  	struct hisi_ptt_filter_desc *filter;
>  	struct hisi_ptt *hisi_ptt = data;
> +	u32 port_devid;
> +
> +	if (!root_port)
> +		return 0;
> +
> +	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
> +	if (port_devid < hisi_ptt->lower_bdf ||
> +	    port_devid > hisi_ptt->upper_bdf)
> +		return 0;
>  
>  	/*
>  	 * We won't fail the probe if filter allocation failed here. The filters

