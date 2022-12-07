Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D8646207
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 21:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGUEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 15:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLGUEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 15:04:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA8F2F029;
        Wed,  7 Dec 2022 12:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+wP7hfanfcgZrqzOHQq2I10yFO14czKPC0XVu5xoTlzH/sOE10jD6VmBEUwTr8xL+kpszFsjgyqlk0Oi/JDqJXVoQBDl3lGC5IBp9fg5ddugbMWhDDPc7k4L4zUPWI+0EkwWHxfEUr+XrhT1s6M6GeMYoIrlnxuUys1hU/3g1w+Cu1yntwbkZh83h6fBxKdGwNSUmfoIc8vHhRW64WmWfxc3CUV6K8ANvnm+UN0HcNr01MrBxcZqQtLYrv9VYUVj/5os7keMr6Idzkw3W/8xTwmyjrFVrnvjTDvW5GgiNr7d5CsBt8Homti4Yxoj9yolu2DgnDX4ajoMroly57lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eHfGfq37CQ83D+HPg7viIOicBZ8V3qUphqLOe1H/Mc=;
 b=IKj5thsO3Ap+oBGZq1K6s6KTwoG5+V8M0+bLtWK38PXrmN+icC21Y3BzsRNYSjK+vcaRL26jEDHYtRx2GULbB/DId/b9GpzctzjVm3Tt19IX6f8FLFC8qwg5We33ST0XCorPLgNKjrfFqKdsovjgf4EShlBeJ3Vo0OJ6A33P0Jc7oK247j8k4Fi5+p0yqpiE6ijno1q/J6E+faU4d4B0ecTyYi4wpPGy3PruUbdZG/D1EGmd33LheetazfB3Jk8DAiH0ZYMIILg+vyMgb2H6vpkqY7EK9ezBRoEIDWVZP3Hb3hCZzS2ARJgCrXt1S+VkaP6Guy0FVXbn74Zhu9yS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eHfGfq37CQ83D+HPg7viIOicBZ8V3qUphqLOe1H/Mc=;
 b=jMOHiRP1ECcSMy17PmKf0Jy/b5GgRI8JxWPq95YyOUf9j69KJKuIni+hIPUl6pt2ZNM+XDzqHelBIYLQZSGGrOLP93ymV2ViqyKzQUTNIlfvE1nB18JrAeUVv7xgKiHt3/NGA/Rpu/DazkT1BuPH5kvSoUXXCVx1f++OcGwRtZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 20:04:20 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::6b84:1aa9:19fe:71a1]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::6b84:1aa9:19fe:71a1%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:04:20 +0000
Message-ID: <59c6e507-f67a-6ae5-4b3d-d836d86d5c0d@amd.com>
Date:   Wed, 7 Dec 2022 14:04:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v6 11/11 PATCH] cxl/pci: Add callback to log AER correctable
 error
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com
References: <20221130224714.GA846634@bhelgaas>
 <166985287203.2871899.13605149073500556137.stgit@djiang5-desk3.ch.intel.com>
