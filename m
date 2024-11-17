Return-Path: <linux-pci+bounces-17001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436E9D041B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95202823D1
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A179170A11;
	Sun, 17 Nov 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AS3hO6Bb"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07D1803A;
	Sun, 17 Nov 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850580; cv=none; b=oxWqzfOZxkV+W7WxS6PpeH1SYdrciLLayhNwUmw41g3D8JzjXNW4iR6diuL3CwlCLK5hyJAKzS4HHnMpUOqcOSNGn2RgX/JuQPsT+zI+VuzsmvDaTwp/4acif01IVN63Q6wajxYO8elIBLiWpGs906m8Lru9GmDQpXJ4sbJ8biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850580; c=relaxed/simple;
	bh=6B9O9K4lKpLnFrRgfITcTiaRr7MosaVzxeLvtDE4CQ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aD11trYG5uNK3ZN4/e7Zl7CAyIZ0aGSxbCzXc/CqP8rC2+Iz40IV4FPeKu0omoMqnwvW97puHsKxwcMOSD0Ox7LJSnBXJmBxNMFDtCBWu4pqAriOBzyppqXuaOoBFFrR/rN0oIzdhHv9J6pcUjy5Tt2bb+uRuETHr0pt3iMpYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AS3hO6Bb; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731850571; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=sPrf19kc7+LO7xSLmSlRMhOGFVSZNNSI0hI3auZl73k=;
	b=AS3hO6BbTxTFpGDJmm2hlKzPNImy8Q7huZCJA4RjHdo1ZPPbohNKZcac0Z+HSFHBAjQpb7iUQZRrUlD3i+jxLOgutDTvUIBdLwWFxy1tCbWR1aZ1id998feRht3V65ZIDL/8IKojg2Qdv2T5fc1kKy2mRY4nX9ARRFKa0AG4NcY=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJZaXPt_1731850569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 Nov 2024 21:36:10 +0800
Message-ID: <9810fadd-2b0b-410b-a8a6-89ddf7a103b9@linux.alibaba.com>
Date: Sun, 17 Nov 2024 21:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org, Lukas Wunner <lukas@wunner.de>
Cc: mahesh@linux.ibm.com, oohall@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com
References: <20241112135419.59491-1-xueshuai@linux.alibaba.com>
 <20241112135419.59491-3-xueshuai@linux.alibaba.com>
 <a76394c4-8746-46c0-9cb5-bf0e2e0aa9b5@amd.com>
 <22d27575-fc68-4a7f-9bce-45b91c7dfb98@linux.alibaba.com>
