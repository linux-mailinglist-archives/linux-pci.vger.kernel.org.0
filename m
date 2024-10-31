Return-Path: <linux-pci+bounces-15721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6AF9B7EDB
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A475AB21AC8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C72136E30;
	Thu, 31 Oct 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zrErzKmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56A132120;
	Thu, 31 Oct 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389517; cv=fail; b=ILsXw0utv/Zh4eSYo2rZaCyKp+C00s0WyVG7c9C3wXfYCQgJDET2hc9Mpbg0SLMYAwZPbtwH7N43ilJSBYxemBvFUtI9j9S9NglMF6WwCmszXFlInxvRp5pCE5D8isEbL+sFCQFfRVN61aUjEGVeyi1bodn33f4+1kAc9XCO7lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389517; c=relaxed/simple;
	bh=C6a0ZyN2ajBk/lxNsG/Fn999CPfRACW+1TPTRSIOjs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EVG4x9QForEdHK3nSQUyBCy/6YObLKwVcZZ703GhEeb0BmzR1bRb7eNqMvA6upEVxs2MSlq6MFfMiFISLzUSkgbqCqnFzNy4fSx5ZI20/YzC0KKzXNn8dIyeV/dsk5GG4+A8zxo2TxwsNuAwOTBfJklj4ZD1TUtFLgRFOSsYQqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zrErzKmF reason="signature verification failed"; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5KtItTHJUAyTtHOTwXKFFXC1Opzgd6UddUh/jnOXXt9ojcFwfvk7gm9T76Lym7RGQaAHg0ez8WjX2NRVd8KBhYS4FAuecmFJTzgmc54U8ym75OyPBsO/NDhKMwPZBR7W7n1a6qVsJUIhlyqFdU5ZKB+9PlrM6vGyQdcP2ApDj9ULe/d6hKdsqW2NmRbkk7PkbU+zSwxGF02Fc/aqFrJuZcMKqtP/ahO/hr+lgayqOmp58hzW8QjrxVtoZwVraeGDd5x+SXNHE2OXz8tEW3ZPaMKzHxrHfzKKNjXnhOs/ddXW9d8WgZMmk5hJ46UhYx1zKNC+xuI3bgL207qailrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx87g+OuLSM7+DmtO8BXRE6urNrldUAuu2LBJRmBeuk=;
 b=FFCHwwtopO2l6OUL5GVESSMLb6Fndmlx/8b9NJscdmVaTLkw0EDqWgRHZHa9j6rcQziSGx6c/pctIKBd4cy2mCF6wdmVFIm8CaJ51oWu1pRogllxlFPd4OUZZaJBnA+tLHdup4nOA2azuSVpcdealVYHp8qh070geKXves2vT9v+CHvlmK1Y0z9RN0qsMhc3LsZld5XS9B8KbBBFYSjrHyk+55BIkCpJkPew39hnBKZID/zD3Jdsd4awswrqqufNqnS/ayd2L1VHnuy4kh13uHz8MT1z9W5q/D4BgWHaQPKkPk7582oS56oPdPqzvE5A390z9EzT4E8+3kdCdLKvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx87g+OuLSM7+DmtO8BXRE6urNrldUAuu2LBJRmBeuk=;
 b=zrErzKmFA16xg57cg45JmjgGU001JGBUhXcKgu0GlaeYM9JQi2x1lOCmyd1xaVqzGh0EwtaDoFHVOZnvpqleyepjJ13ub//XPx/trv4oyAKwzop5afMs+TrSYJjHQ77kcunkJjZrLEBJABsGrwDTKmDtxHonrK/DzFlUmtzM8mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 15:45:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:45:12 +0000
Date: Thu, 31 Oct 2024 11:45:07 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
	"richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH 06/16] x86/amd_nb: Simplify root device search
