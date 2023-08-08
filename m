Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8977378B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 05:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHHDSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 23:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjHHDSQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 23:18:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD110C0;
        Mon,  7 Aug 2023 20:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691464691; x=1723000691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1jR7ssTcTICuRvCwmu3dKSpb4xpCh0c5yrywDYoyvnw=;
  b=Gum7sVsM3OiMoAIlBthPRpjMHs7TTcXNRqa4pBKa9WSXFOFKIvZ0yE76
   IVplABYJQaRv+l0RSDIRTq6oiWGeOi45UTBg18Oad3vW/3np1LwuhYegn
   jsuMR6+khAvJOZbOAmaHJi5fLekAXkxH0tPkLyRuFMkVbBxjEquIRiAvh
   0J6BuX2bs/Fn3xjZaR6m/G48whQDoXJKOBVMGY6mdi80DcDLtyIE0OOkJ
   E5u8VP6IPDrDcrA004AdQu+X3mIO3481U+AP8+UyQKYycBByawIIfH3cX
   0NuXbSq6nmc3b09kcrEBpBjOmmG1n/c2DpjnSOlAMg3HQ8dPEKqRXGmrW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434555901"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="434555901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845280807"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="845280807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2023 20:18:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:18:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 20:18:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 20:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPSjUZ3TrHuSkrDmrzpdoG5rSbmbaSvwF/oPgF/Ua5dGpTNoY4bEDWZconwTc/55+xdHaLfZQUXN56SUrPitb60Xo3DbT+k++j830y1bmvPXYk55U1+p4Wsmo4xZjxWBH4YtzYjQf7eTGopfnKlpTlTCthOOVHjG74M3duIUmfAooilf7oEXBl0eYt9RF//jR32azf5s7XYA1iyU4lNJLf6GseqK3iNL94SNJvoyv4tUFO6QDMkg9wuhVTLTLsE1RS9ftlw+TbKAiI1tnqJr3LC0JTQDFI2ykUx5d8w9/43wxSfUKd3WqHh55tKDwjg65kKa1DdyMjPu1zu7I/0p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmqOXK+eBZuMVRkpgGuRh3pORDd0LxvT6SdYZEYkZlE=;
 b=nQFqZpw7UYhbwUsgzyiWROG6OFexYmC3oCvOsMMppyIHMhLzPx9muuAoWaKEN4UkmXcyFRSnPqeTz0ileyarm5L6XJN4jUG7qHT8YS3mtDq4zD1SvJfdLuNvswKxzCH2tH1kfm9R9A21GgeQBqC+gWs+Na6o8WgAh/0eG3ki8MK/aT9IxEfzSKQGq+7Fjug4KZypCPxSgIUf7Y36lJSg8br8CNF008CrtQ0nrNJJlmmNuqBqyCqhz77epZGJc2cxuB6xYoCeULJl9CQWkPIfISRgX3gCu1/X1TFMnjdv9Sh798WHQadEYqgvAV7c+NWpHsaw3A6q9PjP1w9601rdsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 8 Aug
 2023 03:18:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 03:18:02 +0000
