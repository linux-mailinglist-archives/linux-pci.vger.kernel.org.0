Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC732B7E5E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKRNgg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 18 Nov 2020 08:36:36 -0500
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:17212
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725834AbgKRNgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 08:36:36 -0500
Received: from [192.168.0.104] (unknown [113.247.217.134])
        by c1app4 (Coremail) with SMTP id BAINCgC3F1FLI7VfoMOJAA--.58493S2;
        Wed, 18 Nov 2020 21:36:12 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
From:   Chen Baozi <chenbaozi@phytium.com.cn>
In-Reply-To: <c4bc3817074c0793615440c6220f3813@kernel.org>
Date:   Wed, 18 Nov 2020 21:36:11 +0800
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Guohanjun <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9FC46D81-B76F-46EC-B022-396F59806803@phytium.com.cn>
References: <20201117134214.970-1-chenbaozi@phytium.com.cn>
 <c4bc3817074c0793615440c6220f3813@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CM-TRANSID: BAINCgC3F1FLI7VfoMOJAA--.58493S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13ZrWUKr4DXryrWr43Awb_yoW5Kw18pa
        yxt3yjyr18JFW7uFsxA3W8XFy3Xw40kry2krW3AasIqa90gF93KF1xCFyUWr48Cw1DGF4j
        yF1UZF15WF9xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6ry8MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4iL0UUUUU
X-Originating-IP: [113.247.217.134]
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiDAPgP17uHwDMBQABs3
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

> On Nov 18, 2020, at 5:27 PM, Marc Zyngier <maz@kernel.org> wrote:
> 
> Hi Chen,
> 
> On top of Bjorn's comments:
> 
> On 2020-11-17 13:42, Chen Baozi wrote:
>> 
>> ---
>> drivers/acpi/irq.c          | 22 +++++++++++++++++++++-
>> drivers/acpi/pci_irq.c      |  6 ++++--
>> drivers/acpi/pci_link.c     | 17 +++++++++++++++--
>> include/acpi/acpi_drivers.h |  2 +-
>> include/linux/acpi.h        |  4 ++++
>> 5 files changed, 45 insertions(+), 6 deletions(-)
>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>> index e209081d644b..e78a44815c44 100644
>> --- a/drivers/acpi/irq.c
>> +++ b/drivers/acpi/irq.c
>> @@ -81,6 +81,25 @@ void acpi_unregister_gsi(u32 gsi)
>> }
>> EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
>> +int acpi_register_irq(struct device *dev, u32 irq, int trigger,
>> +		      int polarity, struct fwnode_handle *domain_id)
>> +{
>> +	struct irq_fwspec fwspec;
>> +
>> +	if (WARN_ON(!domain_id)) {
>> +		pr_warn("GSI: No registered irqchip, giving up\n");
> 
> A fwnode_handle is not an irqchip. It's just an opaque identifier
> for a HW block. Furthermore, there is no need to have both a WARN_ON()
> and a pr_warn(). Please pick one.
> 
> I'd also suggest you rename domain_id to fwnode, which is the commonly
> used idiom (yes, I know about the unfortunate precedent in acpi_register_gsi()).
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	fwspec.fwnode = domain_id;
>> +	fwspec.param[0] = irq;
>> +	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>> +	fwspec.param_count = 2;
>> +
>> +	return irq_create_fwspec_mapping(&fwspec);
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_register_irq);
> 
> By the way, this is almost an exact duplicate of acpi_register_gsi().
> You definitely want to make this code common.
> 
>> @@ -115,6 +134,7 @@ acpi_get_irq_source_fwhandle(const struct
>> acpi_resource_source *source)
>> 	acpi_bus_put_acpi_device(device);
>> 	return result;
>> }
>> +EXPORT_SYMBOL_GPL(acpi_get_irq_source_fwhandle);
>> /*
>>  * Context for the resource walk used to lookup IRQ resources.
>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>> index 14ee631cb7cf..19296d70c95c 100644
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -410,6 +410,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>> 	char *link = NULL;
>> 	char link_desc[16];
>> 	int rc;
>> +	struct fwnode_handle *irq_domain;
> 
> fwnode_handle is most definitely not an IRQ domain.
> 
>> @@ -140,6 +143,12 @@ static acpi_status
>> acpi_pci_link_check_possible(struct acpi_resource *resource,
>> 			link->irq.triggering = p->triggering;
>> 			link->irq.polarity = p->polarity;
>> 			link->irq.resource_type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
>> +			if (p->resource_source.string_length) {
>> +				rs->index = p->resource_source.index;
>> +				rs->string_length = p->resource_source.string_length;
>> +				rs->string_ptr = kmalloc(rs->string_length, GFP_KERNEL);
>> +				strcpy(rs->string_ptr, p->resource_source.string_ptr);
> 
> We have kstrdup() for this kind of things, as using rs->string_length to allocate
> the buffer and strcpy() to copy it feels... dangerous.
> 
>> +			}
>> 			break;
>> 		}
>> 	default:
>> @@ -612,7 +622,7 @@ static int acpi_pci_link_allocate(struct
>> acpi_pci_link *link)
>>  * failure: return -1
>>  */
>> int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
>> -			       int *polarity, char **name)
>> +			       int *polarity, char **name, struct fwnode_handle **irq_domain)
> 
> Same remark about the naming.

Thanks. It is very helpful. I’ll fix it in next version.

Baozi.

