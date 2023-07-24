Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C275F693
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGXMnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGXMm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 08:42:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8D126;
        Mon, 24 Jul 2023 05:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cljqggywRtNy1zJ59kmE9KJxCmQrsVLbI9sWq8M6b2m8efa4eUza+BoEpF98uyLchIogEaD+o3Mc1XtOLPcRviDiftFhrENKI6zrDogMBxIzNAKq3AZGOZazDQ8Yh5G8f+mZJ8JE4noIKKxnNrre2czkLLYAEPJkWnwJjHYZwM+QZp6dXW52+KQNYu71za3S1WP1po97Sfg/5EuBTMlTnc0odB/rvzm9xvcK19GtNsYgfovHw5h9pBq0y7HEFv3Icg8jI/wvshSvWEzMvSKOMYCRMPxk1OJuM308tdvUSJl+LW8TdpXU50l1swmHWrum75fj49fjpL14e4719q0N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDcp3h0/2tdkX418XPo23sD6+TWSLWd17s0QQJ0DKOw=;
 b=Y2TVBLi4QZUOzs2IQ8fN/E9Y6XVJjdiAH0EitccyZbqsyAZVKwPEkxokM0XjovryK6TnbhB7zw2x3b8OC8KKT/PFw/IfF01yUM7KdqiLn/duCtWBdOASfX67JrzQsDV8cao4UAkVQs61A/9o1dCNJyHUIYMnf13ZIHHdfZcde09kHialxSw9nxTjoTyj2cNJ110ARDm5upJ0oBGNEkXmy/MaWPcjAxDw0kgqHYWSSj5QWsFGl2ROdSnr/G66EqBFas1DvKDhhc5mNlRcu30gxRKvhKDrMm9iJskPHlB31wbhGocZXbKri7hCZ2lTKyuBb9Kvfp8beZa8LMtdafvumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDcp3h0/2tdkX418XPo23sD6+TWSLWd17s0QQJ0DKOw=;
 b=wV0D4z8YeBVWGdjFE94lGzoI2XiHla5rRCEMoutdOv6TzCrJEXwi1d88yrOTROz0gtxrzI+MfR5xM6K7oTXNsAYFrF7mVxSs3k94VsfAG8Rd72hC4VZGKJ0LVJzfCHJgJvDNfyRxeHLzsCDGIZ1JC0epjJcBDUbqvu1NY6+NuRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:42:55 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::6cf0:e179:9f0b:edd9%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:42:54 +0000
