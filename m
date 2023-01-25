Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD6A67B855
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 18:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjAYRWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 12:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjAYRWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 12:22:21 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14C166CE;
        Wed, 25 Jan 2023 09:22:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG4cbGTotQZtMmHzLerMt8rNdhHYjLAGC/73+W76jIifwi294Nu4AOGnBrTyMTJfodqZaWXfqesIE8S132rm9YLDoiyulh4D+m2QMvSrMNAfpxs0+suikFFbZfYkOphwyahtHLgswyCxMu8yQcjG799wykB6tCyWZt86Jr/I57QvSdi1+p29vI1EFTn4uOHbfeczvp/zzkbI5wTaxg9jM7RxSkC4Arno+STb83WfGaRJa71VRRLVr5bv6XFlRo/9YKHDu55v/JexJT0bK4iuJe71kU7jeWWJ8JdYv7xZpTQJpb7yYwv87uIkywfli5cWtLtpbSh+ZON19Pe3A6v8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VE4woQ1XUyZpVXIB5cM6OYd9qQlHfbitrkjo2oNKNQ=;
 b=EpMJlEK5n+3Ll42FuhzLzWUSqT6II5Ny+JNivqxBnIFEIUwoDCP8uqADOksPyHvZB0IOzBfJbDiADsHTYwx8D2W+NFnQL9C9BZ9jTVRiArsezAiK7SbzrxG86suXhYcqMsFUehy1fRBsg95lWMgCPx/BHofJncKYmlap6LOAX5FdhSUJoUKBT7TZI38tGoXd2IK18oa468REeZhnTDbLBIOVVDtyTH2XKRNUpueGejba9TjJwJw1KlTPU+XDM9BRFVoITclZzZl8zrdjJw8tkcXowR9GroPIancB37VzEJqznAspJUbqQB3y6sRFwM4YwyRkTEyOk/djAqATfnzXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VE4woQ1XUyZpVXIB5cM6OYd9qQlHfbitrkjo2oNKNQ=;
 b=LdLdM+xn7b4gzSZTMrDIV8r2ZVpFE63pHgMAqhJoPQju0XV1PPA2X5Yj/LQv4HFNrIZk+6IdbARh2tIci3ekQAO8MnuTEzmSsZ8yca+yoZlWDP9oW3HG2h5pQNln9VUcl4KFGxuTx1YMLDB7Wi6EI+E71dFEaaWyQfCJy/WrbvglzfCR61kx3CbxhYfyqdUxDe3JMDMAJFpqnm6jCS9SvSxtSNiuiLYojo3tgc6OG0uYgtenFMYCS8VVzTWBS9/dEmrljJLNKIOlF+t8tz7tfkL7/kDLR2s+LG2fUGwfjTK43oripPYplujRDsluHazAk6BiDdAhSj1Xa43X+t5zrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Wed, 25 Jan
 2023 17:22:17 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::8ae8:c68e:57a9:6dae]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::8ae8:c68e:57a9:6dae%3]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 17:22:17 +0000
