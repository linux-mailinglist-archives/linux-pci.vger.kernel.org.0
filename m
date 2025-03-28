Return-Path: <linux-pci+bounces-24908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE04A74326
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 06:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EFA189DE4A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 05:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E881AF0C1;
	Fri, 28 Mar 2025 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="OECaO/bo";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="yARZOj/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A101E4B2;
	Fri, 28 Mar 2025 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743138467; cv=fail; b=sLvs1NOd7kUT79daTfb2pS/IcqUMH8okaGH4WPaHg0sZCpeXAeuuE6h/0ON6ixMvSjUI7uacExw1KUGAGQ3tnGFWzbuRYbfAME/sHfzyVu0Bb3NX0ribTdh/dyBOWODgQqcoT0G3eD+yv47TiOsqskac2rl+/1mFJ6OInGIrtxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743138467; c=relaxed/simple;
	bh=ljy4eSeLxtPpgC50ATMS7TLhNRBz0qBxg3j+ij5PpeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASo91kJSkjVMHEEJMF2bOcOCgkDRL3ZirLUaqopINBHURpE2zsR5JXH4hX2ID52nhHg4z9rHsaeXuliiootsWkwjKvjIBTraZYvtnafXeVefM3vSCVVIUsJuX6+LwIKYQmvuwE4rCK638+RBW0onfxmm/D9ELhAEETlmeprqU3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=OECaO/bo; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=yARZOj/t; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RLnLZs007199;
	Thu, 27 Mar 2025 22:07:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=ljy4eSeLxtPpgC50ATMS7TLhNRBz0qBxg3j+ij5PpeE=; b=OECaO/boOyyL
	vi3xKWD8kL2uUzyyZKjh9PxwkDz7LD0rc+LfOqQj4RW8eczDjJgwQkOS7uuQ9B52
	3jpaF605XQF+6H6czAboUekMDoiLf0GLNohpaUw6l4RjFePbNBHFX1FcI4DOdBXs
	VGYZvVrEYP8y4waCTpXbKHT9T/GAfIJzG0r5qUk+OWxKLf0YflOLiNDJkuAlHGjd
	DomlTGIJk9EsxPWQGwEFJJG9PKDVMsdK07C6tP4oPveRerHmbiqnLEIvoeOWTmys
	2VUlUISJz++QnTwjOcjn5FJdTMudJfxVW1rGllTivaWE8vMQrgBJtnXs640h/BW5
	OrvwbmKxbQ==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrws3rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 22:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJqFvYRy1BoGZ/5soHJ/odM01RvPSTZh+2f75lDTSRfXzsZslXfLh37AB4mbzIgamhRDgwdyILmrym8p8f8GO9dY+4Bs0Bwfy2d3Rsp9ql2BxQXU07c5/yh6wYzbnvFBlLNn1GlL7751hYTuMSfoHB1BYZFL1eQHQMhdf40/678/Xo/2I9zVGUB9xxbxfUY3WD0aAE2MfVqv+BJiUUryqUgWdYTgCZEbrrwTuQVYKYOCKAy5eMiYrrb3tMGho8pRWLZ6YRvnvrGTpENMWRBwnjm8cfu04CjSo+wZ7ngJRDq3kWl7xqErLsQisdJKcKMtJ1i6yR42K8Kvj9VqfzaNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljy4eSeLxtPpgC50ATMS7TLhNRBz0qBxg3j+ij5PpeE=;
 b=BXJ3h8zRDbvQjqQ5Xro1WWR6B8Q8pw7P8wUGVgXinaSP2lpM15lV9PDVIJZHiegEXS5oaRF+EXQLyS/e//X5RkTNexCb99JLkKqH07rKGIPV9ZCDuhnfhxGQl6ZPcTrxERr1gxk+rh4C7TByt6jeBMU2STkB7m4Y8Qvw3XdzA5/NsrWRON8Iq0u7bvxpagAxcObA2D8Oudx7kdeOzV27Vl0CFhN9t05R5YJDsbNzWw/u0KBLLCXlyH0Y5gD53mBYcSJX5HPDgSOUc5BYUUfLVm4WtZm7Brb/opnaSfCFEyWJO4do/bUi+zhmTSaW+Zi9oFMl7hRmhh9OQLr1Z1gTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljy4eSeLxtPpgC50ATMS7TLhNRBz0qBxg3j+ij5PpeE=;
 b=yARZOj/tj682VqSkhGTfEJWpN6K3QfhcUPbDoGXbSsrvITaJMLEKl7ltAxC1oClAEkLGCWgOeBdxjCoOv1hTN39j9NUgetvYTSOTxIjC4ZtxefXmjc75j4f3s/kferSVX1EgBsl7Duq73jN4NXsujoBi7+6ybax6yW2wUQgkdHY=
