Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5D1E2480
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEZOv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 10:51:28 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33960 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEZOv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 10:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590504687; x=1622040687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=LN24KNHsvYOMfCsftHkAoOOJJP3iw2T0kFdIzeHSvHyFgqGg0cNL/K50
   aSuMk80tQmlwrQBNHGsrl1t89h/Js+kXTR/OvMMKr0sxxWXJlqRfLG4G8
   fzOx7v8nwKsOB74dzb39qlhgeyZ0R74C0V/L3vdbFLteERCjTV6r9dD68
   pruBv9EsVzIyLrRmXQwOfH7BVhWclekdOrdsgydh9/YOIZrg4GaZqGSyL
   ApPxMnE/F3WExx8p79pA8XL4+DIU6PmzHYrAaOQphVM1Uzx6gQwwA/vpN
   xK4QkeZZ+AdleN/IFop5PJ0y1KW9o9aSPTlk3vs5NV2BEKI9BbVwX6aNZ
   Q==;
IronPort-SDR: 6IDnaSV0ml+P/I0lGCrom7rEj8uSVxLaJtPQEy+vwRu3LzDc3xL6gh63nA95YTQHcsl4UhfJX9
 BP848pS0YVYyQVxja3h5ZYpl9pmEr8tmDmm5pn3Vf2d3yheLdWESCcxbF1P2+vzETNL0Pvy1ZD
 s1E0WHbBeRRQezG3owas6ECtQir1aAC4Y2oM719NoQzkrvJWzdLljfm63FI7IgzRwxdE8EHlNh
 U1ciEzRyy7PXLtFjSxLy25XAfOWVDXpNeHifiFwUs1BJQQBZoJMzcozcOHnrW18wucHNJcmpaF
 wTQ=
X-IronPort-AV: E=Sophos;i="5.73,437,1583218800"; 
   d="scan'208";a="81031284"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2020 07:51:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 May 2020 07:51:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 26 May 2020 07:51:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R476+FoSYlKoLVcBfknR0TaXS5Iv5MpMQBKIMpx8QC91jTSofOSJ2ZYj+eu8vOn4Gt7yHKWgEzWxwtgURGqjEvkxpBZdkP6TSz8fEqyswak/N3rGjg3kuYHR+FtY2Zhecc6Wk7mmqLDQYyFJcI0sr7tmH2Qv26YneNHRw6w6OAsIJJ3Q3jKiprIry0R2Ga9i//reGtFvABH2sf+wiPrUF9Fc6RgH6pbnZ0lr8RXextvBHnyiQAfuiZluQg7AeMnVm1YLmMnrFjnw5qUTgd8HV3IJDePYCQjARrzH3BWibinxW/CYWAZTZGecVX/3Fn59NJ4AElWin9aXXo5hW6HscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=T136GOI/DJfQN1XbG/AucBmm2Wq64klmvGJGLKxhxOk9LVK1+KrJVvTDeXh4JERodOxklXO5uCte8Zog+iOe5xPNOGUv7pUoT6Ej+y4Pc0io/RWwQe5mvIszeS/CUyGtcx1mIPlRE2O4zXPABZ1eEx5McICa4gZIIdWfetbG65XYqCIxEgOnPGlibC4wQ16MxCoAC490R/lRItzPtjpNcUAtd2Dy2Ol/ZzEce9SdqvdkvCo+d5ehwCuAnREWzBeL/BaOne+tEKCh82AkDsivqkT86CoEzmDLb4zzShzUTBSTUyA3q+G8OadwOC7Rh1YmHqrWbTz8yCtc3CZovKqsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=qpvuELAPC69Gcadm1ZK6Vx0GoLPgMmqSN1InjNBV4S6PUUDPVetZnYVgJSpFENMmwamD+ssSttbh8m2igAgRUUi/EAaEf4diS3muM6pnmdXoK9Fv4mqymaNCzcP2e05cgdZVrvaYAJh3z4LOzByRK2e7O1nSlIcne6Ei117zz/0=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4191.namprd11.prod.outlook.com (2603:10b6:208:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 14:51:25 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 14:51:25 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: Re: Subject: [PATCH v10 1/2] PCI: microchip: Add host driver for
 Microchip PCIe controller
Thread-Topic: Subject: [PATCH v10 1/2] PCI: microchip: Add host driver for
 Microchip PCIe controller
Thread-Index: AQHWM20h/BTvw/mwEUii81oK5tl1ew==
Date:   Tue, 26 May 2020 14:51:25 +0000
Message-ID: <c0b1e55f7fae0998458d6df7e4f601f5e797750d.camel@microchip.com>
References: <930a4f34fd11be89bc66cfa35b249c9b685aa8c2.camel@microchip.com>
In-Reply-To: <930a4f34fd11be89bc66cfa35b249c9b685aa8c2.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3b66a6f-d66c-4fa0-2409-08d8018443c5
x-ms-traffictypediagnostic: MN2PR11MB4191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4191DD8929F17499DB9CE88396B00@MN2PR11MB4191.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsOb2g6gWQLWzmaSdRzgJeYBND2Fim4cBeSiQcpxeS3TCuEeG9ywE+yNikC1ysZtPof/CsGhtzrzua7edUys7GcGS11JS+j3XMscSjSJ7A4JdJP9IN5RoMzz3D4x5hdt0vmMw9WulNeKBk8sTMmGZL5lK7ryjaFThu6gY2AcZkXtdOeLoDeiM0CQ2SHnkKri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(39850400004)(366004)(396003)(4270600006)(8676002)(6512007)(4326008)(36756003)(8936002)(316002)(73894004)(110136005)(2906002)(621065003)(6486002)(478600001)(71200400001)(6506007)(26005)(186003)(2616005)(66476007)(66446008)(64756008)(91956017)(76116006)(66946007)(86362001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 95LOBE9hUaHz+zKRjbXDgyxaGmwlBBwmh+DDbBw22soDN86lTVt+i4ZfDxrsXAAnCrWb3x/DmLFsI7mYJm12W1ciWrjBSvWs/mpFFYaH15lF0jrN1bx/YnSsiWZyq0hNMFQgbosZDOl2dcqpj1hKPQepsMiZY1sLYEbjSe++AZ0Zmli6f3qZ5nYuepT2uYL2WkYWbfpntxsrA+sZnAzdSxQrgcjd2ALYxH0GzxA2lkGZ//b17i3bfumlaQ5TVlAwfLEg83CIZDmbpbh3i0nwHMxS+dn/KakO7f34afYMfVp7VF1slBZMzyouov/rybK7NTurO63hGoL5zRA/WQPQoL+8j6BSiqke1hktFIgbsTnAl8pzqFUcOOLA0g1qMOgga1oBzb9spRtd7w/TG0KTupixFOSwoOA/+LZjxArWJWBxpNHaSPjXc4q4463+a9ChedYnnqomn/deLzAk5C4gjOLRnZqrJZCFgR075sbvzbe70g4lpcdb4iuPjJHMuAB9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b66a6f-d66c-4fa0-2409-08d8018443c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 14:51:25.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GU3FyrrClYhKd/yeFuPghY03A90Na5gE1nNlEN1Y+cA4DTCnNVk1nc3tlyrEVGYspndw4//xdr2wmKaRo6DHoTZh7QSipq5d22BrhNTdTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4191
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


