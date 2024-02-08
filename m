Return-Path: <linux-pci+bounces-3245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5384E8FF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145C31C20E02
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E02381B3;
	Thu,  8 Feb 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NWGpm3mp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13136B0D;
	Thu,  8 Feb 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420902; cv=fail; b=MnUChOzlXB7pQU1+Z+0nuBQUiSw8Wacz0Kyp9SXNs+VciPI1IZ+FLyGsE3n0t1J+RtPuR7AovaiTobnNLOnoINkOC8tgNkgHdz/xLWtrZcaunSc+SRUWxbUwWHk96OtxTUB/Qy7la/rm4T8bc7Dk7zH2t5hV/GxRK/eOrFQOrDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420902; c=relaxed/simple;
	bh=zLu00NqHqe5ct+8TlZGK2FPUTdUtfsVEoXtUXhMK268=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/pJX382RoNyn0PgJqYal+sme+/LQmNuhdoPmfluXLLnc62UyoFWQcoUQmzw0HbZuOvcXVVioWsWxMHM/G7XrjKf/0nVAboDmN3zfMXfTEQHA0xYn1Vk8ifo+DLnmmkW3+qd3beRnGqQfuP/R72yP8cBeXQ+2x8YwDRbBAqRyoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NWGpm3mp; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0pgV2w2FtKTGM0y8dR3kI8mZdLcXbfeYArQBX8rSJLnbT46eRWDjabjZVslxcp71LbFp7Rze5SSrGlBHOOPyhGRkfE/wReUsN16upeT77YtgfzLmpoLB8QJmkswmFWEK2+bUMYyD4QgIx97HQoa7BdmgmO+JVTouf8SYfhtL0hSBCuN0pMDL6F4FistOYYH9XJGgvXdR4aueATJ5uuy8EqLhzc20imKhlXQTwckcNzuGa70THUr0KgggsDH88VnZgMlprfwSn3LutFRK6Ae8SDBDbT/U+upDWCcopOAY6uaRAzOaJ6xD7hdlA1C7hnhl30VXAAKjTZs30Iv/MbK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOGFGSHe77iYwAm96+iVLm+qSzknd3EOP36gW/6HfZg=;
 b=RP9+5wTUJDlBk7CBVekpulll71Z06MQ5yhX7si+UwFFklA4uPXUhi1k5Fk+5mjLzyM5G0Oy76ln2JZd8n95UbDf3rMIoUBRG16oNA99/xP4lBfnXt/8hL6ve+19QH7oSXajiX+kw3qHvzZujdqxjG6+qZKtGWekQhAUZ5S6WPxphgjm5QXQZSZ3E0WlEfD7sBsQ9vdXdEKG7IYoUzPtDgbYaxuP++pUQnwZPFbCYouH7a8TLD729r5dKtJFpg+C3dLS6WhRK12ezB27h0004+7/+NsSdOeM4/eL++3u9VBTFrdulM1q4MqkAdl4XfoV6Cpk0UGIoRPGO3vwaG/r+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOGFGSHe77iYwAm96+iVLm+qSzknd3EOP36gW/6HfZg=;
 b=NWGpm3mpF/6XeRxkEQZ4zKm8GLMsUZERbA6Esz1RcejNyCQeG0wZ/qAmm4JnFtKPcL7lMhqqodFJNtmtJdcHZjOD78vjS30FaLp0WimRuKYl1YHQ1z4yMPuJPQRPFS7fUJsTuHK4VY9rHjWvcpP8zGfppxTjXkCKHCDE7sCUdTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 19:34:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 19:34:56 +0000