Received: from DS0PR07MB10492.namprd07.prod.outlook.com (2603:10b6:8:1d2::21)
 by SA1PR07MB8626.namprd07.prod.outlook.com (2603:10b6:806:195::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 05:07:32 +0000
Received: from DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089]) by DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 05:07:32 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        Milind Parab <mparab@cadence.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
Thread-Topic: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
Thread-Index: AQHbnwj4B1ktiGdr2kiF1UawAazGKLOG1SfAgAAyHYCAAPaY8A==
Date: Fri, 28 Mar 2025 05:07:32 +0000
Message-ID:
 <DS0PR07MB1049293A9CDEBA2B3BCCED34DA2A02@DS0PR07MB10492.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111106.2947888-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <6a487a73-3f2d-4373-8e02-ba749181bdfb@kernel.org>
In-Reply-To: <6a487a73-3f2d-4373-8e02-ba749181bdfb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzF3YVd4c1lXbGNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MDRZbVl4TVRobE5TMHdZamt5TFRFeFpqQXRZVE0y?=
 =?utf-8?B?WXkxak5EUTNOR1ZrTm1ObFpUVmNZVzFsTFhSbGMzUmNPR0ptTVRFNFpUY3RN?=
 =?utf-8?B?R0k1TWkweE1XWXdMV0V6Tm1NdFl6UTBOelJsWkRaalpXVTFZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJM05Ea3lJaUIwUFNJeE16TTROell4TWpBME9UazBORGszTURF?=
 =?utf-8?B?aUlHZzlJakpITVVKRGRYVldTM0ZOUkU4MGNWcGFNaXRhUTBGMVVEUlZjejBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVwQlNFRkJRbXczTUZwUGJqVXZZa0ZTYUUxaWFu?=
 =?utf-8?B?SnpURkpRZFVkRmVIVlBkWGQwUlNzMFNrRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGSVFVRkJRVU5QUWxGQlFTOW5WVUZCU2tsQ1FVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZGUVVGUlFVSkJRVUZCZURsaFR6VlJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlNqUkJRVUZDYWtGSFVVRmlaMEptUVVoWlFXRkJRbXRCUjNkQldI?=
 =?utf-8?B?ZENja0ZIVlVGbFVVSXpRVWM0UVdOblFtdEJTRTFCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIwMUJZbmRDZFVGSVVVRmFVVUox?=
 =?utf-8?B?UVVoUlFWaDNRblJCUjBWQlpFRkNha0ZIWjBGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRV04zUW5aQlNG?=
 =?utf-8?B?VkJZMmRDYWtGSFZVRlpkMEoyUVVkUlFWcFJRbVpCUjBWQlkzZENkRUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRktORUZC?=
 =?utf-8?B?UVVKNlFVYzRRV1JSUW5sQlIwMUJXbEZDYWtGSE9FRmFRVUpzUVVZNFFWbDNR?=
 =?utf-8?B?bmRCU0VGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refone:
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVGblFVRkJRVUZC?=
 =?utf-8?B?Ym1kQlFVRklUVUZpZDBJeFFVaEpRVmwzUW14QlIwMUJZbmRDYTBGSFZVRllk?=
 =?utf-8?B?MEpxUVVoTlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkRRVUZCUVVGQlEyVkJRVUZCWTNkQ2RrRklWVUZqWjBKcVFVZFZRVmwzUW5a?=
 =?utf-8?B?QlIxRkJXbEZDWmtGSFdVRmlkMEo1UVVoUlFXTm5RbWhCUnpSQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUpC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCU1VGQlFVRkJRVW8wUVVGQlFucEJSemhCWkZGQ2VVRkhU?=
 =?utf-8?B?VUZhVVVKcVFVYzRRVnBCUW14QlJqaEJZV2RDYUVGSVdVRlpVVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVowRkJRVWhOUVdK?=
 =?utf-8?B?M1FqRkJTRWxCV1hkQ2JFRkhUVUZpZDBKclFVZFZRVmgzUW5kQlNHdEJaRUZD?=
 =?utf-8?B?YjBGSE9FRmlaMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRa?=
 =?utf-8?B?VUZCUVVGamQwSjJRVWhWUVdOblFtcEJSMVZCV1hkQ2RrRkhVVUZhVVVKbVFV?=
 =?utf-8?B?aEpRV1JSUW1sQlNHdEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reftwo:
 QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSklCQUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQWNnRUFBQWtBQUFBc0FBQUFBQUFBQUdNQVpBQnVBRjhBZGdCb0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUNRQUFBQUJBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFHTUFhQUFBQUNZQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUpnQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQWtBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQXVBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElBWVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR07MB10492:EE_|SA1PR07MB8626:EE_
