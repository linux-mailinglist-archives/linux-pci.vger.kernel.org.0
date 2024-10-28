Return-Path: <linux-pci+bounces-15463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F69B36B7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E595E1F22802
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7576F1DEFDC;
	Mon, 28 Oct 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nNBWpM6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013028.outbound.protection.outlook.com [52.101.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25681DEFD0;
	Mon, 28 Oct 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133499; cv=fail; b=Xlajik8GZPIgIYBuN42XLuHNL6tbLOcUlMyBm1y+Fw8Wj46+hph0pIhm8ywi/+5jAyKOlJCLHJk6e/PyBu3mRD/y4rb3BQjwOlpjGWB+Y+wq0lg9EMc1IRHSmR8tjT9/Sbq71/+SdFoyJA6JyqzBgO3GgjYc2PkKDGqYVTAImqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133499; c=relaxed/simple;
	bh=v0ftlBRkez8up9GwntsXAv3NfegaZulBvA6/fP2fT1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rgsFWCpE1q2/gRDmU0eMh1W1aJpp9VLtEdXNzvTXmcyGr0KXPQOyEl74CWb08kJ1pY7jgAr3/enfQtpRXQRO+JeWBqNC2kH/uTRiJ61AsJu3Y+ne2ChXUcixfl/OecyKjOGIwcN3aiwt/QbBHqRfW+fu13MlL7MvTYA33Jf3t90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nNBWpM6N; arc=fail smtp.client-ip=52.101.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dnm1yvScaeNswv2g6X1L6EorkANZmFicQeUE8UFAW3HVb3/qVeXrvt3RckQTN4FOGtvkHTlcIsHW/HzPlwQUVk5f0wmdiSpB473kvK4JeI7akykKfbgkbylQQ+81XsrbmeLptnCVK0FgebUfpw/1lBz4eCdIBezsvMhD/p+DnxXt6qNG7UJkwBepuq725eGZVTrMJXm5s+enT4dFhEuCqySEzqA8fuzcRqbymlxK1MYlufmJ4dwQZdBfrqUKsg50kolZGRTwHOw3fvNbDKlPDErSROFb/oxaqu0b0hKvwcE0O5NG79KyXPZfCKYIVpwQzZWNf4HUya/TiuVYsBZ0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnkJYxy+1qPDQGbMHtuP5+FNQYSOUxVfdH9aFjUX1rk=;
 b=e6YYE5PBc2cfpbfZmYFN3UDcEEX+eCBoTWCpug4gTXmGVV8KL7JAdJWtPQSuVBWj6dPZzPKvfEeQf0LWeW68cRxuA7fpuToM+2FXtd2xrf/H0H4BoWSdupSkL1Fy5eXKEmJmu0C2I2pizijTa/iJqRWbkaN4T90I2k6eEvROHjOmyNJrkanJbwrn6326BGj2CCBpyy81DsrZ7VbnH2J8pAKwCqMJ6ecXg6BhuaKWP+STYj5TrANFXQKZBxUZCiOrawCJTG5dEi90e54WySFxOlqhBAv5vYnm5hctpg99lb2VhtCnR9oEBP9CMUYwkji1bJs1x/2ukldEDW3yuGgpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnkJYxy+1qPDQGbMHtuP5+FNQYSOUxVfdH9aFjUX1rk=;
 b=nNBWpM6Nmvh3p4hzE9PVWCUDj05QBtH4wqgav2IeJndb91FuVdEM/wIrAQqG4aL3UVLGE6R6HmWyCL/Dd9o9ZTo+xT1tu8jCsb7Csc8mglnccfEIogXJ4bAHsexoeE4murrKLeEqPElv26glO8CgFJikzf/Fh4Z39tQUP8qD8d0LZU2/Ig7uOPnQG8yXgCmSCOVca2NB1l2ADIVP2G8Ct7NvjHpDkiMtgPX22tzP6hOj8ZdTigrFXxzQxULCCVjkgcz2pnP9V1gSkgSHjM63kf8msNUw/wMNKwuIiBMUMPA15q7IEgLL6ahcMBkQ6/ZWxDL3EQwH6L0CBKKqb9vSyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 16:38:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 16:38:12 +0000
Date: Mon, 28 Oct 2024 12:38:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Subject: Re: [PATCH v4 1/4] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <Zx+96SEUUN57SPTU@lizhi-Precision-Tower-5810>
References: <20241024-pcie_ep_range-v4-1-08f8dcd4e481@nxp.com>
 <20241025223102.GA1029107@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025223102.GA1029107@bhelgaas>
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c5b416-d654-4032-e22d-08dcf76ee9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a29XQ3JCcGFWUWVZOUtNTTlhWkJJZ0R3dThRcHhBZXNDMVpHNTI2RHQvSVRR?=
 =?utf-8?B?UkNWZVNHMEJqMjI4OVZvTHR0VEoxMVBpWUpmUmJJd0xIclZkd1JNdFdlM0hQ?=
 =?utf-8?B?blUrOE1wRGw2YWFRc2FjcDVqYWFzbUcrVktycXh1c1RZVW0rWElPajBrRnNW?=
 =?utf-8?B?Qm1rYkZ1U3k2NHRxNWpzMDNBNTMybFVqMWlZS3ZWWWFVeEtGQjYxUHlTbTZ0?=
 =?utf-8?B?cmlPc0JXQnQ1Yk9mRDVuZldrY2RZdjNzalNoWGNwbGN6bzNIOGk0Z3pjcVB1?=
 =?utf-8?B?ekJob3gyOFQ1Ulk2dWdOdzJjMGR3Rjlmak12WjhjeGYzWUxxZ010R0YrTmNE?=
 =?utf-8?B?d3NOL25HOTVobERkV0tJcjdVTi9lZDc2ZlZCbGF6RTkxYUN6a3Q2eldXMHdR?=
 =?utf-8?B?a09mako2ejNucVVCNktHVUNlSlplUndIWVRsOFZZL0djL0dlQlRGVXNPMjRL?=
 =?utf-8?B?bWtlcm5KMTRsUFpsbTU2eFA0OGZ3b0NRTU52SXZtcEhyQXBieCtBZkorejlP?=
 =?utf-8?B?d3N6b2tQajdTekNmcjYzVHZCMTd1clJaQ2c0aUF1U0FZaWVITm9TM2tKSVhz?=
 =?utf-8?B?TWdYUHE4RVJVMm5vcnJsNGxoN1FiRU41U3k1SUYvaWo0czFUeGFEUlZaZTFq?=
 =?utf-8?B?NXJrb1Z4UnlpOVQ2bCtMSmdCYk0wSitwNFFmTm5aRitESHdlc0R2bUJ1SGt3?=
 =?utf-8?B?UWdNUTk0Uy8yQ0dhVXdGSkV6WWJNMVEyNXlMRUdVRFVobDI3Yys2bC9tRW1l?=
 =?utf-8?B?RzRJTWljeGsrazdjeW1BS28vNXo4VEJMZmJlL2t3QUJmS2phNGM1MHgyQlB1?=
 =?utf-8?B?ditpUnhVY295WlNUQzY0Y0Fmdk1CNk1Kd2VZeWl1a3dTdHludE52VGoyNUpK?=
 =?utf-8?B?K1RpKzVDamRWc1MzcHBOVm9TZyszTVpjRTdGR0lvc3Z1N0lGOXNWSlNtbGsz?=
 =?utf-8?B?ZHBhRi9ZNkhJbVhReW1pRSswT2FiTGdWWmd0NzU5M1NnajZpbmFoTXNVRlA5?=
 =?utf-8?B?OU9aWnlDRWdmTHhCbzhGcjBRYSt1ektPZStsUlo3VWZ3Y2ZyZFZ1b21VT1dn?=
 =?utf-8?B?Nlo2L0pyS3JVd0ErMFZ0N2hCeGhOZ1gxckRsamxVckhSQlBNZXorc2ZqTjU4?=
 =?utf-8?B?RytUVkh4T1Q0ODFrU1lkdGIyZlF5TmJSN0RJR2NxTjRGSGRnY2gxZW0wSmlT?=
 =?utf-8?B?Ym13U2Y3RENGUWpJVUQzZjJWdlh4blBCWGgyajJTRHk1Q1IybngwVGhjWGtF?=
 =?utf-8?B?bitNSmRKRnpYSGd3c0dxZmJKZW8wODNKZWhUSTFTZUVFeDM3RFZCczhLaHo5?=
 =?utf-8?B?Y3NUZWdPU2JwK2JBdHZqRGRXWXVaYUM1RHgxUDVVSXliNG5IaFRBVG9Yd1Jt?=
 =?utf-8?B?eWpkTE1pTUNiMjFkVjJtWWhGSWlHS2JodmZmVDdWcDM4Y3ltREtYZENTbUpU?=
 =?utf-8?B?ZWJQMHhrUStka2hDMHUzQUdnYlVsZVFzTkZDa0xDQnA3bTFZdUh3V0hQMEF3?=
 =?utf-8?B?dG0xU1JWeG8vZXFENVpENVNIZGdYaGZxVTdEL2tWQ0pocy9LeU0vNGMrc1Fp?=
 =?utf-8?B?M21rek1TenBwWkhlamNzOGkzRWJ4dDgwM1l6REtTZWF6V2U1Y2tMcFJXZTBY?=
 =?utf-8?B?ZWZzWDd1aWVMWE84MzVGakRCcGlTWVFKbDVERXVCNTN5T0k0bEZhU25ab0pu?=
 =?utf-8?B?cXpqbGJPU2FhY2dpMlg2d1g0andvUW1RZVVSRyt1OFFvVFR2VzgzckRMTFJw?=
 =?utf-8?B?aThRMFNCN2lMb3ZoSXN4MXQ3RTIwUzFNNE96UEdqTEdaR1J3SW9NNUJDd3NN?=
 =?utf-8?B?MFM4NXFYOW9MRnVQRmIxckNLWHUwRnFiSVh6OXJ2cTlPUlFOSGRqTTdHS0Yw?=
 =?utf-8?Q?IkoF9LAeAkW5U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW0xK0VuWHN0QXk3UEd2NWtKRGhUNGZqWEJLaC96UVdJeW9UUklBbnpsb1Mr?=
 =?utf-8?B?am1VNTZiSlZyT1p0UFcxZ2x6TW5tcHNDMWM3VG1XaU1kZmFUNDJ3RUhnYUE5?=
 =?utf-8?B?ZnB5bWZaRUpKYS93UzREbGF3L1NVd0ExSk9uTC8rSmh5MEZ3MVQrMHFFUTQy?=
 =?utf-8?B?RUJFNnN5SnpmMnFiY1hmRFBncEIrbTBsVGF1UmhTc2xEd3Vzcmtiem02VS9P?=
 =?utf-8?B?ZWZ6N0JqZHhXWlI4MHJCVTkwcFRrYi9jeEhzUnoybTFIazZpVE1CU1ZXZk81?=
 =?utf-8?B?azlXWEIvMmF5VU9uTUZ4cjA2YkhYRkdVRVpwYkU2TmlMVWsraGRuWG0zQWdo?=
 =?utf-8?B?WTRiMzhEKzg4YWkzNmd6TDREQ1AyV1dJMzhsYmswbnhibGNkT0tvaWd4NnFi?=
 =?utf-8?B?cWZEOXdwUDFzK1ZubWMxT21nalZEbkN1ZEJ3MGlWYUxYSnNJeUo0N2UyNTlL?=
 =?utf-8?B?aS9mRGZCU0RTdHBibkFWaVJhZmpMaUpweWhwL0dFaDl2VTEyUGNGM1VhZ1Nr?=
 =?utf-8?B?Q1FmeUo3SDluR3NGblFEb3hhWVJ0UWJlVytwVGVVUnhtTXIvOW41ZGJ0bVRJ?=
 =?utf-8?B?d3kxZGZYOEFSMko4ZG5oTmY1MFg5N3Byc1ZweTZTZ3VEcTE5a0dzSjFXTzVQ?=
 =?utf-8?B?WGlpbkVaMWVqODJ6Z25haFFIZGsrR2U5VWNJT3RLTi9KNVVMQmxzS1hvSTJY?=
 =?utf-8?B?R2RDLzNBY1o0dkRPS1dtaDA3dytuWkJkdjlsbUw1TmdBc1ZxdlF5cVlORjM1?=
 =?utf-8?B?WHF0c2lQbGR3ZUE4OWQyeDgzRXo0ek5RQlhjNjc0M1c1VDdNQU1oOTF1WmVC?=
 =?utf-8?B?eGZ2ajlxdm0yWkgrRXZyZnNUbHFtQmdPQTY2ckx1cjF0dVBvM0liWnlHVWZa?=
 =?utf-8?B?RTYrdTd1ZTNVYURiRTQxekw0SHFYQTVuYU9sV1hnd0JUT2VSTlZvNUUrWXBn?=
 =?utf-8?B?b2Z0R0pFcTJ2aENCdFlyTUhtQjd6MTFOOUowUnhLenhvNXF1UmZxZlJCTjFn?=
 =?utf-8?B?aThVTnZkYjdzRWZCRnpyMXB5ckdDMlBJR09DaWMrYnI3SHpTZTRMZm82M1Rv?=
 =?utf-8?B?NGV0ZzI1TStQcCtXQmVFcU9PbWEyQ28zNUd2MStHVlV6NDB3SFVxdnMweHo4?=
 =?utf-8?B?cHZCN2FpRlNIRC81eXYvNnNMaGlmbzhrSjV4V2dnRkpoU2JIQVR1SVJLa2da?=
 =?utf-8?B?VWdhNk5GQlZlbWwyaUNGZzdLaGZpOWdGOEtZNkNwblhleGU1OWZaZzE5ejA0?=
 =?utf-8?B?dVRIazlhSVNLdjdHSnA5S0Y3QURvUGlpbTJ1V2hyb1RscFQ3ZmJwa0hkMWNa?=
 =?utf-8?B?M0drNExIWUttTXFjRFpXenQzaDUremZHTnZZMTBoeERQVkhNQkJ2UWpzRkpY?=
 =?utf-8?B?cHUrU0J1S0U2N0ZQYzdiWHJocS9nOGtJVEpiblQyVE94Vm5oSi9pajRpZjd0?=
 =?utf-8?B?ZmVXOEF1dGJnS0crMU9vaEg1TWY5eVQ5R0NNSjZEV0FDWXNpMHBXaDNVYU5w?=
 =?utf-8?B?aHNGT0tTaXF1Q1JTN3B0eDN0eDBLcnlwMFhuQXl4SWtlZm8yZGE2MW1LK1A2?=
 =?utf-8?B?V2ZnaTJUczhPTVZURDd5K29EQjJ6UzFNOGNucGIrTkNVb0pYaFlVc2lwOVhl?=
 =?utf-8?B?c2tRMWdvVmFjMWtsZHlyYnROb2pMZmFneFQvMjhkTTVGL0ZmNVhOcFYwVi9h?=
 =?utf-8?B?bjhkTVBmSDRqVzgvc3AwdGpRWlMvV0c3aEdHN3BuM01YSEFtdlFVL3o3UWZB?=
 =?utf-8?B?ZnhFRXZ4RlNRNG0xcmxLTFN4TDh5blNPd3ZySCtOMEI2Q25MTWtNY1RmNW9N?=
 =?utf-8?B?b2EzNVdhdk1ERS9uMnp2b3ViR0ljWXYzTGlCaEVKV0JzcktBUHdDT1diUjY0?=
 =?utf-8?B?L1h3UjV5bU94MGVTK09tcW15VlhkWnhoc3p6b211Nm13LzJOQWhQQWtoa2xa?=
 =?utf-8?B?cGI0UjZqQm9nZmJZWjFFS2RSVHBuamlVT1dWTmh0SXV6dy9CbUYvUFJGcHQ5?=
 =?utf-8?B?ZlI4bmd5TmgxNEZpQVZ4c3hJT0sybm54dXJLdVBRckI5clN4MmhlS2tPbkdK?=
 =?utf-8?B?dk81T0M1T213bjVUNkdRVDFEZDVjZmRvOEE1LzJGZ0Z0OFU1Lzh6emxmOThq?=
 =?utf-8?Q?mGja47YZ1rJAt4LcKqFNpP1fL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c5b416-d654-4032-e22d-08dcf76ee9ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 16:38:12.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDTPuwTs2zJKUpQ7rEQ7ctMUzx3TSBU5xnMrhEqR5LaMCAbANP1Jo/Z0Gcp2oCl3WB4CdXrvvvBEI6JGWWKoXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9422

On Fri, Oct 25, 2024 at 05:31:02PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 24, 2024 at 04:41:43PM -0400, Frank Li wrote:
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
>
> Thanks for the diagram and description.  I don't think the top half is
> relevant to *this* patch, is it?  I think this patch is only concerned
> with the address translations between the CPU in the endpoint and the
> PCI bus address.  In this case it happens in two steps: the bus fabric
> applies one offset, and the ATU applies a second offset.
>
> Unless the top half is relevant, I would omit it and simply use
> something like this:
>
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │                ││
>   │           ┌──────────┐      │                ││
>   │           │          │ Outbound Transfer     ││
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
>   ││     │    │  Fabric  │Bus   │                ││PCI Addr
>   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
>
> If you don't want a big "Endpoint" box including the CPU and bus
> fabric, that's OK with me, too.  I added it because everything on the
> PCI side only sees TLPs that contain PCI bus addresses, and can't tell
> anything about the internal implementation of the Endpoint.
>
> > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > the device tree provides this information, preferring a common method.
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie-ep@5f010000 {
> > 		reg = <0x5f010000 0x00010000>,
> > 		      <0x80000000 0x10000000>;
> > 		reg-names = "dbi", "addr_space";
> > 		...
> > 	};
> > 	...
> > };
>
> I guess bus@5f000000 includes a "ranges" property because that
> translation from 0x7000_0000 -> 0x8000_0000 is fixed or at least
> not touched by Linux?

