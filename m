Return-Path: <linux-pci+bounces-20876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E7FA2BFB9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16131163E84
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89F1A23A9;
	Fri,  7 Feb 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cZMineVw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="P92VnMn0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6E1A2381;
	Fri,  7 Feb 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921379; cv=fail; b=WoZEydTIdcszj1gHc5z/U2A6izziYQe6gJ/ouriXqBSSXtsqFla/WxhwlOn5kqGbTnCacCvnrwZGj4flVqc7lEVzHCGQs0BajK0cEB3WYey70nfCcmXnAZZrVJAgGLQQNlBciWU2BPZTAcntotAMF1kBTmU+PcnmCn3MLqVN40c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921379; c=relaxed/simple;
	bh=W5K6GYoHK29R+0ba/u3eIsRSriHAkam02kshjtsRiyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdydN1jcQDDT25TbFMXzrnrDhG6OxNT7Nt6Gdt4fagVVqIAGoW4nCd8sVvd2sozbsL87nCMWBR7z60f06Hntp/HD8sU/aiZpUYpMfjlue4xrbITv15P7prUv08fWhnYEes/IF3sPjsQLt/DAVmN+RbLsWW1INCgqx9lkyWwD6uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=cZMineVw; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=P92VnMn0; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5177R2bA026937;
	Fri, 7 Feb 2025 01:42:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=RctRab4QuOAKG4YasdaNrGuLp3zXdqyE8dgKVru/MTE=; b=cZMineVwQnmC
	qES79/hGlGG1E2Phc+Ncuq2XWjpNM2Exjl/UiUvwf49MIS6plWn4soGiAkZ4LW2z
	gsxt8bsaCNoYEhxqOlX0Sk3YE3EukXIBsZvs1ihxrIA5OQdWtARcwtFlTsbIo2aY
	tY03gSasEHYfm6eGr4eU0y+iFzsYUK3Qd3mx3OPLA8aD+s0sjvF5EgBnCV+AP5Kl
	AOQFv0S8Wn92Yvj2wFQcRcAZ0g5eHUvEI53WNSEDIl3v67cS5gCiMmWo7sN8NgAC
	Ie2jukANWqpJtFMvLKGbAKu8aSVYwSNasK8BWIPg0tLqI1ycPNMiFABc++PtOT6C
	wjvA0Pisxw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44ndt0rm85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 01:42:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZOVIYbW4kgmsGZZ3st0d7ED/jktn4d2ibNE8J+Timv/ah74mBLi3t8Ck0XONiedWbWJ2e50HflkBH6wrhVj4QPegcG2wckOp5ENXhiB1SlsSgEKKErbLEfgNVbQVsGaLqsHJ20h2Kf4opVluPufGWJvgqPu2VB6+pRrPLIqaUtuDMNEgIB0dy1Yb3Kti4ad0xhaqoYNQ8jIyd5ZHzghy0UFuqZM0O9nogViFczTwVSKkMUFPi4d51SfJX5yYGoIYvgsOCg96LHDYQZkCVzPpzh1juHflUordXiCCfTrV6IHRQp6S/o4ivJU8cN+XHl6tg/nABtg++zR1efD6wo3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RctRab4QuOAKG4YasdaNrGuLp3zXdqyE8dgKVru/MTE=;
 b=PQYufRPJtEiFpzNaL1wFb6GeMiljDOkYmzF//oMpUC4Ls1UH7TWsYHu39Nj0F18C17h2qoU/NBYaDj5oR86aA7/DtzcVx59ECaQoT3waDpjgE+BFoRvselP59Jvkkh8VjOSmmzA45t8PwDphhaNi4phVw4ihG/18PnY16qohsUskeR3YfP1HmsPusjLvhXHzJgcfwBzdnzHp/JDWaPOCeTzll9639W5cAZjJ9aY5zua7Cl/0nJR3mu3v1OGQnm11aS4pSwl8pghbvrhQZoDjssOAKx2xYG8Zj2xnBIiet7V8HuOZSnd/QlPtnP2aEss50/6JdrUf26hiF78SXgjqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RctRab4QuOAKG4YasdaNrGuLp3zXdqyE8dgKVru/MTE=;
 b=P92VnMn0T4WsSeBGZYKoi2+MHnxxW0BcuzGheJwiMhmlbsNeOsjFP6VMSWQ4GninclqZU1klJHTRtNwDXQq3aDW3Q4SltUir5IvOTfoVnuC+DKM/MrJz2ZWJ39yNoaX8BFBc1VYa3F09KuBTIUWMGxqUfcOJCawkAmFz0Ua4Eow=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BL3PR07MB8817.namprd07.prod.outlook.com
 (2603:10b6:208:350::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 09:42:44 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%7]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 09:42:44 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [RFC 3/3] PCI: cadence: Add callback functions for Root Port and EP
  HPA controllers