Date:   Mon, 24 Jul 2023 14:42:48 +0200
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
Subject: Re: [PATCH v2 2/3] PCI/AER: Export pcie_aer_is_native()
Message-ID: <ZL5xyC9L0Bx/nrde@rric.localdomain>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721214740.256602-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a4daac-d757-4b88-0d89-08db8c438058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmAdjMAKWPrgZr3dHjAlSGXJ2ifil9YiBZFK3KvPwPQ0KNSOfuXrWMc0lQSuiFH8EOIMj4yD9JUia/lNt39ZU3m9e2pxt89X/PPDem9IqwsSk7aYNDq/6bixK9XNQvlghdaoQpMz7QjdHc8K/dbyoycMw3/l785BlwO9fb5BwKcTVx5grFl7LUhdnydPber27SK/LcVxZ0nim2izijCcRh9pll2njizr4HXL3HjRxRzRNgzoDlRLxcLtty98Fsm6NQ/99rBKZn3LeN+Sa8vV2/28d49wQt/QP549CM3k9IUZ00Un4wDSDZibiKaFc0seGxM8Kk8fTZKsfk8dOpNUiCWK+iVxi0pOiuJQFKq0Swne46psRWY32N+tNGOj9WLY1OsokPvAePXaUnJ4Dkxqi2SzwK8GQB//mIDOMN9s7sdyJyapqjY9m6JtYLGu+pFHFsYxEgK50s5RRN11++Gle6vTR/gnNjuXYo3dUKiF1cGLqPcy9Vce/2X7kM/nfCLs8TbHNbxwQhK+SzcXr8NYTDdaSc57bUvVKcwtsV/V+e1RmIhyI09jwsjAmS3bfNoD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(26005)(186003)(41300700001)(478600001)(6506007)(53546011)(9686003)(66556008)(66946007)(66476007)(6636002)(4326008)(316002)(6512007)(6666004)(54906003)(38100700002)(6486002)(5660300002)(2906002)(7416002)(8676002)(6862004)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cZrcZJh6qD/27CFkpDG/s2CMv81b3yc3TsYDOFSLgy3vuyjuRkE7UrtLOBk?=
 =?us-ascii?Q?gLn66/p61UMUrUZdiHJiSDMiiz05lPbuPocmTy2BRJgyfHraJOm29xdYxpwG?=
 =?us-ascii?Q?jk0KSC3S/p5vUE503l/QWCPkmsk1uXklxam+aHU1xtOSwDCLhmM4HkGcwt3y?=
 =?us-ascii?Q?2OuyHBFZyaZ7W42LgczAZIa/VAp+3lLu3zbQ1ItlyS7/y0UJhyMHoYjkf96B?=
 =?us-ascii?Q?KPr3rG9P2A1TMsts11tsJruWUagRHrsSrzADw8bVLl1QcqJrdEKaqc51jgIT?=
 =?us-ascii?Q?6159yZu/OjMFvr4BAlIAv/wTm9uhhsSXasrrgPWzB4FdSD8APIi2o7cb0+dG?=
 =?us-ascii?Q?+ZME+9R+hfXZXiDAi7/MlMhWMp/Y3rkFP5t0hyRoIAyfbTIx+tbFNfEX1zHV?=
 =?us-ascii?Q?L+MCvuyjeHTc85m+V8x9uoTRUo7rX7S+K0e98MzfhvxRsnt8TkCcOAeDS03S?=
 =?us-ascii?Q?Fi9qT1sbAHXZVpwIPkXdsAP2VEN6555dyNFio/0dZrMD1tuh2PHVL+JwRCxy?=
 =?us-ascii?Q?2H1Zy60gS2eYZNNg06aIPOzfHatJAyjAy7Oj7aCeQhx4gDX4XFjpc52Cmsb3?=
 =?us-ascii?Q?M8M+mmhVoZ6P3mfnYM6ygzTUKp1/USg7f+eUaB6jtRRyF/aFxkU8yySMMQZy?=
 =?us-ascii?Q?a3fofYqtuz/Fh6oFhVTIvONQUC3FUJPaUPSdGg4q/s3M2X7DmXCPBCEBPoKu?=
 =?us-ascii?Q?amJKSwwnhZelRyr+YnXQJg+na7sYN2JgLymQJojNRcrt7pJbWLSYYA0Pcxyf?=
 =?us-ascii?Q?3JZVQO8wm42v8Tr7B/avlch7Prs1eqPWtzzcg4YYJO8HBFypDKk+Z9GDrwQt?=
 =?us-ascii?Q?QvUtYTPlsx/+lkyO8oMfQn2vifKWRRmmGFm9If0SC5ROq1kf7d0kDUVBUzF1?=
 =?us-ascii?Q?9y3o/YuZ/uw6oy1nFMnnJMKJiN2KKQyR/SkV6I0FzSQg7lGfbJWTIh8o5h/q?=
 =?us-ascii?Q?u+8BlN+LbGpUZdOvbr/aITBkRgT5X+vhinAZJVeXwflFfUKTnrwmjy5FXRDH?=
 =?us-ascii?Q?JbbwIXDMm03VkfoxAE/cZkGjUaNf502a7De/NtG09ClSXMWwJi/u/ejMv2G6?=
 =?us-ascii?Q?BnsuosNT3Th6nZcJIS1xD6PwPHf2XaSbsIK+BniwT3WQcNKBwL9jVini2ljI?=
 =?us-ascii?Q?3XbdLU1Bo5cvBVIs+q0+p/cd8YBZj/pmUUcVxE2TYQr5tU/3Qndzh5bazEXD?=
 =?us-ascii?Q?97fAaXqynBFGLbpMj3uhdwJUuipW7RptIpobAe1h+Tt1smdaPfJSBEVnmnX7?=
 =?us-ascii?Q?LWtUKjCQYp4cESGrd3HOB3iGvJv/NVfEyfjgN1dlXLAun6Fw6lZlx9oMjz9e?=
 =?us-ascii?Q?gCiKWOxIjs0/q/RYUb2zQ48HmbeBJpa2hixQa5wRiyqFtZMXCzbNe2kEW5GU?=
 =?us-ascii?Q?tA3TPd9bICjVrPJr1QC4Bgn61L9kgGjSd57LtvzssksdJ9j+HPzSKpa/J2wG?=
 =?us-ascii?Q?Jk+bsOWbQpTGU6lwI+QMr98EHRYfL+vsRMo/kfa7EbyZB3UcjYJXKWLb+YkQ?=
 =?us-ascii?Q?ZnWlQLA68VZF7Fd5zDlbQXQEFpTy/RpASJqkxTmtzMsd07E76Xl2raZou/fx?=
 =?us-ascii?Q?FZWHl/SbD/ph0UxBIyuo76LUaWJNf4RknBL9vzAq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a4daac-d757-4b88-0d89-08db8c438058
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:42:54.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9i31O2CQ0pu3mE7GgqlDZeVa3jLXjc+ABsic62IghQGlzk6J7ew6W1eb3TK2pB9diNXwP4JPWrLmZYOFY1aemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21.07.23 21:47:39, Smita Koralahalli wrote:
> Export and move the declaration of pcie_aer_is_native() to a common header
> file to be reused by cxl/pci module.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

> ---
> v2:
> 	Fixed $SUBJECT
> ---
>  drivers/pci/pcie/aer.c     | 1 +
>  drivers/pci/pcie/portdrv.h | 2 --
>  include/linux/aer.h        | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..87d90dbda023 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  	return pcie_ports_native || host->native_aer;
>  }
> +EXPORT_SYMBOL_GPL(pcie_aer_is_native);
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 58a2b1a1cae4..1f3803bde7ee 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -29,10 +29,8 @@ extern bool pcie_ports_dpc_native;
>  
>  #ifdef CONFIG_PCIEAER
>  int pcie_aer_init(void);
> -int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pcie_aer_init(void) { return 0; }
> -static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  #ifdef CONFIG_HOTPLUG_PCI_PCIE
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 3a3ab05e13fd..94ce49a5f8d5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +int pcie_aer_is_native(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> @@ -58,6 +59,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  void cper_print_aer(struct pci_dev *dev, int aer_severity,
> -- 
> 2.17.1
> 
