Return-Path: <linux-pci+bounces-10341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B4931DF5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 02:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332DBB214F7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDA380;
	Tue, 16 Jul 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyHZbMez"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C90182;
	Tue, 16 Jul 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721088709; cv=fail; b=UNhXoyAeEpPSTMsLv1MEvZIFFVGwhaI8qKUJmcRaKOcAgpexGaysxTM6B71gQoUxYho1X4N4LFhGCPRbQkQtu9CRs3Zqs1ZoV7Hqvkwwha46DNstw5qRMURzwyHD2k5m2rnrS+PeTiuEeaYkqh5MDzfP5tVKCDJ7EiCObUGp93E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721088709; c=relaxed/simple;
	bh=G1lOhMU6Uksd7wGQzLZ3qEAPC3bHQjBynhuPb0f78MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kNY/3b7nMiQ924f4rOpkwXuMfJmP/a+i1BP/3NzmYBOnu0/yhkDKdddNUjnLFhTegDwqqntENCd5hTUX2DB6vnXMX7LR3tlckLjnn9IdL2m95eXw4TS7NQya6+LAlIiELqGJ7jnDQTvuiSDS7W8aDRWbFtDKkGZxiKRt/lMoicU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MyHZbMez; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0xLZXmMxbq8UFyNoiNOS9+oqwBQh1oSnfRfi4tLLSwzA2bZDNti0NNJNpUI53i+18QuWzo11WS2NGqPbj6AYcFiqwGcI5+AsR8572qR5Rf44yAB+kULhA8TUNmkX+p+uwAGCV69XoKZUFMoUKbVjzzlQPcQr3GbmdyyNmX10QFdent27n4oswcarVn+F9zwypjsw12Ywhrf4iWo+OalFDOeWm2xgRtuiSaXWs3JtwrJbPclJveOOtxdnJWiAZwTHMKXLfEi4I5fKYd1J4O5JIZeNLUapqTjyXKDeuHja1o/Nyg4Xcxz9v6Ip0HEWjB9W2987PY6gxBMpH9umKAu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU9Cuiirfhd/GO8jEYecyxVicQ5/GPlJxDpjW2SVFbs=;
 b=cONZgQ71WW7K9AU/q5mUEWzeVS9xY6THe3VNSegTcEkIBkYyaaS4eecNH+mX24o5MRCmocZJhRQXFjToPeK5Wfj7tISH2Q1OcJeAM/fXX8uLcMRUzI+5WRfut9JusKxVgqByV+yLKyX6HYQI/cP8kG3Or3vehxMcTGbcHCfIO3AaQFO1WFRvPkN1/rP4GT6rQAhASOqgHX29ikOJdp+FEeY6h8LnJ8h0QcFUuEzprUJOE04CTy7kNrdEIBFaTqTGIssksatKb3Ot9RV0PIFv20VeZ97vovlwXP0UqpFAXhbhsDjG+KJzbTN0yz+YdOsZUcpJdXmbCc0M1r8skgOjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU9Cuiirfhd/GO8jEYecyxVicQ5/GPlJxDpjW2SVFbs=;
 b=MyHZbMezgxrgqv/NNrY6LE3Wq4Frr8ijcAux+l6dFVrsqx9EwoQHXkfyHb2PhsR9+66OVpNQtoQCQOgZ/oFZZZCzMUd0WdhmflG43Sy48ZqtgZ0E/uko2R4gxOBTYjNPQOGXqPuLxMnaNKFyEPswuxZA+Us7SJxDyOfaSRh+q7FCFrziE9tqydu5EMjJvj3qFvDTigHi8Xk6AcGwy3opbObun/H5hD5r+bfG4bsffPoDcvKXETpwcxeRUQNn3Mq6yjN3kBXe6HcoWlH2MSbVXsyjGUOsabBM1W/GuhI/kTT7bT+6f505qIiF5xUI4a8QBG9Bn45ViiaNDf04g6Dkbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 00:11:43 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 00:11:43 +0000
Date: Mon, 15 Jul 2024 21:11:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linuxarm@huawei.com,
	David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240716001142.GB1482543@nvidia.com>
