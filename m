Return-Path: <linux-pci+bounces-3464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63B85537F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0981F25BAD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245513DB85;
	Wed, 14 Feb 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c8moNkxX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6213B7B1;
	Wed, 14 Feb 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940492; cv=fail; b=JZ/2EscIfc3AZSmy6Ce7KTYwi/g5rQgOKSBnSSB4oDEv0kf2dS31Qo2HvpidOmAjXC/iMQdvT8m94rudgH/FGjtZk1ShOjVF+U87/UNJ7nVDLes9e1MTvwichWV9umVnjRoYBJVzA3RlXHJS4DAyPHSYYw/Y6hecvqvE3sJhF+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940492; c=relaxed/simple;
	bh=bdI88T0TmkcbTNHph+tQCKi93H9QnnRAatF0vJ9QCIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QQ0osgqrE1vsOsHQm92IqzAW31DQUjXU1GUvUK4ow1sonxg127MN23k9OH4Xt1ZrKtEe+NMTc9U6sTaNeCtfdeG7BDapoGyqGNLOnjUKJjrDG/tYDjV035EXshbuSNvbROP86UNtVxeRojecl2aFYbhwbH4OU+m2OiRQ7UPj6QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c8moNkxX; arc=fail smtp.client-ip=40.107.105.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxBiDCv5u71LPWDAp/4c2vm3Mg5602BrClR3XSOCpjcOsNkOiJgRlV9EynCM+mFj0D9VTXsZcO6UQINcb4XtNx0GHjNxos7VK1yGhZTswrDwB/81VBxiVt7jdA07Ext9d9EDTU3L5i+1W0UHryaLjflJ1mcPXUhqAj0nY2uCsRYxj//15YQqtaetANfXctIY/YTeql2d1rCzfYtmC7pbn57vYcgIsvaKXNCxoLar4QJGLPf7ixcDTKaLRKtegYFFJys8GXWQen08Le2yAeWcqGUXxVjAUk3LJnfB6jbhiHgED755IWwVnDoXrjo4KgDnWZ7GSnvMQesHwzf+BliUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCuJnjmRo0IcjvQtw3yJ0ysdOTPVEMYlUWIdw7TkBh4=;
 b=oX7/SK/W2aUQj6vFd7FVnhcDgu1G41dpY4WF/GlyvovQB8j539Ap0ZAlvKPAKdi7ojnb3IK4jI/hlFoMFztnOZcGJkB556kUNqSVIOvWz59MKLBVybIl9vlCsD11MOQ1QZlBJG+9KanAhS2ii5W4Kphw7JktZYhJx/Ot0+tSSIlIA8TSLq4WQ6qtDZ+U+lVZwSGqLhi4khsbANM7PhHolwrhA+AbgkzBV9V5o+Eq5aAPZcRBUcMFcnVkXwKIqRlZ2LDTujXxQEw0ERu8ePHcfLZ5r/sRxq5zbOni4qcpdStaCNGw0OWDISwPCgob46mkex3gSm6sV+NgXByGKsdT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCuJnjmRo0IcjvQtw3yJ0ysdOTPVEMYlUWIdw7TkBh4=;
 b=c8moNkxXSznJuME01x3OIxS3YD102ATURKfr60HqN4nHMrWX52bqgD7aYb5g1T/NnVt9oJz50HRg3bLw1O0cTCsMYt2eg0xEZZvkdP6WGtXxd+LzY5AGFEf5ZMf6wqbXEodfLcJv+D6biN7/H4ODb9vPhnhw1RDhjcreMb4BbQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 19:54:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 19:54:46 +0000
