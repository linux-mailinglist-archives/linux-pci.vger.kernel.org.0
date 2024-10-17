Return-Path: <linux-pci+bounces-14808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E089A287E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96931F22B92
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E01DEFF6;
	Thu, 17 Oct 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="co0vJGKO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061951DE2DD;
	Thu, 17 Oct 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182204; cv=fail; b=UsnCc5mBKNSVqldo3qwHQZ0TOVNytMGbpXDBmBPc9B12Pr9nJXHK5Vs+c7Ag3ATM26YnoY5fPFOqxDvqDf+lLOo3U5u2qnEwiSsx441Qz9wvbA2g8ptIUt27r08Hmv92O6jaZvk/GfjZ+3JNYbfEK+lCe+WZcMexgYxpMLxlMAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182204; c=relaxed/simple;
	bh=BaW15bBUS3lIzKlhHRMdeGzlr5WcVQ1b5fsyPh4JaaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKR4oKgPgCpi9ZuYmVY9DBHPfpmSxkuwO+c7a7mqDAO+UuzWudmxxheyRWaOTQA9wOMRK3Ub4q2eVwpt1K6Y0Va5U5QMNfAsprkQcXYPSNb8PC+STPyjEx7l2hCaUEKCDwhPgJVYVI05AZvzrc2smMAHvNq4unT+JDPQOLEAH/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=co0vJGKO; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVdavAVOfQ1pn4+o25NG7DZA0Xe4GSwawMyBQSh2JDULtOr22F0G7vMcPIx3Ca4vaUqPVyCqqUvZlYIqx8fdt724QrduuQg5YAqqR0ICuHKBuMzuhQcb9LtBFprjyW8pv+YYFp4N40vWFdeMLk+79f+ndXo56pb+LlB3/UpZ72gn2vQVGguGSvf7AXas5LSGwrx5bQz1vgoEYw02noWkejEbVEn72+RK/jUfY0rEMRFb+0Q3ofJrC96YRXFqj9kkfLmHYQQsScYA0QX76rujVAOPa98W8DG8xJIW2bwZa7yvNEcGIIPs1y8O7y+JuIjLyX/4tQQRXDdBx8smwYtPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua9zTRDP7ycjMF7YsiM8GVTqJLA8bhkLno929VYtXrI=;
 b=Ua2eYn+Lz72xqvJHges5hd5LRnT4eJ3crydykxYuUVvOKaEZrBUaaj+oe1mPrHWlDNFPqMgP2rbbb/OdRFJafUgJMqjNIN3xWNOlVVXOvw5x5cl0LEkBDcVhfEosDF1Hs2PgqjVcFq3u7LE1qVKGTTdk85dOMjzzafycsBNiZ8GhnzZSwmwWnLC/feEIL9pF0XHIBeJ1vkGRWmlJxttOU/B5HE+JSkjWDRjkXu2i960EnpRy0HmPDdebfqe/c9ydkMkInOKPwJ7RQz3WWz1u/Ie72SUTctCmjlW173RXRNmMoKTU1aTwV4z+LidKydiTJchpryY+mimZ6wZ3yAeGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua9zTRDP7ycjMF7YsiM8GVTqJLA8bhkLno929VYtXrI=;
 b=co0vJGKOgbDvJYJaDOjv9/l4DvPtXfWc4xevuoD7jPSnFxzRq4JqdfbPWBdcYQiv3IsVAd1kQmCsp4eZBWEwP5b5WSUkOtITINbNrbEDCu+YZrgzL83zKPo6ykC7CEznXi/hxLBOyMVzxcp3BKoOq9jyAK8dYjb/04qH0o1euSxTfIV+Z6S6jF01tbN/dhe5uCFoMOm/mkS8bpsq9NtZ/hWACLKkcbKFQ/oZHK+zDxrOc07xll3GXdXnHQKjgdn5pUbJ45BuxGnT5b8ApBhH/u9aomPiXCHT5WPr0WuV3hIMtHsGjC9vaQv6kqnUlw/APh7Qq/GaNmm0ayx/8gbuMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:23:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:23:15 +0000
