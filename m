Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6D761D65
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGYPaR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGYPaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 11:30:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896E19AF;
        Tue, 25 Jul 2023 08:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0wBXVQisJ2IEXods80/5XdnK9TSg0e3zQ2DOQkyTJWOBk7CE/MmK6XMGkf0AwAeBckzBMMHBzaDzmkoX0sa/1t0ocU5JKhp6UEwkawiJOGOks6SLKSJy6/Q8HqIcceQ36W1ba4Wc00losWLKzhHpYbbZxZITHzwiN+D9CP//U1jskat7Do6AxR2dSpkGCyQzKsDiUbSVzdY9ftAkIQ5tXZnhW+Mo5xAHdnmIaLHcNm1rnkoDZPS49UzDhWwyZnbeNNE4XU5zq+DxM6ByvqgOZDVnphBPU6gYnjM7eaDYki1nKSesC9WzFQxbP2KOkaPiaUS6TX9uq86peE2L9fgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IyKCKJRugZUdfKnW1+o/urkQToa3Luyqy9+OeZWGIU=;
 b=GRHoDreR110Fs4iZcXp5L89rrFavzE4HpLT41Y1JyUUbSZRJiDKjVruwp2fhNFKNWBHamQPuGDxVasyJjwwZgn4KSKLniUbaWOVP89jF2k9a9FNPFsDi5oAFBczvBT5IR/mDgyfaEYN+VYwQcuGWczgqraqd/fX4Div+vN4sQIXif8b2/GGDPJUDg9xNMdJq/fv5poNiBAPBZfxzHks9G9Jo3h/lUavYdzTTtm5IbrZY3ajwRKwATEfKvieA2B1BlM6IolQsCyL69r7lG3JlS8CCBgALHwq4ZsuFbEeQrW+CM8V9pZO32i2B/yFGi4rSnYZON0bRujEXV0mKzLMwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IyKCKJRugZUdfKnW1+o/urkQToa3Luyqy9+OeZWGIU=;
 b=RSqpIu/BFXGLTJfHdWMJSCUCjZoYiqRoJwluA8hzae5yne91n9XnihY0W0sTNF5QZQXTMVfz/MwRmQfBUuPRtOCX6FJA+7g4ahjwqShfNsMCituCheIZQ/AnjU8G5hhdY2SOgepmGFCltShVwZu2jtVkpi7/kx++FornLAJfUDc83PY2HTaT59BRfHYz0IncnHwK+JyZ+qdpqxB3CStOddt5jt2R4FP2nuwfpZomy+oTsBv95b6aLOsb5AyOtboViywdT2ePqLtgXw2/bHW7GazWfUvU9+mQrl8DC/HzrDrTX0oB9h8n8aomIRdp1ppLt7c0HDxLfu/JEKvoPYYHOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 15:30:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:30:10 +0000
