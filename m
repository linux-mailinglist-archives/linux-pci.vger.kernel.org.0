Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E768EE9F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBHMN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 07:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHMNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 07:13:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8751E5F9;
        Wed,  8 Feb 2023 04:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZXwCHI/Wr6ZTcReJqd4l/GIehfnlTL+aFC6+Tx0lF2XEG7v87O2CBxS/zVeduMArUYv/1rxEDkY2RhpLSh18gbagptS8eSTNvUrcw87oAIlmqdVkcXColMsXg+tjapoZhRe/GeEsqyHiVaxA7Hxw7stx3tuY3Ji8vINCC7NB9fN3Tg8Hnrx9CslBraMcXbz7lQeB9Q11fy/1b2PAfjt7ORhDql1Sy20iojuBVlT1++DOsROrjmlvMhMSWktcXsTAvsUQzk7rGQe8dW3nYaWzvMxdxH2o6X2CGaeX+iVXtoteMHeYWNz00GHAs1d8tYWTD0MT9PddcbM0zKt93p6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHA8uxWQKr2OrZ4bjHgyM4htrvQSVjfM+6eQYcQFXRU=;
 b=E6ArfcnoL6lOYfFOXpWX/ZffPSQDATXvlFnwmV3Ib2M0ViLuWGWFv4Xpr31MOP/k/Nh3DNkicew7rlyzuVTfLkHe9a4B42WW/XAx7VzGALf0G6thVmOA2+AY6fd55YDNEA6ZohOkxG7aNdlIvNx4LssK2RA+A1GVz7GJ4sTpeYZ7JNFAU5x1KxqMj/MKu4ImT6JAUAWFXgu/QAIhBJA4wzuy6HaOvZ2GWdXrQ7lX7l3+qtmQ1vQbagGxXAF4N8EmyQoJyj3W+XrVvWCmfETiAKnlkCmJyNr7n/SdTwCjh1ZMXcubEcuT/0a9pGIGdAD5DBqRUIVGgpnAT74vxAlrcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHA8uxWQKr2OrZ4bjHgyM4htrvQSVjfM+6eQYcQFXRU=;
 b=JukBozX4+fJWletmVFSqeRxif7Xmb5vW5YZE0OHJc6zxhmthHHyofGdDOZjB+WWL+XDp/hbznM/GSP1Cpoe56j70mCoGGsrCubT3enS/WeeGq4C+XcIi/n1WiHKbNNMgNw1/OB/SHiOg5JGhj0jSPb3gtMmaJTCl//4XLmPXq+Y9m9QRMBiEX68CXY88iLgORznLzWaZbhRplhyPJ7dFH3uDfjsSrx5hU7aL5jNjYFJy0hxam+fHzMikvFSOIR2Od1/TpLcb9SuJrRlc6bKGRlqnmYCIFwexiehcQbJsz4fF+oSJ9Ux3eWPDKmqBKkC6OyLc92rUL4JX1b++mCEENg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 12:13:51 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d%6]) with mapi id 15.20.6043.028; Wed, 8 Feb 2023
 12:13:51 +0000
