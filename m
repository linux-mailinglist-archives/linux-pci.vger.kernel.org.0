Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4556C395C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCUSpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCUSpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 14:45:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6D53739;
        Tue, 21 Mar 2023 11:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5U6Pj/Pals4iEJt3J1GBgzacAZJC18ZMRSUCVvgatutXtLxyDhZrFedkhIv6tCHSAI4VSf9f9IXKbcXyPjsFKSn8mKLoRLJlRxFV0m0FQV/PtNBW7ctmjMuKaJARX+JeMllsCJBenbsBe9LGv5qORqRz+SkfxK8jVpKWy6AVJr6xcGGei19Rhc1aQthN8ylujvghZZHVoBjI3WfpcQmhBSRp5lfUEsPsA1m1RG/rMSSgyatmpf5OZO62hulbkvDNtiojm13tVn/6Ug0aTRF6vPt28Jlscd0YP0zh7vnMEQgh2r2BPyEU44DGjXAT2I0uoxngLIJK+769Al31ZOvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci4i+YYJEboDTP1uvBypphXcLLBdK29cEXtft4Lt+6Y=;
 b=ftVOevbbz35TIDGpWz4dBDA4rzZuQguWKNnDjH+jp8JP/peKfH1L2Ge5nYr4yVP5gUEw+GBayAF4ASEl376y8v5u1dnSQHeTfcDr7v/VLQjFlD2Dd2JnJtlQgeVHFCv47xe4ijODjzmd/yTD2lAHYmSx92tlCtl1x9no5Goy0p5FEF4Rl9/E7FBabzBp61gR6t/g9z58vxRPg3uCbIs5SpLBTOn4yjQC/Ix8lC0VH4uayieoz5G8Vxr2iVSEKKHngPWxBGnWYn3FFGZa/eJlHzZSgeU4Sc/Tv/WmkxP/8rYhY5GIbqN8bN1S9D19KsK3EMJXNf5fogfftpZpLAOY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci4i+YYJEboDTP1uvBypphXcLLBdK29cEXtft4Lt+6Y=;
 b=ZFTzJ4GvJWhFAwlZneQdrNhzXVtFxAmDnZIRZpgxtS12Dl6Bnjt7jBQkHsfXaB6S8yLwLyW/nbnkczQgCHA0/qa3aQrsF97PJJpXOQquyAv/fJIg7+RNtyFanvcd+1LHyO0oRm1IwMU6EfAxKu3nWSogtovHtftKcArP4vtsIasBigKqTT5gtvx/MXMvJ39Mm1yFvCb8ooqjB5bwWXvEZRf03XtQ9C+pc/i4Rhu5D44wzmPmKDsNtg55k8VaGgbobcu+ucnyJgLH42GM40EtWSuHDf8XMgW8+Gmkcbc8c7FvRPzIals+YEGdEoV0sPClyWp2QXYWt9ISek7T7M+OUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 18:44:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 18:44:55 +0000
