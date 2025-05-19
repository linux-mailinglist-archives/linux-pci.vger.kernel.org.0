Return-Path: <linux-pci+bounces-28032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0406ABCA4E
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900033B1A24
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B1222571;
	Mon, 19 May 2025 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVZMHXQm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146522256A;
	Mon, 19 May 2025 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690956; cv=none; b=S5lrmvv9P2nvqocZ3HRO3AjDTU/1Pcw4NVald9Za6pfQAGcfSfAgCa9mzJuqtc2OSqVqHC8x3hyW7LUp9xODMcvH/bvrXMC9V6PzVkFRrnhoS2hmCH1VP0nBV70CWaManSO7rlS/Ri/Kuz+vcjmdsioofb426/GQIKYNHmTjuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690956; c=relaxed/simple;
	bh=QnEMGygcPA0f5Zad7UyQb4fzXv2pbt0ZV6tKHUFbge8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh8y7bqAM+O4z9HKO1/ViBeg6YzB4GDBPnX+NC+Y5DxyNnZM7c7n2G+QsXDRk5t6bfZICZuXe7NUCVHGFDl62yghtWiTdy6cG3EC6MsaxUzgNCiEtVZq0quPoibJ0CS9XX73bGSZ3tJUzyBdn913DG7fOOyUapEGCqqXkfTS4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVZMHXQm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ede096d73so34889805e9.2;
        Mon, 19 May 2025 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747690953; x=1748295753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVHkFyy8oK5TfjbHGf8VAG29vEH7+P6whpOQorlUcWQ=;
        b=IVZMHXQmZoQsBqU8pD7SUk4vJXECb0lBBbpGFzgsqw0Bamn0huCUP7O6eZsn94A73A
         GkcI1VhU/i9FSv4PZ7ecbrIANzlO9Zi4obOhtShfYtiqa3Q6NxOsFgFuWVieZgLN/9I0
         FdWKfG5ZayO2q1cGIvpYNKSZEA0HyzccEbC59QLkQUBGZ7WYCS8ye/D8rTkpeGXKqwQ+
         PL95BSYMYNQoN5XUiksqfVIJ0W9nhkSrfXiP+jcB9NegogF/dmzKyw0V2erL/PwlPtpg
         vogf8dGLv4bUespAB/vPkbDOemScLA+FiwD2DpKQLSZjX1ioAMgp0UrlUDNxOnv8gY0q
         6J1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747690953; x=1748295753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVHkFyy8oK5TfjbHGf8VAG29vEH7+P6whpOQorlUcWQ=;
        b=XHsBtE9FJFG/XAoO/nm4q6ZQDpLHtYvRXDzJxPhbClaX1DeOLVVPYfrCBjB4P2GHsc
         4uOtB4tLd+/fkDX2hH0K74aQkckEXwNe2hDG+ukD9CHch35SCMDace5HeY1mS4P9jKc2
         EnoJ5RLD1ShfEXZ/Tk/xsQZIKXOxL5iQOhGRVJhX60kMCmN/lvdePQ/99W/lISSkn+E3
         mgskXlcWl081sUFTw2Ai2zjktWpg/3jw72ZVYZbZzEiJ3gvoh9Qd5afFDlnW37mgGu0j
         4x3KBJMy35DPVS1kK7o0kcPQbdeJdURjGzXpHwAgzwIac//fQp+qQTeLvdoXBigkyLot
         B/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBrgDaVMA0axRsuHBcSlN4Wdf4voyt8/RwT6hBa7J8pahA7RbwLoeR27MDg/YkueVCbgLy1Zu4fczMkR0=@vger.kernel.org, AJvYcCWbdKWvh/BRvBu5xjYloxJgYaOMJyq8VHoVhfW+wZeQuf2sYmGZmEnXNPetWcLK3mrp7amZy15UQ44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICYehJOmmMcxEg78WOWSz8MLEpqybZJlOxYLASpWuZPpwI7Mc
	czu1e9wRNo1/B+OYTnHLuKNS2dVxUjj99Qu/kMeAsWwyafytE+XklJIW
