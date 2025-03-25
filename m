Return-Path: <linux-pci+bounces-24604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26EA6E89A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3E83AEEB3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 03:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E844A18;
	Tue, 25 Mar 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WyGIzfyt";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="yhME0IWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC22AF07;
	Tue, 25 Mar 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872599; cv=fail; b=SSUjdbQbFzPuGkfV8pC4BMVdr0BQy3aqYIVZVxqRIgNfwNBUVYQ2xfxRVDhk80n3OvTHICVD5kXDYeuC9+9VQvJBcCa7u5Sh1EVHXk2Y23iNttOxzbQ3gKSymQTdyg7ktXV+Prjf39m/Ybpm5Qh/6+5pV+QBwkJn4U21j6Cpu/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872599; c=relaxed/simple;
	bh=tolrHsZHMma+zijz7O0RCaTsV2FRrCesvA7ezRq6Tbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAJzmC5Ul3jsj76ehHUD4NfnoXyM3sLkUlkYW/M247BH06DRZIoDRCj74Y89sVgYKBdYFzyBUpXZ+mnTzNVkhu6tvn/9SrsWncJ7deX+qrGg7JnYxP7DHZgvg14K9k0i/QODgXLPpHuTvFC2UOYtyzHg22FJEqRypElWDhZl04U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=WyGIzfyt; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=yhME0IWh; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OHEksL032322;
	Mon, 24 Mar 2025 20:16:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=fL1i1lVohWIOTvxQ/SqW1p117jgwqN0v+Jljn6eQFHY=; b=WyGIzfytjhxW
	CLY3aPxU+1Lt2skmXnASfHSHTZqijZj5X9B7LQ+ntkfDwspkImQjfK5DYavV/hKp
	Nlp7ZxdR0lnya0kjtwDRnpXvIzRQT6bbhCXK7fZUbRNDMA2PXmyiWRQKf9EGhBRF
	gu0TGVGOhmdUDM0gbb+njA97cgHoLvJTuyDwaSxaDr7F61Ue66qgD+emkIKGyxDV
	JLQWXeDzD+Md2G0m6Xn+c2/vZw50DBI3sJSfGlc/BL66gFaa8KOOZ0t0Q61AHdN3
	yVSh2Bvfv3dui+zaJQZ4Itz6D+7rC9pL1Jx4V2mDVYN591TcE/6gWZ4bBY9FDdN5
	Ngi9m+bT3g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrswryyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 20:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGAdXrGu0xTT50SBv1vFlqF0HHBtHliajpD9d0a/Z7hSO1O+ca2CfIvcADMxyyyfdziAs9kCQ2vrLJ0JKdKwaroY9Nh9pXlBkC3hbWEepArpvwZRUZA/HZQlowkIuBUPtLQ8qxopjZbsBx7/nNksy8elF29dwXbBJTZ5QRuJXojfBXY7NCQuNzStwLoaw3HQyzl5sJ4Axt+VJTEamyycDfjjuRaMHaEbIREuCaFO9iv65NzEH6pLISrlyBffoUMS6rqiseFMfkS29m5qgKEBuxIYfIKw+HEOhjMaIY4vZlDEey7RRW7jsqNhKnaETXeALNTx6OLMi5uWgmu1vQZJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL1i1lVohWIOTvxQ/SqW1p117jgwqN0v+Jljn6eQFHY=;
 b=gUhQ8AvR2DHioR8BFWdhWax0J22lKZyrAjM6AxMDJn+Cy1y2TGCT8EzgE8/Orj6OogCznZynkB0E46UIyu52II0ILS1WNIdUMAYdytdM1d7ZFZ5ax63bbgJ5Kq0HgMOw1Q4V8mfZZZ2GM6NEfgyZ4XvVcPzz8ALBmGmef5nlT3vqjraFelfw9bEB3H++z8WImcpHro2Vv8YV1XaDxtkCwp95hSQiokY9gaq0+w7XQdpvplZGMqDrWAK6hlH8KiqfrE4bBEuFdc4VkoSk21f9wFuxquoE4pb366thlVcibOd6huC/OQM+Wl2W2+XorC1hkI7QPWOd9cYCJ6zGJJtp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL1i1lVohWIOTvxQ/SqW1p117jgwqN0v+Jljn6eQFHY=;
 b=yhME0IWhmILjILG0rsCTjWLFrouucyvFAFDIjCcxhUMyhlDsLxTjXMkFF3cEE5YLy09zZXfyuSTt0nff+wac4r81BUU9TBV9joTkM9uyPJYbgz4dBCoPSBfhbTVH7+DRfKBt5LdBXshD4CSxJ5QQ8jrZHCeUJJ08ks1VPhG+wQo=
