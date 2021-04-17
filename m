Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABB636323D
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhDQUh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 16:37:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9283 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbhDQUh2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Apr 2021 16:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618691823; x=1650227823;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SOccfZxxxscDTxUcKmcmO0ySSJBWszQAkIkeqeaLfuU=;
  b=k4HPkvnE2ouPeXouB7If51bUOI33gXrWSusjpaOLF3pEB8Q9jAzRXBrj
   Ohm1javnUUe2yAf3UNb420wFMKFfa2ALzMBg0FSGFnAbe5ijaRVT3fYkf
   9+NUekri9pz6b+/PXUek9kvhWtbVzHFurHEMr7VQDLiX2AVZImT2ldlaF
   W/GIfoMTQYnesm8XXQkiFD9HX+WlnAfUv25DLZvWh+BnTtJ6v7UZ8FMEn
   TAZ/RFTvj5/SSYGQSrpjX+kW/3Im4C0JqTaz5mojy1AhD4qzl1ZLJ23lr
   DAWq92pTvKGY7tnN+pdxSdGZD5HcheAZwz0FYKGwrnQbVmHAwOA/ZHpWu
   Q==;
IronPort-SDR: y5HaxgZ2eT8LJ3XziJXwuJ1xYa8Zi3xk86tN0eXNU4mKYyBRbqQhAMXMS0IWFlLJTr1YZeis5H
 sUWERI44cbbfKUEEf424ltpmVtqyxCoykIrW9hHCPsw53y1X40sZvZyze0oHbF/h7SCm2zrJSR
 2Cv7/tqRItjBEOgn8D6GI+QFwDMMuxMtesMF3AVHKfLdfZguow2UafF7KUhChfkTGheilKgePj
 nGfMxWzI3CQjvm/kcNgFsMh5ArU0xGe4ceGlC7/N+p/iOTWRIf52uOut/F9uv5lECz/1q4STbY
 xBU=
X-IronPort-AV: E=Sophos;i="5.82,230,1613404800"; 
   d="scan'208";a="269225565"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 04:37:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck4yHrN9QMOZCm6eQJ2Z4YVtEUYm3xHG7407EbxQUJoQpbBDhRcI00xTdvEIrr3JquN2qtu5jwO7bZApMQwBj4eHbE3+4CEdtvFvBjSNiymmaHcgFwhjxGw74Vde8vY0UgvYo0+2dLElSx0jUAR99+IrJ7oBTw2ePvCID9RIqDKuipSs/Klordwj2e3ZZTfg71b/cL/U0jFnubG4W80gpGt8WzVOawclCftAbpYQl17kB8v6AIi3yfu9hKtm9AC7hLRQQd9tEkfW50B2AmH5AMF7kC+AE2iUycbiRrGqO0NwIz5t7fW4DK7uZVbtuZlGYShSpV4/3vZyX/CsvYpzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2QhGBwnvjwUHe8ogyb3jy+dW34JbMNorjKrrr3JB+A=;
 b=XzKV9QG2px9hx0eZ1IDGhdD5u4uOqzqXaRngJ6nmezBNVsVlJI5AC9EaFHxGSXBeXIE/VqJ3IMISb7ozWK8qK81ghVen3+2zdxqIeg4CnM7a0hpyO/VxMjyIoCuXRZQlpbEVz8rY1WlYCGUtSBVRHpL7Sg0jDDtISuCPC1HA28OlehqJZWoih0EAwuplTaltwibD81rsVgQF/4HzLIsgp05uGDln45bsU2jLWKEWNeFxedB1I9hKFn5hFRZULtE4HPPXIHmIguVF5pZDHgcAqyTgUxw3ayLuwMHa9YDZpNk0b27NVMUGmM1Fh2s17KxUKHJc87ofOI0r4HyHG40J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2QhGBwnvjwUHe8ogyb3jy+dW34JbMNorjKrrr3JB+A=;
 b=AJsvNc92gEg6RVCl1U6QGA3biQDo42CExqkQlaNPZwApSsn+ikKC3erlUXr1Cxw9mEblYu4+mpgJMRJqNe2+DW0ZxrwXUI63J+UKG+7cZ89hpkDKGIlBFflY8pThsnpaRzULc3Tm29n/lV3EDF6xJfbGtp6Tpq32Af/tQpKlAH0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6103.namprd04.prod.outlook.com (2603:10b6:a03:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 17 Apr
 2021 20:36:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.019; Sat, 17 Apr 2021
 20:36:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bixuan Cui <cuibixuan@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "Prike.Liang@amd.com" <Prike.Liang@amd.com>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] PCI: remove unused variable rdev
