Return-Path: <linux-pci+bounces-4022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562AA867A79
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4891F26D2D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48B12BE84;
	Mon, 26 Feb 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="W9BBaHUl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3312B179;
	Mon, 26 Feb 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962066; cv=fail; b=qBxML8JfIbN7liCCtRVH7HI6R6En4ZagNwEPpyzfddLFTBwkJVWWOa+OWSjxwRVsfn7ttdJgJN1HMVwmfwB0mWnFfHrR5Tb0Pa5gGMhKizWePG3pg27U7gIVv2B4AsPWdxioHiuKgVp18mAQMaPYa+xl+PoBSfhbvTGEq6YwkNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962066; c=relaxed/simple;
	bh=OtNX1ro6ukZju381FMmGk0FDKUzqCHvu5rllIxl5U/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oV/Nml0vwMySFQSFmf099Uto8TwdeO8qcDKsWmOqTVhZI6gMYe7145dOMLDeeX0+eqrkEedtLMzTJaeNa7rhnGx6zWl3VTCV5Agn2MBPMj92FGkZk/2hzUtK8+qxAMkh/nM5W3iaZxvoegx8YEBu4b6ghSPB8Me4ukKR+tPbDn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=W9BBaHUl; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QCIh4S011594;
	Mon, 26 Feb 2024 07:40:31 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wfgun5hjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 07:40:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA+5PaTP4z5BRoQSnagqSpNja3ktfYOpzp0kJsDPkdpsEjnpFrRO9KgeXMKZqoeybzR4MTTGy5fcpMaxzz4dROy6SqLxkHd9zsFkPR0kTOx6ajkzprqNYSnyHP8vXEW8U+ifsbZ58uiTzPFr6NAo3bw0aFItN+zkrwoP6Y8byvvf+9MOg19h59XcBVPzqSFh7ZWIX0SGVnSGnrEdKDVGm+FdKBkmv60piyXOa7yjY0nofuy6Cmiziz+z8KQhC8orYcWTF4xFDLizCkEq3z0UldmWQJGWIvELPAWIejuVvWNsRIjUCHpoXCNTv/TeMSEyNcLcVvpqiXi0LtBB0HdZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n+bi7CdwTVa7ijILqI4Td2PO6QiL+C5ZyaL/FwzHF0=;
 b=oYDCqqv0F333dgBBitR2Pr27bfOGIW+aIXodxprIwF0EfToc+aGz0BJ37UPOR3pGvixbsy4dUetjikRoaMjaib6SfgX9TsqqUjZ+eR63GHnpH1ftoL4pMTHT5+NKc9LjQy313SL5YSTJQ0SpQJDjmG9JsJ0BULMxmHKqegghog5e1g7hfc77a9WDyuS4SWyvm7r2v+5YvNGet/AFkqSgUishT+scrw/nds08T2BmNGANEJxYxiBL9BmRHkSWN9qPtV3MGxu3LeeHypG1UkaOrnRj3w+HfXwNsE+DV5XfUuBKgk3Pt6c5yw3pqSqvSkYb5MUyJa8p7XbWzQif5QxVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n+bi7CdwTVa7ijILqI4Td2PO6QiL+C5ZyaL/FwzHF0=;
 b=W9BBaHUlfAAtQ+VSYBmtvv0t0k2BfJp1PbQIx5Cc663dikitUlNUMxRk+mVqjibhdQNjSM7SgdzYRvke4w5qAZW90moejUU74TTO9d5OWw/bc4ZN/x5UkIPuqAVp3wrve+1lj+EnEA41+RXSPR26ul/C+xXg2Q9ALwBjL/cz3uo=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SJ0PR18MB5040.namprd18.prod.outlook.com (2603:10b6:a03:418::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 15:40:25 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:40:25 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Thread-Topic: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Thread-Index: AQHaaModtbBIWSYYL06cdcFlcceFHQ==
Date: Mon, 26 Feb 2024 15:40:25 +0000
Message-ID: 
 <BY3PR18MB470764DFFE3E532B8D1851E4A05A2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240214130853.1321836-1-saikrishnag@marvell.com>
 <20240214172851.GA1258497@bhelgaas>
In-Reply-To: <20240214172851.GA1258497@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SJ0PR18MB5040:EE_
x-ms-office365-filtering-correlation-id: 4dbb1e45-0ad5-4341-9a35-08dc36e1407e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IxcBgcEQRJqNiBTNjzmT9vivgf7LaZ31YFfr9hRFrS8BxGkIrQwo7D+jvZnKdxch4Womy43nV2cl0kYMAUXU/KgUFzvK3XsbOzwuKJUwRR1MlD9eKOGc3cAAx0NGxRqvngo3bTYfeCICmd9+qDMUpbbnRN5zEaGZtEF5C89ehKlVptl5hlcUr2XUakAFW8axjXYQAjJ5xIrjiRwBxflQbFJG3YkHCM9HRiLoMB1ClLlcf+LzZYeccTRBPAwpExGSmecMZqvJgIKL7eQx9BlpDIAWEqls/OD0Op9a2EKepgN3mYNm0NF56GVKTQg0F+4EBKzaY85nfIR1ADhgL+z7dELnAqS8NO2uiZgvChWTPzh0ecBnlBKwJJrJtohzwZEbeqbuwu1dNnXhRzluTEuH949sxcxzcRqAqTNvzjw6QXWRVBvP1345ubXg1aJvz+S30gwtDr/bcy2drJKQhY4nWMJY+w7JPHMaD9vORqkfT3sSvw25VPpcHis3LGbZuVUP6I399dbjQhI4W3hVaxn9S1kx49uLHSwNlsImaKbESXsYmEJaIbX6V94sxBmbUrWwUVr7ALec8Qp83ClWXOMXsGt+zo248v8TKH7Z1DuqF+x2IgcP/1Q8m593zU6JxrTJQyY8qpzztd0P8GfSQjSUA7du52S1/JzO2dQ1dXuDAI1UpJ/5qLyKdnpQmM1KI4UX7vGMxErxbnveE2FkCHAnAw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?e5QfkIlFsAOZ1251L5jm9cE4SG2AUmn3gLcniO2/B2cVgmpRJG5258fr3wNz?=
 =?us-ascii?Q?oZjOFHyfl6+3mVMab/CWWDhs20532sLR93tSGFCgAbFnZqRSmgdXMwPBMivt?=
 =?us-ascii?Q?vVL/dMmF6gIT0MKP44r9s+8Pbnk1sjCQ33bC8LWjAerr0D2MRRzPVK2gDC+z?=
 =?us-ascii?Q?e2WzZKAWZ7eaPSYjfPTvXsHOuGW03iXYSmLF5fRptgTbWh67is4jRnEVwiRy?=
 =?us-ascii?Q?4DJp261IUM4inAz75A8SGC8TtYwEPAjIqi2RkOIxR1nAmKn1KZ3ZwoKcDMvL?=
 =?us-ascii?Q?yNzalR+BLFNSYSm6hb0K49SY3p9o1gdRfYciQ4k2U6quA80xawSGx5IEjfQ+?=
 =?us-ascii?Q?93G174BtnFruH4pHeKsAkva+fvPy8ndzwPAF7uZAuJNaRA66GbF90mdADis5?=
 =?us-ascii?Q?7z0xkSRpY2Tw+eC/AqY91RlFTj4yhFkClZDkuCxFfeYBBLoe0/+3Bec8nr94?=
 =?us-ascii?Q?kjAPrg9UmxTVcAjes+rrlSWUeiv0ydjqCbdx9vQUHypAspEi9yYQPprtp5FS?=
 =?us-ascii?Q?QEVCCYZ0nAUD5wNyUNq3pu/oiaOsE71gk+D+b7efCocuesF2mRQCMtTo4UbJ?=
 =?us-ascii?Q?KxDVfwsF0Sm02YSPqQOOwFkETz/sf8L9I+EVHtSkaJLLjkcmH8tlfL0Nk+1C?=
 =?us-ascii?Q?pBhLDj5v6a6G12q9xsFJH6N6EGIOfOxWTxbZQG76XstLMihe/BYNe2hJX7bP?=
 =?us-ascii?Q?MYYAz7qJgYKEG+7PrntcXRTu9q7AUc3o4pkTqQC0U81RnsPGb5PoBPOZdg6Q?=
 =?us-ascii?Q?ey+jVYZiGRxX9PIa7dbttCLOcTNhpcrRYC2lwt8q/KyhVLjJYi3dWIBVBcns?=
 =?us-ascii?Q?isf3WDdYEGOYaFz47sDwMMzWtsMWQIgYF8Ao9RgEQ/Pv+ifqfqErA2BucuVr?=
 =?us-ascii?Q?/U509bEkoyLXXtSDw7k+WmoCOAdccH8OSVvIMN/aVCfppGpD9rm/zIqEr4An?=
 =?us-ascii?Q?VLVxCil/4TFClXkSFRtMKUKlGUB+xfpQhdTp7nuiVkyJhqA2UroJN6wq3NkV?=
 =?us-ascii?Q?KJn2vrSyoy6aGk/B/5O3OnCgDdFgbDqIQssgGGBUk3jGrz64pPeK7lTQ5XBY?=
 =?us-ascii?Q?zIoAGP8Hdr97HAKjWVP+r75D2P5t2Bu0M3n6Tvvp83DdsIjxTjoRtxRmRaEi?=
 =?us-ascii?Q?4rE8pXyiYtyy6xdvYVo5oRTjB3EH6wkHZLBAMuoPGf2GgTbg545eaV777J1C?=
 =?us-ascii?Q?M6LWz+IE2KhK0tLXqKujAaQbOd++znDW1EC7hfb2/MqVFD3ZryzUP68PFEbM?=
 =?us-ascii?Q?aTXErLBREnw7ujv3flPGEtqnm5/kAzciGwTf5HyaOUMyT7Aon1dS2BOFIs3p?=
 =?us-ascii?Q?IPUXjWsuVNbiwYUZVxe0Xgzxe4iGzdihAW0H+9eudwKTfJGjmaF/pVktr0re?=
 =?us-ascii?Q?y2BbbUAN4gmYWpdui8vByl7NyIzGeteiju8BMck5zxsTxIQb6hoO+krpkHQi?=
 =?us-ascii?Q?jTtFpKgkAM7ZXmgCn+m+RG2xGeVLIzGlyJcWNBhRMz/hfl4L3nbJz2H6+Z5M?=
 =?us-ascii?Q?eqP7VkD3W3AgAaqoItueltPqNrTfU7hzeVuc6VodfCW9yk1tXjMYPurMufXw?=
 =?us-ascii?Q?HiugnmaUC3CN4dk+QSJ48hbnJRR0Mv5HLZf8zEMb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb1e45-0ad5-4341-9a35-08dc36e1407e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 15:40:25.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HoRn/hLdigeIZaH6UFmXzgPN72R5RM9qSOzlmIgVFSmxfYQa4d2lQzqkJDWMUw/wZ4lC2kEZoNImcuOgftEcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5040
X-Proofpoint-ORIG-GUID: _A0Ji7BAJspR4HUryrCjUrbr_avtFC0-
X-Proofpoint-GUID: _A0Ji7BAJspR4HUryrCjUrbr_avtFC0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 14, 2024 10:59 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org;
> richardcochran@gmail.com; horms@kernel.org; vinicius.gomes@intel.com;
> vadim.fedorenko@linux.dev; davem@davemloft.net; kuba@kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Hariprasad
> Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Naveen Mamindlapalli <naveenm@marvell.com>
> Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for
> Octeon PTM clock.
>=20
> On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> > The PCIe PTM(Precision time measurement) protocol provides precise
> > coordination of events across multiple components like PCIe host
> > clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> > support for ptp clock based PTM clock. We can use this PTP device to
> > sync the PTM time with CLOCK_REALTIME or other PTP PHC devices using
> > phc2sys.
>=20
> s/PTM(/PTM (/   # space before open paren is conventional as in file comm=
ent
> s/ptp/PTP/      # not sure if you intend "ptp" to be different from "PTP"=
?
>=20
> Perhaps expand "PTP"?  I guess it must be "Precision Time Protocol", whic=
h
> obviously would be well-known to all clock people since it's in "drivers/=
ptp/"
> :)
Ack, Will submit patch V3 with the suggestions/changes

>=20
> > Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> > Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> > Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>=20
> Strictly speaking, I think the sender's Signed-off-by should be last
> here:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_Docum
> entation_process_submitting-2Dpatches.rst-3Fid-3Dv6.6-
> 23n396&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dc3MsgrR-U-
> HFhmFd6R4MWRZG-8QeikJn5PkjqMTpBSg&m=3D-
> hUWeOgCxq0JK2uXUtjKrhTZxpTXRF4VzG5fgtC2LX1KB1FOV9PkK5E_fsjNvncM&
> s=3DO3K3uhTGzhVQbSkfb_MSDRhdqcoqyqjLbVASMs7ouEw&e=3D
>=20
Ack, Will submit patch V3 with the sign-off re-order change

> > ---
> > v2:
> >     - Addressed review comments given by Vadim Fedorenko, Vinicius, Sim=
on
> Horman
> > 	1. Driver build restricted to ARM64 and COMPILE_TEST+64BIT
> >         2. Fixed Sparse complaints by using readq/writeq like else wher=
e
> >         3. Modified error conditions, clode cleanup
> >         4. Forwarding to linux-pci maintainers as suggested by Jakub
> >
> >  drivers/ptp/Kconfig          |  11 ++
> >  drivers/ptp/Makefile         |   1 +
> >  drivers/ptp/ptp_octeon_ptm.c | 243
> > +++++++++++++++++++++++++++++++++++
> >  3 files changed, 255 insertions(+)
> >  create mode 100644 drivers/ptp/ptp_octeon_ptm.c
> >
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig index
> > 604541dcb320..3256b12842a6 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -224,4 +224,15 @@ config PTP_DFL_TOD
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called ptp_dfl_tod.
> >
> > +config PTP_CLOCK_OCTEON
> > +	tristate "OCTEON PTM PTP clock"
> > +	depends on PTP_1588_CLOCK
>=20
> I guess this can't even be compile-tested without PTP_1588_CLOCK?
> Some subsystems supply stubs to allow compile testing even when the
> subsystem is not enabled, but maybe ptp does not.

Yes

>=20
> > +	depends on (64BIT && COMPILE_TEST) || ARM64
>=20
> Why the 64BIT dependency?  Is it not even compile-testable without it?

readq/writeq calls in the driver did not compile for x86 32bit systems. Hen=
ce added 64BIT dependency.

>=20
> > +	default n
> > +	help
> > +	  This driver adds support for using Octeon PTM device clock as
> > +	  a PTP clock.
>=20
> Another possible place to expand PTM and/or PTP.

Ack, Will submit patch V3 with the suggestions/changes

>=20
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called ptp_octeon_ptm.
> >  endmenu
> > diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile index
> > 68bf02078053..19e2ab4c7f1b 100644
> > --- a/drivers/ptp/Makefile
> > +++ b/drivers/ptp/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+=3D
> ptp_mock.o
> >  obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+=3D ptp_vmw.o
> >  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+=3D ptp_ocp.o
> >  obj-$(CONFIG_PTP_DFL_TOD)		+=3D ptp_dfl_tod.o
> > +obj-$(CONFIG_PTP_CLOCK_OCTEON)		+=3D ptp_octeon_ptm.o
> > diff --git a/drivers/ptp/ptp_octeon_ptm.c
> > b/drivers/ptp/ptp_octeon_ptm.c new file mode 100644 index
> > 000000000000..6867c1d28f17
> > --- /dev/null
> > +++ b/drivers/ptp/ptp_octeon_ptm.c
> > @@ -0,0 +1,243 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell PTP PHC clock driver for PCIe PTM (Precision Time
> > +Measurement) EP
> > + *
> > + * Copyright (c) 2024 Marvell.
> > + *
>=20
> Spurious blank line.

Ack, Will submit patch V3 with the suggestions/changes
>=20
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pci.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/ptp_clock_kernel.h>
> > +
> > +#include "ptp_private.h"
> > +
> > +#define PEMX_PFX_CSX_PFCFGX(pem, pf, _offset)	({typeof(_offset)
> (offset) =3D (_offset); \
> > +						((0x8e0000008000 |
> (u64)(pem) << 36 \
> > +						| (pf) << 18 \
> > +						| (((offset) >> 16) & 1) << 16 \
> > +						| ((offset) >> 3) << 3) \
> > +						+ ((((offset) >> 2) & 1) << 2));
> })
> > +
> > +#define PEMX_CFG_WR(a)			(0x8E0000000018ull |
> (u64)(a) << 36)
> > +#define PEMX_CFG_RD(a)			(0x8E0000000020ull |
> (u64)(a) << 36)
> > +
> > +/* Octeon CSRs   */
> > +#define PEMX_CFG                        0x8e00000000d8ULL
> > +#define PEMX_PTM_CTL			0x8e0000000098ULL
> > +#define PEMX_PTM_CTL_CAP		BIT_ULL(10)
> > +#define PEMX_PTM_LCL_TIME		0x8e00000000a0ULL /* PTM
> time */
> > +#define PEMX_PTM_MAS_TIME		0x8e00000000a8ULL /* PTP
> time */
> > +
> > +struct oct_ptp_clock {
> > +	struct ptp_clock *ptp_clock;
> > +	struct ptp_clock_info caps;
> > +	bool cn10k_variant;
> > +};
> > +
> > +static struct oct_ptp_clock oct_ptp_clock; static void __iomem
> > +*ptm_ctl_addr; static void __iomem *ptm_lcl_addr;
> > +
> > +/* Config space registers   */
>=20
> Spurious spaces at end of comment.