Received: from DS0PR07MB10492.namprd07.prod.outlook.com (2603:10b6:8:1d2::21)
 by BL4PR07MB10205.namprd07.prod.outlook.com (2603:10b6:208:4e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:16:26 +0000
Received: from DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089]) by DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 03:16:26 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for
 PCIe controllers
Thread-Topic: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for
 PCIe controllers
Thread-Index: AQHbnJYN58zDjM3IK0mkK2vcWXEOWrOB/OvwgAB1UoCAALhpIA==
Date: Tue, 25 Mar 2025 03:16:26 +0000
Message-ID:
 <DS0PR07MB10492F672DEACE769F97C609BA2A72@DS0PR07MB10492.namprd07.prod.outlook.com>
References: <20250324082335.2566055-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CE4E18E9CC5B8DAF724DCA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <60af2ed4-91a9-434b-b1f6-a87218aba381@kernel.org>
In-Reply-To: <60af2ed4-91a9-434b-b1f6-a87218aba381@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04NzhkYWZhYS0wOTI3LTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcODc4ZGFmYWMtMDkyNy0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI5OTkyIiB0PSIxMzM4NzM0?=
 =?us-ascii?Q?NjE4NDEwNjk2MTAiIGg9IkZDcEQ1dUdlbGNndVYzaEk1WWs5Z3Y1SWRHUT0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBQXFodU5KTkozYkFYek4yaGZ4YlNqTmZNM2FGL0Z0S00wSkFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQndBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSklCQUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQWNnRUFBQWtBQUFBc0FBQUFBQUFBQUdNQVpBQnVBRjhBZGdCb0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUNRQUFBQUhBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFHTUFhQUFBQUNZQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUpnQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQWtBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQXVBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElBWVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR07MB10492:EE_|BL4PR07MB10205:EE_
