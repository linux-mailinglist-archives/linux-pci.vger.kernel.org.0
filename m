Return-Path: <linux-pci+bounces-18080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF799EC11E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 01:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D695284ECA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6C42A95;
	Wed, 11 Dec 2024 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n9PNuk61"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021130.outbound.protection.outlook.com [40.93.194.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100483D97A;
	Wed, 11 Dec 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878516; cv=fail; b=IUolUgANtsaGLDLp2Vpr01eJ3LKA5wTy04ARV/cj0d3ATx0ocsX144smtZm72uK6J9Va0Fpv7Xao8ThM5MPPRaB8YiPU3fbJ/1nIWvKSDTQfSgk3QJm7c+KrXad1YVhXcLBIPHav4okEWdxO/ImJ9ZpM3MhYfwE61MuMq7+5SZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878516; c=relaxed/simple;
	bh=qwjlX7zxZRk9Uu+T8PQLuJdlQ3p92EQNWKn9FclAeL0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=UH5HIC9DDQLhJNhDUBoHS5mYCcEZb8E4IHiS1oeNUMu83c7SbWV/aCR37EzdeI0AEHgG+VR7rVVp1BRLUKh1EGdxrkQ647YD8d52WNEZV4i4ZwnccPRrDPrRAMgid99cmntHCvyOKoR26ZznULh6nfdrX6cLANroDTW6wNAUADM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n9PNuk61; arc=fail smtp.client-ip=40.93.194.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rknch9vFw+Be8tLWk9TSn65CZE/rLmMZYZAvTEC9Hwy+/rfaWlmiIeFDw2V2Lu7eUkzw/saZOwoN7w8Hmx6BvMBlCCLPCtbLhYSvTuqKQ+DlsJ9H1nie48tYo6kbiDg1RAbRnNbekkMjtS+mWAueLk5mrJcrlb5DVObiK57dt0PzBqI9Ug6WzyYMd/LRGTSwrRyElZZwcLHSRCN0Qgr9avNh29D/7rOQiautQo06mf4W5//mg/n0QOZQqLQ/u5IooaKhOWUMGtYihbObHaclFDvczcBiX7/AK9wccU5enhVzp3lUtoDhAh4OJAdbQcFrdFuOP8Insv+QSQHMpohyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0JE2Ic6cbPN5RMc4iHMrTic0oMopqx6Kaf9VC+ryxU=;
 b=UfV1hqbVADPullceaGtp71j7o5xkExeyB/tl9PFBc4RkbOKOHv9emV5sue2UfchcPqBMHYcDkmbBhKXZo0QOARq0ru0Sj92o7j4S+qCmqImHzxiZ4VoZdMFYrtKbZnTpiZ09T3JhDAdKy1kFHqAAceL8ZMFumyqcsOWYG/f6pLOMK9Xob7qYw0i3927DZlem+Qo4drMCxkeEezrvOm4DPT3gEFK8cM0k4CBmgIVGahaShKPVjzwFArmD9kDJs1EUj04bTNZsQjg2jQZZgcOS15VT6i+fy193xSLOgi0ffbBBgId4CMQQCDN7jqHF9NqrSuwxoF+9Kn1h9iUPwVgK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0JE2Ic6cbPN5RMc4iHMrTic0oMopqx6Kaf9VC+ryxU=;
 b=n9PNuk611ynYTbswn0aDa5KaSLGJiSAtUDsfXlN9XbUcx1NgJWm2zpK2E4pSfAP6Ph5VgrdMf5G9RV0v3gQU75469XsJcwcMpc3y8ITzp26TEUGD5rJuUdytUKt0zUg2jmNEljdwajSg1VJ7GFw3m7ljQlxzbJBuOROV5LvOsrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 PH0PR01MB6523.prod.exchangelabs.com (2603:10b6:510:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Wed, 11 Dec 2024 00:55:09 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:55:09 +0000
Date: Tue, 10 Dec 2024 16:55:00 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Shuai Xue <xueshuai@linux.alibaba.com>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] perf/dwc_pcie: Qualify RAS DES VSEC Capability by Vendor,
 Revision
