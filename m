Return-Path: <linux-pci+bounces-37418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39DABB3D79
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B271C6442
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35A30F950;
	Thu,  2 Oct 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kb9tDQRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDA2D8360;
	Thu,  2 Oct 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406712; cv=fail; b=N7qQifCfalQTMo5J1FksF5gjLsnqcNtuSnf0XisqwLIcwWwR4a1DNbN0VczXd/9idn85xYFLCHMG6jq664I/BB+PvmHpCFRYvVyNXiFhRC9gC3UDVCXd2q7xqZz3QmNjxr/s67iN+EVgVr+/4K2fRT+WK0PN7rDl3EC8iWt9IMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406712; c=relaxed/simple;
	bh=NluRpzgJwnft2vTxTD1Vv5x+BTczPONHRmMNHxncZXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hb2TpIoRR5HVe8CdNxvt42C3r82F8vPWhUwMwHdbgQHYk3hJva7Whn2fYbrmYUSyGCxtbhUOii5dSGhh76KNiY1OOe9sfLfaf5nMC2/zBXNOnQo/JMjjCNyVCm1zbO00tvweXygqHHu9INo8xbFrrG6snpCFvjXNTZwSjTjePhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kb9tDQRm; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N47KtPligi6eDNT4K+Yv5D5Giygfexir522v4b8axDSnnasZtsNLVd1auHwOalfV3AyT2KRSTvjgnt2WVjRz6P+lRzWVhtFEvrfR9IUZHatpBBRuG04v5voqHwQ2dfHsjKL/2qM06hxqDZ66ZpsRAXwjkzHa7qV8xF9GLzhJSENgLEzH11qZ+zdF2OQNm1LamyDkv9jwgzKFoS19NZnmpCvZpAjSNFuveYhwm0aybLIHQnDtt8cS0XBHdQO1p6/hmaN3Rv2s/sy468ENRYROvQHe9LIORqmG10rffOZrKFYhK+ScWPVKcD2pm1Rbr4xdLAWYnKNIVF5mipftI+NMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ese+um9ZYDUw9cCl+sicf1M1LtKbs3R2kAD/VsQXzKA=;
 b=H1Co9MM/d0ggt5Tks22INpPEbCljN01n775nybhOYBjfUEsiSq6m3PwT8CoJ26aO1dZhfByXK4bE7G9lpiWdJh+ZPrme/3kEs3c+Z4399qaiJRcZK0Q9fg34K2GMPHAJdRZA44Twbsr7GLeCx1ZsmjddK5g1NApMIoplWrR7F3NzG+DeI1qBwI8QcDt8A+ems0yFfJKRehs4R2ObiQYkc0WVTQGIn/8SEvtt7vquE7in3bcEn3pNSCe9jZQoYcyRWOZxWn0Nuy7ChzzYOQ0pwVvGESRVO+/ha0W1qD3rV6bgrKFqFD8DJGa0PlfCeoaHBTw0UfjqphpDPpZN+fSP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ese+um9ZYDUw9cCl+sicf1M1LtKbs3R2kAD/VsQXzKA=;
 b=Kb9tDQRmlnqBx34dwu7bQ0JmwI9Ysn4sYvNu0wqApMJqyK801vbKWbcDnPEcnwmedFqnvNFb8dohW5HZeIhPofB0ufQ4BIfJq+KI7QxRLnw39ICndnLsSf/RMXDDHwZip/77/Jp4l9/V8ua2gKbOzEBTTqpJYfBbf6oAG8tUZUIMA7XyR/aMTqk83i6xjIQGWOcvmqcUfZjEn+gFkD80FYmE2cEh7iucgY1RFCL6sZ9965zAbArpbA44CpzoLnUHQ6BKfLjDUXLjk7nxLau7PYdTyDV7vhmcYg4+0+A6TOan4UaiDDVrGg7h0FFf3CiySZyChm4nKj0+wdR6NtAbqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 12:05:07 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 12:05:06 +0000