Date: Wed, 14 Feb 2024 14:54:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <Zc0afuq4t0TwOkZ6@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214061412.GB4618@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e30fae9-b162-467a-8501-08dc2d96cbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8WTsLmMxmMWh0RLsyFH9DN2DmKkh1KkP166keV43QDy6MaTTknGUF4omrb6ZKVa6LfKWenygxwwDhfG2rPfk8kHoSwQ0sEUhtQjkWG1IOVzp/2i1YjkbIpwy185lzn8eoKBwaP+lQPOnouR1o3xeHGuJST5LlfdKgs1ho3E8+UzyknWCzU1G9MT+QlNNbByDRbzljBXV/IXshl3/TbqIWJYESO5YWXTJHSdutUM7/gWa1wSpq3pTsMtaGG0wmrtuRCN5NqS2jFQCaZxMg3oGvlTlK62jyyCocBV0Xg1TFgb9thBAUaD6pW66NjHhBEzpXX1wzRuCiVAGFkYO8wpMCL6Vmoph5tqPPqVZHpaVM6c7paVx2e4XK4MoHV6M7qEPD6FSaHoeSTzaSU14lD9ABdiGjvbMEKJ0pQ91etd1XGQ3CkMZnPM9X7WNZFm5I+qggudBWcPJJ867VD1NLgicNA9r0p0Lx+tzidRzZJXehaf0PTmWQScJFszx9Yc10/nuT+TPi9Pbi1ZlFeg2eEKE+GbN2fF8W9AOEnb+Nz/N4y99L9IvIcEhwS+MdA7qjEEhcYkePo1S0aHgNs8eJUbeHpWc5/42A7IohnOIEg1TxEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7416002)(5660300002)(66946007)(6916009)(8676002)(66476007)(66556008)(2906002)(8936002)(4326008)(66899024)(83380400001)(38100700002)(26005)(86362001)(38350700005)(54906003)(316002)(41300700001)(6666004)(52116002)(478600001)(9686003)(6506007)(966005)(6512007)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFSRWRMWnl6ZlQrT0NVK0R3N0hqR3JzWGlFanJHME5uNE9nRlZwclRRU2Zw?=
 =?utf-8?B?STVFWXAxZzhBSU1UK3FuZWVvRHh3ZVltSnpPQk9lZSt1N1pHam1saWFVYTlB?=
 =?utf-8?B?aWJxcjdWdGZvNXJUVU9EbkVTVkFybndVaEhXdDdETk16UVVsV0pFbUhMVW53?=
 =?utf-8?B?NXRBSElJMW94YnFncUprYTE5WklLdllwcHJ2WW8xdm9jajFPSUJXcGFwK2xC?=
 =?utf-8?B?Yy8rWUhiYjh6RTBzaTlPYWpBTzM2N0lMd1UrZXZjemRqVXVpMXlOakpiN3VZ?=
 =?utf-8?B?eFdRallWbDdMNlZZbUlnNWRaWkRhMk82ZGFMNmZSK0J5OWtHVXBWTHRXZXRk?=
 =?utf-8?B?TXNkTE56MnFNZnR4TjFBdFZ2UXhNK0RLWWNiWkZBb3dhajFkQXRoSE9Ed2pr?=
 =?utf-8?B?Q1l0b2Zpejlad0o5K0FIdEhHUlVKWDdJa0dJSHJYR2JmUGJxSE0rTm9rVEVq?=
 =?utf-8?B?OWF4QzRFd3lOUWNobFlaKzMzNWJHNEZ2ZFc4T295RDVNTHJ1aU8yTXp6TVJM?=
 =?utf-8?B?YjVNVnNtZ3A1bHpvVjgyd3czN3JMaWV6VWs3ZUQwTlFQTjNHbVpDcTdmdU1E?=
 =?utf-8?B?TmtLczdQZHE0d2hMYjFTSVZLYnhvVStLSmhaQlZISWVaaFFVSnR3L3NLRmNE?=
 =?utf-8?B?VzBrKy9KWXRML3hzSWhqMHFDRVJjWEFYV2hDOFV1d0FKOTdaN3ZTdExUZFhN?=
 =?utf-8?B?YlZwSWVJdm9td3pVQ3RKWDJqNTBuNUhlL2ltTWFVNTMzZ2d2VC9uSkZUUnc5?=
 =?utf-8?B?Z2FJMGh2UGJ5eWxFeC91Z2Y5YzRENFZFcWRycERSMFFyZ3JyYjE5Q2xkTEN1?=
 =?utf-8?B?SWNlcTBCaTk3dXpObFNvOU4rY1YrbWdwOWtPaStSSTFKQzVuNkY3Q0trRHlO?=
 =?utf-8?B?clJmTkduOW5nYUVvMDJKaHcvZGovR3RxejgzeTBIWjZRNWZhTmwwRnhML0hS?=
 =?utf-8?B?N09GR2hNM1doc1hlNEdmemhKaTZRcVd0eGZDamsyS3hVdkdOY0krb3lyUGxt?=
 =?utf-8?B?UFpWSU5vRVYxUjlpb0ZPckJXTjB4Kyt6ZFZRbEZQOXNXUW1IR1pueTZ2dlBE?=
 =?utf-8?B?UmNDWDFNUDhBN1pVNnZSRW5veHY0eHZvUXFpTzBuSWF2eFhUaWNZVXhOU0pp?=
 =?utf-8?B?VmdEbWFqVFU4bUduVDdmRllEakh0SWlzbkpHZC9pZXI2cVArVEowZExvYUhW?=
 =?utf-8?B?MDBNM3lteXdNbXE5U1J0QjhjZENaNFlJdDJuY2RHd0pVb2NPRGltcmhWWU5U?=
 =?utf-8?B?dUZ6eE1hM0F1TzE3K3R1THJMQ0MyYjNKOVhmMVlkdUg1QTlYcGZoN0Yyb1cv?=
 =?utf-8?B?Uk9UVDFDcG9tem4vOWFHaXY1UTBUcFZNWWRTdVd5c3owdDYrdlRMejhRa1Uy?=
 =?utf-8?B?aVRpRVhtSEJCeDlRc1R1ZHVsU0c2WnVrS2pncG5JL1RsTjJ1SmIwYzQxcUhm?=
 =?utf-8?B?U1RRMDZBOWJrSEJjYjNLREQ0SHQvQTUrQ0xtSVQxSUdXYWxPcnFQS01EelBN?=
 =?utf-8?B?NW1yUUZ0Tyt0L3hSZUVJRG5TZGFRWGNtVThIY1NkTkRaaSt6OFNvelJmRmRI?=
 =?utf-8?B?UFB1YVVSeUlCbG9VbG5SQUdneWh2a2FFVjFYeWlSd3J3UGU1TmVJSzZBZm0r?=
 =?utf-8?B?ME5iUnZtY21yOWlRdnBmT2daSG1Ldm1iMXdTeHdVUWJwb1ZkT01qTytTZ2kv?=
 =?utf-8?B?VjRZT2I2TEdJaXFRN1RQVmN6bUJ4NnFQSUlYMUJvTDI3U0xhN2pCWXVnZE1t?=
 =?utf-8?B?bnpmT2gvSm5KMG1jSTJLYW9JZjF5ZklacW8zQVEyeEp6bk4yWVhCU3JwT1BT?=
 =?utf-8?B?RCtDZlhPVVNrLzN3MGxITW1CSGVvUGd6SE1LNVlCUW5tcHN5UGUxLzUxWUxE?=
 =?utf-8?B?Ynp0Z1pDd1h3S2xKTnJYQkFBZW1rcmNXVmZ0Y3N3N2FoNW1BWGV3bWdjNkhQ?=
 =?utf-8?B?UVpXTjdOcFhiUVYxSHBsMnZwWUtpUWFqdmRwdzBsQU9nWm8yaDRPbG5tc1hM?=
 =?utf-8?B?T3RKaVUxdGlIenVVdERGQU5qaytKSFZweXB3MjhFMi9FeGUrWVhMWGlWM2Yz?=
 =?utf-8?B?cXljbHBzdTNDNHFJVmFPUnp3UW9XNE96dlh3NnlxWTYxUDlKWjNMdUdLYjk0?=
 =?utf-8?Q?thpo2qex+37LDp3dO3xGY5k+2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30fae9-b162-467a-8501-08dc2d96cbba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 19:54:46.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P79lG+GOIeae26V/8pFKQ9MCw9u2eHerHnUGVsYzlJ6Z5uVkT28Ctf7+N2+DX6fYqaPZnbqLePPJCv/l+aY1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911

