Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DD2A36A4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 23:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKBWi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 17:38:58 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59266 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgKBWi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 17:38:58 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5FF2C40109;
        Mon,  2 Nov 2020 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604356737; bh=vzkk3ajT0rz2gSs980Yo0P3tddfWfN1PuEO4f5N3mmw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LDAMlRoibOx8CmMxdb2fiZxkcQrMfdwRMF5VwVck6mYWgBac7rgc0mfYuTd6CCsjO
         FcOHuFYkd46ew7MtEz/wDcbWrJEVzpxPtH0ng+yE1/SUBTaM99ub2/QoxtZ8XF5nss
         ctCbj8vd3eImVkNcuE5kd47CmSjpNQzaU0f9DyGTisvF6OeFQ9iRoV7VN/sjgau64P
         To8y/2kktNhdDdoewkrEBdncbrvFNsE31z6HrCv5B9Z5pHjvQX/HSsXL0bOzMAKRrn
         Kn+gihKD7qJXlBTaj+PxR/kg5wRKKEWX+DymYz2a3fitp2gIzoFcC+QGtQZAa4sPg6
         eSu3UZO1uJ7yw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D018EA0096;
        Mon,  2 Nov 2020 22:38:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1F08C80276;
        Mon,  2 Nov 2020 22:38:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="bkyXzOxv";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb2Dq1XfTYcjhSx8KQpUChoJUX+B+myLgVARyROrIFAY8qY3t5gSUpYuWgQ6qO25KVNsnnWgmNNA3064eJT1XPusZVvK9k5o/1TQpDfadVbj/cMCc4imfdFGCpGuWcX5NL8GoFgYi3b9yTBjvUHSirhCO4Bxv12WVJTJnFbdVx7qsXkECF1ojRXBvRW+gY8e4kigRuMomFhy+Ibdpc5DN3btCFiB/GDkTBQiez2jXcrNjcOxKSA4s74pbkZB+f63gH0/BuhZyIER9YkEfqBmE7xBCF9pHQ1ZaBTG1FD88Bbj/wpE9bdLcB0v+ny+7hkaXjZVMmLtObEwA6VQ1QtXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzkk3ajT0rz2gSs980Yo0P3tddfWfN1PuEO4f5N3mmw=;
 b=PQoBNd+LoYZHbDTek/YoUq+axzhx2D0jCAMsGncksb5NMP9DLV/dhSKdbxyxvNpiyXOOcY0I/0IBENYNx7snkL48hTH+UxuPNvypRrj4G0TyrAl3YInFd76so2WV/hZtebV5hKPPHeNZ9QiT+eAS6wPWzDHZr4xaORCLDsabQgAUp7vsPnTDIPMll1yiRBtke71s92ZUPteWFhRQCKdwORBfPdf9E41tm85/eofqEQi72uoyg4Hf0Y933zkFkPM/JSZ02egyuo7tBjbwSRrkrgyAJwkRZOLk9gG4Myw0JsXBhMuumh4DRsoD+kNASjaJpB29CVnC7+ITLMqGo0e9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzkk3ajT0rz2gSs980Yo0P3tddfWfN1PuEO4f5N3mmw=;
 b=bkyXzOxvQtV5iYkzu8QWfpFbF2gnpy6v9dECNXkJxssDl7qUIEnObST3pqMUjhicEVTGSOcmbW8iNRaxyF5NHVekEREmbFPZqoAcmP7aHi2I9ukPXYnf26WzqIQhxBUlZYmg8xfDR9gfrM+0w//n3O2sgiy+agzBdp6b8VZZaME=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.28; Mon, 2 Nov 2020 22:38:50 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f%8]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 22:38:50 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Rob Herring <robh@kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Topic: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Index: AQHWrbX/k+XWRE5HlkCJXk3ApXY9lam06eWAgAADLYCAAAuOoIAAZusAgAAFG/A=
Date:   Mon, 2 Nov 2020 22:38:50 +0000
Message-ID: <DM5PR12MB1835187E112C8854D4483E42DA100@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <20201029053959.31361-1-vidyas@nvidia.com>
 <20201029053959.31361-3-vidyas@nvidia.com>
 <CAL_Jsq+3Ek9SRbsTqEmjiZtszvi7Er=TNgOt8t=0OESva2=sTg@mail.gmail.com>
 <902c0445-9fed-8e61-3aba-0e87988eb8df@nvidia.com>
 <DM5PR12MB18357E6BF282C9C65278460EDA100@DM5PR12MB1835.namprd12.prod.outlook.com>
 <CAL_Jsq+jH_bwv2dQrY-O4PTD1kK=BMObLjH_NFmfG8kQUUpD8Q@mail.gmail.com>
