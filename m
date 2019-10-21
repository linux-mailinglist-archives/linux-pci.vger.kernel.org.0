Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A00DF0ED
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfJUPKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 11:10:01 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:47440 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfJUPKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 11:10:01 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8D1FFC039E;
        Mon, 21 Oct 2019 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571670600; bh=fTFdjwxpF4teq4qqkiw4toBaY7Kc2/TL4Zdmne5dRJI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AsC3srh7bhVtoFFPhnKC4P0cXHVTvHXpVehiDRYKMTbN9FtljcK9DH9jzA+SU0duA
         7R2znVkgCxUC2Nw8X0kp8eYuK2q+GdfNJoYCfMjApKOQ7sy7AVm1fVJa3Ai11eO/w3
         IwFI91++Tis2/0BbhhnoGILlY/yhCJ/cI/0zOJFtwgvoLthdU3ZVT29tQ/Y6mPd337
         nOTo53DHEaRWynDRkrujx5rGaufkminKz677o1AMZnSMfT9KxJEf5rBSc7ZNWgACSP
         P2N3wnbct0E/qtSDpwxwRRsvVmAfozK9xZSmWeXsqDU7ZyWXOK3CSgUVXmfdxqrQrZ
         pKrwqgsfNsOtQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2D2A4A005A;
        Mon, 21 Oct 2019 15:10:00 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Oct 2019 08:10:00 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 21 Oct 2019 08:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg7KhxMMV3wZ0RKrPL8LJ53q+LAgMUQkhaaiQlcb+TsJm1sCqlUHs0ZrnF54jf9JORuTVYwkXEjo/rXH8L0FntL7xdxU1qHMwFLZ6KsJZmz4NNtNRfVPFfIRFlsVxtlfmddICKP1DSRVCKGSXRJCZAAs/FIMWn0Dq0p3+Zcsvn2G6cBkqFi3MCGnWgMzDr1jnyEu20T1+kT1RPymAVYkZ4jjRVQ6t9lYk0PySGMsHivBbtB4oeSWYdYY5bsQznSSTHoaj9XG8mZAjw9uRM97zIVmlsZr334/rBNKNY5hBe1VYpyTFdOvJ8uEjiszr0BEMJskrcQwzoSFCc6dO3qvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTFdjwxpF4teq4qqkiw4toBaY7Kc2/TL4Zdmne5dRJI=;
 b=YpylNLCluL0tPKXBd4yJaeuwYIHWaJK5YIO/CLQkzcJ7wBkrOIsYugV/+A4/U4UrPagTwudN72csNzSLpXQj3lWEuo0OyfoXdd3qujwxJFbfCpxoVWn1qiLXd0uRrpQvfyAWehtg5OfRFQ2cEgGV/yjWc593cuq8Ms5F+PkgVnUa6rSmHIL/lMwoBZpuJ4HOjshFlz9Mt95VpZh363yENjxVBQO6E7i6HrPhCG0i8YlnAmP6zDCf9znALOb81CbyvMpoGkapN0XwEbisXc9+kTnoYwz3xy/6R6P93N2IKbRoGukc9NYWSsko/8gsHho9Y169pO9+RkJsIcak/9D+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTFdjwxpF4teq4qqkiw4toBaY7Kc2/TL4Zdmne5dRJI=;
 b=QSvmjf9P/Nfb1ndyE5ZNVNokCs98spyWMMA8n/DDvSfv3zF714ZYnXb5kbzqDLUSOOc3OOzACkLy7t/8V5VKVTYqJhKmkKFb+kOERGwZabER8fERhuHk30s/rKL+UZSIaGN9Of/TVdAy6lVrYkxm2SvJ0jaVLZ2jHnFpcguOAks=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB4075.namprd12.prod.outlook.com (10.141.187.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 15:09:57 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::89b8:dea4:cfcb:a241]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::89b8:dea4:cfcb:a241%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 15:09:57 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Anvesh Salveru <anvesh.s@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Pankaj Dubey" <pankaj.dubey@samsung.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: designware: Add binding for ZRX-DC
 PHY property
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: designware: Add binding for ZRX-DC
 PHY property
