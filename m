Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485455F60C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiF2GJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiF2GIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:08:34 -0400
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 23:08:27 PDT
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CEB1D0C7
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 23:08:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 834993F620;
        Wed, 29 Jun 2022 08:00:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.11
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 48l2bCkwSLvs; Wed, 29 Jun 2022 08:00:23 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 51F693F5FC;
        Wed, 29 Jun 2022 08:00:23 +0200 (CEST)
Received: from [192.168.0.209] (h-155-4-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B14423625BA;
        Wed, 29 Jun 2022 08:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1656482422; bh=kedDAyhqxce/LSmugrguo+Fkh8dnHfaxJ9IvL0i7KhU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XiLsLEUj7X41Aj+VNUt508HLZA2AYA3sOxu7Q1X7NFYIbwDnY1k7YLkRX7W5QXx2T
         yLkvVX+HViaKP1Ltr7aiXuw4Cxvpih6tSYL79c6tmogvySHwbm4UL4pHGMoNIuovAa
         qppJ3CONyQq4wj19gj7aRUluAiPjUDR77c5J0MYc=
Message-ID: <c1a2aef7-9c48-ef87-6275-1eb5ea33b45d@shipmail.org>
Date:   Wed, 29 Jun 2022 08:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Content-Language: en-US
To:     "Dandamudi, Priyanka" <priyanka.dandamudi@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Auld, Matthew" <matthew.auld@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220617184441.7kbs4al7gmpxjuuy@ldmartin-desk2>
 <20220617203252.GA1203491@bhelgaas>
 <20220617212727.h5r2o3schvl73bbk@ldmartin-desk2>
 <21bce72a-3537-0ff2-2553-4d62cc86ffbd@amd.com>
 <DM6PR11MB4492AEEEDB2CC5E6B861B93F8DB49@DM6PR11MB4492.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
In-Reply-To: <DM6PR11MB4492AEEEDB2CC5E6B861B93F8DB49@DM6PR11MB4492.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/24/22 06:02, Dandamudi, Priyanka wrote:
>
>> -----Original Message-----
>> From: Christian König <christian.koenig@amd.com>
>> Sent: 18 June 2022 08:45 PM
>> To: De Marchi, Lucas <lucas.demarchi@intel.com>; Bjorn Helgaas
>> <helgaas@kernel.org>
>> Cc: linux-pci@vger.kernel.org; intel-gfx@lists.freedesktop.org; Sergei
>> Miroshnichenko <s.miroshnichenko@yadro.com>; linux-
>> kernel@vger.kernel.org; Dandamudi, Priyanka
>> <priyanka.dandamudi@intel.com>; Auld, Matthew
>> <matthew.auld@intel.com>; Bjorn Helgaas <bhelgaas@google.com>
>> Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
>> resizable bar
>>
>> Am 17.06.22 um 23:27 schrieb Lucas De Marchi:
>>> On Fri, Jun 17, 2022 at 03:32:52PM -0500, Bjorn Helgaas wrote:
>>>> [+cc Christian, author of pci_resize_resource(), Sergei, author of
>>>> rebalancing patches]
>>>>
>>>> Hi Lucas,
>>>>
>>>> On Fri, Jun 17, 2022 at 11:44:41AM -0700, Lucas De Marchi wrote:
>>>>> Cc'ing intel-pci, lkml, Bjorn
>>>>>
>>>>> On Fri, Jun 17, 2022 at 11:32:37AM +0300, Jani Nikula wrote:
>>>>>> On Thu, 16 Jun 2022, priyanka.dandamudi@intel.com wrote:
>>>>>>> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>>>>>>>
>>>>>>> Add support for the local memory PICe resizable bar, so that
>>>>>>> local memory can be resized to the maximum size supported by the
>>>>> device,
>>>>>>> and mapped correctly to the PCIe memory bar. It is usual that
>>>>>>> GPU devices expose only 256MB BARs primarily to be compatible
>>>>>>> with
>>>>> 32-bit
>>>>>>> systems. So, those devices cannot claim larger memory BAR
>>>>> windows size due
>>>>>>> to the system BIOS limitation. With this change, it would be
>>>>> possible to
>>>>>>> reprogram the windows of the bridge directly above the
>>>>> requesting device
>>>>>>> on the same BAR type.
>>>>> There is a big caveat here that this may be too late as other
>>>>> drivers may have already mapped their BARs - so probably too late in
>>>>> the pci scan for it to be effective. In fact, after using this for a
>>>>> while, it seems to fail too often, particularly on CFL systems.
>>>> Help me understand the "too late" part.  Do you mean that there is
>>>> enough available space for the max BAR size, but it's fragmented and
>>>> therefore not usable?  And that if we could do something earlier,
>>>> before drivers have claimed their devices, we might be able to
>>>> compact the BARs of other devices to make a larger contiguous available
>> space?
>>> yes. I will dig some logs I had in the past to confirm.
>>>
>>>
>>>> That is theoretically possible, but I think the current
>>>> pci_resize_resource() only supports resizing of the specified BAR and
>>>> any upstream bridge windows.  I don't think it supports moving BARs
>>>> of other devices.
>>>>
>>>> Sergei did some nice work that might help with this situation because
>>>> it can move BARs around more generally.  It hasn't quite achieved
>>>> critical mass yet, but maybe this would help get there:
>>>>
>>>>
>>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flor
>>>> e.kernel.org%2Flinux-pci%2F20201218174011.340514-1-
>> s.miroshnichenko%4
>> 0yadro.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C8
>> 096027
>> f68484d0656b108da50a82e7d%7C3dd8961fe4884e608e11a82d994e183d%7C
>> 0%7C0%
>> 7C637910980509199388%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>> wMDAiLCJQ
>> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;
>> sdata=
>> %2FfntE2FTQ8wmLnz4wnzk94R0GMLEwVs7Mj18%2B9Q6PJk%3D&amp;reser
>> ved=0
>>> oh... I hadn't thought about pause/ioremap/unpause. That looks rad :).
>>> So it seems this would integrate neatly with
>>> pci_resize_resource() (what this patch is doing), as long as drivers
>>> for devices affected implement
>>> .bar_fixed()/.rescan_prepare()/.rescan_done(). That seems it would
>>> solve our issues too.
>> Well we never ran into any of the issues you describe with PCIe BAR resize
>> for GPUs so there must be something you do differently to AMD hardware
>> regarding this.
>>
>> Additional to that keep in mind that you can't resize the BAR before kicking
>> out vgacon/efifb or otherwise it can happen that the just released 256MiB
>> window is still used while you try to resize it. When you do that you usually
>> end up with a hard lockup of the system.
>>
>> Regards,
>> Christian.
>>
>>> thanks
>>> Lucas De Marchi
>>>
>>>> If I understand Sergei's series correctly, this rebalancing actually
>>>> cannot be done during enumeration because we only move BARs if a
>>>> driver for the device indicates that it supports it, so there would
>>>> be no requirement to do this early.
>>>>
>>>>> Do we have any alternative to be done in the PCI subsystem during
>>>>> the scan?  There is other work in progress to allow i915 to use the
>>>>> rest of the device memory even with a smaller BAR, but it would be
>>>>> better if we can improve our chances of succeeding the resize.
>>>>>>> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>>>>>>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>>>>>>> Cc: Stuart Summers <stuart.summers@intel.com>
>>>>>>> Cc: Michael J Ruhl <michael.j.ruhl@intel.com>
>>>>>>> Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
>>>>>>> Signed-off-by: Priyanka Dandamudi
>> <priyanka.dandamudi@intel.com>
>>>>>>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>>>>> Please see
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
>> re.kernel.org%2Fr%2F87pmj8vesm.fsf%40intel.com&amp;data=05%7C01%7C
>> ch
>> ristian.koenig%40amd.com%7C8096027f68484d0656b108da50a82e7d%7C3d
>> d896
>> 1fe4884e608e11a82d994e183d%7C0%7C0%7C637910980509199388%7CUnk
>> nown%7C
>> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
>> CJX
>> VCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=d4cf7HQ6t7y1Xobwjdt8im%
>> 2Fh0E5IZ
>>>>> sXgzQDpsB2vCU4%3D&amp;reserved=0
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/i915/i915_driver.c | 92
>>>>> ++++++++++++++++++++++++++++++
>>>>>>>    1 file changed, 92 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/i915/i915_driver.c
>>>>> b/drivers/gpu/drm/i915/i915_driver.c
>>>>>>> index d26dcca7e654..4bdb471cb2e2 100644
>>>>>>> --- a/drivers/gpu/drm/i915/i915_driver.c
>>>>>>> +++ b/drivers/gpu/drm/i915/i915_driver.c
>>>>>>> @@ -303,6 +303,95 @@ static void sanitize_gpu(struct
>>>>> drm_i915_private *i915)
>>>>>>>            __intel_gt_reset(to_gt(i915), ALL_ENGINES);
>>>>>>>    }
>>>>>>>
>>>>>>> +static void __release_bars(struct pci_dev *pdev) {
>>>>>>> +    int resno;
>>>>>>> +
>>>>>>> +    for (resno = PCI_STD_RESOURCES; resno <
>>>>> PCI_STD_RESOURCE_END; resno++) {
>>>>>>> +        if (pci_resource_len(pdev, resno))
>>>>>>> +            pci_release_resource(pdev, resno);
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void
>>>>>>> +__resize_bar(struct drm_i915_private *i915, int resno,
>>>>> resource_size_t size)
>>>>>>> +{
>>>>>>> +    struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>>>>>> +    int bar_size = pci_rebar_bytes_to_size(size);
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    __release_bars(pdev);
>>>>>>> +
>>>>>>> +    ret = pci_resize_resource(pdev, resno, bar_size);
>>>>>>> +    if (ret) {
>>>>>>> +        drm_info(&i915->drm, "Failed to resize BAR%d to %dM
>>>>> (%pe)\n",
>>>>>>> +             resno, 1 << bar_size, ERR_PTR(ret));
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    drm_info(&i915->drm, "BAR%d resized to %dM\n", resno, 1 <<
>>>>> bar_size);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/* BAR size starts from 1MB - 2^20 */ #define BAR_SIZE_SHIFT 20
>>>>>>> +static resource_size_t __lmem_rebar_size(struct
>>>>>>> +drm_i915_private *i915, int resno) {
>>>>>>> +    struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>>>>>> +    u32 rebar = pci_rebar_get_possible_sizes(pdev, resno);
>>>>>>> +    resource_size_t size;
>>>>>>> +
>>>>>>> +    if (!rebar)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    size = 1ULL << (__fls(rebar) + BAR_SIZE_SHIFT);
>>>>>>> +
>>>>>>> +    if (size <= pci_resource_len(pdev, resno))
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    return size;
>>>>>>> +}
>>>>>>> +
>>>>>>> +#define LMEM_BAR_NUM 2
>>>>>>> +static void i915_resize_lmem_bar(struct drm_i915_private *i915)
>>>>>>> +{
>>>>>>> +    struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>>>>>> +    struct pci_bus *root = pdev->bus;
>>>>>>> +    struct resource *root_res;
>>>>>>> +    resource_size_t rebar_size = __lmem_rebar_size(i915,
>>>>> LMEM_BAR_NUM);
>>>>>>> +    u32 pci_cmd;
>>>>>>> +    int i;
>>>>>>> +
>>>>>>> +    if (!rebar_size)
>>>>>>> +        return;
>>>>>>> +
>>>>>>> +    /* Find out if root bus contains 64bit memory addressing */
>>>>>>> +    while (root->parent)
>>>>>>> +        root = root->parent;
>>>>>>> +
>>>>>>> +    pci_bus_for_each_resource(root, root_res, i) {
>>>>>>> +        if (root_res && root_res->flags & (IORESOURCE_MEM |
>>>>>>> +                    IORESOURCE_MEM_64) && root_res->start >
>>>>> 0x100000000ull)
>>>>>>> +            break;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /* pci_resize_resource will fail anyways */
>>>>>>> +    if (!root_res) {
>>>>>>> +        drm_info(&i915->drm, "Can't resize LMEM BAR - platform
>>>>> support is missing\n");
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    /* First disable PCI memory decoding references */
>>>>>>> +    pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
>>>>>>> +    pci_write_config_dword(pdev, PCI_COMMAND,
>>>>>>> +                   pci_cmd & ~PCI_COMMAND_MEMORY);
>>>>>>> +
>>>>>>> +    __resize_bar(i915, LMEM_BAR_NUM, rebar_size);
>>>>>>> +
>>>>>>> + pci_assign_unassigned_bus_resources(pdev->bus);
>>>>>>> +    pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd); }
>>>>>>> +
>>>>>>>    /**
>>>>>>>     * i915_driver_early_probe - setup state not requiring device
>>>>> access
>>>>>>>     * @dev_priv: device private
>>>>>>> @@ -852,6 +941,9 @@ int i915_driver_probe(struct pci_dev *pdev,
>>>>> const struct pci_device_id *ent)
>>>>>>> disable_rpm_wakeref_asserts(&i915->runtime_pm);
>>>>>>>
>>>>>>> +    if (HAS_LMEM(i915))
>>>>>>> +        i915_resize_lmem_bar(i915);
>>>>>>> +
>>>>>>>        intel_vgpu_detect(i915);
>>>>>>>
>>>>>>>        ret = intel_gt_probe_all(i915);
>>>>>> --
>>>>>> Jani Nikula, Intel Open Source Graphics Center
> [Dandamudi, Priyanka]
> @De Marchi, Lucas
> Can I proceed with the current approach or is there anything I need to add to it?

IMO we should be good to go. From my understanding, the problem that 
Lucas brings up doesn't yet have a solution other than WIP, so if we end 
up not being able to resize, we'd fall back to using the small BAR with 
Matthew's work.

That said, If we keep hitting errors when resizing, we should, as 
Christian says, compare with AMD (since they are not seeing this) and 
see what, if anything, can be done differently.

Thanks,

Thomas


