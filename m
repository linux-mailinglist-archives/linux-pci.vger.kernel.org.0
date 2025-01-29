Return-Path: <linux-pci+bounces-20518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B35A218C1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D5C7A237B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544B190665;
	Wed, 29 Jan 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sE5Op80m";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="i5DMKSRN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D02190072;
	Wed, 29 Jan 2025 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138690; cv=fail; b=tNpAzkjMh84mREpxolwk1iP1ndio3Zfo9BUj9ptZbt/KP0ruLY9mIliYLS4FPonMkd/Dlpz3dquqXMtE26LXnu2q2WhC+GFvh/6x3+hT8Qdv3LCVn7AO+vscORhbwIjauRPBZQeRu1c/UE50kmdSHuK0dJv67v68V24E+Icr0Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138690; c=relaxed/simple;
	bh=F4QDYNb0yFM5WVOC7XwFcyS/0cJx6zfudCS1Jb8ff9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S+eQSXSVig/tep3c590mCceWv29PgVdYG22KMVthO+9YOu7yFFtOau4zoGnuK0+QXq3yYyuS8tsldxSm/bUY89BokWAVd3H7CVl9L5daxcP4wXQ7xh8AUopB2rsdWzxy+s1onnmbhDVHKLcP/yy34qxhdliRh0qpY3GS43Nkr6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=sE5Op80m; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=i5DMKSRN; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SLEreN010706;
	Tue, 28 Jan 2025 23:24:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Fj1kgQv+B850tBU4UrwduLbEdCW+n3phjkwOV0o9/Mg=; b=sE5Op80mumvm
	s51oKM5RPJBboJfBan10gquon2LxwmYCuGo+RFcZd/AF18t2CzmD4x8LWh7B5lw7
	jndbB9r54WomRyYomcaOum/WQMR7IcgFTck6aO4a0wTECSEFeZiZyxbipUfiqGc5
	oe+FX3/mpYGRPDF9UrilApRB+Q6Ybxeo1O1JzOVxVDKgAlxKwyoj9r/Fit38kYRR
	IyovMUBTnsQp3ChKiccz93jwhl/KM6H7Qmc4ImcVBwqKpouP6FuCpO9PCdzwHedC
	B7ptPegh8tpXdBoX+kirmZ1NQDM95OcXsxGzPasn1ENf8LELFNVVu56gDNF2VA/j
	QJcALuqipw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 44f6ypsty0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 23:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGz71bYtByrQp7V1GruxBDwYTEdPF3a8WS8sQ8Rgr5OdaA0HsR2Xtmn3dSYMLseZDEGIatNq7qHpRAy/oNFkagnd6BuYCOdtp+K2XqBNPMi8cWYXa/KZ6qykvR2Ac+hgTPK4kcy5mKxNmwjjI+8z+2bdUaGbo1VgegFWexBkrVc7HhipqKd7mpBv2COBKe/51kNk5nIBR94G6/yAEndGHAmZXh/NURhnyXrJthjhgLf9gaMtVPMKwarjy3rdb6kCjk4DHeHBJD5qk1gB6XsBEfRNkm6C5SOn08lRpnBOJ2gYiU7zz8Z0XJuJ15ldJdjLHkFcUGpwjgGPCsaq7J8rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj1kgQv+B850tBU4UrwduLbEdCW+n3phjkwOV0o9/Mg=;
 b=JDQsgDVWeHAjr22bh+kCwznDIzA5GM9MmZ27EDDZfQbjCDog7IhY3IFWWGBU6cJ5SbPojoAwc3TMm3/0rXkGMK4UPbOAIS9n7pmbDOBUBrZbHEezDVZJtLYyKRcwkOXUE438PO74mhxghq6ZbW4lCNlnvowqGoZm+8IomMe5ZaOV3iI7XVP0t851ZXW7MsEKcJOWZNiWrDUFF3fszZeTB3DJkw6ZBANQ+QUcnxp2DrLC2ral+RxiZxnNCwAvBjQcuPx4XotHS8Y5/vVtoALQJKgWFtd5QztsMTVB+A1wU4LcjoGT4+frRdVDV4/Hn4IeCk5dgJcmWXFM0EWcuxQgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj1kgQv+B850tBU4UrwduLbEdCW+n3phjkwOV0o9/Mg=;
 b=i5DMKSRNheiflR58B4OnCcSX9UF2/yLzIBcthwtOxB4mbstGYEASyxRVyvmPchXToev0jtLtjMGrzwykL0gFIxOzJ/+lfwZxKOVe6XjfSVpNJLPN52LCvrBMcPa+WBdZjv4YQubyAE9rZD2WfwdaeCLzcqablQ7RUfWRvvjHHwk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA1PR07MB8452.namprd07.prod.outlook.com
 (2603:10b6:806:1af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 07:24:04 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%5]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 07:24:04 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: [PATCH] Enhance PCIe cadence controller driver for supporting HPA
 architecture
Thread-Topic: [PATCH] Enhance PCIe cadence controller driver for supporting
 HPA architecture
Thread-Index: AQHbchyTfzOJ2HQLaUWpj/zJNr9TybMtVqmQ
Date: Wed, 29 Jan 2025 07:24:04 +0000
Message-ID:
 <CH2PPF4D26F8E1CB68755477DCA7AA9C6EBA2EE2@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250129070650.2148382-1-mpillai@cadence.com>
