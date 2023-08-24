Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2C787ACB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 23:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbjHXV7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbjHXV7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 17:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0546172D;
        Thu, 24 Aug 2023 14:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F393630DB;
        Thu, 24 Aug 2023 21:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7203EC433C7;
        Thu, 24 Aug 2023 21:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914346;
        bh=kp2b+eLg9pxrdioYGesP6dS3LZq1aJVrfYCnpnZ02gs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rakDJ+MRG6gMHEbyrx7maWSj2oAEhzpn6ah8WTiYPHnA5CSkcjKW9HzPK04oPOjfA
         TXg2Zq3wG/x9pyO6bS7aU86AtolV4Wom3/QucENqcg8bcB9OjsMTXnehE45FzgH7Sq
         tH1mYGOb1hYZZTfGrnYKQvy1qXS9JFjIRTMb6dMid4xOwCt0NdWIEAxEzWL9VFzTup
         wLQX8QhR9dRHp3dl5pmW16emeWXxJybznR7zv0HiKUPfbnc7XzxtuaoxWAuHCt2j3u
         8p0t2fPTPOXjLn/mRLZHB+gKWpQn8ip8IJ9TT7CeYa6SvRI/80wW11px7Y7e//3kad
         qre0e+L74GqJw==
Date:   Thu, 24 Aug 2023 16:59:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Feiyang Chen <chenfeiyang@loongson.cn>
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        mika.westerberg@linux.intel.com, anders.roxell@linaro.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        guyinggang@loongson.cn, siyanteng@loongson.cn,
        chenhuacai@loongson.cn, loongson-kernel@lists.loongnix.cn,
        chris.chenfeiyang@gmail.com,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] PCI/PM: Only read PCI_PM_CTRL register when available
Message-ID: <20230824215904.GA604126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824013738.1894965-1-chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 09:37:38AM +0800, Feiyang Chen wrote:
> When the current state is already PCI_D0, pci_power_up() will return
> 0 even though dev->pm_cap is not set. In that case, we should not
> read the PCI_PM_CTRL register in pci_set_full_power_state().
> 
> There is nothing more needs to be done below in that case.
> Additionally, pci_power_up() has two callers only and the other one
> ignores the return value, so we can safely move the current state
> check from pci_power_up() to pci_set_full_power_state().

Does this fix a bug?  I guess it does, because previously
pci_set_full_power_state() did a config read at 0 + PCI_PM_CTRL, i.e.,
offset 4, which is actually PCI_COMMAND, and set dev->current_state
based on that.  So dev->current_state is now junk, right?

This might account for some "Refused to change power state from %s to D0"
messages.

How did you find this?  It's nice if we can mention a symptom so
people can connect the problem with this fix.

This sounds like something that probably should have a stable tag?

> Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
>  drivers/pci/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..7e90ab7b47a1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
>  		else
>  			dev->current_state = state;
>  
> -		if (state == PCI_D0)
> -			return 0;
> -
>  		return -EIO;
>  	}
>  
> @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>  	int ret;
>  
>  	ret = pci_power_up(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (dev->current_state == PCI_D0)
> +			return 0;
> +
>  		return ret;
> +	}
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> -- 
> 2.39.3
> 
