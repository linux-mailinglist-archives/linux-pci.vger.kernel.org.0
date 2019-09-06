Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91223AC2FF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2019 01:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405194AbfIFX1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 19:27:19 -0400
Received: from mail-eopbgr740078.outbound.protection.outlook.com ([40.107.74.78]:19136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732440AbfIFX1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 19:27:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyYcjH4d/vLqn5St7JgxWJ0QVR7klNSPJ9dBQP46LkBiwsaQzn6si1srLhJYyWJ0wtqAaxWwRAAxKkVvwrwCFqIZxZhphCBm3/T6nA4CEGs5fXzz8Adj32crlYQuPMGKbon8kZDmgyGKROSAqf8VwZknKWrcJYmyZdMYmCagS1VsvQCwoBC6V0GCyIGaM1Mts+YXpj8pNxvC2QWYMs8NZAk19XP9BUfN1Ima8Hoc+VqQcsrywdPGVUGXeHna4nHCmMq5bKE0oqtTHUH0XXv+pGZ9iKOwZmo1UPrOL7+Zn3rlrlmP8sDU56ad0R6WF4Jk4nPniq1k2THPQidEYPmPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8KrBt28LgTfVXFfuKWX2kYU9q6qpQvUA0j1E0zYtCo=;
 b=Qv/4xY4T+1AepJ8bUpQfipQZHVzjDPPp6wvqoqTHG5/Jvt/9Pi3uJGBT58gI8WFhbFJFLmgzb9Sq24nhZiy9qsMMhmFPEOn7hmTtVw8OBBOGXOcfbRVovJxL0CUEYGOChJuKptPX3M/FeixAnP7la5/IpCT3LconwLsp4/hU+vMi7319y9sNRyFWdL0gyUjZfNGtocv4e6S0v9p4E3/aWar9M4nz51vBeMFcUP9KvztFc03SBr/wXppPZ6NS6Z7RKdtlmmGAm6bo/qbKU67obL+rICfC66pzi0ZHcppMi6u0NGGXJaKZFybGP6B+nqRuLI/uNdq17c2kqN2RqsoPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8KrBt28LgTfVXFfuKWX2kYU9q6qpQvUA0j1E0zYtCo=;
 b=Juxdn6YyleQYKtcRJ7174tsSFa6JZQ6gC9icNE3cGb1P/NrC60tQWdsVjmLPYWGJIMW6ntJ9iS4D6jy8O2962W2ccnr4cMm0UfgRzEmthVLd5gtvYvS9k8YNBe8WgVd+RvfxiV2dfMibexF9FDHxpGKaVEQM4KqYjypwDbkGJas=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB5299.namprd07.prod.outlook.com (20.176.178.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Fri, 6 Sep 2019 23:27:16 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 23:27:16 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Topic: [PATCH] Add PCI device IDs for family 17h, model 70h
Thread-Index: AQHVZFZcluMS+DwUu0Crbwpgo6jw56ceXdYAgABADgCAAAIBAP//zKoAgABPnwCAAJBZgA==
Date:   Fri, 6 Sep 2019 23:27:16 +0000
Message-ID: <20190906192709.77c70f893dae5c519164a7f3@knights.ucf.edu>
References: <20190904215308.GA12374@zn.tnic>
        <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190905070917.GA19246@zn.tnic>
        <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
        <20190905135408.GE19246@zn.tnic>
        <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
        <20190906091250.GB19008@zn.tnic>        <20190906130206.GB7255@roeck-us.net>
        <6B3FCC26-7A2F-438F-B442-EA665DDD0569@alien8.de>
        <B08C8E54-43FA-4E29-8D7D-5F9C4AF20CCF@Knights.ucf.edu>
        <20190906145030.GD19008@zn.tnic>
In-Reply-To: <20190906145030.GD19008@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:408:20::39) To BN7PR07MB5186.namprd07.prod.outlook.com
 (2603:10b6:408:2a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
x-originating-ip: [132.170.61.99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb5dc603-a7cc-42bd-7ea0-08d73321c0ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN7PR07MB5299;
x-ms-traffictypediagnostic: BN7PR07MB5299:|BN7PR07MB5299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR07MB5299B105D8B5D1AC1CA9656ACEBA0@BN7PR07MB5299.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(229853002)(476003)(25786009)(446003)(11346002)(26005)(50226002)(2616005)(256004)(4744005)(6246003)(75432002)(66066001)(66946007)(52116002)(186003)(44832011)(14454004)(99286004)(66476007)(2906002)(76176011)(102836004)(5660300002)(66556008)(6506007)(386003)(486006)(66446008)(478600001)(64756008)(1076003)(6436002)(305945005)(6116002)(3846002)(86362001)(4326008)(6486002)(7736002)(71200400001)(71190400001)(53936002)(8676002)(316002)(786003)(81156014)(8936002)(81166006)(54906003)(6512007)(88552002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5299;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ae/DZOgSab+VGYTB9KqvMW1SO5nhyRx9hk3qTtZajlI8cGzxve9UDrYyl/AwR9G6R346qIQk3iNttCEAac9Dung1g/Sb0rFjXxFnzlh5xWxZnJLcqz372kH4rb1NPG9bujwAOXT8bOkf7EkUI8vnBYQfTU8cktJ92SP9iNWq+pIVL4S8pliyHYRHbvm6YRSZoislVrxzp3+4gNujREeGjue+s+lYk5frqEnQpfZPpz+PQIMREU3UxA9M6eZKZxZpSEsgTqm/H+ZUp1qGKetw4aeNizJEuGQuYlALPv8uHE6ZX1x2b73geWSVoPq7I65p63DUgbxRd1x9z43IiYfJAnVyNXCPNWpR/5gRkqt5ki+3Pj/l5xgmgnly6B2YaS8c/g4acrIX+Q1U1Jic4Y44hABlzseAJW9EgN6T656U7NY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <611DF315E0E3C742B6825BC5A5D0ED21@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5dc603-a7cc-42bd-7ea0-08d73321c0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 23:27:16.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4nALROk05jZQJcrBxitf2qKNWhALsuPQ+AtCP3/sS8eJ9PigBr9X+x+bcoPwcNmJ3Je2YSk7plkh1XJNenv1yzSbJbc7+ODp5+hQ3wuMCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5299
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > They seem to have already covered the changes to hwmon and amd_nb, so
> > the difference is probably the changes to amd64_edac.
>=20
> Yeah, then you can send me only those changes against edac-for-next.
> The driver won't load on Zen2 before the amd_nb.c changes have landed
> upstream but that's fine - it's not like it did load before.
>=20
> Thx.

I made the changes against the git repo you linked and sent the patch.
The updated module didn't do anything when tested, but that seems to be
the expected behavior with the current amd_nb.

Thanks,
Isaac Vaughn
