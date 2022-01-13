Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB348D928
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 14:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiAMNig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 08:38:36 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38391 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229755AbiAMNif (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 08:38:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V1kApJc_1642081110;
Received: from 30.240.112.63(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V1kApJc_1642081110)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 21:38:32 +0800
Message-ID: <8e6ee387-7dc1-6c8a-c13f-ec06621e3efa@linux.alibaba.com>
Date:   Thu, 13 Jan 2022 21:38:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RESEND PATCH v4] ACPI: Move sdei_init and ghes_init ahead to
 handle platform errors earlier
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20211224001716.GA1324143@bhelgaas>
 <75dedf3a-41c7-980e-a8a8-74d116ae6663@linux.alibaba.com>
In-Reply-To: <75dedf3a-41c7-980e-a8a8-74d116ae6663@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn, Rafael,

Happy New Year :)

I am wondering that do you have any comment to this implementation？ Any feedback
are welcomed.

Thank you.

Best regrads,
Shuai

在 2021/12/24 PM4:55, Shuai Xue 写道:
> Hi, Bjorn,
> 
> Thank you for your comments.
> 
> 在 2021/12/24 AM8:17, Bjorn Helgaas 写道:
>> [+to Rafael, question about HEST/GHES/SDEI init]
>>
>> On Thu, Dec 23, 2021 at 04:11:11PM +0800, Shuai Xue wrote:
>>> 在 2021/12/22 AM7:17, Bjorn Helgaas 写道:
>>>> On Thu, Dec 16, 2021 at 09:34:56PM +0800, Shuai Xue wrote:
>>>>> On an ACPI system, ACPI is initialised very early from a subsys_initcall(),
>>>>> while SDEI is not ready until a subsys_initcall_sync().
>>>>>
>>>>> The SDEI driver provides functions (e.g. apei_sdei_register_ghes,
>>>>> apei_sdei_unregister_ghes) to register or unregister event callback for
>>>>> dispatcher in firmware. When the GHES driver probing, it registers the
>>>>> corresponding callback according to the notification type specified by
>>>>> GHES. If the GHES notification type is SDEI, the GHES driver will call
>>>>> apei_sdei_register_ghes to register event call.
>>>>>
>>>>> When the firmware emits an event, it migrates the handling of the event
>>>>> into the kernel at the registered entry-point __sdei_asm_handler. And
>>>>> finally, the kernel will call the registered event callback and return
>>>>> status_code to indicate the status of event handling. SDEI_EV_FAILED
>>>>> indicates that the kernel failed to handle the event.
>>>>>
>>>>> Consequently, when an error occurs during kernel booting, the kernel is
>>>>> unable to handle and report errors until the GHES driver is initialized by
>>>>> device_initcall(), in which the event callback is registered. All errors
>>>>> that occurred before GHES initialization are missed and there is no chance
>>>>> to report and find them again.
>>>>>
>>>>> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
>>>>> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
>>>>> the estatus memory pool. On the other hand, ghes_init() relies on
>>>>> sdei_init() to detect the SDEI version and the framework for registering
>>>>> and unregistering events.
>>>>
>>>>> By the way, I don't figure out why acpi_hest_init is called in
>>>>> acpi_pci_root_init, it don't rely on any other thing. May it could
>>>>> be moved further, following acpi_iort_init in acpi_init.
>>
>>>>> sdei_init() relies on ACPI table which is initialized
>>>>> subsys_initcall(): acpi_init(), acpi_bus_init(), acpi_load_tables(),
>>>>> acpi_tb_laod_namespace().  May it should be also moved further,
>>>>> after acpi_load_tables.
>>
>>>>> In this patch, move sdei_init and ghes_init as far ahead as
>>>>> possible, right after acpi_hest_init().
>>>>
>>>> I'm having a hard time figuring out the reason for this patch.
>>>>
>>>> Apparently the relevant parts are sdei_init() and ghes_init().
>>>> Today they are executed in that order:
>>>>
>>>>   subsys_initcall_sync(sdei_init);
>>>>   device_initcall(ghes_init);
>>>>
>>>> After this patch, they would be executed in the same order, but called
>>>> explicitly instead of as initcalls:
>>>>
>>>>   acpi_pci_root_init()
>>>>   {
>>>>     acpi_hest_init();
>>>>     sdei_init();
>>>>     ghes_init();
>>>>     ...
>>>>
>>>> Explicit calls are certainly better than initcalls, but that doesn't
>>>> seem to be the reason for this patch.
>>>>
>>>> Does this patch fix a bug?  If so, what is the bug?
>>>
>>> Yes. When the kernel booting, the console logs many times from firmware
>>> before GHES drivers init:
>>>
>>> 	Trip in MM PCIe RAS handle(Intr:910)
>>>   	Clean PE[1.1.1] ERR_STS:0x4000100 -> 0 INT_STS:F0000000
>>> 	Find RP(98:1.0)
>>> 	--Walk dev(98:1.0) CE:0 UCE:4000
>>> 	...
>>> 	ERROR:   sdei_dispatch_event(32a) ret:-1
>>> 	--handler(910) end
>>>
>>> This is because the callback function has not been registered yet.
>>> Previously reported errors will be overwritten by new ones. Therefore,
>>> all errors that occurred before GHES initialization are missed
>>> and there is no chance to report and find them again.
>>>
>>>> You say that currently "errors that occur before GHES initialization
>>>> are missed".  Isn't that still true after this patch?  Does this patch
>>>> merely reduce the time before GHES initialization?  If so, I'm
>>>> dubious, because we have to tolerate an arbitrary amount of time
>>>> there.
>>>
>>> After this patch, there are still errors missing. As you mentioned,
>>> we have to tolerate it until the software reporting capability is built.
>>>
>>> Yes, this patch merely reduce the time before GHES initialization.
>>
>> It's not a bug that errors that happen before the callback are lost.
>> At least, it's not a *Linux* bug.  It might be a poor design of the
>> firmware error reporting interface.
>>
>> If the only point of this patch is to reduce the time before GHES
>> initialization, the commit log should clearly say that.
> 
> Yep, it is a design defect of firmware. I will explicitly document
> the purpose of this patch in next version.
> 
>>> The boot dmesg before this patch:
>>>
>>> 	[    3.688586] HEST: Table parsing has been initialized.
>>> 	...
>>> 	[   33.204340] calling  sdei_init+0x0/0x120 @ 1
>>> 	[   33.208645] sdei: SDEIv1.0 (0x0) detected in firmware.
>>> 	...
>>> 	[   36.005390] calling  ghes_init+0x0/0x11c @ 1
>>> 	[   36.190021] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
>>>
>>>
>>> After this patch, the boot dmesg like bellow:
>>>
>>> 	[    3.688664] HEST: Table parsing has been initialized.
>>> 	[    3.688691] sdei: SDEIv1.0 (0x0) detected in firmware.
>>> 	[    3.694557] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> 
> After this patch, we use explicit call to init GHES rather than initcall.
> The GHES message here is just to prove that GHES initialization is
> advanced to 3.694557 seconds.
> 
> 
>> [Tangent: I think this GHES message is confusing.  What "APEI bit"
>> does this refer to?  The only bits I remember are the Flags bits in
>> HEST Error Source Descriptor Entries, e.g., ACPI v6.3, sec 18.3.2.
> 
> From the log code behavior, the APEI bit refers to OSC_SB_APEI_SUPPORT.
> (BIT 4, ACPI v6.4, sec 6.2.11.2,  table Table 6.13 Platform-Wide _OSC
> Capabilities DWORD 2. [1])
> 
>     /* code in drivers/acpi/apei/ghes.c */
>     if (rc == 0 && osc_sb_apei_support_acked)
>         pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit and WHEA _OSC.\n");
> 
>     /* code in drivers/acpi/bus.c */
>     osc_sb_apei_support_acked =
>         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> 
> 
>> "WHEA _OSC" means nothing to me, and I didn't find anything useful
>> with grep, other than that "WHEA" might be an obsolete name for what
>> we now call "APEI".
> 
> Yep, WHEA is an obsolete name. I think apei_osc_setup() is added for compatibility
> in commit eccddd32ced0 ("ACPI, APEI, Add APEI bit support in generic _OSC call")'
> 
> The ACPI spec Platform-Wide OSPM Capabilities defines
> UUID "0811B06E-4A27-44F9-8D60-3CBBC22E7B48" is used in
> acpi_bus_osc_support(). The Microsoft WHEA defines
> UUID "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c" that is used
> in apei_osc_setup(). [2][3]
> 
> From the discussion[4], the GHES message is to distinguish between
> the two specs.
> 
>     To avoid confusion, can we change the message as follow.
> 
>     - generic _OSC succeeded, APEI _OSC failed: APEI firmware first mode is
>     enabled by APEI bit.
>     - generic _OSC failed, APEI _OSC succeeded: APEI firmware first mode is
>     enabled by WHEA _OSC.
>     - both succeeded: APEI firmware first mode is enabled by APEI bit and
>     WHEA _OSC.
>     - both failed: Failed to enable APEI firmware first mode!
> 
> 
>> I don't think there's anything in _OSC that mentions "firmware first."
>>
>> I don't remember anything in the spec about a way to *enable* Firmware
>> First Error Handling needing (I'm looking at ACPI v6.3, sec 18.4).
>>
>> I think the "firmware first" information is useless to the OS -- as
>> far as I can tell, the spec says nothing about anything the OS should
>> do based on the FIRMWARE_FIRST bits.]
> 
> GHES works in "Firmware First" mode to report platform hardware error
> and it depends on APEI interface. (drivers/acpi/apei/ghes.c)
> 
>    * Generic Hardware Error Source provides a way to report platform
>    * hardware errors (such as that from chipset). It works in so called
>    * "Firmware First" mode, that is, hardware errors are reported to
>    * firmware firstly, then reported to Linux by firmware.
> 
> Based on above, I think the GHES message just means that this booting
> kernel supports APEI or WHEA, and GHES report Firmware first errors on
> this machine. Is it fine to keep the message?
> 
> 
>>> As we can see, the initialization of GHES is advanced by 33 seconds.
>>> So, in my opinion, this patch is necessary, right?
>>> (It should be noted that the effect of optimization varies with the platform.)
>>
>>>>> -device_initcall(ghes_init);
>>>>
>>>>>  void __init acpi_pci_root_init(void)
>>>>>  {
>>>>>  	acpi_hest_init();
>>>>> +	sdei_init();
>>>>> +	ghes_init();
>>>>
>>>> What's the connection between PCI, SDEI, and GHES?  As far as I can
>>>> tell, SDEI and GHES are not PCI-specific, so it doesn't seem like they
>>>> should be initialized here in acpi_pci_root_init().
>>>
>>> The only reason is that acpi_hest_init() is initialized here.
>>>
>>> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
>>> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
>>> the estatus memory pool. On the other hand, ghes_init() relies on
>>> sdei_init() to detect the SDEI version and the framework for registering
>>> and unregistering events. The dependencies are as follows
>>>
>>> 	ghes_init() => acpi_hest_init()
>>> 	ghes_init() => sdei_init()
>>>
>>> I don't figure out why acpi_hest_init() is called in
>>> acpi_pci_root_init(), it don't rely on any other thing.
>>> I am wondering that should we moved all of them further? e.g.
>>> following acpi_iort_init() in acpi_init().
>>
>> I don't know why acpi_hest_init() is called from acpi_pci_root_init().
>> It looks like HEST can support error sources other than PCI (IA-32
>> Machine Checks, NMIs, GHES, etc.)  It was added by 415e12b23792
>> ("PCI/ACPI: Request _OSC control once for each root bridge (v3)");
>> maybe Rafael remembers why.
>>
>> Seem like acpi_hest_init(), sdei_init(), and ghes_init() should all go
>> somewhere else, but I don't know where.  Maybe somewhere in
>> acpi_init()?
> 
> I tried to move them into acpi_init(), and it works well.
> 
> @@ -1251,6 +1251,9 @@ static int __init acpi_init(void)
> 
>         pci_mmcfg_late_init();
>         acpi_iort_init();
> +       acpi_hest_init();
> +       sdei_init();
> +       ghes_init();
>         acpi_scan_init();
>         acpi_ec_init();
> 
> What's your opinion?
> 
> Best Regards,
> 
> Shuai
> 
> 
> [1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#platform-wide-osc-capabilities-dword-2
> [2] https://www.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg4718503.html
> [3] http://www.guyreams.com/PDF/whea.pdf
> [4] https://patchwork.kernel.org/project/linux-acpi/patch/1308640587-24502-5-git-send-email-ying.huang@intel.com/#1978922
