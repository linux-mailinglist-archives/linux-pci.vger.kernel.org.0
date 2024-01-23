Return-Path: <linux-pci+bounces-2461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D821E838A1B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091FD1C21FC6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739758114;
	Tue, 23 Jan 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o/iLO5Dm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nhv94hp1"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73956B78
	for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001523; cv=fail; b=b5hbKQZb2E0+GeZjin4QK2hmlCU39iyN3VspHJtQG5gbcelsdfZ82wvkwMHKg98vWnUTnn8lS+V4QCNbOVG7X676i3YK8+V1eE4olEDBf/j7wUSbI/py3+vSnIPhTuRo4lBKTi/PJRGA9p2XdbNqbvuz4nGc2ypV8j9xLn/Iioo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001523; c=relaxed/simple;
	bh=eB0anAP+x+Say8Ee4iifhfjZDxEOt+PO5wJzFv0BA6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UPYgIo+fR2Cuywv72giGyoVUsXE0yrYFqelHPcd2S+TqiLKQJ1qm3AJqP5V9ZqSqeMDv1RQZT62dRqdzN82H8fIZlfo5FuXoj0CrPuyQcAeNrJsqQK+doLEnkDVCUEww7Mx/WMhVS+4Mifd0k+cc0cVR2DXQtV4EuwWjM8Xsgh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o/iLO5Dm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nhv94hp1; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706001522; x=1737537522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eB0anAP+x+Say8Ee4iifhfjZDxEOt+PO5wJzFv0BA6M=;
  b=o/iLO5Dmuw69e5WnGrJjVOIpHERpCTtR1kpGYIjlJroJKe1n6gvi6atl
   k9qN/VhErwudr/n+ceRKtg2xoW857BAuW15VJvKDJP99ZXMV3UFQtomZP
   +pU3Bj+wfAImmBLG+syuZZco9QePIjJMLL0z5f2b0DGPbUfcFZluuAOYG
   6dzEN1ff1JPsSNFZnQjR5ajVECRnZ6s2sZE/LpRg4hQdm7cV0vcMpnsJ+
   sRtLWn/Wxnd1iCylhEIbk8rQCMAxGSWFOyR/UHDKn4U7E+cjsZBFtrIXW
   0jH7DWAVbAetuTdRsmIHCYdnrmle9Ayg//w9AqHhsIex7oy2SqzmRpH3t
   Q==;