Thread-Topic: [RFC 3/3] PCI: cadence: Add callback functions for Root Port and
 EP  HPA controllers
Thread-Index: AQHbeUJ70j53gmI0/UCefC+2kcf0nrM7loqA
Date: Fri, 7 Feb 2025 09:42:44 +0000
Message-ID:
 <CH2PPF4D26F8E1C38302AC2FDD4233DD652A2F12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250207092645.3140461-1-mpillai@cadence.com>
 <20250207092645.3140461-4-mpillai@cadence.com>
In-Reply-To: <20250207092645.3140461-4-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kZWQ4YzBmMC1lNTM3LTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcZGVkOGMwZjItZTUzNy0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI0NjM3MiIgdD0iMTMzODMz?=
 =?us-ascii?Q?OTQ5NjA2NTI0MTQ3IiBoPSJNNE5QN01rVzVicWlqcnNNS2lqYW45ZUFGaW89?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFHQUlBQUR6TkMraFJIbmJBV1NoRUJaU1QzS0haS0VRRmxKUGNvY0tBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBc0JnQUFuQVlBQU1RQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQWhGVjh5UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR0VBWkFCbEFHNEFZd0JsQUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhR?=
 =?us-ascii?Q?QWFRQmhBR3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVpBQnVBRjhBZGdC?=
 =?us-ascii?Q?b0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZd0J2QUc0QWRBQmxBRzRBZEFCZkFHMEFZUUIw?=
 =?us-ascii?Q?QUdNQWFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQURGQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFIQUFjQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY3dBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFa?=
 =?us-ascii?Q?QUJsQUY4QVpnQnZBSElBZEFCeUFHRUFiZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?us-ascii?Q?QUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JxQUdFQWRn?=
 =?us-ascii?Q?QmhBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?RzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBY2dCMUFHSUFlUUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUF4QUVBQUFBQUFBQUlBQUFBQUFBQUFB?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUNBQUFBQUFBQUFDa0FRQUFDZ0FBQURJQUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?aEFHUUFaUUJ1QUdNQVpRQmZBR01BYndCdUFHWUFhUUJrQUdVQWJnQjBBR2tB?=
 =?us-ascii?Q?WVFCc0FBQUFMQUFBQUFBQUFBQmpBR1FBYmdCZkFIWUFhQUJrQUd3QVh3QnJB?=
 =?us-ascii?Q?R1VBZVFCM0FHOEFjZ0JrQUhNQUFBQWtBQUFBeFFBQUFHTUFid0J1QUhRQVpR?=
 =?us-ascii?Q?QnVBSFFBWHdCdEFHRUFkQUJqQUdnQUFBQW1BQUFBQUFBQUFITUFid0IxQUhJ?=
 =?us-ascii?Q?QVl3QmxBR01BYndCa0FHVUFYd0JoQUhNQWJRQUFBQ1lBQUFBQUFBQUFjd0J2?=
 =?us-ascii?Q?QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdNQWNBQndBQUFBSkFBQUFBQUFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QnpBQUFBTGdBQUFB?=
 =?us-ascii?Q?QUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVpnQnZBSElBZEFC?=
 =?us-ascii?Q?eUFHRUFiZ0FBQUNnQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FB?=
 =?us-ascii?Q?WlFCZkFHb0FZUUIyQUdFQUFBQXNBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxB?=
 =?us-ascii?Q?R01BYndCa0FHVUFYd0J3QUhrQWRBQm9BRzhBYmdBQUFDZ0FBQUFBQUFBQWN3?=
 =?us-ascii?Q?QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSElBZFFCaUFIa0FBQUE9Ii8+?=
 =?us-ascii?Q?PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BL3PR07MB8817:EE_
