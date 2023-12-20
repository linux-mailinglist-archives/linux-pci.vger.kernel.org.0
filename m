Return-Path: <linux-pci+bounces-1226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BBE81A4F3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C8B2892C2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C03FE33;
	Wed, 20 Dec 2023 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oxy7D9rJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9374A983;
	Wed, 20 Dec 2023 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMYueK81vruFRKiZT5vEbK0daQ6X3ifFt0tDyw0yPViOznm+mdgAiIOasX7eLCvR/+Uc/bRJXCyV1xYn26nIy5HfDqtQ6ev0wLYbWkHnq8ZnvsqJbpiWOpZEZweh04wU4p45+a00vZ7+3lSu3Lct8KPUAXGoEeGwgjtsp9VEhXD4cLH8NQQwiI1X1oqx/qxBCkrX7TQUrDtVljAtSi/kMAVTXDfUEcqw0TOy65zeafQT6HRC7fnC7GLMgPZNiCIMskqR/ifC09/sfnyE4PkvnExwOfY4k+9Wqpo3a2OKCoassuQ0V0Q86lBAMEcKTv3BMtLUTDksjCGReT7ed12+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvPvseM7dgEG7mNeUDnPHQo3HTXHE7gYYkg46vgR5EE=;
 b=It8kpmWIkKmiHCxUw+hIt6y0FaJdWIMi3PmLSX9gMbsma+OnzZdn5zSGqsZtKXwsgxLcy6F5c2217UrWsyoBDSCIa1FFcmNnfC6S5Qf3yOuNCyTCOZCso/3BjJY9ttMno0KNjrkaXkp9jpAOD5qDUKHlt2CoO3/fOFJhbBzmBVLU7EdNeoWbQujm83M9ByqPbqwTkiNFgkQmjVSGTahQJUIVxc8CgY9nsK0+b5PBEJTXssv0If10TcxTrV/nwkD9QaaR0ryKwqXD8ed7rrFD1B+0BLJO5LOZcuKRjtPZyK+uucqehJ8691UhjOq+TD7/GWKoPMPfE6qQ+BvIlhMrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvPvseM7dgEG7mNeUDnPHQo3HTXHE7gYYkg46vgR5EE=;
 b=oxy7D9rJoyK1rutC2lPCtLD3pPLUrS3dtdu1V1gghj/aCC/Kf09XtwOcc9Eb7OA5dMsZ6cn7myTdeEfFz4eC01IYrUuKAG3uAykO1MSnA/hD8Znb5bzBKYwwYWwMbU5MK3XZyJjZY+g1IExDRKWNet8RGJNxh53w1/tuJgByBDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9494.eurprd04.prod.outlook.com (2603:10a6:10:32e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:24:25 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 16:24:25 +0000
Date: Wed, 20 Dec 2023 11:24:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kishon@kernel.org,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer fail
 when BAR1 is fixed size
Message-ID: <ZYMVMo3TVPMiEN/L@lizhi-Precision-Tower-5810>
References: <20231219142403.1223873-1-Frank.Li@nxp.com>
 <20231220142736.GE3544@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220142736.GE3544@thinkpad>
X-ClientProxiedBy: SN1PR12CA0063.namprd12.prod.outlook.com
 (2603:10b6:802:20::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c46b32-d9ae-484e-6fee-08dc01782177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QHjkBaZQ5nyI9Edlnder5OM92R1B/BoChoI0Rt7rnk+RqSmN7mrkjRaeVyIKJfpNWA8RiB0xyNRClxwfL1V3w0yK3jr8slxDn+8SSzs+RL1AoD9GWvo2xVvgOfA8ieWoPWTUoPq+NKykqGgHOlwpHEO+YWdvl77ttPldB7ecOrAeNuPlCI1/fDtAwu7m4S3+hxhdzW95D+fr+SyuN2Zc1K9OK9QLEubyYKzuyCaia9QPMkIr+hUqmiNbiZgEkbJMeA42m8K3foQU9wMHaAwn/kSwzBlORFCPtN4DWErzMwoXjTR3FpYRjqTW5Uk8YZSDvAiq/beAbbRrkTv4hXvML6IKjnzywWFPc9K1JJQfjIkKBcgekC2MaA6UnIewS+Dwvn2QfAnh5zTb+szPpE8LoPn61oQPes54hfA7tSjABjwgazgdufW22SY1JVOVV8SIY979sn4vCBXeLQwnrjW09euF9S5rbFFcJQVwspRiyOKOF09UYnkkxLNzpdyJzsKM60D7UnfwoNwsbt7nhpwBqe9TvFb9saeT7gdwPAj+oiktVS69UJrcQncQx6401H/nRk8Lf8XYY1yWlmMNzSKYafPz5G635fu6k25NsDYHfz3RQ+USRTxW6JkmZCOWd42n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(9686003)(86362001)(6512007)(6666004)(6506007)(478600001)(52116002)(26005)(6916009)(316002)(66556008)(66946007)(66476007)(6486002)(83380400001)(38100700002)(2906002)(7416002)(8676002)(5660300002)(4326008)(8936002)(38350700005)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZZRENpcVRSa1c5Sk0wcmcxb3laV3hqdDFscFVRc1hOaFNiRUQ5aXFUV0th?=
 =?utf-8?B?SFRNZzUyMVE4RENqQUZOYUIyTTNEQmd0eHA5UFhwVGZkN3NaZUYwbGdlSjV1?=
 =?utf-8?B?eUY4RURmbng5bUZsSjRXeXgrTUJaNWNKYVllZGtsZ1NHbmZWUTZFYzgySjBC?=
 =?utf-8?B?WEJCUCtRUmJZM0t4dGlZMWJMRExCaVBqQUYxeGIwd1ZLOGhzcksrVHREN0d5?=
 =?utf-8?B?dlVMbVBWbVZBT1VxbDU3dVRGV3FsM2VPckVxcHFJRnFNSWtZbzNReWVjOFJw?=
 =?utf-8?B?V3JySk1XR3BmK1ViL0g2Y2M4Q3dtRmMwQkxZb0YxdVYwNm0vbk5XR0s1WUpN?=
 =?utf-8?B?TVcvSk5uNlNubU9BZVp0V2d5VFJaWWZhVkl0cFpMbHlGSTUyS3hMbVBhTDBu?=
 =?utf-8?B?ZlZUSTJpK0pMMU9qYWU0dTMvT0swaHpYOU9lbHVTVEN4WFJSV1ViTzI0cnZ0?=
 =?utf-8?B?VUF3Z25jVWJGMHhGTzZFSW9QamFCckd5Z3dNU3B3MzltekxrakhSNGV5aUdD?=
 =?utf-8?B?bWc2VjNxS2dBdU13NWpTMWRVRUZ3dDdteklyYVp1RnZaT2xxOC92VWczRFpq?=
 =?utf-8?B?VDJEb255WEp2QWtsNFFqR2J1eTBFaDVtWWlRZDZ4Mm5kcTMzREIrTFFOTWRQ?=
 =?utf-8?B?V3pRVXYyMlcvL0xyL2lyQ1BLM3J4bTBqeWsrQ2dTNTdpblpXTUVwbCs2NTU0?=
 =?utf-8?B?ZWEwL2RWekFBb1VWR2dyb1A3M1Nqby9VY28zb2FwM25oajBzUHpCcW0ydW45?=
 =?utf-8?B?REJTajA2V2l0dWUreFU3NGdPcWhrdFAxcUFJQ1o0K2ZWTjBDc2Z5eFVLVXk3?=
 =?utf-8?B?VGlkT1B6VUdsRE5VaFcyZ1E4Q2pkSVMya2t2eUxDMGdERVp3bEZJZ1ZWVG43?=
 =?utf-8?B?TlkyenBPbUd0SGJncmVEVW9wTy8wdkc4cEhvVmlUeG0vQkpUZFhDYW5HV0FG?=
 =?utf-8?B?eHd3b1kxVHpkTldtZERlcVRzU1hZT1VVQWxlNFQzNm1ZQmdBQmlTZTlSQ0Z3?=
 =?utf-8?B?M21sdlRIb2c0UkhsK3hHbmhqNHZZcldvWmN6U2gzN1BwemVOS1lYdENic1VQ?=
 =?utf-8?B?Q25mK2hELzcyTnlBVXJqT0xDMHRjSzJnQlFYRnZQTGZFUWxucHE0YkZNcWtS?=
 =?utf-8?B?dFFXOGZ5Y0JUZk1lYzJxb0h1ZkY5ckw0c2xMVUdRQlZPelpMSXFwbnJsNk1Z?=
 =?utf-8?B?d3lJTjBoZ2tHTk5SUjRkOXNRYW12SG9OcDExVjBaSmNhL2JaYzkyeTJ6Ynhk?=
 =?utf-8?B?UDJ0VXdtNXdYTGVKdHQySGxUMWJremlzVlZtVTdoQlhrUzRZU2RMcFdVMHVW?=
 =?utf-8?B?VXJwVHVlb3NyQktMS0VXNmJ4OFlWZ3BIUkFBVGNEdmZ0djV3dkdOcmxERDUz?=
 =?utf-8?B?VTNCenphbFdRVVUxeEhPbEdFYWhib0R4VzNOdy8vRkZxUUNzaFl5dlV0NVdw?=
 =?utf-8?B?MU14NVVYUjU0ZHlNUjJ2bVkySFAzQUtmRnpmUnB4Z1diYlh3cStZZktyZCtJ?=
 =?utf-8?B?V2VOMUxVMmpJODFWb2dra2JIdXdPNllMUEpGZ2prTmIzNzN3YmlDYzA3amtM?=
 =?utf-8?B?NGU4VTNiUFdOeDI2ZWhvaEQ2SFpVUTFXMEtHTnNqOGpUaWJRU0l6NTArNEs3?=
 =?utf-8?B?eFVtSmhoSGRLTjJlSlRNUTZjMTFKU3BRS1hZd21vamd4dENqZndOY3lOaVVE?=
 =?utf-8?B?QWdtNVZialA3QVRLYi9leU5ZT2xUaFVqYy9zbVNDcURiV0tPRmdDZ2ttS01z?=
 =?utf-8?B?VzQ1bVpOL1NrS0NDNjl1bEpJMTYxMTNVcEtIZEF6QUh6Z2wya3RzeGtJV0sv?=
 =?utf-8?B?N1hyZjY5QzJqakZQMFVlanl2QjdIMVBNb0piVUk0YzNwVWg3S1EvdWwrbU5y?=
 =?utf-8?B?azJTZ25Qc2J5ZFk3SXZEcy9jeC81TWpGc2R6TVdxODk4ZlEzSzlFQmJoRkgv?=
 =?utf-8?B?OFZZd2EvUmFZa1d5eldHMm1SQnhvTlVvcFBuMzVOSEM0TUxQdFRMU3hDSi95?=
 =?utf-8?B?V2cwUkhwV2h2MVpTNkk2YnR5UjJsL21yWXlvTjlXKzZ0TlZONUdDendEZkFJ?=
 =?utf-8?B?VmsyUy83YXRmdVpxb2s2NTJ1S0NQd0srWjZZMk51bFVEQjA2c3FIN3NDOER1?=
 =?utf-8?Q?6Ikc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c46b32-d9ae-484e-6fee-08dc01782177
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:24:25.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dGuqjSEE4FgHc33TdFtlpWrbyNQ6tc5L1fS2RZ4zyZXkHRFUOmXEoFM5hsMkNvNGYnBFeLbWVtlz/B1Pb2Ttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9494

On Wed, Dec 20, 2023 at 07:57:36PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 19, 2023 at 09:24:03AM -0500, Frank Li wrote:
> > ntb_netdev transfer is failing when epc controller's BAR1 is fix size, such
> > as 64K. Certain controller(like dwc) require memory address must be align
> > with the fixed bar size.
> > 
> > For example:
> > 	If BAR1's fix size is 64K, and other size programmable BAR's
> > alignment is 4K.
> > 	vntb call pci_epf_alloc_space() get 4K aligned address, like
> > 0x104E31000. But root complex actually write to address 0x104E30000 when
> > write BAR1.
> > 
> > Adds bar_fixed_size check and sets correct alignment for fixed-size BAR.
> > 
> 
> Change looks fine by me, but I have a hard time understanding this commit
> message.
> 
> The change just checks the size of the doorbell BAR if a fixed size BAR is used
> by the controller and uses the fixed size. In the commit message you are talking
> about alignment and root complex writing to the BAR which are just confusing.
> 
> Please reword this commit message to make it understandable.

Maybe I talk about too much about it. Actually, supposed it should  work if
use fixed-size bar(64K), which actually only mapped 4k, if RC only use 4k
also.

"copy from dwc spec"

But dwc iATU IATU_LWR_TARGET_ADDR_OFF_INBOUND_0
11-0
LWR_TARGET_HW
Forms the LSB's of the Lower Target part of the new address of the translated region.
Forms the LSB's of the Lower Target part of the new address of the translated region. The start address must be aligned to a CX_ATU_MIN_REGION_SIZE kB boundary (in address match mode); and to the Bar size boundary (in BAR match mode) so that these bits are always '0'. If the BAR is smaller than the iATU region size, then the iATU target address must align to the iATU region size; otherwise it must align to the BAR size.
A write to this location is ignored by the PCIe controller.
- Field size depends on log2(CX_ATU_MIN_REGION_SIZE) in address match mode.
- Field size depends on log2(BAR_MASK+1) in BAR match mode.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For fixed size bar, BAR_MASK is fixed value. If pass down a 4k aligned
address to iATU for 64K fixed sized bar, some address bits will be
truncated. 

Hidden some hardware detail, do you think if it is enough?

"ntb_netdev transfer is failing when epc controller's BAR1 is fix size.
Adds bar_fixed_size check. If require memory bigger than BAR1's fixed size,
return -ENOMEM. If smaller than BAR1's fixed size, use BAR1's fixed size."

Frank

> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v2
> >     - Remove unnessary set align when fix_bar_size.
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 3f60128560ed0..ec3922f404efe 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> >  
> >  	barno = ntb->epf_ntb_bar[BAR_DB];
> >  
> > +	if (epc_features->bar_fixed_size[barno]) {
> > +		if (size > epc_features->bar_fixed_size[barno]) {
> > +			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
> > +			return -EINVAL;
> 
> -ENOMEM?
> 
> - Mani
> 
> > +		}
> > +		size = epc_features->bar_fixed_size[barno];
> > +	}
> > +
> >  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> >  	if (!mw_addr) {
> >  		dev_err(dev, "Failed to allocate OB address\n");
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