Date: Thu, 8 Feb 2024 14:34:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <ZcUs16+Z+I4m4q00@lizhi-Precision-Tower-5810>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
 <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
 <20240208-jarring-frolic-8d4c9b409127@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-jarring-frolic-8d4c9b409127@spud>
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e1ce92-fa89-4899-58fe-08dc28dd07c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Di/+ppjp4SpCYi+IsfXtDk7y5USA1wYD2JlbHJWBQ2qZzAN3iwWpxiQOZEnM52nrB56LnIYo7thUBf/1d7Zvu/9pOhwtla7fQCno9LuGZpLrcqKM6/Cbn1cPrXAke6I45jaN8ueEQ0Az8rYnYNuXlxeBv5deAvQwK0qOHdKyHGzWBC7ErTQxohXBIVRcQzlm2K3ff3nb9aOnoO2pvpnaWQC8TrWtk4EJdwCYYGp51nu6XyDhTcXtayHXeIq8yNDvVeMfaQhxkaoT6mBoZBRzY2+/lztn8z2/wdDSze8ChWnD47x1cOfUQbcNjjqHC/1odjmtVOC4kKnL9ZJ9lSwNDjADjB6xb+mNLBuOOpID7/PdJEB3sBehDP+K2qTmUWlQGUYkz8EJQD0bcHLTxxqPeQ4QIr+Upu9mRCtwQZIVY3NYtDHHCLXwZ8veTvfqyU+2MiuZJ2iVlz1lHWgN+A2uL6bHrSayj+bODNlIRS33BBYxrXmkbjz8URKWTVrM8w74VDc1UBmjqTTgVANmKhQwh8tDcmhVJgqCbGVmp1gZy1Q9MVFKUgrUYibAwtanWLKzk6kxsNbP95dVNbGSObTM+TGeM81dFyTZmlVttt4ojjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6486002)(6506007)(6512007)(9686003)(478600001)(52116002)(54906003)(316002)(6666004)(966005)(66899024)(33716001)(2906002)(5660300002)(7416002)(66556008)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(83380400001)(86362001)(26005)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+kTGyFAuJr6l6w2GqxhL8ZYtod54+yff07CMvNSY9ga9KzEt6APCKX5oeLW?=
 =?us-ascii?Q?EusxqMZY6DSKiT/UI71FXQd31jAdnAwPjEl8/ZvXMSr1j1Mscz/8m7ktMIs+?=
 =?us-ascii?Q?2c2B7IMnz7qRvuZxwI3HPfmtMmsxr7HVa0DOL8P8GggaArYI4NHB0tS71Bn8?=
 =?us-ascii?Q?Ojg9NwWGF9Afw2rifU9K1K7K/R20LgVoEDfWTG9xNlM+wp9jyEeIpiRmIRAq?=
 =?us-ascii?Q?WHQuZ57Sthzd4nvyqje/SchSHeCrBA0b5KFEcfUKp2+Bhqw+n302h3JQu10N?=
 =?us-ascii?Q?KoE7Sne0Pf+I4xyTxDFpdhQd+jenh6CedBD7Uxh21dUWOm3rI8s4uc7ZtjWs?=
 =?us-ascii?Q?VL4MguRe6AvRzt75Jiq+I8B1JjtMg+m5eEJpPTgt6yvHgNC4sxHW7Gw2meA+?=
 =?us-ascii?Q?47eQQV2zZH+Wmk3KoH9jF+tCnrymfbPTQIzIirc4RaUQbtBuuDEib4J8LEle?=
 =?us-ascii?Q?KJu0raAdVuFwSCspnmnfO9M5wU0Y04ivhDVj/Q87H5l8kBGXy0xiGgOHsiC0?=
 =?us-ascii?Q?6PCSvjURmkQ2vVjdDc8rRaZH3uCAXuiEBxxr6fAOy/avUyKxLDPVfWAf6F2t?=
 =?us-ascii?Q?ysKAIM3k+f7oxoodqojtePVnoMkXPghqlZ5b15p8mcGxlyKQm9qgwB76H+wT?=
 =?us-ascii?Q?L5WM46nBePyLDOnjg8Q92RVkJbDjlY6P2lw+/kUqj6bIXevZeusfqyn+TOtq?=
 =?us-ascii?Q?UUm9sgFmPcrXOzqwPFJBu77XHMmc8B0OgvvsPva60g7L6okm5Q1C0uYURpMw?=
 =?us-ascii?Q?K6NVnuRbOhnI7IzE7yCFyv1MDiZ5vj/fpLbOV5gQOn7aEj1lcjQb2vAb2cLx?=
 =?us-ascii?Q?Ia4j3YFaBY9VOx8SOeLij7kh4eWIBJScjnarIpcga7YlNVZkO9PCaKvrn5re?=
 =?us-ascii?Q?uCusvE1v1NYMgDySEedR76Eo3lV72nVd4Coi5twG3RpuXgCAXq2bnra/c3VQ?=
 =?us-ascii?Q?j4TSflKP6vnLaGDhdszB6zXICsFvzRlKNYdp5ENRyRS1ytKLirCPj50q+ymC?=
 =?us-ascii?Q?uZzgHuKJgAzdyNtoXrCvXzPmAh+/MgEF4/v2+mP6gH4w3sqYpHGYL5hKKRB1?=
 =?us-ascii?Q?piW0KY2m9yCWxzP5oZl9r/ZlAOsUqcWtqC54bnFoNS8Rfvu8+I1KFQDaUHzv?=
 =?us-ascii?Q?9anS3r8alr9RbGlEpTGnfg79C6KW1zzOYZC3SuDRTSpCwKM4JeIjEiOIDHRE?=
 =?us-ascii?Q?vThv7EiDKAJ7WU+EnGhlDGy1TXD7YcmimZUJg0p0sUWQA0aeoGiu97PW2+vM?=
 =?us-ascii?Q?6voQHel4Xar7Adaf3lviWv0fw4sVVovFUHSvOghB29z93twqiabIOBuZg56r?=
 =?us-ascii?Q?1q6Vpfuj6BJEyi801M6Qha6sAZmA0CJiqLtzFQwFGpgyQfXoHOP1SvqnBqx8?=
 =?us-ascii?Q?2SOcsWqvUCbAifE5jKguAiRPjcFYmKZNZikEMXudHN6ZZSdF1VjMRZ7N2JiO?=
 =?us-ascii?Q?LF2zH0fa4xsUK/ChSYd3j9+I9gK6ci1JlBZT++DJ3Ko6I6C1+Tor+uDR7fQY?=
 =?us-ascii?Q?f5cOy3F+fStzHZ6SEsRgprmDiZopu34uQhyLPPKhd0Zs1VAxzO+DgvkRt3/q?=
 =?us-ascii?Q?wyDslMMrbUYy2hEZ7apLxl4Qc0V4y5a+FY+22wVr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1ce92-fa89-4899-58fe-08dc28dd07c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:34:56.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTvXjhqWsuKd4z5QeZwro8uwiwFu2e25aybV0S0r3VDIe93Rm/hDSfqYr4k56ff4lgy6Zt96xmaFcn6JUdNHRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926

