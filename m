Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE35B8B77
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiINPMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINPME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 11:12:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58801EAEE;
        Wed, 14 Sep 2022 08:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e42tDf8+Kn3XL5fkvuSHGU6d5R3e38QMkXGnQSy3Ief0vNDLrMHRcaiIiBTssAIl1CylxzqbRw07/ib3FRLj444pSc9r4X5N2++SYp5wiMRFct236NLVq7ihMzUM+QGlT1fI0JB7q0/Jat3v931uwL/rFARJsaJgOeZLrW0FGYvNHQ/ws8MADFyFtylbIERbgRasmTvryMaJv9k4L8/fyGlegZ5NHqfRqvNQ7mt5RHhy8s9je1iwpz6+xfgSHReohnGccK7zgxfhjC37TOPwVLrhI5qhAtxtdJ1fco+txTHTFkHbzyfNpzAnTWGY7Ht11ClwyPPSoMhX3Yu2VXNoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng8DBgTMr4Eb+qNjXaG466QJycW1z/Ty3FRMID4rL2g=;
 b=hYzBgxRNWx3axoqQmuvgYsgn9OGh2FKWA9x7p1TD6qW7NQi00Sl9LnnPPuKB5nHWksgfFiyxBA5aEpW1NFmJ+Ed5UN5IOLkU9HA1Gv6lrVXUV+VHd2P10cAGfEH5sGCpi/L6FriAAFssfsvxChhbjjjGsyXPQR/+j/GSpE4GU7FhLt7LI8Pp2u9SlzsvsxDoA3VyMmFbb9aZE2g49PwtTl0inMO0VydZ7SDqPCeZ9QuSiv49UO1VZDUgdBEy49HA5oKpDKY5K7C3ZBUR/+Tfs0Nqh/M44aTvBls4e7X5oEOW6AsdVF2H+c4RVNMvdrbTByffMepYhjpVYEDOzBm7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng8DBgTMr4Eb+qNjXaG466QJycW1z/Ty3FRMID4rL2g=;
 b=QH136WcADr9fO4sLGeueqUtNN72LoPsAesbXJijE5AqPXS+Iqa6g3dfFzDzIAHwhv1Mstl9UOaxiWnKChkFEyWcOkkK410E3aC5xtDFyutTdiH4RGOo9VuztgjfzyzNpd9C5EtBWr0o8LFuLaViNMvePUt9pmQ9sLs0zQyXKbOyHjNCUx4JpXrbVmL8SGRNKO+esGnZ0rZycts/uYluQMh0cEa0QWFoRectPEe21OY//T/xTj8KdbLNucD2qXHAxxG2xyj986rkzDUlrKaElAFQ0OLNwvnuVAAQlCWylddzPNv3dJzgLu4G1TNNFjVxpo9uXG4y2Ejo1JcSB64CZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.23; Wed, 14 Sep 2022 15:11:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:11:50 +0000