x-ms-office365-filtering-correlation-id: 4911deff-2968-4196-61d8-08dd6db67211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDBDRVdSWHBwZVp2NXlvK3RFNnc0c1VXQUJ0RFo2OEhSV3dCdFZBemxtQ0dh?=
 =?utf-8?B?blJEbjkyVFZTUkFnYjFtaU1SRThyK29sekQxWGQ0a2NVVVlyd3BsdURJbGpR?=
 =?utf-8?B?anVMUjFFY2ZIaGZTRFM0WnZDazNocnZJaEZXNlM1ZDRHQXJidEVhWU9ld0VY?=
 =?utf-8?B?Z1Z3QTAyUTVJSG9oNXB1cGZSdWNjL1VZZHB6YjZFTHpmOUtLbC8yRUsxWEVF?=
 =?utf-8?B?UjlMTFhEWDk0Z0NmeHZlY2hzSXBZdWFTRGdVaW0wc1hFYWtaT2d5ZHJTNHAr?=
 =?utf-8?B?RVNHSFpoZzU5UXQyZDdMOEdwaGlnbFEwL1FWLzkyQkpyaHRjL3lRdUkrTE1E?=
 =?utf-8?B?ZHlCUHlYZTRXWHIrUkFaLzlST0daVUc3a3FJVHdtM202cUM5bXdJOGxUdlF6?=
 =?utf-8?B?KzkycWlxM3lKMWZreW9KcXhhN3ZFY09RcHAxK0FoaFROWFRPcTFub1BLSDh5?=
 =?utf-8?B?VmMzTmdQalFibGRIZUkvWWVvZmZYVG4rWXZiTDRJb1RiWk0vYUM1dXA3UXhn?=
 =?utf-8?B?VHhPdUliVDVKR28wNFcwdjNpSk9CdmdMMkNvazdzQnhpTXl5NmhsUU5xV1VE?=
 =?utf-8?B?cjczQU96UUpYMUJ2d3dJRStuaXpzLzg0QzFJRHJhMXhobHUwWnFmQ1F0MkhU?=
 =?utf-8?B?eUMvV1dwWWY2OHI2U1JpR1MvczAydGovN0ExeTdQSkQrcGdFRG4zZEtidEt4?=
 =?utf-8?B?Mm12V3QxZW43WGpkVEhLaG1aS1FwWkxjNGx2M2NYemxBZ05uL1pLaUgxakFo?=
 =?utf-8?B?QnhSYUxKMzN6YlNYY1ZrSHlpeEFFN2pPTE5hby85MVYrcjVuaHo5MmQ5NTlu?=
 =?utf-8?B?ajJ0b2NSVWRPZm42OEtaNHl1MVlQYlNoLzF1WExsazJvZms5RjRJRkMrQUNP?=
 =?utf-8?B?NmlvaUIzenVxMWRCM2djMDdSV3Q0djVWdkI5SFFlejZYZzc5UHFxbUNDRy9T?=
 =?utf-8?B?YXJLNjcwY2dpNUhPbUpHZHlvUmxYUUNYRkxycXVQT1NsUUVpMzZlU0YxVEov?=
 =?utf-8?B?RlhNMWxoV2lDMVZxUTh0L0pLVjdtNWVyUU1LNDZLeWF0NWRyNE9ieE9SOWE5?=
 =?utf-8?B?S2xqWkRQQTZjQWJXRnRORDhkM2hoajBvako5c0VrU2dPK3I0RFFMNmg0V3Fm?=
 =?utf-8?B?RmFCaTk4MUR5ODZIb2g5d3VVaE1YYUJyLzJFR3hETTFVSkRRbkJCZGNGUGZh?=
 =?utf-8?B?NG5rSkgrcWVCakRWeUxRdXVoMzVsQnJjSGo1bWZvMlJEZmxJNHN5NmdKcXZC?=
 =?utf-8?B?TlZMN3JtV3YxSjJ5YjRSdXhJZ2RJRWtNTldySFcxTFAyYzN4TlBNVGVvV1o5?=
 =?utf-8?B?RUMva2NqbExtdVk1bWNqZnh4T1l2YnpRSVpJeldJaXo2Tzh0Nm1qVDdEWFA4?=
 =?utf-8?B?WWpJWmN3Z3laby9tUEF6NlJyN2RMblNsc3lNU25XSjJmcWJFdW9qcEVLaEhm?=
 =?utf-8?B?dmRaRXZCVWJYanB0Q3F3bXNGaEVwN2hCR0JOOUp0YnJYTUZGaWZMczdka3Zq?=
 =?utf-8?B?WkpQSHNVVU9Zc09jMUw4SllRN0dwbFBIQ01UVnZRdVZEOXRqNlg0allJUVBM?=
 =?utf-8?B?VDNqWnJGTE1HeVZSSTVtd3IyekpGSnFQMjd6Ym9rMDlRWkRLVEFrUVpyNjdS?=
 =?utf-8?B?QUFDRmdVaEI1TThYemtxaGVZc3RxUWhnbmJYcG9LRmlGN1hNdUh2N00zcUtz?=
 =?utf-8?B?aFhRZmxUdytjalZUZm15bVRRb1VWc1E0OTdBRDV1akpwYis3VzQvKzBtZENT?=
 =?utf-8?B?T3gzaEJ4TE5leG9GWmgwSEExWWo5MndLd3ZPSGt5MHpUelUwc0RMZDRxdy9x?=
 =?utf-8?B?NVYyMGdhV1p1U0p5NkNVYXlocVZ2aHV3SGMramF0elk0SlN5SHdmWnc0NjBi?=
 =?utf-8?B?Q3Izbk5HWlpRek1Xb3orUHFORk1jd1FVMjFDdDJYYnhtd1Z5ZklRS3ExT1FY?=
 =?utf-8?Q?J1N0enR1liY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR07MB10492.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVQ3ZmRvQXpzUnZJWE9uZGo1bHpBRThBanVVaGxEdEdZVE1rZlIzaW9WUVFD?=
 =?utf-8?B?cC94aWNQTkYxNFRiVW9wRllXZ09jOXZDaUt4MTlGKzNqdVIyMTQ1UjRvN1c2?=
 =?utf-8?B?bStBME1KSVAva3JXRHpUTnhvZ2x6aHJTczd6UFR1b3krUXJUa3d5cytWdGkv?=
 =?utf-8?B?akd4N0UrM0hVRk9GbXdqM3VBM0NVYXpFN1gzN3BabTB3TUNRRHV1YXdpbVho?=
 =?utf-8?B?bHcvamE2YndpT2RveDEvL0lGVFoveWc4VXE1ZmZGVGhlaEVUcjRzbWN1dHFW?=
 =?utf-8?B?YTRVTUgvSnQ1NE5ManlIRWpQRXV3ZjZFNlhQcHpRUUp3NklJYXFjUzNBQXdW?=
 =?utf-8?B?R1RkT2VyQWh5WjdEUEVwaHJjNVAxYUtXZ3YzM2RGVmgzaWNnL1loRjZ6YW9m?=
 =?utf-8?B?cDN1TEZFNDlMREg2NzNpenBaQ0RZNlVpc0VKR1RFUHdmZEV0UGgxVkovbWZU?=
 =?utf-8?B?dVpZdU5BaDVXL21QWU9DYWEzeGFSQ3NYZ29ZejFTYTRSTktXb1BRa25aOFFS?=
 =?utf-8?B?UE9iNkJJbWFrMkc5VGxEOWJVWCtKK2xTTjhhQnlMOW5LWk01M1pWUlBPTnVx?=
 =?utf-8?B?RFRDSFpaN2JwTGtrY1A5WmFYR1lXZDEyRlRpRkQ5OVR0NnJGOTdYSmtXT2VQ?=
 =?utf-8?B?K0xnR2U0YVozd296eFQ2L3NUTU5ZSGF1dDNBdVBtRW5kTk5Lb2ZTVVJGeUY2?=
 =?utf-8?B?YzV1K0c2Wkk2cDl6aWt0Z1QybFZCV1dFUVhUcE9KM0hmRjhDVERlNTRRaGdv?=
 =?utf-8?B?b3FkQmozeHUxVGZ0ck8va2FlUVNJaHA4RVdqZHFWWldoTmMwMHErdU1FTUdq?=
 =?utf-8?B?V213RTNWM3BPZVdiVURwN1pYaUtpdkdVVzBWeUh5bDZPTytSTURBMU96Z28z?=
 =?utf-8?B?VDVDRlErbDh5ZkdKdk5TalpkQWJKN2xFRGV4UFpzS0kxRUxOTEdKZzUwME9U?=
 =?utf-8?B?SlJ5TE9Ld0doNEZJMG5CRUI5aDI1YVhtdkRZSjFvVytDM0lsckZ1R0RVcmVY?=
 =?utf-8?B?TEExam5abFM1c2RxWVJaelQ0RWR0WFV1R1FSTGlBWjhjb3dWeSszbDRPcnMz?=
 =?utf-8?B?OENKOTMrdVB1VkpyK0tpbll2Qmg4SUxIRmdXVDZsT3I4d1YxVU9DRFBUa2dP?=
 =?utf-8?B?UjhrNDIvWHM4OVVma1d4ZUg5Z005OVZoQTQyRVhoOGc5N3lJQTAwRUN2OWc3?=
 =?utf-8?B?MXFGUFZXVmx0WENwaVptZzJPRWxleWI2UGtsd3pPZGV5VjRrVVc2ZXhiQ3dr?=
 =?utf-8?B?TVVEcnlnMjBsT1VFQUtjVVo5R3dhTHlTRXAwbTlWZVQxelZtWnIwa2IxNXk1?=
 =?utf-8?B?UVRkbmJsbXJOd0VzVW1uUGF5TFlKWVRzQklMSHFZNWcyL1pRQkxEdXdtYUxG?=
 =?utf-8?B?cDBkK1ZCRjlidlIwSmpEZ0psR1VxKzlFZjhGVFp1eHFBa2ppVzh1WUc4MHBB?=
 =?utf-8?B?MDA2RHA4SjhyMmd5TmVYTEVaS3Y0U215S3p5bjZrcDZqUVNEc1BFbm02aVpr?=
 =?utf-8?B?UDZpTW1LQ1hmL25pWkQ2R3NaT2NzOTBLaU5lS1k1M3FrY3BBYU9wcW43TWIw?=
 =?utf-8?B?ZENiVmZjK2xmZlV0UDJiSzlMN1EvRWFKVVhvOEtJZ3pzNTd2MmdvRGZXdEdF?=
 =?utf-8?B?N3VJd3RwUVNIKyswaXp4bUx0cnlWVWh3NmQrVURMcTlCR1M2U090RnNRVGlp?=
 =?utf-8?B?N1pYSWNKTlNFTnZsbjE0UzQrOFUvY2NGMHVFbUtkY0FjN1pVZmY5OUo3bndx?=
 =?utf-8?B?RTRmL0x0Yk5rUm9wbC9KdkxVMWhLRHJmNUkza1lMcS9nc3FPUUU0WVVpOHVs?=
 =?utf-8?B?NVVrYU5uNk9DbWgyMlhGYUNvcjAvVk5oTDdHVjdiOE1yV3VzaFVmNDkxaGR6?=
 =?utf-8?B?UE5OTmk2TFJTUU9rbEV4QktSeGF6R21WeXJWd2lCeDh0aHRYaHJ3akE3ZUE5?=
 =?utf-8?B?RTV0S1NMR3lWQTRGc1VyWVYySDZLM1cwdDBtNVBFU0ZQWXNWK2lzb3NuQnNo?=
 =?utf-8?B?eW84NnhCRUttMFlCTlduU3ZrR2pDOFBvNHBTaEhSUmM3bFFicmdGNDk0c0Vl?=
 =?utf-8?B?VThyMEpmYUtncWZwUWZrcHZVZzQ1ZUxLRGNOWVR3Sk96Szg2U2ozaTUxR1JM?=
 =?utf-8?B?UlhQdFFiSjlxbUxBWjJ0UU9Oc1pPb2VURW9jVVZselJYYWt3bVlJbUU0WDhE?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR07MB10492.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911deff-2968-4196-61d8-08dd6db67211
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 05:07:32.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEYEhzKlLWvHPYJXkrGVgjjXOzD8EkbSAqLIN+6dtievzLaYkFfGiI7Q90XptSqewF479ZE19M7IX5S3WvG2Mdsnm7EBhy75uAYABfY/7d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8626
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e62e98 cx=c_pps a=n6yBKV75teYx4ZnYo0pt6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=gEfo2CItAAAA:8 a=Br2UW1UjAAAA:8 a=PiK4HZvBhwN_URcel5kA:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: sSe5rfWZvj-c3bReYSvsbh_BKHnFI-Y-
X-Proofpoint-ORIG-GUID: sSe5rfWZvj-c3bReYSvsbh_BKHnFI-Y-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280033