Ack, Will submit patch V3 with the suggestions/changes

>=20
> > +#define PCIEEPX_PTM_REQ_STAT		(oct_ptp_clock.cn10k_variant
> ? 0x3a8 : 0x474)
> > +#define PCIEEPX_PTM_REQ_T1L		(oct_ptp_clock.cn10k_variant
> ? 0x3b4 : 0x480)
> > +#define PCIEEPX_PTM_REQ_T1M		(oct_ptp_clock.cn10k_variant
> ? 0x3b8 : 0x484)
> > +#define PCIEEPX_PTM_REQ_T4L		(oct_ptp_clock.cn10k_variant
> ? 0x3c4 : 0x490)
> > +#define PCIEEPX_PTM_REQ_T4M		(oct_ptp_clock.cn10k_variant
> ? 0x3c8 : 0x494)
> > +
> > +#define PCI_VENDOR_ID_CAVIUM			0x177d
> > +#define PCI_DEVID_OCTEONTX2_PTP			0xA00C
> > +#define PCI_SUBSYS_DEVID_95XX			0xB300
> > +#define PCI_SUBSYS_DEVID_95XXN			0xB400
> > +#define PCI_SUBSYS_DEVID_95XXMM			0xB500
> > +#define PCI_SUBSYS_DEVID_96XX			0xB200
> > +#define PCI_SUBSYS_DEVID_98XX			0xB100
> > +#define PCI_SUBSYS_DEVID_CN10K_A		0xB900
> > +#define PCI_SUBSYS_DEVID_CN10K_B		0xBD00
> > +#define PCI_SUBSYS_DEVID_CNF10K_A		0xBA00
> > +#define PCI_SUBSYS_DEVID_CNF10K_B		0xBC00
>=20
> Random mixture of upper-case and lower-case hex above.  Also random
> usage of "ull" vs "ULL".
>=20

