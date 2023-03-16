Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221DA6BCDE9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 12:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCPLS2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCPLS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 07:18:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683E8ABEF;
        Thu, 16 Mar 2023 04:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc3s2AGOz6YreNznxz7Q4oDF/LjiL/I0fnk05FC5a++HiaMPn+yryhd3yPJe/aPVSbQX3AlxONgtbg55x4BgRVHdidCdRMTzQloMuRysWMNH2WZWugavzOuz650QvpghTAyFm2UhWiIa5So1mjwJDy7PwsGPuZbf//95C8FJjJTbBg/khur2q+hglmCPIm1U00WxKBUhA1+Qqtegreigs+Pmx/8nKyiFJkwWCLQ9f2sgKdiBigYxDZVHMKp8SS0bpv3KgVGRj4ibz+4m0itGjRFlpAJ4+16S5HBWrhRbBsPpMkC3KUJU9SRCa2CL21GCZ2z53LEBZnrnz3+ST8B18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5710GWVkVKVXZ3t/R0byw3HRDc8DEUmRjgNhb8qT14=;
 b=PIbeotNZCg253wV11su9zkswt3r239BR5D5fT3q/WXUKmt+q7l8xdijzowniv5PHVFdEDxOX4nxMK8mp0DoUqQP2JBWB3P/dfZPi7eToVKhAwzF0ViByG9l618YtGFipmd1UC47iHU/Bdl6sLpXZIkMUd7jITj3eYQ5eogN4kVT3Sr5wwCCGft9Qj2CA+XcDV7OC75Hq08JuBVrM7O/0kejcW+7Xf4dz6vzra3LHCT+n5NP99YFmpvIpzd8/Qfw69qw9VPTjd22s9KnlCj3f2I3utPzwYDhmmd3ncrNy8XQh192MwYAKymQBeNoo481/InGT5VYeIuXNLtSVeMR4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5710GWVkVKVXZ3t/R0byw3HRDc8DEUmRjgNhb8qT14=;
 b=T+w/ZGKKspDGhEfIZdTdtBuW1/wl07Ukew19ifuRugdo1MttV0FxvoAekjRylXMWbKwP7CJeI8kWq/C6/LIJSoAyOTUi2oOSOZmfucjPmcS2E3/fePEKclGOLP1UXt9sZWAuRPoKCHlC2Y/RVxQw70ezebu680pA5fXXEfvCODCafux5E4BxXXvVbDngk7LkaTb9pTTy8ssM73BRJRdqU6fo9aziHU6jFw35coHzBPuJckf2Bc2rcvevjdti1nHAf7PIO2odFBz/J4Aj4UZHe/JG9ks5zKG5k9xDGLZavpato50In8Xy1W/PW1uGxpwTdBqS4GVKQSL9ib+nJ70RNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by GVXPR04MB9973.eurprd04.prod.outlook.com (2603:10a6:150:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Thu, 16 Mar
 2023 11:17:34 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.031; Thu, 16 Mar 2023 11:17:34 +0000
Message-ID: <612dfdd2-7de1-12a7-c47c-7569c3466224@suse.com>
Date:   Thu, 16 Mar 2023 12:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
 <106b5618-908f-becc-6eb3-75ef136a48e4@suse.com> <6131694.LvFx2qVVIh@steina-w>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <6131694.LvFx2qVVIh@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|GVXPR04MB9973:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa38ca8-4d21-4b5a-96b0-08db26100a9f
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgcGWvUtCrK/FuNWioM9cgbPU+mYVOJg/HAgSHwQu7b+pHH5qz0oEqcQoHUM0eAqZ+pd6bSyMbcXrzxHdGdyltGyjTD2oFikPSnKy/jNyWLKczyOgunh5E6ONpe4IVETPHT3q4SjoQEecQdPupBpdbpSdetc0HpyAmc47WQJOYP6ftNvW1M7zavGJsVkwjwao1QBDjiuBayK+TfDKcvSu43EYsFLreUKfKnXuGrQipeWCrqT4KwsOTP9IXXrFYWPVtNJEQCNGJqYRF5BsaZ2l7Bw4E0WMN6mljU7AIhfrqiZc7Wvcobih9xmfZvU8FHpvsRFAB8QVHTCiVAf3z8ylmYYg2DhsqynqLDnmD/Tpw0sqLzD0nFEMDWJgUJYzPSGWYrl9nZU/48GqExrYUncL31EWLWTwXAcG8PdUVt132LXIPbcwrQ4/H2gpAO7OXeKRDHl1GbWk4yZce+M9B1RaEQ6wTo4xjtN7LCbUv+o6O/YQXRW7g1jvu6Foe9w+C/1E4q4RCW1JrF08CabDxPXR2ij4KIIXAmMUmgt5+vVkckGzS/cz3Onrwg/D+Nl9B5pKm+ItASNh83K2H/eq8EhSUgP1XbVbwvbVupllyMl7zTsvt5x7MSoA909XR3B6p6EXoboJhRSyKi678kcv5c5eqHvPGpT4rOp7vg6YtPIUvPkeTFn9YhswE6NgPWWPlMPKTeomCRQlvx6BuTOwTON0I87KeDsJ1MGKDxW65pt/BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199018)(31686004)(186003)(31696002)(2616005)(83380400001)(316002)(53546011)(6506007)(110136005)(478600001)(6486002)(6512007)(4326008)(2906002)(86362001)(36756003)(38100700002)(8936002)(5660300002)(4744005)(41300700001)(8676002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG92cFYxbjhGQ3VscEszcnVWdVBjalNrSFpQOUQycEtaMkMrSW5XRjBEemFu?=
 =?utf-8?B?cEJmQk5FTlF6dllYRDFVemZ3aXJPK2crcXhMTGJZTFdDTVl3d2V1cGFRUGlP?=
 =?utf-8?B?d1BzT0VxbjNNNHNISE1CWWVzaExkUVBxQmNQV3E4NklkMk1rRitFUkJKTnZ1?=
 =?utf-8?B?STZXQ1F0bm0vK0NwTjVqTVlPWFB0L2lmTTI4Y2RUTnVVdDZqL1lBK2tOdTFT?=
 =?utf-8?B?U0YyMkYzVVJ5TEw1cTNkNzR2M0tjMmttTkdDMGxSaUhhQ0FOS2lrcVE2a3Nl?=
 =?utf-8?B?a21UalFoZC9MVlF4emx6czl5NmFPcmNzWGdvaUNMSW5EK0J1YS93dEVKckxu?=
 =?utf-8?B?cnowd3MydDVQaUZvTkREMnNBMmFWTVVUZXU4WGM4VHNwbWkycEFXZjVnbzVH?=
 =?utf-8?B?UjJ4OG5LU1h2QzJpMHlVUkEzc0FuMVVxeElkeTVvZlNuVGlVWnNVVkdKamRt?=
 =?utf-8?B?aU16TTZ3aWxwVVkxT1NObW1WY0JIM2p0NzdkNWYzb3BSK0JmMnFCc2JINHk1?=
 =?utf-8?B?WVUwL2J0SmQ4VklWU3VWcjdNRWNzZkRUOFpPYm1NYzBrTHd5blRnL21iNk5S?=
 =?utf-8?B?RCtrTSs1MTEzazZET1VJVE5ZbmNwdkhRR242UVhFOEhMK3RuQkI4bDU4RnVt?=
 =?utf-8?B?ZWgrdmM2NVUrNVpQWnpOTldLYmovWG1CMEFSRFVnbGlycStUQytPem8zek5D?=
 =?utf-8?B?eDE3RjhFQzJmMzNZYnFjeExWWWpJTTlqQkR5cXByU3hNOVAzMU5WSzVaR0tP?=
 =?utf-8?B?dy9uNUU4TlZtYVg1Vlc4STVLVGpnZDV3WmZ3cXJkZUZxRHJqSDNSeWZKeHpP?=
 =?utf-8?B?VmptV0F3WDY1Q1hPMjVJY1g5SE1lbExMNVFCbnRNMGxxU2twcjVOaFpRQjY5?=
 =?utf-8?B?SXlnRmdYUkw5ck9LQnlUVlQ3K0pXSXdCRkhCK3dGc3Jhbk5lclRxRUVCWWhZ?=
 =?utf-8?B?UVZWWFZ4cXVOZlhQWnhEVlJqdm9HWDVaTFNhMzgzL21ZcmhyajM3dG9LQk5o?=
 =?utf-8?B?RnlQNkl5QnZOL29KbnV3MlA1aUp4SWg2VnpPQVc0anBLNlhodzhpTXhHK0VC?=
 =?utf-8?B?RXJjR1RpNTBkQ3lPb25oWkNaUXU2bEZCcXpsUVBqc1BSZzl2ZTd4aTNzbUJI?=
 =?utf-8?B?VHZjUXkvNS84SnU5TXFnOHhLNm1ONVk1L080K3MxNFZHODZoalpxOEhFSjZP?=
 =?utf-8?B?K2NscktQaGZvc3g1OG1oUHZWMURObG5ENFFIZUVjbEFla2c5NFFOUE1vS1Ns?=
 =?utf-8?B?TXJ4aERWWjVldlE3cVlQNGdiVnAvdjliZkorYWVVd3JNcG1pcWlXVmQwUnlN?=
 =?utf-8?B?RFM5TGpXQnk3dGp0K2tIbkZ6R2NOd2lSenZYVGtjd0orN01KUkxYN2M5aVdt?=
 =?utf-8?B?WmtBcWszK2VqdkFCNktxU29MVk1Jck9weWNtQWxCTzZiemJKaXJQMlhVWkk2?=
 =?utf-8?B?Qk9IbW5mZnBoUkxocGRQdkZuR1FqRXlqSjQvQUUvTkJKTEFZb2VUTGt3cUZx?=
 =?utf-8?B?MWR3dHMvZnUwTHdZeDhYK2drODNjME1CZVJtM1RBbDk0MlU4ZWhLUXpKTmVK?=
 =?utf-8?B?WjZvT01wY1MwbEdHejdWdE1tSlROYnpBVnVMYnJoTGI2ME4rOVBBRzhISFVB?=
 =?utf-8?B?bnk4MG9RRnZyM0tFKzhNcGJ3eDZGUHVHNGxGY0w1c3Q5OFZobVJBWEZYTjdq?=
 =?utf-8?B?cGRJanBTVFRWanR2eWdEaitveFNEdm05TWJQN1lVYzh2OVFpVEMvL21JbXFJ?=
 =?utf-8?B?bCtPNGxDbGZ4Y0Y0N3ovQjVqRzJPWFlWWEllM2xkeXN6bFZCRXJWT1RzeVQx?=
 =?utf-8?B?NWROL0FKN3NVTjJEQkttY2djY25EZ21tcXN4bU5mVFJGRjFkWVZyTGh3NE5R?=
 =?utf-8?B?aktpTWFaaDU2N3hBSk4xOU1TVVc0aVFTdlE1VjRnSDBtaEpvcnFPdjlOZE9w?=
 =?utf-8?B?Mm1CL0JNVGo1b1Y5OUtLNW9QUC9BNnFoS04ySzJUSk9PeEVRZGd1emxQUWlE?=
 =?utf-8?B?dnloME10MkZVL2ZIdFJlVGxsTEFPQXdFYVVsNDN6c0NPeEdROFZobjlmUGV6?=
 =?utf-8?B?b2ROdEZmZ2pYTEJwVkdwUGtFbW56QU5DeER4dW5iU1pKM3I4bjBJWlQ3cWk0?=
 =?utf-8?B?V2wzS3BEeGJaWCtSQVMrV0xhL0JBM1lFSFRvdkZGTjMzQWVmTUdJWm1PVWk5?=
 =?utf-8?Q?vmsYVrjMMCRPk1zKiZDBP0fnTEOs3rbcB0evkgd77tEz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa38ca8-4d21-4b5a-96b0-08db26100a9f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 11:17:34.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6HzenMw5iK1m3hqU1c9p8p9csqfvgN2AhPFS3c6fQhT8ksjKR0ynP0m+1Tkg8X3mW6GnBfRgTP0DdzRw71hIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 16.03.23 10:33, Alexander Stein wrote:
> Hi Oliver,

Hi,

> 
> Admittedly
> I would like to get rid of these two pathes for creating sysfs files in the
> first place, but I do not know the pci subsystem very well.
> IMHO for_each_pci_dev(pdev) in pci_sysfs_init is part of the problem as it
> unconditionally iterates over the bus, without any locks, thus creating sysfs
> files for each device added to the bus.
> Any ideas?

First of all, this existing code is a mess.

If I understand you have the issue that your driver adds a bridge
in dw_pcie_host_init() and the generic code in pci_create_sysfs_dev_files()
populates the directory before or while your driver does so and
the devices are effectively discovered twice.

It seems to me that you must not add a bridge before pci_create_sysfs_dev_files()
has finished. Now you could add a wait_queue and a flag and wait for it to
finish. But that is not very elegant. From which initcall is your driver
probed?

	Regards
		Oliver
