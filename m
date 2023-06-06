Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC27247C1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbjFFPbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbjFFPbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 11:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE11E42;
        Tue,  6 Jun 2023 08:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C438F60C04;
        Tue,  6 Jun 2023 15:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF13DC433EF;
        Tue,  6 Jun 2023 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686065505;
        bh=uJ+f/1g64nLM6vK8nkih6sj/zYPzF9nEPV9ZNIsbsfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tSMP5tjVaEV6GhyMDWexp72WvnYgTocHQdtJVyYO9OwOeoj8gYoNZ6Ps2nYGtd24E
         4tFm5wsI4WkIC7yGUKDbBP+IWrYlcNV+9M9zXUOqkxO+gojlqGT+IzJom5EQo47ItE
         jWBOrYACowZSVhKmc1bTiarOxTR+ugtGFPgNtgzPNpLj0dBTTUDHNkJzQcVxLdujD3
         PzOwzUt6hdMVChwHvh/2Ifg6iQeY/LiFb/IOsTPkrSx4gQlKYoaz4Ty792RC2xmRNQ
         dDBICUZAts48KV06qluHEm2e/d7oVsYBUwQS5JkNMpSn0LB081U6Nzqiytu7aE211J
         nPLtUUHgJgFhA==
Date:   Tue, 6 Jun 2023 10:31:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v6 2/4] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Message-ID: <20230606153143.GA1124867@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606074938.97724-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 06, 2023 at 03:49:36PM +0800, Shuai Xue wrote:
> The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
> and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
> Vendor ID to linux/pci_ids.h so that it can shared by several drivers
> later.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