x-ms-office365-filtering-correlation-id: cf96c5a5-e09c-49f1-b691-08dd6b4b6de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H39NXpdYgzgdfJP4HqFBukgo6KWX7IqbrTaqNf8Aac4v6NQu9Sw9Ru2XtAZQ?=
 =?us-ascii?Q?ztb0ip38SGHU3zvZHC6Re7yWEe5t779FmytJe5KKyA6Qyir20x0PtIEXoW0w?=
 =?us-ascii?Q?q4azRLaAaiGPW7xiXzquac936LWs0dG0QzRN7Fpe+H+Gw6r0qDPfWRh9xgyo?=
 =?us-ascii?Q?mfQPIwYcaXD6G3fp1G0fJW9mGuoL8kcTZi0eJ7wGnvMNK4UPZQSHqaRAn08f?=
 =?us-ascii?Q?HttWngbpA1YfM9kFECz6+JaQfOEW4kfhG+xl1acV06UVwUQGUOfLdgD+bejv?=
 =?us-ascii?Q?ELaRPOXD3ZaR75x/3vQiMnwcM7YoG4i8rI0dCvinScHJj6ZVmHtM22mwVCIa?=
 =?us-ascii?Q?QfCySM7WGY8UX/OuH71+JQ5t8MXJlG9Zdx6pzbFSjw6ysFkwwlwmuuJDlkd1?=
 =?us-ascii?Q?3mZ3IZLXAJhK8whcESUa0ddibjCt/BQNuJWjiIxCKKhTwqJiluRHT023EBO0?=
 =?us-ascii?Q?gbg8ria35Vd+4R+K/lucFxilBpGmej1Ukdn01iS+oigFzaJg5EMQrXPWOXia?=
 =?us-ascii?Q?LLgROhvyvwf0gFh2kLiMeYSHNxNgMSooB2pzhXazWbdmrmDHiwvjju0ik2Xg?=
 =?us-ascii?Q?kzXeQfWl0K0W7LVcuNg/QfVcKMW8rpzlJ+1IdWn3MqAJ9cyt4dIeXktA7CnO?=
 =?us-ascii?Q?7RV8t1BMANifYwG3ThuZ/uoW+X3qSAJ3mEAjSh/uyxgPvTSO9Qiq22piCrQf?=
 =?us-ascii?Q?3H8KGzjvHo7Z0PoQTdq2L19Yg02TzBLrg3yQ8qiHotNjN4qwRhUeVH5hMh+k?=
 =?us-ascii?Q?j/fl8JVfGFafbiLm1qB8YhK6k8dL9xqwkFTU41s1msu5T+SRxbdUnnI417hU?=
 =?us-ascii?Q?wcuNggh0IxuZ84Tm7nbLKBKnMhrkGA6Yo6a3z/dGLydIXXgUsy7kOBnfr2eR?=
 =?us-ascii?Q?sFvfn1qLwEFSxb1+Hv2hBahOD4rCX7+2GEzaaSUVnODGsvUKrNt0lhMHt1+6?=
 =?us-ascii?Q?zgrHpZR8b5nGaIM38ZYI9VhCcyKe+99qUBZh555Mvi7ZGmwJClvOgx4oVI00?=
 =?us-ascii?Q?h1SAs46cdk3GVPYZl1pVg3dkjsl9ofxJN189NXo0TEbdjSGTrYeqY8y+PZWp?=
 =?us-ascii?Q?pjEWYP9dAKiqIX6gxPE2IkFRdv2FdYAg7Zf/E4RWrIw6Ld9Rm5OvrXMXYgyA?=
 =?us-ascii?Q?TdFU0jSxwiuUcAkJ7tf+iH2ePtglbH44YYHjrcYzcR0T7TkCrabRyncW1yWS?=
 =?us-ascii?Q?iLGYsoq2QOPtsvrsXxv4GdR2xiTnGNP33jL6wPxljwhA+lrDnGGzcngR2/rU?=
 =?us-ascii?Q?7vrZ0vnWusubCizkV25/4ccrTxzINalno0sGsxdI4C+Wzb1+ezWaiS+JipGe?=
 =?us-ascii?Q?GWvbeAi8d3j5d3Pt+cgehLGVCcx1hcRIhwqNnfYT5cOgIPeCOvu8wySqH/Mh?=
 =?us-ascii?Q?QWDKh9tpgSr1oc2t9sIwvu+br92QLrDOV56GdqTipDxdKiZ5ld3rfOtktELe?=
 =?us-ascii?Q?jxeHaIjzNntlK0JBCHV8RMtopL9t2gji?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR07MB10492.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+tFyU4CDLkfUUU3arLQu/A+vW0gV55nAvcRZjjv7WoZXcwhcMC7JpmIhsf49?=
 =?us-ascii?Q?XnkCtKEVINYHP6U2rwZsMQjkAcMeI0DzZZkiayywWbUxR59Ylt2Etd2+3cQp?=
 =?us-ascii?Q?Qx8aoZVL5Y8kKUKTcvvuDtKXPlbUk+V+Yln7DBENsnl8GqdbYpWE6yxH3UnY?=
 =?us-ascii?Q?XBgx4SZ6FG8Cn3lyK3x/5i5I+lZ6QT1dsKQYR2Z8RMFPkbkSPAC2j+C+yCix?=
 =?us-ascii?Q?aeRBwjPlQC9z9wiZoetL4HVr2GaKUfrXS8+PuWMnpKsEhOArzHGkKC8vjtZT?=
 =?us-ascii?Q?3AaJN+OR26newoQsS6u/LTfAcVZA0P5YqdW7ZBfODzTirbIX4uSD3gLSb8Ur?=
 =?us-ascii?Q?pwLPVBiVNPq7G54yNTIzvAuM9UaIhkpZYsW117ZZ2CfLmU6582NW5gEazWZB?=
 =?us-ascii?Q?GOKkWAn6/j1DkIa272eWyDeRI0nhReaaL6w5u1OV+/iHgxvhTDLtBJRjj9OB?=
 =?us-ascii?Q?xdKP9Gxs8q/Xdq9//p6qUihNqDf2SoQ95QfzA8IHWMTwJ0En0BmiWHqPgSOz?=
 =?us-ascii?Q?C0sxSEtpMPuM4uU9e06VxVCthan4VmR396jyrlmTRcyBBbxoILnFk+HiQaIs?=
 =?us-ascii?Q?FXVxtkuGgAjyjIeokEH2rg1XgLrYUQYtQ8wVNavRy6pT4wc9R1Svf5oPODT6?=
 =?us-ascii?Q?BYGAyQRamgBYfoqP5oyEBfJ46JYGRkNYrLPSmEvXDXFqwKfpBxuQdmXV3Inz?=
 =?us-ascii?Q?kzZkh9fIuzUCD2kJZwUduvSkrgXrfqJNuxSJh2hujiR9rZG4f1PKQ/KKeplY?=
 =?us-ascii?Q?hneWUKY7if9HtdJhh6KBPO8PxpVV1Y38kbnPQeKuI9SYWgAUUg5WPOxRQHdU?=
 =?us-ascii?Q?UgmoV7i6jHXMBrFjkDDerAO80PElL9qDP/5XIpca1md+OdoT2tAvawHAoZSB?=
 =?us-ascii?Q?FdWObLLZhXUvhKHJeygivQJhcnnKzMKfxyRznCXki2BQI0988hB0CKEBuQGb?=
 =?us-ascii?Q?aOiP9sNbtz5Buy+ejUGeVnPn7iC2RmwcPMAJG5BdwaLzoxetzJR08O41C29+?=
 =?us-ascii?Q?sUzLfLE+ytDOaPiAIdPaUyMDHuwcUQDGVr4ZbpNMWsamZle8bVGP0FlS2vrA?=
 =?us-ascii?Q?HdJTotIdHkPivDIiSOkHZMgZJ/5xekxXpGjpH1uPU4ds6Jo0oPlVaFQ4LVsj?=
 =?us-ascii?Q?d/jh79nH2ls83HsheS4Vw1Ovnxt2BXFNesDK/QathPr9WFI0ugExYBuwwzs1?=
 =?us-ascii?Q?n2BfjGvRX18hsHz+9TW+/R38li3Oneqfp9Vqvri5tCWe60LVCuzKE7okD9lz?=
 =?us-ascii?Q?k29XwHH1xBrXhkNGFPGg3fCEvGrj1WFQtWTilddVCNLBGVbQm/PinwnktQkd?=
 =?us-ascii?Q?7oCZ+mzstjChladdKNSONXPSK7+YAcohTkEAn+a3mVi/K50PX94DBoIMOsxm?=
 =?us-ascii?Q?DIl9h0CvKdqJFjFsoBRa8tnVKtbWO/zAghruG+hYgB+bc9cfHQBF53R5kV5d?=
 =?us-ascii?Q?dR7b55HLaF8ThbEUPZGXqkQfZxPb6u3cgX/CoTSudmrOp3UCA4riQweuKzJ9?=
 =?us-ascii?Q?UKHDVS6gx+uZXEdbDpMrYRpZD04iML+BOh4fxE/7avDayw89lP6fBE7Kt8Xh?=
 =?us-ascii?Q?mMOE4AA5JFK76jqc0+OPgt/OAp4uR0V0Bw2OUW4L?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR07MB10492.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf96c5a5-e09c-49f1-b691-08dd6b4b6de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 03:16:26.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xo4RwFaal2lQHq29DZOt7UFWdr1EmlMAFk5ytD/VcUvQWXz8M0KlQ3mMLPyMfOIGrBIPZkHswRa6O3e/xFsy1iHzO1QLTwXAzcV22umKHHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR07MB10205
