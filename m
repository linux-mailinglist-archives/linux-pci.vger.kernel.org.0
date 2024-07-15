Return-Path: <linux-pci+bounces-10292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B75931A08
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE5C282414
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE561FCA;
	Mon, 15 Jul 2024 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="px7cCpNO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA973462;
	Mon, 15 Jul 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067181; cv=fail; b=vB1f15KyCCr/dvnE5iot0u4DCl/op3WeCrcvJE1QGRgqQjrumph6V83WEoUUetG9AJamJ4jPaZFw6Y8P+OcQfrY1WcXiSc+RlJUsFjG0RG7z/QeF9Ka2zk52i63FX2PMma0JvFW0CVSZpragYkUs2RKJKCHxqThjpX77FTCDqUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067181; c=relaxed/simple;
	bh=QOOYzVydlRpgah2EGs9TRScMRjw7qb4C4RQFGUgCk04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LQEiIh3KxNkA024MyU3DlfUVDCKMxPwEKXiHtZRw7N3hb+HmcZcHwZRTbXg3rCgCNerIhWfsHQrooc4FMXuky7N/cUCpyyWDk4d3wFUvBwqGTjs8W0u+r+wnfq8/nflkO+ISXE5F/CML9Zx983u9AttkSf8ea4wEomqiwhwqDrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=px7cCpNO; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCzDyaolEDIIfDa6ndE9umTPJcn8hmI5EHhg/z5WD8KuonhoslpkF8UgJWelwjrsEvP/wNDqkWxCZjr2fIW6VQN7FVMO6mQRQe/fL9cL1PAymisE2WJmcCzQXrNRpwAl94s8oXQVN1iEGvZF4T/iqq9oHS1gw9vLyOfK3EI+d/eYn8WhYo/apxh+10jXqkFBbB3T7lxoEFYZDtMmJSAAkVfrcScLLgofxr4QD3X3w4KJi7guDVcEe79CYtyiM/i13du86alCpej2WfdxK4bpy6g1LyqbAJ0UQEK6tyK/NzNw18fHEegeijPJNb+duOerJ8Y+ZmPcMi6/NDLun3+Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOgOdnggyiKkqQSfMBus6HJvvQyj2nUdCS6fDVZxugI=;
 b=b/3851JQ6sECLPQ3P5RIhFvV3Y2WhMjYo+snK3+9q0ZztgpVLM6rDSnAUILjSALnZx6wHazUH1FlNId2t+TUi5VhOkC1xPBFZiWuW92+iC52bCfn0zSA/Nc8dy9d110NADv7ZD76aXfrDICzgmM8bzp78uDB8T2sGJebRib3sfN0cQk4jJMO5RGqoYnKbm//DmAVb8ap9fV6LSEu+JxmE1jH5QiLaiMMzzOakB2LU4scOR5HW+/uGcnc+EWYhoS5hkNSadIZvaGEb6aoH3+56xdlW4Vxw6Yr6/fJaawSiWRmzonTuuQQvloPeumQkl1tp4d4vm0YdIZ6vPie7gTFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOgOdnggyiKkqQSfMBus6HJvvQyj2nUdCS6fDVZxugI=;
 b=px7cCpNO8RJ2ySLp9q/gL2O2eZdoRli+29bbkApFy9OZBKPgBVwgzH/xhIpX+lHwbU1hQwkg0X2qXJKHi/8WqgB4Sbzc00Zd/EGc4J6OqRoujT/eFo2ycO13rO6q2+Y346NR8HKbmKbKtrX16NZhivw/3kSf3l8vCA/x38qxiwjy0vIcSe1oK9y3sPxq6nnYywc7C74WYTFVVyvXa6CLg4uUBbEJReAFC/7hIsL94aJ2f+lH/jBEedLZDgNTyzf6qO33V7bY5wrxjbTLnwProaFgbm/2Qv21krvUDzQOjyrxwCtNpyw84bihtlUdn49sL1uMhyEBS/36N7Ywa5Y98g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 15 Jul
 2024 18:12:53 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 18:12:53 +0000
Date: Mon, 15 Jul 2024 15:12:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kees Cook <kees@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>,
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
	Damien Le Moal <dlemoal@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
	Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
Message-ID: <20240715181252.GU1482543@nvidia.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de>
 <202407151005.15C1D4C5E8@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407151005.15C1D4C5E8@keescook>
