Return-Path: <linux-pci+bounces-24507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51D3A6D717
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2771893625
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77725D8ED;
	Mon, 24 Mar 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PYJ9kwAw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="3JaQLEI5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4F14EC46;
	Mon, 24 Mar 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807548; cv=fail; b=pvQ8rdseJ8atJCfFsvoHb6dl4MSdEmO6gFf0GW6NfBKthniH/ci/fZPWKV3b3c7Hy6zlwrPi54qlwfVhzBCgvViiRk3UuzekshDeIqi8LCo7hAkMqXo82Mpe3tskaNMMtwu4RrPLj2djs5ZebexONBPRUKQn+F4GQB4VzsLu7qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807548; c=relaxed/simple;
	bh=9yocXLkOMtExPwYkJku2iqD6tkb4UwgoqSEtwAvIvbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrvexvCtiILyx8gFKeBfgC4IJ1AKJpgyUuk6GkgtXNCcnuhp9LD3ywz9duSHk+lgeTnA82LyF6c8ZdhVmr95Po87T2ktvtQiEBGvz476RsRRHWiapYcokIK+zympMN0RBfhyU1ZGlgiw1qvNz+H14F8Tt8BzyZZVyK2QgvhEXvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=PYJ9kwAw; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=3JaQLEI5; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NIJgOK002595;
	Mon, 24 Mar 2025 02:12:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=0WZazG3Xfek7l+64ofbe+tx7G72DGb7XlfbCqXckk7s=; b=PYJ9kwAwwY5H
	2nj4X2K/3f2vqt77mGxz0l72upFXc0DqJ1gQne3ghlWg/YpJVOBL1wjfIOoNZ1jC
	wX7ztZCPYprGNo6RQotVWhPJLlfxkegKGtVF69YD6S3RQrWDidQTVwvhKQrB7GqU
	8LSg6IHJZZHFWqMZbXGxzYpOK6Zi7+9bigwMmFAuGJih5pAv5ToGQybXaKg5hIUb
	7hdkMDKgGmCuLOu+XwNHgdE/CN+7PetziPP0bND9Wv5r5v2o+UEQd2LdzI1uJNeI
	CXPuVT0g8jF1/ltLwx/6YrhildfncpBtJfHCX3XWBfakB6+jR7aaGA/tFO4BO0lW
	VLr3RKQUvg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrw4x6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDeWDJXiSaAbDOaSCfbFJcpbbaqK2wo9gJb959qi5kCu27orhcVswCL3E7vOdIr4pgznJ3ZmoHVDr0MeRY4LO4O9822DX07ggO9ZhWkC6BjoptjfOmcXPkNQrz2Nn+7OzihppLXUvSeeT5wVubN3Kc/bphEpAflGFAoqfHIaNSMB9Qp/3kGbXbzjt23Ti3MT8iMO5GiI38kzZCCNjcFkl+P7O/PNJsHURobWWEbaUk8E3F2TljLYby5yIAB9VY37eRRujRyocsoI7c1iNA+EjmgSyrKl8B6xV76anu7CMzrEIqnJyX/fY7i1m/mASpJ+2WTAuQP0WetSr6YGGzmJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WZazG3Xfek7l+64ofbe+tx7G72DGb7XlfbCqXckk7s=;
 b=dnszwWLt77N90shVvaoWtowfBnc2OQpJPjKqkW0EMKT3yQo4gb+R/v9OFnxxinuFx1gVwTHTof7/saWWDrxVXioTNvx2iHGp9xA1Kue/v6jzyAKGNV889J1oZ0zQyArHbP7TWqs5ibD0bhplr/92jWxEPPFkuR0WprxkRG4j+QAN9YKhJ+Na8JPjJpUMUeqsZiHm/IXtuglB4P1HEFTrv7nMc/0DzP3s2EHdsE0XLciZ6bC4qNVqQLoPVmiqpkmV5I0CGhofkHGOYeeNdtH+ThLpQ/183Z3A+tOMvrCQq8WPTzZ7ICMAvT5t8zbyo7W2u+ojaZD2yTOBVEXFMJa6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WZazG3Xfek7l+64ofbe+tx7G72DGb7XlfbCqXckk7s=;
 b=3JaQLEI5TNSnI7BYSJWJpNmqhu7tI43PIkJSsQ/joQzxtX5KoDeMrm+nGx8eDfPPVeZLnr8CzlSZiIueAXphvI37RKBdaPintjwnXLCY6/8QS7gTnLLiGY42SuIlkZBqdbji7l7EiJuppy+oGkc7JUizULq1rpwB3McgZT1eXPk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:12:19 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:12:19 +0000
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
Subject: [PATCH 6/6] PCI: cadence:  Update support for TI J721e boards
Thread-Topic: [PATCH 6/6] PCI: cadence:  Update support for TI J721e boards
Thread-Index: AQHbnJZTOhJ6m6YFzEeA0hubAfDS9rOB/lyA
Date: Mon, 24 Mar 2025 09:12:19 +0000
Message-ID:
 <CH2PPF4D26F8E1C8DB1C7AB88332A3C454DA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082504.2566351-1-mpillai@cadence.com>
