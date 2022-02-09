Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DD4AFF2D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 22:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiBIV20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 16:28:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiBIV2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 16:28:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75578C03BFF4
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 13:28:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0xQXvNXjz2iH+BBtDSv6b9U7wLOmG8Ii2l3UhZ48auUWI2s6L1cqqb1W5tRrC0Y/zlaZimTxPnkEg9VRo8r/2Ef7yVvZL7TaQk2MVk3Ayc6Ymrq5YY9JWylb61WO1/4X9pYGeecyJk0RVwPIa9hlgBagWWE/oErJ+49FizUQWbp/bvu/ZdCgah+Y9xQBbPzG3bKJFc6f9LEeiyyz72nn66thfJW4DQtEw5tsWrFJvWzL1dCTPIq8ai6ADAJp4KaMsjY4/+rs7YsFHshbzF+a8S/Xenfqpc5/0LPfFSbZrQOMTQZCnyE7Q/CfKQV9l80mOhD/aTKlZ28woU2XtlvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12i2fuTlHTUR5ANQ1XN86pxv+CFWndmCGHki5WMswS0=;
 b=kDpgh8x4P2yQPdahNzui0/Eu2LjejTA0AKZd+9YJupvRIu/2ZVSyvCVTUcHQNHNQJGmWhfhdnSCQBlo6UgY7Ggq8GKlvp61jFz5WKxCGkTrBioFE9V2dh3GSX6E3mX/+ogHg8hap584R+c5NgTULItJ7DTGwX9XQ/ELWspi4ne9OZIFd0EKIlZyYYu/6B56R9GpRQqJvM0YQjVwv2YOLhhMGyCIK5tPAP5yty/5ehxMbYXy2w75h70+uoKgvelxUSoVrDRZwZLC0ySxMy0lEXRupHbooBLos76VZtcgHrI6GoYdSZmEKgQoyeN/qtQNlILCgbapJWj55thdwrvii8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12i2fuTlHTUR5ANQ1XN86pxv+CFWndmCGHki5WMswS0=;
 b=w1nAO4tl+SMJq1Ugnf9vdiwGjqehvU0nfAMZ1uZQboEaONBSihZIEs/LEMQOKfJ7T2oxojlOizeaZ282r+5WoRa6FpFSma1gc3BE9sTo/cVHOe+T36OIHSgle6rSJNbWBPqYBpKP0qsN4p8wUFyzTyOfSGfp0DlXdz6xZ7MyIvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 21:28:24 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 21:28:24 +0000