In-Reply-To: <20250129070650.2148382-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wMDIxNmNhMi1kZTEyLTExZWYtYTM2?=
 =?us-ascii?Q?Ni1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcMDAyMTZjYTQtZGUxMi0xMWVmLWEz?=
 =?us-ascii?Q?NjYtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI5Mjg1OCIgdD0iMTMzODI2?=
 =?us-ascii?Q?MDkwMzc0ODM3MTIyIiBoPSJEMzBNVzREdUdWQkZHNFBUejd5cy84cjB2V1k9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFHQUlBQUNDczNqQ0huTGJBVGgyOEVnYmlXMnVPSGJ3U0J1SmJhNEtBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBc0JnQUFuQVlBQU1RQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQWhGVjh5UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR0VBWkFCbEFHNEFZd0JsQUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhR?=
 =?us-ascii?Q?QWFRQmhBR3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVpBQnVBRjhBZGdC?=
 =?us-ascii?Q?b0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZd0J2QUc0QWRBQmxBRzRBZEFCZkFHMEFZUUIw?=
 =?us-ascii?Q?QUdNQWFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUJSQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFIQUFjQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBY2dF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY3dBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU5BQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFa?=
 =?us-ascii?Q?QUJsQUY4QVpnQnZBSElBZEFCeUFHRUFiZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?us-ascii?Q?QUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JxQUdFQWRn?=
 =?us-ascii?Q?QmhBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?RzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBY2dCMUFHSUFlUUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUF4QUVBQUFBQUFBQUlBQUFBQUFBQUFB?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUNBQUFBQUFBQUFDa0FRQUFDZ0FBQURJQUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?aEFHUUFaUUJ1QUdNQVpRQmZBR01BYndCdUFHWUFhUUJrQUdVQWJnQjBBR2tB?=
 =?us-ascii?Q?WVFCc0FBQUFMQUFBQUFBQUFBQmpBR1FBYmdCZkFIWUFhQUJrQUd3QVh3QnJB?=
 =?us-ascii?Q?R1VBZVFCM0FHOEFjZ0JrQUhNQUFBQWtBQUFBVVFBQUFHTUFid0J1QUhRQVpR?=
 =?us-ascii?Q?QnVBSFFBWHdCdEFHRUFkQUJqQUdnQUFBQW1BQUFBQUFBQUFITUFid0IxQUhJ?=
 =?us-ascii?Q?QVl3QmxBR01BYndCa0FHVUFYd0JoQUhNQWJRQUFBQ1lBQUFCeUFRQUFjd0J2?=
 =?us-ascii?Q?QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdNQWNBQndBQUFBSkFBQUFBMEFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QnpBQUFBTGdBQUFB?=
 =?us-ascii?Q?QUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVpnQnZBSElBZEFC?=
 =?us-ascii?Q?eUFHRUFiZ0FBQUNnQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FB?=
 =?us-ascii?Q?WlFCZkFHb0FZUUIyQUdFQUFBQXNBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxB?=
 =?us-ascii?Q?R01BYndCa0FHVUFYd0J3QUhrQWRBQm9BRzhBYmdBQUFDZ0FBQUFBQUFBQWN3?=
 =?us-ascii?Q?QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSElBZFFCaUFIa0FBQUE9Ii8+?=
 =?us-ascii?Q?PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA1PR07MB8452:EE_
