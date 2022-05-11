Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5D52402C
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348680AbiEKWWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348686AbiEKWWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 18:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23B2E528A;
        Wed, 11 May 2022 15:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318F061D0E;
        Wed, 11 May 2022 22:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAEC340EE;
        Wed, 11 May 2022 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652307765;
        bh=max/YLZZYvVMU4pJNqaOdGaTwdVGW7qxAj5WBVzWjJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tiM6aexheYqaLaujb4nWX9I1pdfM2ZSwROG86IeLhNX0MZZrU/13PjbYpasFHgV31
         1DB6QlaH5pcU9XK8cIZN2m6B5KyMvhMCLcXrXrqyAcNlAYOcp1C26fLbhBNIOfUmWj
         DcVLuZFSfK66mZv1dlDowmZO/yhpQwSBeaXcudWz6tJmjNRz1CDkTQi37/3gkv3b/5
         /xUFo7su1hKE8UVrZPH6dbm7X2rGhRKkQbKRhjSB16tvY6uAd1OkcGKnmBg8go0CbL
         uSDx9l9AuFJ97+trSTD+wO72els3vCK5p93RbVtoAyYMeIUA986LLxMw3NCAk+HusW
         y0igt+RUGJ6EA==
Date:   Wed, 11 May 2022 17:22:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jay Zhou <jianjay.zhou@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, alex.williamson@redhat.com,
        weidong.huang@huawei.com, Donald Dutile <ddutile@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] pci: avoid dead lock between device reset and sriov
 disable
Message-ID: <20220511222243.GA822874@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404062539.1710-1-jianjay.zhou@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Don, Jason, Leon, just FYI]

On Mon, Apr 04, 2022 at 02:25:39PM +0800, Jay Zhou wrote:
> Call trace of PF SRIOV disable:
> sriov_numvfs_store
>   device_lock <----------------- (1) get the device lock
>     ->sriov_configure # e.g. vfio_pci_sriov_configure
>       sriov_disable
>         pci_cfg_access_lock <--- (4) wait dev->block_cfg_access to be 0
> 
> Call trace of PF reset:
> reset_store
>   pci_reset_function
>     pci_dev_lock
>       pci_cfg_access_lock <----- (2) set dev->block_cfg_access = 1
>       device_lock <------------- (3) want to get the device lock
> 
> These two oprations would wait for each other forever if the
> code execution sequence is (1)(2)(3)(4).
> 
> Let's get the device lock and then the config access lock in
> pci_dev_lock().
> 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>

Thanks, I (finally) applied Yicong's identical patch from a year ago
to pci/virtualization for v5.19, with a commit log combined and
adapted from both:

    PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()
    
    The sysfs sriov_numvfs_store() path acquires the device lock before the
    config space access lock:
    
      sriov_numvfs_store
        device_lock                 # A (1) acquire device lock
        sriov_configure
          vfio_pci_sriov_configure  # (for example)
            vfio_pci_core_sriov_configure
              pci_disable_sriov
                sriov_disable
                  pci_cfg_access_lock
                    pci_wait_cfg    # B (4) wait for dev->block_cfg_access == 0
    
    Previously, pci_dev_lock() acquired the config space access lock before the
    device lock:
    
      pci_dev_lock
        pci_cfg_access_lock
          dev->block_cfg_access = 1 # B (2) set dev->block_cfg_access = 1
        device_lock                 # A (3) wait for device lock
    
    Any path that uses pci_dev_lock(), e.g., pci_reset_function(), may
    deadlock with sriov_numvfs_store() if the operations occur in the sequence
    (1) (2) (3) (4).
    
    Avoid the deadlock by reversing the order in pci_dev_lock() so it acquires
    the device lock before the config space access lock, the same as the
    sriov_numvfs_store() path.
    
    [bhelgaas: combined and adapted commit log from Jay Zhou's independent
    subsequent posting:
    https://lore.kernel.org/r/20220404062539.1710-1-jianjay.zhou@huawei.com]
    Link: https://lore.kernel.org/linux-pci/1583489997-17156-1-git-send-email-yangyicong@hisilicon.com/
    Also-posted-by: Jay Zhou <jianjay.zhou@huawei.com>
    Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..61a6db1d21f6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5103,19 +5103,19 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  
>  void pci_dev_lock(struct pci_dev *dev)
>  {
> -	pci_cfg_access_lock(dev);
>  	/* block PM suspend, driver probe, etc. */
>  	device_lock(&dev->dev);
> +	pci_cfg_access_lock(dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_dev_lock);
>  
>  /* Return 1 on successful lock, 0 on contention */
>  int pci_dev_trylock(struct pci_dev *dev)
>  {
> -	if (pci_cfg_access_trylock(dev)) {
> -		if (device_trylock(&dev->dev))
> +	if (device_trylock(&dev->dev)) {
> +		if (pci_cfg_access_trylock(dev))
>  			return 1;
> -		pci_cfg_access_unlock(dev);
> +		device_unlock(&dev->dev);
>  	}
>  
>  	return 0;
> @@ -5124,8 +5124,8 @@ EXPORT_SYMBOL_GPL(pci_dev_trylock);
>  
>  void pci_dev_unlock(struct pci_dev *dev)
>  {
> -	device_unlock(&dev->dev);
>  	pci_cfg_access_unlock(dev);
> +	device_unlock(&dev->dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_dev_unlock);
>  
> -- 
> 2.27.0
> 
