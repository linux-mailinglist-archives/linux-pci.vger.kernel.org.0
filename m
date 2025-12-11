Return-Path: <linux-pci+bounces-42935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13230CB51D7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3268B3001631
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D72ED148;
	Thu, 11 Dec 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlKhj0CW"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C02ECD0F;
	Thu, 11 Dec 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442187; cv=fail; b=kDyr98O30SWhMKw0y5Z0FKrCnKTGm2AABA3JjgtQ58CPbrimBs41iLMvKCiql6CAKvElbEghOybQVXdQN/+gXojkUCosUIRaZYcx5SFfSMCXHospmbdvzuvBHZCrMHaMGiZ/DW+pi9o8EOK66BPJo8sgMgPDZy1jjLPC/9TIE7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442187; c=relaxed/simple;
	bh=K2K4HrFRt7+x4qsS52DcCwxzBmrajN9Y/+su706CPCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8bmqRdR6HzcWrJtfhI+8YyiC99Ow/ZKZYIlGJ8euF4UmOtunPXnirLDHa8vcmYMav1MDbFMnPG7HUgu141IjDLphgssRHkqwBZZGmUOcKbtzQW965A7A6zScaB1VPlyYWWWl3J856WjWi0tH6Z7MR1YhoTtKzJVD/06wLvTl00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlKhj0CW; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy2Uqjc2TS7iD/KOTg6F7e3/FtUlrIPJ4J92YKJ1GmDoiYqh0tIzX4Wk7Wspf2U2ZadamrmabUnYnbwRb2ExBak4gS5b4BmorpVNWF1rYhdlgH5aoOHuVxOaRBSG2bLXBU70uYrtBV4pCy/esxKAKBki8zO9biI3Ik494lRq+Kh1/JZqxIr81FqIEbz2inkrSgNrQCG/KBpa/NEgQlevImzvvyffpMbZTrPNl0gt1xc/Hc1JChYxVv4pgzZmCX5N2PHiJWkY4i6aqk0uqjxfh8l/8NeU63oC5xtkbnpPYnxKTDpGe4REVtnzfeA51sO1zN7JJJXv4WmfOXrnXy+2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YANu5ybYhFpriQKXcITk/v3sya667BZ9GMDtQivTsY=;
 b=p0Iu7e0B8PugLXDWCaIBWfoQ8u8OnsM63Fhl1JJd5GB9NRSsl0+zW97kctz8uxN6N7X7TmM18X9nMsj4hWadwOFXjPRVy8sTlZkAqpcqFWwJAwqhGYsw3kvyKQHn2RrJPfFx7xRX3vIMsjfVJGToLL4/HO86KpAgXee1EiUKtB1YUTK+IEWI7k4WG6+UW5nZ6ZELLMMa0JrIomkr1btGHjkIgul0z6O06arNxJ1HxDRe3yst8XfqSTP9yHvXf/fxS3PpuvipgDGXA+/qLo2eGVdiyaFOJLugV1sT2lPHHr3cw/pHmN5jKNcrjv/0R/oUHyHQczOKqRdxAh34bAy2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YANu5ybYhFpriQKXcITk/v3sya667BZ9GMDtQivTsY=;
 b=XlKhj0CWvmRafQ5/yd9VzJ8Fd209a4FIUoCsGmfhu3DyKT3Z9LgzW7Tsdwxl+Q8s/X0lARavgHq9qI/6Aduk/UvBUEQMR0rxdE2YrvXSL6bBZvQkEreCPT0Wn4eHPerSu3u5pMXoeRRDe3FOtqanKYzdMfp/AeKuGR05eVjIJbmD+eBt8BOF6jl+pHMAcLmcnzcEVnBkw3IyJMMwxwRzU8kiNR9HoeVEJa1JwLoWJfoT6xjVVSX4rvjFCwNMr9SFZdDY5ll/zr82SMlT3FJ1YGD/T/syWLTZLyL0NY/7iJD5hN/pIiFWZv8gCvCG7TEBalYIbpyKnTrzWq4jE9Qp9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.10; Thu, 11 Dec 2025 08:36:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 08:36:20 +0000
Date: Thu, 11 Dec 2025 03:36:18 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	airlied@gmail.com, dakr@kernel.org, aliceryhl@google.com,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
	cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, jhubbard@nvidia.com,
	zhiwang@kernel.org