x-ms-office365-filtering-correlation-id: 87265fdd-f88d-4ce7-8f55-08dd4035e8ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ay5jRmkum2eNTQqE4f9sKLkzr3O7PwN0uAK8cD97fSIXj8Di+Cse2D7Dp4eI?=
 =?us-ascii?Q?1p6l6hXlqg6xwMMWVEnic+YIeyxO6/Dcb32+qunQvIbH7dCA5ZIyJgYGChdQ?=
 =?us-ascii?Q?IdLiOrAzJxTxB7N97g33LmRmINElr/CYR+8e97pU+HNl5sKyxuIQE0pKSkF/?=
 =?us-ascii?Q?A7WKlGeieaKgrxt2rv37ceWlLE9PLcV7UwL21Qqdtob8M3ddsMRz3OczN5zn?=
 =?us-ascii?Q?2PXJweYVAOjlIvruc8GC1pVPKTCZBvHRGFD2443Yq9chcRN6+rLNSqKXfe3r?=
 =?us-ascii?Q?dcxc5JWl/HwLFSmkp1J7eP5TBNM3eJ+6aQ9HcawEo4vF995KwB9+2FHooTZP?=
 =?us-ascii?Q?kOX8lOscvb/IFSbKqE+gViKcVsA/kdzypf1qBf7kK67cd8QN08CZJ7eAAgKM?=
 =?us-ascii?Q?0PE3XCtLtu93gYjBmN9B5+sWhB0cOueCgUkgGi/a9h9EjqImIhb6FmrA0i13?=
 =?us-ascii?Q?j2qU/GC1/sMu3AclTBidA7Z18nv1tZPgSJFKkz7SqOh/gWj6ZpDZqw9Mx/SB?=
 =?us-ascii?Q?v1hHqDuQRxFCOFCOyxMN/wK4+YiF16xwoI1ZngSzu3geaigmSjqGT5i3wPU8?=
 =?us-ascii?Q?kmEztsY2vP/UDqc1VSOI8GYmzuLj3ZUL4sRH9aPgN7s4ZYYk+B0pfwwfjKZ5?=
 =?us-ascii?Q?61cDLiml1ds/Ei+9EMmVxFncLg4spY8BWokehf1jlMuYYpz45mvhU+/K448N?=
 =?us-ascii?Q?N5caJZrMVo2Tv8jY6qlrL+C+82sgp8ZZFl9ykw5OHh00l4snHEtw5nOauwWR?=
 =?us-ascii?Q?KcyQD9V3QC+N2dC36XRax2goFhYjapQUY3Ug3+tfZSvjonXzsBk1+1z5sHtB?=
 =?us-ascii?Q?4YuMRT3XslsWigqXvHA7QynZz8uo/B+hcQQirF9SPJzFLhtLi4f6Owst0tlL?=
 =?us-ascii?Q?HITkAFdilAYsFodO647RnbQhxx8Pja9n8Ae/IMlKU0LCFcnLXzK8bW1ygrtL?=
 =?us-ascii?Q?cVUGrpjWn2kWqfDJlzzX5e07mKOsh3/KCF/g9EZzPvjQ7dHCMso5WrYeEy0g?=
 =?us-ascii?Q?2Pq5HtA1hEP5pjivK8KFCPMlDlBLgWbQENuoBvjKeg6+808o0c50UKsjEDCa?=
 =?us-ascii?Q?VvJ/wFDK9RjiXxBxDTM/S613RRW6oCQl0xTFtIU36rVhxV/ADkLPnzk3DyUj?=
 =?us-ascii?Q?wOyUlWuO/x2kTzoarLk74QV7EVAZrH+mUyIK1U1/DRCRbD1GXhh/QBLV+ju8?=
 =?us-ascii?Q?V73q1q6W4rFHhdG4uXrJI5kiT7WZ5Q2twfuRf6No/PL/NJMkmiMGP7P6KThK?=
 =?us-ascii?Q?xeaptgA9tr18uYEdnXHK7pgdQF4IsHrjtrY9vWNJHccNrs3YPI4KnGJ0mO6L?=
 =?us-ascii?Q?68aqRQBPDAeLDfvInEcwq3YRzhhxYSTCrDahZATnlM07hIsEV49Wq07BM9OJ?=
 =?us-ascii?Q?7vDebPCn/uyVqGZAnPVmG5D5s58Y1eR33CSiveuo9ewWyTWcMRQYQPzySL8a?=
 =?us-ascii?Q?rMqzJd5qElAH/2Wy7KpEVM2EdHMsZG3r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XHfYssB26HSy+RgLtMECw9oQ+SI3cAubsHhEw7KAmILLal4upSty3bGn3jIY?=
 =?us-ascii?Q?opEY7ULqkmbj4KTAn1GtABKOANdgSMPC2Q5jJX37c8gBd1BTOSY+jXFMWs+o?=
 =?us-ascii?Q?zd9432XZT6eASjoa0UbyxubOlLv/G0aeJLmsZtqgZOon/sV/7gWh6qM1tUcl?=
 =?us-ascii?Q?Q2fVcyoe8K9vGI4p4eGdO1DZnIZvKihS3NTDK3m1aGkqDaAeOvqEYQdzLVl/?=
 =?us-ascii?Q?8Cdg7nGnWnn47QWwYaxmdY86KYPvlKiJVcV7B0fJ65O7QcPyDOmUf/yiOWlb?=
 =?us-ascii?Q?9gkYCmnkHeOfFgPZzVUKPWcodai+ZTpM3B+YlUVmzykd2y5zodXoHiLvLhVf?=
 =?us-ascii?Q?+b2oXNBOHjGrVAfQkGZcwrWy61vZlDT6tKWYmhNZ7001cFbwKn/PjzLkXROE?=
 =?us-ascii?Q?GUPMxt6L0yxQmpbF3oaRfwqCKCjNmuAX9sqViAQnwz68eU358egVGUKYvL5L?=
 =?us-ascii?Q?9V1LbcDWJdHmGvbMUkD8f1mxB3qvH9Tk+DeRbUL30gn1h0OBrK3LoyTFw066?=
 =?us-ascii?Q?yqAU+OeHjUaEwv+6vVc23Elo2s8wbT7JB3l8igDVjm/yzbdZCH6sH9UrHf9C?=
 =?us-ascii?Q?SJQOOBWesQqPxmfunilvfXyjqb7COvNlKP9qlcdYuxbQusIBogyqyj8fXMcX?=
 =?us-ascii?Q?eQXG4IQOWtfmaPV2VKRJqwLPudadZN0UwZzMkOS93el9A1QumIFCfQyX294j?=
 =?us-ascii?Q?oy2iRdo5fPL5JczY67F5pPL77lsaOeqQ8ndiNxh+v/m1Cb/kRpkckwtGqMwE?=
 =?us-ascii?Q?35T1GKoxkO/sJiCOZuYzzfKfhgnoDKB4+2SXXNeoR7UKHDG9+qyVv+5w1BQH?=
 =?us-ascii?Q?F1Pj86xFR4yBPohCecmanQ7k7QMeMqv8RdhSsG0v0FHw4gZ//4dq6sC6L+fU?=
 =?us-ascii?Q?O8cyLW5MUAT+fd/0rFB33iWICTr3UY4Z6vo+TyF27dqGa5ulOlDpJsotRjQo?=
 =?us-ascii?Q?xTV7C9BzTd5wH4GKLHe5dYWKpPuc0UTiggxO8LFYeYCBcKL5D3AWE/3Ex3ej?=
 =?us-ascii?Q?W+sncCPgfK92qSms7/Z+Iz0lwuwmjmL/Fybb3XEc5PTrsMixBb/dmLK97RUa?=
 =?us-ascii?Q?5OZuffeBNqJqf2Jlsf2hXZO6FQMDPmX15vzr+rxgY90EV/2aussGUzH9Ywch?=
 =?us-ascii?Q?gQMgPhi2EYa5kUDjUmALTIv7K9hn8BJjHh5yt4eUBOVpG7x9aSDwOAeTr9VJ?=
 =?us-ascii?Q?hn1qPHxbr5j2nNW1hm2JbemLK5Kd0OkQYcs8A9pPc4nMMbFwEhUA2+NEG59y?=
 =?us-ascii?Q?Ug91kAesIXtxpexG1jnV/H3OteuOu0Blf5MthcpdAJp+sn/nUxD17kivYeXR?=
 =?us-ascii?Q?bK0pjQuX+A6PzTDoh8fumQ/6yMe+XlniIUvVVakp56Y/rTMIa/9tGNu53Gbw?=
 =?us-ascii?Q?Epm1hf/1+9BVNs0wQJdbS1WqBMoUL9hhZ35MnpY7L0YjDDqufA9QZ2KrvQfA?=
 =?us-ascii?Q?7ADTMycDG96NcWRVN3F+ldk6VEbQw/R53PR+5/9eEkkQhjszVbGVt1l26lj3?=
 =?us-ascii?Q?/dzqh7mjbT2wSntfwuNxns1p8Top5Pw2x8cnf5fqb65bVLYNuTIxYND37Tnc?=
 =?us-ascii?Q?VT2sJnjUHZnfGhqaY6NaR8PFgNp0Rx4RSK10TPdh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87265fdd-f88d-4ce7-8f55-08dd4035e8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 07:24:04.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk9+h75jz1xTuD6OmxxoFdZwnQZp5NGmaQ7BDft1TYN0DfGXpI2nnVB/RyBkpbuVfSS2TOn1G4hmHJlEZjFspFDZQGNS7VchUYEzHQinvV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8452