x-ms-office365-filtering-correlation-id: 249d007e-200b-49a2-13a5-08dd475bc60d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GKDK8GMCvAanZAWQS9fEIfhQDTBGXvm/w2riEE5oo4w8kYuLnSVWt9HnMLah?=
 =?us-ascii?Q?VVjg77v40xf65GHo+vDNxDQH9KRwG1c5y1idiuOqtf3oSZz4eKktwdON+mKA?=
 =?us-ascii?Q?tQ6GTbkXoPbeGzG7JMYKug4n9zOo98HM3dX7yfYp2tC9KNQWRgFxTCLSkhsc?=
 =?us-ascii?Q?pvx7Koda0VKktNb6KVOv+uKTBqXizHqg/P6yDsQHvi8t8Y9IIQsMAJhxE6y3?=
 =?us-ascii?Q?q1sM+glwxmlBf2rcsthZiK4uRdrdGCvAVuiLVfX1nrdzf79uQ5Ps5bgbCI7k?=
 =?us-ascii?Q?XNfvEFlqGYoX5mz6JnETA3NhiiWrEvTEgD2EKfCRkfmCoPbVcmTZR8bBVqEL?=
 =?us-ascii?Q?T/YdnSNCaEsFENe5kHaNUlNi3aWjMZtYwZY3PmA3u7m+L9PsfOqzS6vXkOy4?=
 =?us-ascii?Q?0AvEHP6zHBRZoynZ4nDtchUkGNlyUKUMP5D6ZajZtCmJHkwkCasX5kgnAq+M?=
 =?us-ascii?Q?vL6o8RyF0UlEQQuet533cJIbIl2R+5SV3ksjCLWHsD5aJlkQm1fer9yAXKWK?=
 =?us-ascii?Q?Eq31qd+qNY0Lw5NO/mGzCc9PvzJvPex6DFmR/N4vl+Wcb6gCKmZft+WgMIv7?=
 =?us-ascii?Q?jYnt/zqf3EPGpf000w6AMB6NjAaFv/YavUzL3T9Ox81wFjzRCPExL+k0FmGD?=
 =?us-ascii?Q?fYyJoNYiTSsqpdu1WRVrEfH2Y+mhsAG26nfJjZN5UvgsXec6H9BfMiAmna6m?=
 =?us-ascii?Q?mEvICYnqcmcFGS6XjXvhSyDJ6RwT4vb2dJzy4Dugu0lH/RNwhqbD2mcg8r16?=
 =?us-ascii?Q?VJCGmzBmMBF7cHhmPHjva27flUOnNYGUdXXtfb0/zZrBuaRYHlVBPV7V7i+0?=
 =?us-ascii?Q?FUjy+ZniDFAbJfNV2ZjPl7vwiAtljUgDRy2N/mw3lUVsge/v6PG9Y4e6CLqD?=
 =?us-ascii?Q?coXeIkiQryZoKBkxDFCaZLbQt6DSWtWUrKi7+PYQhgkVg7xqfGV5somkW+uU?=
 =?us-ascii?Q?vV4w52gxovOdUvKT0I934xa9gpXzUueGLP5WwnXxqCGW6OUQqlYiG00hZoAZ?=
 =?us-ascii?Q?yf8iQ2CwmhsgnaMl63ni3aqhQL0WU3q9PVA1wftmYHpmXngjvRQrJ/YTR9k+?=
 =?us-ascii?Q?WdNSkTzk4larJb1LOc4trjOAjPBDf0pmDqlS7LD/NERS6jjfaNaH+Mqp3qcH?=
 =?us-ascii?Q?1j7Y7cYzMzik/DPi4ZdklsCv2P45QCz8ErGMfqD4rUc8d5opLc7q2k+GVKZ8?=
 =?us-ascii?Q?jjEC8jiJ+XnjrKtzZ8cZ8Ycx4HsSJxygzgeHSvTjzcc4sp7mNgjkdpZhkZDI?=
 =?us-ascii?Q?+Qo3QwALP9SSGhuIfcIz9G2KValw21zBlbNZf1DBNJ6CnTUMymjg+QWnVv6y?=
 =?us-ascii?Q?59B4O+Iah40HFZyBSWBXKpCP8Fsd/tVnPVTBTkhJ1eRe2IGdeXRAPy9lRwSo?=
 =?us-ascii?Q?DsXRFeCf5T14KCuqhwnYvXKb3JJJrHcq6/pNddh/17HvALTt9yqH580dthKt?=
 =?us-ascii?Q?xHYV6HcFACNkSDc21+64R96iw7HWsH+F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nVWZV+e5nlXukNMV9I9E3d9hYrntwppEEaIoQoiSWSBIv4HeqPbpMODSjS3K?=
 =?us-ascii?Q?WoJEpQBYpJONAidz1xoKoshZTcX0No7BW/BQDvjx6hUrueNfX69dBWVZe1Cs?=
 =?us-ascii?Q?PrMeBGJKCs9m66clfkalbSRs0fbMtaPAbc3UsysjjurJiYlgCv+HUJPkMo6m?=
 =?us-ascii?Q?4snVxJgJZ5YWDLblUAX1nphNqNDsbQAiC2aSJ3xFONnqEGUVZCeMeQcpVZV7?=
 =?us-ascii?Q?GtGz/SNcamy7QjwWXT7NWbF6p4zV8ykoOi7w1aRyVAJfyeiKzr1502onqYbS?=
 =?us-ascii?Q?2Ai+uVjvpb/wTuu1/1la/HFrDHYAokrrr02sQ+PiNiMBqfw086wit1KsXj60?=
 =?us-ascii?Q?OClJu8qlCLWR750q52wOVAPkFfl4vzjn+rB/tMQOK/w8G42HQ0AaD93HJ0ZS?=
 =?us-ascii?Q?/j2FR5iGWpsjt2I2pEKkSYI6aB7GWg9MTPed3bxbGwA3C/pasIl4P3oSB+kP?=
 =?us-ascii?Q?0cQybZhdd30pKqqfcNrpiTKCxejuLU01ilw4Hh2B0suuDTB6cMwd9plDqDza?=
 =?us-ascii?Q?eAhJKD60pa2xeiuHJmQ/uALGrn3gCbySMIuQ/6v2lpBVCsLRWPyzQ2g2M3ki?=
 =?us-ascii?Q?aXMLxC7sOFo4qNEZexEwioQTgX35EnUvq6HYGJJO5pLUN25PZkn+tXGd+bYn?=
 =?us-ascii?Q?Ojlv00B5pShWVn9fQZMJ5NNOpOqA2UKGRV3Oek1GDgZGnqArCZSsGv6gQ9NA?=
 =?us-ascii?Q?x0vEuqN47mIMzydgrENoaNujs/lwzFsQuaYWsG743RVTSAbjhCV7a1BcmrfJ?=
 =?us-ascii?Q?OB/GF7j+cMYgg9wFRSlBZouS+e+Njmd33PNx/CBcUHuS0rS/B9+mFMvm+Frc?=
 =?us-ascii?Q?Ydl5ryKPR/RdLfBhJy7/V9SgV6m6l/gFojGe4Ue0xCL4VAoGQcV6thsLGoNB?=
 =?us-ascii?Q?RZ/9gGZ96uf3rjUGuYBwE6YAxGccddZ/cEp4HuaasgkeBNem09zRVcn20vTG?=
 =?us-ascii?Q?Z2KwLIurwWxGRr7aWLyS/z18IU5mcXWnge87bkiF4B7dbXGkmZfv+TG9VCpz?=
 =?us-ascii?Q?WLFMjgOWWPVXxcA9tZ9LvRYqsDYdywCIqC7IbBp2QIz3wFInLihsCkP28R6C?=
 =?us-ascii?Q?ZcPXobjiGHhNpevYIhEqWvTacY4Xeoo7kUA2tzxXkOGyTG4a7BKSbZQ0FlHs?=
 =?us-ascii?Q?vbnqBJNkHvZm2uBPtCPoJ/qqG8BEbOR5+6GkYu7/iQPYeGXRmFF4023jdcIO?=
 =?us-ascii?Q?0GBZniM5PWr1SioyT5r6QLHHyqZUBvXWchPXx14ZcgnkGMx7WIOetbQpKKqD?=
 =?us-ascii?Q?HYw+naCXvA2/VMcmz9zim0TYY9n5/8CDL9eak8HvdnDAZApiiLj4Wv1LQle/?=
 =?us-ascii?Q?k+Rd+DF494hZDZpaN6txvw30lWL1d0LZJqaUfucbaCNZ2t23AshYfQURLA+Q?=
 =?us-ascii?Q?LJlGLOj+IZWIIWToDV3x7rRdLtj9IUQ6ikbe2ECwzLxRnnX28yZqkNjFx6ic?=
 =?us-ascii?Q?vEkwQzn216sqZHNeXUPvFir3Qx1crm1hHwVyHf4idsxut4nQ3CJIJ2cqxql0?=
 =?us-ascii?Q?xvT+IvQxMkIfskcrqp/E3GdchUEvllQvjqVcyx7l20aiVitlEiep4d4ooW51?=
 =?us-ascii?Q?tIVajQoSG/t2mREosf3o9bObfzDiKc7r79qwT4LQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d007e-200b-49a2-13a5-08dd475bc60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:42:44.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FI/ba19QNLPpwm7uMe2W+oTo7wgDAQsBJGtoQVyTPOmEhVkqwp3irflRLRm/+xa5471r5LnkZxL1nTmDj+4bSJ0AJAlZ5S2x/W3nnpSGALI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8817
