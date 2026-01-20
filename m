Return-Path: <linux-pci+bounces-45289-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BIpGBDPb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45289-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:53:04 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3A49D4D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD5C8849293
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAC34BA3A;
	Tue, 20 Jan 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mC7GZyFu"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779F34B69B;
	Tue, 20 Jan 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927748; cv=fail; b=n5mQNj7GJR9F/9VVdceqnO9Aou4giGMmuVlmroeOmndS1NChEdrjXDOO+03Vrq8a5OquxrQePGs1NwSB99gHcHbd+n8cmOKi20VsMT1LS5uCbyZi/SenKMwhOg0DZ4tapVGiv5ov5A1hSDokCcQbqICXTmzHnO7mr6wXNX6brI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927748; c=relaxed/simple;
	bh=7YwqsOXv4ug3ShOIXva1lJ58FlAqRy7nk/92130gAiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GFtj9ByUja/SfUW932ZtD5cqEzCqgLJHMAWWpGpyaYf1jj+sUjcz6MlaemNyTgA4VozwmzHJE3d6SxKBsaRcea0RzR8qRO9E5Vk3/+inyPnGr6K2owtT2dj+OvVymVMLc3fpy17sWKjSqUZV3YsVz8g3fo5cfDyYSOGw+T6QYpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mC7GZyFu; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AG3M4TqCO7stEJC2GCDpLkBg43Uant6I6wfr3v5VgxOuV1OlRK+UFr7Ct2uGu5y5L2ZaszcT9YMDYWwlmBxglxw3ja1PNW/kk8+sKjs1goixL2ZmFR5OspkiwA5bIgz6Cjkjn3KV+5kYfAya4gYP/Zvu+L5IqqsZR+S2cYPQMSMuBHjWbmyMvaFNnAoLX2EOPmck7gYBTblwpk0OTvciAsyXIsRDT4Th6e+07Fo3VfXkPQ35tg12znjFpnJX0yV/qQXqDFOLFn+op/LVAXWdqXtACQPuyuZb/R2louKzX9nS7F5PMY8XReDVcnAQiJJa7bMsawtaqUk1ZZFNdl816Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuZDMjEHcRQf2VB+azAYapp4m8KmxBHZ90s6EVnFKNQ=;
 b=EqgTKm493s6SbJBymxc8W73oUArYldxB+8Ca1GrELEs/5N31fsM1KAWa4JZtCCeiVoLYTnOxQv3QMNBMfAz5oRSGnpPJvAyyuZ0sxrxZ8vdoVbUtEkly3bU1lgpfk676IrDJ9K3bzCjXtsBIORjlrUCD6KsOp3na8npINcNKsQWed02eXq79YKgLSrt4mX6YwOmS0sivJaenWoqz5GoMqsGrfp3P9+ueYWxVbB91sYwxE8OXRDl3AzAfrCa/RzrGj2QUZpOaQfCPXT8YfHJiXRiZMcyn/ApPfSxT/KPZYCh+WrSpOlDIYXE4XwXBQetC2t+DWG3a6nWBDWIshKSVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuZDMjEHcRQf2VB+azAYapp4m8KmxBHZ90s6EVnFKNQ=;
 b=mC7GZyFuBlWVv8Otn14ABIGOVmQjn/MOyJZhAhZP3ENpi31vSCVz+/4TLrYkcnDCH+W6Uj5/iCLc8dJBtV/EYZcTZ/O+KrkRGuiSN8VrHFUC9/Gbm4/SPDlGoMsNNahQs16Qm0E57uUG9toWbqipF41IaMKWXihvclzI95WtNZAUQrVxm6oxUAzqCFF+jo1jeQr78FNaskTexGp46zSD+7jR2WktAX4jQJh+6PeJaYknWqJDqNORYu+51LO/jYcOCHjvAqXp1GwwwsfR7piDZyE7WDjyt3GALSc+dtpPzr2LoLnO1CoRrx09XLHcX7Hwse+SndhYTv6hfXlqqDgFEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 16:49:01 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:49:01 +0000
Date: Tue, 20 Jan 2026 11:48:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move
 PERST property to Root Port node
Message-ID: <aW+x9eA1I/nGdAL9@lizhi-Precision-Tower-5810>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-4-sherry.sun@nxp.com>
 <aW5aodaPdjYwAE1V@lizhi-Precision-Tower-5810>
 <VI0PR04MB1211450544DD02D44B4B901959289A@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB1211450544DD02D44B4B901959289A@VI0PR04MB12114.eurprd04.prod.outlook.com>