Subject: Re: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
Message-ID: <20251211083618.GA2144309@joelbox2>
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-5-zhiw@nvidia.com>
 <9cf6135e-43c4-4c31-acf5-03fbe32e2bae@nvidia.com>
 <20251209154114.09cf245b@inno-ThinkPad-X280>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209154114.09cf245b@inno-ThinkPad-X280>
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb6429e-08f2-4da9-6431-08de38905bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?paFrz4hlbBEpNuwUj51GlErfJ7Q09wnCfBH5esVHx6KN4AQQtCJ85sONdfUc?=
 =?us-ascii?Q?P3haryvNFi5+/uk5saTYLMniaNDHXeVF72hRZP17pTc9WKibXaI6FfNCL6lw?=
 =?us-ascii?Q?/qe7DJbj4g05GHl5LvnZGUCzqz4K6pWbEAfBNaUZEh8CEcLX9csk1bvqvByG?=
 =?us-ascii?Q?H7JTMubRjQwMvKaqyT7HFUW5CVGfcfFcheMepVUJkN9pJ3tLgcdmWTlmf7X+?=
 =?us-ascii?Q?gzJ40oH7P0j8gi2Dw/OqVn1XS5aWDN4zPqgY4QWW+hZQEmILuzNFEDDpEMSm?=
 =?us-ascii?Q?nzn9Xiy1lRdh2O0kCqeaKaobjEoRO1H8elhQjdP3EqdwKQm7J1pLOUm9Tgt9?=
 =?us-ascii?Q?vKc00/j5d+bp93f8usNn0eM76TaGA/w3boyg/yfQ573vSxkB0TxQL/bdZEkV?=
 =?us-ascii?Q?gIhXJTAxHzFXLHYFD6CYgljss4XSg8H0pPnM148Si0ayyeNfz/oHtrYsCbxB?=
 =?us-ascii?Q?clL4waGt2/wf4LLZMwdENzyob8T7Umba/6NTTY94zXWaWHdK1gCw8jgGy06p?=
 =?us-ascii?Q?V1u3QpXfW5vrxaONfuWQRAC9FCoYYREx26/6uP5sUJOXfY5tJN/raVjybG43?=
 =?us-ascii?Q?VRginihh/0xiPaUng3Qf3IrdGgM+z/u+nIQ2Pz5JrdoEUKocCPnfcpdumqcZ?=
 =?us-ascii?Q?roLzs67aqJ7chHDj4SG1W1e1Aiut8kLicmEsUmgj7jKG7x3mIrtJdmz0oSv/?=
 =?us-ascii?Q?llBEJVFbjCtxnS7SIMo5y8x6pwIE3sBHlNfvKMk0um0tIw7e3OsCr9KclfDa?=
 =?us-ascii?Q?Q+pKTqA9l36gYfseEm86qR+VDmxMvzBVVfFftoW/p1EI2lcFV+ZTBgGG3e/Z?=
 =?us-ascii?Q?Dcp2ynCjEVQaCogV+/2ZqE63S5Nw8vPr3WfA3D34we8KT+GR0kVuhoVJnqqj?=
 =?us-ascii?Q?D+H9OZmNf7Mg3Su7Rmwo7DLhsa2oTZ9i/rIjMk/3mOrLYu3jFLJy/JHas0xO?=
 =?us-ascii?Q?MacXeY9ugVHMvVXZQrJHaKBh3lJbC6KOZCUlFmIUSe0xoz09fk5T6KtLUCL/?=
 =?us-ascii?Q?V4CVInRGMbbQjbQmC4H9xWIu3HlxllRuiFGrhE243oF8JRpRZnUHyWHlxyOC?=
 =?us-ascii?Q?yydzr182ALrhRYnfU3VFIGboop10whuL25cyRaAKNwGl+HD65trIM7iubLBn?=
 =?us-ascii?Q?Y4VMVpttUxOdL13q271lXhSN+Ah6ovHXUh6AmCjHqXo/AEBbldgBz8Snjw2h?=
 =?us-ascii?Q?6ivCdMQUlWZsJnUi34g1KPM1gKuj7I+cBownlraZ6fqovXOGG/Bqoigsu5pd?=
 =?us-ascii?Q?41VsQigEA2nPJUnSUdE+MgQRaNq6punWkI8PcM8tCVFXsQxvl3KmsIrKfu1U?=
 =?us-ascii?Q?VTKLySqVfjwl6w/TAiHWuaXJHNHJlnFNCZdOBH1gX3TQMu1lXgVz2ddOR25z?=
 =?us-ascii?Q?QdmnJmaoJGuGmO0EHeI+BjPbYQqpdBQPz7lcUSImWS+JKp37YB90ocf8SPtD?=
 =?us-ascii?Q?2+53wnBGLuuKAoExK/E8iqTmZ78ejp9I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtFIfuzLLMKHYtZoDisfFTwkxIvrM7Ou7B6Bajrwry84Wv935FFWXjQHrEU0?=
 =?us-ascii?Q?LqqbdtavwdB0nbSu+6/oLHT0yhV84esJg6GpnAbGiffG0m4JLggV/Wv3Syqm?=
 =?us-ascii?Q?p3aDvrAB486ybPxFlnjNM/tOcnDBzWe2HC8sV1LFv80msTiH6MzAl1T7HFro?=
 =?us-ascii?Q?wlt8i8yhZFVgAATpyLWW+09x0tl2lbg7tFDpiYTDuW/+YDz5/6E+HjDTusOr?=
 =?us-ascii?Q?Lq9s4liobyyYHifxTdPx8FaR87FfpCaXsKsiQABuXtveAJETJMtlniaHjX5E?=
 =?us-ascii?Q?A0ZIjglQ4LFY5R/7egGcG/BLDCsBvWOlb2231Xstybg6UdJYiqbmhCVCfZoS?=
 =?us-ascii?Q?QXEWmFhzaLuhYcClFWAuShWPYAFVUXZIRQ12KYk/UJKLidRk9xraHVcCEWBA?=
 =?us-ascii?Q?BtAy1Dw5rWXoG65OvLB9taVVmfyXB44oLdnZqVOwjBXYqYuxuZValgpzz6q1?=
 =?us-ascii?Q?AGG6lIGBzL7R/MZtmENTewPC896b0ajdFiW7uMjx2H9Eu1jyZt5VvTc0d2dZ?=
 =?us-ascii?Q?gixEGluV4ipqQ1mCI6HdMND3jOpq1mKu5XxXO2dS/Zqu6DA2pCM3QE8JhtTf?=
 =?us-ascii?Q?H+K88hQvpvtnKBymgTcPMQpFQYi6oIyHe4Y35F5ez/+NN776oaVAOLXzVOfb?=
 =?us-ascii?Q?cZNEaKaqnO4E9L0xPI5WirDUuwvG4TFAM/acMJrG9gcZUBm6mmus9IphqGIL?=
 =?us-ascii?Q?z2AzwvWm9JiF/x4aNh2FqyG9Vu1X1tOY+grxD2owl8z79snSkxZO3DYszFP0?=
 =?us-ascii?Q?v+ZR92Gwn3oa+VHAExkWdS0INPxfLFJJMiP2yYuM4FwX/5YMFpDxoZjrDbj1?=
 =?us-ascii?Q?Yh986fSGQ/vjlMwE2Ifg7derHQ9GFqU+YrgRAkewbRqL4TpWE2LQv48wjyHY?=
 =?us-ascii?Q?S0/6ItG/Shpkca7m/dtUvFXGfIMTGPW00cOmj09rT/PzUXG70Oo5g15t3gc9?=
 =?us-ascii?Q?/kGr7TlxIpJPoneEx2MDzaxHeKB7rWciXQKNHA06F1hrJtUmtkbxgo9UK7MQ?=
 =?us-ascii?Q?HgOSTRdYQjXGs4LChYktrpnyK5DOr2c2riwtBA8M1bdbtrMNyEdTRdJwYMQ0?=
 =?us-ascii?Q?4E0GxE1npL/Ekwnb8rhVOUOrCPNvjP96Vj6bOJE2FNwrQ/zV6AcwHOcSy3y1?=
 =?us-ascii?Q?V9NukAXrSDFSqpgSSvZeyZlrcgSzbjvX1TuclgzvmNewOb+EybVEmCemILSE?=
 =?us-ascii?Q?GQH4Ki5AXkzIw2fOtofMA6lR/h5/83XwJCMvSuAjwQXZZrNTpQJ4y0F7H6+/?=
 =?us-ascii?Q?ODjUqRbTEHmCIeCvHsgAZHJT32gfoy7bmldCjCw4RnEhGyZwJHkQk3mWhTIk?=
 =?us-ascii?Q?ciVdczAZqsM3ZEOwpFdXHgrVi3g8kD9XODJSsbnIuoDlADOPEEXPS85rATxf?=
 =?us-ascii?Q?9rC/qtYT8g1hXO0KfPyG8F+m7PhGaikyfekU9ZCLTKhtE9VvaFDmmKTCATvA?=
 =?us-ascii?Q?poC9YsWfog9Myr7nXqgygl5t8y07YKnVjF3/EeZCPDy9RMhWcKmvszRKerg4?=
 =?us-ascii?Q?4vS1gm8YFtE2dqFgjQzmGwIu60TDcj+QrYOMsbsAOhzXtZ3yYPHfu9PNTFDs?=
 =?us-ascii?Q?I5eP+mmEZmgjzhBdJWB/M/g56pYIhUUODca/Jt9M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb6429e-08f2-4da9-6431-08de38905bfb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:36:20.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 972WRqPOMCJfAZp5ea9UIeu6AhHB+KvrBwSbXqv1Z4vNtqGnl+Vxr34ToTzbbs8rbsE93qnGtaeRuKzoW8VBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

