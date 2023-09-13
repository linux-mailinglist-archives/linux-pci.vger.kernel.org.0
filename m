Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42779E8F8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjIMNRP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Sep 2023 09:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbjIMNRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 09:17:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EA01BDF;
        Wed, 13 Sep 2023 06:17:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1894wBgz6D9BZ;
        Wed, 13 Sep 2023 21:12:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 14:17:04 +0100
Date:   Wed, 13 Sep 2023 14:17:03 +0100
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
Subject: Re: [PATCH v2 09/10] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET()
 instead of custom defines/code
Message-ID: <20230913141703.000078e2@Huawei.com>
In-Reply-To: <20230913122748.29530-10-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
        <20230913122748.29530-10-ilpo.jarvinen@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Sep 2023 15:27:47 +0300
Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> e1000e has own copy of PCI Negotiated Link Width field defines. Use the
> one from include/uapi/linux/pci_regs.h instead of the custom ones and
> remove the custom ones. Also convert to use FIELD_GET().
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/net/ethernet/intel/e1000e/defines.h | 2 --
>  drivers/net/ethernet/intel/e1000e/mac.c     | 7 ++++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index 63c3c79380a1..a4d29c9e03a6 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -681,8 +681,6 @@
>  #define PCIE_LINK_STATUS             0x12
>  
>  #define PCI_HEADER_TYPE_MULTIFUNC    0x80
> -#define PCIE_LINK_WIDTH_MASK         0x3F0
> -#define PCIE_LINK_WIDTH_SHIFT        4
>  
>  #define PHY_REVISION_MASK      0xFFFFFFF0
>  #define MAX_PHY_REG_ADDRESS    0x1F  /* 5 bit address bus (0-0x1F) */
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index 5df7ad93f3d7..5340cf73778d 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 1999 - 2018 Intel Corporation. */
>  
> +#include <linux/bitfield.h>
> +
>  #include "e1000.h"
>  
>  /**
> @@ -25,9 +27,8 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
>  		pci_read_config_word(adapter->pdev,
>  				     cap_offset + PCIE_LINK_STATUS,
>  				     &pcie_link_status);
> -		bus->width = (enum e1000_bus_width)((pcie_link_status &
> -						     PCIE_LINK_WIDTH_MASK) >>
> -						    PCIE_LINK_WIDTH_SHIFT);
> +		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
> +							     pcie_link_status);
>  	}
>  
>  	mac->ops.set_lan_id(hw);

