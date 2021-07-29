Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBEE3DADDD
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhG2UnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 16:43:06 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:54881
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233247AbhG2UnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 16:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6jPZUw2ZeGcVnTqx6aAVHVoKIea+Gdzu/gsAv8d1HnhEPcc9q/GPgnws0UQgne6MTLyqQiv0miD7x6i51o4ScRqBVcroNaQzJeJYhcWYLTg83awrR8MEYpUKfdy1E7kRiB+sBTg4lD8oJourt1vYIN01akbHEVjV8gvB87c9tI1+I/C104QDn45cU/pwaHNtcJsKjdkfDu0DocPE979MFXdimLmJ4rkfS8s4GEAfCyp4C3zbzBxVhrd8SDBuPogOVLRs9K8Q/QIY2HThdb5Jk7RN0gW9HX/9bvEzPnoHGh7MZ7+DFhbTt8UX3nAOgU0eS0NLQqfLXZdgJQ/mMU0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lpweTVhsJGR++q5eyN8EN/qVszvqmwGSHC6eRUa5ko=;
 b=lkLJuZW26h3r4C1K5JY3eize+jDcBpjncDo15LdGB/YikSswrOliAKAnZU8zid5r1/pFmy0MKvVb7V1+ngqk1y/O/tMCDqqF6E0pGBPqyNiuiBkMUfrzH0ccJyA3zQZFqUA4ujRZWU+5Z/aSIVFFLPN5KbBGDAGw+H4q1fqgBZjuk64rT+47/fKYwbC5DtQhhKq2QDXP46Bug87+KFqFNQgWVSHdEYkrSGTZ5N1iAgTwNXFqYWA3PHJD0LcIRvPgi2yE9xRNrKO9UbLhVBV6ZIOHxCJDuCVat8OG0P99FedbaJ7ypoP34RqIztvRdejRJ8MSIOss788zOkmmSxyUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lpweTVhsJGR++q5eyN8EN/qVszvqmwGSHC6eRUa5ko=;
 b=iOP/ZczP5j4xYo+mJ9dcKKY+zYOy1EtwJVvqpasOPEa89yb/ELmJrpnika3gaAot/dYH/VglQ/W1ROOVx9QeuApuoxqDS+SQ57YpeTOxzb1vg8b7GU4W+7fvwfmXObp6l3gJVESqbBNt6uxEv968Ei40IbtmnDjRouNrYRDm9Q4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 20:43:00 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 20:43:00 +0000
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Marcin Bachry <hegel666@gmail.com>, prike.liang@amd.com,
        shyam-sundar.s-k@amd.com