Message-ID: <993ca7dc-1d39-6ae9-1033-838d81aeb076@nvidia.com>
Date:   Tue, 21 Mar 2023 18:44:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
 <20230320205936.wd6pj3trljsduj5c@pali>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230320205936.wd6pj3trljsduj5c@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfb023e-e29c-4a58-1dc2-08db2a3c5d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIChYW1OjJLA2O32MySJ/rUibGjSEBl5MeRN634SlYhhfy2x3i9VqBGM/xvgReSRliDfJ2JdddJVGDv6Tx1g+DnO1rAdK+Q28yR1ilUa1umfozZmLK0M5bJ+pbcKkiNOe4AaY3koWTrye15y05tDjnMTQmBD+azBiNSr2XN9jUDeBjD2ovrUvgS2I2NS/j8ifWwm593F7zTmpEB4AZKpJDNpNxCNC8KAyyOReYl8KiL+6JlIcRJf52uyqYZ/Ba3OWOxE+TC8k4/s4GFAzzoODCyVgfqRsd5S5bw1u5Uov2fb3ON40tjAmEAO0XdBHupxPQ08KtH1Kb3Z6/ez56QcyZsmQepNGLAlf3Ibsj7kZV5UL7p/gshtbotzpiqzb7q25LfDPs4iDcIlYp5UHQzil7dboudqaUi+BZmP7akNlCOEe+TiM065t2WajYElAmE+lcKfRzp4xYbWggAAbN+EdJG1J0dpJXxcURHMr/INUpqD+0ZZEcE420qMBxXZlclhO3t2PeTCT7GcH3zEtJABBM7b1M1dXu9byy5InZbSSX6rOYEnPyZNQmwbPTnCm9CWZiPvG8cyOYcchaWkJxsXLtcJgCuHhu+ZxYRMxpCb6ZhDk9vL9G8zHZT9k9Eh97ITuTNJDCTFTaj5s6E3MVVRrjD0TCcZ5Qr9qFoMRLaTOodT/MNjf8vk16EdNfM9689fWgUDq90n/yPy9ZEKihXkVxp910I0ZAtD0cuVxEXpuK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199018)(316002)(54906003)(6666004)(38100700002)(66946007)(6916009)(8676002)(4326008)(478600001)(31686004)(66476007)(66556008)(6486002)(2906002)(66574015)(2616005)(41300700001)(86362001)(186003)(26005)(8936002)(5660300002)(6512007)(55236004)(83380400001)(31696002)(6506007)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVpN1RTSTdiRUo4cGdPcGRDMmhIRGI1bmpRSkZlRFhRYnVGMlhNdWNoRXo3?=
 =?utf-8?B?TmcrTmYxTSsvQWtYZFRBaFRCMzRXQzN4anJDNGpRZHlHRWFLWEh2eFdSYmNh?=
 =?utf-8?B?VHdyQVVzeUllMlNhWkVENUx0dHlwZXNDZTFRQWdnSVBVbUFFZENHRzM1Rjd2?=
 =?utf-8?B?OVJEL1dHT1doT1NMM1dMMmxkYS8zMWtTMU1hMzZoaCtLbzZHUVJmTGZqYXF3?=
 =?utf-8?B?Z2hlQnlMZHc0SEIwTXdlUVhDZDBMQ3UrU05HZUp0M0xIMWU2VmpLWUxNSE1T?=
 =?utf-8?B?b3AweHhCZG1XMCsrQUJJSkhUODIwNlZQTm90NGVkTDlYdE4vUXA4WGRpYWJ4?=
 =?utf-8?B?b2NEcEZqeHYwMmxwdDR1VTl6SERDM20yYytLYnZoT2c4Vm1jUVZPTEE5VUY1?=
 =?utf-8?B?eml3Uld1ZEx3bTRqandwTkFKUi8xZ2JlelRFaTZ6T1lRU2M5Skx2WlZoaFZG?=
 =?utf-8?B?aVpQUko5alU5Q3QvQXpuWE9rRnBUZ1RudzM3VmJrdlgxTmxxWnhWUmtKV1VG?=
 =?utf-8?B?SDI2dEJBNG9Id1lmT0gyZ0liL0tBV2tqRUc5NVZSN3FvUndIa2xvNVpia0FF?=
 =?utf-8?B?TndMN1BVYjBZa253cDJtZUVMVERhRkZXVk5pZENtcFU0bU1mdWNsYkpOUTNn?=
 =?utf-8?B?MGtWbkljVUlyMTNZc29YdFVYa0dVbk1HcWUwdCtyOXd1RUF6Y2xlS1JSL1pH?=
 =?utf-8?B?bzNZSXh0ckJreW5HaE43Ni91TWd3dmUwRU8rVTF4Wm9BOHpJKytwN3YxT2hk?=
 =?utf-8?B?eWQzZWJCRk52ZU13WUluQ0VYK3pValNOSXRoVHhoTnBkNDNoU3lqQXRRTG9w?=
 =?utf-8?B?QzlDZkRiWEhGU1FlSzFZekdjbE9PeCtuZE9zTFZCMXRmVHRDaEZLVmRPYm4v?=
 =?utf-8?B?WWVDOG9rejhDTE5FS2E1b0ZWdkQ0eEYzSUp3QUQ0VTNpM2ticlFxUDJKRUlK?=
 =?utf-8?B?L3k5QndITlh1dTlIVXg2eUY1eCtHSjJabjJldnhoNWtEYmdZZ0Qvd0ZmR2pk?=
 =?utf-8?B?NjdueE1jWmx1U0IxQmxiVWwvS01lMCtCNzZaZFJEM3BYMlBob3duektMOTFn?=
 =?utf-8?B?am5JK3h1cUR3RmdmZHZTTGhVYk9jZWNISjlKZDkrVUswQWRXc0hnWnhBZ3pJ?=
 =?utf-8?B?eURUUkRYWFlzaGxZTDViR2RyY2pLRXdkL01YSTR1em5sV1VWYnkyZWJqZ3Zh?=
 =?utf-8?B?ZzVraSs1S0gxb3FzUzYxYkJ3M0k4ZWxLeVBWN2xnVENxRU9JZ245bjZ5RStL?=
 =?utf-8?B?YXpsSlVnamxvQmk0ay9qc0x3QmVIdzlsR3RNNGRSQWluSWRhS09iemhDUTVX?=
 =?utf-8?B?U2t6MUpFdmkrQjR4S2FnMW1SN3lpdU1DVEJ6ZzhDcmNqZ1JEN1JTYmVZeVho?=
 =?utf-8?B?a0N0UUQwdlRoS3h6MWNzbkJWU3U4T1N4WWQ4c2JQbWYrYmQvV28wemdReW8x?=
 =?utf-8?B?SVJlVEtQenF0ZnVteUd0aEJMTjRqcUpUekdMVnYvZUpsbDB4dW9SRmJYTG1H?=
 =?utf-8?B?dXk4NXB1a004ZXlpbVVPSUVoZmpLTUNadEUvTU1TZk1IaXdiR0phN0hHV3FH?=
 =?utf-8?B?T2QyeUxtRGxvY2FIRzhuWVppb1dXS1N2c0FiODJWWjFpS1ZwdDZ4ZEFRczNB?=
 =?utf-8?B?eUdtbytMR1VWWXFPeUlic1YrZzBpNXV4cjJuazRzdUtxR0NqdEVtenJzdjNG?=
 =?utf-8?B?YzVCd2N4dG9CbDRsK0JibDJlMmtlcWFNZC9jM092L3NnQ2krUm85RkVqTWtW?=
 =?utf-8?B?UVlscUFRSUZDYThRb3NVb01WNGhhTGExMjJZWVhCRzhjUGpTSTkvTkdMQzB6?=
 =?utf-8?B?M2hmd2RWOG0yd2hYWEpIZkhubHgzbGRJWVhyZGJ5U2l1UUxSeVBmbSt4U21Z?=
 =?utf-8?B?S2IrVld1b29Hdkh3MHdMUE5FekZwbDlBNnVnRHFTVTkxZkttMkhnaUFCUDg5?=
 =?utf-8?B?aVhkYWtTcGZFamg4enlvMDN5cmdUOERucjFQUzlhNDNwR29uZFhOQzN5OERP?=
 =?utf-8?B?OE5qeTZqTk9MQUwwb2VDdWtHQVFoOG9JTXhBMks2aHY0VllONHJjUHlJQWJi?=
 =?utf-8?B?WWZQaUZMRWdqYlFyQlFCUVBYZWJDMjRLWU84RkRkSEdjRGN2bS9BbHJFWkRX?=
 =?utf-8?B?ZGNSNkp4U1gzYndyTlBQMzFIVUYzblJHZzV0UzBhb2h3aHRSc1VtREZJZXpl?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfb023e-e29c-4a58-1dc2-08db2a3c5d3a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 18:44:55.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXD65IW3OF+lzNtF9RB5IjRQH75f8Jxq4GY9jPnKNuHFBNEdtXh18SZQoc9SAaY3EK9QMrl07g9bHVQ68TFOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 20/03/2023 20:59, Pali Rohár wrote:
