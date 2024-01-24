Return-Path: <linux-pci+bounces-2532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A983B31C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDBE1F2108D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890E7C091;
	Wed, 24 Jan 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWYVHUUl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10F64CFE
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128477; cv=fail; b=hG/sKU0b5qlVs1Sfh72sEPCvKCZgLtT0EvVQtmGiVu+apn2+VW1MrvSK83uG6hO4nj65xGPLY2fkncASOLekczXNbitIJrbZswCeprDTS6wfacZYrga8E80WAsjSFd0LmL6lhKwy0DdEINKZt3FpFmjCH5rLsUYRpWps08ZAJRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128477; c=relaxed/simple;
	bh=SCBSvqoryenDXp9uZyxcyDkbX260cWVw7Lub5pIHntY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Np7pItHMe7arszFLiLZBhq8fJwjACEaJPLO5IjU5dQPqwVIhZ8zZ8oryuvIMYG/yq9UsgLA93GD0RMBo9rqND81zen7V5XXrTclkQ6D0jr1wwZOnp+Nr70/i5JPBw5xBr6tUqf7OeQMll7G7k9YMtdf3IQcWi7izPR1TDeyIrpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWYVHUUl; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706128476; x=1737664476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SCBSvqoryenDXp9uZyxcyDkbX260cWVw7Lub5pIHntY=;
  b=OWYVHUUlM5prml3rGOf/elex/dufjBFL4vTp5g6KBkBP/EeP4pDurQEY
   UPElUc/+3n19VffVTZHM+zw258Pn1Nk+j9xPJw+iOpeE7TKyRQniYM2zU
   O3eRHLulFKm7CeCRE8QtMHTZwRg7k8/jNiswb6MFlPjEGnas7vnHJMZeH
   XWjLvgH9JseaKM62pIciQ+6i+KovasO4F9sTxUdvP5Fzx00dvxdLS7wr9
   kTthiLEx4fyEcoMRpwYCir2ptFf3docWaFWP4co4n7xHlpQlLbb0nmjk4
   +1iiCD1iZEbt3Cm/9XA/IT7a8kpRot1M76kMyYeB0S148ZiHxeTRAXKrS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399120552"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399120552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2181052"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 12:34:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:34:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:34:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 12:34:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 12:34:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTYSLGKsYNi2qPneYf2XqNuTzyz5suvGy0gWP0TTOlsWUuIUjqP4sYBCBeuaf1nn2j+JafISwZzqQsxhH1nc9K5h6nuy/fyQ+FNGbKP41aMhzolB2FHkIr+2cdOY4mlxTCMzMApDS8xx7H11dmLN5jJBKt1iSP9cJC0IHlYhY1qAx4vnCfifRTXiKdmtURz8ep+4YyVz6FaPLQxccQj6BMYSS8yfRYpr7GOqxf8eAXwWKjWl4suMgpPoKT8/Fp0bLM1noX6myqR6G6+ZJ6RZsOg8TWc5xn0GqdJPen4tuoS3AfAhCno2X0xO4g9sp6M2U3eGwPbsXOJmu/3CA3wKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8McsGwINoM3XkInRnIvYATf9KogDg1flGxBFBLJCp8=;
 b=UdncuQfNeeAbDV0C04drfLahhPP5nhNM+YxF7SBNhoi+kBNC9N9Oica6kIgO40Mibhj2AV3K7iGkA8EZBP6XrRNyleYvPEkKxu3zYjeOhh5ZWb/OFkZER7L6d+sv35SYYr3E37S9aVUMWQiXyI/HTkkTKuTmm2+3X95b5/LVLCWLMjYTSpU026WcpWpASEIHyQ/8r6f+ST/iT3FNoMeXtgbK4LdMiHeu/81QYN/DYPCTPM9GvkN2HwcVfcef8LUAunzYKjGgk364MN45XvKVTGIQFZDwiV9QjS2CoiHLhEmwnwbhEfiPIjLTMRCYj5DLcAT6vioB3ALeZC1r8+CvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 20:34:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 20:34:25 +0000
