Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0953A059B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 23:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhFHVTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 17:19:06 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54374 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230460AbhFHVTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 17:19:04 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E101401BC;
        Tue,  8 Jun 2021 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1623187030; bh=0KWuJxsIQ9csDcMx3+plGEogegpOiC1qQi1WZVFekAQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=a6vom6Dmn94nkh7YTRaK2IJ/sQ3DTUpLxPGej9g6vM+AIcjR+kZL2+d7zkm/463Py
         5Azi1TiApZKN4K1oancNjt5ef08wRrzJ1aPZCKFode61Bmu2G8GUxjPKoLHmdF/fN0
         VPpkVOgEK1iSTvNhO3MFMPypDYBLqGFn2VJC5Ze7NM1xaH5cLipvf7r70wGWPAjtTQ
         M8YnSQHP7ZZ46N8kXLHxOOu32WbfwnM5PqLVb2AxehZhr9o9nU/QkoIW41uz+A2Kyb
         PwKIZNsfkRF3LTMZaX684xOKDUXaMDk+LM3YRGZE4SKpRKiybR5iU5VMg7Fffs7ggV
         JTiqnvRAmElmw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B5C9CA005F;
        Tue,  8 Jun 2021 21:17:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EEA7F400CC;
        Tue,  8 Jun 2021 21:17:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nePxpZf3";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY4Dsf4Aqo1iRTg/SZuaFnUjSlHw08VSW+nQPerxZUtLl4xID/kIG6ccDsYdGaoRz6O7+ifCNFSgLFYoH9rZJl2F8DHBiMW4A61XPgdSmxKpXQpEkUkbs8U0/nu5F9eYgb1e+TA+3Lk78NxpRBm6QfJec0akpFb8V6hYxaeqw1bqTykyolB4WXPcI7xGdObRGAwobIRSFd/QayNvTvOoZLQIzA0LkCgfh3+22S5SUnrpSpAReE1T0J8laxeh+RRQpyoCUVPCSiYEwwjdvAN22OSgVOIIK4FJAQMmUa5G5feRP1iU1KjYFLtP6ghNRk5DkNXdWIMIUaZNNc76WdjXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KWuJxsIQ9csDcMx3+plGEogegpOiC1qQi1WZVFekAQ=;
 b=L8zB/+hO070E1/Myjc0wHPy3idvreYQ0QN0EZRKz1P4NSM6kFCLEE7/M0mPPrGl5SMF0GplTNB/4Mg0RaEMNX7Ym6vvglA6Tj1Uy72Vrf1QZg1WeXwmrCVcIjz4NXOY9F6ylloUqQljkl1gxLLuthY4qn+Jz858TRmN5KNvtC5RFCA1zsjXE3uV3mNpvOaiKOXNdVUKFDQ4SfT6VUbX2oCJx81s0yr/Q9qxFFOwb2vexCMlGeKybyQmbs+eT+/twUuQAlRzsbpGfL7dtnm+jn0FyWpWjbW+KC8EntisZoncP/RwswSB9FznL64XJ4RK4/1A0rrmJj7qDaqR3ZGoRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KWuJxsIQ9csDcMx3+plGEogegpOiC1qQi1WZVFekAQ=;
 b=nePxpZf3HftszdDrvox1azEdEVSZGbuDcFEMhTNvZULdwAik311BUhml0TZhAw94UpPoOEQno2jXhjF96QTsqVecZ6TrwyRGt/WjeQBSSHT+LymeOZt1HXM/MuCLzlqc6PMkD5ZVL+eceepNxnMPE2pAipm707rxI8KUb8SfNyI=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Tue, 8 Jun 2021 21:17:05 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::41d8:f242:b92b:4cf2]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::41d8:f242:b92b:4cf2%11]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:17:05 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Query regarding the use of pcie-designware-plat.c file
