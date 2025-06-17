Return-Path: <linux-pci+bounces-29966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE9ADDB39
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 20:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771897AA3E9
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D6246BB4;
	Tue, 17 Jun 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="epvfjnVg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE82EBB84;
	Tue, 17 Jun 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184461; cv=fail; b=jKZZ+74WGPnCyEdn6Z6DsuXvEnlSFkuISmUyNlyXddqtAgAk5ExLoIgJWKJSu2wgpiLN3WTOzqAz7x5Gq16tk66rK3nU7gvPunJTuuL5qNYZN3UNWxWyGaqQpBP6KdHsa+TgCiyEa4is0YSlT9yIo+bLOnLCPrEer500rmXpBwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184461; c=relaxed/simple;
	bh=tS+JZvSgdAUPOSmICMe8uWyZfLdmqU0RYRfMHjNXwIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rGXsxcp1RPChyolWIhlynOjV413IUMFy840+Tu/eRkaFyeonbVE/p7gz9kkEzMIAa0jb/HH8RLHNz2uVk49lMQ7SnAKUwO24nyGYu8oEljlxI4F5GrIzTNvLD4rmJnTMpYZthC67xqTrNRjXKMu15pPrTIxuW5/p14QeA1sv5Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=epvfjnVg; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vew9cAVjknmWlvvSwZSmYe3XlIKFABwgxb6tHxIlLjJwTFaQJNoUa9BbtvAuQwCcTzFEh2Iu0Y2SJGrnIaziizPwiw14zi05oXddqbdXJMRso5iaJc4KvNi9N17Rwq5QyaKynslVpvgt/NO2RHVJ1XxcWFY4LXj5DVt6JIkA2I8vL/I7tif7B1egmJSWnCSN2sedWTbsQ3D/L4+jUdLt04k9+6O0uNUzI3dMuU6nZNe49iSgt8UsLwtFNe5QKpJn2W/v6ixs1mHYFVE5dUm30p4h8x6TdDCqzxTRJWugStxD/f0HMIssbcBLq9Q1/8T2SDeHJJL83z5OeCs71fWszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sps+tlSq0E8OunutN3kbzA1d3YNSaSeClS7+Tn7XICA=;
 b=Ee9JUhYKGBsY0lRaVDcQLFIRsJWYj5dzy32U3Ux4PnnaqMYboQfCmb72oBjBf2iv1MMVypZpJ7ed8dyBFDI83OGGOmymKHfUJ2/XiLlle5DEemT42DLbKIrwktHuzjy8P12rgzzXESQkkCT/lWT/rUfxro130+pUZHTH6GrPhclI+Ux0+g9Qo73kPCnEg+wQXoJpqiLHWXhQRv6Zv1GTA/H0IjHe31bSKOyKUsyhohomzuoRD9zhfh0FN105T5W+5synFjGXhkB5d0lsG/WRnI3kJbeRsupFTM141h0QHbZ3A0eijO5XqFYUwezbsCQC6vgYVui6FZ9D+gxb5YuR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sps+tlSq0E8OunutN3kbzA1d3YNSaSeClS7+Tn7XICA=;
 b=epvfjnVgZXqbNNwxYOvmM1imGMZkSvhXwwjXs5Cu0+L+B2eqQg58jq8hbEEkTfBGyULACBjn1HTXxJQY04TQ1pL86voovw2lRUDkjk5i6F4CZqb7B1LOeVHJyF4VjFzVRN6c8g/PKEEuC2CmecwIpBjGBdnlVuzvHfhVxeQQfcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 18:20:56 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 18:20:56 +0000
Date: Tue, 17 Jun 2025 20:20:48 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Bowman, Terry" <terry.bowman@amd.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
	dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
	kobayashi.da-06@fujitsu.com, peterz@infradead.org,
	fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
