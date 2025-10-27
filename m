Return-Path: <linux-pci+bounces-39359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59EC0C244
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 08:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFF234E160E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C397A24503B;
	Mon, 27 Oct 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="1l4FAykx";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="eTuwrdP8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325F1F0E3E;
	Mon, 27 Oct 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550372; cv=fail; b=XO/bunAG/613WcQAQDowmXo5/zmUfP721k2KSmNCkNJSq7uJxiyzncPFvVMfEUd4HQHAI6VBkzCPml7PUlgwP+A53Fl1yvd/y1m6D1r9r+QlFGpln4rU52R0Rj7er2iGItPpE8WJNJkctRGOp2YY1q8RDsmuS+ATB1EM/u6fzm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550372; c=relaxed/simple;
	bh=zSGjdKkOIvSVH9fOZtTh8yuUDRPqZ3MfznyY6RzHXBc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZsFbIvkeS3XUL0HLIf3g5FCJLUAed0WrbMjeDkqZFXpiZMGPR4p7O+IbBVg+srybz+QBthc2xYseZ8zSjydB3a/c196NOI7HIVov5Df+KKNPtrvvaa2LQOyWMAtnTTqWs5SjBqw3PSXqJ0NVqmlA2eLeEUfV2JpjL5/42WFcG1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=1l4FAykx; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=eTuwrdP8; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QJeFxQ1864416;
	Mon, 27 Oct 2025 00:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=HxoqE0mph3btb
	1ktmWnLz2O0xPlESJUCdVrwh66kzEA=; b=1l4FAykxWsXt50jYzAEbIevhvf2W5
	M+5flxrJTEFWwJ1FCzsJZVi3pfw7woQedwAu2cJp047sp6xgyGbKaI/NoNe6iMrn
	8rs61LPTnAZlk2CAxzoq9Kpci1v5QxQLayrBzej61owQrI9uZpBqfXtlwiqCevhq
	fv+xEahZ75Jb4W3r88ZYxD57ZCzMtUrxdeG4KDD142XevyCTh3yzJGhqCuPYTHCn
	oojIcP04cD5PwdBhcE/P/JxYyzlXozl94wCnlH1q5Ad1m/cIHYXVNJZz2zB5MDPP
	CvH9dEQPldDURVl7l1OtSlmF80yxXhPn0TTfV1fyHQbwdAdOaCEj9c0iA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021078.outbound.protection.outlook.com [52.101.62.78])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a0vnhajcf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 00:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSXYVHCt6PAtCtuxP8FifTBIPcttis9azcbu20l7xtGs9Y99Z0I4QQmvhGeA2tfRSPZRpTeDVyGOMDK3M7PPaCrQIsRQ86rxiEadTBUztk+yinBJ02ubAeGTbQ1ZvzanBW8XnLcoMKth37IvTt4ZN003t5Wp5HPkqnSxQBdQIlBqWjqA/F3pVQuG9VBL+1I9ShRdWALeV9n+MBHwN5nMHlnXfiVQ35VfLX8kM+0oVtS9vuiFsuUnQGnszRdc6PS/xLdEwmMZDsSAHhXbssi2yByff+ekxJJfcGlJzakHa0aWY9cWw6DNdWjWtFuqr9f60CRUJ+vEqZFOFWvo8hWYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxoqE0mph3btb1ktmWnLz2O0xPlESJUCdVrwh66kzEA=;
 b=oSSUUCqU28vq8ZHPzxXjVU55SY6GH4feLLh66dlp76JIlXhPhgGO76TvyhV6D+0lTp+SiTbu0nfXggIeCam05KNxNZ7ejNWKMvQSbzO1Krul1h+PbijTgedMyPy9zSvuwrjTQgaUIKDTqkH/iUExNCiwqD3027DD7k+HBFp3qi8M0MoYhWr+21heRhd2OK57RcqUjogToPmIJQsbA7AA8Y7c26eOmO1vs+qOKB9mC3nSq/40TaiE36ozEJ1d3ARBSUHktGHloPsnUbnfqmOfGE0poyrJx3pnyVy/BjksRUBWk0s1sZDzBBb1tIWxeoNusSSaJBbo2VkWJS37BQ8EZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxoqE0mph3btb1ktmWnLz2O0xPlESJUCdVrwh66kzEA=;
 b=eTuwrdP82tmzgOY2H1RndR5RrFsqamOf0kptc98NG86gZfIV1gOh7K31FrBwQh+YjZXz7oni4qJ25PZC1oOqJQXQoCCdL6YdzCpMAXgCn+V0FUgsVPQV+mfQ5SFGyCL6/mu732Z5BRTuAlQCG7Zb0aiawUvs3tBxs5peDAyd8Cie4Pz+3byAcDAVCyqyqxcizDad3hgG43ywZH7f8RBUu+JcKr5j3/Ncuq+PsG/i3B1m8zbPvDHbntTfUAcpY9LImYcxiwx+Zg9Fa2ngRjh4/kDa53bsD2VDO/fBfDNM5RoAQm3QXxcdNRwNQvYq9z4LVEfEvgV/PNhQ8o7zVeoK9Q==
