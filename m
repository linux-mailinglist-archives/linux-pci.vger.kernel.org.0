Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBA462B1D7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 04:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiKPDek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 22:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKPDej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 22:34:39 -0500
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11301F03D;
        Tue, 15 Nov 2022 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1668569677; i=@lenovo.com;
        bh=fP7dunf51mzPvHysEHZSDzYmwnqTeb4an60DqzCDZsQ=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=Rvx1yHj1lgNgDPANBnikcPJJDU21Ki7vpl1luhZNu0SrAxXOGe9DDvbHtkgVAfoFU
         +BMpyFYFT7NXSm78nC+B1lPyOaERzbcjd5t+CP7IF1HZ9AeMUVwXcV6bfDIs5CmOE6
         USIgqRSXXB6YVnun5U4aCcO31SYC+n8Dj9rjYgU+wFRw4SI+iX2ZoBiAfG0wW7TVbx
         RUhW1QolSFjXF3L9gwIATZwLZE99PO2VZwUFS+Ug8J+8haiEjO3kWhT6aHCBs50m0u
         3oCuqAtVa/I4dKYS7P0QvgwLN49kheEa+sWadkMWeIuDe7ZY3iUchbMuftDcj7gzo6
         KIA+2wow5PTHg==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTZxzHee7a60E4crY6Hhlg0uwVbHlZyM4
  /GP6B45INGX/MLC5utnC21bbA3XVCJ0nHyhJACTMysdRSoL6sgWGqDnBgEbcwHArlRQcZMmbX
  CCaYDGULIKztoWP/PPn8nu/3931+9+Q5HJWuY3E4U8ozrFGll2NRIm2KMUnx/n6+IHVmVUq5K
  rTU/FA7Rn1rnUUpy/EVMTV2zY5Rtx0DGNU9fEJCWVetImqseSe13tMl2R1Ft148JaadHhPtcV
  dhtH/8NEI3W+pR2jGYTy96Ej+Q7BfrjOqi0oNi7dLMFXHx8I7SypPXRBZw/eVqEIUD8hwKPbc
  viYWiRQwtbcOIUFwCsGZ5EYQKKdmEwLp/VjChmAGw9vJPwZ5IHCOTYMONVUmIt5J7Ya1/Oswo
  aUfh9PFXQiwjD8HZrxYxwaOBp2qWN/zpcLa6Ew2xiHwVdrRXhpkgD8AvBu6E86XkEVjvWgj3R
  pIpcLy1PtwLyJfg37faEOGsWDjlbwozJEno6hlGBd4G5x6siQU/D6fmOjBhPwGONtUAgbPgvY
  GZDX8u9Dm6NnISofvErEjgHfCblscSgePh7792hi8CkqsYXHx0YSN0QQQ776cKnAodSz9u7Dt
  IuPJHmjDoTuj84S9M4GR4vvkRWgeSbZu+wbbJZttks4XvZQscPOMXOYHIDTI4hv2MYRW7lGpW
  p9HyBpVOr1SZFSqliVMcZTheka5UHeWUDMcpuTJDgb5QaWR4Dwi+uUJWk90FJs6vKvvBdhyRb
  yPwd7kCaYy6qLBMq+K0n7ImPcP1g3gcl0PCcDaobWEZDVN6SKcPvtznMsSj5VuJREtQJrhilY
  HTaQTpFtiDj3/f24viw93e4FrfuOZFcc/16j4Ur/IGV6nIWGRk4mKJmFA2GWrWmowvop//F6M
  gIU5GgIiICGl0McMadPz/9XkQiwO5jBhrCKZE64z8iwnmg8MhweH69rKh4XjVf1KcBSm4s++9
  wNO8Ax8T7Q9MWSVZtO/1wHL65/arP9sTpkzHck1qb8CneCuv80ZOjjWv351UcRPRfLQn2ZFZt
  9bGDUbe67swSf1JPmzx9qjrrHR341iJ9NzXo3m77vLq2YxPmirtmdULgcn72V9uP0w80xRfnK
  bzD08ejO/zy9Q2r6zm7jvOtzVlb65j2pEhpMLlrMLcqevdN2ulFJwzR7pz00wD2krz5LEVc3n
  Dlfyhq2hSdo4E2miUPuNPuzxx5JelN9yB14jfdoPch00jjxNjWjMbbQOIj0jJKPOdZWw5meyz
  3n1W88knT0pqu78b+bBc6ipfOz3fJZtIexrt65CLOK0qLQllOdW/be6i9pIEAAA=
