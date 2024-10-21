Return-Path: <linux-pci+bounces-14946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D49A6F32
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 18:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D25283561
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2519923D;
	Mon, 21 Oct 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1E1nl6E"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEA14A90;
	Mon, 21 Oct 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527456; cv=fail; b=lCSV/khCo3pnop8EMzvR8gZjYjGdb5uNOZAiSvRTciK7hNBIP8gx7RwkBlKFS3g7Sw5blVKxBA2ie9vsqYnpYunQGA60qxs/WSHepkXJ4Ec/M68WOfTzoql8XXA99YiobLi59Oc2np86GrFfe+pRWXqhvu72qDGTukUFr8spz2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527456; c=relaxed/simple;
	bh=FLzeoMkvHPB+wxZmfcHvBmvCNdevGAosTbPLRLl7ULc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCmgHuUetHwTwvBu9sbqUSdPX87Gn1RoWTCuQkrno+lD4ce/K2QWY6n/CBWgEaXgdMxCydPqK4f9W7DaYN/YtZQ5Uh03N4sycO+RSCYH28UX8pINWQdzZwS3qcejJ5iDYKYPCERaFJ3f1Lyg72+ifXBsdxvAujDj2HyeDw7KZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1E1nl6E; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO//9HGQFcBd/O5Ghx/+C3OmnpP57IRaAbs+lBsuaTqif7m8cTwldcWhqr5XpYzx7eVf3dV7UB37H4T7vggc/3JQQ3gCwU5MAcUG+3+kjRMoNtWjEajAqvR6vysYU6bMdgtAR8Sv5eiYBiu76cqG1OAxSq1UFQ3QLAYhf/sXIBMRX4MiYbjmR1nASq/9rRJufSQcdOBKcIMZvvvTZ9/649UwKK5LzBp/lsGOBRCxnpGoKi6wXlf7CzQcjCFnsNjSUu6h2rTMzWP81n8KvD4m1RNAnf4jVvXpq2w5AgaHd8sjnRo8fwwaKdasWiKJUg+LlSq1eXg+4+7fBFJPgvw1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLzeoMkvHPB+wxZmfcHvBmvCNdevGAosTbPLRLl7ULc=;
 b=W1Isc+uKA+OM0lyUBnxj2LhNiEsMlZDvTCEBbnTE0iml+JRrCwRdGuvtkJhJM6a9hHeceuy3qKNm2DoUVF1pxa7eSEZl/ek6x2ba/BTNsPm8YOVUIiGad5C6koe0bsTK2VlWY/E6Dfj2oXY+SEd0a8aMX+v/U+ZrnVRqzxWfuc5EePosEFV21CLfmhx9+63lQifJyAvDuRK0EvT+V/Kk0iT3YnwNBGcROAa3NSvR/ygKqw8epPFEbSuKm+u6CtDGecdJKZcicX4UBPW2wowLgPvnJk/wBJShqAz1Et9HSQ3mQLybg4l3ozzJ02mxALPB9YAvrerIewjX6FJH8xeSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLzeoMkvHPB+wxZmfcHvBmvCNdevGAosTbPLRLl7ULc=;
 b=d1E1nl6EjKApGtyzbpEylYtioSZO+SYay8d7QLZxZcpUj7gwlw0Jn+EMNIo5+sJOkyHZtcLDu6926RCyaeP0qSqF72p16zb22B62cwp8eLwD4UPumj3uyXsLOn1AAN4dbsIG3uWwBMLn7EqhA41bXoqv5563NivBON8kVEse1pNtHHambfZlcOBf22jhd5/K1HvJbQwT9eCCsw5SRokOOEUD33wZptX334VrxmFXDkT4oJFUIEuYAM/nOlUWTN+DKmw036XzElverzbJXEgDI34Y4jQlYp7fTkpZwSa0w+G+CMyZixzAJ5Avx7B8POEwdqHwpuCzR8Eac0rNXZaK0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8072.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:17:30 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 16:17:30 +0000
