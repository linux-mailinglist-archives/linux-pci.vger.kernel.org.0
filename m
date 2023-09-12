Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5B79CE9A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjILKoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Sep 2023 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjILKoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 06:44:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5E1FF6;
        Tue, 12 Sep 2023 03:34:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlKZZ4gLPz6J7jc;
        Tue, 12 Sep 2023 18:29:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 11:34:04 +0100
Date:   Tue, 12 Sep 2023 11:34:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] igb: Use FIELD_GET() to extract Link Width
Message-ID: <20230912113403.00006c39@Huawei.com>
In-Reply-To: <20230911121501.21910-4-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
        <20230911121501.21910-4-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Sep 2023 15:14:56 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_mac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
> index caf91c6f52b4..5a23b9cfec6c 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_mac.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2007 - 2018 Intel Corporation. */
>  
> +#include <linux/bitfield.h>
>  #include <linux/if_ether.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> @@ -50,9 +51,8 @@ s32 igb_get_bus_info_pcie(struct e1000_hw *hw)
>  			break;
>  		}
>  
> -		bus->width = (enum e1000_bus_width)((pcie_link_status &
> -						     PCI_EXP_LNKSTA_NLW) >>
> -						     PCI_EXP_LNKSTA_NLW_SHIFT);
> +		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
> +							     pcie_link_status);

This cast is a bit ugly given it takes the values 0, 1, 2, 3 and
we extra a field that the spec says contains 1, 2, 4, 8 etc
Hence it only works because only 1 and 2 are used I think...  Not nice.


Also, whilst looking at this I note that e1000e has it's own defines
for PCIE_LINK_WIDTH_MASK and PCIE_LINK_WIDTH_SHIFT 

Looks like those should be changed to use the standard defines.

For extra giggles there are two e1000_bus_width enum definitions in different
headers.

Actual patch is good - just 'interesting' stuff noticed whilst looking at it :)

Jonathan


>  	}
>  
>  	reg = rd32(E1000_STATUS);