Thread-Topic: Query regarding the use of pcie-designware-plat.c file
Thread-Index: AQHXXJuqcWXSuDl/kEa22GAYpjGdEasKmBKw
Date:   Tue, 8 Jun 2021 21:17:05 +0000
Message-ID: <DM5PR12MB18351813A8F94B0D18E6B505DA379@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
In-Reply-To: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MV1JrWkRGaE9XSmpMV000T1dVdE1URmxZaTA1T0dZekxUQXdNV0Uz?=
 =?utf-8?B?WkdSaE56RXhOVnhoYldVdGRHVnpkRnhrWkdReFlUbGlaQzFqT0RsbExURXha?=
 =?utf-8?B?V0l0T1RobU15MHdNREZoTjJSa1lUY3hNVFZpYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RTBNVEFpSUhROUlqRXpNalkzTmpZd05qSXlPVFF6TWpZeU15SWdhRDBpVXpG?=
 =?utf-8?B?Mk4wZDRNREF6SzNabVFpdEJiRGhLUjNVNFNraHpWMXBKUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlNGbEpRVUZCZGxOVksyZHhNWHBZUVZKTVZFOHdOV3B2ZW5Bd1JY?=
 =?utf-8?B?Uk5OMVJ0VDJwUGJsRk9RVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUVVkRFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGRFF6RnNRMmRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
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
 =?utf-8?B?MEo2UVVZNFFXTjNRblJCUjJ0QldYZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVow?=
 =?utf-8?B?RkJRVWRaUVdKM1FqRkJSelJCV2tGQ2VVRklhMEZZZDBKM1FVZEZRV05uUWpC?=
 =?utf-8?B?QlJ6UkJXbEZDZVVGSVRVRllkMEo2UVVoUlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5C?=
 =?utf-8?B?UVVGQlFVRkRaVUZCUVVGYVowSjJRVWhWUVdKblFtdEJTRWxCWlZGQ1prRklR?=
 =?utf-8?B?VUZaVVVKNVFVaFJRV0puUW14QlNFbEJZM2RDWmtGSVVVRmpkMEowUVVkTlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGSlFVRkJRVUZCU2pSQlFVRkNiVUZIT0VGa1VVSjFRVWRSUVdO?=
 =?utf-8?B?blFqVkJSamhCWTBGQ2FFRklTVUZrUVVKMVFVZFZRV05uUW5wQlJqaEJaRkZD?=
 =?utf-8?B?ZEVGSFRVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVGQlFXNW5RVUZCUjJOQlpFRkNl?=
 =?utf-8?B?a0ZHT0VGalFVSjVRVWM0UVZwQlFqRkJSMDFCWkVGQ1prRklVVUZqWjBKb1FV?=
 =?utf-8?B?ZHJRV0puUW5CQlJ6UkJXbmRCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJRVUZCUTBGQlFVRkJRVU5sUVVG?=
 =?utf-8?B?QlFXTjNRbWhCUjNkQldsRkNla0ZHT0VGWlVVSnFRVWROUVdKM1FqRkJSelJC?=
 =?utf-8?B?WkVGQ1prRklRVUZpUVVKb1FVYzBRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQ1FVRkJRVUZCUVVGQlFVbEJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUo2UVVkRlFXSkJRbXhCU0UxQldIZENlRUZJVlVGaWQw?=
 =?utf-8?B?SXdRVWRWUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSVRVRmlaMEozUVVoTlFWaDNRbk5C?=
 =?utf-8?B?UjJ0QldYZENiRUZITkVGamQwSnNRVVk0UVdSQlFteEJTRWxCWWxGQ1prRkVS?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZM2RDZFVGSVFV?=
 =?utf-8?B?RmpkMEptUVVkM1FXRlJRbXBCUjFWQlltZENla0ZIVlVGWWQwSXdRVWRWUVdO?=
 =?utf-8?B?blFuUkJSamhCWTNkQ01FRklWVUZhUVVKc1FVYzBRV1JCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZC?=
 =?utf-8?B?UWpKQlIyTkJXSGRDY2tGSFZVRmxVVUl6UVVjNFFXTm5RbXRCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFV?=
 =?utf-8?Q?FBQUEiLz48L21ldGE+?=
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.9.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc27837-45fb-4d4f-a58b-08d92ac2c43a
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB250402D5ED3DAFC4AC5A2CC5DA379@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cd4Xlz6j7LlZHtF3dgdN6/lCfwwEkplGuW8PhdYUK3MuFsamcIwD2AD4TLTimqG9OpAQYu4bQkswy6nx4pd5aU8PUT5G/5V2yiKV0gAMnBjiu/UIdMwClKmjv9C8/MO44OpkJVjIR+vZZo3nqzA2Sn+fKePQPWXn5PN0TXF4kpcnooTlydsegpPFuaWxG7286k00KhDC3Wfr0yVExCH3kLIyt37z1Qevx7ByUV/QOdkdOGNDUBhXW+xKddKEkKHwMux2mKEH4c+G8YWani3wrYtCz80nMPGBW5kYfSb9XsLsfsOdfqXtU/DEkxLOU2hPW+abaUc8eUMZWpk88v4MKGrLyzplgKET4GKTFKSh54Mx/pvJub8YOQFFSk39KuvwTGso2UkFgi2sF7NwNbjc2ScClI/QoogS5Z8zGAtaD3t1ZS7E8JcZrrpMhB1LTGhDDQwfvY+mIO7Vk+Y/Z7vukTJ70eRP2RYVIHZnJU+0aI/KNuljprdfxYaL33vo/10N6Cey74PWFpnJ2Lpj6ClipD3smLASij82GmoC84Y4qTOgukwgbwQVbxYzvZ7A92kylaGWy8dqQ/SaY2bsfEwHO8ETspE5hRqB0HfEmdCYQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(122000001)(7416002)(8676002)(66476007)(64756008)(38100700002)(55016002)(9686003)(6506007)(26005)(186003)(6636002)(8936002)(2906002)(316002)(4326008)(54906003)(66446008)(66556008)(71200400001)(76116006)(7696005)(53546011)(86362001)(478600001)(5660300002)(52536014)(33656002)(110136005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnBucDhUT1VMZkkwOExPZitHbXZKQ3VTUEhOL3hUMUllQmRzRCsyaWkyRFht?=
 =?utf-8?B?NUpmOXpXeHhkdjJscFdaeHVXNjRjUHNDZHhSWmxJanJZaFZpTXRJMEthc2lP?=
 =?utf-8?B?L1BVcnQvSWFIYzlNcFVteSswWlU3bm12Y3lwbDB5dno5NTU1MzFwbS9Fc0Yr?=
 =?utf-8?B?bTlOYzZDWmdZOEdTU2tBaWR1eE1yTUQvazA2Mk5ObEJNY3FseDE1MkpHWGVu?=
 =?utf-8?B?dTJzU21WclE4dlVXQTBmZ0JNWTR4L3ZkRnRoNFNkeHdhTzAwcDk0Rm5zTWcx?=
 =?utf-8?B?clJnZmd6R3ZDNEJCem1wWVp1aVArVUd2SzdmMWpEUzVMNk5HZUZuczZXcGlq?=
 =?utf-8?B?dFhRNlIxZ3dNemRqUkJXSzdUc3Z0MG9xaWo0bGxERXB2dlFldDE4eXB2TFZy?=
 =?utf-8?B?OERYcS92ZitUQytKZjlzVVVMV29mc1JtZWhQWkdJa3RFbVRXTEgwVlo3N0hM?=
 =?utf-8?B?RjR1YjJxTklZN3FXd2VwY0N5enZvVC9taUZoczFMWEhneDIyNXNwU3F0QXpt?=
 =?utf-8?B?Z05PdHlyTUw3cEpzRnhEczV3Ry9BSm1PZkNlZXNUYmlyaFpMejFlZytuL3FQ?=
 =?utf-8?B?RXpEZTgweHlibWwxVXB5OHhLOGxaK3dra0tKT2kzOStqSlV1VnM5Y0VzcCta?=
 =?utf-8?B?NUJ1cktsZ1B5SHBZazN4NXpTd2dyUUNBQ3dYaUxTenBpSnhnd0hEaGhrVDgx?=
 =?utf-8?B?aHNHYldxbGFVMFVVbXo4MnFNazAvQTczVllDSzJYWTFZSXE3RE1NeVRUdkp0?=
 =?utf-8?B?dGxHQzBXY1hNaGZqOU9jZ09UTGYrdXlFVFBqT0FEUThTcStEaEoxZFZIRDNz?=
 =?utf-8?B?dFhzdWplR012ZXhsNllwZXNUTHlPVnc3SXMydEwxSFVUMy9UQW16YU5kcURL?=
 =?utf-8?B?bU1VYXg1bGRhNFJTamtUeHd5V2VEcmpQNHhoY3hKdHFqSzNCVXY5amlTNEdy?=
 =?utf-8?B?dHhHbHNZMUl6Y1JyY0ViSWw2Mko3UWVMbkZzWGI3dy9jODJ6TmdIbzhyelVo?=
 =?utf-8?B?UUo5bStMNm1iWFc2WHcxZHVpQWI1d2Y4N1ZjM1ZrbXN0cGlrTS9SYis5dzhK?=
 =?utf-8?B?Y3pndmdDUlpNbTV6WDBadW9VVkpvdmkraVdjSzVxQk1kWDBoUm83M1YzZHRj?=
 =?utf-8?B?OTRLbVVzMjhsYzdJVHk2Yi9BVWE0WngyeXY4OVBlOFQ0c1lYNXh1Qi9raXZO?=
 =?utf-8?B?RThLUWdSdVhhWElzNmZjS2NKQXRiQkFYWTFtcFlKZUg4QXBRQ0RWUGVBUjJ6?=
 =?utf-8?B?NVJ4aTBQT0t4bXljOU9YNm1yU2cxQVZ5Y3JiUVh0UHh5RFJZTC9jdXZJYzlM?=
 =?utf-8?B?QjdYaFpnMEo1VWROSGMxRzNCL0pmU0tQYUE5SE03QnErQTkxN0luUUVFUHZZ?=
 =?utf-8?B?ZjhKQTNPS0cxUUppcU1nV3dpdVY2ZFJoYmtUb0pWcHpkNEtaL2dhaFN0QTBp?=
 =?utf-8?B?T3k5dVpEd0RLSmFFcWlKaWhNVUtXdzVGTXJNUldmVVpBUS9ScTNEa0lkdzBO?=
 =?utf-8?B?bjZuZXdlVzhIWUJSYnJ6c1kySDhTWFN2VnNzM1FjbGhMSFBuTHlhc29JdTQ1?=
 =?utf-8?B?TDQycFM5UGY2cWRIUVdLVkg5d1F4cVhKTGxHSE0vSlg3d21RL3J1OG1aZk9q?=
 =?utf-8?B?S2NsQXBQaHFPNi93VExzOFc2dXRmQlVuUG5SQ08yMkRtUTR4Y2NYUkJDK3d1?=
 =?utf-8?B?MEFraFE1dm91SmhQV3NXbzVvZVlWWkJlSGFIK2w0Zi9FTXVLZENMNXBCTFZm?=
 =?utf-8?Q?BJjTKE3pP/ev77dTVc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc27837-45fb-4d4f-a58b-08d92ac2c43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 21:17:05.2046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OD0QPVJW0K0q1olJSBQsECFScnEEg1i7mOI5bF/4eqyu6RdFJcDunM8jLcBg96qT0+1mEGMt30Ess2DF14+RKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgVmlkeWEsDQoNClRoZSBwY2llLWRlc2lnbndhcmUtcGxhdC5jIGlzIHRoZSBkcml2ZXIgZm9y
IHRoZSBTeW5vcHN5cyBQQ0llIFJDIElQIA0KcHJvdG90eXBlLg0KDQotR3VzdGF2bw0KDQpPbiBU
dWUsIEp1biA4LCAyMDIxIGF0IDIwOjIyOjM3LCBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5j
b20+IHdyb3RlOg0KDQo+IEhpLA0KPiBJIHdvdWxkIGxpa2UgdG8ga25vdyB3aGF0IGlzIHRoZSB1
c2Ugb2YgcGNpZS1kZXNpZ253YXJlLXBsYXQuYyBmaWxlLiANCj4gVGhpcyBsb29rcyBsaWtlIGEg
c2tlbGV0b24gZmlsZSBhbmQgY2FuJ3QgcmVhbGx5IHdvcmsgd2l0aCBhbnkgc3BlY2lmaWMgDQo+
IGhhcmR3YXJlIGFzIHN1Y2guDQo+IFNvbWUgY29udGV4dCBmb3IgdGhpcyBtYWlsIHRocmVhZCBp
cywgaWYgdGhlIGNvbmZpZyBDT05GSUdfUENJRV9EV19QTEFUIA0KPiBpcyBlbmFibGVkIGluIGEg
c3lzdGVtIHdoZXJlIGEgU3lub3BzeXMgRGVzaWduV2FyZSBJUCBiYXNlZCBQQ0llIA0KPiBjb250
cm9sbGVyIGlzIHByZXNlbnQgYW5kIGl0cyBjb25maWd1cmF0aW9uIGlzIGVuYWJsZWQgKEV4Oi0g
VGVncmExOTQgDQo+IHN5c3RlbSB3aXRoIENPTkZJR19QQ0lFX1RFR1JBMTk0X0hPU1QgZW5hYmxl
ZCksIHRoZW4sIGl0IGNhbiBzbyBoYXBwZW4gDQo+IHRoYXQgdGhlIHByb2JlIG9mIHBjaWUtZGVz
aWdud2FyZS1wbGF0LmMgY2FsbGVkIGZpcnN0IChiZWNhdXNlIGFsbCBEV0MgDQo+IGJhc2VkIFBD
SWUgY29udHJvbGxlciBub2RlcyBoYXZlICJzbnBzLGR3LXBjaWUiIGNvbXBhdGliaWxpdHkgc3Ry
aW5nKSANCj4gYW5kIGNhbiBjcmFzaCB0aGUgc3lzdGVtLg0KPiBPbmUgc29sdXRpb24gdG8gdGhp
cyBpc3N1ZSBpcyB0byByZW1vdmUgdGhlICJzbnBzLGR3LXBjaWUiIGZyb20gdGhlIA0KPiBjb21w
YXRpYmlsaXR5IHN0cmluZyAoYXMgd2FzIGRvbmUgdGhyb3VnaCB0aGUgY29tbWl0IGY5ZjcxMWVm
ZDQ0MSANCj4gKCJhcm02NDogdGVncmE6IEZpeCBUZWdyYTE5NCBQQ0llIGNvbXBhdGlibGUgc3Ry
aW5nIikgYnV0IGl0IHNlZW1zIGxpa2UgDQo+IGEgbG9jYWxpemVkIGZpeCBmb3IgVGVncmExOTQg
d2hlcmUgdGhlIGlzc3VlIHBvdGVudGlhbGx5IGlzIGdsb2JhbCwgYXMgDQo+IGluLCB0aGUgY3Jh
c2ggY2FuIGhhcHBlbiBvbiBhbnkgcGxhdGZvcm0uDQo+IFNvLCB3b25kZXJpbmcgaWYgdGhlIGNv
bmZpZyBvcHRpb24gQ09ORklHX1BDSUVfRFdfUExBVCBjYW4gYmUgcmVtb3ZlZCANCj4gYWx0b2dl
dGhlciBmb3IgcGNpZS1kZXNpZ253YXJlLXBsYXQuYz8NCj4gDQo+IFRoYW5rcywNCj4gVmlkeWEg
U2FnYXINCg0KDQo=
