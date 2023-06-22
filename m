Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A87396DD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 07:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjFVFeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 01:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFVFeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 01:34:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960441997
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2023 22:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apgoPS5p6Y+dSC/BuytVo1opnuIkQQTj33m5AtVNErjKwlexNK33Abid/VWuOsvRd7zE8/y7QRD/mufb3mHlLw467QAs7BRpLPyNqzutSDGZkv+Lxqv3RA/A+mZL0I0iIspgDavtrbCe7I3MXoRU2COvp1zB6OYo9YA1Xxj7r4q3c16E+bVkFK7ZdsQlFM4ZKH9r7K0d8tS98O22W9ja8cjjAL6Ds3T3gdSW3zcutmEERvvECCB610mRpYG93k9I40aGXF6IXC3iUlGE3yznE3u6c0fpMN1iSG2hBqDzyvPXyFIwRMDz354XJmvU2WvmkytZdOxc2fFBwOg4DLSQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJexPJO2VXkepU5D2nJFq/yK6iYJPbufbKFfJbeVDjE=;
 b=dYj+DtNL9Jm+QC4yPCDH0fQFfINuDe2tdSF5v9aRHadxDkSfygJcjyY/vnLUsa9DpNUDC4/ULFkk95oqsa7bqQdWN7VaddltoX2LNf9NPRj2mY0Yu+4PaGNVPvwnQRDCnVc9x+YxJ7fcPOYurLXM6iAXNDEYQVBUdMa6/VSKyHd7KJ3bRP5NHGcCyFxObT5su7y6ZpE0/5cgOhCAPweI3n8+I9Efjc5EnEswcduRAr3cmzM6XBJ5hnMeVpFo7yG/FDutDRHUzePGarpE2/gryF1saw26TTeBVrODNRVguRZosrZztvcqFPASMFPlrGOEr1p/1YA3VZErNAwCqQqhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJexPJO2VXkepU5D2nJFq/yK6iYJPbufbKFfJbeVDjE=;
 b=R8zYXA4a6oKRYQM0o/Z+bV1EGbxSk5fageMxxA9q6fLEcKgjImnZfyhvE9Zzh9CVDNbyL/lsi3zm4JJHHaz8dyDKoK+57QAU4jgGYMcWMeshD7Ph7DUrEli9vbT0S/eoldWtxRG7J9asPuf9Yo6qERy45SKEzVg6L7mOqbKJW8GTdEMj8LPFrA+JFQbh0wxvESNYKFgtBwVvA5hqXyT4SDFnfyPyzCmZq4Se14+StrdvBJxFnw1BPUxqEXQ2kiUdFSt3nKN9w7i/aeA01hcG5HN2rAbHO3kJPzgh5DZ/hHDw/WbfFgUMDi2jbbbKzkwONqnumXvE0iea2pEGc55Weg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Thu, 22 Jun
 2023 05:34:14 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::ab42:15f3:c4c0:2a91]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::ab42:15f3:c4c0:2a91%7]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 05:34:14 +0000
