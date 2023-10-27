Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5C7D9B88
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbjJ0Oet (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346088AbjJ0Oes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 10:34:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE01A1;
        Fri, 27 Oct 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698417285; x=1729953285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OK+yZSe7ByLhY1oigYrjGlaRy9WsCPG3i+gLOdxqZTc=;
  b=L5h8jjWhHd6MBa+gZvXKIEIXKMYg9+y8LR5cg4iQloF7Yfq+EXLx2wyM
   sNrdiN5DRkW3nP8c6AMvWsm5dNHI7H/dhgA7n39DdCKckgu24ltSWrcgl
   Ms0R7PHqI6ClvXPei1F90M1Tef4G2lkZv/LTorKTnzqWYAIYZAL3iDdBX
   WGgKe15uDirNg137CtjpPVmzCJtjz64A/MC+WNvDCoMZQIYV5KGOvmXJD
   bRNtaC20ig9yMh85iO8naCV+kpYOIsofS7JYk+2NfdyfKfTGIXOv89FaN
   MdLMPKfDtKd1k2xmw5LgDouQBFXSuMYbG3dAsAr/KpLoP5vH4WfJ5rphN
   Q==;
X-CSE-ConnectionGUID: kgUio9bFRm6pohljxQY1cA==
X-CSE-MsgGUID: cCw3Da7/RDqtHWXpzmo+GA==
X-IronPort-AV: E=Sophos;i="6.03,256,1694707200"; 
   d="scan'208";a="888193"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2023 22:34:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMfndOuv93ML0vrwH+qMxRx1ntXxbgOzOzXQpiMc/qVZDvky/svwjV/301vIq4cDq7Kh5ldLtJAaojrY32PD/qNaiZS7BuCHCKJfJPAdu+MhitskLGdytYHJuq0B8aSzz9X+HfQ+8H/L3ZiQKEBMKIQgYau+o8j+kKWy8SGeNLuYH2y0+Z1uCwkDjWZHy3e5oLHpRtDiMVW4fMwEXIn4gmibwjp4cmj45fQs3Mb5czzXO8QbJNUzQEzN7+fgiUFxXdJt2xxWViineXFCjrox6lh2bfmjERX4Ea5TEj4ElxqmAgVK78dvZYy5nmqfmPQpslZjbJMENqeUk6VaQKfsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSHwyYUcpwTCy191IDDMRt0fB5L4bR/uZo9cP03bH68=;
 b=erDqe1p3xpqU+wWncLyRfNz7zCmeW7oeKuz6UFWvfxxjJ9T9owXtf7rzGWpemOVHIBOivrhMdAChn6YTRUef7yl4nF+7HbKTcSAxnzDqr/PxLwfdEaRjJF8oa8tsrYA53qksIwLWEDbBPoT2C8At9/HPAnt8vxv0d7cLVuwYklKNy8Anige6JC2H7cTHWuMD7vZ3QcdlDUI/Vw209FPHE0sfLBQMsHqEOYo24oKWsSKCt6rbGWGCaJj/Kh4UOdnGE1DixqquIJqmZ2/IoWRsf/zH4JZrnYefZiaZbSUCq9hNXEn07RANZokGpMf3H7zB/iWY4mazlgabt345HV+BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSHwyYUcpwTCy191IDDMRt0fB5L4bR/uZo9cP03bH68=;
 b=kanFq12SnwmYBDWJCbzbknoT+IgBuPT940Gp/z2e1PlnEHls7B9A5rfMn4kabzxAC/+FhSNM95w5bD3H3RHkVCIRd2i9Jm0y8jspfePdtc7rVPi+xx4mO/q941INkHlE/Vjfn2OAMMsTsCj0Fl/psz8EG5aiuo8w4erhHYG4pWg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 14:34:35 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 14:34:34 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Thread-Topic: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Thread-Index: AQHaBoxoQTs0JHhg8kWC9n402P+JBrBZIWsAgAHN24CAAXnjgIABTyWA
Date:   Fri, 27 Oct 2023 14:34:34 +0000
Message-ID: <ZTvKeeYpfX57A+yd@x1-carbon>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-2-nks@flawful.org>
 <20231024-zoology-preteen-5627e1125ae0@spud> <ZTl0VwdFYt9kqxtp@x1-carbon>
 <20231026183501.GB4122054-robh@kernel.org>
In-Reply-To: <20231026183501.GB4122054-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB7623:EE_
x-ms-office365-filtering-correlation-id: b436fe33-f1fa-4ca9-15bf-08dbd6f9d733
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4fbGxfGOLIraxHyc/ZeU8JIZho/itJta6GMkg0HdpPHrhS9/ChUZIeODnl1Sx+/H4nUYs4m8J09SEIH2QgHX7N3mNV+KIs/XdtGqIZMbwrsqVIlVm7f0cLKQr1YdIjFF7MXi7J+bzbkYPfeand5KccaEHLrIz5OLqoA+D3UmK1BIeSMvylWIb4f9w1s89e1FKB1a6bAPvvRUgJrdOO9NI5yGxgi6c3HvhQGc3tXoaB530/srzaHNy0Z77wKBnaMLhNRoP3a2GsVjnS5AAISNj8byS4AVFdnHDvjsC+65NnTjnyIM9KvY2H9Ao4BLo/fiSqIsjZSVNUJFZErZv1RY/9oQw/8/4UWHAXJVTQ81kEIi4OEr4IA919RKr4kvnpvODPsuMLAcLLq9Or986Y/iEAUtYTrWgyACeQPUHJnNy/Vb0Snz5My5WEqpUfnWChXeXB9HG6gXYFsqMyNH64XflwgEzQbhoktuDbyqF3kTkiiz8OzScyZ8Yli5ABWiF9myapVoYIljD6iw1yjIQVz/VYGruUBo1Mq33bOE5JVYF9sP86er4Xe40AxuQJ34Y0QrJGLD6+lSdv1HgawAXHphKyGkFjJhJw1GBvTPiNWYHaYUkxIE7bqu9A5NXHHYozt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(82960400001)(9686003)(41300700001)(5660300002)(122000001)(6486002)(26005)(8676002)(966005)(8936002)(4326008)(478600001)(66556008)(66476007)(54906003)(64756008)(66446008)(316002)(6916009)(76116006)(66946007)(91956017)(38070700009)(33716001)(6506007)(71200400001)(86362001)(38100700002)(2906002)(83380400001)(7416002)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?J1YayHbbOmecAiEhZgxkqNxxxIZUVXyLHJedQ2Uooik0mSs+CEl/Ah32VB?=
 =?iso-8859-2?Q?CXcRZ2nh4/G6C4oGwDIjgT9mMc59VlZC2q1AfmQLqCfkcMVS5ZhnhtQeQF?=
 =?iso-8859-2?Q?aQulWjeEPd4XIrkUvGPcQ5wj6VPNVlGYpiqZZORDNEKjozm+lpQZ7yX2eV?=
 =?iso-8859-2?Q?EtGK4HQk/L2NE1aOXz/KhFK0VoXHBrCVSZvyc483o0ptrw0hnszWnZKgDp?=
 =?iso-8859-2?Q?fY37yj78NmmWWWh7HnQVUuzQb0OSlQgASFxS7faTmFBkPINIn6sIOyeKY7?=
 =?iso-8859-2?Q?h6rDcYX6mPk/NWso9SHLp4as3MOiF523vZajegHNBmo4INN97017Mt7FIX?=
 =?iso-8859-2?Q?7sxxhE8TNPJOXXyVkG/vgSRCaI5XKYbxSnUedccWfWYTfpESAp/1lMrkME?=
 =?iso-8859-2?Q?AoYWJpO05TzD5WNoP1e6rzqMnF1kRtfeUjc5SJFBfA3RVDBOvAAcVI/PGh?=
 =?iso-8859-2?Q?CKRYmOvBB+bO20x8zm7gYDR1O/H+OqyL3qLZlJ5gjRF2efaVlCmHQRDk+F?=
 =?iso-8859-2?Q?zhiUig+OAhBkRqGIBnDJb6mKGBg+Z8dZsOrxN6KdaO9DRrRoQs0nY9NVzb?=
 =?iso-8859-2?Q?jsJNk9+mHtAEc1ln8QWYp9Lj8AO2c6ucSOahFfNbMBlczZWG1jfIvHc2eZ?=
 =?iso-8859-2?Q?lgK3xTgHBfyUPccSrRBTWFWAuort2vPI4Xq0cit9pmjiZrDuYGEolMvHu9?=
 =?iso-8859-2?Q?XudpI340PXPVoxxWroBSinTGPDFllkQ5rakAp8XikDIVZxjgNeg5ZpWis9?=
 =?iso-8859-2?Q?u5/3qtyKD9lqQWX9PHpvS5pL1OqAIiJDfYvDlAgijoMv61eZ+iEex9m6yf?=
 =?iso-8859-2?Q?9L3vGg/OZ4jYD78DiYDGsBE+iFPTxbWvnU8KJGlIWIWTEtUODQclKI6QYj?=
 =?iso-8859-2?Q?VvpZQuUt5v7igjRWjxGDjfoE9ZblxI9EZCWgRrltUa3yK0pQuCf8xX0zVd?=
 =?iso-8859-2?Q?heJ8gidKsjfWh1WQrU9j+2uptJD1zpke1CgZDy/IH6sEaZWOyDYysQa2lh?=
 =?iso-8859-2?Q?M7Ftuj3SL+d0BrgyTDqlivNUK6QDSkPJhV3WI2cWWSwv0W3l1RA6GwD6/5?=
 =?iso-8859-2?Q?myPxZ6RX325k7jWfmHJ/ntwqV0alF1zXOGDLRVQIjvi9x6hpx9Rkan2YA3?=
 =?iso-8859-2?Q?BMEkutSWZEfrbq5+r6rOyQ4aIttW5w/GzRo7COv6Qs380Xp0GgwqIBNRJb?=
 =?iso-8859-2?Q?JKv0n3N9BfXzsGgMC/ZYoAz5S+gc0RhqU8TjelL/iR3SdQufc+rC7nwCxK?=
 =?iso-8859-2?Q?KOfhYiINFbXFJZnws7BKaOCdwcSElg/SmM0qG1b/aCBRhwF7itSYjFMOJo?=
 =?iso-8859-2?Q?+dC+2C3nYSpU5Nn55anlgbx8ZAU9+a5t77lYuh1INfhSDMGU2G1QOmdBX3?=
 =?iso-8859-2?Q?byJ+Nhny9RPYT1iYxJTeyzG48KgljMRqGVIHDiTZiQdn1AnOmY5WO2OTKn?=
 =?iso-8859-2?Q?NR/bBmFnrwuUJg3/CcfzfJtOibn04Ffc2NTyrLL2TqnTLgpFTB2FVtvZ66?=
 =?iso-8859-2?Q?H91HVrMWlcX/WA+uQ/gDyNc4FWlxMHuVOP+SmzaqQILOS2vvc3X14QG8/z?=
 =?iso-8859-2?Q?h/NKocprcFb6HU0AurSaqgjtAHsVNjSPYIUiPlGXURagdiqSRl91JhY3re?=
 =?iso-8859-2?Q?YXwqaqnTY87ngFDOXsP2SVH9SdQ8FE/5jljxMXx+WOykhyhru40YxTbQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <03E4F507EAEDA148B8312B2DECEA9A85@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?IHQSV/ugIqUtmhIqBj2pEADzc7+erkYt3OptxhBClKlLbuUYK4adM/Zi4y?=
 =?iso-8859-2?Q?uPZ/i3NDZwIeN3poR8yQ92Ob1/Di6nYADjT3F1rfaaHOHeGpvcv6FEyaeg?=
 =?iso-8859-2?Q?ujDE12PwiBqP4qI5qlJ5vX0334M+9QF6UqYAqR0Fb2gCKH3FC+orcQToR4?=
 =?iso-8859-2?Q?Yp/g9FqUZGFjWZmjsgptXsq+aiW0iORy50ymmbqVdGFkDA2EhB5WtzXSWq?=
 =?iso-8859-2?Q?dwzbchMcw4jSN1ELGrYl5/6inbJEr389PTZtpBlEr1LZymxoIily8Azpfe?=
 =?iso-8859-2?Q?lu9Ojt32wt7zbaCNcbZDlXH1HO0t0KfwzbumQyfC5QS0nittZYPQc+FytZ?=
 =?iso-8859-2?Q?wDrYNrgbV+vZL69onQ76F0oIVQJU7x15cDB2ltk6QX8WLmxSo8RBmw8Ldy?=
 =?iso-8859-2?Q?+wVHpUm+79Rv8iSfJFLmx0fJFZM67ZyGI3NrANpWzEbPQNy6bwrrUenmzW?=
 =?iso-8859-2?Q?UzqrAPBXstt8XrYI+GHjB0AkEx/cF696VYGgan8xrVHfOkibBlx6Pn45Ai?=
 =?iso-8859-2?Q?DxB9c5KEABfsHy4rCjKHTYnDGFpxxk/PW79BpU5Bik4lxEGBNDAqKkpFJA?=
 =?iso-8859-2?Q?Wwr3f20DIdeDb+MAjgefRzW5/dPGMbPlRO6TTNFFX6cSW1H3xC8m8U/LLF?=
 =?iso-8859-2?Q?IksiO9+9eW9zj5KiTBw93aYeWvJyCJaDWFL8KuVakjEwLY/WrxfeCOStfK?=
 =?iso-8859-2?Q?DmedMRX8qvA1faEvnY/axKOw6tGQCjFU/QuE06Vt7Q2JmE3c7JlKsJiBMS?=
 =?iso-8859-2?Q?j+PaMopB2IDaQE8zuQ3+VlBR7DUYm9yw+0WdLjsakfVWuQQFtg6/rcDzLP?=
 =?iso-8859-2?Q?TdE0BirYdqd92tjADlFuRKG+Qod8afpGSwj5xS7NUjVOBF/WpoqBDqmg8v?=
 =?iso-8859-2?Q?+63XM8CpBb3E9mC+C0vSVJ5/eXJ/8vILvWp+3UdnofRuaMVvnibSXMEVqc?=
 =?iso-8859-2?Q?JDzr1sJE+30TCDxPWAd9IDRxJjyJYqRyFOADElNQ9k8XC0oZcnJXRQwqY9?=
 =?iso-8859-2?Q?blnZHEcfpH2T0IlkAUD6ki5GjepjBkdwy09Uy7UeSm/Yx9ry6FKPlL3/of?=
 =?iso-8859-2?Q?vWwel4kwwEK8WCU+d3Gh5IgQDR1BqKZzzQJFXseogzV4BTpXyrXswuiIGw?=
 =?iso-8859-2?Q?qPZdOZMA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b436fe33-f1fa-4ca9-15bf-08dbd6f9d733
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 14:34:34.8521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IWKmZDTOyZSoB9y+6wZG97VmBgjxSWCfPl3um5YI90xxygxy6yPy38/MawZjjJ+ql2x/yOrdF4mKiQFEW2LDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rob,

On Thu, Oct 26, 2023 at 01:35:01PM -0500, Rob Herring wrote:
> On Wed, Oct 25, 2023 at 08:02:32PM +0000, Niklas Cassel wrote:
> > Hello Conor,
> >=20
> > On Tue, Oct 24, 2023 at 05:29:28PM +0100, Conor Dooley wrote:
> > > On Tue, Oct 24, 2023 at 05:10:08PM +0200, Niklas Cassel wrote:
> > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > >=20
> > > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > > using:
> > > >=20
> > > > allOf:
> > > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > >=20
> > > > and snps,dw-pcie.yaml does have the atu property defined, in order =
to be
> > > > able to use this property, while still making sure 'make CHECK_DTBS=
=3Dy'
> > > > pass, we need to add this property to rockchip-dw-pcie.yaml.
> > > >=20
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 ++=
++
> > > >  1 file changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie=
.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > index 1ae8dcfa072c..229f8608c535 100644
> > > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > @@ -29,16 +29,20 @@ properties:
> > > >            - const: rockchip,rk3568-pcie
> > > > =20
> > > >    reg:
> > > > +    minItems: 3
> > > >      items:
> > > >        - description: Data Bus Interface (DBI) registers
> > > >        - description: Rockchip designed configuration registers
> > > >        - description: Config registers
> > > > +      - description: iATU registers
> > >=20
> > > Is this extra register only for the ..88 or for the ..68 and for the
> > > ..88 models?
> >=20
> > Looking at the rk3568 Technical Reference Manual (TRM):
> > https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20=
Part2%20V1.1-20210301.pdf
> >=20
> > The iATU register register range exists for all 3 PCIe controllers
> > found on the rk3568.
> >=20
> > This register range is currently not defined in the rk3568.dtsi, so the=
 driver
> > will currently use the default register offset (which is correct), but =
with
> > the driver fallback register size that is only big enough to cover 8 in=
bound
> > and 8 outbound iATUs (internal Address Translation Units).
>=20
> We should probably make the driver smarter instead or in addition. We=20
> have the DBI size, Just make atu_size =3D dbi_size - DEFAULT_DBI_ATU_OFFS=
ET.

I though about that, but it seems that some drivers don't use
res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi")

but instead set pci->dbi_base from non-common code, e.g.:
drivers/pci/controller/dwc/pci-dra7xx.c:        pci->dbi_base =3D devm_plat=
form_ioremap_resource_byname(pdev, "ep_dbics");
drivers/pci/controller/dwc/pci-dra7xx.c:        pci->dbi_base =3D devm_plat=
form_ioremap_resource_byname(pdev, "rc_dbics");
drivers/pci/controller/dwc/pci-imx6.c:  pci->dbi_base =3D devm_platform_get=
_and_ioremap_resource(pdev, 0, &dbi_base);
drivers/pci/controller/dwc/pci-keystone.c:      pci->dbi_base =3D base;
drivers/pci/controller/dwc/pci-layerscape-ep.c: dbi_base =3D platform_get_r=
esource_byname(pdev, IORESOURCE_MEM, "regs");
drivers/pci/controller/dwc/pci-layerscape-ep.c: pci->dbi_base =3D devm_pci_=
remap_cfg_resource(dev, dbi_base);
drivers/pci/controller/dwc/pci-layerscape.c:    dbi_base =3D platform_get_r=
esource_byname(pdev, IORESOURCE_MEM, "regs");
drivers/pci/controller/dwc/pci-layerscape.c:    pci->dbi_base =3D devm_pci_=
remap_cfg_resource(dev, dbi_base);
drivers/pci/controller/dwc/pci-meson.c: pci->dbi_base =3D devm_platform_ior=
emap_resource_byname(pdev, "elbi");
drivers/pci/controller/dwc/pcie-al.c:   void __iomem *dbi_base =3D pcie->db=
i_base;
drivers/pci/controller/dwc/pcie-al.c:   al_pcie->dbi_base =3D devm_pci_rema=
p_cfg_resource(dev, res);
drivers/pci/controller/dwc/pcie-armada8k.c:     pci->dbi_base =3D devm_pci_=
remap_cfg_resource(dev, base);
drivers/pci/controller/dwc/pcie-designware.c:           pci->dbi_base =3D d=
evm_pci_remap_cfg_resource(pci->dev, res);
drivers/pci/controller/dwc/pcie-histb.c:        pci->dbi_base =3D devm_plat=
form_ioremap_resource_byname(pdev, "rc-dbi");
drivers/pci/controller/dwc/pcie-qcom-ep.c:      pci->dbi_base =3D devm_pci_=
remap_cfg_resource(dev, res);
drivers/pci/controller/dwc/pcie-tegra194-acpi.c:        pcie_ecam->dbi_base=
 =3D cfg->win + SZ_512K;

So I don't think that we can always get the size of the dbi.
And a solution that does not work for all platforms is not
that appealing.


Kind regards,
Niklas=