Received: from PH7SPRMB0074.namprd02.prod.outlook.com (2603:10b6:510:2b6::6)
 by MWHPR02MB10595.namprd02.prod.outlook.com (2603:10b6:303:282::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 07:32:39 +0000
Received: from PH7SPRMB0074.namprd02.prod.outlook.com
 ([fe80::3d33:a373:9b0c:bec2]) by PH7SPRMB0074.namprd02.prod.outlook.com
 ([fe80::3d33:a373:9b0c:bec2%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:32:39 +0000
From: Ramkumar Santhanakrishnan <ramkumar.s@nutanix.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Ramkumar Santhanakrishnan <ramkumar.s@nutanix.com>
Subject: [PATCH] PCI: Enable ACS "Direct translated" feature on capable
 devices
Thread-Topic: [PATCH] PCI: Enable ACS "Direct translated" feature on capable
 devices
Thread-Index: AQHcRxPfUKJqrrV0OUewME9a0lssRQ==
Date: Mon, 27 Oct 2025 07:32:39 +0000
Message-ID: <20251027073057.39077-1-ramkumar.s@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7SPRMB0074:EE_|MWHPR02MB10595:EE_
x-ms-office365-filtering-correlation-id: 71d7caee-7558-4d6b-d1e1-08de152b01eb
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DJxfm8GyYI55xvcWwJjlOy26h8uihAqnBPN0UjSWnDYq4GXh1p6XQCjOIl?=
 =?iso-8859-1?Q?Pb7jE4s7gTVVOL8331USLMBA4w4gMsZ7ftWJjLpjQ9fbs8JihEwqEdyk0r?=
 =?iso-8859-1?Q?Lo71fc7dB1kHO6XLmblFLm10SAzYTWLtEywx3PUms3yXlSmPmPzJFst1Rf?=
 =?iso-8859-1?Q?lUDxRaIaPx6FvKDY9rzou82sTsjPW/guMXi8PAh7XqIP52h4t1iQqZq7+9?=
 =?iso-8859-1?Q?OFSDhnfFO/4DJJfpHZAvKD4Fs9vVrwt1qqbR2ImnhMkmt5/oiczfPDp3js?=
 =?iso-8859-1?Q?w3+3mf/afMvfnYvXU8TDjkHAoJed8DuoLryflwktt9yulcrv8BMizt9gre?=
 =?iso-8859-1?Q?ASRmiYGWZ1BXF6jDQyEQRPFipUcmo4JETZw0CTKCdDWW6aJM0D1zXNVuuR?=
 =?iso-8859-1?Q?7d9TC1YBIINLxIBrbb6ru9KRBhCFsMBPWt+ou+hrgeCKfud6aCOytC6Gw5?=
 =?iso-8859-1?Q?9GvJGC+SrrkRtQyLPyRix5drP8SrmXEWS50RbgY/2UeZALvKH8Ev3qDdzv?=
 =?iso-8859-1?Q?q88Y8xDg0k79AAA3i7h9MPXt/tEfQ9fJkVG3PnW1mdZAW6xScltD+rYZoZ?=
 =?iso-8859-1?Q?7puZGRXAwHe0ynj+IuhFVmaFgLCw87WlMRaT5fothZ/XLm4b+5Yo2ABvvF?=
 =?iso-8859-1?Q?72Vo7YypZyAQR07WXfs+IDGPSCi+mrNHyU3ami98vCdmo+Avcc//F+tkzR?=
 =?iso-8859-1?Q?eSC1tfHtInEvnkuMQWH1IaOpTEMOOYdgVWpfRNduamjEtsZRauCXt1yRIL?=
 =?iso-8859-1?Q?NE5lPHNhSoxNoypofZfxQZyKMHMmuYKZUoXC03EcnSCJ0WnrdwIgsdG44D?=
 =?iso-8859-1?Q?VKvCxEv2PZQDN13QfYnVNK+jJ+2vAUTPUP0U5QGQnUNhOhNPdLuurQRkva?=
 =?iso-8859-1?Q?S5b5G/Qe61+aDNQNbvnUC9wbqhze/1w0jg0A5HnW+Jz6+Wf2+RDEHOvFPQ?=
 =?iso-8859-1?Q?hNPE8PC4v14PiAfvu5VXYMtXRLPrAz2yl+ihm2fcqtJHVnrPFDh0mfcUB9?=
 =?iso-8859-1?Q?5gsq6Pcw/KhR4GZJmYJJP5C4TcLNfihgPPRFhpyn7JR5hdoY+wciE02m5C?=
 =?iso-8859-1?Q?y2+awdDZ4SMHKYmbK6BnLWlgfUwvWjNz2bXvHq6L9lVx1eadHaJEuKJc8X?=
 =?iso-8859-1?Q?8JOBoRDhCgjBM4c3eZhIIUYc5MWJ4xRtj89ieQY6MYMp5gpPjsK0qbjUUn?=
 =?iso-8859-1?Q?3SkgD/c2gxIEZQ/wVRxd+YO7m84SrdkfO0gTvPa9j38H2AggcBjkW9fRPz?=
 =?iso-8859-1?Q?KDviwfOs1zQqtiIoccqYuJdYMtd/wS+WLnrVciK+asI19PzH84DFtuly/w?=
 =?iso-8859-1?Q?dvC2SUw0hPWoZ0OyoMV75uXoLOUYEGxhbPh/SfNmcdc2rBA/3gHqtFI2v0?=
 =?iso-8859-1?Q?o3t1q5kzW5gx7nDMHI3KliIhohSzU9OD9JkbxWLfkEDD9ZNlEBsj4mzbeH?=
 =?iso-8859-1?Q?uTC2l24XDFfATx3I0xgta7KAH8ZqDqT9Ud0hIXSr702ibixgMtZ8ob4xB3?=
 =?iso-8859-1?Q?iWgsC4J8FdPoAZcG5NUFVrat+3QV5LAem/zgNZ/FqiLmxFSvG1wxa8+HYQ?=
 =?iso-8859-1?Q?5Bfb8sBFtgJAsYfcMYt945eUj9kf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0074.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XfkVQIkYtUd7y6yHZtEM3Ad3+bT6zKnT9xOd+csgzSQ5PI4a+vw2IwJaMc?=
 =?iso-8859-1?Q?kUV3/V4Gc9MiuLz7LzO9ArIa8P2+rUivxfJBGmPaZPWK2mRn1DSpZOME+K?=
 =?iso-8859-1?Q?xwXc6nsOKsoCH19xuO435PuoAqoJPWVLbu29KlztVUaQkDrb0N6GR2y/Oo?=
 =?iso-8859-1?Q?DQslSQlMFY8Qq6EO/7pkRZnADAkGhpUmY0eF9ewQYXKdfLLuMg49yjmVer?=
 =?iso-8859-1?Q?lKIHH0ocVo+G3xGPT74A4dCqYhFk7bvWzrFg1k15k7ETwdGyAEPAE/eNNj?=
 =?iso-8859-1?Q?u/QpxJ3HbuE0l8AFQdMvR1069Qu4uWplhq41cn+ksuCEOE90lDX+0CoL8z?=
 =?iso-8859-1?Q?3pJ9BpYGoBSN2BdoiS/czrhpwmy27AMz1rWU0Z5lVQtEyOiz7UTncktC7+?=
 =?iso-8859-1?Q?Tan5HZWLnsDrSlke67cvl+0FV6XTUWc0nD8XrU7yTg5qsosXLfYBdbPbMy?=
 =?iso-8859-1?Q?DK47iOXLiVsP8ptDAChXTFb6jGufQ28+2NJouvuC/R79GFnlrucdmWFPfP?=
 =?iso-8859-1?Q?CDOix0NxJWbCj8lGZ1/5ulVNXLV7OXiIwSKGI2NwOlUyg8bqVFqTeBQc2k?=
 =?iso-8859-1?Q?xrTof+XIjctbSNBxnxymfoUuCzOlynDzGr7yKj+SEjBmAY/XYYwb7dcWvT?=
 =?iso-8859-1?Q?sTaSofne3tPtku50bmTSfU2e7mV2GbohUYt3cZ7t0SoCt2EYAlArYT2LJF?=
 =?iso-8859-1?Q?JQHpRj6W6WPy1VuwDO7J2mTdLEECZQkmo+mPIt12pQkQx3Qq/2otwbNI0n?=
 =?iso-8859-1?Q?Oz4Tw4m8Fr4k9q/bAkJGBoxQ8O9QUfOQMizjy7QcbB/x8CBAunHXmq9jmZ?=
 =?iso-8859-1?Q?YmgCv3mmMKBI2dBH1BZN9w4wvYzAeNt/LOt9iQVxVtddBp48TwAUCXlvCE?=
 =?iso-8859-1?Q?ggUH31moBf1xiBc6/aDEDFKTZSC4WjyFHfmVg5yor0uburLMv0x6FA1jjY?=
 =?iso-8859-1?Q?bKowEt+OrV7UfUWNLCMfQ33DcWhyuELK53ZJXvnKpBQvo8FztJC/L/T+ca?=
 =?iso-8859-1?Q?/HOkdijxdTAEQJ8hrpSZ63lEwMNI4g4mLN6wHjaYWjx+vjFuaNv2wk0ucx?=
 =?iso-8859-1?Q?7lAWWXzjC1geVJ6VOTtsBPb0x08upl/59s/OYkspQ5+PxvMHZ3XN9tyoRR?=
 =?iso-8859-1?Q?Ug5J3CnJs3mOmPPCyisaNPaSu/8pt6U8uaBdBnqN4hNLq4jSKwPYotH0t8?=
 =?iso-8859-1?Q?7U0bkxrGTBgUUJnos8lT8GPSIFRACDSyykaRs4DqeJD94Fz949v9vjyBeo?=
 =?iso-8859-1?Q?QEqlA5+G3leYmml1thgI/mHM8IguOH0/p+mOCDocGBxHZmwntpQ+kD1zej?=
 =?iso-8859-1?Q?n2/5NbelYMiW2mIjHK3ur2BxK9Qug9Nbvl4MYElCoaGIl6FkMUWmgK97+D?=
 =?iso-8859-1?Q?E2+yfLiXNUEBePQ4w1Do+YMQxdXM8KjAYbtYep0rniLV7m1LRCxt5yidpQ?=
 =?iso-8859-1?Q?FfFdG/i2Rzqc7bh2awbFh76hX3Pl6qwGKO7bUHbgO3y/N8fhtFWoz+pJpg?=
 =?iso-8859-1?Q?bui88iNPosb//kjOClzuOzhVmzirWzogqvvXxDqYZ9kCce45uvNWYr6GgM?=
 =?iso-8859-1?Q?LnXm1RkYeGw2lh351YK11vvwjG7a4sOvM2vHDXLrgETOVE+J8w1IQUqMsh?=
 =?iso-8859-1?Q?G5r3AI/JYa3skAE/WHEImsEPeH9EYuFqm9ElVKRrDk5mviqnEiJGQhCw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0074.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d7caee-7558-4d6b-d1e1-08de152b01eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 07:32:39.3160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTnyLuZ3fwIfeHWRHLjGBQsU//Pi8gnJSY/lnNkmu+qZ7B/xjh6JtRwfrAzzvvmtDzMf/AFLKOi4AfjSRdPZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10595
X-Authority-Analysis: v=2.4 cv=Iv0Tsb/g c=1 sm=1 tr=0 ts=68ff2019 cx=c_pps
 a=c/RC1Hvpwd1gfJZSTjwoVw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=RoCAQQWJHEkieRfjs9kA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: s-msi7pEaeqcmOPfEyO3IEiWhA1qTL6p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2OCBTYWx0ZWRfX3j8BLWRyHsEf
 NKTMlHum/3kbUTILgn0hEQp3VK6rBYftNCK/42AdrGZwIObKNY2zmxlSOlqngZBRk0wbcAahrU8
 hVTNMtu20mfyYceawC0Qqp6Dq7Ubi6QW9w5zB+EdyfsvB9R1/52uPb1brvq716JpfnG5Z6SrQgs
 DCjjzye/205erLXRB5D3SAC4gtu3u5Hr4yX2+dEv+yIbKv+o08mg59ZFmvm9mZ/i+Mbrg6lDexc
 2ZoYXlpo6XRL+7tFslpKY02Nfzm4NScq3kf4anYJ1ynh2CIjvLJ0dkDmnaRuCf74A5lmtwjchcJ
 7fmNZ2QXmA3ccNBCKQv7UoHp0CGUaU6b1v9Yk4CSnfEH/cAV8NAID4zyCK4wJM+U8Ic9lD+rBAY
 0cz4RtNhI/nvQbKHL2xaJgUldLavCA==
X-Proofpoint-ORIG-GUID: s-msi7pEaeqcmOPfEyO3IEiWhA1qTL6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

From: "ramkumar.s" <ramkumar.s@nutanix.com>=0A=
=0A=
The "Direct Translated" feature of ACS should be enabled on the PCIe=0A=
bridges to direct the transaction with translated address from one=0A=
downstream device to another downstream device.=0A=
=0A=
The ATS capable devices can accelerate the P2P transaction by caching=0A=
the address translation and directly send the PCIe transaction with=0A=
the translated address. The parent bridge of these ATS capable devices=0A=
should have "Direct translated" feature enabled to forward these=0A=
packets to the target devices.=0A=
=0A=
The intention is to enable the "Direct Translated" feature when=0A=
the ATS is not disabled and the device is trusted and not external.=0A=
=0A=
Signed-off-by: ramkumar.s <ramkumar.s@nutanix.com>=0A=
---=0A=
 drivers/pci/pci.c | 7 ++++++-=0A=
 1 file changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c=0A=
index b14dd064006c..e5e5ee3ccfc1 100644=0A=
--- a/drivers/pci/pci.c=0A=
+++ b/drivers/pci/pci.c=0A=
@@ -1006,9 +1006,14 @@ static void pci_std_enable_acs(struct pci_dev *dev, =
struct pci_acs *caps)=0A=
 	/* Upstream Forwarding */=0A=
 	caps->ctrl |=3D (caps->cap & PCI_ACS_UF);=0A=
 =0A=
-	/* Enable Translation Blocking for external devices and noats */=0A=
+	/*=0A=
+	 * Enable Translation Blocking for external devices and noats,=0A=
+	 * otherwise allow Direct Translated.=0A=
+	 */=0A=
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)=0A=
 		caps->ctrl |=3D (caps->cap & PCI_ACS_TB);=0A=
+	else=0A=
+		caps->ctrl |=3D (caps->cap & PCI_ACS_DT);=0A=
 }=0A=
 =0A=
 /**=0A=
-- =0A=
2.43.5=0A=
=0A=

