Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956B4EED30
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiDAMez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbiDAMey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 08:34:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2018D986;
        Fri,  1 Apr 2022 05:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsguoKwIB1FtQEYfN1bonI9MbTKJJKdiQf+8Zpn6iPy8wcizhrT5Szvf/jZIrwmgiCW9EO+qLX1jmK3wUDBzr3xPZtT6OPW3244Y30Z31IYb7rO/L1aoBnHc5sfOWmGMuc6dVQ7mI9vnc4MD0af+JwYkJ5aRjkjBZLhJvYUJ9xNXfXT9wJiky9T/Ucacv1so890sBUHXFkdz3jJeFRNj8TZPdHfwupN3tk8E0x52zpSint/WAzmkYyq233hBuIcZJoQMW4Tzf5UhPCgJFHaB4ntf42tFmGVjLreeZTKUoNj19BL74whECCj2Algf9EmktPQy4CO4mP9MBywt4cMOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOFSzH3LmNF/lL52YeoCQb+aI7Xy5Dlsh3xN+BU9IoQ=;
 b=ioz4PU7E28rJreaIWE0TNaBFGmH+XIJAA1wjzamSWNFg2Bqoz9KPR/vOEGxshh9Gt1n1pjOitRjG2jZB8DyfhdHKkU5IqNAzM26yk9V7WqXTIMU/ADqlXc+MoZvziXmI05ll9LthXsf/5BIwvPXRGllg4KZ+kfKVCM1oz4ByxpacOQ010aYsHZQvQ7Ozbq0LQZ/YhoNMSSZa0eJ+4tqa+XSQGScQo4+EIuNkJBsP4kuCwfjIz9+6OB/P06exYIvx3x+M2Ok4sFxMBNn5w76w0HGZgs5s8rMQm/qKqMWk4xXjST2yCmlYl2KPEhO3x1Um2taDQZlOP7ABVyIDern9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOFSzH3LmNF/lL52YeoCQb+aI7Xy5Dlsh3xN+BU9IoQ=;
 b=JiGBXvOKWAX5Asa+TUmqzupI1NJRvPjb5lDUIqOnus7IMKNhOP83XyXNNfrVu7I9QM3uWagZ7n7hAcbZ1ik/tpbra7WqDD+QdTsl2OBZ2Kf20b/+bimdECpr6a5bfuw/ph05AnqvB/dlPnoZon91xWuNG8CNmi0qpIfTNCGv+ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.26; Fri, 1 Apr
 2022 12:33:00 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 12:33:00 +0000