Message-ID: <20241031154507.GA1512215@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-7-yazen.ghannam@amd.com>
 <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com>
 <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
 <20241031153444.GB1511886@yaz-khff2.amd.com>
 <1ca45a43-070b-bd5e-995b-243b9644dde7@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ca45a43-070b-bd5e-995b-243b9644dde7@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:408:112::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdeb1d3-5f2a-4c68-7465-08dcf9c301b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?LoVfzLmr4o8ngh/TN8HF72Snfio6/+BCNtyoS3fAx99i5hdG6soT4rdtEl?=
 =?iso-8859-1?Q?96o2SquFMrBSQwqVXrJZJF+paP9pO+InqzE6IZP92UoQZSBhcFtXOV6NT9?=
 =?iso-8859-1?Q?jCYeL2AJoAzH6Ny3E1bjfhsrF2SdK2zxyXuMa2zHV0w9Lx1f+jf1w92Y2r?=
 =?iso-8859-1?Q?3+7WmOkgjD0kPT+86SSwa8IJQE4YJepAc+xtpQpi6DGdR9xDXxawAp/SeT?=
 =?iso-8859-1?Q?rGQ2jdLFkHL8fxz7ijeZUb5BMdvqJwzW4409K4af/EdEvgIyp8tWiCcDkr?=
 =?iso-8859-1?Q?agHIG5d88oT6Kr9LgSXHrm0Tm7tRqiQdF6CXqoXXEkM58WQbqvn2YCHwWD?=
 =?iso-8859-1?Q?fvtcxkOLlndzxmcdL3HCJBoU7HDw2+OG8JfSHegZq8wNrsIWYCUrH4QHFt?=
 =?iso-8859-1?Q?hD2f/IqHwEK1/8JSw5yMEUxMcDU5mUyFDK9nHG7AeqHUNk0i23KBPUijoI?=
 =?iso-8859-1?Q?NTy0gEpw4ijjE7S/mui6IoDu3L2z7NS5wzc3vugA3tKP4fI1ucu0GN7Rqn?=
 =?iso-8859-1?Q?koF3G8T6rkFIg8CUqX65F9K3cIlshBrTTbQytTLgZ70p6Wxb6abT+h7L0y?=
 =?iso-8859-1?Q?ip1V3/7MTYx1tROujlxthzXWXa7dA/Z3Fd2VEN1U8AHYs7M7FJqiNDn4Cz?=
 =?iso-8859-1?Q?r1YiwLQL4ro/8BSwX51/bEShXcXHrv/wMM2sMWgtrZqrQpJ+g4fK8Waote?=
 =?iso-8859-1?Q?zKrj6CbPl/YgiX8hCakchosJMq/H69y0oi2elC6G50/PbkxVdk70VoCkw6?=
 =?iso-8859-1?Q?Uz7F7YEC84ouliafYSrDYV6y905PXbzPhMtmNb1iSKnncMvawgCCn4XrCx?=
 =?iso-8859-1?Q?Sm0/9rYhrwX8+F+WBYQswGdEblPoNq7SdIcINWktL8rcAQS3JM/yNXEK01?=
 =?iso-8859-1?Q?Ak4yb7R/enUbR9OT48LVabIKMhsCHaevqRA327ioiZFRcRFfgdpEYcTeoc?=
 =?iso-8859-1?Q?jfLHQmb3zKsViJlwJ8iby6Lzx2iYkTrdj8EXVdmrz9Tqljp77ubZ4nN5fY?=
 =?iso-8859-1?Q?6KyvHV17eDMhUZ04tAWU07s1hUZAHYiJ2c6CYtXJdDS8PVFXsnAHb92Uef?=
 =?iso-8859-1?Q?/DO8pLnFLU8wPxHuN3rEmhp2HckFMhdFL4rcqZP/AiAtMyoXHIpPY3Pk8P?=
 =?iso-8859-1?Q?JBRp4VFienlw5Dje2InoXWRuiKGGVcTrVpsVlJYdVd9ALSvmd5C0f/KDS0?=
 =?iso-8859-1?Q?LB96+1MKWF2oDW04R+dL5MVcomzmIwL/SMz53Z+eOlsq00d6ruOZCxsZwV?=
 =?iso-8859-1?Q?3+fp8h14Cei4yeZ1TA2+YxDuFv1illO6kZqqul00mohXLSmI4CdxstSuv/?=
 =?iso-8859-1?Q?iD4y49YwSewrDaIrHyilfNJ/pvhkcE/vJVUUuCj0AJJpytm6k6Bhd0z5PG?=
 =?iso-8859-1?Q?v8F5BQ+Sbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PuhN7qSxXXki5TENlHbzovJgKyv4+9pHRQRIkmT+JONon/1jIb03k4h0Ph?=
 =?iso-8859-1?Q?Wtga1c5w//uIxzvLzw218Wc/swTbgoxtyo3LEPOkSn4vN7/NgmhiccCQ7+?=
 =?iso-8859-1?Q?ah1mz0O+GO2Ktil+llH7iDF1lKgSLjuc4OngfiZnEZE/a+OvqhJepPI7Ve?=
 =?iso-8859-1?Q?Mj6n9XVIiogHV8boM++y04mOOHUAVw5vYdKMyxZDthNSSNLRYMIf2RiIDB?=
 =?iso-8859-1?Q?uYHdUOxrYZHgThXp6TGFHnybcmS0TgQoP618WpGQN23/5woWg5ntaL/T/n?=
 =?iso-8859-1?Q?WlWzUf111+xoo/anYcCw9udWD1ZfmbS8FEUlQjIvir2t22eum5/VOUt01O?=
 =?iso-8859-1?Q?94OVtmg8piz23zgPXp3AyBlshDgmkUIEwvPJn0df/Wu4XGTxi24QAOtWaP?=
 =?iso-8859-1?Q?IdXq7163OJ8iMEJx0fOwkr8kIs/cV8I4R9LD7z+AyaWwQjpA06pYrVZfp8?=
 =?iso-8859-1?Q?is3iEDr15AcF3xXSJvGAck64ZCgsCi1ktIwYP9K0s5af3WS7MSPQ0T4IfH?=
 =?iso-8859-1?Q?6JjvqblOoRvk6Ab87uHdlgDjwefPfly/79fySaIcTD4W4HksQ6ySre3x5t?=
 =?iso-8859-1?Q?eQFQIF1K2Zsf5gQLEMOX/RFvae3qgtC25MyorhAWiaEE5b804LeSypTNU9?=
 =?iso-8859-1?Q?NLJUFFLESAmKiS4zt1Ax3UUipzQrgilj66qIKGzg6wa9KPh3RRqatMBMbr?=
 =?iso-8859-1?Q?Q0AVEXlHaRkPYXznbuz10DrfHeNWHgjt77ZWsfGufhAHTCpHsAMNiQZHFx?=
 =?iso-8859-1?Q?UYzVt/17aCm9gqIBNiEhGX8ZRW3nuNnj5S7mRnT3anWWKvpNZx/4Zf21Dv?=
 =?iso-8859-1?Q?OlNe2/cyebdCh3PHW4VSBwj81yo+yJ/XGcjLM+KgRIUzj0GxARB7ufVfzv?=
 =?iso-8859-1?Q?33wWCbJCMCalyWBefZWz17j8KU2QXE02R1m2hN+dww3ek+dgKajwpLGDC1?=
 =?iso-8859-1?Q?sO6t1PdpS8Rwvg9YtP+WiRQAhvYj5MoSqFdBdRtFWwBMA85XszeT5vEzGw?=
 =?iso-8859-1?Q?OYXLMNTa4RaFo8ksorgncR1GqniuDnoLjBeXNT5IxJp6ILbWu5YL4ZW1M3?=
 =?iso-8859-1?Q?Yyv1gpDDkRafd90YLc4F3FV6idrdbc5gQM5s+OLdb0yPqM/IhQfc96zdEI?=
 =?iso-8859-1?Q?Q3jXJNrL4yUiz38syRPItq0b1bJriLSixP+ErQr75zAGYfdmkUWH2E62Wa?=
 =?iso-8859-1?Q?biunQtTLExCVgFrX2Icivs9E+nDm1atLzKvl1x686vxNKuVZOvPEWlWHAG?=
 =?iso-8859-1?Q?7Xvw6OJm3d3dMAhfZn/Q761lnSxsAuUycPkL3lry4khRti5rbH/Eh4KUrY?=
 =?iso-8859-1?Q?6pgS4zTypCcLSC70HNU/iEVA8f8nILwZZJyLhYrVSfJLpdCWRIey/V8UaM?=
 =?iso-8859-1?Q?wy/eaBTkdKQyOHUOgfQ6W6D4ayOz4ABqElH3GqsvYQHcLOCfsh/RjRsdyV?=
 =?iso-8859-1?Q?ppVe+I4w8k4p+09+8GHSal8PPOlPUNzZ6k/ygtJezHWmK3LV0mNXNOi6lS?=
 =?iso-8859-1?Q?qG1I5Jgp1G8JYToxJMTWGqpdx1GCGh8Nw/dppHJTj1IpxhgpMImGC+EjfH?=
 =?iso-8859-1?Q?oZ/xK8uXhFp6VULreg8waOdYsWluGuU23jkKjnQ47nPh/b7xuu9Nb0Br5f?=
 =?iso-8859-1?Q?9xTcdSAUntJRvBjrd8ICRQ+4lud64NRljw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdeb1d3-5f2a-4c68-7465-08dcf9c301b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:45:12.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OpiYCXnPvZ8B/lAL+s+OWzd3uda0jrH1XrzKCRCz88zo+TNTp1JhZ4ludax8rY4+Rj8Pa75J7ffBX0IeOk3+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

