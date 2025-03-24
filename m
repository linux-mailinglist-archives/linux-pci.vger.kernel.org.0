Return-Path: <linux-pci+bounces-24510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147CA6D7A3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC27A3C9A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32EA25D915;
	Mon, 24 Mar 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VXWKRE/p";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mX1EmIul"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100FF25D8F4;
	Mon, 24 Mar 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809116; cv=fail; b=ShR4xfviSHii3+HT0If93jjba8SSoAPtV5ydD8yoAFo1CzL0e0Z1w5U0GhmVCtrFKQkWQkMpcSuI8NnJHfgHYGFJZCEEwhCCvRUcOjWt6ERHOUszxbTVZt88gNjN88eHb1NarsFoOfamIts67ddWalSIb5WMeeSwMJfd8jEecrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809116; c=relaxed/simple;
	bh=LrYN9sXoztYBdJNFBA8Gv1csa9EAa/1CSHSjLI8XBIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GzGWzZCreWeJw5JOARpobhsRb6fZQKUF92TeZ63NEh6ZETFJE2TpKV5huoSM7GAbX5jZdAk/181ngQO+nD4+NbNdDM83oaXjtDA4nKqzm5PknSPJPBElRRwcv5Nl/LBqMfKd/58ylhGhbysCkbUE7agspLQ8ryF0al/nBsOy1IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=VXWKRE/p; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=mX1EmIul; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKdbu5000606;
	Mon, 24 Mar 2025 02:08:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=mdH/8U2hDJrBIRZfKV9nmhmON5X+JW15HmbJyoJOFo0=; b=VXWKRE/piP5/
	kfg8s7dMoi1Mq7RpYvXWwCIZf1K5QOvio44WlZM24p9KUDS32yC0zKpT9ObRLN6h
	Z9j16i4dZ4XtaCtLJd+27F2P91s+R/dEf4z2m2NfugyifSNbCf/iCl+mg5fJW7Vu
	Q4zNYjFp+3P6l+vvl9O1vBYpJKlqSdYFtkLbiejT1AgxfmRwxNsQub7YrAgQyjF6
	I1Og7zDsMG90Qsl9oGz6wjOX/zLLXAB67pUMvhkYGVDmx/HQX4S3dJ8WkBaGEWvV
	tWD0Vd7/iq6ZQizD6YZ13rLOHjdop8H29ePLOfDIPVRALlWjPNxwj0bWu0LsRpke
	Z8f4JH/MNQ==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrw4wmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDpgI7DE51YZCevZ2r8a7li5+5lXMYDK83vwmjGL5rV/ct4XXTA5UowA9gxlSQQzXdIYpHBRh55/HQypIb1VUwUq6uadAEL+gOFcO3g3h5qy6/mEKJAzlKnKLQ/B9RoZQM7pwclcc3RZnzUyEUO9dzejGPXS9UwH+21PPc9gY/tqM5cRUgavukWF5rlT81LCZHSbEU4nrhX7C+9URJfomVIFjoEhTPmeezhzPBvuhzuA1YFi7yEkm5yxrDzIoq1gXN4WUN3/ZBC3I1fiPTZ9QFMr/YePdasIS4JXAYcxHIHAqHqKHrkl5mKdOWzPEtjYMqzqoLoaXt4SoQQGtGFJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdH/8U2hDJrBIRZfKV9nmhmON5X+JW15HmbJyoJOFo0=;
 b=FWqMkK/ClO2AGUrVpotPIi+vkCmTOs1l/V+vmGGi+BD0a49rb9K7s09gcIsstljwr6OZpMG2hf2K9LWqRcB7r7SIbIMppN1DdGhEecqbiiUUCGe+nTpcBIupNGiE/H6JIHGFM0a+VHc1TOTu0GEiIfOmzniaNTtKzA9+PI2VVJIVqKGoNye87wVtHucmyzKpgYYEnUdWTIANrylwwu9o6YxZwSao2wfbYT282A+S4YCRqKi+Ou++Fgef4YXm3t4DRF6tZxfpcdQmLNpghA+L4Qw/+A+WK0x/Cp/DP3wIofO45t6mr+EWJy7rh1fLlwV/SxVEj29OSPlwP9GLWuThGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdH/8U2hDJrBIRZfKV9nmhmON5X+JW15HmbJyoJOFo0=;
 b=mX1EmIulzmEy9lWtGVLmzoUvI9h+JZxs8eHQZw7BHY15H9R0tjWQOdZW+MAyMP0cu4viPES8MVNHa7KfsHrwBzzi6ozFk+cL1fLcuW1fShXqltjrStAvTUEakhu3y2/IrroxJGCa/acyc6xIfKL1JTjm9DrZ4fb0m8KV6lpTA5U=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:08:09 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:08:09 +0000
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
Subject: [PATCH 0/6] Enhancements for PCIe Cadence Controllers
Thread-Topic: [PATCH 0/6] Enhancements for PCIe Cadence Controllers
Thread-Index: AQHbnJXtfAyajNCRfUSdxKsvy+hfrrOB/A6A
Date: Mon, 24 Mar 2025 09:08:09 +0000
Message-ID:
 <CH2PPF4D26F8E1C205166209F012D4F3A81A2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082241.2565884-1-mpillai@cadence.com>
