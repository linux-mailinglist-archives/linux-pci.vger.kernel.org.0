Return-Path: <linux-pci+bounces-17101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79EA9D3191
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 02:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427B1B21B46
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF06A930;
	Wed, 20 Nov 2024 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S90KAWzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA98C0B;
	Wed, 20 Nov 2024 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064654; cv=fail; b=hE5qMMADEUCvxc4kUFN4r7DC/wSHCiHiE9dYSV4eo/Sc2HlB2X5XOt0MvZqivON7O6TPa5X74vy8d2nbj1IUEzNcx41WiDah6ZlyjPR9aF8v42TTQjC2YonXpILwuI1lQ9eJkWEes8WAqOem/KywGc+73UvPT4eALrOYTfvRDYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064654; c=relaxed/simple;
	bh=0OiYcngXM77ZptpdryMsPR8SlEos2B7SBqg8qVvA1DU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMjjh+hdED8Hj8qTdKqeDgl1bwf7vsg9gomh/xGOTXK6UrA3KcmgTvZORwNYsI+Sceh+o5h6r/Fm/3St2ttBd1AfeAD4i6u9JVGsn17comrb8PQucwoiTWGPXmfprOZpgmY1AcVvcRnTY+kmxCpALZVI0P58P6dPGcjhC8SPuZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S90KAWzU; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8iKb47OiK2QQT6AHzpR/uAb9ULLGE38fHqRBsHD6aM4r3U31HeJZbdYpkfDqbK/j+s6q8omopk0FuywRO2i928fOZQRo3S6KDtyTgVlqm6/0Tgx6x6JIu1mzPNuFHwoQpOTwd9FdpEIDRb7TffnIR/xve5qf0At4oZzfHhwearFLxHjk4W61pwXWUT+fCmzI2ntz7rtcHa19lDGp77OxAEaXA01tdiaf1CCTLnzWjaicgC/JVrrI+w34Qf3EUHjeMneHTSvj7tB9c4r6b7I4b5aPL5mZMbs0yHdgU4m336JxedxosEV+2aGVXb71JnnFa40Pwf0ZTRAZJ4/rSVGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OiYcngXM77ZptpdryMsPR8SlEos2B7SBqg8qVvA1DU=;
 b=Fh6LWQTkykJPUdkPbqtBZ3bmcIn7anG9NE9B0ZufIBjzxNGQYGwMw8L+X6eYo4zkJvYCX9fmS3qEDl4Y/VR0vvjpCTUARUNQKnftvNWMVrvkVyHd2nNhNdTgjZCPVDG+6JIdHFo9f+Uq/foWNTyAWigPxbRg35pSPIvUU3rP0pxlK9o1Th8OfdjLn7ezaddf+bvjHhLViNV/n2bQSvbgy0mJaxZ9znfPtnz3QRlWt4dPVAYv4ING/rctoqOM0ccww0Vw8MWtRSA8mfcvE/TjsGwnFIiswTOCtUjaMTN1qcl2WQJJJ26sucU1p6nHZTiiloryC3ZwuBGN+WEoWuInZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OiYcngXM77ZptpdryMsPR8SlEos2B7SBqg8qVvA1DU=;
 b=S90KAWzUl0wZeO4c9biiP7eCZtaaHX9I5g7L35vgnAWnZIA6RTHeLK7kLNPPRCei938txVffrLoTQctZwOg6UIQE53E3teOCmPvTFvlGRfKdR4j1iAa7ylkXZrz+Rf0sqIMpwMKFr7YSckd42Gl8Si5QJfIGeWDIfX38J9ZDgkmEkCj4bfMxxLLvYvyQjl63n1teBdqPmY/BislC/6+IKnPtXw/4bX4JZo5XDgL+d5y9Cw7tqOjFtNBNq03IiYPyTqdmAxX5h35ThDeSEe8oOo5OdqP6T8XRHjDyyr9DevpCyas0olTUuNbC/35C1boFcHjAkfyvvdRbdSwq4Epebg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 01:04:08 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 01:04:07 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index: AQHbOX1jfD65FUimD0C9XmRBulHERrK+6XSAgAByIwA=