X-ClientProxiedBy: PH7P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::18) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB11919:EE_
X-MS-Office365-Filtering-Correlation-Id: 72689088-7df6-482b-f515-08de5843d030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iKY2le7bTYaIXu72w5HWJiL0d+AG1sf679zdk/BanMvY8AJBF0VVKF3gQszj?=
 =?us-ascii?Q?X7SLwmrtQDN9opYy4yQ+ciGlHXHE2GRpbnFDVjh3wIn06mp8ubQaKlh/8kYb?=
 =?us-ascii?Q?7sFnyEwGAsEtmPOOkFtPogkLgSNRLVJRRcF4k4ULZnugz3ekK6WoiadEFKq4?=
 =?us-ascii?Q?5ZQPVmFqGGunxSuumc/P4/HrCR9L8zzFZtqaHwYk+ERxuU1z6TrknrMHH7OF?=
 =?us-ascii?Q?N2HyeNp2AKZptieYMktcVhtYTY2LPW6irhXH6PPbtSbBc2JQncE7tGV3/SRc?=
 =?us-ascii?Q?6ZjLg+i8xEz2qh5sVanAJJwjQj1E8ckjsr3YlZfVvKtEdNRaJX287y8R4oxv?=
 =?us-ascii?Q?2ovnGxyhLgstcmmP5du9VKXQRwB7r7ZwLfP9ffZE1Wd7/904f86BpxslnEAL?=
 =?us-ascii?Q?Tssygkaw1NSr+T0zZRYPDnCktCNSJAq/KjHFYGq9M9uZeSODjVlsV5fCWbAB?=
 =?us-ascii?Q?7r0lLrhMbx33zYR5qDiU9w69Ez54a/u1iYoc8Q5jWVxyu2aYJ4sFLt+emRdQ?=
 =?us-ascii?Q?cPhbCVGYSmtD/G/cIkw4hStNCkzVURLbA4OzZAZdosmzgZVVpmvbRaW1gkg3?=
 =?us-ascii?Q?X3eDLKUyEWzWSsKiAQFkSAT84gzdyFkKfdFf5yw0RriBaaj4W6ICUJQGcg1Z?=
 =?us-ascii?Q?UK1R15hU7glCE48PZxSeWk31VOlp4SuwkrwM7NL/Y/S99oJaNCLwXecUWaEt?=
 =?us-ascii?Q?vGHTP8HNlLCYfMx/p0jRln2webgm4TLAeJQO3xR8nqM/KTyD1BvO+lLlB1h3?=
 =?us-ascii?Q?mxRbstQfdztyuIBBObY/3MxTxtCzNo9ODdGr4aPTVyMEjDtVpFUN4ciiJr0p?=
 =?us-ascii?Q?nBSMyjN++S+fUa+x8ZOq5HQDjTZ8O0Aqyr94JtdluoeoW+gl4nJ9oms/+1Zp?=
 =?us-ascii?Q?JI1r+rcWQvTBIRHjxc/fj6FEYhydFFfdfagHpZcqsqG9iwwE1IQdc/ZdovPQ?=
 =?us-ascii?Q?zGfrW5CmO/BefUtZIPnI/g4sGo9c3gccqn1ih4icpRjM55qLzeiGtIi0AQvr?=
 =?us-ascii?Q?aLjp1YNpFbzI0KQYfFefwxFBU08tE3J10s0QhRtcO/qARyJF6qT6nADH27tp?=
 =?us-ascii?Q?AnV2qfA8LmrE2jCFAaAv5bnspEr0kdc3ZLAp6Ka5wyDUnkoiX/Im+Nm8yabF?=
 =?us-ascii?Q?Q5mqqf23tNj9zFcraXk679ccFWPNWsRDbOT6usX4/zgItsB4i6rKuEEHCPbi?=
 =?us-ascii?Q?tTFFZruHmJnqPhGyCuUZtqsU3UXilzAwAatH/oza6SgUoKbqxUk4LJawe/Od?=
 =?us-ascii?Q?vaoELlmmcduIUZjv1NS02ZwtTxiKNGoS+gSdNueQcNRd88obwXJ88eCqJuc6?=
 =?us-ascii?Q?bh3BYvPV9VS/Z6EB6c6JO1cZ4ULSl0MYiKidTMTfa55J0AnKtcFwIpVFY0cI?=
 =?us-ascii?Q?XYUFE/djo73RGVJtWwWyfVtqMD6vn4hfg6xyQh307AKYp9IyIgupz+ckoSQc?=
 =?us-ascii?Q?uOuT+NmLoDuVH0Row+Iqi3AEVyL8LvTTfwOnDRK8L4bxDCdrUyrk120L93z8?=
 =?us-ascii?Q?6ZExQiXkbpj/wJuFcufrKhl5fcLA5KrKZ07gvnybur1SdnoKlQBSyiSWJtiE?=
 =?us-ascii?Q?1+kyqTLBTibPKXqwNwIUcT+mVS5kjQY6jq9VciR8VXDLTRXoPBG+AnaUsfnK?=
 =?us-ascii?Q?HbCwH6WaAXxNv3xM7bFWyYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t+90NSHY+P5tz8vCrG7+TdxYGNzW+a9YisVriKMAyFn0gwCTNgXMD1xxdbRR?=
 =?us-ascii?Q?UDPqvDGS8XUKtQy/pEp2WtQhPsjG2CuCCLz27Mhkgx57fwnjt5r20WFYzcSh?=
 =?us-ascii?Q?27BdkLv51NF9dE/Ro6Vxe7Kl0xVAXx2ryX6IQSbqzo8qauqPx52purpx9DOg?=
 =?us-ascii?Q?8IjgYLdEn5XiQo7SvvnOX8pAI6/YHrE+PaiJ+E7JWSmYGmqqiNy8jAusOGJb?=
 =?us-ascii?Q?N50LUk/fxtWf8i2RPUm9vD65o6QwakgGlRxYF4NWtTFuktEMz1FabaR5imYO?=
 =?us-ascii?Q?StJqu9VeLJeEsxiDc4xTQWZlVAZ+KS7CKgzAbNPC4+Zn8MMnF56i5wV3A7jV?=
 =?us-ascii?Q?h6ITsYJRhuxK2vmjJdPqJW4zRrQjc/A5m56tziLTckxtJPjAbPsRcBCW5Yff?=
 =?us-ascii?Q?JkoJLCMS1a00Sv8dMckga5p/SHdbm/e+XMztgS2nju6fl2S7IoQpyvHSYx3L?=
 =?us-ascii?Q?2NAkt3hs3O/FDzKVfdmLs7WHqBsU9BZJkhZCCOxLreK+T0YVZtinKspiuG/8?=
 =?us-ascii?Q?BXnou9pDhCkXsAq11sXyhhxAbghSSoKiA2OMR3HgqclbBex7/Aszq1Z8mQhN?=
 =?us-ascii?Q?tl/Is1TNrqJa+h/LNbAscGbo67DaoLUElhGK8+czrRnkwhr8cCOG2XD6GKBG?=
 =?us-ascii?Q?dICV1mnr5Pt4cFhCYXYEFEUahof9Kuubaa6B5DYbV1LzqhZ4ZtA8rLQbbzPz?=
 =?us-ascii?Q?umzJUBXTpm7h7IJnkECvib35i+Y8lOzvmdvAALkA74bhCdcfC68ajrUocxHC?=
 =?us-ascii?Q?G8M87ot6Cnuvshij4M90tCcuSNpuOl0GRIDeZqA1V7KEqmYNBMuQK8VmXz6b?=
 =?us-ascii?Q?2/yVzd9e6XmvQKaZW2nWk1znze8+W4IzDu6N8hTb/uERcLDXLoZ79DgbrlGk?=
 =?us-ascii?Q?TZCdTc7o5t0WgPR2mSu6yHsRd4DzVHlY4E0YsITOIIuozO0v+ocnPraLGF2L?=
 =?us-ascii?Q?egdlW4AutpdUZ+poyckxVejop6zV63kXgWicxt5uKhP6F+/C8MDCHkus6nml?=
 =?us-ascii?Q?QyGECd/i5g8kna4R12LXzQp+Gl/TAq3e9MVdyVGBv+kWwMuYYgL8l2PGihG8?=
 =?us-ascii?Q?L3qRMBIB1Adbbtv6Ihpx9LP4S6ex3Ye3hlIK+aTpRZZcWl7DX9heyDSHIkVn?=
 =?us-ascii?Q?fZp76AxacrJaLlk/IktqIxTIgdsPPjWCUFCmqQ/k9iDHwAXTFugiy9TyttKB?=
 =?us-ascii?Q?yFYOoQoJARIoL6xnVSP/Wr0DDmVERxSU8/MtigG/ZunR5cNOSqPSj7x7M42Q?=
 =?us-ascii?Q?YgM5F8JgL4r5bG3n10qDRc/aVKbcbkGkfCeJD9OTvrKgKaDJCGl4BRI1Yby9?=
 =?us-ascii?Q?S+kWP84PAaXou5SuLrZtT59NgP7DmEtlIZIfu1BXtcgqH3fdtI+GPg5z7Mrz?=
 =?us-ascii?Q?umcSaIyFhRQnKGsBAZiM6A84uHTXfv081Ds/cHCajQ9SMPWi6QIvBuXjH3B0?=
 =?us-ascii?Q?5PlWNa+gQXLsFrjBS0jeB4Aa9CNphVb97MU6ejZ5GyzAy7uH5DjpuNE/BdpR?=
 =?us-ascii?Q?mJp/yP6BxU8FFZ8ENh1PJ+5ae5yO/Ct5KQ84t734VGafvLrf1IFAxGwluxYb?=
 =?us-ascii?Q?iCqASSmY90u9lmBVAt2dO3lZGeGtoyPXAY+ZJjFEbiaFQfKDFfxrw1FJCxiI?=
 =?us-ascii?Q?F4AojorWF+hvqxo/x/pb+NoptbxX6MtSgsrdLpkhTTC2JTtz9ro/HbV9Y0Ld?=
 =?us-ascii?Q?mGB0t+xO0fBbamordi65dn/1tP6bCGHBd9+U/wr3xrzHTymajJwFEtor53rW?=
 =?us-ascii?Q?wXLx+yMOUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72689088-7df6-482b-f515-08de5843d030
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:49:01.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwR0XnbmY9vTm8uJPCODFdLNazXHhcsHUA5+xLmO5/HIiG6EXNchIUSTWy1kfAAc5AVQEyBICeq0TvY4D1YtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45289-lists,linux-pci=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pci,dt];
	DBL_PROHIBIT(0.00)[0.30.132.128:email];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,nxp.com:dkim,0.0.0.0:email,1ffc000:email]