On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > 
> > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > >            const: config
> > > > > > > > > +        - description:
> > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > +          const: msg
> > > > > > > > 
> > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > 
> > > > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > > > just configure this on its own. However, since we don't describe all of 
> > > > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > > > would have to be handled differently too.
> > > > > > 
> > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > > > 
> > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > 
> > > > > @rob:
> > > > > 
> > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > detail direction?
> > > > 
> > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > property:
> > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > 
> > > > So basically Rob meant back then that
> > > > either originally we should have defined a new reg-name like "atu-out"
> > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > or, well, stick to the chunking further. The later path was chosen
> > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > above).
> > > > 
> > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > TLPs, etc are all application-specific features. Each of them is
> > > > implemented based on a bit specific but basically the same outbound
> > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > of view it would have been enough to describe the entire outbound iATU
> > > > CPU address space and then let the software do the space
> > > > reconfiguration in runtime based on it' application needs.
> > > 
> > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > region. We can reuse this name.
> > > 
> > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > mem region. We can config each region size by module parameter or drvdata.
> > > 
> > > So we can deprecate 'config', even 'ranges'
> > 
> > Not sure I fully understand what you mean. In anyway the "config" reg
> > name is highly utilized by the DW PCIe IP-core instances. We can't
> > deprecate it that easily. At least the backwards compatibility must be
> > preserved. Moreover "addr_space" is also just a single value reg which
> > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > regions.
> > 
> > The "ranges" property is a part of the DT specification.  The
> > PCI-specific way of the property-based mapping is de-facto a standard
> > too. So this can't be deprecated.
> > 
> > > 
> > > > 
> > > > * Rob, correct me if am wrong.
> > > > 
> > > > On the other hand it's possible to have more than one disjoint CPU
> > > > address region handled by the outbound iATU (especially if there is no
> > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > in HW manual). Thus having a single reg-property might get to be
> > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > What about just extending the PCIe "ranges" property flags
> > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > use the flag to define a custom memory range for the TLP messages
> > > > generation. At some point it can be also utilized for the config-space
> > > > mapping. What do you think?
> > > 
> > 
> > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> > > all IORESOURCE_* bit need move. And it is actual MEMORY regain. 
> > 
> > No. The lowest four bits aren't flags but the actual value. They are
> > retrieved from the PCI-specific memory ranges mapping:
> > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > Currently only first four out of _sixteen_ values have been defined so
> > far. So we can freely use some of the free values for custom TLPs,
> > etc. Note the config-space is already defined by the ranges property
> > having the 0x0 space code (see the first link above), but it isn't
> > currently supported by the PCI subsystem. So at least that option can
> > be considered as a ready-to-implement replacement for the "config"
> > reg-name.
> > 
> 
> Agree. But still, the driver has to support both options: "config" reg name and
> "ranges", since ammending the binding would be an ABI break.

