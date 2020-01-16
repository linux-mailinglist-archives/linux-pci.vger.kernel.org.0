Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046CF13D5FF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgAPIfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 03:35:31 -0500
Received: from mail-eopbgr1380081.outbound.protection.outlook.com ([40.107.138.81]:22730
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbgAPIfa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 03:35:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzdSa+bqadCu4a0+0oZtkKN4jGcOr2TwH10cC13Lmh6CxtNt4/ixVtigMLuY/tYzB4xZT3CKkHQodmzorS6G7n54bCj3vrp+Bq8cVDmf/QioPB9K0ksIfJk2q7mk/sa0DTXRaKsRJ9ncT5lIo5mMjUDnA67PN2gRUnNctBiBg8YSO1w2eUoElS3Iuixy6ZuTnTgNbMC3/C0VCgkCWnbVm/YCW8QkJIfZ+h9oHTijM+5K0SqDXmfdlcH2Dh4SBRN/sRECM76/syP7JGkSv0GgTONeem7t2s5nAK1T8px2PPdkv7zrhXbt93aTYvt7hBfRIz3ENhUzwWBVElWAv+bfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9osa+F1hAb/5YcVlz1d2yOQad3DMgzcvWZRES+27VP8=;
 b=WOXpLN/GS8wIhmraDLI2ABgTu5rj08/qwQEnHMB1DR1vfpiGaLYW7ghry5jnwkHve4idK8XqgHMJKKej11Hefh38BrMatP04fXusOE09bcpyOI+ghiBaWZFWnDGBolRgAaPEJRsMwo2SS+yZqF0T6MJmngdepX/HqbhAnRT6qBye3WC3SSiTg5n03gdG2rLTDGQGTwMN8UH2utdZ0qaWnfzFLpAcXm5BkuTtP9RxNcztcEgmaeqfaYkzYULvFICFRe5YIVAuJvt1Y2wqc74t6LVGZEttWUPjdJjH/Nd2DcOs899StessXp0n/R3A12M+7iDMW32OjuNVgLSC3okSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=universaledigitaldata.com; dmarc=pass action=none
 header.from=universaledigitaldata.com; dkim=pass
 header.d=universaledigitaldata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5553547.onmicrosoft.com;
 s=selector1-NETORGFT5553547-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9osa+F1hAb/5YcVlz1d2yOQad3DMgzcvWZRES+27VP8=;
 b=ZVUyztFOuoWeGhlo6FgGzPfnaiSYU1FxLeYIqoqC/YmlKDEFnjFdx2O++o8zEFzWGYSKTdN/49ogXj/QE16avkOh8LfJFX+uS7lyAfg6f/vlM5wMvhzMjzC75sl0hdx1yVSPJn5dYD1I7ZBE0aXS/9TJJP4+qPP9ztkG9HnfpmY=
Received: from BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM (20.179.243.22) by
 BMXPR01MB3494.INDPRD01.PROD.OUTLOOK.COM (20.179.242.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Thu, 16 Jan 2020 08:35:25 +0000
Received: from BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a10c:740:420:ec6e]) by BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a10c:740:420:ec6e%6]) with mapi id 15.20.2623.017; Thu, 16 Jan 2020
 08:35:25 +0000
Received: from DESKTOPMPN5UI4 (106.51.17.50) by MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 08:35:25 +0000
From:   Sarah Wilson <sarah.wilson@universaledigitaldata.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Marketing Embedded World  2020
Thread-Topic: Marketing Embedded World  2020
Thread-Index: AdXMR+VNQJzz05ONTH2m36Oax1CBBw==
Importance: high
X-Priority: 1
Date:   Thu, 16 Jan 2020 08:35:25 +0000
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAPTePss7+FFKu8Ddkhz/AhXCgAAAEAAAAPxnp48fQQxAraA3QaPCQf8BAAAAAA==@universaledigitaldata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::19) To BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:61::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sarah.wilson@universaledigitaldata.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Microsoft Outlook 15.0
x-originating-ip: [106.51.17.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77c183e9-cbf5-4b68-1220-08d79a5f08e8
x-ms-traffictypediagnostic: BMXPR01MB3494:
x-microsoft-antispam-prvs: <BMXPR01MB3494AB6F46344ADA1B9FE0AD90360@BMXPR01MB3494.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(366004)(39840400004)(189003)(199004)(956004)(186003)(81166006)(8676002)(1006002)(16526019)(81156014)(2906002)(71200400001)(86362001)(6496006)(66946007)(6916009)(36756003)(52116002)(5660300002)(6486002)(64756008)(7116003)(4744005)(66476007)(8936002)(44832011)(316002)(508600001)(66556008)(26005)(55236004)(66446008)(2616005)(32040200004)(130950200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BMXPR01MB3494;H:BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: universaledigitaldata.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/uuPklm4k3w4Eh/gajJ6LQWh++9a7n1K+3xKC8BaMBj4OGcs3yZ3NGvg+8beT6KxR7yffLxrimgcBpVMC/4m25VBoU/ZdzAuPd94zHrf00k4MMtIVOlqYaxghYnIfQFBAMATG1cm7/Ehfwc1avQkS5j2JwjfAGoxG6hFMu57rdXcZrRlkapXAzebob1xtPnS3mQsh4+s8nsiu+zgb5Gq1w7duTI4rRVANLj9BjZXHTxnCjiQ5kKk5TqCMb16cNlBLw3/UNz3V5HfeDNo6b1XolE7eV7yyJCmGKxBGRllekhVs9mn3ZTSNVmImBW0SYfgVKeZPO0HFiFgnOgqeQ40ykaSEolRK6diZHBLhLaLQUaFXYpLErmOoeQkN7MFRPtgmJ5imQOuI//SS5Y/uLepfTQlFSFmkPzTt8M+hBHvLd9dbqr0NOGLLJUP9wPJEegzHFqkB7IjxN+DOVWXHh9BciWy5oDXXIxmSf7wGcoALl/zBuFaK9xuSsU0lxy2vMBnF7i9ZJqm//2SNaJqM6jNwlNhqHUwg3dAm80j7+ImwI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54C963F64C29934B93753F6A491C6EC1@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: universaledigitaldata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c183e9-cbf5-4b68-1220-08d79a5f08e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 08:35:25.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 136679fb-fa93-4ffb-ae24-fda892c47083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRVG3DNXsDI9s/zACI2ictBebcpL4YDuPiTg9dKglW0nj6wfvUGB4+XNMag1AN3gvuJniCDdxku4BFRDr+BLO7bPK+/MXBnYdhLPeEGLyNCZn87iYUEZ62YN+96tfhOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB3494
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
 =09
Happy morning.

I just wanted to check if you are interests in Attendee Company list of
Embedded World 2020 (International Trade Show for Electronic Systems,
Embedded Technology, Embedded Systems, E-mobility and Distributed
Intelligence) to reach wide range client/industry leaders to promote you
product/services at global market.

Venue: Nuremberg, Germany
Information Provided: - Company name, URL, Contact name, Job title, Busines=
s
contact, fax number, physical address, Industry, Company size, Email addres=
s
etc..!

Please confirm and feel free to reach me out for any queries. Have a great
day.

Awaiting for your reply

Best Regards,
Sarah Wilson.
Tradeshow Specialist

If you do not wish to hear from us again, please respond back with "Leave
Out" and we will honour your request.

