Return-Path: <linux-pci+bounces-37416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C97BB3D5B
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279643C386C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E188E24C077;
	Thu,  2 Oct 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ku8ShqPl"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFF19F13F;
	Thu,  2 Oct 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406515; cv=fail; b=khlAmCxMjNSlBELS+jukR1GCa1iT2BcDd4lGD4aKyypjTS3iAiPzwmwJxv4qgi3AWigcJbF2aDUiOEhdvucxZNtkLUUDJRjQ7ad64DC+NY5a/VRVkjaOIe2v2Ni4lHt+wztf4YCdAuwW7kDaKTOZ4UikaPNKTrLrb7+3o27z9FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406515; c=relaxed/simple;
	bh=ws0DeS9YePbG5l3sp+MBP9i7IigCqWCtnoUm44jpHfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FrScsLeTewcVEatTXo4bAOmwyU1GeU2WXN11xZEVXkKEb3j6CiSvOZvzQ3BYrsYTpEobA3/i/nOnu5BQI2arjfq9Xi5bRXvJYB3QMb6mSJUHndm3NzAtl4Oirj539KB28WJ1COzYC75FRCLslcwMPB+EvkdythpYpmAem2LPpZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ku8ShqPl; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaAlmTAuRbVaMOUd/Vw8D4N8AvjZElK06P+GXzJzVDRKyqiduN6AFdy+z97uxZ0H1VDlrt0deWc6iTT3srLMqREgobMuoJ11KgkyvHQXECkfoIDSOHoWurBtUC2oPWrukV7jBStHrXBPiNyM1tsSLfPHWPM8nHgPQnvTU3oK1zLTh3O5LVZsXd/T8/UMj79gqaYOqTKmI3WqRG/NVQRUjBY9dmZK5L3Rn8LrrbLl5PAqJupebaCgGR4nCMJjrSUdFDEohbFTjwzzr+YACbOIj+1YC0s/j0Y4GMG5qP55/0uOCNoWZgWWV29sT8QjEOt2m6xUrNbd7VCf+X4vQLWO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws0DeS9YePbG5l3sp+MBP9i7IigCqWCtnoUm44jpHfE=;
 b=sdV4bnkOgtZjjSPQwplEmgfZKKEEtxdj+xozSKLvE2Pr+CJLXWTrnYV/Hf3KFSH/b2hnCs3DwsPG3zmLhv1kHNMjxPDl3ng/t02G9JPC+ZQFS4C6IAXyEX1LTiGklDfBWImE3MYDfwdO1fiBmqBXJaIKYU+DPoUH1/BbndngQF1/opWq93KSCJ9AQWxN0zydllffvpcTtrGD/cixi0L5JWYZkM4S6M/gRJYGW8KKcPQIzYOq1FWF5+RhSWe6TFtRuLkkiA24fk0jXfgYScvqaKMzyGkIO9zRn17S4oTZcKd4rY9WhI7u6ze7JA7dTieHDzUTr7dRCzASk9naaPO2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws0DeS9YePbG5l3sp+MBP9i7IigCqWCtnoUm44jpHfE=;
 b=ku8ShqPlGbTIqg3Ca51MKkoSgqsj89p80+6sWLxJ1qmd/CgEiWga5IalXokazrOrWXWTCt94CWLQ5EH+08k2pnM7XDE6t3UDfQb7bFqjU8Dx0YBJZ9gcCMvhMFNNKnBBbrBprY2gNOHdpJkbOCWBjkU+ukVU+/MeKNDYS0ndcxg2mjXUENlkC054/oMg2uWJRo9G13V9/obzG0judB3TNQyaSLY4hoxEH6lsj4Nf09niH+65GHbcgt7PAfb+d1ZphWChBiSzwrzv7r70tScyg3bQfziNwkcCBhmWWhb1E3keEEOBaXQa3X7xscADapCiAUSADiiQp9NcTbyx+mr4wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 12:01:51 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 12:01:51 +0000