From:   Terry Bowman <terry.bowman@amd.com>
In-Reply-To: <166985287203.2871899.13605149073500556137.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: eac74960-9511-48c5-93c8-08dad88e3a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gJ1ia4TouBZj6K9w6USk44j63S7sGmlQTDPErx83J0osPoM04wpd4DlNJdiDklXuKtgVvp6tK+kp/6PcYr5KthQ/bmIZGf/7rnCYdgUhqUQcnguGmfsec0AhiwIKghFoD6reEwL8ceYZhuXSWMmncED+rBsFrjLJKEI3Gv1p9yzudhuvuvzAl2VE91ckB0vitBLzCPjzP2dScE0q9TUGd5njYbNLpX96TCkddItXijO2EJ5BFGIOjzSDnwI8L1SDSZ2vAovGXEb/lKnTcVg/0V63f6kr6nRpnCDnaTjj+EQNZ23M0QeZh9lNEr9XHRMuZwGSQOAC3BypZbAu0wHLs0QnCT09VrHjcQBI7zV1FGaQtBLXJ6WgFJghEH5lE+wgxMT6UMyL2uqbKpG2PEFxIfeTiJDDllXCsiekncnJXCNKjD683j6JF/S8mpspqmDhli7crSLAfE80XejQScnNhSEstwJySjgRmtVF8be95220nr+d349/35fnElniKGYtgFe/8qLm9pv8pfIUDJMsY6Ys93dQ6cs35GsNAKtDXKsTfga8AC4yAOT2ZvYKOSQPH+kN75s3Y7nsHlpCfn4IRP6entfHLv/xE16sAMpinE34ZS6jiaccge6PN8mj2o9YFx0y9fzTAXYfGrOtmWxseYJg/pLtIJeMIbfQ9LGBYe/kjNLp/0VeVK5oKWbDQPp40KIGzELQHlqUyUut/s5dsffXyoxme1WUGE7Mr/iunA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(6486002)(2906002)(66476007)(478600001)(44832011)(4326008)(8676002)(41300700001)(66556008)(31696002)(8936002)(5660300002)(86362001)(66946007)(31686004)(6512007)(36756003)(186003)(26005)(2616005)(38100700002)(83380400001)(6666004)(316002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01YTndwQzdtelM1UWVaRHVjVXdPZDdybzVDRjhxdkU3ZTRrZy9lbGFDY3Ev?=
 =?utf-8?B?cEhrTVJNcDVZSjAyN0d1YUQyc1B2L1l6OUVjMXZWQWpQT1R0d2dZSlo2RTVq?=
 =?utf-8?B?dmNxWlkwd2FwL1V5dG93WFZYNmdWdERiZEhDeXNkREhWcHdZMjVkN3Nob2Y5?=
 =?utf-8?B?ZDdyanJPYVcwanRnOFowY2cvTEZnN2JoL3gyVmJUbk5aOHZCWWZ0L3g0Yllo?=
 =?utf-8?B?cVR6SlF5MU5xMjl2dysrZTViT2FaeW1qVHBkSjhXSXNvU21GQ3R4dTFwZElT?=
 =?utf-8?B?bUt4dHZNMzRoUUNuTERjTkVjREtXQ2l5LzBsU3NMb01BTTJzaStYUk5iQS9T?=
 =?utf-8?B?bVhlb09qSHRreU9hTld6bDRjMGRpSUhjSWxOeGpBNDFEbGpuWUQ1OU5nRmdn?=
 =?utf-8?B?U1FBUlpPbHZsbzY5bmdGcmsrT0JoNmluTDU0djFBNC9aWUlBRytqUmN3eit0?=
 =?utf-8?B?SGMvWk1rMDlXaGNCeGM5d1p1YU9qcmJ6UXZOZmhaTElBckZPWjVwVE5Ha3hu?=
 =?utf-8?B?VWhqQVpidjZoUWFTbmE0Vy84aVdzQ2xrZDlRS3BhTE4vaWdIVVUyYUlJclFK?=
 =?utf-8?B?bHkyMTZhbklJeHE0NzlaZy93WFBkR1VJNHdUQ0cvSG95dzNrL1k0eStmYU1B?=
 =?utf-8?B?bTRsYlM3TUJERnZxV250TTlJdWJMeDVwUk5MaFNId1MwK293d0JJVldpbkFj?=
 =?utf-8?B?dmVwK1FiSjFBSytwUVlxeS9hOGtyYkkwZHQ3OE5OZW94aU1IMk9tT3liMDJJ?=
 =?utf-8?B?TE5Eem9hZEMzQm5sQ1FQUUI5UkkxaUNRbGpUQko0NkJCcEtKWFRzRllPWW9Q?=
 =?utf-8?B?TWNUWkxhTHVlSXFwRmYwWjV0MTZtTnVNdjk5ZmpXaE9XVG13TGxTY2tKVjNB?=
 =?utf-8?B?ZHNndk5wdVp0bEc2ZmpPeGxYaEpJT005OWJhcmRma0lTdWdqWFgyMEtGdW1U?=
 =?utf-8?B?dVhPdWlqN1ZKeFlrVWtieVBHdXZvbXVqS3Z5Ky9XQkVOdmxSTGNORy9vTGp1?=
 =?utf-8?B?OWxnd1BsOWxyeTJ4NnhIOE9CUXRoUUczQkRLck41MTNIMWF6dUpuR0xsOXgz?=
 =?utf-8?B?MHJxWW9XVjBLVE94MkRtQ1V1RCtRQ1J3Y2hGbHd5dnY5Y1lJbng0OGV5cUFM?=
 =?utf-8?B?dE5BbE5iQW9XM1NWNFRxTU05TjFMOHdydjJRTG53eE1qWE1LOHM1RzdOdlRy?=
 =?utf-8?B?U3ZUeWxtYjE3VXdFV3ZRNFc3Vk15NGgvY211SVJ5WU04RWlXZEM1T2xoMVJk?=
 =?utf-8?B?bVpCWUxiQVpUeHAweUZDYWlqYWI1RG9FUnhLQVQ0S2hNSlJ4aFlPRlVmeU1G?=
 =?utf-8?B?NC9pNVF0d0ZOT2pycDlucmQ3bzJ4WEtaRzg1azdFTzNQYnBNY3lmcXAwcENG?=
 =?utf-8?B?YjBOOXB5a3hCZGZyN2NXWHFUSElhUnJULzc2RFhDTURXYmNpL0xHUnlZcjNt?=
 =?utf-8?B?bkUyb1Z4Y282TUZCbmZ4RGlSWmUvS1pMcTRwZDFZSklpejV1V0RpS3pGSFYz?=
 =?utf-8?B?RjhqbmE5UHpZYm8wUGNLZHRLVE5tNU8rU3prNzhTR3JhMmtYMkJ1eXZ2SGJx?=
 =?utf-8?B?d1kzcVBJQVFlb2tMNVh5Nm1rREZ0YmhMYnlpL2YvbmcwUnBZSFpuanlOZldk?=
 =?utf-8?B?ZTdVWDZ6bVFrU1UzYWxkV3R4RXJKaFRyVTZSQm02d1ZzaXFwNVlCQk5ZTk1D?=
 =?utf-8?B?VS9xU0FTN1pVcGp1ZFpGbTlFS1QxUFVRRUtUNC9RZCtNNDJzTjhiYkFxSDdE?=
 =?utf-8?B?cFVRNkZBT3hhdEFUTXBtUzZLazgrRjNXZHFVT2s0QXJXZXdOdFZmSVZYYnla?=
 =?utf-8?B?aGpQckg4VEUrRW1ZeWtZVnVNd0lvUkJRdFV4SHNwS1hmWldPU3V3REQ0ZDJL?=
 =?utf-8?B?SkdZb0oyYUIzbG9BbCtwM2hJbWdKUm5HQjRxUi9BL0ZPS2QrOFpLT3pIa3N6?=
 =?utf-8?B?VldEYk9TSGZhVlZVditHemJTbUNqOHNvRmZEcWxQWWk1NHdZc1Q1WDIxcEND?=
 =?utf-8?B?VHMvSDR5Qnp1UVRIU2dPZ090SVYyRWtpc1paOGdXMnR1bkxkaWgvR2M3RHVx?=
 =?utf-8?B?dnN3d2RpZjczK2RkVWZnRVhLc0R1SlV4ZkxYRG5kVktuLy9HaHBFb29DQlBJ?=
 =?utf-8?Q?iBktM1RpIgAhiqI9U+LJCMrFa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac74960-9511-48c5-93c8-08dad88e3a9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:04:20.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/kWbeYxfcLdy06HeLJn3COjRjeoudinHMbNNfReQkv0OImBVoTpbewYdBU7RGGPPycj33FnbQahiKH/K996Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dave,

On 11/30/22 18:02, Dave Jiang wrote:
> Add AER error handler callback to read the RAS capability structure
> correctable error (CE) status register for the CXL device. Log the
> error as a trace event and clear the error. For CXL devices, the driver
> also needs to write back to the status register to clear the
> unmasked correctable errors.
> 
> See CXL spec rev3.0 8.2.4.16 for RAS capability structure CE Status
> Register.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> v6:
> - Update commit log to point to RAS capability structure. (Bjorn)
> - Change cxl_correctable_error_logging() to cxl_cor_error_detected().
>   (Bjorn)
> 
>  drivers/cxl/pci.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 11f842df9807..02342830b612 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -622,10 +622,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static void cxl_cor_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &cxlmd->dev;
> +	void __iomem *addr;
> +	u32 status;
> +
> +	if (!cxlds->regs.ras)
> +		return;
> +
> +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> +	status = le32_to_cpu(readl(addr));
> +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +		trace_cxl_aer_correctable_error(dev_name(dev), status);
> +	}
> +}
> +

This will log PCI AER CEs only if there is also a RAS CE. My understanding
(could be the problem) is AER CE's are normally reported. Will this be inconsistent
with other error AER CE handling?

Regards,
Terry 

>  static const struct pci_error_handlers cxl_error_handlers = {
>  	.error_detected	= cxl_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> +	.cor_error_detected	= cxl_cor_error_detected,
>  };
>  
>  static struct pci_driver cxl_pci_driver = {
> 
> 

