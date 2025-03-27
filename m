Return-Path: <linux-pci+bounces-24840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F1AA7307F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689043AB91E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331B213259;
	Thu, 27 Mar 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qXbxcGb8";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UCVof1GJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A71213240;
	Thu, 27 Mar 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075761; cv=fail; b=VBPs0W4il9R7Pagfc5P3AsNF9UF5ILRb4llJoiT7Lc1PhSQY7yM2HVYEOjy80/pprQ3KRiZ5+JuCPKaIt/d0jxNxZ3ie3hWr3eHLEFo+beOCDaq0gOPE7H82ZCrZqixdUHMbOa7c2RQoEYSaO4dJd1eCr3S9x0eDm8F48I8tMH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075761; c=relaxed/simple;
	bh=HPtHjpvySkF6EiM7UDEkJWe+KOBHbxKmQITWO8PRKBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eYgyrq+VkDrP4LWpEYiRSjqSmmUbrjam5x21TQSKntOVtZxLrAFmz4II3ZkiEehy+xXvDVuHP3Y4/W4THNSSha77/1JjJHWsQLGGI1XL0J5SlNwWxMpVjYG+B6WiaSN9rNvYD+Rit4kNWRh1EBNJUjqDv/QqpIzR9goHwb4i4io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=qXbxcGb8; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=UCVof1GJ; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7oZZF022474;
	Thu, 27 Mar 2025 04:42:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=NDd4hbL7i8HntVWlm44yY2uGPe5nyI6UcNVwByAhCt8=; b=qXbxcGb8h7Um
	ESkQ6mhb6U7Bg2ra18+OECxE0GfnvPdOvbLHYjCYm1TL/7pm6MYViHo0fugO6Xg7
	mp0z722sdBS4mdx7mqmNSPeroTZAo1q1/gRmD60lYZpifKK6hEOO7507JsR/ziRN
	RvfYpnDhfEGj4gI6vJW5VwnbBYuYxj9des5cgr+wGFrdlzlByC9tDh52oHxWdeLe
	+rCL3dSQ3RTZ4DMWXGoVVr9NdCfscZcGwN+EQHzWIAjgVG+Yw2y4O1ZAGffxdwaQ
	F+JxGWEOBeJ1GI20RkNx+LURvOdpynfB/HpLlNIH55EeR8P2cu8JBE4dbXYR7r6V
	QnRo1HOsdw==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrsx52d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc2sqR9PXdk5ggdo89eDUXzyJ/4E5npeyIepSJxGK/Pv4rUDKmsZw/e1qp3Mbm/m2cHb0UFgdq8v0EKr7KwtzZl34pogwiI9Ctw0QGn83ulYdnPXgtCNWftbuIBcT0KXU2fceXOzbuYtfgeyTC9Vb1wmXKl29otsPTjB1on3ETUwUVADXrdZbIeGSx5Rr3VvJJMYZVXX1KTaPWbC/q1Trq+T3CWwK13XRem4SNTwYyTtf+TnKBdaxOITuaV97L0m/4AuxvpkKBDb9nL3RMYT43OLpF2UDI1SoFbGlm/Gz7wMqYoguqj8J4Yru/3nbg5Lpk2Mb+XVhHuSfggnLmUenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDd4hbL7i8HntVWlm44yY2uGPe5nyI6UcNVwByAhCt8=;
 b=nkbTXd5nXH6Fj/8QGrcK3e3ImLtRr2sZavLXtGgEqQEWnlr5fc2t4e1yDLCRQHkPYz+byrRiirb8Z2ThVtsOKhzHRjwyAJH2Is+T51okLSBL2OmKARH9THF1LaLbyB5iECGP8FYs1syWP3pjGVBh0N6xTRVPjXYfH1DlIx8dAAvhcxDLK0H41HiN0otA4GrpgK1jNcbivPazjvQusno9oXLC39UvZd34OvJeAdkymTheLODbSD5muzkB8+hDWZcOAE2h7B8Ok0jwLOKu2b8xgICNTK1H9oZlNCg8AGYcSKGi5VxPu2sSzzWCsNZSZ3/LmIQLaBXpIjgsm7cKmGTBZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDd4hbL7i8HntVWlm44yY2uGPe5nyI6UcNVwByAhCt8=;
 b=UCVof1GJgbnbmNppG+twHw1EeYFof69ESq0LXIq/5bDDvwSAxoDXrgKri0XRXW6pLjhi5H+HZhu/jjsZ3JZ/HAmK0ZhDZKXt5qUedZCmzPp/3eSiTBE8rHv+w1ubZKsWmJ50nQcLb0FydWee1gpmvu7jBD/Val0DTtAwC10+zj0=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by MN2PR07MB7294.namprd07.prod.outlook.com
 (2603:10b6:208:1db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:42:27 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:42:27 +0000
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
Subject: [PATCH 6/7] PCI: cadence: Add callback functions for Root Port and EP
 controller
Thread-Topic: [PATCH 6/7] PCI: cadence: Add callback functions for Root Port
 and EP controller
Thread-Index: AQHbnwk5HS8Gr8jva0mrXd6LPp1H17OG3FPA
Date: Thu, 27 Mar 2025 11:42:27 +0000
Message-ID:
 <CH2PPF4D26F8E1CD797FF6A6A2698036717A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111241.2948184-1-mpillai@cadence.com>
In-Reply-To: <20250327111241.2948184-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04YzJhMWY3ZC0wYjAwLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcOGMyYTFmN2YtMGIwMC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI1MDAzNiIgdD0iMTMzODc1?=
 =?us-ascii?Q?NDkzNDM3OTYxNzI1IiBoPSJHclVNeWlrWmU2Q2ZCRW12c244b0pQb3BYUWM9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUQ5OVg5T0RaL2JBUkNrbmY3dVpQaHZFS1NkL3U1aytHOEpBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQTF3QUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQURYQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|MN2PR07MB7294:EE_
x-ms-office365-filtering-correlation-id: 49b6f5a3-c264-4d7b-b81a-08dd6d247356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TOAQs5sIvCZfgc7hI4K2lD2hc6cAnqAl0zBFlXzOx0dbtC3or+CXeNFvNOKg?=
 =?us-ascii?Q?fPggC3Nk2RYpROikRuhyKmujaIHU8MsZFTcnitUkg9sWIBlfGW+KnPEt37Nh?=
 =?us-ascii?Q?JxUcHYlgYGvlI4TunAd0DZ9EcFRX6DsmsmgrsMy2ulXzV0IF+4lRSEokWshF?=
 =?us-ascii?Q?vS0IDb6xvH3Wg6s9fIjPFMkH4+vmZVqURMstL4+6ke6jt8b0KlWYLicujMKm?=
 =?us-ascii?Q?GY39j+yyTERPmKsCkhtlBshnNtLDjxJAjrqawmf6Yn40aJN14TAzKYQpQQUZ?=
 =?us-ascii?Q?csbhON2da+X3pG60699PLa8t3Trnwr8PYdQFqEnWNaRDRjr7bL+sZZ01Xhsj?=
 =?us-ascii?Q?drbwfLXaeGxXOMhP1hHkO/hM7JMq5xy+HJcj5fxcpbV1YINq7t5qcwSwQPaH?=
 =?us-ascii?Q?8Fcd+pn2Vrh8Kf1KJy5a9VzcJtrEfqzwGXCVnZQVZzkQ1a6aReOVS0U3XnPb?=
 =?us-ascii?Q?NGuRuXdfHYEpM6v3qxPchfDnGT01iqPYxtmaRvhsw5brnsBKWFd8QqGhU5Wl?=
 =?us-ascii?Q?GipFPJueOB2XRfcE5HloLuXW1KRTUwN2jvD5UGJhCn2SqXJz0/CgARHc8A5V?=
 =?us-ascii?Q?CnrlepzOsQWkXDJui12oQ0kragSBHEieLmQr033a07E9apZhkadFcE7jHFzz?=
 =?us-ascii?Q?5Gsn17qkLkgLAHzYn5PeXFaZudvGmtesUyapkTxjI/DzPUZir0eU+jbZMeU6?=
 =?us-ascii?Q?Ovq2vDrkYJSGFxWvElMACWRTL9SJxomQXYxiJ18/aBQ2QLFKNQDZbNmrz6Q0?=
 =?us-ascii?Q?MOrLBF16ErBB7GgfLWNAB1c5+97DTAtvYphL9q72zB9GaPC3B36oeRB6OSvz?=
 =?us-ascii?Q?ySfK/lgC8fSzKQdtirqyo0A+TBNIgkU80FxBVhu4pX/bM17C8RkYvFaj7oKA?=
 =?us-ascii?Q?unb8cD61Oywn5XvVLNWv6vkk1yvgEaYC+KCqmVlnAaz1PmRQfgkkGw+8EXlt?=
 =?us-ascii?Q?g7va8IdnSqwwRZ4qtBW2vS1XPUOv5/rtmuY9smfYuAmePYOy6Ou22BE7hT0q?=
 =?us-ascii?Q?spwoT4rn4p897Gh1+lWWtFyITsCQw9taKFPRWZoe3ELRwo6FukephZXgTTIi?=
 =?us-ascii?Q?07BrlAdJQDVVSzMXmXZ/Cg/QB5QJz+vbC/Z8k8Z9Ikwyv5dUGEOsTD+CWJN6?=
 =?us-ascii?Q?/hP7ZGfMZKGYTc8b5YhV7ZdknMZrRiVloWBYFlpKBbcFH7E8t3WCHhE7Seh0?=
 =?us-ascii?Q?WiqovwyS/pEh4iYGT1dP/60BDjOY6rm8zZgiuNTyXzMIadfXwD0JBvJUBejE?=
 =?us-ascii?Q?xeutcVeUpg+E7hW4z2LGHRFqcQ50fOzOa1WbwgozXW90PMYBeVWdbKaBOy/h?=
 =?us-ascii?Q?y3+b1YsB0VpU7p8syjdMEzs5om/+xTuv6YVDOc65XAvdEBJlyBJHzQ/2vcY+?=
 =?us-ascii?Q?cAS7uTiPW1u3b8CVOGLsRG15a/7lSoKzAAa1NZn785l04qmoXtUT2vidNI1E?=
 =?us-ascii?Q?zNqBWJemMLdC76GLHzRk3EXBE53DOr3z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ySKtVN3Es6hjiwSSxeKKN3r+44VqxUEk9U49TCMLD+/jScDk3oEka/3jWQHC?=
 =?us-ascii?Q?VKEIx9fgQwy10nEmrTkqC/DBOGolw4r8fn/9cCKBZmqkCXZYVFNHCOlq/AWT?=
 =?us-ascii?Q?QkPp0sf6Yl8gJApd1Uu1f/jJIz0vR8CbEIYVh3axrT0LMZZ9qnjPPRcTIitF?=
 =?us-ascii?Q?0hP5pFm1JC3vVHVM8gJeDBeY/UaZVj3sJY3bo5ELHMARVAyr2QoO2xZd70kn?=
 =?us-ascii?Q?zUUXhtTboNvMLOteyef0fAk94K0y3azL7zyfSy/YmTehR6GSEvVyXXJnCK0v?=
 =?us-ascii?Q?CkX7zh9ujXbbs4Kil6gWr2yFxoL9XS6MEoBvTanlW9X53H6w0Sgxm7Z2CKxl?=
 =?us-ascii?Q?2jUbTOhbbHtry8ypGNcqVRaLOmjug+XvF7q2p6wTBvqLwIuk1pQWSweqsl9j?=
 =?us-ascii?Q?Mwe9bc51gaaKeutpTFYpxb9ZehiRQEwDGv5fGuNVrGsLhyG4VfbL2JuxTKgO?=
 =?us-ascii?Q?ohr2ahp/9VAnkp7P3wRsjUmRt26gG7K92srCcG616n5rvF/F8aSclAeZykgT?=
 =?us-ascii?Q?ObDJTzTaFwNH0L2tbqy02D3LP+OqaTqfEdXvgc+eWPWPZORiVMFKzl8qTr6e?=
 =?us-ascii?Q?BnaYtLsJPBsijBtrM4QpsEkD7sJ2ovZqUNf3h+J6VqZleH4+9cNiZ9mMWlml?=
 =?us-ascii?Q?VrJ4X/L/kcxCCxIO/1jnq76O0OsTqVuQRnxtPlgMlLHjuH1REyobsTcYSmFN?=
 =?us-ascii?Q?3EP61bTcHttWh+iVdRUhQHifGrfc+bAJHYMyhVcDcub6xkWqrHXu2N+n2nVB?=
 =?us-ascii?Q?fQZ0cvQOW/GEopAVxK1vtWrhksH2JX5039eesnUklw5KBaKKdfYrxTyltyD4?=
 =?us-ascii?Q?zlINF44PPrnbcQRr3HDgDl/WXhMtsoQXF8iqGNg7jV5lZRDkoc9LjljLpwHx?=
 =?us-ascii?Q?/Kid5AuVlw2z12EoxjieCD+mCuT8ZWDTTwbHum8ObERzV34TTxDVHRmLkkB7?=
 =?us-ascii?Q?iKVmalTnsNix5hNxQ/pMsF4wfJUFbJvXZw2jAWalwf7ckqNNTOIPwIJ/HsYK?=
 =?us-ascii?Q?pzsh5lj+XOqPrSYF7llH96bM7zGXp9ccAKfbh7t4yRw7MhTmNQHFt1CLp02K?=
 =?us-ascii?Q?OLQA7btnEz3YCfF1jHeJh4NiyaUWrfkLjetfRxM4DRwWBVJu2zNdrVJwkr3Y?=
 =?us-ascii?Q?i9SGsVLSdQO3OCsyvmhe4L2Y5uD5gl30TD1ABqYmuVNdVvKTcf7v5+CjRDtG?=
 =?us-ascii?Q?GH52m6qBUODCpvDJRle0Qdg4WkPAtdXhFbHxRhwI56Spm/xx6HV3BceSs8cT?=
 =?us-ascii?Q?jTEBFoxWBZ48DCQ2H+GL4mlOiaSwFW7/XAKQTGSsSXJiyiry6Duo0/mGeiMo?=
 =?us-ascii?Q?1yQaYx/eu+d/IjevUv2YxXjRG+XCvDMc7J+3LJ0DPwjcdM+UAEVFpRQZ2mDJ?=
 =?us-ascii?Q?UHzJbdgsU7kxJc+sYErlli+Ay33wNBY2euk5dRlpsrf2BOpfMVlwRADU3v7w?=
 =?us-ascii?Q?Om4FP2C0lWxOluGgLSUoZtaey7O/FUjhG5/8aGRRcQldTQTRT+BinteTtJ9M?=
 =?us-ascii?Q?ht91NKu4O/A2hNpJptGDtl5FjBhahbWQEcVk2FIbwul1R5zmNjFjh8fi2bg6?=
 =?us-ascii?Q?m96dwHWuxxvcikRXbNXvcD520xhSLtoeU670xnet?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b6f5a3-c264-4d7b-b81a-08dd6d247356
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:42:27.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwTVbjgIxaprnaXYYEgZGRCZ3Gqzaz5l9BtiuKG5kLxFT2VGWxKMeD8tLw4V9mFLMEh1vpwxIpxsVlXyEHyEQ2rBP+8Fmj1Ga9oCuvB1CKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7294
X-Proofpoint-GUID: YnwCNvgJZiEYoPbf8_ZYgDwCLVm2W3qf
X-Proofpoint-ORIG-GUID: YnwCNvgJZiEYoPbf8_ZYgDwCLVm2W3qf
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e539a6 cx=c_pps a=yZcDG7BW7OBBh6O1hU8nvQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=84sxc4KJppsAFEfAyyoA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270080

Add support for the second generation PCIe controller by adding
the required callback functions. Update the common functions for
endpoint and Root port modes. Invoke the relevant callback functions
for platform probe of PCIe controller using the callback functions

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  30 +--
 .../controller/cadence/pcie-cadence-host.c    | 252 ++++++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  24 ++
 drivers/pci/controller/cadence/pcie-cadence.c | 217 ++++++++++++++-
 4 files changed, 490 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index 1dc13e403473..d86d00ab475d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -195,7 +195,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u=
8 fn, u8 vfn,
 	}
=20
 	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-	cdns_pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size=
);
+	pcie->ops->pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr=
, size);
=20
 	set_bit(r, &ep->ob_region_map);
 	ep->ob_addr[r] =3D addr;
@@ -217,7 +217,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc=
, u8 fn, u8 vfn,
 	if (r =3D=3D ep->max_regions - 1)
 		return;
=20
-	cdns_pcie_reset_outbound_region(pcie, r);
+	pcie->ops->pcie_reset_outbound_region(pcie, r);
=20
 	ep->ob_addr[r] =3D 0;
 	clear_bit(r, &ep->ob_region_map);
@@ -332,8 +332,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_e=
p *ep, u8 fn, u8 intx,
 	if (unlikely(ep->irq_pci_addr !=3D CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn !=3D fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
-							     ep->irq_phys_addr);
+		pcie->ops->pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
+								   ep->irq_phys_addr);
 		ep->irq_pci_addr =3D CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn =3D fn;
 	}
@@ -415,11 +415,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie=
_ep *ep, u8 fn, u8 vfn,
 	if (unlikely(ep->irq_pci_addr !=3D (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn !=3D fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
-					      false,
-					      ep->irq_phys_addr,
-					      pci_addr & ~pci_addr_mask,
-					      pci_addr_mask + 1);
+		pcie->ops->pcie_set_outbound_region(pcie, 0, fn, 0,
+						    false,
+						    ep->irq_phys_addr,
+						    pci_addr & ~pci_addr_mask,
+						    pci_addr_mask + 1);
 		ep->irq_pci_addr =3D (pci_addr & ~pci_addr_mask);
 		ep->irq_pci_fn =3D fn;
 	}
@@ -518,11 +518,11 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pci=
e_ep *ep, u8 fn, u8 vfn,
 	if (ep->irq_pci_addr !=3D (msg_addr & ~pci_addr_mask) ||
 	    ep->irq_pci_fn !=3D fn) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
-					      false,
-					      ep->irq_phys_addr,
-					      msg_addr & ~pci_addr_mask,
-					      pci_addr_mask + 1);
+		pcie->ops->pcie_set_outbound_region(pcie, 0, fn, 0,
+						    false,
+						    ep->irq_phys_addr,
+						    msg_addr & ~pci_addr_mask,
+						    pci_addr_mask + 1);
 		ep->irq_pci_addr =3D (msg_addr & ~pci_addr_mask);
 		ep->irq_pci_fn =3D fn;
 	}