Date: Thu, 2 Oct 2025 09:05:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
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
Message-ID: <20251002120504.GD3195801@nvidia.com>
References: <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
 <1FA2746D-6F73-4D5A-A0DC-803D0563A5D7@nvidia.com>
 <a7bd8285-922e-446f-9b43-a67fff67a505@nvidia.com>
 <DD7E4902SAFP.3JLTVDIKKCRWS@kernel.org>
 <68BD4291-A757-475D-A1AC-582EF4ADE197@nvidia.com>
 <7fee5949-6ff3-4da9-926d-01c1ba89e2c6@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fee5949-6ff3-4da9-926d-01c1ba89e2c6@nvidia.com>
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a78cc16-0518-4020-87e5-08de01abed5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LCSmFt/NIi9jkq6Uh+ogcZSW6cSTQcuaZa7Q+t5kkycBVc+VF51NBUTPOqx?=
 =?us-ascii?Q?G1Fhb2EAWS4KS7vM0q5QU7cAiqnP9yZ557eFfqRDVx0bs9WfU8RfC9BfWqGf?=
 =?us-ascii?Q?lw+KYvoIufT4C9xWBi/hV/xf4VylEBavdpTPJKiuRif5UwAxg8psZ2qOcEQ6?=
 =?us-ascii?Q?M4em7QFHstYo9CRctxtuK0bsVWBlPmOhT6aKSXzGkymXXb9Ans8tgTfOLHEV?=
 =?us-ascii?Q?lOSCNCaR30luWoLKNWo0BQp+Yc0y9izN4gd2zVH1TLQ9NjYVw4Dz3eXp8B7X?=
 =?us-ascii?Q?Bi+b4JDTmDCGz4tKpn+cvJ28XQc8FZ/HJAXdF/zfzk+xvgOuhL7+VRwOIWCw?=
 =?us-ascii?Q?FR1mZVlkX2gYHwm++hgFDySZfogiszl334y3q9UVLrYbXWx1FItgnTUgwsN3?=
 =?us-ascii?Q?kabp6e4gCVU84L1VjmJaoI6ZqoIzBDnMt00oGTpZmchv3vxz00mNqMPzRkKT?=
 =?us-ascii?Q?MF1aNJRSwMuujGcsN7S9Y2wdrMF+50jv5DVMrleWGMrQjb+QNoXumnA8OLoR?=
 =?us-ascii?Q?mZfXMZQR5PO/iJ7OwmKmD00LgVPok1PR8ly/ZT4/g+s3CO+kyFh/wfBCSF5W?=
 =?us-ascii?Q?KwN2zgvn+dbnq8YiX2qFc2P1wcL2KDAfouMY2ajTBwhuNn3DkZh3nof9qg2K?=
 =?us-ascii?Q?2qfGbtOj7VT+6ZoaOgK5BYuSCUH4YMvEXhbHL2ylBS/ZhlzMRniRyynveBJ2?=
 =?us-ascii?Q?rEaiQW5CGpbpxNFuRThdvvHbCRxjC9+ZiRwQNn1dYa5Qf3qVfAmNqq3CRbaR?=
 =?us-ascii?Q?r8L1kCDMEgcFQCw9T5Ovo0gMsrX1TYagORD4YOngBogCBjYLMujY+IXQUt4G?=
 =?us-ascii?Q?LKXOZrlL6Y/wQS9dbv6Fa0nV5EaoD40g9vCkHeQ91B2KE/Rz72GminF2V8GQ?=
 =?us-ascii?Q?0sGnM2OcQQsuSFZNVQj+jiChivQ1R8aMDa88tBfIGLxABBixfaslMeqR+SDK?=
 =?us-ascii?Q?DFGVBIPx3nCpAd+hUwimsIiUgbOSLSDC4i7ogSXp7gp76gTwl4RLnxU06WnA?=
 =?us-ascii?Q?9saY19aslsqQ7Kd8kwGd+Q90wnCA4J7KUn9B5fAK8QlpofH0JBmZn1m7fixV?=
 =?us-ascii?Q?XfdtJz8oZGqeGHzvx9YZ8lwgv1ihyNEXALbda1wiCb0tZpJ+L+Gc3fh5s8V/?=
 =?us-ascii?Q?BM6cC+rRrrWkOtz5+l2CdAvhcZzdw1HIPLJSjniYin3aRDb7vrtE1R03ra8I?=
 =?us-ascii?Q?BhE0lyH2HO8fjidFDziS0eAywsu/5meImkUE/Hnax42suSROnEvLp1oDX3Uv?=
 =?us-ascii?Q?Q8dITUuRJBZtukZTT2wfMd0SqDeYaiLesjLyiu8l+iZydnmywVKzXIvKgYZf?=
 =?us-ascii?Q?l6x44TZu0IwXRM6vv8flCUQD00ythOgH4rwRcANL0ILml+mZQLYLR2DBI8bY?=
 =?us-ascii?Q?sQ0Saa8cTpoTOc504GkVUc3a46pJFdY600iycIHSv4r1uGBFAmagtrWmIc7P?=
 =?us-ascii?Q?3DwVGBkxhB1PHKEUT7IHiYLjeS7NiM+F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAEWmc5Uz0kjFHkWzdRoT2sgh95ibpSicecv7He5O9BJ52TJtH4enUJ+YpH0?=
 =?us-ascii?Q?mtDCOnDLFjBEOJbcZ/BJlVaYj0corCSbl1cW5icnKx7YQebRXGNLXN0A+ueY?=
 =?us-ascii?Q?VKUz/pP01AaXd9qj7+oX+uZualpPJDfPXYSH8JK8TqI6uD7B6Jgyl8TwXXI5?=
 =?us-ascii?Q?oHaeYU6qSv0mYJUpuYqIUujXTgT85QCaP0B4MPpuKc5itsf5qco7j1F0Ap6r?=
 =?us-ascii?Q?WNYaylSzP9mr+WpNp+HT15ql9H+oQ9D4DyhcmoYGQSAK6l2G8knznF8K6G9Z?=
 =?us-ascii?Q?IHV5GTt+oWX4gk9tE49kU6ebbVb+8+2YV9kWQdLjz89eKIWzMG5gpE0ceeXt?=
 =?us-ascii?Q?OPT6FLe6LmprvFkoi2UJ2ybJ2icrvki9bI2lZZworM2fFKDDxgrG701M8dkN?=
 =?us-ascii?Q?81DTGZvg4vITR4g05IPI/uj+tmZjY7Uv3xxdNkrU19jIz9sJKnQvGWc/QxVk?=
 =?us-ascii?Q?1l43ZkKZNvOQDAnyVXUHas7C1FCi67/NP3/QsWhFauaNCb6PhdR+/feJ80sG?=
 =?us-ascii?Q?Vt9a6CEHU5DB2PREdiLf7HqQGbQlFw4JOqmVk1tJ2PglBORZyGM5zhWvjefz?=
 =?us-ascii?Q?+T9wLwgMHYsvbu6JqVQVsXkAzDbJ5lEv5wp9R1Pl5gULSLQtlAJauH+iCYRN?=
 =?us-ascii?Q?LclCkIdKNRBIrPQxjeDh/CqKM7lSjYgkB2HOvYJ4Pi6sfVrKjpQwaX4e/tEx?=
 =?us-ascii?Q?2HeaqZ7XRFRV07s3Eztfgi6MpmFk0gIY3ACiorrSVjx/ZhiNWQ1gGswyNRdO?=
 =?us-ascii?Q?fGG0uGmknsLUwuTOPNiGAbUuH/DG43uc1sjeQdkmVBHE/IDfkb4rltl3+qwL?=
 =?us-ascii?Q?R+H0zL+oJub22hc0kJ0s0SdSBS/fVKplc4SmWkccXenR049KEqJZ9o7/3f4F?=
 =?us-ascii?Q?19bwSaXxM/WCfUpcfyDDXZW0ogeINDkRIRg1TNfCstqfuyvKMINP3ws168QY?=
 =?us-ascii?Q?nzpZMX1vfWdj7ikD9AUMsCVOY4tveH1Lcy+r3nifZGbtmWyAs+HSqTF8E59k?=
 =?us-ascii?Q?OcmDmd6mG/XXXK1HIu2SsE543NH5S1FrfNQJc7RTMfbK8G4yzMPNyFoT4GuX?=
 =?us-ascii?Q?94PfamMpf1Ed8mWOiTi1OkGNkI5+6BTWjhYbul4qhfBeWnd+GDntaoAp375Y?=
 =?us-ascii?Q?Fma7+N6/vdlRiGhhjN/BFwFH8g5W7qeWrs/0cJ+kKjmt3ieNbyrRS1LIDDvz?=
 =?us-ascii?Q?vNnI/cpGxMHwY21PQm1yeawapNNmOlFijDXRLPUCrvoCQU5bg8SK98X7YBi3?=
 =?us-ascii?Q?GerFZYjymesc/uIDQICB3I2ZdHEjXb7a4JkP2GnrFr0YsWKKqEZdWnaZ4Lcm?=
 =?us-ascii?Q?yAHkLC/YofyfyveQRXbzh+cfRjaroMn9u/0mk8IIpkTtQXi0phWXd5SsWI40?=
 =?us-ascii?Q?Yz0Vy/ctwo4OGdQaxmtoU20VRaH8tLOL0yRo7u/PmE382So8c237O575JzRx?=
 =?us-ascii?Q?oIcImwZImIR7lLVxh2uOFv754rjZt0kJVdxQ9RumljZIK7qsNuzhHngbXWV1?=
 =?us-ascii?Q?hmPVBtib9uC3YqCHizl9iWLPHeUlnj3wOQ0k3qNCojA7tLvosiu6HiGuNzHp?=
 =?us-ascii?Q?j0I6yZKBie0JuJIh8um5Wsc6fXP9BEZdsMPh5ojh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a78cc16-0518-4020-87e5-08de01abed5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:05:06.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2M0cHcntdiZbWx+qCOoOP07Rn1xsLxABLDv8+CurNYW7KIPEjmuYSfpfmmZ3AKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

On Wed, Oct 01, 2025 at 05:54:45PM -0700, John Hubbard wrote:

>  saying the reason for this is because the VFs share the same device
>  IDs when in reality we have 2 different drivers that handle the
>  different functions.

That's the fundamental problem here. Presenting the same device ID
when the device actually has a very different programming model is
against how PCI is supposed to operate.

For examplem mlx5 devices give unique IDs to their VFs - though they
don't have different programming models.

If novacore doesn't work on VFs at all, even in VMs, then use the
register based detection that was said earlier.

Jason

