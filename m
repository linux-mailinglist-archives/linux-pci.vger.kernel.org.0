Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC875F69C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGXMoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXMoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 08:44:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674EFD8;
        Mon, 24 Jul 2023 05:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6W3oc7TYWzlUSjNTSPdhYeNly2i8/CnfgCSByekIrzLb1oPx/2SmsTkyGNsa34Cnoz/CXtRyiP6DcY6sVNHGX/c4J0QacWwOlfrMX+ACXdKLZ7Stjw7OcCoJ0cwmvnFWKnFVCj+jc0Ie/CLvkNJvArx5HWzmf4nf2TgvmzI9mqDZPqI2XCvzvHIYLTU9Z7Go6oPq0/WhlKzMx9hLsrfzXaoJu+VeRsF3BdPiMWSNeeeUGh2GXVA72Xoasrwg+VhxJmn8aCRISA0DnA7Uf48aSBPWtCkSkb6flk99vgD2CgKvJ/ANJoR/9EiEjpc/Hd3DI+czJ0J7wyQ816ymQ5WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKVkdi8qFFDzAlbiGKSU2yXpO3Roo2PPQIXZWVSX+nM=;
 b=UF31w0L1U1JcegJGNrlLQNpkZyXtX6+eJKq4B1KBNrbPOr6PA33SdvNjmHF2yQ0KyfIE2Rh59L7tCnXb+yOLCRhYTTQ+F6J80ptHSGpEhkwLd3jQzR1S+Oui65CJ+04gzX8N5BhvQK8KPnDyhEQB3KQ60U3DUqqiUhXO9BjApalg2kJ15aB4w0hYI666XExPf4yTosVd4r/ujnunsX48Sbtz+zj0rFxUMFLMd2xisz3iw+1xBGp4381JIF1LDF6pKDAmcj+DP14b1tEr5DQbmLfDsM2mc/q4O8e82FnT/RUf38U7/huh00iCNUKv9RbwbCk0LWK7tLItg5G9UnbYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKVkdi8qFFDzAlbiGKSU2yXpO3Roo2PPQIXZWVSX+nM=;
 b=ZO5F52fcQe9CeRF9tRA8iXsyuqClI3uw8RwkxRkCo4JPh0uCoeddvWM0FSbB3ovtHbCDWGC2s2sgs4qsKHWZMavObuwocmRRQ9zHEqZyPBbmR2WNNVwHYLOhe5Y+G1pmdxSWIi0Kf6JOKN8sHC5O5KZ+sCXHqZXhVM7vc/KYKTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:44:48 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:44:48 +0000
Date:   Mon, 24 Jul 2023 14:44:41 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 3/3] cxl/pci: Replace host_bridge->native_aer with
 pcie_aer_is_native()
