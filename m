Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA04D454913
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhKQOsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 09:48:40 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41872 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233479AbhKQOsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 09:48:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Ux3xOmQ_1637160336;
Received: from 30.240.124.39(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Ux3xOmQ_1637160336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Nov 2021 22:45:37 +0800
Message-ID: <c776e881-913e-c9cb-0bd5-e8b725a3418f@linux.alibaba.com>
Date:   Wed, 17 Nov 2021 22:45:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [RFC PATCH v3] ACPI: Move sdei_init and ghes_init ahead
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20211115162734.GA1566887@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20211115162734.GA1566887@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

> On 2021/11/16 AM12:27, Bjorn Helgaas wrote:
> The subject says *what* the patch does, but doesn't give any clue
> about *why* we want this.
I will change it in next version.


> On Mon, Nov 15, 2021 at 02:44:15PM +0800, Shuai Xue wrote:
>> On an ACPI system, ACPI is initialised very early from a
>> subsys_initcall(), while SDEI is not ready until a subsys_initcall().
> 
> This sentence sounds like it's setting up a contrast between ACPI init
> and SDEI init, but apparently both are subsys_initcall(), so this
> doesn't actually say what the difference is.
> 
>> More seriously, the kernel is able to handle and report errors until the
>> GHES is initialised by device_initcall().
> 
> Did you mean "unable"?  Or do you really mean the kernel can handle
> errors until GHES is initialized, but can't handle errors *after* GHES
> is initialized?
Sorry for the typo. Please refer to the following:
On an ACPI system, ACPI is initialized very early from a subsys_initcall,
while SDEI is not ready until a *subsys_initcall_sync*. More seriously,
the kernel is *unable* to handle and report errors until the GHES is
initialized by device_initcall().


>> Consequently, when an error occurs during the kernel booting, the
>> phyiscal sdei dispatcher in firmware fails to dispatch error events. All
>> errors that occurred before GHES initialization are missed and there is
>> no chance to report and find them again.
> 
> s/phyiscal/physical/
> s/sdei/SDEI/
Sorry for typos, they will be corrected in next version.


> This doesn't explain how something in the kernel can prevent the
> dispatcher in firmware from doing something.  Maybe the firmware emits
> an event and the kernel isn't listening?
The SDEI driver provides functions (e.g. apei_sdei_register_ghes,
apei_sdei_unregister_ghes) to register or unregister event callback for
dispatcher in firmware. When the GHES driver probing, it registers the
corresponding callback according to the notification type specified by
generic hardware error source. If the GHES notification type is SDEI, the
GHES driver will call apei_sdei_register_ghes to register event call.

When the firmware emits an event, it migrates the handling of the event
into the kernel at the registered entry-point __sdei_asm_handler. And
finally, the kernel will call the registered event callback and return
status_code to indicate the status of event handling. SDEI_EV_FAILED
indicates that the kernel failed to handle the event.

Consequently, when an error occurs during the kernel booting, the kernel is
unable to handle and report errors until the GHES driver is initialized by
device_initcall(), in which the event callback is registered.

Therefore, we propose to move sdei_init and ghes_init ahead as far as
possible on kernel bootup. Other notification types, such as
acpi_hed_driver should also be applied, which is not mentioned in this patch.


> What is SDEI?  Please provide a citation to whatever spec is relevant.
The Software Delegated Exception Interface (SDEI) is an ARM standard
for registering callbacks from the platform firmware into the OS. Please
refer to the [documentation](https://developer.arm.com/documentation/den0054/a)
for more details.


>> In this patch, move sdei_init and ghes_init as far ahead as possible,
>> right after acpi_hest_init().
> 
> Please be explicit about what the dependencies are here.  Is there
> something in sdei_init() that depends on acpi_hest_init()?  If so,
> what is it specifically?
> 
> Similarly, does ghes_init() depend on something in sdei_init()?
From commmit e147133a42cb (ACPI / APEI: Make hest.c manage the estatus
memory pool) was merged, ghes_init() relies on acpi_hest_init() to manage
the estatus memory pool. On the other hand, ghes_init() relies on
sdei_init() to detect the SDEI version and the framework for registering
and unregistering events. By the way, I don't figure out why acpi_hest_init
is called in acpi_pci_root_init, it don't rely on any other thing. May it
could be moved further, following acpi_iort_init in acpi_init.

sdei_init() relies on ACPI table which is initialized subsys_initcall():
acpi_init(), acpi_bus_init(), acpi_load_tables(), acpi_tb_laod_namespace().
May it should be also moved further, after acpi_load_tables.

> 
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>> Changelog v2 -> v3:
>> Fix compile error in X86
>> Reported-by: kernel test robot<lkp@intel.com>
>> ---
>>  drivers/acpi/apei/ghes.c    | 3 +--
>>  drivers/acpi/pci_root.c     | 8 +++++++-
>>  drivers/firmware/arm_sdei.c | 9 +--------
>>  include/acpi/apei.h         | 2 ++
>>  include/linux/arm_sdei.h    | 2 ++
>>  5 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 0c8330ed1ffd..4200369503b8 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1457,7 +1457,7 @@ static struct platform_driver ghes_platform_driver = {
>>  	.remove		= ghes_remove,
>>  };
>>  
>> -static int __init ghes_init(void)
>> +int __init ghes_init(void)
>>  {
>>  	int rc;
>>  
>> @@ -1499,4 +1499,3 @@ static int __init ghes_init(void)
>>  err:
>>  	return rc;
>>  }
>> -device_initcall(ghes_init);
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index ab2f7dfb0c44..7658ae509377 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -23,7 +23,7 @@
>>  #include <linux/dmi.h>
>>  #include <linux/platform_data/x86/apple.h>
>>  #include <acpi/apei.h>	/* for acpi_hest_init() */
>> -
>> +#include <linux/arm_sdei.h> /* for sdei_init() */
>>  #include "internal.h"
>>  
>>  #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
>> @@ -946,6 +946,12 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>  void __init acpi_pci_root_init(void)
>>  {
>>  	acpi_hest_init();
>> +	#ifdef CONFIG_ARM_SDE_INTERFACE
>> +	sdei_init();
>> +	#endif 
>> +	#ifdef CONFIG_ACPI_APEI_GHES
>> +	ghes_init();
>> +	#endif 
> 
> I love to replace initcalls with explicit calls.  You provided stubs
> below, so why the #ifdefs here?
I will change sdei_init in next version like ghes_init:
	#ifdef CONFIG_ARM_SDE_INTERFACE
	int __init sdei_init(void);
	#else
	static inline int sdei_init(void) { return 0; }
	#endif


> 
>>  	if (acpi_pci_disabled)
>>  		return;
>>  
>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>> index a7e762c352f9..606520be326e 100644
>> --- a/drivers/firmware/arm_sdei.c
>> +++ b/drivers/firmware/arm_sdei.c
>> @@ -1059,7 +1059,7 @@ static bool __init sdei_present_acpi(void)
>>  	return true;
>>  }
>>  
>> -static int __init sdei_init(void)
>> +int __init sdei_init(void)
>>  {
>>  	struct platform_device *pdev;
>>  	int ret;
>> @@ -1080,13 +1080,6 @@ static int __init sdei_init(void)
>>  	return ret;
>>  }
>>  
>> -/*
>> - * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
>> - * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
>> - * by device_initcall(). We want to be called in the middle.
>> - */
>> -subsys_initcall_sync(sdei_init);
> 
> Ugh.  It's really good to get rid of this sort of implicit ordering.
Thank you, agree that:)


>
>>  int sdei_event_handler(struct pt_regs *regs,
>>  		       struct sdei_registered_event *arg)
>>  {
>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>> index ece0a8af2bae..155a0fe417c6 100644
>> --- a/include/acpi/apei.h
>> +++ b/include/acpi/apei.h
>> @@ -27,8 +27,10 @@ extern int hest_disable;
>>  extern int erst_disable;
>>  #ifdef CONFIG_ACPI_APEI_GHES
>>  extern bool ghes_disable;
>> +int __init ghes_init(void);
>>  #else
>>  #define ghes_disable 1
>> +static inline int ghes_init(void) { return 0; }
> 
> I think the only reason ghes_init() returns int is because that's what
> initcall_t requires.  If ghes_init() is no longer an initcall and
> nobody looks at its return value, it should return void instead.
> 
> Same with sdei_init().
Will change it if we reach an agreement that we shoud move sdei_init
and ghes_init ahead.


> 
>>  #endif
>>  
>>  #ifdef CONFIG_ACPI_APEI
>> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
>> index 0a241c5c911d..983b7404bff9 100644
>> --- a/include/linux/arm_sdei.h
>> +++ b/include/linux/arm_sdei.h
>> @@ -46,9 +46,11 @@ int sdei_unregister_ghes(struct ghes *ghes);
>>  /* For use by arch code when CPU hotplug notifiers are not appropriate. */
>>  int sdei_mask_local_cpu(void);
>>  int sdei_unmask_local_cpu(void);
>> +int __init sdei_init(void);
>>  #else
>>  static inline int sdei_mask_local_cpu(void) { return 0; }
>>  static inline int sdei_unmask_local_cpu(void) { return 0; }
>> +static inline int sdei_init(void) { return 0; }
>>  #endif /* CONFIG_ARM_SDE_INTERFACE */
>>  
>>  
>> -- 
>> 2.20.1.12.g72788fdb
>>

Thank you for your patient revision.

Best regards,
Shuai
