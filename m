Return-Path: <linux-pci+bounces-14689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C989A1253
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6894F1F22B5C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EE20FAA5;
	Wed, 16 Oct 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D92/aWC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B318800D;
	Wed, 16 Oct 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105862; cv=fail; b=Or2wHgIaDSQYtdtK+3KbJWcPf7OVDTeCusaJcthpV6v5LDXU6ooINz/eHr0VnLnOxo+IKyRON9n0XuI0zksJfV6LNadA4uwYESjXoYWWrd2ayl2l27Gc/C3AN8xNGmpDNpK2TwO5W7OPLiVJSNPYb1RSVjoygouL3r9JmZ7HLKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105862; c=relaxed/simple;
	bh=m6K+o8+5wsCW67pnPe0IneuvJAFV0GAS/9/obPD9U3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ls/Roec8q/ID+utyl3wBEWPHLoJFG28qloDX8F1mfcbQA2ElqKs74yVxVpuh3YvbxL+W9xtNGoQBsgM04PcFBxFKByu64ZA4q+EYcrHaJNJOLHUgRZctgGZs0c0Z9bA2YZVYUxcyiBqoEaBxFfwhZbwnAKIzOfaTUQRKyY41Kzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D92/aWC5; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPkiBAzwfxdx/CGL0Vr93X+jrbMz9ScLlxn+xn8L+FhRTu38EBG9wu+wK9/KpWcorBnbVLukJox3uBi9+5ExrpSecd2fPTMlEZHFn+1OvZ4Xxx3BrTLdXkocJefEZ/I3jvRQerwowkA2Yvm8Oz3LHolkSSRKtJKNwrPJQd8c9APgPX+rULx6XUWFUvJCmyB/ZJWN4Dw6/+1QV8YKT9FJFXHJuoIouZZ3bv/22GTmixVBXT4xKmIcFf/KgkwGruZVaXWkKe4L8DxR+lVGH+dlpG3aLiQqysshfWDUJ/2CPsuE6RPajt7Ux32jbR7a6PBBLneCX49YAdRYuT89PWyFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G93qL6ZxM+HkQPT8/RITdgqAc8X6akuJvkrBUbVVFfQ=;
 b=aOIkXdsw5Uq2rQfTA7zJ9x0od3sih67XKWxhKqzCX5LDGtuL6IhiSl3svrvdym9iQYfSxbkk4r11zdqSn5XwNY65jm+vUIhFORAO8wxBZ7R9xDcvngX+kFgWDDrNb3kzblFHa7WX/RrvuPelCJRWgBacXu2mEAWqkcjgsjIwXbZ3nlu7qsFHdv9lsgtsDqsm6i8WePAAx1/4u2N0jmXdU4DDIbSPoVhmJK8lyDH2b9uA0MEI+D57bPW3RxeoE86Dx5eqM4+gU2N1iBdBCwOdNRk/EyzSoX7i/U6pZmRR2n7BLJG37bXtTLhz8uYe5DqJyKaiAx58HRHTWqYSMcnlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G93qL6ZxM+HkQPT8/RITdgqAc8X6akuJvkrBUbVVFfQ=;
 b=D92/aWC5aygQmPIhoAFAeb09tG7cg/QkBZKLBWDuZSLw/Me+wKPyye30EhsqzoXGUMa8PsPkMQOY1Xz7FqvV3Myzl2hH5qwBeowZYYG5fJLBFMN3ooHaKOo7Rk+ToV3nBqKWSQT73t9rDYrdIVR+QnK2g+8+PmyJ2RLm/I38PKww8lmXd6HNS8Kwd3C2LlJfB7w5ip6EaHEgNgSU1t0JkfHDpU9ZfR9AgQvYzhxqvPpcSMBBp/kwd/hLiIU924Wkujvh90Km8YmP4n0nN2rkqP+tT+07zy7cwHHTyHGx3KJRvu+rcqCApmWZi1K/nmv0Dx3nEG5Pt7e6KrfpzqRCOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9681.eurprd04.prod.outlook.com (2603:10a6:20b:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 19:10:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 19:10:55 +0000
Date: Wed, 16 Oct 2024 15:10:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <ZxAPtfOhYBsz3ygC@lizhi-Precision-Tower-5810>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
 <20240923-pcie_ep_range-v2-1-78d2ea434d9f@nxp.com>
 <20241016180849.w7vppj2bsvagqhb7@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016180849.w7vppj2bsvagqhb7@thinkpad>
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c94cd7-ac39-4682-82c4-08dcee164265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZS96aUd4UXJ5ZkhCazhVcGhrNERmMWQ4NkpNSHYrQ1E2aTlvL2M3cWFhVkc2?=
 =?utf-8?B?VkVQY0gwQTF0Q3ZFMFR0ME8yM0dXQ2Jqa0NLcXM5a1VJWE5YRnRIbVB0SFh3?=
 =?utf-8?B?ZTR4UTNFdW9FQ0MyR2pJL3o0OGd0TCtIS29mTG81b2tzaTd3bG1hb3dLSW9T?=
 =?utf-8?B?SGVPQXZyZVZsUkJtSnNDNXAvYmFaZm5taVpvVTM2UmRtTEtYMEU4VW4ybkZ1?=
 =?utf-8?B?eXphaUE1NTBOWkg1c1Q0QXhVeDQ3cTNSL2JmQXZDdERtdS9vT2xGR0psMVR4?=
 =?utf-8?B?dENBM0w3U3NMNnBQaUh1SU84NTRHOGFwRHY2RGZiRWQySGF3N0tXcCtoQWR3?=
 =?utf-8?B?SzRzM3FxM1ZKcmhvZElkMStSbWtyM0JNL0t2NDlSdW90TFJTM01jVnlvb1RW?=
 =?utf-8?B?Wjl6bUlYL1hjNmVqdFdJb2lraHlScjlYbVFNTnAvdktncXErMWhISUhWbGJF?=
 =?utf-8?B?WklvQ1loazVRemJ2WTJVZ3MwMEZsT05hSU9ua0l4bWRtZ2hTMWxsUnpkRlZV?=
 =?utf-8?B?aW1QajZpcHpNeUE0TVpkMEFzV2ZBYkR3Mnp1ZVJRMW4zVmhLbWVFek5PRE1Z?=
 =?utf-8?B?MnVQRlBrSG0rQ2pvdms3L0xZUTB2clRqLzg5eFdxMVdQbXNDNmt6MlZ4UzB0?=
 =?utf-8?B?YWFLSktFc0gvQ0UrR2l6akpWdHl3OXU4dDVja1J2aUg3QUNObUdaWTNlNlRk?=
 =?utf-8?B?RnFCeGUvelFUcG9VcUJEWVN4cklqaDVxTmtudXovcXVYVDdhNzVhVFlDTVB5?=
 =?utf-8?B?QmxUbmRMazlzUlBUZXBoUzZpNXdKRGdZRHFNU2p3UmlTQm8wQnpOQ2g4OHBy?=
 =?utf-8?B?MjlXYUZSVjRaWkNmdjlsMTFjWFl3bGFkZVFCS2xvblVZR1FnTzFXMzlicDBK?=
 =?utf-8?B?MWMxS0pXcXZkRDhVS0NyL04rV1poRGEvbGF0dVNoV1VmQnEvK2Q4OVFibmk4?=
 =?utf-8?B?cCt1Vk44RXNOQ09weEVlaHNvT2s5eWZLbUQ4Qk9LZzQ3ZWZLTG9vSXZHZ1dp?=
 =?utf-8?B?cTB1WmxnbmhTNDFObkJ5MWI3YmJzVzhKQ0lBdnFFYnkwTWlIUkV5NGk3Z0Ur?=
 =?utf-8?B?Nit2RlcxZHFGUGFJN0tUSEhabWNxQzhCZ2FFK0RITWU3b0NLOXlMb1ZQeEpy?=
 =?utf-8?B?aUxIOUUzakR3QjBJVTBxcEh1czBuQkY2eGIyZUxXZENmSkhNWTdWV0cxMjIv?=
 =?utf-8?B?U001VVl0ZzdsYWhvQjNmVkVQVnFmZU5Vc1RFQTBtN0JuZ2hNK0VJTXlYbk80?=
 =?utf-8?B?MDRUUk9ZcXJmbS94Z3EyR1JSRitwMDNxLzBlTm9UNERKa3B0c1lhZ2syQUlt?=
 =?utf-8?B?Y2Jwb0FURGFVZDJRbXlQVVMzYWtYTWhzb0d1YXlOS1dyanlqRGpqWTBmcFNU?=
 =?utf-8?B?eWxqNGJGSzYzQXRaQ3BINjkvL2lySHZQbWxNZVZwbnpkUTRqYWpnTU1Fb2FE?=
 =?utf-8?B?TVQzNWtzSWN2TkVWakc0Vlh5cFRkd2E5akQzR0w5QU5MRnhTRHc1Um9sRUdu?=
 =?utf-8?B?aHJEYjV4QjVMQlYyTUdTOFJwUDc1T0c3NzJReGM3dmVjS0tVR1htVzhGZnRy?=
 =?utf-8?B?UzJ5UlcyRlVRZ1llc3NPbzdlTGhQTkQ4M05Gb3ZDbkFZTENmNDRyYWlFQUVW?=
 =?utf-8?B?SHk1RTl5TjBXdHNMY1lQUjdqYUJJUVJhanF0Q3RQRkJZREpBZ21KMkVmOVJH?=
 =?utf-8?B?RmhsMHFLWDNDUXp2eEFZWlhmcFVpTFNBTWlkL1ZQdXRRVndVWUxsTVB0S1I3?=
 =?utf-8?B?dUtNbExmLzdGdWxGbm1hWmJEck9MUEdDdXRWK2hGNTQ5NCt0N1c3Tk83MlFv?=
 =?utf-8?B?TS93bzVDYW1JVStQbE0xUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGFJSWJVaGJEY29KZjdRWkEyWk1CNzFTTEd3RW9OSU9HQ2x2aVl2MGJFZEIv?=
 =?utf-8?B?djVBTVdXVHJmY0dKOGJNQmxoTnRHS0RQUHpBYldXWmhpZnRUK28xTGt2T0Zj?=
 =?utf-8?B?Y0YrNHBTOWtzakNqL1VQYksxd0dFbDhRdVh2UExkNEhmZWtzVFp6UVcxU0Zo?=
 =?utf-8?B?VUdCZmc5bUpoVjRjQXF1RUF0TGxjaHZrYTVjcFFqTTBRdGpJdlZwdEppaThk?=
 =?utf-8?B?MEQ5bDNmek5mcGUzWm55YTA0MkxhL3A0V01QcjhvYS9RMW5oM1BRTm9WR1Nz?=
 =?utf-8?B?NXduUG5oMFh3THhzendEajlTQnVmMGl5MmkwN3BCV1Vvb1p2dUVXMUxKUWVw?=
 =?utf-8?B?dU5Kc2M3MHpnaSs5bXdKSEVHV0VFWUFyZ0YySmRBWVhQRmdvU3Yzc0hlWmMz?=
 =?utf-8?B?Wm1EZWQ1U3pybjhjU3NCS3dzc2diOVBDekdUVkZTc0tDa1VjOXh3Q3p2TXQv?=
 =?utf-8?B?WThNbDJNck0vdUpUaGhhUFpNdHB4a0RCVU1Dc1hPVmpaSnYrV2J1VlV4YkpM?=
 =?utf-8?B?OEpaQXFqQS9iN0FIOHZpbmFGdk04bGx3S1dqcWJoNHB1WUYxWitkRXBNbzR1?=
 =?utf-8?B?ekdGaFY4N0lmeFIzclY5SVlzTy9oTFZPeThWaEM0VzdzcEtBaDl3aDVZYlF0?=
 =?utf-8?B?ZmpKeXhHaHdoMkE0QjcwSWRnbmJXVW9yMk51a01NOUd3KzgycEtmcnBZUXp0?=
 =?utf-8?B?U0Z3MTRXa05IZ21WZGxCYytscDdQTzZIMXFEQ043aHlCNW95S1ZaaWs3ZWxj?=
 =?utf-8?B?VlBCRERON2FkMEMyK0tpdnlMSkhxS1d3Sm53VHpJc1NJazVzbnNxQ3VUMkNV?=
 =?utf-8?B?RVZTWDJJTFp4dzloY2dnNWVGcGt1QjZwR2FPS0lOaXVqb3NtWkZYUGw2T0VL?=
 =?utf-8?B?R1dlYXFrUmsraXZQWjlnSGV6NFJsd2hBN2RlN2tnQkY5WFp5VFRXY0tqcDVJ?=
 =?utf-8?B?Qmx2aGU5VVFnR2U4NWpDQmpTeWlJQXZ4Q1FqYzUyVXl1aC9VeEVuQWpRaWtu?=
 =?utf-8?B?b25BMkFGcm4rck0vYmUzc21zMERnV3ZQVzhFbkRPUmxTOVBuT2hsazRyZjRS?=
 =?utf-8?B?b1paU1J5aVVlRUFNL0h6RkU1K29zRmRLOUhXMThJRU1ZT01yaUxscitkLzBt?=
 =?utf-8?B?c2NYNUNBWTE2T3BOTlR5dlpBZUpDeHVaeDRMVUJQMnZLcnUzUWlDOGJITUZx?=
 =?utf-8?B?RFJmeDJBSG0rRFBONDIvMCsrbVJybnltRG1FYXMyVlhVWFlKaTFNaWRLWk1S?=
 =?utf-8?B?SWl4Sk9uUWtXdS8vWmN4dXhjNUc5MkgvdWUzWHBoamhZd1RoL3pUWVZtdjZv?=
 =?utf-8?B?M3RxeEJkRFFGaVo3T3R2eXp1OFQzaU56WTNUcnNMQjVucnAzTng1M2hpeE4z?=
 =?utf-8?B?dkR2SCt4NWpkUUVnYUdJSElWQ0RjbElOQ3BpcTVpQ3dtK1hjc0hmNm9xbmwx?=
 =?utf-8?B?Rm41dExWL0dHd3JTTU8wNWJRNFk1akJ0VkRNczJTUm15ZHd6OG5HeHc3Y25V?=
 =?utf-8?B?QUVNN0ZUU1JwbGJISzhrYnBKUUtCcDJvSE55ZXJRazdvRGprQVBZYUxEb2Jr?=
 =?utf-8?B?eDhRd2t2RmJFUHJ1YnNOTVRBU1M2TDdMazJ6N3U0Ti8xbTF0SGVxb3YwMDg3?=
 =?utf-8?B?dnlzS2lVd0dlN0MwSDJYR2s0eG5qMmlYK3pvUjRYVmtXeDRscXdFY3BaWVho?=
 =?utf-8?B?a1FwbjFJQTJkeTRiNDhESXdqelM1NTRuV3hSL3ZZQkVycDJLS0RScWEwcjY0?=
 =?utf-8?B?M3cxaGxGMHFtWHAyVS81VGUyNDN4QkEwNDhGUWl0S1A3Sk04Q3hnOEhPUk14?=
 =?utf-8?B?YVYycjhPdUJER2RNWkFMNXlGdlNocEdWS2ZrdVdydDBpMnhxSUdLVURZYWVQ?=
 =?utf-8?B?VzNqS0YyQUs4TEJLT3VlR1dFOTV2Y3FTdFNwUnZMeXhaandXMXhOTDFZNG13?=
 =?utf-8?B?Z3VlYTR0T0pTdGFwb2pJb3NZTnBxZHVJSXNGVjA4bDhlYzZ2NE4veVBicW5J?=
 =?utf-8?B?ZVkwWjBmcmNpNmFjV093U1BscHJ6WWtLRDM5NEdmRzI2bkFIcGRFR2dkZVhN?=
 =?utf-8?B?QTJxYVZEYStoc1J3byt1Y0xldko4K3BPSTJlQ1poOTNHN3RQWlV6a0dLWHNS?=
 =?utf-8?Q?hRZM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c94cd7-ac39-4682-82c4-08dcee164265
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 19:10:55.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/9RXv/di8H2v3sGhVJAldinEXNH3OiitLmeaOXR9FpxguiXevWIaJwn2wX7qNw8ZuySMAn4ligJq2Ab3VJBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9681

On Wed, Oct 16, 2024 at 11:38:49PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 23, 2024 at 02:59:19PM -0400, Frank Li wrote:
> >                                Endpoint          Root complex
> >                              ┌───────┐        ┌─────────┐
> >                ┌─────┐       │ EP    │        │         │      ┌─────┐
> >                │     │       │ Ctrl  │        │         │      │ CPU │
> >                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
> >                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
> >                │     │       │       │        │ └────┘  │ Outbound Transfer
> >                └─────┘       │       │        │         │
> >                              │       │        │         │
> >                              │       │        │         │
> >                              │       │        │         │ Inbound Transfer
> >                              │       │        │         │      ┌──▼──┐
> >               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
> >               │       │ outbound Transfer*    │ │       │      └─────┘
> >    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
> >    │     │    │ Fabric│Bus   │       │ PCI Addr         │
> >    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
> >    │     │CPU │       │0x8000_0000   │        │         │
> >    └─────┘Addr└───────┘      │       │        │         │
> >           0x7000_0000        └───────┘        └─────────┘
> >
> > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > The bus fabric generally passes the same address to the PCIe EP controller,
> > but some bus fabrics convert the address before sending it to the PCIe EP
> > controller.
> >
> > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > Bus fabric convert it to 0x8000_0000. ATU should use bus address
> > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> >
> > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > the device tree provides this information, preferring a common method.
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> > 		 <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie-ep@5f010000 {
> > 		reg = <0x5f010000 0x00010000>,
> > 		      <0x80000000 0x10000000>;
> > 		reg-names = "dbi", "addr_space";
> > 		...
> > 	};
> > 	...
> > };
> >
> > 'ranges' in bus@5f000000 descript how address convert from CPU address
> > to bus address.
> >
> > Use `of_property_read_reg()` to obtain the bus address and set it to the
> > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 43ba5c6738df1..51eefdcb1b293 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/align.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >
> >  #include "pcie-designware.h"
> > @@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >
> >  	atu.func_no = func_no;
> >  	atu.type = PCIE_ATU_TYPE_MEM;
> > -	atu.cpu_addr = addr;
> > +	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
>
> If you convert the address here, aren't he drivers with cpu_addr_fixup() will be
> broken? You should only update the address if the callback is not available.