Message-ID: <34612803-5038-f727-f12a-8f71929301ac@amd.com>
Date:   Fri, 1 Apr 2022 07:32:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6] PCI / ACPI: Assume "HotPlugSupportInD3" only if device
 can wake from D3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20220401122918.GA87920@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220401122918.GA87920@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::19) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 474281d4-4672-4f19-726d-08da13dbc20e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4407:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4407A295BB967066ECCBD6E0E2E09@MN2PR12MB4407.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7168FDqFMivZU4sgCoHxRyIDWrniziUkPN9hy82hAV2HJInq8D+UwKsSwZM3Sg6uSrAddtfBIRiwAl877VWCmSfKOsQRd5v0yvVAET82m/J3lhVOhQcG8COSe9f3l+k6G8pFJ2GQPCJklE+sPlaT/fHMdxQtk6b19jC6iCUrY3heTOiJv9mjG9Ggl+IN4AjE3+D9XDdJbHiqBuqJe9No4MP5TI9gE5nY5iIftd3G/aMn9kmVLkKAPB2y+i9EAb4r+N7Dq/V9w3XVPMan1k30U9omuWu1WTSuSZ15kGxAu4HcsfGbk5Vw2E917rRW0iFHLxqUUMfApFMBt1ZEr9kRpXhs47GgyrCemaGuc+EuUYq1i08Al2xb4DqBuYmYbLFTmh/KXFqS9yItxNFkfTB3bLDTu1Hw85h5rjrHs8oaQDktZ0OqLb3k9V2O/kMXq9BZLg0MKoMG3nCMWQLKouYHAuw5mgHAh/kBXGj/dClP6c6XrtTI57ujf/rv3ghlVrm5ZjMLbeiF4km4GtLbnVnWXaZm7epYb4Ov1KaDh/eArQADoQW47PveLQWxjc+DYfLN1M+vjomnoswjqTrmuGKbUMLkDaAu/zrHMWLY64GREbEbc45L6AmfPGagA4H1iO18RcyJdiimyFZNv4wUsmFdDUbC4vUPQZLbCTihpwutORkiM3HYU/aHygiZQj7PWLQAalAxr70JQuVwbImn0pW8XeAqNh7Mr2AGg1P+v6fzLmxUoYh1Q67JcE4lIOUwXqJg7sBGOjBiXB8YS1ZSY8+0HjQg0/L7mYXi4ZFByOuOOPhPm87PWsD/TPd0JKY0gpZh0NUAfOKt2TUAOQlOGrETR5esZsWQFfUKKDHcZHpUCbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(66476007)(316002)(66556008)(186003)(2616005)(66946007)(86362001)(4326008)(31696002)(8676002)(38100700002)(6506007)(6512007)(54906003)(53546011)(110136005)(45080400002)(8936002)(6486002)(2906002)(966005)(83380400001)(31686004)(508600001)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUNzMTUzUU9OaXQ5QTlBRTBjSzRQYVlZaXpGZ25KWTU5Niswc1gyK0xjdkpr?=
 =?utf-8?B?NjNuQ3Jod0VndEt0UTFsdmlUS0RYWDc3eEx1aWV2dGx5UGVDdGhGOFA4K1JP?=
 =?utf-8?B?b05kZjFZQ1VLU2l0cjQ2ZEY1dDRPaTlnZlcvWklwSlRYaEMzQmhxUGM3RWEx?=
 =?utf-8?B?QlFXS0lvOXV2VWxkUzYrZ1JIOWY5OHAwTTQwbnhFT3dNSFM0SE1DTFdTVnUr?=
 =?utf-8?B?cCtMY0xNMlZFNWVqbXVLZnJVS1ZqSTZQMFh0S1F4SExudkEvVHVCU2xjOTFy?=
 =?utf-8?B?bkc4QzFoNUYvcmdFVFoyM3A4dFJ5OHF1eG5jS1FXWmN6b3NlMjAvTlZudDlw?=
 =?utf-8?B?VTJKaXJEYjB5UXZtRFBlMDZWOU4zS080WmNSSnVabzUva1pybDNjZU4zelBy?=
 =?utf-8?B?THZSRGZUVHZFT1lGaG1IekU1eGUrMFJiL1FET1l5VDZmVEZlc1JycXdrbjRz?=
 =?utf-8?B?SW95SExvV1Q1OW96YzZ5eDFYMlJJMytjZVdyd2JqR2JMeDBBRHYzVmRraUpY?=
 =?utf-8?B?c1NBaW5lM0E5WWEvUm5qVzU4NTlvcXMzUlM0NENnQW1RcTEwL2N3cnlyZTNJ?=
 =?utf-8?B?NXNYTmcvLzQwZHNva05hOVFwQjdUSk5Zd25WZ3JjUmxEMnMyeTg1a0wrdTRB?=
 =?utf-8?B?SUYxQkpIUUU3bklWSG52VzJuMFR2akdaQVFLdTRpUDV1TzRKaC9wZmVvVE11?=
 =?utf-8?B?NE5HVEJSbWNIOEc4aDRnRG1YcVJ6VVlVUEJONHNJN1BtOTRMUDhac0pTMzl2?=
 =?utf-8?B?MGV2SlVDK3FiaERMb2V0OFhuVFRyc2J2MUlWOE92cnBPMUwwdHloT05vNUt6?=
 =?utf-8?B?Z0p0Z0l2ZXlhVmpveHFxcUc0dHR2RE81MFVyYkx5SXNrVlFIUktUZkJtYU1N?=
 =?utf-8?B?L0crTFFXUlh6dlp2VnppSkk4ZnlDdUo1UXlLdjdaSGdWTlV1Sy9vbGNvRk13?=
 =?utf-8?B?a050R1p1dXZZdk1WcXBDa01naW5BUWN5L3BqaHZ5RnhhOEZWanZpNzlHdUly?=
 =?utf-8?B?bFRFN2tmL2xSdFBGa01FQjFXU2FybzBPc2h4V3pMRlBiUno4eWNLSS9kcHZ0?=
 =?utf-8?B?MU9oVWlBK3hrWjdSK3JQbm9zNmR2andjSkViL3dLN203YTBHQ1N2bHpFcSs1?=
 =?utf-8?B?UDU4NlUrb3A3bEJ0bzZWRS82NitWVVdoeWtHTFhnbldwSElFZEZXcC90ZDQ4?=
 =?utf-8?B?K0ZoQysvZGhpZldocTlXTFRZWWRCejFhU0dCbkpGZllYYnVDSGNlK0NsQXZQ?=
 =?utf-8?B?cTBqMkRKWlJkSzRzMWZNbUtzNWFsdEl1cS9ySXp6RkltZklSalJvdythSEtO?=
 =?utf-8?B?L1l1SjlFM25HMDQ3QmRpOEVlb214cGU3aDJIZUhSZnhvZWV1cHlrT0ZxUEdV?=
 =?utf-8?B?Wm9sVkg0a3ZWMnRnSXRKbDg4QmlYL3c3WjlGUkp5TVZhSHZqT1k1N2p6OFF6?=
 =?utf-8?B?T1hwVFJDdG5zM0x2S3B4QysxMXhDQ1Zneld3NkptSm9ZOHFoQ3N3RytZNVd5?=
 =?utf-8?B?WXIzWEI5VXR0Y2Y5dGVOUEowemQwZ2xlVzdKOU9TMGpZZW9oKzlSQ1lvSDFU?=
 =?utf-8?B?NkxxQ2J3eXF5NCtTOEd2MnZIYnJKSXhwQjJtV0xqQXZ1MUJPbTkxUkpMTGl2?=
 =?utf-8?B?RVBJSGdMY0hwUmJUZzh2YmhucEQySkxYczNjNGg4cWhoRHJHUWxvWW5PVExF?=
 =?utf-8?B?QThlV2REK2tnRXIralFpaU5kdk9aMjdRSW1aaThBNnFCeHpsbHlvTmptYVBp?=
 =?utf-8?B?VFgxUDI2SE5KbUtXMmhoeTJYT2tSZUF1MGVyL3hxOVd3SDlmUDJDdmpLbUJY?=
 =?utf-8?B?QUw4dWdITWxNRzFyZFB6eHhrdjI2SXpxZXhqYzJqSDBGbmFVVFQ1MWlUSmZY?=
 =?utf-8?B?eG5uVnNlNXRrQkpOc1FZRW1MZTRxQ3BlYVNmY08zcDBlazZpaG0yaXVzOTB5?=
 =?utf-8?B?dVRsTTZpek9zY0NyUUlCR3ZQcWZxUlgzZ2s5NU9TMW1OcWZ1bE53Z0VCdFBV?=
 =?utf-8?B?UmlKeUhJeVd6OTMwcDlXY1BzS0UzOFpISmhSN0tTVGUwbHlQenMxNng3dEZ2?=
 =?utf-8?B?VTZuM3dCcjFtVFJOdjhkMzBGeEJpSmZoQ3NHSFRUdE1ZcW9hbCtzZnNxTDB6?=
 =?utf-8?B?dTdSM2ZZbUZBMlM5Z1RVVXJmR29ocUJxWTBEYTM0QzVkRG9YVGtUSnBBVlQv?=
 =?utf-8?B?bm5YdU5qNDQ1cXJCbzBrYTBVbHc4U0h3Si9MK0pFVERtVXFYZHRCNWVBQVBC?=
 =?utf-8?B?SW0vbXQ3ZUxDU2tnNHFGeEZQTWxKZDl2MG4rZVQwYkVsWEpXUHJIVmlNWHFS?=
 =?utf-8?B?TkVQSXY1TkxSMVdYQTljdTMybXFhQVN0b1B3TVN2bHJJck44eVc1OXhDTjNC?=
 =?utf-8?Q?/Veu50HYJ63McSWjk38b0p7+hhG/QOLDwuSEcYuq0PHlt?=
