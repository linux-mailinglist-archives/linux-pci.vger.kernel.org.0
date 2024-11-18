Return-Path: <linux-pci+bounces-17018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830F29D0809
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E742282209
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78E1DFDE;
	Mon, 18 Nov 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LpAFSxpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335B5A79B;
	Mon, 18 Nov 2024 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898804; cv=fail; b=K5ksdJIY3KdX+xJtCJpjjTzCpN9Mj4ozlIOIihAFiI70nhX2SL3aZg+nJ+EA+bQf/rGS5qFTIQtJXF5iCWSVqla15BqO/ONRu82o59CC7t1WLwXxv4zGOAKkjabTVFdadti6DijgDlj604kbfNolnexv/AihASGvySmSSL236ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898804; c=relaxed/simple;
	bh=JNq1zktG8M1d0xg5C7mQRCfxqAi0Xn7xDhuL4KMt1DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZF4s/ZtPnXhB03L/ZtuWjuQ4TDNpN3WNsx0++YaD08Prd50YqAb/Gn6TF/0GLS8oTWelyRMhQDAm9dRjyO0RdgRmevghMTruBm9AZ+VoyBoUisdKGehXWIBG5WjeUXnnyboiYguFOuiT2M6GxUh0F+Dw4s8R5bdIJCgGAo8shwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LpAFSxpU; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS73mDFi9Axe8Adp94WJ/F6roohVAKrlvzj0qy7YdC+9KsiqV/6ZErcRNkmLOXUGZdhorhPYwlxGhIYAKaYo/ObU8KBqel8mZalZbQiHfXqMMQo7vEupM8NH5bq15xwuvUENHArPElkpdAlN0RRb4Kbs7SAWqnoYiGB8VWZ6RMh9PX6z/0Y/KzmC5Ir5vXv3RGSWZM1PQP2HspFvMDByI3vng9p7byqie6dCttQ4O8uPnL+hiSSHjm7/l+f7A22qrvrUCXP5QaeTokpg2Lwn9jLPCENfnaRnBpm6FcgxqDX6waAt631XAcEDRg7qXjwtSOgEnkuYD9WRbwon9Bmm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNq1zktG8M1d0xg5C7mQRCfxqAi0Xn7xDhuL4KMt1DM=;
 b=ctt2fpelG+tKGUDN+qaPP96m4+6JSngQdvfeoJ7ZjfmcFYux7sqq3zR92YecMA5hR+kTZEbXJ2UAqE3o9bfiw28d8FATRYsdToITWaW1lfy0gVQb/cXZTAY6NskIkAkxTQr8Nq02yi0eHHPL73ZCqQ1jJuwwfoq62/aHDTnSzzTPztX80uqQUvzoGa98Hueuvfyk8Hshdh9/noYJXrnxB0mafkfOhvRhgJaiEXVMN4y6R+x7tGiQndgYVgdZOTYpqBJwhs7TJMSBQ5BPOhiKNiizm9ve7CkQRA+oYjEhqIK8ijO6DFVOpbzx5eVPmASdx8DCjfrbYz+/v9cqOxBNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNq1zktG8M1d0xg5C7mQRCfxqAi0Xn7xDhuL4KMt1DM=;
 b=LpAFSxpUrAy+v7+9VL6H0VRkqwPEvmSa+7uYVhJDl4W4AZCu1CQPf7si8esaWwpLwolrPVfZZ6XcetUc7xhKtW3ngfiyETkZF1j8rbWznQULKl6KDS0e5nwuv6rCE8t7gPST/Ew9PT5o8/frj9mbmY0SPTtp9XPnjTKdab9Nm/RjHzkU5OYabAnMz5S5dZs/gN3JD/XVBBfAVqHq4oyJEkqMSsbN3Ng56+KXSZMHFeifeb39+hXfQtu6zcd0glzbowjk10dZrLPxxSsXT+549NyJZjokmguQDYHA6uvf0BS7dzhzccvFt+tpXC/R7VHpyoSnYSLgmHI4VfqSRqfb0w==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 02:59:59 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 02:59:59 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 05/10] PCI: imx6: Make core reset assertion deassertion
 symmetric