In-Reply-To: <20250324082241.2565884-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03ZWJkMjNjZi0wODhmLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcN2ViZDIzZDEtMDg4Zi0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIzNDE4IiB0PSIxMzM4NzI4?=
 =?us-ascii?Q?MDg4NTgxNTU1OTkiIGg9IkpmQWJpM2Juc0UrdjczRFJZcWFGbkNqTC9xYz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBQlAraEpCbkp6YkFYQWNWNTlCd2kwdmNCeFhuMEhDTFM4SkFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 7e561f1c-67f4-416b-7c28-08dd6ab36582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?69gCSrri28ZOTFn6AlEDqekqXe1Cgn2p7YCQVghV+Y+3TixcL10ZaFVLKQUh?=
 =?us-ascii?Q?IPHby6f7hZYxbRFm1jUXTmcjhbTTeXLZ5joXPDTDqm2rwvab6pMVm/1Ff+c6?=
 =?us-ascii?Q?ZH34L7TWlWOvsoEce5psDysIY52CuWkJdPAkqYwu2s5j57AFsSEZ0yeIbWQl?=
 =?us-ascii?Q?YTHcw5qFf3bM6g40DANgTJukW78Upz5GAuLQs8ns7wVOjXfC3a3X3CCDTrH/?=
 =?us-ascii?Q?Bfk306o1OHwDhEphkKbYstKPvObsIuRqLwn3/k7e2bHBs6TbyNI8gnjE17zC?=
 =?us-ascii?Q?uLPXYOcRqJ/GxFk3csvyTIMYDav6vXZzY2d+9cSbMisrhbx1hp6CFFfgqwEo?=
 =?us-ascii?Q?+vCMQcKG21ITs6Yc9duygd1aNjLsw6XVBS1gLzxwq8niDEf3ALEBLMouFiN7?=
 =?us-ascii?Q?gG2lnr6VoqUr+49zqQImAJl3HioUAoMX58zme9kF942SEgW7SZPjtAtWJqUq?=
 =?us-ascii?Q?+K/QpE5OahD1nH+vew/N6zCYwg1gdw03ll6OUbPBMWRG58J8rdh0a836X/zl?=
 =?us-ascii?Q?V/KWUGIU7XlJ7bjHWGvmytmBNzvOEJC3Kego9jvHmLHzDeFNLul5IiAc4DYI?=
 =?us-ascii?Q?BFN0LSaJnBiK5P/I4rFfzjU0JmnSArWri6gN5K1z5pETS22RVNARppZFXd+C?=
 =?us-ascii?Q?yCMwkPszzjuD6WTnqUwNKqjZ6YviFNwJvJ9Sn8dv93uI+kNmLphyuwzXA8bN?=
 =?us-ascii?Q?MlAsnGOPHs4s06dDK4FJWRggFW9ACngLZJc99XlsXIJfbsJlTPFe9vSkil//?=
 =?us-ascii?Q?SQa4HZ76RZKlVcJhzczKe38vTR/sjwuTGSAuL5oPOY8b4LWWHzyBJCZXTchm?=
 =?us-ascii?Q?eHbl+77H61M4kbjc98yFMPRPr8eor1fb7ygmm3PbkSrY2OISh6RQpsDJxSEr?=
 =?us-ascii?Q?WAfCU3euQPbZHQkWBtnf/RXZp6gTjCm/cN9gptBhHgPw6I4ZiqPTVuCoK8OT?=
 =?us-ascii?Q?55DZVzFs5KW4n0q5PHcnfZElf0Gy7GlF7UFPm4sE4fwCIeeKwc4H5fPLO12/?=
 =?us-ascii?Q?omNdfC6eDDqsMkpYHh0TMEvbcs+lM5l+umtMWHnrnMdzmIof9j0dmTa2gpW+?=
 =?us-ascii?Q?INVqaPoXkHEQfxMBlMe0oQTKnRAx8yyYGKH6ceEyk3Uhz+Mo1Vr+AYeCIAvD?=
 =?us-ascii?Q?g82LxuK88deEmKV3G5XiopZ6UgnnN3DvuqlxYm5i6iatixBTlcO+qKVars1B?=
 =?us-ascii?Q?cmjCAlZBZ+fSDS5e3AtInSoroF0ZYO7X9mmjhaho7USqoBtalMd+a1K7BXVz?=
 =?us-ascii?Q?8zMWn6lIY6F21wXOfyV3qqxsuImQTP1ewYBCSjt4ebtb9JBWQ2aHVt3fFlOW?=
 =?us-ascii?Q?Lh5Fgcqy0tx5O9f9h0ibIAa+SGJfAalwk8z+/q4q5rBf/fi5gIZ16NQ/EoRe?=
 =?us-ascii?Q?U9Ev/Xaaira/857ykR+DvLI5Jazut7X3qdvZj9o7iFruRE1+KpTFWnu/OhDv?=
 =?us-ascii?Q?qi8B0qHW2MaAESu+k4fQmYsvniSxMnbG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gh75SZAFCE9RNg0/ardMXdiFg7HOHF8JW4vPMYa5NzO4zaKKqDBBvQIvrIBT?=
 =?us-ascii?Q?oSW5okjhO+Wknse+wxe5Dg7Bgjd4KLPA2+BGPoyqHtIARUn1/tsi1j/lRUI4?=
 =?us-ascii?Q?WtBywoARjPn+LuTc628NxmtN82gQYuECBPIF83e2tHbPnl1lYbnEPnt9Ncvu?=
 =?us-ascii?Q?D1Eqf5FoIdWTz1u3VpCv5eP1vCnGyse9sFmkPsrEFeSPlRcLv55OjzRi3lZs?=
 =?us-ascii?Q?t3WI4SGTGsbHTl4iX2xYx5+MjWgbpIYwC2cjWI79WzY5Ma0szF0J7ISAQFWO?=
 =?us-ascii?Q?CQX4Fmh/Wblr8HsgONum/rRWgHh56wOk8dZCGlZTq7H2W7OUSmw9Fclfdq/G?=
 =?us-ascii?Q?RgETN52gj4/kBlkSykZ/Y7X4palOJsIzPLzmFyjDeSKDffGmKebS8UcLi6hM?=
 =?us-ascii?Q?O9PPkrf9CxzXaZnX5558AlbstuIcUqGSxnh5azNDWqWvwWJNtRe6LAIcpm+u?=
 =?us-ascii?Q?RUmMdHvSss2raI9OJq49nvqJxE9debPoKsj5DXF7iKxnyHkVQR2aRpcYVg2c?=
 =?us-ascii?Q?p8ndhc8dvcNPRS4B6fx/yzj8ey49gIQ3/nCqaXM1R46DMr8rrEJgDU5MFzV1?=
 =?us-ascii?Q?S0wgEaN4J0WGUeyFXIuuOKwnVr4AcRDpuXp64smz5nmXPTSY98Xrbi4Ra7s0?=
 =?us-ascii?Q?0cudtH9Ec8f7nwVhzSjG7M5zObc2G7eJuaYi9EI27stPirpZqKdVjV/lWC4x?=
 =?us-ascii?Q?AIMlzGh3XbsGBt/ZbUReBIoV+0pHK89DgaXQei5pUIu0HK4PHN4wkDM7RXeX?=
 =?us-ascii?Q?iXOyYtdDd+Cd9RwWIrwZYIgFLANCUx7iGv0d4VFhE0qBa+x0BkGzmgHpTBK9?=
 =?us-ascii?Q?KKeuITi2QI6j4Y+2dR6x+ykVHYtatI28Y60OKdNzxihsJ1QeYT5cS9BYlB5Z?=
 =?us-ascii?Q?dqmTgeLodAILkof/bz8cN+TaxNmyE9hhxmPZP56d/UutnnEaoirKokf2djma?=
 =?us-ascii?Q?IFNbBNvdBisQ+OEG6N7UYwUou5KxEF/e5505t+BvTVf11ftRo4bkLVIvcpbR?=
 =?us-ascii?Q?XCbKYwwUO3pioaB/E1HauCKAPaWn6T+Q6aSyMpvmgphkyi1DQX5Suryj1A1D?=
 =?us-ascii?Q?5JYtfpchQKsXQQVOcB46FIQXgDDFmNEvbagG2cg8+QRBa2QvQp/CZQIYf2DW?=
 =?us-ascii?Q?MDAbH6AhriewU87Nmbi1NEIH9WpL6/Y/f86xm2pF1YAwTB2USDgmCltgOZTs?=
 =?us-ascii?Q?f8MBuQRRS+PqUVHQvwnsAH58HLSxhjjfIRllqtQinSmCDwcJg4DNyxS3CWuE?=
 =?us-ascii?Q?hyAHLl4zUrajbsKloRPV+fMVZz0FC4rSStFbqG+Ew61qxUuMnftJA+nGkNDN?=
 =?us-ascii?Q?WNIiQdkrxCArwIW9swK+JikTZZP2D92nS1msAaS9A2DY/9tZtzAtcx+69u8J?=
 =?us-ascii?Q?tLv6s8yDWzKSD+GFK0K58Jh1+5a9XVGdYHyM4vwikdrTyZkXEPQ3FkKUzRUX?=
 =?us-ascii?Q?U0wURw13Qb6N5jvL4MzScADaIZp3MC+aAI4AZgvVf4EnXsZruoeL9e/4FVH0?=
 =?us-ascii?Q?FROFMjAjaasoGv2Gb/+pigdydydQRERJmXoVgusX8SDjvk4fIjg1FOdby6nZ?=
 =?us-ascii?Q?lA+PPTIb3q4BpITg9+R+pFDynXPbb/wW6Aj6u1+l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e561f1c-67f4-416b-7c28-08dd6ab36582
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:08:09.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHoP8xlRUp+Q72eyfiordpt1HU+ti1a4nIJVNu57/CUfHGp4prjOyB0zd40ps6HPQ/XwZOrAZeuyhV2kTpKaVh1s5u77bk+T+GMf9nej9IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e120fb cx=c_pps a=MGIL9jhmtb3Hqg0nl2vIzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=tmJdkqCscsw4aizfEMMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: rLONtB8AjKUmpC5ggnSSc6JKtW6Z7RSQ
X-Proofpoint-ORIG-GUID: rLONtB8AjKUmpC5ggnSSc6JKtW6Z7RSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Enhances the exiting Cadence PCIe controller drivers to support second
generation PCIe controller also referred as HPA(High Performance
Architecture) controllers.

