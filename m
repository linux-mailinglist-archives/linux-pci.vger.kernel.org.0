Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B41F554408
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349499AbiFVHKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiFVHKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:10:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26A36B6D;
        Wed, 22 Jun 2022 00:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW2hejxSn4CeyGiD9vgA+b971wZfkdHclflN8V46gXRT/Wi9wuPgXPVlTvzXnhMybnzY76XuTmB5eFAvVdmHYnH+BrNPX0Urspr2MMwSmPXbSqpgwo8mkNa834gTtFTR0/TgMsox1lmArxRRSdFDUQ5UKXM+bnDS0dci6tpi0QW5OyFmw0DYAfrQmQ7dc+Nn1H9QVwkkReZyw5xUnrUqKmT4XyG+qw7pClJ8NhOKsGjSlHOwxYInJABsLf6Pbtjll/YhDZQ8plrirhV3AsYEOP4KSRIddpHkxemR0v8nuIBNljDzH7t7nqVn9pZb8WKIL96aYt3wyEuOEPTsFK7ZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YWXA1W4UvfIWvgkunCwe7jRJXXXZk6kdTatAawR5lg=;
 b=WlAAnMcflOUAm5R5bLh+JHAOTzXMlAC8MnsBQCe9slGnD2UaG96KycXcbyMWbgeOzbFtewkdSbBNtbl96SutoEIzqe0S1RsYWnQ2I+jHlQCW6CrkWOC7ibCj3bi3WPK0tR4LflMDYZbT6DLxUkZf0qc2e28NNMbQYzsHXlLtwBNLtC7vrx8rf9pad/w/VqmoCdz+CCbIqd9T/mi0ZgA8L2U5pfgzBo9vsVWfObqeSEZghtB9u8UxTwKq4vLbqI9JFeJpv0acCfWKnT8exbDKrpAlf6dUN07fVz9BAi7zRV5yAqKorA3yp6/INCpmvGwQqm/TueBTt1PPBpP1QEeQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YWXA1W4UvfIWvgkunCwe7jRJXXXZk6kdTatAawR5lg=;
 b=dtta2zGeGkq20HBWEFVxitUyZVmvD1SyJS/SV6w3eK72/53XVSe/K99ZFMgt2i/Ob8B8qXkpTukVskOA4rReILmFNs78kG/l+6kqcY1qfXkdA5Q1KOSBGP9K8P9bLw0nycV2HupAOiZ+IVQ2lslIBzLBvYckihwFeKEeiB7A4/SbTm/OTkP35lHV/mES0IwUzXcqQdtB7nB63+zfS0K2tie+XJZpMJzta1GEwhsyS+lm6EkTylRKxZPDsZonwSdkM7PUpKlFcoqwEUJL5zMAklN9lBXHzqa8+j0j4zdPpf7AHyRyd6fb+ZlpdgHEHi2NokimLul/4lUS1cvYaJQI2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Wed, 22 Jun
 2022 07:10:33 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 07:10:33 +0000