Message-ID: <ZL5yOXI4XkappwTL@rric.localdomain>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cb9c3a-0f4c-467a-c08f-08db8c43c404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqc33bX16EB2QWiqsvoR8QJwgZiWQZ835J6zqFNK1SnDsUFPXbbfHqqWn9nmac/VJG6jT8BJLAyZRytq9WZzVzJWh7/HPW5yiQoRa81cDaaavHsX9LgP2lByLoHcORBm9ZaQMI64AJw+xI+5CncR/cY0ucBIz4vxsitgGrX93Ahi0hHjc16NRus9CPwB+vq1QRCfosS0A+vgWxtYt7hnSDf6NVX32/ZOhVsuCrdvL6/+4upGTDMwejP/57VwVNYyigXtq3hp40a4VoPqgwA/EMrYeCvvPApiYgrW/utVXk3lA1BeMtRUksODCSk1WgHovlT1bPJh23+ZeE6E1Em1sz56gJFJX0tkSM1FeFiTa41eJ88ubFYBgAN41zw06kjByhp9oaIyIkMGHY2YcYEW0+ueHaIau1Nx4LcEqKPj2+kQT/FwFrQg+wD7DaSTZZaFN9gABCd3YHiodFb1sh/7aZfBoAT/PpMgRUwoIPEop7kffTbcZrC7oHw2NB1IYF/J6O7NX3aCPu6imvJqZMC4KqkdjJokHpHUzV+WNhPQRHUU5EVg3vyEMl8UdxTfJU/o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(26005)(186003)(41300700001)(478600001)(6506007)(53546011)(9686003)(66556008)(66946007)(66476007)(6636002)(4326008)(316002)(6512007)(6666004)(54906003)(38100700002)(6486002)(5660300002)(2906002)(7416002)(8676002)(6862004)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6lZPxejb1QDHIYd7z8A0dnX1NMvr3qdu6urUVuW0Hv3z1NSWX6YlSx5d5nSM?=
 =?us-ascii?Q?o8h/dzExjLlqW7AuqWUEs+e8mOUpgVif/cZAFmuXwIYgXahXCRdkajTN9V7f?=
 =?us-ascii?Q?zdlNDhUhXHL1l3ovDRlp1+pssVqw3DjrpyEaAT9OP8N24YkmO47VUcHiZlam?=
 =?us-ascii?Q?xtfoV6Xx/S8Ay2pVsH/O5elh66e8Bf0ytMSt5ylbyDa4Bw1qaUTcRAMjBhHw?=
 =?us-ascii?Q?FkrAhSNkl9Ng6LUOsmX287e40XQpNwEUmoIQgOjr4FwLVQePqub4fOrisOGI?=
 =?us-ascii?Q?V+DExAiNQQVevsMJfmsmY7zseuQHLdxZvPdWXW6voFZWxEDLHwrSeQQI9GjS?=
 =?us-ascii?Q?BJNcYRehAf4lyHShLmdG0SeFiAwEZyHyQ72ZwRKYiZUOl9mymvZjDAwpe6Fo?=
 =?us-ascii?Q?DYmLb6zREPdmXgOSSwr4qsxBmQ6MkoFL1LIgDNJa6VA1TwnWn1ffelDbYqWG?=
 =?us-ascii?Q?hZKaXomsWLfId74H1D8XxKVyrsglK76AHWWDhaaF0qc6xTmUVbhoBfiBM1d9?=
 =?us-ascii?Q?k3p1YIy+BlDlHA2dq7ymYsEId8yF1EwQM/Gip9ShIT9swEAyQZaWlEYeItu0?=
 =?us-ascii?Q?N1vs6MMxhlBUtaB5EXdUYfPDTZqqCXjJweqZ8YHluW3hbmygwR3jU2edqWy1?=
 =?us-ascii?Q?8RSmM347juhtQeMmmk++o064ML7S7GJqYZqym7FicQ/PkXSw7XpG4vWpa75h?=
 =?us-ascii?Q?GET93h/pPxe5zdJqbjsb2vx+il6+NoW9arzaAE9Jz6Jg5o+88U/Wqg5DP27Z?=
 =?us-ascii?Q?oPm7wwFLIqJF3LyF9WMm2SdKnHWZUGVvBJkbPKfIsU6myjE2DOGDXEBjTEuf?=
 =?us-ascii?Q?IKLnLP3V+NbeE9JrnNRuB6CqDm6G/1yJ1GTS0AZOX9peE0rH/4nLegzQ1rFI?=
 =?us-ascii?Q?vziOxevXP17UrwQ2Wow+hBk/Q4iYTzbRtJolJFWjEeA+Qtwy6mVp71f9Nyun?=
 =?us-ascii?Q?EafLny9tOO2GG8Zt4VNNgaWI8F9evlK4vPhDyC+HV4Cniejh22yQ36zmZOKn?=
 =?us-ascii?Q?0H5/g3x6EoDMnrqPzwEApIAuCBH5Xh2tooQWOYM0Gbw9F4moOw5OPTw9H6Ec?=
 =?us-ascii?Q?YR8/XASWqV8U5Wndyeo2ho5jZ2SnBWkuNm6cnPnalj+M7BJznt5qB3wCEEb/?=
 =?us-ascii?Q?c0thLd1qYrgWP2hcCcxHX2jdJy5PN6udpffjIVTsNKS62HzegK8ltuyKltO7?=
 =?us-ascii?Q?oKdk6xqqRJO4gb6m2M77yOJhK0bOGA0Pzp9TfjfDTFgKZ/gN2NB/Nl4iwO+E?=
 =?us-ascii?Q?SGq9BKvg8POz6kB/JO69YnICw8iLCp+qy5qR/JFQhjjAbPYczCirvOCU/V9f?=
 =?us-ascii?Q?F7UfzL+KscPklNk02nhCWJ4ThnN/QLyZoz9N3BVG2GyDG99qdGHIMNTJKgea?=
 =?us-ascii?Q?/6xSXvA9avabXrodcETKJaNOYI5LrOCBtV1atYGJ9FsRiV0irG5b4a+wRPf7?=
 =?us-ascii?Q?6OBS+ZxTHuzl4o3BdDLXfXSWVl+MCDvfnX2V9e8J11M1DjZouXRG8lF0IZ+3?=
 =?us-ascii?Q?hzl/GtNdp2MDUojtXfolDkWwPg4i7BULAQEuv12NRPzQGlHV552RIP2GgXa+?=
 =?us-ascii?Q?mxtrGYj0yklzpgYcWyw+kXVf0i9AwEJMViSEecUK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cb9c3a-0f4c-467a-c08f-08db8c43c404
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:44:48.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT12dwubNQilwiGT1AeMFH066B2wITK7EmscIEFNFL4HjmC7uchLxYZUL/Y5J2Egrx9K3hDHsiOGe+RbD4uuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21.07.23 21:47:40, Smita Koralahalli wrote:
> Reuse pcie_aer_is_native() to determine the native AER ownership.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

With Sathyanarayanan comments addressed:

Reviewed-by: Robert Richter <rrichter@amd.com>

> ---
> v2:
> 	Replaced pcie_aer_is_native() at a later stage for automated
> 	backports.
> ---
>  drivers/cxl/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2323169b6e5f..44a21ab7add5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	void __iomem *addr;
>  	u32 orig_val, val, mask;
> @@ -542,7 +541,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  	}
>  
>  	/* BIOS has PCIe AER error control */
> -	if (!host_bridge->native_aer)
> +	if (!pcie_aer_is_native(pdev))
>  		return 0;
>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> -- 
> 2.17.1
> 
