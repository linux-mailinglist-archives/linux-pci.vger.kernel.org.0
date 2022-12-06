Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9987F644236
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiLFLec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 06:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLFLeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 06:34:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB33664FB;
        Tue,  6 Dec 2022 03:34:30 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRJFv3nNKzmWBc;
        Tue,  6 Dec 2022 19:33:39 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 19:34:27 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>,
        <suzuki.poulose@arm.com>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 1/2] hwtracing: hisi_ptt: Only add the supported devices
 to the filters list
To:     <mathieu.poirier@linaro.org>
References: <20221122120209.25682-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <fb2441ce-fe4c-3733-5cd3-93a7d949d9f0@huawei.com>
Date:   Tue, 6 Dec 2022 19:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221122120209.25682-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mathieu,

Do we still have a chance to catch this cycle for these 2 patches?

Thanks!

On 2022/11/22 20:02, Yicong Yang wrote:
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
> 