Date: Wed, 24 Jan 2024 14:34:22 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Dani Liberman <dliberman@habana.ai>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Gordeev <agordeev@redhat.com>, <linux-pci@vger.kernel.org>
Subject: Re: Re: [PATCH v2] drm/xe/irq: allocate all possible msix interrupts
Message-ID: <glzb7wto57sesypswgwvk5z7bqieahcjl3htcpsjufwja2azss@u36oldlhylhq>
References: <20240121090214.2072923-1-dliberman@habana.ai>
 <fxq47vgjlyhjeijm26ftw37zzcza4ai4jwgxtvuekpe4t2y2z5@dxhsegrvwkul>
 <6f2080ad-135f-4c7e-bd40-47f531db2d7f@habana.ai>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <6f2080ad-135f-4c7e-bd40-47f531db2d7f@habana.ai>
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: aba74a46-bda5-4991-7ae9-08dc1d1bdafd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8usjuwW9V1V2Gh98oYs+cGUEG/vaNDUkriHKLahxtUzTYbLr01ZqQholr/yyCgWcWorBBwPYJVUwf9xJNgmm4L2k1z34oeudPPIPdVb09IDzFISUPdj8Zl3jQwBm4N5fQL57CtQlnHrTy2H/KplrkmXxFBrLUY/YGDVOkz1WxSiwtaYqkJwqtnaSZfw3Jh8bFpNMAj4x0+MwUaDwk8/03SSaXGz6PaqKkVQHcSSZWeuy31V21e5yaZfB3OdMqhtA83Jhh+CmJGftBLQNrDUjCDn9ZLX4eZoj0fWIxucpNvN2zJwwye4XRoS2lIRC/SnEK1S8sNrjCq0zG2wc0EnTomc/GHddlI/XIpI/ZvXec6b3ZkvfISn9mnO7tjXfBHifhUVaj5r+U+DVet7clCzjyGuQjtxjCEoYMzT4/4NHRKBaKX/750UClt7O8zACZANZ4VW5lMjJbQMjrRki/4Eyu9mw7tPfNqVJ1kbopF5yOb/CPccVwTzzGqyEECGEO2WJg7+fJl89gjWUfFJLbEKE+IVSbmI+45dLiTU7ezmy24QXw8VSBcRyLLhv6hY+qgR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(66899024)(33716001)(6666004)(41300700001)(6512007)(9686003)(6506007)(66476007)(6916009)(316002)(66556008)(54906003)(82960400001)(5660300002)(6486002)(8676002)(8936002)(4326008)(38100700002)(2906002)(478600001)(86362001)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8Q0RY79tnNbF5vzzXceYYanwgBb+MQPVnzsHmTnfqeKK3Y8UFq1TFvw2sQG?=
 =?us-ascii?Q?tcZjj79+bbnU4xhJFiMu4Swh5lfWM94aFl78qTVfmgSk9GDZxGpQsxFc94Nv?=
 =?us-ascii?Q?lG0IuZfOlO+5/UPqYe/XeQZFyhe+TtXDbgCtAbgts6hMVMiujS4t5eNfJUm3?=
 =?us-ascii?Q?PMDHBqa933S4d7kpKZLsdAc+qVIJH6evbV7eJMJppJmi6fmzijbFSJT9/Uq8?=
 =?us-ascii?Q?RPrBlkuXXvMz1fzDR0jVNVi6vQGGK2pBFBtCxFd/oH9lKwXRfXJSNgUSpfp5?=
 =?us-ascii?Q?uBqK6awFoMsZkErXp3slX4LVEpDdKEnqU7roVq/jgjQ4aczVeQrtfl0ZtzvU?=
 =?us-ascii?Q?MRoyEPs0d6nOTGTFYkkGSJ+rO0hpjHP09jb7YKG32y0GU4bY+MjwAzmt4+fK?=
 =?us-ascii?Q?8fM21YRLfrZifa3dZZDg4UmZEp1zTWYsztaIPY+FmaExeXP8T7qNdj2MOYsI?=
 =?us-ascii?Q?ho9cb9IPkW5qSFmPj7/00ZwQ1BtWceN+GSRP1zyWOZiOfVIqUONKqme03Rc0?=
 =?us-ascii?Q?aBQEz5evXs1FTxpxvXvzpnxwPjZRl2h6aKvsKTq2krLAI7ZgheWPwN/FEPPm?=
 =?us-ascii?Q?c7Z+h6qd/LBZOkaXBQmdQTpvTVK9s87xDxQEplkEISPBRvdABWIJ4zdcNuM2?=
 =?us-ascii?Q?bM90uFQMEW3+iamdKlFS08ebgxBeaGTso1irJ7cuqt3vo1PbDyPLGFED/owp?=
 =?us-ascii?Q?MFF19HVt8gjCROKA1bK8TgZxuxPQX3vFC99IVyGMpPh0Mok96YLSEreYmC+o?=
 =?us-ascii?Q?X3D57E303GU4fyhPj93G+UsMgSENQnWIGXEysicKzwUX6GMc3EXrt1TkhlNU?=
 =?us-ascii?Q?hLdE3f72uvCIEIWvXYjFI4Z3lkdRHE+bC7nwWEJix6jltWB7BBxMoserZp08?=
 =?us-ascii?Q?geQjC+yp5MHC6O923a8I6W4lPRryYwORISgbBJIJ+S20KvRZOwh7XHSGqgiu?=
 =?us-ascii?Q?ISAxVHKhM5Y2TfYoe/lxI+4TM9DKOa3hCjyRpRYgYI44oWy9+kadtTLrQncg?=
 =?us-ascii?Q?RhdXi1wu7RU9QI2WopcPQqgcnx9KAamwmzXxmTEAv1AZPblC+4gSiQ0BlBuy?=
 =?us-ascii?Q?McYwkHUOJ+sZJP+kkqQ4rn2cKtHRtWxDY2wFch88odB8pNdHap/H5ivwFN0r?=
 =?us-ascii?Q?qP6qPyo+YdHaCODcKrLVsgNQjTmrmkyUB9ok4TFPXhGrJLXtYUPUpOzOQM2e?=
 =?us-ascii?Q?ptWT5VBsYORKYqd+OjGOkUBA3a+SHfSM9hqleFecN3XjuH9rOw0AtVL1I8NQ?=
 =?us-ascii?Q?+eAjQHc5FpVkkYmrc9z3/YkTksdMeuMot9AGfsdLjJ5L4k2X48qdhXPenJkH?=
 =?us-ascii?Q?j9UpdZlkc5lmcu21acGyL2admcM4MxFQ1xNjnc77tcKqAumww4pFztFGfIsD?=
 =?us-ascii?Q?GvAHdY18N7yqwwFlvae/UuSLZe7g1vWtabCGkDnIBIVlm2eOVYCv0kmBBUMX?=
 =?us-ascii?Q?8k8cPioJts0y12QpVbCy56Ah7iIkC5UgmfC3UNOC6myADTrZ4RufLn5eur88?=
 =?us-ascii?Q?/Tp4qKaUU9m/k2PDsOI5OlWHjbq4yWFEnNBUkcqzhyOQB+DOMFxuNJ34qUo5?=
 =?us-ascii?Q?Q0jvxyLMAtOQPl+tEmvwXmf7VKZGUrIIKBf11PNuQ4vY4j6ltwQl0CHll6Qg?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aba74a46-bda5-4991-7ae9-08dc1d1bdafd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 20:34:25.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2fL3XNXnHRCUVtNzCEjsoR3x3Xx1FCSkxZCBgeFCMV5i9UDOyKI20oqC+HbgN8s3TdxnDx59uIc7K1axWfOO/7QnXsVfrSDIgAXk23d8Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-OriginatorOrg: intel.com