X-Proofpoint-GUID: 5fveKajZ9keycusXsoFCtYZ5xuYeETIi
X-Proofpoint-ORIG-GUID: 5fveKajZ9keycusXsoFCtYZ5xuYeETIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290060

This patch enhances the Cadence PCIe controller driver to support HPA
architecture. The Kconfig is added for PCIE_CADENCE_HPA config, which
needs to be selected when HPA compatible PCIe controller is supported.
The support for Legacy PCIe controller does not change.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
Signed-off-by: yuanzhao <yuanzhao@cadence.com>
---
 drivers/pci/controller/cadence/Kconfig        |   8 +
 .../pci/controller/cadence/pcie-cadence-ep.c  |  12 +-
 .../controller/cadence/pcie-cadence-host.c    |  44 ++-
 .../pci/controller/cadence/pcie-cadence-hpa.h | 260 ++++++++++++++++++
 .../controller/cadence/pcie-cadence-legacy.h  | 243 ++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c |  42 ++-
 drivers/pci/controller/cadence/pcie-cadence.h | 230 +---------------
 7 files changed, 598 insertions(+), 241 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.h
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-legacy.h

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controlle=
r/cadence/Kconfig
index 8a0044bb3989..d7501ce7b39e 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -6,6 +6,14 @@ menu "Cadence-based PCIe controllers"
 config PCIE_CADENCE
 	bool
=20
+config PCIE_CADENCE_HPA
+	bool "PCIE controller HPA architecture"
+	help
+	  Say Y here if you want to support Cadence PCIe Platform controller
+	  on HPA architecture
+	  The option should be deselected if the Cadence PCIe controller
+	  is of legacy architecture
+
 config PCIE_CADENCE_HOST
 	bool
 	depends on OF
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..caf8040b12e9 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -121,7 +121,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u=
8 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
+#else
 	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+#endif
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		cfg =3D cdns_pcie_readl(pcie, reg);
@@ -158,7 +162,11 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc=
, u8 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
+#else
 	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+#endif
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
@@ -569,7 +577,6 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
=20
 	/*
 	 * Next function field in ARI_CAP_AND_CTR register for last function
@@ -682,9 +689,6 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	if (!ep->ob_addr)
 		return -ENOMEM;
=20
-	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
-
 	epc =3D devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "failed to create epc device\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/p=
ci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..be279c5baa5d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -14,6 +14,18 @@
=20
 #define LINK_RETRAIN_TIMEOUT HZ
=20
+#ifdef CONFIG_PCIE_CADENCE_HPA
+static u64 bar_max_size[] =3D {
+	[RP_BAR0] =3D SZ_2G,
+	[RP_BAR1] =3D SZ_2G,
+	[RP_NO_BAR] =3D _BITULL(63),
+};
+
+static u8 bar_aperture_mask[] =3D {
+	[RP_BAR0] =3D 0xF,
+	[RP_BAR1] =3D 0xF,
+};
+#else
 static u64 bar_max_size[] =3D {
 	[RP_BAR0] =3D _ULL(128 * SZ_2G),
 	[RP_BAR1] =3D SZ_2G,
@@ -24,6 +36,7 @@ static u8 bar_aperture_mask[] =3D {
 	[RP_BAR0] =3D 0x1F,
 	[RP_BAR1] =3D 0xF,
 };
+#endif
=20
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where)
@@ -32,7 +45,7 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsig=
ned int devfn,
 	struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	unsigned int busn =3D bus->number;
-	u32 addr0, desc0;
+	u32 addr0, desc0, desc1, ctrl0;
=20
 	if (pci_is_root_bus(bus)) {
 		/*
@@ -46,20 +59,30 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, uns=
igned int devfn,
 		return pcie->reg_base + (where & 0xfff);
 	}
 	/* Check that the link is up */
-	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
+	if (!(cdns_pcie_readl(pcie, (CDNS_PCIE_AT_LINKDOWN)) & 0x1))
 		return NULL;
 	/* Clear AXI link-down status */
-	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN,
+			 cdns_pcie_readl(pcie, CDNS_PCIE_AT_LINKDOWN) & 0xe);
=20
 	/* Update Output registers for AXI region 0. */
 	addr0 =3D CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
 		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
 		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(busn);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(0), addr0);
