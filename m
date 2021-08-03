Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC53DEDD2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHCM0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 08:26:50 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:35265
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235573AbhHCM0u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 08:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu/W7qhngd5Ph9NFq/4gu1MpFHiY4wYznA4ztAA2WNshkIhTKg39q2vND54aUkF3MNHaRewWjsOo2RHxlre1y89C1yWYh+4Wrc1drPFLhIhbTeeetamyvn1pGiZrNjT5laQlrck8wtgmGtRsgWjX9+HYjgU6+c/z36jwhLHMKTK2ZMjRCGkOlKNGJj2l+NNQ5gOFDeMgu0iuWPYbTo7M3wGXRb+7xvCDFGroR6mO/Cj8cFOXMzTssf0AWUFB/Ebf75kbsOn6NTMd8RBgIHbFz8t4ADEpe109kkHX0wxb6ajS6ZwlgUu+JXcnLb2y2Yn2IUSgh33IgUVM+zfxCYVkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvVl2kiRA24Fpfuhg6xEuGSVafwLIcB7X+mC94yNymE=;
 b=JdVY5wJMLRmZ+vjOV7aSUF4rC5/sez+dPgPX3IXEzZaaJP3iawhfMlbjc9Y2SRjeJK9puB5nseXzXBib/LuaiMN4L5UdZdPMX+3HffXeB/nfDkT+gD5pryOfibpq4sdHT5M4idlPDqil0xoeS/aqItKjzZcVzeYUgcs4k2jUdgWyJe345cCMlhA+CunQB0rhOKMKHnLiRrBZhm+yz14aJfPyVYjvWMOkQrC4hOPC/01HEP4/3tgQFvGSMOnTRHx6iyeHbc+wngvpsT7p/6l7ZdrIGQqHmx8UUwhmR+tJC9eJTlIkakQGNvuDya3WRuXWzedLPxL5cYVnSSFtlZ4OFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvVl2kiRA24Fpfuhg6xEuGSVafwLIcB7X+mC94yNymE=;
 b=dlCqvLLLyEF5Eo13A5R1g9PzKopxmXiqp5mBVsIMqH+n9jeThd9AfmIfSpXr3PSyU97pUphB6GIqtgw+4QyrR1UOmnnfs2qeq9xQWVJp+Qroi6XVTi9lysnzJ+vMqAydxW/alcFhBpczHUBZ9JZKmpcHuTRoa5/WqSGlWrMixJ8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 12:26:38 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 12:26:37 +0000
Subject: Re: [PATCH 1/4] PCI: Add AMD USB4 host router device IDs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, bhelgaas@google.com,
        YehezkelShB@gmail.com, Basavaraj.Natikar@amd.com,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-2-git-send-email-Sanju.Mehta@amd.com>
 <YQgLX2CukV8oc8eW@lahna> <8578079b-76f1-b596-db3c-e02618724ba7@amd.com>
 <YQkQTWxWK3YzFYeJ@lahna>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <4feb675d-7b5c-e5a3-4b01-d22289a8ad32@amd.com>
