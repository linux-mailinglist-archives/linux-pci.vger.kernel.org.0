Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0450CB90
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiDWPO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiDWPO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:14:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E91D48E7;
        Sat, 23 Apr 2022 08:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiRJ3WPYFkToh2aqbqYWxhiUjJHS5ncO3OWZpLdswLg7QojD6J9soUP/KIeEEIakBdfyaFCKILm3h9ICXCvGLX9aVOk/o7l7Vk0KE3oGZnIHttsn2PJbs5wBZEF4oCzxrP+6JoElB2kEtxkRrsCERbmWt+S7iI4TiY8eSRXBxEnYNVVLBtgMet4thy99U2RzvipVJ4WMFVIKgbvhG/g8JGTuastPg4fnzdSo0PM2OlqKyAhq+jnyqVSXnc9020ulwj2T3AApkvspn3fo2xB4rZY9Vg6uKPo+sHgFfS2DVA7e+8UA+IGfR7tYivLoTvK2EAV+2CAovKht7pA2s3n9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjm2kv8OjSC3rIvc4Xzxt3MjjwYEjDPfroBJ6aJY1Tc=;
 b=LnNQay3qSWBwizz/nvWOSBKg7bUxeh9yyO+UkR4QIVAzJLYcAHfT/iOousSr26hwd1Y5F6vkv6dRkCs1MxqO8iohT+RNpl1CcYe1Hz/iV+hnbbWhkLioVy0OcmozjmTOeKqrLluhFU6OqYqPmgztZVXdi+BzeBz94NEus0PlRsRCO/oHSNUh9PywQYpjk2336lxDOOmH8F45936JOvVnWztz+s9jnDddK6HDVjdBJB0VgU7Oz7KZskrt+VWggLryoyAKi+cYZUlwdNyNTjAralWWFpw5UdJAzfBOrc1ySFc66nkUfMIm3USKINZU3Cz+M4VbkX5WTQZzjXS+EwWHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjm2kv8OjSC3rIvc4Xzxt3MjjwYEjDPfroBJ6aJY1Tc=;
 b=QMrA0Fc466wXbmSkDFGbwyFp4sMq6PNBsWI1f1XNw0vO9CX/Vl3gfL/NL7MFFrJ5k+seWcB+1qJVVEiyXWo6PJQASjc1h1CEwL0hoDXCgMHnuYQtTPFpfkZ40AIG6j6V+YBAmV0W/tWtDb0CGi9rAvuOYLZtmnjJ8DSXK/MgMaSOmrAFsCieKRxWPil87ary0VWYdAewzcHkShZ3V5VaJ23qZgKN75dRGqI+qf6FxP/NlOpPgQntFz1Tkk+COFvkgg/RTqg2vCxsZXTCmzSH5NvIRVTBJhcKjWGj7JrsFHRqc48Rw1m7xAUeSSRLpXUlObl2AovUQHAriXQ2ftoG7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sat, 23 Apr
 2022 15:11:56 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425%6]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 15:11:56 +0000
Message-ID: <26c0caf1-4cfc-9c7d-ac51-180ba4501bf5@nvidia.com>
Date:   Sat, 23 Apr 2022 20:41:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 2/8] dt-bindings: PCI: tegra: Add device tree support
 for Tegra234