Ack, Will submit patch V3 with the suggestions/changes

> > +static bool is_otx2_support_ptm(struct pci_dev *pdev) {
> > +	return (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_96XX ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_95XX ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_95XXN ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_98XX ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_95XXMM); }
> > +
> > +static bool is_cn10k_support_ptm(struct pci_dev *pdev) {
> > +	return (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A
> ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_B ||
> > +		pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_B); }
> > +
> > +static int ptp_oct_ptm_adjtime(struct ptp_clock_info *ptp, s64 delta)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int ptp_oct_ptm_settime(struct ptp_clock_info *ptp,
> > +			       const struct timespec64 *ts) {
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static u32 read_pcie_config32(int ep_pem, int cfg_addr) {
> > +	void __iomem *addr;
> > +	u64 val;
> > +
> > +	if (oct_ptp_clock.cn10k_variant) {
> > +		addr =3D ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0,
> cfg_addr), 8);
>=20
> These ioremap()s look like things that should be done at probe-time and
> retained for the life of the module since (I assume) this will be called =
many
> times.
>=20

Ack, Will explore the suggestion and submit patch V3 with the changes

> > +		if (!addr) {
> > +			pr_err("PTM_EP: Failed to ioremap Octeon CSR
> space\n");
> > +			return -1U;
> > +		}
> > +		val =3D readl(addr);
> > +		iounmap(addr);
> > +	} else {
> > +		addr =3D ioremap(PEMX_CFG_RD(ep_pem), 8);
> > +		if (!addr) {
> > +			pr_err("PTM_EP: Failed to ioremap Octeon CSR
> space\n");
> > +			return -1U;
> > +		}
> > +		val =3D ((1 << 15) | (cfg_addr & 0xfff));
> > +		writeq(val, addr);
> > +		val =3D readq(addr) >> 32;
> > +		iounmap(addr);
> > +	}
> > +	return (val & 0xffffffff);
> > +}
> > +
> > +static uint64_t octeon_csr_read(u64 csr_addr) {
> > +	void __iomem *addr;
> > +	u64 val;
> > +
> > +	addr =3D ioremap(csr_addr, 8);
> > +	if (!addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return -1UL;
> > +	}
> > +	val =3D readq(addr);
> > +	iounmap(addr);
> > +	return val;
> > +}
> > +
> > +static int ptp_oct_ptm_gettime(struct ptp_clock_info *ptp, struct
> > +timespec64 *ts) {
> > +	u64 ptp_time, val64;
> > +	u32 val32;
> > +
> > +	/* Check for valid PTM context */
> > +	val32 =3D read_pcie_config32(0, PCIEEPX_PTM_REQ_STAT);
> > +	if (!(val32 & 0x1)) {
> > +		pr_err("PTM_EP: ERROR: PTM context not valid: 0x%x\n",
> val32);
> > +
> > +		ts->tv_sec =3D 0;
> > +		ts->tv_nsec =3D 0;
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Trigger PTM/PTP capture */
> > +	val64 =3D readq(ptm_ctl_addr);
> > +	val64 |=3D PEMX_PTM_CTL_CAP;
> > +	writeq(val64, ptm_ctl_addr);
> > +	/* Read PTM/PTP clocks  */
> > +	ptp_time =3D readq(ptm_lcl_addr);
> > +
> > +	*ts =3D ns_to_timespec64(ptp_time);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ptp_oct_ptm_enable(struct ptp_clock_info *ptp,
> > +			      struct ptp_clock_request *rq, int on) {
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static const struct ptp_clock_info ptp_oct_caps =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.name		=3D "OCTEON PTM PHC",
> > +	.max_adj	=3D 0,
> > +	.n_ext_ts	=3D 0,
> > +	.n_pins		=3D 0,
> > +	.pps		=3D 0,
>=20
> Initialization to zero is unnecessary, but maybe it's the local drivers/p=
tp/ style.

Yes

>=20
> > +	.adjtime	=3D ptp_oct_ptm_adjtime,
> > +	.gettime64	=3D ptp_oct_ptm_gettime,
> > +	.settime64	=3D ptp_oct_ptm_settime,
> > +	.enable		=3D ptp_oct_ptm_enable,
> > +};
> > +
> > +static void __exit ptp_oct_ptm_exit(void) {
> > +	iounmap(ptm_ctl_addr);
> > +	iounmap(ptm_lcl_addr);
> > +	ptp_clock_unregister(oct_ptp_clock.ptp_clock);
> > +}
> > +
> > +static int __init ptp_oct_ptm_init(void) {
> > +	struct pci_dev *pdev =3D NULL;
> > +
> > +	pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
>=20
> pci_get_device() is a sub-optimal method for a driver to claim a device.
> pci_register_driver() is the preferred method.  If you can't use that, a
> comment here explaining why not would be helpful.
>=20

We just want to check the PTP device availability in the system as one of t=
he use case is to sync PTM time to PTP.

> > +	if (!pdev)
> > +		return 0;
> > +
> > +	if (octeon_csr_read(PEMX_CFG) & 0x1ULL) {
> > +		pr_err("PEM0 is configured as RC\n");
>=20
> pci_err() or dev_err() etc. when possible.  Maybe #define dev_fmt or pr_f=
mt
> as appropriate.
>=20

Ack, Will submit patch V3 with the suggestions/changes

> > +		return 0;
> > +	}
> > +
> > +	if (is_otx2_support_ptm(pdev)) {
> > +		oct_ptp_clock.cn10k_variant =3D 0;
> > +	} else if (is_cn10k_support_ptm(pdev)) {
> > +		oct_ptp_clock.cn10k_variant =3D 1;
> > +	} else {
> > +		/* PTM_EP: unsupported processor */
> > +		return 0;
> > +	}
> > +
> > +	ptm_ctl_addr =3D ioremap(PEMX_PTM_CTL, 8);
>=20
> Hard-coded register addresses?  That can't be right.  Shouldn't this be
> discoverable either as a PCI BAR or via DT or similar firmware interface?
>=20

Ack, will explore the DT implementation for register addresses access and s=
ubmit patch V3. Thanks for the review.

> > +	if (!ptm_ctl_addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return 0;
> > +	}
> > +
> > +	ptm_lcl_addr =3D ioremap(PEMX_PTM_LCL_TIME, 8);
> > +	if (!ptm_lcl_addr) {
> > +		pr_err("PTM_EP: Failed to ioremap CSR space\n");
> > +		return 0;
> > +	}
> > +
> > +	oct_ptp_clock.caps =3D ptp_oct_caps;
> > +
> > +	oct_ptp_clock.ptp_clock =3D ptp_clock_register(&oct_ptp_clock.caps,
> NULL);
> > +	if (IS_ERR(oct_ptp_clock.ptp_clock))
> > +		return PTR_ERR(oct_ptp_clock.ptp_clock);
> > +
> > +	pr_info("PTP device index for PTM clock:%d\n",
> oct_ptp_clock.ptp_clock->index);
> > +	pr_info("cn10k_variant %d\n", oct_ptp_clock.cn10k_variant);
>=20
> Combine into single line; otherwise there's no hint in the dmesg log of w=
hat
> "cn10k_variant" is connected to (though dev_fmt/pr_fmt would also help
> with this).

Ack, Will submit patch V3 with the suggestions/changes

>=20
> > +	return 0;
> > +}
> > +
> > +module_init(ptp_oct_ptm_init);
> > +module_exit(ptp_oct_ptm_exit);
> > +
> > +MODULE_AUTHOR("Marvell Inc.");
> > +MODULE_DESCRIPTION("PTP PHC clock using PTM");
> MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >

