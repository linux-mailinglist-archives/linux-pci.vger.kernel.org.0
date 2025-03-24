Return-Path: <linux-pci+bounces-24503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3EA6D6EA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8600C7A1CD5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A925D8E7;
	Mon, 24 Mar 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ep0OQR4G";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EZ+dca+N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356461EB5D7;
	Mon, 24 Mar 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807333; cv=fail; b=S07MuE16UAX7VT0oCqUbgpSJY42A8RqHX5Depq24QZxTZHvfU2vkFQtHoksWd18g+8v6ypRYJ95iItrJ0DxWuak1ZzEt8ELO/u/hxvuHhBV0JLpVEG6GTddYQ6mpQ9LkihTbwIlYYE96Z81UV/tx4dsyBRAyWoJiHBR65mHkb2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807333; c=relaxed/simple;
	bh=J1446KP7KXPvn0qmPQkUxNWkEggHpSzNXPQv6MtJooM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPk4HJQRbgAlM3aSbwkpabNsLv1Ggi17SgT0gd5utRm40Qu3LEkSXl7mlOz3HiMjl1LcPU/AB6WXUYRA/rBt6fKMttLktkBVs1ATLQW2Rrqka3K9sQ3tiR9Svoqt4MdYoQtqxf83MbkPcp2o3Lijx831XUnj174hPwuoM03DFTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ep0OQR4G; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=EZ+dca+N; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NMuHSX027610;
	Mon, 24 Mar 2025 02:08:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=3MLoc0sZMmIX7ioSaL0U9SpIPlIQF/KqTrw7Ozw5xdA=; b=ep0OQR4GKXKu
	+ikYYMvNgm4zpw+A/zTkCbOASuz33Ogyf4yWWQRuBS4PglFioZph0WlTgstLVwao
	WFc+23A2q0vHc3gbpn8Wb7xiHMZAGXyyR5j9rTY4apqFiYJ7oPTTIQrnRkHNMzEh
	CrOO+BVDAbkCfyAsoXEWEBVGrnLJumFMLJUyq/ye20RBiBrNfia2ryGCIzQ2wpod
	H/r05M0HdFE9ZkfMaaY+qmC6wIJeCUAgU4NW1LLk6tweDFaXUd1NMi5pSoi7f9Eq
	TUd7nzWuZmSV1DSdYW+2mBdwSiIVAdGwsQdAiwDK3LhJk0rAEvswV1on8SgXVYvx
	JSL3fvhvlw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrw4wp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVllw3cZOUL7JzIBSRKfzQLHwGUwpLY3ZgEQDHUbtDmBa1XUHmWww6VyEvhmo/4BL1Ij1efSZD5RLNPBxhPrlcf0kl8SuyzHJIQRYIwJnghiZ9732LSNlvpGx/vFBPNajQgyunDUsnU4x7dp6AOJ0S2fdaD0KzjNF2ipfWtDWtesOhulHipJtXrlYxa8Sq8Xant9tnxLhzuIvQN+j70+ipTexfIWQg21PLv/LRLUxYOoR8gDp3UpQVc18SmzP49gjLuZHsnmFwGn2uIPZCrGIR5qGiOA+yeAOXF0sAqZtQ21A0HrlAfsIg65znFbRbgniJxf9gG6cf7i8yqbF0cN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MLoc0sZMmIX7ioSaL0U9SpIPlIQF/KqTrw7Ozw5xdA=;
 b=iK1p/MKxEENrs00n1Zoszj5njMdGwC5PuD0IViDzFX6i+KDVoAspJNWKYsNlNxkbrclFjg81QC53J5QOCpadOgzTK1z4CBoDfbnP6ianfr9+INo1jEI2kJrUflRA5LUCCq1NFi3eprryVsHWMBu93U3/noho3eCtJEP9UyB6qy3fgFkkIKJwUV3XajVxiBaxXtNA0z4jTDAXwRwymSYQ4cgcGjNLefPSjjvTZnE3YecfrlvC2UGeo15JXyBywTzwFDm6E4jZxl9jao/8l+HthckJ3xyqIfzAusV4F3tEjQLtJ77EC3kKE54goLAhmyDE779JkBQOAGZMqnsKBKDOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MLoc0sZMmIX7ioSaL0U9SpIPlIQF/KqTrw7Ozw5xdA=;
 b=EZ+dca+NIVQ+fRjqryYlfetvysGTX/s4O2WvbDjF4LkgXMBfqVB2AJeUI6pRC78Ireq6+0Jih2VvCkiTf/igvedDfIy9HEjKB+rM4YHhEHJxR1M7PsuRhO1DVE5izBYnituMLnF+mocII9smG8/xV4WpRE5o93UxVWMSTcN8rAw=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:08:38 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:08:38 +0000
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
Subject: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for PCIe
 controllers
Thread-Topic: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for
 PCIe controllers
Thread-Index: AQHbnJYN58zDjM3IK0mkK2vcWXEOWrOB/Ovw
Date: Mon, 24 Mar 2025 09:08:38 +0000
Message-ID:
 <CH2PPF4D26F8E1CE4E18E9CC5B8DAF724DCA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082335.2566055-1-mpillai@cadence.com>
In-Reply-To: <20250324082335.2566055-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05MTJlZDEzYS0wODhmLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcOTEyZWQxM2MtMDg4Zi0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIzNjkyIiB0PSIxMzM4NzI4?=
 =?us-ascii?Q?MDkxNjc1OTU0NTAiIGg9IlhRTE9rZ0V4SGZHazZPSUxidThRUUlKQjVTcz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBQzZwNFJUbkp6YkFYQlo1RkxKNnAyVGNGbmtVc25xblpNSkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUNPQlFBQS9nVUFBSklCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFRQUJBQUFBeDlhTzVRQUFBQUFBQUFBQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?akFHUUFiZ0JmQUhZQWFBQmtBR3dBWHdCckFHVUFlUUIzQUc4QWNnQmtBSE1B?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BYndCdUFIUUFaUUJ1?=
 =?us-ascii?Q?QUhRQVh3QnRBR0VBZEFCakFHZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZB?=
 =?us-ascii?Q?R0VBY3dCdEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QndBSEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?bmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFIVUFj?=
 =?us-ascii?Q?Z0JqQUdVQVl3QnZBR1FBWlFCZkFHWUFid0J5QUhRQWNnQmhBRzRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJB?=
 =?us-ascii?Q?QUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpB?=
 =?us-ascii?Q?QmxBRjhBYWdCaEFIWUFZUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFB?=
 =?us-ascii?Q?QUFuZ0FBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QndBSGtBZEFC?=
 =?us-ascii?Q?b0FHOEFiZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhV?=
 =?us-ascii?Q?QWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhJQWRRQmlBSGtBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSklCQUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQWNnRUFBQWtBQUFBc0FBQUFBQUFBQUdNQVpBQnVBRjhBZGdCb0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUNRQUFBQUFBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFHTUFhQUFBQUNZQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUpnQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQWtBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQXVBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElBWVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH7PR07MB11228:EE_