References: <20210729203914.GA987812@bjorn-Precision-5520>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <7b6c6fad-8cda-537a-2178-f5e22e565e8c@amd.com>
Date:   Thu, 29 Jul 2021 15:42:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210729203914.GA987812@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0030.namprd04.prod.outlook.com
 (2603:10b6:803:2a::16) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.180.36] (165.204.77.1) by SN4PR0401CA0030.namprd04.prod.outlook.com (2603:10b6:803:2a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:43:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5deacab7-9e61-4d18-7adc-08d952d1746e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2767D3DD9D384AC1C3C459FBE2EB9@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAHw7snuc7oWbQ6y/cCR1+C38nYObnJoeQWp8SAZk4m7TlNCVEWaQey+2bgNiqZpy8GBZIeRiJUh3Xj8LJW/U96PmpuMwWYsB2h+Sz54Lv3sE/nw4sdnKtjpK++NFgCqhKr8DF55KNtf6+5Ky4Gemhaxq082GJJFqoFzHthRzcCaHuLOLCq9PG3f+/RQ/vwJED8V9sBTlqryodg1VZAiR7d5YRQww+YPrfyI72/3KKKv+hucaCg23EKERIHu+wJMjJTy2k6CFgQp4ql5QIaa6tkEDXSxwgooZytmXUyeVcKZdsLHPwiSa63wsEW9Oy3xyYSrLvNJxOXIWmgkC/BVcAjbDSleGAzf+YDOyve76VcCzhjsovyDx5BC+hhyf4JVqQ45ada+OwmTPM5Z7dPu1GBCqJYZnXw9IQ5PV76/fzy3EEmisrvL9rYWGp+pXe/PuknPMCyjOCwCqQnPqk5surCSAk5rywm9s7PgH/JNlWMFeXc4bXuHkj/XQP8m9ccpTFhqfYumP1kH446IFTdOWYa2hUBWZMG9jab8FRapaxm3qw7+k254KgT/sylg59Mbq0zB6yH0/uVeP54sw3+KE5HpU0KSZ76WDNuQxFKJRyBtjnymf4wNZBDA741GzPNw/a1PLP5l+ogNz3MJWK0z6i+beTREWOwdrX12cq7n0GzTN6OwIBlUlOIGWQv2RhA1O/rw7VQetGKK/gjx2TTmKKHzFdh1skcxK79UWOMWxhORMx9eJg16iq8XWFyl2oACtDjmKWX3MAMhAMbtoPSL0tmsPIC+ZHgp/HgNVR29sl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(83380400001)(4326008)(5660300002)(86362001)(16576012)(110136005)(316002)(6486002)(478600001)(53546011)(186003)(26005)(8676002)(36756003)(956004)(2906002)(38100700002)(31696002)(8936002)(66476007)(66556008)(2616005)(31686004)(6636002)(66946007)(42413003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhGT3JlVlYzN0M0aDBSUngrYk1FZFBKQkNZblc0aDNIQ1poL1lzZmRyUjZm?=
 =?utf-8?B?anVLRjF0R2NQdW41cDBhTDVQK2NtOFZyN2RSMVJacEw3MnEza3BsTDJBQXJY?=
 =?utf-8?B?amFYZk5CVkxaTnRUS1pDTjNSMTNGa3Jvc1pDRmo5UTlUU1Z3bWdta2VRTmVN?=
 =?utf-8?B?SFA0UHVNbnNINnh5MURVU1VvVmxPQXl2Y3BJYjYrR2dYV2FBdWo3VGtHVGRQ?=
 =?utf-8?B?bHdNbVJxd1ZRQkxwSDU0MWVmU2MwaStRb3J3QTZhMVBTTlB1SlVyNHdnVDNG?=
 =?utf-8?B?ZWlIQk9VU2I5Umw5N2hEcnZ0RnV2a204R1RzeHBjZU1TWUlPWHQyNmIwRmZn?=
 =?utf-8?B?cHE4N21VZldmNEN0QWx1S0R0SnJMTlNJUTQxRGpqY0l6Mi9PNXJKRzdlTkxo?=
 =?utf-8?B?SFhFSnp0eS9KN0ltWFg5M3g1Rmo5YTdUNkNseG1QY2dOTVdBYnlEQk9mb29Q?=
 =?utf-8?B?NGNzdnMwaCs1VlpTZ3J3a2xFTkQ5YVN3RGk4VVBDd0dvcUMrYlBVZUQ5dXBl?=
 =?utf-8?B?d1IyMW1rVFhmYXpBRFYzdTNpYml4NHAwc3VHVzR1Uy8yVGtiZWYxVk5RN1o4?=
 =?utf-8?B?eWhteS9LRzdrNFREWFZhbEdXbExRRW1HUkUrM2N0cWljaWU5YkFzRFUzbzA5?=
 =?utf-8?B?dktoU1NqeldCeXdzbitGT21TVXdaUlpsR2gwaGpFMVR1TmROVWlrb3ZJQmpw?=
 =?utf-8?B?eXpGa0l3eWFFb0R0UmZHVGdrNXhVRWhkYzBHZ1BrUGNzWEhvWXk1TWpLb2lF?=
 =?utf-8?B?N281RFBuQzUxNUVyNUM0bWcwRlN3YVhxd1BleXR5VGY3ZWFjR3BMdCtpTnNQ?=
 =?utf-8?B?NXUxL2RTaTBEd05aNjBlNnEyU2NRM0twMEE3MDNkRGQ4bmtydEx2Wm0ra0lF?=
 =?utf-8?B?eDZsT1IwZWIxd3BxdFZmYUZScWZ3N3prUGRsMnJhQUlPckZxc1dZN2lhcmp1?=
 =?utf-8?B?dE9kQjBzQVBGamh6ejhJSzJEa1ZianU4MjIwd3FheTFpZU1za2FBaGI0QTBV?=
 =?utf-8?B?MHppTCs2d0JqMS93RlhpM2RWT3BmZElWWkcycVRDV0oya0hnQ3N3bkMxNDg5?=
 =?utf-8?B?YUVFc2xXdlVoVHIwR0QzV0hTWEROa24zSlhWZVgxeUpiZERMekNEcHQ3Q1dV?=
 =?utf-8?B?K1JXVC9RbkI1TThncWZiU21LZllOU0JYeDJ2WFNPdGxNalpXNVcva0hqcldj?=
 =?utf-8?B?Q2VQNURYTmRteHMvSHR5YnQwdFowZGVlMGNjVW5FWUpqOEwycjRsTndmdmhS?=
 =?utf-8?B?YXpHQmEzYndrWk80Mk00WTlvMzAvM3Q2NVpiUjBDM1pBd29pMWtMSVhDZG42?=
 =?utf-8?B?WS9OeDZ2N3pQa0t6aWFibzREQllFbUN4VWw0NkJ4cWpCcElqSWI5Ym0xM21a?=
 =?utf-8?B?TGVEMFIvc0s5cTVhUEJ5ZEh6WjhaSHNrMzJIOC9maUVVUStwb3A2eEJ1WStz?=
 =?utf-8?B?RDJsVDlPL3JFN1V0M29OenlWcmUrTUUxMlpsRnhKVkJzK3dZM0lyaDd1NStx?=
 =?utf-8?B?a24wOWx2Z0tTNlQydGNUVktHQlU1Vlk2RzVUK3YrTkoybEVlQVM4Um43QTI2?=
 =?utf-8?B?NkkyaDBoWTRUc0Z4L29GU20xaGZZdjR4U2xvWWVkNUQ5S2trcnh0aXB5Nnlk?=
 =?utf-8?B?VVMxRHoyVkZoa2M2UXhsSGFzOHcwbDRjU0IxNmtSejdQSDZFMFZoTGFkVC9R?=
 =?utf-8?B?MWNZMmZVV3FFdFJyMW5EdS9SMGV1UWwva0N6VXBhQkxOdzQzeG5aSU5VT2Qv?=
 =?utf-8?Q?gbgumWfd9wiz3BdbbJq4AcJOVkAhEPv84BMog4l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deacab7-9e61-4d18-7adc-08d952d1746e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:43:00.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gNhiNRyUFfHgP+anAEX5rQ61vfvYRfYihyYlNmURGLUgGNT+0ZVua1iwgutmYfDOI8E64RtfknKQsT8F4j7cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/29/2021 15:39, Bjorn Helgaas wrote:
> On Wed, Jul 21, 2021 at 10:58:58PM -0400, Alex Deucher wrote:
>> From: Marcin Bachry <hegel666@gmail.com>
>>
>> Renoir needs a similar delay.
>>
>> [Alex: I talked to the AMD USB hardware team and the
>>   AMD windows team and they are not aware of any HW
>>   errata or specific issues.  The HW works fine in
>>   windows.  I was told windows uses a rather generous
>>   default delay of 100ms for PCI state transitions.]
>>
>> Signed-off-by: Marcin Bachry <hegel666@gmail.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Added stable tag and applied to pci/pm for v5.15, thanks!

Thanks Bjorn!

Given how small/harmless this is and 5.14 isn't cut yet, any chance this 
could still make one of the -rcX rather than wait for 5.14.1 instead?

> 
>> Cc: mario.limonciello@amd.com
>> Cc: prike.liang@amd.com
>> Cc: shyam-sundar.s-k@amd.com
>> ---
>>
>> Bjorn,
>>
>> With the above comment in mind, would you consider this patch
>> or would you prefer to increase the default timeout on Linux?
>> 100ms seems a bit long and most devices seems to work within
>> that limit.  Additionally, this patch doesn't seem to be
>> required on all AMD platforms with the affected USB controller,
>> so I suspect the current timeout on Linux is probably about
>> right.  Increasing it seems to fix some of the marginal cases.
>>
>> Alex
>>
>>   drivers/pci/quirks.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 22b2bb1109c9..dea10d62d5b9 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1899,6 +1899,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
>>   }
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
>>   
>>   #ifdef CONFIG_X86_IO_APIC
>>   static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
>> -- 
>> 2.31.1
>>