Date: Thu, 2 Oct 2025 09:01:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251002120149.GC3195801@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb09939-684b-4c55-80ff-08de01ab78a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?77Ow9WQL5U20FThaqYakGS6dWVwbidm+zEkr1/P35BtG6wnpE+dihnSyV/6O?=
 =?us-ascii?Q?rlK3VxjhtB8SJ7GCZNeEv76sPgG2OWlUivZZwekHXe18g+dHE6mb44+2NVHv?=
 =?us-ascii?Q?BLWV8H2sGKEAzSBkIWDKQa1P24WOupUbvPzMVp2UqynfQ+4Ef4vxoLAVzZYM?=
 =?us-ascii?Q?pv0+tF4i/wza0gF/aQWE3YjGoOTVKwnRO6s29cZ12H0kfXsstecocFhr9ISM?=
 =?us-ascii?Q?RLYa3IjIg8AJ2rt9BfhaMEpe3owI4SD1FrShvuTttFbYjNU+h6nvu12aeSQM?=
 =?us-ascii?Q?xC2bgGooOiqdRo/XNGrn7nJnf7qOUqcfDNTn3NrYVKh5inIMYYTIKErKEwOe?=
 =?us-ascii?Q?mcQkqN9zycZAbJGxWD4IZKuKpeuWaATv+cNQWbb2qyLexhKqznytebmgmIPD?=
 =?us-ascii?Q?obXPInFrt0NEZc2YGNavQPf6f6mWfsc+saCmIlXEigyuA3aNfOj/lcoCmIpc?=
 =?us-ascii?Q?v1ZebHBklgoV8Al/So2Rbd4DJbV29rdfc0YrIDHqdQTWuIqtLJQ4xkuYxAYv?=
 =?us-ascii?Q?WkjjytLngwPt5fNJuDgWuWDBeMhedPAnyo8fBbkJYipImJ8+jroVeK9+G3gw?=
 =?us-ascii?Q?CjG/mvp6HdW5NMHlO15MNych9Y+Em+F41lFdxljV0oX1VxUKDji0O2muz9CC?=
 =?us-ascii?Q?B+6QKJ0k0ip1SQRetYtVnhOnoSfuMs2shbYGJJn9qs9HSGe4cRbazyvYe5ij?=
 =?us-ascii?Q?L0/whetERV8xXtjYpj/hLebSovm791MH5ygrRLjX81DBjJf8jtN6s5HIiaz5?=
 =?us-ascii?Q?ze5Ff/47FlSBcIOZcFuyXpcmgI88N0Baov6Iafnt45zjApNJ8ePdUtE/QaAB?=
 =?us-ascii?Q?8FFWEl4DrDwbmMRSu94MQ+Zu+im1+ES12zOoDUJqIds4K8qWr3qX2axCSpVe?=
 =?us-ascii?Q?L//n5/JqpATJhUjBYyxCb9hLJ43WxrnyFV8ZwlebDEa61WcZGdgPA0DFMvtx?=
 =?us-ascii?Q?ccFVVnpXpJ6h/ErUoRf8UMwY9kcNf9G5Ip/zALNkSHvsolqeuV2PoJr5ZyjD?=
 =?us-ascii?Q?qwg6YiDKoqusi1VOrEbIJv6gMLRSjk9Uo6oP0UNCMJ5AXRT/v1G7q6M/Sxlz?=
 =?us-ascii?Q?D0pHsB6I8381SzErNS7/nbdfAylYNvkOvHDj2/9L8nWS8i+daW7SOocL1QOx?=
 =?us-ascii?Q?yFKyNej7Fxh/glVCIZrCRqOjL+J2YROCcf/q8bJT3deqF5R1wo4rc4UWZuMZ?=
 =?us-ascii?Q?dEYf+4E0qzm227CevdembrqwdL0D1dffdFl/8LIRYgVJJV03cl8r5C2D6Lht?=
 =?us-ascii?Q?2ePac/t3gWQqx2ns5YXuNM8ZtVP9t5KvNdOy5Zap16mUgF1Sr3IZ+raE1jjy?=
 =?us-ascii?Q?TdS2cUVpLpwZ3AXboC47sBsEZhlhfkrWtO2I11+HOguIcL1v9wmNwcfDRe8Q?=
 =?us-ascii?Q?YjCSTqeEKP82uBy17ikYt9Ly2cKm2U5tujX5TgXE3h+D5FEcSPPvmuY2y2wm?=
 =?us-ascii?Q?PSCYYtMSJL93DwIZ05c/JhUTu2yCC/xw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BuBalowtEFfbA2fJW8r9uri50lPkY2Y+GR76SlA4GeTgKJXi67gVhOAZQtm?=
 =?us-ascii?Q?+lAUOzpLG50/13Djdo+UXlhTlQqVeRurUYV7AuPNFjzdz7IVV6rQWPNlmoq3?=
 =?us-ascii?Q?gUsTa0CzkhAbvhFGTB3I6VtLUKfSc3f9g8LBZf4iT3K1wmcjfRB/GrpuryRB?=
 =?us-ascii?Q?Br4LXAARPjglq0Z6fz/qgaDjpo5hvg4rdNhlEfG+z+cgrovUghccVnhgfxue?=
 =?us-ascii?Q?f5kjQoIj5rgtJj1HfCQhhqjfXvPxu/xK6DgfhfaVEIwUx3xI01zqoq496bCn?=
 =?us-ascii?Q?2XRwSEc0Oe2uiaajAR1tCU8yMOMfVU7uBF8r3UJ05gcSN7gGbWWPcqg3xwct?=
 =?us-ascii?Q?ch7IkBK1OFRTiq34j+kveaIyIourDmszDBZa22mWZVdATwHa1tKp5813LeNC?=
 =?us-ascii?Q?wpXBHYAKlGU+JufdBNB6RX/N9bs6UhCAFse2kAtNNSOR2vXNaj4sjyEZCOxX?=
 =?us-ascii?Q?LoKZEYHFkgNFXv59NwEvA0erHq3gk9JmC09aJAo9iOnc/4tOcvLKwojWBSTZ?=
 =?us-ascii?Q?MgA1ANILYgyPamCcFHSpBZQ9+LqqOEOjF+OwMc7vI+e4QupocF+QJ9eTVSxy?=
 =?us-ascii?Q?eozdLEKlrQsp0d6bBe2q0B9SiF3h668cQN9oitbKZ24g0aa+Pl1S4XmIn7+H?=
 =?us-ascii?Q?yW60ff3lcpjScTsWYkMtf6u+fs+hjr7S6Yw5J+HHE23xfg6+MliSqNNkPrQj?=
 =?us-ascii?Q?JXKQjYgi4Y+O/ftcPEOgLtgAhEZulUk7S3ti5RrKqdbv6XZd7lemf4+bN+Wq?=
 =?us-ascii?Q?oM2oovwFawhOdLVE9UVJMBcRpyFwPIciSwrmFCI16GMWs0T26OVXWC6A7RvF?=
 =?us-ascii?Q?a9cPaJihb+sSH+L8a9F40YLTBCfSEJDGxVxYz2jP267PScqKL1q+r7QyNaot?=
 =?us-ascii?Q?zdfh0pe0+Z5VWGPI4OFlyd08IcUzP6m58c+GAK2DP6IEEZvv5zopY5+PsvN+?=
 =?us-ascii?Q?Ln2S50VWSgQ6Z9zL84QpYNRN0jd9IqhN1hvp09YweCwfbnzIOpHWT8SsoOig?=
 =?us-ascii?Q?/qHxQnIbCd2ZvJnc5T1AfOmudgRkKH5Qv2vzp+E1lsp53jJLjaT8NGDUdm4K?=
 =?us-ascii?Q?yr7lGavwYVszSFaOUy45Zg3GYI8ndkQdB9qnF46i27gmnnYkwCSdBV1sDTtE?=
 =?us-ascii?Q?EVL2SpQ/RJmfiXJEJ4JNa2XkQbxbfjxPnQUas4XmidOFS+RH3b+3XwR/S9PT?=
 =?us-ascii?Q?hWZHpgvvZ9gb5NM0tl/jmCTjtrks2JQAPYh3cPvAgP7TZ3G//gK5SPbyWk0H?=
 =?us-ascii?Q?8OCG5Mi5INuKkjsEIMWeKdjeCOcms4qVR3RGpwk/IcX1736LT32cMxIUbT8X?=
 =?us-ascii?Q?XiKj94201TYyOSi9Gwm9y1aSz8Lo27lVsNFpPLIRmnCI3f9o6co/aF5nNFv3?=
 =?us-ascii?Q?xu1oBeXCgQbDho9YmFhU5ReW3cbBABH1acW5QytIdOcVYkoYN3qfBt3l9iLy?=
 =?us-ascii?Q?3gy7rGaIkNLOhO1gDXLb22wRCdopIdXIWIQJ7zVDrz90lx+8OEmMtLenLi5E?=
 =?us-ascii?Q?BEWUL39vYi5Vfx85qUvIJHs6L6LiaY4J00yu5BPTk5CmvMLwNblC9W60jgdp?=
 =?us-ascii?Q?T2CcFfAntjr4CJXP175OyH8NR/UNDuXYY0mjg3Um?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb09939-684b-4c55-80ff-08de01ab78a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:01:51.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN2YLeWZFyedFtCV/D/0aaXZi9JUTI6u1SH7uyABjehGm1jY3tp2+zg4Ud9QNhrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

On Thu, Oct 02, 2025 at 12:52:10AM +0200, Danilo Krummrich wrote:

> Indicating whether the driver supports VFs through a boolean in struct
> pci_driver is about the same effort (well, maybe slightly more), but solves the
> problem in a cleaner way since it avoids probe() being called in the first
> place. Other existing drivers benefit from that as well.

I'm strongly against that idea.

Drivers should not be doing things like this, giving them core code
helpers to do something they should not do is the wrong direction.

I think this patchset should be simply dropped. Novacore should try to
boot on a VF and fail if it isn't setup.

Jason

