Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BA6F8A7B
	for <lists+linux-pci@lfdr.de>; Fri,  5 May 2023 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjEEU6t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 May 2023 16:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjEEU6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2023 16:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9ECC0;
        Fri,  5 May 2023 13:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C2A663DA0;
        Fri,  5 May 2023 20:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F07C433EF;
        Fri,  5 May 2023 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683320327;
        bh=pSZtoLI3P14PzFPlXCopMdsVdDAbhVVobh2s7pM4kHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RCyCrMRFqdx0kRTbESWE59KRg72n1BT3yPW1QkH9ekR5NysdWxalf2Xjh1F3bhKDE
         ftn1Tpv41Ot/vYGWpp8Wdsg299U0E/esv345bxEUNeynXsFMMT7LyEykBvBFWyRQCc
         s4vdNY8FcH/JexN5HO1UnK+DM1VAMDWPSrMujT06/dD71x0Wo/h+r+ct+sJ/JEMs/6
         JBwpS5mB5MkaFVBXBjve+yWZdYkVm3Cs45hi+HQnHyqb0sjJJ+e9Aj23ve3UAe/PwZ
         ImhZhhivmyQs4pQpCqoLYiTT+VaBs4gxCq1i8EmZ6v8DSmavyjA68xXJ8LJ0FclhRb
         2HII3W1SB0m5g==
Date:   Fri, 5 May 2023 15:58:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        vidyas@nvidia.com, david.e.box@linux.intel.com,
        kai.heng.feng@canonical.com, michael.a.bottini@linux.intel.com,
        rajatja@google.com, qinzongquan@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: fix UAF by disable ASPM for link when child
 function is removed
Message-ID: <20230505205845.GA978671@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504123418.4438-1-dinghui@sangfor.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 04, 2023 at 08:34:18PM +0800, Ding Hui wrote:
> If the Function 0 of a Multi-Function device is software removed,
> a freed downstream pointer will be left in struct pcie_link_state,
> and then when pcie_config_aspm_link() be invoked from any path,
> we will trigger use-after-free.
> 
> Based on the PCIe spec about ASPM Control (PCIe r6.0, sec 7.5.3.7),
> for Multi-Function Devices (including ARI Devices), it is recommended
> that software program the same value in all Functions. For ARI
> Devices, ASPM Control is determined solely by the setting in Function 0.
> 
> So we can just disable ASPM of the whole component if any child
> function is removed, the downstream pointer will be avoided from
> use-after-free, that will also avoid other potential corner cases.
> 
> Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
> Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>
> Suggestion-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>  drivers/pci/pcie/aspm.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 66d7514ca111..1bf8306141aa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1010,18 +1010,17 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)

Not directly related to your patch, but this looks racy to me:

  void pcie_aspm_exit_link_state(struct pci_dev *pdev)
  {
    struct pci_dev *parent = pdev->bus->self;

    if (!parent || !parent->link_state)
      return;

    down_read(&pci_bus_sem);
    mutex_lock(&aspm_lock);

    link = parent->link_state;
    root = link->root;
    ...
    free_link_state(link);
      link->pdev->link_state = NULL;
      kfree(link);

Since we check "parent->link_state" before acquiring the locks, I
suspect that removing two functions at the same time could end up with
a NULL pointer dereference:

  pcie_aspm_exit_link_state(fn 0)    pcie_aspm_exit_link_state(fn 1)
  parent = X                         parent = X
  parent->link_state != NULL         parent->link_state != NULL

  acquire locks
  free_link_state(link)
  link->pdev->link_state = NULL # aka parent->link_state
  kfree(link)
  release locks

                                     acquire locks
                                     link = parent->link_state # now NULL
                                     root = link->root         # NULL ptr

What do you think?  I guess if this *is* a race, it should be fixed by
a separate patch.

>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
> -	/*
> -	 * All PCIe functions are in one slot, remove one function will remove
> -	 * the whole slot, so just wait until we are the last function left.
> -	 */
> -	if (!list_empty(&parent->subordinate->devices))
> -		goto out;
>  
>  	link = parent->link_state;
>  	root = link->root;
>  	parent_link = link->parent;
>  
> -	/* All functions are removed, so just disable ASPM for the link */
> +	/*
> +	 * Any function is removed (including software removing), just
> +	 * disable ASPM for the link, in case we can not configure the same
> +	 * setting for all functions.
> +	 * See PCIe r6.0, sec 7.5.3.7.
> +	 */
>  	pcie_config_aspm_link(link, 0);
>  	list_del(&link->sibling);
>  	/* Clock PM is for endpoint device */
> @@ -1032,7 +1031,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  		pcie_update_aspm_capable(root);
>  		pcie_config_aspm_path(parent_link);
>  	}
> -out:
> +
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
>  }
> -- 
> 2.17.1
> 