X-MS-Exchange-AntiSpam-MessageData-1: pucT5u66brnO9A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474281d4-4672-4f19-726d-08da13dbc20e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 12:33:00.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u54BofIxfCuulmonSwb2lm4208Vw5Mh88KFLiI2GckrCk9Z+7bqpAYvbxUT2MQobGvF9rSH43t4zwDiWadKuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/1/2022 07:29, Bjorn Helgaas wrote:
> On Fri, Apr 01, 2022 at 01:44:42PM +0200, Rafael J. Wysocki wrote:
>> On Fri, Apr 1, 2022 at 5:40 AM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
>>> that can handle hotplug events while in D3.  Previously this meant:
>>>
>>>   1) "dev" has a _PS0 or _PR0 method, or
>>>
>>>   2) The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
>>>      property with value 1.
>>>
>>> This did not consider_S0W, which tells us the deepest D-state from
>>> which a device can wake itself (ACPI v6.4, sec 7.3.20).
>>>
>>> On some platforms, e.g., AMD Yellow Carp, firmware may supply
>>> "HotPlugSupportInD3" even though the platform does not supply power
>>> resources through _PRW and _S0W tells us the device cannot wake from
>>
>> More importantly, it doesn't supply a wakeup GPE number through _PRW,
>> so from the ACPI perspective the bridge has no way of generating
>> wakeup signals.
> 
> Perfect, thanks.  That's the missing piece about _PRW.
> 
>>> D3hot.  With the previous code, these devices could be put in D3hot
>>> and hotplugged devices would not be recognized without manually
>>> rescanning.
>>>
>>> If _S0W exists and says the Root Port cannot wake itself from D3hot,
>>> return "false" to indicate that "dev" cannot handle hotplug events
>>> while in D3.
>>>
>>>   1) "dev" has a _PS0 or _PR0 method, or
>>>
>>>   2a) The Root Port above "dev" has _PRW and
>>>
>>>   2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
>>>       D3cold and
>>>
>>>   2c) The Root Port above "dev" has a _DSD with a
>>>       "HotPlugSupportInD3" property with value 1.
>>>
>>> Windows 10 and Windows 11 both will prevent the bridge from going in D3
>>> when the firmware is configured this way and this change aligns the
>>> handling of the situation to be the same.
>>>
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance_Mgmt%2Fdevice-power-management-objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-state&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cc8ff8ac0568049a166bd08da13db41f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637844129686586061%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=bjd5NnFaGslXcSVvShZMRHzuedEx8VgGnEnCGlWZ%2F2Q%3D&amp;reserved=0
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Cc8ff8ac0568049a166bd08da13db41f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637844129686586061%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=r11UKOwL6SvGv4VCxaDyH0k15dsJib%2BJvRCS2MRobUQ%3D&amp;reserved=0
>>> Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> --
>>> v5->v6:
>>>   * Re-order checks to only check for _DSD if necessary as suggested by Bjorn.
>>>   * Adjust commit message wording
>>>   * Drop rewording comment patch, just apply it while moving text to avoid
>>>     ping-ponging the same lines in the commits.
>>> v4-v5:
>>>   * Don't fail if _S0W is missing
>>> ---
>>>   drivers/pci/pci-acpi.c | 25 +++++++++++++++++++------
>>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index 1f15ab7eabf8..5ab797e2709d 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -976,7 +976,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>   {
>>>          const union acpi_object *obj;
>>>          struct acpi_device *adev;
>>> +       unsigned long long state;
>>>          struct pci_dev *rpdev;
>>> +       acpi_status status;
>>>
>>>          if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>>>                  return false;
>>> @@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>          if (acpi_pci_power_manageable(dev))
>>>                  return true;
>>>
>>> -       /*
>>> -        * The ACPI firmware will provide the device-specific properties through
>>> -        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
>>> -        * for the root port and if it is set we know the hierarchy behind it
>>> -        * supports D3 just fine.
>>> -        */
>>>          rpdev = pcie_find_root_port(dev);
>>>          if (!rpdev)
>>>                  return false;
>>> @@ -999,6 +995,23 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>          if (!adev)
>>>                  return false;
>>>
>>> +       /*
>>> +        * If the bridge can't wake from D3hot, it can't signal hotplug
>>> +        * events in D3hot.
>>
>> I would say "If the bridge cannot signal wakeup signals at all, it
>> cannot signal hotplug events from low-power states including D3hot and
>> D3cold."
>>
>> With the two above remarks addressed, please feel free to add
>>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Great, thanks!

Bjorn,

Please let me know if you want me to send up a v7 with the minor remark 
updates, or if you can just fix those up while committing.

Thanks!

> 
>>> +        */
>>> +       if (!adev->wakeup.flags.valid)
>>> +               return false;
>>> +
>>> +       status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
>>> +       if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
>>> +               return false;
>>> +
>>> +       /*
>>> +        * The ACPI firmware will provide the device-specific properties through
>>> +        * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
>>> +        * for the root port and if it is set we make an assumption that the
>>> +        * hierarchy behind it supports D3 as well.
>>> +        */
>>>          if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>>>                                     ACPI_TYPE_INTEGER, &obj) < 0)
>>>                  return false;
>>> --
>>> 2.34.1
>>>

