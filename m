Return-Path: <linux-pci+bounces-24838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17BA73039
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11724179E43
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102E2144AC;
	Thu, 27 Mar 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UagUpG9D";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HN4tP89f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CC2144A8;
	Thu, 27 Mar 2025 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075647; cv=fail; b=Iolsnfkbr6JFYrLcRH/WBeXjrq3hurlXdlIP5euCAPSueGAyR67RD6xMgKJvEeW9Att0tU9REwKvjP1OdDqFTE3/JYbunFEGzuTX/Jm8X5kBXWs7kWJvTFU1TLs3nqqcTYfWHs0eCt36XwSL9YeM6JzPgBpp4QtVFIXXgo7m1FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075647; c=relaxed/simple;
	bh=Kq+eXlm6oACfW83wJ55td4/6X3gATEGlrTsTKqmrM6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RyteG7pl217K/1aS7gzRYV6mEMx7Ga5/yJiixzGiLO1WGdj89w7VuzgTKh+SGOR0vzZ6vGALk6mtwpcWvomuneSiSjGHB5nicnbtjJmcFW226RfBLHVNGw5gl7hbD504arMLm6pVAgwg9fsUZ2J6mXoosewHv0OCzZUxplj4kos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=UagUpG9D; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=HN4tP89f; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7kx5x031554;
	Thu, 27 Mar 2025 04:40:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Z2XSJJlG0KR7Kj/P1g9Xkql2Desgqp0CrRvgudiQxoA=; b=UagUpG9Dc3MM
	Nzh08KFfpKNkpLmQqL68fQdDMkynR0FIbVSn/jagSAaKpdQERez1yw4e/oEKcCcK
	QHNznqc1yP5CB9FdoFQbKxaRUh0WG8SoGvO1DdyzCF2M9oLA6E7XNuiyHL6K1xoe
	DViRfxaHzd1RMDwQMxBN8h0nGBkJy/l+8I/APJRrvNjFBhlZJC+U4uk2x90vzEcg
	S6wrlKJ0X72w1GOcF8miBcdmTo9F7W3Zv/So4yG6LjlmSLSzg12snr0xyIN4NXgg
	1Jxk0c7B5fKLQLtPK6D4EgrWMrKRqEJ0Two7MyZcdNmcAui6n2r8o/16MnpN9LEV
	0hx6xb8VMg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010007.outbound.protection.outlook.com [40.93.10.7])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrwmxt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGRUbIlZHQoSGO8qY2B2yR7fCBfkFWOOU0Q2Uq1zvBpiz10Ny+Bd1ltFxY9zDVjNgQ9bugEXqyUMpy6aqFnDE3WTPHJYS00YoxR9HNj1A/3jYgalJkWfHuxD2ka4DyJDI8293AHbFTd7CmSnhJOS8JudVnzNsrGb69YLBmcHZWQPOHEjBJ3Wh7eyBYLsHGZdaGozRYeJnEEcAO3t9qyZ3KnX576O9i87w0Oq5d06zlnR2DoW52It/RdT042gUsruVYZWR8qWGPesqrvwQf70/cZdtIvlCU4b6g3taOtMnBj/yWxorN2C77BEhi2UwG7BhJmUaEFLD+FAwqx3RtvmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2XSJJlG0KR7Kj/P1g9Xkql2Desgqp0CrRvgudiQxoA=;
 b=Y5B+aGujmr/AtHSeMwdOD5bkugTZfhjcaV2afDtryIB99F1GIAhW+CyGHaMCXOXZi7TnTjaw3W4SamcVu9W4MSMAytARIVLMtKXukHPYPhwPI93R51/erlvbaTVW88cbbpcSF+z8OrgVWw48VND6jIuUS2L1NHI89PRJ4uXhR5xB3KvDHoGzLxNzGZPz14hv8uXEdIKIKnRc17aTQVv1nqFToZUMCu+Sptb6CTkSMj5wlhugK/xTbY54+0hRqAhQeRlhSV7Ddj7XhPuNtuhclIJmbCBYq3xS2Wluy7LY+UrgwJKEBbgrvGYwyDx8E5xo2jAhVZNSL1jiMsqk/JLfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2XSJJlG0KR7Kj/P1g9Xkql2Desgqp0CrRvgudiQxoA=;
 b=HN4tP89f7orLRbE3SZWo4hWfUaic0X31q078QkF5BT+si2u/10MLL9SB44UQY3X6LuYsGN43kf+D1RAIdNLxoiZosPHY/ze+70yqouD/NDAq3VC0K5JlYABQrYVSlzIIl0tCoSWBmc4v83MUSorusB+5QIbf6mY+iZuwvqSfzjk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by MN2PR07MB7294.namprd07.prod.outlook.com
 (2603:10b6:208:1db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:40:36 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:40:36 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] PCI: cadence: Add support for PCIe Endpoint HPA
 controllers