Message-ID: <aFGyADxBLT5tSbFX@rric.localdomain>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <aEexYj8uImRt0kr9@wunner.de>
 <aad4372e-d73b-47f9-9736-31dc1e6e03b0@amd.com>
 <a602603b-e075-46a1-a4bf-3653954faa08@amd.com>
 <aEkIXiM3jaCvKw3o@wunner.de>
 <79e86754-710a-4335-8a09-a756201f7ae4@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e86754-710a-4335-8a09-a756201f7ae4@intel.com>
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fc4a23-31af-4563-b785-08ddadcbb3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cL7yhXSkKYs7uzw7eZ73q8WizgfVGIQaMwvapBVFq8l40BbWrv5gdoHIhU8+?=
 =?us-ascii?Q?5AkKUQWuAVDOyevOfcdyngQT/9aUcHfAntSDxvmiX0c9N8lOaErxdZZbtqx/?=
 =?us-ascii?Q?4LrSRwl74FJdqQBGDAMk7C+lHa7hLQW16irHykVTvNZx2nveEoJzbk54piAo?=
 =?us-ascii?Q?vqGjEjEk+V96nQR53XqkF0v9FlDSh1mhCJMgjQdSHcMnGrJcZEtaWNi7jMbt?=
 =?us-ascii?Q?LOXPJq+2GexZ638kIRkS1r07MUQmRrj323qqf8YdkGXwvrduwESOGbJbANDi?=
 =?us-ascii?Q?YerwPA/A8iFDSHRIowOYe+lGt1+VT33aonNfQKtkJvzG2lzrcBYe5yq0r17O?=
 =?us-ascii?Q?B5MhCPjYX2I958NsUuBF0hdoPtrH6ysWkRUZWqZLlnQaL021JE9xGNEZBW7u?=
 =?us-ascii?Q?FacKqOZI0ZWN9EZC3UERlTdsfeDT2zJi5VZrd85VQNKHltjBp0bK7JD1LfMO?=
 =?us-ascii?Q?EJ4Tlk1JX011UZwyOtVYGx7qNEAdVXOHlN2GqXBoUSNMhprmeIlazRs4OCzQ?=
 =?us-ascii?Q?L4u8txPe47hywrtbiCLZgkUkSziO3x1ZTF2fWxFe186T1LoM9+X6ylHrC43w?=
 =?us-ascii?Q?S9JjLyUr9C7RkrMEbtZgTE4AraI+s1BxloW7gWqF5djFE22DnvZd1WtzoOwU?=
 =?us-ascii?Q?722u0ApTX7+jzXTiVxWLEqghmTT9jKApAbhR3JTXU6GdTK3BdDGbx90uaOKx?=
 =?us-ascii?Q?Tr7rC8ug8gdxBi6l/BZh2Oo700UM7L6wEUitaPFXvWzFoOnPvH1Al09Utamk?=
 =?us-ascii?Q?yB1d0gX2AGFRx82SF47XU/bLYJNlJM9r53/bL9Fqy/uZZCiUMnITkAaIp2Fx?=
 =?us-ascii?Q?tHNHVHR0jIs9/t7T0cFFtuBGDmixtex7hDeCNxM3jmvWAnjeFfAZauBs9Nj8?=
 =?us-ascii?Q?K9dpiwM9uHmergIhS6KY0WI2sEC2E4Z/1+veq8STS+NfJoMZviex+G5d0Oo1?=
 =?us-ascii?Q?rv19IKFzvG8e+tI5stdF2RMUYlgYbtwc5idYKPcEOq2/7mAv7uTWZjYlXfiH?=
 =?us-ascii?Q?ozgfAlGYVAzvf23JwkaBjEBSfI2o0xc3QZ/yQ8YeSiNhZRXEm0gqZuAkpqwH?=
 =?us-ascii?Q?CfoTqsRKONi3I645SZsM0KCQ1fsK2dwJYUBXUj3KyXBPhY3u5okWQb1W7WlP?=
 =?us-ascii?Q?K0EiSVBzNe5npJ5dZht5btkr+5wvjccVALYZWE7smnknrEoJm3DVf6ZYoTg1?=
 =?us-ascii?Q?sabTZS/w5OLJ13cUKUfJyeJU0ucuvDpfk6+nhyIk6ge+izGwWuDp1ya2miy4?=
 =?us-ascii?Q?teKzv/rCPGTXzC2zHzIief0JWS0RoibgXnRCfCC/qA7UIQAoc7Fkoj0+XqLX?=
 =?us-ascii?Q?CTW7K3MuW0ZYGR+RF085kMNLd1/+jWD3qD9cmgpAtx9OidjDmf+f/cEA8NkM?=
 =?us-ascii?Q?pFGSPIWCSLifbzXx8+3Ea2i5nHgW+BVuFbcN5G2nBzm23jIeSZOOicv9ccUL?=
 =?us-ascii?Q?jUgV2C6WHh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMnnvM4z/kpMbXLKDEN2q4+ylFPWzHGYQqrNo3C2aFtN0MIF8eX/YyrbOfAe?=
 =?us-ascii?Q?WI6+QCEAqPVT90ygw1Ed8tbX3aDDr8JU7EhHgpgdRBT1Vj6+qjOlOfFMtzyQ?=
 =?us-ascii?Q?XlQfY06HZqpciYx/vUmTFN+mWw1bxNkIvo3+eK1bSzt0q+lr7M4bfR7hH4sK?=
 =?us-ascii?Q?mEhas5QMoK5HiPYoXfSVaGj/D3H/2YoN7MHpEL4geEriPnU9kFfIpgkzE568?=
 =?us-ascii?Q?KMG/iTT8cwPZqnYphQCbND64+KFYoTlcZUC17/qBmYJkrArDUb50EfIEKq1p?=
 =?us-ascii?Q?+bYEaAbNEpDZcIr6EVeC0EqkvwjhtL8qFLIkigD9tWWVgt7PBZS0AkmvzqSE?=
 =?us-ascii?Q?Cvlq/k5EA159/jY2q0It6v8adA58HKlZ9aJJTpf+L03K+WlBctDS1aRJA8q9?=
 =?us-ascii?Q?mQbIkXuNxFSGOpYe0CvTDRfoMzZzvwF+ScON6q51DbwetnrdOQ99/7qDFT48?=
 =?us-ascii?Q?gZVCLTA9DzpmJRMiLp0FcUeE8KiSPXy3PdBZW0qyldzQfXyXq2S+HurKmPOu?=
 =?us-ascii?Q?dE9MmWjKh7BdNoBD86TUGLbv4G2Uwu0X2u1CIpfue8EVVz1YHdvxJGCRlwGC?=
 =?us-ascii?Q?8boZPkJwsevpWDqIUQx7fHciDDaZGkk/eC4bTYvb4Ujpu0Zh7NhE1FOAHgs5?=
 =?us-ascii?Q?s4EVlygHLwTEXNDHFhKUHFsj4Kio6ZI2YHuS3FO1yC3ZaK0ASzLIVmcv/pWM?=
 =?us-ascii?Q?7TJG3caBH2b6KDzsKKU9BQsrCbWyptjgNP4Zpxnj1rhZmPdAjmNp7K7Rt49a?=
 =?us-ascii?Q?nazOxckqGDOR2BBO/wuXqZM5wnTSAPAoEWat28Ro42C4hc8+9NyQB8ikN4iR?=
 =?us-ascii?Q?LrfG0auYcmYlaTE7EANwNC21GOyJCxtsFPVlNxkc1xzgTutoX+LrSXJLawCF?=
 =?us-ascii?Q?feCTr6cF+MZ+8Va0lXTgnorpjX9BAc/9UVEMsuE8Mi/RH7RS9HBIM9jj0pH5?=
 =?us-ascii?Q?mHk2dNERANJRGTTrrhPfes0zBOVlvCjHdHjHPBLnUogsQ5Ah2DFYBh3FW4rC?=
 =?us-ascii?Q?GvHDWNfwJHblN77Y7LIfVX8pm1OaNhAzM+4OfY6yn0vNTtNFZ0mK0l3VR0xA?=
 =?us-ascii?Q?TkFqQX12b+IqzTyKsHIFmXJTVu30xkKk7y9fWREBjhxw8VfmBqveXmxLv6PM?=
 =?us-ascii?Q?bYmYSp24TTagaZNd4OR/qWWd5osJwUq6Cht1fZMn2sYTZDbf1Wx6ol5AzHtQ?=
 =?us-ascii?Q?5z6jVOVewtOuB9b9G+wIGjTm/HWD+hSLhwGhuxGZrU/IwYj7fJCCScTSD38P?=
 =?us-ascii?Q?SOTwygHNJh1OWEU6PwpVjQTEVOdKJId+P1MgIcI+4upZltflbAwvuC8JJBKg?=
 =?us-ascii?Q?FdCjhCBJkGS915yZJulC00/cWzn/CPoZ4FQ+F+54UNBJD7appnipV+rBobc9?=
 =?us-ascii?Q?7k35mZ4FgvpRp9e3lO/gLikdTEeh+3B7jTD2KzeXvg4JqA0rvF5jaqul7g7p?=
 =?us-ascii?Q?WwquN+nC9NkuyGtICltTv+pyqA8YSz8/3lCFzJMMeZBuunE3AaNBPDBD+Vg/?=
 =?us-ascii?Q?JMg2U2+hqeWdcGmbtSB3DvXFVAKu+MDGDWypxsYQ8C+1clMwt2np2n3HAYA6?=
 =?us-ascii?Q?WLgjP+oKam7+qamcgn9fcs6Jd7WH7GheaW9xOcdE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fc4a23-31af-4563-b785-08ddadcbb3d9
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 18:20:56.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUZLIS/N7yT1TPiqZhX5bEGQ/ORAYOHfKg8Lt26YvBkD/d/FUj6pv4hUHLquEWoE5l/4wh1j/r2euan5hUNoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776

