Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D3E69898D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 01:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBPA5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 19:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPA47 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 19:56:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159BC2A153;
        Wed, 15 Feb 2023 16:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676509018; x=1708045018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gqElSBvj887rU5EWfQN0wDSv48c9DBEYxpd5QJQIc4M=;
  b=igngIhU7jlfkmQfpmp+aiNkcSxtzueSJ2PEgwoqcrPXKqwADNy56j1xT
   plvL1/WFwV/aDeO2QdB/eBvD6JN/I/dPYP1Q3l4ThdVt2Tzw6y5bb4SY9
   9DrpeLDb0Rp2vzHuySwjfdyyfZ/mxcO5beyzyjspUVhTzQJaqcjpMj3Po
   x58C+9gQDF5IURd/Th9Dp94yFnuXc1syXgEQLIVqUtinEDt3GcOF9sMhg
   /LWbBSuqNG797IDx9BI+N/Q910iaefgEV6+tok/mm9tD8sIoafAP4Xla1
   O4rxoWCzb163W2VJil1DgUktuuRC3Lohx7QttYGLD9mHp96ZbxAOwxB20
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="417809225"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="417809225"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 16:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="812762235"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="812762235"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2023 16:56:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 16:56:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 16:56:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 16:56:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWHj8/e05g/QF30A+LrQcmoFqzPwsLmZFQR1mM9JIl0vYKozAPw8K2TiD9xSEvHqUNuzWqtehatSp0k9lUsfsIXfsPWXrm58ML4oGT8PI4p32o7K6eh8vhBIoMzQ1Az/R9Oxh9UosJTdH2Sht6bDjOB7xBHHz345MSLLwRy8ucYpoLwQEInNym5hYoyKnWbZtCa86EFhU0iWRAogkB1rhtZEkm+MN2FVS5nWZPfdmSIjWpOcGySfQ4Tg8u/lEZGIwtV9haPEvXBVSNAHQ+JXSmK7HfFT05uxhBbs1n9aGj7ApmKR7HHh2pTBKhd/0IJ5c616CidHFF6kpLmBSm1QWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQJ5DHBlz8IZcTp/LeT06sz1OF5fwxBZt3CWySSZbnA=;
 b=jKJQssjf2rN+hrAYYXD0JGL3/WLORRZIsCCNAfvSWvH0ExguI5OLHCSIJMZu/A29ogaSOSpkiEcC5QUovvprkrxrckW/vWYQOR8b3PzvLrFVFsGqfsZAJaVa2/9zIde9vLGUHB21L64lABI8WNdRh6c3MXQtVu1/1qJmjWL2YF8VUBvSzn3QHC5Kjwh0su/xoW5VG3toKDZb8L2YwRocOYDEF8YJHvZSz9kmkR5e5qMvAYnvcvWly+9/60ro+bopLgxyTxgLqC/1XUjmL3Sl9YTratgV7yJ4GIbkw/n59KmtOLoDlIbbcoHbi5OYhFx17ZoRdVyiUT1QKeVlTS2OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Thu, 16 Feb
 2023 00:56:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%6]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 00:56:53 +0000
