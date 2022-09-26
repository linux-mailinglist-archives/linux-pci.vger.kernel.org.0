Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7423A5EB2D7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiIZVIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIZVID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 17:08:03 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A030874341
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 14:08:01 -0700 (PDT)
Message-ID: <6a435b33-b27c-7f56-2dca-6e8964242109@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664226479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbK0a0b2cvFpJLbVBqmEudCdcMiN8USB7uQaj60v4jk=;
        b=TELLA11a1i91wUDAf1E6foVh17bJFoP9dDtQEduS7aZeIr8TsePNfkIy1pGqz7In8/7NTI
        gWgV7qnNyZEYMi9IAh+9jCi8elvSEyfCTWPf9gmL3PWh7XUG+wxCCGSzVKBV9v4lPwIO2M
        5NyhnmQfQ2Ic/J/uIAFoKGNAANJnMBQ=
Date:   Mon, 26 Sep 2022 15:07:51 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Fix secondary bus reset for Intel bridges
Content-Language: en-US
To:     francisco.munoz.ruiz@linux.intel.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
References: <20220923203757.4918-1-francisco.munoz.ruiz@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220923203757.4918-1-francisco.munoz.ruiz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/23/2022 2:37 PM, francisco.munoz.ruiz@linux.intel.com wrote:
> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> 
> The reset was never applied in the current implementation because Intel
> Bridges owned by VMD are parentless. Internally, the reset API applies
> a reset to the parent of the pci device supplied as argument, but in this
> case it failed because there wasn't a parent. This change feeds a child
> device of an Intel Bridge to the reset API and internally the reset is
> applied to its parent.
> 
> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>

> ---
>  drivers/pci/controller/vmd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e06e9f4fc50f..34d6ba675440 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	pci_scan_child_bus(vmd->bus);
>  	vmd_domain_reset(vmd);
> -	list_for_each_entry(child, &vmd->bus->children, node)
> -		pci_reset_bus(child->self);
> +
> +	list_for_each_entry(child, &vmd->bus->children, node) {
> +		if (!list_empty(&child->devices)) {
> +			pci_reset_bus(list_first_entry(&child->devices,
> +						       struct pci_dev,
> +						       bus_list));
> +			break;
> +		}
> +	}
> +
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	/*