X-Proofpoint-ORIG-GUID: nTRewmxuPoL4OjXYwKZOVLPQsN2G_1FN
X-Authority-Analysis: v=2.4 cv=ZJ0tmW7b c=1 sm=1 tr=0 ts=67a5d596 cx=c_pps a=UnxCF3xIguukyKwtQsEHPg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=Eoq2wZs9ZSUw5P7FtuoA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: nTRewmxuPoL4OjXYwKZOVLPQsN2G_1FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_04,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070074


Add support for the second generation PCIe controller by adding the require=
d callback function. Update the common functions for endpoint and Root port=
 modes.

Invoke the ops platform functions registered during initialization for the =
relevant PCIe controller architecture for EP or RP mode.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  16 +-
 .../controller/cadence/pcie-cadence-host.c    | 237 +++++++++++++++++-
 .../controller/cadence/pcie-cadence-plat.c    |  21 ++
 drivers/pci/controller/cadence/pcie-cadence.c | 154 +++++++++++-
 4 files changed, 406 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index c911963b6e06..31ba454ff542 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -93,7 +93,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 f=
n, u8 vfn,
 	 * for 64bit values.
 	 */
 	sz =3D 1ULL << fls64(sz - 1);
-	aperture =3D ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+	aperture =3D ilog2(sz) - 7;
=20
 	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