Message-ID: <ce878dab-c0c4-5bd0-a725-9805a075682d@amd.com>
Date:   Wed, 9 Feb 2022 16:28:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
In-Reply-To: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::47) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e6cde0-df49-4e03-dafc-08d9ec131a6d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5607:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB56073C22FAA41DCAC27A6CDAEA2E9@PH0PR12MB5607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h73iOpttVWp+/mTMN1q0GJ27nYw9jQRKwU+1rKhCpzoKzj59F1w9fudeIthYkZ1mRCYm4UYdZNXA3q+4JvtthDQ2MHCUVk/lnhLNQcO/L9bLCQIZnTghmCJARgBT3PkJIxMNesEGFa3CwehXZybEBD5A15yJ30CsMciziUa5GzAU3J5VwE8ANFKzjpI2QtnC+HsaZHxRIAH43MPAwIcet+PmYgjve4VjBsQzPlm5rbaZMfWpL8py4EmW67xYGmaXrHfmKQNBBPg+LKBzZ041mDLXQb8Qv+EYDXVKSLz5GVfHohJzY7/JkHwKTRxKo/PJQSz3KGZm4oaNqpi9dZFcb8QzSynNuH9vL56TDI6FLuc9/PThPHVwJYhvdbM48NvSJbhvCANqAyf5nb4aPz6QwFX8Pr4GlLK4EevQTJRx/GAWxLdxV4Yu0ORpa0kQBbK7aY6IZBQCIHlXLmA139sslD6488TlAidGvqOv8ruCuV8fpqqzi1c6hoYwBtka3ytW/qLpeSeoRdPZeH44zOzSI0+Lv63naBRyRW99CVvy3jyn3v2DxMMnzLVbPu9N3u8uiFiO4rvKHU3eaUjTkoUQ9ZEn3N5zVOuOIH0LCwbT9/ptvzsVYZyqS1cTmqA+EvHiy3KdKYNAPgtY8IqJKFxMHGEj4zkd3eaFsTUgC15E+jB273kKsVJkVzNfdNq7gxLGjHa29KKx8KCdI76qLTubkVt5ZRCXobNEnu6t9Ezs9oXp5VYG8szdNcuYX+nuPLY1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66476007)(5660300002)(83380400001)(66556008)(31696002)(86362001)(53546011)(186003)(316002)(38100700002)(6486002)(110136005)(6666004)(44832011)(66946007)(2906002)(2616005)(6506007)(6512007)(54906003)(508600001)(31686004)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZIdllDOGxoWDBTOG50M0QrZ21oK3pJQTFsZW9rZjRrTGZqWHdDVXdqYkNY?=
 =?utf-8?B?b2xZZHZSWDhSbzVYNFkwekJnWFpCQXRLOVVvdUU0a3ZGdU11Ri9IR2VEMFZQ?=
 =?utf-8?B?NVJUbnBjZjdidEV0S3FYZ3VGdEVIOUZ4cG8zaGdlbHBGYXFJbnZGQjg1cXVv?=
 =?utf-8?B?b2pLZGlMOU1JMUsxbTU0VTM1ek5XWFhvbUhrdWQ2YllrU1M2MDBucUVjN2dH?=
 =?utf-8?B?L2ZTTEo4dDgxZ2hIMzJzMEZwZkt6K3lsVHUzMStrQ1RydWdYdEZLUlBkbXZv?=
 =?utf-8?B?aFJuNGRocVRmN2xJMXdLTWhlTTJvOFY3MlNHam5Ca0pCV2t4dTMwRmFWdjFk?=
 =?utf-8?B?VWFyekFycFIzQ0JNR3FBOWFhcUk3YmFrTXBUaVpzaTJoNCt6SlZ1OE5CTkFF?=
 =?utf-8?B?cWVDa1gvOGZxaFlNeCtnQk9sZGF0WEYwT1ZzeUJrOXRXOWlGSDU2SW9pOER0?=
 =?utf-8?B?T1FXV00vanF6MlBRaHoxZm9oK01Zb1Y2a1BmRmJEc3I4ZkpFQi9oaGxnWXR4?=
 =?utf-8?B?eUp2NTY4aVcvYW1ZdUs1bGFUNms0NEFIYXdyYlBPTitmT2dUbXRuRWNtWm01?=
 =?utf-8?B?dmI5MTF4eUF3OVpWVEZLSjdiTURiSW8yeDlBNzhiM2VhUHYvaUFFQnZoeStm?=
 =?utf-8?B?cC84dlBYWEFZWUhNNTQ4elowc0xsRjJOVUZzaDliWjZ0ZXpvcTQ2Q3lQN1BI?=
 =?utf-8?B?dUZ0RG1iSUlqbjg2UFROT0tGOFhleE9jWGU4bkV4NFhjMjVkYTR4MTkvRzVj?=
 =?utf-8?B?SWk2ajJjalhvK0NQNlhKVUVuc213aGVYUmRDdDdwSEJ2cS83NEJzWVp0M2R2?=
 =?utf-8?B?Ty9YbllaS2Z1OFREczdkU0o1SmFIU0wzbUVZV1RGblRSRlRQOGV6Rk9SMTRB?=
 =?utf-8?B?STFUbEtMZi9iTC8xWUtpVE5ld3h5Zy9VYmdWNERhWEdDMGdlVE9TYnZwdE5V?=
 =?utf-8?B?Z05jU0trUXFhbjBDQlE1TWFqL2hJanZkVDVRRkZvbS9sRFd5cCtRNmxhVUFU?=
 =?utf-8?B?cXBPNDR5eGEreXJVbEpBdzlITzVPc2FXRFBOSW82bC9vMFBScGNCK1pkZFY5?=
 =?utf-8?B?N3lvbjV2ZytPdVN1cFJpTkRQaW9PTitZTEpKcmp1MmNZMVZNNXFCUk00YUdT?=
 =?utf-8?B?d3VHNjNhV3o1UEZtcUY3Q2EwTmNvQUZjTUUxd0cwZFowY1dYTEJUM2NMSlRh?=
 =?utf-8?B?Nm9DOHUydE9qak9oSCtkQU4rWmwrM1NKazJWQjBod3NrNUdBSmllYmhzaXlK?=
 =?utf-8?B?bVliSlZ2VkZqMGtzUVR1NmI4cENUMjRaRVlFQklaWklOakkxMHVSOE45MWZY?=
 =?utf-8?B?dmJDTTIzaWJZYzhQdEh3K093RERYaUkvNG1CamNGZStDekFwZ08vbGkwbWN6?=
 =?utf-8?B?VzFCb21vYm01bkxidzZTbFZDSkU5Nll0dDlyblZ3VVpndTRJblRLNlJpY3Zi?=
 =?utf-8?B?a2ltTFJFNWcrVXRKT0VlZU13VXJCUy8wZXRVcFVLZWJkaGdueVhqOWhEM0xW?=
 =?utf-8?B?SytrRCtocFhBL05TTDA4YWhpM1FkU1krRVVwRE9wSDZUVTRhWXRJYmI0WGVh?=
 =?utf-8?B?WjZ4M2I4RENtbGhDMVVwYmVFTHNWeUszancxUkZodzEycldXbkFnSFU1aCsz?=
 =?utf-8?B?b2FmZVo1eE1Gb2N4VVZoQStqNU1YY1BuSWVSQlhWTHAvNmtLMG9naVEzMmZi?=
 =?utf-8?B?LytxUFRoQWlLb1owU1VTOStBTHVaTkc4M1NtN05Sb0ZiVEEwcXQ3WE15OFo3?=
 =?utf-8?B?REVVSVpHQWdic3Nic1IyQUxidHlxUDhjUEVoZVdUaW9wSEtnMHBZV3lscnVp?=
 =?utf-8?B?Y2RreW43M1ozeTcxMnh5dFZtb2Y2VzhNcTJGUUpuVCtKVW8zNy9yS1VjSG5V?=
 =?utf-8?B?UXJaSGpoZ3Y4ekFXcElOWlprK2thV01iVEdjUnIzeFVKR1EzUFJhZDV0YWd6?=
 =?utf-8?B?Y0oraWNkaDY2YWZ1YVFGbm5iUGI5d0hLVXdCc1RBVG8yb05ndTJrNjBkb01z?=
 =?utf-8?B?bFREVkJ5UnlpYmJpS3Z0cnlGbUtleCtaQzQvSkN2NkIrcmtDbmM3M0RmSzVw?=
 =?utf-8?B?aksrYk5tWFlCUDl2TnZYU3RXTUF5ajkwRHVhalpyT21UVEFkQTVzYmJmN2dw?=
 =?utf-8?B?TEcwWXl5SUx6dWdUTjVCTUxpUURzYStUUEVNLys3UHBXYUl2akdJTnJtT0E2?=
 =?utf-8?B?bmUwTkwrY3FaOFdxeEw0dTBZczhzTytVbkJCVFVqUlJsanUwN2lQTUI3a2FL?=
 =?utf-8?Q?+W5UAe//PxtgysNU3++QcLbmOq0XuP7kWjqJoL8Veo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e6cde0-df49-4e03-dafc-08d9ec131a6d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 21:28:24.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI9lO7me+sWEQrdGi1PiSdWHND/RcVMSZ7ZJ+pPkkN4u0uMnd2q6yv4EV4X2P2Bb4SNH6N64Br38GmfteZiKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I got a bounce back 'Message too long (>100000 chars)' reply so