In-Reply-To: <22d27575-fc68-4a7f-9bce-45b91c7dfb98@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/16 20:44, Shuai Xue 写道:
> 
> 
> 在 2024/11/16 04:20, Bowman, Terry 写道:
>> Hi Shuai,
>>
>>
>> On 11/12/2024 7:54 AM, Shuai Xue wrote:
>>> The AER driver has historically avoided reading the configuration space of
>>> an endpoint or RCiEP that reported a fatal error, considering the link to
>>> that device unreliable. Consequently, when a fatal error occurs, the AER
>>> and DPC drivers do not report specific error types, resulting in logs like:
>>>
>>>    pcieport 0000:30:03.0: EDR: EDR event received
>>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>>    nvme nvme0: frozen state error detected, reset controller
>>>    nvme 0000:34:00.0: ready 0ms after DPC
>>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>>
>>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>>> after hot reset, we can still safely access AER status of the error device.
>>> In such case, report fatal errors which helps to figure out the error root
>>> case.
>>>
>>> After this patch, the logs like:
>>>
>>>    pcieport 0000:30:03.0: EDR: EDR event received
>>>    pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
>>>    pcieport 0000:30:03.0: DPC: ERR_FATAL detected
>>>    pcieport 0000:30:03.0: AER: broadcast error_detected message
>>>    nvme nvme0: frozen state error detected, reset controller
>>>    pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
>>>    nvme 0000:34:00.0: ready 0ms after DPC
>>>    nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
>>>    nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
>>>    nvme 0000:34:00.0:    [ 4] DLP                    (First)
>>>    pcieport 0000:30:03.0: AER: broadcast slot_reset message
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> ---
>>>   drivers/pci/pci.h      |  3 ++-
>>>   drivers/pci/pcie/aer.c | 11 +++++++----
>>>   drivers/pci/pcie/dpc.c |  2 +-
>>>   drivers/pci/pcie/err.c |  9 +++++++++
>>>   4 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 0866f79aec54..6f827c313639 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -504,7 +504,8 @@ struct aer_err_info {
>>>       struct pcie_tlp_log tlp;    /* TLP Header */
>>>   };
>>> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>>> +int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info,
>>> +                  bool link_healthy);
>>>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>>>   #endif    /* CONFIG_PCIEAER */
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 13b8586924ea..97ec1c17b6f4 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1200,12 +1200,14 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
>>>    * aer_get_device_error_info - read error status from dev and store it to info
>>>    * @dev: pointer to the device expected to have a error record
>>>    * @info: pointer to structure to store the error record
>>> + * @link_healthy: link is healthy or not
>>>    *
>>>    * Return 1 on success, 0 on error.
>>>    *
>>>    * Note that @info is reused among all error devices. Clear fields properly.
>>>    */
>>> -int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>> +int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info,
>>> +                  bool link_healthy)
>>>   {
>>>       int type = pci_pcie_type(dev);
>>>       int aer = dev->aer_cap;
>>> @@ -1229,7 +1231,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>>       } else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>>              type == PCI_EXP_TYPE_RC_EC ||
>>>              type == PCI_EXP_TYPE_DOWNSTREAM ||
>>> -           info->severity == AER_NONFATAL) {
>>> +           info->severity == AER_NONFATAL ||
>>> +           (info->severity == AER_FATAL && link_healthy)) {
>>>           /* Link is still healthy for IO reads */
>>>           pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
>>> @@ -1258,11 +1261,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>>>       /* Report all before handle them, not to lost records by reset etc. */
>>>       for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>>> -        if (aer_get_device_error_info(e_info->dev[i], e_info))
>>> +        if (aer_get_device_error_info(e_info->dev[i], e_info, false))
>>>               aer_print_error(e_info->dev[i], e_info);
>>>       }
>>
>> Would it be reasonable to detect if the link is intact and set the aer_get_device_error_info()
>> function's 'link_healthy' parameter accordingly? I was thinking the port upstream capability
>> link status register could be used to indicate the link viability.
>>
>> Regards,
>> Terry
> 
> Good idea. I think pciehp_check_link_active is a good implementation to check
> link_healthy in aer_get_device_error_info().
> 
>    int pciehp_check_link_active(struct controller *ctrl)
>    {
>        struct pci_dev *pdev = ctrl_dev(ctrl);
>        u16 lnk_status;
>        int ret;
>        ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>        if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
>            return -ENODEV;
>        ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>        ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
>        return ret;
>    }
> 
> Thank you for valuable comments.
> 
> Best Regards
> Shuai

Hi, Bowman,

After dive into the code details, I found that both dpc_reset_link() and
aer_root_reset() use pci_bridge_wait_for_secondary_bus() to wait for secondary
bus to be accessible. IMHO, pci_bridge_wait_for_secondary_bus() is better
robustness than function like pciehp_check_link_active(). So I think
reset_subordinates() is good boundary for delineating whether a link is
accessible.

Besides, for DPC driver, the link status of upstream port, e.g, rootport, is
inactive when DPC is triggered, and is recoverd to active until
dpc_reset_link() success. But for AER driver, the link is active before and
after aer_root_reset(). As a result, the AER status will be reported twice.

Best Regards,
Shuai


