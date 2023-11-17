Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6599F7EF52D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjKQPXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 10:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQPXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 10:23:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688ED57
        for <linux-pci@vger.kernel.org>; Fri, 17 Nov 2023 07:23:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DC6C433C7;
        Fri, 17 Nov 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700234596;
        bh=R9gtMv1mlx1XFPa0IOyEngjAsd6b0IyS9o23nfyNy5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHakJntJ4U6+/sY3OR5jtcL31/W5aky14gC2LdV2cXi1ByaLLh4oSozqVSkeNANZN
         ES+/AdEVl+hOLGwUIT1Xu4gP5xq7rNyoUIrBNa6aLXfmf5oUGTJhLjQJ1KlFuwwi4R
         7f/1agrFIZ6FFFs6CsMuSaPe7UD0azOrM81brF+8g/JpaHOTe3xK0pgk+48xpT+RFD
         +0DCo3oGKFtqExUSxpfD2RQB7Cqvp4y3HxnNV5tI0Rdc8b6RIy+pq13vOdBQKMjrvN
         eyMIJF/DlDFmYpUqdoe+OGXBdcIiAis9HhP0n+mVBAaLgXA7mEw+QOjBKn6Fu0llrZ
         YYurBOy/9+5Tw==
Date:   Fri, 17 Nov 2023 15:23:11 +0000
From:   Simon Horman <horms@kernel.org>
To:     Petr Machata <petrm@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 08/14] PCI: Add debug print for device ready
 delay
Message-ID: <20231117152311.GC164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <63fca173195f5a9d3a2b78da700650a29cf80f96.1700047319.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fca173195f5a9d3a2b78da700650a29cf80f96.1700047319.git.petrm@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 01:17:17PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Currently, the time it took a PCI device to become ready after reset is
> only printed if it was longer than 1000ms ('PCI_RESET_WAIT'). However,
> for debugging purposes it is useful to know this time even if it was
> shorter. For example, with the device I am working on, hardware
> engineers asked to verify that it becomes ready on the first try (no
> delay).
> 
> To that end, add a debug level print that can be enabled using dynamic
> debug. Example:
> 
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
>  # echo "file drivers/pci/pci.c +p" > /sys/kernel/debug/dynamic_debug/control
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
>  [  396.060335] mlxsw_spectrum4 0000:01:00.0: ready 0ms after bus reset
>  # echo "file drivers/pci/pci.c -p" > /sys/kernel/debug/dynamic_debug/control
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 55bc3576a985..69d20d585f88 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1219,6 +1219,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	if (delay > PCI_RESET_WAIT)
>  		pci_info(dev, "ready %dms after %s\n", delay - 1,
>  			 reset_type);
> +	else
> +		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
> +			reset_type);
>  
>  	return 0;
>  }
> -- 
> 2.41.0
> 
