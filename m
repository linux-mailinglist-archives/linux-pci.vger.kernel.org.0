Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E163BDF4F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 00:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGFWRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWRo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 18:17:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149DC061574
        for <linux-pci@vger.kernel.org>; Tue,  6 Jul 2021 15:15:05 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so328690otl.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Jul 2021 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=alaBIcPjtR5SO43mLw3wyiICmJV1pgc+CN0LQaZTtL4=;
        b=FZ8UOYRbhl0lP+M/wV+79So4wS4vhYVFgCk+x86Gp1GBDbLTeDju/tr3jxxO6gUYFo
         DeVvbtcCk2ILIeIC0zNOT6YhSiBx1WvuzvvPSKfBoZDqVSbHs6kFJSvVKRFCUteoIJpI
         PaTCP6GEqJsmBXyc5qe3ONwhDztVxMMuSNCjUMF5jhkfgpo8sxXFeLVQvKS5Ouy7uF37
         GK/ZBz35nTEZXEwMTXKn+hkyT4DTo05Bb3SbBKz3HTGaQxLlaBddjGB5PuwWRiJFi5Tp
         pJkgYlszSFn3b5VpY/X0y8SpB0Y6RFa/OqZxEVBFSiPg2RyL5tzmZNlC4v2nxDUuB+vS
         /Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=alaBIcPjtR5SO43mLw3wyiICmJV1pgc+CN0LQaZTtL4=;
        b=OLLlylvblxrUACS3gAfooaVa6pD1FnMEkpV0P1QqvD7Dr+Le8VbKYZhtNQ9JDhuRYm
         rHfG+Hy3smSWtWO+UObpBubET9Be8NpXQ5DvlU/znyVoKINKYqb+h4hOjDivWGFQknan
         IPfpMgp/v4kY+BREwzgQlke1qbOuH/Nqs3GCj0qPbpF+cRJEIbhmnwOeCFFsoHUp4Voj
         vIbqjotulmkOpS7pBV6mltDCIohpV0+bOMDym4v9wqlAZ4AVOS8ynqg5aMWg9yssz+HZ
         BRbd7sLGEIPOZ3JQnrr0aDHZDxBcDzq6RkQK1KpfNuBPpUJPHEGJ8qQrdpv1gTgBcJPQ
         oqLQ==
X-Gm-Message-State: AOAM533NgIibA8FuXG+7j/ncRNg1c12yMutRZteUM/SLqyve6YSXedAO
        DsRcbIJpLmLUZKW1dKa4sJA84RsuUAiF0zsg
X-Google-Smtp-Source: ABdhPJxTnZ975uTmwIN4qLMchFyaeyMKd0hYPR4XnkvGfD7KLwABYpXRLdm1hC2jlVl05qQg7nMkrg==
X-Received: by 2002:a05:6830:3089:: with SMTP id f9mr16052644ots.160.1625609705097;
        Tue, 06 Jul 2021 15:15:05 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:d456:b7b1:8f00:bd70? (2603-8081-2802-9dfb-d456-b7b1-8f00-bd70.res6.spectrum.com. [2603:8081:2802:9dfb:d456:b7b1:8f00:bd70])
        by smtp.gmail.com with ESMTPSA id y6sm3761889oiy.18.2021.07.06.15.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 15:15:04 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <0be565d97438fe2a6d57354b3aa4e8626952a00b.1619857124.git.lukas@wunner.de>
 <20210616221945.GA3010216@bjorn-Precision-5520>
 <20210620073804.GA13118@wunner.de>
 <08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com>
 <20210626065049.GA19767@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <661f1019-da20-6656-989f-2e7dea240fc4@gmail.com>