X-Rspamd-Queue-Id: 12C3A49D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:44:34AM +0000, Sherry Sun wrote:
>
> > Subject: Re: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move
> > PERST property to Root Port node
> >
> > On Mon, Jan 19, 2026 at 06:02:28PM +0800, Sherry Sun wrote:
> > > Since describing the PCIe PERST# property under Host Bridge node is
> > > now deprecated, it is recommended to add it to the Root Port node, so
> > > creating the Root Port node and move the reset-gpios property.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++++-
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> > >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++++-
> > >  3 files changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > index ba29720e3f72..c64c8cbd0038 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > @@ -754,11 +754,14 @@ lvds0_out: endpoint {  &pcie {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_pcie>;
> > > -	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> >
> > Generally, don't remove old property to keep back comaptiblity. You can add
> > comments here if you want.
>
> Hi Frank,
> Actually not remove, just move the property from host bridge node to
> the Root Port node, if keep both reset-gpios property in dts, not sure if it may
> confuse users because it's unclear which one is the valid configuration.

You can add comments here. Just in case this dts use by old kernel. At
least keep some kernel release, then remove it later.

Remove it at least need wait for pci part driver merged.

Frank
>
> Best Regards
> Sherry
> >
> > Frank
> >
> > >  	vpcie-supply = <&reg_pcie>;
> > >  	status = "okay";
> > >  };
> > >
> > > +&pcie_port0 {
> > > +	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>; };
> > > +
> > >  &pwm1 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_pwm1>;
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > index 9793feee6394..c03deb2cdfab 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > @@ -287,6 +287,17 @@ pcie: pcie@1ffc000 {
> > >  				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> > >  			clock-names = "pcie", "pcie_bus", "pcie_phy";
> > >  			status = "disabled";
> > > +
> > > +			pcie_port0: pcie@0 {
> > > +				compatible = "pciclass,0604";
> > > +				device_type = "pci";
> > > +				reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +				bus-range = <0x01 0xff>;
> > > +
> > > +				#address-cells = <3>;
> > > +				#size-cells = <2>;
> > > +				ranges;
> > > +			};
> > >  		};
> > >
> > >  		aips1: bus@2000000 { /* AIPS1 */
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > index c5b220aeaefd..c35c24623d36 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > @@ -45,10 +45,13 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ
> > 	0x000b1
> > >  };
> > >
> > >  &pcie {
> > > -	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
> > >  	status = "okay";
> > >  };
> > >
> > > +&pcie_port0 {
> > > +	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>; };
> > > +
> > >  &sata {
> > >  	status = "okay";
> > >  };
> > > --
> > > 2.37.1
> > >