Thread-Topic: [PATCH 4/7] PCI: cadence: Add support for PCIe Endpoint HPA
 controllers
Thread-Index: AQHbnwkT/WXya8JxT0KBS+TATPDd87OG289Q
Date: Thu, 27 Mar 2025 11:40:36 +0000
Message-ID:
 <CH2PPF4D26F8E1C61F700C22A738FF8846DA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111200.2948071-1-mpillai@cadence.com>
In-Reply-To: <20250327111200.2948071-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00YTg2OWQxYy0wYjAwLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcNGE4NjlkMWUtMGIwMC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIxNTkxNCIgdD0iMTMzODc1?=
 =?us-ascii?Q?NDkyMzM2ODE3MDg5IiBoPSJjQlBSaDF4T2tiRG8rcCt3TnNra1ZyZTJ2dWc9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQURCMDkwTURaL2JBVlRtN0Jpb3pzUm1WT2JzR0tqT3hHWUpBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFDT0JRQUEvZ1VBQUpJQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQXg5YU81UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR1FBYmdCZkFIWUFhQUJrQUd3QVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUhN?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWJ3QnVBSFFBWlFC?=
 =?us-ascii?Q?dUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQVVBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJm?=
 =?us-ascii?Q?QUdFQWN3QnRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBR1lBYndCeUFIUUFjZ0JoQUc0QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFa?=
 =?us-ascii?Q?QUJsQUY4QWFnQmhBSFlBWVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?us-ascii?Q?QUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0J3QUhrQWRB?=
 =?us-ascii?Q?Qm9BRzhBYmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFISUFkUUJpQUhrQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQUJRQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|MN2PR07MB7294:EE_
