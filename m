Return-Path: <linux-pci+bounces-4628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A7F875A48
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 23:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8AC283DB1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8213EFEE;
	Thu,  7 Mar 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZMXGtnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A913E7EA;
	Thu,  7 Mar 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850535; cv=fail; b=IOjq4WErkFGMc2PYUW2f9hPN2QqFYkAssteZiXxeFhcHf5QZrLpjv4B68oEnekLDArHIpJmJ3UZ53BxDU271graytdxRaKedEBspk33h77hpAFxvGuoFPrQETI85Lb8E0xi5TYjf3qNVtVQDffKH7dcuTNVzpeD/8ozh05UoMBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850535; c=relaxed/simple;
	bh=1R4C9EhzA23PdxQUuEhwi+oTtV2VtixKsAPzPwTd2CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jlrCBIn8s5cCDcSGFZEoC+1t/lpYwAkjoOMaaU1FTRbrX+tNanc0B/BSzr0EhUBuhf1D7k069OyaEwumxKTNE+xWrwuse8fDNr/5eVq9SOacw9dHYLZk5Xskj8E3xUhVJNtsz+phjzIuvqEyjuNfx2t2OnMStbU+qlVNQgeqa8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZMXGtnh; arc=fail smtp.client-ip=40.107.105.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM4VuYJ3XYd+WMu5ddjDarOQveTzxKPWKb7LaUMDm/jBw9dfQPK/O7xD55EBRgTkQeVx0hIKA+izF5ApCpdrzMsRaxVO0SDdo5cZQPNtnYtVhtzEWuRVldvdvkonNU/h5K1rK+E2UhO8gzuGvhW896816H/3gfB5xqcNEJqq1Jjb+xk2Cm2FkzaJ7/psOOL7ynYJpiToCa4SeKVL1yDhgXvoFX62PQZ1HDa6SWa/giiE2eVsPyHqKYlcUs1CZuunGm5ePEY6c+1N0UD/pjpCo0DudOnSKprPx4gFXOnhQItvmT65Jk4EI7BVcVJb0ucmT1oeOyEIGXwr9KzSTYqU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwiFA36EvKzgAWM7NrtuW+K0sdh3ip5cZtTe5u2bwN4=;
 b=V135rqr2XjinHjHs485TO/UvDurWpcFd/aTec16qWFNodUYsn2ZoqORF3P6s01vzTq0/pVlNpskTiJbJxQmnNtkVdo26BAC7n0SzSTL/h9a4Mu+dpYIWaJD5+zvpLFNR6X1SWKFHTOUf1GP6Qubto6rA8cSipEyMivyJMynZDe4zG9/DMJNFkTimrInd2f8TwZh2bYLlM2vWFjw7ppOwa5IEKiwPjr2msBUZUyJQJyayNb/QhBunL+qig02cmGPNijmoXRKKjULRzaO2vtIG1UCijAULr2+z9U0jx8UCfRpWLMmMVNrijrdRaBFBMB4fZ7NYqHUWemo57XJmAjiRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwiFA36EvKzgAWM7NrtuW+K0sdh3ip5cZtTe5u2bwN4=;
 b=EZMXGtnhRgQ6L0fxGmSNYwbMtIyfsYqVjwUAG4PsLavb7OtGU0Hpnm2Y1ekK4cr23nWg8l3L195cWneUvvklbd1d61jzkfARE0POYmESkC0/mBFmC6+1T3KU0F2x19M3sELnWpPgnAhGuZ94O0ErYCYaLjz9X9cSkT5A8rMNK0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 22:28:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 22:28:48 +0000
Date: Thu, 7 Mar 2024 17:28:40 -0500
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
Message-ID: <Zeo/mOvMjDkR5rq5@lizhi-Precision-Tower-5810>
References: <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
 <20240228160346.GA4069607-robh@kernel.org>
 <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
 <CAL_Jsq+tfDHM7T1xVm5dcn62A8Sd3GTtDRmxVUQpYtJtGg=pKA@mail.gmail.com>
 <fvre5zsj3a2dkvctbamuisomlq2lav7mqmugq2oasx7hibelsm@czz4ypnrqboj>
 <20240301160816.GA2221899-robh@kernel.org>
 <3nu77xnuaq7pb7lmct76n37n7g5snwhcghgodqd5q6paihdxbp@4imk4w2qfrlx>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3nu77xnuaq7pb7lmct76n37n7g5snwhcghgodqd5q6paihdxbp@4imk4w2qfrlx>