Date: Wed, 20 Nov 2024 01:04:07 +0000
Message-ID:
 <AS8PR04MB867676A6078A1DC792C16AB58C212@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
 <ZzzUa8Zs3qJiVPam@lizhi-Precision-Tower-5810>
In-Reply-To: <ZzzUa8Zs3qJiVPam@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB8667:EE_
x-ms-office365-filtering-correlation-id: 900732ce-7ddc-459c-bdf2-08dd08ff3c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?gb2312?B?NlNxbXVQcEVmNkNzendxeEZZREN4eUZUMG5oRzcwWGZvTEpmWDhNRHFJOG5z?=
 =?gb2312?B?K3lMYldPMnpYWGZQc08wYmw1M09wN3B4SjM0bHVucmxvb3B4bmd1cUw3K0Rk?=
 =?gb2312?B?ZVoyMnR2Tm9SUVpOTGo5eTA2Q05WL0hrNnlXRFlBemlhekV5WVFhb29Yb1NP?=
 =?gb2312?B?WWtmYmxWa1pRYUdmNWJzWEJlOEtNeTN5UzNHTWpDRkR3UVhlZSs2cExhaVBm?=
 =?gb2312?B?OUYvbDFmZXgvUnR5K05HditxTE1DUkNwaC83S0U4Z0dPNktQclkvc3NnN3Qz?=
 =?gb2312?B?RXJQQ1dodjY1VU1XMmhSYWVhZlhKWmNHQXBLYlU0ak0zbnlxOHhvMVZnWnIv?=
 =?gb2312?B?alN5dHhKaDZWSjR0VU5KZ1lpSkRmNVJrOFY0TlBZa0oyeWVkUXFPOTRtN0Ju?=
 =?gb2312?B?VXNkKzR5bVFwWEM3QS9na2gwSExCQ2k2djk2SGlycnFTMlRnSkx2N1l4QStw?=
 =?gb2312?B?TnBXaE9jUFhzQjdVaDJETDNIZXZUWW1hTTVlN1ZYMWdTTmlaYlRlM3lzeEpI?=
 =?gb2312?B?WWlGTTdna0xNcFVvaXh5ZVRFT1VZTml6dUZFelVNTWJHSUxqend3VCtSSjl3?=
 =?gb2312?B?ajhpZThJSmxXd1hreVdjNnNKSkFIV2JnNWJaV0tmQlB2YzhRZW5JZXphSzcz?=
 =?gb2312?B?L043UFRkTHRUKys2c1dVY3pXS0h3WkZpNVJhNWJHZlM2WStpdXVRaWgrWDUx?=
 =?gb2312?B?a3pva3NFbVBHQUZlQzNtSEo0SlRiZVhKNS8wREQ1ZkdtenVKaG5tR2k4MXBy?=
 =?gb2312?B?b2JXSmVUUWI5eXJyL1FjcXVMQXlZcEVZNDNxRUROT25TUC8vSHZTU1p0ODZh?=
 =?gb2312?B?a25yM2NkeUVhb3MxWmlKUFBSbmlIVnk1TWl4RVNvWDFabC9QMTUrVWV0V2lO?=
 =?gb2312?B?WEh3ZXNqM21lZS81RVRDeFlCa1ZaaHdWeW1ZRmJpeWh6V3EyenVUVzVPVTlS?=
 =?gb2312?B?ZkhTNHc3NSs1bVFpODhaMjlUSnQzd3R6T2JBRkVpanc2cEtOZ3c5cXQrOUE2?=
 =?gb2312?B?NVNOOGExbGVlTE9Ock5QOFc0TVh1NWJiV1NwV1RBOEp6bVVDL21CSkFYbE52?=
 =?gb2312?B?NU9lc2hwNjRpR2E3NXNCYUVrMGg1eVZDSFpjMGZ6RkZrbGRtSllKZUFmcm9U?=
 =?gb2312?B?L1lhRVZIRldIUFVTSmtyQjlxb3kyL3E1VHg3QWRXOS8yOXRUUzVIN0lOa3Q2?=
 =?gb2312?B?N2tYOVRTVStpWTlFNE5uRTYrZnVqQUU4WTJ6ZEQzTkcwVmNCK0trRkpVcWd6?=
 =?gb2312?B?VlJpSm9zRkgxYzBMVmtyTmpJdXAzZkhIWkY2WEoxeUl5UTF3dWxtek9odS8v?=
 =?gb2312?B?WmlmREJkLzZWQ1hLcHlRYUhrTVZrSnBYYm04aTFDUWZINlZFeTgwbDJuNTc4?=
 =?gb2312?B?c1IvQkhXUklNRG5TS1FCTkJHbDF4YjVuRTRRUDJNa0dRcWV1Z3ZhcVFMRDg2?=
 =?gb2312?B?Ylk1SEFtK0M3WmVrb0lJdWVjTlRwR0dFUlJXYnROWTFUWHA0WTBXOW51VW9y?=
 =?gb2312?B?elpQZVpzcFFOMHIwa1p3QThxb1JJcDE2NGdWc2FKTTF0TzFES2Q4WU1ZdSs3?=
 =?gb2312?B?Smd6MDRTLzA4SXV1OXlHV25MK0RwbWdEdEk3NGpibHYzbC9YWFAwQnhuRG1s?=
 =?gb2312?B?WXQxNDZFN1cwaGo1NW5mMzBqMDJIS3UwWDluclJzM2pqYVh4Q3pBR2lpUVI4?=
 =?gb2312?B?UUJQZWZEWldvSGFYOGNJMVUrMmFsUlFFdms2alZEM2ZSL0daRXhpUGxhUDFx?=
 =?gb2312?B?THhYQlJtTzRubzhRQmdQdVdtYkFzekxSakZBaTI0cDF5ZlJtN2syS24zbFhX?=
 =?gb2312?Q?rJR3oWS923cKw/mxXZiJPtiATtYBjKv4Qt/p4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZDdGWVhFQUNCNCtuREN4alNPalV1MGhWT1ErZ25YcUxkTjZBYUQvZWl6NlZt?=
 =?gb2312?B?ZFNQRm1TNkdXN0RFTjVTUkxXVjNPaWtGV1R1UXZnMkcwRzhIOWg5RHB4cTVh?=
 =?gb2312?B?NXNvWmhHZzZvWElHZDZjNXdkUmxLUlZKM2o1ZndHZ21OblU3WDduWjZhTkRo?=
 =?gb2312?B?UjVmejVLZkR4YmtXelFkNnVXdjJwaHVJSlZicnlrcjBvejhHS3Z0VldjZ1I2?=
 =?gb2312?B?VWtiQVYzb2hKODNNanNCaXNHMmtBSUpEQjdiT3lSdzY2N29MOVh2N3dWOWhE?=
 =?gb2312?B?R1RBYjBGWnlCdVk0KzFDOHMzZ1NWM04rVUhSdm9zei9vd0FtM3N4NXYxbzNC?=
 =?gb2312?B?M283dlIrN1F6WHYxbURzTzZ4THlRUUczcWlUb3BzMy91N3lKZ0p4NUo4MTJ2?=
 =?gb2312?B?YkhCN0JxaDFiL2RMY0kwYmNsSE1jdWRHMkl5VmZ1UVdGSEhPeHNMcFlGV3NV?=
 =?gb2312?B?MkhxdVRLeml0dVlxZk94dGpCQW5vamoxRlpoUlBETm92S2xWNnpDT0Nsa2t6?=
 =?gb2312?B?M0p0TnlVcFFFUlRobTlBN1pubGtBbUliYjZyWDFycEtnTCs5cWxyRjdrUXY5?=
 =?gb2312?B?dTRrQnBrWGtnWklYeDlSQnRSTjJJNjNiSW9mc1ZqcVRoQUJPS2RlMEN1MmNh?=
 =?gb2312?B?anhPaXpFNUJVb3BBMGZwY0JXMGdPM0MvVlBGVnF2dEJzL3ZCdVJhK0FwdTBw?=
 =?gb2312?B?K2dFSm5oNUZ5U0pSemZQSTJCVklGL3JaOCtUNWh4T25TdHVUamNXMHp2YnFw?=
 =?gb2312?B?SCtOOTYyUGNPaldvYzJuNDV0SXl6M2RJSkhIRndNbGorcTV2cnV3OWkzOTRQ?=
 =?gb2312?B?YmcrNUZPYnVBTkljLy9tb2QrRXUxQnJrcytMUnl1NVRVdUQ5T1ZUaU9leGlo?=
 =?gb2312?B?OUtTcndWeTkzcjI0dnhqbm9lcTY4ZndwVFBpZ2lOOVBBSk45N3RmYlR3ZG52?=
 =?gb2312?B?bUJTajJSNG1IRVpLNkRKVERPcmVYWGR4eFhnUHRSeTdVVXk0UGVyZGtZSStX?=
 =?gb2312?B?cFVpNU9JUG5MVFVsUi9GMFNteE9pNEc4WEIyQUFlUC9jQXExU1V2S1ljUG93?=
 =?gb2312?B?SWxMdXBnQXRNTDRoNHBZWWpDVnRnUE1PUnVPTmpwcElZNnlsRHhmODNRNENQ?=
 =?gb2312?B?ekJsSzZRT0N3alowRW1Fb2oySjJiV1ZOV0UxcVM5YklLZmxxVkNGZ2JXVUs5?=
 =?gb2312?B?Tm1ROWhXUlVtQ3EvSHZRbEtCTURtU012ckx1Vnl1R2RUVUExR3BlODlSYmlr?=
 =?gb2312?B?SWpKSHRXdTMyUXg5aDBTQWlTRXNaVFhCc01ueGdxdGlNQjBOeDNWdW94Ujhx?=
 =?gb2312?B?ZUw4V0V4SzVXN3FVUkhGODhVdXdxUHdHOFlzWE5FZGUwRHVXelFRY2tuR2pk?=
 =?gb2312?B?VU96dGt6SnF5VTJLYmxNREp4Y3A2b1RLM290Tmpna3U4dFJSN3grWlBJZ1Rh?=
 =?gb2312?B?aHYzSkFndzdQU0o5aWEzU1JUQjZNK1B3NnJWMHp3OS8zZGpydEhEbkhsVllF?=
 =?gb2312?B?TU1wdW5ZWE1WQWsvUnRLZkYvQWpaZXY5K2dCd1REOFJjY3p3U3lKUlZrNnBW?=
 =?gb2312?B?ME5KRFl3bmNTb2hieUp3Q3hDeTV0RjU3Zkd2ZHNoY2FVTC9iSlhKN1l1ZHhB?=
 =?gb2312?B?TnVZUVFTK1FoN3U1RDZXVFhDOXJKdzdLRWFwRnRXaFIvbjF1Z2Y5QmdBVjBs?=
 =?gb2312?B?OVMxY1FWNnlDU2Y4NjZhTXpocEhnYnBUeWxXLzBFRjRBQW9ldGdTdytTdmlX?=
 =?gb2312?B?Rnh2NWtqWUJ2aW9COEQwMmZBUTFZVHNrU1dTNnRJeURUUG5HNjRGYWNqRzJP?=
 =?gb2312?B?R3dBWm9PTXcyZG84cmQzUTRxTmlxWFRjUmpHcGdFdkF1SzhyVEl2QjlWN0dC?=
 =?gb2312?B?WWh4RkRNSFlZYm5oVWxQV0E5aXV6YXpPWjdCdStkMW5SMHdTdDdUWXpOWFh6?=
 =?gb2312?B?aFNMS1BlZHlDZXRKNVFwWW5uMlRqdGhXMFBUdkdNQUtQci9rL3JWMnAzSGJX?=
 =?gb2312?B?VFlMVm81Y1ZCb20yY1MxeFVUQXQ1eklTVU9UNW52R0FpaDlPWGhiOHVPa21p?=
 =?gb2312?B?akNub0JpVXF2aThZSFNCTmFwZFZMOGhsQXpQRlk0WnAyazhtMzcxaHVaeWY2?=
 =?gb2312?Q?SNlT5c5jOTCatntVws8LLfMI2?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900732ce-7ddc-459c-bdf2-08dd08ff3c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 01:04:07.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2tqbY7CCBAxJbh7/NQ4Kq+mmljL2DIccT8sEZtxgvFsHry/4S2+hu/slu5CqnT/UjUwPVosvw+UhUasHfBPDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTHUwjIwyNUgMjoxMA0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGppbmdvb2hhbjFAZ21haWwuY29tOyBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7DQo+IGt3QGxpbnV4LmNvbTsg
bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gaW14
QGxpc3RzLmxpbnV4LmRldjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjNdIFBDSTogZHdjOiBDbGVhbiB1cCBzb21lIHVubmVjZXNzYXJ5IGNvZGVzIGlu
DQo+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpDQo+IA0KPiBPbiBNb24sIE5vdiAxOCwgMjAyNCBh
dCAwMTo0NDo0N1BNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBCZWZvcmUgc2VuZGlu
ZyBQTUVfVFVSTl9PRkYsIGRvbid0IHRlc3QgdGhlIExUU1NNIHN0YXRlLiBTaW5jZSBpdCdzDQo+
ID4gc2FmZSB0byBzZW5kIFBNRV9UVVJOX09GRiBtZXNzYWdlIHJlZ2FyZGxlc3Mgb2Ygd2hldGhl
ciB0aGUgbGluayBpcyB1cA0KPiA+IG9yIGRvd24uIFNvLCB0aGVyZSB3b3VsZCBiZSBubyBuZWVk
IHRvIHRlc3QgdGhlIExUU1NNIHN0YXRlIGJlZm9yZQ0KPiA+IHNlbmRpbmcgUE1FX1RVUk5fT0ZG
IG1lc3NhZ2UuDQo+ID4NCj4gPiBPbmx5IHByaW50IHRoZSBtZXNzYWdlIHdoZW4gbHRzc21fc3Rh
dCBpcyBub3QgaW4gREVURUNUIGFuZCBQT0xMLg0KPiA+IEluIHRoZSBvdGhlciB3b3JkcywgdGhl
cmUgaXNuJ3QgYW4gZXJyb3IgbWVzc2FnZSB3aGVuIG5vIGVuZHBvaW50IGlzDQo+ID4gY29ubmVj
dGVkIGF0IGFsbC4NCj4gPg0KPiA+IEFsc28sIHdoZW4gdGhlIGVuZHBvaW50IGlzIGNvbm5lY3Rl
ZCBhbmQgUE1FX1RVUk5fT0ZGIGlzIHNlbnQsIGRvIG5vdA0KPiA+IHJldHVybiBlcnJvciBpZiB0
aGUgbGluayBkb2Vzbid0IGVudGVyIEwyLiBKdXN0IHByaW50IGEgd2FybmluZyBhbmQNCj4gPiBj
b250aW51ZSB3aXRoIHRoZSBzdXNwZW5kIGFzIHRoZSBsaW5rIHdpbGwgYmUgcmVjb3ZlcmVkIGlu
DQo+IGR3X3BjaWVfcmVzdW1lX25vaXJxKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjMgY2hhbmdlczoN
Cj4gPiAtIFJlZmluZSB0aGUgY29tbWl0IG1lc3NhZ2UgcmVmZXIgdG8gTWFuaXZhbm5hbidzIGNv
bW1lbnRzLg0KPiA+IC0gUmVnYXJkaW5nIEZyYW5rJ3MgY29tbWVudHMsIGF2b2lkIDEwbXMgd2Fp
dCB3aGVuIG5vIGxpbmsgdXAuDQo+ID4gdjIgY2hhbmdlczoNCj4gPiAtIERvbid0IHJlbW92ZSBM
MiBwb2xsIGNoZWNrLg0KPiA+IC0gQWRkIG9uZSAxdXMgZGVsYXkgYWZ0ZXIgTDIgZW50cnkuDQo+
ID4gLSBObyBlcnJvciByZXR1cm4gd2hlbiBMMiBlbnRyeSBpcyB0aW1lb3V0DQo+ID4gLSBEb24n
dCBwcmludCBtZXNzYWdlIHdoZW4gbm8gbGluayB1cC4NCj4gPiAtLS0NCj4gPiAgLi4uL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgNDANCj4gPiArKysrKysrKysr
LS0tLS0tLS0tICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCAg
fA0KPiA+IDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE4IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBpbmRleCAyNGU4OWI2NmI3NzIuLjY4ZmJj
MTYxOTllOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IEBAIC05MjcsMjQgKzkyNywyOCBAQCBpbnQgZHdf
cGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAlpZiAoZHdfcGNp
ZV9yZWFkd19kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NUTCkgJg0KPiBQQ0lfRVhQX0xO
S0NUTF9BU1BNX0wxKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4gLQkvKiBPbmx5IHNlbmQg
b3V0IFBNRV9UVVJOX09GRiB3aGVuIFBDSUUgbGluayBpcyB1cCAqLw0KPiA+IC0JaWYgKGR3X3Bj
aWVfZ2V0X2x0c3NtKHBjaSkgPiBEV19QQ0lFX0xUU1NNX0RFVEVDVF9BQ1QpIHsNCj4gPiAtCQlp
ZiAocGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZikNCj4gPiAtCQkJcGNpLT5wcC5vcHMtPnBtZV90
dXJuX29mZigmcGNpLT5wcCk7DQo+ID4gLQkJZWxzZQ0KPiA+IC0JCQlyZXQgPSBkd19wY2llX3Bt
ZV90dXJuX29mZihwY2kpOw0KPiA+IC0NCj4gPiAtCQlpZiAocmV0KQ0KPiA+IC0JCQlyZXR1cm4g
cmV0Ow0KPiA+ICsJaWYgKHBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYpDQo+ID4gKwkJcGNpLT5w
cC5vcHMtPnBtZV90dXJuX29mZigmcGNpLT5wcCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0ID0g
ZHdfcGNpZV9wbWVfdHVybl9vZmYocGNpKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPg0KPiA+IC0JCXJldCA9IHJlYWRfcG9sbF90aW1lb3V0KGR3X3BjaWVfZ2V0X2x0
c3NtLCB2YWwsIHZhbCA9PQ0KPiBEV19QQ0lFX0xUU1NNX0wyX0lETEUsDQo+ID4gLQkJCQkJUENJ
RV9QTUVfVE9fTDJfVElNRU9VVF9VUy8xMCwNCj4gPiAtCQkJCQlQQ0lFX1BNRV9UT19MMl9USU1F
T1VUX1VTLCBmYWxzZSwgcGNpKTsNCj4gPiAtCQlpZiAocmV0KSB7DQo+ID4gLQkJCWRldl9lcnIo
cGNpLT5kZXYsICJUaW1lb3V0IHdhaXRpbmcgZm9yIEwyIGVudHJ5ISBMVFNTTToNCj4gMHgleFxu
IiwgdmFsKTsNCj4gPiAtCQkJcmV0dXJuIHJldDsNCj4gPiAtCQl9DQo+ID4gLQl9DQo+ID4gKwly
ZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLA0KPiA+ICsJCQkJ
dmFsID09IERXX1BDSUVfTFRTU01fTDJfSURMRSB8fA0KPiA+ICsJCQkJdmFsIDw9IERXX1BDSUVf
TFRTU01fREVURUNUX1dBSVQsDQo+ID4gKwkJCQlQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VTLzEw
LA0KPiA+ICsJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQo+ID4g
KwlpZiAocmV0ICYmICh2YWwgPiBEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlUKSkNCj4gDQo+IGlm
IHRydWUgb2YgKHZhbCA8PSBEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlUKSwgd2hpY2ggbWVhbnMg
bm90IGRldmljZQ0KPiBhdHRhY2hlZCwgJ3JldCcgc2hvdWxkIGJlIDAuDQo+IA0KPiB3aGVuIHJl
dCBpcyBub3QgMCwgbWVhbnMsIGxpbmsgdXAgYW5kIG5vdCBpbiBMMiBpZGxlIHN0YXR1cy4gU28g
Y2hlY2sgJyh2YWwgPg0KPiBEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlUKScgaXMgcmVkdW5kYW50
Lg0KPiANCj4gTk9UKHZhbCA9PSBEV19QQ0lFX0xUU1NNX0wyX0lETEUgfHwgdmFsIDw9DQo+IERX
X1BDSUVfTFRTU01fREVURUNUX1dBSVQpIGVxdWFsICh2YWwgIT0gRFdfUENJRV9MVFNTTV9MMl9J
RExFKSAmJg0KPiAodmFsID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfV0FJVCkNCkkgc2VlLiBTbyBv
bmx5IGRvIHRoZSByZXQgdmFsdWUgY2hlY2sgImlmIChyZXQpIiBpcyBlbm91Z2guDQpXaGVuIHJl
dCBpcyBub3QgMCwgbGluayBpcyB1cCwgc29tZXRoaW5nIGlzIHdyb25nIGluIEwyIGVudHJ5LCBh
IHdhcm5pbmcgd291bGQNCiBiZSBwcmludGVkLiBJZiByZXQgaXMgMCwgdGhhdCBtZWFucyBMMiBl
bnRyeSBpcyBkb25lLCBvciBubyBsaW5rIHVwIGF0IGFsbC4NClRoYW5rcy4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gRnJhbmsNCj4gDQo+ID4gKwkJLyogT25seSBkdW1wIG1l
c3NhZ2Ugd2hlbiBsdHNzbV9zdGF0IGlzbid0IGluIERFVEVDVCBhbmQgUE9MTCAqLw0KPiA+ICsJ
CWRldl93YXJuKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEgTFRTU006
IDB4JXhcbiIsDQo+IHZhbCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBSZWZl
ciB0byByNi4wLCBzZWMgNS4zLjMuMi4xLCBzb2Z0d2FyZSBzaG91bGQgd2FpdCBhdCBsZWFzdA0K
PiA+ICsJCSAqIDEwMG5zIGFmdGVyIEwyL0wzIFJlYWR5IGJlZm9yZSB0dXJuaW5nIG9mZiByZWZj
bG9jayBhbmQNCj4gPiArCQkgKiBtYWluIHBvd2VyLiBJdCdzIGhhcm1sZXNzIHRvbyB3aGVuIG5v
IGVuZHBvaW50IGNvbm5lY3RlZC4NCj4gPiArCQkgKi8NCj4gPiArCQl1ZGVsYXkoMSk7DQo+ID4N
Cj4gPiAgCWR3X3BjaWVfc3RvcF9saW5rKHBjaSk7DQo+ID4gIAlpZiAocGNpLT5wcC5vcHMtPmRl
aW5pdCkNCj4gPiBAQCAtOTUyLDcgKzk1Niw3IEBAIGludCBkd19wY2llX3N1c3BlbmRfbm9pcnEo
c3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPg0KPiA+ICAJcGNpLT5zdXNwZW5kZWQgPSB0cnVlOw0K
PiA+DQo+ID4gLQlyZXR1cm4gcmV0Ow0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgRVhQ
T1JUX1NZTUJPTF9HUEwoZHdfcGNpZV9zdXNwZW5kX25vaXJxKTsNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBpbmRleCAz
NDdhYjc0YWMzNWEuLmJmMDM2ZTY2NzE3ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gQEAgLTMzMCw2ICszMzAsNyBAQCBl
bnVtIGR3X3BjaWVfbHRzc20gew0KPiA+ICAJLyogTmVlZCB0byBhbGlnbiB3aXRoIFBDSUVfUE9S
VF9ERUJVRzAgYml0cyAwOjUgKi8NCj4gPiAgCURXX1BDSUVfTFRTU01fREVURUNUX1FVSUVUID0g
MHgwLA0KPiA+ICAJRFdfUENJRV9MVFNTTV9ERVRFQ1RfQUNUID0gMHgxLA0KPiA+ICsJRFdfUENJ
RV9MVFNTTV9ERVRFQ1RfV0FJVCA9IDB4NiwNCj4gPiAgCURXX1BDSUVfTFRTU01fTDAgPSAweDEx
LA0KPiA+ICAJRFdfUENJRV9MVFNTTV9MMl9JRExFID0gMHgxNSwNCj4gPg0KPiA+IC0tDQo+ID4g
Mi4zNy4xDQo+ID4NCg==