@@ -877,7 +877,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	set_bit(0, &ep->ob_region_map);
=20
 	if (ep->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
+		pcie->ops->pcie_detect_quiet_min_delay_set(&ep->pcie);
=20
 	spin_lock_init(&ep->lock);
=20
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/p=
ci/controller/cadence/pcie-cadence-host.c
index 1e2df49e40c6..0aadc194014e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -73,12 +73,83 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, uns=
igned int devfn,
 	return rc->cfg_base + (where & 0xfff);
 }
=20
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn=
,
+				   int where)
+{
+	struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	unsigned int busn =3D bus->number;
+	u32 addr0, desc0, desc1, ctrl0;
+	u32 regval;
+
+	if (pci_is_root_bus(bus)) {
+		/*
+		 * Only the root port (devfn =3D=3D 0) is connected to this bus.
+		 * All other PCI devices are behind some bridge hence on another
+		 * bus.
+		 */
+		if (devfn)
+			return NULL;
+
+		return pcie->reg_base + (where & 0xfff);
+	}
+
+	/*
+	 * Clear AXI link-down status
+	 */
+	regval =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT=
_LINKDOWN);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
+			     (regval & GENMASK(0, 0)));
+
+	desc1 =3D 0;
+	ctrl0 =3D 0;
+	/*
+	 * Update Output registers for AXI region 0.
+	 */
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
+
+	desc1 =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
+				    CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
+	desc1 &=3D ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
+	desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+	ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	/*
+	 * The bus number was already set once for all in desc1 by
+	 * cdns_pcie_host_init_address_translation().
+	 */
+	if (busn =3D=3D bridge->busnr + 1)
+		desc0 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
+	else
+		desc0 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
+
+	return rc->cfg_base + (where & 0xfff);
+}
+
 static struct pci_ops cdns_pcie_host_ops =3D {
 	.map_bus	=3D cdns_pci_map_bus,
 	.read		=3D pci_generic_config_read,
 	.write		=3D pci_generic_config_write,
 };