Supposed not, ep->phys_base and ep->bus_addr_base should be same when
use cpu_addr_fixup(). but I warry about some old dts have not reflect
hardware bus address translate correct.

How about use below method:
https://lore.kernel.org/imx/20241008-pci_fixup_addr-v4-2-25e5200657bc@nxp.com/

Involve a varible 'using_dtbus_info' to controller it.

Frank

>
> - Mani
>
> >  	atu.pci_addr = pci_addr;
> >  	atu.size = size;
> >  	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> > @@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct device *dev = pci->dev;
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct device_node *np = dev->of_node;
> > +	int index;
> >
> >  	INIT_LIST_HEAD(&ep->func_list);
> >
> > @@ -873,6 +875,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return -EINVAL;
> >
> >  	ep->phys_base = res->start;
> > +	ep->bus_addr_base = ep->phys_base;
> > +
> > +	index = of_property_match_string(np, "reg-names", "addr_space");
> > +	if (index < 0)
> > +		return -EINVAL;
> > +
> > +	of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
> > +
> >  	ep->addr_size = resource_size(res);
> >
> >  	if (ep->ops->pre_init)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 347ab74ac35aa..c189781524fb8 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -410,6 +410,7 @@ struct dw_pcie_ep {
> >  	struct list_head	func_list;
> >  	const struct dw_pcie_ep_ops *ops;
> >  	phys_addr_t		phys_base;
> > +	phys_addr_t		bus_addr_base;
> >  	size_t			addr_size;
> >  	size_t			page_size;
> >  	u8			bar_to_atu[PCI_STD_NUM_BARS];
> >
> > --
> > 2.34.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

