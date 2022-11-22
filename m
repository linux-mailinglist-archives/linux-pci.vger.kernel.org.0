Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EBB63451C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 21:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKVUF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 15:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKVUFy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 15:05:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F2687555
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 12:05:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF14617E3
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 20:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AEDC433C1;
        Tue, 22 Nov 2022 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669147553;
        bh=bic0W/Yz7oujIlwrDxUCxfYXaKqHGMrhHAtNLxnCiLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YPRCJzT/Uu0169iRloByfuM7zEX50iI2E8r/Iv5KtP4anmGuz5iyWtJK1kO0L6F9w
         ngd2slPSFaF/wLvvnDGkZ/3r5vPUD/bbV2CjnmgiwgNKAyoiogBmECkdATm5hdgRqV
         FiVf8GLfJH21R/4gTBryJcuIR5FojU4TVKmY97Mbwptt8bQ2AoSO2RwE8hdec11gxz
         Bt2mdwcAgH3h2QfOANUfHgsc1bSxTBLsKO53sjHZev9JcE8+DnV/17QhhmsijrMsPJ
         YB0jZn5h8Pph3vg+uMo8XOPXmj7sAGoJoUgDNHTyCqhLrQRJTwnGAvtdY+B0C5RCWF
         ahdc1dvPjZgwA==
Date:   Tue, 22 Nov 2022 14:05:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     bhelgaas@google.com, gregkh@suse.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpqphp: Fix error handling in cpqhpc_init()
Message-ID: <20221122200551.GA212321@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122101346.80461-1-yuancan@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 10:13:46AM +0000, Yuan Can wrote:
> The cpqhpc_init() returns the result of pci_register_driver() without
> checking it, if pci_register_driver() failed, the debugfs created in
> cpqhp_initialize_debugfs() is not removed, resulting the debugfs of
> cpqhp can never be created later.
> Fix by calling cpqhp_shutdown_debugfs() when pci_register_driver() failed.

Add a blank line between paragraphs.

> Fixes: 9f3f4681291f ("[PATCH] PCI Hotplug: fix up the sysfs file in the compaq pci hotplug driver")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/pci/hotplug/cpqphp_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index c94b40e64baf..c47981ef92ea 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -1389,6 +1389,8 @@ static int __init cpqhpc_init(void)
>  	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>  	cpqhp_initialize_debugfs();
>  	result = pci_register_driver(&cpqhpc_driver);
> +	if (result)
> +		cpqhp_shutdown_debugfs();

Is there some reason cpqhp_initialize_debugfs() needs to be called
before pci_register_driver()?

In other words, could we do this instead?

  result = pci_register_driver(&cpqhpc_driver);
  if (result)
    return result;

  cpqhp_initialize_debugfs();
  return 0;

I assume this was found by code inspection?  I've never heard of
anybody actually using this driver :)

>  	dbg("pci_register_driver = %d\n", result);
>  	return result;
>  }
> -- 
> 2.17.1
> 