X-Env-Sender: lixc17@lenovo.com
X-Msg-Ref: server-21.tower-636.messagelabs.com!1668569675!8366!1
X-Originating-IP: [104.47.110.42]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26383 invoked from network); 16 Nov 2022 03:34:36 -0000
Received: from mail-tyzapc01lp2042.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.42)
  by server-21.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Nov 2022 03:34:36 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1MV1L0irAm94EeqKSrc4eKM1uF6U+W8hJF+EHZVlWVaDLwtPaNn78E14hudQ4B3BJghIEK4A+otmOc7RpurTALg1B4xMnG+89AlKe8ogL1yQjZHAk7CpQ9WHbS0rQkhNqC50flWmBGA+M51jx35BO4nsULP2qWYxR0YCMMr8puZeAfzuKJTzqJs/jOL/1kpPqdzl+Bd3SYt5Kd8A//zArD2yI+WP9DItE9T+hQmFw/1F1OTHmq49kKXVU89d89/p9LG9wuokDoLnzzAm3AMxwwqHU6EhLNEfiWNm72yxLutlPhl++9W5Bx2hibHLiBtfKEA/sRtEKDYzZQmgZTTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP7dunf51mzPvHysEHZSDzYmwnqTeb4an60DqzCDZsQ=;
 b=PTMBGDDA0fma23lGkTwX89DYffDIycyWxtEHWyD+7AYL2z6FMpaqDKuFH0dRIGboIv1A4Ms57aS6Mj/HC/7RwyNPOLIhzHfj9sCBT6N4Fx6z/tmWscV+2EtbwQmPePdL/kvbS23hQtGHEtsZgUNSJOGJFSN2DDtTcurOvNyUDX2xlqABEY0A8yqJZh4z+WYsC3Oq6JtiKOehrNp8YsJV27HAvszw3EjZ2BDgAf09dOqjBTJnUQqpDa6/I+LW/cWNHlNuTFbt76aUv/VCk1JMrZoYAZm+z2WokBwQpDG6Xxc0++LqKXlab/JpUObV4cgFnL+hf+NJCIyrNydjOs+BAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by TYZPR03MB5279.apcprd03.prod.outlook.com (2603:1096:400:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 03:34:34 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::b2a6:e182:1737:8f7b]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::b2a6:e182:1737:8f7b%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 03:34:34 +0000
From:   Xiaochun XC17 Li <lixc17@lenovo.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Xiaochun Lee <lixiaochun.2888@163.com>
CC:     "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Topic: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Index: AQHY9ijyZogN/mU3ikCFvi4cdjkRD65A5kcw
Date:   Wed, 16 Nov 2022 03:34:34 +0000
Message-ID: <SEYPR03MB6877FB2A677FBBCF80E6BD3ABC079@SEYPR03MB6877.apcprd03.prod.outlook.com>
References: <1663075485-20591-1-git-send-email-lixiaochun.2888@163.com>
 <20221111235425.GA764316@bhelgaas>