Thread-Topic: [PATCH -next] PCI: remove unused variable rdev
Thread-Index: AQHXM372m5dbMPg2N0GodkAlwNRSYg==
Date:   Sat, 17 Apr 2021 20:36:59 +0000
Message-ID: <BYAPR04MB496544C1569DF3ABFCD953E0864B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210417114258.23640-1-cuibixuan@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b788c4-b809-4e36-4936-08d901e08cbc
x-ms-traffictypediagnostic: BYAPR04MB6103:
x-microsoft-antispam-prvs: <BYAPR04MB6103797992D245818906845F864B9@BYAPR04MB6103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4oA1ZamjF8HrZ2fZL+PTUbtjd7fq7d7Uo/HMfXfYCG91D11lZCzI/OHO15ICVS+VbGhwIgqkcepGxgrZry7MomrZLnK6Dyn9jygrUpV2QnfLlBR4tfDp3SXz4F3sqp7V3P2QB0ONc8NpE9Fl38raPIqCfWeDbm3dsBJtopG7Ipx1Ya8Wsz/nO+G/s3rd2CSgbJ94IJ1JfstGDhU7iLTYnb98IR0jY8BRyot2GUjqU5a73pKPKgaW/gw/KFJB/qu5yrHaC7dgm8nWa1PEy72KdWcKEYhtf42SCHjIZ3E1G1cXHdzG5wnW00Q0O0c0r931Gb3FVrNk2LoE0L9HdNHOyqX6cMSGFq/7NA8dOlCUKg6JwvR1V4YePn/ojwCMlalo2TMCLtK713E6fgx4DvlABWbHhFyzryTKaJT9y93wxX93zLxwPHKrci/ElcfqozdCFEwZ7Y56P5Z3YGdWzskd1J613LWYGuvXV+8MPTW7l+kOBj8jxJv0IvSEy4IhaH5T+vJJMlgkizvw2jtMz7gWljDNCJ3EysUZyfvUc/ikv/WqNc4uIur2nrwU2owZd6EsGv+PgVafqmCpawMORPc4zRys9Eu/k/Hqrr5lSCxtuy8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(4744005)(33656002)(55016002)(76116006)(6506007)(53546011)(186003)(86362001)(4326008)(9686003)(5660300002)(52536014)(83380400001)(66446008)(66556008)(26005)(71200400001)(66946007)(2906002)(66476007)(64756008)(38100700002)(478600001)(8676002)(110136005)(8936002)(7696005)(316002)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?wDxCUIo6JAOCerL2po/dye/IpO0Xk4NsgbpG1mA+lu25x2JTlav6Q4Uw?=
 =?Windows-1252?Q?odoXKmVXOjRM87ymzTVimHehvxhVJtYjHnimBPH+Mp1e+p2WbuyAaE7/?=
 =?Windows-1252?Q?t7exO837rSbauwiJIebQJreeCzFV+MviUEm6x8HeO7lVKHnSzrbu63xt?=
 =?Windows-1252?Q?MQAFp7yxbFs6mc1pRmqI5NZb/uV5dZv6glYgEpVG+dDSInytEjeQmBJL?=
 =?Windows-1252?Q?zofdz0/Fg1FS6OoqCFrpodsSJlB8SoawJcYEj4y+kqWdkZz/N/Gp/Hp1?=
 =?Windows-1252?Q?PMxQrjF0MSRDKbdQ8VmJrKWrv9ihILoI6NUY2T26eYJP6lhd378Ep16K?=
 =?Windows-1252?Q?k6DjqJYnv2QTCPx6wnWRJlHxmlFLqHTaK9HZ8m/9t0OUMmVDtIqUBjPM?=
 =?Windows-1252?Q?2PV32EmxqH9Jc91GxSD1Oz+J225xXZlYi9E150FtWbn6Pd+rGuOqZbdu?=
 =?Windows-1252?Q?+WMRKnutGA+dvdmAPSOtaaZtEdqlkZzsAepZdpTvs8U/Rzs5gYbOfh/+?=
 =?Windows-1252?Q?lRD61jeRW8U7s2jZuHezyuEmVCVx16Sold1IgSo21doTDKOGw9ENggmH?=
 =?Windows-1252?Q?BSHYxQxDmWiT7p89hDBJ8j8NywNyfkmu7pkaK0WG56O4dBBt+S4tKuN1?=
 =?Windows-1252?Q?c7zdgNJeLQNo0Eu3+sf2o6tPnlhWXURbfjIdNrP3sPvibaPhBQK/biLz?=
 =?Windows-1252?Q?qq9RN4vzTiOWdVvI8FZfqiDyg0nbTrpIkaKPRka7GiClxpbWG4VTcoPm?=
 =?Windows-1252?Q?1ObStd1hqBahWtT5S5k5LxTyZx7CpT1myX/if80vGMeu/0uBxi4md1M/?=
 =?Windows-1252?Q?/rGYu/RwQJw5shi9d0RlSFS7oBC9lnEFqh68utcF+89guvsBjhDi8SeK?=
 =?Windows-1252?Q?8Ubd1wxn3dKUj2/VuRiq6YacYFvMuoIXG67rHzA98auw5wkof1l/WxQ/?=
 =?Windows-1252?Q?3fzP4AkfTOkndQqjqt0o9aaSu74qXdkWclZzn+CkzQpop/oeA48VN6oR?=
 =?Windows-1252?Q?PLfKcwtnj6POxkywzowu21oA7jtvurMziVNT8z1+0Zo36iDzttZYMXGx?=
 =?Windows-1252?Q?LWB7Ai8z8TNUQKOp0b0Gxnahe4/kRaxlsraQGFcSKuYF0Rez5HPdh90Y?=
 =?Windows-1252?Q?INixhjiGCRNF6Z3DDnUZMkf/l5BDkjiXn8XtYZBmZW8poK9dZuKp/WnB?=
 =?Windows-1252?Q?hX0HAyYB32EmywaAQ/yRLArel89vWBwTjL3BF7tdj9pel9RHHvWRhh4f?=
 =?Windows-1252?Q?brn90AJQ0g8zwOww5OjgGKESprKCBHzng+uZ+msIsu8Afkc6g/RAv5KB?=
 =?Windows-1252?Q?pQkQa+VD4MeWmcO/OkuLzh1StYN7uATlP7oBMcBV8FOl4JEF8VvlXF+5?=
 =?Windows-1252?Q?9UZzaNxgW91PaYUb2N4apwPz8/ssK+LZXpfb/X9O3K6Ch7USuujnTy5/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b788c4-b809-4e36-4936-08d901e08cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 20:36:59.4038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbDYPgWV0Ajitebvouw2gyewu6i1bpSv8k2+aZW74ZX/PKCnKkl7W+wNr0m4XvqLozcCDu1dkGPi+FWMtLLvOD/0ejsE0s0Cw/vfgBuYztI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6103
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/17/21 04:44, Bixuan Cui wrote:=0A=
> Fix the build warning:=0A=
>=0A=
> drivers/pci/quirks.c: In function =91quirk_amd_nvme_fixup=92:=0A=
> drivers/pci/quirks.c:312:18: warning: unused variable =91rdev=92 [-Wunuse=
d-variable]=0A=
>   struct pci_dev *rdev;=0A=
>                   ^~~~=0A=
>=0A=
> Fixes: 9597624ef606 ('nvme: put some AMD PCIE downstream NVME device to s=
imple suspend/resume path')=0A=
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
