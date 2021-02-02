Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325B30C6DC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 18:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhBBRCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 12:02:24 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53230 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236911AbhBBQ7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 11:59:54 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A12AF4023D;
        Tue,  2 Feb 2021 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612285133; bh=AU6DuKIx324rjT4s/2Rmnz+vm5etz17Kfp7XmWTX1UI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j+lrO6b5Z7+QwJCMeLFct8dHiTgIjwjGTQAlg83VBs5iY+0CFsdfiHIP+PofHPxnx
         iNcpis7aFMANU6aR1hAjQYUj8PoVoiNbcXZG+5BUMPgcVuVn/eZZIDZ5AiXb9V9J2+
         6Bi1xNpL3/s+w9D2Lw9tY2gXJGdmpKihd/6AGDEjtzz5F/8tbPv0GTAcV8hyK3dAcG
         hi7Mj6YaJ/DSMW41x+MPBI2aDiHCXfrDxZL20UOHgL097+Ea6c9GZTw3H+Gk0MKg7t
         nOXjVJRfPjTc+9DzQNa2Y7A5ChbMS3icOCV6CbBKNqmYSG3dmL0SFAuvjd1QSR5sS+
         BzHFdPN0UOi9g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4BD2DA006F;
        Tue,  2 Feb 2021 16:58:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EF8AC400A3;
        Tue,  2 Feb 2021 16:58:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UXmK1iL+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP5wp0gC46kbGkwfBALag+HYqKyeYo4/3w3zAJdAa+P+pYeGneNGSfgM5xSPLEHg3MMp/2c3/BEHbnDPSazI5Y+gE3SOlIt7syJlk+ElGrMlxFS41F1OmYtbuFjR6VBH0f1UtJdS07fWg83GYZZgmAhYVc7Sq58ww7tLhKbbIfj/5QopUODBynrvQlS/nDsRITe3St6xWVVi/pd9dSs7xc0OjMLv5+Bps65i+fHFYb410Voj69gE/RGk9t9IemGMaUSCcQm85M0NGGILU06C5k7B/rZrKBsmkOabckp+3WWjo8WIPayb/+ucDIoX6q212MgaZ1ylGF9SgqSZELiPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU6DuKIx324rjT4s/2Rmnz+vm5etz17Kfp7XmWTX1UI=;
 b=J1Lv+UOAFumn5YMD7SX3u7pMQlvkYFSc4+sVLEeAgpjKguxoRSsCf+OOaOAeOFTACykZKiEiVxPZIwp9ElSs7VIdtMLfaes8YSDsb6L9mhVm2wJRIwSwGP8ygyi7iRGXIylcdGnX1wv0dfjNF3+GbRd5giUuCaWIsDrVgVPDxfweflwn4ettOdhkvg6SPJYMvqPoUtUA4phRyva86S9cU9oNTwH++bFTSJN+lLI+4p4J8cLnZegWwJVOceHWo8/b+RuSBsxOhaihpIlTPgUa0YyNYBFTCt/IrbwXJmzner47k2I1H8XqvLd09auUUQOZn86ebaSRFz/g1CnyjguTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU6DuKIx324rjT4s/2Rmnz+vm5etz17Kfp7XmWTX1UI=;
 b=UXmK1iL+zG01lBbayWrEyAW0i8jBssoUB1BKMbsJZtqvdhGbp6XIJqhmLkhopmONPqDqn+kthFEp5NZbmj74ENqsk2uo9XL1mE7f/6Kpj+pBsqKlO1ubSFMDkCKu82m/Cc60Q0b8T9B+bIcSkg+ZYZqohKUw9fHEseRuHexz9/4=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.22; Tue, 2 Feb 2021 16:58:50 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 16:58:50 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Thread-Index: AQHWvlUnrEoqwwtzmk2HTCBmG0B2lKpFBCnAgAAWroCAAAXKUIAAAxKAgAADzUA=
Date:   Tue, 2 Feb 2021 16:58:50 +0000
Message-ID: <DM5PR12MB18352C83BFA6587910C922A7DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
 <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YBklScf1HPCVKQPf@kroah.com>
 <DM5PR12MB183515FF24DC1C306CDCD718DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YBkst6PeVskpi4SO@kroah.com>