Content-Language: en-US
To:     Raul Tambre <raul@tambre.ee>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com, krzk@kernel.org,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220423124858.25946-1-vidyas@nvidia.com>
 <20220423124858.25946-3-vidyas@nvidia.com>
 <50b80804-e95c-2137-5d74-2451e5bb826f@tambre.ee>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <50b80804-e95c-2137-5d74-2451e5bb826f@tambre.ee>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::34) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b04b1e0b-906d-449f-1bb2-08da253b9b30
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB530504941B536CAB95BE9894B8F69@BN9PR12MB5305.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2AMMXZX1AJFoE9/XkozZm/IdKjw2SrSrVLuSDZVwHBc4KkeB1EtaP/fcimG06hGHSLqkLRQ7CBSt/i4ihw8Z+CwgoFTUAHKETSMqflmXsAsMbY+blIHc+aseduwheA9HhX63W2F09hm15ARuzVZybU0McL+yq/RVw46/KEmswwWWbXhTmWW/wjyDZmZEa33/zheAad3L6WbHTML+8X/1Y5EwLyj5K1nbtiOs86HdcoYF6mQKMAHxWO3qIeH/iAYig/q5dAhq4S1S3tI6nrMzrY8y/IGZ9aROUiAzTKgfDlbIe2Y3T7EzvWKHsamAfb4k4jCqzvxnbs0yVTlrx6JnnUI4aptBs3km8Eeve10cpnbvSKmv5wB5Uxli/5tmMcJxeIaSp0m+jL5ImR8dCKyCsm2rpOOSZCSJGRSjBbGuXieIILS9Bv9MlDYhSURyMJ3l7XUledW1T2p0G2A4nNRvg4DwIkRj/QU7bvz80LtRTmYI2L+LP0zlzyDSWBe9gjCuuF/0oVGMDkBdf5BWjLdyWxiJBpSuGT7rgZIqKm3x8iHMcf0BNyMt7MH9MXFoq8Rqhldu1vwxeg2rPEnB7YHgGPn7IZsMn1I3tptxv8w70Lu3PJXK5Xfq2UDEjdlrD+8mWrKj//1Btx+1NCLSDVitxEdCVT9JQ5MvmFJCY8KkwrTRgOEvQm5a7YjHqYHvqdO5eH3rvGKrQT5ag+ntnP10dg49lgTMsiYwOGE0w6lIMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2616005)(6506007)(6512007)(26005)(6666004)(6486002)(508600001)(38100700002)(31696002)(186003)(86362001)(6636002)(4744005)(2906002)(8936002)(5660300002)(7416002)(36756003)(66476007)(8676002)(4326008)(66556008)(66946007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVkvRjFjQWRVV0NNdjVPZm9ReXBNVGtaNFBPQk42R0Y0WnVzTG4vLzhDWWEy?=
 =?utf-8?B?MUNFaEtvL0x2cEtIellRdE9zc1VON1E1MVRJUHhxcWpOUmhzbWpWdlZEaXBn?=
 =?utf-8?B?MUh0VGUwSlFhOEhoSmZuejR6Q2ZQa1MzK2xwL092Y0tMemU5bk11Y3U3K0E4?=
 =?utf-8?B?TmhHT3F0UitLcVoyS1MzNVJJTzZsUlg0Q01QSWIzeWw5bDFWWTQ0UDI2OUJq?=
 =?utf-8?B?K1BYbFVESXVqL0V5dkY5aTNacGxsb1hlNE43NWdiRGVUYzd3b0Y4WUhlYzBZ?=
 =?utf-8?B?OTdnblczZTlWakR3SXVmWHZhM21qMjFjL2ZIeHpKWmtmSi9POENNU3BKR0VD?=
 =?utf-8?B?OFR3WkdIVnArTlM4dkx5TWN6aHdrSEk4bExWTHo2cU1rMHNjbGVwQWljNTg1?=
 =?utf-8?B?dlhjY3BhQklyTmpQRjJRUFRuV2pReTdDUTRDODhCOTZyUlhQKy9rblZGcnVR?=
 =?utf-8?B?MnY1R0ZYOElRcWhqamY2elduOVg0emZDVlVPS3MvRjh6Znd1SUpxRjVGRENK?=
 =?utf-8?B?d0QrK1lLbjdIY0RKYTUyTDRmRVlnR0RGQU5PZGQrbmI3MGp0YlZETmxuU0h4?=
 =?utf-8?B?UE1oUmdVeC9UM1ZaT0JWZkdjRkRMaFdTb2c2eFJzbGowQ2JhZytSZGUzMW1j?=
 =?utf-8?B?RnBuMWF3YnVlUGdWdk1XOWtOMlp4Z1VQTFpkUzZ5OUhmc0R0NnJDTFVoZGZU?=
 =?utf-8?B?Q2tVYzlROUxnQktZSW50OUNRWHJCTlUwYUNoanlEeEM5VGR0SWFraTNncFZQ?=
 =?utf-8?B?VmFtMVNRUHhObklkanlXNUx5WmZJc3BWL3h1Vk40RTlsS0l5aVVzNXNtU21N?=
 =?utf-8?B?di84Ui9iWmVKeDdDK005VEZXV21rcTBRNmwvNnVqcUVRYytxYytuSStlcWJy?=
 =?utf-8?B?L2VGZUZja1pteUhwTXNjajZYYUxJa09aSjNlWU1VV2pnTUVnamNJaFk2VWsw?=
 =?utf-8?B?R3hEODJ6MWxzakhXS2sybzNaTDdGR3F6QTNLUXBpVDdqZzR3M3ZEeDE1dlk1?=
 =?utf-8?B?Qkh1bTlnb3hNOW1mYlZBSTl1WkhuckpGRExNbFdsRjI2eURMUERpc293THR5?=
 =?utf-8?B?emRHRkRUOGF5aUVKY1VGU1ZqYkpWd000dzhtQ0NJbjczVlFWcEJuZTlmYWxq?=
 =?utf-8?B?cUhrNGlZK09ZaXJXQnlrK0NnZ1lnajgrbU5jYTEyVUdzbHEzTzJmWWdEUEJn?=
 =?utf-8?B?dEZnM3d4Zk9GRHh4ZmN0TWduNy94OVpmN2o2UWs3T3FYT01ZM1hneHpqMHY3?=
 =?utf-8?B?T3ZEdUYvL29kZU50aFltT0VnWURCT0p5LzJqRjVJcTBkSE5JTnl6ZmdUL09F?=
 =?utf-8?B?YTg2YjNPOEdjMW5FaEFpcEVUMEZ0bFVSMkM5VXgyVHM5NDNpSkpRN2Ntdkp1?=
 =?utf-8?B?UlQyZzdFUlRpSDQ1cXVnK2d4TWJkalpKSHRTcWcwMjBwQXlGaytoTlBwdVJI?=
 =?utf-8?B?Z1V0RDloOTNBMFcvZGFDSjRKN0hmeXI1NjRHb3ltd25lNmVhRENDYVpRNmUz?=
 =?utf-8?B?VlhaOHdseVFzT2lWZUphZVgxcUtFQTJqd3VlVDRGOXE1QWg5aENRWWowRHZj?=
 =?utf-8?B?V2s5ZUFvamNsckJ6YkVkMldXbGN5ZE81SGRvNE0va3lDeUhYNTdaNmxOS0xE?=
 =?utf-8?B?MExjd3Rnc3NvSmlHQ2JoVXhYcHkySC9yTUdrZmFSWmh6R1AwdjBxcGsyZEN1?=
 =?utf-8?B?TytSK0YxbHZXRW4yTEhQMldHb1ZNS2hBbkE5THpra3BYSmxWZmhTK2NHdkN0?=
 =?utf-8?B?bVR1eWxOUmRnWjBjUENZckhHZFVzMCtuYVNMKzVkV2VsdFc0eGdQd3IxZjh1?=
 =?utf-8?B?bUVzNzFQeHNQTkoyTi95YXo4bGZDdXU2ejBBY3hQVWh5OGVDUnB2MHdqN0kz?=
 =?utf-8?B?Y3pTb3h0RGVObVVoWWJpM1kwbGFDa2VSdlVjYTlHOSsvWWFFMElJQkkvVjBm?=
 =?utf-8?B?ZmgxUFEwdSs3S3Bvak5VZFlkOGM3Tkhqdkt1SDdlL2NYamJKTVhwUS9GNkpC?=
 =?utf-8?B?d21nUXBESzZacCt1OHRSeFRxaUVGVzJQOW03UEZ4eHdVdUtTQi8valUrWm1w?=
 =?utf-8?B?SmVWUHZpMGkvVmFIeStNZGxueWVyZUs4ZUp3TGk4MGx5cXFNeU5OMXkrUytP?=
 =?utf-8?B?OWVxa3Y1Z0FNR0toWVJ5bklHTERnWkd3bnZmQlZ5Y2lQQzVhVGphM1FuMjN3?=
 =?utf-8?B?ckg4SjREUU00R0hkTjFPRENHQXBqV3NuNk9RYUxkeE5MNVF5alNPRDZoNTY4?=
 =?utf-8?B?TjFGRTZnd0FRN3BmSkZvNDJNb2k0T2xUUGdzNk1nZEtkQmducTc3Wmp0Vm5U?=
 =?utf-8?B?SGR0VVZMSEx1MXhvS0NOdUZmWmlPRzd2ckVPN002WmZhS2IzazFmZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04b1e0b-906d-449f-1bb2-08da253b9b30
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 15:11:56.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZI3ZloztobfNGPyvxG4y3k886hYfNB7hULIyjlG3Zmefw13JBrpcpK+SfP8Fgsd6YhqdTRxBsc5zvZHVE0lpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/23/2022 7:57 PM, Raul Tambre wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-04-23 15:48, Vidya Sagar wrote:
>> @@ -47,16 +64,33 @@ Required properties:
>>     "p2u-N": where N ranges from 0 to one less than the total number 
>> of lanes
>>   - nvidia,bpmp: Must contain a pair of phandle to BPMP controller 
>> node followed
>>     by controller-id. Following are the controller ids for each 
>> controller.
>> +  Tegra194:
>> +  ---------
>>       0: C0
>>       1: C1
>>       2: C2
>>       3: C3
>>       4: C4
>>       5: C5
>> +  Tegra194:
> 
> Should this be Tegra234?

Yes.
Oops... How did I miss this? My bad.

> 
>> +  ---------
>> +    0 : C0
>> +    1 : C1
>> +    2 : C2
>> +    3 : C3
>> +    4 : C4
>> +    5 : C5
>> +    6 : C6
>> +    7 : C7
>> +    8 : C8
>> +    9 : C9
>> +    10: C10
> 
