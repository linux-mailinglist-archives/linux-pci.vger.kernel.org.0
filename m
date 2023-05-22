Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5E70C2F2
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjEVQEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjEVQEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 12:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B657107;
        Mon, 22 May 2023 09:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8535660C84;
        Mon, 22 May 2023 16:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE75EC433D2;
        Mon, 22 May 2023 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684771468;
        bh=meCLncrPuvhB8KcjkV9KWGZpz0fPVtjBdsvKv08SZtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bHliJYeh3Oqqx8c9Pg29FiV3v69DnPVp/wVrct28320nrTV2RpzS13wdax/2CYBgU
         VDEvyOKmuVL62/LFIooupTxO9DNe1KRk6khLrfwEyj7dgdbfiX4QGdbKgMbODI8akn
         OrFv6pNCB2MYYwixCplUlKnIIhBihnjaDA84XeuGpYMOrghLmJRJX5z6jFgATOfU0y
         FycubCFq/HmTtRl3C+OD81vQIsWNZloUt3X+jnREZKYRcDUqhCaFt3sINoZcRyC7+c
         AY5csoLyYWOCs0bg/f0ngxedT9ZHPBpMnk/NFGD2aQnZS0JGPDOpoy0q+xmCvd27ga
         Dk2AGM2xgfBzQ==
Date:   Mon, 22 May 2023 11:04:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v5 2/4] PCI: move Alibaba Vendor ID linux/pci_ids.h
Message-ID: <ZGuSimj1cuQl3W5L@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522035428.69441-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please follow subject line capitalization style (learn it with "git
log --oneline include/linux/pci_ids.h"):

  PCI: Add Alibaba Vendor ID

On Mon, May 22, 2023 at 11:54:26AM +0800, Shuai Xue wrote:
> Move Alibaba Vendor ID (0x1ded) to linux/pci_ids.h so that it can shared by
> several drivers.

It would be helpful for reviewers to list the drivers here, since only
one is obvious from the patch.

Thanks for sorting the entry correctly!

> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_hw.h | 2 --
>  include/linux/pci_ids.h                | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
> index 76ce2856be28..ee35ebef9ee7 100644
> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
> @@ -11,8 +11,6 @@
>  #include <linux/types.h>
>  
>  /* PCIe device related definition. */
> -#define PCI_VENDOR_ID_ALIBABA 0x1ded
> -
>  #define ERDMA_PCI_WIDTH 64
>  #define ERDMA_FUNC_BAR 0
>  #define ERDMA_MISX_BAR 2
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 95f33dadb2be..9e8aec472f06 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2586,6 +2586,8 @@
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>  
> +#define PCI_VENDOR_ID_ALIBABA		0x1ded
> +
>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> -- 
> 2.20.1.12.g72788fdb
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