In-Reply-To: <YBkst6PeVskpi4SO@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MV1U1TTJWak0yVmpMVFkxTnpjdE1URmxZaTA1T0dVMkxXWTRPVFJq?=
 =?utf-8?B?TWpjek9EQTBNbHhoYldVdGRHVnpkRnhsT1RObFl6TmxaQzAyTlRjM0xURXha?=
 =?utf-8?B?V0l0T1RobE5pMW1PRGswWXpJM016Z3dOREppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RXlNRGNpSUhROUlqRXpNalUyTnpVNE56STRNems0TWpFMk5TSWdhRDBpUldO?=
 =?utf-8?B?a1prcGphbU16Yld0WWFtVmFjVFZUY0ZCb1dISkpaRXhWUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlFsRktRVUZDVmpFNGNYTm9VRzVYUVdOdlZFOXhaR3h6V0hWRWVX?=
 =?utf-8?B?aE5ObkF5VjNobE5FMVBRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUTJ0RFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGT2NsTldNMmRCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
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
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e2342c9-72fd-4b70-24a4-08d8c79bd083
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-microsoft-antispam-prvs: <DM5PR12MB235861B36A49FB452EEA130CDAB59@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lg47oPrP0LNyP+xLXW6kC0gANDKBSXcZDAKuW9O//G+ltNQd/AWZPgOHDxrt5OBFCFKH4Ze3N3Ro7tAv8F2ruHDnb8kAPkIAoSkUbFAtb2Qp6+PA9bBzoWSRPNM2LdpfF3TP5raGsbtlvibV8a8AjHk3CIbd1EJccvbhIgjMHLmCD4f5FJ8C1KaMdcEw7Gpk83PTI4xof++lKXBWRi25JFHQFnokjci5mMYSsIrW34opTGMR0s9kneKyFGIBt1YtDquzYNP6ZQE/wTeWFqkF3fdeoVoYm4brUhzoQY+PKtoct5v45980ImtHp1YeC4N3LE8vj72+BsxZJRkynKe0NxLEi5jGYGUJPKAZ8kKYhA9GcpTNlTIyu8uzFCagWQ2bG1Picnp8Tdcu/uozkk9haMy+SRw5/gICheSmdQEqF97cwAMYksLeCiLxvR3keYg8LvPtF9xExMsk4XbeBqAedWl8Max1wUCzBAwMWStwr4nP+Mii1NAwrwOK6AXATek/gZknzVot5AwKr8X4iGQ4Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(33656002)(316002)(9686003)(7696005)(54906003)(83380400001)(2906002)(4326008)(55016002)(66446008)(53546011)(71200400001)(6506007)(6916009)(186003)(64756008)(76116006)(4744005)(478600001)(66556008)(5660300002)(66476007)(52536014)(8936002)(86362001)(26005)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZTZLNVZ2TGFOYlV3U1I4UzBwOEZWL0dzT2pkMEdQRGIwS3BmZmtKc3N1Mk5K?=
 =?utf-8?B?TjY3bTJaNDBJUUZsVHVPUVIyUDJ5d0doUkNERUg4TnFJZm80a3RQcUN0cFZ6?=
 =?utf-8?B?R0xqcmNuU3lJZDkvRVdwc01OZ2JXditUMEJUUUFVdjBnK2cvTjM3ejl2dmpa?=
 =?utf-8?B?QlhPQmUzUE5uWXd0aWdYNGpsa0xBYzZWS2l3WW8weTc0NGpaK21JOFNYaHZh?=
 =?utf-8?B?NXdmRHY3aWtmMmRjelg4VU1JTnE3TVVjRThSMlA2S1VlZzBWdE9ta3d2Snpy?=
 =?utf-8?B?KzVxWkJ0cm9adEZVNDhBMm5yQmlJNUFUc0V6K2hJVEtWQlh2TVVJV3JGWVlJ?=
 =?utf-8?B?MVdteXdMb0J3V0lOMlphMGtRYXFwcXovRkl1WGJ4Rnd6bVdBUk9pNEI3SnNj?=
 =?utf-8?B?Q0RlOUMwcGMxNjUvYjFsS2Z1VmJzNExGcTRMK3I4U253YkE5VXRES0ljOElF?=
 =?utf-8?B?WVQ4VWJhMk5wK3FKTHp4UzdDZjJkTmZIVUJ0MnpYUGN0WE9qSDVwYUpJTlp5?=
 =?utf-8?B?Snc3UENZTjhpY2g2L0F1WlJrejYzOE1sSmxwK2hTajJHbGV4QTBrdlFRT3ZS?=
 =?utf-8?B?ZUZmQTd0Q09hWUN6Qk9xK3U1Y3A2bm4yT2E2YkdrVG5DOXNaTGdiczFkUjNz?=
 =?utf-8?B?YVUwNUpTdGxtTlNWb2o3L0xwMERBdjAvUzlja2xZeG1rTkZjQ093TlFPOVds?=
 =?utf-8?B?Qjd0L3IwTWV2WnpuT1d5SndyQ1lpSFBqZ0Y3N2ZWb3lOWVJVLzZVLy9xYlFI?=
 =?utf-8?B?MEMvbzJraDJXc1VBTTlzbnV4YWxPV0ZLemJoVUNJdkgrS1ZMeWJEOVJvVkhK?=
 =?utf-8?B?aU5LYlJ0R0cyd3ZZKzdUcEM4eXZnelFTSjNSN1lKTXJYRWpFeHFqWUZHM3NF?=
 =?utf-8?B?K0RCRWNwRTVXSENReTBxd21xK2dacGZrR0I0bGhjNS9HM1cyYjFuQnJwNS95?=
 =?utf-8?B?S2V5Z0ovOW9mUjJwRXdTOFN2bEh6VGE5ejZwaFFiczdKNlc2TmhQbC9rWUU2?=
 =?utf-8?B?bmVVS2dVdU4zSlJIcEIrbVNQbnJtQm4rZE1VQ0x3MFVwZzBmNXV1bXhFZXFO?=
 =?utf-8?B?WU5aUXhkSkJHN1VFWThwaGRWb0cyTFRWMyt1ZWFZTVhLcUJVU0x1MTczK09j?=
 =?utf-8?B?cGlKNEwzU2FJeFBNTm5qWVBvOWloWm1reTVBdmgwYmoyajU2WXF1SjVvQW1P?=
 =?utf-8?B?WlVMQjIrZVdIU1N6MkRkYnM5d054RlRGUUVHazVwUTFyRExpMDg3YU13d3ZC?=
 =?utf-8?B?ZEgvNzI5eVlzSndMRmZKazM0L0xLNDg2MzBSalRONVFMMXFNOTkrS1BkTW9n?=
 =?utf-8?B?a0RYWkw4ek53SDEwR0p3ZXBHUFRDZENJQXdEdEtEMzBtQTZnMGVvVjMzaTFQ?=
 =?utf-8?B?UEtuNDRUZ1ZtcW14SmJIbEswNXBzNVVaRnRRQVg2LzJXQTNhMUUvbU5vRWRk?=
 =?utf-8?Q?hSc685sm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2342c9-72fd-4b70-24a4-08d8c79bd083
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 16:58:50.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MBdmy/n+8fG9olObIl94ayWZZoUEZ5xDYFkmKxYn/tWS44hcmv8zDeeLIKUQBxWRqcC6o0YibTXXOCyl8I+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCBGZWIgMiwgMjAyMSBhdCAxMDo0MzozLCBHcmVnIEtyb2FoLUhhcnRtYW4gDQo8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgRmViIDAyLCAyMDIx
IGF0IDEwOjM4OjI5QU0gKzAwMDAsIEd1c3Rhdm8gUGltZW50ZWwgd3JvdGU6DQo+ID4gT24gVHVl
LCBGZWIgMiwgMjAyMSBhdCAxMDoxMToyMSwgR3JlZyBLcm9haC1IYXJ0bWFuIA0KPiA+IDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gDQo+ID4gPiBPbiBUdWUsIEZlYiAw
MiwgMjAyMSBhdCAwODo1MToxMEFNICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3RlOg0KPiA+
ID4gPiBKdXN0IGEga2luZGx5IHJlbWluZGVyLg0KPiA+ID4gDQo+ID4gPiByZW1pbmRlciBvZiB3
aGF0Pw0KPiA+IA0KPiA+IFRvIHJldmlldyB0aGUgcGF0Y2ggc2V0LiBJJ3ZlIGRvbmUgdGhlIHJl
cXVlc3RlZCBtb2RpZmljYXRpb25zLCBidXQgSSANCj4gPiBkaWRuJ3QgZ2V0IGFueSBmZWVkYmFj
ayBpZiB0aGlzIHBhdGNoIHNlcmllcyBpcyBmaW5lIG9yIGl0IG5lZWRzIA0KPiA+IHNvbWV0aGlu
ZyBtb3JlIHRvIGhhdmUgYW4gQUNLLg0KPiANCj4gSSBkbyBub3Qga253bywgSSBkb24ndCBzZWUg
YW55dGhpbmcgbXkgbXkgcmV2aWV3IHF1ZXVlLCBzb3JyeS4NCg0KSSd2ZSByZXNlbmQgdGhlIHBh
dGNoIHNlcmllcy4gTGV0J3Mgc2VlIGlmIGFwcGVhcnMgbm93IPCfmIoNCg0KPiANCj4gPiBJZiBz
b21lIGZlZWRiYWNrIHdhcyBwcm92aWRlZCwgcGxlYXNlIGFjY2VwdCBteSBhcG9sb2dpZXMuIE15
IGVtYWlsIA0KPiA+IGFjY291bnQgd2FzIGhhdmluZyBzb21lIGlzc3VlcyBzb21lIHRpbWUgYWdv
IGFuZCBJIG1pZ2h0IG5vdCBoYXZlIA0KPiA+IHJlY2VpdmVkIHNvbWUgZW1haWxzLg0KPiANCj4g
Q2hlY2sgdGhlIGFyY2hpdmVzIHBsZWFzZSwgdGhhdCdzIHdoYXQgdGhleSBhcmUgdGhlcmUgZm9y
IDopDQoNCkkgaGF2ZSBqdXN0IGNoZWNrZWQsIHRoZXJlIGlzbid0IGFueSBmZWVkYmFjayBiZXNp
ZGVzIHlvdXJzIGFuZCBBcm5kIA0KQmVyZ21hbm4uDQoNClRoYW5rIHlvdSBHcmVnLg0KDQotR3Vz
dGF2bw0KDQo+IA0KPiBncmVnIGstaA0KDQoNCg==
