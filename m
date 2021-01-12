Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61702F364B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 17:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391336AbhALQ6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 11:58:08 -0500
Received: from foss.arm.com ([217.140.110.172]:49786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbhALQ6H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 11:58:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96892101E;
        Tue, 12 Jan 2021 08:57:21 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC5E3F719;
        Tue, 12 Jan 2021 08:57:21 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Vidya Sagar <vidyas@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        catalin.marinas@arm.com, will@kernel.org, robh@kernel.org,
        sudeep.holla@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <9ecfbc2e-5f33-dd3c-0c3b-ee7c463b3e68@nvidia.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ffc65624-197f-14cc-58da-2b1cfde285fc@arm.com>
Date:   Tue, 12 Jan 2021 10:57:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <9ecfbc2e-5f33-dd3c-0c3b-ee7c463b3e68@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/12/21 10:16 AM, Vidya Sagar wrote:
> 
> 
> On 1/5/2021 10:27 AM, Jeremy Linton wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Given that most arm64 platform's PCI implementations needs quirks
>> to deal with problematic config accesses, this is a good place to
>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
>> standard SMC conduit designed to provide a simple PCI config
>> accessor. This specification enhances the existing ACPI/PCI
>> abstraction and expects power, config, etc functionality is handled
>> by the platform. It also is very explicit that the resulting config
>> space registers must behave as is specified by the pci specification.
>>
>> Lets hook the normal ACPI/PCI config path, and when we detect
>> missing MADT data, attempt to probe the SMC conduit. If the conduit
>> exists and responds for the requested segment number (provided by the
>> ACPI namespace) attach a custom pci_ecam_ops which redirects
>> all config read/write requests to the firmware.
>>
>> This patch is based on the Arm PCI Config space access document @
>> https://developer.arm.com/documentation/den0115/latest
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/pci.c   | 87 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/arm-smccc.h | 26 ++++++++++++
>>   2 files changed, 113 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 1006ed2d7c60..56d3773aaa25 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -7,6 +7,7 @@
>>    */
>>
>>   #include <linux/acpi.h>
>> +#include <linux/arm-smccc.h>
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>> @@ -107,6 +108,90 @@ static int pci_acpi_root_prepare_resources(struct 
>> acpi_pci_root_info *ci)
>>          return status;
>>   }
>>
>> +static int smccc_pcie_check_conduit(u16 seg)
>> +{
>> +       struct arm_smccc_res res;
>> +
>> +       if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
>> +               return -EOPNOTSUPP;
>> +
>> +       arm_smccc_smc(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>> +       if ((int)res.a0 < 0)
>> +               return -EOPNOTSUPP;
>> +
>> +       arm_smccc_smc(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res);
>> +       if ((int)res.a0 < 0)
>> +               return -EOPNOTSUPP;
>> +
>> +       pr_info("PCI: SMC conduit attached to segment %d\n", seg);
> Shouldn't this print be moved towards the end of 
> pci_acpi_setup_smccc_mapping() API?

Thanks for looking at this.

It probably should be, the assumption was that it would attach at this 
point, but its possible the message is inaccurate if something fails a 
bit later. I left it there because the segment number is easily 
available. I've been playing with this a bit for the V2 where I added 
the additional function checks.



> 
>> +
>> +       return 0;
>> +}
>> +
>> +static int smccc_pcie_config_read(struct pci_bus *bus, unsigned int 
>> devfn,
>> +                                 int where, int size, u32 *val)
>> +{
>> +       struct arm_smccc_res res;
>> +
>> +       devfn |= bus->number << 8;
>> +       devfn |= bus->domain_nr << 16;
>> +
>> +       arm_smccc_smc(SMCCC_PCI_READ, devfn, where, size, 0, 0, 0, 0, 
>> &res);
>> +       if (res.a0) {
>> +               *val = ~0;
>> +               return -PCIBIOS_BAD_REGISTER_NUMBER;
>> +       }
>> +
>> +       *val = res.a1;
>> +       return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int smccc_pcie_config_write(struct pci_bus *bus, unsigned int 
>> devfn,
>> +                                  int where, int size, u32 val)
>> +{
>> +       struct arm_smccc_res res;
>> +
>> +       devfn |= bus->number << 8;
>> +       devfn |= bus->domain_nr << 16;
>> +
>> +       arm_smccc_smc(SMCCC_PCI_WRITE, devfn, where, size, val, 0, 0, 
>> 0, &res);
>> +       if (res.a0)
>> +               return -PCIBIOS_BAD_REGISTER_NUMBER;
>> +
>> +       return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static const struct pci_ecam_ops smccc_pcie_ecam_ops = {
>> +       .bus_shift      = 8,
>> +       .pci_ops        = {
>> +               .read           = smccc_pcie_config_read,
>> +               .write          = smccc_pcie_config_write,
>> +       }
>> +};
>> +
>> +static struct pci_config_window *
>> +pci_acpi_setup_smccc_mapping(struct acpi_pci_root *root)
>> +{
>> +       struct device *dev = &root->device->dev;
>> +       struct resource *bus_res = &root->secondary;
>> +       struct pci_config_window *cfg;
>> +
>> +       cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
>> +       if (!cfg)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       cfg->parent = dev;
>> +       cfg->ops = &smccc_pcie_ecam_ops;
>> +       cfg->busr.start = bus_res->start;
>> +       cfg->busr.end = bus_res->end;
>> +       cfg->busr.flags = IORESOURCE_BUS;
>> +
>> +       cfg->res.name = "PCI SMCCC";
>> +       if (cfg->ops->init)
> Since there is no init implemented, what is the purpose of having this?

Its basically dead.


> 
>> +               cfg->ops->init(cfg);
>> +       return cfg;
>> +}
>> +
>>   /*
>>    * Lookup the bus range for the domain in MCFG, and set up config space
>>    * mapping.
>> @@ -125,6 +210,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root 
>> *root)
>>
>>          ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
>>          if (ret) {
>> +               if (!smccc_pcie_check_conduit(seg))
>> +                       return pci_acpi_setup_smccc_mapping(root);
>>                  dev_err(dev, "%04x:%pR ECAM region not found\n", seg, 
>> bus_res);
>>                  return NULL;
>>          }
>> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
>> index f860645f6512..327f52533c71 100644
>> --- a/include/linux/arm-smccc.h
>> +++ b/include/linux/arm-smccc.h
>> @@ -89,6 +89,32 @@
>>
>>   #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED   1
>>
>> +/* PCI ECAM conduit */
>> +#define SMCCC_PCI_VERSION                                              \
>> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
>> +                          ARM_SMCCC_SMC_32,                            \
>> +                          ARM_SMCCC_OWNER_STANDARD, 0x0130)
>> +
>> +#define SMCCC_PCI_FEATURES                                             \
>> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
>> +                          ARM_SMCCC_SMC_32,                            \
>> +                          ARM_SMCCC_OWNER_STANDARD, 0x0131)
>> +
>> +#define SMCCC_PCI_READ                                                 \
>> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
>> +                          ARM_SMCCC_SMC_32,                            \
>> +                          ARM_SMCCC_OWNER_STANDARD, 0x0132)
>> +
>> +#define 
>> SMCCC_PCI_WRITE                                                        \
>> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
>> +                          ARM_SMCCC_SMC_32,                            \
>> +                          ARM_SMCCC_OWNER_STANDARD, 0x0133)
>> +
>> +#define SMCCC_PCI_SEG_INFO                                             \
>> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
>> +                          ARM_SMCCC_SMC_32,                            \
>> +                          ARM_SMCCC_OWNER_STANDARD, 0x0134)
>> +
>>   /* Paravirtualised time calls (defined by ARM DEN0057A) */
>>   #define ARM_SMCCC_HV_PV_TIME_FEATURES                          \
>>          ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                 \
>> -- 
>> 2.26.2
>>

