Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E124E1F59
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 04:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiCUDyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Mar 2022 23:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiCUDyC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Mar 2022 23:54:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84246AD10F;
        Sun, 20 Mar 2022 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647834757; x=1679370757;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+xVB4tejKj+jXZwnepYkpDsgaZslDPFHLemDy5ezqI8=;
  b=Z8qSyD0mhjgEm1oB8M3MmV4RasRAYQ0hMLngK3qe4okhKVIfyaBs1WPz
   LXwCDmsJebXNq8NkbTACJGFlZAZccPzI+Nf6ijz3/167coC268RE4BFiG
   No9hAR/2Q3Wx0CZgPHYLkUF7DSi09Med2etaxEIuSbvZsL/YEGsZgknf+
   IJpvAj3aF+jptWl+i9QSoikRNX6NWWLiudzTwNXtr5djcBoPzNCgDARK1
   PsCqNgiWAJda63lt842Figolb1dvwN0v22dHcZ1t8qd+Ld72OfvaB6QBH
   c36Fu0gJ1vD0BSzEPIN+hM4lP1pVDUPN+MkzflVRESXYA+s4wtKSqGxpJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257408864"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="257408864"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 20:52:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="600348464"
Received: from miahcroc-mobl.amr.corp.intel.com (HELO [10.212.144.180]) ([10.212.144.180])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 20:52:35 -0700
Message-ID: <9d47ee80-1f92-4b52-1080-4d8325dc4a5e@linux.intel.com>
Date:   Sun, 20 Mar 2022 20:52:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
 <427f19c6-32f0-684e-5fdd-2e5ed192b71d@linux.intel.com>
 <CAAd53p6ZrFNhtKk=9wz8SF68jBuNajKgOzZFgHgKgd57Zp3pHg@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAd53p6ZrFNhtKk=9wz8SF68jBuNajKgOzZFgHgKgd57Zp3pHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/20/22 7:38 PM, Kai-Heng Feng wrote:
> On Sun, Mar 20, 2022 at 4:38 AM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>>
>> On 1/26/22 6:54 PM, Kai-Heng Feng wrote:
>>> Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
>>> hint") enables ACS, and some platforms lose its NVMe after resume from
>>
>> Why enabling ACS makes platform lose NVMe? Can you add more details
>> about the problem?
> 
> I don't have a hardware analyzer, so the only detail I can provide is
> the symptom.
> I believe the affected system was sent Intel, and there wasn't any
> feedback since then.

Since your commit log refers to ACS, I think first we need to understand
following points.

1. Why we get ACSViol during S3 resume. Is this just a noise?
2. Why AER recovery fails?
3. Is this common for all platforms, or only happens in your test
    platform?

If you are not clear about above points, I think you can submit this
patch as adding suspend/resume support to AER/DPC driver and not include
the issue about ACS.

 From your commit log, the problem is not very clear.

> 
>>
>>> S3:
>>> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
>>> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
>>> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
>>> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
>>> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
>>> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
>>> [   50.947843] nvme nvme0: frozen state error detected, reset controller
>>>
>>> It happens right after ACS gets enabled during resume.
>>>
>>> There's another case, when Thunderbolt reaches D3cold:
>>> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
>>> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>>> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
>>> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
>>> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
>>> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
>>
>> no callback message means one or more devices in the given port does not
>> support error handler. How is this related to ACS?
> 
> This case is about D3cold, not related to ACS.
> And no error_detected is just part of the message. The whole AER
> message is more important.
> 
> Kai-Heng
> 
>>
>>> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
>>> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
>>>
>>> So disable AER service to avoid the noises from turning power rails
>>> on/off when the device is in low power states (D3hot and D3cold), as
>>> PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
>>> transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
>>> with aux power) and L3 (D3cold).
>>>
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
>>> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> v2:
>>>    - Wording change.
>>>
>>>    drivers/pci/pcie/aer.c | 31 +++++++++++++++++++++++++------
>>>    1 file changed, 25 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 9fa1f97e5b270..e4e9d4a3098d7 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -1367,6 +1367,22 @@ static int aer_probe(struct pcie_device *dev)
>>>        return 0;
>>>    }
>>>
>>> +static int aer_suspend(struct pcie_device *dev)
>>> +{
>>> +     struct aer_rpc *rpc = get_service_data(dev);
>>> +
>>> +     aer_disable_rootport(rpc);
>>> +     return 0;
>>> +}
>>> +
>>> +static int aer_resume(struct pcie_device *dev)
>>> +{
>>> +     struct aer_rpc *rpc = get_service_data(dev);
>>> +
>>> +     aer_enable_rootport(rpc);
>>> +     return 0;
>>> +}
>>> +
>>>    /**
>>>     * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
>>>     * @dev: pointer to Root Port, RCEC, or RCiEP
>>> @@ -1433,12 +1449,15 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>>    }
>>>
>>>    static struct pcie_port_service_driver aerdriver = {
>>> -     .name           = "aer",
>>> -     .port_type      = PCIE_ANY_PORT,
>>> -     .service        = PCIE_PORT_SERVICE_AER,
>>> -
>>> -     .probe          = aer_probe,
>>> -     .remove         = aer_remove,
>>> +     .name                   = "aer",
>>> +     .port_type              = PCIE_ANY_PORT,
>>> +     .service                = PCIE_PORT_SERVICE_AER,
>>> +     .probe                  = aer_probe,
>>> +     .suspend                = aer_suspend,
>>> +     .resume                 = aer_resume,
>>> +     .runtime_suspend        = aer_suspend,
>>> +     .runtime_resume         = aer_resume,
>>> +     .remove                 = aer_remove,
>>>    };
>>>
>>>    /**
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