In-Reply-To: <20241209222938.3219364-1-helgaas@kernel.org>
Message-ID: <63442519-ae22-dbc2-debd-c4337463cde9@os.amperecomputing.com>
References: <20241209222938.3219364-1-helgaas@kernel.org>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SA9PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:806:27::7) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|PH0PR01MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c5bc47-a088-402e-61f6-08dd197e75c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JmAKHg8vPTumKVOXU0PRAF/pgixWgXSZM1feXE8UzA1EVfNEemKDzcwpT/2Z?=
 =?us-ascii?Q?y8yETQLtNcqR55flqCugI3a+WQ5nDxaNJcS2KXigEcF44wBEOpsIJxFWFEXS?=
 =?us-ascii?Q?TECJhz7VewMG+QQWoGkZmTrF96+93lmmn9jtPNvo6HInWOsWsXyEJx/KGV0t?=
 =?us-ascii?Q?gG+FsVzVNaPFvU+Gh5Uev/MXtX5vPvCvqIsldYhIohnu/rFrLgKELgVL8CMO?=
 =?us-ascii?Q?WC9zxkVnWIE66bof0xD4tgPOILAboWQMgdLRZwxkTibazmLscUAsQnRHqPQT?=
 =?us-ascii?Q?r9QnOX1/BQsweujwMPfhMWUBUvVGAt+lgHeVop8zyblq9sY7hotGCZv5tfBE?=
 =?us-ascii?Q?WW4qT4hoEuPQkDPbguAebYfn/6HL0x72md+aeHXWpyhGtfKR4H9H5IaJgyZQ?=
 =?us-ascii?Q?Y2dLTud1hev1TXz0IQNZynK/u2l4iJl36gJS9EHO/BlhB4i0VchlSEk3bQ9m?=
 =?us-ascii?Q?MNQ90yh07ikDeRggKNsSCncK4Bip855QmTV9L4mUGDuRh8B2sDfFSyQw60vE?=
 =?us-ascii?Q?Hez4KNhJzvfWdcR4kp8u68nAamh/8W3EcyYHEDqzDKpsGl3xokbEseFbI/kQ?=
 =?us-ascii?Q?2XhRwprAf6htLyrjNjpRHYHithx0cwi9ggeY8iad8s7TVk1lBZbaiVmFEyqn?=
 =?us-ascii?Q?eYvyv/iJ/Ibo0+n6SZ2NaNbnjNGOaKMetKt2yjqxmNn6ZE5YtvES4S+LqHZC?=
 =?us-ascii?Q?OYNb8yPCaNdSRFBRUFgP2uCap3ld7VUy5fkI0WK0Sm7TdjFbwQBgwMkZcEI1?=
 =?us-ascii?Q?zc2mNJwfeYjDqsVpOKTao5XQReG51IKKMH2t3f6uxkV4Eap7ZXUCRLf6KsyW?=
 =?us-ascii?Q?K3Vz/cX579CQ0cGxDO4ijzkbr399i5CGdPFGAaoG8O32T9vHHYI9KdohDa/v?=
 =?us-ascii?Q?fEo/OlzyNGQC+aEseNixY8yrQe3m/lZgMy3KgdNopQxecMuw8s294cqrg4HK?=
 =?us-ascii?Q?XOovJEIFQCyOnAoohd8omJtm+N4zmTeZUYWKBDbVhvDa1o8KUJnGYsT0ejU1?=
 =?us-ascii?Q?9EueTRdjhN2TcbCcu8tERIRFoNUAf/mGZN7jOkqUCpeG6PCymM9YKhACgRO3?=
 =?us-ascii?Q?TSB7WfkUayrJ9oNjeRUmRwb/D5epUHb0lb4vwfKSYs6DIZ5uWtOBY/UUerej?=
 =?us-ascii?Q?+Td6b+JJtZqW5qeq3PdWmIe/t13p4u3AyTjmsOuhYqDe2qIzKos5l3bxbCYe?=
 =?us-ascii?Q?58S4nWf90zOrKqi7AlF+82fMXR3bXwRGWpxEwUqfWe3Mnf8IlbSOk5M0qEaT?=
 =?us-ascii?Q?H6Hkj3Ez/zLGYTY3MkyUE/O9SIhIhGjXCAKxnxaUKcShd43QSXADwpy9k9NV?=
 =?us-ascii?Q?4cBpKndNFXsED9fVebqZQ3QuqZ7c2uBFi36DkL+fHLxIMucfyDB/84jW+bsz?=
 =?us-ascii?Q?faig1g8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKlGqpxME/TNLKA4xyNRgDvdzey3MaBo2p3zUa8x8D+1LoWyAGrCj8LLOOa/?=
 =?us-ascii?Q?/cEv62fMbf2JLLtJKVqgLk5aIWYQIHXFPhlETb1CyMvbWhislSr16kAsaF/f?=
 =?us-ascii?Q?7/LRZlXZcn8RJ3obv7XQRdlf4DxsfZAutdPi0Th4wAeG1p0DVlszBCuYHlS0?=
 =?us-ascii?Q?ssI0d9WC5bJneP4XkTBSWhfTBLqmTwv+mugAk9okfyRrmr1IVQAl5ktLli29?=
 =?us-ascii?Q?Y2rasRqQu59MdVLzeUzBbXJIvT3//ktVdwcQNzUQGJFMHhBWy/mJc87B4Uxy?=
 =?us-ascii?Q?TrRAUfIdkVYHQ5bNoYuecPQxLdcq6j/oBfN87JE0Q6tkuiDEhbqFH4bfmMWU?=
 =?us-ascii?Q?6IcdvIWdKPBLKlljeMiVHEk3P99TqPM/ogH9ySzUweKPEfc4cpfbHUphviqS?=
 =?us-ascii?Q?KdOCMbiZfICyzXQ3MVRCT5EXVI5BrnTp56wlIBR4qDc8xkQvIeP5B0lDP/+g?=
 =?us-ascii?Q?kPX+lK5rUMVwN8WbYH29MMKlDdNmlfj58oCDabxW4e/SJcRJdcrTxb35fUgR?=
 =?us-ascii?Q?Regu58S7Oqpv/pgj/gJA+ALO+JWuPe2J1wKos74RYeFZBTGrc2w4jQYvn1nl?=
 =?us-ascii?Q?k+2A06iXYjYFcZeylBdMPFLnx0ceok+BfXNEVRf3Lz0ElYXotALTig16neGy?=
 =?us-ascii?Q?vMXsE7oH2qIlZRvEAkiX3CURtJbeC4JcJMqJ9V/XowVr1FYZwGHxD8jEpXp2?=
 =?us-ascii?Q?5ojNNtqlLvF7Aj4jNY5besGBIzJzsekR2ec6Dd9qcGaeFu+OGMvAaE4TPavM?=
 =?us-ascii?Q?aJ1hTC7HBEH+9H69CIbdSaCJBlkpjIriNS/jhfvCOQoTHyDnHnGHiSCmqgSZ?=
 =?us-ascii?Q?yebCLCfVYnkqJsDqZXAoW4tfJ4Rb3+ImwXqADH+VQQ4j0+AvZAqdFqplNxNa?=
 =?us-ascii?Q?j2RNAyk8NheZuCGqGO5Mhrnp61Az9y8t5gbDo78N2lKP4Bf3to/1wYpXh2Z7?=
 =?us-ascii?Q?hC+PSJ7041UMnZwga1jjmN1UuSJFsAVD+mEP+XMOOt3cBcGXb2YhgMVKcpbs?=
 =?us-ascii?Q?ijvMzBINKBoFOyleYPpH9E+z/jmbBnSoHmXtYzEnKqHd5bZYop85yTvuH5hL?=
 =?us-ascii?Q?hMkapI5B0nFZ6nHczNv8RkVVHlVY8uzEGYC6/EFajLpplWY/reTHkIFlPK3e?=
 =?us-ascii?Q?qWMQCIPG+BkDhDJ7hICZVV5HOrGcJja2m4jujbgzLaw+CPiHH9p0iQIGVv+c?=
 =?us-ascii?Q?4s35Ju6KK7y5oHCs8F3urV8CWffw3mnVQ4DHoyCej0dV2PfcLxt2hroctQbg?=
 =?us-ascii?Q?K7xd1rmsE4mDZWCty8tePNkpmfJcwFtwWbTxLtMR7f2cjTVRvzzA7PGfN/gl?=
 =?us-ascii?Q?BgquFIjxUT4HX+Z3DUpJuUFVM8IjjIK6eUWyAuksCVhGnp2Ah7SqbQzJQcvl?=
 =?us-ascii?Q?IywSwC5Oa5JPJtoHxaPCc4e+hygpqo8yti5CYLybEIxg1+TIf0Yir90dheC9?=
 =?us-ascii?Q?VgDopJjVO+q5BRoxJgAe6UVXilFTgu1dAQTb/1ZKblD8uxwm9LhzQTig+mGa?=
 =?us-ascii?Q?bM4nFpeEDtY1OM11fVCRX0sGLfW05u8KD6U/clfYBvgJDlSVNcHvtgVQYKil?=
 =?us-ascii?Q?7z3sEv3SoXUco0O20GHgsCZ9ZZzGnfBR3O1RRvhfMbWvmwsRICFrN07cOhIN?=
 =?us-ascii?Q?06heuKJnGY4KaxlzxniJW3g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c5bc47-a088-402e-61f6-08dd197e75c2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 00:55:09.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXCbMXn2x1i93XzWIiQExG4dSTbR6fOziUI0GiplWQb0tiVfPxsSsbChJ9CNhXqJFUPrrY1J1fv/8aXm3uzlHEF0jfSxMAsRyNlZXp8KtHBnhIbiUKlvcvm2KR7+SVwC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6523


