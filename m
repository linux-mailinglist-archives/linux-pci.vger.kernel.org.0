Return-Path: <linux-pci+bounces-24504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BFA6D6EC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B9A189074F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA925D538;
	Mon, 24 Mar 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MPhnLUCF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zHyW2WAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167D25D218;
	Mon, 24 Mar 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807352; cv=fail; b=ao46DLE1k2wa/1IpiKId7qtaFuEfQ0iZNyxr7wBbJcAzzwAjobUpYcvu0bLpHvCd5VCEGoLqXUnVqHp/7w6z/Y7ZpACGoQgGk25zxDzoUgaB7iwa0Pa9cYfky8oSZKrj6c1K50yyZT0Fz0buyfcz1p/xrOQFPSj/vubZ79jGF1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807352; c=relaxed/simple;
	bh=15iHOdzdE/uiMY4qONXlu2UGvW+opu4q4RRwB8+ZbJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUlHXyRqG/SDI9nu3muMdcIZI4D1askM2R53hMDxrubQ8s4ysO8Aurm4WrN3exCMc5rAYnWy5WSmdAyNxdGwWeg1F9vu/JfifbLySgVU3L1mNktD8JymcBOINtvphOU0xzZwoIV1diAxb0xfm71+XBERbqOHu7T45NSZh2hN3pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=MPhnLUCF; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=zHyW2WAw; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKdbuC000606;
	Mon, 24 Mar 2025 02:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=rcrAeYyy8xJq6l8Ao09QzWeqQH0Jrd2TkQNAFpt+Qvc=; b=MPhnLUCFOefZ
	7X+5S5eX3wLufiv2xtHT9DhvyC/0V8HqbRveDXL+wRbjEsdmmF8iVxyMh60rKPYV
	OuSVusRkXWTtAAT4tEnT2rTbujoWkhSY75GgFSwIA/0fQAAh7AkIhXL0XFiT1dY0
	j5e/c6EyGlfsxTqkPgspZY6KGFS65UUd93AmqtyFC7Dxm8axIUqlpLn1A/KPXgvn
	0J9361yezAoMcXFpE1k9CcRuO9f1i8/mNtpP62RVq3aidzBCLqfZQlaMrNeMDk1V
	/xUHOSJCGQcJkviH0Ey3OLI73yr3l5npJPkXo9DtaTp336R7WLwq5ogZHQKUam7q
	VVGrnBEF3Q==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrw4wpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1vCft2vxpeDzdCip89Uo73W8ycPGiymxE60XRYP3uUGJFAW15hm7m16fnBmyDKaicO8kMwsgK6Fg9Nw2AMmqDxP8GRozI+QyfVmiUoO857r7rfcyRmbIeGtO5QrrhU5xsCmjKMfz7N75id5lcuzDx3mJjZ0uEvpOC7xvwM8KGtNba1DGuqXyVhn15dm4Wh7eL7BJMhrGmxFNKIytmAUM52S/3Mz0MrC6KqP7hIrOgKgsHIgZ73z5FN/1/hwiTvGDPIArhwZdu80J+gEmuHQw0w65KyjaPN0i3NJfu/5hWnBV36xM9soI8pLQzbXjsgGOHNFiC1mYv2ZGTicLrYhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcrAeYyy8xJq6l8Ao09QzWeqQH0Jrd2TkQNAFpt+Qvc=;
 b=fzcSS9kxpg6Ze7AYrcomo5g0FnJZoYBy6pNi7qBpnRX4BEOsI0UR+IX70zkHPRSvviLUQMnxKtozi/aFpxz3wBqwgjZg56CFPmTp8NfOTvUB9u5Sl7ODutnZttzNQMwzdN0uRMIQqu7Mq4nFSTpW36FabyCCZUD5GPjDt4X9rqHprUXHS/83L6g+DEnHUvjWfPzP4x/f1tq2GoUebAwvsDDVgcvL7nK1cHjLMvRS7CAv8aumNQp8/WmHFLctC0YM7dU99bKyd4qkIDj67UKu/Ud+SU6obarycBhiHsySH8aj3kCZFbdCDYawS3LwTDZWqe8VQyPbsKAnmXxIfaapDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcrAeYyy8xJq6l8Ao09QzWeqQH0Jrd2TkQNAFpt+Qvc=;
 b=zHyW2WAwUHt0Ny9SDeNQXO07e0jMc8o2cQEzfOXR8NisN322sq0zbfoWN2zdCdjGv29hm9mCPBfrlumxv/fiCJW8dpL3YWphGorm+cCQEWN9sj7IQ2/ZUF1qojlyozGIUjTlTacJUY63m22rtv1gTf0F4WJKVh6f1E2nycsIn9w=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:08:56 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:08:56 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 2/6] PCI: cadence: Add header support for PCIe next generation
 controllers