PkVYVEVSTkFMIE1BSUwNCj4NCj4NCj5PbiAyNy8wMy8yMDI1IDEyOjE5LCBNYW5pa2FuZGFuIEth
cnVuYWthcmFuIFBpbGxhaSB3cm90ZToNCj4+IERvY3VtZW50IHRoZSBjb21wYXRpYmxlIHByb3Bl
cnR5IGZvciB0aGUgbmV3bHkgYWRkZWQgdmFsdWVzIGZvciBQQ0llIEVQDQo+YW5kDQo+PiBSUCBj
b25maWd1cmF0aW9ucy4gRml4IHRoZSBjb21waWxhdGlvbiBpc3N1ZXMgdGhhdCBjYW1lIHVwIGZv
ciB0aGUgZXhpc3RpbmcNCj4+IENhZGVuY2UgYmluZGluZ3MNCj4NCj5UaGVzZSBhcmUgdHdvIGRp
ZmZlcmVudCBjb21taXRzLg0KDQpPaw0KDQo+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWFuaWth
bmRhbiBLIFBpbGxhaSA8bXBpbGxhaUBjYWRlbmNlLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5k
aW5ncy9wY2kvY2RucyxjZG5zLXBjaWUtZXAueWFtbCAgICAgICB8ICAxMiArLQ0KPj4gIC4uLi9i
aW5kaW5ncy9wY2kvY2RucyxjZG5zLXBjaWUtaG9zdC55YW1sICAgICB8IDExOSArKysrKysrKysr
KysrKystLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCAyMSBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9jZG5zLGNkbnMtcGNpZS1lcC55YW1sDQo+Yi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL2NkbnMsY2Rucy1wY2llLWVwLnlhbWwNCj4+IGluZGV4IDk4NjUx
YWIyMjEwMy4uYWE0YWQ2OWE5YjcxIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9jZG5zLGNkbnMtcGNpZS1lcC55YW1sDQo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NkbnMsY2Rucy1wY2llLWVwLnlhbWwN
Cj4+IEBAIC03LDE0ICs3LDIyIEBAICRzY2hlbWE6DQo+aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLQ0KPnNjaGVtYXMvY29yZS55YW1sKl9fO0l3
ISFFSHNjbVMxeWdpVTFsQSFDQjVsdmt2UlVLU0VEUFNqcFc3R0pvUE55WFoNCj54TWdlNVN5bmRE
NFotVlZMQ1p2ekxJUERQLUJNUmpoS1oyVVR4aTZhMTh2YW9kYVUkDQo+PiAgdGl0bGU6IENhZGVu
Y2UgUENJZSBFUCBDb250cm9sbGVyDQo+Pg0KPj4gIG1haW50YWluZXJzOg0KPj4gLSAgLSBUb20g
Sm9zZXBoIDx0am9zZXBoQGNhZGVuY2UuY29tPg0KPj4gKyAgLSBNYW5pa2FuZGFuIEsgUGlsbGFp
IDxtcGlsbGFpQGNhZGVuY2UuY29tPg0KPj4NCj4+ICBhbGxPZjoNCj4+ICAgIC0gJHJlZjogY2Ru
cy1wY2llLWVwLnlhbWwjDQo+Pg0KPj4gIHByb3BlcnRpZXM6DQo+PiAgICBjb21wYXRpYmxlOg0K
Pj4gLSAgICBjb25zdDogY2RucyxjZG5zLXBjaWUtZXANCj4+ICsgICAgb25lT2Y6DQo+PiArICAg
ICAgLSBjb25zdDogY2RucyxjZG5zLXBjaWUtZXANCj4+ICsgICAgICAtIGNvbnN0OiBjZG5zLGNk
bnMtcGNpZS1ocGEtZXANCj4NCj5XaGF0IGlzIGhwYT8gV2hpY2ggc29jIGlzIHRoYXQ/DQo+DQo+
SSBkb24ndCB0aGluayB0aGlzIHNob3VsZCBrZWVwIGdyb3dpbmcsIGJ1dCBpbnN0ZWFkIHVzZSBT
b0MgYmFzZWQNCj5jb21wYXRpYmxlcy4NCj4NCj5Bbnl3YXksIHRoYXQncyBlbnVtLg0KPg0KDQpI
UEEgaXMgaGlnaCBwZXJmb3JtYW5jZSBhcmNoaXRlY3R1cmUgYmFzZWQgY29udHJvbGxlcnMuIFRo
ZSBtYWpvciBkaWZmZXJlbmNlIGhlcmUgaW4gUENJZSBjb250cm9sbGVycyBpcyB0aGF0DQp0aGUg
YWRkcmVzcyBtYXAgY2hhbmdlcy4gRWFjaCBvZiB0aGUgY29tcGF0aWJsZXMgZGVmaW5lZCBoZXJl
IGhhdmUgZGlmZmVyZW50IGFkZHJlc3MgbWFwcyB0aGF0IGFsbG93IHRoZSBkcml2ZXINCnRvIHN1
cHBvcnQgdGhlbSBmcm9tIHRoZSBkcml2ZXIgdXNpbmcgY29tcGFibGUgcHJvcGVydHkgdGhhdCBw
cm92aWRlcyB0aGUgaW5mbyBmcm9tIHJlbGF0ZWQgZGF0YSAic3RydWN0IG9mX2RldmljZV9pZCIg
aW4gdGhlIGRyaXZlci4NCg0KPj4gKyAgICAgIC0gY29uc3Q6IGNkbnMsY2Rucy1jaXgtcGNpZS1o
cGEtZXANCj4NCj5XaGF0IGlzIGNpeD8gSWYgeW91IHdhbnQgdG8gc3R1ZmYgaGVyZSBzb2MgaW4g
dGhlIG1pZGRsZSwgdGhlbiBubywgbm8NCj5uby4gUGxlYXNlIHJlYWQgZGV2aWNldHJlZSBzcGVj
IGFuZCB3cml0aW5nIGJpbmRpbmdzIGhvdyB0aGUgY29tcGF0aWJsZXMNCj5hcmUgY3JlYXRlZC4N
Cj4NCg0KQXMgbWVudGlvbmVkIGluIHRoZSBlYXJsaWVyIHNlY3Rpb25zLCBjaXggaXMgYW5vdGhl
ciBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgUENJZSBjb250cm9sbGVyIHdoZXJlIA0KdGhlIGFkZHJl
c3MgbWFwIGlzIGNoYW5nZWQgYnkgb3VyIGN1c3RvbWVyDQoNCj4+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBQQ0llIEVQIGNvbnRyb2xsZXIgZnJvbSBjYWRlbmNlDQo+PiArICAgICAgICBpdGVtczoN
Cj4+ICsgICAgICAgICAgLSBjb25zdDogY2RucyxjZG5zLXBjaWUtZXANCj4+ICsgICAgICAgICAg
LSBjb25zdDogY2RucyxjZG5zLXBjaWUtaHBhLWVwDQo+PiArICAgICAgICAgIC0gY29uc3Q6IGNk
bnMsY2Rucy1jaXgtcGNpZS1ocGEtZXANCj4NCj5UaGlzIG1ha2VzIG5vIHNlbnNlLg0KPg0KT25s
eSBvbmUgb2YgdGhlIGFib3ZlIGNvbXBhdGlibGUgaXMgdmFsaWQgZm9yIFBDSWUgY29udHJvbGxl
cnMsIHdoaWNoIHdpbGwgYmUgZGVmaW5lZCBpbiB0aGUgU29DIHJlbGF0ZWQgYmluZGluZy4NCg0K
Pj4NCj4+ICAgIHJlZzoNCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL2NkbnMsY2Rucy1wY2llLWhvc3QueWFtbA0KPmIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jZG5zLGNkbnMtcGNpZS1ob3N0LnlhbWwNCj4+IGluZGV4
IGE4MTkwZDliMTAwZi4uYmI3ZmZiOWRkYWY5IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jZG5zLGNkbnMtcGNpZS1ob3N0LnlhbWwNCj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvY2RucyxjZG5zLXBjaWUt
aG9zdC55YW1sDQo+Pg0KPj4gIG1haW50YWluZXJzOg0KPj4gLSAgLSBUb20gSm9zZXBoIDx0am9z
ZXBoQGNhZGVuY2UuY29tPg0KPj4gKyAgLSBNYW5pa2FuZGFuIEsgUGlsbGFpIDxtcGlsbGFpQGNh
ZGVuY2UuY29tPg0KPj4NCj4+ICBhbGxPZjoNCj4+IC0gIC0gJHJlZjogY2Rucy1wY2llLWhvc3Qu
eWFtbCMNCj4+ICsgIC0gJHJlZjogY2Rucy1wY2llLnlhbWwjDQo+DQo+V2h5Pw0KPg0KDQpUaGUg
ZXhpc3RpbmcgeWFtbCBmaWxlcyB3ZXJlIHRocm93aW5nIG91dCBlcnJvcnMgYW5kIHRoZSBjaGFu
Z2VzIGluIHRoZXNlIGZpbGVzIGFyZSBmb3IgZml4aW5nIHRoZW0uDQoNCj4+DQo+PiAgcHJvcGVy
dGllczoNCj4+ICsgICIjc2l6ZS1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAyDQo+PiArICAiI2Fk
ZHJlc3MtY2VsbHMiOg0KPj4gKyAgICBjb25zdDogMw0KPg0KPkh1aD8gV2h5PyBOb3RoaW5nIGhl
cmUgbWFrZXMgc2Vuc2UuDQo+DQo+DQpDb21waWxhdGlvbiBlcnJvciByZWxhdGVkIGZpeGVzLg0K
DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0K