Thread-Index: AQHViArdRl1xcTG91EaVBXmINz+ZiadlMw+Q
Date:   Mon, 21 Oct 2019 15:09:57 +0000
Message-ID: <DM6PR12MB40102695CA1BB24F7ADE2E6DDA690@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <CGME20191021122630epcas5p32bd92762c4304035cad5c1822d96e304@epcas5p3.samsung.com>
 <1571660755-30270-1-git-send-email-anvesh.s@samsung.com>
In-Reply-To: <1571660755-30270-1-git-send-email-anvesh.s@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MV1EyT1RNME16SmlMV1kwTVRRdE1URmxPUzA1T0RrekxXRTBOR05q?=
 =?utf-8?B?T0dVNVkyWXdObHhoYldVdGRHVnpkRnhrTmprek5ETXlaQzFtTkRFMExURXha?=
 =?utf-8?B?VGt0T1RnNU15MWhORFJqWXpobE9XTm1NRFppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RTJOVGNpSUhROUlqRXpNakUyTVRRME1UazFPREUxTURReU55SWdhRDBpVTI0?=
 =?utf-8?B?eFpHcDRjVW81VWxKMU1XVjVhV3hyYWtWUWF6YzNjVmhOUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlFsRktRVUZCWWxGbGRWbEpXV3BXUVdSbWRtNVZPSGhrWkV4NU1T?=
 =?utf-8?B?c3JaRlI2UmpFd2RrbFBRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUTJ0RFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGRlIwbFplbEZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKdFFVZHJRV0puUW1oQlJ6UkJXWGRDYkVGR09FRmpRVUp6UVVkRlFX?=
 =?utf-8?B?Sm5RblZCUjJ0QlltZENia0ZHT0VGa2QwSm9RVWhSUVZwUlFubEJSekJCV1ZG?=
 =?utf-8?B?Q2VVRkhjMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhXVUZpZDBJeFFVYzBRVnBCUW5sQlNHdEJXSGRD?=
 =?utf-8?B?ZDBGSFJVRmpaMEl3UVVjMFFWcFJRbmxCU0UxQldIZENia0ZIV1VGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV21kQ2RrRklWVUZpWjBKclFV?=
 =?utf-8?B?aEpRV1ZSUW1aQlNFRkJXVkZDZVVGSVVVRmlaMEpzUVVoSlFXTjNRbVpCU0Ux?=
 =?utf-8?B?QldWRkNkRUZJVFVGa1VVSjFRVWRqUVZoM1FtcEJSemhCWW1kQ2JVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVW8wUVVGQlFtMUJSemhC?=
 =?utf-8?B?WkZGQ2RVRkhVVUZqWjBJMVFVWTRRV05CUW1oQlNFbEJaRUZDZFVGSFZVRmpa?=
 =?utf-8?B?MEo2UVVZNFFXTjNRbWhCUnpCQlkzZENNVUZITkVGYWQwSm1RVWhKUVZwUlFu?=
 =?utf-8?B?cEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVow?=
 =?utf-8?B?RkJRVWRaUVdKM1FqRkJSelJCV2tGQ2VVRklhMEZZZDBKM1FVZEZRV05uUWpC?=
 =?utf-8?B?QlJ6UkJXbEZDZVVGSVRVRllkMEo2UVVjd1FXRlJRbXBCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5C?=
 =?utf-8?B?UVVGQlFVRkRaVUZCUVVGYVowSjJRVWhWUVdKblFtdEJTRWxCWlZGQ1prRklR?=
 =?utf-8?B?VUZaVVVKNVFVaFJRV0puUW14QlNFbEJZM2RDWmtGSVRVRmtRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGSlFVRkJRVUZCU2pSQlFVRkNiVUZIT0VGa1VVSjFRVWRSUVdO?=
 =?utf-8?B?blFqVkJSamhCWTBGQ2FFRklTVUZrUVVKMVFVZFZRV05uUW5wQlJqaEJaRUZD?=
 =?utf-8?B?ZWtGSE1FRlpkMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVGQlFXNW5RVUZCUjFsQlluZENN?=
 =?utf-8?B?VUZITkVGYVFVSjVRVWhyUVZoM1FuZEJSMFZCWTJkQ01FRkhORUZhVVVKNVFV?=
 =?utf-8?B?aE5RVmgzUWpGQlJ6QkJXWGRCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJRVUZCUTBGQlFVRkJRVU5sUVVG?=
 =?utf-8?B?QlFWcDNRakJCU0UxQldIZENkMEZJU1VGaWQwSnJRVWhWUVZsM1FqQkJSamhC?=
 =?utf-8?B?WkVGQ2VVRkhSVUZoVVVKMVFVZHJRV0puUW01QlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQ1FVRkJRVUZCUVVGQlFVbEJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUo2UVVkRlFXSkJRbXhCU0UxQldIZENhRUZIVFVGWmQw?=
 =?utf-8?B?SjJRVWhWUVdKblFqQkJSamhCWTBGQ2MwRkhSVUZpWjBGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSVRVRlpVVUp6UVVkVlFXTjNRbVpC?=
 =?utf-8?B?U0VWQlpGRkNka0ZJVVVGYVVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZM2RDZFVGSVFV?=
 =?utf-8?B?RmpkMEptUVVkM1FXRlJRbXBCUjFWQlltZENla0ZIVlVGWWQwSXdRVWRWUVdO?=
 =?utf-8?B?blFuUkJSamhCVFZGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZC?=
 =?utf-8?B?UW5wQlJ6UkJZMEZDZWtGR09FRmlRVUp3UVVkTlFWcFJRblZCU0UxQldsRkNa?=
 =?utf-8?B?a0ZJVVVGYVVVSjVRVWN3UVZoM1FucEJTRkZCWkZGQ2EwRkhWVUZpWjBJd1FV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFV?=
 =?utf-8?B?RkJRVUZ1WjBGQlFVaFpRVnAzUW1aQlIzTkJXbEZDTlVGSVkwRmlkMEo1UVVk?=
 =?utf-8?B?UlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZC?=
 =?utf-8?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f69aabd-9df3-4291-9e32-08d75638bc89
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4075338CC814C82402D362D1DA690@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(305945005)(7736002)(6116002)(3846002)(74316002)(6246003)(4326008)(71200400001)(7696005)(76176011)(71190400001)(99286004)(110136005)(54906003)(316002)(6436002)(9686003)(229853002)(55016002)(2906002)(33656002)(81156014)(478600001)(8676002)(81166006)(8936002)(25786009)(86362001)(2201001)(446003)(14454004)(52536014)(5660300002)(6506007)(53546011)(102836004)(26005)(256004)(2501003)(486006)(66066001)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(11346002)(476003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB4075;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcCDFb10DtMFiPpR9/4hL5l/x48BlNdAmSkz4hT7YGe356PDtFlHQM54dwSm9TV3VfGC8p+Sj5ZpIMGqiROJwLGAxLKAg8kARn0A57y5qYVmgpcNJkte6T3TdQRHPgOWaU7MyvgOpjlvKI4D9kvfa0aFAvyDH0p4uLcGPtyfwy1F33o7vEfT1fE48KH9t5LZWryD02Yd6rEXbRVpI0eax4sZ6ZQWZ5KeZ8RpDAZQwgYackTN+PeWvnP+0j8lK7yb00SFu+x4oJvEZE6LzCcrxrkfUwzRXlQcHpRsZt0hF0dFdrLSIgQXxwMvnzIqEiaYCnm0xV7FczdDzyKIV9+JTKIN+ndPyKY91H127NTVgLIer8/2qZqVNNE1yPhg5fyYwdby3l2rtbt3iaO/4HcyOSAFBjQ83336y5z6vxEtrJvfueu5c9lwYQRm1f3fzm3E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69aabd-9df3-4291-9e32-08d75638bc89
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 15:09:57.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrmgMUNU3NojC0RD6psGViFDhVzUKGbfAmNH/AM0/IhjrrW4yYBpZxyLOGTVfQyD34vFILP+a+y9FzQXcLGobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgMTM6MjU6NTUsIEFudmVzaCBTYWx2ZXJ1IDxhbnZlc2gu
c0BzYW1zdW5nLmNvbT4gDQp3cm90ZToNCg0KPiBBZGQgc3VwcG9ydCBmb3IgWlJYLURDIGNvbXBs
aWFudCBQSFlzLiBJZiBQSFkgaXMgbm90IGNvbXBsaWFudCB0byBaUlgtREMNCj4gc3BlY2lmaWNh
dGlvbiwgdGhlbiBhZnRlciBldmVyeSAxMDBtcyBsaW5rIHNob3VsZCB0cmFuc2l0aW9uIHRvIHJl
Y292ZXJ5DQo+IHN0YXRlIGR1cmluZyB0aGUgbG93IHBvd2VyIHN0YXRlcyB3aGljaCBpbmNyZWFz
ZXMgcG93ZXIgY29uc3VtcHRpb24uDQo+IA0KPiBQbGF0Zm9ybXMgd2l0aCBaUlgtREMgY29tcGxp
YW50IFBIWSBjYW4gdXNlICJzbnBzLHBoeS16cnhkYy1jb21wbGlhbnQiDQo+IHByb3BlcnR5IGlu
IERlc2lnbldhcmUgY29udHJvbGxlciBEVCBub2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW52
ZXNoIFNhbHZlcnUgPGFudmVzaC5zQHNhbXN1bmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5r
YWogRHViZXkgPHBhbmthai5kdWJleUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNpZS50eHQgfCAyICsrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBjaWUudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBjaWUudHh0
DQo+IGluZGV4IDc4NDk0YzQwNTBmNy4uOTUwN2FjMzhhYzg5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNpZS50eHQNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBj
aWUudHh0DQo+IEBAIC0zOCw2ICszOCw4IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICAgICBm
b3IgZGF0YSBjb3JydXB0aW9uLiBDRE0gcmVnaXN0ZXJzIGluY2x1ZGUgc3RhbmRhcmQgUENJZSBj
b25maWd1cmF0aW9uDQo+ICAgICBzcGFjZSByZWdpc3RlcnMsIFBvcnQgTG9naWMgcmVnaXN0ZXJz
LCBETUEgYW5kIGlBVFUgKGludGVybmFsIEFkZHJlc3MNCj4gICAgIFRyYW5zbGF0aW9uIFVuaXQp
IHJlZ2lzdGVycy4NCj4gKy0gc25wcyxwaHktenJ4ZGMtY29tcGxpYW50OiBUaGlzIHByb3BlcnR5
IGlzIG5lZWRlZCBpZiBwaHkgY29tcGxpZXMgd2l0aCB0aGUNCj4gKyAgWlJYLURDIHNwZWNpZmlj
YXRpb24uDQo+ICBSQyBtb2RlOg0KPiAgLSBudW0tdmlld3BvcnQ6IG51bWJlciBvZiB2aWV3IHBv
cnRzIGNvbmZpZ3VyZWQgaW4gaGFyZHdhcmUuIElmIGEgcGxhdGZvcm0NCj4gICAgZG9lcyBub3Qg
c3BlY2lmeSBpdCwgdGhlIGRyaXZlciBhc3N1bWVzIDIuDQo+IC0tIA0KPiAyLjE3LjENCg0KDQpS
ZXZpZXdlZC1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5j
b20+DQoNCg0K
