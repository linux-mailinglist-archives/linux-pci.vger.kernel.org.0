Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42941554434
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352151AbiFVHIf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiFVHIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:08:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B631206;
        Wed, 22 Jun 2022 00:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACKKsTe7PHuPvzd+32LJXpjLwAebDT+zcSI7QtNVN8ZSE6LvWBiilohmG1OUB+DabsVTE7ePjMeQv87J7/KSOsDPScYpuJo+D7QA9HkEUwbfhAFZJTJeOyStBC1une3bMeDHg9fRrEIATVahdD1VwoDceptRatTNF/KgE6zRk22AAZf0my76gq3J5O0VdeKc4bN1GlwEKOgh+tnIK029JCXBRgpEo/1SKg61/LJx9yK316aTv0vITvgN2wDW8sUbk0M31tzHoHR1x8haNYYoMHLwq7H9hA6hs6+xBRynkXIzvIMzK/X2D0thyUVUebY+w39FVmM2lxhBkCLNbBimmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n7Fw04nJ0TrZAWIAmwOpaXZ5JgIgXkv3cJ9DTFwcww=;
 b=cPPSUM73k9l6fWZsNEBEWHVBxH7v6B5rbCvZTA5TZCjGaRt/4uXkpfiwtUp85D1TBFoWi7/guvDcARchAiE+OqRBeA03IUnqHBFCrW4b/PH2R4qtiWfFkt6RZ8RJkaO1xiw/KTC+3ht4FOkesyD0AAA0FtpEGwfkDajMNbidFBfqv/Z7iQxE1II8PljRPJw8dfWcAhd0oOdyvc9pNH814cH0vy2YqhZwOdnpdGHkbGztnwHo6f9NgfNq1v4g1ses0snrdOZzfSDd13yD8xymUJpcACiMRGDazuPfbXqE9LZpE2OGBWvGrbONevbNZwi66U02HUx3jbHsqOrrIuqQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n7Fw04nJ0TrZAWIAmwOpaXZ5JgIgXkv3cJ9DTFwcww=;
 b=fMuYo4Q53F+tz2skZTxkmkNbNizdV10WqttRBA+5XiRqQUCnpyiSk01z8mG05rIr88v6yEbJPZSFpxyYr2RWIlzrYCla9TRZ+32uEYJ7J3J+W9TwDU0b8zlzUWkzgNMk5Lrg1ZfQ1iAyHmdSwmPnI5hzM8nqSYAENz2LHGRJc3kBafFRNY8M0GcuC1SuvS5DoBCoS43OVNH2K5fkReoVxcYFIzEvpRoR4qo/aRHc+s5y7l+vtQb2KGni3W3SDummf8vT/51PkuFS8iVQWDJkDtfZlwFdDPpZ4Fn70bqi/cfJCCgZiQr4ul0sTz7bmUTQGLJ7SvbXaPaRlStB3Tu76g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Wed, 22 Jun
 2022 07:08:15 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 07:08:14 +0000
Message-ID: <dd6f5d4b-a348-8bbc-09c7-b34b01f18698@nvidia.com>
Date:   Wed, 22 Jun 2022 12:37:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: endpoint: Register release() for EPC device
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, nkristam@nvidia.com,
        sagar.tv@gmail.com
References: <20220622053705.3283-1-vidyas@nvidia.com>
 <ec2ee06c-b83d-b1f6-8cb4-0a32bccb5132@ti.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <ec2ee06c-b83d-b1f6-8cb4-0a32bccb5132@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5937b104-c339-4ccc-8ad2-08da541df986