In-Reply-To: <20250324082504.2566351-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xNDY1Y2QyNS0wODkwLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcMTQ2NWNkMjctMDg5MC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIyNzY2IiB0PSIxMzM4NzI4?=
 =?us-ascii?Q?MTEzNjkxNjQyNzYiIGg9ImR2TFVwcjN5VHdhVTVlRXpWaitGT244MkU0QT0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUpBSEFBRDA3YjNXbkp6YkFSU1JiNUR2RWxvM0ZKRnZrTzhTV2pjSkFBQUFB?=
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
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH7PR07MB11228:EE_
x-ms-office365-filtering-correlation-id: df2bfd8e-be01-48af-1d4e-08dd6ab3facf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BQ9xFRG0L9neLOyu3mQTA740M3FF6i+uav3rnfAvdF4TpfFLTbl4gd2XBxhD?=
 =?us-ascii?Q?KqUd/iUG0dDKxoTSHCKLjjq1HEt/b3p1K3zbEPYu/CiXtclpl32EiCygvSNT?=
 =?us-ascii?Q?iIIAhaIDWPtk9ToZw4Lg8SH534jsD8HsxK7fEHxcbGOodU3RvuuBqkOj02X+?=
 =?us-ascii?Q?PcrflQLbeLG15hxF6mheNeDLLhA4rIqBHMrv276CEmlbeXM/q/3JPoIfTnwz?=
 =?us-ascii?Q?j+e92yrgHyfOGY5LgL4KPnTni9qDJ0e3AGKVas4Qf2AJa0JGgu4zDpKtWKKT?=
 =?us-ascii?Q?EC8WTtq1aT7zLpen07h9a8Rxo027T8SBftSM1VR1TY6lkI9SgR4CSPM7yILJ?=
 =?us-ascii?Q?32KKQK5p4L+SGkdwgL3QkLzqbBnnhdwi/3RaVyWjW8llrTPLfPSMcF8OwDQF?=
 =?us-ascii?Q?EE5H1Q8Ieg3remHc6FXEDOeY46nK2GK27xh7waP4PiKXCMhrQRdgza9WOkGR?=
 =?us-ascii?Q?BOTqkyWjsZLpQmyNVK3W4zZIcey9X8+RU+8luilJuvDDDw50bYkMHxGrqesM?=
 =?us-ascii?Q?gQY59hBBQATyAzlYZnBVN+XJS98c0sLc07eNrgQ9qU+QMszMwYex3YB008xp?=
 =?us-ascii?Q?K+trNLymikBMPw1OucgI+frSeTN2X81jAfkXCA6+G49MCiZYPbblftKjNNlW?=
 =?us-ascii?Q?FZKvHb8dfxtgBulJl1u7a6s/W1ewwCjuCsz2duWZrwBZFAnfqU6iGEPuJat7?=
 =?us-ascii?Q?HrsnKcoQHTuR4asYxIjhXMalKuYsxRP3nK0wDVaC6CoY+L74nw6V3+u+VZjw?=
 =?us-ascii?Q?S2WnEuDcmI5Mamzf2jmJGG/1/v7u311vN1cE2M8KpN9DyIWYPQoeCIHKGKJa?=
 =?us-ascii?Q?mozt7h602eGF6S79FyW47wqi2itYkFQOMyDUOGPr/S7Tq83hIW5CZP6UKEEm?=
 =?us-ascii?Q?FWzHuHdiMIyedMGfmR1o/jV+PzxWV1UXw1nlmC6XdG8iUJV+p8lf+yHpJLxi?=
 =?us-ascii?Q?4DQ7N8AKs7oiTZL0xyyOFLbTMcuHFnreelagMnnncAp/VGtBR1IKXJpbAFqH?=
 =?us-ascii?Q?m671MITW9vpF1ZMhQH9Qa7CRqB7+7HTHG0v4CDmo+uj6ZXb6IXU53cyXe073?=
 =?us-ascii?Q?UoazF7oDtNLoTsnWaqPrAktKx6vlzj5DRDuzIX2JWCcXtgjnNoSv6e08uscm?=
 =?us-ascii?Q?1r41SKuKpceep9tCTn6R6RhLYMg7XlvRCr38Hx7INb/Zatoc5eH2w8hDHZdp?=
 =?us-ascii?Q?cTotsDinVzfgYDkFs1xEz36Ih7+TGi5RjosmujAWg3cru/RfNZdyD0O07JbJ?=
 =?us-ascii?Q?hz6wagcmpq9mWHoXINOkvc8IifE9tAgG/TUWCG/BweTonAdDkZLlHNNjDdX9?=
 =?us-ascii?Q?9Qb4I7jprb+zchgAFKWAWJZDzWXat6Bscmc3vw5b7ZRqiaU+uQ80iPMvRDpk?=
 =?us-ascii?Q?vMKKORvbeDK7wq3F8fUNcFUfZVvQGe1xGprS7k/ICrdQ8YXl5y1+ojKPMPI4?=
 =?us-ascii?Q?wb4xoRplmwiNyRk7hosiITLKYX5sCWQF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mztHOgPhH2nqTp5UtnoKIeCzoy5Jh+F619bD3hWibVGt2EjifAhY1i06KHUb?=
 =?us-ascii?Q?ZDNZB5WQpVrAm+4OJXa5SBXk0wgHAam0TvnPm/qk1JFTpPbdupx0sTMVrbbP?=
 =?us-ascii?Q?SNtSEXFB4i3MiKa619DAH0Tby2Msx9FTwYoIrSUuxPVjZ/bk5r53tanZ5/g0?=
 =?us-ascii?Q?1xqOxke8PgsxkUvMIVEJ/H8xAe4rye4VZgdHziuKdFE22UzzIQ01nhK/q51+?=
 =?us-ascii?Q?Ml/Bo4vvPQl8lfJYfZKrvzI3A+gwP/RB0PGBI0b3LoFmks+CfOuQT2qPVJBq?=
 =?us-ascii?Q?ZSTGX5IlmTJ/FJ41di35b3RpXQ0IaWKLT4VmMOXnak7UzydpHbwpyewETMb4?=
 =?us-ascii?Q?DWDwVF7GHFhO1P5NKJb6+jAKNLkAdTfHVVn+Ukw9DKsmLVrC1RPgnlxz66Fd?=
 =?us-ascii?Q?Pbmm+nWg+u9EbedvpkvYeeNhzTuhQpmwlCD/b6jbmS3c0yQqGw1R9Mp0HyGy?=
 =?us-ascii?Q?6yCT/KPXaVy4Vb4IkVauTq9D+QCCba96kbRuqy+up1/GRjVfCIPj74asmsq6?=
 =?us-ascii?Q?yAeebXBhTXr0/oLmPLjSjKCoE/cu+9MO9S13shE+knQIBTwvEuwsGTVjx+PZ?=
 =?us-ascii?Q?BTyCEXpooc53WmGlBtG9CdzNfDZIy7rKOhNt2smE3ObtgclzEAAysGWeq6WO?=
 =?us-ascii?Q?V9dA3momArzwffKmJyspjcKIwpBh5VCGxmhpcsHSamAJQiq1fyhJB/lZPl/p?=
 =?us-ascii?Q?QCUlqT3dvp5OyA84TNQ880aHqyOQmES57LpmHTcS6zH8ezZ61ZX+Pw4Zz2CG?=
 =?us-ascii?Q?M4KcMK0LpxBU1OFSpnvlax2cQqRj6F3sn/GuCl4tYW8juk48bS5nVaXKw3wW?=
 =?us-ascii?Q?NrA3Yn6BKNbNYujrPy42nXlQv6VVUxRnt1B1REASZgJVrSgbek/1uvtNbcFu?=
 =?us-ascii?Q?/oGM12DwI0vgFv3/UxVOejeWTQP4oH/DsJNYcdp58OcrMhC+6BqmYBoQsPdN?=
 =?us-ascii?Q?UFgv/eLkoe0oZTYxG8PI7oGnU342w0iwrynacSIDf2s/NA7qEuv2eoxJjfDm?=
 =?us-ascii?Q?9V0hqmmvQyP+6ajkdtZkJnEuRmH9kcm56AQrgGYoKggXtEj2urC1xcC+cko4?=
 =?us-ascii?Q?7OpjoM1eC83xX1IKuvkIvVcm+9hb4iXIF3wSFVOyyvSzB2uOfYy20FxXrDDR?=
 =?us-ascii?Q?jEexNEIGwPasdOfTrkajjZcASJQDGT3sqnPo60KGfqnj1ax/RwjorhwPahzE?=
 =?us-ascii?Q?nVxTtpAL1UDSn1rLY2H5Bo6b+stVa7YD7A+FEGHsKyBQ2atMI115F/Pok/gp?=
 =?us-ascii?Q?Tf7oXq9fI4rq/0mKFkd/FLT2QcOlUuMXxdDCBrLmBYVRFFvyLCjcMSrm92z7?=
 =?us-ascii?Q?eKKMnTtIv/i6kpLXFeqHv6wkyjFH53H6zvgthlf8Ybu7Q0Jck4/rERwOwfXO?=
 =?us-ascii?Q?eeNZLn4RbGp+UfAvrJVUCf3qOlFJlj4smNK/Bz1lNAPoZVoKuhiYoBjWw1UG?=
 =?us-ascii?Q?yuoENYKN0sPLPD1didb4spUve1SuG32A0cDx+1DijSdgMJPBEalP45iKXJTX?=
 =?us-ascii?Q?BhYNz+9ScLnSvy85qNO1D+7NCjwn8YA5RTgzQdumV58obGjscnoKveyFoWW0?=
 =?us-ascii?Q?t4NHAX1LANu3SM/VeRr5lL/U2cDFsk4Hq6kEcLDs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df2bfd8e-be01-48af-1d4e-08dd6ab3facf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:12:19.5690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKBcfcOfKz8I0JJMmk2tD7HozpuOX294a0myGemRFERk1y2HbnmtYwhmO/tg9UHOqnfT9sVdGaY4/Hd67Yq/hYvfxASpRHcUuwzy6kTavqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e121f5 cx=c_pps a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=O9xH7Zzy3WR4EW-CiMoA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: 4ucGlolrHaljPi1zAP9b1oELJtQpAd8r
X-Proofpoint-ORIG-GUID: 4ucGlolrHaljPi1zAP9b1oELJtQpAd8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

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


