Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC988602442
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJRGWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 02:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRGWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 02:22:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6C89945;
        Mon, 17 Oct 2022 23:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fofPpAW3XCsOUM1klDgIRSs27dbBIxugmNp1+ldzLQMzEB2M5raOfun6sC0sOIcb9vZUoOItsEJjbURvl8NvODzKokHkmlcsTJ9KAwCXBPJWSxs5H4HU6FjNPbNJCtmxw/jbIwbgmqZVgEXnv6A1YeZfQsCEd45aYc+7qXVGdb3Npdi06/Ha4QdJivBEsq9nHT/UmyOnZcJHWNvqCm1EdlrLl0+iVHk6GdC89zpSm0B/B0Ed0Tx4Itx9TYMBHRJ3rg7c24N8r+jnUisAEjHEbWKhZe/YcjhLNucY3fU5NMVjsjr9uY3bp/C8bMjGw+m0oebBtiMJjoC68jQ9kidn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH4UXjRJHAmAYXsdPcSgYvb2YwxObF93kRhN/TioLng=;
 b=C1LgAedRJAbbWWIZaTF23gYnFIm3DHsTXvyh9lvxc6dWWmPe2DcuBoocJThiWxb/A1l+VDCPdXZCKW6oeCdckPpDnMT5k+a3HZrzJSBfQAoWo/sy8Q/KJ3O+nvKHqMt4BY/xhTqvolBuKIltI0mzn95YhjHWU64UNMq+L0jS2bWw/urFt2Q8Edo82zUHgtMZW975uIZFUAJSByAVKl8FxQ7qrw3DqUIdWtHj/oqCngjjHxBYamMD3l6zMhC1MF64ntcZW6fDDeMnhKGIShifJbFUZNXNloUrKNue2sMQb5PW0zJuIAHtrUmdlhUYKm8d56DqIwQbxv0lt2uJxVp5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH4UXjRJHAmAYXsdPcSgYvb2YwxObF93kRhN/TioLng=;
 b=D843b3qPhU0PqLgm9pmt4GkcKfbO4crGnDDTRlOKLCokp6mo4vL6CfQWCqoNMKZj2OgQdVSGGIFVIrCK2g8h8bd4y67QtIjP8uA46lol48RQtE0Fubz/eOAbmtf+CqrfaVNDzOM1M+/TZJWR4Rj/7WDCKJbqVVLGI0X4OovIlp/uU0NDoTa/0ycOxAJavtNj3rmlPpjSFyYeEPFSriohHpoTHI0jgOKPAtmAqNMqiU6e4ovO09C6dlmRAKLS1DlVWxE5Bcsbi2HscVf7fswfI6xSHthhkBGfKgLRLVeMqiaAm/2+vNsID5+oTtRh+B3Q9nEVFFKm/EU3Z2gk6Tr+Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Tue, 18 Oct 2022 06:22:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 06:22:02 +0000
