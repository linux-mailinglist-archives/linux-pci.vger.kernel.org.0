Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C27C50B0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjJKK7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346550AbjJKK7W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 06:59:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8792;
        Wed, 11 Oct 2023 03:59:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S58p76fjtz67f4J;
        Wed, 11 Oct 2023 18:56:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 11:59:18 +0100
Date:   Wed, 11 Oct 2023 11:59:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Nirmoy Das" <nirmoy.das@amd.com>
Subject: Re: [PATCH 02/10] PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse
 quirk
Message-ID: <20231011115917.00001811@Huawei.com>
In-Reply-To: <20231010204436.1000644-3-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
        <20231010204436.1000644-3-helgaas@kernel.org>
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

On Tue, 10 Oct 2023 15:44:28 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Separate because this isn't as trivial as the other FIELD_GET() changes.
> 
> See 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT
> Pulse")
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nirmoy Das <nirmoy.das@amd.com>

Change would be a tiny bit more obvious without the early return, but I can see
why you think that is an improvement over relying on the return just below.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 848c9ee65d7f..5dc6e7cdfb71 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3751,14 +3751,14 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>  		return 0;
>  
>  	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
> -	cap &= PCI_REBAR_CAP_SIZES;
> +	cap = FIELD_GET(PCI_REBAR_CAP_SIZES, cap);
>  
>  	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>  	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
> -	    bar == 0 && cap == 0x7000)
> -		cap = 0x3f000;
> +	    bar == 0 && cap == 0x700)
> +		return 0x3f00;
>  
> -	return cap >> 4;
> +	return cap;
>  }
>  EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>  

