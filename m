Return-Path: <linux-pci+bounces-4265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7786CD4F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7968428768A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107314A0B5;
	Thu, 29 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FsnkvO3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9914A089;
	Thu, 29 Feb 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221474; cv=fail; b=aNs2HiMXWHsp43zgYKTH+nHh245HxmnsUjzjCiY2SsHjzmjvqu3caAKFiO60Jk2K2yiCAxqSkY9l1YvZJgdMDiR3TALhDH9jhjqZbXOJvc+WNbfIqLh7xlARwMrphNrWvZtfXEo1oeSRPJ77gpOVesJD8rzgiqbutUkaNv/dqoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221474; c=relaxed/simple;
	bh=IBsuT+F4A7+/Pua7X5SdCSetK4BSwhyKtS/RdWBG/lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qkrLsxPz+RjrIQxWkfXQscUg485ZrydZKwi43vQZcaAsBMCViMqO4wb/iZ44tCzNUFFbptrg1lYIQBPB/m8v2bkY89v7Fnp2O+ybfNdBpy1+1fTcR6feADJj4YRDiBMHbC7iAQlsobh5MlXIjy8Ji2xocus9Lol+iQ7reL29sbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FsnkvO3f; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxEpeVTG8r8b88wMEYJw3FA3ql2euNF5ve7j6xofJ6l3Qkxlh/pdUXJ2ONiEd1v9S0rrxpiPkxcq3aUdXlmmnXvepj8ViWJ8o5/5jJEG1mbT0EEJO3LIiZBOC2Un7vVMZsw632Qoq04q6RXPtjdnjkvGpNA4UcBAE48C5v3gP933aAurO4UrH4RzE7t9yvJwq9Wj12WzSIBehDwaUfvAt/X5uyQNAtDQ4usljEfYaXknpKXj75Ry8sZUOqCxqom4NYHOzEqtgvkiaU7ROmEH1SOPejIZr+prRz3yXWWn6PKwbC1i6v25NQcrzHaz7iCwwhLyR/6SAlmEpvBVm/0/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ2rGqSfNfQZR7BzfVpWYmacf4Sz8nskQ/BDQQDRaMA=;
 b=FDdp2TDrf4wZrmQuZ0WxE6nU3otyvk8lhYNhlwo5Vig1+qpR4aU0qocOyt5qEv3zzMDiNpzE6dcvMNWYBjNY8wvXpn7X7nFW8Yf4paFtooOCGqC6pOrW81Ne3ofiH6utkmT8USVJASgnMptvBGb6d/kvt7pYCllzPZtYx/LQsaygFN5y3SgnCwNJpvumGk16Sh5sWLHcOE7R9oWzbLy94QHDpDVphgm+tIKNWtowSOm3KtTEzpzb4V/kGr1JAxNg3PEq1K1d3Adr3tpOYaWJtuSp5Z7ma/Z+sCHNU0YOH24l1gFmhCe5UgriDG91HX0OIqUxrq0xSYJObaVtxZRm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ2rGqSfNfQZR7BzfVpWYmacf4Sz8nskQ/BDQQDRaMA=;
 b=FsnkvO3fotCuYND/7sMbJslfB3PFCu6+4nuyucusQIIW6dfF2/t7uKHtb+1mWARDjEhBog8Uyesn05kAT7hICwD1azgl9sEzVGjSzEMbQFid7eTvSKtjG+MQA0zcTgvCZTrLjoL0oWd9uPV0udXc8xiZLMdooDSx6xKvcrdGtbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 15:44:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 15:44:24 +0000
