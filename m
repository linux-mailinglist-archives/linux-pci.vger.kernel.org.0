Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AE68F297
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBHPyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 10:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjBHPyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 10:54:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0E04B768;
        Wed,  8 Feb 2023 07:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkMoGwhKWE1tC60tSedm6dsXHupTe2CbrZKLoB6qkU9OCg4x6rGYve9iR7heY0w9pN5QnFvUeUIGPI2EwQ7ki4daZxkRBXNNtCoB4SY+iVPMMW3x/1g06UvpJvRp5bXgyG6iqBgYueslS14U3OmsU0RBuFf5KXpY43r8HgeH7YQBzuUIvEvthVXYL75/RcMT6xKmq+5CRkQ8eHlyIc5KmlzXCYB9joMSxNC9HNt0hpVrsJ5c0OcmBkxpp4ATfz3ye/iUOXiEmtZZx3Ly0Pr6EcMsxNYl0gU8GQLWva0qUz8bM1VumzHe5X4FQTarnoU7UAgucq+V8lo6Duic0I2vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsmADMksPAAWlT9eVPE6J7QkTqnpLGbrrUep06WhpfQ=;
 b=ne7Phd1BJm1qhCx5OeTUUvDEZsYe6yJy/LRi+uJnhPLeg+NQnH/4/Gz9/P5Xa/0F5CmtQ0+RV+9Sn6jloVJULsFBc8d2CbpaB1hLFNbHjE/VTspUBfj3i+/F9wFjV8ApAioiQ99hXf7ESU7aJ4KsbFu+2EohvvcjBLAYV1GF3rFSGPQ3pdjmltnOVXw2/C8+pxg9EjLcxRlhIgb+PSLVt66O02EjugCAyFmC0KO4Hw8EmN7bS1zuU/vp9gX0WMDmGcdmA9vvIAbsNrWRTH2cWlzgtwyJFrZSQc0C8AzMuy7P8bzQvB9bWPFjFHG3hvWKP8/hfEVQClYYS/zrXmvCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsmADMksPAAWlT9eVPE6J7QkTqnpLGbrrUep06WhpfQ=;
 b=Z9xdYSQBED7R/wqUWoukNvKFcw7Oux7Dh9yKDnGIgAA0vdamUmP8kLLrJ0gfXq9+pqn+15vOHZvmSdbXurKaGJCEIHyC4bDsYpp23jI67X+m7aGw6Cv7OqCUWLGbNS4RCbQDb0aQNg9jGF+F6WuHVNHa2dIIpmfrMQ2AFwghTPDRhEtJjpF+77qRSH3vPOTzhRp/eC+rMZvKVXocM3DhCp5cRmRjma1jqk2m7ml5sG5Qkso85cfLQiUmahHfpb4kgjNRXNKwRErrDWKTZCsXc+4zM9lR2KC9WJ3zKD8442aFMD8h/m4i/tfDO62Vh41jC6amkEeFBX9GOivLdj+eJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 15:54:18 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d%6]) with mapi id 15.20.6043.028; Wed, 8 Feb 2023
 15:54:18 +0000
