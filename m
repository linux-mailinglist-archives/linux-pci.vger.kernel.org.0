Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B6DF4D5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfJUSID (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 14:08:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43281 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUSIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 14:08:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so11821050oih.10;
        Mon, 21 Oct 2019 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UFzcie1Kdy+TQnFgDdcnkE0/mTEbBivghAaYrK9KZs8=;
        b=KDFjqE171QwDsMriP+7dTO2DolIsNlI3o+umpcWe+vJaAfJkpr5v8KSGySpxTcBNXn
         c4TU666kawAQS0CxETuCQDHsw4fe0rXc3UL8pvmPugYog99/rb0akaHtkM2OsOdsqV9T
         pcjxoKlS4V/r7b1YJPXSffHKizDBIrZEZ2ydb0TkvY/sKJnfe8Eos5RAFwqgPWxkdiDI
         ujpKiV+5rQPmHjde7Lz2P3ojbW8yUqvKkgHRKUXqtv4NOHszg+u+lNFMAqX1KKYpGUrs
         u76WQkZFpqvEgRfh7fjjJobJhzj63OGh5XJURcA1Bqa941WecDGluQn0j60Go7ZinUh4
         8VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFzcie1Kdy+TQnFgDdcnkE0/mTEbBivghAaYrK9KZs8=;
        b=OtV4QiWviFf6pkDryAx5Qil6aY321pquatQsBctsii6gLLauaHdrhbzKA8RC7OUaNX
         uatytr/znck9j1et1oOauhJ8X+fcoou+WysbdUE6EyM62atyGHaREtWsHS3KHZtm70NC
         f7i0eto1HS2GJDIloKrEkR+xFKeU/SFrMfFnwQDyptwN6cSvMkaEipQLJtQVBCbgEemJ
         K8AVKCo/WneCo2JVNKDI7/bpYGqF73YBXXZEbkbZjAE4LjmhtXAZB9Q2gM48boUoKShz
         eWwP55qMvpmnc+2JQfpDZUb6Qyfx3v7n6C2PsuJDK/sqCxzGFgx973jAbBrwRhVFTvDT
         EH6w==
X-Gm-Message-State: APjAAAVjVPZ/KJ6OE8Q/tKSZpmLwLiQmtC50zxgWukgNhtGT3ES0oPwA
        gO2ztExbjKxqkSz6JWNW7co=
X-Google-Smtp-Source: APXvYqxMuJx275nZoTHfvIzsgLsAMZziiN0W1oqwo4vbRBZBcmabAKtm7+5+R02HNdWQBW6hbSeyZw==
X-Received: by 2002:aca:1b10:: with SMTP id b16mr20769811oib.110.1571681281993;
        Mon, 21 Oct 2019 11:08:01 -0700 (PDT)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v132sm3947565oif.34.2019.10.21.11.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:08:01 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] PCI: pciehp: Wait for PDS if in-band presence is
 disabled
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-3-stuart.w.hayes@gmail.com>
 <20191021134111.GK2819@lahna.fi.intel.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <2ba3b9ea-488b-91ea-ba41-0602efaa21f4@gmail.com>
Date:   Mon, 21 Oct 2019 13:08:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191021134111.GK2819@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/21/19 8:41 AM, Mika Westerberg wrote:
> On Thu, Oct 17, 2019 at 03:32:55PM -0400, Stuart Hayes wrote:
>> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>
>> When inband presence is disabled, PDS may come up at any time, or not
>> at all. PDS being low may indicate that the card is still mating, and
>> we could expect contact bounce to bring down the link as well.
>>
>> It is reasonable to assume that most cards will mate in a hotplug slot
>> in about a second. Thus, when we know PDS only reflects out-of-band
>> presence, it's worthwhile to wait the extra second or so to make sure
>> the card is properly mated before loading the driver, and to prevent
>> the hotplug code from disabling a device if the presence detect change
>> goes active after the device is enabled.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> One nit below.
> 
>> ---
>> v2:
>>   replace while(true) loop with do...while
>> v3
>>   remove unused variable declaration (pds)
>>   modify text of warning message
>>
>>  drivers/pci/hotplug/pciehp_hpc.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index dc109d521f30..02eb811a014f 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -242,6 +242,22 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>>  	return found;
>>  }
>>  
>> +static void pcie_wait_for_presence(struct pci_dev *pdev)
>> +{
>> +	int timeout = 1250;
>> +	u16 slot_status;
>> +
>> +	do {
>> +		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>> +		if (!!(slot_status & PCI_EXP_SLTSTA_PDS))
> 
> It is more readable if you write it like:
> 
> 		if (slot_status & PCI_EXP_SLTSTA_PDS)
> 

I agree, it is more readable, and the double bang shouldn't be needed for an 
"if" condition.  Thanks.

>> +			return;
>> +		msleep(10);
>> +		timeout -= 10;
>> +	} while (timeout > 0);
>> +
>> +	pci_info(pdev, "Timeout waiting for Presence Detect state to be set\n");
>> +}
>> +
>>  int pciehp_check_link_status(struct controller *ctrl)
>>  {
>>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>> @@ -251,6 +267,9 @@ int pciehp_check_link_status(struct controller *ctrl)
>>  	if (!pcie_wait_for_link(pdev, true))
>>  		return -1;
>>  
>> +	if (ctrl->inband_presence_disabled)
>> +		pcie_wait_for_presence(pdev);
>> +
>>  	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
>>  					PCI_DEVFN(0, 0));
>>  
>> -- 
>> 2.18.1
