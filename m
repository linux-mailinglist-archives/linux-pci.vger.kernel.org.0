Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0EB2643
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfIMTuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 15:50:54 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:46819
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729614AbfIMTuy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 15:50:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKC473r+BRCzDQ6WeIoWlufTQ8/ss0JYo+tO809ME0+6D+eNVlL1Jb83VQ8sfYjYsG4eJQhnpSo5Vean9ft0DxhRhxFgEiikJ3qm0ZKdXbsnErvqksngg0N2UqXFg7CQRMn9FfBNZC4XIdJmnzAj6qZxnvtVOyRjloaNoMe35RYJZ56mPRTQTQczaq9KSoImJJobq5hpSjpSIF+a/rLIM5FGPxi+6KKSaXhCYnzJdxywV/DdZi2d/TYm1nDNIszB8XtNhA5YuhEcleW+Vy0iVKb/xwNpC28ZDY7aYuMJTKNALP8bsA+hNJ+I+ZgLZ5HFKAM5QRD+3rO3jn1BQ+UsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO7dE0cbaEZsJ5xiah12EiX8QFktExTGmjSV5awP7Ng=;
 b=VT4IC4+Jwuu0tbZWrcSpKgdzNQ31np8a4TdKT2by/fim1VU6TpgMlTB5zwRT0UgKw96o3DHJHdx78UP5H3WMbirbmHY0IkLEserC/lt+VmY8S9xUX+Revt9gj7k02TZu2GHBkJ0cPorzFWCxrIjumOfL2fxZx3NCZUkJGW8qYCzXhoecEeJ3bbDPm79X+rHgTof97Sw/vWggGsFXokICBT7/vINheDhggugUOk6WvSBG+zFnVKTEdE2G874SKnJvhtBeTlOwL09EDrwbXuWGnfEzFxTr98aG39sLCqwD66QivO5GURSEnnV/nOV5XX84Mz8nUx8YnUlFxvXiW70Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO7dE0cbaEZsJ5xiah12EiX8QFktExTGmjSV5awP7Ng=;
 b=b84tKznbxKnsTcO7sLul8D4i9HHQKW/+Fs/IXM+/oS2Cgosuxtmg9seJQtwIlN95je12ovaspN11v9QdeOZwb1xsw+oW98PletTUhMj8MCoTSU+c68hv7+XJO2ATgUpfjbDA01zu+vKqrmn1v+FMQZYYC7e9A9qj9dX2PVDLmwQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6574.eurprd05.prod.outlook.com (20.179.25.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 19:50:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 19:50:50 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Megha Dey <megha.dey@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>
Subject: Re: [RFC V1 0/7] Add support for a new IMS interrupt mechanism
Thread-Topic: [RFC V1 0/7] Add support for a new IMS interrupt mechanism
Thread-Index: AQHVadCis80jNXQJ7ESbv2tE+P8b86cpe96A
Date:   Fri, 13 Sep 2019 19:50:50 +0000
Message-ID: <VI1PR05MB4141EAE19EE47DA20A75AE21CFB30@VI1PR05MB4141.eurprd05.prod.outlook.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
In-Reply-To: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c13d9d-3244-4ac1-9fd2-08d73883ad75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6574;
x-ms-traffictypediagnostic: VI1PR05MB6574:
x-microsoft-antispam-prvs: <VI1PR05MB6574A412D433E70E5B18C9C1CFB30@VI1PR05MB6574.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(39830400003)(366004)(346002)(199004)(189003)(33656002)(256004)(52116002)(66066001)(66556008)(66476007)(66446008)(66946007)(64756008)(7696005)(76176011)(5660300002)(74316002)(52536014)(8936002)(6506007)(386003)(54906003)(446003)(11346002)(6116002)(486006)(3846002)(476003)(9686003)(55016002)(81156014)(478600001)(25786009)(81166006)(99286004)(2906002)(53936002)(86362001)(8676002)(6916009)(14444005)(4326008)(6246003)(26005)(316002)(71200400001)(7416002)(229853002)(305945005)(102836004)(7736002)(71190400001)(186003)(14454004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6574;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: li6kZpccTJ8Pxw4lnNhbNj3fEj2+exwWrmfAgsFsKQY7W/w+lwq2GNvaJoRQtIgzyA902SGi3JrSSpetdVcm9J7qrmolOJ1ILNqrwaLjRTE5+gmulB1W4lLTyNLvAfyg0eOJ3PbEfJ4sLExS12FFwwTwOiC1anVpKykfW3Czpz8++lnItikIpL2jZVFAv4tbOJtIqU584dx35Xi2XT4Q0GNKE+cZ+qrrKjxQUhQ1ku56X4MZBxZPMHk4BC3BZZu54ZpvsdQHvYfC8zM4ITDroc3jy9hq1XLt/2tlCX4cpvrGwxXwVUiEkdgtiY/lB+/k3ubiT5HEUNpHJWzRVUBG00p7HVngVqzw7Dr7T0867nn9WZocPCFryMIRgDkmxsv9aVlSwM6ahg6dOQJEQWHlAq8IQFTxDFsap/gZIUTccg4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EFF5AE607A0DD409FA0740C7E8393F3@Mellanox365.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c13d9d-3244-4ac1-9fd2-08d73883ad75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 19:50:50.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eZnf7MHKvpvtNkRL2TW5Y3btaGLtlJvhBfAiRHiHeP8DNc6JVwLgxckMBewyvWLhdqm4ScXpYycE3DDGfbDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6574
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:01PM -0700, Megha Dey wrote:

> This series is a basic patchset to get the ball rolling and receive some
> inital comments. As per my discussion with Marc Zyngier and Thomas Gleixn=
er
> at the Linux Plumbers, I need to do the following:
> 1. Since a device can support MSI-X and IMS simultaneously, ensure proper
>    locking mechanism for the 'msi_list' in the device structure.
> 2. Introduce dynamic allocation of IMS vectors perhaps by using a group I=
D
> 3. IMS support of a device needs to be discoverable. A bit in the vendor
>    specific capability in the PCI config is to be added rather than getti=
ng
>    this information from each device driver.

Why #3? The point of this scheme is to delegate programming the
addr/data pairs to the driver so it can be done in some
device-specific way. There is no PCI standard behind this, and no
change in PCI semantics.=20

I think it would be a tall ask to get a config space bit from PCI-SIG
for something that has little to do with PCI.

After seeing that we already have a platform device based version of
this same idea (drivers/base/platform-msi.c), I think the task here is
really just to extend and expand that approach to work generically for
platform and PCI devices. Along the way tidying the arch interface so
x86 and ARM's stuff to support that uses the same generic interfaces.

ie it is re-organizing code and ideas already in Linux, not defining
some new standard.

I also think refering to this existing idea by some new IMS name is
only confusing people what the goal is... Which is perhaps why #3 was
suggested??

Stated more clearly, I think all uses would be satisfied if
platform_msi_domain_alloc_irqs() could be called for struct
pci_device, could be called multiple times for the same struct
pci_device, and co-existed with MSI and MSI-X on the same pci_device.

Jason
