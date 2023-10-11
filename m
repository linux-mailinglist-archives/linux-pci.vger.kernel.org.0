Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D97C523F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjJKLhw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346422AbjJKLJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:09:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C53591;
        Wed, 11 Oct 2023 04:07:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S59102Kpcz6K62T;
        Wed, 11 Oct 2023 19:05:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:07:40 +0100
Date:   Wed, 11 Oct 2023 12:07:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
Message-ID: <20231011120739.00005d7d@Huawei.com>
In-Reply-To: <20231010204436.1000644-7-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
        <20231010204436.1000644-7-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Tue, 10 Oct 2023 15:44:32 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
A question about what 'rules' you are applying for using these macros
vs choosing not not do so. Personally I prefer using them even for
flag fields mostly because it makes the code more consistent and
the compiler should remove any unnecessary shifts that result.

> ---

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..a9fdc2e3f110 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6154,7 +6154,7 @@ static void dpc_log_size(struct pci_dev *dev)
>  	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))

This is what I'm commenting on below.

>  		return;
>  
> -	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
> +	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {

Why do this one and not the one just above?
In both cases extracting a field then comparing it to 0, I'm not sure
it makes sense to care if that field is 1 bit or multiple bit.

>  		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
>  		dev->dpc_rp_log_size = 4;
>  	}

