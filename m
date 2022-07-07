Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA4569E4A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiGGJJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGGJJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 05:09:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AF1D30F;
        Thu,  7 Jul 2022 02:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZdB8qh1T4/kgk5EUo6DHTD1XFwXnMB750KmHPiQ0bIU4RgvMMwpSX1nv2maeWghgpcxg6rplR/dSOnd85biTZ/UWrBakKifESCJViBxgvTpSEtJg1niAxSsjtfswTQLXAEqTobYr7kkVX4F3etqSxAwN4gzgJn0N9tnpPQOz+Abzju5cX1Yze3vFHGt147LNzKfJU+rZfVy1gX9bHDQZNktnFijjswg+1gP69LPSz2e1yhGRw7gH3sr/uecd/m2LOXBq2WRtHM9CWdY7sMmEkxcQEcb1WYLIEw1LYf0rDNibMqB4QWWgTdnABKJdlfN/zY2+oZtiWFqMe7aTeNmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryOuf2/oSMKO22SiFIdWKjzU9qjqgacKOeo72IMqXF8=;
 b=IJG2mzpdDEniLwqsMCbwdAzuhLWNF8QV9R8yiJ46uzKrYanTJfgztW2CKChbubqRoHOyfly0Tb9spS4NGCxXxY2fWAiVy0wrtreshh/9dEh4wgIbKuq307rp1S0x1qsoDsEBQ+QniFFrgX/6xTYIpXtwnM3Hq3n+3nM1d+U54qRQ83GLthKLHzjvOGk7/GyTfU7T99MWxGNQoa3IJ+GsGFPy10cLiu/Uzz2vXC4JlPpTElLNoTYK4DTX+vByuvwADG2smzgZhMd+lC73wuuthusoCxQxtQscItH6gGeOSQSxw0MZJ2XfvyjJe6mHOATMHN0NwEOUh0bg7iT+ctKhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryOuf2/oSMKO22SiFIdWKjzU9qjqgacKOeo72IMqXF8=;
 b=Ktii2XQ7J9OcKIhddz90OCU9XzCdh01QttbO3texR6Thz/gz0T0KEUkiNsMHucJKTUQNN9RLlrFAuG2+o9dC8xdw0aho6Esj1o9OqQo5mhjRKP9ItI2bDjPIc9uRS1dU7da8VxNij8O0K8KQxvlS/13bLqT6jSnQUI8VtS/lhTDtBzcWKmFYict4KGrYLsc14d/gn6X3g+oSYAHJIvrrXI9zF9FiHWq6PSKMFUnPY0Em19wlwvF/Xq9MZIr8yCsHwt2ZAFnZSESnNS/xVpsS84trQoAYRk+zqr32pHXSAhAj145CC31yb/hyicv5aW7gXZOxzwwdGe7I0eLmBGBbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH2PR12MB5531.namprd12.prod.outlook.com (2603:10b6:610:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 09:09:19 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 09:09:19 +0000
Message-ID: <5c36260c-6bb6-7eb5-be82-c60cd927c02d@nvidia.com>
Date:   Thu, 7 Jul 2022 14:39:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Content-Language: en-US
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220622040133.31058-1-vidyas@nvidia.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220622040133.31058-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd301f66-8346-482c-049f-08da5ff85fde
X-MS-TrafficTypeDiagnostic: CH2PR12MB5531:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1/Ca6ApgrYasfwuDDdsVZr1yDJUNK+TI8kWDv72QyleoZOd/RIzByYO0Sz7GIit0znSc9aLkVdJZdZB2hesawfwhE7hf/6prALjnqSJ6YaSRgvHybBdpQh3XZPH103YDJHj8yOiYkA/WGleKoa7RXFJHeCPUFgBYHE2mFnCv0CrDzoUi6Zf62jFlGb3aU7ZQfTC93QGjrn83a3K3AKmsfcMjisxHXrWzR8gB8xcmTH3vzlFfouG+lzg1Ujxi0L4jOqOspuqNX+w2bNKoZnzgQAcWqMzw/9tpbCtFDCw/3cFfr9ftOeN3u0BfjHOXO/osMJkBDbzI3vBqtjrslR0uOqysoTlPWCWCH96wzEZPD9OAuWPzgLGr+zHjd47uZ1rLhh7fkbUtv2+aEX1zP8OleM4fsWWROqBZ8L45k2lNg05AYRK8tK21UaRC3D+L7Tp2iRtSi1Ptg6IFh4Mtsa4HubhRpcZSNGmT4OljBVT6Kja5mgVTfEY9bkEob7NhiVmsmkVEA2oze0Z0u7ayG69TrkLEEjbRUJIRxkxZAqKomkCE7/65l1SGYaKR0sOQjFc3oddk/DiREvRVnA+O7hY9dAbpUGK4DJ2lQGZX9NCkyiz7dz2QSTHeN/caKekOKOd257jrMMC6CDCaJfKadXfJL2jPttspS6chlsEQwZ8W387iqyuYRi1suedGu3HP0sUCrYK8N4+MitqDXX4YF4tu8yDPVwukFe04qBJe8SDz9+46VSodiElLtoeKxuHnc2Ey5AQB+o9k2nMy+E+THc4Seen05QvkW0nCjyk6TVLytUQlRB46AS2Y3/NP8vB5XluwE2p/zQpedlbrBX559AAmzwNPjBS+KFTI7TclMKh86s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(316002)(83380400001)(186003)(31686004)(26005)(36756003)(6512007)(66556008)(66476007)(6506007)(5660300002)(86362001)(2906002)(8676002)(31696002)(4326008)(66946007)(38100700002)(478600001)(6666004)(6486002)(41300700001)(53546011)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpXbHZjUWxDM2RzajkrTWEra044ajhjdEZ2ZkEyTk13YnBMQ3NiSXF6SmhX?=
 =?utf-8?B?MTRnL2xpTFlPbE1sK05tOTdwcEVlZ05rY0k2MCsxVTQ1b1padThsb2JhRnRF?=
 =?utf-8?B?YjhnbHBlYnlwdUljUkRBanFHYVRMa2xSWXpGenJBM3ZDbUhmK2hxS2xUSUlz?=
 =?utf-8?B?NnhBcHpxTDlFMWZ0NWliYU1pUXZRMDVHWUdIc0p2Rm9aSi9nZXlWOElaUzVj?=
 =?utf-8?B?OU5sQlp3YldEaHFaTGIxcDBXRHdoZkV5MUZxRHpCWFpuVXYrOHUwRW0rb0lI?=
 =?utf-8?B?OVgxYWtkd1Z0S0xTeTBZWE5VN3U1YkVONVlFVHgvb3M3R2ZHZERxcDFjUDNJ?=
 =?utf-8?B?bUxmSCtMbmFTa3dWYlB5UHVsWnlYNkluWW1UbW1Ibjkya0NZWUZrNzNBUnUy?=
 =?utf-8?B?cWhTempqN1JxRjVVM0VoSVE0d3ZvV01ZeXphb1plbE9SYjc3VHRXSHF6VUVK?=
 =?utf-8?B?Y2lhVExuaS9GNjNLS1NIUDZXMTNZeWpSVzlnQk12aFZtWlFMSUdUSFBNTERu?=
 =?utf-8?B?VGcyRlhvM2J3RjY2VGJ6RXFFWjNNemFvRnBVR3kwZElHRTdNT2psbzhkdTEz?=
 =?utf-8?B?WnFUTUdTaHhnOUo2b0VjWDB3WTJBbzRkTDNyTDhoNTB4UkhoZnFYQzhaVENW?=
 =?utf-8?B?S3FMaFlmZC9xa1lucnQ1VDduQ1lkNVlRQldCRGlicDNiUUpKckUyYnl2Tm9o?=
 =?utf-8?B?cFBsZjAwbUFUY1htNWoxcU94cGVBRGJxWElkM0VlTGdZakZBbSt5YUR0K09U?=
 =?utf-8?B?T3lpRjlWZm9RaWV3VGdTZjBtdW54eVZxK3pxOVcwMXJ0NzFDVlVtTlJuU3JP?=
 =?utf-8?B?SkZNWTZOekQzUkQ2dWI5TFRWMG1tU3hKRWpUMU5BZmN3ZllVV2EwL29iUW9F?=
 =?utf-8?B?R3p3d3JmOHR0c3pXdVZSaENtODRHWTg2UDk1YklodlF5TWtyNFR4Ky9zY2lU?=
 =?utf-8?B?ckg4WitiSmdCakxTWUhiZE93cm9uQk5jMmp0T1RWZXhpWnhMZTdJb2U4OGNt?=
 =?utf-8?B?TzdpOThVanVXNm5wamVoQjNiRTFXTTJKSkhQYnpBTWtyZTdybFhuS3ZsV0tF?=
 =?utf-8?B?RUlueUhybC9STWxZaXJaVERpRG5RakpwSm1tTzc0Z0x1UWt2cXdmYm00YkdQ?=
 =?utf-8?B?QXdZODlqLytmc2FEQ0d3UlIraHJscG1mZk5oSmxLdXdGdmdOZjdnc1VENFNG?=
 =?utf-8?B?Z0srS2VOK1BUM1UvTStQRis4MStlZ0h5VTMyQ3VNVUhtbjBWN0E1MHJOV2hs?=
 =?utf-8?B?VVk0bTEzQWoyVDA4RmpSUUh6TkR6b1k2dG9rT1JEaGJLYXBJTDYwT3JpUzZj?=
 =?utf-8?B?Nk5oQUtLdDY4bDFBMlJFQ2FxeEN1a0FXSzVhdEwwVVBYUGlpVzVtK2tzODlv?=
 =?utf-8?B?QVM1R0VkM1UxNm44UGZpUUJ6UGlWOWFaTFQyVkpKeWI5SWRCa0ZlYlRQaU1T?=
 =?utf-8?B?dUNETkM4c3ZURzBhUTlqeGFJOC9hRFNTZFJ1SkUvZDM5WEs0WTlYWWJoKzNU?=
 =?utf-8?B?OTYrdEZ4ZTRmd1dRa1kydm9hSndkUk5JcnBCazF3b1hRV3ZmbWFRWmk0aFpo?=
 =?utf-8?B?TVl3UXpSTzNyOC9RdEVTbFRxRnVxbDhmZ1lTRTVpSkZ1NldaaEJhY0lCYnF2?=
 =?utf-8?B?eVo4bTJyZ2FnanhxMXF5c20xRk8rTHBCVjBsazZCakEwVVFISkxETjZkdUlu?=
 =?utf-8?B?Y3JSZFltMnBvME54UHk4RHhvdExZeWczaEdja1lleWNTM3NDUFlGZXMvTDRB?=
 =?utf-8?B?WFZsMXovOUcreG1GTlBYNU10UHVCZDA1MWpYVmFjYjdKK2s3SldYYkFtWVJk?=
 =?utf-8?B?T3VzMFJkWUg2V2w3eVo1UmtIYjFiZTl6S1UrVDNPYjFzVEpLcDJWUmhmZ2hI?=
 =?utf-8?B?YWlaaStlNmRlSmlTRXdYYWM3Y2xpUG13VURONzdyb2xmQ1JFR1h3TXRQZUVG?=
 =?utf-8?B?R3VZdnRzNHVTYUhnWXhxT2JIQXV6SHlEblVmZ1FKSjQ2Uzd3VlNTL085Tk03?=
 =?utf-8?B?TElKdUtyQ2dsTk5qRUV2TVZheCtGVjNHbERTcGVIOFlrOEpwQ21QS2dQZlVV?=
 =?utf-8?B?Wi93eGxqZ0hZT2thTXRsejFwN3loTmdKUGo2eXdEWmVIVUpyN1FhWTUrMFlu?=
 =?utf-8?Q?UUSbjedD6VHmfOxXWfZ8UQWic?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd301f66-8346-482c-049f-08da5ff85fde
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 09:09:19.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKjQHyNWClPKtHk0KiNa0I5NRD728hsIpL8TwzKeI7Zz7QtdfSQzlHgeaKVmXWOAy0KFzNsMMBWjSNWdKfojZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
Anyone has review comments for this change?
Without this change, Tegra194's endpoint mode is effectively broken.

Thanks & Regards,
Vidya Sagar

On 6/22/2022 9:31 AM, Vidya Sagar wrote:
> Platforms that cannot support their core initialization without the
> reference clock from the host, implement the feature 'core_init_notifier'
> to indicate the DesignWare sub-system about when their core is getting
> initialized. Any accesses to the core (Ex:- DBI) would result in system
> hang in such systems (Ex:- tegra194). This patch moves any access to the
> core to dw_pcie_ep_init_complete() API which is effectively called only
> after the core initialization.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
>   1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0eda8236c125..9feec720175f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ep_func *ep_func;
> +	struct device *dev = pci->dev;
> +	struct pci_epc *epc = ep->epc;
>   	unsigned int offset;
>   	unsigned int nbars;
>   	u8 hdr_type;
> +	u8 func_no;
> +	void *addr;
>   	u32 reg;
>   	int i;
>   
> @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>   		return -EIO;
>   	}
>   
> +	dw_pcie_iatu_detect(pci);
> +
> +	ep->ib_window_map = devm_kcalloc(dev,
> +					 BITS_TO_LONGS(pci->num_ib_windows),
> +					 sizeof(long),
> +					 GFP_KERNEL);
> +	if (!ep->ib_window_map)
> +		return -ENOMEM;
> +
> +	ep->ob_window_map = devm_kcalloc(dev,
> +					 BITS_TO_LONGS(pci->num_ob_windows),
> +					 sizeof(long),
> +					 GFP_KERNEL);
> +	if (!ep->ob_window_map)
> +		return -ENOMEM;
> +
> +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> +			    GFP_KERNEL);
> +	if (!addr)
> +		return -ENOMEM;
> +	ep->outbound_addr = addr;
> +
> +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> +		if (!ep_func)
> +			return -ENOMEM;
> +
> +		ep_func->func_no = func_no;
> +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> +							      PCI_CAP_ID_MSI);
> +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> +							       PCI_CAP_ID_MSIX);
> +
> +		list_add_tail(&ep_func->list, &ep->func_list);
> +	}
> +
>   	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>   
>   	dw_pcie_dbi_ro_wr_en(pci);
> @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   {
>   	int ret;
> -	void *addr;
> -	u8 func_no;
>   	struct resource *res;
>   	struct pci_epc *epc;
>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   	struct platform_device *pdev = to_platform_device(dev);
>   	struct device_node *np = dev->of_node;
>   	const struct pci_epc_features *epc_features;
> -	struct dw_pcie_ep_func *ep_func;
>   
>   	INIT_LIST_HEAD(&ep->func_list);
>   
> @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   		}
>   	}
>   
> -	dw_pcie_iatu_detect(pci);
> -
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>   	if (!res)
>   		return -EINVAL;
> @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   	ep->phys_base = res->start;
>   	ep->addr_size = resource_size(res);
>   
> -	ep->ib_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ib_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> -	if (!ep->ib_window_map)
> -		return -ENOMEM;
> -
> -	ep->ob_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ob_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> -	if (!ep->ob_window_map)
> -		return -ENOMEM;
> -
> -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> -			    GFP_KERNEL);
> -	if (!addr)
> -		return -ENOMEM;
> -	ep->outbound_addr = addr;
> -
>   	if (pci->link_gen < 1)
>   		pci->link_gen = of_pci_get_max_link_speed(np);
>   
> @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   	if (ret < 0)
>   		epc->max_functions = 1;
>   
> -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> -		if (!ep_func)
> -			return -ENOMEM;
> -
> -		ep_func->func_no = func_no;
> -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> -							      PCI_CAP_ID_MSI);
> -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> -							       PCI_CAP_ID_MSIX);
> -
> -		list_add_tail(&ep_func->list, &ep->func_list);
> -	}
> -
>   	if (ep->ops->ep_init)
>   		ep->ops->ep_init(ep);
>   
> @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   			return 0;
>   	}
>   
> +	/*
> +	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> +	 * step as platforms that implement 'core_init_notifier' feature may
> +	 * not have the hardware ready (i.e. core initialized) for access
> +	 * (Ex: tegra194). Any hardware access on such platforms result
> +	 * in system hard hang.
> +	 */
> +
>   	return dw_pcie_ep_init_complete(ep);
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> 