X-Proofpoint-GUID: CF6JfCQB881tLtTnyt26H4LLANxSBfbP
X-Proofpoint-ORIG-GUID: CF6JfCQB881tLtTnyt26H4LLANxSBfbP
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e2200d cx=c_pps a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=VM1riDuTR6mHfHIcB6QA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22 a=cvBusfyB2V15izCimMoJ:22
 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250021



>-----Original Message-----
>From: Krzysztof Kozlowski <krzk@kernel.org>
>Sent: Monday, March 24, 2025 9:29 PM
>To: Manikandan Karunakaran Pillai <mpillai@cadence.com>;
>lpieralisi@kernel.org; manivannan.sadhasivam@linaro.org;
>bhelgaas@google.com; kw@linux.com; robh@kernel.org;
>devicetree@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>Subject: Re: [PATCH 1/6] dt-bindings: pci: cadence: Add property "hpa" for=
 PCIe
>controllers
>
>EXTERNAL MAIL
>
>
>On 24/03/2025 10:08, Manikandan Karunakaran Pillai wrote:
>> Document the newly added property "hpa" for Cadence PCIe controllers
>> in Documentation/devicetree/bindings/pci/ for Root Port and Endpoint
>> configurations
>
>Drop the path, pointless.
Ok
>
>>
>
>Please run scripts/checkpatch.pl on the patches and fix reported warnings.
>After that, run also 'scripts/checkpatch.pl --strict' on the patches and
>(probably) fix more warnings. Some warnings can be ignored, especially fro=
m -
>-strict run, but the code here looks like it needs a fix. Feel free to get=
 in touch if
