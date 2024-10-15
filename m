Return-Path: <linux-pci+bounces-14553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E499F19B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BC32813E9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5961DD0E2;
	Tue, 15 Oct 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YbWWujPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC91DD0E6;
	Tue, 15 Oct 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006860; cv=fail; b=JNM5MDA6Al89l+xtwzwJkWFkCLyM9RGRVKuY3iOH27vIkJ6ZdU8FvmWMmYmyGVshPHgHz8/AXbuF5pYcJ9qlEiL0zQJFpnNRXXtjSpxUyA8OdzETMNxQUNjsKohIrQgk2N/Pw5CY2Yq1oLqfn5Q0LAWnQJr+uUNOW8ngSIVgd6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006860; c=relaxed/simple;
	bh=lEtoWVdvwNxZLX4oxyjhj/hK/nWjmGRluYUqFJD2rtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dArTAgkNj7LpBz8yxsFnW/AiymU9Oa4uambP2b87dwFDEv/jE1va8yN9VJRMM3yhIXBLA2taD9v3IxH9pc3qK3JEE1a7rrQsgOFMGHAwGTxPN7ielTBzDDOeq8fyMF6MsvRHF+C+b0r/Rw7p0qYOzeVrwyksHzOzqvtUU/9Qd5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YbWWujPV; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta30dHf+F0LLiKN2/iyL4lg12iLw/zOpzqyTRmLEy0aR/XWEe672ZQYTiJRXFRDZt7hD1xqyKjtXBtRwnL6VUM9O/hB1vORKQekz3aWb9KomMFDpwaU50r5zLgEF6trDQPQBORY9dCvQoAqnGgshUl83r0KatAd/tOiHZJm12n3v0JSvYj6L+Qf+HavTJw6HREVzCNc/4R1UUWloliHdTvZXxPsCQBhVYUJiMzyWw6T7EXkWHqeDV6JKY+HPXbB2vIe06aN50ZxRatXWF0PHUWWy3RUnkxjRBNkoZHsfNg5zGiQdhyXmN3Ga+r2EBiaCYgJubkqTt/U8JN6DLYaoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5Sx9DGOCgojvRmCrtucwdcYt6z+GwrlbDP7KXvjq+I=;
 b=laKHcIym0Lu6Q6qqp8moVH0Cu7zbIHfhjve01eBghPmpduXZCPp9i9UwfWOwaFvcR9AoXwbnQY6OrineUboUO9iyV5wBhPIADeA3FQDHxkUpaWYf8PRzEPrQPGLhJNx9L6fnyCLGXzd/dlTTpVV55u+sOVIzx3UZomFPxrGF7X2bI9AwGtN8ROZV/o6o2ETuqGItirOW4CCJ+2ZaSNjxWn8Og4ecdmI5IptnilvoKDZhoYBeinBJm/CysLaBR1E3OdQ2uk649RZgzRhuj1qyxnuCnPmOIIqN+vtkw0fOjscwj1dvQ620/6Sz0oS7ebKlFp+Hvqrbk+4sjc6+XMDcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Sx9DGOCgojvRmCrtucwdcYt6z+GwrlbDP7KXvjq+I=;
 b=YbWWujPV5cUQ4G65H8610pNnj8J6jXhM/4LALNRI4lyUxsUqoUkpwIPYM1/VcBAjoO3TpBu5kBx/eE5HI8acHpRP00awdmRk/fVuj+u5W8y40iMwSg9b0fDeLPvKFjPtL0UQ5msPlzIwpEuTYvSc6rqK04u85U5E9sENf1bU5ForgEkIbokDwbr5n6H4BvXrj7uQ8mH0f7bRZMiA5ISFmDauZ8hhrdpocghWhZHLbUGn6ygszbG6niSyJthxTD/7sk9NaolrwjutszNa8DgzLwqACQT6HJqCdhDNm0J1hLV5ocPvcAySkMBgbU/kHLbJ2jLhSqIFpFLAWDEA3LXIjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 15:40:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 15:40:55 +0000
