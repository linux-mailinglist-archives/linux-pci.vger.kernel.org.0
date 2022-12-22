Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1863D653D69
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 10:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiLVJVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 04:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVJVU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 04:21:20 -0500
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 01:21:18 PST
Received: from out-102.mta0.migadu.com (out-102.mta0.migadu.com [IPv6:2001:41d0:1004:224b::66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D89B1C9
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 01:21:18 -0800 (PST)
Message-ID: <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671700522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvqkcEhrk+31x6ylR2f9V4qr4sT6WSxNh1dY0eCIAOs=;
        b=XTVAAwsSdY6nHEMOBrzOgvN4x8AqzHZeORy/uoDdixW280qUcHCF+W3bpJavdLjOKCK89U
        Cm3nLGJvY6HLZV3fCpnfWRboZMTcoxdfO9S6rOlzBBLE1caL1tnTCFiTzuY6ILn7CZxwvi
        aJ9VjA37iMNgELJEqErmdnmXnu144tE=
Date:   Thu, 22 Dec 2022 02:15:20 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
To:     korantwork@gmail.com, nirmal.patel@linux.intel.com,
        lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20221222072603.1175248-1-korantwork@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/22/22 12:26 AM, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> Commit ee81ee84f873("PCI: vmd: Disable MSI-X remapping when possible")
> disable the vmd MSI-X remapping for optimizing pci performance.However,
> this feature severely negatively optimized performance in multi-disk
> situations.
> 
> In FIO 4K random test, we test 1 disk in the 1 CPU
> 
> when disable MSI-X remapping:
> read: IOPS=1183k, BW=4622MiB/s (4847MB/s)(1354GiB/300001msec)
> READ: bw=4622MiB/s (4847MB/s), 4622MiB/s-4622MiB/s (4847MB/s-4847MB/s),
> io=1354GiB (1454GB), run=300001-300001msec
> 
> When not disable MSI-X remapping:
> read: IOPS=1171k, BW=4572MiB/s (4795MB/s)(1340GiB/300001msec)
> READ: bw=4572MiB/s (4795MB/s), 4572MiB/s-4572MiB/s (4795MB/s-4795MB/s),
> io=1340GiB (1438GB), run=300001-300001msec
> 
> However, the bypass mode could increase the interrupts costs in CPU.
> We test 12 disks in the 6 CPU,
Well the bypass mode was made to improve performance where you have >4 
drives so this is pretty surprising. With bypass mode disabled, VMD will 
intercept and forward interrupts, increasing costs.

I think Nirmal would want to to understand if there's some other factor 
going on here.

> 
> When disable MSI-X remapping:
> read: IOPS=562k, BW=2197MiB/s (2304MB/s)(644GiB/300001msec)
> READ: bw=2197MiB/s (2304MB/s), 2197MiB/s-2197MiB/s (2304MB/s-2304MB/s),
> io=644GiB (691GB), run=300001-300001msec
> 
> When not disable MSI-X remapping:
> read: IOPS=1144k, BW=4470MiB/s (4687MB/s)(1310GiB/300005msec)
> READ: bw=4470MiB/s (4687MB/s), 4470MiB/s-4470MiB/s (4687MB/s-4687MB/s),
> io=1310GiB (1406GB), run=300005-300005msec
> 
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>   drivers/pci/controller/vmd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..9f6e9324d67d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -998,8 +998,7 @@ static const struct pci_device_id vmd_ids[] = {
>   		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
>   	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>   		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
>   	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
>   		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>   				VMD_FEAT_HAS_BUS_RESTRICTIONS |
