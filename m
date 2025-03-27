Return-Path: <linux-pci+bounces-24827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC2BA72E52
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D3816B922
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4D20FAB2;
	Thu, 27 Mar 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iwBCVZW9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wLqLo8Kr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4120F096;
	Thu, 27 Mar 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073174; cv=fail; b=OIH0hklya4UP4nrIiLt+sdqRcvAcujPcFLEmqpW2u5CaJm99fIrMqCW+ZOSBzU5vo9m2UVY22rOhEnyaEX/D3INSEuyPKgv8dXw9q7fbb7JnYxtOHJlJ0M77ke4eeLgEEhyG3F0yN0qDwTJbPEc+dDoNyi91JrhMfKCHIQaRZfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073174; c=relaxed/simple;
	bh=fxyk7heuEWo1Re/k+7RNtHDG1WLLBNPlSBBlpZJdTjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEl100pPbCUB+nHmXTmCBgvoZcWtAML/esRz6XYMsQHOKzn7vzLEyoRqwZ146xSXqy/pr7uENWx1vesOMo6lE6TJrceu9tD9lfGXcIotu9eXCws3sCgDAC23/SVkjvvHcm53fERL8gGthQHkbB1Zm1/+O+3ILVTVDCd63mq84AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=iwBCVZW9; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=wLqLo8Kr; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7q1KZ021632;
	Thu, 27 Mar 2025 03:59:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=ER2IA8/6WrSz//76FSSSIv853Aa2TEKdpF7s4rQ3JNM=; b=iwBCVZW9Kkzn
	AFTOV7/5sQOQHtFaP0C1I8QH0hzQgub5V/RCXzq3IAPkc9r03iJ7QxNAFCR0TP3u
	KrfDJZTFfnNyJrg6YiqiIVMRslXMNHpwpECRxCAKLOyZdu2uW/k8W8lu8BARUV0K
	J5JlKrC8eMJPuXjhCowJEaMS5rFc1YPDU93O5aQbJKyWq4XhvtF7239+n7qhN4wT
	VvzNxYUDDSZ4m+WxMxlTB/wYXl3e6Ka/9KB3sSvWRW8gkGb8np+bYRWWtexFAAdn
	wjzMdqKiZBptfIl3I231JcXVEQVChJ1kINn4jp1lC4spn96R/NxYUFFvEVo5p6/e
	fVmJ+f1OWw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012050.outbound.protection.outlook.com [40.93.20.50])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrsx4wt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 03:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzpYp+2nXIMT2pYnRg8eoQcu0VUl+B5N/gTdFyOXYBxonfJvsMKt+unb95jQU2NuW2kRa9IHmOaEFPc+7ba+mX5Q3L9G+AM4qW4IQLdGaS/FYDnU0DgRZ2IdqpcwGX5d3BtBYr4sUsFYMy3Ch0Xvyml5b3WQoFOZPBKpYkomoScruZJ4e1Q4ut5oo9mTMnPJn2tr6cTeYdj68kcD3wgLxXUWG+9Tw9U0hft70Kl0nYcBZUlIIfhmlXXeO7zlYugmGbwsHPBOD3EKPDJvdZcb3M2W8AzboXojua2EPcum1GEKrgdciKqfIfq1eal5TrV1sWnLEOAYFfTjiIAlqr22pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER2IA8/6WrSz//76FSSSIv853Aa2TEKdpF7s4rQ3JNM=;
 b=JQduOXV8INkEEXkb0uFH1gxZnPZ+qkXIdoc8DuApqDE4KSkYWVy5V5RYOmLfNltwwvbyUAxouQPXpMXR0uSZ+k0L2bMbIULfk0rJDaCV0tDpB6YRrpfKsMr03ubn1zYt/wXKV0bd2pjRC2C/eAaM8moxUri5FtQCpYEuECqohbGqx3P8w2fPAPrvOfPsesmV1MOxmA4bCLHEGZZxx0VoW7Fb6YbAaQMVqJmEwJawk3Ci34rCzl6vCIW2w+Bztg0i+bnBW/XutOdBmnKzQF3nOMepSKBWnDbux065g+3xLG9xHqZsfSTAns7BVPCS7WtLRc/+7sk3eMlGcBEEe80Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER2IA8/6WrSz//76FSSSIv853Aa2TEKdpF7s4rQ3JNM=;
 b=wLqLo8KrSX/Qm7/XU8WILqKxuidSQjjRE5nyx3NWkk6XYl48Pze/Dwo/fRT0/swHS4aQ0N6lKacKJLatf9YFXP869h3GbJWe8Wdv14I05vfo+qn1JXVupJyrSGwhhmcBIi0RZbXsBMq3ucqvTGWHK+6RKHbDEu7um2WrGCmbCbo=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH3PR07MB10848.namprd07.prod.outlook.com
 (2603:10b6:610:219::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:59:08 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:59:08 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Manikandan
 Karunakaran Pillai <mpillai@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Enhance the PCIe controller driver 
Thread-Topic: [PATCH 0/7] Enhance the PCIe controller driver 
Thread-Index: AQHbnwasjE0SelmZSEibiI56xlER37OGz6YQ
Date: Thu, 27 Mar 2025 10:59:08 +0000
Message-ID:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250327105429.2947013-1-mpillai@cadence.com>
In-Reply-To: <20250327105429.2947013-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04MDQ0NzhiYi0wYWZhLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcODA0NDc4YmQtMGFmYS0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI2NDY2IiB0PSIxMzM4NzU0?=
 =?us-ascii?Q?Njc0Njg3MTQ1MTEiIGg9IlQ3S2FVOHBGb2pwU25ZaEFjcFcxcmMrYk4xUT0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBQVBzcHhDQjUvYkFRUU56ZjgvTUc1eUJBM04vejh3Ym5JSkFBQUFB?=
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
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH3PR07MB10848:EE_
x-ms-office365-filtering-correlation-id: 4d3d1885-2097-4ee3-52dc-08dd6d1e6641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iamXaTvsGyoloezQfDk/C6n5xLIMIA98Oy0r629eQzZxqS6CP0qEiDcvTFIL?=
 =?us-ascii?Q?YWuZhs9tkfFdvQVreefHYAqVxoCmH+xfWLsDmynXzcHRKCqCGjyy7eN8V3Cz?=
 =?us-ascii?Q?WZ0dLdnqGRdMbDGHdhb16MaVkY1FbjysQ+4V85JmQcLmJZtMinfxa/fHcJCv?=
 =?us-ascii?Q?QE1ONneH2o3C3B22T+kjR6+tC/gE12cN8pXhKl9Mm1+AJB5K2qvoTdNmqUwv?=
 =?us-ascii?Q?6Rw8yJVLyYIa5T+UVgbF7Q6zYfJTZ13HM9ozp83Ulcl3LVr7PFp6DXEuPRCT?=
 =?us-ascii?Q?i4107vcEcaxaALUnB3qqlq3Ig3UNYEZKEDAyrEVoMP+RbcrDzpfjah297PIT?=
 =?us-ascii?Q?bWj6U6BTmBxgC2Ec8IrGykrhhzZTPr1e7grxCOUbOA+XpEHB9rao5V9bDGAX?=
 =?us-ascii?Q?Ig1pEo2cHKxLM68OXP2EGdo7QBZLTzPHZgcJhYhLZHwf6/ol44MG5B+saOGX?=
 =?us-ascii?Q?XOKVpmYa4LP3B+bR0jSNpOD0hATjSu+/wJqu1KXpXqWwmcOWzuZfYH7fVUHJ?=
 =?us-ascii?Q?7oLQKBdW88WsQhO81HxSBkdpPXAaw9wdFbXiTJt36p7jICZMBmF+j8dPqlEK?=
 =?us-ascii?Q?F868kK/ezcAERhswXxxbXLEmt7wJpQmkmLlxkUoAFBZ6wxgyPn0ToHuYugT9?=
 =?us-ascii?Q?6P/TExb3E6Mw1rk2lhNo1Sm+gV/WZRByCSUaFfLklbly7CaPq83UBrut+12Z?=
 =?us-ascii?Q?aHW0VJDh2kTORg4y3YaqtRQIOdvLAo0eVxprqBAPtbMavUAjcIZ2uuS3pb1C?=
 =?us-ascii?Q?/Um1jXpXZc+bISON195BTDC4zt4ZWph6WXPb8MWPIbGojJ3+E72gQ8peJKRx?=
 =?us-ascii?Q?8umQWFMzBUSk9zLOQiUhywrFnaquVQnwq7iFA/HX0yxFeD4TtRLHiQ7IbD1A?=
 =?us-ascii?Q?js5QfnFolCbqPu8LRKjBeUbfEAC2r1bmlUvnJBnuKnRYtS6zaGgpyXD52BRV?=
 =?us-ascii?Q?Un1zlqW3C5tINlqlUd/wtUYfTyjf8NDw3gQ6EjO5+wP7Ps3PPJNmL8Udpw9J?=
 =?us-ascii?Q?iGNlg0LrIxomsO0rPGZ8oPadpw93XwjBCmdevS2Rv3BdkQiPLPialUDAquF2?=
 =?us-ascii?Q?jdjt/HivGe2JrvxWDOb32IA/fzkdmfsHWqsKFdPIbDhOVyqYXMZnSbSJnHez?=
 =?us-ascii?Q?m8xutPLB7NMOXcNRYb/Vsg4i04xX90knJHNOCYzGlZ3UzhN06mjFsU/M++hH?=
 =?us-ascii?Q?dClA/hLJB96hHoRBpXw6bcbDyX1+o6O9vgcbuQQOYlS5XoeUpsg0EXS8f6mo?=
 =?us-ascii?Q?KBPVCwPPBnYaPaebhEcNajTnS+GkmrjoS5TvbS49wZXI27VNoLdEGhDl62A7?=
 =?us-ascii?Q?ylm6YBxm++/ExX/kv0iAb4Hp08XE2//B5X+R+q/5CtlbaxESg1GNYVMbDxoH?=
 =?us-ascii?Q?lcvisEz9Copv5Fm1yOD4uDoDUXWftfOR7kE9b+D0UVH2hEu3tkvP1t292qbD?=
 =?us-ascii?Q?EHzH+kaKFZ2cQhGlBymV/e9d0aCuP0Df?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YiFwgCYxja1fY6baeCSRXZ5MEG37G13HMQ8S6OrdLDn/nDG8YSbnExX/tDYo?=
 =?us-ascii?Q?VQ7RjCIi0gBEm0PyGr9e3GOie8AnOoO2EHUbo7xBIfAc2a6DBIirRKPcUrln?=
 =?us-ascii?Q?1p0XtX49uj2Vdpm7Ps4E2ZBlTriq8pWpBNKefLElhudnz3eTuDAfJbqI0Ilc?=
 =?us-ascii?Q?VocfXdnXkbKA7BHnc0/kbtm+9HUG+KpU916aU/FNLWKjQyM9i/6Cyv4RniFF?=
 =?us-ascii?Q?3wvq+4QVRtNEmiynacOT4/GeKvi1z8I6RqRJFgSS2sQxrpa//RKZQNuIQ1SJ?=
 =?us-ascii?Q?hRMy2sZoxBDxE/zgzpfVklvHEDNCNXeGOlmjuYqrfeHE4UXy1JZ/xMKPS5Va?=
 =?us-ascii?Q?yO6FGbqkLCR6UXV11r6kNmJhv7SqCqJSvFo+B7E1bjiTxuN52/1jA50Xr26Y?=
 =?us-ascii?Q?BF/Aeqi5d0vAPL8bXgZn3kq47Dl7Vj1nWoFX5vu/j68DUqBXALF5JyF4Oa1T?=
 =?us-ascii?Q?erLcE8XpndS15w1rJ7cmA9hrgBGgfUAiGTh0lmZlBLvsD2BCH9fS0Mw2RFIR?=
 =?us-ascii?Q?zos4KwiBuyj88KtApAoDgL7LCR+l+RrNX7hpA16NQcYJMtURO7hmI6bpCOUk?=
 =?us-ascii?Q?OeyHZKCMRPa92G8Lrky9S1NI5J7x8j32GMb4uv4vQ8sIpbTEebAjmbE3+z1N?=
 =?us-ascii?Q?Hrqdg0Uxo+eWRXo/T5qAiA8ZSAb6w64TazKtL175fNLQHkq154uTAUn4yGwO?=
 =?us-ascii?Q?XeDBv5YqxEiw9dgmNwUrV8yafsxJWPaNaxiAjdzAmUkpRlDgZNCU7FBMS4Y4?=
 =?us-ascii?Q?TegKmyRpTQDDdzfGKkGCtKCCEmpnpm9jA8yIe049s/bzfJ3T2BHeWPRfTpf9?=
 =?us-ascii?Q?NljYq+rX3SFQdYAW8hMVhn5G8DuGTeiPPwfReNj1Zt4Sn0X+MRSGIJVKWFJY?=
 =?us-ascii?Q?EGIki0zzjMA+WweNQ1fT2omMw0fpSMcEG4xfuGd9H2tHCIP6XM+ZQyn8SYA2?=
 =?us-ascii?Q?Wo3/VAnm3A0T+hTMD4N29mqkpT05Ma5D30rOeiqjIAMxaAoS1ryciiQpw+I0?=
 =?us-ascii?Q?evb/ohwLtDOat/vRnt7G6safctU/GPbhu5deei3rjjSOzWgiH+ZAeuPcXAwK?=
 =?us-ascii?Q?KUxkzd5zlsWurfq7jBafq8SFGeKSM12xCgjtuR/wF+h90iagn13DXkRxk/yU?=
 =?us-ascii?Q?pSX9m/7mdP0RosupwYsB7y+HveIbjAcC26MiJakwSlFCxhUtO+0S3Q4GGhF2?=
 =?us-ascii?Q?UC+Fxb6xVhgtPRoTw9WxFVVVPBm/e1sAEDbYcEKzTiZN7+E++jlNm4tWVTQo?=
 =?us-ascii?Q?SkE1G/PappwTvDJGI4mXdb9oKjtP7MKfoq8x+q9lpIC2Kx81sNUcPYht0j9a?=
 =?us-ascii?Q?E7ZKsNC+oAVbkbrT02foM3dIsH4GHt+ahT8ulIGot9iDz5lrVqE+j5Xopyqm?=
 =?us-ascii?Q?TDjhYpFSbesNnPFUl70C5GMwizOdHELsPazWfiUdveeLldjIGH0ML2AyE1Vq?=
 =?us-ascii?Q?CXeXXgg+rRKwNldw8YGKbYTKGq7NlYYYSCmwDtvri7ln9ocwFhJWGtXqlmXi?=
 =?us-ascii?Q?cjF1v4a9DCHkZ5DZ8+3xCHFSXM5Y1WSxHRDS564xR7R3UoJ8giIc/4Xv5UsJ?=
 =?us-ascii?Q?b+rV5nmHr/yzGmmYgITMl2o4js75hdcku3bw5YTv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3d1885-2097-4ee3-52dc-08dd6d1e6641
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:59:08.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNjhs+wtgNWG5NUBx9PQjnTnaoae4JblJOnyp5JdpiGlx/3tho03juEuu4s3SLLrNNV7IVs7WEctoValvLxUEM3YohDWVATW2jhKzMrXm2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR07MB10848
X-Proofpoint-GUID: LOFiI6h8ynODg77fsOiWoZCPrAkc-saY
X-Proofpoint-ORIG-GUID: LOFiI6h8ynODg77fsOiWoZCPrAkc-saY
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e52f7f cx=c_pps a=Al84TKQ7ImdPUwhB59KusQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=jlRnNx3M3tNpWZo0hxoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270074

Enhances the exiting Cadence PCIe controller drivers to support second
generation PCIe controller also referred as HPA(High Performance
Architecture) controllers.

The patch set enhances the Cadence PCIe driver for the new high
performance architecture changes. The "compatible" property in DTS
is added with  more strings to support the new platform architecture
and the register maps that change with it. The driver read register
and write register functions take the updated offset stored from the
platform driver to access the registers. The driver now supports
the legacy and HPA architecture, with the legacy code being changed=20
minimal. The TI SoC continues to be supported with the changes=20
incorporated. The changes are also in tune with how multiple platforms
are supported in related drivers.

Patch 1/7 - DTS related changes for property "compatible"
Patch 2/7 - Updates the header file with relevant register offsets and
            bit definitions
Patch 3/7 - Platform related code changes
Patch 4/7 - PCIe EP related code changes
Patch 5/7 - Header file is updated with register offsets and updated
            read and write register functions
Patch 6/7 - Support for multiple arch by using registered callbacks
Patch 7/7 - TIJ72X board is updated to use the new approach

Comments from the earlier patch submission on the same enhancements are
taken into consideration. The previous submitted patch links is
https://lore.kernel.org/lkml/CH2PPF4D26F8E1C205166209F012D4F3A81A2A42@CH2PP=
F4D26F8E1C.namprd07.prod.outlook.com/

The scripts/checkpatch.pl has been run on the patches with and without=20
--strict. With the --strict option, 4 checks are generated on 1 patch
(patch 0002 of the series), which can be ignored. There are no code=20
fixes required for these checks. The rest of the 'scripts/checkpatch.pl'
is clean.

The changes are tested on TI platforms. The legacy controller changes are
tested on an TI J7200 EVM and HPA changes are planned for on an FPGA=20
platform available within Cadence.

Manikandan K Pillai (7):
  dt-bindings: pci: cadence: Extend compatible for new platform
    configurations
  PCI: cadence: Add header support for PCIe next generation controllers
  PCI: cadence: Add platform related architecture and register
    information
  PCI: cadence: Add support for PCIe Endpoint HPA controllers
  PCI: cadence: Update the PCIe controller register address offsets
  PCI: cadence: Add callback functions for Root Port and EP controller
  PCI: cadence: Update support for TI J721e boards

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++-
 drivers/pci/controller/cadence/pci-j721e.c    |   8 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 184 +++++++--
 .../controller/cadence/pcie-cadence-host.c    | 264 ++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    | 145 +++++++
 drivers/pci/controller/cadence/pcie-cadence.c | 217 +++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h | 380 +++++++++++++++++-
 8 files changed, 1259 insertions(+), 70 deletions(-)

--=20
2.27.0


