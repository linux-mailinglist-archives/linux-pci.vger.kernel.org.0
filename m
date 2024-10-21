Return-Path: <linux-pci+bounces-14929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251129A58BF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 04:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307E01C20F12
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 02:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6515714286;
	Mon, 21 Oct 2024 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R/I+9L5U"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BF14263
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729476257; cv=none; b=URBHZZYbkQJ46bFUtNG+8/8FPWhITNoGi7GvHJ9aadeF6rVG+sXC+Dk4M5gViylpBndgt/cgRoCl+zer9aZzHYqepulE6hfvKimvHy4h037O/7xcPnzH68vbiNuDbbrDLLuNY055X86jBj+TUe54oVZYRpgMLeMokx+reohVft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729476257; c=relaxed/simple;
	bh=zFYyI8WZw2XDhMcPQsX3YCg/xRWWWaPQdTV09dA6a38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THuVigNyZbUyPG//zni1MJ4uyYZVavHnRe9qfReQM3A+j1KliGHnugtUXh5EYcdIdXsWPCIL4oZ2oyYrp89ahsyweC/46kbaHwW+tFWlJ9gI1RfYtiyT0ITDtHucPOfIjgoDBJfQEw9fhBT5C+jQ94GmDfr71N7jRIIn+16bz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R/I+9L5U; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729476247; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QPckyj6QPxLHNarv8y+4mbd5EkPERDvjm3dPzajkO64=;
	b=R/I+9L5UDKvaXE5e5srDgQIyEMcbDQVzVbEt1d6PPd83+dKo89a677KAxC/KmmmYLLtzsg+fR7IDuNhk9x0a2VE+/+UTDfox/7ZvQZZ6Ad9XeL/UVktb41zlZKosf/URpPet6eUHG5zWJtgypMYT0xq3ldWIOOwYj2fXCEswdzM=