Comments from the earlier patch submission on the same enhancements are
taken into consideration. The previous submitted patch links is
https://patchwork.kernel.org/project/linux-pci/patch/
CH2PPF4D26F8E1CB68755477DCA7AA9C6EBA2EE2@CH2PPF4D26F8E1C.namprd07.prod.outl=
ook.com/

The changes are tested on 2 platforms. The legacy controller changes are
tested on an TI J7200 EVM and HPA changes are tested on an FPGA platform
available within Cadence.

Manikandan K Pillai (6):
  dt-bindings: pci: cadence: Add property "hpa" for PCIe controllers
  PCI: cadence: Add header support for PCIe next generation controllers
  PCI: cadence: Add architecture information for PCIe controller
  PCI: cadence: Add support for PCIe Endpoint HPA controller
  PCI: cadence: Add callback functions for Root Port and EP controllers
  PCI: cadence:  Update support for TI J721e boards

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |   4 +
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |   7 +
 drivers/pci/controller/cadence/pci-j721e.c    |   8 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 179 +++++++++--
 .../controller/cadence/pcie-cadence-host.c    | 257 ++++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  30 ++
 drivers/pci/controller/cadence/pcie-cadence.c | 195 +++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h | 290 +++++++++++++++++-
 8 files changed, 922 insertions(+), 48 deletions(-)

--=20
2.27.0