Yes, it is fixed by hardware.

>
> And the pcie-ep@5f010000 address translation from 0x8000_0000 to
> 0xA000_0000 *is* programmed by Linux and therefore can't be described
> by a DT?  But I guess Linux only programs the *PCI* side, and the
> parent side (0x8000_0000) is fixed?

0x8000_0000 -> 0xA000_0000 is programmed by Linux RC side host driver tell
Linux EP side driver how to map it. 0x8000_0000 is fixed MDIO space.

>
> AFAICT, the "reg = <0x5f010000 0x00010000>" part is not relevant here.

Yes.

>
> I guess this implementation assumes there's only a single aperture
> through the Bus Fabric, right?
>
> And also a single ATU aperture through the endpoint PCIe controller?
>

There are 8 ATU provide by DWC PCI controller. Bus only provide a big
PCI map windows for example, 0x8000_0000..0x9000_0000.

we can slip it up to 8 small region, such as each 64K,  each region can
map to any PCI address by ATU.

0x8001_0000 -> 0xA000_00000
0x8002_0000 -> 0xB100_00000
0x8003_0000 -> 0xD000_00000
...

This part EPC driver already handle it. EPC driver only need know
"addr_space" information by above sample dts.

> And also that there's only one layer of Bus Fabric address
> translation?

