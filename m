Return-Path: <linux-pci+bounces-24833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132EAA72EB4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C58189B4E9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C2211A20;
	Thu, 27 Mar 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c2EUPjWn";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pQUHg9Ty"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E602116FD;
	Thu, 27 Mar 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074404; cv=fail; b=MZiOECsWkoHB3onB1TxUo34lIc9eBAVbUHPA+KMmlHpu9pTVmbhbE8nvpq48Hh5jdIRszeWgvAYRiF2udJK2iEbuZOmD6kpmPQ0nxQ9I0kg5NkQGc9E24o8gTxWuA7+ThUrvh46569BquJvi8dJoMRnwRxtXuamFwzu2IsCMHaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074404; c=relaxed/simple;
	bh=9aQfENATrEJvGtqsUln+UoyTYhWSpdgTC9gNubWKUzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jpORB/vb0jNzu0FhhGrLAnpcIhhuDdtnDxQkCiXCTtnZ3GYiJaqULKMticXxRifa/OI2nj1Q3dhJI1zTEjCQrSpdzRoVsusTfkiT9naL2BVjgOOOr7NG3qvaMjoY+RUgRek0Og0A59Sm0C/JS4SFhOqePYISjIy0SzCjwdHd+uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=c2EUPjWn; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=pQUHg9Ty; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7q1Me021632;
	Thu, 27 Mar 2025 04:19:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=byzR6QC5COogM4L8hM56N/CqlEcVJLaGQamliT73lhY=; b=c2EUPjWnFGFR
	pOxYf/GoPg3xAMryQNCPwQxjqEV0yhcoxLqrquo4cDheT8YTkJ8ysX8SNWarS2Uj
	+HKb2Q8wL/3TejzbxXhom7T4KOttqim9oMuwom1nt/FTWq9s5yyraJIPZAmZa/WZ
	q5W0BqJzxnowyrInzUutyk+vt1bfKonmlgEK8sIUTn4WwfYi2433PQErmdnxfGV1
	b638w767wl66nkGoeSBawX+dSJWOAbusXpdheuYH9bLotUvxiOwksz/UliIeOQCp
	VNIjw45YBY+jERt7TYCd6UUQ2bagGUTvDzjiavs5+LNwcEtCuOkr3UAStOKOEyU5
	mKxeU9l+Lw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012036.outbound.protection.outlook.com [40.93.6.36])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrsx504r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q26Ej4Nmi4QpApiu67j/yEEGR9WzDosSZNALGIEtQMMFpBba3FrSY7tsNV2vQBsmBKdhwqjUwP2nXzxNPrwhpJqKDtPeqr3AGlMpP0hS3W7j7Sr9EHs0yeS7kqKKoEvFhObLgaN4GOW5EQxz1Z0who9X4BC1MSy42bFH3AWooXMwFtnQXNsAHTOpQfN4M9jDk5D4VUM0SQIHxJLI3FXmc0AMCByRF6yHexaHBWPNNjrWGtYHKUIp6ViyMGEYuByhMIksATSYWg6NIYIeACVLLPK/JsdH/zF4mA4ODWWEXfLqAU+c41O9mUtGF8lMiZc2JjGgtQ14ERX5IZqcl+M4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byzR6QC5COogM4L8hM56N/CqlEcVJLaGQamliT73lhY=;
 b=McwB4U0lTTzb0t/i+yvUQEt1rJls4cpMVsr1qd4g8hxa6JjaEL+SV9e4ABin1ah0HbWfHLeWg/QlEycABqefpB0Vcy2VxFH0Tz05XjdLPTTl5FL1Ul+WGTaKHCz1xm89dm9SaSXou0nQuuG7cddo3cuVk2010yf6IdDO+A54leV6GrFX5Qm+qBLXF6NrSt5cxf/Gz7/LYtxnn23KulIa4XcHbUJT84OX9HcK608p48PnrQMpnoibeUbwMYIRx21hV+aPIausEFGzGbiTcYvA8nbeO5473vObZfB21CQo4Ps8YKgFtkJVGoSG7jLMqvf731032VBNUE2shKzXWw9/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byzR6QC5COogM4L8hM56N/CqlEcVJLaGQamliT73lhY=;
 b=pQUHg9TyOauLF7ak4TI2wqISlV//bFLqrME83F5LX240lhRJomKwyM3uG6OS1xG0HSjfGCm2SZfNuytk6yIq8RYnUs53WZt4MtITG6cldMymmwd8VEbDkALoNI0VLDWXIix7K+AT0V2awhlgjU/0pSXCn0BECUwUMyqZ3QP46Bk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA0PR07MB7804.namprd07.prod.outlook.com
 (2603:10b6:806:c3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:19:47 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:19:47 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
Thread-Topic: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
Thread-Index: AQHbnwj4B1ktiGdr2kiF1UawAazGKLOG1SfA
Date: Thu, 27 Mar 2025 11:19:47 +0000
Message-ID:
 <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111106.2947888-1-mpillai@cadence.com>
In-Reply-To: <20250327111106.2947888-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02MjRlZDhlOS0wYWZkLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcNjI0ZWQ4ZWItMGFmZC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIxMzI2NCIgdD0iMTMzODc1?=
 =?us-ascii?Q?NDc5ODUwODIzNTI5IiBoPSJZUTlJQ2lUQnE0YkVaZTRUWVpxRXBhOEkvMzg9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUJwcjZRa0NwL2JBVTFYbDJUVjNvK2FUVmVYWk5YZWo1b0pBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUlRQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQUFoQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA0PR07MB7804:EE_
x-ms-office365-filtering-correlation-id: 8a9b1d40-7ede-43b8-5c4c-08dd6d21485e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?a4sAoffGs85IOKoSv+0tuZCYyyuXU5ixyOuOf23QYGit0rcrmL8xnP7MNwxe?=
 =?us-ascii?Q?WHWvHtAEiWlZmscfwSGA7SmRwAGQBOK1D/QztMwAGUtDhGDXqUFHK5dHk4m1?=
 =?us-ascii?Q?hyIgfZEmr2IelDpAeozZegaArawzhB++qr94La88lUu60E8uHlG+h3DZxPbs?=
 =?us-ascii?Q?wSj2X8WGm5tcCILYfnL0WD+cvj7v7pLAMuc7vZDVpnl4qoCMR/ygHq6UCT3t?=
 =?us-ascii?Q?swFH7twO3RcEX/Ck4td3ooAWMiGiB9GIhge1YXY3O6IlTMWCoyKrNMndgTjY?=
 =?us-ascii?Q?gQ85WPUB73Qnz1jdO197Ytk8+tLY7ym/Tb54Nz7Vvb7MrnpcrOF4OyazIwyZ?=
 =?us-ascii?Q?sJczjDwYf8HJifFWT4EUIT16Viqg/Grs2rREnadaSkWjtR0RxQ1jqK+jKXD3?=
 =?us-ascii?Q?eXMD7a0z0u2TLFnJfTSlQ2dyq/YjYMn4hz95u4TPvuoAcIZGK6xuv+FaPEi2?=
 =?us-ascii?Q?YWBqE+KZNWQMC/gCsnLjkVqCEwqXXH9v5qDIiTPtn4tWYSuL42qOigAfYlUd?=
 =?us-ascii?Q?TbSN+S1bmSlgk+r/yt/WlDt46GxeihWniiWjWI9xCyZbR+XvyyrOSm5LEBl8?=
 =?us-ascii?Q?YZsppWQfzego8rlvw++1hMVfrCH6X59i5a5H6AgkhbIvbOnm4Vp4oUJQv+hX?=
 =?us-ascii?Q?Nn+CVMEnZSnUZnQo7mCl9sBnMrjh11hjhvQQITZnEKZoAoySvWxGC6OuCCbu?=
 =?us-ascii?Q?7JRAX6OtMFGd/k4xlzPjPbjR0OomwZ/8tt0U/eZXR4JF7jw+6keaNjBgMq4Q?=
 =?us-ascii?Q?pd1VERd3rrSb7tOvIXc5iXSEKnbn7p0mT9GdQEcKnAvyRZyVVgLq1uMSGu0H?=
 =?us-ascii?Q?hv/Qn4RgC3LYBD+x2st+spfTlSdFQyQrrhhBs2JErOX6AyJOHorFoa7fcFxo?=
 =?us-ascii?Q?eEv4DKNGI1SR18+o9pql9/4yKCrxroOJuXND0aK9wjVC+lb39krjBVNA9h3S?=
 =?us-ascii?Q?zRzSLnyrlZLjoqGuIVzm5LsBmbMr7qmPMsBeyotm1gv7Gc/hLnrq8g3pcivL?=
 =?us-ascii?Q?CKO8ne9T18uxJiHUe2ed57pCKUYqUanRrxQ50GNMTzz1PnC2ftuU2C039uyK?=
 =?us-ascii?Q?U3m14Q9Yt6GVhRUdAk7lrrhaFnq2pmaioNX9Cl8roOGjQfptphpuv3T/xeru?=
 =?us-ascii?Q?Mel3NJSBtEU7PUfkYypntlS7b0jFQA7+mXnvP0PNaV5ou9ejKiXpLj58P9db?=
 =?us-ascii?Q?kH4b9mp/LK1zYAwKuLbEjeWTlhz2yMNPtLTIGIQnnEzOem08vmcn2lTiJLUZ?=
 =?us-ascii?Q?ZdD3l8GF1tztBpUO3YQH4PJpTGjI+shSkn/69vXO1jMtTHNVRFlaSQCByuX4?=
 =?us-ascii?Q?YbMDSGf94s6cB+jZ/IfwDbJPB9eOWFFr7lZD3U7UMxKzkoApMGTy8yJdOwOH?=
 =?us-ascii?Q?Ujk1AgAgizgfYksXI/RjPwKjKXpA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QU3uyCtKhgz9BVY/Y/up1iPgxJZAzAt8YISZr8MbuLAICU3NvYZH6MGbgNZ0?=
 =?us-ascii?Q?CemYUhjaeQ4w76H9Ys9Wda15CKIv1GIFe89jaUy1lUUs6qN+cj4TzqF7BdUV?=
 =?us-ascii?Q?PtWp40oiF2an23MH41M6gjuVaLLbJ+v14KN3fjVCk5U7h8k1VctXmzlqXzqI?=
 =?us-ascii?Q?sMH8WhlLoqAAI61DZp49L+pvjOE6Z0sG9JCQhgjbFW5gQaA6C2eTAH6nBGRk?=
 =?us-ascii?Q?Tqtrq202kVoADMc6OU9o+djT27sIihTJ+cSSWYXtqTY4tJ91mLX1C100l0U3?=
 =?us-ascii?Q?haB39BsJkPjpet76C9STPGNr63fl/1FG/Z+6Y89FMleqMYb3NYo5Yhh1ylBn?=
 =?us-ascii?Q?mhtUIi3/AMtw2NY5dJ8qONtXd9sScEuLO4apqRQzh6OdP3ksbe5JCyfnM0MI?=
 =?us-ascii?Q?F7pWCPwvi/VuY/4z1girN5JC0jYk5ft7cONI/ii3bo+/Vx4UBGE7rN6F/Ghp?=
 =?us-ascii?Q?KhcdFX+gDVCkBkqkvSeVq4DuTNpzMHcJbLz8TbcOeQm13jsR6Rfaw3kCHBiy?=
 =?us-ascii?Q?EGwtLnB2dKGmqwTfpGeqto7KhVsT0YRAfxLYO7uufNT8m+IpM0P+XMJbdyU1?=
 =?us-ascii?Q?tBtaJkxTpGbTMZX2d69e7LcWTWV0jo2vFFprNlWdaV7TxsxqwbSf93Nm9OCW?=
 =?us-ascii?Q?8ZGbgtpIH9Rmzy5ceH1if1t7XbFZOHYrV/YsgQsfHyEoLc4d1Tsb/nACANa0?=
 =?us-ascii?Q?qg2dDbIbkC/M16kBbOPUvZ4ZqL4jowbxP0ZMIJatUbACZ31frsXyQ5B4IfVY?=
 =?us-ascii?Q?t00ZWAOYKsRpfxL8zHch6VIluoyqyYz9rCNT9CLnnxhwzPZxpx52oYLfGfvT?=
 =?us-ascii?Q?Y6meWsugCyqoFl2kyZrfMLfQxmaUaOwdLSCITKfgsvM4pBrKPCHzhtAovMqr?=
 =?us-ascii?Q?e7RRGexa4LkMoDBYnNd51dx7dkN5Wj9Pf7sG4Ohl2FPFuUjfMbN82FKDxz09?=
 =?us-ascii?Q?Ss7zsLosuFMfNMMjsfpogVrsHXMw98y6zJ9kraOR7O1MlnKcim6qFu6kE+A8?=
 =?us-ascii?Q?I4A/M6g+p6KHhPkaw4zqU4JGrLO8ZiFwK4SZgYf0bOmB1b0fFJmtAjMOiccL?=
 =?us-ascii?Q?TOqbKMSKp8zo3Fg1MFg7RGFHkjh8Xs9g7raRVLcWpDzFrQcZujiDxYGLRPwC?=
 =?us-ascii?Q?P4YI5nFaT+WS7pyZGzrM8z1F+2/GArqPd/A2B80FvijOQDqf5RhKwM29XElu?=
 =?us-ascii?Q?CGo4wDwCxyifJJXJWIcJ9VzIgwWo7JAnErxbtAA2v3i57jnX7NsY3jH3FdPk?=
 =?us-ascii?Q?l+HRXoRpZByrAeajykTisI3KeCKAJ9xa9o0/WRZBsB2b3osOPTDaZlE3nptd?=
 =?us-ascii?Q?4NAp1KxBSK1G6F1z4rnaLdM6GV7jcKCldasBNTC7S+yUTLzAIhdfMjThaQQF?=
 =?us-ascii?Q?ginNY3UPhKQ5uHWWt6ZiK4EjiJtZHxKocYQ2uVlewwYqG7LzKXdZSMZhj0BW?=
 =?us-ascii?Q?9A2kQvzKDooAiSPUA3bf4bpHctd1eITralnYt6QUs52M/BIWM1uDPNTlQ6iX?=
 =?us-ascii?Q?YxNAhkj3ySXjA+041obHPaAejd0fLM5wE1u+qonG6CpTBzWHUHB29FICQZbC?=
 =?us-ascii?Q?8VPepuWfqiAB9flXlscfSipnb8qchDxwM7g5UGPD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9b1d40-7ede-43b8-5c4c-08dd6d21485e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:19:47.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVNEMgrckFJlr9AMR+iTOp2+FNMx9HM/KWgGjDUIxn+wLSr3OF+FzR0368kzAq2YpF5ZuNGbb1OYdozPlsed2n8oanWSSE0SIXSsnXcyRaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7804
X-Proofpoint-GUID: gJZhE-ZrT8TZSYCgbg65SjEb3h9Md0JF
X-Proofpoint-ORIG-GUID: gJZhE-ZrT8TZSYCgbg65SjEb3h9Md0JF
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e53457 cx=c_pps a=dbnGGe82Z6Ok/5ez5STjcQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=gEfo2CItAAAA:8 a=Br2UW1UjAAAA:8 a=oiguXBUs3hy4C_FcSyIA:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270078

Document the compatible property for the newly added values for PCIe EP and
RP configurations. Fix the compilation issues that came up for the existing
Cadence bindings

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++++++++++++---
 2 files changed, 110 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b=
/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 98651ab22103..aa4ad69a9b71 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -7,14 +7,22 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence PCIe EP Controller
=20
 maintainers:
-  - Tom Joseph <tjoseph@cadence.com>
+  - Manikandan K Pillai <mpillai@cadence.com>
=20
 allOf:
   - $ref: cdns-pcie-ep.yaml#
=20
 properties:
   compatible:
-    const: cdns,cdns-pcie-ep
+    oneOf:
+      - const: cdns,cdns-pcie-ep
+      - const: cdns,cdns-pcie-hpa-ep
+      - const: cdns,cdns-cix-pcie-hpa-ep
+      - description: PCIe EP controller from cadence
+        items:
+          - const: cdns,cdns-pcie-ep
+          - const: cdns,cdns-pcie-hpa-ep
+          - const: cdns,cdns-cix-pcie-hpa-ep
=20
   reg:
     maxItems: 2
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml=
 b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index a8190d9b100f..bb7ffb9ddaf9 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -7,16 +7,30 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence PCIe host controller
=20
 maintainers:
-  - Tom Joseph <tjoseph@cadence.com>
+  - Manikandan K Pillai <mpillai@cadence.com>
=20
 allOf:
-  - $ref: cdns-pcie-host.yaml#
+  - $ref: cdns-pcie.yaml#
=20
 properties:
+  "#size-cells":
+    const: 2
+  "#address-cells":
+    const: 3
+
   compatible:
-    const: cdns,cdns-pcie-host
+    oneOf:
+      - const: cdns,cdns-pcie-host
+      - const: cdns,cdns-pcie-hpa-host
+      - const: cdns,cdns-cix-pcie-hpa-host
+      - description: PCIe RP controller from cadence
+        items:
+          - const: cdns,cdns-pcie-host
+          - const: cdns,cdns-pcie-hpa-host
+          - const: cdns,cdns-cix-pcie-hpa-host
=20
   reg:
+    minItems: 1
     maxItems: 2
=20
   reg-names:
@@ -24,6 +38,74 @@ properties:
       - const: reg
       - const: cfg
=20
+  device_type:
+    const: pci
+
+  vendor-id:
+    const: 0x17cd
+
+  device-id:
+    enum:
+      - 0x0200
+
+  "#interrupt-cells": true
+
+  interrupt-map:
+    minItems: 1
+    maxItems: 8
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: msi1
+      - const: msi0
+
+  linux,pci-domain:
+    description:
+      If present this property assigns a fixed PCI domain number to a PCI
+      Endpoint Controller, otherwise an unstable (across boots) unique num=
ber
+      will be assigned. It is required to either not set this property at =
all
+      or set it for all PCI endpoint controllers in the system, otherwise
+      potentially conflicting domain numbers may be assigned to endpoint
+      controllers. The domain number for each endpoint controller in the s=
ystem
+      must be unique.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ranges:
+    minItems: 1
+    maxItems: 8
+
+  bus-range:
+    description: |
+      The PCI bus number range; as this is a single bus, the range
+      should be specified as the same value twice.
+
+  dma-ranges:
+    description: |
+      A single range for the inbound memory region. If not supplied,
+      defaults to 1GiB at 0x40000000. Note there are hardware restrictions=
 on
+      the allowed combinations of address and size.
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie-phy
+
+  msi-parent: true
+
 required:
   - reg
   - reg-names
@@ -33,37 +115,36 @@ unevaluatedProperties: false
 examples:
   - |
     bus {
-        #address-cells =3D <2>;
-        #size-cells =3D <2>;
+    #address-cells =3D <2>;
+    #size-cells =3D <2>;
=20
         pcie@fb000000 {
             compatible =3D "cdns,cdns-pcie-host";
-            device_type =3D "pci";
             #address-cells =3D <3>;
             #size-cells =3D <2>;
+            device_type =3D "pci";
             bus-range =3D <0x0 0xff>;
             linux,pci-domain =3D <0>;
             vendor-id =3D <0x17cd>;
             device-id =3D <0x0200>;
=20
-            reg =3D <0x0 0xfb000000  0x0 0x01000000>,
-                  <0x0 0x41000000  0x0 0x00001000>;
+            reg =3D <0xfb000000  0x01000000>,<0x41000000  0x00001000>;
             reg-names =3D "reg", "cfg";
=20
-            ranges =3D <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1=
000000>,
-                     <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x001=
0000>;
-            dma-ranges =3D <0x02000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
-
-            #interrupt-cells =3D <0x1>;
+            ranges =3D <0x02000000 0x0 0x42000000 0x42000000 0x0 0x1000000=
 0x0>;
=20
-            interrupt-map =3D <0x0 0x0 0x0  0x1  &gic  0x0 0x0 0x0 14 0x1>=
,
-                 <0x0 0x0 0x0  0x2  &gic  0x0 0x0 0x0 15 0x1>,
-                 <0x0 0x0 0x0  0x3  &gic  0x0 0x0 0x0 16 0x1>,
-                 <0x0 0x0 0x0  0x4  &gic  0x0 0x0 0x0 17 0x1>;
+            dma-ranges =3D <0x02000000 0x0 0x0 0x0 0x1 0x00000000 0x0>;
=20
-            interrupt-map-mask =3D <0x0 0x0 0x0  0x7>;
+            #interrupt-cells =3D <1>;
=20
-            msi-parent =3D <&its_pci>;
+            interrupt-parent =3D <&gic>;
+            interrupts =3D <0 118 4>, <0 116 1>;
+            interrupt-names =3D "msi1", "msi0";
+            interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
+            interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
+                            <0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
+                            <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
+                            <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
=20
             phys =3D <&pcie_phy0>;
             phy-names =3D "pcie-phy";
--=20
2.27.0