In-Reply-To: <20221111235425.GA764316@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6877:EE_|TYZPR03MB5279:EE_
x-ms-office365-filtering-correlation-id: 2b3f332f-055b-4d2e-6fda-08dac7837ad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7yTdPys1VMAueWEHdgkyzWLzaayx9pgcnmwFqm1zZ+7McI8yg1Ypqas/aAWnup+ybGZ+ukRBUjVwV0gIxkC0a9cCi+VQ3Xvm7WE+kNaUc5LS0SmSBNO4lqvGHojXvOxBeIqW6+461gJeWPaAXGc9t8livZTTnXNGDXllHPPPYE6KyELh6DaPsCk1tHUmb9wGc0WTtOJTVgBGqo2kQ7vvmS/YCH+WsQaIpjrwtEuuJ4e7/5hyf874qfEb7rqMjN8bsMuRRRxNdcNJP9cthIpVVwwPjJ82PDhmBBgway9jd12EybifUhQCf4JoWiECL+t8usQpawHhXq5bPjK17EWgrbbe4oe3YOUwI7dQ+oifFKHuIftnd7mxIlW+zYpg0pXYmsrr/K07DzsxSazBLOwcZQBZ9Q6K0K7hs+uroTYht8VkAzeSIte0dnREyx/nEpC5beVTG2YyWxGVWmD/CnbWvmC9nW67yOb4zRCP8aRppqbRKa2s2nXrsxVNdRmCvrbcGG1hIpa43kvP1kRycoidewDzjFOeGgtgoaadtcZA+S+Gr7tF41r9Fo7GKFTL89KFPKkTbrfJUXA+uv6byjI2gsA4/pKcLPyYXwQtfZNWNP5QRwaCVnzT6BvucVMFD6JrmMBuEYr/SPQMbZkiavvm0FB6O0zXRXp5KlUj/mjyGr3wcfEXBFRG4qUAxvNo5yTQmNzXW/Gpmj01/8WyV0fMTUxhKu+4YjB0TG9JEVy7Q+HbdPoUqoegLSkygQEABEnrN/Xa13Ckat/JipRwWzVO6hW9xZLO4iiW69SRvYnVOiRqkqc5cX29+6eUEH9DdnRCxyQ8ZuTpjECsI/HUE6y3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(122000001)(33656002)(38100700002)(5660300002)(86362001)(38070700005)(82960400001)(478600001)(55016003)(966005)(52536014)(8936002)(7416002)(66946007)(45080400002)(71200400001)(4326008)(66446008)(66556008)(64756008)(8676002)(9686003)(316002)(76116006)(54906003)(66476007)(41300700001)(2906002)(83380400001)(186003)(6506007)(7696005)(110136005)(26005)(53546011)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fGX2DF+lr4IolX3k9+mvieDTxBkbb0xFaeZFZ0/A8oG061VKBMoMheXEN8pD?=
 =?us-ascii?Q?++oI1ynw2eblE/SLsqY9VVXxDugWS0r75b6+c63pPv+pur2TxaE2fBr7mtr6?=
 =?us-ascii?Q?rutIXrEV1pvrIiNrSrjG0+s2KqaG6Ih3T5GZirxxBobFllwFiVCvv3BH5C+R?=
 =?us-ascii?Q?PDhkh9WPy/Dqjywmiva9vsXDq14aYJ03/e8ccijVEjbl75AvtxFnmGQa63eo?=
 =?us-ascii?Q?fnK0Szss5cTKin6Lc06tX4BV/tmAH2AnhCOxR81YNtbm3nBCzkuQI1w7ZICD?=
 =?us-ascii?Q?i7YeQnAsuzvxH/Q7d2wD7uU2RLQULu7nUksvsaUkiNlVspWUE//KsUd7782/?=
 =?us-ascii?Q?fCVz+YLBmQGTRl541NrjDZYazbYB0mxTzCjgJ3QgYwwPyEDrxb7ZW0evtu+M?=
 =?us-ascii?Q?iica4dg7GGOA1ZzT1aHrEz28ssSHy9moSclkU3FGN/YdpJP5+XBIyg4tdzUO?=
 =?us-ascii?Q?F9zZf1c21y3gXuwosb5c97pPooyomQyCYN8OlOK+w29vI7D3dHES4R7+S6/E?=
 =?us-ascii?Q?/lsVtg+22ZfRMQ4GDhqyp3ev+mp3CqmZlVGwPU95QxXzIjsC/NZewsYKuqiR?=
 =?us-ascii?Q?4taAIBLs5+8WptTxGrKtWmwEwnGv6ZoieIBtvGJ7Fzx1QKkC/rJLzT9FiJqo?=
 =?us-ascii?Q?rkSZ4kWl6irUxoPahwNdAIkhPuBOWFR4cQZgDwMrsT5G3iSeYrylsG561rrp?=
 =?us-ascii?Q?zZ0a8d+/ddd48mLzbW8ZLF1mO9kBfnP2Yaz5qfXpAa4V+b4aS5FW2WfG0ubD?=
 =?us-ascii?Q?eY3+VDLOJLmf982rTFwH6Gq30oK/MT2DOdeua+mr4rDvltKT9ICG5WtcgX3L?=
 =?us-ascii?Q?nntaa5llu5dQ6zEi6xn86e+ZtCv5Fvayxt8xc52cE8v5pjCdEjOwagDTrnyu?=
 =?us-ascii?Q?Sy349w+PhoUKdfEHLyY5oWyBvbPLF4jN2tq2PvxHlJl4UuzFVWW/zi0SWyKz?=
 =?us-ascii?Q?M9Q1Cft/WMAlMaDBAOA+9FPVQy3Q/I6rFtNWUsTDUFnZtqMkll4iEzTsle9e?=
 =?us-ascii?Q?fz0gKrGTW4p++lamhv2SJZgLwYHS8ikWJ7SuLDCAxcMf2Z7V9Mk3+0DFdUyV?=
 =?us-ascii?Q?DRNKwOcMCSNO2qJz9c0acE8Z4NA/uWlQpbJEbfhc4ZIdNKn/h/T9xY6J8YoD?=
 =?us-ascii?Q?DDhzTmLORVWL73szlPd6M27aJSO9SNwLze8NIjYYT2XUmUoP5aH115EDRl26?=
 =?us-ascii?Q?E584UZ60FlIW+4Syfd/r0WnzVZT55GgaZF6AQkVWYftsi+37wftEXEF4AUO9?=
 =?us-ascii?Q?yTRXikypB4TEKt5icauECn5cQYzdIsUIQstZg17yJ1j781ecKduohfq47NnJ?=
 =?us-ascii?Q?mT6ed0IfELpOC1vqBF/V+4WIjcH9ibjxYrVOeIibV9DK5UJwQ7/DbGaQ+KQv?=
 =?us-ascii?Q?GG13din4JI7oF8yhBw/QXcRs3YzYwjsfN5bYOtnyQqKIt68nDDc+FWOpNcEU?=
 =?us-ascii?Q?s86SdTVMM8g7CW78g9NC0QrZtWU/kGcLmXEtnOoVX/zwxlDPHTL+Bq/TQjsh?=
 =?us-ascii?Q?pEnvi+l/9po7U37+tc7oVS9eGPhkV23D9gs3yTIru/DfXRwSLcLXWNBztZpH?=
 =?us-ascii?Q?SP78RepR+ICTtNg2jQ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3f332f-055b-4d2e-6fda-08dac7837ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:34:34.0926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaUkm/z578XIhitx9mAeQNUbx1UE8OiWMC7boFZacUtVXmX+cOOKPZ1eD2SUeHJb+QwGKRapgRU/qS47XujTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 11, 2022 at 07:54:25, "Bjorn Helgaas" <helgaas@kernel.org> wrot=