Message-ID: <8bde8aa8-d385-aadb-f60b-9a81e7bf165c@nvidia.com>
Date:   Thu, 22 Jun 2023 11:04:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     vsethi@nvidia.com, jbodner@nvidia.com, kthota@nvidia.com
From:   Vidya Sagar <vidyas@nvidia.com>
Subject: Query about setting MaxPayloadSize for the best performance
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::9) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b7c6ac-7c6b-48a0-1e22-08db72e25054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ArBenoMD3owmmqQaRPLDRmsHj0pqd8GOBaLj0TsDKpvhKPbWV/qLDt5YCFwuKwGFBFl6+bi7oVf9WdoUTfR/DJ6XWAWbKNSOE95hSjcoMbqVd8nVJdY/LuE5MRLNpHTey6qGvtA7JrnD/k9hIeA4eg7pBcTfXSnabXvxIlrP7EXVQLXrz1c+Psp8n3KBLqrTP+ZWsouKH11qFARjX1NCuO9wxq0Uq86SoeYc4eznYWiFOlqwQnvi6VAaZKQIw9qZNLs2oEZA+kzYXDQB91TDuBdti+sDTrNyXdqatWR1FGyPRsbzj/j7I8jBi4WicXJvQ9Qxg+UbrrAE9G+frXgY/XfNaQbXT5YCYc/G9lYsvnJf/8Yz9bVLtZBd0Th/thg/gDlerPYwblTnQ8A1NrwNGLaih9KyajxHbUWZpUdIFhp1VQDf6Etw541uDMVJdUc4bNzNLAKpxEs+ZyL3CpV99siNOXzhUL2ZLF7/h6vKj80nZTemxRkvTLfyIVQSK5OszY2ZG3yT+kH+ImUZ/kwoAZFApE4fMfFqci/aA64SF1ofaZb18FzRxvHG5rWuoPPM8keJ8gFYMSTrMCqtQh/wbE/f6GGGQmK0JFjAXW+y9CSx3Ve5U1Ycc+nV9ZFp4HWAOwM4qG6j+XKTpMXJFUTBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(31686004)(66899021)(6486002)(478600001)(6666004)(2616005)(83380400001)(86362001)(31696002)(36756003)(6506007)(66556008)(2906002)(186003)(26005)(107886003)(66946007)(6512007)(38100700002)(316002)(41300700001)(8676002)(4326008)(5660300002)(66476007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ljS0llSVNYNCtHYVNiZWZiUDhwZkRBdVJ1ZUtMVHZCeVNzSkVncjJRTWlw?=
 =?utf-8?B?WFpXZy9aL1ZtemI2T2dRSEhmdkxpOEE3ZFZmUFZXMnBNblQ3dFdYMjE4MFpw?=
 =?utf-8?B?YUtpa21HTDR1VnREN0QyenkyOFJxdHBteDJWbVNEeVdLUHZYK0lwQzFOYVRE?=
 =?utf-8?B?Q0ZtTEpIaVY2a1QyZENGTW5XQnZPYUxqL05KQ3kzOHVqM0pUYk00SFdMeFd4?=
 =?utf-8?B?bkpSdTQxVGZvQTlXNmdBVGdWbVllTlBvUE0zUjN2ZFNRZ20wa21uTzFYTDRv?=
 =?utf-8?B?ckFtRjNkb0NsNjlBU0IrcVJSZk5iazJxdkErRWNSa3YxM002THQzYnFPWUlS?=
 =?utf-8?B?NjMzd2ozcUw5RVY0dEVhcG9wTEpJaFFiQytLTmYvRWsvai95MU9MTy9CdkRC?=
 =?utf-8?B?RHU4L3JjdEdBS0FpY2pZcDZCanpxV2tLd2tmSzV1Uzh3ZWlUc1BESnErZUQr?=
 =?utf-8?B?YzFlM1JFUjRmS04zTmR5N2dRQkM3U0ZXWXhUT1hxQ09Tb1NVQ2c3SDBoTUp4?=
 =?utf-8?B?TVFmTVV3cThYVVluQUZ1VGxNN05QU0xyaWo0VjgvQ090L3lPOWZFbHJvd000?=
 =?utf-8?B?MnZtNmR6dTBJU2RTQ1l5ZHd2OWZZUmJEU1M5UnFJc21NTFU3RWxjWEZQakZQ?=
 =?utf-8?B?TUpDWFlGSkFvWFR2UFlqRGc3TUdVSEdQeW1JOFpLTDBQSmFXMmhyTDU2UlNQ?=
 =?utf-8?B?SElSaGptZ3J1VjZxamxYSVNvWjYzOWR6ZXlZZEtaR3NNc1h4MEs3ZXFCTFF3?=
 =?utf-8?B?RlljUFFzWjdMb3hTeGUxS04wVFpNQ3RRa3NueVdyNzU3UWxKQWVZdkhVRHJS?=
 =?utf-8?B?bi9KTkplR0ZPODhSQzZqVTVSalVtU0ExTlB3YU1uZTQ5TytFbjAxSkgvOXY4?=
 =?utf-8?B?aTN3aHZSZXZWd05mTDFvYzFIOW92bjlncmh4dUpudXN6V29RdGx1ODNiNHV1?=
 =?utf-8?B?bGg4L2U2V2VOMlllRldmS1Awcm5jYTY0QTFRRnRndUd4WTJSVVhqQmpleGhP?=
 =?utf-8?B?S05RRkQrVHNtQmlEbmJrdGFJRm1uN25ueHpTOGd6eHZXcDhJa2tTY3JRNmRQ?=
 =?utf-8?B?NmpXckZQZHlWNFB1empXZEZPZUZ6Ri9hR0ZJY25TdnZsQTEzSklUM0RqQU9Y?=
 =?utf-8?B?QVhQZ24zMitXVm1uTjZ0MDFkRWpTNmxaaVRqVzNRMTFsWDFMOW50MXZsWkRt?=
 =?utf-8?B?Z3JrRFBnNFprZTV5MVhoaHZyekFMblhYQ1hmTzU3Y2liaThLb3dlRVBYaWc4?=
 =?utf-8?B?WDRIcGhlWFhMcHJoemh4MEJjT1NqNnE0c2tIVm9aS1M4Zk5lOWd6YXRZREZ1?=
 =?utf-8?B?QTV4K1NjRmFTZmI3NUsySEtoNng5dVg5REZsd3dnWFM3Z1FJTld5SFV3clRG?=
 =?utf-8?B?WGdXaW9ONnVwOHIzd3ZhZWlGRGpQeXJLalJMdWJRUGlFWUtWaEtiQVQ2V3dD?=
 =?utf-8?B?VFFLc3NDUGxud1pDSUE5c0VGSjFBS0I1WW5weCt0TVJ0R3d5OGp5d0dGUkxD?=
 =?utf-8?B?bzVLTkN3dlRNdC8yNGowWjVJekRqT2dOQ0hjNGhwNDF1RzZ6cGFGZklSU2pP?=
 =?utf-8?B?SkxUNHBVRE5tRmVBNTlkVm1PQmRxT3VJVlNiemJoc3RQZnBpUUhqSU9xTFpF?=
 =?utf-8?B?WExhQitnczM1T2J6alhVSUVldEw4TnlyY2I2cnAzTlVOVjBFSlZ6ZVBmdzYy?=
 =?utf-8?B?TEFiQ3FodmFIT0RxWUUvbjZ5UEc1Qmc2SjN1WEZSU21OdlZCVkxyOTArMkZH?=
 =?utf-8?B?bHBrMHZ2TUZWcGFJMnlGVm8rNDA5MVlONS91UTViOFFkVXpKVFhweXJkODhW?=
 =?utf-8?B?OTBTWWdHMFNORGt5K0xTWlRaZWtqRGtTUU9HSm5hNGt6Yk1QUTJEcmFsVzBp?=
 =?utf-8?B?M0NKODFESURGUWlibmpEWG16RTNoWUZvSFBhSjhNN3MzbGJQU2xFdW90bEdx?=
 =?utf-8?B?MWRmemQ4NWluRVpBRS91LzZYWERCMUdaUDZ5SnpMdE9nS1RpZzBGamplZEVp?=
 =?utf-8?B?QWhDL2tsR0R4OTVaM05MbDFxR1MrWkc4bWo5c0VxU2o1cTV2UjVWWGVqWTZL?=
 =?utf-8?B?MDRFYTl3bElZQmRyR3poSVRXNi9TcVVaMUdtUkREQ2w3a1dubDZWb3MreWNv?=
 =?utf-8?Q?NmUWMHJ8yKd4NvFleb32ZHAsh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b7c6ac-7c6b-48a0-1e22-08db72e25054
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 05:34:14.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPsAV/It0hA6ukhIYk2Fdx3uXPi96lkVAUzUhB+YA4Y5A+QU4N81Zb0njbGEVNuw8VhB01gAj2RZOe83xFTUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi,
This is about configuring the MPS (MaxPayloadSize) in the PCIe hierarchy 
during enumeration. I would like to highlight the dependency on how the 
MPS gets configured in a hierarchy based on the MPS value already 
present in the root port's DevCtl register.

Initial root port's configuration (CASE-A):
     Root port is capable of 128 & 256 MPS, but its MPS is set to "128" 
in its DevCtl register.

Observation:
     CASE-A-1:
         When a device with support for 256MPS is connected directly to 
this root port, only 128MPS is set in its DevCtl register (though both 
root port and endpoint support 256MPS). This results in sub-optimal 
performance.
     CASE-A-2:
         When a device with only support for 128MPS is connected to the 
root port through a PCIe switch (that has support for up to 256MPS), 
entire hierarchy is configured for 128MPS.

Initial root port's configuration (CASE-B):
     Root port is capable of 128 & 256 MPS, but its MPS is set to "256" 
in its DevCtl register.

Observation:
     CASE-B-1:
         When a device with support for 256MPS is connected directly to 
this root port, 256MPS is set in its DevCtl register. This gives the 
expected performance.
     CASE-B-2:
         When a device with only support for 128MPS is connected to the 
root port through a PCIe switch (that has support for upto 256MPS), rest 
of the hierarchy gets configured for 256MPS, but since the endpoint 
behind the switch has support for only 128MPS, functionality of this 
endpoint gets broken.

One solution to address this issue is to leave the DevCtl of RP at 
128MPS and append 'pci=pcie_bus_perf' to the kernel command line. This 
would change both MPS and MRRS (Max Read Request Size) in the hierarchy 
in such a way that the system offers the best performance.

I'm not fully aware of the history of various 'pcie_bus_xxxx' options, 
but, since there is no downside to making 'pcie_bus_perf' as the 
default, I'm wondering why can't we just use 'pcie_bus_perf' itself as 
the default configuration instead of the existing default configuration 
which has the issues mentioned in CASE-A-1 and CASE-B-2.

Thanks,
Vidya Sagar