@@ -192,7 +192,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u=
8 fn, u8 vfn,
 	}
=20
 	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-	cdns_pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size=
);
+	pcie->ops->cdns_pcie_set_outbound_region(pcie, 0, fn, r, false, addr,=20
+pci_addr, size);
=20
 	set_bit(r, &ep->ob_region_map);
 	ep->ob_addr[r] =3D addr;
@@ -214,7 +214,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc=
, u8 fn, u8 vfn,
 	if (r =3D=3D ep->max_regions - 1)
 		return;
=20
-	cdns_pcie_reset_outbound_region(pcie, r);
+	pcie->ops->cdns_pcie_reset_outbound_region(pcie, r);
=20
 	ep->ob_addr[r] =3D 0;
 	clear_bit(r, &ep->ob_region_map);
@@ -329,7 +329,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_e=
p *ep, u8 fn, u8 intx,
 	if (unlikely(ep->irq_pci_addr !=3D CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn !=3D fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
+		pcie->ops->cdns_pcie_set_outbound_region_for_normal_msg(pcie, 0, fn,=20
+0,
 							     ep->irq_phys_addr);
 		ep->irq_pci_addr =3D CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn =3D fn;
@@ -412,7 +412,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_e=
p *ep, u8 fn, u8 vfn,
 	if (unlikely(ep->irq_pci_addr !=3D (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn !=3D fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
+		pcie->ops->cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
 					      false,
 					      ep->irq_phys_addr,
 					      pci_addr & ~pci_addr_mask,
@@ -515,7 +515,7 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_=
ep *ep, u8 fn, u8 vfn,
 	if (ep->irq_pci_addr !=3D (msg_addr & ~pci_addr_mask) ||
 	    ep->irq_pci_fn !=3D fn) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
+		pcie->ops->cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
 					      false,
 					      ep->irq_phys_addr,
 					      msg_addr & ~pci_addr_mask,
@@ -633,7 +633,7 @@ static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc=
, u8 fn, u8 vfn,
 	/*
 	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
 	 */
-	aperture =3D ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+	aperture =3D ilog2(sz) - 7;
=20
 	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
 		ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS;
@@ -869,7 +869,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	set_bit(0, &ep->ob_region_map);
=20
 	if (ep->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
+		pcie->ops->cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
=20
 	spin_lock_init(&ep->lock);
=20
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/p=
ci/controller/cadence/pcie-cadence-host.c
index 1e2df49e40c6..7acf401158e6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -73,12 +73,76 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, uns=
igned int devfn,
 	return rc->cfg_base + (where & 0xfff);  }
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_LINKDOWN,
+			 cdns_pcie_readl(pcie, CDNS_PCIE_HPA_AT_LINKDOWN) & GENMASK(0, 0));
+
+	desc1 =3D 0;
+	ctrl0 =3D 0;
+	/*
+	 * Update Output registers for AXI region 0.
+	 */
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0),=20
+addr0);
+
+	desc1 =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
+
+	return rc->cfg_base + (where & 0xfff); }
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
 static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)  {
 	u32 pcie_cap_off =3D CDNS_PCIE_RP_CAP_OFFSET; @@ -340,8 +404,8 @@ static =
int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
 		 */
 		bar =3D cdns_pcie_host_find_min_bar(rc, size);
 		if (bar !=3D RP_BAR_UNDEFINED) {
-			ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
-							   size, flags);
+			ret =3D pcie->ops->cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
+								      size, flags);
 			if (ret)
 				dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -366,8 +430,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_r=
