Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B9520AF2
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 04:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiEJCHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 22:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEJCHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 22:07:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4BA210B94;
        Mon,  9 May 2022 19:03:48 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ky1V31sFpzGpdn;
        Tue, 10 May 2022 10:00:59 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 10:03:46 +0800
CC:     <yangyicong@hisilicon.com>, <weidong.huang@huawei.com>
Subject: Re: [PATCH] pci: avoid dead lock between device reset and sriov
 disable
To:     Jay Zhou <jianjay.zhou@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>
References: <20220404062539.1710-1-jianjay.zhou@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <0b146b52-054d-4f89-961a-65f29037e172@huawei.com>
Date:   Tue, 10 May 2022 10:03:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220404062539.1710-1-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/4/4 14:25, Jay Zhou wrote:
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

The patch looks good to me,

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

I met the same problem and tried to fix it in the same way. It's worth to be merged if somebody meets
the same problem again.
https://lore.kernel.org/linux-pci/1583489997-17156-1-git-send-email-yangyicong@hisilicon.com/

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
> 
