Return-Path: <linux-pci+bounces-37350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49DBB0CCB
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35B414E2B88
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB02146BF;
	Wed,  1 Oct 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ubpg2uhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82B347B4;
	Wed,  1 Oct 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329998; cv=fail; b=FFs+1SDHlfB0I8YV4lB921lzU98bkApvCCo0aiM+Dn9oVZa7CAKGnWz9EV7Id28SwKVcUtrnCjC+ndKsb2Q/9lNPF0QyiuT2ACwb9eGZ1wjHr/QkN84tGPsIqBSqwYbqKlzhbTdcZ9J5QYfs/Td1+lhgM4p10IB/uj8PtPnthcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329998; c=relaxed/simple;
	bh=TWVO+y7NhVmoCMdWxHnUkUlEBFY+jghAIVHTTuxD7io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MwLwAGNU//lIX/eEhYhs0AGTN/bvfS4SFlCMiZI4T0k3Ciu51v9p7cvAfCB/xXCzpcroWxGe30RgV+J8CLvKk7j/tYuzZOxGgRirnSCW6/L9MAa8f97LZ+2OeE6tjSHVu8hkemL1iEWTDnGhNtAM2Q4tbLuPdoKCN8QPiAogtAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ubpg2uhl; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn6CNIppj4qC1Q7Pz6/GVZtkL8KRTbgmonIMdF4io165PYQeJf7JVGtvizpF4SRqJIVDG3a3t/ftQSNYGhweneT9Gmq9QYbj5db2LMYq/zEU2y9Eg48+ufdzNAl5MjA/44yBtuSXGmPwdZzVOL0c5MqG2M1g7cEb1LYWHjNM6nZywKcxcWovQ5UUBlLRRpZCiF8hmXN1ViNZvczMEskMgwT5uVnqpABlGbnXQYmar1yqwItwMs14HiPzkMp2gw7pOTamuw7m4AB/JwwqWUeBBw6dAQLJ7jYV3UgWLWj7HJCU/EM6tLsDrlmtBiPaCO+QMwBdliLvn1HqWwtCXGAQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3BOvs4XsFw/cZRobmLGcF+mDiMD3Y26wE4t4QAMNCk=;
 b=xREY5FmbKePuVNf7K0ZafIZkzsQQ4L1hnP7H17GF5ZyjfnNcGwGu4kp8Gkz8tkyBuLK0EH8qAiE4P1GHIogAWfkTpDqL6l8NEYwXNX7KK6VFGNuA5oNGtknWwL7ggMC7yp4jTgNID3KXSUXev7KLMrZqzyMQM6s5mlEuzyVPp0fkUnuZLM4S2/0ccKdAVEsLp0J3SqlhvZ73NjUOPGjp/3t8+BOV6u2r87qPiqSsy3TQ95mryQaggTS3GCRvLzzYa59EbruJKvJznM0z+rAzR47z5G019IAqv6JlM9sBqAXKAygvERK8nuvYNV1YgYB1mdCKkp5yxtuonPw1RDSn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3BOvs4XsFw/cZRobmLGcF+mDiMD3Y26wE4t4QAMNCk=;
 b=Ubpg2uhlwKDXZ5BLQfUYbLc5aMROCu2k4dyiXgAEFoSBLs9abCL97zG+jnUzozmRbrq9ZEIqJ3ZzsDshBhLDYWrnnGyowjUhEsfmFlXGIt1hbOXZk7pZ95dFAEXhJIZoLZsqTxq40/AKEf+/rW/bgdtyI633K5fAcTKDm8Coo13OtDcEVh7oLdKvAwILHsp198wl7wJmpL56jvyTIndIAXIyDWX5JgWAivyNPCrg0dvJzrNFcttzJJ1gplJTx1mpB62YgxmIbnHfoJaH4ESFMln6WuwMVg3076ns24Rt09aXVA71H0yc9PsS/8JgeFlCWntVaCuUg5qNFMpRC94bsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 14:46:32 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 14:46:31 +0000