c *rc,
 		}
=20
 		winsize =3D bar_max_size[bar];
-		ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
-						   flags);
+		ret =3D pcie->ops->cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsi=
ze,
+							      flags);
 		if (ret) {
 			dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -408,8 +472,8 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pc=
ie_rc *rc)
 	if (list_empty(&bridge->dma_ranges)) {
 		of_property_read_u32(np, "cdns,no-bar-match-nbits",
 				     &no_bar_nbits);
-		err =3D cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
-						   (u64)1 << no_bar_nbits, 0);
+		err =3D pcie->ops->cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+							    (u64)1 << no_bar_nbits, 0);
 		if (err)
 			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
 		return err;
@@ -467,13 +531,156 @@ int cdns_pcie_host_init_address_translation(struct c=
dns_pcie_rc *rc)
 		u64 pci_addr =3D res->start - entry->offset;
=20
 		if (resource_type(res) =3D=3D IORESOURCE_IO)
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
+			pcie->ops->cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
+						      true,
+						      pci_pio_to_address(res->start),
+						      pci_addr,
+						      resource_size(res));
+		else
+			pcie->ops->cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
+						      false,
+						      res->start,
+						      pci_addr,
+						      resource_size(res));
+
+		r++;
+	}
+
+	return cdns_pcie_host_map_dma_ranges(rc);
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc) {
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	/* Set root port configuration space */
+	if (rc->vendor_id !=3D 0xffff) {
+		id =3D CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
+			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
+	}
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
+
+	if (bar =3D=3D RP_NO_BAR)
+		return 0;
+
+	value =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_LM_RC_BAR_CFG);
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc=20
+*rc) {
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), addr1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0),=20
+addr1);
+
+	r =3D 1;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res =3D entry->res;
+		u64 pci_addr =3D res->start - entry->offset;
+
+		if (resource_type(res) =3D=3D IORESOURCE_IO)
+			pcie->ops->cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
 						      true,
 						      pci_pio_to_address(res->start),
 						      pci_addr,
 						      resource_size(res));
 		else
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
+			pcie->ops->cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
 						      false,
 						      res->start,
 						      pci_addr,