On Thu, Feb 08, 2024 at 07:12:47PM +0000, Conor Dooley wrote:
> On Wed, Feb 07, 2024 at 12:49:19PM -0500, Frank Li wrote:
> > On Wed, Feb 07, 2024 at 05:17:55PM +0000, Conor Dooley wrote:
> > > Hey Frank,
> > > 
> > > On Wed, Feb 07, 2024 at 01:24:02AM -0500, Frank Li wrote:
> > > > Convert layerscape pcie bind document to yaml file.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  84 +++++++++
> > > >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 163 ++++++++++++++++++
> > > >  .../bindings/pci/layerscape-pci.txt           |  79 ---------
> > > >  3 files changed, 247 insertions(+), 79 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > > new file mode 100644
> > > > index 0000000000000..3b592c820eb4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > > @@ -0,0 +1,84 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Freescale Layerscape PCIe controller
> > > > +
> > > > +maintainers:
> > > > +  - Frank Li <Frank.Li@nxp.com>
> > > > +
> > > > +description: |+
> > > 
> > > Are you sure that you need this chomping operator?
> > > 
> > > > +  This PCIe endpoint controller is based on the Synopsys DesignWare PCIe IP
> > > 
> > > > +  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
> > > 
> > > You shouldn't need this statement given you have the ref: below.
> > > 
> > > > +
> > > > +  This controller derives its clocks from the Reset Configuration Word (RCW)
> > > > +  which is used to describe the PLL settings at the time of chip-reset.
> > > > +
> > > > +  Also as per the available Reference Manuals, there is no specific 'version'
> > > > +  register available in the Freescale PCIe controller register set,
> > > > +  which can allow determining the underlying DesignWare PCIe controller version
> > > > +  information.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - fsl,ls2088a-pcie-ep
> > > > +      - fsl,ls1088a-pcie-ep
> > > > +      - fsl,ls1046a-pcie-ep
> > > > +      - fsl,ls1028a-pcie-ep
> > > > +      - fsl,lx2160ar2-pcie-ep
> > > 
> > > Where did the fallback compatible go?
> > 
> > So far, no fallback compatible needed now. each devices already have its
> > compatible string.
> 
> It used to exist though, have you checked that u-boot or *bsd etc do not
> use the fallback compatible? You also need to mention your justification
> for removing it in the commit message.

This commit just convert binding doc from txt to yaml. I just make sure
which equal to what descript in txt. If there are someting wrong in "uboot"
or "bsd", we can fixed it later. I checked driver code. exited dts tree
under kernel, which use unexited fallback compatible string
"fsl, lx-pcie-ep", which should be removed at dts file.

> 
> > > > +
> > > > +  reg:
> > > > +    maxItems: 2
> > > > +
> > > > +  reg-names:
> > > > +    items:
> > > > +      - const: regs
> > > > +      - const: addr_space
> > > 
> > > The example uses "regs" and "config". Where did addr_space come from?
> > 
> > Example just show pcie-host part. Not show pcie-ep part.
> > pcie-ep part need 'addr_space'.
> 
> Okay. Again, please mention where this is coming from.

Ideally it comes from snsp,dwc-pcie-ep.yaml. but it is use 'dbi' instead
of 'regs'. It needs extra effort to make driver code algin common
snps,dwc-pcie-ep.yaml, and update exist all dts files.

I think it will be deleted soon. 

> 
> > 
> > > 
> > > > +  fsl,pcie-scfg:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description: A phandle to the SCFG device node. The second entry is the
> > > > +      physical PCIe controller index starting from '0'. This is used to get
> > > > +      SCFG PEXN registers.
> > > > +
> > > > +  dma-coherent:
> > > 
> > > dma-coherent: true
> > > 
> > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > +    description: Indicates that the hardware IP block can ensure the coherency
> > > > +      of the data transferred from/to the IP block. This can avoid the software
> > > > +      cache flush/invalid actions, and improve the performance significantly.
> > > > +
> > > > +  big-endian:
> > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > > > +      this property.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - reg-names
> > > 
> > > This was not previously required, why is it required now?
> > 
> > Actually its needed.
> 
> Well, if it wasn't, I'd hope that you wouldn't be making it required.
> But I asked /why/ and you've not given a reason. Please mention the why
> in your commit message for v2.

Sorry, I just sent v2 before see this. According to driver code, it is
needed. Please check v2, I will update at v3. 


> 
> Cheers,
> Conor.
> 