x-ms-office365-filtering-correlation-id: 894cd921-07b3-4987-1dff-08dd6d2430c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+FgyQT62NRWLx7w6lfipDo8wuGIez7z5d1kIm69UyuL1bfl1f+uTIuy60y80?=
 =?us-ascii?Q?OoDD/YrnqM36DvxpLCeE+m4JFKF4XAwqVS0xPGDg3U8ex0fsrWbRIyvqryCG?=
 =?us-ascii?Q?DK6omn5qyy1/XG4WeTrUP3ZBfpi0IeYu112H3FCJGrNd5hjPwdRwa13ScLrf?=
 =?us-ascii?Q?D/ZNQHadlZwM7WddteW1magXCZuyxyEdAQ59hP3qqLQn+f7KEYaq9t/zs7jD?=
 =?us-ascii?Q?ueiJxGVLc/+1spjjn06gBtt5CrHYq/3hw9QhfSmU7Qz4Ue4EMrjSAECgHIUm?=
 =?us-ascii?Q?pqiPm1HlyHffD372dk4DdqPqKwBqQgSkuSwHQuGVePPwF4VDGquRwOzeUF9V?=
 =?us-ascii?Q?Zun8GCR6M30WEjZbMPZ4MsSICa72U/TNMYHD4NTUxerTf5dA93x3DmLZxLnT?=
 =?us-ascii?Q?jijeAycLiJN/Nix9KSjoT8uI042oS8gNzL3Sos6Rn3C0QoAqt2OdJIr7Fr/2?=
 =?us-ascii?Q?vFpGNeKzbaCcZ1L9BqQNhQqrkR/5cMMcvj8h6nne8JheXRWUTBtZhcHwmwFg?=
 =?us-ascii?Q?BZjyvAQ6Z0gm0Ct8EZK+XyjPTU1H3MTtp8LWUwMA5Qtp3UqHvp4vMDpCh+rU?=
 =?us-ascii?Q?Fy20SGfo2xqit9ort1snex/ujIcZ9aJ1+k9I0NqFuAOLgN4O3PaU3Il89nxl?=
 =?us-ascii?Q?I7WmxEnYPr1hiH7utvqlYBq1P4+Vm5R9NcsVStJAVhyh+zdrLovokIfyCirf?=
 =?us-ascii?Q?R6fBTXNXepfqZc2sUQ1QzY4sIQqIyflDAUMKA48shvXHibHcB9kCxg8nW0Qb?=
 =?us-ascii?Q?XemtqSKxyD7YAF14okIy0lnU6s29UjQCnmQ4mSO6YOmH/wWnt59JK9fyNSKy?=
 =?us-ascii?Q?UtRsOyl4XdWfs1fUtqwVl7rc1bWTAaCoB7tFYRo3e4+LwJmp9Hbt3W6xQgNM?=
 =?us-ascii?Q?4xyKjWl466CT2mxCjMUNXfRkHawOMe23bAsPbfW1jxQrZat9KT1dkMrsnHqV?=
 =?us-ascii?Q?3jEHMxY6DkSF2mYflgfSQUysblt2lqshkJIJHyNC2KOLItBxtlYcNBYDgSV9?=
 =?us-ascii?Q?AtdCYXpUDU9zMLUBmTdrpRCp+w/1h4KKFvFvOkr4p3E3CZJ38rU2+DAZgYlT?=
 =?us-ascii?Q?WwLX7iWeTZyuiqemQxBLI+LE03ll8erpzBx/tCmFmHNbMWOQgN8tncgrfWQ6?=
 =?us-ascii?Q?L4yUr1ZG16Ys1KNwC7QhH6TqKMZohUXtYvcm7JMBzTRUI158Y0EajChaoDjl?=
 =?us-ascii?Q?Tu3vuCvRRoZdqJdayrvYgc2C/RWIEWeeT3xcULi3kKFMdpCcB6DdkXon9vVp?=
 =?us-ascii?Q?pVV/5DK8j/GuXUvHDdIJ4FgCqcT1OKrVfQAZpR87anYqbaz98GnpYkAdGJae?=
 =?us-ascii?Q?vX0kW+3G+BoLYFz0sbtVXXTgaYzbCEVVDsRFeD6A04B28Ngjs+rgLkvkO+eV?=
 =?us-ascii?Q?WoVvv6I7Yc3gfxQf0zzNg2mRTRg5gzByK/lua1FiYmI+9eTXapwYTi9FEpzI?=
 =?us-ascii?Q?1XC6F9WrwtjtZNnOKruj7ghmP1u8dvni?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EH7vNRhF39JcfK9es+TX9XnDRbaWoWPsnvFWydb2Dj/BgioDlpMQRMr+5Fk1?=
 =?us-ascii?Q?FiVP8gEvy3ET1tujjGtDIBDlG283SMP2x8FlRhi+olbrgTBu2FnTdkB+l5vN?=
 =?us-ascii?Q?AEV0To2W20PIeReOVIKyBIAyFl0RmALgzmdsBbHSXKzBa/7B9YFGGS6B9MfK?=
 =?us-ascii?Q?o0KcvmkzghJHOOS+2A0v+U1r5uwNTtFYMChUY6wAMdaAS7UdTVxB46VPWDz3?=
 =?us-ascii?Q?EN6+ZqDDr73i4pPXbM+UozD7VByR/V7q6ERK2BB1NHWGu/H61FieYwOJWWqd?=
 =?us-ascii?Q?0ykw/RiMVISQoeSphQgof1IGE5TQ9vBpN2loi+1+r46icE1oHZ4BZL83HlB6?=
 =?us-ascii?Q?fKDv/tKxOJKqnkl+t1JWqGHcfK11w66aB7k2bX2zwVnEWqtCnjvmx9YUNkA+?=
 =?us-ascii?Q?U2KXzSuFRIZ3D1JH/shMfDhE4pBI+muJk9JTARgZyaNeWYUxUDp2yTUcJ3t/?=
 =?us-ascii?Q?VGojESsnVCUeVZsIzjdlNEScDY10+OwpS6ICDzp1WnoAqLJaGIkbIwjJ33Lm?=
 =?us-ascii?Q?9JirFwzutznNWB71XCiDEcjbxlq2s9kpKVs9G3uBhb5U3h1eNz9yAMZUojKo?=
 =?us-ascii?Q?RKPAIO8Oci7Q4u7c62N5ZCIFJ6hT+1wq9bXUVQ5Krv2qyQvpoGZadv7N1pys?=
 =?us-ascii?Q?VUG/kJJVkaySJaZ+tRC3b6+kFgWkndBj2AAGazuCG5cDkMZcBCy91KznET5y?=
 =?us-ascii?Q?YFh9X16x/ZTiRwg3rIu6GcWiPNS+gWwxJ5Y1jsv+rxf771dCsmtwJnMEpNxQ?=
 =?us-ascii?Q?c7UMY7RDzBPi2pbEPBadFC++Rw0ygjTHTwxnfADCSECxwcxdlnntWwLt5RQ5?=
 =?us-ascii?Q?Bum71UFoKr2tsS/CvzMfuns1CUWXpIAt3UTMA9riqExgeU+bf3TqrkmCeXk7?=
 =?us-ascii?Q?WiMoITkciFcbQyj9VnQn+ib8jiGhlX35R/4iuWAsrOspe6XIfl1XFth1w1Q0?=
 =?us-ascii?Q?wMbovsm36lrgKZJbuEnlcRP53tu/jKH0AX9NSjAmZPiUz1PQDs/ZCRMKEhEr?=
 =?us-ascii?Q?WlHVIJlz8IlyJsPW6Ir01mCgyuL6640YBDFj45Acn/0vYBdT9E3vJIylaPXj?=
 =?us-ascii?Q?PgVYvEMcI6O7ySrRrmgV0RyTAosETkc94WgW8GHTRQ4whmREm+N1o92VjUd+?=
 =?us-ascii?Q?7iszwYVYp8xFsPADQveAphDFfgZbG88SJdM9qpOZLWqu3mI8F0KUpqEvEao3?=
 =?us-ascii?Q?0UPORhfv9IBcStnVLlXKUglTjolKpKBksWtwx5a/sNd7aFs4UF395IJVZzxA?=
 =?us-ascii?Q?T2BYZOOQV2PC7ql4bgFaHk1v/5rogofGx82CQ4HywZqMXmwfD4bQAFutTcvm?=
 =?us-ascii?Q?PnLkSWF/kjALnMz0VU6wudLnEsEPVFKzgJ9T3AN1skZQVpgI46x4DN7WV6Wa?=
 =?us-ascii?Q?5CKOlnNH17VjiSssd7tCR5hs+3OW+fNaY9X2aX5fWgdB9z3stlKHuAq2NVDm?=
 =?us-ascii?Q?h4n5jZJkTwHwxCAGBs3Fy5BZU8YoGL1O6ftUotB1r+zg9VLkuVTUceLDUfgc?=
 =?us-ascii?Q?Z39ctI40qjqaMJz0+4pXTY7l2qVEuRN1DLL8FbMjJZ/XzeB6hDjwCGs9I6h3?=
 =?us-ascii?Q?8Ps4ocWL/V2QxvCpf5yn9RLg+LdWppXOy4y6TMlU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894cd921-07b3-4987-1dff-08dd6d2430c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:40:36.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwsNd9hU/NxN/C4LqbysoxoK8t+WakrIGTTa532K3aKqD98nzCDBk+4C2pK3VSodAFoAd8vWg8xU33ckdcfFAzg5kdSzF2efUS6BnRQzGuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7294
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e53936 cx=c_pps a=NtTLQTA3WOB+IhtGMQTGww==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=n7m9l1-mCJkT1szWuNkA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: yqw0_x-FPSRmkp0ATfb3lxVkcBulBQcR
X-Proofpoint-ORIG-GUID: yqw0_x-FPSRmkp0ATfb3lxVkcBulBQcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270080

