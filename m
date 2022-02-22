Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CED4BF1E4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 07:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiBVGEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 01:04:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiBVGEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 01:04:01 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CED8A30E;
        Mon, 21 Feb 2022 22:03:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V5BrHyw_1645509810;
Received: from 30.240.116.247(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V5BrHyw_1645509810)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Feb 2022 14:03:32 +0800
Message-ID: <dfa2c9ca-cb5a-a067-65c4-6f6588bed095@linux.alibaba.com>
Date:   Tue, 22 Feb 2022 14:03:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 1/2] ACPI: APEI: explicit init HEST and GHES in
 apci_init
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     helgaas@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, lenb@kernel.org, rjw@rjwysocki.net,
        bhelgaas@google.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
 <20220122052618.1074-1-xueshuai@linux.alibaba.com>
 <YhPXX+CSoK++9MP6@dev-arch.archlinux-ax161>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YhPXX+CSoK++9MP6@dev-arch.archlinux-ax161>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Nathan and Rafael,

在 2022/2/22 AM2:18, Nathan Chancellor 写道:
> Hi Shuai,
> 
> On Sat, Jan 22, 2022 at 01:26:17PM +0800, Shuai Xue wrote:
>> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
>> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
>> the estatus memory pool. On the other hand, ghes_init() relies on
>> sdei_init() to detect the SDEI version and (un)register events. The
>> dependencies are as follows:
>>
>>     ghes_init() => acpi_hest_init() => acpi_bus_init() => acpi_init()
>>     ghes_init() => sdei_init()
>>
>> HEST is not PCI-specific and initcall ordering is implicit and not
>> well-defined within a level.
>>
>> Based on above, remove acpi_hest_init() from acpi_pci_root_init() and
>> convert ghes_init() and sdei_init() from initcalls to explicit calls in the
>> following order:
>>
>>     acpi_hest_init()
>>     ghes_init()
>>         sdei_init()
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/acpi/apei/ghes.c    | 19 ++++++++-----------
>>  drivers/acpi/bus.c          |  2 ++
>>  drivers/acpi/pci_root.c     |  3 ---
>>  drivers/firmware/Kconfig    |  1 +
>>  drivers/firmware/arm_sdei.c | 13 ++-----------
>>  include/acpi/apei.h         |  4 +++-
>>  include/linux/arm_sdei.h    |  2 ++
>>  7 files changed, 18 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 0c5c9acc6254..aadc0a972f18 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1457,33 +1457,35 @@ static struct platform_driver ghes_platform_driver = {
>>  	.remove		= ghes_remove,
>>  };
>>  
>> -static int __init ghes_init(void)
>> +void __init ghes_init(void)
>>  {
>>  	int rc;
>>  
>> +	sdei_init();
>> +
>>  	if (acpi_disabled)
>> -		return -ENODEV;
>> +		return;
>>  
>>  	switch (hest_disable) {
>>  	case HEST_NOT_FOUND:
>> -		return -ENODEV;
>> +		return;
>>  	case HEST_DISABLED:
>>  		pr_info(GHES_PFX "HEST is not enabled!\n");
>> -		return -EINVAL;
>> +		return;
>>  	default:
>>  		break;
>>  	}
>>  
>>  	if (ghes_disable) {
>>  		pr_info(GHES_PFX "GHES is not enabled!\n");
>> -		return -EINVAL;
>> +		return;
>>  	}
>>  
>>  	ghes_nmi_init_cxt();
>>  
>>  	rc = platform_driver_register(&ghes_platform_driver);
>>  	if (rc)
>> -		goto err;
>> +		return;
>>  
>>  	rc = apei_osc_setup();
>>  	if (rc == 0 && osc_sb_apei_support_acked)
>> @@ -1494,9 +1496,4 @@ static int __init ghes_init(void)
>>  		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
>>  	else
>>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
>> -
>> -	return 0;
>> -err:
>> -	return rc;
>>  }
>> -device_initcall(ghes_init);
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 07f604832fd6..3f403db20f69 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1331,6 +1331,8 @@ static int __init acpi_init(void)
>>  
>>  	pci_mmcfg_late_init();
>>  	acpi_iort_init();
>> +	acpi_hest_init();
>> +	ghes_init();
>>  	acpi_scan_init();
>>  	acpi_ec_init();
>>  	acpi_debugfs_init();
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index b76db99cced3..6f9e75d14808 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -22,8 +22,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/dmi.h>
>>  #include <linux/platform_data/x86/apple.h>
>> -#include <acpi/apei.h>	/* for acpi_hest_init() */
>> -
>>  #include "internal.h"
>>  
>>  #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
>> @@ -943,7 +941,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>  
>>  void __init acpi_pci_root_init(void)
>>  {
>> -	acpi_hest_init();
>>  	if (acpi_pci_disabled)
>>  		return;
>>  
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 75cb91055c17..ad114d9cdf8e 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -40,6 +40,7 @@ config ARM_SCPI_POWER_DOMAIN
>>  config ARM_SDE_INTERFACE
>>  	bool "ARM Software Delegated Exception Interface (SDEI)"
>>  	depends on ARM64
>> +	select ACPI_APEI_GHES
> 
> As the kernel test robot pointed out [1], you cannot do this.
> CONFIG_ACPI_APEI_GHES is a user selectable symbol that has dependencies,
> which 'select' completely overrides, resulting in build failures when
> CONFIG_ACPI_APEI is not enabled.
> 
> If CONFIG_ARM_SDE_INTERFACE truly requires CONFIG_ACPI_APEI_GHES, you
> should have "depends on ACPI_APEI_GHES".
> 
> If CONFIG_ARM_SDE_INTERFACE soft depends on CONFIG_ACPI_APEI_GHES for
> functionality but can work without it, you could use
> "imply ACPI_APEI_GHES", which will enable CONFIG_ACPI_APEI_GHES if its
> dependencies are met.
> 
> I noticed the same error with Alpine Linux's aarch64 configuration [2]
> if you wanted a quick configuration to test with.
> 
> [1]: https://lore.kernel.org/r/202202151504.jWpZGPaH-lkp@intel.com/
> [2]: https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.aarch64

Thank you for explaining the difference among 'select', 'depends on' and 'imply'.
I was wrong to use 'select'. sdei_init() is called in ghes_init() now, in other words,
CONFIG_ARM_SDE_INTERFACE truly requires CONFIG_ACPI_APEI_GHES, so we should use
'depends on'. I will send a new patch set to fix this problem.

Best Regards,
Shuai
