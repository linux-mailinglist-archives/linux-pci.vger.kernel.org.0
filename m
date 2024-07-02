Return-Path: <linux-pci+bounces-9599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D3924406
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54301288639
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0214C1BD51B;
	Tue,  2 Jul 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZwlrFSk8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2790846D;
	Tue,  2 Jul 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939656; cv=fail; b=H1nmgb97hAOY+lMy2ky3YYxpauHq5bnqAHHF7rpTOwOg5GHnV89YLZ87/5Tr1yHERSqY94uHb6GlTuWgIylZWlnPxF4iKze5kB8zBcb646QSFGhaOS+b0ov8V4fz3U1KrrqUjhiNPKNrrs6W92IQzUc4R+MxBKM0BDU+wqSq+VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939656; c=relaxed/simple;
	bh=r9ygmJGrWHQ482i3lEhQGIggfPj1tIcnUGxhUk/yvCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RbdXegVvCFOjtY3Q8KhIzINkCUF1VgXjPD8C1Bm15yKvPGV8fBRJiqYMIwQGXEl/dHnc7Wn+x4awWBZWuPi+VhW6QGrgeXcZBB544I6sfyotOBr6pUfqIHf2obI0f34u660BwnAvw3a9pzBRbza0F8kGqYFUO9CQZFaI74nkaik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZwlrFSk8; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3pJju1tlqKn5ayp+aRjzu5bdLC5n1dID17Mdi5PNDCfged1Hr/f8qVIQc54qRFFYQWQtKMgLcxsmk8QOzs4bzV80Rvcl5QXo9EF6PNfk4xKiP19g4Lw7cryhzpVVlq6wk674HTD5cSVswZBZyanBTadq0ritXiBxSyRrIRVxvb2IMO0CPGzs5htTkINbk02zGTReX0wx5VY2VjGb7hKPQb1ksnr6yxFiIMALQM9i+y5eDfHgj42r3xzKZQkAi8FZzpUBTnX4Q7qmGeBiXXDs//hkG8YlZFW9K6LK0QLD7jmrnz7hTQXGDzrev0q2NG+HSa2L3fL/uHc1mQvXntJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzODdJS6wByZVmL73fxC3eFL4oOkuBeHwInDQV3cXEY=;
 b=BJzM5JP4952/VaLt2pLR+hemSlT7e1amhfKrb8feJDBKJXhW4ReI7MOJlmRRIgd8bMav9XLBKDSs/kSzQnriVaV21idm/UXWfBPL0kL5wIQZeeMx6DGVm+PSUNx31VJht2eQdLEelGQRjnrhTVeyaqiXFbCW8E2oYqftIWySrlRLd0uepSNhqOzRWAwX0diL/YRH+cVFic+1rIaKv+kKqSlRJmeAyF4mv5WhuJU1fKnLaCE0EbJhK3W37GX20VXdx6scrSMfCQ6dHnqJGR7o+O0CepmylijY0bmHCVraXe26ARme21d8cUecH4SpNUtq7qlbPHp6u7NSCrU9BZbyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzODdJS6wByZVmL73fxC3eFL4oOkuBeHwInDQV3cXEY=;
 b=ZwlrFSk8DFdz9Un/FA2mpgpIT2DNr+FinAzYYe9ZDFAUtB5e4lJYZSdWWoB0xZ4FH1cTRypg9O1e3W0tfTlRe+sgloVSHI4H9I5RdPaZYLOFUPULXR00kP/DR0QzjPIoAzHERx4Kltypo1ZIV/2qgNwG7Wjtg1hvJyWGlnjTUUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10034.eurprd04.prod.outlook.com (2603:10a6:10:4c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 17:00:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 17:00:52 +0000
Date: Tue, 2 Jul 2024 13:00:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: PCI: host-generic-pci: Increase
 maxItems to 8 of ranges
Message-ID: <ZoQyO2Ycl7pVDAYV@lizhi-Precision-Tower-5810>
References: <20240702153702.3827386-1-Frank.Li@nxp.com>
 <20240702164350.GA24498@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702164350.GA24498@bhelgaas>
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3157e1bd-8c24-4aec-a079-08dc9ab887b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uRzID06sOsSmRcKCreV7G9HA0tow1+Go1CmbGHpV+1W002yGOXdtsHKL9H2?=
 =?us-ascii?Q?kdOmonQBEIuAHqMyLoWdkrzqFVMBkCy9vKhva5LlkPv6cyglqL8jlpKn4NdX?=
 =?us-ascii?Q?wShyFCLybEA+4ut/0OLAKCuN6SQLVUTffaoiWL2hWOV9Y/1lGeso9siJkmGd?=
 =?us-ascii?Q?CNLbCljXN0lpIdF51uqHJe8/CADePWtE8YThrKHOTlWKS2H8le3ZOdx7oHPX?=
 =?us-ascii?Q?a7c8wIuO7tV5pXSVkAzyIye5P5DMANp23qiqarJOYv2xjxol7Zknr9i12f82?=
 =?us-ascii?Q?d6P6GZsYuC+N7Qg0WTa+ykv1TABWT+znB0kf6G02lvMnx2+Cu/V8eJSH1p2N?=
 =?us-ascii?Q?MCiTcATvf2cPlIYcdRgewgdR6BpsiENsKaH9ykrCWXBVJ/D9c8sdW1GMXacd?=
 =?us-ascii?Q?xyOhxsc3AK0p7Zc5aNVy1HgIbNlbnYsESL61Kjv2eJgOEnD86ExhpwKKLR8K?=
 =?us-ascii?Q?Y6cOcfP6rBKB1LLkbqRePA+BM4frdF3zvVcFD8dg3WZMJkhCtf2RkrYNC7wD?=
 =?us-ascii?Q?9kgk06Y/xrswCxMJISQZkTbWPeNHFu75tXMi7gv3Yy+FXcWUa6dXMT9s3MF3?=
 =?us-ascii?Q?G+dvw40GMjYgP82kp5Lh8Dy18G7Kj0x9i7WNa9sbmNkJTALrOhPlPWD3nB+6?=
 =?us-ascii?Q?67ZtNtG48SRUvVuMUVh9oIszQ4DHQfzMaq7rfEabuDHeaN13Q3oarngCurgN?=
 =?us-ascii?Q?hlrnq+nLPRj1dPxqc5jVJ4epMDmxNNym+LeZGgShGJG/FPyVforWaNtHa3VL?=
 =?us-ascii?Q?ZsMENL2qh+tMIQg5SL4O3lOwINuDaq1oFT15OH0XYs+bHvDvzRxqpbGym96w?=
 =?us-ascii?Q?DSrArs3WttqSXQfoNW1AtqW3jkCwFiJSZfJQuY+wkg7b5XlvD+F3acquJWAQ?=
 =?us-ascii?Q?WLnLKfjUznqetWIqWsqzfUL2mBDd0Gv0+4igxOkxdYARHzafjep1PhkjM5qZ?=
 =?us-ascii?Q?vbm7Vva+uY2TPDGwxb96ZM4/cXoekVKbWxEXHfO463VK2SH6iGxDolYgD/BY?=
 =?us-ascii?Q?VyuaSwa412WQL93z0sIN7JBVRGnac/+2ZwqNrOr0NAxpgUuLLrb6JhwiXOAW?=
 =?us-ascii?Q?BYgMgEYbdOx/Lnvp5XMzRYwZ8rqhE9pxhf8xKwl5Exw97/6Zndmh8VtYsl8A?=
 =?us-ascii?Q?Xabtz1orLiExacHc8vHvH9Vzab1QH7hUkyELWNc/dRUrH+BlpaOC/5sRbmCp?=
 =?us-ascii?Q?yyNJZLlrDuoOrg6VABMFOgEBBJIz7PfUQV6dIA0OxeJrW766Y+TlLkImZAYZ?=
 =?us-ascii?Q?bcorFBYIgu+8/eo/WigMEz7858DX+cmcxo4p0HJXNhf1WvOAUyy05g5OjW4j?=
 =?us-ascii?Q?9FCQ+sfwKJeVVNKgQHfT3wKTQBEnjcN9dGr8xqPF7AMaDRMBvgaxI17uPXlv?=
 =?us-ascii?Q?OILRagw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfBDGwgVcl2vtyyNp+5rlKFt69oeoN6MFUoBoJabtgJda7ZVceEWcniSxksV?=
 =?us-ascii?Q?sB4tMudlRl2PxoB6RV5IkKvyEzUAPLZPSPI71iH0ZSQPgS20vJ7lNYT0wteS?=
 =?us-ascii?Q?CoBJlEqsWkGYppkX9+buZZ/H0l2rBky9Qj9c8GE1yHYTqLn13RcF3uYTEZ3Z?=
 =?us-ascii?Q?VJj4FNop/+2mJfAXDHVlzUx34+5zz2rLGSn+Hr9MqZ1uXmw968AHHd2o0MO+?=
 =?us-ascii?Q?6sdP/vJtMA8jnRUd1lp0LqRMyyGjSI2y/UA8t3MFlfxgq4GGYXIKB2RZ4ahl?=
 =?us-ascii?Q?jyVmKisMAQLs5RWxAPgilJhIB2/T/Ypj5h/yfnhr3MCr5MxqEcw/f5kfsTeR?=
 =?us-ascii?Q?kJClVaCH7G3yaGzTH9YHbtJyf20iwcqYlW4hr7GUwgsPUKSi+3CAh8qwbNO2?=
 =?us-ascii?Q?7Uz3wmAGTbMIr14Vys1zDXE+0BSushiec32sVZwyoh5QwyoOqXV0BhqJK++B?=
 =?us-ascii?Q?+mxfWscW4IFN/4hBxkiwCKgun46I1+fRLz0k5+BLL9vp+7E5oSmpMQRcYOTv?=
 =?us-ascii?Q?J2+uW4QLhNIgiTruvDde9/TCQjPbRSsSF4NYLNZFqfdfP9JFprPsruB2wg0v?=
 =?us-ascii?Q?VUJnWrmwfTtYz4XBxuuWlY0ajWJ3KUp7jcQln/XadbgWJG6uJ6ZFpaS0GPvR?=
 =?us-ascii?Q?FOGjsN4QRhx46h0kEAj8HfWytcDZxZvWfIkgUau4ZlcqgQUV8TLwbzfMZ20I?=
 =?us-ascii?Q?re3IWYFfqa2/E2OYLfd0eAPIdJZf4X5zp9xZ9HPBvSoqgyvILApuVDPsMs1i?=
 =?us-ascii?Q?RDasywtQhH3Y4LQGbBjU/71TPdPsA8PZgplCUL9PHoYeZMOOmzAOEGTL6H2t?=
 =?us-ascii?Q?SR3+LAmPaVO/kDstlDCx9sYE2YG4WgWbM304U8oo63Kyt0VaRo+cHu1eWvN+?=
 =?us-ascii?Q?EV2FykTennAJ2WWGkcFNv7e2sy/fZLTgnm9UKzj13bgktZ6bN9Mq+7BklIWo?=
 =?us-ascii?Q?ypVyBdbaXXtQVKNFuTquLoDvvjEXA/ELOVpUZftKVCNf57VqM90cfxM6N6XV?=
 =?us-ascii?Q?p5oemM7Jf09z07tELyrXUweSXJwr92ezmM+9Xm8MRKqZ8GmGcWaJuXyVU35K?=
 =?us-ascii?Q?VH/XEfwTNk+tfiR1UrLWTvk84VzePEo8ryU30pOY1wo+jKgXA6jOyq2KKuMQ?=
 =?us-ascii?Q?UXg1YT+dOaE6e2DRmZXtj44qZk3pCigOEi5/G3zOkdR7HGOuATwO5QqVOIrR?=
 =?us-ascii?Q?hCKX/7QYtVOUn4xLw3SEr+dnk2W9bWQ0HuOPh4EEfaXSMZJzj8uY+qEJzt0X?=
 =?us-ascii?Q?8wZt7ls/DXaqx9bdCJk5Ng/NdbwkasYgwsQPgHfiSAfdFyMrhWHAt1UfELE9?=
 =?us-ascii?Q?FK63YrvZCBfXlIQ2YoKBIcJG0FKvq77DJ4RVet1Lac/mEXtGUUtxLMLcXM2d?=
 =?us-ascii?Q?4lEUbTpELGjPf0GIxcX67a1PycSk0DpveAf0WEikJ9WkAm1mjZjXa8RSqxrB?=
 =?us-ascii?Q?yqd4wihmwNAmamM/TleJY+XGzn+8DipqDax2dGvwv11Q3hTeLF9UKDz/lek+?=
 =?us-ascii?Q?YgVTSZBAMoAIbh3OOfJAMEdoT2nI+oYvn5in0Ikp2BtrveQnp24Ba3cuOKiS?=
 =?us-ascii?Q?UN+N3vKkolIGVLRmOqEj+iw66Mv7gg+2JapUhPVR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3157e1bd-8c24-4aec-a079-08dc9ab887b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:00:52.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkFA7Zvg8Q3miJYlVYNhArNkDh2yuaNq/HHw7G4ppxjY3zNDq5jQh/MGAQiaG+nHzOm/yGyAWP0mBf/0MOWTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10034

On Tue, Jul 02, 2024 at 11:43:50AM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 02, 2024 at 11:37:02AM -0400, Frank Li wrote:
> > IEEE Std 1275-1994 is Inactive-Withdrawn Standard according to
> > https://standards.ieee.org/ieee/1275/1932/.
> 
> I'm not quite sure what the connection is?  Is the sentence below a
> quote from the spec above?  Perhaps include the section number it came
> from?

I quote from original yaml file. This spec is not free. I can't access
this spec so far. But I think limited to 3 is not reasonable.

Frank Li

> 
> > "require at least one non-prefetchable memory and One or both of
> > prefetchable Memory and IO Space may also be provided". But it does not
> > limit maximum ranges number is 3.
> 
> "But IEEE Std 1275-1994 does not limit maximum ranges to 3"?
> 
> > Inscrease maximum to 8 because freescale ls1028 and iMX95 use more than
> > 3 ranges.
> 
> s/Inscrease/Increase/
> 
> > Fix below CHECK_DTBS warning.
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > index 3484e0b4b412e..506eed7f6c63d 100644
> > --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > @@ -103,7 +103,7 @@ properties:
> >        definition of non-prefetchable memory. One or both of prefetchable Memory
> >        and IO Space may also be provided.
> >      minItems: 1
> > -    maxItems: 3
> > +    maxItems: 8
> >  
> >    dma-coherent: true
> >    iommu-map: true
> > -- 
> > 2.34.1
> > 