Date:   Mon, 7 Aug 2023 20:17:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Message-ID: <64d1b3e78629f_5ea6e2944@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:303:6b::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 13085db0-b4ae-44fb-72f9-08db97be1323
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /t4wLOh7hJW5gUnkJrc52SHgVjZE1lYXKdt15MC5YJ5WzMGujaOEQ/j4Nc5nu75ll+cdOz+Nb3UULpv+GaKjq7BT8kn0xDzP4E8lWrIC9rkHdjpcVkaAn1ZsBVS7R47cVWNGraTzRSUV3hEBdm0Rg3YiD4sO1QH8TN/a5g58RbQ7boHLURFWcMvGyi71/OCiDfEP+CMjZ7VhIlQikPdetfP88J/xfN78ifLFY0cZrl5o+TUTVxRnY4AF+z1bmSJRSZTb/2CVOoIKvAQVOAJynKnKiSR8wrW1yDGRsJedLQMNol/htBqLq4PK7Oa/z8vrefH6/+r99dYBGoRKZkKDnIhLdmjocmET6DUw6jpHYcp5g2aGIzm/FdXmrFxUw9ojYAcLl+gNHaW3Fkv0fzltp4IAi3GLGMpcxJQhINDvNhdpmhR637I+iOwtKGU+Qf/SsJMXgH2DPVnusMy7LZJgeFqlNyTLmGp5FzebSTZFMPF0KhyjIS2Van4V5flFfF5noNR4WG6JCZjNoCvY8lRAY//wHmEMCHObDvRWVj6sKUI9dsJcDtOZzLsufd2fVyIdzHKiD/CoXkyxm3A4GXBCIakVGIn7vgojBjOC68B+vrQ2RWKAvrHVzaBWaBmRpVYJ4axErnjlYmS8X54Pu+dvxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(1800799003)(90011799007)(451199021)(90021799007)(186006)(66476007)(5660300002)(86362001)(316002)(8676002)(4326008)(38100700002)(8936002)(54906003)(66946007)(7416002)(66556008)(41300700001)(82960400001)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(26005)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IIYJLF5z8LtElkh2fDGorU48ZsQ1r+7rhvJqqeuXhM/OyYL0Z9vwRg9Vr39T?=
 =?us-ascii?Q?asgvOdgXfGv+cgwz1osKxdQHxITdqYVxfYe2Zajox+NZJB9flt21oOrXw4FV?=
 =?us-ascii?Q?dHf+cJBrQICvahWf2/wT0vl29nA5qnvB0BwPL494d2eiKZL5qmLg2a7ezGsM?=
 =?us-ascii?Q?cjrvJrkHMgAmX9TfRlVn57r9mS4KEzfMt0MJCQ3/nxb7AteGOO5MtMFifdbm?=
 =?us-ascii?Q?Ad5e0kQ54SJHSESlOMIEwHEuAhKzh4z7Tal3It7ubIpgYj3Zt31WCSjuY948?=
 =?us-ascii?Q?k/2kSc8Ml+eIiLtipcD9+j38M8BIypOcnRWvpY+i/5ScZi5ZjUs9u7HE9NAH?=
 =?us-ascii?Q?8NFqqf9/9xjYka6bgcKqz9XQQHHXSPJtgvn2Gbs+Vl2cS5f/TgGN3qFJglrV?=
 =?us-ascii?Q?MAx5WrqreGS2aOn+oEMVqDnuE39KFKq0r+l/M+6tfCStF6zerXSXK2XOqY1p?=
 =?us-ascii?Q?kGbK36PYW5GQ9JesmeZNvpQcIIpjM3t3ZtdqqTG+mrZBDtCEEbKIHbd9u8AE?=
 =?us-ascii?Q?I5+rLb1H5i078iaYEvOQ+ledlA8ixclw4b8R6Si/66HV1cC9qsFmxDtN/EM9?=
 =?us-ascii?Q?ELGvdN1Xqkd1peB8A9Ee8nWZ3VVAJtVG/4i7UuIW8ib1CCz2Bd3l3cH+YbIl?=
 =?us-ascii?Q?F09w3U52UnsZa4AlloEPP0ziN4kReeaB9HpUXBhtzGm0bGmVrYmlvyur7qyQ?=
 =?us-ascii?Q?FHyIU1kjQgb3Ytc2Ojz/DL6BcTZdP/oOFo2KzeXf/sRPJgXwuCFF2rnEK3L4?=
 =?us-ascii?Q?g6xD2B0ScVy8la2Ge8zU1NQBb/z5Bh4dqtfukFACl5CKFlCCqBv29buIHc0S?=
 =?us-ascii?Q?ngIklw0N2W2mG7a4lrHV5K/nAOMsrpnGaFxRPEexfVC7nuOQ6nEnX4yZ/Z82?=
 =?us-ascii?Q?t0r6Aa6dkiwww3FKBuSFVS2ZXeSK+GmmZq7sjcKeXVS+Y2Cjj/ZbzAAA6Uvg?=
 =?us-ascii?Q?p0sqf9G3tCvh/QYTa1aeQrtPaE9MRK/bqgE4U0wGy0ZTvPOIMWnoZEtgyHwE?=
 =?us-ascii?Q?MCfW1tYbaLjyZiDbk75DZIh/+yAIUnqTpgl4yQZcxA2x9C+muPqGMdhrIJ18?=
 =?us-ascii?Q?gwNVyH5uFSCDSqD0MvTHo6b4YyTeB4JEjPQrRyQmrqVKrH47lRSdcsvNVPMG?=
 =?us-ascii?Q?qkSKKE4Rqm0cG6S2rZDbuCORex5hoq8ufY4QbpGK+8fSNKH9PACC4HRbdxRG?=
 =?us-ascii?Q?n+O8xsbdBnfGH1RRzZWMRmppXnXXnq6IbiS4QAFAqRkH2trYQj+3WJY2LOFC?=
 =?us-ascii?Q?x6aEMVUzLbifykJWTXhIYDzQIPjcpf5arzRWe5xMcQS5lqoFJW9WYKDwcl8t?=
 =?us-ascii?Q?vXrH2jZa1G7JGa3kI9bwaYjrvZSGcAFKW4UZE5asl/sNwnV7XfO3bVAWdcnc?=
 =?us-ascii?Q?CccBfrZNefA8xVOSYkT99KAGs04LIji7/Mxgbc55rUFBGkd0r/Tyc/W+N3m4?=
 =?us-ascii?Q?djfCKy48PAe75yzKdEW5/tXsfAT9shXpsyocFhO0dzLk7aUldRDOzX2fx6f5?=
 =?us-ascii?Q?QVTNLBUI2dDigc2OC7IHTJr5ymDLIdCG3/wDgD8gJ62xLnvGwICYnw43/4In?=
 =?us-ascii?Q?O7E2yTLz4vPsoFmFRNPQBEITkS6Vr+e73IWgDO+4HhwN68JaqasJD2G+fhvo?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13085db0-b4ae-44fb-72f9-08db97be1323
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:18:02.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRRJtINurzcAFdwltiQ17dCd1vCTJdSNuCAa5fRipU0lA3lURIqFHYT0COyFJ9WFIV/TzFXf3+7JUS8lJwB3zvJw3+vRd8Xu8hAKTZMDRS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Smita Koralahalli wrote:
> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
> of AER should also own CXL Protocol Error Management as there is no
> explicit control of CXL Protocol error. And the CXL RAS Cap registers
> reported on Protocol errors should check for AER _OSC rather than CXL
> Memory Error Reporting Control _OSC.
> 
> The CXL Memory Error Reporting Control _OSC specifically highlights
> handling Memory Error Logging and Signaling Enhancements. These kinds of
> errors are reported through a device's mailbox and can be managed
> independently from CXL Protocol Errors.
> 
> This change fixes handling and reporting CXL Protocol Errors and RAS
> registers natively with native AER and FW-First CXL Memory Error Reporting
> Control.

I feel like this could be said more succinctly and with an indication of
what the end user should expect to see. Something like:

"cxl_pci fails to unmask CXL protocol errors when CXL memory error
reporting is not granted native control. Given that CXL memory error
reporting uses the event interface and protocol errors use AER, unmask
protocol errors based only on the native AER setting. Without this
change end user deployments will fail to report protocol errors in the
case where native memory error handling is not granted to Linux."

> 
> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
> 
> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> v2:
> 	Added fixes tag.
> 	Included what the patch fixes in commit message.
> ---
>  drivers/cxl/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..2323169b6e5f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  		return 0;
>  	}
>  
> -	/* BIOS has CXL error control */
> -	if (!host_bridge->native_cxl_error)
> -		return -ENXIO;
> +	/* BIOS has PCIe AER error control */
> +	if (!host_bridge->native_aer)
> +		return 0;

The error code does not matter here and changing it makes the patch that
bit much more noisier than it needs to be. So just leave it as:

	return -ENXIO;

>  
>  	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>  	if (rc)
> -- 
> 2.17.1
> 



