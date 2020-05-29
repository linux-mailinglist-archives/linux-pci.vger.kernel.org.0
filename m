Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7C1E8359
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2QOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 12:14:47 -0400
Received: from esg-sm2.forcepoint.com ([204.15.67.172]:41020 "EHLO
        esg-sm.forcepoint.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE2QOq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 12:14:46 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 12:14:46 EDT
Received: from webmailgov.forcepoint.com (unknown [172.29.172.3])
        by Forcepoint Email with ESMTPS id 963EF3D1C99204C673BE;
        Fri, 29 May 2020 08:59:39 -0700 (PDT)
Received: from SRCA019EXCH1A.tcs-sec.com (172.29.172.2) by
 SRCA019EXCH1B.tcs-sec.com (172.29.172.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Fri, 29 May 2020 08:59:48 -0700
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.152)
 by SRCA019EXCH1A.tcs-sec.com (172.29.172.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3
 via Frontend Transport; Fri, 29 May 2020 08:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=hveCcgUrIrftNXV43mu6lM/1ihQxDRdfNSE5waHwuS6MmmNR8UYaQ/GduM/tdqdkKh/1ctQOmoF9QCS1oZsqiKU+o73aIHnxi9CHdta3ufa8hH0+QcS9N5ptnd4M4zXvR4GSQERSlGrQHu8vAsfFW/e9d/p/Q92hbE5rBm9Uc+vYG8H7ymSiHBJ8qVsDL49/vHig6nD5URll9lEHJbFg8yKrsq0rKQUoV1/9QwwaKJ++ypAdvi0a9CAkJ9VEaKTs+zsbxsPBWFGRIfP5l5xx1qVZCB7QiBmlJHQbGWQyMMRN4UPMntocTSLDE1qBHFpEdZ3U3/ddxetWmjWrk0V0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+eY/y64gj11U/Ml03JCaLC4Fqc8jcWYTLg+K8HGtKA=;
 b=tjpO215Kn4niHyZZNuwAzdqQk4ef9BxjVLfBgruh+gWZXg83ck7lVw4ADy9F4zv1XtfrGhz1XUwgZAdxEn4wAO5gBdxBhok0aZriHheZ7KixFR1j7bDwIaM9nsGRSvZds4/pwCupDS1rCl/7tbDYO2o1q9hBtPEgnOS8jV2fsglHwU/Ch1MQ5KXlF9gAXBIHLSDUXdIyDk5gFLpI3FZikzih8N5MggPKSZ7Od4kDfa2PAFPkvKqewTKv6fJZ4pqf7NB53gWARIz4GiiK8hVzwjL3WdExw3i2ulBoOtO76ZIXlpOYt8AhbizgwsfoeLTTFeTdVThTw+VY5zksk8DRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=forcepointgov.com; dmarc=pass action=none
 header.from=forcepointgov.com; dkim=pass header.d=forcepointgov.com; arc=none
Authentication-Results: forcepoint.com; dkim=none (message not signed)
 header.d=none;forcepoint.com; dmarc=none action=none
 header.from=forcepointgov.com;
Received: from DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:414::9)
 by DM3P110MB0441.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:412::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.32; Fri, 29 May
 2020 15:59:35 +0000
Received: from DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c08b:22f5:bb8a:a1d3]) by DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c08b:22f5:bb8a:a1d3%7]) with mapi id 15.20.3000.039; Fri, 29 May 2020
 15:59:35 +0000
Subject: Re: Re: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
To:     Ashok Raj <ashok.raj@intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        "Mark Scott" <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>
References: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
 <20200528153826.257a0145@x1.home>