=20
+static struct pci_ops cdns_pcie_hpa_host_ops =3D {
+	.map_bus	=3D cdns_pci_hpa_map_bus,
+	.read           =3D pci_generic_config_read,
+	.write		=3D pci_generic_config_write,
+};
+
 static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
 {
 	u32 pcie_cap_off =3D CDNS_PCIE_RP_CAP_OFFSET;
@@ -340,8 +411,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_r=
c *rc,
 		 */
 		bar =3D cdns_pcie_host_find_min_bar(rc, size);
 		if (bar !=3D RP_BAR_UNDEFINED) {
-			ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
-							   size, flags);
+			ret =3D pcie->ops->pcie_host_bar_ib_config(rc, bar, cpu_addr,
+								 size, flags);
 			if (ret)
 				dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -366,8 +437,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_r=
c *rc,
 		}
=20
 		winsize =3D bar_max_size[bar];
-		ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
-						   flags);
+		ret =3D pcie->ops->pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
+							 flags);
 		if (ret) {
 			dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -408,8 +479,8 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pc=
ie_rc *rc)
 	if (list_empty(&bridge->dma_ranges)) {
 		of_property_read_u32(np, "cdns,no-bar-match-nbits",
 				     &no_bar_nbits);
-		err =3D cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
-						   (u64)1 << no_bar_nbits, 0);
+		err =3D pcie->ops->pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+							 (u64)1 << no_bar_nbits, 0);
 		if (err)
 			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
 		return err;
