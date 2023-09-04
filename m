Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33F791A6C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbjIDPSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjIDPSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 11:18:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D9E5B;
        Mon,  4 Sep 2023 08:18:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfXMd3Qfpz6K6lp;
        Mon,  4 Sep 2023 23:18:21 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 16:18:25 +0100
Date:   Mon, 4 Sep 2023 16:18:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alistair Francis <alistair23@gmail.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <lukas@wunner.de>, <alex.williamson@redhat.com>,
        <christian.koenig@amd.com>, <kch@nvidia.com>,
        <gregkh@linuxfoundation.org>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
        <rdunlap@infradead.org>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 3/3] PCI/DOE: Allow enabling DOE without CXL
Message-ID: <20230904161824.00001076@Huawei.com>
In-Reply-To: <20230904054329.865151-3-alistair.francis@wdc.com>
References: <20230904054329.865151-1-alistair.francis@wdc.com>
        <20230904054329.865151-3-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  4 Sep 2023 15:43:29 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> PCIe devices (not CXL) can support DOE as well, so allow DOE to be
> enabled even if CXL isn't.

But surely everyone enables CXL? :)

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v7:
>  - Initial patch
> 
>  drivers/pci/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 49bd09c7dd0a..a1223f46a902 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -117,7 +117,10 @@ config PCI_ATS
>  	bool
>  
>  config PCI_DOE
> -	bool
> +	bool "Enable PCI Data Object Exchange (DOE) support"
> +	help
> +	  Say Y here if you want be able to communicate with PCIe DOE
> +	  mailboxes.
>  
>  config PCI_ECAM
>  	bool