Message-ID: <55fb64f0-7fe7-7938-9852-0ce389050f09@nvidia.com>
Date:   Wed, 14 Sep 2022 16:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, treding@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
 <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
 <20220914114306.GG16459@workstation> <YyHMvBhWgbDtv6V2@rocinante>
 <20220914134539.GI16459@workstation> <YyHqxGw6ADmJUTEv@rocinante>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <YyHqxGw6ADmJUTEv@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH2PR12MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c013821-5c2f-4eed-2a21-08da96637320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKwB+uQKSESowDQqqGKrLspYxmVlCtN1zncKjvux7acUfROJABxQ2LLMxcwYsDgzFJmf0H9sxMGHt/ObFC2Rfz32W+S+XQDtIwSjsQT9daOwv84YOchKZSMHwv8KFit9aqt07JfuiJmGenjvikHdPM434BtNj98wpnDVIWemlX7hFtVKyQ/8WeQU+DIQllWRl2iC9trm3ElpkMZdlU1+r66qFJfE4YzTR8GX+CklIUeLo+Tnq5P03OVUuONkoWF/w2ZcIyULEr0sCVLuold0oZZnNTS7vib/X4XsYudlbTVNTGCRUWgmx4UoZxsUK0qZc5FMM4nREhcvPLBiHgYwLDFvtkgITa1+WlrITAWkYI//yjFppSUxQ+si9yPT62/kX/GhA512jm60+p30m5f11BuZ0e1dvKOCvuJi6mEGAewP4WB1FrJn/bOSKLjLD8uMkggHkEDZb19YoEqLCeY18sCRD/FK6k52P7pSqr3AyGM91rhTXJrKX8XHZrRKbyA8P32N50cC4W1v0eMbJYgHNi8WOmCq/1x6IMszlV0tj2W9JZwlrukQsCXCQRu91TmuRKZU/IHAxZOELIJlC/yBDcNAsnEezidx+HQ5hz7aUOSj0tTa8MyV3QOSN5so1+Dwyv/tiS+RbC+7/NNG3NKAxxjVoVfQicK50R0O9SJutae0GQx4vU9SVt1OKbPlVm5gNJqPZ6aHM8/EWmm7EyMtcDuJqHf9dzbaIHc2xy99I4VBxthKSzkCccKxWZ3a2eB0um40F3cJfwn8oIoVh2BPq4IVEk8yJaZ8fff9mUEGuqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(6512007)(2616005)(186003)(31686004)(41300700001)(6666004)(38100700002)(66556008)(8676002)(7416002)(4326008)(5660300002)(66946007)(66476007)(8936002)(36756003)(31696002)(86362001)(66574015)(83380400001)(2906002)(110136005)(478600001)(53546011)(6486002)(6506007)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1drWkZILzNoVjdEZ1J4bG5aKzBKNlRKTm0wclNmQ2JKMFVqYVVhbWMrdzVi?=
 =?utf-8?B?enQyZkRvU2pYdWxkTkUwSlNRLy9DRXR5aENLdE9uYko3QUFiaW5tTzE3WUUy?=
 =?utf-8?B?NG4valR5UDBBdElqMnpwZUFzU3NWTmd5WDN3bmJ3MjJ0TW01MHBZWDZSVVMr?=
 =?utf-8?B?ZHVsaE1tYVdGam96R1hSMUhmajk3SzduUWJZT0JqV2NBUlltZ21VSm9RNjFQ?=
 =?utf-8?B?cXRsMk91bWFKWCs0N1VvR0tVaTUweU1aNHdzODUxMnFpdGFIZGh4UzI4RXF5?=
 =?utf-8?B?WWhMSUg1K2M1NFFqSk0rZlNPKzU0UVE4RVRIS2FNRVlxR3R6Ui9udjQvakR3?=
 =?utf-8?B?Snl1VlZpaXNISi9COUQzNldhcDlLMkZ3YkZVbUJEcnh2TFJiWGdiVytnYVlL?=
 =?utf-8?B?UWZ4UVQvNGdHeUpJcGdFQTZOdkcyZzA0dlVjTXNNNm8xOXVrc3B1bWpqeEEy?=
 =?utf-8?B?Qml2Y2VhTXgxQlNLQmlUSWFSSlJ1ZFdUWTNWRUFVNkU5QXd2cWRkWlpXT21T?=
 =?utf-8?B?cnZZcUhoSFhmelFscFpyUW9RMFgzMnpFQzBKUkhXeGFhWE9NazZ6aUtyb0dN?=
 =?utf-8?B?T1RGNWEvSCsrSHdKMStVYlYvUzY4aVdhU3dwVzBJemNxWHF2MjNnb0pIL0d2?=
 =?utf-8?B?ZlpZMFhZaVFNdVRyZnduMlQ4Z3ZxWDNZek5MeUt3THR0UC9NTmdmaG5sK3Zw?=
 =?utf-8?B?QWFUN2pYUGRxc1ArUmh5QXl4VDQ5bTF1T1lTSzFreHZHZzBodnFYUkdqcG1E?=
 =?utf-8?B?ejZBMVRZV0o2NGc1T3VoREpEdTFEbTZUQUZTSWc1NHE4VUczUDVNNzRwUmlo?=
 =?utf-8?B?SzFOeFhpWHJqbjZNVjBoTTlOZlNWOXd2Rk1neFFnMy80YXZxZ2xXbUU2Q0Q0?=
 =?utf-8?B?NEsxbTZVTW9DS3RFOGhuNGNPcmY3VExsb0o5aFU1UzlKZk1QTGFMaG1MOEpN?=
 =?utf-8?B?UERIczMveVY2N0RZR2VDWEtnektuVmJKSEpsY2JNRlFUbEoxbTM5aktYdUg5?=
 =?utf-8?B?eXllVExuWnVoZ0oycWFqN0JPSG4rU1RhUTNSa0w3dDloK0RoUi9TL1JlRTFs?=
 =?utf-8?B?L1ErUTBndS81Q1lsVy9ZVDJkUDZ4c0FVaXRBT1c5alZkaXo4bDVFQWs5dHJF?=
 =?utf-8?B?ZWhmRzlJUWxlYWQxWjNzUHNpQjdqRVZGODJhdlFpSDB0YzQySlZVV1NXTUtQ?=
 =?utf-8?B?WlFiQ2VrTzdEUmdQMmdacFA5ODFicUM2bEgrQS9iT041MS95ck9hQnE0MWlr?=
 =?utf-8?B?cVBjMVp0Z3BRTklTRHZ4Qm9vV3hzRUJobHBuVU5UWUNuVTViYWlwaThnbkRO?=
 =?utf-8?B?eUhmcStPemFNYyt6alV4SHo4MEJKaWEzV0N1TVNxUHdKdjFhdWZERHlQcVhW?=
 =?utf-8?B?b3FkSU9UMXAwQTZKbXpQY04wSHQ5U0lRWnRTYXIrSVBxY2w3QlRQZUdGVENQ?=
 =?utf-8?B?RFQ5NE1RWTdoU05OM3l1cU1GMmhtdFRXWDlZKytxWU5nQTQrbjBOemlXdGs5?=
 =?utf-8?B?WnpaUDNmQlMwVExIQzVWQWtiT3pvTVBvNTRnWHF6dEVSU1hKNHNubzdHQVp0?=
 =?utf-8?B?UHhPa0gzWlE2a0J6c1lDNXMrQ3R2WThLZ05leE5RczVMVG12a3ZlcStSSVJy?=
 =?utf-8?B?NTlrYTdiV2ZCcGpNOE9VdUhWekhPMU9GaEhqTnFhUkJibG5WNmc0M2Y0am9i?=
 =?utf-8?B?Q0JhZlFldzRIWlA4RXVKSGxTOWQ5MW1ZS2M0dUxIdDRzcmRZQ1R3d1ppVURM?=
 =?utf-8?B?SVJoOFdRRVB6UTA4T3FTVXVEdXo2UGNrc2t4SDJ2b3VlYmJMMTRoTjc1Z2Ro?=
 =?utf-8?B?eVBSR1pMYnhYUVhyVExBK3hMQjV4c2FQV0dmVHF6cWlyOVY4RjRlWnBaUVJq?=
 =?utf-8?B?ZnRMd1RkNy8yK1hhbjVZYzJFbnIzMXRvZFpUckNSYXA0dk13M2dYdTF0SCth?=
 =?utf-8?B?Uml1MGhQaG4rajh1UWVpOUVTQ2QvTmdndnhjQmZKZWtPdm1FRVZmWmxHRmhy?=
 =?utf-8?B?cU9zRW81dXpCVVArWEdsV2ZSK0ZFQU00OFM0WTRhVHJqdXdFa2ZsN1RPeGht?=
 =?utf-8?B?L3lpTUtCek9UeVY2SXZsV3V4RDgwL3BSR214dHZUMFdPUmVxTUlIMDhPeS9Y?=
 =?utf-8?B?bS9VSTgzYjlxNWo1NGExMVZHYlJPcDE5V0orVWFWSjg4VlgxY1FyeGlVejgx?=
 =?utf-8?B?MHdVR2pZeldzN29qT0phNVl2TjlQL1czL1lOb0tlL0g1N0JuMnJEdUd3Q05G?=
 =?utf-8?B?a3g3bXEvNDFUdjRwRmNGaklMbGRRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c013821-5c2f-4eed-2a21-08da96637320
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:11:50.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0Dk1ujQ0V7SnGv1tBPJiC3qIpeYIN59tAzdcUkAnsKTumj1W8g2FEZ/sNpvNUWQz1AJ0eeAb0e5NEGRbNE+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 14/09/2022 15:52, Krzysztof Wilczyński wrote:
> Hello,
> 
>>> Perhaps it makes sense to make this a dev_dbg() over dev_info(), especially
>>> since it appears that this information is of more use to the developer (who
>>> most likely has the suitable log level set anyway), and given that there is
>>> no way to reliably detect a presence in a slot on some platforms, this
>>> might otherwise, add to the other messages that normal users don't pay
>>> attention to usually - if this is not to be treated as an error.
>>>
>>
>> No, this is clearly not a debug message. As I quoted above, the link up
>> can fail due to an issue with PHY also. In that case, user has to see
>> the log to debug/report the issue.
> 
> Apologies!  I missed that.  Thank you!
>   
>> So, either dev_info() or dev_err().
> 
> So, there is nothing to do here, then.  This stays as dev_err() as per the
> change from:
> 
>    14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")


I am not sure I agree. There is a similar change here ...

commit 4b16a8227907118e011fb396022da671a52b2272
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Date:   Tue Jun 18 23:32:06 2019 +0530

     PCI: tegra: Change link retry log level to debug

If we have a way to determine if a card/device is connected then dev_err 
is appropriate, but if not then dev_dbg/info are appropriate IMO.

Jon

-- 
nvpublic
