Return-Path: <linux-pci+bounces-24837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A1A73055
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A52840956
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13852139BF;
	Thu, 27 Mar 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GGRw+RQz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SsJnQE4i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866762139AF
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075611; cv=fail; b=RP6GNgvHF9kl4Cp1UzF2jLc3RPsEbOrkDEeh3+/ZVx25LZhdWs2WflM++WizX0BToJuFfgez6YZ49NsiNAfE7/aCWD+7ulz+uD3gx1Qcu2/L3VIfOElGKYs0+szvUjkOta7YWZ0qYS/j3dvN7PYQUf/B0YeGjKrWtX5XETIPsJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075611; c=relaxed/simple;
	bh=9eNfVyvnwf0/9tJJexsg+N53uWnXLsNRfD40RNFlvh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oR2udlqJPlX4jQC6ui5YczHTcZnKvLcdGOlWIKyoWs0lilnjVq98olpOv0ZhoEqaBBy+5BhOoHSd2CWU6L+o/ovaL+1znfNu5pkH7Bbu+WpDU98o6FWuDL3cR4xD8ko/2afCt9FxMXIk2b82OUJ68X3J2+Beaz/fFBYeYGxMoVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=GGRw+RQz; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=SsJnQE4i; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7WteP031517;
	Thu, 27 Mar 2025 04:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=++oQVCkG8LiegJ+bAxadjgtfLcjBHQyIP2hJv2bKCa4=; b=GGRw+RQz9/El
	KbDd1VnCzCNy6MmtYKfHIcSnUmne/4Y77xxvzCDts269jA/pCgWzFPnBiGFuv02J
	jz6lRJCLmW1UwOSKepIgHMogQwFXs9IUKnMX96XEdnrEuGQkSTWGAGnsoNKEAmTI
	TL5GMAtjb1FHlw3uNzGNidGEzdms3q9+1m/+lFsQZnqLPFm6L6RwA4HdYFETJfDZ
	6ohw0K1vW6p7wGw700WIxfG9ITYq7YjCvSxJj1JnsVs3xsXq4xVWLNzFsLtSU1PE
	asRh0D79Y47XzN5Nwbmx+iAlgo8Ugwp2SmM+FgrkDtwG2gfaBKK53GHfjUMorA/T
	lr2GyCo+Xw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010003.outbound.protection.outlook.com [40.93.20.3])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrwmxqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDC/5PR3mPBZJtNTvEG7nceTXcIUKafdYkUF4roMi/8kfJqesJqmVVjsar2PFXy6j0p9rAEMfz7U41RnWf812opBHxRCnEqd2yG27j78bPirwv42X9iYzoKKq3M8EWHXoj+Q3awSwmE3IOkOHjpctr6le4TS+GIJ0OXsiyk30VpAooqE6NE14prwrQHqG8morqyEX56D9sSCiu1wmprpL1VELUBZQqTpzzdOZhp9vyQM4uUpJ3eJYAZvS6xbJcpx9LSY4yX3a+8rSqi1Czjnsq0OCqXulgbxZpWnuHBEUdwOkBl7LIzxRXmpXxX0cpKZ00cRn50q3pK6ZgJhFRoT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++oQVCkG8LiegJ+bAxadjgtfLcjBHQyIP2hJv2bKCa4=;
 b=Vt1oWKvnZz6j39ElPthb6bqQ7BR5Ecl9lU/8H7wNFPKgvbi9t8wxGseQqMADUOoffL5MV2meAjNps1l/CEXjGbIFLXeW/IwSJdGEvkhjbwPFMny6xgpKOjmFEyEqwiDVfusmBSittrktx6Sz1TXmoGYeIINleISvo+s41vrFfVmVh4gOXlkT+2BgcR2IyR4N9jvwEeGfkw0SM19TgQVS9oHVTEAm8tfmBCNUv7eSdhVK5BUORqH2B8D5QHI97lCqykSWz8P0Sm1OuVoE9odrRfb4VdtvkTUZx0xStePgHT+9NkqAO/eMe8Pl6ropzugsmg/zCJg/oYaiop18a4GF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++oQVCkG8LiegJ+bAxadjgtfLcjBHQyIP2hJv2bKCa4=;
 b=SsJnQE4iqNkbvGQAeU4Gfx0yu8rAYNrqGDe8Pxkyfk1G+8C0XshWEP34vByOggl1hYdl474DTpfZN8OT5KQmNwDg6Cjgi5+5HBHGtIg0WCBYHynU4RuMKgJY+CTZKYm+Eat0n163LSxirGFq6gC51rPfOi5pYBzoWjVAFcnGFHs=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by MN2PR07MB7294.namprd07.prod.outlook.com
 (2603:10b6:208:1db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:39:43 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:39:43 +0000
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
	<linux-pci@vger.kernel.org>
Subject: [PATCH 3/7] PCI: cadence: Add platform related architecture and
 register information
Thread-Topic: [PATCH 3/7] PCI: cadence: Add platform related architecture and
 register information
Thread-Index: AQHbnwkMJekZ5LC+V0e47zdOm6rTRLOG22qQ
Date: Thu, 27 Mar 2025 11:39:43 +0000
Message-ID:
 <CH2PPF4D26F8E1C5086A79888CB5AD0A01AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111146.2948015-1-mpillai@cadence.com>
In-Reply-To: <20250327111146.2948015-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yYjJmMjI4YS0wYjAwLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcMmIyZjIyOGMtMGIwMC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIxMjQ1NiIgdD0iMTMzODc1?=
 =?us-ascii?Q?NDkxODEwOTAwMjM0IiBoPSJWamxicXpKL1BsOG1pUjMzSENlaVd6SEFLSzQ9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUFLK1lUdERKL2JBZEFuUGdnMjdlblcwQ2MrQ0RidDZkWUpBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUxnQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQUF1QUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|MN2PR07MB7294:EE_
x-ms-office365-filtering-correlation-id: d7216160-79e3-438a-2b87-08dd6d241169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xqYXBohWYnqyDXiYuh6omk5ieaPK3U0E4yTsVSM0QdMBeQM/WDX8l1VHBPCm?=
 =?us-ascii?Q?2NUIW8viFIQ7g2CXQ7JmPO1tuIkgaBmAf1FAeP7nrr+ixRouSVm+W8l5Jo8i?=
 =?us-ascii?Q?0Ngxo0ikh99jOyhTBfetZHUIcBwz0FtkgmagUh8mOKmGm/j90OUkrPr39Uj3?=
 =?us-ascii?Q?JKJJTLKc94WP7AJ+VGju3YpmkgyNbdIwpPwcW7y1vLhzNH7eb+bNPPzxGlQ8?=
 =?us-ascii?Q?/lqPIM4TlUdUzuOjbxOysX+OHK8XjS1hBKulZ0Pb4s0p54f7HBJXOTDQ8AVx?=
 =?us-ascii?Q?i8NkjMfOavU4kO6ZGp9rYXdbBUE+fxIiyjzfAPJV4ZKsdNAAMQW+tqRBWmBq?=
 =?us-ascii?Q?GAAadEE3Yd5g4rCQaSoF3K5lqzxIFuruQRyU4kCysVfapUyz5nuv6GzA0ubJ?=
 =?us-ascii?Q?qOlw1ao3bz0LJAk2BJr5E2V2l5I2DXJ9r5sVpdemD0unuI7AvF2bFtKUoQqg?=
 =?us-ascii?Q?04oTijUyFufYQTauRWJxhiWwRoOopBLhvHNPQISFnInGnrhw4j8Ya+4plZXv?=
 =?us-ascii?Q?q/ROoViNFxgM9Q72RMGc7QTWraE/Vn76trushhXFZS9jdezMTXGWh72mJS0+?=
 =?us-ascii?Q?lu0gpPoxpN3tZDwUP+d9gJBTOswULKO9iPnHP5PNjGNa6nSj50CCpmv5Qgy6?=
 =?us-ascii?Q?Z/W6W52rC+AjyXIL3/7oGgsra6/QQBeAHcpI7qk1aN4iHFZVHatVlXetdfF/?=
 =?us-ascii?Q?cMyN0McdspR9HHaoK8WvIlkDwhbC57F1YDYHjlylNYdTVj7mkmfdgH6+1M4G?=
 =?us-ascii?Q?Ud6J4124nMKnUZ1f1leWZXCNjOSem6q4XabklnKdAnwNS0as/uIvIbgrcCnA?=
 =?us-ascii?Q?l0Ea4z+kWK2lgB6kciH9rrS5MLq5V7rRNzL1guAY7IGge3wurHFvTDOGczKY?=
 =?us-ascii?Q?Nu5HJJhn7vAVKtkCmtQMa4gTqSwHsMWavt071fyndP4HAKfDM/g645KYv9RC?=
 =?us-ascii?Q?C0IBthQfx8OX3eNys8wXCkVulkgVJhwegnR9HBiscDvGTPAaefzfknd9+kM5?=
 =?us-ascii?Q?mzWU/mqgkFw1OqCnvyt5A/CG5eIvVYvJAksFbNvZrJAxOyuolcT+YC3IXg97?=
 =?us-ascii?Q?CgGghLpHU8bYvDmA2RNTvQLYC2fJxmGq2n3HJb9qDfKqHnXJCyl7HmfeaKKb?=
 =?us-ascii?Q?c0pHwfsaxR4c5i6IfeZuCz2neH5GiyO8T4mK+FvQabWfLM93USgeHKq2kfN3?=
 =?us-ascii?Q?kd3yZCxYSFh3xeA/m2YB9hVN1w7SZst7VjBKJ5ccdjcjOVoe7eq1JZGYR7VU?=
 =?us-ascii?Q?PqNX0OFGPZDL1jWigSE/moi83j7OHSL5ydx5+EUD0YFw0CxGLBWMmBX2JvMi?=
 =?us-ascii?Q?AZ4KyfdVQX8VZ9/yPNyqbNI6Y8SfN92MPrI1uHvkHtPz4DfQbOVEfBBUJ51s?=
 =?us-ascii?Q?Xq8yZ6hsxGlBsKSVO2Ml1oC4NT31gD5DBp5T4NdOUwLQ6Du6uC0OMu1Yh/Hx?=
 =?us-ascii?Q?bZYJkjpgIe9UyME8IooxueOo33vrQl9s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+WwtN1/J54PmeMWI+sA2dJ0nZGEX+fRrSIBrG7xr7OlrHd4ukydXlyCTbkRa?=
 =?us-ascii?Q?7wymvRkgTeuLHEZqZrm/Y7M/PlZhCwgd4/F7XwGUn0Je7MOCQI64DwpUup02?=
 =?us-ascii?Q?5c6ZWcZ8HctnT0c5XJ1I1eOTQVKPTEikEhhtmbAUdWPSqB7G+rOFhAMnmIvc?=
 =?us-ascii?Q?9v1ub61NocJpu3J84IT9mhnyBvEMc/GyAbnxurQhRsAwMhq3mVnFxOj4OkVc?=
 =?us-ascii?Q?el7571DuYd2+9oPuK9bcMWGZAQjvDFMTNJp+m4qkjRv91erYYs0jKeLdlmV+?=
 =?us-ascii?Q?Kms69xKRcREawCvyA+E1yuOBW2Y4UR4zBBGixfL+HpREnnOP/WuPFUXDEXWY?=
 =?us-ascii?Q?x5rsD48D9zrGN+sMl9kni7DL3IqOyMO9tU1/QpT1wvppE+xXWXan2cSYoVSC?=
 =?us-ascii?Q?WPEh7k5/Z+vXid+Cc4gc9uJYK/fJZXd2C/GaGoa2Adcq8MdJEGvrJmYOHDwd?=
 =?us-ascii?Q?nz3l2CdQR0MIfuw0IC/G52eqkGyjktR0hc+dfU6PZhydLPh6k6PvLB9T5SJr?=
 =?us-ascii?Q?tz1CVpJiX3b1c/OMreqCtX5JsebWVbUfq6+e8LHORYfRPxSzwIhaZsfjuKm1?=
 =?us-ascii?Q?Af+jqOhkofLN4mFoB68l4v8nxR62tYEW0ftSfH4IGEA0kWQXaBoqjxzv5mJa?=
 =?us-ascii?Q?C2ZREjfjEXHAzn/ib4WQy7MWT2Bj1jKZc0MIbf+fsVZf6tgGg+hXl6f8dVUu?=
 =?us-ascii?Q?fyIFOHDoOJTHqXIFMibnDL6KHucXeWeGjP5NMLN2MabZHlGVnFBpbuuBfiQF?=
 =?us-ascii?Q?dyh4MPCPNzPkD8vjjXZsF2t9FrXKf4uTi7jLO1BcmZWfCc7N2i+P4Shpj4qK?=
 =?us-ascii?Q?uHTwwDLGOETKyhh0ZVWMenl0SdROG7Q5VahkWDIJShSeuLZZPf7LLFDzrKGU?=
 =?us-ascii?Q?dUnbL+Nk1VSuxM6S5NIBd2KPzO2B6AE9M8KI/lTeu858RwhvEFBjsDlzBOWo?=
 =?us-ascii?Q?QJoPvGAl4MgF5ZHIXO+7csoQ3+ZDY6PdwHUXE5//JGdN0X8gqgXBZcu+OVzq?=
 =?us-ascii?Q?GOGmdl5Rpq4TEFMNBeqdRe60OaV/2Y2mYbeuh6yH+sMT4MiYv5pcp6UGorEn?=
 =?us-ascii?Q?Ci2ujWS2hfZTFvylCB8rZ9usxzObNrDXTlgo67MCCRFnwoiNYZ2r1LNDpr88?=
 =?us-ascii?Q?0TXRx5xo1ox1ewfCXkQyOHNn3OW/iSm75GcX6WQY8SIBJr7TJKYI4phXq0dB?=
 =?us-ascii?Q?9+g6anYwykuV3R8Ska+cYjLhO2uD98T73m31Qa0Akk6vt/5i6iWcYeh9cJ++?=
 =?us-ascii?Q?w5EC/PktsVJyIRJiOt9yBJTGphD1J0G5ayFBlmhJTD97BJFCOjyaD6Sdn18u?=
 =?us-ascii?Q?C14jzgaLE3Q4Kr6hGyMGNUvdyowWDlcCDC5QRgFb5WAftRUWispofhE/dlL3?=
 =?us-ascii?Q?V31T3OXcG0KC9zRjrKjhHff1FlCJ4muUIC+LKfZUD5sAuKRFEWrGhL6OXbGS?=
 =?us-ascii?Q?hRDWLNHF9qpdbV2VMAtk0Q361bF2HMLTsGIqLY7tLAsijCVRoUpItPMbADuz?=
 =?us-ascii?Q?gHXPfo6xiF58dDr2CFsfrKEvHdyWLS4APf+kIpJfYhwAp/cZbzk7TtYEcVUd?=
 =?us-ascii?Q?+zVAJqH+FCFXrxt2uR8KGmDJRqcsyaBIQPhtGKel?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7216160-79e3-438a-2b87-08dd6d241169
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:39:43.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+gkHiONVbgIbba6B+ZCqN50fAXuHI50mD2G4kuNPqOOXgMhrR5qI/gXxMwgwxmpz9Z5fbakSDmmgz7NTDkIAe4tpa4JcMnI4uY8kNhSXHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7294
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e53903 cx=c_pps a=0ZLAD3l0a2tGCwaiWSoSeQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=RPVXSfxXQisr9kFX8C8A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: Wd34WOWcoz_H95IhwbKYHAGsR0bf8eZV
X-Proofpoint-ORIG-GUID: Wd34WOWcoz_H95IhwbKYHAGsR0bf8eZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270080

Add the register bank offsets for different platforms and update the global
platform data - platform architecture, EP or RP configuration and the
correct values of register offsets for different register banks during the
platform probe

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../controller/cadence/pcie-cadence-plat.c    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..e190a068b305 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -24,6 +24,15 @@ struct cdns_plat_pcie {
=20
 struct cdns_plat_pcie_of_data {
 	bool is_rc;
+	bool is_hpa;
+	u32  ip_reg_bank_off;
+	u32  ip_cfg_ctrl_reg_off;
+	u32  axi_mstr_common_off;
+	u32  axi_slave_off;
+	u32  axi_master_off;
+	u32  axi_hls_off;
+	u32  axi_ras_off;
+	u32  axi_dti_off;
 };
=20
 static const struct of_device_id cdns_plat_pcie_of_match[];
@@ -72,6 +81,19 @@ static int cdns_plat_pcie_probe(struct platform_device *=
pdev)
 		rc =3D pci_host_bridge_priv(bridge);
 		rc->pcie.dev =3D dev;
 		rc->pcie.ops =3D &cdns_plat_ops;
+		rc->pcie.is_hpa =3D data->is_hpa;
+		/*
+		 * Store all the register bank offsets
+		 */
+		rc->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off =3D data->ip_reg_bank_off=
;
+		rc->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off =3D data->ip_cfg_ctrl=
_reg_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off =3D data->axi_mstr_co=
mmon_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_master_off =3D data->axi_master_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_slave_off =3D data->axi_slave_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_hls_off =3D data->axi_hls_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_ras_off =3D data->axi_ras_off;
+		rc->pcie.cdns_pcie_reg_offsets.axi_dti_off =3D data->axi_dti_off;
+
 		cdns_plat_pcie->pcie =3D &rc->pcie;
=20
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -99,6 +121,19 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
=20
 		ep->pcie.dev =3D dev;
 		ep->pcie.ops =3D &cdns_plat_ops;
+		ep->pcie.is_hpa =3D data->is_hpa;
+		/*
+		 * Store all the register bank offset
+		 */
+		ep->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off =3D data->ip_reg_bank_off=
;
+		ep->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off =3D data->ip_cfg_ctrl=
_reg_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off =3D data->axi_mstr_co=
mmon_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_master_off =3D data->axi_master_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_slave_off =3D data->axi_slave_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_hls_off =3D data->axi_hls_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_ras_off =3D data->axi_ras_off;
+		ep->pcie.cdns_pcie_reg_offsets.axi_dti_off =3D data->axi_dti_off;
+
 		cdns_plat_pcie->pcie =3D &ep->pcie;
=20
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
@@ -150,10 +185,80 @@ static void cdns_plat_pcie_shutdown(struct platform_d=
evice *pdev)
=20
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data =3D=
 {
 	.is_rc =3D true,
+	.is_hpa =3D false,
+	.ip_reg_bank_off =3D 0x0,
+	.ip_cfg_ctrl_reg_off =3D 0x0,
+	.axi_mstr_common_off =3D 0x0,
+	.axi_slave_off =3D 0x0,
+	.axi_master_off =3D 0x0,
+	.axi_hls_off =3D 0x0,
+	.axi_ras_off =3D 0x0,
+	.axi_dti_off =3D 0x0,
 };
=20
 static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data =3D {
 	.is_rc =3D false,
+	.is_hpa =3D false,
+	.ip_reg_bank_off =3D 0x0,
+	.ip_cfg_ctrl_reg_off =3D 0x0,
+	.axi_mstr_common_off =3D 0x0,
+	.axi_slave_off =3D 0x0,
+	.axi_master_off =3D 0x0,
+	.axi_hls_off =3D 0x0,
+	.axi_ras_off =3D 0x0,
+	.axi_dti_off =3D 0x0,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_host_of_data=
 =3D {
+	.is_rc =3D true,
+	.is_hpa =3D true,
+	.ip_reg_bank_off =3D CDNS_PCIE_HPA_IP_REG_BANK,
+	.ip_cfg_ctrl_reg_off =3D CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
+	.axi_mstr_common_off =3D CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
+	.axi_slave_off =3D CDNS_PCIE_HPA_AXI_SLAVE,
+	.axi_master_off =3D CDNS_PCIE_HPA_AXI_MASTER,
+	.axi_hls_off =3D 0,
+	.axi_ras_off =3D 0,
+	.axi_dti_off =3D 0,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_hpa_ep_of_data =
=3D {
+	.is_rc =3D false,
+	.is_hpa =3D true,
+	.ip_reg_bank_off =3D CDNS_PCIE_HPA_IP_REG_BANK,
+	.ip_cfg_ctrl_reg_off =3D CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
+	.axi_mstr_common_off =3D CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
+	.axi_slave_off =3D CDNS_PCIE_HPA_AXI_SLAVE,
+	.axi_master_off =3D CDNS_PCIE_HPA_AXI_MASTER,
+	.axi_hls_off =3D 0,
+	.axi_ras_off =3D 0,
+	.axi_dti_off =3D 0,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_cix_pcie_hpa_host_of_data =
=3D {
+	.is_rc =3D true,
+	.is_hpa =3D true,
+	.ip_reg_bank_off =3D 0x1000,
+	.ip_cfg_ctrl_reg_off =3D 0x4C00,
+	.axi_mstr_common_off =3D 0xF000,
+	.axi_slave_off =3D 0x9000,
+	.axi_master_off =3D 0xB000,
+	.axi_hls_off =3D 0xC000,
+	.axi_ras_off =3D 0XE000,
+	.axi_dti_off =3D 0xD000,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_cix_pcie_hpa_ep_of_data =
=3D {
+	.is_rc =3D false,
+	.is_hpa =3D true,
+	.ip_reg_bank_off =3D CDNS_PCIE_HPA_IP_REG_BANK,
+	.ip_cfg_ctrl_reg_off =3D CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK,
+	.axi_mstr_common_off =3D CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON,
+	.axi_slave_off =3D CDNS_PCIE_HPA_AXI_SLAVE,
+	.axi_master_off =3D CDNS_PCIE_HPA_AXI_MASTER,
+	.axi_hls_off =3D 0,
+	.axi_ras_off =3D 0,
+	.axi_dti_off =3D 0,
 };
=20
 static const struct of_device_id cdns_plat_pcie_of_match[] =3D {
@@ -165,6 +270,22 @@ static const struct of_device_id cdns_plat_pcie_of_mat=
ch[] =3D {
 		.compatible =3D "cdns,cdns-pcie-ep",
 		.data =3D &cdns_plat_pcie_ep_of_data,
 	},
+	{
+		.compatible =3D "cdns,cdns-pcie-hpa-host",
+		.data =3D &cdns_plat_pcie_hpa_host_of_data,
+	},
+	{
+		.compatible =3D "cdns,cdns-pcie-hpa-ep",
+		.data =3D &cdns_plat_pcie_hpa_ep_of_data,
+	},
+	{
+		.compatible =3D "cdns,cdns-cix-pcie-hpa-host",
+		.data =3D &cdns_cix_pcie_hpa_host_of_data,
+	},
+	{
+		.compatible =3D "cdns,cdns-cix-pcie-hpa-ep",
+		.data =3D &cdns_cix_pcie_hpa_ep_of_data,
+	},
 	{},
 };
=20
--=20
2.27.0


