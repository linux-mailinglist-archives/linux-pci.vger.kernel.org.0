Return-Path: <linux-pci+bounces-13479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38449851BE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46BA61C20ED4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB82149DF7;
	Wed, 25 Sep 2024 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fTsDBgJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB4139E;
	Wed, 25 Sep 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236992; cv=fail; b=pyiSRR7RwdoiLqUwhhlqvSLrYr1mzy8c2IZlIp8Fo98z23D9Gd01yTrIpb9wcGGDTO5KSXcnOAXqVZvjZAJToLJM7vwDBuso9or18ZUjBacoQTkkWFR+ZP/9UMg25uJGycYOHwz9kHtx8tICktfOSKAhkaNMBfjNCFxqMV1omxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236992; c=relaxed/simple;
	bh=8XA/ZQU/e1f6SNqq77UVBelCRiMC2g3Jb5Q8tmSCb1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3tOUvXfTLzzOKJU2yzWdRb+2sFmTLfMVAlwr8MUqhfs2iJI2EC7S7OnS96LJ9RCtKjL4JS1eLBk5tlpiyCHaIJemiVKSm6wPaFoQOlCCkjOiqvwG3n/eZS+SCCfGdHiObBcNnb3MDIFPBqMbUAot5cAXApt5BKPexN2j45vWv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fTsDBgJD; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMB0vEA7l6ACjg66lZ9vIS+mT8XDU/mRKGnCQog0X1iUxuzVRFZtH9t/xzGJZq6lX2X3B6AG1ZYMGVSeLzy1JKNpU5V4cc5VjSR0tnapfEosEKMmcalW+Y5yXA29UjDxn7WVFyRRzwWHqDmIeNS6vfc8/I3J+fq+NkovQPSk1Zr6AXy/nVjkKO8Y781kGfrQYvJvqKfHT0e67eU6ZtYUFFv7UARSEYEfLxvF8y9JjMZfvOrJAfuHcrzuPiJjUYM6Efz37RAuxqh2wXYm35fpP7W24ZNICNaV3pg+CXWS6f8v/fUIIMNHufHnQxQjeXdp1QVgnz486shAbMtZtdK4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XA/ZQU/e1f6SNqq77UVBelCRiMC2g3Jb5Q8tmSCb1A=;
 b=AjcvPTIaj5bChSf/MpxtKby5tBDikqPOePiPdbMhd4Bu03XzzK86PhOHQx0JfbQQCkqRQBBwWqVplTpuHmsg8Nco3nXB7jX7/bLMCdk0okwjEI2iEzohLYMBOm3ZSo1NYWrw3zYyuWcKNi1+BjhdwqZOVs1Wk0rEiF2IC2fLgtifsQpadHQ5aoN04Iukdrsv84ZD3FMuadTW02pa8OHPwS68s7kktlb7yW0UZoMGGOsX47GNeojVe4cPohlPMG0m4ZgGjxFa5RYpFTNDJUJgaDs1R32HiB4L8WhTZ6ZisJYb91uKpIvJguaN5m0QTi/YJ9InKBnb88yQ7gbgJe5dlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XA/ZQU/e1f6SNqq77UVBelCRiMC2g3Jb5Q8tmSCb1A=;
 b=fTsDBgJDIFQqTziBvohITzUmQyxtndnFsWaem8WnmjMIcqfsvsgfCrlwPbJAuEHcO8Jdm9FIF53MINaFq6mAwJk5nD8pqM5xD89SRaqvvkHrpDT+b277SRDAFPQgwzT/r0uHZsxhIKF3yM/xSqfcSe82gXwVuHf0BK9H/ElcdcDbmWeX4YQS4eSGu3d8ZnLWb3bf73iZS02caPw2SFaUI2J2V48xR+VHGdDseUIuodJUloaZMQIBsMmWebNhzm38yX0vpNIkKCY9Wc+jBWfUBECNzSj8xGrsKyZIuQWbFz6JkRPBfduhuUD6S+V3K4hZWx7h9XTzWNEYBwbi7dNkfw==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by PA4PR04MB9712.eurprd04.prod.outlook.com (2603:10a6:102:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 04:03:03 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 04:03:03 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Topic: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Index: AQHa7VchMMLSKbpmfky4pqFpd8TS8LJBcW0AgAYQTQCAIKJmoA==
Date: Wed, 25 Sep 2024 04:03:03 +0000
Message-ID:
 <DU2PR04MB86771BA534FF1A8C0AE5B8618C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <ZtMUbpBJscWlgkhW@dragon> <ZtgqmCbkD1ruZr4U@dragon>
In-Reply-To: <ZtgqmCbkD1ruZr4U@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|PA4PR04MB9712:EE_
x-ms-office365-filtering-correlation-id: 0093cf09-a884-4d33-05cb-08dcdd16f3f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Yjl5ZFdRL3oyb3dvdExSaG9sZjBOb0VsbWhPeUhjTG5PNzhwU2FTYVJtWFdF?=
 =?gb2312?B?QTNXT0twNDBLdnVUbGZzY1pUUHRQRVdYcXBPdVlqdmhNZTFyT2Fzc0RnbTdP?=
 =?gb2312?B?L3FERXFJMm1yc05BbnVtOWFFNTVHK25mQ2dKeVk4SDd1YXNDRVdTWmRhZnRI?=
 =?gb2312?B?b3lPZWpodXczaTBJdzFrOTgrQ3JITGs4dURZNll0K2dVb1Y5T2g3MVI5NVk3?=
 =?gb2312?B?M25GQlRmeHpYQmxhZHRLcEhNZXZlaSt5MkZyNjlMcUlnQUFsRXk4cFQ5L0M3?=
 =?gb2312?B?NkVpaUFJcjg2YlFDb0pmTDJYcUhXWC9yYjRrRVhSVWNqSk5aRjJrUFZsRHZ0?=
 =?gb2312?B?bi9raUpqbnc3dkNhYmhiWFhwRlkxYXkyN2JPZU1uMHprOGU4RDlTb2FYZkZK?=
 =?gb2312?B?b3IxbDJnZmJlUVBaU1g1NzkwNmt5WDRBZFphSk5haDJZZ3NDL3R2RVFWRkdL?=
 =?gb2312?B?VERsQTgxWklsRzZpb3VCMTJSK1QwaHpLSC81QnFXVktmbDg3bWs0WHlPV0d4?=
 =?gb2312?B?d2lmYWtjT1VGNTBtVmdMRG9mR1V6UlRPc09nVGY2S3VSV1JqcUFqNTNnNWxD?=
 =?gb2312?B?ZmRmb1BUVlZLWWpJa2NHTk14NGtGVUZlNUlmMVd1K3QwNS9LMllyQUNGWmsr?=
 =?gb2312?B?OGpEQUd5SFVmUWsvU1FXMEV2V3dUNDd4WVJLVHhXSG5IMHpCWGJsQW9MWkdS?=
 =?gb2312?B?ODZ3Yi9ZZkFXYmI2a3dJcm5HYzlYcTBKdHpVeUJEZFQ5ZGpMaVpJbXF4OUov?=
 =?gb2312?B?SFlIcU15V3duN1NsTm41YXBBWEpuRDdDeUFjZ09iTG9CZEY0cHN2NjV1VGFk?=
 =?gb2312?B?Y3cxQUVscnRWNjZma3hDeE5jTFdTNHNKQ0ZsY2pCakdKVUxzVzhYRVVNRkp6?=
 =?gb2312?B?OVFCTGxEMHZ6b1EwR1FRQXo0K0hEZlpmSUtjKytqSE8vSnNmbzUzaGV6aTF2?=
 =?gb2312?B?VUlDMWZpbFBzQVFJeHUrbS9MaGR5Qm1FdFN6b0ZJT0hJUHF3TkNrVDYwcTBG?=
 =?gb2312?B?bmZxeHdObmNwU0s3dkVtb0RWZVpZUDhoQW1JYWQ2azZadGc1V0tBQUtEREdh?=
 =?gb2312?B?aVBpckxlSGI0NWcvN3MxMVJVRUJYb0pxZUtoMWx5bFRKSGdCbkprQm1zSTc0?=
 =?gb2312?B?SGM2R3YrbUs1NUpNRDM5bEo2NnIzUWRqYi8zVVUrNjdQdE00MlJLeTh2K290?=
 =?gb2312?B?bEVKTEQrQzk1U1V3U2tYZlVoMnFkb0FWVEVHeGJHZnhUdnJiZVBtcTdvZnV0?=
 =?gb2312?B?b3I1R3VNSFp4U0s2NURZU3FieDJIZjdqT3VpRklpUWdoV3JaU0NvcjZWYStz?=
 =?gb2312?B?ajFYQTBNYmJkOGxPeVl6Ym5QUVZ3dDV6bjh3aUltUDVROXNub1lwakNKaEJv?=
 =?gb2312?B?UENCZG03SnFhUVBRUGVmOUx4eEYwbm9OUmZTWEQxbnpRcUhGZmZnbFM3NDNK?=
 =?gb2312?B?ZDd5L2xTM0dhNDdNR3crZzlmS0JqSTNha0QySnMwMnpaR2xETW90U1A5dHZD?=
 =?gb2312?B?NzYrZmJOcEtnNnNta2E4d1ZIYU1tYVh0NjJYTUI3NTMxeCtMRnArSVpQNmhW?=
 =?gb2312?B?Tkd4VU1DWjJCby94dGIrdTdqUUJNZksrYW5sSHUzOXJTSFAzY3dCaDdzZDRH?=
 =?gb2312?B?ZCt0ZVNDS2FWdXZRSndzVXV1bmh3N1MvTEJHVFV2azcxTGVQSmhyTTdXNnMv?=
 =?gb2312?B?NFBpWXpvZHROT1c1Ry95SktUOWJCTHdkZmM2eURqaXNIMTRFZGdJWU45OTQx?=
 =?gb2312?B?dnBDL2doVW1mNVRZOHJGRmtBTzBPYmhBbnkwaTFJZGs0cHZ0bUtlRGhRU0Er?=
 =?gb2312?B?QWJXL2tSbU0ycFlKcVh2dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cXk4TE1URlg1eGJWb2c2b3ZwVTJqckZXL0hGWHNlSExlK01KbTEwVlZGMkhi?=
 =?gb2312?B?eWp2M2xuZjBLUEt2ZlpaWXppVjhpZGpvekZrK2JCRmlOOWFsTjhKSjlYYWd4?=
 =?gb2312?B?UHBwVzdnNDJCNFl6T2M5OEtBSmpDZTBpRDdWbk9ZckhDeEFucS9JTG1PdmpS?=
 =?gb2312?B?UlE4anRxN29mUDlBUWVwQkpmZlJ2WDBQMGZtS2U4M29YYkI3MDlsNGVqYkJV?=
 =?gb2312?B?UEpaSjVld1E5WUpzMTB2SUszdXdUTmlaUVdneWJKZ2M4RVBsK0ozSUJYZlNa?=
 =?gb2312?B?bjBQcjdMektyRzFuZnZhc3YrbmdNL3BVelp6UWg3SEtxMWdzS1FLUDIvNXJ6?=
 =?gb2312?B?amc0aFpHOFRUekQ5QTBZRko0eE9sMEx4VGtnYVZuZjZFS3RjTjZDd2U5S1o0?=
 =?gb2312?B?K3Q1QTVBcjUwUkVtSDVzOHZhb2VidUxmNmY4VVEyUEtWcVR3TEpPWUwvbnJJ?=
 =?gb2312?B?aEl0N0JTWUtBcjhCWWcrS09zYXkxcWc1TXIzdGREV0wzdHhIR20rcWdXWG44?=
 =?gb2312?B?aUF3MlN2Nzh3S3UvQlNtSUZpcE9JUGhPSjRrMTNoZWp5QTlHMkJhUDhvdXBS?=
 =?gb2312?B?bHN6RjZrL3pqZjFqY1R1R2dXbTFyWXIwQzFKdFJhZGhoeDBJeXpZaUJDbWo5?=
 =?gb2312?B?TXdxcFQ1K1FiWExaR0haeHJaSC9hYXA4YlRNWUtqektlbEdRc1pLakFRVUZE?=
 =?gb2312?B?YkZJMkdVOXd1a3BTU1h6T0xXZ2lzT1BpMTdhQXd1K0plTjIya1d2U3E5bjY5?=
 =?gb2312?B?KzZERkJ2dnhLbmkxNmNLMHBrTlFNQ0dwK0NNNUZEaVFiWTJ2SVh4a2dQM3Z0?=
 =?gb2312?B?cDkxSWgyT1ZzZm1FVXFzUWlNTWFQcU5BSzk2K0JNNEdZS2Naa1ZNSm5jVDNG?=
 =?gb2312?B?Q3VkMzVacWROZ3JrcGl5WlI4OTVyUXdiM09tajRoaUVmcEVxaTZXSDdNN2Nk?=
 =?gb2312?B?ZS9nazRlM3dWY1hqZTBOUXRMUkZSZU4xUVBRV1F3UWRxZG4xa1hVNGh6VllO?=
 =?gb2312?B?M0J6dXpOd2ZPcHhOb09QRlVDYXZtR3hvaUk1eFFxNHFRTnlmWmlRYmtwWkJk?=
 =?gb2312?B?RDFFTFVJaS9zcHhFSHF0bHdMVnZHQkNZa25vNm9WekZuc3dBeDN4d0hWV1JL?=
 =?gb2312?B?dG5HdHoxckdxQlhnWG10V0t2YVhqV2RHa3pIeFZ3YWduWWRQWUlJYWRCMjVV?=
 =?gb2312?B?UDRuOUV1bGRZYXFaR08yQ2ZoRG1JekxlRkkyZDdOVC9YUmt4emlxWVhwZTh1?=
 =?gb2312?B?R3UreDlUa0hlYXRMcllIdVZjNmRoK3poSk5nUDF3T1QrazlzMDBxc2FCOTV3?=
 =?gb2312?B?aE9uVlowb1Nya1loQ0Y3NnVnQWxMek8wRllTY1pPV3NNWUFZb0RrVjZoSTBs?=
 =?gb2312?B?ekVQQkNjeDZJaTZpa0RvMUJSNFpIUUlNMk9BeXdTRCtlU21LajV5Z3M4RGhZ?=
 =?gb2312?B?MDBZUHcyYmpwN05qM3ltbE5yVHNUL0wvYVFOVi9sTlk1dHJlT00yMTcwTGli?=
 =?gb2312?B?V2NHYzRONVhoT3M0Nis2K2psTUtIbkxadWJsRVBNWExGOW0xV0dYMzFya3Bn?=
 =?gb2312?B?YzFRWjJ6dGs1dEk5RFM1eDNOUk9CTGdNa2VLeW5wRFV1VitVMVJmTGowcHp2?=
 =?gb2312?B?RVppT3dTQzY2UXdVQUxBQi9tU2Z3TnJuSzdjK1owK0pibEhXeVU4TkdzM3RU?=
 =?gb2312?B?c0dxdE0zbisxWC9rdXVPMmpzWURLM2J1ZkJUNnVoRUpNZUFwMVhUelJlc2xj?=
 =?gb2312?B?Wkd5WTB5NWNMZDN4Yk40QTU3OC8yUGttZEF5bEE1QXhLa0RUbzVqT3JTbkFt?=
 =?gb2312?B?VUptVitLY0JWL3BzQlkzQ0wrNTJHbzFNbTVERWI4NjdsUGIvWGZFQlRxanpy?=
 =?gb2312?B?S2h5RGpQRkwwcWNzRjR0RGR1WHJ3ZEVFRjY5R3dMSG4wK3dOMEo4Z0ZqNkcv?=
 =?gb2312?B?RDBMazVXSHlsSjc5MVhwT1NWaENBUmxJU0RSL2lOb3FwNi9lb2lKN3lPWlly?=
 =?gb2312?B?d1pRQm9EU2FaQlBjaFByUTcwWnZVWEZEWFZYTVMxajZFWUQyUXJQWTJ0bDRO?=
 =?gb2312?B?WWN4VHhTNnFxVi9wRWE3cHBjL1pCYjRiVWdOeGs0VHJyQVNPY2RiYXhhYnRj?=
 =?gb2312?Q?Zy1PGl8SKfoEk/clHB1/cbhuV?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0093cf09-a884-4d33-05cb-08dcdd16f3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 04:03:03.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyzyoYc+F5o/TDZpR6kEG8HyOnBqu6HGji9M6KbkMyEH8AcN2B5XWvErDjo5tnXBQLb8Oh0/DLzThGFgL1+W8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9712

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
MkB5ZWFoLm5ldD4NCj4gU2VudDogMjAyNMTqOdTCNMjVIDE3OjM5DQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvNF0g
QWRkIGRiaTIgYW5kIGF0dSBmb3IgaS5NWDhNIFBDSWUgRVANCj4gDQo+IE9uIFNhdCwgQXVnIDMx
LCAyMDI0IGF0IDA5OjAyOjM4UE0gKzA4MDAsIFNoYXduIEd1byB3cm90ZToNCj4gPiBPbiBUdWUs
IEF1ZyAxMywgMjAyNCBhdCAwMzo0MjoxOVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
PiA+IHY1IGNoYW5nZXM6DQo+ID4gPiAtIENvcnJlY3Qgc3ViamVjdCBwcmVmaXguDQo+ID4gPg0K
PiA+ID4gdjQgY2hhbmdlczoNCj4gPiA+IC0gQWRkIEZyYW5rJ3MgcmV2aWV3ZWQgdGFnLCBhbmQg
cmUtZm9ybWF0IHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+DQo+ID4gPiB2MyBjaGFuZ2VzOg0K
PiA+ID4gLSBSZWZpbmUgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbnMuDQo+ID4gPg0KPiA+ID4gdjIg
Y2hhbmdlczoNCj4gPiA+IFRoYW5rcyBmb3IgQ29ub3IncyBjb21tZW50cy4NCj4gPiA+IC0gUGxh
Y2UgdGhlIG5ldyBhZGRlZCBwcm9wZXJ0aWVzIGF0IHRoZSBlbmQuDQo+ID4gPg0KPiA+ID4gSWRl
YWxseSwgZGJpMiBhbmQgYXR1IGJhc2UgYWRkcmVzc2VzIHNob3VsZCBiZSBmZXRjaGVkIGZyb20g
RFQuDQo+ID4gPiBBZGQgZGJpMiBhbmQgYXR1IGJhc2UgYWRkcmVzc2VzIGZvciBpLk1YOE0gUENJ
ZSBFUCBoZXJlLg0KPiA+ID4NCj4gPiA+IFtQQVRDSCB2NSAxLzRdIGR0LWJpbmRpbmdzOiBpbXg2
cS1wY2llOiBBZGQgcmVnLW5hbWUgImRiaTIiIGFuZCAiYXR1Ig0KPiA+ID4gW1BBVENIIHY1IDIv
NF0gYXJtNjQ6IGR0czogaW14OG1xOiBBZGQgZGJpMiBhbmQgYXR1IHJlZyBmb3IgaS5NWDhNUQ0K
PiA+ID4gW1BBVENIIHY1IDMvNF0gYXJtNjQ6IGR0czogaW14OG1wOiBBZGQgZGJpMiBhbmQgYXR1
IHJlZyBmb3IgaS5NWDhNUA0KPiA+ID4gW1BBVENIIHY1IDQvNF0gYXJtNjQ6IGR0czogaW14OG1t
OiBBZGQgZGJpMiBhbmQgYXR1IHJlZyBmb3IgaS5NWDhNTQ0KPiA+DQo+ID4gQXBwbGllZCAzIERU
UyBwYXRjaGVzLCB0aGFua3MhDQo+IA0KPiBJIGhhdmUgdG8gdGFrZSB0aGVtIG91dCBmcm9tIG15
IGJyYW5jaCBmb3Igbm93LiAgUGluZyBtZSB3aGVuIGJpbmRpbmdzDQo+IGNoYW5nZSBnZXRzIGFw
cGxpZWQuDQo+IA0KSGkgU2hhd246DQpUaGUgZHRzIGJpbmRpbmdzIGNoYW5nZSBoYWQgYmVlbiBt
ZXJnZWQgb24gU2VwIDA2Lg0KQ2FuIHlvdSBoZWxwIHRvIG1lcmdlIHRoZSBvdGhlcnM/DQpJIGRv
bid0IGtub3cgd2h5IG15IHBpbmcgZW1haWwgc2VudCBvbiBTZXAgMDkgaXMgbWlzc2luZy4NClJl
LXNlbmQgZW1haWwgYWdhaW4gaGVyZS4NClRoYW5rcyBpbiBhZHZhbmNlZC4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KDQo+IFNoYXduDQoNCg==

