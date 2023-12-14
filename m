Return-Path: <linux-pci+bounces-929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA490812592
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39459283492
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F060A52;
	Thu, 14 Dec 2023 02:57:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F4D0
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 18:57:28 -0800 (PST)
X-ASG-Debug-ID: 1702522644-1eb14e538d33460001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id SFcKvVzqjKyNY6SE (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 14 Dec 2023 10:57:24 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Dec
 2023 10:57:24 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Dec
 2023 10:57:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <1ba8036b-c010-4d02-9557-5b6333e4eff1@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date: Thu, 14 Dec 2023 10:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
CC: <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<LeoLiu@zhaoxin.com>
References: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com>
 <20231115091612.580685-2-LeoLiu-oc@zhaoxin.com>
 <CAJZ5v0ig2+uv4kF0SjAByvcmBF9auhY_1OVrJvjKTVJK23=cSg@mail.gmail.com>
From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <CAJZ5v0ig2+uv4kF0SjAByvcmBF9auhY_1OVrJvjKTVJK23=cSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1702522644
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6229
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.118058
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



在 2023/12/7 0:35, Rafael J. Wysocki 写道:
> On Wed, Nov 15, 2023 at 10:16 AM LeoLiu-oc <LeoLiu-oc@zhaoxin.com> wrote:
>>
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> The purpose of the function apei_hest_parse_aer() is used to parse and
>> extract register value from HEST PCIe AER structures.
>>
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/acpi/apei/hest.c | 77 ++++++++++++++++++++++++++++++++++++++--
>>   include/acpi/actbl1.h    |  7 ++++
>>   include/acpi/apei.h      |  8 +++++
>>   3 files changed, 90 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>> index 6aef1ee5e1bd..7fb797fdc1b1 100644
>> --- a/drivers/acpi/apei/hest.c
>> +++ b/drivers/acpi/apei/hest.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/kdebug.h>
>>   #include <linux/highmem.h>
>>   #include <linux/io.h>
>> +#include <linux/pci.h>
>>   #include <linux/platform_device.h>
>>   #include <acpi/apei.h>
>>   #include <acpi/ghes.h>
>> @@ -86,9 +87,81 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>          return len;
>>   };
>>
>> -typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>> +#ifdef CONFIG_ACPI_APEI
>> +static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
>> +                               struct pci_dev *dev)
>> +{
>> +       return ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(dev->bus) &&
>> +               ACPI_HEST_BUS(p->bus) == dev->bus->number &&
>> +               p->device == PCI_SLOT(dev->devfn) &&
>> +               p->function == PCI_FUNC(dev->devfn);
>> +}
>> +
>> +static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr,
>> +                               struct pci_dev *dev)
>> +{
>> +       u16 hest_type = hest_hdr->type;
>> +       u8 pcie_type = pci_pcie_type(dev);
>> +       struct acpi_hest_aer_common *common;
>> +
>> +       common = (struct acpi_hest_aer_common *)(hest_hdr + 1);
>> +
>> +       switch (hest_type) {
>> +       case ACPI_HEST_TYPE_AER_ROOT_PORT:
>> +               if (pcie_type != PCI_EXP_TYPE_ROOT_PORT)
>> +                       return false;
>> +       break;
>> +       case ACPI_HEST_TYPE_AER_ENDPOINT:
>> +               if (pcie_type != PCI_EXP_TYPE_ENDPOINT)
>> +                       return false;
>> +       break;
>> +       case ACPI_HEST_TYPE_AER_BRIDGE:
>> +               if (pcie_type != PCI_EXP_TYPE_PCI_BRIDGE &&
>> +                   pcie_type != PCI_EXP_TYPE_PCIE_BRIDGE)
>> +                       return false;
>> +       break;
>> +       default:
>> +               return false;
>> +       break;
>> +       }
>> +
>> +       if (common->flags & ACPI_HEST_GLOBAL)
>> +               return true;
>> +
>> +       if (hest_match_pci_devfn(common, dev))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
>> +{
>> +       struct hest_parse_aer_info *info = data;
>> +
>> +       if (!hest_source_is_pcie_aer(hest_hdr, info->pci_dev))
>> +               return 0;
>> +
>> +       switch (hest_hdr->type) {
>> +       case ACPI_HEST_TYPE_AER_ROOT_PORT:
>> +               info->hest_aer_root_port = (struct acpi_hest_aer_root *)hest_hdr;
>> +               return 1;
>> +       break;
>> +       case ACPI_HEST_TYPE_AER_ENDPOINT:
>> +               info->hest_aer_endpoint = (struct acpi_hest_aer *)hest_hdr;
>> +               return 1;
>> +       break;
>> +       case ACPI_HEST_TYPE_AER_BRIDGE:
>> +               info->hest_aer_bridge = (struct acpi_hest_aer_bridge *)hest_hdr;
>> +               return 1;
>> +       break;
>> +       default:
>> +               return 0;
>> +       break;
>> +       }
>> +}
>> +#endif
>>
>> -static int apei_hest_parse(apei_hest_func_t func, void *data)
>> +int apei_hest_parse(apei_hest_func_t func, void *data)
>>   {
>>          struct acpi_hest_header *hest_hdr;
>>          int i, rc, len;
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index a33375e055ad..90c27dc5325f 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
> 
> This is an ACPICA header and it cannot be modified just like this.
> 
> The way to do that is to submit a pull request with the desired change
> to the upstream ACPICA project on GitHub and add a Link tag pointing
> to the upstream PR to the corresponding Linux patch.  Then, the Linux
> patch can only be applied after the corresponding upstream PR has been
> merged.
> 
> Thanks!
> 
the data structure "hest_parse_aer_info" is added to file actbl1.h, it 
is not necessary to put this data structure in file actbl1.h. In the 
next version, I will move this data structure to another file.

Yours sincerely,
Leoliu-oc

>> @@ -1629,6 +1629,13 @@ struct acpi_hest_generic_status {
>>          u32 error_severity;
>>   };
>>
>> +struct hest_parse_aer_info {
>> +       struct pci_dev *pci_dev;
>> +       struct acpi_hest_aer *hest_aer_endpoint;
>> +       struct acpi_hest_aer_root *hest_aer_root_port;
>> +       struct acpi_hest_aer_bridge *hest_aer_bridge;
>> +};
>> +
>>   /* Values for block_status flags above */
>>
>>   #define ACPI_HEST_UNCORRECTABLE             (1)
>> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
>> index dc60f7db5524..d12e6b6c4546 100644
>> --- a/include/acpi/apei.h
>> +++ b/include/acpi/apei.h
>> @@ -33,10 +33,18 @@ void __init acpi_ghes_init(void);
>>   static inline void acpi_ghes_init(void) { }
>>   #endif
>>
>> +typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>> +int apei_hest_parse(apei_hest_func_t func, void *data);
>> +
>>   #ifdef CONFIG_ACPI_APEI
>>   void __init acpi_hest_init(void);
>> +int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data);
>>   #else
>>   static inline void acpi_hest_init(void) { }
>> +static inline int hest_parse_pcie_aer(struct acpi_hest_header *hest_hdr, void *data)
>> +{
>> +       return 0;
>> +}
>>   #endif
>>
>>   int erst_write(const struct cper_record_header *record);
>> --
>> 2.34.1
>>

