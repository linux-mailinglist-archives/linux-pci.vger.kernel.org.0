Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24274DCBE0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiCQQ7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiCQQ7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 12:59:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF214C414;
        Thu, 17 Mar 2022 09:58:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 17B805C017F;
        Thu, 17 Mar 2022 12:58:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 17 Mar 2022 12:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=q/O4oWCbOCxInkyu4qYV95RiqyU/wps554Da5a
        nLtKg=; b=ZxzY3SyVYFxDVKwqKYS+JKuj2Pb0snRyTIEnFh+A5cdJ9c3ndJye5P
        OREBIgjHI+Jv9HmCh56/UOuhVMTQ3P9jM19p7ocDbGMjb/1QoB2hNnC5TajumV34
        yGlTCLhLw2CE9ijQAbg6025udnVhbMojznGCM8ZOa6Fa8qUHpEruKcnvJsROSxiO
        O56L0v6bASvwyMPxxAU6SFTmgs8PnGZ0vwJOM+6KqagOZlYc/3VvqxL4kZOWD/Hb
        jTmyBHiX+mJ6GUpRcR5DLnMJcgNF4S5JMhqyhfKhDrnDJO1OpO8Lgk6raWSyaDaI
        umxd4vKgY0l4ZapdsL36aF9kU0dQYKqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q/O4oWCbOCxInkyu4
        qYV95RiqyU/wps554Da5anLtKg=; b=U88Rzc+LaCzMghYa8HODqlkkj5evepbcC
        +r4XfyaPAGIASFv0UKnpgUR4qpEAHDHMGDnLQXmEsfArhGwYzAcPtfsR837DeNu4
        Y8OuFKNbKLTDnrFQCTeZdrjViyBCPKo4ynn4EzfFl8Trbp27tO9kTHmVYcDcC4C3
        cnTmwFqh5ZiqoLpo1OBk/mS80IoSG6nEauDLXYXtT1wrHOSNMin7UgWmDm3CRyM6
        iYMI11zs/kWag+F3R1D4fLIq35Ccck6hcVfrsSMgz6N3ZsGwWPW3nRx6P4RQAmDt
        QozpabU0qZr715IR+Lr6e2gIDozo+HKsu5eo5FFx5meAQnnkkp5bw==
X-ME-Sender: <xms:rWgzYgl8uI1N5aZ3zELULYDhVLYa2jFakvdJc7s0VG-PD0wZjuBuMg>
    <xme:rWgzYv0BP4WJU8FjBFs7CF5V1tfWSk_-VKsa-WlGEvvQWISnJjBkW5ymntgbrxgT5
    KrQrKWOp3wsgg>
X-ME-Received: <xmr:rWgzYup-OYqzHNWV6RLW6oyLoAs6_03V3I9uK_T0n33rLQnsWzrfkjo7b4wpgPm0n1k1aliwoM1BfgHSOBOpWu4nwC-QxVed>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleeltd
    ehkeeltefhleduuddvhfffuedvffduveegheekgeeiffevheegfeetgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:rWgzYsmxHLPdqz8BBqoQFCuHMO-93cVWIMDhFtwnCxJGycTX-Q8mKA>
    <xmx:rWgzYu0MgnonLHvL-UY4kLWe8xwCpDCGxNA2Q-_wTRfjWEZqbZW80A>
    <xmx:rWgzYjsLX_KbyNEwugWA-MOKCjN_n2IBf0BTlvDcQ1Y0OiCtSJimog>
    <xmx:rmgzYluaxMoZDZ9sZbHhT5cpHdQHYJ48wyWPdNB2uqEJc2C-3eyyQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 12:58:21 -0400 (EDT)
Date:   Thu, 17 Mar 2022 17:58:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        mario.limonciello@amd.com
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjNoquzvN7CdFIyl@kroah.com>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 17, 2022 at 04:17:07PM +0000, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. What
> actually matters is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
> 
> Avoid false positives by looking as close as possible to the same PCI
> topology that the IOMMU layer will consider once a Thunderbolt endpoint
> appears. Crucially, we can't assume that IOMMU translation being enabled
> for any reason is sufficient on its own; full (expensive) DMA protection
> will still only be imposed on untrusted devices.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This supersedes my previous attempt just trying to replace
> iommu_present() at [1], further to the original discussion at [2].
> 
> [1] https://lore.kernel.org/linux-iommu/BL1PR12MB515799C0BE396377DBBEF055E2119@BL1PR12MB5157.namprd12.prod.outlook.com/T/
> [2] https://lore.kernel.org/linux-iommu/202203160844.lKviWR1Q-lkp@intel.com/T/
> 
>  drivers/thunderbolt/domain.c | 12 +++---------
>  drivers/thunderbolt/nhi.c    | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..d5c825e84ac8 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +
> +	return sprintf(buf, "%d\n", tb->nhi->iommu_dma_protection);

sysfs_emit() please.

thanks,

greg k-h