Date: Wed, 1 Oct 2025 11:46:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
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
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251001144629.GA3024065@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c112e2c-680d-4225-e769-08de00f94f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JjSkXKgsdtkHxb9g0pJsm5jVfXiDFwu27nsIrpBnNleIP0PSQ5AWaGis7o4?=
 =?us-ascii?Q?GQzQal/sOT7P7qhPxKGAe3S8ieSY/1BIgc4csbuvAJuvN3HlKOSdvgluiaKg?=
 =?us-ascii?Q?LyimETzVSGUzKSHQ8nIyqcYjDd2d1abmVnNRG3m89o4tRsyMjZZ16GwfXCSM?=
 =?us-ascii?Q?QBeiD5bxYJ0yibY//bIXJlu3512rZeqe72ZGToPp4lRlQDqlvg+gRSKuRuPy?=
 =?us-ascii?Q?kD6z/gWY5UReLy2JcQouT3LCXbyYynUIYuAOoGx5reP3naamgkNm/lTmABOy?=
 =?us-ascii?Q?/OBKLDC6IQ32KACFd2WJfwSX+TVBleJnCeZMMzwLE5yU3/QnNvpzjeCZWIr9?=
 =?us-ascii?Q?/TYfvm0r5I6aF0WctH0PSInZkTXnCZRsfofzYPPI5xPzbAOREHJZA4C7CWrz?=
 =?us-ascii?Q?v+D/BE8cuioxXhhTY0G4sdlfgjAAOMuA5Vt1muZZ4JYG4mmeOYXpBKKOH0AU?=
 =?us-ascii?Q?oKCEde7aIsNG+DOekFfeAXfqWn1IbNZP1FiX9k97dDwk5Xy4RkE1czRMatzq?=
 =?us-ascii?Q?74TRj/QqRHl55A2LLy0qY+WQrAJKIBjP4BEHfsOWYGiigJwZ97xoYQDlNEIo?=
 =?us-ascii?Q?xZLlnLbCbYWxCE/1nnQV2sJTvJoenXmyMl1YEw58p40iP6vMp+rr4d4GKzsp?=
 =?us-ascii?Q?ZMLlmgFpo+gx2Chvhh0BqXv+wQjrpzTQ16kMG/h7YsCUGXJowwpuiL3X7oFs?=
 =?us-ascii?Q?dAspI4JwzVUM4AdYc8ESp957FIF+Ov3NhOksXfEsFGLFtpHtwqGm2bobVnoA?=
 =?us-ascii?Q?FtpsfHuORK0FEX1DMF5qCDb+SJHQHHR2oom0wGkrqU5rLfRH/NzakPU/2t9C?=
 =?us-ascii?Q?VsI3mV4kOYp7YOT/siaK3zDBlW8/FasCUbRpyR3bmYuoqx8gBXjV38clw1M8?=
 =?us-ascii?Q?BGTmMXs/YsEbyVXewzXhnE7KcDJISGm+Klfg/oggY+hGnj6xkRwG0Bwyow0+?=
 =?us-ascii?Q?+r1GoHecn6nSvSjZhBq/1prqEEPQtv2YCk0QOGKz7ZKuIzjdFqf7OmMCWojL?=
 =?us-ascii?Q?KUGO+6b1F+j1UwJRz+op7/Tg3BfOyxaJ5vZRq/qreuEJmODP9L4dQ14lwvzp?=
 =?us-ascii?Q?cTrIYzLQGgSk4/qOmI7+zQtYjNheXe1yotHWEVJHvCTGVe+JsD4l23OsrjvJ?=
 =?us-ascii?Q?vpFS9+er2at+92rPKVU9utupwRtJWpaEZG+KmsbR1FNRmbgWtmSC1+JwXVRA?=
 =?us-ascii?Q?WndZ1Dh7fFPe9FzFUjFt7nQFZMm0Pc7U9QYd2SG2AwVbgG/wm2br7YsaO7h1?=
 =?us-ascii?Q?K4zMoiVBwxX9VyuapF7hx508PVwUVQAObpH9Xo2RIRetr2P9NvdD4AH/J41H?=
 =?us-ascii?Q?0U7hjSBOPEC380em5Q+fCuhJM4rkT33cM4T9v/LVuLsXpVYIcHtLq/0BvBjy?=
 =?us-ascii?Q?KqLBOi6IYIFeYqPoT//qCoH9Pyo5Jbnjdp/wbqxAosFB1x83eB9zD2n8R/q+?=
 =?us-ascii?Q?tL5quAPHudIQr02RHIj6/CU9030DOh16?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TP95/Qg5XYOHRIP7RcPDQ17Fy0rojIxDsG9mPiubwzUvTyW6+pwyG99kTNGh?=
 =?us-ascii?Q?uyJN4E1as8VmdW+PubZQK48cWRO9T7qKYcU0phpm2gR34DNLOGoUAr0sy7YR?=
 =?us-ascii?Q?RYmYKWc8NnOPrpefNQCdV6W187+k2w9S1+7emnumBJXp49PTgz0xEPCGxYMu?=
 =?us-ascii?Q?QMsY3qyVKkDA3HxELIONNiCqLSWUMONQKuLTtfJJr8LlUkpRi8CB6e+54mSm?=
 =?us-ascii?Q?1Y2ta4hWu76y+ZJ49Ofp0c7AKn6xyf5pjdz2vwp9zFnIjM1kq+5A5SYCE4ui?=
 =?us-ascii?Q?/Ffbawyd/ET2svdWcb0TsWjzR1j+uthOtgewWnOVFe1kGhZjzfWwXxC+U2bq?=
 =?us-ascii?Q?R+hcS4slpynmspA5sqHhaOhkk2j4/eDhp6BRBt/3eRbsjAv+oPwDLeSJ/uTM?=
 =?us-ascii?Q?xf24BiiBgr55ch/nvy05ddUQNEs5fNHQw1q7b9AkEWKP/6nn8J9wt8m2rPgz?=
 =?us-ascii?Q?D7Dz5S49DeSxQX/px1uJycbCpfXyuI54IoLd6jZ7Lx6GHC9BBEi+SyG1D/5n?=
 =?us-ascii?Q?C+rpevb/AJu8qCxisuhigdTe0YgerC6GhJdGBvpoHBdAsqdIYS+8hEUsv2U3?=
 =?us-ascii?Q?aNJOrBAUFvp84CXRG8Erx6R/+aN4bm4Wm0WA+FbfJpwsaYKfGQoPtJf7nULd?=
 =?us-ascii?Q?kFJDUoxeW3RbevOoi3Z1lRid8RA5BaL+WWyjYDi6N5eMAq2pHNISgm4Rfq1V?=
 =?us-ascii?Q?AMfceJzOw22xtg5bfWlg+0pJfwLWerQ2vAze542sM0RNS2OWa6VVMXYhCzpL?=
 =?us-ascii?Q?rxMnqwTQ+SIj81lwtF5i/FKDTPbULeuZ2pWASqYslI4MTtrvGewVVbqWOagS?=
 =?us-ascii?Q?rEAZ/poPBFI+e2nwaYmvAsE+O+3Zd/fNxA6JDA0JlGxYhEX3AlxXoRBBOQqW?=
 =?us-ascii?Q?NXAPiAtyB7lfPwNFizCzEz9v+Qomr8ECFjVgP6OKudgmrBY+uiG1PgHWTPln?=
 =?us-ascii?Q?qkLWbl37eIBYVsimlo1N5XwuErjc9tbdv2OHV6JHZ19L6uSeLa9Erx/0KZcT?=
 =?us-ascii?Q?C98Oa7GP4YFTBlC/ixGFSsmOCzT0HYtw2NPUvyKjD5pUnqvL9Ousr0aTjKhS?=
 =?us-ascii?Q?QpROwhjSVRkgGRl1tfV+JD09cPcopr5t/6VEpzYvPQRMsKaLZpgH+6mM4NHz?=
 =?us-ascii?Q?+YNqAM7DOyA9MQ950rP2MFwO/NOUAKrJRrd+xPx+N/6ksuJlTpj+nAqO6xqu?=
 =?us-ascii?Q?z667S14YJr3HmQkEYkrm5scmsWTXsq5C+dBWYSXAB/d/8xEWyEGFj7PAAZ0c?=
 =?us-ascii?Q?15z32bHWdJxb2S9HcDuMqj6LDHHGz2jGaA4kdFNthg+1xJIkN3Al2e4v9BBH?=
 =?us-ascii?Q?B+OLS+OcW9rgggrPsV5q27wBhJmdBT9bJB7gEMApBhdStECdddnlMtUjptN/?=
 =?us-ascii?Q?lT2mL/PWGbrQz6h8bESorcez74NGPFfvsUEsrMTjxedRatvku0Ssf+PA79xO?=
 =?us-ascii?Q?ct2TuQo/jHApAb9Htp8nrpapks7IN27MdAXmQdMrrc5BoSeZkbSSHQfQ6uwB?=
 =?us-ascii?Q?8+NBcgNb9sndGVq2MO71aHOktFytcRwkVc2Cy85V33w18cUJ+Ok31vVioyG4?=
 =?us-ascii?Q?9wnCnOOknxCuzZ6Pchh5DocYJ4Hng68eOJVRVOyO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c112e2c-680d-4225-e769-08de00f94f7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:46:31.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HU+r8kvEUp8VY3UAa6bUzNjZL2wOUH6tSCe5TAIleSeJeyRZf5PVEGLuJ/if2LBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587