e:
> On Tue, Sep 13, 2022 at 09:24:45PM +0800, Xiaochun Lee wrote:
> > From: Xiaochun Lee <lixc17@lenovo.com>
> >
> > When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
> > recognized by VMD driver and there are many failed messages of BAR 13
> > when scan the bridges and assign IO resource behind it as listed
> > below, the bridge wants to get 0x6000 as its IO resource, but there is
> > no IO resources on the host bridge.
> >
> > VMD host bridge resources:
> > vmd 0000:64:00.5: PCI host bridge to bus 10000:80 pci_bus 10000:80:
> > root bus resource [bus 80-9f] pci_bus 10000:80: root bus resource [mem
> > 0xe0000000-0xe1ffffff] pci_bus 10000:80: root bus resource [mem
> > 0x24ffff02010-0x24fffffffff 64bit]
> >
> > Failed messages of BAR#13:
> > pci 10000:80:02.0: BAR 13: no space for [io  size 0x1000] pci
> > 10000:80:02.0: BAR 13: failed to assign [io  size 0x1000] pci
> > 10000:80:03.0: BAR 13: no space for [io  size 0x1000] pci
> > 10000:80:03.0: BAR 13: failed to assign [io  size 0x1000]
> >
> > VMD-enabled root ports use
> > Enhanced Configuration Access Mechanism (ECAM) access PCI Express
> > configuration space, and offer VMD_CFGBAR as base of PCI Express
> > configuration space for the bridges behind it. The configuration space
> > includes IO resources, but these IO resources are not actually used on
> > X86, especially the NVMes as device connected on this hot plug
> > bridges, and it can result in BAR#13 assign IO resource failed. So we
> > clear IO resources by setting an IO base value greater than limit to
> > these bridges. Hence, we can leverage kernel parameter
> > "pci=3Dhpiosize=3D0KB" to avoid this failed messages show out.
> >
> > Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
>=20
> Some of the discussion here got lost because of email issues.  Lore has
> some:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F1663075485-20591-1-git-send-email-
> lixiaochun.2888%40163.com%2FT%2F%23u&amp;data=3D05%7C01%7Clixc17
> %40lenovo.com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bdf
> 8410caa934df372b16203%7C0%7C0%7C638038076734438158%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DJzWYkIsaEfINofiqo
> XyjEh43VjXO3HZw2JLSsmhpUiQ%3D&amp;reserved=3D0,
> and patchwork has a v2 with a little more discussion:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.kernel.org%2Fproject%2Flinux-pci%2Fpatch%2F1664288166-7432-1-
> git-send-email-
> lixiaochun.2888%40163.com%2F&amp;data=3D05%7C01%7Clixc17%40lenovo.
> com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bdf8410caa934
> df372b16203%7C0%7C0%7C638038076734438158%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dy%2BtIsepTpyLeoHW6CrgkZz2
> tiMjY0TONfK7zNCKXQ90%3D&amp;reserved=3D0
>=20
> But the v2 patch doesn't seem to have made it to the mailing lists or to
> lore
> (https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor
> e.kernel.org%2Fall%2F%3Fq%3Df%253Alixc17&amp;data=3D05%7C01%7Clixc1
> 7%40lenovo.com%7C9cd095ffdb584e492dec08dac440139b%7C5c7d0b28bd
> f8410caa934df372b16203%7C0%7C0%7C638038076734438158%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DzxGz1hZOD2tvQP
> EsbxQTzjHwQvXvqeO%2FUd6I9S%2Fj314%3D&amp;reserved=3D0) and I don't
> apply things until they appear on the mailing list.
>=20
> I *would* like to get rid of those "no space" and "failed to assign"
> messages.  This is an issue for platforms other than VMD, too.  Just an F=
YI
> that you need to follow up on this if we want make progress.
>=20
> Bjorn

Thanks for your comments, so do you mean we'd better come up with a
solution to avoid messages like "no space" and "failed to assign" using
a common way, for both VMD and other platforms?

Xiaochun