Message-ID: <8cf4c8fa-db6a-7814-04d5-921958949f42@nvidia.com>
Date:   Wed, 25 Jan 2023 22:52:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM
 configuration
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        kai.heng.feng@canonical.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230125133830.20620-1-vidyas@nvidia.com>
 <5be13f9b-fc19-28ee-3ed5-8b85f85ca7e8@intel.com>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <5be13f9b-fc19-28ee-3ed5-8b85f85ca7e8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 92192152-885c-40fc-9f40-08dafef8b49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8Jp1UqEfefcVKwSiP4Jh6LcuXIu9OZ27ak+N1WhlMoIuhzqPg7illpFxL5der4/vyCkq5Bx6YHu4S7RTNcqXWp058x3o2eF0KDISk+l8dtjESDPDjcn096RZMNWfIOtERjyZmcNDSdqphL8ssfdFRemGPyRG26/BkTHitytQWeIXon9CXNJ3quPApT1Uv7g2wJG7nVg0QD/Xjz5m++ZdlRCUnGM7IfIfcKBEoBHxJaA4+eLA1qnQwqtqh8rziYB0oEfxpxmOjnWSXhTRosrvFs3ADB911CXb4k6kvXAVo2qzNPV1s3LutLgtQxOTBBpteV0K9paAjqzMnwO6M5JV1kv2YxuVDiiBI+sS1FpactdYk8dhuosLjUCs05/72NFtyDnAo6UVeaOHd9o5q5MAm6nH1Lot8tnq4gAAQi0YbxN2o+jCZeO1VIYBt6h4ELPhYoSmPWHjMxzt7uP1mh9ek031dPeeqocjraJkpT3OthJX2AnP3aLi1+l8OwnKzbx0fPXMoRMGz+pKs0FVIIj+cYOcbWUQ/nSLNMkxAcnVYd6JhLCLGbN9FIxrCRCtSWSnZ53JzMy4aTeC8Dzyp6VxTwHvu2OvJ/DQatyuusBKx4nmmjmuvsnty/xt9ylzRVZCX4xVIrHq6muMuBdaUiwDrcBtGk6uUZ90sY9XtjhkO1p8YMX03xcy80a2wrHuGIJQ34k69ODKxiBSnssUuKJGABzmD2xRCWOz/ZOkzeHPOG1wcrI0qNQLXQ5iFcZd7DL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199018)(5660300002)(8936002)(478600001)(2906002)(66476007)(66946007)(66556008)(4326008)(8676002)(41300700001)(31686004)(15650500001)(6486002)(6666004)(6506007)(186003)(53546011)(26005)(6512007)(2616005)(83380400001)(38100700002)(316002)(36756003)(31696002)(86362001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlqK2NYMVRJQnlFOVd3YldVN1gxUFk2dnN4a0Y4THlPTC8wRDAweEJmZzYw?=
 =?utf-8?B?RXErWkhpWkVTK0NveFMzZjdXMnluMDRsOS9WVHR5SHV5N1g4UmM0cjVFMStP?=
 =?utf-8?B?Nk5CWlQ5dkRmcVI2bndPbDc2citHczlFd211a09hQ3k0ZkRFZWRzbTFmNUlx?=
 =?utf-8?B?Skt0bk51NkE2cUVockFxWDE4TU1ja1YxNXJVSHFSVUJFRmMvbi9vNDhoODhH?=
 =?utf-8?B?WjhnVzZqOGozcVRiUDhER0VFVy9OY0xuQlVrenBLNkQwZHZKNjBjTUdPSE55?=
 =?utf-8?B?WXczMEI0RGo1eHU5cjhoV3BSSGdyQjlBeWFqTU4vTStMKythMTVLNXB1eVV1?=
 =?utf-8?B?VDFxTDNjczdyS0dzRlZqZmkwS1RoVWtBMWJzQTNFdC9lM0ZGUVFMem9YclVK?=
 =?utf-8?B?Szlmbko4b2RMV3p0K1NnWEk4akJKMjNTV0JKbHlSWVdUbUJQTFJHMmVJWUsv?=
 =?utf-8?B?MzZRc24zUENFVnlFb3kxRGFJUHJEL21pUmJzK0JPa2s1QWhub0tHZTY0RUxo?=
 =?utf-8?B?ZlN1NXhORmdWTmJ4WlQzYTlWRUxmdXhRY09heHFlMmVaZkU3dUU0RDlpY0pz?=
 =?utf-8?B?MnJKd2hKMXV0QjRPSzBJT2dTaUNYamRTb3BwZ0NCRTRQNEtxZDlweHZuaDJw?=
 =?utf-8?B?aGdmUTREMUtuUWRnQU9xa1BiZzh3dElNaERnSVNyUjdsdkNxTkI4aE5ldXQv?=
 =?utf-8?B?NFVkME11WWZsZ0VML3FIaVE0djh5b0dCQ1ZtOTU1TEtaekM4RUlZYVBBNHpp?=
 =?utf-8?B?My8vUE1uQi9OTk1YVFBMSHl6UnJPK1NVditvek9ZN0FGWnRxc212cWlOeUNi?=
 =?utf-8?B?bjhnUVBRUzVMU0NhNWVXUVRDcjkwNVVKaU1tbmJ5dGtVTTdpRkg2d2NaNjhk?=
 =?utf-8?B?bVhYMnlNZ2VUd25aY2xPYllMZ1ZKSmxuQjM2SzRLeEdscUpWNWdFaDJteERm?=
 =?utf-8?B?VW1zSVA0MkNmdWJtL0hBd1N2dnFNVmdNM0czaXowSXkwTWlMK01TNVMrdHZK?=
 =?utf-8?B?Nm81Z05DU1p5d0JSSi9UdUw2YkJXTjFTUmJocDJRNUlvTXBJbW5CdlJYNUoy?=
 =?utf-8?B?UHdsWC9vTUNic1JUeHM0TDNKVUxGem1HZXJjNm80OXlaeWZLb0JwL3ltYW9N?=
 =?utf-8?B?UlRibk1MeUlHaitFQktmcEIrZXc3VkZXbWMyQkZsK0toQ1R1dXdBZGVMS3NU?=
 =?utf-8?B?WXRMT0JhcFlWZjV4QUd0QjI4SHJsVStwYlY5Lzg2blgwVmxOam51SnRiRWla?=
 =?utf-8?B?dDFYa1B5aWM3OGtTcmlqaEdwMVdlWExGWm42QUEybHUreXdYTzFNbzJQL2tT?=
 =?utf-8?B?ZXVpUGd1ZUk3S29hOUxUVGxwS21LUTUyRmpXMEV6NXk0ZnNpYVpLcWk2ZHJM?=
 =?utf-8?B?aGdDU0U4V0JFdW8zL1Z5enlDMzArS3RZR2dFN2M1Ri9UZzhML0JBRFBpZFBC?=
 =?utf-8?B?WjRualhXeW1oUGJSYytRS1ZIRDlPRm5STHRNU1VpY2E0QzR5ak9PRlM2ZmV0?=
 =?utf-8?B?WGtCQUo2TUp0N3BkOVdpS3lRNW5iV090a1FrTGxhRi9xRHo1MEt5WU1mMEdC?=
 =?utf-8?B?SEZ5TTNXN3ZMcFBQOUQzcHA1Wk1nS3pRY2U4Z3J0L0x4aDFMM0lRMll3WHlu?=
 =?utf-8?B?TzFzcUhnSXZtanQycXljc3pvWmpCYU50TDYxNGZjUmU1UkVpUGdZbytqOHJ2?=
 =?utf-8?B?b1R1c0dBZE94bmpMWERySHRWRGJsTkxSTmNiam1ua213S1cvMDdhUnA1TnVL?=
 =?utf-8?B?VjNXQTh6a3V1cDBTNEhyeEd5eU0wR1haMmlJWHo0T1ZOWDB0NjA1WmI2OGlr?=
 =?utf-8?B?RjRFVXZoYmdhMUJvWjZxVDl0S1lOZERmWXNvTkQ4bE5KOGl3UjRreHBUQk5H?=
 =?utf-8?B?TFNXWmRYdmxTWEpIeUtEcVFiN0NwVkVMZlY2MXVKUGxLVHRWOGppKzM5V3pw?=
 =?utf-8?B?dXJSbzZNeTNHSVZiM1Z4VzV1WVFwV1ZoWkFLSmh0VjBKUVNIdDJZUnVKM2RR?=
 =?utf-8?B?d1BOMldUaU40THErZndyZVZlaGhqa3l2dFNldmVUdzN0dHg4YU55ZDY0YzdS?=
 =?utf-8?B?Q05WSUppYiswRVd3eXdZeVRHejVWM3FYWlpnRmUyQ0FiWnZjb3BKTlc5RHFK?=
 =?utf-8?Q?PHImA8M6ZPWkK59QMLh6GIl2+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92192152-885c-40fc-9f40-08dafef8b49b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:22:17.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FetnDJhpLU10uDPa7uODWVFc5kKT21v0apg7Ujv/d/yZst/UXQyksiqO8ZCWaKNyDQZBVJ3csJdLeoOCl8Oxmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/25/2023 8:31 PM, Wysocki, Rafael J wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 1/25/2023 2:38 PM, Vidya Sagar wrote:
>> Many PCIe device drivers save the configuration state of their respective
>> devices during probe and restore the same when their 'slot_reset' hook
>> is called through PCIe Error Recovery System.
>> If the system has a change in ASPM policy after the driver's probe is
>> called and before error event occurred, 'slot_reset' hook restores the
>> PCIe configuration state to what it was at the time of probe but not with
>> what it was just before the occurrence of the error event.
>> This effectively leads to a mismatch in the ASPM configuration between
>> the device and its upstream parent device.
>> This patch addresses that issue by updating the saved configuration state
>> of the device with the latest info whenever there is a change w.r.t ASPM
>> policy.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
> If it is a bug fix (which I think it is), a Fixes tag should be present
> here.

It is kind of a bug fix but I couldn't pin point to any particular 
commit that would have introduced it.

> 
> If the reporter's names are known, Reported-by tags should be present
> here too.

I was experimenting with the error handling code and happen to find this.

> 
> If anyone except for you has tested this patch, a Tested-by tag should
> be present here.

Only I tested this patch for now. It would be great if more verification 
is done on this patch.

Thanks,
Vidya Sagar

> 
>> ---
>>   drivers/pci/pci.h       |  4 ++++
>>   drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 9ed3b5550043..f4a91d4fe96d 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -566,12 +566,16 @@ bool pcie_wait_for_link(struct pci_dev *pdev, 
>> bool active);
>>   void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>> +void pci_save_aspm_state(struct pci_dev *dev);
>> +void pci_restore_aspm_state(struct pci_dev *dev);
>>   void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>   void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>   #else
>>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>   static inline void pcie_aspm_powersave_config_link(struct pci_dev 
>> *pdev) { }
>> +static inline void pci_save_aspm_state(struct pci_dev *dev) { }
>> +static inline void pci_restore_aspm_state(struct pci_dev *dev) { }
>>   static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>   static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>   #endif
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 53a1fa306e1e..f25e0440d36b 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -151,6 +151,7 @@ static void pcie_set_clkpm_nocheck(struct 
>> pcie_link_state *link, int enable)
>>                                                  
>> PCI_EXP_LNKCTL_CLKREQ_EN,
>>                                                  val);
>>       link->clkpm_enabled = !!enable;
>> +     pci_save_aspm_state(child);
>>   }
>>
>>   static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>> @@ -757,6 +758,39 @@ static void pcie_config_aspm_l1ss(struct 
>> pcie_link_state *link, u32 state)
>>                               PCI_L1SS_CTL1_L1SS_MASK, val);
>>   }
>>
>> +void pci_save_aspm_state(struct pci_dev *dev)
>> +{
>> +     int i = 0;
>> +     struct pci_cap_saved_state *save_state;
>> +     u16 *cap;
>> +
>> +     if (!pci_is_pcie(dev))
>> +             return;
>> +
>> +     save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>> +     if (!save_state)
>> +             return;
>> +
>> +     cap = (u16 *)&save_state->cap.data[0];
>> +     i++;
>> +     pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
>> +}
>> +
>> +void pci_restore_aspm_state(struct pci_dev *dev)
>> +{
>> +     int i = 0;
>> +     struct pci_cap_saved_state *save_state;
>> +     u16 *cap;
>> +
>> +     save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>> +     if (!save_state)
>> +             return;
>> +
>> +     cap = (u16 *)&save_state->cap.data[0];
>> +     i++;
>> +     pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
>> +}
>> +
>>   void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>   {
>>       struct pci_cap_saved_state *save_state;
>> @@ -849,6 +883,12 @@ static void pcie_config_aspm_link(struct 
>> pcie_link_state *link, u32 state)
>>               pcie_config_aspm_dev(parent, upstream);
>>
>>       link->aspm_enabled = state;
>> +
>> +     /* Update latest ASPM configuration in saved context */
>> +     pci_save_aspm_state(link->downstream);
>> +     pci_save_aspm_l1ss_state(link->downstream);
>> +     pci_save_aspm_state(parent);
>> +     pci_save_aspm_l1ss_state(parent);
>>   }
>>
>>   static void pcie_config_aspm_path(struct pcie_link_state *link)
