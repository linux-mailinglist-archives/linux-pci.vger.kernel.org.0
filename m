Return-Path: <linux-pci+bounces-11019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBD941019
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29BDB28314
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9400D1993A4;
	Tue, 30 Jul 2024 10:36:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15580.qiye.163.com (mail-m15580.qiye.163.com [101.71.155.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952919DFBB
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335792; cv=none; b=Ct0kNe/YBCmc3s69EozcBwLa0E4urLXSuxCbyFquwc/7laHmJqY6+UyjPtmB3HQZius+1NUyjgXuO420AaLN1bM4MQepvtZkInJeWXGGSyKaYnkE9BtegUgBVxMexOaAKb6DLVLCUjBgR9fO+J3mqIKCdhBYolpPbwW16Ivwc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335792; c=relaxed/simple;
	bh=99rqNyZ6Pv8TZH7iDf9+ne8M6i00yGUgswKlGBASsYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLBU6S3ni25j17E+/XVNF1QtfV9YsbvYv8ps6INZjXcyZo82qM/VsgcIGue3Ywl697oJ+ZTi/DvcuY/mjOQ73riIhp/Z39lVMONcjWRDaLRoD/zrsWwwj5FrJjedX7vd9zy/MnPrChv3aP+9E8kn6baIWzmef7GX9pwKNa/ZV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=101.71.155.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [0.0.0.0] (unknown [IPV6:240e:3b7:327c:7080:144f:1ac1:3638:8460])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8A7781A0C00;
	Tue, 30 Jul 2024 17:57:45 +0800 (CST)
Message-ID: <1580700a-95e6-45cc-a461-68fa1cc1b50c@sangfor.com.cn>
Date: Tue, 30 Jul 2024 17:57:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Update ASPM sysfs on MFD function removal to
 avoid use-after-free
To: Jay Fang <f.fangjian@huawei.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com
References: <20240730011639.2590846-1-f.fangjian@huawei.com>
Content-Language: en-US
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20240730011639.2590846-1-f.fangjian@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk5MVkIYHU0dTUoaS01CH1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0seQUgZTEFISUwYQUxLQ0tBSk9PHUFKGhhKQUhNSENBQ09NS1lXWR
	YaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSkJLS1kG
X-HM-Tid: 0a9103130cc703abkunm8a7781a0c00
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Hgw4QjIyCzUUHx8OARM3
	P04aChRVSlVKTElJSEhIT01NSk1IVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
	QVlJT0seQUgZTEFISUwYQUxLQ0tBSk9PHUFKGhhKQUhNSENBQ09NS1lXWQgBWUFISENJNwY+

On 2024/7/30 9:16, Jay Fang wrote:
>  From 'commit 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal
> to avoid use-after-free")' we know that PCIe spec r6.0, sec 7.5.3.7,
> recommends that software program the same ASPM Control(pcie_link_state)
> value in all functions of multi-function devices, and free the
> pcie_link_state when any child function is removed.
> 
> However, ASPM Control sysfs is still visible to other children even if it
> has been removed by any child function, and careless use it will
> trigger use-after-free error, e.g.:
> 
>    # lspci -tv
>      -[0000:16]---00.0-[17]--+-00.0  Device 19e5:0222
>                              \-00.1  Device 19e5:0222
>    # echo 1 > /sys/bus/pci/devices/0000:17:00.0/remove       // pcie_link_state will be released
>    # echo 1 > /sys/bus/pci/devices/0000:17:00.1/link/l1_aspm // will trigger error
> 
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
>    Call trace:
>     aspm_attr_store_common.constprop.0+0x10c/0x154
>     l1_aspm_store+0x24/0x30
>     dev_attr_store+0x20/0x34
>     sysfs_kf_write+0x4c/0x5c
> 
> We can solve this problem by updating the ASPM Control sysfs of all
> children immediately after ASPM Control have been freed.
> 
> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> ---
>   drivers/pci/pcie/aspm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..eee9e6739924 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1262,6 +1262,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>   		pcie_config_aspm_path(parent_link);
>   	}
>   
> +	pcie_aspm_update_sysfs_visibility(parent);
> +

To be more rigorous, is there still a race window in aspm_attr_{show,store}_common or
clkpm_{show,store} before updating the visibility, we can get an old or NULL pointer
by pcie_aspm_get_link()?

>   	mutex_unlock(&aspm_lock);
>   	up_read(&pci_bus_sem);
>   }

-- 
Thanks,
- Ding Hui