of_bus_pci_get_flags()
{
	u32 w = addr[0];

	/* For PCI, we override whatever child busses may have used.  */
	flags = 0;
	switch((w >> 24) & 0x03) {
	case 0x01:
		flags |= IORESOURCE_IO;
		break;

	case 0x02: /* 32 bits */
	case 0x03: /* 64 bits */
		flags |= IORESOURCE_MEM;
		break;
	}
	if (w & 0x40000000)
		flags |= IORESOURCE_PREFETCH;
	return flags;
}

flags will be 0 for config space. It should be okay for flag: 0 as config
ranges.

but it can't resolve 'msg' space problem. Even there are more bit at
addr[0]. but there are not enough bits for flags yet.

Anyway, could you please check v4 version:
https://lore.kernel.org/imx/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com/T/#t

'msg' will reserve from IORESOURCE_MEM without change dt-bing.

Frank

> 
> > > 
> > > Or we can use IORESOURCE_BITS (0xff)
> > > 
> > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> > > 
> > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> > > #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> > > 
> > > we can add
> > > 
> > > IORESOURCE_PRIV_WINDOWS			(1<<6)
> > > 
> > > I think previous method was more extendable. How do you think?
> > 
> > IMO extending the PCIe "ranges" property semantics looks more
> > promising, more flexible and more portable across various PCIe
> > controllers. But the most importantly is what Rob and Bjorn think
> > about that, not me.
> > 
> 
> IMO, using the "ranges" property to allocate arbitrary memory region should be
> the way forward, since it has almost all the info needed by the drivers to
> allocate the memory regions.
> 
> But for the sake of DT backwards compatiblity, we have to keep supporting the
> existing reg entries (addr_space, et al.), because "ranges" is not a required
> property for EP controllers.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

