Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2EF3116DF7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLIN3f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 08:29:35 -0500
Received: from mail-oln040092254031.outbound.protection.outlook.com ([40.92.254.31]:6887
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727200AbfLIN3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 08:29:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTOVKWDKC34nQuSCQUsaCBIFIb0jTl+rHm+flqh7VX6QEk56OZwjSrBEBmPuoJtSmxv4KmIoJdNFxHVvL+qq9fhf2kGpouzc4h7/DLGrWOiANzV77Wv3o3tV8MZVMkuwbEFZy+CJ23bjkWEb/A057BMeX899YXRFxRX4pd3xw//HUPxr0TDwWlOjkqlTbLrAPnmQ7ryifJGA+lvRD7qWxy8Am+BRXJ06Qbky+/oYO3bp6Vgfeli1Zz2IqMwWPpO12PZntUteoNGdF3XwjLyGQKdWDI89sfecXvf4aQuoozw+0mF72XSiyWC2O7F5QqPhfAzpYkgftRJKJtvvbqdEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFpM1/LjlwttsvtxF3epBLhvFitQ/9uvTZOw78C08ts=;
 b=OUO+9Eg6Zl6aPXqFHalXTQzORINwF0z/cchhgCk0zC5XM5350hlXsmMpBWOO6yiW7UBZkX11DUHoI9asaBfrn1eBy55hfQ7ySQvZcMJhgAUFMZFvcv2tSyhWjhLHvDUbXFP4vgakZwumxwJ8LjoDbnJHeA4WovojLFsnk4WgJ+XCJgj48eLEzQsUS0i1CEis1rGdiYlQomvqiLDg3UHrwCl6TFYzfcE/sHZEG1bws4Y9O0LMSdorcfuMo/JehI+gXoLvzSC3xOBNEuHJdkBs//arHZBWq9hZqJ8HilMFQEOtvAqYYmP0p7J2hQQqZNZdXaIT4dagHt2HaicOwkxVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT053.eop-APC01.prod.protection.outlook.com
 (10.152.250.53) by SG2APC01HT185.eop-APC01.prod.protection.outlook.com
 (10.152.251.234) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 13:29:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT053.mail.protection.outlook.com (10.152.250.240) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 13:29:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 13:29:30 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux v5.5 serious PCI bug
Thread-Topic: Linux v5.5 serious PCI bug
Thread-Index: AQHVrozxq7Q7SfMf80m5ItEmvTDCAqexx4+AgAAErAA=
Date:   Mon, 9 Dec 2019 13:29:30 +0000
Message-ID: <PSXP216MB043859B2FDA7F999BF88157080580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
In-Reply-To: <20191209131239.GP2665@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:1:14::17) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:BEB30873ABCC25B5565F5D3A6A36081768C3DD8669B47737EBFD0A309183371B;UpperCasedChecksum:8D1BC1703EE630EB29FDA5E04F4439190C7646E1C5BE41852E42BA12C1DBED6B;SizeAsReceived:7561;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [y7A3tuTwl0WLW6Q18MnKzshhVKbkEBF4gZPX2Tn4DjXarWvSp+XlWOfX69UKiTvf1Wku68q7XRc=]
x-microsoft-original-message-id: <20191209132922.GA1911@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 43b09229-1e43-4caf-7604-08d77cabd1f7
x-ms-traffictypediagnostic: SG2APC01HT185:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkSNJJgEFuWe0zLghBrZizywqlWc2v9yCc6hqzWpO3u5LzBMbbGd6bUTcwoi33BXmQhMv7hHDv0lCN8aE35M+93n7NFbcPFtbcPa0hYk28+E762S3hmn7EfSe4hzg0+1mTbS5l6EYNrsFK8xPSbqqlOJ88/wEEgEivflMa7WGpHPzTCaZnh7nhyb/T2dr8oh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C52A66FC21E644BA769DF57BFC497B5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b09229-1e43-4caf-7604-08d77cabd1f7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 13:29:30.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT185
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > Hi,
> > 
> > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > GPU driver.
> > 
> > We had:
> > - kernel NULL pointer dereference
> > - refcount_t: underflow; use-after-free.
> > 
> > Attaching dmesg for now; will bisect and come back with results.
> 
> Looks like something related to iommu. Does it work if you disable it?
> (intel_iommu=off in the command line).
I thought it could be that, too.

The attachment "dmesg-4" from the original email is with iommu parameters.
The attachment "dmesg-5" from the original email is with no iommu parameters.
Attaching here "dmesg-6" with the iommu explicitly set off like you said.

No difference, still broken. Although, with iommu off, there are less stack traces.

Could it be sysfs-related?

Kind regards,
Nicholas
