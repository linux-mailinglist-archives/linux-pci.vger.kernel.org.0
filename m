Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360D50C7FE
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiDWHZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiDWHZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 03:25:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F49AE59;
        Sat, 23 Apr 2022 00:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSY903PHylPU5JnIgH+Ex5zPmYt97O7ee//8/YUZ6PLBqOf3Nv0hKGhqeHyeir67CD7qUDl1rfzF5pmKprDOVUdeLli3wjq4/SuLWkGCmZFi2LEs42/gTn+kJ5iEOCC1iWqBpxevCzbsUIWjixflC462azElg5EXiXxbA1ztuxynAur7UPdJi5ngJp3I7wihLzlD3hjJPkITprDrweib8RpE2xLW7l4IHlLhnS7+/welX40OnJWqu8ZPBOgvjaRIKOEVDQS4E5NtyEHQQprLBxckw4Q59gcEzSDLiMEB3Ljbh+cO93eKoqHXMUw7knBkNdaxvQ2xAtYnP5woC8zp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La7oiqfUvMWy5JPz/zZadazJs/uJHpZ3Xs7tTLcrPoA=;
 b=cYNAIDEG0Aqz/CRgCIPzkXw6JwjoEE8QIXuGbWzdhOrbzZoP0pMkYiKSQl9grSfnZcITBhrU2sthnnou4QNV1SM+eaFehm2SX7sPJRWai4Om5m+B56PwB6cGxm0qXcskiGfzWo1hcCxNfrBy3xDJMp7uFDpVKAFM+KDTeeMOXAJdwVDhh4otk67mItR4n8I5TaADJuvP8yvnZMos7YEKC5urSANdxWzUpe6DDvGIjFCln/vQqAU6X4TTnz3fYeIPl6E08Za5ZFQZSmAkZqMiYb7Tfwd2qiTDfgfWQsotDAC+noK4GB3XMhwqvxZoMB1x/vutOzusY+A44IJjmP5DKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La7oiqfUvMWy5JPz/zZadazJs/uJHpZ3Xs7tTLcrPoA=;
 b=TMYhRtE8s1f/AFHrjxXOTF78tfrkxDSwFpZR3HhISt0p3Pqk1G3NIGjGKR3H4eU0aHz3FJE2+g22VNXOCY6gvCKA5GxoPXborgE8odCFTm7MlIDUZLCNjxzluf6Pp10GAUq+vl7bnLGX1RSjtE6GW6XtBV1XQeLeu0RGff0jqN6keV1WwNjScYIl2/eLA4LJibD8SpfZdSMH38jbyiwKpFH+ZEFi6z/fnStOuE1vVnOcvWlLtTsUjvcGlWN3aEctBmDPlNNm6Qdpa2DimBRAY3/fFlJHYqLXWpHJYsJ0zX4kh1n+V6+LM7krL+5Isu0JVSfM7xSAVQFJea2jXAB8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH2PR12MB3928.namprd12.prod.outlook.com (2603:10b6:610:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 23 Apr
 2022 07:22:58 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425%6]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 07:22:58 +0000
