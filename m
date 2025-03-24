Return-Path: <linux-pci+bounces-24509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB218A6D795
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67EA67A54DA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596031A5B84;
	Mon, 24 Mar 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ObfCQucD";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LR/bfUat"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0325D554;
	Mon, 24 Mar 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809010; cv=fail; b=A6dDyj6Cgu3kmFtIg4Zc+3QSV2G3uESm/1OaokurT5IegKAFgoAq0ucbJ8/WBe5OlwV+awGYJCn8cAY6I0yz+L4wJ3/jKLUhyjnjufKaZltB3m53K2sfsy9NPLCUBrEXVGZiw2tLqwmuaU+660R5aBuq5JL2mO1OOBUimbZjfKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809010; c=relaxed/simple;
	bh=8LLMQx58wLfXMuInW3H2ITjQyZv8C2KWECCSkkHwM7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rk3Frd+AimtWZD0pQZPDVVwbCpgnEfTTi9DlqypnIxf+qt9w6virsZjLM64n6BYPc+wbC8PQZlFZXd98o9CnLueNcFnfzhK+AiyLCOFcKpYE8fYjxND8/xbXISedn04/YunKNauJQziOqcHubiXgb6hoavhYGygy/QRcC7bkHKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ObfCQucD; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=LR/bfUat; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKxX1v020026;
	Mon, 24 Mar 2025 02:09:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=1cM57l32c2Qk0h7ValGMKdK1FrmVe3lkPvMS1BagdeU=; b=ObfCQucDV4sw
	7Tgga4FWvuRpYz/Y58s/ijOf69uHLuW4QroHGw5I31v2qDFnvcKjlCrybhyEQoHt
	Q85PW7nWCtLrZsaJQJ5Ec93ZGuKtvkx57CmHu4IUCoUw9mVxicfkYtF2djIkOLrX
	w48Sq9ULz29zSt4wwPTOkhaPGCS6gKEzlM9nHqc75bJmhI+J0QtIv426D2dCN1wk
	5llzwot/RcOG0qTuDd+dSDgDhrBxKadU5ivWVIFtwiPVyjvuQW3jOqRxSzHlPq8u
	JXzxSGCmNfCkYfpPuszwa/7eYaX23M1qiN7qzAu9+zLS8yVMCE+yh2iYL3JO2t3P
	WpGmOjdR3w==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrswn108-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOD+nbv8XKRPo3xqObNK473V98zthYyFYnOjDaaWuQlH8s8DGJ6F2UEytVGoaSEAkPwTAHZNstg7LJXUbrb7rlcsG24u1VCtaxLQU1aXIR+Eqlok+VSDNn35tnzCRLm/J7/1nEe94bz8pINH6z9wdySFCUi1e7DJG9U/vY5upW7gGxM9isMeIEd0dK9cwIUeWnnTZDtXk/r5BUWcXDzT9CW5rkyN8obzgGslSJRsz0YzGT+X/dOo0OxOihSzKzWw9rDUc5iRqiKZl0Nwffa62tnH/9asNf4BX/cOo9xTzNDAK4lBdMYcU1ECsFfedLxdxvJ1BoTLd1dV4t0RYwScXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cM57l32c2Qk0h7ValGMKdK1FrmVe3lkPvMS1BagdeU=;
 b=PJEJdADWs+fz3aIuDPz8l4+Yas2y2atH55wHP+XfUom90bqWFGmjikeO77LLbUf3lrtWfPZxiOiOFvKUmZ2JvpSq0CL8UkEf/GVCK6CVaTjOpmMPUSW/o543+iTei3oSD5zXgqfSyUQXubrmuCKP2eRxA2pmSBGpInbsrpz4MHC1VrOI/EnMWTF8pxC2ZaVhhe/QQpSPyNrJuzISAyeNeBwa2OtOFdkfMqtTbNCnkPLt45qhUKSR/AX2kdEiiLOdMyT398JSE+GcBRy5cOP1KL75/MVo7egFNaGJ3kdeKw55KS554dD2OleYLSIACrGE7jBAOfKNOne8CNtTPsL+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cM57l32c2Qk0h7ValGMKdK1FrmVe3lkPvMS1BagdeU=;
 b=LR/bfUatqNsJzrgRK04+KVpi07v3YN0aC+xil4LU6TgEgOf8SNHOA9VFtDWR9BFThp48O2O6A/DQKzrJW+BjSgLaGXLSI1DNespxKTOSKeCx9Hb8N7im6vv5bSFN/BUZs3/kbc8TRU8WKRPWo1BchYS3GFENTHaZybyt993QWeE=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:09:25 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:09:25 +0000
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
Subject: [PATCH 3/6] PCI: cadence: Add architecture information for PCIe
 controller