X-MS-TrafficTypeDiagnostic: MN2PR12MB3437:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB343778CEDDCA1AD96A732D27B8B29@MN2PR12MB3437.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3066QemA9Q6LCYStLeSiec+HTVO+u3Z+b7OoLMPwEXn+W9tTrYUJzZHx6G33Gou5Z1Uy+zOjaJy7AjET74wLc6u4xw1Ln5KhuSr78iSASTbyfCZMj7326Lij6jMWli0QCWM3WQGI0M3EeTWYDgp/w5cluF/YGAizj4DKYWPskIjhi4vkK8h5dOZx19EqK8KhK8b6z6PEhS7fZt8h0PI7laBlpQqo67D+6trzAydMebEqAC06jdxcN6mlq9T5KNzTaHt94bja9ouFfYfY7I4J3ss10Ywxk4GG/4aQjwjaHhOYmEubtf6tTQcawB7Iiq5gYvhi+3IT4a/v6CJCtpstIBUre8JFRDUSxv/FohftuELmAgS8AwBecgaouQI3jOGX3J1qE2hENuHHCznvP1dzhavXe9DDKULgoWfMjieMPoZ5RMpir4DE1MNC4OsFnUZTtr59l/vnp69BIZXWFwDrOIvunArUbydO1f6bwm/3P3EyraJ3tepoyElwjPEsuEsKhOMNmxUsp8TmvrFcggjGvaWo6H45/IhQxqY5wrknRxkxR8vrVjn5y68FAImpzybVcTgo+k8okz/dwk97sYarjlfgWZe04X7lc9G1tt57+6sJR/VUF9SosFAIHmLq+yUD8B6mGq7VZAfAqa/ThydCHpZAlopaUj4dXs7ajmCptjetbJvG/FcS1li7hbGJohSSmT0CpTYrtnazZTNRy5Qryvz/Q89tGAampxKnlOAlA5GWSF93RVG8xDZfG5GRzKmbvkRDfg+8BOhGRHP9P0V+vv3XZhvJL1DufEUuuQAcYq8iPghi2CvnT6hPnYZipu9/XdPs4N811N1VoQ4hGznqYEVLpC2/0/tGO2P0DpEGVGv3s817lOlDFa1tfGm7JtUa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(66476007)(36756003)(66556008)(31696002)(4326008)(86362001)(26005)(38100700002)(8936002)(6486002)(83380400001)(45080400002)(5660300002)(316002)(6506007)(6666004)(53546011)(31686004)(2906002)(6512007)(41300700001)(2616005)(186003)(966005)(8676002)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9yTzBHbUtVZFdCeTFDdzNGVm5FZFNrS1RHVDFoSGV0MHIyOXRnUk1BaUd4?=
 =?utf-8?B?ZFhsdHQxYVUyMmF0dkJCS0ZTaFJ2TFk2Z29BeitIL1U1TjJRRlJocmFQUjNp?=
 =?utf-8?B?YzAzRC9WczBQTUR0Tm44UWIyRHArV29YVXkwa0tIVjVCRFNMVUhCNGZnd2FI?=
 =?utf-8?B?WTRPYXZUZUJRRXl6dUNiZGpvRzE4VVF5NDRoeUFHNllhRzdiaDZjYVBMZ2VU?=
 =?utf-8?B?M1Zhb004UWRiQnk1TGJLeDJVbUNKWDFtR0N0VnFKZjlScVBsQ0dlWlIzMU1M?=
 =?utf-8?B?N2hpNnBnTjFacTJGYlp0UmlzUHRnYzhpTE02RHgwbjFTR0tGZkxnSFZUSkdy?=
 =?utf-8?B?SHN6aERXL2VNME53MlpCeW9CRk5wdXNVMjRwZ1BLV0NNUGEzOGRXd0ZOTUhh?=
 =?utf-8?B?Znk4bWZUMjNlODJMOFdyaFo2Vk5OZ1NWWXB0RnFWeFFwczJTOFJXYzZ0eVE5?=
 =?utf-8?B?QVVUbHQ3dXgwY05LeGNQdmZEM1FYK2lpVHB6RGJDYWFiTEtiNFlYVVdkM2xX?=
 =?utf-8?B?UUZEamo2a3dtVUlLcnoxTy93VmNaYzA0dDNYNWZxQjFDbmx5cExyV3lubUZk?=
 =?utf-8?B?TDdBazhFYlN4UG0xL1l2WDNPblc3S093YlY4UUR0emRZZitkV2dsZU5mcUp6?=
 =?utf-8?B?OENOS2lzZmlybjRzOUZINXhCZFdzb0ZlQnBCS1R5N3JmUnVjaXBwR3Z3NSsx?=
 =?utf-8?B?MkR1TGJ6MWJBenhZdEhUN1EwQUZzVzdZOEJnK1E0T1p3a2syRFFWalgwcVhS?=
 =?utf-8?B?amNaUkdrVVBRRVRIZ3lrYjZjclBZMUh3TmxSL0xvVEk4a1I1c2FJSU5LMnM0?=
 =?utf-8?B?ZldTU1hNbUtHYXZBbVhHeEZzRU1maGRLTldEMGJObStxakJ4NzhjVTNGRHE5?=
 =?utf-8?B?WC9reW5XcHYvWms0emE2OFFiZnZFTzU2TGpQYVpNY1ViaHMrbGN2a2crdkFJ?=
 =?utf-8?B?MnEvMjVINXVBSjZrV3hmNVIyOHdPT0xHb3VUZHQ5NEM0dytIVTQ1cllaVnNF?=
 =?utf-8?B?Uzh3MGx4eFdnbEs0bjNKT2NURmExR1p6emFXRzg1ZWhKWndKQjVGamc2aEF6?=
 =?utf-8?B?bE5yb0c5bEM4eEc0MzBybXVJVWlBTEtpdjhHQW9rTm52THZpOFZGZVFvOFA4?=
 =?utf-8?B?VmdJT0c4blE2UnQzRnlydTkzMHNEMC9JL0hrWGZpNy9UWEY2K1pvcW5XRjJp?=
 =?utf-8?B?a2NpZlM4STA1NHY5YWI3U2ovUERPaEhpa1BHaHowSXlsUXBmc2x5R0RBV2cx?=
 =?utf-8?B?NUV4WWRmQjQxV01VenNuSDhOb28zZkRaMW01SlRjV3l2VWNrcmpqRlVTRW5P?=
 =?utf-8?B?VTR6TlAybGJUODhtcnNVaEJ0ZnRsYm9zcC93dDFEL2tRdXNCNlJYTDJpV0h4?=
 =?utf-8?B?TjlCaGwrdEpVSEFPZnhUbkxaS0JnODJpNUE4Yko1R1ppeno1d1krdjZ2Vmla?=
 =?utf-8?B?U3FBMHg1UWVSSjIwS0I3U3JqNGF2SDUwR1FLZVZJRzBXVEZnQkxjWXR5LytO?=
 =?utf-8?B?aVhCczdQMUN5UzI1WEZFNzZzSnFlZk1xbHlvT0lLV2FGTUF6K2NIaW00MFYy?=
 =?utf-8?B?QjZtdVNwZjdqSTc3VHpZSVRFZkZzbWJ3TDhLWDUyNXhaQWQweENLcTZ2T0kr?=
 =?utf-8?B?QTIxQm4vK29YR3I5VGJYZlFXTFZWUUs1OUdnTGwvUGpGMkJYN3hJMGMrZ0Nn?=
 =?utf-8?B?VU9kTXdVbGk5dTF3ZHhrajQzMnl1cjFkUGRZMUxOdGpHRVk4d3hQVHFrVmZn?=
 =?utf-8?B?RTdkQURRNjlLcDE3TlRCNUlDYzJmWkxlb2tJVEJMWmxjM1cyV1FQSUN5RTFj?=
 =?utf-8?B?N0poOFdlazVaRlNhYmhUOTNCY0NnMSsxUDN3dmplT2tDeDcwYTI3S2RiWFhH?=
 =?utf-8?B?V0QvYmtxeEMyQ1ZUTFN0d2RickZxSWVOazE2blVFdjhrOWVJM00vaE1GRXpS?=
 =?utf-8?B?TWZoUzdzN3VRYk1wSEFCKy9HVzMyZExhcWQxYWx1cWIyeFhvT1dUMGdYcDN4?=
 =?utf-8?B?RXV1RS9GaVJXQWpkamhWaEs4b1ZpVldiK1BIZkFtQzE0a3ZwUmhVaGFndVZI?=
 =?utf-8?B?SXQzc1QzVWVqRXV3czhsbGNxenlDM0tyTkZ2M1ZlcVdWOGU5MDVUKzFEKzl6?=
 =?utf-8?B?LzhlL1huVzhPbmthaEc4TTZNcE5EU2ozQU9FRVA1UXpxdWxDWlpYOTBmM0w5?=
 =?utf-8?B?NllaVDNUampBNzFiMjBzalRBN3Y5ZFA5SWE4elZzTGFKakpXdDdzOWgzWVZR?=
 =?utf-8?B?OG03UzhwWXVQNmhsWWdWVUg4aWZ6UHgydXVreW5BN01WenFzYnpYeHVTNU5C?=
 =?utf-8?B?LytOUjlGdk01aHVxdGhmNm5QWjYxeFQ3NXN3OE5vQ2Z6ZE1BYTJrUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5937b104-c339-4ccc-8ad2-08da541df986
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 07:08:14.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR9yYseJjR+9M8xmlFMgFPnk49IBVTuqb3i9pePnGYthu2D0zfhE+Ylc8SvBMjSi2znCZ93//bHzMhM5ul8n8A==
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