Message-ID: <41b411ca-ad24-40b4-25be-5c73a4e724af@nvidia.com>
Date:   Wed, 22 Jun 2022 12:40:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::24) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d49d49-b9e6-4a7a-b088-08da541e4c2a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3437:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3437A7908C5EB0A4A0664A17B8B29@MN2PR12MB3437.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohmwBswOB/a/8xkDeWl8V7G08jgIy/Nyp7auc/B/NcDlTICFNknSStXPQgWoS8SRwXaBaIcpw4lvQC/DwvAa+cyoN6JmTSyT3Kirp0PY2y+qq5JE+QEO9kTzLAqUQxZPG8b6Ho8IFuirVo5fSISu88KDKd3X9IfKSvr1TgcmBk2gEWwQEvhplVEdwSk6M0/ZlL0T1D3UsbiuPPOoc5cAwpQA2qlszYjcNT5JAnzAupj7PgfWjoUqEX1YTdlNwrfdnX4EkRO1EPtOeZiNXq6dxKS32YLmTngTULunpWgsili5LyqptvhvL0GgXbt2AMKgcN9IFf1cTXIdpMZoFD6+CPEExiG/BFRHFSSqlxXiRmc0Z7RXqX62a0KEt0YKVNyT3mzDdKGSOpPTkCOVteLGYGMw8XbOBU2h8q+aGctaFA4IdeenWz7TPxP+R+cJEHznq4l90ySSkm4ppcfZYNEgf5B3+OY3ISf7Ekxh1bS17ZRh/TfwptETYD+2mZkCOa6tpHLFOUyjtwshXhhAhyb2rKHHV1nGAm2jzcBTxz52ofsuTle/lAL7zahEQcWjiOqLJ5N8YiKqoqHKVLVYaQ+XJGpHjvcrKCCQbPQ39awl/alHvnm1DvIVqs/rRRkpVb4J4ei+bBaI3yJ83anPFYrHRJ3mC+653T7VYdxQUdGHiDXokzPw21VZDnKbbXu7ZpuSB91+2uCPHGRPW/kkUEaIv1FgyVm7jZkeb/McoUxzf/oPH3YxyVkhzoQ3xcA9mhiPLiQ1SsGEDOd0DLYNDGKFggFDq7/FdOFN4q9W9fNxYhj9tjagcMzSHkZ8RBGkQwsXTEOMhaYJNYNRkoLY36g/ZkTEQHkZqTaLbIS5/bNA98ilhQA1qDnwuRmpcJrogB50
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(66476007)(36756003)(66556008)(31696002)(4326008)(86362001)(26005)(38100700002)(8936002)(6486002)(83380400001)(5660300002)(316002)(6506007)(6666004)(53546011)(31686004)(2906002)(6512007)(41300700001)(2616005)(186003)(966005)(8676002)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0w1ZFpGYVdDWVd5NHd4S3A0cmR5ekcxUkU4T1RXNkpSNXVSTyt3V0JkaklP?=
 =?utf-8?B?bkZMekxmV044N29PVWlKMXlOMlVZUXA5MmpWaDZhaG9SYnJSem9EdFF2UVV1?=
 =?utf-8?B?dTJLd2NJcjRQYTc4Nml0cjY2bU50Yjlkd0lBOTBHRVJkTlE0SWhnbWNwTkF6?=
 =?utf-8?B?VzNtaTJZcHVxTkJNRFp3R1NSZ3NHRlZQM0FEWk9BaDJMRTF2bUhtQ1FoblJS?=
 =?utf-8?B?MXhiRW9IcStjVnUzNEVpNHB4TDVqSWdGQmR1TXB1cVVBKzlUNjR4ZFNNWkRp?=
 =?utf-8?B?b29PSElicERkcE5FemdUenJRREw4cFp3M2w3bVFCN2dhSnZOeXZsRFNEUlpP?=
 =?utf-8?B?Rk5EMDJiaDQ2MXgzVU53T1BKYzlRZnlVR1V3d2N1VHo2L2dPN2lDSlJocHlD?=
 =?utf-8?B?aVkzS2dLUk91RHFkaTN4dkdMaVpadUR3TjJtVnp6MzdJdTNndldUVHFYU04v?=
 =?utf-8?B?a2hYR0FXUmQyZEVaNHpmQXlaQmQ4QUJyaFJBUngrSnZBbnhOV1dBUEY4WnQw?=
 =?utf-8?B?QjVHekFsT0lNeWtSamx6K3A0Zy9sUVIyY2QvOWtXbDJteldObHJKS01OTCtP?=
 =?utf-8?B?cXZLakhHUVdBQXRnZnd2TkgxVEUwSzJ2ZkNwT2ZNaEc3YjE1aUJjbGJJSUd4?=
 =?utf-8?B?TDF6c0NDeU5XT2V1dm1nZkp2bXhTdDNJSi93S0N5L1NLVWFWcVBNQVlyVlpo?=
 =?utf-8?B?NmtBZys5OTBMUFpMYXpYNXlmeU50ZlNlNCtINHNzV2tUSGpIei9wZHp3T08z?=
 =?utf-8?B?ekhxbW5WYnUvS1FyUm9HVTBqanlzN21VMDZubWV4WWtleEgvM25CdTdoTGNM?=
 =?utf-8?B?cCsvTXB2Zmoxc2hCSHlRUzhIOHhOZkpjbGNuTmhGenBpVHk0ZDJTaHFMVnhi?=
 =?utf-8?B?S3ZpaHd2eG9aaEEzUG1OeStBVFFOd0NJa0lYSGJ4Q2RWalVibnZBMnB0V2to?=
 =?utf-8?B?aVJMZ1lhekZCSFhyenZDYnJDUXcvTkd2Z0JZSnpyeTVlSzhZQXlvbkMwSm9l?=
 =?utf-8?B?MDJ3Yld4SlUvUmw3R1Ntc0dMbEUzbVdrQ3NNUlhDRnRGWkx3UE5zMlZVVjd6?=
 =?utf-8?B?bC9vNjVET250VFc3bzFiWGJrNmJIUDJnVTlveDIyWlNDWGVrN0hTUFRsTG1L?=
 =?utf-8?B?aWVHZXRWNUF3d3ArYVAzSUtQYUdYcmp1MWFXY0x2dUxYRktFWStuYzNwTk8y?=
 =?utf-8?B?eXptR0NlZnV0S1BhTzZuWUY4cGdSZGQxNVRLNk12Tm5saG1PcE9zcjV1M3RT?=
 =?utf-8?B?bFFYRFdGdW4xVU9pVGMrNVZlRzRZUVhEQ09Pa2ZKWmNKT3I3TmtBQUlPTFA0?=
 =?utf-8?B?TGdPSVo1d3FwY3J4VTdqenB6UFl4cjY4dCtNVEdGK2JtNEJYdEZnNkJCS3FO?=
 =?utf-8?B?WjZMd2t6eTN1TEgzKzBFUkNZS2pDY0Q3RzQwaXk1eXZEbkFJck9GY0dQaWEx?=
 =?utf-8?B?bTFiOHpMUEt1MXhMc1dhZER6ZHVXWE9Ud3NXTUxndGZOMjJ4T1EyODRLbU1K?=
 =?utf-8?B?RXVBUnk1akZJeldXdjVLK3FmM3NGU01Gd1pXWUkvTTR4c21zTTBzWU1vc0hD?=
 =?utf-8?B?SVhLTjl1WmNiVDRkV3BIRWFQZ1JwZ2hQWDhNV3JZVHRuZ2cyeHNnTGEycWlq?=
 =?utf-8?B?WjI2TnJNU3BzZVZXbUZoL3UyMUcyWXRVV2JNM0xnS1JHVkRIdkc4SG9Sd0Fo?=
 =?utf-8?B?NWV1WjBBanZFYXFESEhxK3F1ak9NSXl3Yk4zQ2JGbVZRd3JWWWw3c2hRTWFp?=
 =?utf-8?B?Y1hwTmo2Z1BHQTJadDNBWlRaUkM3N1FMRHBjSFkvNmtKUlV0endNNUdETVA1?=
 =?utf-8?B?K0x2dTZjZjR1VXloMURtQ0pTRElLS0FKVU43Z3VWZEQvcTArN0l0Q21MNjJ6?=
 =?utf-8?B?RGIyQmk1bEp5RUpzL211eThsei9IVXJhZkpJZ2FBMitsMEJ6QzFOdnFaQVgy?=
 =?utf-8?B?Q2JEUjd5OWlFcElGSyswYnN0NjRDK1JETHV3c1hQTmhISXdDRWNRRWd0dTQ5?=
 =?utf-8?B?dEt3cDdSdHMxalliMnNzd3ZCbnNWejVXMndHTmtTWFp4eVFJUmcyb291Nm0x?=
 =?utf-8?B?Y3lucjB1MVZkNXRYUUtCRHhpOVhFdm9nbmlPTk1Xb1JTUGxXWFhZVnVCdzZa?=
 =?utf-8?B?RWtMdzkwSDlkSUQ0eFVzd3VNbXVSNGVieUtxV1pua3hwTzJvZ0pnNnlMZ1pH?=
 =?utf-8?B?c2QzRldDbnJ0WEoyMTdhcDVqVk9rRHU3T2NsczAvaiszWjJiM3djSERLTEQv?=
 =?utf-8?B?TWFmN0JpYnJrcVNuRGtDWG9BNVFzWUJjNjQ1VW9td0Z5a1JZYnZnU1pvQTVk?=
 =?utf-8?B?Q3A3a05KYzFNMVdPQnJBSnBvNEVmeCtLa01ZK28wdlhpMFlIdS9Hdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d49d49-b9e6-4a7a-b088-08da541e4c2a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 07:10:33.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFhWcKUWE2bgqp8V7nv9K+hMhhmZGUMw0UZBmCCTKMGmy+BKe31QN7Px1sVfs8OrTqcv/Z6nuL8GbI5SxOlKGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3437
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Verified on Tegra194 platform.