Thread-Topic: [PATCH 3/6] PCI: cadence: Add architecture information for PCIe
 controller
Thread-Index: AQHbnJYkkvUSMEJCnUyTa3FMuTXuLbOB/bxw
Date: Mon, 24 Mar 2025 09:09:24 +0000
Message-ID:
 <CH2PPF4D26F8E1C0E6114F6916AC384AEDAA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082409.2566181-1-mpillai@cadence.com>
In-Reply-To: <20250324082409.2566181-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hY2NmNzMyYi0wODhmLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYWNjZjczMmQtMDg4Zi0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIzNTg4IiB0PSIxMzM4NzI4?=
 =?us-ascii?Q?MDk2MzExMDc0OTkiIGg9IklaYmNuQzV4RHpvc3FSdnJCRktuVzlXVnRRYz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBQ3JTU1Z2bkp6YkFSUXhjY01nNEhkd0ZERnh3eURnZDNBSkFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRmdBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSklCQUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQWNnRUFBQWtBQUFBc0FBQUFBQUFBQUdNQVpBQnVBRjhBZGdCb0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUNRQUFBQVdBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFHTUFhQUFBQUNZQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUpnQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQWtBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQXVBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElBWVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH7PR07MB11228:EE_
x-ms-office365-filtering-correlation-id: 8fc8ecb8-79fa-488a-9a1a-08dd6ab392c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WzTJSLONkgWMt4u/sBuWzhqLDWHrVStoKYx5KeZ0sFFSEZBH1SZpsS470nbT?=
 =?us-ascii?Q?bB5QQywn9svs+tVTZdvhqqn3ZpP/Hm81bdWgenmNsVihqD5SVWcJxmg2YDuY?=
 =?us-ascii?Q?CdQ8t51J9YBqxQb5lqa/1uT5ylUXCzOUAXVGOS2sJO0Fr/uM6zVg4YRcqPCY?=
 =?us-ascii?Q?doEVqN8QZcC4wZwpKAcnTmnW9n6rUaxBt3PE8TZRqKsGDbMhcR7OeFJsj4uP?=
 =?us-ascii?Q?sTj/MdpOJEigoUO3BsF5KNothN+kC3/hoKDIttpo0IdSj+l8TjP42NhWGK1F?=
 =?us-ascii?Q?lvfrX4LVRrFlg1SvXnlQkzcM5/AxMcy+oSsdtSrp0UPQqUiidJgimqs8Xpui?=
 =?us-ascii?Q?KzqerZ2TwgLqcBw5fwghKgO6M8AIwN1pQKf5MqJQS23WZ7YMTpwfrBDnFNRC?=
 =?us-ascii?Q?gqff9vel4l6Oo1M2eu8x6kdlu56tImUXddg66MvLVJQKlqKFU872KXvIg+mH?=
 =?us-ascii?Q?oFMo8xHOKzuPz3inXXrxEWakzMxAY+WakSnykCCzhKJ8ivWRxcNoXFAHnkav?=
 =?us-ascii?Q?8CDNsnIACe1Yk1QcXJ+EpR++ttTB++BW2t7P4feeesnrguoitjc3av3pNXiE?=
 =?us-ascii?Q?XTc4PXkQe3/uUl5tqNiCe9ot6XUNNdx0YvYC5lDYtzH/c5LmkOvzWeJa7uFF?=
 =?us-ascii?Q?a1UyAz05UfdHOeVoPdZIni5HI5f9oil9/YyXkCkEjY7atU7k4vNSs88LxqyW?=
 =?us-ascii?Q?KEdvE+4RK/y9velVZynlYHcTQqGcz0z4MPoVZERGlItvIkuobHx8ZFbfKqiS?=
 =?us-ascii?Q?LDv0ZMneJHGNFdj+A540gboxrOm4B/eYb0YCZYmZEAmD0w6ZJtMRe+ZRanPB?=
 =?us-ascii?Q?kC1hRU25bpQB0fCIJ58VBQrsofJ38az2KiGfNP6vHUoJhrRVmug0pkXJg1Fk?=
 =?us-ascii?Q?ck5fS/5PwZ5o2WZPSxwNvovprUoA+Fkflbb9gxO5gsvbFWn0l+wd3Phsq7uW?=
 =?us-ascii?Q?y3/EH8a0oVqRe79fOrj039sJsyYsLoPze9G8EyGHEO+NeApyCcPNA0rcLm2w?=
 =?us-ascii?Q?BHP/oeichaezN101ublaomtAuS0Bo+OLKNc20Xg6cZ6x3JUDJrZy7Fq4h1Rw?=
 =?us-ascii?Q?8Hyi/en26tnwoezFsB/TOdJ8Zzuqm15mIg4sakdAIONeo78qxxKGRU40VrH8?=
 =?us-ascii?Q?8AQmM6oSv9JjcBxfBXFzDtJHfSACGvxvV9yqxZBWbtaJS9YZrDhR5ezn8nXw?=
 =?us-ascii?Q?elKbHy3s7sx+XXNPGYRIRrBb1sRefykrslvkiics0pOsOSrD6HYWTP12GxT3?=
 =?us-ascii?Q?M/ac5gFmPScFhCJ9f8g+dXnheiY6aUIllhk6AmON0iBlBPQ6YS40RpskBlN3?=
 =?us-ascii?Q?bKlo5s/02vHZnuYiJPjpeM8Wa8lXap+2JGkw1c+V84T85eNfC1NuM/KkWqNi?=
 =?us-ascii?Q?lNKDmh67Ia/ICvUbsrNrESqXilAQzOGZK9Q6HGy+T2ZFeyxHQki3M5+7+YlZ?=
 =?us-ascii?Q?KblRe552TegeWKcjEI42FiLZ64ipiNy6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RM/zzTf5JdvQB2bySL6wdCy4hH73qAyoo0eRk68bWm39LnD8ZiNCPM9KrhUJ?=
 =?us-ascii?Q?eseyKUSf0JLKR/cxkDo5m9UpMlejsnIjW6Wkm7lwpkd+fnFVwQAvI85B0kd6?=
 =?us-ascii?Q?THHZ/oTmfIVKnE3zy0VfAoTVSQ03r9DTmiaEHzeEXEyZG1WxrIdweZJHBMEu?=
 =?us-ascii?Q?7hoNpAL4pZC8IQAtxy93KDq6skgzAhpqT9ipYEWpAahbWLhEsDIi+9z8Cl43?=
 =?us-ascii?Q?jDAm/nbtRUJ2bq0kRAUIdvJmlRkBCto7hzs8aNnl5GRXIavikmJrSS+ZREDX?=
 =?us-ascii?Q?BIXaAe0XYZXjRHE/c5h+f/5TTcPMzrAhjMbGq/f9I3aEiQ4+BmmPa3xZrDxW?=
 =?us-ascii?Q?Q4lX20Ptsov0/JuYCpqhSRYdUFD0OTdVAvyvMmrujek87PobnKT8l2VGXRDT?=
 =?us-ascii?Q?khnF4YxT7vTnD81u6vaGHNRoItZmBt/kHOWbB9bfGhcchEeNrvGa8mXYc/O4?=
 =?us-ascii?Q?oKaDwNLQ7OMCTVGW74elKOJDoWpnfelANbkfCdx5nvhTeYk7rauoUa/IPioj?=
 =?us-ascii?Q?EFZ0g7MyZrW9SWikzZui6lv1upvKokphQ/2jzipbur2Ta6DmGiNCJVjTDENn?=
 =?us-ascii?Q?izNK8H3ngYpa0laui95LmgRruHfKh3npA/ThzWb9acMrO6pUvoU2WG3EDVEP?=
 =?us-ascii?Q?bM3rooqHo8m1vA2tZdBHwUN0FFQiDs4vhzCaA/5mQdYc+Kl3ZnTnzS6Yba14?=
 =?us-ascii?Q?iEi4b8EbfbjFOODecGKDvkHlizMarsxlTWtHn1McKh1wamdf53fMAdU5HSxv?=
 =?us-ascii?Q?NotDiyNvdf5cqt18AnnnX9GmYPFeZSCRRd+tax9R9vQZyBdu2V5i40OFSR0t?=
 =?us-ascii?Q?X7C1moPxt4MrkhKGixk+TTQe2u6DdlKf+sqJUBYW4QXCZGXHxPxotZSezwT9?=
 =?us-ascii?Q?ZvQzdYHQjkr3W3lTKK/GK2XpdpfRphVGYegfbAcR/+B8Jw132iL7DE0z7mlY?=
 =?us-ascii?Q?vpUYyfB9skPg5UcdhTPPC24WGW4nkYmF4LErQGsSDw6770Jph925RZu22W4p?=
 =?us-ascii?Q?jn06tijKl1dICvH7MbkBZj/2MLWGZvJxoDCUjHqaaLFjJqFxl2g+CPqRPJGe?=
 =?us-ascii?Q?bOPCRBP1r68Y5LthodKUW2Bb1c3Lx61mxhk6fx3YupoR/618OBOzzS1qQpxC?=
 =?us-ascii?Q?LP6zKOBZ3+eKzacIej3KPI6NVIForDFnETAWxzrI5Jdb/AfaxrNtITVahqAt?=
 =?us-ascii?Q?PWBeFm9k6MKZATTC2j+GzNBdM5hpGEsTi/05PrS9I3BbSzlI9JcF7kYfoEze?=
 =?us-ascii?Q?rCKactyIMPf1Tyk1yX2HpUs9QFf57Z2Ied9E035HmgszvZWWp6OSYL7EmHZX?=
 =?us-ascii?Q?CZIjETegprtzZEBbsku9EyvoMDHivi6L+a4U/+cmuvJel14CYCDM8VW7mIBs?=
 =?us-ascii?Q?HrAHVITMhmttjHzIeAF7TaSMOMyN09NxXGwcm4RC8Pfd1Tqj3r//DjjUeFBA?=
 =?us-ascii?Q?/+XpqaKcBPGj5Kwn5ieSK9gIGcv9MpDfWC0OiXf8nujBhrPg6zw2/Zrcy+X8?=
 =?us-ascii?Q?wVIOsah2kQNfCObKv0MaHjMPlHhRGqf2ZudBr2n4qn2Sa6wNcz78YlNOo7WC?=
 =?us-ascii?Q?vv75gldYe1RI/pLNlJ1VloSDWxhOpvWAPTUiq2Hi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc8ecb8-79fa-488a-9a1a-08dd6ab392c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:09:24.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWrjMCXxRNwV0YkTTxWxIbs4ck2tYGmsiRPoozj63eTXJl9ubuYRVYJjQWc4+yNI/w+xe9nSjBdPrvRl0YcyUjaUKZb2NNmYxQnmp7QI7K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Proofpoint-GUID: gpXZigOn2XZ2c_ZQ-b8baBDD66ig7Hlo
