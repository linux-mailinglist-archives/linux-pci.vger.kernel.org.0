Return-Path: <linux-pci+bounces-24842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4CA730B0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B443BED49
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F282135A2;
	Thu, 27 Mar 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ccmIJToo";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="FB4uzqM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE117A2F8;
	Thu, 27 Mar 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075835; cv=fail; b=Eve4Pf85qOjKuZl4o6dfmTmmSmM54L08cda+PPEAYShJguBlVUvy5QCyJ6CX18NUXoGnLIi4U0HbdnBLcjjCImsoPJWRAY4GmYbC1trVn1dWF76FRiOEoZFeBQYO75H9M7u2WRkH5KDje9OfGV1LRTUcYlsjRPzxV/uedaJ9P50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075835; c=relaxed/simple;
	bh=9yocXLkOMtExPwYkJku2iqD6tkb4UwgoqSEtwAvIvbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VuNPilaRBfgXLurmtJSwbUZtG+ASDzHyi6jyZUL5SKf8oJ9dRYL2flPl1O8SiX+MFpkKUO6Wjv9/wBpR8WPfpFb0XSzDs/nnLL2H9JmZ35jbiEzT1daf7bZFF8V12BscNzlr5qu7gBlgq/9nCOFu4ivQGbyBn5/+NhWRcGuVYVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ccmIJToo; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=FB4uzqM2; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7kx6D031554;
	Thu, 27 Mar 2025 04:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=0WZazG3Xfek7l+64ofbe+tx7G72DGb7XlfbCqXckk7s=; b=ccmIJToouPD7
	s5u0H3qo6S6gDiwmODavPpDXXAiCwnp30CKVh7Xt2zqD+pibgDvn84IIRUvgqsck
	Oi0EJlV8Ptk6/qNSWWXTjAjKTeCxxiywhmCC8CxiCc3fAIwvrlc1ztcG4hsMdYPo
	nlTViXoMikjJbf0UNeLchh/SKq4Tkjq7YdnLIlXrFtnk2+dv2PlZ5quuH1egcC9Z
	hKWMI+HtFDPJAnXBzd6qulzPAPw8DWQY5/VcL0v90dLpBflWf4Tp7y0vGSZnFXZn
	mgvf1hbqEo06i81jiYdjnlZvHPISmhX356aMa3NrXrY41NcrS6/O2R9BJQHrs6g8
	rWCaMD2r0Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrwmy4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw9OBmigIhicRkVJwf+CZjG+w928sz9lxx0aauPLiL91kmCEVkt3Z8wm2svOv4CxdMNcnrN6LNxN+Psa1buEagx6I7GoSFZ99AzVrVSyTuwQ4D/aoGS/+HCfWTYxSr+NXhyiwXRf+Ulk5EYsA4h9IeM0o9ds5n8ACehW6lxeGuQ5jieKsDqAy9dJVdc+w4AH7S1uL7Zzn5juz+YremwwJC6dDf49DXDx5Erz28xV2rEapjwIxEMaWTlJz9nh09Im8MOh3pIkEKfAV4Bb4YHGkK+spk8Mxo+zwbLsfGYhFqkLImjz+f40wkp4oz1CR90uqDoq4Tn/GpX6Z38w2zkzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WZazG3Xfek7l+64ofbe+tx7G72DGb7XlfbCqXckk7s=;
 b=LzC6xc0cQ1SLHw9HxPRUU3K1i50lSRaqUveBKk/7sgjkAGRSb24JOpvdXj0WvS5D74mj0/YTwX/ODt1N6v9NaTHvMU3DvoMr1SLbI4Bt66/BR7INosa2F33teJube5FI3SUWKdbKaAdxWJAJRM7H8YMBQQjwVgRwqykxM4oI0z3HtLGV7KFFKP8QKe9Q0U6nv0tP3E1kEESg4B2wcW2DI/O/8Fs7sDStkgI+6b/xpxDEG5byjrpopTwnhIyHfc1QSWqYTOnx4BW8fJwPgWs6je0yGVLq/P/OvUlkkpXGeZjhDFYqS5qAfns4w2RDaN78oR+ipsqaz7QHw7tHrhqM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WZazG3Xfek7l+64ofbe+tx7G72DGb7XlfbCqXckk7s=;
 b=FB4uzqM2IzSM/iMXJuBuu2EainupABWNvRvm4sr7nPCfSiHWHw3mqAibda9J2/J/W+/P8/cH3DCxBM6zbHDIC0lQSXVsCwJNFuhUwwJMomRqLH48iZML9xegXFPi7pU5yrT47DagcqjVrdiu1kMM4y1gnz492StqeBxIvRi/4NI=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH4PR07MB10924.namprd07.prod.outlook.com
 (2603:10b6:610:23f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:43:41 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:43:41 +0000
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
Subject: [PATCH 7/7] PCI: cadence: Update support for TI J721e boards
Thread-Topic: [PATCH 7/7] PCI: cadence: Update support for TI J721e boards
Thread-Index: AQHbnwk1V/YSo3TDikuH7mSsH9PZV7OG3JUA
Date: Thu, 27 Mar 2025 11:43:41 +0000
Message-ID:
 <CH2PPF4D26F8E1CB9C8CAE52EEB91E3CD08A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111256.2948250-1-mpillai@cadence.com>
In-Reply-To: <20250327111256.2948250-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iOTRkYjk0Yi0wYjAwLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYjk0ZGI5NGQtMGIwMC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIyNzY0IiB0PSIxMzM4NzU0?=
 =?us-ascii?Q?OTQxOTU0MjU5MjUiIGg9ImdUK2djOHNSVDl4TGk0dHJLOXpWNXl6RUp0dz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBQ0Y4cVY3RFovYkFkQldBdnZhN0dZOTBGWUMrOXJzWmowSkFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSklCQUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQWNnRUFBQWtBQUFBc0FBQUFBQUFBQUdNQVpBQnVBRjhBZGdCb0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUNRQUFBQUJBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFHTUFhQUFBQUNZQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUpnQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQWtBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQXVBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElBWVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH4PR07MB10924:EE_
x-ms-office365-filtering-correlation-id: cc09ce9e-7889-4f78-44d6-08dd6d249f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UxQ5JS9Fm83it+v19ubJYetLFNSXKtx34DQ09SznImv/ZEhMbgTZhmVvJ32h?=
 =?us-ascii?Q?e4j/pwKdtkbErekTXgGx2dvUsXkHi0JWBtDmab1xGgpIeGKuXC8TL8EIDynR?=
 =?us-ascii?Q?x/gZ9GE/ZorKzOCuLMmCIyMsCfSOVmfllIOWy+om/DkIP0suF48VNSetLttA?=
 =?us-ascii?Q?Zy4K6YvjxyWmFXOtPFcOtfJHykBqqqvWpPQ0+t3ajx2SA+z+0dkowJrWtCt1?=
 =?us-ascii?Q?DxJDeu7HscqUPpBNG68ekTGvtF42cYXxsOkpcNwaIFWHeay2BO5wkoSKMicR?=
 =?us-ascii?Q?W+1chML+N+AvRMb9Nr+8vvS5WVinpED+EnrPN+PKDCuH7TkDgF9v+3D82Pae?=
 =?us-ascii?Q?oIpRy+vHKFJRHZqj7eJ0Wkf3sN7baXaI6VXxNvZAwRvOWU0LLpddZPyQjYmk?=
 =?us-ascii?Q?aKHGDvsGsa33VXRetHWi0t6hv6/n6TvoLUB4SW7px/EDSy54+c6l2gUcOqBK?=
 =?us-ascii?Q?rvmqaaBMyH4tN5XfzbuJToGDZ9UueiO1Mun20qdu9kKP0pf8JhL4bgbJv1Sn?=
 =?us-ascii?Q?Cp69rAQ13aSbmB2hgRiBURYVofVxDnRG6tnAFrapxC0A/esZ13kmaH7ZUDH0?=
 =?us-ascii?Q?1yull/lJ22ZgC5/iwfBRIrqJBjg1nMBvwns6riZdYAvqEtzgzX9bXMLjU1wJ?=
 =?us-ascii?Q?ro7WxdiNk6s6TvI8gWlrj/6uAY3tSaU3w46MS8OV2EFXAmrJVfPiSQf9MVfv?=
 =?us-ascii?Q?P0xd/5Sk57STFrdQDdbMUD/JH+TTMv0yix/r9cCPe+3o6tQItlSmNqW8MpDH?=
 =?us-ascii?Q?VlcMfwt3Jgl5Mb8eT9xRTjcDQcUuQ6wbH4fzqg9XsuxE713TAaYY6S5crOBy?=
 =?us-ascii?Q?+Ap1BRkz2A4A0e7JWnjzE+wltgDjtYVY462L+LM5UrenCTnD96uA6EndhuQ+?=
 =?us-ascii?Q?xn6CdKnQnk7QwPtYn2JRkns5tyIOlZsJi2ypdmAqVxpiCagdPW4oeHrRcDfM?=
 =?us-ascii?Q?zkKk9IbKHxegQKtFH5A5XPsU0EsACe+YPEo+yGjevrHAiin3Qex8KBIrJT5w?=
 =?us-ascii?Q?A8Wk3fgHWdC3jShLVxnFdTzOM+nTB2VBc+PqO1MzYLGvUHdNNhlMaM/FA96Q?=
 =?us-ascii?Q?+4bBgCeL7MeLOqDvIUdGjmcv3/Bc0wBTl+3Y3MbYaTYgDe5Z+VuHdShBD3FP?=
 =?us-ascii?Q?KqF53nJ+maF//d+bnZDGmuvPMKv9anJAVKxyCi5XruFZnmBXBqauH49tZF2y?=
 =?us-ascii?Q?bySp+6+fCcX0vPdPDHEtfJlR2QRFC7hWgM+p/FIv4rrp/y8hGEklL32qT3fx?=
 =?us-ascii?Q?1yl0Cowsn0tP27sLYiO2RM95twO1Pxk5Huxdz7qGZqD8CfIH0yPwz8M/BuFL?=
 =?us-ascii?Q?pTSfGdI1dsA0bL1TQDT+8zWSjRvYfREw3t99V1H26FKmy104ZpWLivxLfZCO?=
 =?us-ascii?Q?iQP6+CJplzkB3dVzZ9n28jVOQr1GFvY14rga1PpeummFQMK88hppe7r58f/O?=
 =?us-ascii?Q?eJ8e1Zhq+5dmWuc26xuSWucEuB1ig9eG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?97dZb5y1USnfW54r/gTj/AyDQ8XzoTRtG5d8gIFdcsDmLlronL2zPYg00oPi?=
 =?us-ascii?Q?kZsyH2YgGdLkmArcg/HwaKNItNEkbj4m0SzeBSZ/EAUi4kJN6I2iWhbmHbqB?=
 =?us-ascii?Q?tVjfT1csEAYIELKOvBzMpAIhIGEkLTRBCu+LFAaizQOKQj8mjRcOs2IfRwwC?=
 =?us-ascii?Q?eEJwnOzYtzz01PEUbxYUDSmhZYVoHAPEeYQjHd0yeAqlRIwdPqldQAUdCTfh?=
 =?us-ascii?Q?rbVKLU3c7Oo0NpbpSPjx+GRiHofaOmcjooa72/9NyS/beUfYAHWhsSWB0x61?=
 =?us-ascii?Q?hJsynWXJmKS44mSPoBiqE+2WQ5ChEdhFJfx3HeFSdbRyPmkJ9F0waSiOxhWN?=
 =?us-ascii?Q?G49vbn8mLcFc+0WA3xrECZ7Ilv4WtWNzLia23iwAKH0lkdFmQmnyYekvpFiU?=
 =?us-ascii?Q?kaycYzfINDQIGgVcNqFAzkf2CoyumzsNrDKQYNOoRZ6WvF4X2376Ia/d+s77?=
 =?us-ascii?Q?JusQk1geY83IuuC03DF5IviOvQN3uUnYJpIU5xOVadx+kyzu4UhbtkPvEgfq?=
 =?us-ascii?Q?/AKap2OKhfcR+zShlxaEx93MLQpAIHnqWzJWe54TAJHfbciOSOKaIntUxzdP?=
 =?us-ascii?Q?eInYl5JLGSfnl+g+h7iCksSBg4KuiLBvbole7bm7gq8ljMp8aizssZFOBP0U?=
 =?us-ascii?Q?qT9Ggb6AhbtLSwbQIkqYlXlTLsyFea0o9VXFb7n8GM16XL8xVNqHm6zQ5K9v?=
 =?us-ascii?Q?1CH3yw2Ve7z/N/N4ko5mxVibkxgIlZ3p5980uWTVtLpWvP2jwDT+PQJq9UAC?=
 =?us-ascii?Q?hFHqUybri9ju66ogmCq4x89kvAPKe6b+iGBlfnRD26q5iwdnuZ86eJrssoUx?=
 =?us-ascii?Q?99jqvPrw3dR17JoEQsGvhVR/Z4id+vAfRZyz6g+eafXaAKZIhxKlKlqAn/6H?=
 =?us-ascii?Q?/5KmjnzTcPqZibqvTVRzDrcLcGBzUrsGISEBPMsF8l92RqJg/zXJKyJtGcx/?=
 =?us-ascii?Q?4dHwp4J1dVEaPzcaF2gan2P+84xWryDyJuNoEIDvqbAkUSV3/iWpuDLPbf2p?=
 =?us-ascii?Q?rlseSBnpnQVIXFoFnFAFc+iHnHxgzQLIm2antjm6AevolOn4n4l3+ZmUPqF4?=
 =?us-ascii?Q?orwXmuARvhP9kpO4+G0JUwkhsJ5ePpy+wDZCw1u93wFkD0mK+3DTLiWLKHCg?=
 =?us-ascii?Q?AdOWPJv47iU7MxMZe7tx4nislyMKCa0IRI247o0q8jqXolmmp1CQw+acUFVN?=
 =?us-ascii?Q?H7Lz6kIkIPHTI79frT+Z2sPIp+FgqbEuxO9MEEkqmAa0bWEvDfJFHCNx2xTn?=
 =?us-ascii?Q?/ohhx8H5tNL5rRaxNzRiDRKfz6PNalVowTTHusk8RLbchQ/k1nw91Yv0dfVx?=
 =?us-ascii?Q?zgJbOZXDPrmYlkcALDarYemDGFuPPMt8MBJbQgR9Q9he4zUuoJP6k/fakOF7?=
 =?us-ascii?Q?WBYY5suj5bjv6lpHmDuuo8lA3DQdQKlijET9Q5svTsjK7WOc4R/+GfpJjjV+?=
 =?us-ascii?Q?tpTh/e/yuJpLAJRltR4GoxHguscB721IHDNIvQgcsyNZSnRvYYL7q1Tjhj6+?=
 =?us-ascii?Q?lDeMvJ3AFnRiDuOUPA/QNX1Ekv+XzOIPwOt9Xo9Y3gSHmPJysS7aKcDy0neJ?=
 =?us-ascii?Q?XuEJ6FVd4hqTgyFujjNVJiDwuFfQsV6R8uZD1Q9T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc09ce9e-7889-4f78-44d6-08dd6d249f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:43:41.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhABCDg/tzPXMeX+ErRCUuoIvN9utZg7jSBnPRJarM2ZbISTQ1rTyMTF4Iscy6dwSuKRrJzpbX/RYCLHUp3iXmfMyTjmAPQ/ou9JwLDVBqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR07MB10924
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e539ef cx=c_pps a=5L1ZokDb34JZJib1CqSWiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=O9xH7Zzy3WR4EW-CiMoA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: oiLxxSgWD6lNx4llEVz5c7sv9RYwCbzk
X-Proofpoint-ORIG-GUID: oiLxxSgWD6lNx4llEVz5c7sv9RYwCbzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270080

Update the support for TI J721 boards to use the updated Cadence
PCIe controller code

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/contr=
oller/cadence/pci-j721e.c
index 0341d51d6aed..118c87fb9381 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -164,6 +164,14 @@ static const struct cdns_pcie_ops j721e_pcie_ops =3D {
 	.start_link =3D j721e_pcie_start_link,
 	.stop_link =3D j721e_pcie_stop_link,
 	.link_up =3D j721e_pcie_link_up,
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
 };
=20
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *sys=
con,
--=20
2.27.0


