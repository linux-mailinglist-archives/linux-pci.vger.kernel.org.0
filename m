Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF1F359C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKGRVP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 12:21:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46021 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGRVP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 12:21:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id r24so2650091otk.12
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2019 09:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VvyVLLVIhuFKB1NmWYbGPFMC+7n42PIg+DfFWWOOQiw=;
        b=M+nWGtg5fEJvzg6WrHoByoElWfQtBVE1TSmjzRinnDPKRKWO30XmCgXo0yWnw8B1Gc
         u1VZylMIfSMCwWNz8Hz+x3g9T6G8EUHuTCRLGs0BAo64lH4cWXZh1qGEvqXbXlzMJ9lb
         rvvPaMRID+5MZvF7U9vYNd/dxp/xI0tuJX0H0dhn6H0h1Npe4XB/QJfgL7RV6lWs54F4
         eOkgHq68hHUrrag6503vC2LWoiuQx8ZCA25CitEsxoZSuzM2iIbpq3AhTwlNNy8T5oYh
         6HXmVQ1T6UeFEmZ7xqFr3ZkTU9ZGAmLwsSGuT0X6xZONooP2bPRy7J6DiRnZdfuj6vmj
         /TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VvyVLLVIhuFKB1NmWYbGPFMC+7n42PIg+DfFWWOOQiw=;
        b=tA2J0iBMpzF+2fFptY1tsYszr6KfufQ3AADJlKG0yCP38ed9Uhe0xdXJoe9TztjExr
         91qmVQ7E6okyjBuPVYI714XqC4drg/05aC/rV2ZS4RmviH1AudgNz/f55/kj6LmKtbnW
         CoPokrA3ZDlDnaSGSrHOK61JF+osEtYNtnb+dr7BLHx2ue2CyPuS+LU9Z1dNAuGa+Cqe
         IepCuMwpjVlBGb7emFeF7W2F82/74Uuzd/4HTHBlJYBhRT03MtEn2jT5nLcBKt/4c6G3
         4aQFE1oEHbU/sBDiXL/aeIsYF3fzGAn5hCIqHfS3NkHGn3+F3OJ2fverwzENhHSiozTk
         3vIg==
X-Gm-Message-State: APjAAAXSDBPyeflFWPN9Javu0jpeI4B4ftb70RB2Z1wIqhrCGuaZl4ql
        iFY7usGjfgPAUx1NyyzuKd4=
X-Google-Smtp-Source: APXvYqyVGFSuUKNH1Bh3oukx9sPF0j62KSriz/WWc3rABI/iCMhlVXOPXzjqj6x8WQ7MvispYn93Bg==
X-Received: by 2002:a9d:7399:: with SMTP id j25mr4195886otk.155.1573147274162;
        Thu, 07 Nov 2019 09:21:14 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id b12sm796864oie.52.2019.11.07.09.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 09:21:13 -0800 (PST)
Subject: Re: [PATCH v1] PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20191011090230.81080-1-andriy.shevchenko@linux.intel.com>
 <20191107151536.GA32742@smile.fi.intel.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <a11f53df-911a-3eee-6bda-01322550f1d4@gmail.com>
Date:   Thu, 7 Nov 2019 11:21:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191107151536.GA32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Andy,
On 11/7/19 9:15 AM, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 12:02:30PM +0300, Andy Shevchenko wrote:
>> Infinite timeout loops are hard to read.

Why do you find infinite timeout loops hard to read? I personally find 
that emphasizing the common case to be more redable. An ideal loop for 
me would look like:

	do {
		do_stuff();
		if (timeout) {
			complain();
			break()
		}
	} while (what_we_expect_has_not_happened());

Cheers,
Alex

>> Refactor it to plausible 'do {} while ()'.
>>
>> Note, the supplied timeout can't be negative for current use,
>> though if it's not dividable to 10, we may go below 0,
>> that's why type of the parameter is int. And thus, we may move
>> the check to the loop condition.
>>
>> No functional changes implied.
> 
> Bjorn, any comment on this? It would be nice to have in since contributors are
> unable to know which style to use. This patch makes similar places follow the
> same style.
> 
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/pci/hotplug/pciehp_hpc.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 1a522c1c4177..e397c78ca232 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -68,7 +68,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>>   	struct pci_dev *pdev = ctrl_dev(ctrl);
>>   	u16 slot_status;
>>   
>> -	while (true) {
>> +	do {
>>   		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>>   		if (slot_status == (u16) ~0) {
>>   			ctrl_info(ctrl, "%s: no response from device\n",
>> @@ -81,11 +81,9 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>>   						   PCI_EXP_SLTSTA_CC);
>>   			return 1;
>>   		}
>> -		if (timeout < 0)
>> -			break;
>>   		msleep(10);
>>   		timeout -= 10;
>> -	}
>> +	} while (timeout > 0);
>>   	return 0;	/* timeout */
>>   }
>>   
>> -- 
>> 2.23.0
>>
> 