X-ClientProxiedBy: BL6PEPF00013E0B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ebe449-8b06-424d-cf94-08dca4f9beb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QHets1scaj/z5LaYYfbSvRiAf01HOY+w6idujo0bBhZnjchoPqm9pIF8Hrwn?=
 =?us-ascii?Q?Fsyy9mBVEsMeyMupVA2j9sj8bzMPgQDD1SSt9Y4ebeoIPYi096pCemRdn0g/?=
 =?us-ascii?Q?9cODkIdwCaqU1psPTjpLRobdNQtCs+QNlC2bngLO5PuZwTzX0AWZEwefFxz8?=
 =?us-ascii?Q?OxhqWGQ5wgqAg46ao93e5eZtU4OGiEcDR+lXLhbXaiWq/CnFm507e4gwUHLs?=
 =?us-ascii?Q?cApYB+45UgTqeuaeN2byyL9YtJPEoqwksZod/a2LnW2lPg5eze7Ro7fhqBEQ?=
 =?us-ascii?Q?ljUdBZmkYh1l9QFIza/FNUTgG9mHYhFoAkRDBb5F9qfSFpSl/u1N+ofpU1EA?=
 =?us-ascii?Q?o9C7bfq36iig6zOqjrhJ4AGKxikSTbgHaDT6mZD7HWf1cbap9PLqlx/5/5eJ?=
 =?us-ascii?Q?MZiyNnR+NEfgU532ECXbeLJNRhEXgmhuWV750lh/AgmFXXcDTLHwelfQpUif?=
 =?us-ascii?Q?/zF8AAyElDpla2K0g8SQX0Sm7G9Yt0Yc5+EshtAyQQr3Fx3dgXvtoumfQ4we?=
 =?us-ascii?Q?6CSrq+V0brcFJ3OlzztvuJ6ihitjjgt+zM2YkBeT7VYtXLkXulhrxPMXOrJw?=
 =?us-ascii?Q?pEHk1hhE6C8b+gXWs7MOxks2xy4BqKmOgt36/BJ3AxYPabB8zcVZn05KPcbu?=
 =?us-ascii?Q?zLrwDgtL03ZvH8wxIECoup45hODRBZu3xKQWDhH4oEccaTTLX7LNln/0q7VU?=
 =?us-ascii?Q?D2Ss8eyjW060KQimgj6Bz2AdQSEMaLIj1i2qoGNfQQ1O8TRP3IjA6iLDBwvo?=
 =?us-ascii?Q?YTHuPyRdi0KHtPhROy/tX1pAVj/p9Cwa92mKOzmHrdBR/Yn7706tYhea465O?=
 =?us-ascii?Q?I3EBWYcYM5ANd7hoyAKScA2ctDcRLCNjH0yIlQiNJN1sktAJX0Iz1LtRnQ4I?=
 =?us-ascii?Q?4U42SEAuseo7CPnNsgv0gnO3YX9SUwizagEtbeL49qrmYEqGEWo8idicutRD?=
 =?us-ascii?Q?oG7kdjLOUK7/T/TRrJUFRTugVyXKLGmvRln0o30xKtCFw+qiW4k05h0aXQli?=
 =?us-ascii?Q?EzD/k5K8WuZruxtCUrcnIxcVqkfUgvqIGwEUBv4T54vrIMRMiSltTvH6INdz?=
 =?us-ascii?Q?ARGKqhJE9sywfl6RcVB8CejnVouABWl4gVzGf82tjHbj8pWJevesWBGNbrDn?=
 =?us-ascii?Q?0fYE8wLA3V9j4sg4ObFMmMdFPCPloKdEL+IrfQ3RrWHclMTHbg7v0K5GeLW2?=
 =?us-ascii?Q?fHHTKGz0K4RZY4BY4wsJKTZlz2lnTJgoaaYpZPdcwc4QFeB6+Op0gB+2TEsB?=
 =?us-ascii?Q?DoBMX4/41yf0+b8BSWyT6gydgphyB+W1tIxhhSrDh4xwmgcmZnQNYYYnbVUO?=
 =?us-ascii?Q?xT+j2aNJfBDo00//rgzI5Lh2ZwFjQ+JuJA0WZIZq/qjXbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfIukPAg/TPB/BaVPR43RouO761oVkNjhj8aKJzXGt8gFsk2YhBfqMVZVgXi?=
 =?us-ascii?Q?7Wpoj9FJpFx74bfCO3/nwttmZuZm3bvxwP2lc6nOOEbJQgsBT6WCmaZC2bcQ?=
 =?us-ascii?Q?I2IlZqZUI3E85FvKEaqWua7ZyrLToLGIRvqE46UqcUUQTKzq+kyCt3HUFOVM?=
 =?us-ascii?Q?0vfx6F3OYNgKhOcFg1H4sIlZNod87t5WmBfu08j+/evFO7ZB0IEjYpQhPrg7?=
 =?us-ascii?Q?WDxTSOeHrF8FNc4OVM7UY9M+SFvGvsCvPJJJz+noNBnH3TXlUW9PeUJtSJhJ?=
 =?us-ascii?Q?/qfW2kUTRtLb3kaQ1plJpw6BUSLBs+RyABmps6vCoAa36oQ3CD2ZcmCrTlGq?=
 =?us-ascii?Q?nQXsyGEhNLM1vlTcaLufbkr1ejn2Kch9NQSvhRkq8xPJF4ejtRXgn3D3puKs?=
 =?us-ascii?Q?4IIrW6zYhY0daLpjvLR6e1HiwFARhjXhceJaURzG/m8MBcJ0OIc9Xp5gfDpb?=
 =?us-ascii?Q?TyVwavFIG5IwWI6GGSkuMm4KLsh2wjQmDAxLlNeKApLtKyz/NneH5OAJtSNk?=
 =?us-ascii?Q?LotVVENP0dEYtCQ6TXfmS9DoqUrwCWVuCDGIZV6iSbcpGVjFhAkfs5AQLcjf?=
 =?us-ascii?Q?ClA0WIc1HdjTTuSWsU/9Z27feL1s1uITBB0dDLyr/QGGmXQnYQxmVQEG209l?=
 =?us-ascii?Q?E8u0lf6K+9veKQJb+xxhFQZE4ITmPu9gUO1fAfiqyMP2GgRYDPYaFFPlPycg?=
 =?us-ascii?Q?9jBzwjH72pyJMaf7TuOdMQb+q5hO6Ze+YDiOcSoCvVZWIRktMWoY2KiCGuFj?=
 =?us-ascii?Q?EG5cyp2AXWwDRh1aNzONMcrCT/Lhy7Kumek2wQ/Nib6jHXkjlD0+LK38MzZE?=
 =?us-ascii?Q?kBsMnilMeqsvVVLqLVBEv2hjECd3NAZcWc6tHU+GkoYq7WIlEhvtk4tR9UXG?=
 =?us-ascii?Q?AwMz3qPgLosD+rLexKR8HJJYYxyXdICxitvxlHdOhR2iNQ/LocmFyORPM/Uy?=
 =?us-ascii?Q?9jYBd3xhl7nHNZd+kuxVr3x627SnpB3h7w+KlBRtccB41+mVE5c2Y67NSTgm?=
 =?us-ascii?Q?SS89ZTmuIJfSQpqpRIOxWstb42+Ao24/RaIGGvds7yCq/U8FalXzp42cfdXq?=
 =?us-ascii?Q?iTAQkgbWKusB0ULnvZCx75NZL3OzqV7JcDITPul5N5a6aY0tISzjcBWu1R77?=
 =?us-ascii?Q?YexVwV/fPbxrt9tQ0zMFY0C6ONMcDrKbmU8JEpdNxP8f1CEmfPZxRgvQd1ym?=
 =?us-ascii?Q?R6lRV6qbbSqXK8HmA2NV97k/GlyVsjPr9qJcN1QkaSipsY8wWxqcB5dsBPSr?=
 =?us-ascii?Q?6T5TmUeXcSnoNAzrWB1VXMX8Gp6IpFEJB18CuFgFaO7Lt6alRHMD4v9wenb6?=
 =?us-ascii?Q?ke6/gokAwaC4YWeNOfbZI2xKo9SiMM1ykdMNuI3ar6vU9K6/vb0Kqa71jVBU?=
 =?us-ascii?Q?U+g/yK4EDB52ex20nDGV9i1W2op5WCYTXCjnn89U07Y1oaHhtU1R5vqqI6YU?=
 =?us-ascii?Q?kJ7nyBOhSul6E8niGO0KvTj2catPDzZRkpkAzInXbErTlHs6s/PpMHLoatDg?=
 =?us-ascii?Q?2fKh9moap9n76wkRUtA5hNjmPF2/Mfb7korZ9BB2a5+kQXpYXSIQHmNX/xok?=
 =?us-ascii?Q?K97TVSkQOJFpcQDQLPQXVfIJirH978BdI7D79MnE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ebe449-8b06-424d-cf94-08dca4f9beb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 18:12:53.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egRcP6wcA6NLovMCYdWIYbDrWiuGsdgBM6yjp46YrD1KCw93STezWCwV2r1AEz7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

