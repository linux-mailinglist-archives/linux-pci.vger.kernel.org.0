Return-Path: <linux-pci+bounces-20646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4062A251CD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 04:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CCF1883935
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 03:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D243172;
	Mon,  3 Feb 2025 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XbeNDgBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897974414;
	Mon,  3 Feb 2025 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738555100; cv=fail; b=nr0yGBOIK4AYgaTo/NwaP61WQouviq1IejktL91Umq93s2lvhgZekYYNWgjUHB8MFpUBG5XCyRyeIrtxf1Y2kby4YLwMGkXUBopngR/mierVGh59l65eIMsKMMP+jb2hPcwNvfVKYlUfq5pJ4tR67QyxIYWFgFAn/l0hz5HJClw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738555100; c=relaxed/simple;
	bh=oUdFwUoUnC6JswJrBx2rrSSWf+NMutRH/BPzwkXB2C4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T07dSDlhGiqABCcCsOEBi+g2+w/TT+SDIowIhpZ9GYF38bUOjePK+kO6z50cZ1071dY1gToENCFFpng9PBWhzxvAc3kAaRnGDfQLNHm/qB3rEjj7kGx9LWL817PMbR7AMiYapEmwoS9KqRxmTH6tbxii0SJY5nydWqtnlf3anYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XbeNDgBO; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5133HR96009256;
	Sun, 2 Feb 2025 19:57:48 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44jnrx01ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Feb 2025 19:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUUlPTjmqBL7DEUZwwtFeAajoD+5LWqLHZzXbOtJ8glWdfNikT91ZdmPu1dt6ca7TTaR3q4nXdOFls7edRs6f1+O2T0U54hqddlam1AJLpXOUogApoHoakR6dQ+dEYJHySV0J6k105hmjubm8I3PGk0jfUIaRAVHNgUCBN3zJxHyP7JMHEGxjNKl872wEiIRY5AbGW0EC3lY0cPSmO75xD312b4EiNEwNuvDR+jO5Fl9l9lF8hdAuLi9FEzhD8vX3X7A09U7tWYT0SmAc6Rnar0vdRY1voA+zlQIm5ID2wttPalHNWTxl1Xerw9rt/x1aT0olR92GL/RzuPQA6Es0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGOizS7GeXpYjj06Yeroe3nR/FtAN8NUhySVS8cwjnc=;
 b=Yys72R9XuEmkhb6yZQkf/MeSKJH4xocZsA1bHiffw38GuleSXixHWyh0qSzbE845NJNBygZ5TK+mw+5ogSHzWOS2HX+4DMF8VEJYNFPhxXRhhwKitbegt/sq/n+wvHUqKpS6PkGvocrNmqoJDtrBHbptfM+9Oj7GO8JkaleQXIgiGfAuljrVRxrocEv4rvFYXEz8bf8J8if2rUuhFiqzGC5SCcI52bQA90Y6XvR5S5ZILUuZAbeedksG8nTHG5PlpH2OVmfqu2HaFj9OqKM41RMR7GhTUJlW+UCaDWRFeVik0boomruSNOmMWGFsFSgUgNbiU0DqY3JHilOK1EiAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGOizS7GeXpYjj06Yeroe3nR/FtAN8NUhySVS8cwjnc=;
 b=XbeNDgBOkelZ5EX5d+cgUhG4zldKXTnvUA0w0rUPRcifQQpXVgyI1LBy/occqSA+de4bbt5eFLttoPWGD1jF+V5gauhd3biJxktibLG7aKhspSKDjX/beCoywiwdtgfHr/jGQxLTDp4sYatbOWoZgxaXNAtMYqRqGd7sMjYuYI4=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by MW5PR18MB5812.namprd18.prod.outlook.com (2603:10b6:303:1ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 03:57:42 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 03:57:42 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Russell King <linux@armlinux.org.uk>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Topic: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Index: AQHbde9Z/QZcGbF1f0+V088vXVv6abM08uzQ
Date: Mon, 3 Feb 2025 03:57:42 +0000
Message-ID:
 <BY3PR18MB4673E44EA35B265B25413A34A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112064813.751736-1-jpatel2@marvell.com>
 <ZzMokT-2pop1Y5hh@shell.armlinux.org.uk>
 <BY3PR18MB4673A39E3A7053093DD03047A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB4673A39E3A7053093DD03047A7F52@BY3PR18MB4673.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|MW5PR18MB5812:EE_
x-ms-office365-filtering-correlation-id: e16f5baf-939c-450b-6bb5-08dd4406e909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fmhQ/2thNP1oWcFH1Zo7s0jAcCRQzQY5Q/WM8subdR50l+K2tvqgqPpz8c4q?=
 =?us-ascii?Q?741tJf5JoXlOUWfFvv4PUqNqBHayZ39wpyRA6r4iIq7sjd3IzY5HU2RiQvBK?=
 =?us-ascii?Q?+5ka+YeAGIQPKaQlmpYVrAQyeYyu/5TKRZEOmLHWvJx7u0ilzBwwbNDFELYL?=
 =?us-ascii?Q?Oo7jANwKM3zB3fUv4v1IWheE6AJ8pLi2p0FtLZBb0kVNq20r69zvnwZRQFvk?=
 =?us-ascii?Q?oEoqytoWrB0KN4tdWZeVw3xGvFUPFTV1Zq02qvHUtsvlyHTjHehrQe9VZpdt?=
 =?us-ascii?Q?VAcniuSro+VTefMSJV8njJdfcGRCGfVQ/P0sB1jABr8769ySC1accicNeC/J?=
 =?us-ascii?Q?7TAvtj7L94PiMHBj6V9ci5jSx26Wotz5OaxbMy4UsLE6Zf5kss39NmBFJC/y?=
 =?us-ascii?Q?l/qpEeRevSxNWAJVHPBzpwQ13jPWCXT5jMnbYeWQ+Z9Q00nUEDSUagcbejZq?=
 =?us-ascii?Q?p2KXo3xyMscyPOhYk0H1ulcKn6ftDZn5ed8uVv5wfbVO8GEtZnD9TCDsvrCB?=
 =?us-ascii?Q?ObEqwsO6+OwZFKtSq5bWLLT/fruTWFpowlKIOM+ZQZgVRastzdhtPZsZS6QD?=
 =?us-ascii?Q?7Voa2xNy8iBVnWonuHWnLRkoCnmomvzM/MEfRwZ/rhxNUd2N0H0OV4l40rQM?=
 =?us-ascii?Q?AQdl8t7zI6zJ5AEqivfVJ+dLZlfx5g+U1e4ueDbZxjXxh14uCLI95D657cAz?=
 =?us-ascii?Q?Pqygodrjh4xF1fLwLZFquyuyYvAegrr2vQppZoPw/p0DiYFvMOaIgCzdKiWh?=
 =?us-ascii?Q?+KjfnqLH/9p8CUgni4AUcLt9jWPIV6S2BJ3XMWAOPIksb8TswxWNYONHN7WH?=
 =?us-ascii?Q?KFxQlUuFVqtP+zEGQSDfnGeRHur79f2hnhjjalrGBakWcFuhDMX8At36eMPH?=
 =?us-ascii?Q?kfJlT+z16p0H5a+BzVGD9wNCx5We/Bfvq2UuwEgqWkNTkjjY5ocS288cDfHP?=
 =?us-ascii?Q?j0ZtogAvuCygaeUb6Wss4RJ3QSbgRFpm1qKPglpqGeuaOuF3M4472rhm6E93?=
 =?us-ascii?Q?MaHexoOlAn2PdoW84wNPzp46Bplixxy6B0e1DjHP7uHMKIA9fkUYj+RlmH4M?=
 =?us-ascii?Q?K5uhaa3AVL/l27eCRw3qj450ZhWc7GMwhkVpH7o9gXz/FfmFxrdxwYHAvo48?=
 =?us-ascii?Q?422CYpCDx/TLnlpgPCM2ibyrFqjFE+9TcpH9tYPxZlK0VVf5sdsdZSCnGFne?=
 =?us-ascii?Q?J+xlhMb1TBhkaUqwJeeKY5SZlKLTKH2vZMZCXqEA1hoGlrsLYmwqGO1JzIyH?=
 =?us-ascii?Q?ee5U2Hy3puUi1dKAA5OAm2dHfm51uo9v+H+ecRLroIMk3AxC0c2uy29+3l++?=
 =?us-ascii?Q?Z5sk5JZEmQns7Qx+SnWCbWHO3tHZ0YxS18EYc9gUuO6+F7/gc4xgk6PYNpvK?=
 =?us-ascii?Q?9iu6N7vj86eVr5QsRAO5hxvVHaKP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hCwHbTRxtS4XingRiW6WaRkT6+v9xnZUMwTz3nmR1t1mJe8UdNk1Syo+k8lw?=
 =?us-ascii?Q?QQ+o/Ri7MHXFDh90QOSbqPtkVgBveVXCUDejeGN2UL3kyGjMmVF9YMwBZ/6k?=
 =?us-ascii?Q?rUZ6HrBthBLBKb19JAuXcU6yJCAu2XCutoe/QUMXctAKKc+4FcUuuXMCy0k2?=
 =?us-ascii?Q?77i9PYi6hh5ww9ulPP1bEYoc2fuAv5JlrLHOriYknejThHRLxGRamGAEroAH?=
 =?us-ascii?Q?Yem5Az8OoyNJ1t2I2p2NKNhjssazdv4n8WNCcj7zLpvj6whINLXRzG+7kWN3?=
 =?us-ascii?Q?aqdZSZxzH2IOwi0e5Jn/XhmRbjtp2B/3vBDp0gH77oq6gGIcxMAsxmhdB/5d?=
 =?us-ascii?Q?EMTuh6SR5X3k/Q37qczwxhSeRswRm0GUxTIkGdJoaWddudg0IsCrKiAkkCeQ?=
 =?us-ascii?Q?ctSg65CsOtDrU/5EXfHuqBG5IiHvJrVfhG9f4s4tp1cEr36oJop3+I04tg7m?=
 =?us-ascii?Q?XtJ9BzKkGRegg7SLkeef1pLGBw8wKhyC6Yb26Ba+a8P0gFll7JbYznOH1ixm?=
 =?us-ascii?Q?MsOjDBqW3AfxaWqIqez3Hj3AMHFi0XqZYSOcRexHtdh825L4tb1iYkPqWGIk?=
 =?us-ascii?Q?udTAQxIr0fi+WCK2lijuWDAyUngWRQPhh+EavI6vAGao9uEE/Whn5/FYItpQ?=
 =?us-ascii?Q?8LiL3WjvvOZac0dq7CTRqGAoV5R7gr4Zz6KKG4Rp7IMqiqKAp7aDHncqlVyt?=
 =?us-ascii?Q?b1OOObtdLanNC+m4XW/JTdb6Ok9uU5nRb/KYpzQCLWUN/Ys85b3a5FGLsZ+v?=
 =?us-ascii?Q?DrgzY2AQOQoZusZalU+g2TFFM4l5lBWVPaTtyws6Pwt8GAlyLnq+OHUQqslj?=
 =?us-ascii?Q?UqurHBfrbygT5E4QEKXKMXKI7TapuIdIfIu06Aq/K8ndRhoyNSrCd0LS3p+D?=
 =?us-ascii?Q?jUuv6zrkf4iO7zjrISU9zn+LYGjKd/2WHBxY0xxae/007QEi1SM/3LtwimSX?=
 =?us-ascii?Q?PX5dvk0bIiLN2QIlF4OdBjoxkN0eIZsTND+IU8zLv8Olr9nK7iR8xJ3WGhZb?=
 =?us-ascii?Q?zpSSjhhqfL5oUSlgUDOySkitclD3U8c3t/TVtoqPf2LfRUBHvHhyY+wRkHbA?=
 =?us-ascii?Q?j+Xv93rAEBzaTpoBN4SvCqRXUtdUUFrwmAucs+4gtPfV7BUEYDrxbwgTQw85?=
 =?us-ascii?Q?XGIz1FVqpjLdBvy/ywkL/7PdNJUZ2RGuAqJ6cR8WHh+mjPXV5D2qEXvCcaV8?=
 =?us-ascii?Q?NaFN3qwOI0yoIHZraErpcLe5ZQbNOh3Rq3LXGWeyZfE5pi2v/uMelL4MPd9A?=
 =?us-ascii?Q?BnMUw7NQD88/gZArWCRQilXFfDBawIQPCuc4iis6Gih9V+fPzzPdrOeyVXmR?=
 =?us-ascii?Q?lI6ZlRz7ete51YUMtXLm09nx6XYzr8uWffY91dj90nAG+vTiFDbDSt4IOoga?=
 =?us-ascii?Q?eem1oxnv4zzHq7tywKTP8OEQbUNyQUDEnmIO4evPvEt1p254FG9L1to+extv?=
 =?us-ascii?Q?yn6EgUeb8nfAqim2VFcpNOET2sucwOLUfRnDAWSIqvL1wePrqn6tEZOZYKfi?=
 =?us-ascii?Q?DCAZ7QvLKpDib356MTR+udk4fq4fca4Y99/N2dE560jfiPl5u0qN4IhHJTlg?=
 =?us-ascii?Q?xfp3D6TAv6g/AXcvBiUpsagp+vxYBUqCWwEHowa61z67bf/RAkg1SJdrrIiE?=
 =?us-ascii?Q?j982eAd3kveun3xX0ytFW/+pvkF29mzoF59ipKh9uhr3?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16f5baf-939c-450b-6bb5-08dd4406e909
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 03:57:42.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njsdIZMMmNIjE8O/QFM6pd9uO6T/9aVSPytASHHT/pe9BPRu5KTQ0FdmexLTrqaFe/1p45/8bbsXQM8kRZwiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5812
X-Proofpoint-GUID: E5BgVh2JsYPRmNgoiCT1kiMVtvAN60wa
X-Proofpoint-ORIG-GUID: E5BgVh2JsYPRmNgoiCT1kiMVtvAN60wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_01,2025-01-31_02,2024-11-22_01

> Overall, your recent patches look like they're part of a series - they ar=
e
> dependent on each other, but you haven't sent them as a series. They need=
 to
> be sent as a series so people know what order these patches should be app=
lied
> in, and that they're all related.
>=20

Thanks for your time and comments. I will resend these patches as a series =
with
the fixes.=20

> On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai Patel
> wrote:
> > In PCIE ISR routine caused by RST_LINK_DOWN we schedule work to handle
> > the link-down procedure.
> > Link-down procedure will:
> > 1. Remove PCIe bus
> > 2. Reset the MAC
> > 3. Reconfigure link back up
> > 4. Rescan PCIe bus
> >
> > Signed-off-by: Jenishkumar Maheshbhai Patel
> > <mailto:jpatel2@marvell.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-armada8k.c | 84
> > ++++++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c
> > b/drivers/pci/controller/dwc/pcie-armada8k.c
> > index 07775539b321..b1b48c2016f7 100644
> > --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> > +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/resource.h>
> >  #include <linux/of_pci.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> >
> >  #include "pcie-designware.h"
> >
> > @@ -32,6 +34,9 @@ struct armada8k_pcie {
> >  	struct clk *clk_reg;
> >  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
> >  	unsigned int phy_count;
> > +	struct regmap *sysctrl_base;
> > +	u32 mac_rest_bitmask;
> > +	struct work_struct recover_link_work;
> >  };
> >
> >  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> > @@ -72,6 +77,8 @@ struct armada8k_pcie {
> >  #define AX_USER_DOMAIN_MASK		0x3
> >  #define AX_USER_DOMAIN_SHIFT		4
> >
> > +#define UNIT_SOFT_RESET_CONFIG_REG	0x268
> > +
> >  #define to_armada8k_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  static void armada8k_pcie_disable_phys(struct armada8k_pcie *pcie) @@
> > -216,6 +223,65 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp
> *pp)
> >  	return 0;
> >  }
> >
> > +static void armada8k_pcie_recover_link(struct work_struct *ws) {
> > +	struct armada8k_pcie *pcie =3D container_of(ws, struct armada8k_pcie,
> recover_link_work);
> > +	struct dw_pcie_rp *pp =3D &pcie->pci->pp;
> > +	struct pci_bus *bus =3D pp->bridge->bus;
> > +	struct pci_dev *root_port;
> > +	int ret;
> > +
> > +	root_port =3D pci_get_slot(bus, 0);
> > +	if (!root_port) {
> > +		dev_err(pcie->pci->dev, "failed to get root port\n");
> > +		return;
> > +	}
> > +	pci_lock_rescan_remove();
> > +	pci_stop_and_remove_bus_device(root_port);
> > +	/*
> > +	 * Sleep needed to make sure all pcie transactions and access
> > +	 * are flushed before resetting the mac
> > +	 */
> > +	msleep(100);
> > +
> > +	/* Reset mac */
> > +	regmap_update_bits_base(pcie->sysctrl_base,
> UNIT_SOFT_RESET_CONFIG_REG,
> > +				pcie->mac_rest_bitmask, 0, NULL, false, true);
> > +	udelay(1);
> > +	regmap_update_bits_base(pcie->sysctrl_base,
> UNIT_SOFT_RESET_CONFIG_REG,
> > +				pcie->mac_rest_bitmask, pcie-
> >mac_rest_bitmask,
> > +				NULL, false, true);
> > +	udelay(1);
> > +
> > +	ret =3D dw_pcie_setup_rc(pp);
> > +	if (ret)
> > +		goto fail;
> > +
> > +	ret =3D armada8k_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(pcie->pci->dev, "failed to initialize host: %d\n", ret);
> > +		goto fail;
> > +	}
> > +
> > +	if (!dw_pcie_link_up(pcie->pci)) {
> > +		ret =3D dw_pcie_start_link(pcie->pci);
> > +		if (ret)
> > +			goto fail;
> > +	}
> > +
> > +	/* Wait until the link becomes active again */
> > +	if (dw_pcie_wait_for_link(pcie->pci))
> > +		dev_err(pcie->pci->dev, "Link not up after reconfiguration\n");
> > +
> > +	bus =3D NULL;
> > +	while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)
> > +		pci_rescan_bus(bus);
> > +
> > +fail:
> > +	pci_unlock_rescan_remove();
> > +	pci_dev_put(root_port);
> > +}
> > +
> >  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)  {
> >  	struct armada8k_pcie *pcie =3D arg;
> > @@ -253,6 +319,9 @@ static irqreturn_t armada8k_pcie_irq_handler(int
> irq, void *arg)
> >  		 * initiate a link retrain. If link retrains were
> >  		 * possible, that is.
> >  		 */
> > +		if (pcie->sysctrl_base && pcie->mac_rest_bitmask)
> > +			schedule_work(&pcie->recover_link_work);
> > +
> >  		dev_dbg(pci->dev, "%s: link went down\n", __func__);
> >  	}
> >
> > @@ -322,6 +391,8 @@ static int armada8k_pcie_probe(struct
> > platform_device *pdev)
> >
> >  	pcie->pci =3D pci;
> >
> > +	INIT_WORK(&pcie->recover_link_work, armada8k_pcie_recover_link);
> > +
> >  	pcie->clk =3D devm_clk_get(dev, NULL);
> >  	if (IS_ERR(pcie->clk))
> >  		return PTR_ERR(pcie->clk);
> > @@ -349,6 +420,19 @@ static int armada8k_pcie_probe(struct
> platform_device *pdev)
> >  		goto fail_clkreg;
> >  	}
> >
> > +	pcie->sysctrl_base =3D syscon_regmap_lookup_by_phandle(pdev-
> >dev.of_node,
> > +						       "marvell,system-
> controller");
> > +	if (IS_ERR(pcie->sysctrl_base)) {
> > +		dev_warn(dev, "failed to find marvell,system-controller\n");
> > +		pcie->sysctrl_base =3D 0x0;
> > +	}
> > +
> > +	ret =3D of_property_read_u32(pdev->dev.of_node, "marvell,mac-reset-
> bit-mask",
> > +				   &pcie->mac_rest_bitmask);
> > +	if (ret < 0) {
> > +		dev_warn(dev, "couldn't find mac reset bit mask: %d\n", ret);
> > +		pcie->mac_rest_bitmask =3D 0x0;
> > +	}
> >  	ret =3D armada8k_pcie_setup_phys(pcie);
> >  	if (ret)
> >  		goto fail_clkreg;
> > --
> > 2.25.1
> >
> >
> >
>=20
> --
> RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R
> 0mOyPaz7xtfQ&r=3DsXDQZu4GyqNVDlFUXakSGJl0Dh81ZIPlU26YS4KHGIA&m=3D
> 9VAHsMcDLVnsayEXDyN5CmlJpQPhncBHZIUVgNw-
> LAYA4ZffMKdKDAHrMSbXfbDf&s=3DqHNsIk-
> qZGjDWyWZH5VcWD3yg3uhMXB6DW6AGIqRQTg&e=3D
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