X-CSE-ConnectionGUID: 8FcTfk1YQymgN1zwKyVUaA==
X-CSE-MsgGUID: IhMZPsoqTFO9oAiqRLffHA==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7460324"
Received: from mail-eastusazlp17013024.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.11.24])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:18:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcUO8JveZmGPstNPqqMDS+O6+z6eOjI7frKyyXRFJfF6l/LEdClKAHcf4MvcHd/wuSOgrd9w2gFmtzISTkVmGMslwzmeaNE4adLVxKq4+5BL/IeDu7gP/v7C7AaZJ9Zm/tDMINZ9rkM9TdZg2qt1Jq1YzGLU0xWi9doZ8xwmBzuRZc5qACmRQVmnMkfLHqwGDZ7NMm8IXiBgwC2UIrhXFIXH4IytQCQ9MDEFAodV8W7q29FnO98Nu+YToDUZ5sa9ANrcjJ1sWRMTLfOGR8WqFMUHo2XxsCABxdqEnCoyWF2gWaqcm7N1QB/DmpKBKA+n+O1prp8oS4aNoPhVu0osDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC//qBk4hBXS5DNIn8Dofpl2WQsKWjkUOZR1OIN/90s=;
 b=HiWGBcZ6DpFESGrTM1PUoKhzlCutcdjUBdmJ7dZtBTSwlhkqdefKfEZHb2uyrpFFvI/zirMavL4ChRtjERnKUG4GBXaxoVrJkFDjYbPwH4JUwCWsaFMRYKhQR3Y7Fhxeu6/Z816LpVq75hxlC08jKkcoORxjC1BjFgR0czwlcghWYeYZPFPAz4PHosZ0iVPJv80U92Lju9X9afIy4fZrJbYnGAdp/I2BWVE+vNK5NU8LjBlJoFMA3dvEypsEglFzrIqtsngoRYYq3vAJCoC7ftUbPmJ/ou/1zDVRDif5wwhHrHZfZRRJwnVwmQLkbKbfwI4aZJXpP5BbWLJIpRrhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC//qBk4hBXS5DNIn8Dofpl2WQsKWjkUOZR1OIN/90s=;
 b=nhv94hp1X3Vp7oa8jYnsOjwjdw26+Hfj1YOLunTQuHoZafnGXVxlvLjVBvudo3V9ar590E7QbdPVGkbiyWLWNB3dYiMMO8Rg9RjSunpM4Xx3BvIMZGsPH4Eb7W3btJEKvND2Z2lgVbOaIO1eL9V5FwXqGiMMhOlwzyGIrWHkBNU=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by MW6PR04MB8869.namprd04.prod.outlook.com (2603:10b6:303:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 09:18:32 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::f955:275b:3305:4440%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:18:31 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index:
 AQHaIiIryDDmjYJXQUiqpuEqK4O7WLCRLOCAgABGvQCAAAxigIAA60IAgABPfQCAACtvgIAjWssAgBbgVQCAExQfgIAA2JUAgAZn/AA=
Date: Tue, 23 Jan 2024 09:18:31 +0000
Message-ID: <Za+EZmGONuQn/OaS@x1-carbon>
References: <ZWcitTbK/wW4VY+K@x1-carbon> <20231129155140.GC7621@thinkpad>
 <ZWdob6tgWf6919/s@x1-carbon> <20231130063800.GD3043@thinkpad>
 <ZWhwdkpSNzIdi23t@x1-carbon> <20231130135757.GS3043@thinkpad>
 <ZYY9QHRE4Zz30LG8@x1-carbon> <20240106151238.GC2512@thinkpad>
 <Zalu//dNi5BhZlBU@x1-carbon> <20240119070116.GA2866@thinkpad>
In-Reply-To: <20240119070116.GA2866@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|MW6PR04MB8869:EE_
x-ms-office365-filtering-correlation-id: 873f1c1e-2b5c-45f9-242a-08dc1bf444a6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xSe9k6PvSu9wlt9z29Dm1y/xcubpUq9qy/U7ZdUAiqRVwA0t7conFew/8v5wtRuL/za4GIed3Mi2K3eNlOe1uewugznMXDRnzlo0KiItT8RV6PX+AHNjTKu0+AFAHshLf7nTxL8JkDlf5DRmH+KQsb6EPAXkmJSahBc6gCNuJSLOrnfDsr0j2aBd49WU7J7V9hwpG7G69IYw2YKn+isoQhP6p8x8H8yKe9wr82QOhmSSfYG32bpxLG/ZUIpvnx7nJvHR7t3ANMyHeK8yr/bZxeqp3nGuBo/MJxYUSXg7kLyqzjAsYTeDCbkjKLLFVjugC+7spcB2K5ELOYOQ4NFl/sXabJ1cFq/Z4skyQvXdj0uHK7pCp0U1jU58Kmgf92QyPduehKUZ0qTPl1LZOHnXF6ysE2Qy32XtJCPtCpGS2NQXyReXfr+Cj8jhzTuv3kVHWK+LqL9CREVeXKXtmr9lCZXy4sxEJJTD7PTTanKs933R2VNKuGAvmgCVHJjsvaDm9vDOiRnR5hlgNc6X14/5UuV+Mb8Yaiir5WAhMccYhlJsVue0fJaM24evQA03L3HOviQKkispHjVYIMeoVVLCpEYHfQZT6HyNRjcnZI/BrlDnMLuejWpuPDMfQ8i4zfnL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(71200400001)(9686003)(6512007)(6506007)(26005)(122000001)(86362001)(38100700002)(82960400001)(38070700009)(41300700001)(33716001)(2906002)(5660300002)(6486002)(76116006)(4326008)(54906003)(8676002)(66476007)(66556008)(66446008)(6916009)(8936002)(66946007)(478600001)(64756008)(91956017)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VTd8z+6MdvwEBskV8rVzQm4oJHG9DEPbTbs0YQcJSVAPa7YuqZQ1Hhu0l1ur?=
 =?us-ascii?Q?ugtEY7RQfrKY96wW3GA5eAaaY4a3LTVU/2kdu527ykxN48bY8betwBAqrZlb?=
 =?us-ascii?Q?uEmc/ees3HbgQ3AkTIsfsXTgarndzHfm56c1u1W5FKLyd+vVZ+8e9ldDxpT1?=
 =?us-ascii?Q?0LZydEBEkZMbv4sL7Vr4cgG3Riocx49xnro61MAC0RSwOaI95wp0mIY4y8ds?=
 =?us-ascii?Q?0z5N72psUTx0oBoinTIxbi6KbWZMUzHL1J1u9p65+4uU5hx6/OdHbLO6SILc?=
 =?us-ascii?Q?EJEfsxRu4YYQq+izoh++m/5Ec41CSAkgoQzXP5pRbELNo0k0XNnDvP9AZdXD?=
 =?us-ascii?Q?OHeefH93fJY5H/X9f3ClE7jiEla63+Zw5oACJ92QDO27eXWHS2DAqpTZwC+r?=
 =?us-ascii?Q?hdXoNTgO1ffNiKCQkwP37qnx4naCSmREVe2v6QxJw3MS23jA2+gJpl9/+6JR?=
 =?us-ascii?Q?QeX+5fNeNG2Sh3h9kF/m6Ex9GgAyXvh6lRTTDOWwQZ21vFfKPOZ48iMgmc9J?=
 =?us-ascii?Q?4P8fuhNobRn4tc1VGfsIGRIhJKFw91DcpspYgIUtaEsRRIBkFIapzEkheFV/?=
 =?us-ascii?Q?8O0+OzTeCkCTO4h8qsnYW1Ij6L8k3vef7Ld/JvjjHMvqtz/Fv64Mt10pI7p3?=
 =?us-ascii?Q?3bkUX+LH7J35nwmdQMFYlUyJiRYM0seMEEzYIRwdpFqspVnoJGYtup8yFeld?=
 =?us-ascii?Q?sXsMtlNcUPklS4bo00PXv8/UIviIUwVFERKMJC+bjy5785QgKh22GWCiWLBf?=
 =?us-ascii?Q?ahHXlxisr5zJlADH4kPanNuWmVsFMjLVPAkWQeIZ6hvdynCKrYbPug7vdspf?=
 =?us-ascii?Q?y0PVXq5uYEbnaO++Nk7/fZ/F4zsC6HX7sUqmHxqBCLZjZsoPaiMKMOu2iVKA?=
 =?us-ascii?Q?KOxQQSoLjl5vASorxJCKtuEroMJiB4Vv1kU/8ZDNAj5qJsF2ODzZG8+Qb/sK?=
 =?us-ascii?Q?V4PU28H/vN9LRkJrgLmLKGJRv47Fxzj1dl0XwTez4HixVqaqfd0dwnJDLwID?=
 =?us-ascii?Q?OsiBsVFpdBDMOOE+MjxefA7MW0X5Tuf6bCqVcFM3tzUTl7ejseP1vzBrtVgL?=
 =?us-ascii?Q?ymoYm6oY/VhWVJgfkwLAKhGe5U/UnZqHFzgx8/MOrfaE+wNBVk1bzDINEm16?=
 =?us-ascii?Q?IYBM0IYO69U9+c5jl5OdB43PO/AtRBtC8m9TQG3fodQlrZDKUZXo92YRZzx3?=
 =?us-ascii?Q?X8U69llRkjeDaXw1L1rQUiFyQJV3nsOwJSoPjXkbN44pcRjx6sxjtLNqvA/J?=
 =?us-ascii?Q?KJD+IuugQ6Cc9yK4Dts4pea0TbpKglNzsaoMHL/K91X8uJfUJ8BCYXGHkynq?=
 =?us-ascii?Q?H2AkQ3cFPoPRfn3RtM3d2tA+dbVKFFSJzBM+Ul0YBlarjPwP/NAD9hvG73X+?=
 =?us-ascii?Q?nmn5cf2204mLJs6QSGZsKRw2Hm1TrEZa2rXG7HCNTc1rJVikA7lvlpJHaLAS?=
 =?us-ascii?Q?DYXYSnROdxIKb7/+XN3sReQXPRENZaeVaYIjDS0UzjUQDpaVPyGsKP3iP6/E?=
 =?us-ascii?Q?ec9F2LjNCEKTVKUVpYaB4t+63NCICFwZf+34HV31TSUSfXMjd6lQBIwHJs43?=
 =?us-ascii?Q?t/JDT2TFliq23sAw3JaxKBO9bDKplE9XYh4xHfmmoZpAHioduFK5X7BtFNlM?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C506C7EFC9BE0840837D20565079CEE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HGsd/ffjT0cxLkDFnnsXDTwdc88Sujl/Lpk/zNiZ7RMD/+UDkWFFjUPP4un1bygZk2lMKDHmYj2SrjuUwUg8XF89sCdtQm2A+k+h35b4SH1tLsbQnnQp3NQ/2+mi4mwMHTenBIWw9pZjE25KT7KTgHNSXiZhj5BwdH/1iqI6+Oc6xILZziF0cHd0AfJOSt7JkpMM/Ev4g13IMX0YGiKvpRRs3KN5Mb0ARcRi1d+fbxjCU7VZ5PIPsfwWzMsDuVBA7e4HKzde7tNGjvbg0AEA596YIgv/C5X1JZEP6eehgM8rnvdVDE7HcZQk1COLHqPDc3V8g+MYuFyHscGLGwOwjpGY+/9goKjqWCPe83XJzVj33dw9k/Z1sXTBrTRONfur9VqIPddGVCwYhloyV8l5vsV/fdr/SKuD5cpc9NCfz5Fm36yveFFFvAV72vRQyzDMKe8+smP14dy8N/MHlQBsmN4HeuWNlgUWg2d6VXpefyeJUqQhu1bAcWOxT10q2UIs/jX5Z4l0gcLeDpiAvN36p8nk6TKfeXLDWfaAr490rkaH+n4FosKDBDOoIdcL0nxqwCZPfja+kPNZnsTcNjwl9yEd6OgWpSQG9oCH+Vp3g5F/GDyYSwPU4na5BH3P9Fo2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873f1c1e-2b5c-45f9-242a-08dc1bf444a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:18:31.7101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBKEAycvIxOw9p91ZkbtOats+gC9SYITH1DJ6UyAgFSaL3KHB7wTgXIBEZc8vkT6KoIyN1Zw10k0EfkWfDWbDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8869

On Fri, Jan 19, 2024 at 12:58:46PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 18, 2024 at 06:33:35PM +0000, Niklas Cassel wrote:

(snip)

> > A nicer solution would probably be to modify dw_pcie_ep_set_bar() to
> > properly handle controllers with the Resizable BAR capability, and remo=
ve
> > the RESBAR related code from dw_pcie_ep_init_complete().
> >=20
> > However, that would still require changes in pci-epf-test.c to call
> > set_bar() after a hot reset/link-down reset (and it is not possible
> > to distinguish between them), which could be done by either:
> > 1) Making sure that the glue drivers (that implement Resizable BAR capa=
bility)
> >  call dw_pcie_ep_init_notify() when receiving a hot reset/link-down res=
et
> >  IRQ (or maybe instead when getting the link up IRQ), as that will
> >  trigger pci-epf-test.c to (once again) call set_bar().
> > or
> > 2) Modifying pci-epf-test.c:pci_epf_test_link_up() to call set_bar()
> >  (If epc_features doesn't have a core_init_notifier, as in that case
> >  set_bar() is called by pci_epf_test_core_init()).
> >  (Since I assume that not all SoCs might have a PERST GPIO.)
> > or
> > 3) We could allow glue drivers that use an internal refclk to still mak=
e
> >  use of the PERST GPIO IRQ, and only call dw_pcie_ep_init_notify(),
> >  as that would also cause pci-epf-test.c to call set_bar().
> >  (These glue drivers, which implement the Resizable BAR capability woul=
d
> >  however not need to perform a full core reset, etc. in the PERST GPIO
> >  IRQ handler, they only need to call dw_pcie_ep_init_notify().)
> >=20
> > Right now, I think I prefer 1).
> >=20
> > What do you think?
> >=20
>=20
> [For this context, I'm not only focusing on REBAR but all of the non-stic=
ky DWC
> registers]
>=20
> If the PCIe spec has mandated using PERST# for all endpoints, I would've
> definitely went with option 3. But the spec has made PERST# as optional f=
or the
> endpoints, so we cannot force the glue drivers to make use of PERST# IRQ.
>=20
> But the solution I'm thinking is, we should reconfigure all non-sticky DW=
C
> registers during LINK_DOWN phase irrespective of whether core_init_notifi=
er is
> used or not. This should work for both cases because we can skip configur=
ing the
> DWC registers when the core_init platforms try to do it again during PERS=
T#
> deassert.
>=20
> Wdyt?

I'm guessing you mean something like, create a dw_pcie_ep_linkdown() functi=
on,
that:
1) calls a dwc_pcie_ep_reinit_non_sticky()
2) calls pci_epc_linkdown()

If so, I like the suggestion.


The only problem I can see is that not all DWC EP glue drivers might have
an IRQ for link down. But I don't see any better way.
(I guess the glue drivers that don't have an IRQ on link down could have a
kthread that polls dw_pcie_link_up(), if they want to be able to handle the
RC/host rebooting.)

One thing comes to mind though...
Some EPF drivers might have a .link_down handler, which might e.g. dealloc =
the
memory backing the BARs. But I guess that is fine, as long as we have calle=
d
dwc_pcie_ep_reinit_non_sticky() before calling pci_epc_linkdown(), the
non-sticky registers have been re-initialized, so even if a EPF driver perf=
orms
a .link_down() + .link_up(), the non-sticky registers in DWC core should st=
ill
have proper values set.


Kind regards,
Niklas=