Date:   Wed, 15 Feb 2023 16:56:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 16/16] cxl/pci: Rightsize CDAT response allocation
Message-ID: <63ed7f50ed22b_19cbb72946d@iweiny-mobl.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 4715eca3-2639-40b6-1d99-08db0fb8b18b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+VwkLcM3AZHBRheYaEsVSmEytToqaQd3U24wuNlEsyXKXVtb8Wiu8UA1ZQWs1kNN/Xsl7GMOl2cZuSUu50L3flUyPKob5VeIrDsVh2+WZyn9xTAm3iSV9+pEEaLllv07Mn9/8k7iR8PArTUD8NK+4PpnD/S+6ypsNgU+FJXqYUq8kgtOYCnulG36sZ81kIYdjdPjJTCRJmABc4RKQKq6XucoYJmyHFru/jOarB57XL5NSopABLUTdS52wOCH+dHOC5DqQtln1chowdbY5edI8MmckSQAxSEHd5MeMdMV6B4k9vHBk4csrwYhvHZtrRJDAleOYuQlhEicoje8JKdCm47lfDh41Arunnv6/2xiKlHIFpPTvTn0rLLWvl7Jl/epTYniTRB+4auc+rMXfpwlsWJy48UQmR/dnm5LYWXN9UCU4Z1kcSVv69PQCXM6IEAObdqzn5WxqtXbTBQeAU2qMtt7xe0UQek8SFdY+v/5N+Z5fs8JGlgxXPNhRtpZdN0tW2BwLkX69fyOidgcCAf4VRspBPS/mrXcTFurO4gfrA1sW4WRB2oTOvETT8tTd9vugug35p4SLbTrHppY28Kq3QJnd6WL7tiRRQ0/6fZ53bGuD+s26R6+D684mAIpwVsBbt2PxkVo+tAaFd0OM4yS4DxARk1WLsRKaePiL2rZGBA6AQDopzDkjjoPAKU3si6UwXFgq9BBerppBTtqEBPJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(83380400001)(86362001)(6666004)(6512007)(82960400001)(66476007)(66556008)(44832011)(8936002)(5660300002)(38100700002)(8676002)(4326008)(41300700001)(9686003)(316002)(110136005)(6506007)(186003)(6486002)(54906003)(478600001)(26005)(66946007)(2906002)(334744004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8SQuhG1lOhKk45FTklxgk4SewZFi8ydxxf1DjLk96p2bEGGpolaIotNSvO3?=
 =?us-ascii?Q?44k4vwFap42l25BXRukcBteeMGdguBDpziu2cmm2ODmX14GoA+WVzmJPQyR2?=
 =?us-ascii?Q?AoWYvvRpu3dY1wYwocFQO/JZctSzn6DYmdvLyWUrMjj0HZPk9dTHMz5qIoAr?=
 =?us-ascii?Q?SzCWr4REUImtNYbshQY4BnljWlFBkXVrR4k+AnE6Ee1n3hcPLlRbh+r84reg?=
 =?us-ascii?Q?JQIXodHe+NAp17Gpccno+EqzHpr5MRNfS/6/5PClyMur0BogjBwTpuCuGfI5?=
 =?us-ascii?Q?ZOPjRqwKEvvES9RpVzrfGnVpd+OBjSv5n7JSdvD7OZVFKCpvMHp1E6//HqPs?=
 =?us-ascii?Q?Up3ujJNyrGhPxA3KKhwRuOvBIk+lZ16FJoBby4sldpeUMnxBs0YUjuVoF28k?=
 =?us-ascii?Q?un9p3yb70wMxZNbma8GJQ9f+hXUWO1kA8VXqWVm2uuq7/RAp7SH5acOp5U17?=
 =?us-ascii?Q?pfnameDORat9Bpdok+RdKxMmZRuJhZMFV2pE1Npz0YEN3Zko7ioE+t4W9t/Y?=
 =?us-ascii?Q?0w8Xopl/fMirHxpb774eSIpDXI+UsJhVawkLnJ2ETyks32u0i+8mk9KUvUYJ?=
 =?us-ascii?Q?MomuF0QZ1I8D0VJ3x6dSZ8OdQG3kkakKeHGiVxH8rg+8rFBuHkwOEKcZvr9O?=
 =?us-ascii?Q?3TQ52kl2n+q6usIspVPaggjLXMXSfnhN0lfOuG5THP8xVpcNtaqt/LGh8rWL?=
 =?us-ascii?Q?jihlyRWlJvO2MX8vApV/y9boOmVmyqrYKY/EJN/QqgGWwlzvRteJofNmxxUe?=
 =?us-ascii?Q?8RiLGjsKzx4nBuiaP1+hApzsoUsfJytbEJVYS5E+rK9Z4YpCOaUMZS4c42E8?=
 =?us-ascii?Q?e80Cx5F4rHqIWqUShaG1R/4zsYcrCGN0MZhBJUnKVq8nydihozojNsqDyznj?=
 =?us-ascii?Q?IjjAbJeoS6+gGnzbEMSA/2lh6hi1t2IdnHBI6JMhTVQ70+NfMaVfa1+Caa+B?=
 =?us-ascii?Q?EyQ8DJ+73uxGMlmPYGerv3D8Jlq30P5JqCk8WH8nHvzFGFOgHgKHfmciPlwr?=
 =?us-ascii?Q?tCdJcJ++GWz7QP0hESA05DIoiLRhXaIyyAh7kMjE4aEpH/l409drWbIpAOFB?=
 =?us-ascii?Q?V2TBNoi7znS2kdGJXlklhnAUpnpppOf1AZ0uaQqO2/FzJO0djWOYye56OJd7?=
 =?us-ascii?Q?qEazEqb4S8DZ7PPluDuObYlOxwDiuV4/dGrHmw+kEJLGhd2oc83eCVeKMFAo?=
 =?us-ascii?Q?iGi8A0UyXKHeuRJZTBJN3C8Yqoxzjis1/uu5syk1luitofji/kaP+IIY1ZE9?=
 =?us-ascii?Q?d8n1pL6chH97bcY1J+WVfdsxy6NTqWraOVcvz+HoHirwDGVCdWbXQbs8ddms?=
 =?us-ascii?Q?/chId2NAfZB/+BAHXWDsFjNO3yC7dlet/eBstAhz2d9pawcQNsRXvQTexwTa?=
 =?us-ascii?Q?BATR5nUtnqXgd5GTTJYaBT3h0sknVzzclL/V9BJaVkZknPIEZyuqSrw975Y2?=
 =?us-ascii?Q?NhwYzQ/ykiUywRQ9+dPVL4pP/duVfXvYk2U1Aq1HtFgK9gNhqBIShbCt58WZ?=
 =?us-ascii?Q?Xh/d1z+d+beP5QX0ORmThq4+pP3eVJlan5ivDnJj2YA2hWSis7GZa6s4xTKi?=
 =?us-ascii?Q?Xlwa5kB/0kHbVArNgrJb30tmb83kKVlimM+aHaI7TOo3YfdSI+0u9zH1zj5i?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4715eca3-2639-40b6-1d99-08db0fb8b18b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 00:56:53.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Leyks2n+h40/Lsaj+rfT3UD3P0uOxSEWTxzozwSiVJZ4MI4DUXXccu7TWgeBFGaMmJy+NNUiqpZckD/DDAUXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> Jonathan notes that cxl_cdat_get_length() and cxl_cdat_read_table()
> allocate 32 dwords for the DOE response even though it may be smaller.
> 
> In the case of cxl_cdat_get_length(), only the second dword of the
> response is of interest (it contains the length).  So reduce the
> allocation to 2 dwords and let DOE discard the remainder.
> 
> In the case of cxl_cdat_read_table(), a correctly sized allocation for
> the full CDAT already exists.  Let DOE write each table entry directly
> into that allocation.  There's a snag in that the table entry is
> preceded by a Table Access Response Header (1 dword).

Where is this 'Table Access Response Header' defined?

Ira

> Save the last
> dword of the previous table entry, let DOE overwrite it with the
> header of the next entry and restore it afterwards.
> 
> The resulting CDAT is preceded by 4 unavoidable useless bytes.  Increase
> the allocation size accordingly and skip these bytes when exposing CDAT
> in sysfs.
> 
> The buffer overflow check in cxl_cdat_read_table() becomes unnecessary
> because the remaining bytes in the allocation are tracked in "length",
> which is passed to DOE and limits how many bytes it writes to the
> allocation.  Additionally, cxl_cdat_read_table() bails out if the DOE
> response is truncated due to insufficient space.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3 on popular request (Jonathan)
> 
>  drivers/cxl/core/pci.c | 34 ++++++++++++++++++----------------
>  drivers/cxl/cxl.h      |  3 ++-
>  drivers/cxl/port.c     |  2 +-
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1b954783b516..70097cc75302 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -471,7 +471,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  			       size_t *length)
>  {
>  	__le32 request = CDAT_DOE_REQ(0);
> -	__le32 response[32];
> +	__le32 response[2];
>  	int rc;
>  
>  	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> @@ -495,28 +495,28 @@ static int cxl_cdat_read_table(struct device *dev,
>  			       struct pci_doe_mb *cdat_doe,
>  			       struct cxl_cdat *cdat)
>  {
> -	size_t length = cdat->length;
> -	u32 *data = cdat->table;
> +	size_t length = cdat->length + sizeof(u32);
> +	__le32 *data = cdat->table;
>  	int entry_handle = 0;
> +	__le32 saved_dw = 0;
>  
>  	do {
>  		__le32 request = CDAT_DOE_REQ(entry_handle);
>  		struct cdat_entry_header *entry;
> -		__le32 response[32];
>  		size_t entry_dw;
>  		int rc;
>  
>  		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
> -			     &response, sizeof(response));
> +			     data, length);
>  		if (rc < 0) {
>  			dev_err(dev, "DOE failed: %d", rc);
>  			return rc;
>  		}
>  
>  		/* 1 DW Table Access Response Header + CDAT entry */
> -		entry = (struct cdat_entry_header *)(response + 1);
> +		entry = (struct cdat_entry_header *)(data + 1);
>  		if ((entry_handle == 0 &&
>  		     rc != sizeof(u32) + sizeof(struct cdat_header)) ||
>  		    (entry_handle > 0 &&
> @@ -526,21 +526,22 @@ static int cxl_cdat_read_table(struct device *dev,
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 le32_to_cpu(response[0]));
> +					 le32_to_cpu(data[0]));
>  		entry_dw = rc / sizeof(u32);
>  		/* Skip Header */
>  		entry_dw -= 1;
> -		entry_dw = min(length / sizeof(u32), entry_dw);
> -		/* Prevent length < 1 DW from causing a buffer overflow */
> -		if (entry_dw) {
> -			memcpy(data, entry, entry_dw * sizeof(u32));
> -			length -= entry_dw * sizeof(u32);
> -			data += entry_dw;
> -		}
> +		/*
> +		 * Table Access Response Header overwrote the last DW of
> +		 * previous entry, so restore that DW
> +		 */
> +		*data = saved_dw;
> +		length -= entry_dw * sizeof(u32);
> +		data += entry_dw;
> +		saved_dw = *data;
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
>  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> -	cdat->length -= length;
> +	cdat->length -= length - sizeof(u32);
>  
>  	return 0;
>  }
> @@ -576,7 +577,8 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	port->cdat.table = devm_kzalloc(dev, cdat_length + sizeof(u32),
> +					GFP_KERNEL);
>  	if (!port->cdat.table)
>  		return;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..78f5cae5134c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -494,7 +494,8 @@ struct cxl_pmem_region {
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
> - * @cdat: Cached CDAT data
> + * @cdat: Cached CDAT data (@table is preceded by 4 null bytes, these are not
> + *	  included in @length)
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   */
>  struct cxl_port {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..0705343ac5ca 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -95,7 +95,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
>  		return 0;
>  
>  	return memory_read_from_buffer(buf, count, &offset,
> -				       port->cdat.table,
> +				       port->cdat.table + sizeof(u32),
>  				       port->cdat.length);
>  }
>  
> -- 
> 2.39.1
> 


