Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917B67CD1E9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJRBmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 21:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbjJRBmH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 21:42:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CFC4;
        Tue, 17 Oct 2023 18:42:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D1C433C8;
        Wed, 18 Oct 2023 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697593325;
        bh=35o2Y8/cJzVFwMj0lLlMkxzyp3mX/WQk9C/SzjhSbEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VIGrmHy4DM1kB5rgdhG3YbSUWE3UDc45k/mUIp4CAYWbZlOFAfBae2zYCQAlrz9ZE
         odPBcVhJRbVHBLUGelXzJP6fxzvyUkruunLkWV45iYD36qHkw62uW5NWBVRjiO377k
         wl3kfLqMfkjDyNMJBKgqGzB/3RbBKElr76v3XOhn4w2LmmknirFLnRtWzYGK3j7z9Z
         K4mL5EViefkcUNN22AV+on8e2GoI/M9iMkOJykruvBH44LB75H/NCLO1eW3CcT8MPn
         +rdc6oYltmDrR8BOsbHi8CMaofXqj4PZxIbmIVkSie/wF8A2xRkCuEu8VbFJPvpPsC
         +UaLonOYDHmjA==
Date:   Tue, 17 Oct 2023 20:42:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH -next] PCI: Remove duplicated include in pci.c
Message-ID: <20231018014203.GA1344868@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018010551.118071-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ilpo]

On Wed, Oct 18, 2023 at 09:05:51AM +0800, Yang Li wrote:
> ./drivers/pci/pci.c: linux/bitfield.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6898
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I folded this into the commit that added the duplicate, thanks!

https://lore.kernel.org/r/20230919125648.1920-7-ilpo.jarvinen@linux.intel.com

> ---
>  drivers/pci/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5b70eefc38fc..92b8dafec0d9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -32,7 +32,6 @@
>  #include <linux/vmalloc.h>
>  #include <asm/dma.h>
>  #include <linux/aer.h>
> -#include <linux/bitfield.h>
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> -- 
> 2.20.1.7.g153144c
> 