X-ClientProxiedBy: BYAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: ab70d7c8-a3ad-4975-04a2-08dc3ef5f54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iNm3iJmiOdiAZCCSBLtx62oyFFKY4rAirATN+H3Tj5Lbvephtl2IimE6ioyVF6RbOEzjReir9k/DFgZLVzYUd0tv7wcz5KyH9niu6ChCFYLTIUOscZEeH0y+bQkzZLNsj/jdZ9Rg21QsJkeww9LKe1SbekdawCkIiAMwTAJNlTFn0Fw4KKuJaDFS0MeZYXttiRXlUaDLVQzsZwr0wvRFNLhuFxLXxVRg/6+MVb0ETOm1N8dAk1RbOuYMgfjcZOnqvt8T+r/wfYdOj59uEgpmbvbvRkozx1CTc8D/VU3EIG4vq1LdFOjCngRmUGGuIp9wJZ2nnCW8YTueT1g0q8IFN90xWL5RX8btpZAzZU0TQYO0zydZGNJ1vz0KOKuOf3KgEAwApAj+BNtcBZA8S5h4KZ318OsQ3xVGT21TQaZcisnVXa2VUQmJDDuUwFOio4L1B8drFv7tmfyocNR2/sqHzK3A0ZS3gt7/y7useJvdCtLJTnv1nwqcmcUIs63tZ/U0SYsnK8nFOwazGy2VKn4TUkT1vRfVLtqoxF2LPUeebrHHGj3slD7XfUZg3fRRkNC4TGkaQQiz2aBhVazbTCG4GVQWuyzyi6oWKXS+gYCM0i1ELUczM3xGsO0/QXVJs2/d0jJQxcNcygnGbyJ8oP87iOMt4KZU973mqLftYpgyk1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25TUysrYVI2WnYvZ0d2LzVsZmlBa1QwMW1sRkl5ZGV5YlVrYXh5VnVaSGg0?=
 =?utf-8?B?R1EwQ24ycVpJRlh6NHRicjdQOHN4Z25rSkFpZGl1UFNRZFVVdFB6NjV1STJ0?=
 =?utf-8?B?QkRDQzhHaWt3eGxFWFRndldsTVlaYlc1SjhHYWNvVU5pdHQxdW9ORFVZeVhw?=
 =?utf-8?B?WVc2a1I1b2F1VEpYOFlxL3FFakoyQVVLTjQ3aEd3Um5oSStxMTduQUFZNlBZ?=
 =?utf-8?B?eWhIQUxOVVJRWkl3YUNJTVNnblJJQ2VUUGdzWUd2cFFNTWVGSEo1NzF0Tkdw?=
 =?utf-8?B?U3NGVVJGVUh1SVUxOVBBVWpYb2pQRU9UY0lseTl5OG1TWWF5RllPS2xuMVhT?=
 =?utf-8?B?T0FOdEMvY0JPcko0cWxrek1JdWdWU21NdHkyWjVkZjNQcGQ5c241N2lyb0hN?=
 =?utf-8?B?MXp1dk14bkRzNGxqRlB4K3B3dDB5TGpLblVsZXhCZzJIUnAzREdBdTBtb0xI?=
 =?utf-8?B?UHhUWDBWVDJ5RHplZWJHczRZbE5FOU1lT0pJalJQYUswQ0l6am9KWFpraU5E?=
 =?utf-8?B?eVBUc0hOT3BNWjJrZUozMGdqcUR1YTdYNGg0dTZmR2VTZUlscUZkSy9lQ0ZT?=
 =?utf-8?B?aXRuRnVxam9XL2dONzVXVDVzc1ROUHZvWG43WXAycGMrY1huL002Yjk1U1dq?=
 =?utf-8?B?cWNYYzdzTFFvc21IdFpIUkpLS1BVUCtnRXdjdThVL0hBS2V3dUNCY280QnBT?=
 =?utf-8?B?b0tzU3MzMjFhM282K1BzMXVqR1V4cldTL0hnQjZJeFpQbkRCYVhlaHR2T1ls?=
 =?utf-8?B?d2Q1VGUvMnBGNHVDUWw1Ny9YTkVKN3JsbFRQRlNFRjFYWHU4UmJxS01Ka203?=
 =?utf-8?B?YWMwVU5uMFdJK05aTU9OeGg4UzkrM2FUa094RWlSR1VZNzY2NXFNNGpTdDRR?=
 =?utf-8?B?UzRJUDRsUUw3T3lhZHN5Vy9FdmlWTnIwOXJ4VmFKSGZnTytQT1lTOFovYXpm?=
 =?utf-8?B?aXNUaUxHQlEwbENUUCtxUVFWMGt1MDFsNENjUTkrUmZ6Qm1wWDc5RkoxZllX?=
 =?utf-8?B?bnN1UGZVRnpsU0xlU1F3d2N0R214Rzg5TkxCdktiVzNaU2prZWxvdVJOYWJa?=
 =?utf-8?B?bk9uaThKaXZtVWVYZlcwOHk3dHRHcUw3QW5ibnVPVHUzUWJjSTJnb29NMzAx?=
 =?utf-8?B?NUIwdGUvdWpXYkNmb1B2cXhEZmdwMXRVdFV3RHBUZUdyclJrZlNXN29EaFBS?=
 =?utf-8?B?R0NZRGdlUE95aGk4UGFFbzhYUkdDWFdTQURSMm9KYzQ0YWl6YWNKUk56Rzd4?=
 =?utf-8?B?bXNmVXNXeGlnNTRZU3gxWlBZV3cvemhsMGpTL0RHQ1JQNlJnRUU0ZXRsL2Z6?=
 =?utf-8?B?SHpwQ0luZE5XeENYaHhySFhuaDhjVWdtdmtzMkZZWXBPb0dKSXYwUS9Tc0w4?=
 =?utf-8?B?VWZYTUJFcTN5QVZjdGYzRkppVmNQblorQmZZMWdpR1VEWXk5SDZVNUJvZmh6?=
 =?utf-8?B?OGtycHNwTXMvdEZhc0M5bWE3RFkvYUQxa1pKTC8yb0ZNV3p5WUZvY1lDSWdS?=
 =?utf-8?B?U2l1Y01PMEtPNEd5Q2FoSFJ2SnFveDlvVkpjeGZweWx6bVU1d2JaRkZSM3JN?=
 =?utf-8?B?cW5YdlkxdkVCbHJ1dHM1bGE1TERJWlR6b0Mrd0FJdGx3dmM5WEo2QjRRcW1v?=
 =?utf-8?B?TU1JNTBMdXYzczlYTHRhcStOSTh2Ymthci9mZzF6cjB4YkUzOHdRM29ueHZO?=
 =?utf-8?B?WGN5OUZuVURvMDBhNnNJdUloYTNPdmJsa0xKL0c3V3lMYUhqM0pkTmx2SzlW?=
 =?utf-8?B?eHdLL0F3RmVGT3BDdk5WSEZZdnpyMHduMU4wZGhzbnNyMnlwU3BVSGx4TVlI?=
 =?utf-8?B?S2tiOWQvQWZUTy9NMWJFZTJiTG9DN0doUTgxSDlmQjZLMlM0SjR5ak5sU0Ry?=
 =?utf-8?B?TUpTZUdUd1dCbHltNGxPVmc3SGtYTjBPbGNaV3ErVWxvcHhNdUZKSFg3TnY1?=
 =?utf-8?B?dkY4S2hkNFg0ZjhwR2cwR3E1UEpTdklnSklCV1pwNm1TNGU2N0h1b1p4SG5u?=
 =?utf-8?B?R1oxMG93ZUNhd1I5UEF4a1dkbnRmVlNCQWhRQjllTmhOTUl0Vk9tQWo0WWF2?=
 =?utf-8?B?SzFmcjYwRXZHczR1d2ZXMzN5aXllK1hBaFlPckZ6RktaQnhoNDgwcGFIRUNi?=
 =?utf-8?Q?kk5pyNZoBWgYwqEsJ0fo/vtNC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab70d7c8-a3ad-4975-04a2-08dc3ef5f54d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:28:48.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Q4fDw/XQAniHMCfz/4aXxSdrWzN2mJ2z5vbj4JTRyg9qh3TVxJMnvK/jd7d89nigNMFtQ238aDC33WAo8sLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