Date: Thu, 29 Feb 2024 10:44:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <ZeCmTXte5OBTcyna@lizhi-Precision-Tower-5810>
References: <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
 <20240228160346.GA4069607-robh@kernel.org>
 <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
 <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
 <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 84098b52-bcd9-4f4d-8124-08dc393d4db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ug4JcHzV3I3qi+yU7T5G9OK5xk092G2lI4aCXm8AgtoNHkJRcCSGTJvC67DzOgw3nLb7fBQVAcgpiwjx0YHkKiGj712rOtQbjZGI9q9cJnZMpUtgQQzOsuwHV7jOsZ3Ucxm54Ig4Y5gXIezmSS7awpYRCEhg8A2kUkHX3Twwqpj46jo8wS4FhZYcqjpxf8Gotn12uqSXTC6iYzLX1ipqB4jSq6zmo5lYv0k0t8cs6/PBXEX6QF9/f9SSIE/zQj4ziTM2e0R3Lbqp3+64g2tu/5g6BW1n5A9E6VUrGPgFQTFgcC/6djd1xtm5PFoDb5e46QJTtFDFhD5lPWrweVbU799R/yVIsReUCPZU03tORBo4O3FCO+OojsInGIY252tTG/3Acs7FLmrVCDIQlw+SwF9UglhE7p40KHgb5Y+1UI9FUSP8E++dp6PhIrCCPq/zQmjDYMSpxzjYrD5XS0mE+D7bak+/ODZXzsLyGHeR8aqoe82TEDzbzTTnXncv0ysQfJ1x4rMRI2mc8eHUmRvD09V1XcW9H98Z4t9ROEDVgQvTGYnHerlu/kMtJva7GgamWrHdDg0YjBgDbf9kKWJv3poq98bOZIHTgLasyGeuGXcq0GVQN6jx/c4DIYLCwkQCh29iAFHK3XxMO3C6LxQLLpGz4pgTA4sBH5oApk2z4kg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lys0ZHlOUVFDa05ORGVHZENpYUNSbFM4TUViNlR1SmNUNEpoYlFPdC9Od29U?=
 =?utf-8?B?RFV6Y2RJZmM4K0w1bjluZXUzU3RCS2ZZdU5JZ3pWajgxaDlJRUxvbU4xYTFi?=
 =?utf-8?B?bWtnZXNzQmJ0NHIzR0tsMElkMUNVUVlBUFVvUjUyczgybDdpamNxblIwN0o4?=
 =?utf-8?B?c0tpZkx6WTc0TitXOGlIN1JoeHZ5TGdTQk1YV09sbkpvWVZiVjM3U2lCTHYv?=
 =?utf-8?B?WHRrREg5RFVpZS9TZk5SOVlaWXd1QTJ1MG12eCtvWDJHV3NrZTQ3RlUwOHFn?=
 =?utf-8?B?RXBkMzZFNmpkcGhjMXdpRHZFdjRjOVZoM1F5UEJiWEdWTGJqazFtdG92b2dQ?=
 =?utf-8?B?YmMwc3orMGQ3MHc4T0UwQWtITVdqQXBxbWxCNDRKWlp4WHFVTWR1SDZkUGRx?=
 =?utf-8?B?NnlSMXJjN1VvNEpvYVdUUDhBaHpXenU3dkllTVM1RVFMQ0JGaDBGODlHbEtp?=
 =?utf-8?B?MW5TWmFRRTZ2bG9nNzVNQmtvTXlQckhUbC9RNHc3b2VpbDhIcjN4eVRxR1RE?=
 =?utf-8?B?aDMwckFoR3QxRDFJbjlNSUkwZnZGQUNuODdzVHhqemVWOVV6MWQzazRBL1c0?=
 =?utf-8?B?OHFGVXFUVHAvYUs5RS8vRE1tdGNCQnZOaE9mUHZ6TXYvdEttczBnVUdUOWxU?=
 =?utf-8?B?aGZsem5pV3hxeGp3TWU2K3htdUZKT3NNbHJpODduMnQwcUFXRUhSbHZVbVND?=
 =?utf-8?B?bjljdGQ3d1lPTm9vSjdUVjNzaHR1L053QThjRDV2bXZSb0thRlBUMFcvazdF?=
 =?utf-8?B?UXFWczdBL2FEQnhnOGhkWDdkQTVtNXliaG02YkZ6T083eEttZFNDdm9lK2My?=
 =?utf-8?B?OE1UWmVMTjhDeUpUTUNYODdLWWtoNXB4WjhncE5QK0YxakNGRVF4SkQ4d0hQ?=
 =?utf-8?B?Y2VuaGpaaTNNRHZ0RTdsN1doUStJZUpSaXNBbGVTNU1tb0Rmd0JRZ0dWZ21T?=
 =?utf-8?B?N1VUdGkyRHE2cmdUWmxxVTVQOXZXM240UlMvczZNUWNnSWQ0UDNzTHd3cjRn?=
 =?utf-8?B?aW9HRjBtMmlDak9zSElsSFVKZHRrM2RRc1ZKN0doVzZzOTNLaURUdlNLbFk4?=
 =?utf-8?B?UkErMms3aE54dUd3djlZdzFFTW9PdHd6ODJIVU0rc24zMWRDbFNDcFBWY2s2?=
 =?utf-8?B?eTVxOUdHUjVzU3Y5eFdDSC84TGVyQVJRSFgyamV3L1hrZFh3VUhLQlltMmdR?=
 =?utf-8?B?WDZnQmcxL1lqTTdkZHdmSkVVamFGV3RtVERwSnowa0RNbnI1Tm9yd0JsNkVV?=
 =?utf-8?B?UWMvb1dzQkRXYkFpWmVuUGIrN2Iwc2wySkg3SlVyV3AwUHpXSzNRQTN4Y0lU?=
 =?utf-8?B?TWhIbzdGZ3JtWEJQa3Z5eXBEbDVJWFdXeERlNW5mTURmbU1mU2ZQbGhvcmlS?=
 =?utf-8?B?cFBuMitBcVIvZmtvL3RUZ3VhV3BVelVVUCtQMmxvN2tKRStPMkdDUCs5WEhX?=
 =?utf-8?B?WDd1V2IycldkYS9OLzJzWDBqU1hVZE93UFJFaEN0cE52SGszS2RrOWhRSGZT?=
 =?utf-8?B?YUtueUlBaDh6cC9qWUt2RWx2S0s1U2MrOGtsUmVmNmdZRjkrMUlvTDdlUVNt?=
 =?utf-8?B?dExEZjRUOGpaTVVvaWJNTHpjUU1sZDB5MGNZM1N0MVFkRmJTcyt4azE0WW0x?=
 =?utf-8?B?cjNiVWxJVEdQM0RBQWZSQTY3cGl3Z3FuZ0dNRkZpYjNPdXlmai85ejdpTG5V?=
 =?utf-8?B?eVEwSll0b0R2OG1LdWN1ZXdUeEhQenlHNm1BZ1I2eW5TdVVOS0lkQmdzU3lz?=
 =?utf-8?B?MkEwWFdldkZoQlRxWGx4aFV5Y3AzNFlqa1J3WG0wQVp1eGhvamZyUGpSV0dX?=
 =?utf-8?B?MFJVSzBuWHpyUUtCNUlpL3BYR0hjUnFOQ3orTjhLQ3p0RE1vZzBPclZRNVVw?=
 =?utf-8?B?KzJXMlpaL0R3Y3JycmNDcWR0YW9yc2lGUy8zekJnQisvb29aWGlVRzV0b2dq?=
 =?utf-8?B?cUNTSitQV3Z1Z3dZNmNRZ1N6cVdIYWhRQm5BMmVuOHpiTmNVQjQ4Qm5HYklU?=
 =?utf-8?B?RkV3M0N5bksvTE1KQ0VNWGJ5WlY2RStUbVBDRlVQZTJ4MEJlNXJxdSs5Z2Qr?=
 =?utf-8?B?bEcxZHB6NFFLR1ZiSExKTWxLYUJicWlHZ1Qyem5PZkt6L1AyN2w2UDJ4L2RS?=
 =?utf-8?Q?wUYs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84098b52-bcd9-4f4d-8124-08dc393d4db5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:44:24.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STpRieK9/VmUAM7pqnMv5H3HkqtIrimzCvQzfdY9VO22O+1Y0IuFpVpa1dK6/tP/F/W6OXLSrTPtnQPiVnniew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871

