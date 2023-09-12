Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9667A79DBF7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 00:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjILWj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 18:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjILWj6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 18:39:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C110F9;
        Tue, 12 Sep 2023 15:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I15UIGsRfgWvKbonl6BeBRU/50qPO3VSbDPU2jAloEh7oGdAar3Y4xPOdBQvqrd3i/TB9npd3IWhV0U3x/arfZsGPbk8zgx5a+7SVsLEcb1G1cCI76CZfJtgxLPihE304bgKBLv2E8Ge7fQ00y/TR0KMOYnxV8e9GM0IwtPGtYF8MJUh9W6s0hOFjrx0HDs5RMt9Udv9xgB3tZaL4t4U4nyyzOz0e9dM62nSq/Sfd9nbF8eMSKzq/U2fs8pUnAGxGG9b6YIqXTQj+GT7VvGAnnK63hCxk3TV9AJBJmmEh3zFqfTvs62rKZNSsmqY1rpvIhS38Bc5ts/88LHQ5Rl7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N20BNW4QuY11F4+i6/0+3a6aUWNv2ONwUtZktNF0Ukc=;
 b=Gaxo61bkFpAAN7UtihTP/OWCHLsf28HWY7SStZePHY2bUF/kuKMumLQ63Wd7iGg6sXor8bAbFrN/qxCB1Bh/lUctaqh6cLJVOt7z4OZZTcqrKOmsmHlnjFpsxzQIZDtJu6TBxiswMnGoFspTyBYYfe7iuWTZa1V4KppZw8rTVOyTr+F2uIgoqQWryJ/5/q/QWWmeogsQcLUmqPLgflZ5+DOK5lwinl+oSpu5rsolWSSJ1h7AKRStfV3nx/QrL4u/cJ5YjzNKEM0dN/P+skUeVf3SCQgKtmRNrd+ircY0io1owRyvvFR5mapzU2B8cHAwFjcMnR70LvjC5p+uoLQYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N20BNW4QuY11F4+i6/0+3a6aUWNv2ONwUtZktNF0Ukc=;
 b=lDTeyc97k56veXapmR8r4czk+T1Yb07g/vDuRUopssaOpIzM03l9I6VNV6v5VXXPey4yc7+pHKMgE4kEPjKoVT1UMyt2Nx38QXtHDNyK0HUGCTRkGDGpHuYt8tIkz1GKbAVJ06w3sJ3afmwGkQeJM9zo/NzUhk30s4AwI8UHBxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Tue, 12 Sep
 2023 22:39:36 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::2709:2c34:f842:ce33%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:39:36 +0000