References: <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
 <20240715230333.GX1482543@nvidia.com>
 <f228526a-984f-4754-8ade-3f998a8b436a@kernel.org>
 <20240715234259.GZ1482543@nvidia.com>
 <5f7fca8b-ab74-4fba-8df8-152ad6f94227@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7fca8b-ab74-4fba-8df8-152ad6f94227@kernel.org>
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 44eb1ab6-81ce-4aa1-fe2a-08dca52bdfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Boj8ry6f7qK8sq7BawJO7cm7lDtJjL4evUHSotyy+9MTSTCseF12NzTOSiH3?=
 =?us-ascii?Q?5gDAwutZS2Jo7B32buvakd1rUC+o+rfFbUQZSWMAp31inZjCAq5Llppgfm8A?=
 =?us-ascii?Q?SGlL+6pwG+mPKmUKuG6A005o0llCqy6A1ol+Bz/y5/9XCfAfSwSX67wVAVqn?=
 =?us-ascii?Q?MIpOKW7kT6QToDJwTnUuTTRmHxrBw4dzwQIVDUZPbw+a/+qBcYu6TqXJ9Dfs?=
 =?us-ascii?Q?9iZLHdqHyceNL2K/ROBV7xW32WXHCoYe8z4GffwvFkEqqjFVNtOpGJ+ghdub?=
 =?us-ascii?Q?Mpc8XAL0Lhh/EL823aVoFeG1+RIRD2j6cM3oy5m/qtRPCE1tCg5MzMxbyRAu?=
 =?us-ascii?Q?6VKUtCWJ1+P6ssPLeNXttQZ2fv6spLfT7sySoQqmOtgo19vYfNbo1mdO0AZ2?=
 =?us-ascii?Q?XpBqoegpLqyVHJKkL1fKWNFLfFQpa3mUy5a0uOkWssgCiQ8b0qEhvH6wGTjs?=
 =?us-ascii?Q?qu7XioB5WhW1KtZ1BKDJVNpR7lDDEd6+5FoQ6Tcp+vr/Ib9qqdPnfpesHy/y?=
 =?us-ascii?Q?ZYcCzZX/ZJ0IcWIalAFI7Tvz6MhhmNM5XKE5umjcazlpDe9FpZnTVi5s8g8l?=
 =?us-ascii?Q?Vp3X4J84BWe18RRJYiZ1O7WQ+3psEryzLX6IVqHZ7ku2pgN24MkkLJ11OPw4?=
 =?us-ascii?Q?oUASRbfMAV4rldhpwVc4YqvNP8KIRVC29eVuFD5rBKRw4YXlXjJrWnxZw3ZS?=
 =?us-ascii?Q?iKQ41ZWs5s4UXIsVk8GoB70s+kbcjcBI3CPR00R/SX0PQv2F96VHvF9ZU1Jm?=
 =?us-ascii?Q?HEdWNp3g7kQ/DSjqALNnkZjQvvrm6HFyfVBKS59xfXMsCnJZeNlR0tkK98Ag?=
 =?us-ascii?Q?FI7XGM/atfpKmfwIywAXjM/IwnH8GOPMdoCghjVqKgpZ41N+sYZOk0I/8GnO?=
 =?us-ascii?Q?uetdMyfNpICi4YXVwH79S3Ayk1T7YlHJdpxNI2EwTv26JHeRZAG/38YY/OTQ?=
 =?us-ascii?Q?5G2+lRJhgTKoP4zPZv9IGWOxZFCzvnmsH+7LTTCUoVD7+zqoLrjkgAGc1Aox?=
 =?us-ascii?Q?/9YLy+A7t0Nri1k1+OkBFnTMYoY2RFCWZw+ZHk5gWbKM0sXc+Yu3Xh2Rt2LC?=
 =?us-ascii?Q?bZv8KKx5pghSl+jMbJDo2h7BSFUB3u20XdIxHilUSpkTo0T0sUJa6CdpoIe4?=
 =?us-ascii?Q?zPIxlVwINb2s3fCU51MgjBeIFAC3ucpUzXVfeIVwM6nrSaXCoO3rsJbFbzwA?=
 =?us-ascii?Q?W3D4tbbxk0cBmjxLTfch78iOOtriPYSGOWqs+p/Ue/+7ltPYKjI/HwSCu+gr?=
 =?us-ascii?Q?oj9FBzPAoh/dKlx0ALpohr7nZm1dWWLRur8k9SMeHkziFE9/b7cMe06HHrJa?=
 =?us-ascii?Q?cpkLgsclZP4etyqMir8sjKlV23T0r4F816TkQ+ancG87gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L0XNqqOEt11w9NHw9XjEeR8pzY9Y0WGH6O3KVrMt8k1YDbOQcr5/dV+UhY9T?=
 =?us-ascii?Q?lPPz6390aHeDnz1FKBcYUVUCkvntK0xPJqwdq0y83GjgO9Z2Fbvc4RwvRM8L?=
 =?us-ascii?Q?aByp9aaEjPhzlEDBDE22251mgPWm59L4EeO3iTJ5qRLJ7m+52tuOF7XOxRp6?=
 =?us-ascii?Q?ySlV9HaOXFdk3LeOC/94q2HHLWruPb1SK7P1dwFWwiemvwHpJ+D/CqRovc0v?=
 =?us-ascii?Q?eUH+EUWt0cC7WFsdEYFWWM8/MSv3Bpi65Zh5bJt2qv7cUyqMCnXBxz/LyB7+?=
 =?us-ascii?Q?vA1ZTfpzuRGCSyA3y0ebEAFMaUOPTIf5n6U0ZNngPy1Fl5pHZgPq6qpQqg/U?=
 =?us-ascii?Q?NXC0a6izMWPh1Q87jLWi72nb2zyb1/UPB6QwlX+TJZwSKzN4Gca93yRwghPD?=
 =?us-ascii?Q?eixfvFcF6+rdpjqUk0eMI08i0pB5yxKysY8opzKTrQ4ZAzyc0srjMl5en/Cy?=
 =?us-ascii?Q?9fQytvZ0uCbZct4x5wgQsweqo63qD/bNG5DpAjFHdjte7j57bsiYP7jjKNu7?=
 =?us-ascii?Q?a8FiNiZeajqzZm6js1Dfxwt93EUrJdZ0P/is8lGYboLwkFl9OcQqTdSyRYlW?=
 =?us-ascii?Q?eX5xkp851Ug2IPIbl5sCWbFjAthBNduwIkvNRMunRmy8Ef8Df9FVpqPN4vjt?=
 =?us-ascii?Q?eCsQiTpOH3ype8j5zo5iXtKbOtxjgjeik44WnoDQRVFOnhI3oBeQLUZ7AM5o?=
 =?us-ascii?Q?f8w6DIXJEfpYsolW9SnNLzySx4o7qoGXLToE1Z6nNl/FIkkp7ewakDNgArxi?=
 =?us-ascii?Q?IpfRSOYBF45uTbQhcefq8hRY/3vio0pKzdAbWFC+1+T6kUXb2Lyx3fhpkhBc?=
 =?us-ascii?Q?2mdce/a6RdX4Uh3e4BkgpXY7Ke/GR5jfkGJwvguMAtQF9LvbHIeSEwKH6n9T?=
 =?us-ascii?Q?gQMyDakozhk+LIpDX4XMucC3tWFM3cteCzgx1la5bLg1t+yTl1BRu+xA3cdH?=
 =?us-ascii?Q?qUWS4Uh2jYP4jlveg7hTLK27ZuXvQyheW63a5rg36+TyjSBQqCKrpMRaSlSH?=
 =?us-ascii?Q?hknoKkWegD+v0IRgoaM82qhePEncxSELNt7rnAZt4S0KilGsmcpcGwFMBvYc?=
 =?us-ascii?Q?xEaZQcDnaiJRGU3KKZdXib1Fgqc4YPMx+CdqSvRSH5O/d7syLdgUeKP8gsOy?=
 =?us-ascii?Q?Rl3JAVtvTPj+iV7EWYNqciINvOnSFxCvndPmYvtGGReecRarBbJ8FT6bRDCp?=
 =?us-ascii?Q?9CXffhnnfJB78cTZhsWGnV70KLS6gspxbB4thSF0n85dzGxyAPOgV85iZ8y8?=
 =?us-ascii?Q?K8VxbAkAc5VjuGvXL6JDDkZRZ40qwjAm7/B3zOegc++ATllGu+ydDCPQm/Ct?=
 =?us-ascii?Q?/Hu7sDFSfaaEiaXOuqY/yXxB2Dl/8WdR50zMkeN6NTcVzi2eLy0e0TuMZJd1?=
 =?us-ascii?Q?xxi24gsCmGhWqMqtE/zAy/7aUPWvFjXOb4V3qPhOaMX7VtOwlZ/rU0Cj3zqv?=
 =?us-ascii?Q?Soo9lgh1Xk/7qyvXbQ4w5dxVkd1j3J1r3qr2k9+bPf3VOjGnTTiejzCym43H?=
 =?us-ascii?Q?OVoZ3PuvN1y0gOma8WXWFIRWUgXE310Mfyl4J0iLerUHLYaKRT9GHKmQozcB?=
 =?us-ascii?Q?ZvByb0vUKVx0EUQ4Lm/EoVyq7V0a9iQkOu5Vn7/i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eb1ab6-81ce-4aa1-fe2a-08dca52bdfa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 00:11:43.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amMUxWr1KSBvLXteU1fRanfzs+qhBqNeaQlmEs3VGA1b+41qO9cRL0g92RsaBKQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095

On Tue, Jul 16, 2024 at 08:57:14AM +0900, Damien Le Moal wrote:

> Initially, we can certainly treat them like that. But eventually, we
> may need something more as CC VMs access to storage has to be
> trusted too and so will require both HBA and the device to be
> trusted. For the TDISP handling, I am however not sure how that
> should looks like (is it the HBA or the storage device secrets that
> are used, both ?). As I said, I have not spent any time yet thinking
> about that use case.

My guess for CC VM's is you do both.

From a big picture a CC TVM is going to want encrypted storage,
otherwise it doesn't really make any sense.

If the TVM does the encryption with the CPU then we don't really need to
attest the storage or PCI at all, bounce the encrypted data into
untrusted memory and then CPU copy it while crypting it. This
minimizes the amount of stuff you have to trust.

If the TVM would like to have the storage device do the encryption
with something like OPAL then:
 - Attest and trust the PCI function, this lets you load the HBA driver
 - Attest and trust the "media"
 - Use the media attestation to load an encrypted copy of the media
   key from the secure keyserver into the drive

The split view of "media" and PCI function seems appropriate. The
keyserver should only release keys to media that has the correct
attested ID, while a controller may have many different media attached
to it.

Attesting the controller is probably not enough to release the keys?

Jason