Date: Tue, 15 Oct 2024 11:40:46 -0400
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
Subject: Re: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <Zw6M/rjt6e6iZ2zd@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-3-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f2b6ed-c278-4829-9f04-08dced2fc1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJ8mS5I/41yqJsILuEBKVX/Mv8A9Yy7UpM8Rsz1X6RJPcPYBUv7+DKujQKFL?=
 =?us-ascii?Q?SxUSI00KdkCgfbGZzx4io2sYktPRRK/zB/mWv2ai1i+oKbHNAzQZ7S7NfMaB?=
 =?us-ascii?Q?NDrUWIE6BC1AORJ/1dOGEUKjJUQszW0wbrs4MKCJjFMFjLw5Oy7ZE0t5RHmt?=
 =?us-ascii?Q?QQvgiVEX2CM5wzFXn5wX9TIMKZQcfSQLRzFeaN8EoRZHBu5E+kvGrJAD8D+W?=
 =?us-ascii?Q?5R5u6BP8v8wl7CQuSOmmkR2UbmJVrUaG8ggoN06n18EaFJbMUQPg7Jiw3kF9?=
 =?us-ascii?Q?5GHHeEfyoGh+53nD7l/a1Fjg5XEzKTKlDSsb/wGjrU5nJs9Z46i3ELPmxWL0?=
 =?us-ascii?Q?YoVxxXWSmQch90s6y+Cea6WchIjMC7QA0fWnDeF83t7LpW0pm4KF8lmJyyxs?=
 =?us-ascii?Q?tCYKIM4jcZInYhzFQEPCQUhyekPR8PdGC5yyE/ordgISgSPeqreVX25yGUGI?=
 =?us-ascii?Q?RxM6owvBKXLOuunXetvW3BUEJLYCuYMn2o92mgpNa77XngN3gwzVJyk6NjJ6?=
 =?us-ascii?Q?jYXllKbxiYjrxzCZB+WcxvMUneQAfgAy3Q/fGiCdP9UhQ2Ig6o5D5Z/Lktx6?=
 =?us-ascii?Q?mXjr3Myq+KcIry8H/eCGWPLbdaZV/6GhJj1SCrlnBjcZxKKqZ1sCMMKpu5mf?=
 =?us-ascii?Q?JYx3yFV105s3um43zJzjH2E4MpKgzndTytjaqdpErS7Qlrwarm41Ztr4gnjN?=
 =?us-ascii?Q?MWBf3r7CYEGUEk4zrcU4tTKSil2L/+8CblSB/ePzp5RifvfmjTmVSa36KfJ8?=
 =?us-ascii?Q?AYo5xqkudaApw51G5elp0ElkMQcxX4aQI2iQ2yVb7LuHZYU12N6YUT20VKzS?=
 =?us-ascii?Q?WcwD/o5D08Tk0SyIOO2ECiCLWUD/kdRx4L/UTlYN/fkzkzs7tPtzOLM/t+0n?=
 =?us-ascii?Q?kxSZJ+KRFxbC8o+ZNrKMNtT5ajgo6LdWflZPUQfX/oxZLVO8yw+Ek45fNcD/?=
 =?us-ascii?Q?xHYlq1sMQV78wn2M+m1T3ttjPhE0a+ZuRtBySnnQn5B8PntO7EEfuP5iTJW2?=
 =?us-ascii?Q?oCx+qeJHYMcy9qogel4sij59FvRXpotU1SYqAPz/W6S48UjNPW7TpfHWtmrF?=
 =?us-ascii?Q?G5RP1yupUG1WRC2uGJPBm8hOez7t/gMuCZhsf+KiOH+chb2IScrEPEQUY9qV?=
 =?us-ascii?Q?ABCV6pg+Q2HKzohkUHev/6uesdubWAwtiAReIIDCQ8RaT41rOLpZtnL0LPk5?=
 =?us-ascii?Q?M5Mb41JhJk9uJUgLWxxGQhS/Dw8aj1wfFbr/H8HBd8Ik3i/cyUZff6nwVumU?=
 =?us-ascii?Q?BbiFs7u1Zkuj85NEJCvtazO2ecjwOLBKhSbxJCBz1rw0q6u1oRwTu9edW00S?=
 =?us-ascii?Q?xsX+lYshFxvvD95OylAn/e+zqC5awfU83SqzOxcVpJ3l2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POo2j9gRrvP5BMGRlXJ08RIdMOEEjWDzu9wKG5gPAZ5u9hVu7jHIb2DrQvmO?=
 =?us-ascii?Q?yuaoiUJFu034Uc2E6XrwLKykx9Ehs+ABhVQh/HstThGP/NvtaHjT72RssxVJ?=
 =?us-ascii?Q?cXkRwMMQeRXTTUfAEu4A+TYBBdAERKDfRf+ysZE5mz4u273mOSDbIncy3mU5?=
 =?us-ascii?Q?Mg6Pd5/RPvuWWhx7JNyyEpYxfxr7848t+WpxPLl2dP7itzdNBdATfAHSL18e?=
 =?us-ascii?Q?u4TP0eEALBzm0mylH9ZU4uZzBi7zxulnBD6sUwbEf1G0wJCUY3b2w1m27AEI?=
 =?us-ascii?Q?LB5Ugm1zUy39zcPsJ37mhiiGlqoqXEdDX0oXfpLKbLHF/MtL3UPdlv2q3tmX?=
 =?us-ascii?Q?1/feyQM09XgQu9Aq1LGDdPANVG9oLhIwOamlP9ozjti3KHsLT4iGBz4oRAD+?=
 =?us-ascii?Q?OffjQHxaE5V3/ECNU0ycHbVIVCQ70RgXM8ZqO/e4moBjO2FFq1ZNpL11BpHm?=
 =?us-ascii?Q?eG1ClAyp/oVAOVZQdLUSHR13zvnZ52pYvdXi3HZpcicaeZywGcJG+/gqgB0B?=
 =?us-ascii?Q?n9ELQEf9yOeVw+eGzT2U3P2kEXzNSJPPjfZ/FLIOv5YNWnZ/BZnpcfmGqkvL?=
 =?us-ascii?Q?MO16ZUTOB/Ckf7IhlBVuRbnUq5j+oOhvzDOGgk8NvuMWnBOFhMsRdrvBih3m?=
 =?us-ascii?Q?eFvUUbA4MXk45ftf9n2FgnTC0b52FLH9IUA7jCqdlxUxlEZxUjcL6AE0dn5v?=
 =?us-ascii?Q?b+gG9EmR0X2x3meeNMQRrDloztFN2sm8nVZagUD69OD0K5ESr4icrkwxWpaD?=
 =?us-ascii?Q?2vm1jKuclUCBNAmdOK7GGuW5R3W4nanwbbKHworoiwxY63SCaZ/3ScYa+bP6?=
 =?us-ascii?Q?nRtMFoOAXhTDGa04FYty1cyIQ/azOxZOzeByjiyYbMpX618fOVb53L6BW7GL?=
 =?us-ascii?Q?WiIzYT5QIDAAql9TRSVW2g4vYzL6gmW71I8xnwKScbzSvvAZDubVM3LYxOgy?=
 =?us-ascii?Q?waqbbhsIbm8U/sYkWafQSmiev2zYc9TxiKYok1atyUZZdOoXVGUKqIg53QLm?=
 =?us-ascii?Q?zvidHSWCpQIQkcsxQ1l8pzGjRmpMDaSHoNsZnkkR8JYKuYhKvA+KQqqiUawH?=
 =?us-ascii?Q?4AKDIfxKNIQVpjeHz0p4PRFWrJiL1QDXcMDttuOvkSJXBGy/JMl8mZcaPqC/?=
 =?us-ascii?Q?aKTQdDo7HoWqmRcSnunq9qdFcSciIPGgqqvoj2+1II83fXSlnKzdamlr+1E5?=
 =?us-ascii?Q?JpcziMUwxMxlKnlARdPgG6WfA9j9A+u3ne/Z9ttpuQdb7yQjzr5D50KAF4NF?=
 =?us-ascii?Q?fnxcrt6N/YEIwNX7CL/IUEsof2PNDCXetllm2Y8rgPE8o3nCqQhKH2Px1Yqk?=
 =?us-ascii?Q?V1JD+jC13hMWvN+KVI4zRYpGcP5/tV1hgTLO6xfGPdEsc2IAZFCUmnNN+Co9?=
 =?us-ascii?Q?RIxgyc7xOuwvn3s1CT7OIRDBRaosfHUGShBGjZ1tqwB2XBEboL8AvaMwZHn7?=
 =?us-ascii?Q?o5UA1b5bAmJJxvEihS+9DyxDees+fWODnRx9wCmut2rpuFsmCmPT7FTz9CXe?=
 =?us-ascii?Q?gq2I5dp9XeB2pbP6LreWpOjGWWWiHoY8QLrPzZZSl0Za90j/QYjmJZ7MjS0C?=
 =?us-ascii?Q?QG0MKY8Dwi5bnZ6aVv5XuiSj4WiwMNTVBXuWbB1Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f2b6ed-c278-4829-9f04-08dced2fc1f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:40:55.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eF269ghunLtt8kvr30rsEUSdRzXCS9sC8EHHbRIlw/r6jE3sSwLsudfWtJd1wimGcpYNFSRrMT+/TJ+9hW2iWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092

On Tue, Oct 15, 2024 at 08:58:30PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes: remove "nxp,imx95-enetc" compatible string.
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..409ac4c09f63 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,14 +20,25 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - pci1957,e100
> -      - const: fsl,enetc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,e100
> +          - const: fsl,enetc
> +      - items:
> +          - const: pci1131,e101
>
>    reg:
>      maxItems: 1
>
> +  clocks:
> +    items:
> +      - description: MAC transmit/receiver reference clock
> +
> +  clock-names:
> +    items:
> +      - const: enet_ref_clk
> +

Need use allOf to keep old restriction

allOf:
  - if
     ...
  - then:
      properties:
        clocks:
          minItems: 1
        clock-names:
          minItems: 1
  - else
      properties:
        clocks: false
        clock-names: false


>    mdio:
>      $ref: mdio.yaml
>      unevaluatedProperties: false
> --
> 2.34.1
>