@@ -489,11 +696,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)  {
 	int err;
=20
-	err =3D cdns_pcie_host_init_root_port(rc);
+	err =3D rc->pcie.ops->cdns_pcie_host_init_root_port(rc);
 	if (err)
 		return err;
=20
-	return cdns_pcie_host_init_address_translation(rc);
+	return rc->pcie.ops->cdns_pcie_host_init_address_translation(rc);
 }
=20
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc) @@ -503,7 +710,7 @@=
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 	int ret;
=20
 	if (rc->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+		pcie->ops->cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
=20
 	cdns_pcie_host_enable_ptm_response(pcie);
=20
@@ -567,8 +774,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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
index 98ffd184be93..26d54162a95f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -35,6 +35,26 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pc=
ie, u64 cpu_addr)
=20
 static const struct cdns_pcie_ops cdns_plat_ops =3D {
 	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
+	.cdns_pcie_host_init_root_port =3D cdns_pcie_host_init_root_port,
+	.cdns_pcie_host_bar_ib_config =3D	cdns_pcie_host_bar_ib_config,
+	.cdns_pcie_host_init_address_translation =3D cdns_pcie_host_init_address_=
translation,
+	.cdns_pcie_detect_quiet_min_delay_set =3D cdns_pcie_detect_quiet_min_dela=
y_set,
+	.cdns_pcie_set_outbound_region =3D cdns_pcie_set_outbound_region,
+	.cdns_pcie_set_outbound_region_for_normal_msg =3D
+						cdns_pcie_set_outbound_region_for_normal_msg,
+	.cdns_pcie_reset_outbound_region =3D cdns_pcie_reset_outbound_region, };
+
+static const struct cdns_pcie_ops cdns_hpa_plat_ops =3D {
+	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
+	.cdns_pcie_host_init_root_port =3D cdns_pcie_hpa_host_init_root_port,
+	.cdns_pcie_host_bar_ib_config =3D cdns_pcie_hpa_host_bar_ib_config,
+	.cdns_pcie_host_init_address_translation =3D cdns_pcie_hpa_host_init_addr=
ess_translation,
+	.cdns_pcie_detect_quiet_min_delay_set =3D cdns_pcie_hpa_detect_quiet_min_=
delay_set,
+	.cdns_pcie_set_outbound_region =3D cdns_pcie_hpa_set_outbound_region,
+	.cdns_pcie_set_outbound_region_for_normal_msg =3D
+						cdns_pcie_hpa_set_outbound_region_for_normal_msg,
+	.cdns_pcie_reset_outbound_region =3D=20
+cdns_pcie_hpa_reset_outbound_region,
 };
=20
 static int cdns_plat_pcie_probe(struct platform_device *pdev) @@ -104,6 +1=
24,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
=20
 		ep->pcie.dev =3D dev;
 		ep->pcie.ops =3D &cdns_plat_ops;
+		ep->pcie.is_hpa =3D is_hpa;
 		cdns_plat_pcie->pcie =3D &ep->pcie;
=20
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie); diff --git a/driv=
ers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/=
pcie-cadence.c
index 204e045aed8c..9035a7312a10 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -5,7 +5,6 @@
=20
 #include <linux/kernel.h>
 #include <linux/of.h>
-
 #include "pcie-cadence.h"
=20
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie) @@ -147,=
6 +146,159 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, =
u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);  }
=20
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie) {
+	u32 delay =3D 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
+	ltssm_control_cap =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0)=
;
+	ltssm_control_cap =3D ((ltssm_control_cap &
+			    ~CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0,=20
+ltssm_control_cap); }
+
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size) {
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r),=20
+addr1);
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0); }
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0); }
+
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r)=20
+{
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), 0);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), 0); }
+
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)  {
 	int i =3D pcie->phy_count;
--
2.27.0