-
+	desc1 =3D 0;
+	ctrl0 =3D 0;
 	/* Configuration Type 0 or Type 1 access. */
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	desc1 =3D cdns_pcie_readl(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0));
+	desc1 &=3D ~CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN_MASK;
+	desc1 |=3D CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN(0);
+	ctrl0 =3D CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+		CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+#else
 	desc0 =3D CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
 		CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
+#endif
 	/*
 	 * The bus number was already set once for all in desc1 by
 	 * cdns_pcie_host_init_address_translation().
@@ -69,7 +92,10 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsi=
gned int devfn,
 	else
 		desc0 |=3D CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(0), desc0);
-
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CTRL0(0), ctrl0);
+#endif
 	return rc->cfg_base + (where & 0xfff);
 }
=20
@@ -239,11 +265,19 @@ static int cdns_pcie_host_bar_ib_config(struct cdns_p=
cie_rc *rc,
 		return 0;
=20
 	value =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_RC_BAR_CFG);
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 7));
+#else
 	value &=3D ~(LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
 		   LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
 		   LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
 		   LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
 		   LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
+#endif
 	if (size + cpu_addr >=3D SZ_4G) {
 		if (!(flags & IORESOURCE_PREFETCH))
 			value |=3D LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-hpa.h b/drivers/pc=
i/controller/cadence/pcie-cadence-hpa.h
new file mode 100644
index 000000000000..ee0bd76d84a0
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-hpa.h
@@ -0,0 +1,260 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe Gen5(HPA) controller driver defines
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#ifndef _PCIE_CADENCE_HPA_H
+#define _PCIE_CADENCE_HPA_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-epf.h>
+#include <linux/phy/phy.h>
+
+/*
+ * This file contains the updates/changes for PCIE Gen5 Controller
+ */
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES 10
+#define LINK_WAIT_USLEEP_MIN  90000
+#define LINK_WAIT_USLEEP_MAX  100000
+
+/*
+ * Local Management Registers are renamed here and
+ * are in tune with PCIe Gen5 changes in controller
+ */
+#define CDNS_PCIE_IP_REG_BANK           (0x01000000)
+#define CDNS_PCIE_IP_CFG_CTRL_REG_BANK  (0x01003C00)
+#define CDNS_PCIE_IP_AXI_MASTER_COMMON  (0x02020000)
+
+/* Vendor ID Register */
+#define CDNS_PCIE_LM_ID		        (CDNS_PCIE_IP_REG_BANK + 0x1420)
+#define  CDNS_PCIE_LM_ID_VENDOR_MASK    GENMASK(15, 0)
+#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT   0
+#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
+	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
+#define  CDNS_PCIE_LM_ID_SUBSYS_MASK    GENMASK(31, 16)
+#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT   16
+#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
+	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
+
+/* Endpoint Function f BAR b Configuration Registers */
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FU=
NC_BAR_CFG1(fn))
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(pfn) \
+	(CDNS_PCIE_IP_CFG_CTRL_REG_BANK + (0x4000 * (pfn)))
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(pfn) \
+	(CDNS_PCIE_IP_CFG_CTRL_REG_BANK + (0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_V=
FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(vfn) \
+	(CDNS_PCIE_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(vfn) \
+	(CDNS_PCIE_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x0C)
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(9, 4) << ((f) * 10))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_M=
ASK(b)))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_IP_REG_BANK + 0x02c0)
+
+/* Root Complex BAR Configuration Register */
+#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_IP_CFG_CTRL_REG_BANK + 0x14)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(9, 4)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	(((a) << 4) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(3, 0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	(((c) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(19, 14)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	(((a) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(13, 10)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	(((c) << 10) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
+
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_ENABLE BIT(0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_IO BIT(1)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_MEM (0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_32BITS (0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_PREFETCH_MEM_DISABLE (0)
+
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_ENABLE BIT(10)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_DISABLE (0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_IO BIT(11)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_MEM (0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_32BITS (0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_PREFETCH_MEM_ENABLE BIT(13)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_PREFETCH_MEM_DISABLE (0)
+
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(20)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS    0
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS    BIT(21)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE      BIT(22)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS      0
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS      BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Comple=
x */
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x3
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x1
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x9
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x5
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0xD
+
+#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
+					(((aperture) - 7) << ((bar) * 10))
+
+#define  CDNS_PCIE_LM_RC_CFG_BAR_APERTURE_MASK(b) \
+	 (GENMASK(9, 4) << ((b) * 10))
+
+/* PTM Control Register */
+#define CDNS_PCIE_LM_PTM_CTRL	(CDNS_PCIE_IP_REG_BANK + 0x0520)
+#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Endpoint Function Registers (PCI configuration space for endpoint funct=
ions)
+ */
+#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+
+#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
+#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
+#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
+#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
+
+/*
+ * Endpoint PF Registers
+ */
+#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
+#define CDNS_PCIE_ARI_CAP_NFN_MASK			GENMASK(15, 8)
+
+/*
+ * Root Port Registers (PCI configuration space for the root port function=
)
+ */
+#define CDNS_PCIE_RP_BASE	0x0
+#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
+
+/*
+ * Address Translation Registers
+ */
+#define CDNS_PCIE_AXI_SLAVE	0x03000000
+#define CDNS_PCIE_AXI_MASTER    0x03002000
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_AXI_SLAVE + 0x1010 + ((r) & 0x1f) * 0x0080)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(23, 16)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	(((devfn) << 16) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(31, 24)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	(((bus) << 24) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_AXI_SLAVE + 0x1014 + ((r) & 0x1f) * 0x0080)
+
+/* Region r Outbound PCIe Descriptor Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_AXI_SLAVE + 0x1008 + ((r) & 0x1f) * 0x0080)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(28, 24)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM	\
+	((0x0 << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO	\
+	((0x2 << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	((0x4 << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	((0x5 << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	((0x10 << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK)
+
+/* Region r Outbound PCIe Descriptor Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
+	(CDNS_PCIE_AXI_SLAVE + 0x100c + ((r) & 0x1f) * 0x0080)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(31, 24)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
+	(((bus) << 24) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	(((devfn) << 16) & CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN_MASK)
+
+#define CDNS_PCIE_AT_OB_REGION_CTRL0(r)	\
+	(CDNS_PCIE_AXI_SLAVE + 0x1018 + ((r) & 0x1f) * 0x0080)
+#define  CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define  CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_AXI_SLAVE + 0x1000 + ((r) & 0x1f) * 0x0080)
+#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_AXI_SLAVE + 0x1004 + ((r) & 0x1f) * 0x0080)
+
+/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
+	(CDNS_PCIE_AXI_MASTER + ((bar) * 0x0008))
+#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
+#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
+	(CDNS_PCIE_AXI_MASTER + 0x04 + ((bar) * 0x0008))
+
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AXI_SLAVE + 0x04)
+
+/* Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define  CDNS_PCIE_PHY_LAYER_CFG0   (CDNS_PCIE_IP_REG_BANK + 0x0400)
+#define  CDNS_PCIE_LTSSM_CONTROL_CAP CDNS_PCIE_PHY_LAYER_CFG0
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 24
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
+#define CDNS_PCIE_RP_MAX_IB	0x3
+#define CDNS_PCIE_MAX_OB        15
+
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register =
*/
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_IP_AXI_MASTER_COMMON + ((fn) * 0x0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_IP_AXI_MASTER_COMMON + 0x4 + ((fn) * 0x0040) + ((bar) * 0x0008=
))
+
+/* Normal/Vendor specific message access: offset inside some outbound regi=
on */
+#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
+#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
+	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
+#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
+#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
+	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
+#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+
+#endif /* _PCIE_CADENCE_HPA_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-legacy.h b/drivers=
/pci/controller/cadence/pcie-cadence-legacy.h
new file mode 100644
index 000000000000..1053cae9fd72
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-legacy.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2017 Cadence
+// Cadence PCIe Gen4 controller driver defines
+// Author: Manikandan K Pillai <mpillai@cadence.com>
+
+#ifndef _PCIE_CADENCE_LEGACY_H
+#define _PCIE_CADENCE_LEGACY_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-epf.h>
+#include <linux/phy/phy.h>
+
+/*
+ * This file contains the changes for PCIE Gen4 Controller
+ */
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
+/*
+ * Local Management Registers
+ */
+#define CDNS_PCIE_LM_BASE	0x00100000
+
+/* Vendor ID Register */
+#define CDNS_PCIE_LM_ID		(CDNS_PCIE_LM_BASE + 0x0044)
+#define  CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
+#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
+#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
+	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
+#define  CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
+#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
+#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
+	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
+
+/* Root Port Requester ID Register */
+#define CDNS_PCIE_LM_RP_RID	(CDNS_PCIE_LM_BASE + 0x0228)
+#define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
+#define  CDNS_PCIE_LM_RP_RID_SHIFT	0
+#define  CDNS_PCIE_LM_RP_RID_(rid) \
+	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
+
+/* Endpoint Bus and Device Number Register */
+#define CDNS_PCIE_LM_EP_ID	(CDNS_PCIE_LM_BASE + 0x022c)
+#define  CDNS_PCIE_LM_EP_ID_DEV_MASK	GENMASK(4, 0)
+#define  CDNS_PCIE_LM_EP_ID_DEV_SHIFT	0
+#define  CDNS_PCIE_LM_EP_ID_BUS_MASK	GENMASK(15, 8)
+#define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
+
+/* Endpoint Function f BAR b Configuration Registers */
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FU=
NC_BAR_CFG1(fn))
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn0) \
+	(CDNS_PCIE_LM_BASE + 0x0240 + (fn0) * 0x0008)
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn1) \
+	(CDNS_PCIE_LM_BASE + 0x0244 + (fn1) * 0x0008)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_V=
FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn0) \
+	(CDNS_PCIE_LM_BASE + 0x0280 + (fn0) * 0x0008)
+#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn1) \
+	(CDNS_PCIE_LM_BASE + 0x0284 + (fn1) * 0x0008)
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(ba) \
+	(GENMASK(4, 0) << ((ba) * 8))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << ((b) * 8)) & (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))=
)
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(bc) \
+	(GENMASK(7, 5) << ((bc) * 8))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 8 + 5)) & (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))=
)
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)
+
+/* Root Complex BAR Configuration Register */
+#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	(((a) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(13, 9)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	(((a) << 9) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
+#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS		0
+#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
+#define  CDNS_PCIE_LM_RC_BAR_CFG_CHECK_ENABLE		BIT(31)
+
+/* BAR control values applicable to both Endpoint Function and Root Comple=
x */
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x1
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
+#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
+
+#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)		\
+		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)	\
+	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << (((bar) * 8) + 6))
+#define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
+					(((aperture) - 2) << ((bar) * 8))
+
+/* PTM Control Register */
+#define CDNS_PCIE_LM_PTM_CTRL	(CDNS_PCIE_LM_BASE + 0x0da8)
+#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Endpoint Function Registers (PCI configuration space for endpoint funct=
ions)
+ */
+#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+
+#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
+#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
+#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
+#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
+
+/*
+ * Endpoint PF Registers
+ */
+#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
+#define CDNS_PCIE_ARI_CAP_NFN_MASK			GENMASK(15, 8)
+
+/*
+ * Root Port Registers (PCI configuration space for the root port function=
)
+ */
+#define CDNS_PCIE_RP_BASE	0x00200000
+#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
+
+/*
+ * Address Translation Registers
+ */
+#define CDNS_PCIE_AT_BASE	0x00400000
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
+#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
+
+/* Region r Outbound PCIe Descriptor Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(3, 0)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xa
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xb
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG	0xc
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_VENDOR_MSG	0xd
+/* Bit 23 MUST be set in RC mode. */
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
+#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
+	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
+
+/* Region r Outbound PCIe Descriptor Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
+	(CDNS_PCIE_AT_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
+#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
+	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
+#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_AT_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
+
+/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
+	(CDNS_PCIE_AT_BASE + 0x0800 + (bar) * 0x0008)
+#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
+#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
+	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
+
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
+/* LTSSM Capabilities register */
+#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE + 0x005=
4)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
+#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
+#define CDNS_PCIE_RP_MAX_IB	0x3
+#define CDNS_PCIE_MAX_OB	32
+
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register =
*/
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_AT_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
+
+/* Normal/Vendor specific message access: offset inside some outbound regi=
on */
+#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
+#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
+	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
+#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
+#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
+	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
+#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+
+#endif /* _PCIE_CADENCE_LEGACY_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/co=
ntroller/cadence/pcie-cadence.c
index 204e045aed8c..edd7e5332e8e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -34,7 +34,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie=
, u8 busnr, u8 fn,
 	 */
 	u64 sz =3D 1ULL << fls64(size - 1);
 	int nbits =3D ilog2(sz);
