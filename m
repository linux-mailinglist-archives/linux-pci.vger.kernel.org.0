Return-Path: <linux-pci+bounces-36057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93408B557F3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 22:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AD25A63F2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E22D47E0;
	Fri, 12 Sep 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NUu+2uQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD02D47EE;
	Fri, 12 Sep 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710273; cv=fail; b=CgrGMIx60j80lSIeH+qTy7cRHXbwBSpDbz1Q3D5UKxKpuY8JHVZk296dzoDF492JVRbWS277/phl/98E5J8zmXzsJcHtZAbCiq7RtHLdGJniUJLJLT2VqC7gF3+3nAv0gAW+5XwnKndKpm7MaPL7oqnb1zsAIOaemH80AiOPBxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710273; c=relaxed/simple;
	bh=8USdbRfeaPRVauA4RK4oJXktUsYjypncrab88zbHqLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NRHInmfZ7rljDdcef5j5eTZFsbFtfzwcrJPsedJ+DEgHofzwFO/Qj+yVZf0yKd0jEWGFHBaJ3KmGKutO8Yz8JP5hgRm1JRSsppwah37FEAVN4gMf/bWqqCEfx/ErXxShgg/AVQ2qp7xoRgUVt6F/OC5gm01NIqT41yK4/WULqhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NUu+2uQJ; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vol3kBuS9W2bHOKjIlJcanmzex49q5eAETetple+5nYiws21T4S3VSADH0JhH7DAWRCm1011q/EpolaqkLtXw3pptgDo22SEDcmmYnHNpRo0F/8PMbJ+9Zbxsxyg9tIRNYGS8aRwtoK99MBVUmXmTTS/wbVflkhh3tPXAqdRhuim51JkbSnfvt6HXgyDZ2CKprBwduJxdw108oYY/pv9C/jqth+ui/aILlizSRQBMcUkryi/JZRssFJlEWTI9aRLb2GzY31wwuU3+6s78jsI9JN7p6tX15PwT2c+uSDMSRD3JSe9k1GCLPlZhx0juDYUIhS9H94/EmDDU/85Csihyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNvYcQU4Rrh9XvR0pVgybEpFlIPzZAgj+1ZiG16xUT0=;
 b=l/+exOCvbHVMTazeEHL8hxJo/oB3gTSh3AByrk7Z/YintrZgboaZtW3gkcEFR0vErNh4bperSjV1GkZzmeDtJHf92ooqpb/lU386AyxP9ff9gSUO60mAZXXEWmgGSl0nbeGnNdQvZEV6wTiv1n8BlGCJuGoe20UHqACFsE/n0nURmYKFFnWYcr/qAqzkjpM7i4Sg1eJ8uugavpwwciQN/kJ9KB+AZOUGS5nNlybMFDNGMBR1pKCqKeqpu1cJWr+g8cFhBvBiJrTAxklS+gGyqva3sCIme9C7PUW8KHoyTKXd50oBmk2/2/4R7zrjjew73h7VVesFk1TDeeBB1AZeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNvYcQU4Rrh9XvR0pVgybEpFlIPzZAgj+1ZiG16xUT0=;
 b=NUu+2uQJmn68bhPEx+F7QyPzyOkdIsleRYjPNLnAgBAGbJOrtfF/PyuFdbrkonoNoFd5D0WppjbfaqxVHKEZRSfIt2fW3WtLhCiI4ppkcXuxWvEbJd1jsNw/rmqcXM1Mwv9c8MwUx++m+nffVqtIWCyNcGHmpMR+kgl8yLuufpDZ8ms+ZEYSIOP/ewm5oUhvqYrpP7aST/XXSqj8bDCyoNyMpk8+6nYi//2jHMOjNpfvlW9Em5AeZr9AsVvInVqDRDyt9bp6GINCKNCRBGVRehxlutuydr10xL6QD6fqnNTyh1VN0EXXFKr7z/qM5Kd4RDj6XE3w0/0f8ozueQJg4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11566.eurprd04.prod.outlook.com (2603:10a6:150:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 20:51:07 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 20:51:07 +0000