Date: Mon, 21 Oct 2024 12:17:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZxZ+kpAuInG9eCa9@lizhi-Precision-Tower-5810>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
 <ZxJqITunljv0PGxn@ryzen.lan>
 <ZxJ7HoSuYNr8mwSi@lizhi-Precision-Tower-5810>
 <ZxUWlSFEPDCCXaq0@x1-carbon.lan>
 <ZxX66guRidaeV1zO@ryzen.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxX66guRidaeV1zO@ryzen.lan>
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa7c0c7-101b-4577-8853-08dcf1ebdce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yp0ZUSmARaGh0RlBewuoEWj3WgTbX43lWcfmOxsL9I7+H/M8lIJi83uMBv+j?=
 =?us-ascii?Q?Iax9+TUOo+94zFWscnVm28EzrdNbY7xgD0uVHJR1zFU+Z79N2SNgVAX+/Rqp?=
 =?us-ascii?Q?GpLf0Xp+NNLfwKVuRCaF0ox1S504oTUfxfovWxCrrbxIAPCzkg3QtS7PN+mg?=
 =?us-ascii?Q?nevnM36jZTZssykzC8P9mI7ghWMepSmMIgDUhqOiibUL3mLSYxupfSoY5oY3?=
 =?us-ascii?Q?SMkawMI+iCcUx29sbJIKHzoE5HmcMODOdP63hsr02NM6hFpnWF3/sx1pz+P4?=
 =?us-ascii?Q?8Gam5+ulfajmM5ZdtJDjVfjZOb6AQgq1UxqhWN/pstxb270m3+JAXDEEX35l?=
 =?us-ascii?Q?ahUjfWver51HvEjk2Xr6b2DAMnCleIKY2KFlKDQtogPYhtM4um1wNhpQP/Cb?=
 =?us-ascii?Q?sksTEn00b0g9WftaaCqxGtajpd8wAnaOQffO8UrWszaa9BoLx5uOhJKDNMLd?=
 =?us-ascii?Q?Yo++FElUoSRThFjNJjrv0cmuUTE5QeG5FP9ZHyQIl4R2u2rnypKcxbIGVeBv?=
 =?us-ascii?Q?8oDnwnQtCe/Ey4/L5mJYVyZhzxgf9mCujzCR1iU7Z2s4bl/g+zIsK3v/p2NK?=
 =?us-ascii?Q?7iAb4P7xJbJIOYTBnX3HMinvJrYvtLWTufIrMaL02jfRng6aiAjv9BcYOnBc?=
 =?us-ascii?Q?TS7204lqHx5jpwLDstE0+01g8/Gd9LzXPetiwRUKBTZN7CS/ifyBLKxSfUa7?=
 =?us-ascii?Q?ERzYuqIIFPcK6wBQLRjMTH9INw1x8UgRyQlt5mwhGxJdyOk21u3mbELQoJWD?=
 =?us-ascii?Q?4FVrAol70ccmkkHTUf4Sro2lfYoyJDt+/Q0yyvBnvOaD/uuv7HUOZA7a3OX9?=
 =?us-ascii?Q?1n7LE6BWvDa5xCT19I4xFmTAXJ48Et21CxhKuiRrI+8VVfx0Ha+irDhsA5Ee?=
 =?us-ascii?Q?qG8FQMsxqebtC+sqyMy13iuZ4YWffc5WRPz5DsrRe8nygdnvTxgkCiCnkwID?=
 =?us-ascii?Q?VYB2XYn1LnKqlnDC8L6CDNf7aytpnhi+iNRznkpzKDDhODrFogpo4RP+hlEd?=
 =?us-ascii?Q?bJb8DLxtAX95K87+AkneyH/4X6TiztT2EF8CoHhXFC8jR/EFF3O7e/j8RsTX?=
 =?us-ascii?Q?5ZEoMOqVAShRkDAlsNxQZmWDq57hAr3vlNHqrJB0Irv6T7y9RPy16odGz45q?=
 =?us-ascii?Q?NNwPyTyD40zeQWabTt3UPiS0qcgaIx4UQbjip8z/BRDUIi+O7UhFpEYopffT?=
 =?us-ascii?Q?REeixk9XzhyZvM5B2VwC5b5eYWEZxTHnmZQcsfn9S2yUXPEr5nl7mQwoK4ER?=
 =?us-ascii?Q?Xu3LWyWRH+DC6vIWpssEmeaMdwHrXQ4kOPQgkWf3AmUUpQNBni2ywKjVuMOK?=
 =?us-ascii?Q?FTN0zJoSme4FTxefEmgnu2MacdUw4daNQKWrWkvtR1W4wQWAWTu8PRbiztdM?=
 =?us-ascii?Q?MAwdsfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iynUqRtXOtBExS7C9BaL8WH9OXReM/FgjYBHFZAEXWyz32axPAKHtdbSQXEL?=
 =?us-ascii?Q?I+KRYTzCsF5O/y6VZgi7r3S1JlcAqm6DNYrJt4JA27xj1w1OpXiH2nF7TDCn?=
 =?us-ascii?Q?fWVyXZL0KFnMYVHV6EXuQwunDxpANP3hWC8O4gzUcBruT3If3ttmz9PaOxRV?=
 =?us-ascii?Q?MrkIT26hXcRrFL1nluEgBoILWE4XVVObK9i51oDABOUz5f7HArv3Rf3gGudZ?=
 =?us-ascii?Q?CMkwMoxcugbpMpRFcM0ajgjEUMkAVdLZelJTRUIypPI09OBOU67gJepOAvXR?=
 =?us-ascii?Q?iL2+MXY6V8+//GptIqCHTMiyLExHtNCruReVoip675whuntaKVakzIonlavt?=
 =?us-ascii?Q?dsCPmDm0YTZB/3zCeSdofBS7I7gLcAhZAkCOJdgiq1NTqHzCJt8Mc64aBa98?=
 =?us-ascii?Q?VwSmN1eN14Oquj1wmcDi+xoGxCRxi/wJ9bnZA2ywRh1skfoUuXbol6N7EcQt?=
 =?us-ascii?Q?2+1U0u5DTrSoQ0Nzz6tGNkQgsND6T3Yk+e5wwI0o4GfjCoEpazmONlPDueSO?=
 =?us-ascii?Q?RZSRZFPw2sGnyjabg6XBTyrL/EVfCOReiC9LIK3yQPFnM7ErMvCmrDHTtpNN?=
 =?us-ascii?Q?/csxhmXfZfR8w93rNOjrxzv/qx9uk6tewmfFo3np8h3kLyxi7lpsRKVnwOYv?=
 =?us-ascii?Q?NKfJwIlBHJufYnrdI8Y42iD9jmUyzOdrzHlwC21adTAX3NCgHGBLc7ISFl2F?=
 =?us-ascii?Q?VZ9u9VeiMxwnw5gpO+mhsuJPYa3epUHlNQ5aGF7ALCSvzA1C1cQmvd823PD4?=
 =?us-ascii?Q?wYSB3nxNL36Wz3cE82Frt1Ik7DIalRRjmM3yDQ0FYvfXZaSf7MrAlizRPI20?=
 =?us-ascii?Q?zf6k4vLTBX/lYmaNeW6imbEmr/AzLlsgiObLxuNUmFyejLHStMpOWlD+EDq2?=
 =?us-ascii?Q?dklHQch4tRGdOikqhK2sRcjiSt/WLHnr+cn+HEDSp1iHfjB5L2yveMVM+Fwe?=
 =?us-ascii?Q?3zKeNrBTyJtSv6qEo0qTRq1Vd+2Q6xs/TCdNPE5o3YtbbfHW897ZcPlMg0np?=
 =?us-ascii?Q?wM5r4OK0b45TnztSlq8t6bIs35mY/x3AFCk3kNHXAZLVzPZvljO/YKNB/exD?=
 =?us-ascii?Q?J3RnDTlOVhFS4IueHc3/LUba7Rs7DUFBzc1jJoaI9OA1iQgnBTlyfhc88rKB?=
 =?us-ascii?Q?2h0B6P08NGfrhkGi7WIJvrtSZXihCWHCMhkYaNt8ZpJaHN6oQusaT4wNtPu/?=
 =?us-ascii?Q?XgPsXFIk9CKc6ziiWLRHuZX1ZYJW6lpA14MH7AkzS+XZvxl1A7nPIAJLxkRt?=
 =?us-ascii?Q?XE9N0KkFUitXetr97yXMCfokSRz0mQZznVRI9hK2Kq7KRTX7UxQgdYVOs1yh?=
 =?us-ascii?Q?IvqQcffNPnW0YUe6DqMoylPPyV+KXCjD66z07CneBdJjxLoJl5obz2X+zRXT?=
 =?us-ascii?Q?rCcCdf/Me8QqNo5znBLSEgTcjTCeT304EEil595wf4L72Vdlx6em5U42FhLT?=
 =?us-ascii?Q?KKPNm/7Cb/+9vHAkeajGiyGyHkK4tSjm3pHIHqjmQRyetRt666uXx6LSeCwe?=
 =?us-ascii?Q?nYGf5nFan9VZP2bCSg4BGamqw3O1WB0jipsadJg1bhJ9mUeksKUa7gFsF0M2?=
 =?us-ascii?Q?Ur0dQKFQeyyyGduiZ/ApLJn/f8a7l9DDZv7Z1Cq2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa7c0c7-101b-4577-8853-08dcf1ebdce3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:17:30.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8/XTifu3fhkgs3uNUI7Izt7KHI4/Jh1xSaLua9/VtHQNs0uzxO0sRQiDMgv4oY1uXUF3PBwBsiAzorZv6lrzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8072