-	u32 addr0, addr1, desc0, desc1;
+	u32 addr0, addr1, desc0, desc1, ctrl0;
=20
 	if (nbits < 8)
 		nbits =3D 8;
@@ -53,37 +53,51 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pc=
ie, u8 busnr, u8 fn,
 	else
 		desc0 =3D CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM;
 	desc1 =3D 0;
-
+	ctrl0 =3D 0;
 	/*
 	 * Whatever Bit [23] is set or not inside DESC0 register of the outbound
 	 * PCIe descriptor, the PCI function number must be set into
 	 * Bits [26:24] of DESC0 anyway.
+	 * for HPA, Bit [26] is set or not inside CTRL0 register of the outbound
+	 * PCI descriptor, the PCI function num must be set into Bits [31:24]
+	 * of DESC1 anyway.
 	 *
 	 * In Root Complex mode, the function number is always 0 but in Endpoint
 	 * mode, the PCIe controller may support more than one function. This
 	 * function number needs to be set properly into the outbound PCIe
 	 * descriptor.
 	 *
-	 * Besides, setting Bit [23] is mandatory when in Root Complex mode:
-	 * then the driver must provide the bus, resp. device, number in
+	 * Besides, setting Bit [23]([26]- HPA) is mandatory when in Root Complex
+	 * mode then the driver must provide the bus, resp. device, number in
 	 * Bits [7:0] of DESC1, resp. Bits[31:27] of DESC0. Like the function
 	 * number, the device number is always 0 in Root Complex mode.
 	 *
 	 * However when in Endpoint mode, we can clear Bit [23] of DESC0, hence
 	 * the PCIe controller will use the captured values for the bus and
-	 * device numbers.
+	 * device numbers. For Gen 5, instead clear Bit [26] of CTRL0.
 	 */
 	if (pcie->is_rc) {
+#ifdef CONFIG_PCIE_CADENCE_HPA
+		desc1 =3D CDNS_PCIE_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 =3D CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+#else
 		/* The device and function numbers are always 0. */
 		desc0 |=3D CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
 			 CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
 		desc1 |=3D CDNS_PCIE_AT_OB_REGION_DESC1_BUS(busnr);
+#endif
 	} else {
 		/*
 		 * Use captured values for bus and device numbers but still
 		 * need to set the function number.
 		 */
+#ifdef CONFIG_PCIE_CADENCE_HPA
+		desc1 |=3D CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN(fn);
+#else
 		desc0 |=3D CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(fn);
+#endif
 	}
