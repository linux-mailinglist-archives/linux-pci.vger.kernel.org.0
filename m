Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60B4CC4C1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiCCSMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiCCSMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:12:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4F1A3618
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:11:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46791B824C9
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 18:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E2DC340EF;
        Thu,  3 Mar 2022 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646331105;
        bh=6kHNyAW28+qceLN/t4c1l4MsxbS0QQfdH4sCCGEqDmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GgEqJZW0Z5IfGdcxMBZsoQLZGAvv/saQ3soSQ8d6NKBwdVGpcLDz3sq1VYvG59l6B
         UzS6AIY1RgW+/tDMWmTr9FS+b0rRuNOSLsqvQ5ygAg/enRUD4k+Voaejnat5tRHnVn
         b0YNCWF7FvfqkuJQuA5g6+Oq8EH8XTDHEooi4srxhIiIbcU8jNMOSs1OE0WYIH1hQB
         MXoVbUSRnK4e5x4uMA1PedodnN63V4uJaErNP/E4fvAYiLEiB79+Pu8CKcLyme+KM5
         SNlmgG188mF5CoIduu7jLln8VmOYAg+hq7I+OVOok7XI/7zTVIgNo7dgfJ3hci+NOb
         PLIAWfbqvxs8Q==
Date:   Thu, 3 Mar 2022 12:11:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Support BAR sizes up to 8TB
Message-ID: <20220303181144.GA820025@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118092117.10089-1-liudongdong3@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 18, 2022 at 05:21:17PM +0800, Dongdong Liu wrote:
> Current kernel reports disabling BAR if device with a 4TB BAR as it
> only supports BAR size to 128GB.
> 
> pci 0000:01:00.0: disabling BAR 4:
> [mem 0x00000000-0x3ffffffffff 64bit pref] (bad alignment 0x40000000000)
> 
> Increase the maximum BAR size from 128GB to 8TB for future expansion.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Applied to pci/enumeration for v5.18, thanks!

> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 547396ec50b5..a7893bf2f580 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -994,7 +994,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  {
>  	struct pci_dev *dev;
>  	resource_size_t min_align, align, size, size0, size1;
> -	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
> +	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
>  	int order, max_order;
>  	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
> -- 
> 2.33.0
> 