Date: Fri, 12 Sep 2025 16:50:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <aMSHsoLHGUBoWX8e@lizhi-Precision-Tower-5810>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-2-vincent.guittot@linaro.org>
X-ClientProxiedBy: PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11566:EE_
X-MS-Office365-Filtering-Correlation-Id: c313ab61-647e-4a8e-59c2-08ddf23e187b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2nUQR5ecWBAF1GfyWBS5jdbPIxLHMNjsn3Ydm8ihkRgI4l4wcPyewoMZrDHm?=
 =?us-ascii?Q?UDgYZVRyTc64WGGI4u3ABTv85XLB7QDCSljz5auL+9OP88peI/HNivaVdENp?=
 =?us-ascii?Q?b+fEQNkEgrqrR6Rp6Hr7NVdznb40n4aB4ITpK87y/gYWf0xRVxlR0EtniTlh?=
 =?us-ascii?Q?T+VC1hZclc7au+UdwqyQFX71lvjlWyTaI9ueHkkjTBOOl0+pGdHz0nBcKFMi?=
 =?us-ascii?Q?uN+l+5OO75AoCjzEUpAoEM4AY3wNJ9+LEFgY0dULmzWVF9NNAJfs6sqKSVcu?=
 =?us-ascii?Q?GWbmdRh4+X8T2Qr/yaIjJdYJVBvv0avrZZt1DK0osKUQV5cF91hX3nQRgPmy?=
 =?us-ascii?Q?QSmZt6Ueono2eYLfRip6sLsntiqQSuRELS4+OFQKVH/cQgCVbNU5C3lUB5z+?=
 =?us-ascii?Q?3+srzdfxCLklpck70ycmkKfl302H5YGrFEIMWgPQEEcfp3Hgh81pHQUEK8uM?=
 =?us-ascii?Q?SNsuh1YNAhGLOMWkcS4cbLuThSgduVZVt3kip0NZ2oztWQYrCGMJForrlpkS?=
 =?us-ascii?Q?q8Zpd31VXDfkgPBdiftibc9mAk2lWeKGd3T/Y0WIXeH7k3ZgzL08bvViGhHl?=
 =?us-ascii?Q?yob0fLYijGo3BthAoxFBvorL4ZoCsvEKMo1r2pl6j5U4oc3HLgo5vFznB97C?=
 =?us-ascii?Q?keKirecKyWTnZ76Q2lja6qTnGleAfRPpmpV2JKG15KpBm23wOHKAh/GGg38q?=
 =?us-ascii?Q?vf//evAH0AqK3kFjiLmLGyYtLTzZbElQNjIfgAosfXb8aHJqMypinkljYJVY?=
 =?us-ascii?Q?JAqlHwsNzfZXb4C11g6Ibjmt6EJm3s37OEAKszSI2gLcKfKHNRY8FTSJYlKl?=
 =?us-ascii?Q?mPk+RmhGHzqzviFVfAdK+YTWgTm87N1ctGkrBmH0t3LJJ04Qqfn44oPIUQOL?=
 =?us-ascii?Q?IXzxmElwsWkfeQvXvESNzuQpHdCZ7ng+GTWyu5/IZRAMkOZkgC8eQcO4wOxw?=
 =?us-ascii?Q?JDQsoATtcSMc+WbW1mpqCCizN2SPQ9NpxjTrH4zPnS4flOo/r65K/RRyTqQE?=
 =?us-ascii?Q?NJT6Rthqlduay0D9fylN0KF26mLIxinpLnI53qhUsyNN1JUZKDDTL9J71IiZ?=
 =?us-ascii?Q?HXikbfrtVr+ip7K6ZV7T2dwj8M8BHMl4Eqb8f3bEam4R75Wcq+SLciBnlm+O?=
 =?us-ascii?Q?k0bU3NxzWOEvJNHJVTzBtYSYhHjfrTJLuRPm62fFUsOJvGouspZSYLZ38W5G?=
 =?us-ascii?Q?sTfHdsUztoDj2sUWAVRbgyvcvO7kDymsFjxihkfdhaEHIlU/0hFCdKx1vzx9?=
 =?us-ascii?Q?dTORfbmJSAX4RMqMnVw6fftL5DNgcrJzVChd+7DExpRYQTGPa4roTvuM4/9q?=
 =?us-ascii?Q?+LlXYkIWQmwXhZctvsnsQMsg1+pwfzX5Obqp8rhGZKLlVBaGYKbLRhjsphlB?=
 =?us-ascii?Q?x7XhO0wRV7zIhuB5GFLpvYK0lGPX2sdyzIAa15Sb0noMXlasXt0wXQnKVO0r?=
 =?us-ascii?Q?R+FYE0GdBuNN4Bl872XoucUFlNfEbkKv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEHOQluIje1TZETSf6H1Of5Nd44XqLFPWjWCwFbv96BkGVEMKNWfA4D5p1LZ?=
 =?us-ascii?Q?jS1dwtBfulo2lJNzzab1J1FSpsoIAvKnP/xqjuxIJyBLUZdiGvnfZAhPanqB?=
 =?us-ascii?Q?5IPQzgkJuHckAQdQ6/mlFfLxxHPQPKTrnE0BgARgNBxn8lmQ5gDASkLKAj+V?=
 =?us-ascii?Q?R+p1MW1V7tpcRIn3OAnhiYDMIoPgZ0inuThZuUSrT/PKQK8zfFMPcwqotwYG?=
 =?us-ascii?Q?ZhJNiKPIT1q85MrrANOAGjL1WjrSwJ02mXpAE3BRTOLkOoaCd32eVE4myN3k?=
 =?us-ascii?Q?1k9VLuaubr6zUXsL9vklkIrWYttIeG8w50cd1uA72hc5T69P6IvidmScZ90m?=
 =?us-ascii?Q?x+nplkKdHJ+fd2Q+Vn3CIP5BiObZQnnlUtIhTffoFR512yTZXHPzWPwZ3xxb?=
 =?us-ascii?Q?m7u6W8vzPlpl93+fv8X2e2TFdwoIpe4hwRF77ZqFk2gXET9kJ1nj8bN6MTvJ?=
 =?us-ascii?Q?I+QlcRYXQe13H3lSl5jWUWOZ/9AQFFgpUlYVFLqhgSI2v4m/v1y1z22L3arH?=
 =?us-ascii?Q?luwIAZcU+3GwmqIUALYRP2cv6UaW83ZBooiKp2DwZ7aoV1BPwtmZdz1Z6tzb?=
 =?us-ascii?Q?j8GjamJ+z1twq3XqCBaedFGNeQVeAD1z6vEztW7nVR1WjdUCtKY71hctcSgf?=
 =?us-ascii?Q?vvHIlfL12lLtOdC6H1rvHKlM20tCT6fEwqphQhGjxpetq2PudxGZfHmqk51M?=
 =?us-ascii?Q?c4Ws8b68OqP/TIxHDSdsUSzOGItEGbydjo54qjPIoswp08qvQr9AC0UPuy3s?=
 =?us-ascii?Q?WPxocNslSSGvYCZMbh8XkYjg3U3UNyhHwoBB2qCG8v2WnrJdTKEMxnxtvMLB?=
 =?us-ascii?Q?+q8LZMn0y/KlF1Yh9HnbK97M2tfyYbpqj7ApznRRLoI5WbQKBjSa8Ps8fgqK?=
 =?us-ascii?Q?9CKHmyBqLyPZY4P4LNAhcKiQz46s+xOVOMNmT7Nd+9csMXe3oc5tQDEsEQ70?=
 =?us-ascii?Q?k2oQHV0RpOYtSbRftCkwiBhmblMeaMAUi0UOr9QxuhkJS/geEvGJFMldj2GA?=
 =?us-ascii?Q?JKZ+lkR54dq1eC0sLcGMCoqmDa0ZWGPTH7bvYANQ8et6Qh5cvLsezhK3sjHV?=
 =?us-ascii?Q?BaOJO9FB+xG7l2wV7YMn2y0SPz44jzAjc3X+8tmGG0/2wA0XbaPnStHM+gPu?=
 =?us-ascii?Q?hzZdN5vvDFjNjzmFMEzlcGqzKrmXqDQfg8I/L5f61BBr4GGyq5fJQvr9C0mz?=
 =?us-ascii?Q?PFPXhz1sZWj40z7XkuTvyM5KJwEBvukFmQUYplwH89V/MdShWV9DAHCJPFRa?=
 =?us-ascii?Q?o/GGS8NIVeH2gdAJMFETMpwZt8ep4G/RLXKWufBlpjb++y1W9kfwWkwUhqcX?=
 =?us-ascii?Q?pn6GdOVJm2MLP/bPXhmMk8Zh5u5NrGPfA7ddHScqsUC9zUwXgX7WS/pQVS2t?=
 =?us-ascii?Q?TKhyBt0L0fkySK2Ziq9SCfYp6mciNnpZygIxOA6DwMS9C0BvnXG35yG5oLBE?=
 =?us-ascii?Q?/Oo2oqLbDVXyprWFv6zr9ESl0qmAPIEqP1jBPHon6WaWyF3wfjwXg5+sc2pc?=
 =?us-ascii?Q?7Jnr/YDb6NuC9nzPRbrZEgDGlS/6coF4/E+ugtvUrqTQ0BwIj2tGxjsRc/NQ?=
 =?us-ascii?Q?egurnacREKsKHcdeUFfFtYsnv3L1sfEpKNNFCTE5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c313ab61-647e-4a8e-59c2-08ddf23e187b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 20:51:07.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCXrkm0WikpK/Gyk4nJkq72a8JS4sb1kgZWqybOWjNa8SeBB6Qe9dlgjGV70bUh1My478Tipx4oikBMKCQuc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11566