@@ -467,17 +538,160 @@ int cdns_pcie_host_init_address_translation(struct c=
dns_pcie_rc *rc)
 		u64 pci_addr =3D res->start - entry->offset;
=20
 		if (resource_type(res) =3D=3D IORESOURCE_IO)
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
+							    true,
+							    pci_pio_to_address(res->start),
+							    pci_addr,
+							    resource_size(res));
+		else
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
+							    false,
+							    res->start,
+							    pci_addr,
+							    resource_size(res));
+
+		r++;
+	}
+
+	return cdns_pcie_host_map_dma_ranges(rc);
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	u32 value, ctrl;
+	u32 id;
+
+	/*
+	 * Set the root complex BAR configuration register:
+	 * - disable both BAR0 and BAR1.
+	 * - enable Prefetchable Memory Base and Limit registers in type 1
+	 *   config space (64 bits).
+	 * - enable IO Base and Limit registers in type 1 config
+	 *   space (32 bits).
+	 */
+
+	ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+	value =3D CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
+			     CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	if (rc->device_id !=3D 0xffff)
+		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
+
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
+	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags)
+{
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	u32 addr0, addr1, aperture, value;
+
+	if (!rc->avail_ib_bar[bar])
+		return -EBUSY;
+
+	rc->avail_ib_bar[bar] =3D false;
+
+	aperture =3D ilog2(size);
+	addr0 =3D CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
+			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
+			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
+
+	if (bar =3D=3D RP_NO_BAR)
+		return 0;
+
+	value =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_H=
PA_LM_RC_BAR_CFG);
+	value &=3D ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
+	if (size + cpu_addr >=3D SZ_4G) {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |=3D HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
+		value |=3D HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
+	} else {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |=3D HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
+		value |=3D HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
+	}
+
+	value |=3D HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_=
BAR_CFG, value);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc);
+	struct resource *cfg_res =3D rc->cfg_res;
+	struct resource_entry *entry;
+	u64 cpu_addr =3D cfg_res->start;
+	u32 addr0, addr1, desc1;
+	int r, busnr =3D 0;
+
+	entry =3D resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry)
+		busnr =3D entry->res->start;
+
+	/*
+	 * Reserve region 0 for PCI configure space accesses:
+	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
+	 * cdns_pci_map_bus(), other region registers are set here once for all.
+	 */
+	addr1 =3D 0;
+	desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), addr1);
+
+	r =3D 1;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res =3D entry->res;
+		u64 pci_addr =3D res->start - entry->offset;
+
+		if (resource_type(res) =3D=3D IORESOURCE_IO)
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
 						      true,
 						      pci_pio_to_address(res->start),
 						      pci_addr,
 						      resource_size(res));
 		else
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
-						      false,
-						      res->start,
-						      pci_addr,
-						      resource_size(res));
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
+							    false,
+							    res->start,
+							    pci_addr,
+							    resource_size(res));
=20
 		r++;
 	}
