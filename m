Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2824C60D759
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiJYWqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 18:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiJYWqc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 18:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626F645D1;
        Tue, 25 Oct 2022 15:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B670961BE6;
        Tue, 25 Oct 2022 22:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3603C433D7;
        Tue, 25 Oct 2022 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666737991;
        bh=xuwXU/xzYbZWh4izFdRc2XO711LNwKWbdij0r5R4HJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DhCzaWwtjx9YxM+RmzWmbKX61JVVpMOldDYrol+a97KY8uhcHPvd2vAb8lO1tQ2C2
         T4RrgSSEChiQx4R3ZkXlzrCiMDqL4YxgLes+c3UMmn6ujc66KLymKB7l0LQ6MpyPeV
         vPG5kbuVYMXkR+bhtJaRptY0s0261tBLIYC56mZuG0Zh9Ex8+QY523ufSIgjeY3TIV
         tMIQYs7Jo8uNlDlpdcFjPjl90WhH2p8/HpiSIJPgQSjCDRcUMM5sNDCbIsp8D/r4+M
         D0+28IwWkgQKyxBht6UfKxENF7v/zb5f8e81SpmNnnKg1+8Wb2umNeXsSBBFWymslA
         BwbPjITjUEeAQ==
Date:   Tue, 25 Oct 2022 17:46:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/PM: Remove unused 'state' parameter to
 pci_legacy_suspend_late()
Message-ID: <20221025224629.GA694877@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025193502.669091-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 02:35:02PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 1a1daf097e21 ("PCI/PM: Remove unused pci_driver.suspend_late() hook")
> removed the legacy .suspend_late() hook, which was the only user of the
> "state" parameter to pci_legacy_suspend_late(), but it neglected to remove
> the parameter.
> 
> Remove the unused "state" parameter to pci_legacy_suspend_late().
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with Rafael's ack to pci/pm for v6.2.

> ---
>  drivers/pci/pci-driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 107d77f3c846..a2ceeacc33eb 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -646,7 +646,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
>  	return 0;
>  }
>  
> -static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
> +static int pci_legacy_suspend_late(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  
> @@ -848,7 +848,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  		return 0;
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
> +		return pci_legacy_suspend_late(dev);
>  
>  	if (!pm) {
>  		pci_save_state(pci_dev);
> @@ -1060,7 +1060,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
> +		return pci_legacy_suspend_late(dev);
>  
>  	if (pm && pm->freeze_noirq) {
>  		int error;
> @@ -1179,7 +1179,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  		return 0;
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
> -		return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
> +		return pci_legacy_suspend_late(dev);
>  
>  	if (!pm) {
>  		pci_fixup_device(pci_fixup_suspend_late, pci_dev);
> -- 
> 2.25.1
> 