Thread-Topic: [PATCH 2/6] PCI: cadence: Add header support for PCIe next
 generation controllers
Thread-Index: AQHbnJYZBtqAG86gAEuwtxdGpa4BL7OB/Wfw
Date: Mon, 24 Mar 2025 09:08:56 +0000
Message-ID:
 <CH2PPF4D26F8E1CDE19710828C0186B13EEA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082353.2566115-1-mpillai@cadence.com>
In-Reply-To: <20250324082353.2566115-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05YWU1YzM5Ny0wODhmLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcOWFlNWMzOTktMDg4Zi0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIzNDk2MiIgdD0iMTMzODcy?=
 =?us-ascii?Q?ODA5MzMwNTc5OTkxIiBoPSJEV0xlRnA4VHJUV1pFTERlZzRpOWduUlBjVlU9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUFYbWp0ZG5KemJBZWlNekUwUDRqMnU2SXpNVFEvaVBhNEpBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQVJ3QUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFGMEFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQXdB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQUJIQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUYwQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUF3QUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH7PR07MB11228:EE_
x-ms-office365-filtering-correlation-id: dea71401-2b1a-4d70-83cc-08dd6ab381ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fiIurUZxGJAC/2gI5sv26GQ16B63T8/MqhPLjPcm+OtlrQ08K2hn/u3raBcL?=
 =?us-ascii?Q?m19SeoQPxa9fTKQuTbpMqSzNuhcRO+Nqc7+bsF+3tsAm+bNuNupMpOyqwtVF?=
 =?us-ascii?Q?LiBGmHrNGPlOCmsXczwbiDvT1ahG0d8GAmkuJds/vNE4OXOUPRATZYawALdd?=
 =?us-ascii?Q?5XiqxpGQiZfFk7bxSrAS8CgdP5T1uK/Juvl5JrqSsmFRzy7yesD33dHPgFIo?=
 =?us-ascii?Q?3hQs1PJrKDLD7oypg3e54ypMDEVvE0QnJFkflCS2Q7aWr2m9vY16UNTJzBOv?=
 =?us-ascii?Q?gvsOCTMnX1hJROVgpf0EdLeE25BYMwicv//0vDhxI2phFpBPzU+5NEktDstM?=
 =?us-ascii?Q?YNaVjBhgdCzaCMSDDlvFJR4N58omtw6rIhpm7k21ipE6i7ZE4juoOOVv3nkQ?=
 =?us-ascii?Q?kUdtsv2DhMpNmqmGjZG4aEznuJ/FpbnNCUpKOiSHJ/eeGAK/BKCG9dVbsuva?=
 =?us-ascii?Q?PL9fjLZXF/o/bP/gzZPlYdEyjggTXcyR+tqex/a/2tOxmHkvw0hpy0LWlmqV?=
 =?us-ascii?Q?byBqyRgj/zE+eyZR3Dp918QrcpOgpNC+ajW6EyN2aY3NgK3MVSqj/9Rvygdh?=
 =?us-ascii?Q?Ofc5KVQqGLF1apGBtigT6tNEG0BTzWWjkgHQaWoxXbl0+MujwWmm3bA2zXlk?=
 =?us-ascii?Q?SxnC5kziQhlsQlBFTS6dV27Ua/bm8D2g+4SSVwx6sp8sBDq58o6vKUfRJ0zY?=
 =?us-ascii?Q?LAyyc0uN3D45sHeRt4ZScdJ3iqNVon7GfKszpBcX2AacpUXQjsbhl02cTnPl?=
 =?us-ascii?Q?HU9926sXFEnvwROYL9xTVze9Fl0SdCS7aFoc0K/VZcBjGdhx7CmN9lY6lWLf?=
 =?us-ascii?Q?3D6nnffz2yMqFKeHCJDfY/jzZZTkXX0sAz13g5t4Cr8qR3B9SwE4wf/2QOoQ?=
 =?us-ascii?Q?0vYT8236U3Equ4UZhatT2IS610IyINQO4S26uERtLQtvpSFgYnQKG92BmNdV?=
 =?us-ascii?Q?GRD0meTzaH6cKrFU3BwQrQZJhEVaZSLEpokyTQQetjjPCNAgSKW8y8td/LI0?=
 =?us-ascii?Q?IaztUIHE1q0IaiEbdCWtxbi2+nVKkcNA9KXmcxQKrL/g9U/07Zv1aNaHn2yF?=
 =?us-ascii?Q?8m/l/pNgy6R44nMizc1uQtM0EP0ZPWzucqOIOem3yHNQsxbyEH5CJTZr/y5r?=
 =?us-ascii?Q?PGqdvRbDPHdeTUTkNWHy7c3q1kA6P1/s0h78NOq4ZqH+9OVcG9ZqcreEce7w?=
 =?us-ascii?Q?sEV5gneaK8JYQypg+cb8w7uTH8q2/k4BAePsFxa96GsGj4GjHkavjZelG1sG?=
 =?us-ascii?Q?UXHWZI8tsV45nUdPFGbUtaYWNAkW0g59Jlizy7Ek6ajhMLgndeY7tX47/FhD?=
 =?us-ascii?Q?PVd6Pb01ucG1N/pyqBqe0KZyEHN9DYBnxsNob/vzRIv0xnUQ1t3oiPW7L/78?=
 =?us-ascii?Q?0d4f4qPOl0C7jVzSreAubTZZWufxArYt19A+3VglSChYD1hIqHvb7+Jw4MjE?=
 =?us-ascii?Q?7bz23SWuVVL55zv+Xm7NdUri2Eq3w5aJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E+gkBw7RCPwd3hoYMe3Z4zm7kHhzx/3haGFmSRFlGWew2qBZezb0yyKRxAl9?=
 =?us-ascii?Q?wFqo4jhvmXt6YiJOK0tXTmGPDVwp1dh74xdVQKPkOZW5CXPuG+rnSWSp4VLd?=
 =?us-ascii?Q?e0Gv4gLa7BK/cS6QVZo2nip94NxbPI9u9h9qi07o39U8MR0NQQQISHVqzOMy?=
 =?us-ascii?Q?DzpBDqL+OFOoerj6MwKcEZTUh+fjPsNv2psAFW2/4s8pAi+OkCNl/oyKuzOO?=
 =?us-ascii?Q?nTOikYRbQspy1969TKI9s0pRr2qiu6Fl1qtBat8fhkUO0raT8W/OLfti3Njq?=
 =?us-ascii?Q?4a7a33cwGNuGTtVgXCYFi5ifpKeoKnWMrf9ZLNtGWi+uukLPKTHr7s71E4O1?=
 =?us-ascii?Q?/wjSerlnCfnh8pZPJdawf7bDTIMfcb66BJNJdihvHrf1YhgZtNmq5YaTjfZG?=
 =?us-ascii?Q?9pvZ8A4qIweQh3EysXbt2uxEeJnNT0pt+In+Isews7xS2rMtfzXkMf3fSXCW?=
 =?us-ascii?Q?JxaIBCBsPyXz91kaNVGiBTcqVfxtzjlIkcDcRuy5zfxwyrzKZkIsdiwEs+Lb?=
 =?us-ascii?Q?Z5ylMmV/O/hEOhJhNIJUdLvureuGzGscOT9bgwyKt4KZ5rf2RAGRVu7/XY1p?=
 =?us-ascii?Q?NuDdQNZWejUrtVB/gSfVYkI8VUBP42zMfYqP/xhuJdXfb8lljNgYPhabmC06?=
 =?us-ascii?Q?WP45oILOkpDB1pbwxgWmNIqeetxCK0Rfy1cD2PHJj+hRDq5SLv2rnm7U3pQZ?=
 =?us-ascii?Q?3FMLdSWqg2FZIIqPmIXBh/v4OvuA7eqf8FkwMAGoFj9tceWb3pO9hDamLHE6?=
 =?us-ascii?Q?tABOy/YKr9suNbcvklB61jCEGBj5mJKWVZuujtNJcqVZLaiHeKbYPlr/9lke?=
 =?us-ascii?Q?iZMkiPXw7hGlzeSN0VEoBgcNdWNZ5VCKeFY54HtH3gFFScBqf/Hm6/ruUF4C?=
 =?us-ascii?Q?XtIMRqb2TAJ7dgD08QCaQ1O6B7IULQGya0tSs6t1rSBlY+++Comcx0HkCOxc?=
 =?us-ascii?Q?JcIDeVDSD3/jW3U0TA8fS3GJgi3YRlgwactdzAMOE/Vqy+eW7pX9AOcNdCNR?=
 =?us-ascii?Q?dwGvk8ODJfePboOuSGsh+k407vqYjmN78JFgTD2epFgA0gJhubeiI6S84Lsl?=
 =?us-ascii?Q?fn12zxCMlNWXzIUMc19yZL2jnE82fxEC1VmWxrCBv7t2erCA3dhbZjzqdduh?=
 =?us-ascii?Q?mNXGEN83w4JL6rx4KH4NoYTSWb2jwZ/52DECYopQSbkIRj03Bvsk4rihiuhg?=
 =?us-ascii?Q?rU0EMLWgT82wq8vd28Afyq7gF4hgUYpGOqRrsSuxNGxY8AuHrmSXT31CIa45?=
 =?us-ascii?Q?Le6NSZXi29DZtR86RSk758Xvr3Dy2ekCttxg7ddipqGBfR9WyTtU7I524IfW?=
 =?us-ascii?Q?Ph8wtaKg2NOONrgKCR3M2KFxfeSpIC7WdNzBAZnzO/vFBz1q+emItxL8vKHA?=
 =?us-ascii?Q?gj8AqnnBvtQ665EmH3BwXn7sjaxwVMJ6AZiCC1mth06bnh4oQExM3l1+qBF7?=
 =?us-ascii?Q?2LlyJ8wB7d9BMItbjmtry2LiPRSc5AfD1jQiYM/ZV1ferDDLToLxxmzMkJJE?=
 =?us-ascii?Q?t6SHPqsF3Xh2yaHsw0fmnMhN3oILqRxnCkfNBobHl/Su/09+wGPIJpmFQgVZ?=
 =?us-ascii?Q?jTc6FDrvf2YQK4HhSVjCfYpZC37iskCdcWbzhmeS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dea71401-2b1a-4d70-83cc-08dd6ab381ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:08:56.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYB760ow6kiL6JuovXTgcL6Hf6azxRTOEbx2h1tJPtRSI5yrd8SccaBUPQtIRoiPFzkZQvBMYeIpWckspVUNs7oayO7xbKk+1Tm7oxoiQCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e1212a cx=c_pps a=MTHhyWX0+jVkNfluivEPDw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=zWsyvq7YNSaA_77DEgIA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: 72A254FX06N02K59eOI-nv1yXDH8skKo