X-Gm-Gg: ASbGnct0y3hQOB2lYPrYtVCzrtJ+ooz/+JwhOELGMb6k9qc9UH8qsbyEYHYP7UtDbyr
	uHcXD5RNWl7bmVLfmRzKbT2QOR3gzXAVAOjbRHpn+8AY6GTtVUcXvQjdI9ZQungS7sh5v8Ax8cw
	1kRAAv1YQWW7zYE/4+lzLyITQAezaIp2PPkEXEo+JhhN1JC4tvU2suNtBJd+dpXKCwJRnAZdnIs
	kgPcJmxGdAMmxRcYvnrrSyQRsMFmhOKecXgv/f1RTeitSRa0/9wehugu9P2O6H9UwdFPtLSB/n7
	Xlq2lYcNStuVQytU16b74Tf9k5xSBH6blRpNzhiLdPsnJ282+5V7JTXucNRd+U8=
X-Google-Smtp-Source: AGHT+IFmA5/6QPgZj8I51Svm91lEeVnURAzRcIbwPNgquD4PPqbXskXY0PnIithLK6BBgFY7KwwrbA==
X-Received: by 2002:a05:600c:a378:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-442fd64dfb3mr173307515e9.16.1747690952955;
        Mon, 19 May 2025 14:42:32 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm4431325e9.3.2025.05.19.14.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 14:42:32 -0700 (PDT)
Message-ID: <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
Date: Mon, 19 May 2025 23:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
To: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 lukas@wunner.de, aravind.iddamsetty@linux.intel.com, superm1@kernel.org
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <aCsK743YSuahPtnH@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/19/25 12:41, Raag Jadav wrote:
> On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
>> If error status is set on an AER capable device, most likely either the
>> device recovery is in progress or has already failed. Neither of the
>> cases are well suited for power state transition of the device, since
>> this can lead to unpredictable consequences like resume failure, or in
>> worst case the device is lost because of it. Leave the device in its
>> existing power state to avoid such issues.
>>
>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>> ---
>>
>> v2: Synchronize AER handling with PCI PM (Rafael)
>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>     Elaborate "why" (Bjorn)
>> v4: Rely on error status instead of device status
>>     Condense comment (Lukas)
> Since pci_aer_in_progress() is changed I've not included Rafael's tag with
> my understanding of this needing a revisit. If this was a mistake, please
> let me know.
>
> Denis, Mario, does this fix your issue?
>
Hello,

Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL

>> More discussion on [1].
>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>
>>  drivers/pci/pci.c      |  9 +++++++++
>>  drivers/pci/pcie/aer.c | 13 +++++++++++++
>>  include/linux/aer.h    |  2 ++
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 4d7c9f64ea24..a20018692933 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -9,6 +9,7 @@
>>   */
>>  
>>  #include <linux/acpi.h>
>> +#include <linux/aer.h>
>>  #include <linux/kernel.h>
>>  #include <linux/delay.h>
>>  #include <linux/dmi.h>
>> @@ -1539,6 +1540,14 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>  	   || (state == PCI_D2 && !dev->d2_support))
>>  		return -EIO;
>>  
>> +	/*
>> +	 * If error status is set on an AER capable device, it is not well
>> +	 * suited for power state transition. Leave it in its existing power
>> +	 * state to avoid issues like unpredictable resume failure.
>> +	 */
>> +	if (pci_aer_in_progress(dev))
>> +		return -EIO;
>> +
>>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>  		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a1cf8c7ef628..617fbac0d38a 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -237,6 +237,19 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>  
>> +bool pci_aer_in_progress(struct pci_dev *dev)
>> +{
>> +	int aer = dev->aer_cap;
>> +	u32 cor, uncor;
>> +
>> +	if (!pcie_aer_is_native(dev))
>> +		return false;
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &cor);
>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor);
>> +	return cor || uncor;
>> +}
>> +
>>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>  {
>>  	int rc;
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..e6a380bb2e68 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>  #endif
>>  
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>> -- 
>> 2.34.1
>>