In-Reply-To: <CAL_Jsq+jH_bwv2dQrY-O4PTD1kK=BMObLjH_NFmfG8kQUUpD8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVEppTmpVeVlUWTBMVEZrTldNdE1URmxZaTA1T0dRMUxXWTRPVFJq?=
 =?utf-8?B?TWpjek9EQTBNbHhoYldVdGRHVnpkRnd5WWpZMU1tRTJOUzB4WkRWakxURXha?=
 =?utf-8?B?V0l0T1Roa05TMW1PRGswWXpJM016Z3dOREppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?UTROVGtpSUhROUlqRXpNalE0T0RNd016STRNemc0TnpBNU5pSWdhRDBpYUZS?=
 =?utf-8?B?UWQwSXJkMXBJZDA5WlNUVXhVVUZZU0UweGJUaERSRlZqUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlFsRktRVUZFTkZkNVNIVmhURWhYUVZaM01XRkZOVXBLYUdsRFdF?=
 =?utf-8?B?UldiMVJyYTIxSFNVbFBRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f59a6bab-99b2-4b15-c50a-08d87f8011ec
x-ms-traffictypediagnostic: DM5PR12MB1835:
x-microsoft-antispam-prvs: <DM5PR12MB18358308B3874928E58394B4DA100@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0cgT8jiDEtQKAEjlEJTKnw5/2l/bQwybZs3kpyOG7K4A4zjLr9pSnkbjo9U+X7Ogfek0bm3zDd9LJOKrTOwt1xo8NBAIFEWR27OjDD8GxqAzBDprL2oWvP8n9VWaEVOW8y3+eBFmEenrLEtUIZXXX1gCxG4AVzudVfuQayxERamIGaTCtpJ3bgyyfHiOK+1tsPqA9T3+gJjVT6kNxQC2bLR5BtxP1ao2F1BuUKMOQKEctjKbL0m+2EDMYb0BfqLJTc7GHuWhB94e4u+XztJFxeSwK9Py7XSEPfG0IRT9b4NRqxqQYnKUSbO3Es3jYB5MqFa9Vl9YGIWNYqM36N3ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(7696005)(26005)(8936002)(52536014)(478600001)(8676002)(6916009)(186003)(9686003)(4326008)(71200400001)(5660300002)(55016002)(66446008)(2906002)(316002)(54906003)(83380400001)(76116006)(66946007)(53546011)(6506007)(86362001)(66476007)(33656002)(7416002)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VStygTsmt+mZx0X3NoQ7XopDdBHK92Rk3SNA8TtaOewfvOSZuxH+vHRpLy2JUE9MydY4w4GXD2gPL+PWnTyZpIexJTQybh2s85FfgCHogCoY5QfZH77ZUkeGgee2hufuz6GW4Pcs3oEvOK8H1PTJanF8z7KYAJaowGrzB+M1ai+0lJk1YYwhI6JpNHbJ02GQUtWhV76C5JPUpex/0qp9MJiYqpKqvjqIIJzeBu2WfeAHEQxBuQvyv4n8HC5OPDyEOLyKDqBTZIDzGa0KncsiS+wogX5ZWuloTWYkw9BMeFW5WN0wQrTfQhAoJL+pHVG4BaeYtF0b364IK72LKPGVdC8KaWlw+hQouv2gjucRyDYWQYhb36CbsMgh8gXCKU3umyGBGtaraU55RtgN2KG+TCuuhrgA2YC646h2Ayoq0lecFhJAitq14EfvMJGH2FeMrsPGuVPukTrJld+8h+IvIfFRtEVQYVJcgLa8JZ0OQpKseGhA8dplYO1Stev0a4So/xjFonPWFljci7L3oYWViM3UKrpWkp4fc/8OCF2CaIE5khjmAEGEjlJ8QtSa8n5PDxjExSrfy3cThA+T9Z8zNLCv8MJ1HYjpOjeGaMbrpXYrWE2cjkKwnV3V4Hv1ehTkC5jcOpK5AbNX/9rVMAk76w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59a6bab-99b2-4b15-c50a-08d87f8011ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 22:38:50.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWOL8TKn7I1GKxl/dFVoChNvFbIr7YUhNLg9PM56J6pFi8ac1cRVscj3QbWGqiFBWmWaHvOe9iUDIL7l4YVUww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCBOb3YgMiwgMjAyMCBhdCAyMToxNjo1MiwgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4gd3JvdGU6DQoNCj4gT24gTW9uLCBOb3YgMiwgMjAyMCBhdCA5OjEyIEFNIEd1c3Rhdm8g
UGltZW50ZWwNCj4gPEd1c3Rhdm8uUGltZW50ZWxAc3lub3BzeXMuY29tPiB3cm90ZToNCj4gPg0K
PiA+IE9uIE1vbiwgTm92IDIsIDIwMjAgYXQgMTQ6Mjc6OSwgVmlkeWEgU2FnYXIgPHZpZHlhc0Bu
dmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiAxMS8yLzIwMjAg
Nzo0NSBQTSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiA+IEV4dGVybmFsIGVtYWlsOiBVc2Ug
Y2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IE9uIFRodSwgT2N0IDI5LCAyMDIwIGF0IDEyOjQwIEFNIFZpZHlhIFNhZ2FyIDx2aWR5
YXNAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiA+Pg0KPiA+ID4gPj4gRGVzaWduV2FyZSBjb3Jl
IGhhcyBhIFRMUCBkaWdlc3QgKFREKSBvdmVycmlkZSBiaXQgaW4gb25lIG9mIHRoZSBjb250cm9s
DQo+ID4gPiA+PiByZWdpc3RlcnMgb2YgQVRVLiBUaGlzIGJpdCBhbHNvIG5lZWRzIHRvIGJlIHBy
b2dyYW1tZWQgZm9yIHByb3BlciBFQ1JDDQo+ID4gPiA+PiBmdW5jdGlvbmFsaXR5LiBUaGlzIGlz
IGN1cnJlbnRseSBpZGVudGlmaWVkIGFzIGFuIGlzc3VlIHdpdGggRGVzaWduV2FyZQ0KPiA+ID4g
Pj4gSVAgdmVyc2lvbiA0LjkwYS4gVGhpcyBwYXRjaCBkb2VzIHRoZSByZXF1aXJlZCBwcm9ncmFt
bWluZyBpbiBBVFUgdXBvbg0KPiA+ID4gPj4gcXVlcnlpbmcgdGhlIHN5c3RlbSBwb2xpY3kgZm9y
IEVDUkMuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gU2lnbmVkLW9mZi1ieTogVmlkeWEgU2FnYXIgPHZp
ZHlhc0BudmlkaWEuY29tPg0KPiA+ID4gPj4gUmV2aWV3ZWQtYnk6IEppbmdvbyBIYW4gPGppbmdv
b2hhbjFAZ21haWwuY29tPg0KPiA+ID4gPj4gLS0tDQo+ID4gPiA+PiBWMzoNCj4gPiA+ID4+ICog
QWRkZWQgJ1Jldmlld2VkLWJ5OiBKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT4nDQo+
ID4gPiA+Pg0KPiA+ID4gPj4gVjI6DQo+ID4gPiA+PiAqIEFkZHJlc3NlZCBKaW5nb28ncyByZXZp
ZXcgY29tbWVudA0KPiA+ID4gPj4gKiBSZW1vdmVkIHNhdmluZyAndGQnIGJpdCBpbmZvcm1hdGlv
biBpbiAnZHdfcGNpZScgc3RydWN0dXJlDQo+ID4gPiA+Pg0KPiA+ID4gPj4gICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyB8IDggKysrKysrLS0NCj4gPiA+ID4+
ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCAxICsNCj4g
PiA+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmMNCj4gPiA+ID4+IGluZGV4IGI1ZTQzOGI3MGNkNS4uY2JkNjUxYjIxOWQyIDEw
MDY0NA0KPiA+ID4gPj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmMNCj4gPiA+ID4+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5jDQo+ID4gPiA+PiBAQCAtMjQ2LDYgKzI0Niw4IEBAIHN0YXRpYyB2b2lkIGR3
X3BjaWVfcHJvZ19vdXRib3VuZF9hdHVfdW5yb2xsKHN0cnVjdCBkd19wY2llICpwY2ksIHU4IGZ1
bmNfbm8sDQo+ID4gPiA+PiAgICAgICAgICBkd19wY2llX3dyaXRlbF9vYl91bnJvbGwocGNpLCBp
bmRleCwgUENJRV9BVFVfVU5SX1VQUEVSX1RBUkdFVCwNCj4gPiA+ID4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1cHBlcl8zMl9iaXRzKHBjaV9hZGRyKSk7DQo+ID4gPiA+PiAg
ICAgICAgICB2YWwgPSB0eXBlIHwgUENJRV9BVFVfRlVOQ19OVU0oZnVuY19ubyk7DQo+ID4gPiA+
PiArICAgICAgIGlmIChwY2ktPnZlcnNpb24gPT0gMHg0OTBBKQ0KPiA+ID4gPj4gKyAgICAgICAg
ICAgICAgIHZhbCA9IHZhbCB8IHBjaWVfaXNfZWNyY19lbmFibGVkKCkgPDwgUENJRV9BVFVfVERf
U0hJRlQ7DQo+ID4gPiA+PiAgICAgICAgICB2YWwgPSB1cHBlcl8zMl9iaXRzKHNpemUgLSAxKSA/
DQo+ID4gPiA+PiAgICAgICAgICAgICAgICAgIHZhbCB8IFBDSUVfQVRVX0lOQ1JFQVNFX1JFR0lP
Tl9TSVpFIDogdmFsOw0KPiA+ID4gPj4gICAgICAgICAgZHdfcGNpZV93cml0ZWxfb2JfdW5yb2xs
KHBjaSwgaW5kZXgsIFBDSUVfQVRVX1VOUl9SRUdJT05fQ1RSTDEsIHZhbCk7DQo+ID4gPiA+PiBA
QCAtMjk0LDggKzI5NiwxMCBAQCBzdGF0aWMgdm9pZCBfX2R3X3BjaWVfcHJvZ19vdXRib3VuZF9h
dHUoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTggZnVuY19ubywNCj4gPiA+ID4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBsb3dlcl8zMl9iaXRzKHBjaV9hZGRyKSk7DQo+ID4gPiA+PiAgICAg
ICAgICBkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0FUVV9VUFBFUl9UQVJHRVQsDQo+ID4g
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXBwZXJfMzJfYml0cyhwY2lfYWRkcikp
Ow0KPiA+ID4gPj4gLSAgICAgICBkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0FUVV9DUjEs
IHR5cGUgfA0KPiA+ID4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgUENJRV9BVFVfRlVO
Q19OVU0oZnVuY19ubykpOw0KPiA+ID4gPj4gKyAgICAgICB2YWwgPSB0eXBlIHwgUENJRV9BVFVf
RlVOQ19OVU0oZnVuY19ubyk7DQo+ID4gPiA+PiArICAgICAgIGlmIChwY2ktPnZlcnNpb24gPT0g
MHg0OTBBKQ0KPiA+ID4gPg0KPiA+ID4gPiBJcyB0aGlzIGV2ZW4gcG9zc2libGU/IEFyZSB0aGUg
bm9uLXVucm9sbCBBVFUgcmVnaXN0ZXJzIGF2YWlsYWJsZSBwb3N0IDQuODA/DQo+ID4gPiBJJ20g
bm90IHN1cmUuIEd1c3Rhdm8gbWlnaHQgaGF2ZSBpbmZvcm1hdGlvbiBhYm91dCB0aGlzLiBJIG1h
ZGUgdGhpcw0KPiA+ID4gY2hhbmdlIHNvIHRoYXQgaXQgaXMgdGFrZW4gY2FyZSBvZmYgZXZlbiBp
ZiB0aGV5IGF2YWlsYWJsZS4NCj4gPg0KPiA+IFRoZSBTeW5vcHN5cyBEZXNpZ25XYXJlIFBDSWUg
SVAgaXMgaGlnaGx5IGNvbmZpZ3VyYWJsZSwgdGhlcmVmb3JlIGlzDQo+ID4gZGVwZW5kYWJsZSBv
biB3aGF0IHRoZSBkZXNpZ24gdGVhbSBoYXMgY29uZmlndXJlZCBmb3IgdGhlaXIgc29sdXRpb24u
DQo+ID4gQWx0aG91Z2ggU3lub3BzeXMgZG9lc24ndCByZWNvbW1lbmQgdGhlIHVzZSBvZiBub24t
dW5yb2xsIEFUVSwgdGhlDQo+ID4gY3VzdG9tZXJzIGFyZSBmcmVlIHRvIHNlbGVjdCB3aGF0IHRo
ZXkgd2FudCBmb3IgdGhlaXIgZGVzaWduLg0KPiANCj4gT2theSwgdGhlbiB0aGVyZSdzIGEgYnVn
IGluIHRoZSBkcml2ZXIgaWYgdGhlIHZlcnNpb24gaXMgc2V0IHRvIDB4NDgwQQ0KPiBvciBsYXRl
ciBhbmQgbm9uLXVucm9sbCBpcyB1c2VkOg0KPiANCj4gaWYgKHBjaS0+dmVyc2lvbiA+PSAweDQ4
MEEgfHwgKCFwY2ktPnZlcnNpb24gJiYNCj4gICAgICAgIGR3X3BjaWVfaWF0dV91bnJvbGxfZW5h
YmxlZChwY2kpKSkgew0KPiANCj4gUHJvYmFibHkgY2FuIGp1c3QgZHJvcCB0aGUgdmVyc2lvbiBj
aGVja2luZy4gVGhlIGRldGVjdGlvbiBzaG91bGQgYWx3YXlzIHdvcmsuDQoNCkhpIFJvYiwNCg0K
VGhlICJkZXRlY3Rpb24iIGlzIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHJlYWQg
dmFsdWUgb24gDQpQQ0lFX0FUVV9WSUVXUE9SVCByZWdpc3RlciBpcyAweGZmZmZmZmZmICh3aGlj
aCBpcyBhIGhhcmQtY29kZWQgdmFsdWUgYnkgDQpkZXNpZ24pLCBpZiBpdCdzIHRydWUgdGhlbiB0
aGUgaUFUVSBpcyB1bnJvbGxlZCBhbmQgdGhlIGZ1bmN0aW9uIHJldHVybnMgDQoxLCBvdGhlcndp
c2UgaXMgbm9uLXVucm9sbGVkIHJldHVybnMgMC4gU28gbGlrZSB5b3Ugc2FpZCBpdCBzaG91bGQg
YWx3YXlzIA0Kd29yaywgaG93ZXZlciwgdGhpcyBjb2RlIGJlaGF2aW9yIHdhcyBjaGFuZ2VkIGJ5
IEtpc2hvbiBvbiB0aGUgZm9sbG93aW5nIA0KcGF0Y2ggMmFhZGNiMGNkMzkgKCJQQ0k6IGR3Yzog
Rml4IEFUVSBpZGVudGlmaWNhdGlvbiBmb3IgZGVzaWdud2FyZSANCnZlcnNpb24gPj0gNC44MCIp
LiBIaXMgcGF0Y2ggbWFrZXMgbWUgYmVsaWV2ZSB0aGF0IG9uIGtleXN0b25lIHBsYXRmb3JtIA0K
dGhlIHJlYWQgb3BlcmF0aW9uIG9uIHRoYXQgcmVnaXN0ZXIgY2F1c2VzIHNvbWUgdW5wcmVkaWN0
ZWQgYmVoYXZpb3IgDQpsZWFkcyBoaXMgcGxhdGZvcm0gdG8gY3Jhc2gvYWJvcnQsIHRoYXQncyB3
aHkgaGUgY3JlYXRlZCB0aGlzIGFsdGVybmF0aXZlIA0KdmVyc2lvbiBhcHByb2FjaCB0byBhdm9p
ZCB0aGUgImRldGVjdGlvbiIgYWxnb3JpdGhtLg0KDQpGcm9tIHdoYXQgSSdtIHNlZWluZyB0aGUg
b25seSBkcml2ZXJzIHRoYXQgdXNlIHRoaXMgInZlcnNpb24iIGFwcHJvYWNoIA0KYXJlIHRoZSBr
ZXlzdG9uZSBhbmQgaW50ZWwtZ3cgKHdoaWNoIHByb2JhYmx5IGRvZXNuJ3QgbmVlZCBpdCkuDQoN
ClRvIHN1bW1hcml6ZSwgdGhpcyBpcyBhIHdvcmthcm91bmQgc28gdGhhdCB0aGUga2V5c3RvbmUg
ZHJpdmVyIGRvZXNuJ3QgDQpicmVhayBpbmRlcGVuZGVudCBvZiB0aGUgY29udHJvbGxlciBJUCB2
ZXJzaW9uLg0KDQotR3VzdGF2bw0KPiANCj4gUm9iDQoNCg0K