X-Proofpoint-ORIG-GUID: gpXZigOn2XZ2c_ZQ-b8baBDD66ig7Hlo
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e12146 cx=c_pps a=tJhdH1fDB3NOBSro6qvwmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=RL30f-D3pFWFbXPyOgcA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240066

Add "is_hpa" boolean varirable to struct cdns_pcie, to support presence
or absence of next generation - HPA(High performance architecture) PCIe
controllers

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..98ffd184be93 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -42,11 +42,13 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
 	const struct cdns_plat_pcie_of_data *data;
 	struct cdns_plat_pcie *cdns_plat_pcie;
 	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 	int phy_count;
 	bool is_rc;
+	bool is_hpa;
 	int ret;
=20
 	data =3D of_device_get_match_data(dev);
@@ -55,6 +57,8 @@ static int cdns_plat_pcie_probe(struct platform_device *p=
dev)
=20
 	is_rc =3D data->is_rc;
=20
+	is_hpa =3D of_property_read_bool(np, "hpa");
+
 	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
 	cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL)=
;
 	if (!cdns_plat_pcie)
@@ -72,6 +76,7 @@ static int cdns_plat_pcie_probe(struct platform_device *p=
dev)
 		rc =3D pci_host_bridge_priv(bridge);
 		rc->pcie.dev =3D dev;
 		rc->pcie.ops =3D &cdns_plat_ops;
+		rc->pcie.is_hpa =3D is_hpa;
 		cdns_plat_pcie->pcie =3D &rc->pcie;
=20
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
--=20
2.27.0


