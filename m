Return-Path: <linux-pci+bounces-24851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F8A734E1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 15:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64F4164F7F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE40218593;
	Thu, 27 Mar 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XxN4SXt3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HX0bnn9t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA620E6FA;
	Thu, 27 Mar 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086614; cv=fail; b=oWvtAIEsoWgLq0XoY6MJcOHZuP81Fn1NcFNUiUCotMD8bOtvpLKK5mIR9/1FqovDTS2tKFtB1V17YLICjDJOMdS2es7BuUKooQJoc9VgydBzleWpuUU4ge3D3uaTpkZDaTtfvKZ2KDqeRLjyab6oqWpI8CFTDR+rCsRuprSlsYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086614; c=relaxed/simple;
	bh=Rn0y5SxIYarV4aZCWzkWPzJZ9PHlmykNQ5ICx+9PauY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfulXcrrsrhZIW6jtLMldoVemp2u/WbAykoB7didh4wvJ9iZwsoxtlon3woYMN1Y4/TRWWjAneLRdAsQFdI6wBr9iKiMnTiza9emxAZpSynFI/HLwu7syXj6pGmDzm1derj7c1Uxvn9LPIil3aDE6iBxzHxOiG8VRFTBU964/FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=XxN4SXt3; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=HX0bnn9t; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7rVTs032254;
	Thu, 27 Mar 2025 07:43:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Rn0y5SxIYarV4aZCWzkWPzJZ9PHlmykNQ5ICx+9PauY=; b=XxN4SXt3PnT/
	TYbumB6Rlawo7846Rzt9X98teGJAeFqDkpmIxsSyjVE3ZSzWUN1/SeV5U4Uqkl9F
	4OxJgUPiSDn3sVFNMVFVPRQEtPnR3vQBNixSnKzBUReIreI53e6fu//S8L745xul
	5VUmy+6nSClQNJ+LImlb3AtyuZloycfLtY8JNA/CgC9xNiQtnwxwoOptsU615K9S
	LlLT7MFg/DTc4QxZ/5VeU8TOjQCEW1B4WclQ1Ho4wGINAXZnt4fWyrXt9HK86B+v
	zZ6Jj3R0AWPM136c3pP8TlATQeCJL4GdhDOQQ1+7LJueaYyxRwu2FaXM4Z2XefyO
	YJ1y0i2BEw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrwnppb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 07:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY8GbKG+nq8m2K56ow55pe2GpfslR8EGo4P4JzGOn9BCkHc4RfhTtaYf1w/+c0sHKKWfSMHVS1QjIki591yiyvAsxTdCAuJmp9zTi+GMU6+V/FTDp+VDkeM0tKIJGD3dmdxew8yY09m0kZ0XvXqKH1hSQQV152WZGwWjpTiZZ/JJ6hujIrpBxRaNsKTEPB9w4YZnEduJBRG6GW8hKO1+Z2zFpipNfAfE6g7uAYAX82Lpyi6i0FJasdaBRG0ijYwOAlVXZERIhsHvolnt/2NhDSV6hMlhwjAVdSybvCjKbgp1qmXfmwkpACWQA854ZXkEnCFNBJLO7Zn/+pB35n9H4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn0y5SxIYarV4aZCWzkWPzJZ9PHlmykNQ5ICx+9PauY=;
 b=WgXTrKDJqeciXB8ZnUyp2BHmC4BQiYUFPXf4XmIJyz6wpe7osz0XnW95u41oXYO9OiXr3VYdPjxL0d2jE+9yKsSY9eqYfR+De6g7cnznLwzEwawR1nRA+aUnvhvUlE20mY0OTK7fsuyFZ6cVjbAxbGppBuSBed+RcGMKGXngeRiBRxvSH3juoqJ2BrCuOR6z7yQ8QM5oJnl9c1SRHhRrMhXmbFipd0FuN6kz8dAiEtGxoHOxduElSWh2UR3dbpnhRZIc52RuBw6twd9Zl7N7sIkeZkj/HbLh5nRHCqNRTwpl6FgpMHa5fPQ/xbTTaDOYbGog3fq4Ii+KX1CdJB5e8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn0y5SxIYarV4aZCWzkWPzJZ9PHlmykNQ5ICx+9PauY=;
 b=HX0bnn9t3qGoNRJfL7sbXuh4F95xplYrWH77hZKdu5QDw7XzsQTkJIf4xA3QsWX9JnWLOQVhp4SAnBcXBhlOOw9t0ivstkpRyvwadoYbmHmuZ1WimGD5L9yrbC1OGkqaVTD18riOPY/ldP7kESS2YXhOVfmTasHI6QweJQFCMq4=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SA1PR07MB8532.namprd07.prod.outlook.com
 (2603:10b6:806:193::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:43:20 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:43:20 +0000
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
Subject: RE: [PATCH 0/7] Enhance the PCIe controller driver
Thread-Topic: [PATCH 0/7] Enhance the PCIe controller driver
Thread-Index: AQHbnwasjE0SelmZSEibiI56xlER37OGz6YQgAA3+4CAAAaVgA==
Date: Thu, 27 Mar 2025 14:43:20 +0000
Message-ID:
 <CH2PPF4D26F8E1CE0395D8E80DA73829B4EA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250327105429.2947013-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <fc1c6ded-2246-4d09-90b4-c0a264962ab3@kernel.org>
In-Reply-To: <fc1c6ded-2246-4d09-90b4-c0a264962ab3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzF3YVd4c1lXbGNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MWtNV1JsWkRjNFlpMHdZakU1TFRFeFpqQXRZVE0y?=
 =?utf-8?B?WXkxak5EUTNOR1ZrTm1ObFpUVmNZVzFsTFhSbGMzUmNaREZrWldRM09HUXRN?=
 =?utf-8?B?R0l4T1MweE1XWXdMV0V6Tm1NdFl6UTBOelJsWkRaalpXVTFZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJME1ERTJJaUIwUFNJeE16TTROelUyTURFNU9ERTJNVFUyTWpj?=
 =?utf-8?B?aUlHZzlJaXQwVWtSWFRESkpkemsyZUc1WE1WcGhaazgzWjBOalZVaDJNRDBp?=
 =?utf-8?B?SUdsa1BTSWlJR0pzUFNJd0lpQmliejBpTVNJZ1kyazlJbU5CUVVGQlJWSklW?=
 =?utf-8?B?VEZTVTFKVlJrNURaMVZCUVVwQlNFRkJRVXh5YWxOVlNuQXZZa0ZhVTFOeWNF?=
 =?utf-8?B?aGxObXR3VW14S1MzVnJaRGR4VTJ4RlNrRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlEzZEJRVUZCUVVGQlFVRkJR?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSklCQUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQWNnRUFBQWtBQUFBc0FBQUFBQUFBQUdNQVpBQnVBRjhBZGdCb0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUNRQUFBQUxBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFHTUFhQUFBQUNZQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHRUFjd0J0QUFBQUpnQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQWtBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhNQUFBQXVBQUFBQUFBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JtQUc4QWNnQjBBSElBWVFCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBYWdCaEFIWUFZUUFBQUN3QUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBPT0iLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SA1PR07MB8532:EE_
x-ms-office365-filtering-correlation-id: ed9084c9-afbf-445b-1476-08dd6d3db7e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkhaQnVVK0tyNU5qZGVkQUthOUhBTnJ2c3R2K1RVWFpiQVhBK2ZQRUhVLzc1?=
 =?utf-8?B?ZGZncGJtQVVreGl1OVZJVDJXY3hNRUM0NFhrbEFsaU5RMUxPdU5aWUNGOUtn?=
 =?utf-8?B?MWN5M2tVSjVsUUc0NlV1emRhMEZWMktuZDBzRWdoNkk2TWp6YmNmN1dGSVBE?=
 =?utf-8?B?Wm11T3VvN25pbUdCRm0veFc2aTFaaUFueWFtdmNmM0RpOGRwZ2piZDN2N0Fu?=
 =?utf-8?B?MWdDZjJjWmtCVmo4M2NGcVErTnhnZG5LV0FEdHpiS05qajBzQ0lDcFFSZDdO?=
 =?utf-8?B?SXgrMWpPZWx6dnlOdzhVbGhYa2V6ZWNUYyt0MXZGK05uWVpZclV0TitLZ0Ex?=
 =?utf-8?B?YnozSzdCNk0vcHkzNkVVZldVT0NUYVhFR3U2aFlyMFBiaWlrcFZ3M0duQnRC?=
 =?utf-8?B?Qis2ZWRCcHhVdnJYZUVIUEltU0hTdFR6MFZZNERQWlROM1RneU1xYko2TGh6?=
 =?utf-8?B?UEhHVldqMG1COUhod0JSNmFlb0E5T0xZRFhUUU12RmlTMDR0Z2hwU3BvL2dq?=
 =?utf-8?B?TWxpd0NNWjlNUTYybVpmSzdFYkRKVkwzbW5mZEdvWmtUbUVWTEdnQlpLbmtB?=
 =?utf-8?B?RjNzRTBGYlNGZWJJV2NjNmF0Y0NrREtCZUEzS21DeG5CWkcvZkNpUjFJamJW?=
 =?utf-8?B?TUQzSUk0NzRVVTJaUWdpNGxzK1lNUFVwSUlra2FlaWZMN05TYW9Mc2hWTWho?=
 =?utf-8?B?Q08ra1Q2VlJYR0MrTG5DV2toL04vMzdhR20zSHdHdC9RSDJjNEJPeFRUcFEz?=
 =?utf-8?B?VHUvNWZXN1llZkZoK2RSTWdGTVphME14NVhyTTZORjBVZU16RFM3UXU3akIw?=
 =?utf-8?B?Vk1CcnZ4L0Nxak5uN2ExL1RobVpWUG5kVTV0dTc5bHJNVk5qNnFEZnNxbUt1?=
 =?utf-8?B?eC9IdWg3VnE2NU4yR3pqNm5LMjJndWxXWjRpcjFuTE44QVl3TGxwNGlXQmtw?=
 =?utf-8?B?MzZ3T2tqcXpsemk5TE8rWDFrSWEzdmZRNFVXTEFlSGpWbnBsMnNMYXZFZjVW?=
 =?utf-8?B?YVlBOWVseTVoVnV6amVzb2dvb3hmWlRMS2t1UFRnalQyUEkvTG1qRFNYSjNO?=
 =?utf-8?B?NHFxSmR1SEM2K1lRUFErUTFRbWZ5cXExQTBIOWxBRy9sbnlpa29oVUdQTm5t?=
 =?utf-8?B?T0JZRWFCTk1ETnBPT3hJaGRuNk1UdFdlQWJuSXZvWHFRSm45aEgyL2lRblZG?=
 =?utf-8?B?WS9wb2daYVg4RE9LRWIyVHFvZ1RUTnZWdTY1UFFseEtNK0NrL2h6ZmZLSHZ6?=
 =?utf-8?B?cUszYVV5NFNkWWtsNjh6UURMakx5UEtpbEhpSnpIOFh6NG11OExOSDhXNWd6?=
 =?utf-8?B?anJNd2svWjlJQjFRdXV2TWhueHcvUVpkNDEzVkVhRDh0VDgySTBMYkFFSHE5?=
 =?utf-8?B?OGRIeGtrOWl2dWl5ajErZzNVVGFtaG1oKzcwQjA4OXRHMFFQWnBCdzAweVg0?=
 =?utf-8?B?aEZ3TUhaMkVsTjYwWEd6VjhIcy9vdmhodytBL200NWp6STFsbXNBenNTWTZk?=
 =?utf-8?B?VlJweUJaVC9qdllqSEdtUWpwZTZWbEJFUG9GSGw5ZDVmNlZpWTU2OERFVE1v?=
 =?utf-8?B?azVxZCtiOFFBZDRid2ErNk9RME8xWlh1TDZtNGtsZzhVWGoyWlFWMzJHdi96?=
 =?utf-8?B?TWJRL253K3VPcFhWZjZ4V2hMNVRRa01tR1VETC8rOVJFOHA2amVUcVhoSFZF?=
 =?utf-8?B?Zm80L3k0Wk5nUXZPS1ArWnJwL2hBb1pNNUppb09td2NrQnlSTmFKQ1QxeFVk?=
 =?utf-8?B?cHpKWC90WXU2TG5XNkZhU2JHTnpFMEVPNlpiMTY1UE11dExoY2gyWUpVVk9C?=
 =?utf-8?B?b25QYlJpL1B6VDIrUmk5MFZEWUQvOU5sUVdpQW1xQ2owQnlaMEpZOGxBQjQ5?=
 =?utf-8?Q?C05At8UkqeHZ7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmVSY0V1MEFkWVdPQjNaVlJvTTRsZm9hVHgzUnZkeHlpNlA4eTJFcVZWSndK?=
 =?utf-8?B?bEc1RWplTlRPNEt0bFFmYVVoUkJmS01wQ04xSFAzcHdqcmlNazM2Q0VReWlI?=
 =?utf-8?B?eWxqVjhiU1JYRDBKaU9talZoMVVKNGZFTUxCWG9IWFUyMVVBQ01vdFErZmRI?=
 =?utf-8?B?VVM0QnRzcnptdG5xck5uc2tYdmlzYkRDWnNSS1pGL3B4S2JNaU5VWTJFOW56?=
 =?utf-8?B?VFg3OGpiODNUNHFZNkkzWVRDY01LZUtNcDR3WCs0YTlOWXViSWNibnhxVWd2?=
 =?utf-8?B?aXNPODNjNWlHS3E5NGhSN0tCMU1aODdjSGtwRXQ0NkhPM1ZVOE9lWTZxYnM5?=
 =?utf-8?B?dCt4QjVpemxHU1ArNHZYZWJLaWUrL1FxSFhmNlB5U3ZiNUdVdy8xaDl6K0p5?=
 =?utf-8?B?MHlUSW4yeS9EZHcyNkkrZGhBVXBpMXRjRjhjem85NGdweEFacEFUa210cm1M?=
 =?utf-8?B?MW9FTDY1eGVJVnZxSktodFVSY0NqcllyQ3ZyaXNQdHkzNDB4YUZxdjFYcXU4?=
 =?utf-8?B?cDU3NUxoMEZFWnBiTTJpdmtHSVlHTUV1SVg3WStPaFlTdXVKS2pYNStOOFlV?=
 =?utf-8?B?cjl5L2l1S3liWTVUbHNFV01IUmhPT0JwcXl5N3A1UGs5N3VIbnJhZlVsblJ2?=
 =?utf-8?B?UU4yYjJQanJKV3BRdFAzVHU3WHpLMUIwWjV5VHJia0w0RnNuZ2xEUUR4bjV5?=
 =?utf-8?B?SjFpRkJHdTMvb0pCWVdyV0haZ2hoSkRObFREVm9jMDVhdkZ2RDkwdkRIVXJq?=
 =?utf-8?B?L000S0ZIWk5lVkUzRk9XL280amZyMG53R3JlVDRxNzJONGh0aEtqTXBIeFRH?=
 =?utf-8?B?emJnbEh4VU9CMEx3M1NEODNXQXpOUmFFZDM1TllpM2o3UmpFQ2ZnMzZLa2hM?=
 =?utf-8?B?aHFKZndQM3dPYkwycEdXZys1Z1BJSFRLVmYxd3F3a2hPTkFzT1ZHazRHWFRq?=
 =?utf-8?B?N2xIUzlSWEt5U2ZCQ2RaSXBkUk5qd0VrVGFYbC9rSEEreXZxUzRBSTU0SXQ2?=
 =?utf-8?B?MjRMbk5MN2crKzZ2UmY5TVNjVTltVy9LaEF1ak1YV0N1b3NET0RNbHJ3RHNR?=
 =?utf-8?B?MnRNbzN2dW13QkdwUnpVM1VnM3hXMC9lak5MaVYzOHYwVmJwTWxWVnVtbFUx?=
 =?utf-8?B?USs3QU9EM3Rzb0k5RXdOc1JLdzlCb0hiQ0lxclI1VkRUbFl5MFdpOXIwL3Q3?=
 =?utf-8?B?M3VKMmUwUVpuYWNBbUovdlZsVFlmSG84THVzcjVxMTBUMmNYZTgrbUp1SmdD?=
 =?utf-8?B?ZlRwQlh3QUMwZXRNdldGVVBveWpieWxFNlNCc2VWSUd4SVVrU0s2UFBTamxn?=
 =?utf-8?B?S2JSbzlKckRwajlSc0UwL2Y2aTdqZkNxWEdNMk9GdnY0aCtwcU1lejBjMm4z?=
 =?utf-8?B?MkVHZFp4ZnZocEMxU0ZkS1hzRXMwTEFaRUlMVFN3SEl6TlhKVzRjV3g2Z3Mv?=
 =?utf-8?B?TjZtMWd2WURUekVRTmUzdDJoeVJNOFFqOWZzT2tMSHdjeFFSczQ1bHBQbll2?=
 =?utf-8?B?UDV3ejBLWFJmTExGRUg2RVdVc1ZrKytKM3hNMzgvV08yZzVtaWhxN3VCM0Ru?=
 =?utf-8?B?UTRmV0xvMjlFN3c4MVArWXVldDFJeHhXbi8xempsOFpVYlU1aUlNTGhYWVU5?=
 =?utf-8?B?Mk56c1hmK1o3T1JVWlBYZlpSY0xINU92VGhTZFJiWnVob3I1LzVWSTBqRnZN?=
 =?utf-8?B?TkNkRUcxdEw4cE5kdGYrdmNUelhoZDM5K0E5Y3RpMnFxeVljYXNEZWtyZTZB?=
 =?utf-8?B?SW1qR0RwdE9iaXM5cnFHN0lRQ0dnbjhaTmVKLy9KUlZsbnZiUU9JYTB5Q0ZE?=
 =?utf-8?B?NlpwMHc5SmJQRmxUL2xvZzZtYXYyZW9lVzhzaTdZblo1V2NHUTl6d2o0aCty?=
 =?utf-8?B?NFNyem56Nk9HMXRtWDBlaFBDdytVakEzSXhaMmxDV3JrTGZnMmw2a0Z2cWJz?=
 =?utf-8?B?Q2RqVEVRbWZLM2VUSVl3NnNsWEpZbWMzajNsRmp1VEJKbGdzMmxLaEFzVW8r?=
 =?utf-8?B?NlpPeS9UM3JFR2JISVEwUVhXOW1XY3VYcmhtRkpESzBTakdCTExwZUs1UEVH?=
 =?utf-8?B?R01EZGx0TldNUXdRVkZtUTN3K0Z2NWI3RVJSekY1Q3F0dHVGUUJTQjIwQWVC?=
 =?utf-8?B?V2hhL2gvM3U2RGhUSFh6M0lxRFlQeE8xL2NoeVhEMjRZbklJc1cxZ0tFSFVL?=
 =?utf-8?B?c1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9084c9-afbf-445b-1476-08dd6d3db7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 14:43:20.1182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ITeu5H4QfDHi1KylGlbtl2o4QmLHFxYWIrjhqnL2QoKMGDVSjHgeYzzMQEJCX7kePkixA+M+0wPFC3NMILEvXeBYHhNazzAi/fmZ6ttKl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8532
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e5640b cx=c_pps a=k6qe+EuqS5agFzeLFj3oqg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=KKAkSRfTAAAA:8 a=pUp2uPF-V1qaUiRG4_kA:9 a=QEXdDO2ut3YA:10 a=WmXOPjafLNExVIMTj843:22 a=TPcZfFuj8SYsoCJAFAiX:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vXK-QXXDdF5nKM4L5TbNpLg87xquhIdH
X-Proofpoint-ORIG-GUID: vXK-QXXDdF5nKM4L5TbNpLg87xquhIdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=933
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270100

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiBUaHVyc2RheSwgTWFyY2ggMjcsIDIwMjUgNzo0
NyBQTQ0KPlRvOiBNYW5pa2FuZGFuIEthcnVuYWthcmFuIFBpbGxhaSA8bXBpbGxhaUBjYWRlbmNl
LmNvbT47DQo+YmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0Bs
aW51eC5jb207DQo+bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IHJvYmhAa2VybmVs
Lm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPmNvbm9yK2R0QGtlcm5lbC5vcmc7IE1pbGluZCBQ
YXJhYiA8bXBhcmFiQGNhZGVuY2UuY29tPg0KPkNjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMC83XSBFbmhhbmNlIHRoZSBQQ0llIGNvbnRyb2xs
ZXIgZHJpdmVyDQo+DQo+RVhURVJOQUwgTUFJTA0KPg0KPg0KPk9uIDI3LzAzLzIwMjUgMTE6NTks
IE1hbmlrYW5kYW4gS2FydW5ha2FyYW4gUGlsbGFpIHdyb3RlOg0KPj4gRW5oYW5jZXMgdGhlIGV4
aXRpbmcgQ2FkZW5jZSBQQ0llIGNvbnRyb2xsZXIgZHJpdmVycyB0byBzdXBwb3J0IHNlY29uZA0K
Pj4gZ2VuZXJhdGlvbiBQQ0llIGNvbnRyb2xsZXIgYWxzbyByZWZlcnJlZCBhcyBIUEEoSGlnaCBQ
ZXJmb3JtYW5jZQ0KPj4gQXJjaGl0ZWN0dXJlKSBjb250cm9sbGVycy4NCj4+DQo+PiBUaGUgc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIGhhcyBiZWVuIHJ1biBvbiB0aGUgcGF0Y2hlcyB3aXRoIGFuZCB3
aXRob3V0DQo+PiAtLXN0cmljdC4gV2l0aCB0aGUgLS1zdHJpY3Qgb3B0aW9uLCA0IGNoZWNrcyBh
cmUgZ2VuZXJhdGVkIG9uIDEgcGF0Y2gNCj4+IChwYXRjaCAwMDAyIG9mIHRoZSBzZXJpZXMpLCB3
aGljaCBjYW4gYmUgaWdub3JlZC4gVGhlcmUgYXJlIG5vIGNvZGUNCj4+IGZpeGVzIHJlcXVpcmVk
IGZvciB0aGVzZSBjaGVja3MuIFRoZSByZXN0IG9mIHRoZSAnc2NyaXB0cy9jaGVja3BhdGNoLnBs
Jw0KPj4gaXMgY2xlYW4uDQo+Pg0KPg0KPldoeSB5b3VyIHBhdGNoZXMgYXJlIG5vdCBwcm9wZXJs
eSB0aHJlYWRlZD8gSSBzZWUgb25seSBvbmUgcGF0Y2guDQo+DQpJIGRvbuKAmXQgaGF2ZSBnaXQg
c2VuZC1lbWFpbCBlbmFibGVkIGZyb20gdGhlIG9yZ2FuaXphdGlvbiBhbmQgaGVuY2UgbmVlZCB0
byBzZW5kIGZyb20gTWljcm9zb2Z0IG91dGxvb2suDQpJIHVzZSBnaXQgc2VuZC1lbWFpbCB0byBz
ZW5kIGl0IHRvIG15ICBPdXRsb29rIGFjY291bnQgYW5kIHRoZW4gZm9yd2FyZCBpdCBmcm9tIHRo
ZXJlIHRvIHRoZSANCkxpbnV4IG1haWwgbGlzdC4gKFdoaWxlIHNlbmRpbmcgZnJvbSBsaW51eCBn
aXQgc2VuZC1lbWFpbCwgSSBhbSB1c2luZyB0aGUgTWVzc2FnZS1JRCBvZiB0aGUgY292ZXIgbGV0
dGVyKQ0KQW55IHN1Z2dlc3Rpb25zIG9uIGhvdyB0byBmaXggPw0KDQo+U2FtZSBzdG9yeSB3YXMg
Zm9yIHRoaXM6DQo+aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9DSDJQUEY0RDI2RjhFMUNFNEUNCj4xOEU5Q0M1QjhEQUY3MjREQ0EyQTQyQENI
MlBQRjREMjZGOEUxQy5uYW1wcmQwNy5wcm9kLm91dGxvb2suY28NCj5tL19fOyEhRUhzY21TMXln
aVUxbEEhSE56T2dCMmVOaVBpaTB2c1BqWmpMbXNtQXRuVzN3enZ2NXBKdnpmNXVnSUNDeg0KPllw
UVd5YjBpV19MZnhFNnBrUG12eDc1STkzY2tVJA0KPg0KPkJUVywgdGhhdCdzIGNvbnRpbnVhdGlv
biwgc28gdmVyc2lvbiBjb3JyZWN0bHkgeW91ciBwYXRjaGVzIGFuZCBwcm92aWRlDQo+ZGV0YWls
ZWQgY2hhbmdlbG9nLg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg==

