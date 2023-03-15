Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8F6BBFBC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 23:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCOW01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCOW00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 18:26:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54EF968D5
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678919184; x=1710455184;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=zuWYUGoyLAPPOtDarSxhtltZuL26PyrDoqkN+06b99U=;
  b=FR6M3cOxBMd8UEeiMUHzge41YoA7kr7JUOTj1QsgYoTpuhQLGgFCmNbZ
   jcxGn4wMaW1exVeBaLKGe1jf+pw2i09WqXY4t4nrXYmJ7rxfTFX/Ny3/0
   EgcNXn096vQiuy3/4KqYGwDqK8i29fbD+AGW/4WX0Ue3xcm+pqxjb0/T/
   WIUvo9x7QZUMgWLP59Xk5T7unT1iodXHAYKWVAlDElktmNd+JNkqsDJbU
   q6M6P0Jpxr4MITNSEp0Dw6am0eAZXMZP6dwBV6Oe/hDV26bdwkqzqZW4r
   j9p4xnHxExmeG00gQHAfeX+4bPQjOv56/ZAQ/lqHcigC4j/Uenh6fjh7R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="402701173"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="402701173"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:25:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679653568"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="679653568"
Received: from kaliving-mobl.amr.corp.intel.com (HELO [10.212.158.22]) ([10.212.158.22])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:25:27 -0700
Message-ID: <122ba43d-4db4-6e2c-bf6e-eff9cbbfd457@linux.intel.com>
Date:   Wed, 15 Mar 2023 15:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Tushar Dave <tdave@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <c17f7476-8ed0-212e-9480-78732635ee3f@nvidia.com>
 <20230314161127.GA1648664@bhelgaas>
 <ZBCuPM0WcWaLwWXJ@kbusch-mbp.dhcp.thefacebook.com>
 <e598b84f-2f90-b29a-6209-17309763514f@nvidia.com>
 <362f552f-df15-878a-1fd6-4ef086e8fdb1@linux.intel.com>
 <d41eb762-af7f-ccd2-51de-5c3f81138985@nvidia.com>
 <1f0a843f-1890-7096-2d43-0b6cb07cafce@linux.intel.com>
In-Reply-To: <1f0a843f-1890-7096-2d43-0b6cb07cafce@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/15/23 3:23 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 3/15/23 3:16 PM, Tushar Dave wrote:
>>
>>
>> On 3/15/23 13:43, Sathyanarayanan Kuppuswamy wrote:
>>>
>>>
>>> On 3/15/23 1:01 PM, Tushar Dave wrote:
>>>>
>>>>
>>>> On 3/14/23 10:26, Keith Busch wrote:
>>>>> On Tue, Mar 14, 2023 at 11:11:27AM -0500, Bjorn Helgaas wrote:
>>>>>> On Mon, Mar 13, 2023 at 05:57:43PM -0700, Tushar Dave wrote:
>>>>>>> On 3/11/23 00:22, Lukas Wunner wrote:
>>>>>>>> On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
>>>>>>>>> On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
>>>>>>>>>> In the log below, pciehp obviously is enabled; should I infer that in
>>>>>>>>>> the log above, it is not?
>>>>>>>>>
>>>>>>>>> pciehp is enabled all the time. In the log above and below.
>>>>>>>>> I do not have answer yet why pciehp shows-up only in some tests (due to DPC
>>>>>>>>> link down/up) and not in others like you noticed in both the logs.
>>>>>>>>
>>>>>>>> Maybe some of the switch Downstream Ports are hotplug-capable and
>>>>>>>> some are not?  (Check the Slot Implemented bit in the PCI Express
>>>>>>>> Capabilities Register as well as the Hot-Plug Capable bit in the
>>>>>>>> Slot Capabilities Register.)
>>>>>>>> ...
>>>>>>
>>>>>>>>>> Generally we've avoided handling a device reset as a
>>>>>>>>>> remove/add event because upper layers can't deal well with
>>>>>>>>>> that.  But in the log below it looks like pciehp *did* treat
>>>>>>>>>> the DPC containment as a remove/add, which of course involves
>>>>>>>>>> configuring the "new" device and its MPS settings.
>>>>>>>>>
>>>>>>>>> yes and that puzzled me why? especially when"Link Down/Up
>>>>>>>>> ignored (recovered by DPC)". Do we still have race somewhere, I
>>>>>>>>> am not sure.
>>>>>>>>
>>>>>>>> You're seeing the expected behavior.  pciehp ignores DLLSC events
>>>>>>>> caused by DPC, but then double-checks that DPC recovery succeeded.
>>>>>>>> If it didn't, it would be a bug not to bring down the slot.  So
>>>>>>>> pciehp does exactly that.  See this code snippet in
>>>>>>>> pciehp_ignore_dpc_link_change():
>>>>>>>>
>>>>>>>>      /*
>>>>>>>>       * If the link is unexpectedly down after successful recovery,
>>>>>>>>       * the corresponding link change may have been ignored above.
>>>>>>>>       * Synthesize it to ensure that it is acted on.
>>>>>>>>       */
>>>>>>>>      down_read_nested(&ctrl->reset_lock, ctrl->depth);
>>>>>>>>      if (!pciehp_check_link_active(ctrl))
>>>>>>>>          pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>>>>>>>      up_read(&ctrl->reset_lock);
>>>>>>>>
>>>>>>>> So on hotplug-capable ports, pciehp is able to mop up the mess
>>>>>>>> created by fiddling with the MPS settings behind the kernel's
>>>>>>>> back.
>>>>>>>
>>>>>>> That's the thing, even on hotplug-capable slot I do not see pciehp
>>>>>>> _all_ the time. Sometime pciehp get involve and takes care of things
>>>>>>> (like I mentioned in the previous thread) and other times no pciehp
>>>>>>> engagement at all!
>>>>>>
>>>>>> Possibly a timing issue, so I'll be interested to see if 53b54ad074de
>>>>>> ("PCI/DPC: Await readiness of secondary bus after reset") makes any
>>>>>> difference.  Lukas didn't mention that, so maybe it's a red herring,
>>>>>> but I'm still curious since it explicitly mentions the DPC reset case
>>>>>> that you're exercising here.
>>>>
>>>> Commit 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset") didn't help.
>>>
>>> I did not check the full thread. Since this seems to be in EDR recovery path, make sure to
>>> include following patch.
>>>
>>> https://lore.kernel.org/lkml/20230215200532.3126937-1-sathyanarayanan.kuppuswamy@linux.intel.com/T/
>>
>> Sorry but in your patch I guess you really want 'pdev' instead of 'dev' in pcie_clear_device_status(dev);
>>
>> or I am missing something?
> 
> You are right. It is pdev. I will fix this in next version.