@@ -489,11 +703,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 {
 	int err;
=20
-	err =3D cdns_pcie_host_init_root_port(rc);
+	err =3D rc->pcie.ops->pcie_host_init_root_port(rc);
 	if (err)
 		return err;
=20
-	return cdns_pcie_host_init_address_translation(rc);
+	return rc->pcie.ops->pcie_host_init_address_translation(rc);
 }
=20
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
@@ -503,7 +717,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 	int ret;
=20
 	if (rc->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+		pcie->ops->pcie_detect_quiet_min_delay_set(&rc->pcie);
=20
 	cdns_pcie_host_enable_ptm_response(pcie);
=20
@@ -567,8 +781,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (ret)
 		return ret;
=20
-	if (!bridge->ops)
-		bridge->ops =3D &cdns_pcie_host_ops;
+	if (!bridge->ops) {
+		if (pcie->is_hpa)
+			bridge->ops =3D &cdns_pcie_hpa_host_ops;
+		else
+			bridge->ops =3D &cdns_pcie_host_ops;
+	}
=20
 	ret =3D pci_host_probe(bridge);
 	if (ret < 0)
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index e190a068b305..3f4e0bd68f11 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -43,7 +43,31 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pc=
ie, u64 cpu_addr)
 }
=20
 static const struct cdns_pcie_ops cdns_plat_ops =3D {
+	.link_up =3D cdns_pcie_linkup,
 	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
+	.pcie_host_init_root_port =3D cdns_pcie_host_init_root_port,
+	.pcie_host_bar_ib_config =3D cdns_pcie_host_bar_ib_config,
+	.pcie_host_init_address_translation =3D cdns_pcie_host_init_address_trans=
lation,
+	.pcie_detect_quiet_min_delay_set =3D cdns_pcie_detect_quiet_min_delay_set=
,
+	.pcie_set_outbound_region =3D cdns_pcie_set_outbound_region,
+	.pcie_set_outbound_region_for_normal_msg =3D
+						cdns_pcie_set_outbound_region_for_normal_msg,
+	.pcie_reset_outbound_region =3D cdns_pcie_reset_outbound_region,
+};
+
+static const struct cdns_pcie_ops cdns_hpa_plat_ops =3D {
+	.start_link =3D cdns_pcie_hpa_startlink,
+	.stop_link =3D cdns_pcie_hpa_stop_link,
+	.link_up =3D cdns_pcie_hpa_linkup,
+	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
+	.pcie_host_init_root_port =3D cdns_pcie_hpa_host_init_root_port,
+	.pcie_host_bar_ib_config =3D cdns_pcie_hpa_host_bar_ib_config,
+	.pcie_host_init_address_translation =3D cdns_pcie_hpa_host_init_address_t=
ranslation,
+	.pcie_detect_quiet_min_delay_set =3D cdns_pcie_hpa_detect_quiet_min_delay=
_set,
+	.pcie_set_outbound_region =3D cdns_pcie_hpa_set_outbound_region,
+	.pcie_set_outbound_region_for_normal_msg =3D
+						cdns_pcie_hpa_set_outbound_region_for_normal_msg,
+	.pcie_reset_outbound_region =3D cdns_pcie_hpa_reset_outbound_region,
 };