On Tue, Sep 30, 2025 at 06:26:23PM -0700, John Hubbard wrote:
> On 9/30/25 5:26 PM, Alexandre Courbot wrote:
> > On Wed Oct 1, 2025 at 7:07 AM JST, John Hubbard wrote:
> >> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
> >> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
> >> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
> >> let NovaCore bind to the VFs, and then have NovaCore call into the upper
> >> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
> >> longer in favor.) So, in order to support that:
> >>
> >> Nova-core must only bind to Physical Functions (PFs) and regular PCI
> >> devices, not to Virtual Functions (VFs) created through SR-IOV.
> > 
> > Naive question: will guests also see the passed-through VF as a VF? If
> > so, wouldn't this change also prevents guests from using Nova?
> 
> I'm also new to this area. I would expect that guests *must* see
> these as PFs, otherwise...nothing makes any sense.
> 
> Maybe Alex Williamson or Jason Gunthorpe (+CC) can chime in.

Driver should never do something like this.

Novacore should work on a VF pretending to be a PF in a VM, and it
should work directly on that same VF outside a VM.

It is not the job of driver to make binding decisions like 'oh VFs of
this devices are usually VFIO so I will fail probe'.

VFIO users should use the disable driver autobinding sysfs before
creating SRIOV instance to prevent this auto binding and then bind
VFIO manually.

Or userspace can manually unbind novacore from the VF and rebind VFIO.

Jason