Received: from 30.178.82.70(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHU8QjJ_1729476245 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 10:04:06 +0800
Message-ID: <757d1cda-875b-4135-8b3e-110154a9543e@linux.alibaba.com>
Date: Mon, 21 Oct 2024 10:04:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI: optimize proc sequential file read
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20241018222213.GA764583@bhelgaas>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241018222213.GA764583@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/10/19 06:22, Bjorn Helgaas 写道:
> On Fri, Oct 18, 2024 at 01:47:28PM +0800, Guixin Liu wrote:
>> PCI driver will traverse pci device list in pci_seq_start in every
>> sequential file reading, use xarry to store all pci devices to
>> accelerate finding the start.
>>
>> Use "time cat /proc/bus/pci/devices" to test on a machine with 13k
>> pci devices,  get an increase of about 90%.
> s/pci/PCI/ (several times)
> s/pci_seq_start/pci_seq_start()/
> s/xarry/xarray/
> s/,  /, / (remove extra space)
>
OK.
>> Without this patch:
>>    real 0m0.917s
>>    user 0m0.000s
>>    sys  0m0.913s
>> With this patch:
>>    real 0m0.093s
>>    user 0m0.000s
>>    sys  0m0.093s
> Nice speedup, for sure!
>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/pci/pci.h    |  3 +++
>>   drivers/pci/probe.c  |  1 +
>>   drivers/pci/proc.c   | 64 +++++++++++++++++++++++++++++++++++++++-----
>>   drivers/pci/remove.c |  1 +
>>   include/linux/pci.h  |  2 ++
>>   5 files changed, 64 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 14d00ce45bfa..1a7da91eeb80 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -962,4 +962,7 @@ void pcim_release_region(struct pci_dev *pdev, int bar);
>>   	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>>   	 PCI_CONF1_EXT_REG(reg))
>>   
>> +void pci_seq_tree_add_dev(struct pci_dev *dev);
>> +void pci_seq_tree_remove_dev(struct pci_dev *dev);
>> +
>>   #endif /* DRIVERS_PCI_H */
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4f68414c3086..1fd9e9022f70 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2592,6 +2592,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>   	WARN_ON(ret < 0);
>>   
>>   	pci_npem_create(dev);
>> +	pci_seq_tree_add_dev(dev);
>>   }
>>   
>>   struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>> index f967709082d6..30ca071ccad5 100644
>> --- a/drivers/pci/proc.c
>> +++ b/drivers/pci/proc.c
>> @@ -19,6 +19,9 @@
>>   
>>   static int proc_initialized;	/* = 0 */
>>   
>> +DEFINE_XARRAY_FLAGS(pci_seq_tree, 0);
>> +static unsigned long pci_max_idx;
>> +
>>   static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
>>   {
>>   	struct pci_dev *dev = pde_data(file_inode(file));
>> @@ -334,25 +337,72 @@ static const struct proc_ops proc_bus_pci_ops = {
>>   #endif /* HAVE_PCI_MMAP */
>>   };
>>   
>> +void pci_seq_tree_add_dev(struct pci_dev *dev)
>> +{
>> +	int ret;
>> +
>> +	if (dev) {
> I don't think we should test "dev" for NULL here.  If it's NULL, I
> think we have bigger problems and we should oops.
Sure.
>> +		xa_lock(&pci_seq_tree);
>> +		pci_dev_get(dev);
>> +		ret = __xa_insert(&pci_seq_tree, pci_max_idx, dev, GFP_KERNEL);
>> +		if (!ret) {
>> +			dev->proc_seq_idx = pci_max_idx;
>> +			pci_max_idx++;
>> +		} else {
>> +			pci_dev_put(dev);
>> +			WARN_ON(ret);
>> +		}
>> +		xa_unlock(&pci_seq_tree);
>> +	}
>> +}
>> +
>> +void pci_seq_tree_remove_dev(struct pci_dev *dev)
>> +{
>> +	unsigned long idx = dev->proc_seq_idx;
>> +	struct pci_dev *latest_dev = NULL;
>> +	struct pci_dev *ret;
>> +
>> +	if (!dev)
>> +		return;
> Same comment about testing "dev" for NULL.
>
Ok.
>> +	xa_lock(&pci_seq_tree);
>> +	__xa_erase(&pci_seq_tree, idx);
>> +	pci_dev_put(dev);
>> +	/*
>> +	 * Move the latest pci_dev to this idx to keep the continuity.
>> +	 */
>> +	if (idx != pci_max_idx - 1) {
>> +		latest_dev = __xa_erase(&pci_seq_tree, pci_max_idx - 1);
>> +		ret = __xa_cmpxchg(&pci_seq_tree, idx, NULL, latest_dev,
>> +				GFP_KERNEL);
>> +		if (!ret)
>> +			latest_dev->proc_seq_idx = idx;
>> +		WARN_ON(ret);
>> +	}
>> +	pci_max_idx--;
>> +	xa_unlock(&pci_seq_tree);
>> +}
>> +
>>   /* iterator */
>>   static void *pci_seq_start(struct seq_file *m, loff_t *pos)
>>   {
>> -	struct pci_dev *dev = NULL;
>> +	struct pci_dev *dev;
>>   	loff_t n = *pos;
>>   
>> -	for_each_pci_dev(dev) {
>> -		if (!n--)
>> -			break;
>> -	}
>> +	dev = xa_load(&pci_seq_tree, n);
>> +	if (dev)
>> +		pci_dev_get(dev);
>>   	return dev;
> I'm a little hesitant to add another place that keeps track of every
> PCI device.  It's a fair bit of code here, and it's redundant
> information, which means more work to keep them all synchronized.
>
> This proc interface feels inherently racy.  We keep track of the
> current item (n) in a struct seq_file, but I don't think there's
> anything to prevent a pci_dev hot-add or -remove between calls to
> pci_seq_start().
Yes, maybe lost some information this time.
>
> Is the proc interface the only place to get this information?  If
> there's a way to get it from sysfs, maybe that is better and we don't
> need to spend effort optimizing the less-desirable path?

This is the situation I encountered: in scenarios of rapid container

scaling, when a container is started, it executes lscpu to traverse

the /proc/bus/pci/devices file, or the container process directly

traverses this file. When many containers are being started at once,

it causes numerous containers to wait due to the locks on the klist

used for traversing pci_dev, which greatly reduces the efficiency of

container scaling and also causes other CPUs to become unresponsive.


User-space programs, including Docker, are clients that we cannot easily 
modify.

Therefore, I attempted to accelerate pci_seq_start() within the kernel.

This indeed resulted in the need for more code to maintain, as we must

ensure both fast access and ordering. Initially, I considered directly

modifying the klist in the driver base module, but such changes would

impact other drivers as well.

Do you have any other good suggestions?


Best Regards,

Guixin liu

>>   }
>>   
>>   static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
>>   {
>> -	struct pci_dev *dev = v;
>> +	struct pci_dev *dev;
>>   
>>   	(*pos)++;
>> -	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
>> +	dev = xa_load(&pci_seq_tree, *pos);
>> +	if (dev)
>> +		pci_dev_get(dev);
> Where is the pci_dev_put() that corresponds with this new
> pci_dev_get()?
In pci_seq_stop(), will call the pci_dev_put().
>
>>   	return dev;
>>   }
>>   
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index e4ce1145aa3e..257ea46233a3 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -53,6 +53,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>>   	pci_npem_remove(dev);
>>   
>>   	device_del(&dev->dev);
>> +	pci_seq_tree_remove_dev(dev);
>>   
>>   	down_write(&pci_bus_sem);
>>   	list_del(&dev->bus_list);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 573b4c4c2be6..aeb3d4cce06a 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -534,6 +534,8 @@ struct pci_dev {
>>   
>>   	/* These methods index pci_reset_fn_methods[] */
>>   	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>> +
>> +	unsigned long long	proc_seq_idx;
>>   };
>>   
>>   static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>> -- 
>> 2.43.0
>>