+linux-pci and few people involved with
aff171641d18 ("PCI: Provide sensible IRQ vector alloc/free routines")
for possible feedback.

On Tue, Jan 23, 2024 at 11:34:17AM -0600, Dani Liberman wrote:
>On 23/01/2024 18:37, Lucas De Marchi wrote:
>> On Sun, Jan 21, 2024 at 11:02:14AM +0200, Dani Liberman wrote:
>>> If platform supports MSIX, driver needs to allocate all possible
>>> interrupts.
>>>
>>> v2:
>>>  - drop msix_cap and use the api return code instead.
>>>  - fix commit message.
>>>
>>> Cc: Ohad Sharabi <osharabi@habana.ai>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> Signed-off-by: Dani Liberman <dliberman@habana.ai>
>>> ---
>>> drivers/gpu/drm/xe/xe_irq.c | 15 +++++++++++++--
>>> 1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
>>> index 907c8ff0fa21..7a23d25c1062 100644
>>> --- a/drivers/gpu/drm/xe/xe_irq.c
>>> +++ b/drivers/gpu/drm/xe/xe_irq.c
>>> @@ -662,7 +662,7 @@ int xe_irq_install(struct xe_device *xe)
>>> {
>>>     struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>>>     irq_handler_t irq_handler;
>>> -    int err, irq;
>>> +    int err, irq, nvec;
>>>
>>>     irq_handler = xe_irq_handler(xe);
>>>     if (!irq_handler) {
>>> @@ -672,7 +672,18 @@ int xe_irq_install(struct xe_device *xe)
>>>
>>>     xe_irq_reset(xe);
>>>
>>> -    err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI |
>>> PCI_IRQ_MSIX);
>>> +    nvec = pci_msix_vec_count(pdev);
>>
>> From docs:
>>     Additionally there are APIs to provide the number of supported MSI
>> or MSI-X
>>     vectors: pci_msi_vec_count() and pci_msix_vec_count().  In general
>> these
>>     should be avoided in favor of letting pci_alloc_irq_vectors() cap the
>>     number of vectors.  If you have a legitimate special use case for
>> the count
>>     of vectors we might have to revisit that decision and add a
>>     pci_nr_irq_vectors() helper that handles MSI and MSI-X transparently.
>>
>>
>>
>>> +    if (nvec <= 0) {
>>> +        if (nvec == -EINVAL) {
>>> +            /* MSIX capability is not supported in the device, using
>>> MSI */
>>> +            nvec = 1;
>>> +        } else {
>>> +            drm_err(&xe->drm, "MSIX: Failed getting count\n");
>>> +            return nvec;
>>> +        }
>>> +    }
>>> +
>>> +    err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSI |
>>> PCI_IRQ_MSIX);
>>
>> these are just possible flags, so what you did above was for nothing?
>> If platform doesn't support MSIX and we pass e.g. 16, we will still have
>> just 1 allocated. So, as I said in the other version, this is just a
>> maximum the **driver** wants to deal with. Still not clear why we need
>> this rather than just pass a value for max that covers all the
>> platforms.
>>
>> Lucas De Marchi
>
>We need it for the minimum msix vectors value.
>
>The maximum msix vectors allowed is 2K, lets say we have a platform with
>1K interrupts, we must ensure allocation of 1K vectors.
>
>If we pass min_vec = 1, max_vec =2K and the api will allocate only 512,
>it will still pass and we won't have any indication.

ok, so you need it for the **minimum** to be "all the platform
supports" and you don't accept less than that. From that pov it makes
sense.  For people added in Cc, is that an acceptable use of 
pci_msix_vec_count()?

thanks
Lucas De Marchi

>
>About the docs, so yes, if we have a platform specific code, we know
>exactly the number of interrupts and we will just use a define. But
>since it's a common code that should support more than 1 msix platform,
>we need to use this api.
>
>Dani Liberman
>
>>
>>>     if (err < 0) {
>>>         drm_err(&xe->drm, "MSI/MSIX: Failed to enable support %d\n",
>>> err);
>>>         return err;
>>> --
>>> 2.34.1
>>>
>