On Mon, Mar 04, 2024 at 09:48:56PM +0300, Serge Semin wrote:
> On Fri, Mar 01, 2024 at 10:08:16AM -0600, Rob Herring wrote:
> > On Thu, Feb 29, 2024 at 02:26:34PM +0300, Serge Semin wrote:
> > > On Wed, Feb 28, 2024 at 06:39:36PM -0600, Rob Herring wrote:
> > > > On Wed, Feb 28, 2024 at 10:23 AM Frank Li <Frank.li@nxp.com> wrote:
> > > > >
> > > > > On Wed, Feb 28, 2024 at 10:03:46AM -0600, Rob Herring wrote:
> > > > > > On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > > > > > > > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > > > > > > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > > > > > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > > > > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > > > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > > > > > > > >            const: config
> > > > > > > > > > > > > > > +        - description:
> > > > > > > > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > > > > > > > +          const: msg
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I do think it is a bit questionable. Ideally, the driver could
> > > > > > > > > > > > > just configure this on its own. However, since we don't describe all of
> > > > > > > > > > > > > the CPU address space (that's input to the iATU) already, that's not
> > > > > > > > > > > > > going to be possible. I suppose we could fix that, but then config space
> > > > > > > > > > > > > would have to be handled differently too.
> > > > > > > > > > > >
> > > > > > > > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > > > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU.
> > > > > > > > > > > >
> > > > > > > > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > > > > > > >
> > > > > > > > > > > @rob:
> > > > > > > > > > >
> > > > > > > > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > > > > > > > detail direction?
> > > > > > > > > >
> > > > > > > > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > > > > > > > property:
> > > > > > > > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > > > > > > >
> > > > > > > > > > So basically Rob meant back then that
> > > > > > > > > > either originally we should have defined a new reg-name like "atu-out"
> > > > > > > > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > > > > > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > > > > > > > or, well, stick to the chunking further. The later path was chosen
> > > > > > > > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > > > > > > > above).
> > > > > > > > > >
> > > > > > > > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > > > > > > > TLPs, etc are all application-specific features. Each of them is
> > > > > > > > > > implemented based on a bit specific but basically the same outbound
> > > > > > > > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > > > > > > > of view it would have been enough to describe the entire outbound iATU
> > > > > > > > > > CPU address space and then let the software do the space
> > > > > > > > > > reconfiguration in runtime based on it' application needs.
> > > > > > > > >
> > > > > > > > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > > > > > > > region. We can reuse this name.
> > > > > > > > >
> > > > > > > > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > > > > > > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > > > > > > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > > > > > > > mem region. We can config each region size by module parameter or drvdata.
> > > > > > > > >
> > > > > > > > > So we can deprecate 'config', even 'ranges'
> > > > > > > >
> > > > > > > > Not sure I fully understand what you mean. In anyway the "config" reg
> > > > > > > > name is highly utilized by the DW PCIe IP-core instances. We can't
> > > > > > > > deprecate it that easily. At least the backwards compatibility must be
> > > > > > > > preserved. Moreover "addr_space" is also just a single value reg which
> > > > > > > > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > > > > > > > regions.
> > > > > > > >
> > > > > > > > The "ranges" property is a part of the DT specification.  The
> > > > > > > > PCI-specific way of the property-based mapping is de-facto a standard
> > > > > > > > too. So this can't be deprecated.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > * Rob, correct me if am wrong.
> > > > > > > > > >
> > > > > > > > > > On the other hand it's possible to have more than one disjoint CPU
> > > > > > > > > > address region handled by the outbound iATU (especially if there is no
> > > > > > > > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > > > > > > > in HW manual). Thus having a single reg-property might get to be
> > > > > > > > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > > > > > > > What about just extending the PCIe "ranges" property flags
> > > > > > > > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > > > > > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > > > > > > > use the flag to define a custom memory range for the TLP messages
> > > > > > > > > > generation. At some point it can be also utilized for the config-space
> > > > > > > > > > mapping. What do you think?
> > > > > > > > >
> > > > > > > >
> > > > > > > > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS,
> > > > > > > > > all IORESOURCE_* bit need move. And it is actual MEMORY regain.
> > > > > > > >
> > > > > > > > No. The lowest four bits aren't flags but the actual value. They are
> > > > > > > > retrieved from the PCI-specific memory ranges mapping:
> > > > > > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > > > > > > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > > > > > > > Currently only first four out of _sixteen_ values have been defined so
> > > > > > > > far. So we can freely use some of the free values for custom TLPs,
> > > > > > > > etc. Note the config-space is already defined by the ranges property
> > > > > > > > having the 0x0 space code (see the first link above), but it isn't
> > > > > > > > currently supported by the PCI subsystem. So at least that option can
> > > > > > > > be considered as a ready-to-implement replacement for the "config"
> > > > > > > > reg-name.
> > > > > > > >
> > > > > > >
> > > > > > > Agree. But still, the driver has to support both options: "config" reg name and
> > > > > > > "ranges", since ammending the binding would be an ABI break.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Or we can use IORESOURCE_BITS (0xff)
> > > > > > > > >
> > > > > > > > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > > > > > > > #define IORESOURCE_ROM_ENABLE           (1<<0)  /* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > > > > > > > #define IORESOURCE_ROM_SHADOW           (1<<1)  /* Use RAM image, not ROM BAR */
> > > > > > > > >
> > > > > > > > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > > > > > > > #define IORESOURCE_PCI_FIXED            (1<<4)  /* Do not move resource */
> > > > > > > > > #define IORESOURCE_PCI_EA_BEI           (1<<5)  /* BAR Equivalent Indicator */
> > > > > > > > >
> > > > > > > > > we can add
> > > > > > > > >
> > > > > > > > > IORESOURCE_PRIV_WINDOWS                 (1<<6)
> > > > > > > > >
> > > > > > > > > I think previous method was more extendable. How do you think?
> > > > > > > >
> > > > > > > > IMO extending the PCIe "ranges" property semantics looks more
> > > > > > > > promising, more flexible and more portable across various PCIe
> > > > > > > > controllers. But the most importantly is what Rob and Bjorn think
> > > > > > > > about that, not me.
> > > > > > > >
> > > > > > >
> > > > > > > IMO, using the "ranges" property to allocate arbitrary memory region should be
> > > > > > > the way forward, since it has almost all the info needed by the drivers to
> > > > > > > allocate the memory regions.
> > > > > > >
> > > > > > > But for the sake of DT backwards compatiblity, we have to keep supporting the
> > > > > > > existing reg entries (addr_space, et al.), because "ranges" is not a required
> > > > > > > property for EP controllers.
> > > > > >
> > > > > > I don't know that its worth the effort to carry both. Maybe if it is
> > > > > > useful on more than just DW host.
> > > > > >
> > > > > > I believe we had config space in ranges at some point on some
> > > > > > binding and moved away from that. I forget the reasoning.
> > > > >
> > > > > I can alloc a 64k windows from IORESOURCE_MEM windows to do 'msg' windows
> > > > > in dwc host driver in v4.
> > > > >
> > > > > But I think it is wonthful to discuss if we can extend of_map bits, add
> > > > > more type beside CONFIG/IO/MEM/MEM64.
> > > > >
> > > > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > > >
> > > > > phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
> > > > >
> > > 
> > > > > There are '000' before 'ss'.  If we use it as dwc private resource.
> > > 
> > > Frank, why do you mis-inform about the idea? The point was to use the
> > > ranges property for:
> > > 1. PCIe Config-space mapping.
> > > 2. PCIe TLP messages region.
> > > There is _nothing_ DWC-specific in the original suggestion. Case 1 has
> > > already implicitly defined by the DT standard, see the link above (but
> > > for some reason hasn't been implemented in the PCIe subsystem). Case 2
> > > hasn't been determined, but could be seeing there are three unused
> > > bits in the ss-code of the phys.hi cell. All of that can be used by
> > > _any_ PCIe RC/EP device.
> > > 
> > > > 
> > > > DWC (or any host controller) specific things? No!
> > > 
> > > Rob, could you please dive deeper in this thread? The idea is to use
> > > the "ranges" property for the "config" (PCIe config space) and the
> > > custom PCIe TLP messages regions.
> > 
> 
> > I did in my prior response. Here, I was just making it clear that 
> > something host controller specific is a non-starter as you did.
> 
> Not sure what exactly you meant by "host controller specific". Did you
> mean a particular host-controller or all the host-controllers? I meant
> that the "msg" range could be used by _any_ host-controller, but the
> usage would be platform-specific indeed because the message-type depends on
> the peripheral devices.
> 
> > 
> > For config, we had some bindings that did this and we moved away from 
> > it. I don't remember the details. Unless it's ECAM region, I don't think 
> > using ranges makes any sense as how to use the region will still be host 
> > specific.
> 
> Could you please elaborate why exactly the config-region would still
> be host-specific? Strictly speaking the normal MEM or IO region is
> also host-specific because what lays behind depends on the attached
> device and the enumeration procedure. IMO the reason of not using the
> 'ranges' for the config/ECAM space would be in opposite to what you
> said.  Unlike the CPU-to-MEM/IO mapping the ECAM/config-space is a
> pre-determined _linear_ space with in most of the case no need in
> special space remapping (unless we would wish to map particular
> peripheral device config-space). So normal "reg" is enough especially
> seeing the config-space is a set of registers. (Please correct me if I
> was wrong.)
> 
> > 
> > For TLP messages, do we have other hosts that could use ranges for them? 
> 
> AFAICS the next controllers might also be able to generate the
> messages via the outbound AT-memory:
> Rockchip PCIe controller (see pcie-rockchip.h AXI_WRAPPER_* macros)
> Cadence PCIe controller (see pcie-cadence.h CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_* macros)
> Mediatek PCIe Gen3 controller (see pcie-mediatek-gen3.c PCIE_ATR_TLP_TYPE() macro)
> ...
> although I am not absolutely sure.
> 
> > Is there something in the PCIe spec that defines TLP as an address 
> > space and what that address space looks like? IIRC, some hosts (Altera?) 
> > just have a message sending interface and that includes config space 
> > accesses.
> 
> I already sited it in the message to Frank here:
> https://lore.kernel.org/linux-pci/pprkba3ygxwv4lzieu5spqamcn2gzdcviv4kb2kzkzam4fbhit@6uqtmevzm5uj/
> Here is an excerpt from there:
> 
> < Note paragraph 2.1.1. of for instance the PCIe-4.0 spec:
> < 
> < 2.1.1  Address Spaces, Transaction Types, and Usage
> < "Transactions form the basis for information transfer between a
> < Requester and Completer. Four _address spaces_ are defined, and
> < different Transaction types are defined, each with its own unique
> < intended usage, as shown in Table 2-12."
> < 
> < Address Space     | Transaction Types    |  Basic Usage
> < -------------------------------------------------------------------------
> < Memory            | Read/Write           | Transfer data to/from a
> <                   |                      | memory-mapped location
> < I/O               | Read/Write           | Transfer data to/from an
> <                   |                      | I/O-mapped location
> < Configuration     | Read/Write           | Device Function config/setup
> < _Message_         | Baseline (including  | From event signaling mechanism
> <                   | Vendor–Defined)      | to general purpose messaging
> < 
> < So basically the PCIe-spec defines four _address spaces_. The
> < _message_ space is one of them. Seeing the "ranges" DT-property is
> < about the space-to-space mapping IMO there is nothing wrong with using
> < it for the _message_ space mapping.
> 
> As you can see the MEM, IO, config and Message are defined as address
> space. Looking at the message request description in the spec, there
> can be various types of the messages. All of them are listed in "2.2.8
> Message Request Rules". Some of them can be routed by _address_ or
> _ID_ (BDF), but some of them can lack of any address/ID field. In
> accordance with the "Table 2-17: Message Routing" footnote there is no
> message requests defined at the moment with the Address-based routing.
> In the meantime for the address-less messages there is no address
> translation needs to be performed, thus having the ranges-based
> mapping would be just pointless for them. But if we had a message
> request defined with the address-based routing then it might have
> required a mapping similar to the MEM and IO ones.
> 
> Anyway giving to all of that a second thought, I more-and-more getting
> further away from my original idea of having the config and message
> region mapped over the "ranges" property. There is no actual address
> translation performed at least in the second cases. So using the "ranges"
> property for it would be pointless indeed... ( But originally the idea
> seemed very attractive seeing the PCIe-specific "ranges" property has
> unused mapping type flags and permitted special address format...
> 
> 
> Let's get back to the Frank work then. What would you suggest as a
> good solution? There are two options at the moment:
> 1. Define DWC-specific "msg" reg-name with a peace of the outbound
> iATU space which would be used to generate the messages. (thus
> implementing the same approach as being utilized for the config-space
> mapping).
> 2. Manually, in the driver, reserve a peace of the CPU-to-PCIe-MEM
> "ranges" region and have it utilized for the message request TLPs
> (implemented in this patch).

link: https://lore.kernel.org/imx/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com/

> 
> The later one seems less safe since the entire outbound iATU range
> could be dedicated for some platform-specific means. So reserving
> a peace of it will cause problems in those platforms.

@Rob, @Bjorn

Please help comments about options: 1 and 2

Frank

> 
> -Serge(y)
> 
> > 
> > Rob