Message-ID: <6ca287a1-6c7c-7b90-9022-9e73fb82b564@nvidia.com>
Date:   Tue, 25 Jul 2023 16:30:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Content-Language: en-US
To:     Ajay Agarwal <ajayagarwal@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>
Cc:     linux-pci@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230412093425.3659088-1-ajayagarwal@google.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230412093425.3659088-1-ajayagarwal@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CO6PR12MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: df5b1a4c-360d-4a24-2089-08db8d240894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxxhcUnsCrrbugvRrnSHsuqMJBVF9tlC27xKoQguwmFXqsEqMCBDW7j6XnGs2IpbDTSBfusIZFnBeyab9D32zksQLV8t0YkP6WH9O8WqgDb9v8YOQom5WvMpQP02oLOjeN1nBx48WqV6/4wawpdtPz6rBdnmGUnKqT+j+JwCUyqkdcosnBaADOgO0LhZZIEO/MNAgvtrf08mizowK170Wj7Pz+LjO9ZIjyz//ROwvH0l85dY1QEgesknFc6T9lnbqRWLp4/nxxXMt0n3wJcwigpynqV1LPRHUFkNdhdK/82mdh4AxPZShpCx8l+spdzwFSn4NM4v5dzVpUFlUgn1Al/2e1KV34GL1JLhEqo2MsxeCtNaRjNkG8quwJMLYOryu1Q90wU6zulgP3l9mPYBAT51Vg5njpG4Cf+It+pFUz8YhqxmOt4wLi37H152VllDPtHmaVE4G81K+cZyaOWXBfFLbHXxx/Lm8W638Vk3V5ltA8tn2adTB5peXh1XNqnFyM/G+VUt4C/h9xzRAIUygWfdmAv3q5VwtT/RvC2C0JZ9SEPJk2sJzJnFAOIHJs+eUpSdxF+D0BWF2LAKUe62RReXUikuPu7XTOQMXcxYm6EPux0CawitUSvNcr3+yyX56yP3xVrGWFuLogP+hPSSDD8nU1SeJEyiQ7pKGvazsxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(2906002)(186003)(26005)(6506007)(4326008)(921005)(38100700002)(2616005)(55236004)(53546011)(83380400001)(41300700001)(5660300002)(66946007)(316002)(66556008)(66476007)(36756003)(8676002)(8936002)(7416002)(86362001)(31696002)(110136005)(6512007)(6486002)(6666004)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNKcGsreTA3ZWc5U3lvb2tJMFEwS2x4WUliRGE0Y2pGQ0ZPRlJQUWZBdmlh?=
 =?utf-8?B?RWZhL2x6dFgwQVYxa2FoWU9aeWZVTzFrR0tiRjNsOS85YUpTNGxWa1NybStZ?=
 =?utf-8?B?My9BR3U0QnFmUS9DTkp2eXVFMGRHaitpcWlZeUl0M3hIRFM5QWQwTXFWWXJu?=
 =?utf-8?B?WkFmcmlvcXFIVFVCbXpVVUk0R1ZhMGNjUFZScVNydnhGZkJhZTUxWFgwMjZQ?=
 =?utf-8?B?Vk1Td0dFbU5ZVGV3MEpIcDVyazFjZU43R292TEFsRUdCQ000MW1YaEExYUZp?=
 =?utf-8?B?aUxEMitNMklZVUJjeS94S2hQU2g0VCtZODJlZlMreEN6K0w5MHBtSE5jTlpr?=
 =?utf-8?B?NjBPcS9Md0FzR2Vrb3g3UDlibFcvWGVXWWk4cExhanlkUGlEZU56YnFoNEZH?=
 =?utf-8?B?SXZydENRYzJ3K1BLektDd0lnVXpvZ01Sb1dUZ1VkSWVpUERzMU1nOEsvTTBj?=
 =?utf-8?B?em1uRzNGNCtXYWtISER6bHo0VEprNHN4ek5NRGJwWWxhd2NPb1VsZ3RFZFpV?=
 =?utf-8?B?bkVuazlJbjMwM1AxSjk0eVkrdWJUdGFKRDlaS2hyd0VYQ3BET3hycEFYTFZB?=
 =?utf-8?B?RXpzWG9DS0ZlOVUrMVlJQlVodnByTUVLR3ZHRzlNVTUzdXE0dFNnbHBTbmt5?=
 =?utf-8?B?RlNaWWxOT1ZiSi9lejVhdk8xa3JrK2drWU0yb3JWS0c5Uk1QZ3RucCtTTkpT?=
 =?utf-8?B?ekJYd25sc0FwV2lDMFFhZXFpNERaTGJGMUJwUitTMGdtOVRuRmd4dTl1ZzVJ?=
 =?utf-8?B?eGgzbW8xTlMweHFTZjJlYThPNHJCL3k4WnJOWEs1dHJ3NHRVdFhMS0ViVHps?=
 =?utf-8?B?RXowdzNobDJxNnhqaHFHNGRySkdwbmd0WXRXemNEd1N4ZHp5WnJnWW43b1lH?=
 =?utf-8?B?akhlRnpSLzcyM2JHcG0zeGhqVHEveE45MmJGaDNxcGNGRmdiS0g0QkdablNz?=
 =?utf-8?B?MDMyb0lvS1ZXaTkzNUFtdS9UazVKOFI0R0ozMXdpaXh4OWNVYUY5Sk5OdEtR?=
 =?utf-8?B?Y2sxQllyWlBObFN5MVZsN3I3UHUyRmV1OEw1dytXZ01qdG5hNjR1ekxnY2s4?=
 =?utf-8?B?aWhSeFhUYldRUG5TUmU2dXNmZ0dWMVBNT3FBNkZGRWpjaGR3UUhhTTRoSU5v?=
 =?utf-8?B?eWp5SmkyNjdqMG9XZkQ1S0dXa0FVV3Fza29WYXBRelpqei9uYlZhWHNjSEd6?=
 =?utf-8?B?QWJUUS8vZkpYdEdUZDZSbFhsOTdwME5Id25UUVB6T3E1MjJJampBQlYzbk1Y?=
 =?utf-8?B?V2RXb0hhdzRocWhGUnVqZ29wZEg0N0x1THZlU1BXSmJkL2tUakN4dnM5cFVr?=
 =?utf-8?B?M3Zjemp5WlVYYTZ3TFU4cEJ2T1hzczBRSitKK3FVUzczNnY5dTNKTXVhN2JK?=
 =?utf-8?B?b25DV1RmZEFwVlpId1BrTklSV2ZrZThjTXRKUWU5cmVvTWFyM1pzQjFUdk9D?=
 =?utf-8?B?VVg0OFZISFovWnFMWUhJZ3MwbmtrL2Z3RVAzbzJIeXNLUm9Fc2t6QjZQYTFi?=
 =?utf-8?B?WWtoNXNYSnUvelVKUkpyd2F1YzM0MTFKQXh5Ym02Y3VnQUtIekhoU0FTOEdY?=
 =?utf-8?B?TE5yaU5iR2s1WnBhcG1USXBJRytjQ3lXeW0ydmZTSTF6QklkdGovb3c2SHUy?=
 =?utf-8?B?UVZNZzgxQnJIYUt5cWxzdEo4d2plYjRTYU9iV29hb0pUa1YyeTg1UUk5SVAr?=
 =?utf-8?B?RWZjSG9rWkRjUWlsNHljVDVlWUcvL2ZhcUt5anhpVVFYcWw3NWo0SHZ0REVw?=
 =?utf-8?B?alA4cGtMdmw1SThkL2F3Rnp1b0dMT3R4THhRNGhqY3ZpSGNoS1pielZUVkJP?=
 =?utf-8?B?MU9UU3psOGZkd2RyUUZmSzRYejk2VDJwbnRTUUZ5YkhJRVRGZURsdUVqU2Vr?=
 =?utf-8?B?RUQvSEpZUzltRjRUd3BJcytlR0dUZk9hUjZ5MTdpcG5qNTEwY2FkMlg2NTRN?=
 =?utf-8?B?bVpJelROQjJHNnJ0ZFBGT3NJMnNJNkpxSGYzb2xLS1hOZGlJamwrL2xaSGNa?=
 =?utf-8?B?OVpjeUQwa3UzdjBwUW5RVHJKczJEVmpqamRmTUl3d3AzaEtrZ1kyWWJzVnNW?=
 =?utf-8?B?Z3BDRFROSlFjWU90MXVVT09qUU5XTmxzNDhIQ3NiTTJpbWlDVFlvdTBIQnBt?=
 =?utf-8?Q?+QRDNtbppOIvf9PLAJ3P9MCYf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5b1a4c-360d-4a24-2089-08db8d240894
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:30:10.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exkRTRZCdhgEusnneUc2328YhKnWl6acpOu8S/ezZP53aF8ExGIDtpLLIG6HxokkJN1gsImuWTyMy+w6oDqtvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ajay,