=20
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), desc0);
@@ -105,12 +119,23 @@ void cdns_pcie_set_outbound_region_for_normal_msg(str=
uct cdns_pcie *pcie,
 						  u8 busnr, u8 fn,
 						  u32 r, u64 cpu_addr)
 {
-	u32 addr0, addr1, desc0, desc1;
+	u32 addr0, addr1, desc0, desc1, ctrl0;
=20
 	desc0 =3D CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
 	desc1 =3D 0;
+	ctrl0 =3D 0;
=20
 	/* See cdns_pcie_set_outbound_region() comments above. */
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	if (pcie->is_rc) {
+		desc1 =3D CDNS_PCIE_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 =3D CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		desc1 |=3D CDNS_PCIE_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+#else
 	if (pcie->is_rc) {
 		desc0 |=3D CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
 			 CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
@@ -118,7 +143,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struc=
t cdns_pcie *pcie,
 	} else {
 		desc0 |=3D CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(fn);
 	}
-
+#endif
 	/* Set the CPU address */
 	if (pcie->ops->cpu_addr_fixup)
 		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
@@ -133,6 +158,9 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struc=
t cdns_pcie *pcie,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
+#ifdef CONFIG_PCIE_CADENCE_HPA
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CTRL0(r), ctrl0);
+#endif
 }
=20
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/co=
ntroller/cadence/pcie-cadence.h
index f5eeff834ec1..47de8e9e9abb 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -10,213 +10,11 @@
 #include <linux/pci.h>
 #include <linux/pci-epf.h>
 #include <linux/phy/phy.h>