On Thu, Oct 31, 2024 at 05:42:34PM +0200, Ilpo Järvinen wrote:
> On Thu, 31 Oct 2024, Yazen Ghannam wrote:
> 
> > On Thu, Oct 31, 2024 at 12:08:20PM +0200, Ilpo Järvinen wrote:
> > > On Thu, 31 Oct 2024, Zhuo, Qiuxu wrote:
> > > 
> > > > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > > [...]
> > > > > +struct pci_dev *amd_node_get_root(u16 node) {
> > > > > +	struct pci_dev *df_f0 __free(pci_dev_put) = NULL;
> > > > 
> > > > NULL pointer initialization is not necessary.
> > > 
> > > It is, because __free() is used...
> > > 
> > > > > +	struct pci_dev *root;
> > > > > +	u16 cntl_off;
> > > > > +	u8 bus;
> > > > > +
> > > > > +	if (!boot_cpu_has(X86_FEATURE_ZEN))
> > > > > +		return NULL;
> > > 
> > > ...This would try to free() whatever garbage df_f0 holds...
> > > 
> > > > > +	/*
> > > > > +	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
> > > > > +	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
> > > > > +	 * this Data Fabric instance. The segment, device, and function will be
> > > > > 0.
> > > > > +	 */
> > > > > +	df_f0 = amd_node_get_func(node, 0);
> > > 
> > > ...However, the recommended practice when using __free() is this (as 
> > > documented in include/linux/cleanup.h):
> > > 
> > >  * Given that the "__free(...) = NULL" pattern for variables defined at
> > >  * the top of the function poses this potential interdependency problem
> > >  * the recommendation is to always define and assign variables in one
> > >  * statement and not group variable definitions at the top of the
> > >  * function when __free() is used.
> > > 
> > > I know the outcome will look undesirable to some, me included, but 
> > > there's little that can be done to that because there's no other way for 
> > > the compiler to infer the order.
> > > 
> > > That being said, strictly speaking it isn't causing issue in this function 
> > > as is but it's still a bad pattern to initialize to = NULL because in 
> > > other instances it will cause problems. So better to steer away from the
> > > pattern entirely rather than depend on reviewers noticing the a cleaup 
> > > ordering problem gets introduced by some later change to the function.
> > >
> > 
> > I originally read that in the context of using a guard(). But really we
> > should do like this in any case, correct?
> > 
> > struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
> 
> Yes, that is the recommendation. It says "always" so not only the cases 
> where guard() or other __free()s are used.
> 
> Of course this only applies to use of __free(), other variables should 
> still be declared in the usual place and not spread around.
>

Ah right. Will make the change.

Thanks,
Yazen