Add support for the second generation(HPA) Cadence PCIe endpoint
controller by adding the required functions based on the HPA registers
and register bit definitions

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 154 +++++++++++++++++-
 1 file changed, 146 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..1dc13e403473 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -93,7 +93,10 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 =
fn, u8 vfn,
 	 * for 64bit values.
 	 */
 	sz =3D 1ULL << fls64(sz - 1);
-	aperture =3D ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+	/*
+	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
+	 */
+	aperture =3D ilog2(sz) - 7;
=20
 	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
@@ -121,7 +124,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8=
 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
-	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		cfg =3D cdns_pcie_readl(pcie, reg);
@@ -158,7 +161,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc,=
 u8 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
-	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
@@ -569,7 +572,11 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
+	if (pcie->is_hpa)
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
+				     CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc->function_num_map);
+	else
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
=20
 	/*
 	 * Next function field in ARI_CAP_AND_CTR register for last function
@@ -606,6 +613,117 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
=20
+static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				    struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf =3D &ep->epf[fn];
+	struct cdns_pcie *pcie =3D &ep->pcie;
+	dma_addr_t bar_phys =3D epf_bar->phys_addr;
+	enum pci_barno bar =3D epf_bar->barno;
+	int flags =3D epf_bar->flags;
+	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u64 sz;
+
+	/*
+	 * BAR size is 2^(aperture + 7)
+	 */
+	sz =3D max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	sz =3D 1ULL << fls64(sz - 1);
+	/*
+	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
+	 */
+	aperture =3D ilog2(sz) - 7;
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
+		ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS;
+	} else {
+		bool is_prefetch =3D !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
+		bool is_64bits =3D !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+
+		if (is_64bits && (bar & 1))
+			return -EINVAL;
+
+		if (is_64bits && is_prefetch)
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
+		else if (is_prefetch)
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
+		else if (is_64bits)
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS;
+		else
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS;
+	}
+
+	addr0 =3D lower_32_bits(bar_phys);
+	addr1 =3D upper_32_bits(bar_phys);
+
+	if (vfn =3D=3D 1)
+		reg =3D CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg =3D CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
+		cfg =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, reg);
+		cfg &=3D ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |=3D (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, reg, cfg);
+	}
+
+	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), addr1);
+
+	if (vfn > 0)
+		epf =3D &epf->epf[vfn - 1];
+	epf->epf_bar[bar] =3D epf_bar;
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				       struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf =3D &ep->epf[fn];
+	struct cdns_pcie *pcie =3D &ep->pcie;
+	enum pci_barno bar =3D epf_bar->barno;
+	u32 reg, cfg, b, ctrl;
+
+	if (vfn =3D=3D 1)
+		reg =3D CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg =3D CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
+		ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+		cfg =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, reg);
+		cfg &=3D ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |=3D CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
+		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, reg, cfg);
+	}
+
+	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER_COMMON,
+			     CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
+
+	if (vfn > 0)
+		epf =3D &epf->epf[vfn - 1];
+	epf->epf_bar[bar] =3D NULL;
+}
+
 static const struct pci_epc_features cdns_pcie_epc_vf_features =3D {
 	.linkup_notifier =3D false,
 	.msi_capable =3D true,
@@ -645,6 +763,21 @@ static const struct pci_epc_ops cdns_pcie_epc_ops =3D =
{
 	.get_features	=3D cdns_pcie_ep_get_features,
 };
=20
+static const struct pci_epc_ops cdns_pcie_hpa_epc_ops =3D {
+	.write_header	=3D cdns_pcie_ep_write_header,
+	.set_bar	=3D cdns_pcie_hpa_ep_set_bar,
+	.clear_bar	=3D cdns_pcie_hpa_ep_clear_bar,
+	.map_addr	=3D cdns_pcie_ep_map_addr,
+	.unmap_addr	=3D cdns_pcie_ep_unmap_addr,
+	.set_msi	=3D cdns_pcie_ep_set_msi,
+	.get_msi	=3D cdns_pcie_ep_get_msi,
+	.set_msix	=3D cdns_pcie_ep_set_msix,
+	.get_msix	=3D cdns_pcie_ep_get_msix,
+	.raise_irq	=3D cdns_pcie_ep_raise_irq,
+	.map_msi_irq	=3D cdns_pcie_ep_map_msi_irq,
+	.start		=3D cdns_pcie_ep_start,
+	.get_features	=3D cdns_pcie_ep_get_features,
+};
=20
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
@@ -682,10 +815,15 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	if (!ep->ob_addr)
 		return -ENOMEM;
=20
-	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
-
-	epc =3D devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	if (pcie->is_hpa) {
+		epc =3D devm_pci_epc_create(dev, &cdns_pcie_hpa_epc_ops);
+	} else {
+		/*
+		 * Disable all but function 0 (anyway BIT(0) is hardwired to 1)
+		 */
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
+		epc =3D devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	}
 	if (IS_ERR(epc)) {
 		dev_err(dev, "failed to create epc device\n");
 		return PTR_ERR(epc);
--=20
2.27.0