Message-ID: <b2b91240-95fe-145d-502c-d52225497a34@nvidia.com>
Date:   Wed, 8 Feb 2023 21:24:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC,v14 1/5] dt-bindings: PCI: Add definition of PCIe WAKE# irq
 and PCI irq
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-2-mmaddireddy@nvidia.com>
 <CAL_JsqJtx+AMFC6SRUEVEgLbiWqv=Ov2cN=oqofZhqvtd1c8vQ@mail.gmail.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <CAL_JsqJtx+AMFC6SRUEVEgLbiWqv=Ov2cN=oqofZhqvtd1c8vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|BL0PR12MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6810b8b6-7db2-4072-ed0e-08db09ecbc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mh76e0oRHuKWdrfAOBIA/R9e8Oih0rq1yBiId3w9R1QWEHFJ9J7y9NppivDo5ajooujRqKB22v2lNyvikkR1c+HPCzeuQSLBXMuQbv2g1Ta7cKEJWC5Be6bAZNd1is0wR3GfPgifMCQY15CO6/Yoq9v897ILS+jlusBsmoWsefeCLWoc2hTP6PTN5nzYuWZ3J2GhoDQeXq/7HDaMACq5Qxggs6q9ub01xzo8rxGF6yugtc/2n0FeUuA3nQN9zncoVquGF9p0gga+E6VetxX8qrvW2oo2LsulC9OlXDhYXnHQY5S85x7grNbCKTcik2eYvKNUeRcEKMhD0H0QiZNBo9Np4RYpDJjU/A5hDgNaNU3cKiv6coDXXaJxREoyJ7DS8JmrQ4pVtyjUiSUD12yVbq2H/v7Q8zyjkw6QD/2aY6ZnspT2qywM3NgcJf6mqpjBQ/TgG37vd/5A2I7oiieey9R+bLigqel+RitnDZMx+8z7I86iBLCCG1pxDqvwuko5mLyICFt/kIFxaVUQMPXyhXOk/SzNcXD+BoXt7UzrH//aLFZupwRUoo+rYca6xRuAKVhvu6Is3zaf6GpHs/f51tOZZiKuQ5MChHAwKizBCn2TrGaGgchdZ1XwWuxWEYsQEYqldZCkot36OmTFsu/ny3x/lj+uvl+gDZrGLSkQ3TUjoIN+RzybDi7Agkjy+uO2ty/jJl9jQ73v+76X6uKF05hbCVo8GjS7vIvHXwebTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(31686004)(36756003)(5660300002)(2906002)(7416002)(186003)(31696002)(26005)(6506007)(53546011)(6512007)(8936002)(6666004)(66556008)(41300700001)(107886003)(478600001)(316002)(6486002)(86362001)(38100700002)(2616005)(4326008)(66946007)(6916009)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZiYTltUVp0cnJJWFhSNmMvMlE1Tk8zVlo2eWZWTVJ0Zi9aWjIwMVJNd0pK?=
 =?utf-8?B?VVRYcGZuNW84VGgwSEMwZUNMRXJNQnArTHh6c3FIZUNmY0FrMGJmOEtSR0tK?=
 =?utf-8?B?WVVVZXY4VDdTTXBhZlVLWUl4ZXNPcFdTcjRwRENubVpVMHBOVWplZ2ljd2d2?=
 =?utf-8?B?ZjZ0ZmtVV2NiU2VFcUxsbVl6YUhCT2NoN2VIV3RwMXlqMW53L2xTNENyMWpz?=
 =?utf-8?B?RWdFRjVXaUIzdTArRHNUTklYNkpxSlFrRitMbTAvREozQi85M3l0czRxdWJE?=
 =?utf-8?B?RWo1aG9kNXpmaDZBdkRJVmJuWHRpRWhHUVg5SFVrVWJsT3huaTMwNWhIcjZY?=
 =?utf-8?B?M1FhYUx1V3pXcHlqdzdhWEEwcUkyK3NucFNBQllRUWxJMVo2NGw4cTB1ZGRz?=
 =?utf-8?B?K1RUK3JLc2w5Vnl3VzFXSktvS0wyWnhQUDc2YmhBSU9KMStUNUZ1OU5HVk1J?=
 =?utf-8?B?ZlFtOUl5NEdPbFdQNi8xVDVzZ2R2S1l2eG04ZEdYR09TaDRxaGtWeW5wVldI?=
 =?utf-8?B?REZ4aWJweFZZMUc2S05GL21VT1BmRWNqQVpPWVRDZEU0TVQvcnI1Y1l5eGFi?=
 =?utf-8?B?eDhVWWUvV1dZbTZ1bmZWRlAyTXJJUzhrN01MRkRGUDFrMmRDMUZBVU12Rzdy?=
 =?utf-8?B?b0VtYWpsdkNWeEJOOFVRQkNXbjFQbFhrT2oxYkt4WjlrMS9tTFhJVVRCOGVw?=
 =?utf-8?B?blZuVHJObFV3V3ZsREhiNmxZa0Z3ZTFYRW9TdGFPc0RaZnlqNGd6TW44L2dJ?=
 =?utf-8?B?VXc5T0Z1ZENWeG9DcGhEZVlnR251aWVJSmcyUUw0Q3plYTMrSng0SzhJYWs0?=
 =?utf-8?B?MnRUZHdZRnZaWTdURkR5WnRQZUU1cDU4bnk4dnp0V2xmWXVEVnN0Qk8vRlQr?=
 =?utf-8?B?UGE5ZkVTOU9jdmNpT2xwQ1E3cThlcmtTSUx4WUJSd1V3MmZwdUlUb2ozUmgr?=
 =?utf-8?B?NDdaNVArbFpNSWs1bHY1RVBUZUh4QktFQ1daYkVVYnoxNDBPMXBlQTlQTlNq?=
 =?utf-8?B?VTR4WVhORHBwRE9vT24vV29WOXRLckcrT001eTRacGx4ZEo1M3lHdUFRZWtl?=
 =?utf-8?B?TjNuV1FFRVk0ZmNacnFJbG96L0RuRzZpbmFVTXAyeCtkNEJQMlhkYVZsbU04?=
 =?utf-8?B?WVVpU1pzeFVFQkFKbWpZa1RQQVpUMlh3K05BYmNlb3JqOTY0SVlEc2tGckxh?=
 =?utf-8?B?am9KY0tUeWYwb0NINWhWT2dERTFQUlh4V0p6QUlZVlg2Z1JvR1FrbTJ5ZmVx?=
 =?utf-8?B?cm8vUCt5dWNpQ2FRbzZNWmIwU1NVRzNSYTdkMjJpNjhrNFI4OUk2WWJZcWtF?=
 =?utf-8?B?Q3VYdVV1V1V2QzBNb2dDeThLMmQ2cklaQ3ZONU9NdTZNek0rZ0dIQnNUaGd1?=
 =?utf-8?B?K2EyTWpHOThXdHZzK2tVUUFnaWtJczAwcXdHeEQwUjBGZ1R6ZGFCNm4zRFZi?=
 =?utf-8?B?RUlNd2VSS1hrNFViR2R2a3l4VXVkbklFTGNSVDNiWFYyRi9YKzJPcDhsVC9N?=
 =?utf-8?B?d3l0L0V3dE9NL0FHU1BrMmVqcmJXQ3E5R0ttMFNEcS9WbW53RFVqTVhod1VW?=
 =?utf-8?B?WGNINENTekgzeVBnOUt0ckFkY1hWQkNlQW1kVExMdjEwLzFsYzgzdVluWUlD?=
 =?utf-8?B?clZqYkNoT2htYjAxeDVjTytRYlQzQmlKUUYweW13UUZCaktrZ3ZFYWRaV3Bi?=
 =?utf-8?B?bElHa1BaS1lDclY4VkhDNzZkRENySVR4bmxlRWk5K1FVMWZZbVpEYlg1VGFR?=
 =?utf-8?B?ZnpXY3FOd1MzNTlrS2lDTFRaL1F5NUdxOHJCTTRUQzJOL045aS9saHNJbnVl?=
 =?utf-8?B?RFBGRHBRUkdIVVVjNDZOOG5mYTVabUdoRS9uR2dmN0dja3Vrb2FncGk5dE0y?=
 =?utf-8?B?ZXV2OWo2Y0Z3ZHZyWE5ZU0lUYUlPQXdaSTlPZ2lhOFRMTmxuUnhxWlkzNitU?=
 =?utf-8?B?aFk4VmNjMUVUQ1dOWTBac3psOFNhRk1sVEJGTVJQRjcyOEVlVDVySkFhZVZi?=
 =?utf-8?B?VWdpWjQzZmlrTFRGNSsrKzdlWkpoNWp5QWt3YVAwMVBlaXF0Rzk3VStkamRt?=
 =?utf-8?B?dlJoa3BROEhDandpQktZcEJObDEwSnYraFg5Y0MxVlcwYmE4WUlaL0s4QWIy?=
 =?utf-8?B?aUFpZXpweldra01TaHIvM0xZN2kwVWZKNDBnRU9VQkViSGRLcGZUL0JoMk1i?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6810b8b6-7db2-4072-ed0e-08db09ecbc2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 15:54:18.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmbRgfCR9LS6lSyfKwgzfpG39Js0xxvdszawfocl6prATqXIXKneX4GWsv7IlyhUlnMJT1JuXDAAnAQiUfBg7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/8/2023 7:23 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Feb 8, 2023 at 5:17 AM Manikanta Maddireddy
> <mmaddireddy@nvidia.com> wrote:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> Add device tree support to pass PCIe WAKE# pin information to PCI core
>> driver. To support PCIe WAKE# and PCI irqs, add definition of the optional
>> properties "interrupts" and "interrupt-names". These properties should be
>> defined by the PCIe port to which wake capable Endpoint is connected,
>> so the definition is added under "PCI-PCI Bridge properties" section.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> I did? 5 years ago it seems. Times change and evolve. Don't add to
> pci.txt. This must be a schema now. PCI schema lives in dtschema.
>
> Rob
I will prepare new patch in dtschema and send in next version.

Manikanta