Thanks Kishon for the quick response.
I just verified the other patch and it works fine on our platform as well.

Thanks,
Vidya Sagar

On 6/22/2022 12:22 PM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vidya Sagar,
> 
> On 22/06/22 11:07, Vidya Sagar wrote:
>> Register a dummy release function to avoid the below spew
>> when the driver is unbinded for an endpoint device.
>>
>> root@tegra-ubuntu:/sys/bus/platform/drivers/tegra194-pcie# echo "141a0000.pcie-ep" > unbind
>> [   55.802704] ------------[ cut here ]------------
>> [   55.802737] Device '141a0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
>> [   55.802956] WARNING: CPU: 2 PID: 477 at /home/vidyas/y/mlt/kernel/drivers/base/core.c:2321 device_release+0x7c/0x90
>> [   55.831544] Modules linked in:
>> [   55.834781] CPU: 2 PID: 477 Comm: bash Not tainted 5.19.0-rc3-next-20220620-00001-ge53d3cc05d82 #17
>> [   55.844078] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
>> [   55.850675] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   55.857957] pc : device_release+0x7c/0x90
>> [   55.862265] lr : device_release+0x7c/0x90
>> [   55.866558] sp : ffff80000c24bab0
>> [   55.869965] x29: ffff80000c24bab0 x28: ffff0000872a5700 x27: 0000000000000000
>> [   55.877410] x26: 0000000000000000 x25: 0000000000000000 x24: ffff000080a946bc
>> [   55.884840] x23: ffff000080a946c0 x22: 0000000000000000 x21: ffff000083194400
>> [   55.892275] x20: ffff000082076000 x19: ffff00008203ec00 x18: ffffffffffffffff
>> [   55.899720] x17: 6620656220747375 x16: 6d20646e61206e65 x15: 62207473756d2064
>> [   55.907179] x14: 6e61206e656b6f72 x13: 6d20646e61206e65 x12: 6b6f726220736920
>> [   55.914651] x11: 2e7473722e746365 x10: 6a626f6b2f697061 x9 : 2d65726f632f6e6f
>> [   55.922132] x8 : ffff800009ff2e40 x7 : ffff80000c24b8b0 x6 : 00000000fffff1fc
>> [   55.929587] x5 : ffff0003fdf4ba08 x4 : 00000000fffff1fc x3 : ffff8003f44f1000
>> [   55.937033] x2 : ffff0000872a5700 x1 : 45c50f22e593f400 x0 : 0000000000000000
>> [   55.944501] Call trace:
>> [   55.947037]  device_release+0x7c/0x90
>> [   55.950995]  kobject_put+0x90/0x108
>> [   55.954797]  device_unregister+0x20/0x30
>> [   55.958877]  pci_epc_destroy+0x20/0x38
>> [   55.962908]  devm_pci_epc_release+0x10/0x18
>> [   55.967406]  release_nodes+0x3c/0x68
>> [   55.971121]  devres_release_all+0x8c/0xc8
>> [   55.975409]  device_unbind_cleanup+0x14/0x60
>> [   55.979951]  device_release_driver_internal+0x100/0x180
>> [   55.985508]  device_driver_detach+0x14/0x20
>> [   55.989968]  unbind_store+0xd8/0xf0
>> [   55.993732]  drv_attr_store+0x20/0x30
>> [   55.997639]  sysfs_kf_write+0x48/0x58
>> [   56.001489]  kernfs_fop_write_iter+0x118/0x1a0
>> [   56.006239]  new_sync_write+0xd0/0x190
>> [   56.010159]  vfs_write+0x1bc/0x390
>> [   56.013831]  ksys_write+0x64/0xf0
>> [   56.017483]  __arm64_sys_write+0x14/0x20
>> [   56.021567]  invoke_syscall+0x40/0xf8
>> [   56.025516]  el0_svc_common.constprop.3+0x6c/0xf8
>> [   56.030511]  do_el0_svc+0x28/0xc8
>> [   56.033920]  el0_svc+0x1c/0x58
>> [   56.036936]  el0t_64_sync_handler+0x94/0xb8
>> [   56.041049]  el0t_64_sync+0x15c/0x160
>> [   56.044652] ---[ end trace 0000000000000000 ]---
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> 
> There's already a patch  posted to fix this.
> 
> https://lore.kernel.org/all/20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com/
> 
> Regards,
> Kishon
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 3bc9273d0a08..ae403aa54e72 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -746,6 +746,11 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
>>   }
>>   EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
>>
>> +static void pci_epc_nop_release(struct device *dev)
>> +{
>> +     dev_vdbg(dev, "%s\n", __func__);
>> +}
>> +
>>   /**
>>    * __pci_epc_create() - create a new endpoint controller (EPC) device
>>    * @dev: device that is creating the new EPC
>> @@ -779,6 +784,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>>        device_initialize(&epc->dev);
>>        epc->dev.class = pci_epc_class;
>>        epc->dev.parent = dev;
>> +     epc->dev.release = pci_epc_nop_release;
>>        epc->ops = ops;
>>
>>        ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