Doesn't metter, but PCI controller only care about closest one. Others
translation is tranparent to drivers. As above example, PCI EP controller
only care about input address is 0x8000_0000,  and cpu send out address is
0x7000_0000. Even there are more translation,
0x7000_0000-> 0x9000_0000->0x8000_0000,
  ^^^^^^                   ^^^^

PCI EP controller only care input (0x7000_0000) and output (0x9000_0000),
don't care any internal translation (0x9000_0000).


> The fact that only a few DWC controllers have this
> translation suggests that this part of the picture might be external
> to the DWC IP and there could be more variation.  But I guess there's
> no point in adding code for topologies that don't exist; we can deal
> with that if the need ever arises.

Some cdns also have the same situation.

>
> > 'ranges' in bus@5f000000 descript how address convert from CPU address
> > to bus address.
> >
> > Use `of_property_read_reg()` to obtain the bus address and set it to the
> > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> >
> > Add 'using_dtbus_info' to indicate device tree reflect correctly bus
> > address translation in case break compatibility.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3 to v4
> > - change bus_addr_base to u64 to fix 32bit build error
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> >
> > Change from v2 to v3
> > - Add using_dtbus_info to control if use device tree bus ranges
> > information.
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h    |  9 +++++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 43ba5c6738df1..81b4057befa62 100644
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
> Tangent: Maybe dw_pcie_ob_atu_cfg.cpu_addr isn't exactly the right
> name, since it now contains an address that is not a CPU physical
> address.  Not a question for *this* patch though.