X-Proofpoint-ORIG-GUID: 72A254FX06N02K59eOI-nv1yXDH8skKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Add the required definitions for register addresses and register bits
for the next generation Cadence PCIe controllers - High
performance architecture(HPA) controllers

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../controller/cadence/pcie-cadence-host.c    |  12 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 290 +++++++++++++++++-
 2 files changed, 295 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/p=
ci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..1e2df49e40c6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -175,7 +175,7 @@ static int cdns_pcie_host_start_link(struct cdns_pcie_r=
c *rc)
 	return ret;
 }
=20
-static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	u32 value, ctrl;
@@ -215,10 +215,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_=
pcie_rc *rc)
 	return 0;
 }
=20
-static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
-					enum cdns_pcie_rp_bar bar,
-					u64 cpu_addr, u64 size,
-					unsigned long flags)
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags)
 {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	u32 addr0, addr1, aperture, value;
@@ -428,7 +428,7 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pc=
ie_rc *rc)
 	return 0;
 }
=20
-static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc=
)
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/co=
ntroller/cadence/pcie-cadence.h
index f5eeff834ec1..2a806e5a3685 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -218,6 +218,218 @@
 	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
 	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
=20
+/*
+ * High Performance Architecture(HPA) PCIe controller register
+ */
+#define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
+#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
+#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x01020000
+/*
+ * Address Translation Registers(HPA)
+ */
+#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
+/*
+ * Root port register base address
+ */
+#define CDNS_PCIE_HPA_RP_BASE			0x0
+
+#define CDNS_PCIE_HPA_LM_ID			(CDNS_PCIE_HPA_IP_REG_BANK + 0x1420)
+
+/*
+ * Endpoint Function BARs(HPA) Configuration Registers
+ */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x0C)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(9, 4) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTU=
RE_MASK(b)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)=
))
+
+/*
+ * Endpoint Function Configuration Register
+ */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		(CDNS_PCIE_HPA_IP_REG_BANK + 0x02c0)
+
+/*
+ * Root Complex BAR Configuration Register
+ */
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + =
0x14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Comple=
x */
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS   0x9
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS   0xD
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
+		(((aperture) - 7) << ((bar) * 10))
+
+#define CDNS_PCIE_HPA_LM_PTM_CTRL		(CDNS_PCIE_HPA_IP_REG_BANK + 0x0520)
+#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Root Port Registers PCI config space(HPA) for root port function
+ */
+#define CDNS_PCIE_HPA_RP_CAP_OFFSET	0xC0
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1010 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1014 + ((r) & 0x1F) * 0x0080)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1008 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x100C + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1018 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/*
+ * Region r AXI Region Base Address Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1000 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
+
+/*
+ * Region r AXI Region Base Address Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1004 + ((r) & 0x1F) * 0x0080)
+
+/*
+ * Root Port BAR Inbound PCIe to AXI Address Translation Register
+ */
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar) \
+	(CDNS_PCIE_HPA_AXI_MASTER + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar) \
+	(CDNS_PCIE_HPA_AXI_MASTER + 0x04 + ((bar) * 0x0008))
+
+/*
+ * AXI link down register
+ */
+#define CDNS_PCIE_HPA_AT_LINKDOWN (CDNS_PCIE_HPA_AXI_SLAVE + 0x04)
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0     (CDNS_PCIE_HPA_IP_REG_BANK + 0x04=
00)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
+
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0   (CDNS_PCIE_HPA_IP_REG_BANK + 0x04=
20)
+
+#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
+#define CDNS_PCIE_HPA_MAX_OB        15
+
+/*
+ * Endpoint Function BAR Inbound PCIe to AXI Address Translation Register(=
HPA)
+ */
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + ((fn) * 0x0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + 0x4 + ((fn) * 0x0040) + ((bar) * 0x=
0008))
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED =3D -1,
 	RP_BAR0,