reseeding with minimal essential log inline here

[   56.138636] ACPI: Waking up from system sleep state S3
[   56.140541] pcieport 0000:01:00.0: Refused to change power state, 
currently in D3
[   56.143542] pcieport 0000:02:00.0: Refused to change power state, 
currently in D3
[   56.146517] amdgpu 0000:03:00.0: Refused to change power state, 
currently in D3
[   56.209416] pcieport 0000:00:01.1: AER: Multiple Uncorrected (Fatal) 
error received: 0000:00:01.0
[   56.209438] pcieport 0000:00:01.1: AER: PCIe Bus Error: 
severity=Uncorrected (Fatal), type=Transaction Layer, (Requester ID)
[   56.209440] pcieport 0000:00:01.1: AER:   device [1022:15d3] error 
status/mask=00004000/04400000
[   56.209441] pcieport 0000:00:01.1: AER:    [14] CmpltTO 
   (First)
[   56.209817] sd 0:0:0:0: [sda] Starting disk
[   56.211483] [drm] PCIE GART of 1024M enabled.
[   56.211484] [drm] PTB located at 0x000000F400E10000
[   56.211508] [drm] PSP is resuming...
[   56.231386] [drm] reserve 0x400000 from 0xf41fc00000 for PSP TMR
[   56.312520] amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta ucode 
is not available
[   56.320623] amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta ucode 
is not available
[   56.326446] [drm] kiq ring mec 2 pipe 1 q 0
[   56.326919] amdgpu: restore the fine grain parameters
[   56.539633] [drm] VCN decode and encode initialized 
successfully(under SPG Mode).
[   56.539655] amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng 0 
on hub 0
[   56.539656] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
eng 1 on hub 0
[   56.539657] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
eng 4 on hub 0
[   56.539658] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
eng 5 on hub 0
[   56.539660] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
eng 6 on hub 0
[   56.539661] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
eng 7 on hub 0
[   56.539662] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
eng 8 on hub 0
[   56.539663] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
eng 9 on hub 0
[   56.539664] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
eng 10 on hub 0
[   56.539665] amdgpu 0000:05:00.0: amdgpu: ring kiq_2.1.0 uses VM inv 
eng 11 on hub 0
[   56.539666] amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
on hub 1
[   56.539667] amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv eng 
1 on hub 1
[   56.539668] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv 
eng 4 on hub 1
[   56.539669] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv 
eng 5 on hub 1
[   56.539670] amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv 
eng 6 on hub 1
[   56.685926] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   56.686175] ata1.00: supports DRM functions and may not be fully 
accessible
[   56.686848] ata1.00: disabling queued TRIM support
[   56.688408] ata1.00: supports DRM functions and may not be fully 
accessible
[   56.688925] ata1.00: disabling queued TRIM support
[   56.690217] ata1.00: configured for UDMA/133
[   57.246588] pcieport 0000:00:01.1: AER: Root Port link has been reset
[   57.246635] pcieport 0000:00:01.1: AER: Device recovery failed
[   57.246668] pcieport 0000:00:01.1: pciehp: Slot(0): Card not present
[   57.247019] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
[   57.247198] pcieport 0000:00:01.1: AER: Multiple Uncorrected (Fatal) 
error received: 0000:00:01.0
[   57.247212] pcieport 0000:00:01.1: AER: PCIe Bus Error: 
severity=Uncorrected (Fatal), type=Transaction Layer, (Requester ID)
[   57.247214] pcieport 0000:00:01.1: AER:   device [1022:15d3] error 
status/mask=00004000/04400000
[   57.247217] pcieport 0000:00:01.1: AER:    [14] CmpltTO 
   (First)
