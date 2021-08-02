Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F503DDFA1
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhHBSyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 14:54:11 -0400
Received: from mail-mw2nam08on2088.outbound.protection.outlook.com ([40.107.101.88]:55674
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229567AbhHBSyK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 14:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLCoZ1YL15vaEy77hhwK5FNET+jfZ5/t0pPRkeoRe/qDj1axJ6Ap7mO2+IXiuirV8bx7o3/mYoQKC6/MuKe/DZmQjNswXpSqEI36Vak2K3wBfkhM4uzfu6eoaOJirxcx22AlT4v2c3WH5D+Rx2ZlzDhQPTV1g1kRKaBp6x4UZK0yK5kVfcnc1hXAF9Yk4MZ/p7ptgOwKKICasWNrGZGXB+TUdrRZDxFsKrzHupy6J+cxCnd5EkIKCq0/QFq+k/ZYZN66zT1+9/K/iC9ddnYq0O9N/ucrLhgGUYIDjmsraJb+q9jXI+gNqVt9hfLoUlJ9jj20KT9Fjr95pFm3rSNXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z30/GL00JYGoEQzQauEmt2M+gmlz55M6qOBxgISfpnM=;
 b=eJAiM8ggMQT4lJycvzJ6mWoHn8uTGUMWxqURJ7XkrCoYCZh1VCyEOilbQUJ5TkzeixJTX5lHn1/5pTK/8em5jD6EUNsoxvahpkESASr+tyW/hWGPJwJd9SW+c9E88PvDjRn+vjfQEydUPOGVGYuEaCKYhF8h96eRy4GUE9t/DmvhNlOrm4AnOF3gYmy9+StT/Dk+cjb+zldKH1oxOkH6MMUrSGZGNuO90atuO48NqawPAzFXXxZsZfU2TJP/ja7j18A3i9hRTFjidHaoStCisQohaZQvPbIxvDXvxpXS3rj3RdUBOd8Jf9cSjAYO+JduxxeWSclrCik0Bpm3MwvrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z30/GL00JYGoEQzQauEmt2M+gmlz55M6qOBxgISfpnM=;
 b=NAP7TpDUz/NO1kWBqUXoJGnY+K/geOUEEfWsgHTJS9NV1zWNulXb7r3BPnykE8waKiXZ7AAwgWUlBihnYvSJb9HyG6uZx4qe7ITGqmDxnG34m1dcp7SJwtEtedZc4M47Z2o+8YA0tt0/9XRqtrucImyzP3djQ6WavHHEpJravng=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 18:53:58 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 18:53:58 +0000
Subject: Re: [PATCH 3/4] thunderbolt: Fix adapter init handling during switch
 add
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-4-git-send-email-Sanju.Mehta@amd.com>
 <YQgOj7elfCp7l4OO@lahna>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <6da505a4-abad-ab8b-7706-17f83a35ff41@amd.com>
Date:   Tue, 3 Aug 2021 00:23:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQgOj7elfCp7l4OO@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Mon, 2 Aug 2021 18:53:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac82b0aa-352f-47bc-5d22-08d955e6e294
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54629F038283318E3FC2A469E5EF9@DM8PR12MB5462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njnyUiXvsoysBuzDa6088gUQ+0dft302tPaWxqLRFf7aLcAdLns3NbujoBoYA7fLtisnbmdRWui6m/tZH391OPTiEoJO7R5yq93/CzMf2IRgtPQO6sPVj0Zn/AXBP+7Jkv8ZKnmbH7Swvpdi3147MKy+KdLUrgPuGHFlgxkEwwvod71eD/IDLTKkbrwwDMIUqqfJfiA8H0iXRX5kAogrsPYLI47zTX3/5n0L0sqU8DdwQ1jn39fkIqE+G81x848pDHd4PIcS/MVBIsdT1IM4jdOY8HX8BF80VDGKWwJzEEBlg41gGBCl4QJmVY5Af/qhstiuZ9OkDzMYPlDdonFle4DW/CTZTejvM3IaY/Oj7+ZyehO6ZH8HKUvPZSzjdt9cxosG9h2p/znunpchYQDnvZ7tzmSasShcYtrLKkyWNguxGmx0Z1tywgD0tcytpyZSODuVxl2vfi+/FDph4KGudkVeG6y/5wtoXHYtX/IbVsz95IuN7CGgnlO3/E9LOjiXq72lfyqg61ksBq2qCuQQRRvEOxMKNqcpxKxhECbrHGVJEG/Hc/JakyMgAKf9f6ZgaLtHyeAdFbmtWxdeh0UF0lNHduqTPrTeKpPo8eESvhEpVJVLCb5oAJn6Ky2imc/D9imlGB/8/8BhPFJHcWrUeaX8yZLZUPSFpIal2QJ1+DkEATqX1ni+OKDyXDGxvrRAfcneV5VeDAVclMK7f5SH4ppoXj9aYTCdFADeCvin2vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(53546011)(956004)(2616005)(26005)(66946007)(31686004)(478600001)(5660300002)(6666004)(31696002)(16576012)(316002)(2906002)(83380400001)(110136005)(186003)(6636002)(66574015)(8936002)(36756003)(6486002)(8676002)(4326008)(66556008)(38100700002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhjZWgvd2xDU0JCL1Z4b05WL1NVY1Q5blVndFJiVzBraG5ERFNpQ2VBb2o0?=
 =?utf-8?B?RE9TWVRpUnBTK1dTYmR3RmwwUzNOaHBOMGVvZHJHMVFhZDBZR1FMZEFoUFoz?=
 =?utf-8?B?Qk10dUdLbWVYdndNME1zVFVSLzZLYTVCM1ducWRuU1d1NnVsektQcGIyeHVu?=
 =?utf-8?B?RStKN1NvTnlOdXlCWFV4cnlOdm1RUjA1WGtmdEphZCtrSWtnMW1Pb1Z0ZFp5?=
 =?utf-8?B?cE1vWmI3cnRHeWFSTDVSUCtVbm54QmZITXYrSmRNMitzVFVkYis4WVQ4OFd1?=
 =?utf-8?B?bDgzU1JGU09Rd1M2aHZId2RxYTJpY3EwUTNhYTVjbEJVdy9zSlhBQk9FTEFy?=
 =?utf-8?B?dHhUWmhRanc1RUVxTVBCb1J6SGsweTZpL0g2MnFTdmZyQXpWaVdZQ0VVRkl2?=
 =?utf-8?B?TzBjK3N1eUE3UVZQY1ZCeTNIZ2ZEelJ3RUIyWWdiaFFEdzFBcFdDU2lrSHdF?=
 =?utf-8?B?OEJvM0MvTHZ5cnhyQ2lXMng2MEs5WmNJbHZDZy9iTTVlc3lCTERTcnF2N1Rw?=
 =?utf-8?B?Zk9ISHZxamhWdzBqWkQyWVAvVSsxM0RoK29VSit0TjN1MEVuUXlwSUs5Sjdz?=
 =?utf-8?B?czFUUUIrV1RRWnBKOEVVV3hkMVA2SGpJUlhlZ0kyaEUrNUhlNlBrK2dtQjJF?=
 =?utf-8?B?MzQxWXN4cHNpVjZDK2hGNWdqNzVTQUJzVmtua0M1MHIxWFV0N1Q5VTkvTmxQ?=
 =?utf-8?B?UTN5R2liTkRodlV4azZUUlZrMmc2MExtdHdXT1UyRnk5YU80MGlERzdpVlYv?=
 =?utf-8?B?amd6NTRrYU9zNGxxLzFJRTlPWUVhZVM3dTFTcGJIbjkzMTJWcFU2QUtFc0pF?=
 =?utf-8?B?TkFPVjBaYkFQYVduOUhyM2FHUE1VU2lQQlozdDh2WFJUL3NmMzd0QlFBd21v?=
 =?utf-8?B?eStRS2RIeThkdXh6aWhQaldwam8vc08wQTBMdWROcDhJaVVnMytaZHBmQVZs?=
 =?utf-8?B?UFZJSG1JVTAxS0hGWWZhMjY5NUhXU2RveUg0R1dseVRuYzhrZmdHUm41VFlp?=
 =?utf-8?B?WXQ5eHZHVUhPYytwcWJ5L1h6MEhRSVJUbGpkY2lqaGFMWjBkSE9VM25rbjVo?=
 =?utf-8?B?SUdxQzBpcDdIbFN0WXZ4M0RraWZyL3BiUWVsSmdVVnA5ZkVQODdYSWlIUGZv?=
 =?utf-8?B?WWRXemFZSk9IbXNpemdKemQxUWw1cXJBWG1mblJEMlhjM2VaN1VBdVlBM2J4?=
 =?utf-8?B?bjJPWWdDUUtIZEo1ckxRNDdrZFZVWVk1TXdBNUozMW5XVjB1MllCNU5hNFcz?=
 =?utf-8?B?eFdTNS80VUd1azRQZ3VpNktsK3RVbGNRN1psOSthZlROVW55SURGdHpSQncy?=
 =?utf-8?B?RzJXUDRsQlYxVjlZQTdPcXk1VGh2SjkyWG02NE5uN21UcnZPRjA5VTF6eWJz?=
 =?utf-8?B?U2ZxQ240aUJRZGxqUTYzUGd5UXFuR253WWdKbE0wbzFaZzVWMmZrSUtzZnVm?=
 =?utf-8?B?SkV2VTdIZWZteFJjM3FsSkpETWdGZExFZmVrSWp2bHU3dnBCd0p4MndWTGdx?=
 =?utf-8?B?MzlRTGlZOEpsVHVjT09PalM4MXZYNkQ4bTd6enRFc24xUTlUYzljWnR0QjBz?=
 =?utf-8?B?V0hhbWxNd21OelZjQU5oUDRYbUtuYi8wUVVmTGRodjFpQzBmSVBzcXNVeXFU?=
 =?utf-8?B?Y2xXaW5Kc3pNY282UW85U1VqYVV2RnM4S0xmU1VpclUzY3AyaGZZVXBrNlZH?=
 =?utf-8?B?OWpUWjBheDg5aTRVWmM2SUpqRmtPSW80ZTdmT3pQdCtHSnNmVzFENkxUS29F?=
 =?utf-8?Q?UlbLk1jzzXE6OrKvSro9LnQ83liPDMqcnh7/W4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac82b0aa-352f-47bc-5d22-08d955e6e294
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 18:53:58.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJNVa/yh92nbcwVrcZiROTMrAf+F4uGJmBv7QN19Cb46FwvTVyyagWpP6Lu5qw3qucMqg6s4SBFt2/N7CdbOhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/2021 8:56 PM, Mika Westerberg wrote:
> [CAUTION: External Email]
> 
> On Mon, Aug 02, 2021 at 07:58:19AM -0500, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> Adapter0 (Port0) is the control adapter on the AMD USB4 host router.
>> As per USB4 spec in "Section 1.8", Control Adapters do not
>> have an Adapter Configuration Space".
>>
>> The read requests on Adapter0 time's out and driver initialization fails.
>>
>> Hence Disabling the Adapter in case of read-request timeout and continuing
>> the driver init.
>>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
>>  drivers/thunderbolt/switch.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>> index 83b1ef3..effbfe4 100644
>> --- a/drivers/thunderbolt/switch.c
>> +++ b/drivers/thunderbolt/switch.c
>> @@ -2747,8 +2747,9 @@ int tb_switch_add(struct tb_switch *sw)
>>                       }
>>                       ret = tb_init_port(&sw->ports[i]);
>>                       if (ret) {
>> +                             sw->ports[i].disabled = true;
>>                               dev_err(&sw->dev, "failed to initialize port %d\n", i);
>> -                             return ret;
>> +                             continue;
> 
> Instead of this, would it work if we start the loop at 1? In case of the
> control adapter (0) tb_port_init() does not do anything useful anyway
> and it actually would simplify that function too if we get rid of the
> special casing.
> 
Hi Mika,

If we start loop from 1, it will work for host router
but this will skip port (0) on device router which may be valid port.

Yes, as you said, for host router adapter (0) we can skip tb_port_init().

Will send the changes accordingly.

Thanks,
Sanjay

>>                       }
>>               }
>>
>> --
>> 2.7.4