From:   Darrel Goeddel <dgoeddel@forcepoint.com>
Message-ID: <842370df-0ec3-fc81-f734-33078f2ccc4c@forcepointgov.com>
Date:   Fri, 29 May 2020 10:59:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200528153826.257a0145@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY1P110CA0056.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:400::26) To DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:414::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dgoeddel-pc.champ.us.fdo (192.241.53.215) by CY1P110CA0056.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:400::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.39 via Frontend Transport; Fri, 29 May 2020 15:59:34 +0000
X-Originating-IP: [192.241.53.215]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc0dfce-e0b8-4f0b-0937-08d803e94871
X-MS-TrafficTypeDiagnostic: DM3P110MB0441:
X-Microsoft-Antispam-PRVS: <DM3P110MB044131CB6483A21D60ABD2C8DA8F0@DM3P110MB0441.NAMP110.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3P110MB0538.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(66946007)(66476007)(66556008)(54906003)(5660300002)(4326008)(83380400001)(16526019)(186003)(498600001)(53546011)(26005)(7416002)(2906002)(52116002)(31686004)(8936002)(6916009)(6486002)(2616005)(6512007)(8676002)(31696002)(956004)(86362001)(36756003)(6506007)(43740500002)(16060500001);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc0dfce-e0b8-4f0b-0937-08d803e94871
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 15:59:35.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c1def8d1-d468-417f-bc2c-0c2734eaec23
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3P110MB0441
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/28/20 4:38 PM, Alex Williamson wrote:
> On Thu, 28 May 2020 13:57:42 -0700
> Ashok Raj <ashok.raj@intel.com> wrote:
> 
>> All Intel platforms guarantee that all root complex implementations
>> must send transactions up to IOMMU for address translations. Hence for
>> RCiEP devices that are Vendor ID Intel, can claim exception for lack of
>> ACS support.
>>
>>
>> 3.16 Root-Complex Peer to Peer Considerations
>> When DMA remapping is enabled, peer-to-peer requests through the
>> Root-Complex must be handled
>> as follows:
>> • The input address in the request is translated (through first-level,
>>    second-level or nested translation) to a host physical address (HPA).
>>    The address decoding for peer addresses must be done only on the
>>    translated HPA. Hardware implementations are free to further limit
>>    peer-to-peer accesses to specific host physical address regions
>>    (or to completely disallow peer-forwarding of translated requests).
>> • Since address translation changes the contents (address field) of
>>    the PCI Express Transaction Layer Packet (TLP), for PCI Express
>>    peer-to-peer requests with ECRC, the Root-Complex hardware must use
>>    the new ECRC (re-computed with the translated address) if it
>>    decides to forward the TLP as a peer request.
>> • Root-ports, and multi-function root-complex integrated endpoints, may
>>    support additional peerto-peer control features by supporting PCI Express
>>    Access Control Services (ACS) capability. Refer to ACS capability in
>>    PCI Express specifications for details.
>>
>> Since Linux didn't give special treatment to allow this exception, certain
>> RCiEP MFD devices are getting grouped in a single iommu group. This
>> doesn't permit a single device to be assigned to a guest for instance.
>>
>> In one vendor system: Device 14.x were grouped in a single IOMMU group.
>>
>> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
>> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
>> /sys/kernel/iommu_groups/5/devices/0000:00:14.3
>>
>> After the patch:
>> /sys/kernel/iommu_groups/5/devices/0000:00:14.0
>> /sys/kernel/iommu_groups/5/devices/0000:00:14.2
>> /sys/kernel/iommu_groups/6/devices/0000:00:14.3 <<< new group
>>
>> 14.0 and 14.2 are integrated devices, but legacy end points.
>> Whereas 14.3 was a PCIe compliant RCiEP.
>>
>> 00:14.3 Network controller: Intel Corporation Device 9df0 (rev 30)
>> Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>>
>> This permits assigning this device to a guest VM.
>>
>> Fixes: f096c061f552 ("iommu: Rework iommu_group_get_for_pci_dev()")
> 
> I don't really understand this Fixes tag.  This seems like a feature,
> not a fix.  If you want it in stable releases as a feature, request it
> via Cc: stable@vger.kernel.org.  I'd drop that tag, that's my nit.
> Otherwise:
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

I have tested this patch with 5.6.14 as well as a slightly modified
version (without pci_acs_ctrl_enabled()) in a 3.10 enterprise linux
kernel.

Tested-by: Darrel Goeddel <dgoeddel@forcepoint.com>

>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>> To: Joerg Roedel <joro@8bytes.org>
>> To: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: iommu@lists.linux-foundation.org
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Darrel Goeddel <DGoeddel@forcepoint.com>
>> Cc: Mark Scott <mscott@forcepoint.com>,
>> Cc: Romil Sharma <rsharma@forcepoint.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> ---
>> v2: Moved functionality from iommu to pci quirks - Alex Williamson
>>
>>   drivers/pci/quirks.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 28c9a2409c50..63373ca0a3fe 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4682,6 +4682,20 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>>   		PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
>>   }
>>   
>> +static int pci_quirk_rciep_acs(struct pci_dev *dev, u16 acs_flags)
>> +{
>> +	/*
>> +	 * RCiEP's are required to allow p2p only on translated addresses.
>> +	 * Refer to Intel VT-d specification Section 3.16 Root-Complex Peer
>> +	 * to Peer Considerations
>> +	 */
>> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END)
>> +		return -ENOTTY;
>> +
>> +	return pci_acs_ctrl_enabled(acs_flags,
>> +		PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>> +}
>> +
>>   static int pci_quirk_brcm_acs(struct pci_dev *dev, u16 acs_flags)
>>   {
>>   	/*
>> @@ -4764,6 +4778,7 @@ static const struct pci_dev_acs_enabled {
>>   	/* I219 */
>>   	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
>>   	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
>> +	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_rciep_acs },
>>   	/* QCOM QDF2xxx root ports */
>>   	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
>>   	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
> 