Message-ID: <41f5f3ee-46f9-8adb-71cb-df828e94522c@nvidia.com>
Date:   Sat, 23 Apr 2022 12:52:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1 09/10] PCI: Disable MSI for Tegra234 root ports
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, krzysztof.kozlowski@canonical.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220207173648.GA402391@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220207173648.GA402391@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27577103-d9fd-4c1c-a2ef-08da24fa177e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3928:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3928C557622D7A6891F7A542B8F69@CH2PR12MB3928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvn+F44eapLAd5V8IasjuWv+/W0dSdL6/f/5mQfrfv0Cs8yXu/DKoHBOgrfBcwicWSkBVte/+aK3VzsC/jFBsJopdG0OrlPyBmljW+YF1xdejBnfoQzjJKQdrRYCbD3d3Jsc3GqpR3RmSWG1/xcwDPTGrZkfb05snZd3M+7ineU4bOFIjrAmwa7QMY0JqydqA1RYzxkvBwZC2UgStH3+ZtIpyyNjvj4WTeDLIv+QSujT7AoBJlHcmk2rnZDQu+dgG+mn/VJnE/uEoaZxxFaCyqXARIVcyNVJegvEmSV3bbbG23qF1bD+yz3GFv/CJc9VrPiE+jQUkzuOCBtPHMPDZDKZLo/yI4htQMGcnx1wdIhdLYi5FuixqJyPNgSElNisepjcWTVyfsPn/aL9FNOztvbbaSMWTNCKM80E0nYyjYnncYnEqpEX6W1Iha5PTORfPxTvadeN8IHC/tjIh/n4e9weOYUWaFuf0X/M2VD2c1gGaxC9baQHamlBE3IkEm2h0iAn82wH1iC5b35U/8uz9rWcRlMgay2oLSJ+U9aKacO8eLXrymwUbh3E30OgsunkTzWv/hw01TiMo1jT0Pr374OsVRXtsYYfgl3CmNQR0lN3dQvhLNw93UiLEqT4RrdSSXVc5KSRyo0ItY7nbu1qAse5FL2Gv7LJE1fq9tS23vR1aPrkeSfhgmjo1hDciayMlt7kU3qv66kkp5DMbsDrS+RKXsOpRxes42ovitHYhgHz/Xq7LJW3Zyw/tGDGZFKozPRSNLlOZqpCQbyrEYz0k6Wwc3Feg7WTVVVcq1o/dRxM1ZbaBYOY8P4m5Qc51XMCWVHszyjMhfcLmpEV0Ywing==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6512007)(2906002)(26005)(966005)(5660300002)(6506007)(508600001)(8936002)(6666004)(7416002)(53546011)(6916009)(31696002)(31686004)(316002)(186003)(83380400001)(36756003)(86362001)(66556008)(66476007)(8676002)(66946007)(4326008)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1rdlh3TUFLOXNYRTJWWG50N0pnaDVDRmJlMUZJNXlBNWlqSW8wMlkzWDFm?=
 =?utf-8?B?TnZncVhucXdodnVsa0V6bjd3NzV5bVZDS1Q4Rm1MeFM4dFVBcWpzSWhyNmdw?=
 =?utf-8?B?MldFWndsaFZ1RVkvSmhFOHNSdjBxaERVRXpzbDM2bjJVSDFHYWx6QXdNZi9i?=
 =?utf-8?B?cGQvMXRDaG5MUWtrL1pKaWN1Wnh1SCs5Q3kvWEg5Z2ZYNFVwZHh4NVJDOVJZ?=
 =?utf-8?B?aWFJNGFRelRpV1l2MzhZM1hzUnZwYjQxR2pzU2kvWDd5eGFDVUFBZHZUSXkx?=
 =?utf-8?B?SW9MNlh6dE4rcERWenFwR2NvRkgrSk5qc1cxNG1PM2tHeVB6T21HYU1TOWRi?=
 =?utf-8?B?TTVyRlpPYThMRHlVbFlvNkFFU1VBcHZkZTFHMXk0a3pkNDlKSWR4UW95UUxN?=
 =?utf-8?B?Z3JBaWhrY3ZmQXRHRkdTQnpRWmY5UjJnaWZkV2dSRzAxRWZRSWZQVkZlbHBS?=
 =?utf-8?B?UG0wVjFIeDloQmZPQ0hEZFBUK0plVjBQZS81T3VjS2pyVDlRUnArbnNnVFha?=
 =?utf-8?B?Vk1qUHhLN1VDKzd3TmdhYVErRHNUU3BSTXhyY1hxN3lPR0gxL3VHVUgxRmh3?=
 =?utf-8?B?Y3g0cEZ6R25wZy9UdzRKZ2szbXk5QUEzWnZVMExwZlh2UlNEZyt1ZUxHUktu?=
 =?utf-8?B?Vm9OYWpTeWZJMWhYRi9BdWJBdTR5ZHNTWjlXbTNLQ2dDTTJxR0Rjb2tabzF3?=
 =?utf-8?B?VHpJZm96c2VYMWVob3JYVndONHBJMlJ1cmZ0QTZrREVleWFrN1BEZUlubnVG?=
 =?utf-8?B?OUhqdnhxNVlqa1JCNG9xN1lzQnFWcjVJSVZrNFpXQTYyMUZtMGw0QmMvSjlH?=
 =?utf-8?B?SERId0FzREVlM3E5cXl3dzZ6Mmp3Zk44QzJmZFEwS25QTEFJeUxrRGM3Yi8r?=
 =?utf-8?B?dTNrUklyVjJ6VmF1NzNRa3k4QUdjbTdWWTlPeWpxRC9Tc2o0dUh0S3VPY1Ew?=
 =?utf-8?B?bys3T1VJZUR1WmJtcWhNbHhhdVVoNWNrS2Erc0FqTzl3b2h5VzJCeitwbXht?=
 =?utf-8?B?U2N1SEhncXNHMThlaGZhZlFMY1Mxa0M1eUpqLzRKT2hXV2RnREQrL3dGa2NI?=
 =?utf-8?B?UnZ0Tm43c0Uvc1Z2V2VWaHhLczVNZmVyRGhwWkYzUUxwYitHZlRQbTVnUFJj?=
 =?utf-8?B?Y1I0SWxkZTZTWnR5SGRMaitHNlY2clNQRnk5VXlhbmNOczNMaUVJNG9BQldn?=
 =?utf-8?B?N3NlVHkrb1dYVnhsVUN2WWlyYnhFN3UxcHZOeFpwK2VMZWRiMHoycGRIak5p?=
 =?utf-8?B?MkdhZ1lnaktYU29NYjNVUmE3L1BpamRsVUNlU2RCMExna1NqdmNvV2xzTWRI?=
 =?utf-8?B?dU1mTTJvc2RGNCs4Wk1RaVNUNUZoRy85c1krRW1vVWJpMmkxNlFTVHQwbGov?=
 =?utf-8?B?ejYrNVI2cDlyZkRpNFUvYWZDalRXMTVYRjlyY01UR3UxS2F3NkN4c1ZtOFJE?=
 =?utf-8?B?eXlNVW9rRTFQQzJyUHpNeDFmVXhwYkFJWHg2eVlmUDFNcFB4SG9LeE5QRTF4?=
 =?utf-8?B?U09senpJdHlITCt5WXpoQ2d1TXhjNXNQVzhva3F4bnY3U3V6L2VxbERqZ0Z0?=
 =?utf-8?B?c0xoSEpLVmR0TUNGcGZZMk40NDNWazBIWmtpTjlXMWdMRU1wOUVQbXZXcGhE?=
 =?utf-8?B?anEvaVVBY2JKN2xSVFY4ajA2OTdFclo1TGtkOW9zOWwyVXRyclAxTjVLTTJD?=
 =?utf-8?B?RXpNR203ZXcrNkdMc3BJRFh5a0VlYnU5K1YvclJXbTR4clJkL01xUEFlTU1z?=
 =?utf-8?B?SmpPQndCbEZIem5FbUZOcHl5YnpQcDNGWXdPVWVJdTVzOFEwalpJbTVma250?=
 =?utf-8?B?MWpBR0kzb1BLTXNJNTJyUHRHclZBUFBsaDhrVGhRWHN6WDZlR2xCWXVUcnow?=
 =?utf-8?B?WnJUVkoyWnhnUmpvWEYxMk5YOHZBdGM3c3FZQ1p4VVY3YmpXNWpwenMzNlJn?=
 =?utf-8?B?Y0psSTR4RHlLNjYyTVFnZE5SajlReHQyKzJRRk9KVkM4MkxJM0M4QUNLejFY?=
 =?utf-8?B?MTlEZXZVNXA4VEdWbncydzVTTytKTFNLM1I1TmRMS0lzd0wrZmoxQUJNamZD?=
 =?utf-8?B?Yis4R1JZN1pZSkhpdlgrTWpmL3o4YzI2ZVRIbXRtLzNyc3BhNGR2OW15SCt3?=
 =?utf-8?B?Q3hvZE1DeG5RUDhzd1FvdE81c09OZlpHK2JXaWR2cWt2cHhtSEpmRFNTZDRh?=
 =?utf-8?B?QXFtSjVaNzlHaEdjT0lWOVRDblFhMXdNeFBBUnBHdHM3WUpKT1B5cXQzendW?=
 =?utf-8?B?ZVMzakhlZ0NJVWlZOEpRelo3dUJzY1hzY1dPTUFUNitiMjdnUUVPTDFCSUZB?=
 =?utf-8?B?QlNUZytTRWdWQnhVcXl2cjIrVE1naDgzdEp0K1UzRmNRRHBlS29mdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27577103-d9fd-4c1c-a2ef-08da24fa177e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 07:22:58.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrtd+BBJjwuRof95At2oIt2wq3hnKq0As7Y5wtaDbK59I/dfaIKPdriqyn+oNgNIkEBX9nBKWKkJLd1MWRXiCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3928
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/7/2022 11:06 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, Feb 05, 2022 at 09:51:43PM +0530, Vidya Sagar wrote:
>> Tegra234 PCIe rootports don't generate MSI interrupts for PME and AER
>> events. Since PCIe spec (Ref: r4.0 sec 7.7.1.2 and 7.7.2.2) doesn't support
>> using a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root
>> ports service drivers registering their respective ISRs with MSI interrupt
>> and to let only INTx be used for all events.
> 
> s/rootports/root ports/ to match other usage here.
> 
> This argument matches that in 8c7e96d3fe75 ("PCI: Disable MSI for
> Tegra root ports") [1], but that's not quite what sec 7.7.1.2 and
> 7.7.2.2 say.  Those sections talk about what happens when both MSI and
> MSI-X are disabled:
> 
>    If MSI and MSI-X are both disabled, the Function requests servicing
>    using INTx interrupts (if supported).
> 
> but they don't say anything about what happens when MSI or MSI-X is
> *enabled*.
> 
> I think a better citation is PCIe r6.0, sec 6.1.4.3, which says:
> 
>    While enabled for MSI or MSI-X operation, a Function is prohibited
>    from using INTx interrupts (if implemented) to request service (MSI,
>    MSI-X, and INTx are mutually exclusive).
> 
> Can you please update the comment in the code and this commit log to
> cite PCIe r6.0, sec 6.1.4.3 instead, and to clarify that these Tegra
> devices always use INTx for PME and AER, even when MSI/MSI-X is
> enabled?

Sure. I would fix this in the next patch set.

> 
> Why do these Tegra quirks use DECLARE_PCI_FIXUP_CLASS_EARLY() instead
> of just DECLARE_PCI_FIXUP_EARLY()?  quirk_al_msi_disable() uses the
> _CLASS version because the same Device ID is used for non-Root Port
> devices.  Is the same true here, or could these use
> DECLARE_PCI_FIXUP_EARLY()?

Tegra's PCIe controllers are also dual mode controllers and MSI works 
just fine when they operate in the endpoint mode configuration.

> 
> There are many quirks that disable MSI, and they're a mixture of EARLY
> and FINAL.  They should probably all be the same.
> 
> [1] https://git.kernel.org/linus/8c7e96d3fe75
> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/quirks.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index d2dd6a6cda60..3ac5c45e61a1 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2747,6 +2747,15 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
>>   DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
>>                              PCI_CLASS_BRIDGE_PCI, 8,
>>                              pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229a,
>> +                           PCI_CLASS_BRIDGE_PCI, 8,
>> +                           pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229c,
>> +                           PCI_CLASS_BRIDGE_PCI, 8,
>> +                           pci_quirk_nvidia_tegra_disable_rp_msi);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x229e,
>> +                           PCI_CLASS_BRIDGE_PCI, 8,
>> +                           pci_quirk_nvidia_tegra_disable_rp_msi);
>>
>>   /*
>>    * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
>> --
>> 2.17.1
>>