-
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES	10
-#define LINK_WAIT_USLEEP_MIN	90000
-#define LINK_WAIT_USLEEP_MAX	100000
-
-/*
- * Local Management Registers
- */
-#define CDNS_PCIE_LM_BASE	0x00100000
-
-/* Vendor ID Register */
-#define CDNS_PCIE_LM_ID		(CDNS_PCIE_LM_BASE + 0x0044)
-#define  CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
-#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
-#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
-	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
-#define  CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
-#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
-#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
-	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
-
-/* Root Port Requester ID Register */
-#define CDNS_PCIE_LM_RP_RID	(CDNS_PCIE_LM_BASE + 0x0228)
-#define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
-#define  CDNS_PCIE_LM_RP_RID_SHIFT	0
-#define  CDNS_PCIE_LM_RP_RID_(rid) \
-	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
-
-/* Endpoint Bus and Device Number Register */
-#define CDNS_PCIE_LM_EP_ID	(CDNS_PCIE_LM_BASE + 0x022c)
-#define  CDNS_PCIE_LM_EP_ID_DEV_MASK	GENMASK(4, 0)
-#define  CDNS_PCIE_LM_EP_ID_DEV_SHIFT	0
-#define  CDNS_PCIE_LM_EP_ID_BUS_MASK	GENMASK(15, 8)
-#define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
-
-/* Endpoint Function f BAR b Configuration Registers */
-#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn) \
-	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_FU=
NC_BAR_CFG1(fn))
-#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
-#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0244 + (fn) * 0x0008)
-#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn) \
-	(((bar) < BAR_4) ? CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) : CDNS_PCIE_LM_EP_V=
FUNC_BAR_CFG1(fn))
-#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0280 + (fn) * 0x0008)
-#define CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn) \
-	(CDNS_PCIE_LM_BASE + 0x0284 + (fn) * 0x0008)
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
-	(GENMASK(4, 0) << ((b) * 8))
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
-	(((a) << ((b) * 8)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b) \
-	(GENMASK(7, 5) << ((b) * 8))
-#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
-	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
-
-/* Endpoint Function Configuration Register */
-#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)
-
-/* Root Complex BAR Configuration Register */
-#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
-	(((a) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
-	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(13, 9)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
-	(((a) << 9) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
-	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
-#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS		0
-#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
-#define  CDNS_PCIE_LM_RC_BAR_CFG_CHECK_ENABLE		BIT(31)
-
-/* BAR control values applicable to both Endpoint Function and Root Comple=
x */
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x1
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
-#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
-
-#define LM_RC_BAR_CFG_CTRL_DISABLED(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar)	\
-	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)		\
-		(CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar)	\
-	(CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << (((bar) * 8) + 6))
-#define LM_RC_BAR_CFG_APERTURE(bar, aperture)		\
-					(((aperture) - 2) << ((bar) * 8))
-
-/* PTM Control Register */
-#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0da8)
-#define CDNS_PCIE_LM_TPM_CTRL_PTMRSEN 	BIT(17)
-
-/*
- * Endpoint Function Registers (PCI configuration space for endpoint funct=
ions)
- */
-#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
-
-#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
-#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
-#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
-#define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
-
-/*
- * Endpoint PF Registers
- */
-#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
-#define CDNS_PCIE_ARI_CAP_NFN_MASK			GENMASK(15, 8)
-
-/*
- * Root Port Registers (PCI configuration space for the root port function=
)
- */
-#define CDNS_PCIE_RP_BASE	0x00200000
-#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
-
-/*
- * Address Translation Registers
- */
-#define CDNS_PCIE_AT_BASE	0x00400000
-
-/* Region r Outbound AXI to PCIe Address Translation Register 0 */
-#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
-	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
-	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
-	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
-#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
-	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
-
-/* Region r Outbound AXI to PCIe Address Translation Register 1 */
-#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
-	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
-
-/* Region r Outbound PCIe Descriptor Register 0 */
-#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
-	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(3, 0)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xa
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xb
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG	0xc
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_VENDOR_MSG	0xd
-/* Bit 23 MUST be set in RC mode. */
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
-#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
-	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
-
-/* Region r Outbound PCIe Descriptor Register 1 */
-#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
-	(CDNS_PCIE_AT_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
-#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
-	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
-
-/* Region r AXI Region Base Address Register 0 */
-#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
-	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
-#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
-	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
-
-/* Region r AXI Region Base Address Register 1 */
-#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
-	(CDNS_PCIE_AT_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
-
-/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
-#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
-	(CDNS_PCIE_AT_BASE + 0x0800 + (bar) * 0x0008)
-#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
-#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
-	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
-#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
-	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
-
-/* AXI link down register */
-#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
-
-/* LTSSM Capabilities register */
-#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE + 0x005=
4)
-#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
-#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
-#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
-	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
-	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+#ifdef CONFIG_PCIE_CADENCE_HPA
+#include "pcie-cadence-hpa.h"
+#else
+#include "pcie-cadence-legacy.h"
+#endif
=20
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED =3D -1,
@@ -225,29 +23,11 @@ enum cdns_pcie_rp_bar {
 	RP_NO_BAR
 };
=20
-#define CDNS_PCIE_RP_MAX_IB	0x3
-#define CDNS_PCIE_MAX_OB	32
-
 struct cdns_pcie_rp_ib_bar {
 	u64 size;
 	bool free;
 };
=20
-/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register =
*/
-#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
-	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
-#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
-	(CDNS_PCIE_AT_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
-
-/* Normal/Vendor specific message access: offset inside some outbound regi=
on */
-#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
-#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
-	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
-#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
-#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
-	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
-
 struct cdns_pcie;
=20
 enum cdns_pcie_msg_code {
--=20
2.27.0