On Mon, Oct 21, 2024 at 08:55:38AM +0200, Niklas Cassel wrote:
> On Sun, Oct 20, 2024 at 04:41:25PM +0200, Niklas Cassel wrote:
> > On Fri, Oct 18, 2024 at 11:13:34AM -0400, Frank Li wrote:
> > > On Fri, Oct 18, 2024 at 04:01:05PM +0200, Niklas Cassel wrote:
> >
> > How about we add a new pcitest --set-doorbell-mode option
> > (that is similar to pcitest -i which sets the interrupt mode to use).
> >
> > That way, we can do:
> > ./pcitest --set-doorbell-mode 1
> > (This will enable doorbell for e.g. BAR0, pci-epf-test will call
> > pci_epf_alloc_doorbell() when receiving this command from the RC side.
> > The command will return failure if pci_epf_alloc_doorbell() returned failure.)
> >
> > ./pcitest -B
> > (This will perform the doorbell test)
> >
> > ./pcitest --set-doorbell-mode 0
> > (This will disable the doorbell for BAR0,
> > so it will again not trigger IRQs when BAR0 is written,
> > and pcitest's tests to read/write the BARs will again behave as expected.)
> >
> > (We probably also need another option pcitest --get-doorbell-mode.)
> >
> > I think this should solve all your concerns. Thoughts?
>
> And just to clarify, if we go with the --set-doorbell-mode approach,
> then my previous idea (introducing capabilities in pci-epf-test and
> pci-endpoint-test) is no longer a necessity.

Yes, the problem is that it needs dynamatic switch bar mapping address.
I am not sure all EPC support it. DWC should support it because I did it
for vntb driver. But bar's size should be issue. PCI don't support change
bar's size after pci bus scan devices. ITS's offset is 0x40. Anyway,
ITS + DWC should work.

Frank

>
>
> Kind regards,
> Niklas