Date: Thu, 17 Oct 2024 12:23:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <ZxE56eMyN791RsgK@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-3-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: be808ee7-0203-4175-04ab-08dceec800c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pnc2uAyUVDLOCTe2RjvW4TUPBvH2KtWNTBVklD3xCUxlbnPlhA8jXTCSYsa?=
 =?us-ascii?Q?6OZ/mHXlMDJqAE8fDT8rAIC1w+DZ7gHE5HA1dW/9sSDhtavSRhueKtsJ3vrY?=
 =?us-ascii?Q?HMzx8QfbGKyk+BQKm4jzDtGECv6pOpEfnQTqu3PhGbuJeUfk+/2zaHsXYCzo?=
 =?us-ascii?Q?g6d0t+UtXKD2xUkw85nOAQ88aDjmt6rblj15v3p8oGsJTXDGfmo3QgyNtbTW?=
 =?us-ascii?Q?bZzgv6WP20nw+QDgQ5iVXb6bk7qnRU6Bj+i+93qdtFO3giQQX0p/lgVppmtA?=
 =?us-ascii?Q?ScYVOIAGylmDkJ3Z8WC1ovaTT2xHfffL1ivdcrgBE0fJ/Wv28QC35Ehmnqjl?=
 =?us-ascii?Q?GphWXnLMPY1TJWEtqs/JvRYPgc2i2j3cA0Yhe4oGYLVOd2+4trCP1zy8rjR2?=
 =?us-ascii?Q?BtbXzr/5hW0ukPIRudcb/kfca2L0o3xmzuC0t9yBefq2X9K8toyFyvgwcvXc?=
 =?us-ascii?Q?0fAjc8JzqMbGcaQ5d2vVHL31IADHV+N7DsPHAUnvGr8n6h/rrIBvFcthuxqw?=
 =?us-ascii?Q?A57yFiR6CeBay0avx4wIFc1lPirxSIzPosutKt6AHJ8vdOv1VT19MBjPg0+q?=
 =?us-ascii?Q?hd+EQgghNhS3d3CDAZdtwHaoryYa9dzV1bjui/VBJ4cmuAqgo09ZRvhuuLtP?=
 =?us-ascii?Q?RKhQGMt4mzgxYC/WVzA76KOTBx8hubr1O3VcgSzE+B9BohkNRM5JYFq9XVOW?=
 =?us-ascii?Q?rlgGGjvUXy8SpZw3SPCSvsB2np23fwqz0uQ47BzAepF0QVHoMM5RxOSi/9qS?=
 =?us-ascii?Q?pMiPygnsZFNBjELUjWIzao7GPCDNwnQewk9WMXzTvHtLLfbGajAWJtMM176J?=
 =?us-ascii?Q?hUvxwz5dGlajTQBlJekoTQCoFXLYkjLOJWL9n6+MqpNr1PRtPtPJ8FldaTF4?=
 =?us-ascii?Q?TnQ4VvpiS0wS1+s1S3mh6caOhP9zkWZ0AalwC1DIrE2ti9zm6MjENCtItiTe?=
 =?us-ascii?Q?uDPb3o+b9kLqanvCHU0dy29wmIUomXrgjDpu+ASPdl3KVl3fUusdAH97+erj?=
 =?us-ascii?Q?5tZLQFQsEDB7S6Ecmf3D5xNN/w1SLbLRdlNg8pgQAvs+sBdJIWjXp7m0IbWC?=
 =?us-ascii?Q?C/Z9SWHt6pvwHwRyHA3Ms5urtpfMNI8q4I6Ok80EBusmai8QhG58UfKDnI/C?=
 =?us-ascii?Q?WfnlT+SKfMUCW/U349OJ2EaSdFhrGlpF9ISjl8vQxtlLrFUQaJ6oIQaJKNQl?=
 =?us-ascii?Q?VevtEtiguRC/rn/xLsj6sayHPZovp/QR90lhegQ+pPdzsRKa55RM7xEFozQ9?=
 =?us-ascii?Q?Pw/Bck0RDx/Ld5EqutiWUI9yi1wfGxKCaQwuaonDiasZp1QYTFs2R8f7gt7q?=
 =?us-ascii?Q?R5fs9KTZxQrFW36XJlbIZ7heggRSH4v8afhGoqqDBPXHeU17AtdTotZEQfhk?=
 =?us-ascii?Q?YWQpiBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nE+i1XHWprJgVB3Sv58GgXyjs63uw1ZLDLnpEsKo5abOVGIBiC1/2uzKQld7?=
 =?us-ascii?Q?oYxdjp8YK26BCskBNlWHW8fOQBdP59/78AQfJwMLmu2/U8YHafyERlHIwFYl?=
 =?us-ascii?Q?X3zBuY7S1yE667nMgK57YLSbzd0975ORYeyDe3pMaWUs4EmFQBKOMmvkOiAo?=
 =?us-ascii?Q?x1r18FO/j3E6WfUpF+1ooBkp4yuukNMNssGE9r9btheudXhmazhWsc4isbSa?=
 =?us-ascii?Q?g6JXcoB1EfeKpqzgm2iZVw8HU73jjjKyYEVjWAnAT9HajDcBaCefVeh8Z/LE?=
 =?us-ascii?Q?IfeOQCd/tbibqDW3p2jWNd74zZW2vSTyeHqPUDFiKjsDSUH3duGXCz7vvmXU?=
 =?us-ascii?Q?jy2VSIJabPH6i9xIU9ROkn9I+1wPo3tQLf9YWLynYaA59iW8I6lQp6gQBTuQ?=
 =?us-ascii?Q?Ru5Y/JwtzuH9+17NMwCI93TyRG+96aVBXlTHG560YvumOKSc15IO67IdG2xv?=
 =?us-ascii?Q?evntP8GA3PYgemwLfFEfS/meGAR6x9qJSSYyn5nOnKpAh8Ha4Ek4sH0EFE4S?=
 =?us-ascii?Q?ijSkHbkjE6YDfEJOqtZQxTgjxd6FDKQyrqUpZBiJW29NRoKd9AIrE+aSLsj/?=
 =?us-ascii?Q?tCq6b/4iMxHiu8/RgX2sM6luuVjqf8j2CX1SZcy3bBuTeDeLgJ3Gt5zCkGIx?=
 =?us-ascii?Q?ojC3xuyv5L3mT8x2AfcJ6sBAK5w8UkL/3852YJ3I3ZYqoB5BLpMCK7vWp0+i?=
 =?us-ascii?Q?NnbQyiEA/mTxJVM2t123zONN6DUOkTuS34/bvs4pyIRGjed95JPHeQpenXiQ?=
 =?us-ascii?Q?AlWyGY0PgUlgfwjQCFTOI+2ckXRHI+JiFj5V7L+6B0FLYnBIk2bu18oBsOfm?=
 =?us-ascii?Q?+pty9fuQTQnDmlLcnXHajPuKeL4ScJzHpF94pq+LGLrVtRQvyegNEJRdGh5j?=
 =?us-ascii?Q?fSRiChawDHRyU7sDHfm9V88y+K+6wdz3AFsId2TZ3GHC53njO+eGGFTRPSGL?=
 =?us-ascii?Q?LFbx26lCAoEddWbPqXy8V57lRhg+vqL2c5CFbCXIdYcBg/T3gBnVtuI7Apv6?=
 =?us-ascii?Q?SP/d7+CEvt3FioIcc4FW1sD0WGQ4g0JYvmQtEPdp1gY6U8ChCCbfVnnRithV?=
 =?us-ascii?Q?3HvCJlgmunLngbkGfeYnAZEXfVGZXX9VNPpIC93QxqzxWPNjuW1TvmIT/66t?=
 =?us-ascii?Q?Li7T4BOr+Wr4FiHFJV0b9a4BS0nsZI89e7CtGJf8VnGI9mfmMqx8pfzVn8h9?=
 =?us-ascii?Q?IlHxm3Ia9U9YWkTsaVjxzmqvotBdQZSLfZBfLj2ulafzw9yHQ0qwiKW4DjAD?=
 =?us-ascii?Q?1vBB/6vIsyLER3e7Fkh1PG+Njnxf+QkQS9DNnaRZI2leHcT4dJ/LTU/gzT1N?=
 =?us-ascii?Q?AqahbKDNHeb19Uu5ujHE6BCC0tpkWItXHJvIMQxPhJGN2hM6s5WEyOWg05CK?=
 =?us-ascii?Q?wc5vyGxLh7HZjwdjCTmCkyl5v6xOIu1t4MYqrbUwvFKh2InOPZuS7GUZKIgG?=
 =?us-ascii?Q?Q+DFbdDaTGe7uqbu4rCaQEZ68Bt8JgFp5BNoAhPF5qV/77Xtc9icF40gl6xY?=
 =?us-ascii?Q?dDhfGor6Vmme1P4JBpzbb6+1qnoTXPKss6ZsRB+bXXbMzHaQAQhF2seI9LE+?=
 =?us-ascii?Q?ZpBt3MDyzl9WN8b6mwwXHkgnCtNhTb65ItHncwM0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be808ee7-0203-4175-04ab-08dceec800c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:23:15.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMUxxVft71Y3ha9ktdpVKvLUPRvi39Sflr5HwRhVGoqvTbiXtsL/u5lkqfNPgc5iWRoiOleWdO526P1ztUAsTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815

On Thu, Oct 17, 2024 at 03:46:26PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2: Remove "nxp,imx95-enetc" compatible string.
> v3:
> 1. Add restriction to "clcoks" and "clock-names" properties and rename
> the clock, also remove the items from these two properties.
> 2. Remove unnecessary items for "pci1131,e101" compatible string.
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..e418c3e6e6b1 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,10 +20,13 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,e100
> +          - const: fsl,enetc
>        - enum:
> -          - pci1957,e100
> -      - const: fsl,enetc
> +          - pci1131,e101
>
>    reg:
>      maxItems: 1
> @@ -40,6 +43,19 @@ required:
>  allOf:
>    - $ref: /schemas/pci/pci-device.yaml
>    - $ref: ethernet-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - pci1131,e101
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +          description: MAC transmit/receiver reference clock
> +        clock-names:
> +          const: ref

Did you run CHECK_DTBS for your dts file? clocks\clock-names should be
under top 'properties" firstly. Then use 'if' restrict it. But I am not
sure for that. only dt_binding_check is not enough because your example
have not use clocks and clok-names.

Frank

>
>  unevaluatedProperties: false
>
> --
> 2.34.1
>