On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> Describe the PCIe controller available on the S32G platforms.

can you cc imx@lists.linux.dev next time? suppose most part is similar with
imx and layerscape chips.

>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> new file mode 100644
> index 000000000000..287596d7162d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xx/S32G3xx PCIe controller
> +
> +maintainers:
> +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> +
> +description:
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> +  The S32G SoC family has two PCIe controllers, which can be configured as
> +  either Root Complex or End Point.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
> +      - items:
> +          - const: nxp,s32g3-pcie
> +          - const: nxp,s32g2-pcie
> +
> +  reg:
> +    minItems: 7

If minItems is the same maxItems, needn't minItems.

> +    maxItems: 7
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: ctrl
> +      - const: config
> +      - const: addr_space
> +
> +  interrupts:
> +    minItems: 8
> +    maxItems: 8
> +
> +  interrupt-names:
> +    items:
> +      - const: link_req_stat
> +      - const: dma
> +      - const: msi
> +      - const: phy_link_down
> +      - const: phy_link_up
> +      - const: misc
> +      - const: pcs
> +      - const: tlp_req_no_comp

use - for names

> +
> +  msi-parent:
> +    description:
> +      Use this option to reference the GIC controller node which will
> +      handle the MSIs. This property can be used only in Root Complex mode.
> +      The msi-parent node must be declared as "msi-controller" and the list of
> +      available SPIs that can be used must be declared using "mbi-ranges".
> +      If "msi-parent" is not present in the PCIe node, MSIs will be handled
> +      by iMSI-RX -Integrated MSI Receiver [AXI Bridge]-, an integrated
> +      MSI reception module in the PCIe controller's AXI Bridge which
> +      detects and terminates inbound MSI requests (received on the RX wire).
> +      These MSIs no longer appear on the AXI bus, instead a hard-wired
> +      interrupt is raised, documented as "DSP AXI MSI Interrupt" in the SoC
> +      Reference Manual.