Message-ID: <49834f69-0e6c-70a6-ef70-5563fb5e9215@nvidia.com>
Date:   Tue, 18 Oct 2022 07:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220913101237.4337-1-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220913101237.4337-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: df174422-0716-4d0a-8144-08dab0d111af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjRjMHjFBRkoDaiKCSEW8KPrUilnXEcN9drL3wWO1h7JvHsBS3fJNkL4Xs5zKUho42ruD+rVlS3MOHHmX+2qOZzAKRrL4yzFgItFg+oM9FcamEoyzIulG104ldUM+VucZX1ag99P4oOJzxtJU6zZ6H/CkqFuamCQSlK/VWq1ULxsKgoTNf6rcSwbdxV4iERn/ziM9nakntLM798/38+4ssjcegQYXqDD19vYUipHRR2YS//wz0j8ruXMAyX30xg62ITGAf8V+jLlV/2yL10Qk3qzxJxgp4e4RxoFgxX7E3o9norewCAChX75X7U8w7A1tYbFyn6gxiS/G9CP11Q7LLowIkUieDVhvFnn69rQiiVtmzrQiofnOaQV0i5ie78LFEm5qOvgxXk52G+bTJTwnj6SkGFlycD3eeBxG8ElLi9/NW8N9OC0zHHcCvhnmvnKpCVHkdFVJodXL2NJT51bc9+OEzmGAaqECzPtEw5KNQWCWPfD9zWHdceOy6rFlUQUKa4GxEdvf4Kw5MHn3n62wGCJBrYOEGAm5vJ9x7Zsd631/LxmnPRR8Y4LKe6V+58h3ycKfbRWP/N8GoviJCC8eGSSr+w9V/KHXIG++wr41+pIx4+J5rEBzOvHwXr7SjuzOtgsj5BxychyBqWCYYukYXJiiQ2yos+j4JjVGKitZDQwOEdcg0vY+1CfCCzdsdpx0mAQXQTLDR/Yt/ivAB2GRUNOhUFrSccMJsm0VFGYFzLn7UerDXe+ReaQLh+6Hhzvs0tFUq8xzz8pGlPbP7++kPqVIOGWOq/3j/Jcpz2IJDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(186003)(316002)(6636002)(36756003)(2616005)(4326008)(6506007)(2906002)(5660300002)(6512007)(53546011)(8936002)(83380400001)(7416002)(41300700001)(31696002)(86362001)(66476007)(66946007)(66556008)(8676002)(6666004)(31686004)(6486002)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk04NWpUTlpNdHZJOS9ZWnA4Q0drYWlRZE82REhGWm5DeDN5QlhGdmRCYk52?=
 =?utf-8?B?WmhFb283RThSOHJaZkhGOGthNjNGeTZWVnJ4anE3Qjd1bEVsWHhReXNzV1Z3?=
 =?utf-8?B?VUJOc0F5TkprR29abFN3azhrVHVYSmhCaGZTTUhCNzFERFdHSXJBVEZGanRF?=
 =?utf-8?B?cm1iSzNQUm9yVUs3Qk11bFJlVmJqd0RjNEZDbU1KcldaR0JudHVMNlZvQkN1?=
 =?utf-8?B?eUM2OE96dGFQSVJucmI1NEo0bUdub3hvQnMvTXpZWHhJRXk3MHhuTGFoNmFP?=
 =?utf-8?B?YTQ5T01MQmtYWmE5UUdBM0pBVGlmcGd3eDU1akpyZzdlbjN4REY4b1FOWGdM?=
 =?utf-8?B?czZKWWZyMi9TZkJFTTdkSWR6bXJQMlJlUVFOWE84bTdpeTJaamZzK1RYYkI3?=
 =?utf-8?B?YTNjTVlNOE9pTWNNRmhtK3A0bGJRdWR3UTM1SmpCcUQwS1A3ckY4Z0xpM2pt?=
 =?utf-8?B?eDBTbmNKWEdEM05wczhiZnNqZkpGN3lJZEtOR1BxQlVkcHBlS3ZuMkl0UHcz?=
 =?utf-8?B?TFpnYkU4SlJ4M3V4K0hNOFl2clFzVFhVSlpyaTNtN2tTcFZ3MlBjUUdPNXNS?=
 =?utf-8?B?S3h0Wis4MXlacHA5aE16eEVxdE1hRXB5WXhELytWR0dnR3JBS3lvS0xJNzJF?=
 =?utf-8?B?OGwvM3RUQ3pCVGdabVJIc3k0UWN2bmhvbzcwN3hHeTBjK0k3b1dzWldxU3dG?=
 =?utf-8?B?Zk1SbC9HY1RQMys5ZUlJYllibTN5MlFwZ0JmNEpsUy9ONEhTQ2d2b25SNGI3?=
 =?utf-8?B?dVFKUWh5dTk5U0ZWaHlqRWVmRW1CSTFiUmdUR2U3eEJXWk83d0s1TmR0T25u?=
 =?utf-8?B?QlZ3WE9kZTQyQWpJS3BJakYxS3ZDYjhYVDdxR08xUXZQWGZDQ2pWWXZRUkpC?=
 =?utf-8?B?Zm1ndHFBSTFNWjdxN3dtbUNCSTRjK2Zkb3N6UFNQNXB0bDhaai9oTG9ER09w?=
 =?utf-8?B?bGNoMjNWUzJDU1BWcE1QWVlaWmJwL1hxMzYrd2ZscjJwUmhPbzlubExiNDda?=
 =?utf-8?B?eE9JSXNDMVVnZXZ4TEJUWjRPMW5QY25wSDZ0a1JCVnp0S1Y2V2VFdWZPKy9F?=
 =?utf-8?B?OEVJRk5MTG5vQURGU3A4RGxxZUdJNXM4NHpwU2Z4T1NpOVMycFdGa0x6cUIv?=
 =?utf-8?B?TGc4ZC9sTko2c0NHRGZBMUE3WkZndkRtWXlacG9wODJEU0NRbEI4L21DU25H?=
 =?utf-8?B?dEFaNUwrTzhXQW9uZVdXYVFjY3hwRzVGWGdvaG9JTVVCZUxEM0lDclNGalpR?=
 =?utf-8?B?YnBNVStValBaT2JMdXdud1ZiaG9rM0lTT2pGMXhOQ1B1Rlc1TEFVT2pyK0ox?=
 =?utf-8?B?T2tOMU01aDR6dklIL2xFVWpKUFJ1UTQrRStvelN3TEE3M1JacnpFK2JVWnJr?=
 =?utf-8?B?Ym5lbHBzTmlLSlVwTHczeUJJb1RJUS9MbU1kQWMxd05VaGxKaUpPR3pKVGNa?=
 =?utf-8?B?QmxmTiswZ3ZwM0l0endRQnBJK3VGU0doV1R5RWdSRHNTTVNEdFo5N0ozRGth?=
 =?utf-8?B?UDg0eU9NSGNnMkJkN3RTOFRJREZuU29nMU5ldXRGZWl6WjB3Z2QyWi9uTzda?=
 =?utf-8?B?TjJRT0ZOR0trbXFua25maXZLS3lJOUo0RUlhdDRkUnJrVEpYdGZEWStuMVdk?=
 =?utf-8?B?akJxdU5nZXpuT2tlU0VaZXQxUWZkRnA5UW83SUJYYURvYnV6bnJObElORDU4?=
 =?utf-8?B?UDVieWdwcU5XK3d6ZzBJV3JDaVR6WHRiWEl5WmpXdlN2dldkYjdDNFdWbHZt?=
 =?utf-8?B?bWZ1eENrQlBtTHQzbmIrdkx0WElkelQ3VzF5MldVZGx3SFFxQkUwZk9DQmQy?=
 =?utf-8?B?SlNyL1JEZ3VpVUtyV291cTdoenVhWnk4YnUyck4zRFBpYTcrMk5pN1k4RlB0?=
 =?utf-8?B?Y2hkb3czUlhaUFVlVEVjS2ZBaUkrYmxmOElHaVhtaGFLZjlocHhHeEtiMXRP?=
 =?utf-8?B?OU9mS0dnbFhQYUJuQnplZ2tFbkJxd0U0OGRrMWF1N0FtNjF3djRWQ1k2aUxk?=
 =?utf-8?B?djgrRUVIa1hKZ0RIcnQveEpHd0tsQ2ZjaXRNaW1Gak9Cb0NYR0JoZFpEQnRu?=
 =?utf-8?B?NUpOZ01jbmVsSFN2U2pXbm9QRm5PR1hNcnF6SFpLUXd0OVdMNUxpM09SNi9i?=
 =?utf-8?B?S3UxcEpwRmVwdVJnWkRBOTZ4SUN3MDFEcE5qSitoK3J0ZW1ibklYOFBITWVQ?=
 =?utf-8?B?cFVCYUV6WUhaNnZLUVF0dFBFNkZ1RDhMSGpLMVE2dWFkaUlDMHpUdkJHNmFO?=
 =?utf-8?B?YWJxOUttMEppdEtiUk0xbGs5UmFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df174422-0716-4d0a-8144-08dab0d111af
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 06:22:02.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZF8f/w00a1nqR3VeSPz8ldEyYXpguJt4GIZul0GJ7i4hBhHYw7jH3JlGq5NKfWn03TzGCgK5dSW717s8yN1iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 13/09/2022 11:12, Vidya Sagar wrote:
> Some of the platforms (like Tegra194 and Tegra234) have open slots and
> not having an endpoint connected to the slot is not an error.
> So, changing the macro from dev_err to dev_info to log the event.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 650a7f22f9d0..25154555aa7a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   	}
>   
>   	if (retries >= LINK_WAIT_MAX_RETRIES) {
> -		dev_err(pci->dev, "Phy link never came up\n");
> +		dev_info(pci->dev, "Phy link never came up\n");
>   		return -ETIMEDOUT;
>   	}
>   


Are you OK to take this change?

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
