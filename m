Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627E7CE7EF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjJRTlS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjJRTlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 15:41:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E623B8
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2023 12:41:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E99C433C8;
        Wed, 18 Oct 2023 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697658071;
        bh=79J258HbqH4/kkkD7j45ZgaF2NuqX5EhwfzRK9eenU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B9pjGqVbO3w0VepxJgsuuZ+2xGythRnZdGok8MbNhvzxzv7rIqXUa8SEB7Pk/LilG
         mXbHCULJ+eGX5+9SkOoOQL7dMWtVlV/Po4UhkaNTA9NeSR3dwvgny2pJXT3GL1WKt/
         9m+mb+xVsy4ZxVRZGlhZwmKeUNvArtskImb/XcAsh75xzcb+pVLXDrbqvMxF6fTKut
         tVBXV659WY/8uABn1JwS5gsKSoXvvtxLucFH79u+BrjIuFdOVgq0fKX6EC6C6LfVAZ
         tQu5RDR+YAWOHofxKEn7YN7/omJLXBC1MwIwjrYhKXPa1PcxgQPd6e3nmRDpNStrTP
         xjE37LbX3JA8Q==
Date:   Wed, 18 Oct 2023 14:41:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 06/12] PCI: Add debug print for device ready
 delay
Message-ID: <20231018194109.GA1371221@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017074257.3389177-7-idosch@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 10:42:51AM +0300, Ido Schimmel wrote:
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
>  [  396.060335] mlxsw_spectrum4 0000:01:00.0: ready 0ms after link toggle
>  # echo "file drivers/pci/pci.c -p" > /sys/kernel/debug/dynamic_debug/control
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..0a708e65c5c4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1216,6 +1216,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
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
> 2.40.1
> 