[   59.038917] pci 0000:03:00.0: Removing from iommu group 21
[   59.039314] pci_bus 0000:03: busn_res: [bus 03] is released
[   59.039790] acpi LNXPOWER:08: Turning OFF
[   59.040014] acpi LNXPOWER:07: Turning OFF
[   59.040296] acpi LNXPOWER:04: Turning OFF
[   59.040500] acpi LNXPOWER:03: Turning OFF
[   59.040682] OOM killer enabled.
[   59.040682] Restarting tasks ...
[   59.041112] systemd-journald[342]: /dev/kmsg buffer overrun, some 
messages lost.
[   59.047174] done.
[   59.047182] PM: suspend exit
[   61.382560] show_signal_msg: 29 callbacks suppressed
[   61.382563] glmark2[1891]: segfault at 0 ip 00007fdebc1cbd85 sp 
00007ffd56800870 error 4 in radeonsi_dri.so[7fdebb972000+a94000]
[   61.382574] Code: 00 4c 39 ed 74 6f 49 89 fc eb 1f 66 2e 0f 1f 84 00 
00 00 00 00 48 89 ef e8 08 a2 7a ff 49 8b ac 24 e0 77 00 00 4c 39 ed 74 
4b <48> 8b 55 00 48 8b 45 08 48 8b 5d 10 48 89 42 08 48 89 10 48 c7 45
[  243.354138] INFO: task irq/26-aerdrv:170 blocked for more than 120 
seconds.
[  243.354145]       Not tainted 5.4.2-10-feb+ #51
[  243.354147] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  243.354150] irq/26-aerdrv   D    0   170      2 0x80004000
[  243.354156] Call Trace:
[  243.354170]  ? __schedule+0x2e3/0x740
[  243.354173]  schedule+0x39/0xa0
[  243.354179]  rwsem_down_write_slowpath+0x244/0x4d0
[  243.354183]  ? schedule+0x39/0xa0
[  243.354186]  ? schedule_preempt_disabled+0xa/0x10
[  243.354192]  pciehp_reset_slot+0x51/0x150
[  243.354198]  pci_reset_hotplug_slot+0x3c/0x60
[  243.354202]  pci_slot_reset+0x107/0x130
[  243.354205]  pci_bus_error_reset+0xf3/0x120
[  243.354210]  aer_root_reset+0x5c/0xf0
[  243.354214]  pcie_do_recovery+0x13e/0x275
[  243.354217]  aer_process_err_devices+0xb2/0xc7
[  243.354220]  aer_isr.cold+0x50/0x9f
[  243.354223]  ? __schedule+0x2eb/0x740
[  243.354228]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  243.354230]  irq_thread_fn+0x20/0x60
[  243.354234]  irq_thread+0xdc/0x170
[  243.354237]  ? irq_forced_thread_fn+0x80/0x80
[  243.354241]  kthread+0xf9/0x130
[  243.354245]  ? irq_thread_check_affinity+0xf0/0xf0
[  243.354247]  ? kthread_park+0x90/0x90
[  243.354250]  ret_from_fork+0x22/0x40
[  243.354255] INFO: task irq/26-pciehp:171 blocked for more than 120 
seconds.
[  243.354257]       Not tainted 5.4.2-10-feb+ #51
[  243.354259] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  243.354261] irq/26-pciehp   D    0   171      2 0x80004000
[  243.354263] Call Trace:
[  243.354266]  ? __schedule+0x2e3/0x740
[  243.354269]  schedule+0x39/0xa0
[  243.354271]  schedule_preempt_disabled+0xa/0x10
[  243.354274]  __mutex_lock.isra.0+0x182/0x4f0
[  243.354279]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  243.354284]  device_del+0x35/0x370
[  243.354288]  pci_remove_bus_device+0x77/0x100
[  243.354292]  pci_remove_bus_device+0x2e/0x100
[  243.354296]  pciehp_unconfigure_device+0x7c/0x12f
[  243.354299]  pciehp_disable_slot+0x6b/0x100
[  243.354303]  pciehp_handle_presence_or_link_change+0xdc/0x140
[  243.354306]  pciehp_ist+0x10f/0x120
[  243.354309]  irq_thread_fn+0x20/0x60
[  243.354312]  irq_thread+0xdc/0x170
[  243.354316]  ? irq_forced_thread_fn+0x80/0x80
[  243.354318]  kthread+0xf9/0x130
[  243.354321]  ? irq_thread_check_affinity+0xf0/0xf0
[  243.354323]  ? kthread_park+0x90/0x90
[  243.354326]  ret_from_fork+0x22/0x40

Andrey



On 2022-02-09 14:54, Andrey Grodzovsky wrote:
> Hi, on kernel based on 5.4.2 we are observing a deadlock between
> reset_lock semaphore and device_lock (dev->mutex). The scenario
> we do is putting the system to sleep, disconnecting the eGPU
> from the PCIe bus (through a special SBIOS setting) or by simply
> removing power to external PCIe cage and waking the
> system up.
> 
> I attached the log. Please advise if you have any idea how
> to work around it ? Since the kernel is old, does anyone
> have an idea if this issue is known and already solved in later kernels ?
> We cannot try with latest since our kernel is custom for that platform.
> 
> Thanks,
> Andrey