On Mon, Jul 15, 2024 at 10:21:48AM -0700, Kees Cook wrote:

> Anyway, following the threat model, it doesn't seem like half measures
> make any sense. If the threat model is "we cannot trust bus members" and
> authentication is being used to establish trust, then anything else must
> be explicitly excluded. If this can only be done via the described
> firewalling, then that really does seem to be the right choice.

There is supposed to be a state machine here, devices start up at VM
time 0 unable to DMA to secure guest memory under any conditions. This
property must be enforced by the trusted platform.

Further the trusted plaform is supposed to prevent "replacement"
attacks, so once the VM says it trusts a device it cannot be replaced
with something else.
 
When the guest decides it would like the device to reach secure memory
the trusted platform is part of making that happen.

From a kernel and lifecycle perspective we need a bunch of new options
for PCI devices that should be triggered after userspace has had a
look at the device.

 - A device is just forbidden from anything using it
 - A device used only with untrusted memory
 - A device is usable with trusted memory

IMHO this determination needs to be made before the device driver is
bound.

The kernel will self-accept a bunch of platform devices, but something
like the boot volume's device will need something to go look and
approve it.

Today the kernel self-approves untrusted devices, but this is perhaps
not a great idea in the long run.

It is definately not a good idea for trusted devices.

Jason