x-ms-office365-filtering-correlation-id: 3df2bc1e-5ebc-46b1-cf8f-08dd6ab3770e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KpxCJUc7ULObo5e+RMs87NmVG6leo0zml2IswCMLgkBDpY31w+Rj1noY/pvj?=
 =?us-ascii?Q?WI9vx3crnKzg1QDWHytGL6OeoXawbGXQs/g8Jbi3M9zzpq8d0VUeLHQtHOwX?=
 =?us-ascii?Q?cTcDgOQh2lfWnu0YuePT+CmNVUfBeGhOPCCOaqyKCGaOXUVeBj5mMoNLKneL?=
 =?us-ascii?Q?7EtiD2Czj7FS95q839rfEAp8IrFl9kW20xbltCF4V+pa7sEeoNaweGFKhynG?=
 =?us-ascii?Q?+hKUc7yqm9wovEYMYS1QUYNGfr8CYYzFCf1vP1//vtjxEAAA9N/vIpFVQHd0?=
 =?us-ascii?Q?4NY/bPzfggdFSaNv8ZRGUsZ8aIXWl23PZkMqetQTyyV/NmQphoc5Da190zb+?=
 =?us-ascii?Q?w4BVginhQ5Mnj9nqbfyQWUfsweX+kd7l0+bL0faw8tn2K4s/F6dGeXZOAo9s?=
 =?us-ascii?Q?Jmtv5CvZ8Jn4KvBHCKKHQjpXS/I4bpXvQ33fru1+vjn+4/yCd+spN5KFMOgA?=
 =?us-ascii?Q?dVUnZkNm+hYxUlCyFsaM9uIrPpCHL9P7tXZOGeVaVOQQMIrYirb/AJnqhtm3?=
 =?us-ascii?Q?P9YadTPFWk+XQYCQDrbdBxOfOTcsu5NUKxQtZXHK4eFwLDDOeF8mSwNwZW0o?=
 =?us-ascii?Q?ADe3ENtNiL1LVUcSQdCesswtV0jW4opcyPDBJw9NBk3So593cj2g5LgvlC0l?=
 =?us-ascii?Q?t48U644WLCYqmezTC1AePngwtdv5M31JAY00hzUzemve7odQtEzjbWHe+PKN?=
 =?us-ascii?Q?GINy78vg/oIGtbZkYP/F5Hy2ma9jhOxbWEmPyArHCYY3WVR75ijOxcIzGFi2?=
 =?us-ascii?Q?hf4AZq0oxsgMcp2BWuLvbnqUrk/FNdIJhAsIT+/EDbH4sknIulknvUkwLOy+?=
 =?us-ascii?Q?cciZY0FREcrNkE3+SpuJ3u4vrJdZB2oF4pqQvyfbma5Rw3MIM50ee+1V0ggn?=
 =?us-ascii?Q?le6QCqgekJfA9zm7J3GX49qKxhAEKA+w0V2EVFahFRH6fFYRXp/mb0HhChwG?=
 =?us-ascii?Q?69qS4f42pjmEdiwr5xVDQN5n5YUfWk4hchXp6Rh0VEvHpLxUcpiF4qRt3iaW?=
 =?us-ascii?Q?oGOkaFt82dQQ737YbOMWUudV4iTcCVNa3NuP9fNVkyKe8h5AemXAPJUkEO54?=
 =?us-ascii?Q?dand+1GBLRM3SzsEhit77AU/KhexDoGV7wc8pp0y/ZUtKvOO0MAGCQBlNIvW?=
 =?us-ascii?Q?wctUpJ36h5i2CdaGOO+p0Joym6woTaTFwFPnZWJSDo+q66khL+tSXq7SmCEa?=
 =?us-ascii?Q?xkFwU9D7zDhC74Ny68JwT3NEekzD9PngY9SaAyrUJw626FKHnacr+vVquWgH?=
 =?us-ascii?Q?k2zffPG+81xIUstlQ9Qdc5gw35F63/uToyn4gEUo27HyLA7MyQnqRfCifikn?=
 =?us-ascii?Q?9KW6qvzTdvfIBovwjZmix4PkBngJTrHbjdp0NAwOhnHYrCEuHvTLhEA0aBRX?=
 =?us-ascii?Q?jS8Lg6WGsO1/VTYiQo5c7LBYB/tQ3op2Bb0egbVeORZ9ioYYE9SabzGlYQc6?=
 =?us-ascii?Q?2MlJbY0euUsi49N48JxPoYTpV+fsT5cz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VFuruTk7BGhRs1x/wRue31mrl/misfWdIMUBrX4hp612ddNtNjo1BjbKbwdX?=
 =?us-ascii?Q?KeR8St1OnUCApIBoqcEUxwBfAGm6dTF2/578m8JmfTiyoPgYV5rH+gd413BS?=
 =?us-ascii?Q?HBzhVkGHxt8oGJxvSzg8kv95O1lJIh33Ml/+BGuV25XzCahVdUOZVhpMg8WD?=
 =?us-ascii?Q?kXRQMY0QP1TNMtmzDM7ZZ/m6QdiONbfq6cy4iaztyj9PcC8+cpEdIYkPyXEO?=
 =?us-ascii?Q?FkcAW5ySE6z049yoW4APUqwA0YRuVXm6XTRqMO/jtXZDU7klXjhzxcBf5qnY?=
 =?us-ascii?Q?8a0TXwWE0RgABEfX0NvnMc75hSLNIV3+5m6HzSkV9/kkyY5/Iil0N9Gy8Qud?=
 =?us-ascii?Q?6VgZghRaAvdCbWoJ1a+fwZNX2ZlQR37cbMI7eDUvkFVoE9xLlPyNkjKU8zqd?=
 =?us-ascii?Q?ZK161FlDnpe98KxinJpEYn1YNwN9trKHs68LP7UgjHE/mokXsdEiRgP4v0Fp?=
 =?us-ascii?Q?qO6FP8ew1LOz0P+GmYyd2FxycwERkezCB/qOspyyOh1LQq6YIw/Ga/tMd0TO?=
 =?us-ascii?Q?cRAJifxm4WpHgmEX05QHqDWeTnCXlj5JcGkZmt5LYBTbqDcsGHXVTn7J4IwU?=
 =?us-ascii?Q?YzXAlOO4LPED1flv7wFBAp5zGPhZNOYFfHi2QsLNJ+0lCA+aWstFvcdy8t/i?=
 =?us-ascii?Q?HlmeX6qGraomSN1lN/JXZ+kLrux0gDEwo4FxSK9+eaHjOEyeit8gb9u7l8BB?=
 =?us-ascii?Q?/Qruugp/MA3FTsvhnub+JCOmpeSUPo2onTI7D1jp2F+8uzkVm3oktq4qI03i?=
 =?us-ascii?Q?wzJzJFo3hYFAHbIR2F6EhwRs7+SdoMxHzUg5mnZ/BZUKPcjQsapkLEWX7wWy?=
 =?us-ascii?Q?mP75REPNTrWKDb4Fu7nMiWmr96fi63zVO30UQwpEPBcK9jBk6BGWUt4R4M4A?=
 =?us-ascii?Q?zIw63ZbMtLfMmkbLlqjw7z38Q87PeUHuf5SHUux5nkVCLNRLS3GegX1ro0/U?=
 =?us-ascii?Q?hRbzhpCKI8FgJg3yUyW6P8Cvn9gk8rpAB3+rqbViCkyCjYaSDt8G6jzZ6ZeW?=
 =?us-ascii?Q?6rL1eWvdUBP9O7eAraNqQWQmdTgaNh84aO5ysHJbt3k6vsp88oFoQArbftMN?=
 =?us-ascii?Q?998HWuiXm3E1ypyLS6FfrtsHDqUpHZ3PLBXKJYWf2u7TtiGT4DcMFxEMD2jh?=
 =?us-ascii?Q?Ml9zBD/tohLX/Hi4w6brvC2Nd9Dq/bxFcbl9qwVvAka7x8SLJrgo4CJ30N9q?=
 =?us-ascii?Q?jEOjYhQGfnDPnj/Pe860jN/dF+r0eGtFHLEgSaa0PX+tqSjgEFg3Z9RxBw4f?=
 =?us-ascii?Q?S/UmYl7JubScQDCtUV1aKbXGyNA5eWGsuWoK//EjqWeNRbcunh8OoFeSc68X?=
 =?us-ascii?Q?uDYlM4gzRWkimZl6R1PzDL2yhD8Ua/Nvs3fAlySn648Pk9Ai6/sYH6XFaTId?=
 =?us-ascii?Q?6D/rGoiejnu9kyIh2wXjKdM3oAUhgRa0udSTMp9Mv9qCEhMCF7cAdu94cfy7?=
 =?us-ascii?Q?/2inWn+Y3HpMYX/Bu2AorazWly7qm89fir43c1oso098e9lXPZILHt0tyrsh?=
 =?us-ascii?Q?coP0xKWDjVFAmgCAQEcb8MzTUMP+BnfFqyWJtpXJJlkpgunMQn18MDQV1AVb?=
 =?us-ascii?Q?a2pHIVDc8dbXbTd7gJepVB+qM/jCt8iXiunFHohi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df2bc1e-5ebc-46b1-cf8f-08dd6ab3770e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:08:38.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgN4ZmfFMF6iFRBKEOQ/2ySnsgb68ZGtIMzCxVxDQ7REepGdPiUf+rfGekm0LdydzLD78YW9skISwwRsjBIsqVDwBfJyJ9Er4+Xk5O+hag8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e12118 cx=c_pps a=f1nyBA1UpxJqkn7M4uMBEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=w3V_qhxWECijm69RcPYA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: 30XHHN9iwFZegNJJW4ngdkM4XRoiC6wF
X-Proofpoint-ORIG-GUID: 30XHHN9iwFZegNJJW4ngdkM4XRoiC6wF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Document the newly added property "hpa" for Cadence PCIe controllers in Doc=
umentation/devicetree/bindings/pci/ for Root Port and Endpoint configuratio=
ns

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml         | 4 ++++
 .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b=
/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 98651ab22103..4e839fa90b23 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -24,6 +24,10 @@ properties:
       - const: reg
       - const: mem
=20
+  hpa:
+    description: If present PCI controller is high performance architectur=
e
+    type: boolean
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml=
 b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index a8190d9b100f..c219fe15c879 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -9,8 +9,11 @@ title: Cadence PCIe host controller
 maintainers:
   - Tom Joseph <tjoseph@cadence.com>
=20
+select: false
+
 allOf:
   - $ref: cdns-pcie-host.yaml#
+  - $ref: cdns-pcie.yaml#
=20
 properties:
   compatible:
@@ -24,6 +27,10 @@ properties:
       - const: reg
       - const: cfg
=20
+  hpa:
+    description: If present PCI controller is high performance architectur=
e
+    type: boolean
+
 required:
   - reg
   - reg-names
--
2.27.0