Date:   Tue, 3 Aug 2021 17:56:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQkQTWxWK3YzFYeJ@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.44.125] (165.204.157.251) by MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 12:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7186bfe6-e35f-4e59-2037-08d95679f059
X-MS-TrafficTypeDiagnostic: DM4PR12MB5053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50530E7BA986B2EBEAD18817E5F09@DM4PR12MB5053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxPTc5rc1XcB/TSTN3Y0KTKxcHBIYwLe5dLRnWNPVxO+Y9XxWpOmFCsU3NenbaT+PcABWEuRghni/uiOwwJVDtaZhmhS2ZB9ReXv9q4lMPggjaW0ng0BRcLqpYoplXtcHTOLwYD/OOc7iU6HigWM3ovnfGnqiMOYmg8PRYZKxRGhj5JxWk5n45OaOqnJmx0yMZHlQpkAVz+MCLC5x2CJYooFtku6Am/Vg3LzdrRTpX7+/yTdaMXFkHBvjn8ATVVMxWhHnhszwsmszSV4H8aTgNm88AefHoi+c6kgyNjkF89j1KpHyCjb8leo5dC7Ie4cfeGjLX+4sMEIwYixWnwTW4zEAOoYZNECL7kdWvD/siwo83qb1sSunBg+GZJRlQo+iLrt3QR9WsBWaoUxRuJlAdjGxbi502WppHlmZ2WizzF8r0Z+ZsxE50NcdGoBD/dfqRJc5j35lXz9nd2FhiuZzlWdDjEaeP78Y7qjsZV991IjteDkfRlGfHlPtVg/snSuZYzcFiM9wUUFzbh5CcnNxirg40m/5wVATuIZGsYmIxmsbZKSolouisb6J3XD1r7HVI/Td33NFmLvZ9j5Yc3mbQ+h9dGt9YB/y4b1nXKfgJyJmkOwXYJtppGYrQDKgZ8TXhbe1Zliz/LKUFxYqxiLjm/NXTGV1sy5vy1bVUdLWWmGasuJZp3/juZEtrwML5USnHavZFTxxZDfTRtqIznOEdsKLBeVDggrwmVJkQ+QHBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(36756003)(2906002)(6486002)(31686004)(66946007)(66476007)(66556008)(316002)(16576012)(4326008)(186003)(8936002)(38100700002)(53546011)(26005)(8676002)(5660300002)(478600001)(956004)(2616005)(6916009)(66574015)(31696002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9QNFRnTVk2Ti9ka25kT3lEeFVFZjJtMTQwVG9qYjJpR1UzRy9PUWNMa2VX?=
 =?utf-8?B?RGhuUVVHWm54ZFVTS1pwaEFmWW1PVE1tYWRjT083TnV0VDMzK3NqQ2dnV05D?=
 =?utf-8?B?c2RGeEVkMloveUhXWGpxQlVyd3ZDV3UzeDVCM2h6dk93VEY5OXV1Y1NaUVU3?=
 =?utf-8?B?cjdTRGttaHJUQVdsRUJMVGMyVlF0NGJhTENRc2FwajJQNUNlYTljZ2k4S3g3?=
 =?utf-8?B?bCtWYnRwdzRFNFJvbDRJRHBNbmN2U3VDRGp5YlFweXpUMUVHa0FEdDBYNE9N?=
 =?utf-8?B?clhaTFR6QVlMS3FOSlFLZW9VZmJVZWRaamRoV0o4NkVWTXQ2QUYrU1dvUVlm?=
 =?utf-8?B?NTdnU25OWWRwS1JmNVhpTUs5M1VTajN2bUJCZjlhWFkwQm01dVBCa0RBYktG?=
 =?utf-8?B?WlJ1cnFTOGlSVUN1aTJGanRCNWlOMVI0cU1FdXhaaTBaeW4rNTBabkVBdE5y?=
 =?utf-8?B?dWtWWU91UHJudTcrQTgrOVhGK0c5MlhSZVVZN1NkVE5RWU53d3RQVUZXSHkw?=
 =?utf-8?B?cXNvdGhOQi83NkpsRGl4N3N4RmpDN1RUZDc5aDNERE4rZ1d5SWwwd29uTTM5?=
 =?utf-8?B?amRDeW5Zb2JZY1MwbGordDVuVWhEelJGcFVlUXFnRVMxRGJRTko4cUozay8v?=
 =?utf-8?B?cEVLS21MbllaZmZTVWtoQ2tiQjk4OEtvNHZjT3ZDTnlhc1NUTnNFZDhuQnA0?=
 =?utf-8?B?N0EvNGZCbjRQZWlrSHNub1lLNWxsTkxOVmZ1dXBicHMzVXJNRFNwVmRTV0ov?=
 =?utf-8?B?d0FJZXh5VDhXMlA3YjFDOHlLcTB3dDBlWituUW5wamlXN09yWWlDUUczYjFC?=
 =?utf-8?B?b25RNUhHNnBsREdvcWtpNWlwRC9RSUo4N0I2YTI1dXFEaWZYT2NxWUtEWmNt?=
 =?utf-8?B?bW5aN2J3bmRGaSswVUdVeGQ4REd4TE41TnpNS0VaMStqRVAwTHlmczJobnJr?=
 =?utf-8?B?Wkp0OTkxK1ZlYWR5bzV6VmpxRGxmcStpcGVjZjhteWVFeGZXYThsSThqL2pB?=
 =?utf-8?B?UmUyQ29kNmhobjVaMXdFQktLS0NIamNaejlCWjVwWTJvNDlicVF3R2tETzRX?=
 =?utf-8?B?VW52VW1BZG1QU3VZYTZtcGhhQ3VZMFNNU3czVEU2Z0FaSHlaWXQyWDluN2R2?=
 =?utf-8?B?NmZ5eVIzNHBDb0RVYlltUGY4UWZnV2puTURzdG11alZ1Ym5OVFJjS0hscEVz?=
 =?utf-8?B?ejJiL3d0SmMxdmp2RjF1am1KQ0pLTDFYY0p0YjZRTU1LZk9QTVdVWWw2RkQ1?=
 =?utf-8?B?QTZEY3NLMTdPU0paOHhKSlczS0tFeUd3NFYvNGtIYk96NWdOWnF1YWNYUGxh?=
 =?utf-8?B?eXB0dnZaU2xWd1p5SU5zdlNuS05WelNkY0RSVXZMT0tXRHFUWlB2bzNZWUt4?=
 =?utf-8?B?ZHFYb3dobWFuSjdEZUR2YVRRKzNXQko3TFAxek9Ga1d2c0hXdWx6YVJEclB3?=
 =?utf-8?B?SlluZkt3MXU2TjFaby9vTnpjNEZpU1pQa3phRHE3dmgyS0FoeGR0YTdWN2x5?=
 =?utf-8?B?OHZNWlJVTVdNdThkbE1TSXI2blNtQzV1aTVCTEZvRDNoU29LbzZMUmRoYmNJ?=
 =?utf-8?B?dHlJbUtqa0xjTzZQOWl5M3lWVFQ2OTQ5YnFQQmp2V2RsUmtIMGxYK0ViTHJ5?=
 =?utf-8?B?ZFNxVG9TTmdBVUhnYzd2eEZ0T2NKeWwzZGVsUnlsWTFveFpvTE1KN1l2d1ZB?=
 =?utf-8?B?dXl6OWk4dWcxekZmY2JBZDVRQTIwbHhERWQwbDgxaFB2N0JnVUpSQVBXd3lM?=
 =?utf-8?Q?kGDDINxBjPgEmM4m66qnPlcik9WOC/TrBUqQvrA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7186bfe6-e35f-4e59-2037-08d95679f059
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 12:26:37.7888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr/oqu2EbahTI1sTMwFB05B1Mfaz4Bc6GuctR/PMbyAG+nbUygCbJ4NTPy0xBMMMUyU3x8VfTX7vhc46050Rbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/3/2021 3:15 PM, Mika Westerberg wrote:
> [CAUTION: External Email]
> 
> Hi,
> 
> I have one more comment, see below.
> 
> On Mon, Aug 02, 2021 at 11:39:32PM +0530, Sanjay R Mehta wrote:
>>
>>
>> On 8/2/2021 8:42 PM, Mika Westerberg wrote:
>>> [CAUTION: External Email]
>>>
>>> On Mon, Aug 02, 2021 at 07:58:17AM -0500, Sanjay R Mehta wrote:
>>>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>>>
>>>> This patch enables support for AMD USB4 host router.
>>>>
>>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>>>> ---
>>>>  drivers/thunderbolt/nhi.c | 4 ++++
>>>>  include/linux/pci_ids.h   | 2 ++
>>>>  2 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>>>> index fa44332..d7d9c4b 100644
>>>> --- a/drivers/thunderbolt/nhi.c
>>>> +++ b/drivers/thunderbolt/nhi.c
>>>> @@ -1338,6 +1338,10 @@ static struct pci_device_id nhi_ids[] = {
>>>>       { PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_NHI1),
>>>>         .driver_data = (kernel_ulong_t)&icl_nhi_ops },
>>>>
>>>> +     /* AMD USB4 host */
>>>> +     { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA0) },
>>>> +     { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_USB4_HIA1) },
>>>> +
> 
> I wonder if AMD USB4 controller exposes the USB4 PCI class ID? If that's
> the case and you don't need any special quirking like Intel does then we
> don't need to add any PCI IDs here and allow the below line to match.
> 
> This is actually what I hope we get eventually in Intel HW too.

yes, make sense. Will remove this from the series.

Thanks,
Sanjay

> 
>>>>       /* Any USB4 compliant host */
>>>>       { PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_USB4, ~0) },