Date:   Tue, 6 Jul 2021 17:15:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210626065049.GA19767@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/26/2021 1:50 AM, Lukas Wunner wrote:
> On Fri, Jun 25, 2021 at 03:38:41PM -0500, stuart hayes wrote:
>> I have a system that is failing to recover after an EDR event with (or
>> without...) this patch.  It looks like the problem is similar to what this
>> patch is trying to fix, except that on my system, the hotplug port is
>> downstream of the root port that has DPC, so the "link down" event on it is
>> not being ignored.  So the hotplug code disables the slot (which contains an
>> NVMe device on this system) while the nvme driver is trying to use it, which
>> results in a failed recovery and another EDR event, and the kernel ends up
>> with the DPC trigger status bit set in the root port, so everything
>> downstream is gone.
>>
>> I added the hack below so the hotplug code will ignore the "link down"
>> events on the ports downstream of the root port during DPC recovery, and it
>> recovers no problem.  (I'm not proposing this as a correct fix.)
> 
> Please help me understand what's causing the Link Down event in the
> first place:
> 
> With DPC, the hardware (only) disables the link on the port containing the
> error.  Since that's the Root Port above the hotplug port in your case,
> the link between the hotplug port and the NVMe drive should remain up.
> 
> Since your patch sets the PCI_DPC_RECOVERING flag during invocation
> of the dev->driver->err_handler->slot_reset() hook, I assume that's
> what's causing the Link Down.  However pcie_portdrv_slot_reset()
> only restores and saves PCI config space, I don't think that's
> causing a Link Down?
> 
> Is maybe nvme_slot_reset() causing the Link Down on the parent hotplug port?
> 
> Thanks,
> 
> Lukas
> 

Sorry for the delayed response--I was out of town.

I believe the Link Down is happening because a hot reset is propagated 
down when the link is lost under the root port 64:02.0.  From the PCIe 
Base Spec 5.0, section 6.6.1 "conventional reset":

• For a Switch, the following must cause a hot reset to be sent on all 
Downstream Ports:
   ...
   ◦ The Data Link Layer of the Upstream Port reporting DL_Down status. 
In Switches that support Link speeds greater than 5.0 GT/s, the Upstream 
Port must direct the LTSSM of each Downstream Port to the Hot Reset 
state, but not hold the LTSSMs in that state. This permits each 
downstream Port to begin Link training immediately after its hot reset 
completes. This behavior is recommended for all Switches.
   ◦ Receiving a hot reset on the Upstream Port
(end of paste from pci spec)

For reference, here's the "lspci -t" output covering the root port 
64:02.0 that is getting the DPC... there are NVMe drives at 69:00.0, 
6a:00.0, 6c:00.0, and 6e:00.0, and a SAS controller at 79:00.0.

  +-[0000:64]-+-00.0
  |           +-00.1
  |           +-00.2
  |           +-00.4
  | 
\-02.0-[65-79]----00.0-[66-79]--+-00.0-[67-70]----00.0-[68-70]--+-00.0-[69]----00.0
  |                                           | 
       +-04.0-[6a]----00.0
  |                                           | 
       +-08.0-[6b]--
  |                                           | 
       +-0c.0-[6c]----00.0
  |                                           | 
       +-10.0-[6d]--
  |                                           | 
       +-14.0-[6e]----00.0
  |                                           | 
       +-18.0-[6f]--
  |                                           | 
       \-1c.0-[70]--
  | 
+-04.0-[71-76]----00.0-[72-76]--+-10.0-[73]--
  |                                           | 
       +-14.0-[74]--
  |                                           | 
       +-18.0-[75]--
  |                                           | 
       \-1c.0-[76]--
  |                                           +-08.0-[77-78]----00.0-[78]--
  |                                           \-1c.0-[79]----00.0

I put in some debug code to printk the config registers before the 
config space is restored.  Before I trigger the DPC, the slot status 
register at 68:00.0 reads 0x40 (presence detected), and after the DPC 
(but before restoring PCI config space for 68:00.0), it reads 0x140 (DLL 
state changed + presence detected).

Before config space is restored to 68:00.0, the command register is 0. 
After config space is restored, I see "pcieport 0000:68:00.0: pciehp: 
pending interrupts 0x0010 from Slot Status" followed by "...pciehp: 
Slot(211): Link Down".  So I assume as soon as it is able to (when its 
config space is restored), 68:00.0 sends the hotplug interrupt, which 
takes down 69:00.0.


>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index b576aa890c76..dfd983c3c5bf 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -119,8 +132,10 @@ static int report_slot_reset(struct pci_dev *dev, void
>> *data)
>>   		!dev->driver->err_handler->slot_reset)
>>   		goto out;
>>
>> +	set_bit(PCI_DPC_RECOVERING, &dev->priv_flags);
>>   	err_handler = dev->driver->err_handler;
>>   	vote = err_handler->slot_reset(dev);
>> +	clear_bit(PCI_DPC_RECOVERING, &dev->priv_flags);
>>   	*result = merge_result(*result, vote);
>>   out:
>>   	device_unlock(&dev->dev);