yes, cpu_addr is not good name altough it is correct for most system.

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
> > @@ -873,6 +875,16 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return -EINVAL;
> >
> >  	ep->phys_base = res->start;
> > +	ep->bus_addr_base = ep->phys_base;
> > +
> > +	if (pci->using_dtbus_info) {
> > +		index = of_property_match_string(np, "reg-names", "addr_space");
> > +		if (index < 0)
> > +			return -EINVAL;
> > +
> > +		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
> > +	}
>
> If this translation were fixed, I suppose we'd extract something from
> a "ranges" property that contains (child-bus-address,
> parent-bus-address) information.

Yes, see below
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

> So I suppose "addr_space" contains a
> fixed parent-bus-address, and is setting the child (PCI) bus address,
> right?

"addr_space" hold PCI EP outbound MDIO space, which is parent-bus-address.
it is confused if called as PCI bus address, which most likely the address
after ATU covert.

bus@5f000000 {
     compatible = "simple-bus";
     ranges = <0x80000000 0x0 0x70000000 0x10000000>;

     pcie-ep@5f010000 {
             reg = <0x5f010000 0x00010000>,
                   <0x80000000 0x10000000>;
             reg-names = "dbi", "addr_space";
             ...
     };

History reasion, PCI EP use reg-names "addr_space" indicate outbound
windows informaiton.

>
> If so, I might add a comment here for other readers who come this way.
> (And me, because I won't remember the next time I read it :)
>
> >  	ep->addr_size = resource_size(res);
> >
> >  	if (ep->ops->pre_init)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 347ab74ac35aa..f10b533b04f77 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -410,6 +410,7 @@ struct dw_pcie_ep {
> >  	struct list_head	func_list;
> >  	const struct dw_pcie_ep_ops *ops;
> >  	phys_addr_t		phys_base;
> > +	u64			bus_addr_base;
> >  	size_t			addr_size;
> >  	size_t			page_size;
> >  	u8			bar_to_atu[PCI_STD_NUM_BARS];
> > @@ -463,6 +464,14 @@ struct dw_pcie {
> >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> >  	struct gpio_desc		*pe_rst;
> >  	bool			suspended;
> > +	/*
> > +	 * Use device tree 'ranges' property of bus node instead using
> > +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> > +	 * reflect real hardware's behavior. In case break these platform back
> > +	 * compatibility, add below flags. Set it true if dts already correct
> > +	 * indicate bus fabric address convert.
> > +	 */
> > +	bool			using_dtbus_info;
> >  };
> >
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> >
> > --
> > 2.34.1
> >