On 17.06.25 09:08:27, Dave Jiang wrote:
> 
> 
> On 6/10/25 9:38 PM, Lukas Wunner wrote:
> > On Tue, Jun 10, 2025 at 04:20:53PM -0500, Bowman, Terry wrote:
> >> On 6/10/2025 1:07 PM, Bowman, Terry wrote:
> >>> On 6/9/2025 11:15 PM, Lukas Wunner wrote:
> >>>> On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
> >>>>> --- a/drivers/cxl/core/ras.c
> >>>>> +++ b/drivers/cxl/core/ras.c
> >>>>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
> >>>>> +{
> >>>>> +	struct cxl_prot_error_info *err_info = data;
> >>>>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
> >>>>> +	struct cxl_dev_state *cxlds;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * The capability, status, and control fields in Device 0,
> >>>>> +	 * Function 0 DVSEC control the CXL functionality of the
> >>>>> +	 * entire device (CXL 3.0, 8.1.3).
> >>>>> +	 */
> >>>>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * CXL Memory Devices must have the 502h class code set (CXL
> >>>>> +	 * 3.0, 8.1.12.1).
> >>>>> +	 */
> >>>>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
> >>>>> +		return 0;
> >>>>
> >>>> Is the point of the "!pdev->dev.driver" check to ascertain that
> >>>> pdev is bound to cxl_pci_driver?
> >>>>
> >>>> If so, you need to check "if (pdev->driver != &cxl_pci_driver)"
> >>>> directly (like cxl_handle_cper_event() does).
> >>>>
> >>>> That's because there are drivers which may bind to *any* PCI device,
> >>>> e.g. vfio_pci_driver.
> >>
> >> Looking closer to implement this change I find the cxl_pci_driver is
> >> defined static in cxl/pci.c and is unavailable to reference in
> >> cxl/core/ras.c as-is. Would you like me to export cxl_pci_driver to
> >> make available for this check?
> > 
> > I'm not sure you need an export.  The consumer you're introducing
> > is located in core/ras.c, which is always built-in, never modular,
> > hence just making it non-static and adding a declaration to cxlpci.h
> > may be sufficient.
> > 
> > An alternative would be to keep it static, but add a non-static helper
> > cxl_pci_drv_bound() or something like that.
> > 
> > I'm passing the buck to CXL maintainers for this. :)
> 

> I don't have a good solution to this. Moving the declaration of
> cxl_pci driver to core would be pretty messy. Perhaps doing the
> dance of calling try_module_get() is less messy? Or maybe Dan has a
> better idea....

That check originally was to ensure the pci driver can connect to the
cxl driver to handle errors. So the cxl driver exposes something here
that can be used to check the binding.

-Robert