Message-ID: <1b24e9f5-539a-dd0f-6485-5dbf3757ef27@nvidia.com>
Date:   Wed, 8 Feb 2023 17:43:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com> <Y+OJaGY6mcxM0JOF@orome>
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <Y+OJaGY6mcxM0JOF@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: d11609d4-5319-43db-0e94-08db09cdf0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yd9LdJsfHYTuCVJYBzyUYmVRXbVo7/p3fIYRKB/3PcLH3jN65/Xd2yuTWEJ8vbOukHQB2Zfi26P0lP987q7y6q5Xelv69JyJ2A3Q5oxm/0vsgkoAlptDWfZgvMxDw3jmwEd4mGLs30sGvSKyZh2WMNiSArRV1IAcFf7q2tVxAHA3EckOtjhP10hlv3TQ84oRdnT71PbsRTCJ3UdUOsNNgGlxDYtSGafx1DquA5FHphjFuzVOvi1I9lWlWGTNsIqoP/PqJDaUtzxUfAhnSxRiM9YX1/1Hz4v3CVq/ZX8cweVvzclQwIz3gin75/KV37IFHWyAydYcuwvokLbPMWyZIe1p1lcijFniHypel/fYeT7AGypyFql0b+454c+RbiZvZ16xDqtMD7mLQgWBJtlO7TNkkE89L7i/wckOdT3nLyJKOrVljU2dHu9OVzB6lvSdlQMublORtq1bYW3wuX5ZBVmuMWgz7LwiydBm0aridOx39MAB9yBHPOroAsSpohXx+qGkdVOweJMqmhh+s+WY325k7z/C2CzcZi+55IF7dnT3oc7fUeiuadzdnqChlAzkx7Us+FXKGwNtjcUfW0LN3dPZmr01g5L6cRGoiHg6A9yqhL0UHJK1VQP/SQ/EYMaUcRJxv1XX+d22WOgmsKFgnZcUs20F19Oxp/NQpcgT9EPnUH9SKneCw5KBGZXOcHzjvv2tNdNwGXZcJfLu1KAqvwvQaqwAJXjI3zfl0pWJhRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199018)(6486002)(186003)(26005)(6512007)(5660300002)(7416002)(31696002)(8936002)(107886003)(6666004)(4326008)(316002)(66946007)(66556008)(8676002)(6916009)(41300700001)(6506007)(53546011)(66476007)(2906002)(83380400001)(478600001)(86362001)(36756003)(2616005)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3N1WUVwMGNjcWcyZVdMUDhxblFxdzZsTUN4VnRGWkdEWEdWVm9weTA4eDND?=
 =?utf-8?B?UEdpcjJFbjZUOWZtKzBrak94QStWdVpOYlE0ajhiSUtrWjBJOHM2RG8wbWhJ?=
 =?utf-8?B?MitiVXJ3K0NVZVRyQXA5dmNtdjlBTDJxTFBVdTFpQVZTZmNZV3J1ckFUVWpT?=
 =?utf-8?B?SEtUWkxETUlHYklHTzdJT1ZuNWVsTlJMYi9YSnI1dE1HZ1Nkc29uRDZ3bkYx?=
 =?utf-8?B?NXpsRHlUd3diK2VDY0tHVEJPeDFOUjArOG43V1dNQlFDN2dSbzNrRy93bG9l?=
 =?utf-8?B?L2pJQVNsYzdhQktGZk1GQk42U2Fwclp0WjJmQ2NldjVWRVFtMHNlY05DT25p?=
 =?utf-8?B?QzFneVFwVEc2NVhydlE1NGdkaExmOVFlb1Izb3RPalFyRXVOUVNoMkY0Nm1h?=
 =?utf-8?B?VWdRcituUEVVakUxY2FKa0V6NUVFcUlDUVo3WCtTWWo2SkphS1F2dTdlVEVl?=
 =?utf-8?B?RHJVZ1BEeHRWUHR5MmUxajlCeU5iYXRGT2srV1R2alFvSTdITWJvYjg5SXNP?=
 =?utf-8?B?MFRFWXg0Y2VPOTNRV0NOaStycVh1allpaVhoOUZTZ3ZXTmEweXZ3MlhiVlNZ?=
 =?utf-8?B?T3NIdEhySktoSjkyUm5HUHBWdW9KZlBiL1M0aCtOWXkrRDEwekxQQXdqNVFm?=
 =?utf-8?B?QmYyM3lRNWFMeHNicHdpN2k5b1dOTmprRVd2T25QZElsd2pydlptcWJlU2gy?=
 =?utf-8?B?dFRMK2grUC9Lckt0MS9MSWRjL3FTaWRFSWpnbFdUeElvL0RpZ2dDeG54ODI0?=
 =?utf-8?B?a2NiV0NTWnFjbkRJdHJibkNnZnlycDFGZkRFOUF4MndEcytmaEFQYlVaclFo?=
 =?utf-8?B?RmVLWGZZczVpM2pyblZmNE84QWVZeWU2S3dHM3RJZDFwZnBwc3RXME5lNllR?=
 =?utf-8?B?RVJRZWJHTGV5TGN0UGVtYXJHZ0lvTVhWbkVXRGZaaTVmTWdUVGh2LzQ3M3Fl?=
 =?utf-8?B?MElpbnZUMHNReGJoWDNtZU5vYkovYWZBbUs5dU5saElHdFBKTWRDRG1MM2Fv?=
 =?utf-8?B?RDRPd2Ria3RyazdpQU9GZFNSSFd1NDNaSVg0a2czQlVwbXZqNS9kY0wxcjRl?=
 =?utf-8?B?MUVMcmpHeDZsUUN1cCtZSFc0SzcrcWNIeVZra1RzYXA0WDBBQUxyZU1Pd0Zr?=
 =?utf-8?B?dWZOM3hoTlBVZVF4a1llZHIyaUsyMUJuUTdWQUUrMlV4L3Z4dUhBS1ZsYTBZ?=
 =?utf-8?B?bEUzU0NlYVUzWFA2am5XQjE2TEUrNjVMS3dmZTkyYVN5TUQxOTMwbjVldWFO?=
 =?utf-8?B?WU1sK3pLbmNuZWo5VWxwaUl2VjJsSTBFeW9kZXlWU0dxN0Uyb3VMak4xL3FX?=
 =?utf-8?B?R214WkhZVVZRbzNSWU9Za1AyeDV4Z1FQMGRsVEFLSHhEWjlqUSt3bjQrbytL?=
 =?utf-8?B?L1BUcWpOUWhYV0hpTmgwb3AyU2doTzJ1NWtUcm1vUm5NVnlhdVI3SXlnZmds?=
 =?utf-8?B?cTVubjUySkFSYy9EVkI1bEsrSlk3QTI5Wkp5WEFZVlVTMG5mQXpSTnNZM1Vp?=
 =?utf-8?B?Z3Evd3hMMTQ1M3ZKZ05vd2ZnTjE0MlBVaVZtTUExVVR5QndGVlRDT1gvNVhn?=
 =?utf-8?B?WVlFR2tYaytMTHZnTWxFeklFVTF2KzNOZzlFYXAyVnZuTVU2ODY2K0QrWUFZ?=
 =?utf-8?B?SUsyV2hObGJ1dUJEQW5Bb3ZtVjM1TkJaUTUxaitMb080ZWREdHJ6bUZFaktL?=
 =?utf-8?B?eDZPcXVtQnpWQlFwWk5Hd1duekI5U29ocG9La0pIREhlUFR6anEzMFNvNkVW?=
 =?utf-8?B?TnYzNkIwVi81QWNOenpDQ3h0QjNTenVoTkFHZjZvZDA0d2dJZzZKaDkrcElY?=
 =?utf-8?B?UG9rVlh3a1ZkaVFxalhaMWpPT0g0cnBKOGd0eWdWZUNzN095d0xPL25UdmZL?=
 =?utf-8?B?SzBTTnVmV1Z6eS9DakRmdG5XUWg4a0lod0FkQlUzY2J4UGpjMnVENnlLNGdW?=
 =?utf-8?B?TGlHVVNwSlNuYktocTQrc0NtNGFRYS8zSXZkMDJOWjU2bGR3dzBXYXBEdVNS?=
 =?utf-8?B?TklYekluSUU5b1hSWDJ2N3VvQURwWlhOcTJFc0R2bllYZWpmcGZJU3cwaVB1?=
 =?utf-8?B?OXQrbkxLK0c4ZDdPZnZPZ21qNzl4Q1MvS3orRWhJSnQveTlidnowZVhJd0pK?=
 =?utf-8?B?NEFNOWFuNkREZDBnODN5NTE3bUVWSnU1cTF5VTlnam9ydzlMWXQvZWRQaHNm?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11609d4-5319-43db-0e94-08db09cdf0ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:13:51.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CRwJ4WvOeAxbEIzKg9NxNVrI5d8kM3dsk1iE+12Iki6x11Z7ySGSJ0ZViCXu5LiWEjdXFl3nYLc6qPZyHYMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/8/2023 5:07 PM, Thierry Reding wrote:
> On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
>> Add PCIe port node under the PCIe controller-1 device tree node to support
>> PCIe WAKE# interrupt for WiFi.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>
>> Changes in v14:
>> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
>>
>>   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> index 8a9747855d6b..9c89be263141 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> @@ -2147,6 +2147,17 @@ pcie@14100000 {
>>   
>>   			phys = <&p2u_hsio_3>;
>>   			phy-names = "p2u-0";
>> +
>> +			pci@0,0 {
>> +				reg = <0x0000 0 0 0 0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				ranges;
>> +
>> +				interrupt-parent = <&gpio>;
>> +				interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
>> +				interrupt-names = "wakeup";
>> +			};
> Don't we need to wire this to the PMC interrupt controller and the wake
> event corresponding to the L2 GPIO? Otherwise none of the wake logic in
> PMC will get invoked.
>
> Thierry
PCIe wake is gpio based not pmc, only wake support is provided by PMC 
controller.
I verified this patch and able to wake up Tegra from suspend.
Petlozu, correct me if my understanding is wrong.


Manikanta