Message-ID: <57b2b450-2fc9-ac68-d016-fb1d061ba992@amd.com>
Date:   Tue, 12 Sep 2023 15:39:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/3] PCI: Enable support for 10-bit Tag during device
 enumeration
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230815212043.114913-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230828095429.GA17864@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230828095429.GA17864@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 541c3f33-d72d-4c88-a009-08dbb3e1243e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIebDpPBrC2Ej+vukPgS34uc/kzS9zvQ2+y9Kj/H55ObLTXP6ZbyO9fwq6iIAONT9wVB49OXLCc5cqaWlLW+oimFZm7y1V48MqS6oPL35aB8tUrDj4QVXmMN/YXHDxGsrI218Vj8KcPbU5L6R1QUBSJ+NjPVRKCcHwFUbqeJ4nKHk8cgEa5G+iAKzn0R19ulXgA2uYqPr8EMsIQPX0lvL0bW20dTO35fJvInaaGoHRvZVynr2SwQvN4TxjO1tdbXzgk20eqS48H2TsTx5i3mgWLwKOHX8prfSBtVLIxYCXIv4LrNOWDNEG2aPKrx3XhDpnWKPxABo63PbkFf4bFx9jVoOVjmrEQvOluIJhC0n06wagh0dHh/CYnJBmnLPRKb+s8YxehyLqBI6kjjoIuGIP+ubVFvGguWN5Vt5XspUXcZ8iiwrE2iKfd+JgQjezgs3gtE0A16+BVKrTUUYBzKKaC7y2z1Y0ICTlNNpAeH9L+ifJhtOdqI58jToclB6rUg11w9E3yk9X+/T2v3Cm+63YyLclxDUFYXAmqkhpvnhnevKxnG/8gFQiAQdAjZGUaUMkb+xoNwoQR7uS2z5m1vqyKdf2AIqhtorJjsO+UrKOy2bgDJKuRRkxgJXsZXikm/pyOj4FS4QVWU/fuustiOyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6512007)(53546011)(2616005)(6506007)(6486002)(6666004)(26005)(54906003)(8936002)(41300700001)(316002)(66476007)(6916009)(66556008)(5660300002)(8676002)(4326008)(38100700002)(66946007)(478600001)(31686004)(83380400001)(36756003)(2906002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFLMzVoaVNvU0dqT2hsRnZNclpPeERMbm1INk9XTnF5TGQxc0ZWRUdGbitF?=
 =?utf-8?B?R0tDOGNhOGZVMUVWcGhCM2FRVWo4c1NlbitMZHEweGNQeEFBd0s2UGZFMWlV?=
 =?utf-8?B?c3ZKUTF1Q0l3cndlWFRmV0FzRWtQNUFpMVU1ZTJRY3YvUEp1bEk0V2Q2RGVS?=
 =?utf-8?B?aEQ1SjdNbU85N1lPM3NmM0VVS3JGRzN5dHdTNVVHcGFtMDNwVnhjc0hTeFYw?=
 =?utf-8?B?K3l0THhFcGJNaG5VNExqWW9jUkx3RkZmeDJ1ZXpzbGpkdUZjaHJJZm4zM21q?=
 =?utf-8?B?K3Evcm9sdkVVZHR4dlpSRUx4SjBkU1BCZHRuMG5BQmVSMDBOWkJjdUJsYlYy?=
 =?utf-8?B?UVFzMEczNE5lRFVkazhnZVY0a2xyVkQrOE1OOGdDUkNtUUQvczNsZ1hScFFN?=
 =?utf-8?B?bnJhUzJwTlhRbnM1KzlsRFh5VnRsTWVLYm1JY0xvZHdUSjBvcHBnU3FiOGFR?=
 =?utf-8?B?OGRnVWRJdUdSRjdwMVlyMjdtY00yS0l0a1N0MDVxYjc3RUpGb0hKZ3RsSE9F?=
 =?utf-8?B?d3lxM0g3R2paaDNiM3gyS0tnV3Zyamg4Z0dmcFBWVTRpaStVSFhLRDc3eFBO?=
 =?utf-8?B?dEJhdnBBZlNaOUtUYVRNYlcrMytPcDAweE1TRWl4OHNkems2cHZ1OEpqVEwv?=
 =?utf-8?B?eVJhMlErK3oxbUhQTHgyNEorMzVOeDgxRFVoRzg2YUhPRzFEU1U0VVJaM2dW?=
 =?utf-8?B?U3pDMVFrWmFHaFRNTnB0TFBOOUJRZS84Q3gxSzV2Y0hoOXZRUWJhTkE0MGpB?=
 =?utf-8?B?ZlE4QXM5ZXIzZWd4YnowdmZVQTdCZGRCK0JZT0Q0eTZMNnFOOGlXYWR4TXJ6?=
 =?utf-8?B?Y3N5bTQ1ZUxPaWl4WnlLamltSHpiTXB4UTFpQjlnUHFjcTQ5ZG5OTDd0bGMx?=
 =?utf-8?B?Nlo2ZU1lOHgvTk9iblpNVEVOeC9zQWs2cy8ybEtyZTYycmh0SU9qU1BBa0Q3?=
 =?utf-8?B?aExCMjV0UHNjRHhDczRRWUpOaExINTZQWTVCMU5lV0FCNTZCekx0emh0ZkZi?=
 =?utf-8?B?RStocHpmT1pRK3hFL2xUa0MxczczbWE0c1Q5WG1TVnpkZGgwTGczMDdEbmdp?=
 =?utf-8?B?ZlVxVTNRcUg0RHdlU1pQWlU3SHBaVERybk5iM3lOSG13QXB5U2tzaU5LTk5B?=
 =?utf-8?B?Qy9sK1FVd09KYlR2MkUvbFNsOUZudExnWjExb3h5ZU15VnlGdXlHbUsyN09y?=
 =?utf-8?B?UkptbnNmWHV3NmsyWmNVcnhRZ0ZmYWRGd2dIUDJqTlBJWndCUWJaTnpsNWdi?=
 =?utf-8?B?VmdvOFFIcEtUNkZCSmpkdkcwa05vV3o1dEpEUHBtRUJCNXJQcWRVR2U1aWRQ?=
 =?utf-8?B?cjJCRlpVRmh3MDRTblBBM1l1NFRJZ1dXcUJpa2cxM2hCUWhuUXlpNEEvYVZQ?=
 =?utf-8?B?NnhmVFlQTE1qNW51dGdhVmJ3YS9yUDk4SndZdU5ERitTcGhUbzV1R3FTUFI3?=
 =?utf-8?B?N0hUWm9HcHFib2dHUEpBU2E4OGJRcnBGcW1aWWpoY3AvRW9SZjRXdXdwQko3?=
 =?utf-8?B?c2FWZmZybUVRRUltVXl6TjcrY0dONm9kdlcvZ2o5UHkyL2NiMEUxZmx3RWh3?=
 =?utf-8?B?N285UFhRc3U3TXFteE5jN1F6MDA1MnBXbU9pb25tUjMwK0pvU3dPTEJPdlF2?=
 =?utf-8?B?aVFvM1hNNTFiQ2xOa2t2aDJ4cVI4eGJaOXBQK28zYVE2dzNncWloc1gzUlEx?=
 =?utf-8?B?M2hjNktXdG5xZlMzeUVCSW04aWx6TzlRMDNSWmdNS1VqTWxoc0U5RzlEMFd5?=
 =?utf-8?B?cEN3RDhRUlRXSVp4YW9XKzROcTRhdS9DYk1PSGdHTzVXaEdXaGdIUmVBTkNS?=
 =?utf-8?B?NEI2enZLVkR0aXcxZ2F0alJiRzBiNnpiTi91bEp6ZndLdE82UllOMm1JaU9H?=
 =?utf-8?B?eFNuNU1OTGpSR1R2L1NvMGNISU55QXJJY2xSVEUzb0M3MTVzVXdsdHhybFp4?=
 =?utf-8?B?Yi9Td0wraXlmemhaVThFY0hDM0RzTWNuSW45VkxCdldodXRKYzVZdEpvVi9P?=
 =?utf-8?B?M3FRS3l6eXBTUWhFcTZiYVh0M21ZVjZDNDh4a2MrcFdhSlNDWm96OURBbDJN?=
 =?utf-8?B?aE1NRi9mM1lzRWNLYTdqRGlvT0VBaGdQN2xBYmNMeWRIUDltZ2ppakR3a3dW?=
 =?utf-8?Q?CNo/DZHog4HGbySxrvlErVSni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541c3f33-d72d-4c88-a009-08dbb3e1243e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:39:36.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV0yvIIA0RWfPZq/FnLiZ+jKsAOPKGBlntCLGrzLeUV+ARUkYQW1NNdxFbl6xkXQwkh530yEA/VuhOFAOVb/pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/28/2023 2:54 AM, Lukas Wunner wrote:
> On Tue, Aug 15, 2023 at 09:20:42PM +0000, Smita Koralahalli wrote:
>> +void pci_configure_ten_bit_tag(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *bridge;
>> +	u32 cap;
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	bridge = dev->bus->self;
>> +	if (!bridge)
>> +		return;
> 
> I think you need to use bridge = pcie_find_root_port(dev) because
> "dev" may be further down in the hierarchy with several switches
> in-between it and the Root Port.
> 
> Note that pcie_find_root_port(dev) returns NULL if !pci_is_pcie(dev),
> so the check above may become unnecessary.
> 
> If pcie_find_root_port(dev) == dev, then dev itself is a Root Port,
> in which case you need to bail out.

Will fix thanks!

> 
> 
>> +	/*
>> +	 * According to PCIe r6.0 sec 7.5.3.15, Requester Supported can only be
>> +	 * set if 10-Bit Tag Completer Supported bit is set.
>> +	 */
>> +	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
>> +	if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_COMP))
>> +		goto out;
>> +
>> +	if (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ) {
> 
> Hm, if Requester Supported cannot be set unless Completer Supported is
> also set, why check for Completer Supported at all?

Makes sense to me. Will change.
> 
> 
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2476,6 +2476,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>   	pci_pm_init(dev);		/* Power Management */
>>   	pci_vpd_init(dev);		/* Vital Product Data */
>>   	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
>> +	pci_configure_ten_bit_tag(dev); /* 10-bit Tag Requester */
>>   	pci_iov_init(dev);		/* Single Root I/O Virtualization */
>>   	pci_ats_init(dev);		/* Address Translation Services */
>>   	pci_pri_init(dev);		/* Page Request Interface */
> 
> Hm, isn't this too late to disable 10-bit tags if a hot-plugged device
> doesn't support it?  There are plenty of config space reads/writes
> happening before pci_configure_ten_bit_tag() and if the Root Port
> has 10-bit tags enabled by BIOS because a previously unplugged
> device supported it, I assume the Root Port may use 10-bit tags for
> those config space accesses, despite the newly hotplugged device not
> supporting them?
> 
> If so, you may indeed have to unconditionally disable 10-bit tags
> upon device removal and re-enable them once a 10-bit capable device
> is hotplugged.
> 
> I'm wondering what happens if there are switches between the hotplugged
> device and the Root Port.  In that case, there may be further devices
> in the hierarchy below the Root Port.  I assume 10-bit tags can only be
> enabled if *all* devices below the Root Port support them, is that correct?

You are right! I understand I missed the consideration of involving 
switches and hierarchical PCIe structures.

> 
> The corollary would be that if there's an unoccupied hotplug port somewhere
> in the hierarchy below a Root Port, 10-bit tags cannot be enabled at all
> on the Root Port.

Yes, but the BIOS might have already enabled 10-bit tags on root port 
before this hotplug port becomes unoccupied on hot-remove.

   Maybe we can leave 10-bit tags enabled on hot-removal
> and only disable them on hot-add?

Considering all the challenges, would you think we should 
unconditionally clear 10-bit tags on remove and enable them on add? 
Because the TLPs issue will exist even if we leave the tags enabled on 
removal. Disabling unconditionally would atleast resolve config space 
read/writes and p2pdma issues. What do you think?

  That wouldn't work however if TLPs
> are sent to the hot-added device without operating system involvement
> prior to enumeration by the operating system.  Don't CXL devices
> autonomously send PM messages upstream on hot-add?
> 
> There's another quagmire:  Endpoint devices may talk to each other via
> p2pdma (see drivers/pci/p2pdma.c) and if either of them doesn't support
> 10-bit tags, we need to disable 10-bit tags on them upon commencing
> p2pdma.  We may re-enable 10-bit tags once either of the devices is
> hot-removed or p2pdma between them is stopped.
> 
> Finally, PCIe r6.0 added 14-bit tag support.  It may be worth adding
> 10-bit tag support in a way that 14-bit tag support can easily be added
> later on (or is added together with 10-bit tag support).

I agree.

Thanks,
Smita

> 
> Thanks,
> 
> Lukas