> Hello!
> 
> On Monday 20 March 2023 20:26:05 Jon Hunter wrote:
>> Hi Pali,
>>
>> After this change was made we are seeing the following bug
>> report on a Tegra234 Jetson Orin board ...
>>
>> [   17.172346] tegra194-pcie 141a0000.pcie: host bridge /pcie@141a0000 ranges:
>> [   17.172470] tegra194-pcie 141a0000.pcie:      MEM 0x2800000000..0x2b27ffffff -> 0x2800000000
>> [   17.172519] tegra194-pcie 141a0000.pcie:      MEM 0x2b28000000..0x2b2fffffff -> 0x0040000000
>> [   17.172548] tegra194-pcie 141a0000.pcie:       IO 0x003a100000..0x003a1fffff -> 0x003a100000
>> [   17.173449] tegra194-pcie 141a0000.pcie: iATU: unroll T, 8 ob, 2 ib, align 64K, limit 32G
>> [   18.279048] tegra194-pcie 141a0000.pcie: Phy link never came up
>> [   19.279285] tegra194-pcie 141a0000.pcie: Phy link never came up
>> [   19.279599] tegra194-pcie 141a0000.pcie: PCI host bridge to bus 0005:00
>> [   19.279613] pci_bus 0005:00: root bus resource [bus 00-ff]
>> [   19.279622] pci_bus 0005:00: root bus resource [mem 0x2800000000-0x2b27ffffff pref]
>> [   19.279631] pci_bus 0005:00: root bus resource [mem 0x2b28000000-0x2b2fffffff] (bus address [0x40000000-0x47ffffff])
>> [   19.279639] pci_bus 0005:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x3a100000-0x3a1fffff])
>> [   19.279687] pci 0005:00:00.0: [10de:229a] type 01 class 0x060400
>> [   19.279886] pci 0005:00:00.0: PME# supported from D0 D3hot
>> [   19.283256] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
>> [   19.283590] pcieport 0005:00:00.0: Adding to iommu group 26
>> [   19.283991] pcieport 0005:00:00.0: PME: Signaling with IRQ 174
>> [   19.284429] pcieport 0005:00:00.0: AER: enabled with IRQ 174
>> [   19.285003] pci_bus 0005:01: busn_res: [bus 01-ff] is released
>> [   19.285591] pci 0005:00:00.0: Removing from iommu group 26
>> [   19.285751] pci_bus 0005:00: busn_res: [bus 00-ff] is released
>> [   19.285870] ==================================================================
>> [   19.293351] BUG: KFENCE: use-after-free read in pci_bus_release_domain_nr+0x10/0x70
>>
>> [   19.302817] Use-after-free read at 0x000000007f3b80eb (in kfence-#115):
>> [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
>> [   19.309691]  dw_pcie_host_deinit+0x28/0x78
>> [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
>> [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
>> [   19.309752]  platform_probe+0x90/0xd8
>> [   19.309764]  really_probe+0xb8/0x298
>> [   19.309777]  __driver_probe_device+0x78/0xd8
>> [   19.309788]  driver_probe_device+0x38/0x120
>> [   19.309799]  __device_attach_driver+0x94/0xe0
>> [   19.309812]  bus_for_each_drv+0x70/0xc8
>> [   19.309822]  __device_attach+0xfc/0x188
>> [   19.309833]  device_initial_probe+0x10/0x18
>> [   19.309844]  bus_probe_device+0x94/0xa0
>> [   19.309854]  deferred_probe_work_func+0x80/0xb8
>> [   19.309864]  process_one_work+0x1e0/0x348
>> [   19.309882]  worker_thread+0x48/0x410
>> [   19.309891]  kthread+0xf4/0x110
>> [   19.309904]  ret_from_fork+0x10/0x20
>>
>> [   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, size=1072, cache=kmalloc-2k
>>
>> [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
>> [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
>> [   19.311571]  kmalloc_trace+0x24/0x30
>> [   19.311580]  pci_alloc_bus+0x24/0xa0
>> [   19.311590]  pci_register_host_bridge+0x48/0x4b8
>> [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
>> [   19.311613]  pci_host_probe+0x18/0xc0
>> [   19.311623]  dw_pcie_host_init+0x2c0/0x568
>> [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
>> [   19.311647]  platform_probe+0x90/0xd8
>> [   19.311653]  really_probe+0xb8/0x298
>> [   19.311663]  __driver_probe_device+0x78/0xd8
>> [   19.311672]  driver_probe_device+0x38/0x120
>> [   19.311682]  __device_attach_driver+0x94/0xe0
>> [   19.311694]  bus_for_each_drv+0x70/0xc8
>> [   19.311702]  __device_attach+0xfc/0x188
>> [   19.311713]  device_initial_probe+0x10/0x18
>> [   19.311724]  bus_probe_device+0x94/0xa0
>> [   19.311733]  deferred_probe_work_func+0x80/0xb8
>> [   19.311743]  process_one_work+0x1e0/0x348
>> [   19.311753]  worker_thread+0x48/0x410
>> [   19.311763]  kthread+0xf4/0x110
>> [   19.311771]  ret_from_fork+0x10/0x20
>>
>> [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
>> [   19.311799]  release_pcibus_dev+0x30/0x40
>> [   19.311808]  device_release+0x30/0x90
>> [   19.311814]  kobject_put+0xa8/0x120
>> [   19.311832]  device_unregister+0x20/0x30
>> [   19.311839]  pci_remove_bus+0x78/0x88
>> [   19.311850]  pci_remove_root_bus+0x5c/0x98
>> [   19.311860]  dw_pcie_host_deinit+0x28/0x78
>> [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
>> [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
>> [   19.311900]  platform_probe+0x90/0xd8
>> [   19.311906]  really_probe+0xb8/0x298
>> [   19.311916]  __driver_probe_device+0x78/0xd8
>> [   19.311926]  driver_probe_device+0x38/0x120
>> [   19.311936]  __device_attach_driver+0x94/0xe0
>> [   19.311947]  bus_for_each_drv+0x70/0xc8
>> [   19.311956]  __device_attach+0xfc/0x188
>> [   19.311966]  device_initial_probe+0x10/0x18
>> [   19.311976]  bus_probe_device+0x94/0xa0
>> [   19.311985]  deferred_probe_work_func+0x80/0xb8
>> [   19.311995]  process_one_work+0x1e0/0x348
>> [   19.312005]  worker_thread+0x48/0x410
>> [   19.312014]  kthread+0xf4/0x110
>> [   19.312022]  ret_from_fork+0x10/0x20
> 
> Based on the above trace it looks like a double free of "pp->bridge"
> structure.
> 
> Also, which kernel version are you using? Because from above third
> trace it looks like that dw_pcie_host_deinit() calls first
> pci_remove_root_bus() function and then (from first strace) it also
> calls pci_bus_release_domain_nr() function.


I have definitely seen this with v6.2. I was doing some more testing and 
  now it appears that the issue is somewhat intermittent. So now I am no 
longer confident that reverting this change does fix it. The backtrace 
made it seem like this is a likely candidate, but I need to do more testing.

Cheers
Jon

-- 
nvpublic