Hi Zhi,

On Tue, Dec 09, 2025 at 03:41:14PM +0200, Zhi Wang wrote:
> On Sat, 6 Dec 2025 21:32:51 -0500
> Joel Fernandes <joelagnelf@nvidia.com> wrote:
[..]
> > > 0x00000004); +
> > > +            let val = bar.read32(0x88000 + 0xbfc);
> > > +            info.b64bitBar2 = u8::from((val & 0x00000006) ==
> > > 0x00000004);
> > 
> > Please no magic numbers, please use proper named constants with
> > documentation comments explaining the values.
> > 
> > Also BAR reads here need proper register macro definitions/access.
> > 
> 
> That is true. :) But this is because there is no register definition in
> the OpenRM code/non OpenRM code as well. I have no idea about the name
> and bit definitions of this register.
> 
> Suppose I will have to find some clues from some folks then document
> them here when going to patches request for merged. :)


I think these magic numbers are PCIe config space related. I found a couple of references [1] [2] [3]

[1]
In Open GPU docs, I see 0x00088000 is NV_PCFG but this is on Turing, lets
confirm what it is on other architectures (if not common, should it go
through a HAL?).

https://github.com/NVIDIA/open-gpu-kernel-modules/blob/a5bfb10e75a4046c5d991c65f49b5d29151e68cf/src/common/inc/swref/published/turing/tu102/dev_nv_xve.h#L4