@@ -249,6 +461,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
=20
 struct cdns_pcie;
+struct cdns_pcie_rc;
=20
 enum cdns_pcie_msg_code {
 	MSG_CODE_ASSERT_INTA	=3D 0x20,
@@ -286,6 +499,20 @@ struct cdns_pcie_ops {
 	void	(*stop_link)(struct cdns_pcie *pcie);
 	bool	(*link_up)(struct cdns_pcie *pcie);
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
+	int	(*pcie_host_init_root_port)(struct cdns_pcie_rc *rc);
+	int	(*pcie_host_bar_ib_config)(struct cdns_pcie_rc *rc,
+					   enum cdns_pcie_rp_bar bar,
+					   u64 cpu_addr, u64 size,
+					   unsigned long flags);
+	int	(*pcie_host_init_address_translation)(struct cdns_pcie_rc *rc);
+	void	(*pcie_detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
+	void	(*pcie_set_outbound_region)(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+					    u32 r, bool is_io, u64 cpu_addr,
+					    u64 pci_addr, size_t size);
+	void	(*pcie_set_outbound_region_for_normal_msg)(struct cdns_pcie *pcie,
+							   u8 busnr, u8 fn, u32 r,
+							   u64 cpu_addr);
+	void	(*pcie_reset_outbound_region)(struct cdns_pcie *pcie, u32 r);
 };
=20
 /**
@@ -305,6 +532,7 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	struct device		*dev;
 	bool			is_rc;
+	bool			is_hpa;
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
@@ -444,6 +672,8 @@ static inline void cdns_pcie_rp_writeb(struct cdns_pcie=
 *pcie,
 {
 	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
=20
+	if (pcie->is_hpa)
+		addr =3D pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
 	cdns_pcie_write_sz(addr, 0x1, value);
 }
=20
@@ -452,6 +682,8 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie=
 *pcie,
 {
 	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
=20
+	if (pcie->is_hpa)
+		addr =3D pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
=20
@@ -459,6 +691,8 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *=
pcie, u32 reg)
 {
 	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
=20
+	if (pcie->is_hpa)
+		addr =3D pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
 	return cdns_pcie_read_sz(addr, 0x2);
 }
=20
@@ -525,6 +759,22 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags);
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn=
, int where);
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags);
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
+
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -546,6 +796,34 @@ static inline void __iomem *cdns_pci_map_bus(struct pc=
i_bus *bus, unsigned int d
 {
 	return NULL;
 }
+
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn=
, int where)
+{
+	return NULL;
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags)
+{
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
 #endif
=20
 #ifdef CONFIG_PCIE_CADENCE_EP
@@ -556,7 +834,10 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_=
ep *ep)
 	return 0;
 }
 #endif
-
+bool cdns_pcie_linkup(struct cdns_pcie *pcie);
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
+int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
=20
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn=
,
@@ -571,6 +852,13 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie =
*pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+				       u32 r, bool is_io, u64 cpu_addr, u64 pci_addr, size_t size);
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pc=
ie,
+						      u8 busnr, u8 fn, u32 r, u64 cpu_addr);
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
=20
 #endif /* _PCIE_CADENCE_H */
--=20
2.27.0