On Thu, Feb 29, 2024 at 02:26:34PM +0300, Serge Semin wrote:
> On Wed, Feb 28, 2024 at 06:39:36PM -0600, Rob Herring wrote:
> > On Wed, Feb 28, 2024 at 10:23 AM Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 10:03:46AM -0600, Rob Herring wrote:
> > > > On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > > > > > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > > > > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > > > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > > > > >
> > > > > > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > > > > > >            const: config
> > > > > > > > > > > > > +        - description:
> > > > > > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > > > > > +          const: msg
> > > > > > > > > > > >
> > > > > > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > > > > >
> > > > > > > > > > > I do think it is a bit questionable. Ideally, the driver could
> > > > > > > > > > > just configure this on its own. However, since we don't describe all of
> > > > > > > > > > > the CPU address space (that's input to the iATU) already, that's not
> > > > > > > > > > > going to be possible. I suppose we could fix that, but then config space
> > > > > > > > > > > would have to be handled differently too.
> > > > > > > > > >
> > > > > > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU.
> > > > > > > > > >
> > > > > > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > > > > >
> > > > > > > > > @rob:
> > > > > > > > >
> > > > > > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > > > > > detail direction?
> > > > > > > >
> > > > > > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > > > > > property:
> > > > > > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > > > > >
> > > > > > > > So basically Rob meant back then that
> > > > > > > > either originally we should have defined a new reg-name like "atu-out"
> > > > > > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > > > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > > > > > or, well, stick to the chunking further. The later path was chosen
> > > > > > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > > > > > above).
> > > > > > > >
> > > > > > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > > > > > TLPs, etc are all application-specific features. Each of them is
> > > > > > > > implemented based on a bit specific but basically the same outbound
> > > > > > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > > > > > of view it would have been enough to describe the entire outbound iATU
> > > > > > > > CPU address space and then let the software do the space
> > > > > > > > reconfiguration in runtime based on it' application needs.
> > > > > > >
> > > > > > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > > > > > region. We can reuse this name.
> > > > > > >
> > > > > > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > > > > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > > > > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > > > > > mem region. We can config each region size by module parameter or drvdata.
> > > > > > >
> > > > > > > So we can deprecate 'config', even 'ranges'
> > > > > >
> > > > > > Not sure I fully understand what you mean. In anyway the "config" reg
> > > > > > name is highly utilized by the DW PCIe IP-core instances. We can't
> > > > > > deprecate it that easily. At least the backwards compatibility must be
> > > > > > preserved. Moreover "addr_space" is also just a single value reg which
> > > > > > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > > > > > regions.
> > > > > >
> > > > > > The "ranges" property is a part of the DT specification.  The
> > > > > > PCI-specific way of the property-based mapping is de-facto a standard
> > > > > > too. So this can't be deprecated.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > * Rob, correct me if am wrong.
> > > > > > > >
> > > > > > > > On the other hand it's possible to have more than one disjoint CPU
> > > > > > > > address region handled by the outbound iATU (especially if there is no
> > > > > > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > > > > > in HW manual). Thus having a single reg-property might get to be
> > > > > > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > > > > > What about just extending the PCIe "ranges" property flags
> > > > > > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > > > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > > > > > use the flag to define a custom memory range for the TLP messages
> > > > > > > > generation. At some point it can be also utilized for the config-space
> > > > > > > > mapping. What do you think?
> > > > > > >
> > > > > >
> > > > > > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS,
> > > > > > > all IORESOURCE_* bit need move. And it is actual MEMORY regain.
> > > > > >
> > > > > > No. The lowest four bits aren't flags but the actual value. They are
> > > > > > retrieved from the PCI-specific memory ranges mapping:
> > > > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > > > > > Currently only first four out of _sixteen_ values have been defined so
> > > > > > far. So we can freely use some of the free values for custom TLPs,
> > > > > > etc. Note the config-space is already defined by the ranges property
> > > > > > having the 0x0 space code (see the first link above), but it isn't
> > > > > > currently supported by the PCI subsystem. So at least that option can
> > > > > > be considered as a ready-to-implement replacement for the "config"
> > > > > > reg-name.
> > > > > >
> > > > >
> > > > > Agree. But still, the driver has to support both options: "config" reg name and
> > > > > "ranges", since ammending the binding would be an ABI break.
> > > > >
> > > > > > >
> > > > > > > Or we can use IORESOURCE_BITS (0xff)
> > > > > > >
> > > > > > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > > > > > #define IORESOURCE_ROM_ENABLE           (1<<0)  /* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > > > > > #define IORESOURCE_ROM_SHADOW           (1<<1)  /* Use RAM image, not ROM BAR */
> > > > > > >
> > > > > > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > > > > > #define IORESOURCE_PCI_FIXED            (1<<4)  /* Do not move resource */
> > > > > > > #define IORESOURCE_PCI_EA_BEI           (1<<5)  /* BAR Equivalent Indicator */
> > > > > > >
> > > > > > > we can add
> > > > > > >
> > > > > > > IORESOURCE_PRIV_WINDOWS                 (1<<6)
> > > > > > >
> > > > > > > I think previous method was more extendable. How do you think?
> > > > > >
> > > > > > IMO extending the PCIe "ranges" property semantics looks more
> > > > > > promising, more flexible and more portable across various PCIe
> > > > > > controllers. But the most importantly is what Rob and Bjorn think
> > > > > > about that, not me.
> > > > > >
> > > > >
> > > > > IMO, using the "ranges" property to allocate arbitrary memory region should be
> > > > > the way forward, since it has almost all the info needed by the drivers to
> > > > > allocate the memory regions.
> > > > >
> > > > > But for the sake of DT backwards compatiblity, we have to keep supporting the
> > > > > existing reg entries (addr_space, et al.), because "ranges" is not a required
> > > > > property for EP controllers.
> > > >
> > > > I don't know that its worth the effort to carry both. Maybe if it is
> > > > useful on more than just DW host.
> > > >
> > > > I believe we had config space in ranges at some point on some
> > > > binding and moved away from that. I forget the reasoning.
> > >
> > > I can alloc a 64k windows from IORESOURCE_MEM windows to do 'msg' windows
> > > in dwc host driver in v4.
> > >
> > > But I think it is wonthful to discuss if we can extend of_map bits, add
> > > more type beside CONFIG/IO/MEM/MEM64.
> > >
> > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > >
> > > phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> > >
> 
> > > There are '000' before 'ss'.  If we use it as dwc private resource.
> 
> Frank, why do you mis-inform about the idea? The point was to use the

I am not sure where I mis-inform.

> ranges property for:
> 1. PCIe Config-space mapping.

This one already exist. Just dwc driver have not use it for unknown reason.
We can change driver to support it if want. That will not related
dt-binding.
 
> 2. PCIe TLP messages region.

So far, as I known, PCIe spec only define TLP message format, not define
'region'. DWC choose use mmio region to send TLP message by ATU. May other
hardware can define a register, fill TLP related information, then issue
TLP message. 

> There is _nothing_ DWC-specific in the original suggestion. Case 1 has
> already implicitly defined by the DT standard, see the link above (but
> for some reason hasn't been implemented in the PCIe subsystem). Case 2
> hasn't been determined, but could be seeing there are three unused
> bits in the ss-code of the phys.hi cell. All of that can be used by
> _any_ PCIe RC/EP device.

Please give some exmaple how you plan use these bits. 'msg' region may be
an example, although rob doesn't like.

Frank

> 
> > 
> > DWC (or any host controller) specific things? No!
> 
> Rob, could you please dive deeper in this thread? The idea is to use
> the "ranges" property for the "config" (PCIe config space) and the
> custom PCIe TLP messages regions.
> 
> -Serge(y)
> 
> > 
> > Rob