Don't need description for this common property.

msi-parent for pcie devices is most likely wrong. It should use msi-map.

> +
> +  nxp,phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Select PHY mode for PCIe controller
> +    enum:
> +      - crns  # Common Reference Clock, No Spread Spectrum
> +      - crss  # Common Reference Clock, Spread Spectrum
> +      - srns  # Separate reference Clock, No Spread Spectrum
> +      - sris  # Separate Reference Clock, Independent Spread Spectrum
> +
> +  max-link-speed:
> +    description:
> +      The max link speed is normaly Gen3, but can be enforced to a lower value
> +      in case of special limitations.

needn't description here.

> +    maximum: 3
> +
> +  num-lanes:
> +    description:
> +      Max bus width (1 or 2); it is the number of physical lanes

needn't description here.

> +    minimum: 1
> +    maximum: 2
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - ranges
> +  - nxp,phy-mode
> +  - num-lanes
> +  - phys
> +
> +additionalProperties: true

unevaluatedProperties: false

because you refs to /schemas/pci/snps,dw-pcie-common.yaml

You can send to me do internal review before you post to upstream.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0: pcie@40400000 {

Needn't label "pcie0"

> +            compatible = "nxp,s32g3-pcie",
> +                         "nxp,s32g2-pcie";
> +            dma-coherent;
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> +                   * at the end of the outbound memory map
> +                   */
> +                  <0x5f 0xffffe000 0x0 0x00002000>,
> +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> +                              "config", "addr_space";
> +                  #address-cells = <3>;
> +                  #size-cells = <2>;
> +                  device_type = "pci";
> +                  ranges =
> +                  /* downstream I/O, 64KB and aligned naturally just
> +                   * before the config space to minimize fragmentation
> +                   */
> +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +                  /* non-prefetchable memory, with best case size and
> +                  * alignment
> +                   */
> +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> +
> +                  nxp,phy-mode = "crns";
> +                  bus-range = <0x0 0xff>;
> +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +                  interrupt-names = "link_req_stat", "dma", "msi",
> +                                    "phy_link_down", "phy_link_up", "misc",
> +                                    "pcs", "tlp_req_no_comp";
> +                  #interrupt-cells = <1>;
> +                  interrupt-map-mask = <0 0 0 0x7>;
> +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> +                                  <0 0 0 4 &gic 0 0 0 131 4>;

use pre define macro

<0 0 0 1 &gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,

> +                  msi-parent = <&gic>;

Suppose it is wrong for pcie

you should use msi-map

Frank
> +
> +                  num-lanes = <2>;
> +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> +        };
> +    };
> --
> 2.43.0
>