=20
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/co=
ntroller/cadence/pcie-cadence.c
index 204e045aed8c..d730429ba20c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -5,9 +5,49 @@
=20
 #include <linux/kernel.h>
 #include <linux/of.h>
-
 #include "pcie-cadence.h"
=20
+bool cdns_pcie_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	else
+		return false;
+}
+
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_P=
HY_DBG_STS_REG0);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	else
+		return false;
+}
+
+int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_P=
HY_LAYER_CFG0);
+	pl_reg_val |=3D CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0,=
 pl_reg_val);
+	return 1;
+}
+
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_P=
HY_LAYER_CFG0);
+	pl_reg_val &=3D ~CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0,=
 pl_reg_val);
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay =3D 0x3;
@@ -147,6 +187,181 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie=
 *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
=20
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
+	u32 delay =3D 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
+	ltssm_control_cap =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
+						CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	ltssm_control_cap =3D ((ltssm_control_cap &
+			    ~CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
+			     CDNS_PCIE_HPA_PHY_LAYER_CFG0, ltssm_control_cap);
+}
+
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size)
+{
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	u64 sz =3D 1ULL << fls64(size - 1);
+	int nbits =3D ilog2(sz);
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	if (nbits < 8)
+		nbits =3D 8;
+
+	/*
+	 * Set the PCI address
+	 */
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
+		(lower_32_bits(pci_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(pci_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), addr1);
+
+	/*
+	 * Set the PCIe header descriptor
+	 */
+	if (is_io)
+		desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
+	else
+		desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
+	desc1 =3D 0;
+
+	/*
+	 * Whatever Bit [26] is set or not inside DESC0 register of the outbound
+	 * PCIe descriptor, the PCI function number must be set into
+	 * Bits [31:24] of DESC1 anyway.
+	 *
+	 * In Root Complex mode, the function number is always 0 but in Endpoint
+	 * mode, the PCIe controller may support more than one function. This
+	 * function number needs to be set properly into the outbound PCIe
+	 * descriptor.
+	 *
+	 * Besides, setting Bit [26] is mandatory when in Root Complex mode:
+	 * then the driver must provide the bus, resp. device, number in
+	 * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the function
+	 * number, the device number is always 0 in Root Complex mode.
+	 *
+	 * However when in Endpoint mode, we can clear Bit [26] of DESC0, hence
+	 * the PCIe controller will use the captured values for the bus and
+	 * device numbers.
+	 */
+	if (pcie->is_rc) {
+		/* The device and function numbers are always 0. */
+		desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		/*
+		 * Use captured values for bus and device numbers but still
+		 * need to set the function number.
+		 */
+		desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+
+	/*
+	 * Set the CPU address
+	 */
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pc=
ie,
+						      u8 busnr, u8 fn,
+						      u32 r, u64 cpu_addr)
+{
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
+	desc1 =3D 0;
+
+	/*
+	 * See cdns_pcie_set_outbound_region() comments above.
+	 */
+	if (pcie->is_rc) {
+		desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	/*
+	 * Set the CPU address
+	 */
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
+{
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), 0);
+
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), 0);
+	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
+			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), 0);
+}
+
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
 	int i =3D pcie->phy_count;
--=20
2.27.0