>the warning is not clear.
>

The scripts/checkpatch.pl has been run  with and without --strict. With the=
 --strict option
4 checks are generated on 1 patch(patch 0002 of the series), which can be i=
gnored. There are=20
no code fixes required for these checks. The rest of the 'scripts/checkpatc=
h.pl'=20
is clean.

><form letter>
>Please use scripts/get_maintainers.pl to get a list of necessary people an=
d lists
>to CC (and consider --no-git-fallback argument, so you will not CC people =
just
>because they made one commit years ago). It might happen, that command
>when run on an older kernel, gives you outdated entries. Therefore please =
be
>sure you base your patches on recent Linux kernel.

Ok

>
>Tools like b4 or scripts/get_maintainer.pl provide you proper list of peop=
le, so
>fix your workflow. Tools might also fail if you work on some ancient tree =
(don't,
>instead use mainline) or work on fork of kernel (don't, instead use mainli=
ne).
>Just use b4 and everything should be fine, although remember about `b4 pre=
p
>--auto-to-cc` if you added new patches to the patchset.
></form letter>
>
I used an earlier list generated. Will take care to generate the list on la=
test tree.

>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> ---
>>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml         | 4 ++++
>>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml       | 7 +++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> index 98651ab22103..4e839fa90b23 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>> @@ -24,6 +24,10 @@ properties:
>>        - const: reg
>>        - const: mem
>>
>> +  hpa:
>> +    description: If present PCI controller is high performance
>> + architecture
>
>compatible defines this.

Ok, Will delete this property and use compatible instead.=20

>
>> +    type: boolean
>> +
>>  required:
>>    - reg
>>    - reg-names
>> diff --git
>> a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> index a8190d9b100f..c219fe15c879 100644
>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>> @@ -9,8 +9,11 @@ title: Cadence PCIe host controller
>>  maintainers:
>>    - Tom Joseph <tjoseph@cadence.com>
>>
>> +select: false

>
>No clue what you wanted to achieve here, no explanation in commit msg and
>this makes not much sense.
>
Was done to remove compilation warnings. This is one of existing yaml files=
 and without any changes it is giving errors/warnings. I had to change the =
scripts 'dt-extract-example' to clear some of the errors(as shown below)
	(changed to raw mode)          root_node =3D re.search(r'^/\s*{', ex)
	---
	(existing code)                          root_node =3D re.search('^/\s*{',=
 ex)
The first time running a - 	=09
make ARCH=3Darm64 dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetr=
ee/bindings/pci/cdns,cdns-pcie-host.yaml fails,=20
a subsequent run passes.=20

>> +
>>  allOf:
>>    - $ref: cdns-pcie-host.yaml#
>> +  - $ref: cdns-pcie.yaml#
>
>Why?

The addition of these were to remove dt_binding_check errors.

>
>>
>>  properties:
>>    compatible:
>> @@ -24,6 +27,10 @@ properties:
>>        - const: reg
>>        - const: cfg
>>
>> +  hpa:
>
>Again, compatible defines this.
>
>Anyway, follow standard DT binding rules (see writing bindings, numerous t=
alks
>or guides).
>
>Best regards,
>Krzysztof