Tested-by: Vidya Sagar <vidyas@nvidia.com>

On 6/22/2022 8:20 AM, Yoshihiro Shimoda wrote:
> External email: Use caution opening links or attachments
> 
> 
> Add pci_epc_release() for epc->dev.release and move kfree(epc)
> to the release function. Otherwise, WARN() happened when a PCIe
> endpoint driver is removed.
> 
>   Device 'e65d0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
>   WARNING: CPU: 0 PID: 139 at drivers/base/core.c:2232 device_release+0x78/0x8c
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   Changes from v1:
>   - Move kfree(epc) to the release function.
>   - Revised the commit description.
>   https://lore.kernel.org/all/20220621121147.3971001-1-yoshihiro.shimoda.uh@renesas.com/
> 
>   drivers/pci/endpoint/pci-epc-core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 3bc9273d0a08..2542196e8c3d 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -724,7 +724,6 @@ void pci_epc_destroy(struct pci_epc *epc)
>   {
>          pci_ep_cfs_remove_epc_group(epc->group);
>          device_unregister(&epc->dev);
> -       kfree(epc);
>   }
>   EXPORT_SYMBOL_GPL(pci_epc_destroy);
> 
> @@ -746,6 +745,11 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
>   }
>   EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
> 
> +static void pci_epc_release(struct device *dev)
> +{
> +       kfree(to_pci_epc(dev));
> +}
> +
>   /**
>    * __pci_epc_create() - create a new endpoint controller (EPC) device
>    * @dev: device that is creating the new EPC
> @@ -779,6 +783,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>          device_initialize(&epc->dev);
>          epc->dev.class = pci_epc_class;
>          epc->dev.parent = dev;
> +       epc->dev.release = pci_epc_release;
>          epc->ops = ops;
> 
>          ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
> --
> 2.25.1
> 