On Mon, 9 Dec 2024, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> PCI Vendor-Specific (VSEC) Capabilities are defined by each vendor.
> Devices from different vendors may advertise a VSEC Capability with the DWC
> RAS DES functionality, but the vendors may assign different VSEC IDs.
>
> Search for the DWC RAS DES Capability using the VSEC ID and VSEC Rev
> chosen by the vendor.
>
> This does not fix a current problem because Alibaba, Ampere, and Qualcomm
> all assigned the same VSEC ID and VSEC Rev for the DWC RAS DES Capability.
>
> The potential issue is that we may add support for a device from another
> vendor, where the vendor has already assigned DWC_PCIE_VSEC_RAS_DES_ID
> (0x02) for an unrelated VSEC.  In that event, dwc_pcie_des_cap() would find
> the unrelated VSEC and mistakenly assume it was a DWC RAS DES Capability.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Hi Bjorn,

Thanks for the patch. It looks good to me. Also, I quickly tested it on 
AmpereOne and everything seemed to be working as expected.

Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> Sample devices that advertise VSEC Capabilities with VSEC ID=0x02 that are
> unrelated to the DWC RAS DES functionality:
>
>  https://community.nxp.com/t5/S32G/S32G3-PCIe-compliance-mode-set-speed-to-5-8Gbit-s/m-p/1875346#M7024
>    00:00.0 PCI bridge: Freescale Semiconductor Inc Device 4300 (prog-if 00 [Normal decode])
>      Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>      Capabilities: [158 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>
>  https://github.com/google-coral/edgetpu/issues/743
>    0000:00:00.0 PCI bridge: NVIDIA Corporation Device 1ad0 (rev a1) (prog-if 00 [Normal decode])
>      Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>      Capabilities: [1d0 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100
>
>  https://www.linuxquestions.org/questions/linux-kernel-70/differences-in-'lspci-v'-output-4175495550/
>    00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 13) (prog-if 00 [Normal decode])
>      Capabilities: [90] Express Root Port (Slot+), MSI 00
>      Capabilities: [160] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
>
>  https://www.reddit.com/r/linuxhardware/comments/187u87b/the_correct_way_to_identify_the_kernel_driver/
>    04:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device c852 (rev 01)
>      Capabilities: [70] Express Endpoint, MSI 00
>      Capabilities: [170] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
> ---
> drivers/perf/dwc_pcie_pmu.c | 68 ++++++++++++++++++++-----------------
> 1 file changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 9cbea9675e21..d022f498fa1a 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -20,7 +20,6 @@
> #include <linux/sysfs.h>
> #include <linux/types.h>
>
> -#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
> #define DWC_PCIE_EVENT_CNT_CTL			0x8
>
> /*
> @@ -100,14 +99,23 @@ struct dwc_pcie_dev_info {
> 	struct list_head dev_node;
> };
>
> -struct dwc_pcie_vendor_id {
> -	int vendor_id;
> +struct dwc_pcie_pmu_vsec_id {
> +	u16 vendor_id;
> +	u16 vsec_id;
> +	u8 vsec_rev;
> };
>
> -static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
> -	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
> -	{.vendor_id = PCI_VENDOR_ID_AMPERE },
> -	{.vendor_id = PCI_VENDOR_ID_QCOM },
> +/*
> + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> + */
> +static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> +	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> 	{} /* terminator */
> };
>
> @@ -519,31 +527,28 @@ static void dwc_pcie_unregister_pmu(void *data)
> 	perf_pmu_unregister(&pcie_pmu->pmu);
> }
>
> -static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
> +static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
> {
> -	const struct dwc_pcie_vendor_id *vid;
> -	u16 vsec = 0;
> +	const struct dwc_pcie_pmu_vsec_id *vid;
> +	u16 vsec;
> 	u32 val;
>
> 	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> -		return false;
> +		return 0;
>
> -	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
> +	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {
> 		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
> -						DWC_PCIE_VSEC_RAS_DES_ID);
> -		if (vsec)
> -			break;
> +						vid->vsec_id);
> +		if (vsec) {
> +			pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER,
> +					      &val);
> +			if (PCI_VNDR_HEADER_REV(val) == vid->vsec_rev) {
> +				pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> +				return vsec;
> +			}
> +		}
> 	}
> -	if (!vsec)
> -		return false;
> -
> -	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> -	if (PCI_VNDR_HEADER_REV(val) != 0x04)
> -		return false;
> -
> -	pci_dbg(pdev,
> -		"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> -	return true;
> +	return 0;
> }
>
> static void dwc_pcie_unregister_dev(struct dwc_pcie_dev_info *dev_info)
> @@ -587,7 +592,7 @@ static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
>
> 	switch (action) {
> 	case BUS_NOTIFY_ADD_DEVICE:
> -		if (!dwc_pcie_match_des_cap(pdev))
> +		if (!dwc_pcie_des_cap(pdev))
> 			return NOTIFY_DONE;
> 		if (dwc_pcie_register_dev(pdev))
> 			return NOTIFY_BAD;
> @@ -612,13 +617,14 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> 	struct pci_dev *pdev = plat_dev->dev.platform_data;
> 	struct dwc_pcie_pmu *pcie_pmu;
> 	char *name;
> -	u32 sbdf, val;
> +	u32 sbdf;
> 	u16 vsec;
> 	int ret;
>
> -	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
> -					DWC_PCIE_VSEC_RAS_DES_ID);
> -	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	vsec = dwc_pcie_des_cap(pdev);
> +	if (!vsec)
> +		return -ENODEV;
> +
> 	sbdf = plat_dev->id;
> 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
> 	if (!name)
> @@ -730,7 +736,7 @@ static int __init dwc_pcie_pmu_init(void)
> 	int ret;
>
> 	for_each_pci_dev(pdev) {
> -		if (!dwc_pcie_match_des_cap(pdev))
> +		if (!dwc_pcie_des_cap(pdev))
> 			continue;
>
> 		ret = dwc_pcie_register_dev(pdev);
> -- 
> 2.34.1
>
>