Thread-Topic: [PATCH v6 05/10] PCI: imx6: Make core reset assertion
 deassertion symmetric
Thread-Index: AQHbLCsyqPY1xwdi1Ui0NFleqjcktrK3/X+AgALa1oA=
Date: Mon, 18 Nov 2024 02:59:59 +0000
Message-ID:
 <AS8PR04MB8676D25A87FBF45E2B1D26628C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-6-hongxing.zhu@nxp.com>
 <20241115065221.scfb2chnoetpdzu6@thinkpad>
In-Reply-To: <20241115065221.scfb2chnoetpdzu6@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: cf85ccf8-fea2-43bf-539f-08dd077d1700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WGk2NVJvZElNOTh4QXZjcmRDZmUvUnhUUzNtY2phcWpFbnFOcnRtcXg2aFB0?=
 =?utf-8?B?b0VHYzZ0TzVqZ3U5VEtKMFhlMzlucXBYTzlUWm5mRE1DcGc1NHNaaWhvQldO?=
 =?utf-8?B?bzlEdFRHdndjQmZHSWtoaVhkTEVHbUtSNjM0L0hGd3dTNVJZaGE4N3Ftby9z?=
 =?utf-8?B?NzFCTkNLZ2thWUN6YzliWmhhR0hQZWZ6cEozaEUwcWJUTE4xVExXTHNtN2lS?=
 =?utf-8?B?cFR2RDMrYWhGV0NGWUo3emZtejdVT29FMEZFYmtsWUdlQmRYdS96QjNUTDBF?=
 =?utf-8?B?VTNFNm9ZeU5udlJsYmhxNFk1ZXM2VnpjMmY4NTZpVWFHMEl4dEg0NGxQbnNz?=
 =?utf-8?B?dXFMRmxOb2xwTnFWUFcyU2E3N3YxMElCMDE4bitpcG9vcVlEVk9aZXdFcTBu?=
 =?utf-8?B?U2xuRTV6K3ZyNUMxSTJzK3A5OE1UT3ZNS0UvbmRjSFFvSExQQVEra0NsVnpF?=
 =?utf-8?B?U0UvQ25tTkZkN1FBdUhwTWY4RW1zOWlCRkRWV1V3VnlBZFZLYWtwTVJ2RStO?=
 =?utf-8?B?MnpPY0FOUHdURStjTmc0eGtCYURDSUZETHRVR2o5WkJaL0hsUEEvRHkvZ1NS?=
 =?utf-8?B?NWMzWDNTM212RjNMZ1ZRYm5GSVozUWtzYlhxSXB0NVVUajRlSWlPZFZWeGo1?=
 =?utf-8?B?dVlTNlBxYnV3bkxSTG9la0pNd2ZCK2NyMHE5MnhDcTlnc3FwbWJYRHhCeU1u?=
 =?utf-8?B?ajNIdGFWWWxYMFhzNys1NWx4bDdrN3Eya0tENC9HWVBLS1pJRUlvZVhrRnJu?=
 =?utf-8?B?N3pYb3dQK0lYbGltVmVXOFJXRERVM0NxT3ExMEFxMkVISUhIam9nRWFUMVhC?=
 =?utf-8?B?TDUrZTdraWw0UmNkU1lTUFBhTEQ4ejFkcmc0d3B3c1VBK05ybmZPZHkvOHVo?=
 =?utf-8?B?MU5tbDhVNENmVVdsb3ZYc2U4bkJiQnVRRk5sQTlJYStyTDBzMzdOYkQ3UGNC?=
 =?utf-8?B?dzVpNzdvMzhvR2k5VmMxcXdtdm9WVCszYmlOWGpWZ1VJOUhaWStFWlc3UmNE?=
 =?utf-8?B?bG1oNEZYQ0ptMGNDVUw3Rllod1E2bHdHMm5RbFBvYlN5QXROR0ZmWVFZdkp3?=
 =?utf-8?B?SDJUTXlxMjFTMXV3YkxzVWdpang0YUw5RFdCTnpsNGtCczZDNTA3SUhzbER3?=
 =?utf-8?B?ZFB0eW5QZWVBUU8yWm9tNXBxZTMzRUcvVVFiQjhIVjFRMk1ndEZzWVVVS2cr?=
 =?utf-8?B?ZDJvNFRuQUk3YWJpUVl6Yjlud1gycW52dzBsaWVyTVQxK0pQZWZ6bUYrTHpC?=
 =?utf-8?B?ZXJlMHNreHV3U1RWQmx3OGc5VWVnVHZkZU1JeGY2NFlyOUI3SUhTZTRmbU9R?=
 =?utf-8?B?KzRkYkhoQ0M3N013LytNUmx1bGg0aktTMkc2NjdLSGZYclYwSzI2NW4vdGF2?=
 =?utf-8?B?QjV4cEMxYm1QQ3g0aE9oVGd5ZitKOWYyNHBtSlhObzQ4bDJTL1FPZjRKVUVE?=
 =?utf-8?B?YlcydG9tTW5RSm04WTNPY2VrMithVko3NFM4b01uYzR2QUtrS3h6T3h3cm1v?=
 =?utf-8?B?OW5pZnV6SG5xTWR2RFhaMEdWb2hHZDlzcG00bC96UTZZdGpldm1BRHprMzNj?=
 =?utf-8?B?OFBmeTdJV3Evd0lhQzVhWmczcWpCbjd2WFVTeGRHY1Z4YmxaVi83QzBkMnRp?=
 =?utf-8?B?Y0hYTXhwdGR5SW01eU1RMjNTaHhuZExVMFd0UW4yZ3FhNDR3dVpqVDN5aklm?=
 =?utf-8?B?Q2ZLMWNBeGFiUktJNG0rZWhlVEQ3d2dDQ2FRaFp6WmhqRnhPa294VHRHSThO?=
 =?utf-8?B?a3pYaXlnZXd3L2VVWGtObU0zK3M0eWlJd1NwRjRudllBdTdEYXZkWjNNUEdJ?=
 =?utf-8?Q?vTieL8r52w80BYQNFE4sC5o/Nauz5J4qUgcTw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RCtSaDljcFYwSkZqK3BVandHR3A5MlVOWWdDMDNYbkFRUDVDc0RWcGJoTkVm?=
 =?utf-8?B?R2RxaVJWSUxNZnVrSVRIeS9MT3I0NVBwMmlYY0lQNm5qUkZ0ZGxPbElyTkVj?=
 =?utf-8?B?ZHZDTnJwNDRDd2ZMTnE3Wi9UZXFWb0w3VHdvZFp3VDRjbTF0N21zMzNsQTll?=
 =?utf-8?B?N09NbzRXRURhQzNmT2dzanN1Y2txM0xHck9sc0Z3bGVVWTVmYW4zeW5Mc2to?=
 =?utf-8?B?dHFvRFVIL3NDcVl3TnZiOXdvREtiVytDYjlPOWJDN3hteWVMZm5aeEVPU0xI?=
 =?utf-8?B?MHpzam9lakVCbUlkZ1NzYnNyK1lzTnJZMjVZdWJkVWhSYVpIRXpQNFJ4RDFO?=
 =?utf-8?B?MEFPQzkvMkhZeHdFM0wrRTNjVnRDTHFzSkJpTXE3dUpLQUg1VERDQkNZV0RQ?=
 =?utf-8?B?U1NqRW1VdnhDZnNJdWN5UDlCa0NxdDNseHZwcy93THpxR1d2N2RwdVdUV2s4?=
 =?utf-8?B?cjZxWFFZMjYrV0hzUk5qVS9Sbjd4anpkNE4xREdqd0N0aDVkOGVtZnhjY3B2?=
 =?utf-8?B?VWxUNFk1eHN2Si9rZVdRNkZ3cFkyNlRxMnpDY0Y2MExyZ3AzVGt3MnBSbWJh?=
 =?utf-8?B?VFcxOHZnUEdBYUJKQWNtcDVrRTBUcmNsdTFnK3Y3eHpYWE9TeVFmbnpDaGNt?=
 =?utf-8?B?dXVjZmhEUkhNUGFJQjlLVC9KaEsrZFgzRytYaCticEs0a3p5cTVLMlFBckV0?=
 =?utf-8?B?V1BmSml1RmpOVDZIaDBXc1RBcllzZ1dKdmgwK1hPTXhqd2VXTU9NT3BKM3hj?=
 =?utf-8?B?NVNZeENFTk9zRUFFakp2cFhLMlE5dEhha2tXOXZuOWhDY05uMmNZa0NGR25v?=
 =?utf-8?B?SUVDcHAzWVBTcVpuSjBZWlg4Um0rUEF0VXk1djBlMEMzYUp6dWZ4S2ZUZEIr?=
 =?utf-8?B?R2RCQVFWMVhTWldQM1c5U1IzU3pHdXdwc2RLemgrbVpXYWk3aXhoOWl6RThM?=
 =?utf-8?B?SVpDL1REL3BOUE5ab3JQRDJtYW1vL2htMFZVRjRnbEZkNis5ckM4YlpXUTB1?=
 =?utf-8?B?K1NrRGUvbEIwQWtDWVQ5RmVZcTRBNXdZbVVEdFVLcEZINmxLK1lXZDZYRTgw?=
 =?utf-8?B?U2RDQUtpbklhSWkrR1Q2MkU5TVBSRVNuVnBsbFdlS2MwM01BMjQzekFBU1JY?=
 =?utf-8?B?SzE1cHF5b3MrcUhwZHhiOWZGUXo0dEROeER3R01yTTk1NWJmWFdvUmRTVGZa?=
 =?utf-8?B?bHkxem85QW5PTUJXWVRQbVIrUzVxTDlIcjdDNStqbUdlcjkyck1sMXhFWG52?=
 =?utf-8?B?Q3ArTWlrZVo2SmVINm9RV2dKeElrd3RuOEtJZUlQc3R1MXRMaVQzUlpmZzhT?=
 =?utf-8?B?R1ZXN05JRnZQSFExUnBhZE5hanVoVThOQkJPUnBDUGw0MmRsREQ3VEZHbjJK?=
 =?utf-8?B?bVlxalE4K2U4SUhFc1RkL3g5eUxLWDdTek9DcDJWdXIva1dBOE4zQ3JqL0pa?=
 =?utf-8?B?aFRCWEFJaEJ4dTQrK2FPNlRydFNyWXE4ZXYrbFBaeDgzOC9MZWM0RjhSL2tj?=
 =?utf-8?B?YXBzMGx0Rm1jaFVxQXovVm94MkdIZ3pTMk9hY1V1cllHeDR4UlhJTVN0dmNw?=
 =?utf-8?B?ek1YQnNWSlB4UDdKMzA3U3hJU3dEQXhoaGxvK09NbmxCTGRVOEVkclJ4Zytn?=
 =?utf-8?B?aHN4SnM5azZpZ1pSYWd2T2o4S1NZMm1TMUx1anZ0UlRuSkJZM29iRFZtTkY3?=
 =?utf-8?B?OE53WUJqUlJQcWpWNTFmR25jUzhlTDVVcGx2dk1majJTNVZJd0Fld0FuUHhO?=
 =?utf-8?B?c2JCSWFOQXNjb0ZnVzZ1SDVNSGl1RGtnZVorNzhadmZZNENiWFViR0trMFBJ?=
 =?utf-8?B?ZWUwQVJKNmxCdTkxem5WMjU1ajJlWU1qd0RuN2hLWGM3dC9FS3JpbXVRQndu?=
 =?utf-8?B?N2VBQzNWb29XcmI5Vm9SR0pNdTZzdlRPT0xobG5KZWtaS2VRbTlPTEh4Ri9K?=
 =?utf-8?B?NlVSOE5rR1A1Mk1PN2xnS0I5eHVIdlNKYS9ETnlvK3RLbFhkczNRSkRleWdO?=
 =?utf-8?B?YzV1MkRtZm50Slc2TUVDTmowUHpyQmFQUVZpa3crTnpQZmthSndaMDl6Q1pY?=
 =?utf-8?B?ZDhlQnEzdnVYSkwzd1BBZVFWa3UwbUhLUFBPOC9oV1R4MjA2THV3a0c5ak53?=
 =?utf-8?Q?Jm1fwGpDIISj4GtzLN+OCWhD5?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf85ccf8-fea2-43bf-539f-08dd077d1700
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:59:59.4494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVbC7EBZ3UK2OXPzoHwsCDQhepqcfgm4NJpeHwP1NgmM/PC+ZNmiOAr+BgnHGWH33u4Q8PExk4RCQ64GtZnhsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgxNeaXpSAxNDo1Mg0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9y
ZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA1LzEw
XSBQQ0k6IGlteDY6IE1ha2UgY29yZSByZXNldCBhc3NlcnRpb24NCj4gZGVhc3NlcnRpb24gc3lt
bWV0cmljDQo+IA0KPiBPbiBGcmksIE5vdiAwMSwgMjAyNCBhdCAwMzowNjowNVBNICswODAwLCBS
aWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgYXBwc19yZXNldCBkZWFzc2VydGlvbiBpbiB0aGUg
aW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLiBMZXQNCj4gPiBpdCBiZSBzeW1tZXRyaWMg
d2l0aCBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpLg0KPiA+DQo+ID4gSW4gdGhlIGNvbW1p
dCBmaXJzdCBpbnRyb2R1Y2VkIGFwcHNfcmVzZXQsIGFwcHNfcmVzZXQgaXMgYXNzZXJ0ZWQgaW4N
Cj4gPiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSwgYnV0IGl0IGlzIGRlLWFzc2VydGVk
IGluIGFub3RoZXIgcGxhY2UsDQo+ID4gaW4NCj4gDQo+IEknZCBzdWdnZXN0IHJld29yZGluZyBs
aWtlIGJlbG93IHRvIG1ha2UgaXQgZWFzeSB0byB1bmRlcnN0YW5kLA0KPiANCj4gIlBDSTogaW14
NjogRGVhc3NlcnQgYXBwc19yZXNldCBpbiBpbXhfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpDQpJ
J20gdmVyeSBhcHByZWNpYXRlIGZvciB5b3VyIHJld29yZHMuIFNob3VsZCB0aGUgaW14X3BjaWVf
YXNzZXJ0X2NvcmVfcmVzZXQoKQ0KIGJlIGlteF9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoKT8N
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gU2luY2UgdGhlIGFwcHNfcmVzZXQg
aXMgYXNzZXJ0ZWQgaW4gaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSwgaXQgc2hvdWxkIGJl
DQo+IGRlYXNzZXJ0ZWQgaW4gaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLiINCj4gDQo+
ID4gc3RlYWQgb2YgdGhlIGFjY29yZGluZyBzeW1tZXRyaWMgZnVuY3Rpb24NCj4gaW14Nl9wY2ll
X2RlYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPg0KPiA+IFVzZSB0aGlzIHBhdGNoIHRvIGZpeCBp
dCwgYW5kIG1ha2UgY29yZSByZXNldCBhc3NlcnRpb24gZGVhc2VydGlvbg0KPiA+IHN5bW1ldHJp
Yy4NCj4gPg0KPiA+IEZpeGVzOiA5YjNmZTY3OTZkN2MgKCJQQ0k6IGlteDY6IEFkZCBjb2RlIHRv
IHN1cHBvcnQgaS5NWDdEIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+IA0KPiBXaXRoIGFib3ZlIGNoYW5nZSwNCj4gDQo+IFJldmlld2Vk
LWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5h
cm8ub3JnPg0KPiANCj4gLSBNYW5pDQo+IA0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJh
bmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXgg
OTk2MzMzZTkwMTdkLi41NDAzOWQyNzYwZDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNzcyLDYgKzc3Miw3IEBAIHN0YXRpYyB2b2lkIGlt
eF9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiA+IGlteF9wY2llICppbXhfcGNpZSkg
IHN0YXRpYyBpbnQgaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gPiBpbXhf
cGNpZSAqaW14X3BjaWUpICB7DQo+ID4gIAlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGlteF9wY2ll
LT5wY2llcGh5X3Jlc2V0KTsNCj4gPiArCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14X3BjaWUt
PmFwcHNfcmVzZXQpOw0KPiA+DQo+ID4gIAlpZiAoaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVz
ZXQpDQo+ID4gIAkJaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVzZXQoaW14X3BjaWUsIGZhbHNl
KTsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPg
r43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