and 0xbf4 is SRIOV capability headers, per the same header file:
NV_XVE_SRIOV_CAP_HDR10

Also the bit definition is not documented in that public header, but I find
from internal sources that what you're trying to do with the "& 0x6" is
determine whether the VF BAR is capable of 64-bit addressing:

 Bits [2:1] is VF_BAR1_ADR_TYPE and = 2 means the BAR is capable of 64-bit
 addressing, and = 0 means 32-bit.

I wonder if the format of these capability headers are present in the PCI
specification? It is worth checking, I find some very similar mentions of the
value 2 being 64-bit in https://wiki.osdev.org/PCI as well.

[2]
In Nouveau I found the 0x88000
  drivers/gpu/drm/nouveau/nouveau_reg.h +684

With a bunch of ids and such which is typical of what is in config space:

#    define NV50_PBUS_PCI_ID                                0x00088000
#        define NV50_PBUS_PCI_ID_VENDOR_ID                  0x0000ffff
#        define NV50_PBUS_PCI_ID_VENDOR_ID__SHIFT                    0
#        define NV50_PBUS_PCI_ID_DEVICE_ID                  0xffff0000
#        define NV50_PBUS_PCI_ID_DEVICE_ID__SHIFT                   16

Perhaps this is something pdev.config_read_dword() should be giving?

[3] This one I am not sure off, but the link
https://envytools.readthedocs.io/en/latest/hw/bus/pci.html says that on NV40+
cards, all 0x1000 bytes of PCIE config space are mapped to MMIO register
space at addresses 0x88000-0x88fff. This matches exactly the magic number in
your patch.

Also, I wonder if we need to determine if the BARs can be 64-bit addressed, do
we have requirements for BAR sizes > 4GB for vGPU and if not, do we need to
determine the BAR size addressability?

Also, shouldn't the PCI core subsystem be automatically determining if the
BARs are 64-bit addressable? Not sure if that belongs in the driver. It would
be good to understand how this is supposed to work.

thanks,

 - Joel