On 12/04/2023 10:34, Ajay Agarwal wrote:
> In dw_pcie_host_init() regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where start_link() is not defined the code ends up spinning
> in a loop for 1 second. Since in some systems dw_pcie_host_init()
> gets called during probe, this one second loop for each pcie
> interface instance ends up extending the boot time.
> 
> Wait for the link up in only if the start_link() is defined.
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v3:
> - Run dw_pcie_start_link() only if link is not already up
> 
> Changelog since v2:
> - Wait for the link up if start_link() is really defined.
> - Print the link status if the link is up on init.
> 
>   .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
>   drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
>   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>   3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..cf61733bf78d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   	if (ret)
>   		goto err_remove_edma;
>   
> -	if (!dw_pcie_link_up(pci)) {
> +	if (dw_pcie_link_up(pci)) {
> +		dw_pcie_print_link_status(pci);
> +	} else {
>   		ret = dw_pcie_start_link(pci);
>   		if (ret)
>   			goto err_remove_edma;
> -	}
>   
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +		if (pci->ops && pci->ops->start_link) {
> +			ret = dw_pcie_wait_for_link(pci);
> +			if (ret)
> +				goto err_stop_link;
> +		}
> +	}
>   
>   	bridge->sysdata = pp;
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..03748a8dffd3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>   	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>   }
>   
> -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> +void dw_pcie_print_link_status(struct dw_pcie *pci)
>   {
>   	u32 offset, val;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +}
> +
> +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> +{
>   	int retries;
>   
>   	/* Check if the link is up or not */
> @@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>   		return -ETIMEDOUT;
>   	}
>   
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> -
> -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +	dw_pcie_print_link_status(pci);
>   
>   	return 0;
>   }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..615660640801 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
>   void dw_pcie_iatu_detect(struct dw_pcie *pci);
>   int dw_pcie_edma_detect(struct dw_pcie *pci);
>   void dw_pcie_edma_remove(struct dw_pcie *pci);
> +void dw_pcie_print_link_status(struct dw_pcie *pci);
>   
>   static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>   {


After this change was merged we are seeing the following errors on some 
of our Tegra platforms ...

  tegra194-pcie 141a0000.pcie: Failed to add PCIe port: -110
  tegra194-pcie 141a0000.pcie: Failed to initialize controller: -110

This is causing the probe of some of the PCIe controllers to fail. On 
some of our Tegra boards we do have some open PCIe slots and so the PCIe 
controllers are enabled, but there might not be a device connected. I am 
wondering if your change always assumes that there is a device 
connected? If that is the case, then this will not work for these boards.

Note that previously we had changed a dev_err message to dev_info, 
because the link failing to come up was not actually an error for these 
boards. See ...

commit 8405d8f0956d227c3355d9bdbabc23f79f721ce4
Author: Vidya Sagar <vidyas@nvidia.com>
Date:   Tue Sep 13 15:42:37 2022 +0530

     PCI: dwc: Use dev_info for PCIe link down event logging

Jon

-- 
nvpublic