Actually, it is edev.

> 
>>
>>>
>>>>
>>>> [ 6265.268757] pcieport 0000:a5:01.0: EDR: EDR event received
>>>> [ 6265.276034] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>>>> [ 6265.283780] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 source:0x0000
>>>> [ 6265.292972] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
>>>> [ 6265.301284] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>>> [ 6265.313569] pcieport 0000:a9:10.0:   device [1000:c030] error status/mask=00040000/00180000
>>>> [ 6265.323208] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
>>>> [ 6265.331084] pcieport 0000:a9:10.0: AER:   TLP Header: 6000007a ab0000ff 00000001 629d4318
>>>> [ 6265.340536] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>>>> [ 6265.348320] nvme nvme1: frozen state error detected, reset controller
>>>> [ 6265.419633] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after activation
>>>> [ 6265.627639] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>>>> [ 6265.635289] nvme nvme1: restart after slot reset
>>>> [ 6265.641016] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
>>>> [ 6265.651248] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xe0600000)
>>>> [ 6265.661739] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xe0710004)
>>>> [ 6265.672210] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, writing 0x8)
>>>> [ 6265.681897] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100546)
>>>> [ 6265.692616] pcieport 0000:a9:10.0: AER: broadcast resume message
>>>> [ 6265.716299] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 0xa824144d)
>>>> [ 6265.725614] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading 0x100546)
>>>> [ 6265.734657] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading 0x1080200)
>>>> [ 6265.743824] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
>>>> [ 6265.752348] nvme 0000:ab:00.0: saving config space at offset 0x10 (reading 0xe0710004)
>>>> [ 6265.761647] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
>>>> [ 6265.770247] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
>>>> [ 6265.778857] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
>>>> [ 6265.787450] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
>>>> [ 6265.796034] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
>>>> [ 6265.804620] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
>>>> [ 6265.813201] nvme 0000:ab:00.0: saving config space at offset 0x2c (reading 0xa80a144d)
>>>> [ 6265.822473] nvme 0000:ab:00.0: saving config space at offset 0x30 (reading 0xe0600000)
>>>> [ 6265.831816] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
>>>> [ 6265.840482] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
>>>> [ 6265.849037] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
>>>> [ 6275.037534] block nvme1n1: no usable path - requeuing I/O
>>>> [ 6326.920009] nvme nvme1: I/O 22 QID 0 timeout, disable controller
>>>> [ 6326.988701] nvme nvme1: Identify Controller failed (-4)
>>>> [ 6326.995253] nvme nvme1: Disabling device after reset failure: -5
>>>> [ 6327.032308] pcieport 0000:a9:10.0: AER: device recovery successful
>>>> [ 6327.039781] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>>>> [ 6327.047687] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>>>> [ 6327.083131] pcieport 0000:a5:01.0: EDR: EDR event received
>>>> [ 6327.090173] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>>>> [ 6327.097816] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 source:0x0000
>>>> [ 6327.107009] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
>>>> [ 6327.115330] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>>> [ 6327.127640] pcieport 0000:a9:10.0:   device [1000:c030] error status/mask=00040000/00180000
>>>> [ 6327.137319] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
>>>> [ 6327.145236] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 00000001 5ad65000
>>>> [ 6327.154728] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>>>> [ 6327.162624] nvme nvme1: frozen state error detected, reset controller
>>>> [ 6327.183979] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after activation
>>>> [ 6327.387969] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>>>> [ 6327.395596] nvme nvme1: restart after slot reset
>>>> [ 6327.401313] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
>>>> [ 6327.411517] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 0x0, writing 0xe0600000)
>>>> [ 6327.422045] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 0x4, writing 0xe0710004)
>>>> [ 6327.432523] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, writing 0x8)
>>>> [ 6327.442212] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100546)
>>>> [ 6327.452933] pcieport 0000:a9:10.0: AER: broadcast resume message
>>>> [ 6327.460184] pcieport 0000:a9:10.0: AER: device recovery successful
>>>> [ 6327.467533] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>>>> [ 6327.475367] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>>>>
>>>>>
>>>>> Catching the PDC event may be timing related. pciehp ignores the link events
>>>>> during a DPC event, but it always reacts to PDC since it's indistinguishable
>>>>> from a DPC occuring in response to a surprise removal, and these slots probably
>>>>> don't have out-of-band presence detection.
>>>>
>>>> yeah, In-Band PD Disable bit in Slot Control register of PCIe Downstream Switch port is set to '0' , no idea about out-of-band presence detection!
>>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
