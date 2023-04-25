Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641226EDB6B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 07:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDYF6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 01:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDYF6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 01:58:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFFB768A;
        Mon, 24 Apr 2023 22:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682402312; x=1713938312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=se7YPSlb4h1MC4CMmAIT2KU5ZaEL8RqWu41fI7ro+m0=;
  b=Ej85k1WHrsZzn9ZSsbPKL905G1yGchbNsac4ln6dcXpVBMGyk4KP7Nax
   5I2jYsjBWB6aVysDCDVMlJZOmd6x6MNaymMDONfYpaXY2NJ4KLSq8FXAH
   +kicONGKjZ0HodnR1CsQ7fTVsUB73mUbiOXerrZoQd9mGlbG21OGvimpc
   z1SYjFZpMcO/TFvEz3MzTxQ7PwSJIltRu1V40/JqgxuXUlCLFJSRBnzEQ
   1HcprUDRL3t+WSgDlkDIiodHXgUX/Jh4JeeZgBlujPZF0c4Y2fD6yYQBy
   Rt4MfGJL68OHaz/t8L7wUGuICTUDDwHAaSutmvTNA8Jus8TF4qVrfVtiq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="344147885"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="344147885"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 22:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="867763728"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="867763728"
Received: from jsagoe-mobl1.amr.corp.intel.com (HELO [10.251.8.47]) ([10.251.8.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 22:58:30 -0700
Message-ID: <ba8a948f-d28e-d411-b00f-0a198d53ae47@linux.intel.com>
Date:   Mon, 24 Apr 2023 22:58:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/3] PCI/AER: Disable AER interrupt on suspend
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424055249.460381-1-kai.heng.feng@canonical.com>
 <20230424055249.460381-2-kai.heng.feng@canonical.com>
 <97260e8b-1892-49a5-3792-0e3c28378fc0@linux.intel.com>
 <CAAd53p5nrTQOxLkv+e9gLu3R9iOLXz5taJuwaAO4_W7_y89vEw@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAd53p5nrTQOxLkv+e9gLu3R9iOLXz5taJuwaAO4_W7_y89vEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 4/24/23 10:55 PM, Kai-Heng Feng wrote:
> On Tue, Apr 25, 2023 at 7:47 AM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>>
>> On 4/23/23 10:52 PM, Kai-Heng Feng wrote:
>>> PCIe service that shares IRQ with PME may cause spurious wakeup on
>>> system suspend.
>>>
>>> PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
>>> that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
>>> (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
>>> much here to disable AER during system suspend.
>>>
>>> This is very similar to previous attempts to suspend AER and DPC [1],
>>> but with a different reason.
>>>
>>> [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.feng@canonical.com/
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
>>>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>
>> IIUC, you encounter AER errors during the suspend/resume process, which
>> results in AER IRQ. Because AER and PME share an IRQ, it is regarded as a
>> spurious wake-up IRQ. So to fix it, you want to disable AER reporting,
>> right?
> 
> Yes. That's exactly what happened.
> 
>>
>> It looks like it is harmless to disable the AER during the suspend/resume
>> path. But, I am wondering why we get these errors? Did you check what errors
>> you get during the suspend/resume path? Are these errors valid?
> 
> I really don't know. I think it's similar to the reasoning in commit
> b07461a8e45b ("PCI/AER: Clear error status registers during
> enumeration and restore"): "AER errors might be recorded when
> powering-on devices. These errors can be ignored, ...".
> For this case, it happens when powering-off the device (D3cold) via
> turning off power resources.

Got it.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> 
> Kai-Heng
> 
>>
>>
>>>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 1420e1f27105..9c07fdbeb52d 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
>>>       return 0;
>>>  }
>>>
>>> +static int aer_suspend(struct pcie_device *dev)
>>> +{
>>> +     struct aer_rpc *rpc = get_service_data(dev);
>>> +     struct pci_dev *pdev = rpc->rpd;
>>> +
>>> +     aer_disable_irq(pdev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int aer_resume(struct pcie_device *dev)
>>> +{
>>> +     struct aer_rpc *rpc = get_service_data(dev);
>>> +     struct pci_dev *pdev = rpc->rpd;
>>> +
>>> +     aer_enable_irq(pdev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  /**
>>>   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>>>   * @dev: pointer to Root Port, RCEC, or RCiEP
>>> @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver = {
>>>       .service        = PCIE_PORT_SERVICE_AER,
>>>
>>>       .probe          = aer_probe,
>>> +     .suspend        = aer_suspend,
>>> +     .resume         = aer_resume,
>>>       .remove         = aer_remove,
>>>  };
>>>
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
