Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156534D4CE1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 16:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCJP1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiCJP1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 10:27:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399D1587A1
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 07:26:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXdOCAXEtfB61iKNk0DdRQ0FyTWgJI5HhYZFyW62K6LPFvWAvuLuZt4PJpNvJX1+RSB8TXG0PSK7zzAIQzk3accHu+QHEZIrVuuc2h+J7zvsTXVO2CYIzUiO83UuOuXsWbdBgH66Psa4z8x1LYcu9DV6fbEd+6XbcNUUlpSBJ8D1EBXtXN2WEI5YBpzurqo1EbzlEqhkPE7ZPO8DgNBCY9mD0pRBh/z5ccPxmq23IvVJgOATu2uap7WCv6XN51nDutK2u/5JGjDV7fzf1RS+xdAvvkNZvMcyHpe5XvVKQ6fzc3cZ4d8BwyICbmaxfbgLJ7bEUHwx/ZoTxX6bgkMY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWYHrWP6sW0XDFtWdPf7JyJ5AjcjVE/C65yip++ajM8=;
 b=fHmPGxPEr2WjXMFu7dyGr1DM+hl3Bq6h6KoYsInl9YO8EoxsVNnn6+XV7vNnqLz9qkNLNSclM1ZGdzZy9cMMSgRpPq9JHbJi4LZrlES5VwD/5EBIiwIv8lPGGQzM+05NFarvUv1k/QBYTPRIiPDMxc8X7iBUB43q/9t5HCA7Z7nPSJ2PB9bYqqA50iqAys+sinLMLDwgqiTm7SNkitjlGgHlMEpUOAXHpj5ocX/xZzZgK4Zts6/sXyNu3IPbEIXWS+i4Ng/bo+4Njx/BxHz7/hqoz3lIGNFj/Yh6idyraOboj9740W+DkQYaIOk/pWx5YSKMgSy+sblU3afYmdOmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWYHrWP6sW0XDFtWdPf7JyJ5AjcjVE/C65yip++ajM8=;
 b=KgBXiKZYjdIXt8U+xIVmZXHTGPAFFsBpyBWk/YPfvgajTgaPb1bdwSJRPaay7S5y3wltvdVuONEW2ped5ycjIX6vyhYuhecFmj7pMy98YnuVlqdRgI3hdJNNCJP50kqCotqokCelqtSEaRhcZEGLiHs/poofgiHMrbnHzvwW6E0=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3789.namprd12.prod.outlook.com (2603:10b6:208:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 15:26:15 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 15:26:15 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Thread-Topic: [PATCH] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Thread-Index: AQHYNAf44/EKKl5JoU6DgQEBAwDa96y4Yg4AgABbdoA=
Date:   Thu, 10 Mar 2022 15:26:15 +0000
Message-ID: <BL1PR12MB5157F6BF645D46BA9898F2D6E20B9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220309224302.2625343-1-mario.limonciello@amd.com>
 <YinLNvaH7+yv88QX@lahna>
In-Reply-To: <YinLNvaH7+yv88QX@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-10T15:24:17Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2bc52dcb-c840-4838-bea2-eda14849d681;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-10T15:26:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: be0f1168-b266-4fa6-8cd8-7da71b4ce4a5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5d56cdd-691c-4a1f-6bd2-08da02aa5120
x-ms-traffictypediagnostic: MN2PR12MB3789:EE_
x-microsoft-antispam-prvs: <MN2PR12MB37893DDBEBAA3BCF69F5CEA3E20B9@MN2PR12MB3789.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gI7/APmJh2CO0RmtGF+Iu57qkb3NRSQmbOUKOm9N7wNDERYiQ6S6qDiOyvFWnSpqWUT2ddeb4+4TA83g38FFIvyUEyGdDIpU95tdxWSSb9OwBsLBhJRM1SAH8FljLV4Bw4y82P6zKH21cJJ+RCe+IYR7LATUcEn96SB2WT782LTozybuL70+SJ0SFEe+gMcmtaiBHUg/XDYdSQhTmMAvtqGUPQ7yBvzA3ZxQdysSlChkQKJ+PxmID2G0xTQ7JcEc9IppNqPAlj53Gif3oas3qMdUUdj1gJNvA/tePWfI5wDFsvT6lIIv2fNkjXI+DjKRMZfZUqpFFf+bXlDTH84jy5j5g07s5HpMViQujeSvhujDGrCxIbcdlMh/Ed8Yy83XRhdVUQt6vN5rnTyZOWWe/ss9XYdmn5saDlObQYHJE4XkMIXOdWR/BPJCVsUjZ7ErBlDgFuPVhLTR+MeGJ36UZ7JsJ1lfSHBHy9QfVMWnnQ2NwLPyx9NqRCTdlBr+g5fq8hq9hRbFiX72zfR6AZjNnDVPxG7m8ZnXD1jUIP005Te0DakjniRkQnv7Eg6OyLCF61mTsM+gdMR06hNwo6KKVay1w+1WNApSsWngdmr4JrYM1WhYKy8w2946ezb9Izm9Hp03rCa7UDdLr//tpQbZVU0oE8QFd/JcOTKO9afS/i5EbGX3bmp86WlMA3wBB3bqiLUtXH0q1JLFvgjPiRXyy9/8DqqYVxizwSAjeqo8hhtbxS4FhNLxfgk/N/3BkpMcGRBkIXS1+y3k28LJHsJRsyMYH0UTaZf/OlfVuGH31eXPhhR/i5ozdKvUNCIey4ztrMtaMlAbyYZKhG8EYqvBjfhjRDWH2ZWIhFC+kcvKxXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(9686003)(6506007)(4326008)(66476007)(53546011)(33656002)(45080400002)(7696005)(66556008)(966005)(64756008)(66446008)(508600001)(122000001)(76116006)(66946007)(8676002)(71200400001)(2906002)(52536014)(186003)(26005)(54906003)(38070700005)(6916009)(316002)(83380400001)(8936002)(38100700002)(86362001)(55016003)(5660300002)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dXl2+96QEBcjf3aoAhqctDOsyrhyrVTSE4KeKeYvhFsZN34rpIuUyz0UIrr8?=
 =?us-ascii?Q?q8UI40Lukh/RWPY64ofeLzE3JQjYAMVmRgPodnokuU/QVf43NMV+9jLqgZs0?=
 =?us-ascii?Q?d4eFNzpSs/j646ZS7RuTjojO/C4Gr8XiouhuL4fHghdntquYv42FH2dyKMVs?=
 =?us-ascii?Q?YXLVCU5czXSOm6CN9tZAJerpEAQVG/yy/SeE/e+f4WdaFm0+VyIqD7BJWFgY?=
 =?us-ascii?Q?7AIo2HYJ4tJoQoTr5TqjxJflAdPHmxpzHAlkDg+H9Xe5raepjmMYgkZ9d97A?=
 =?us-ascii?Q?aOIM8XP/EKfesfWKI8VmTbA+Hs0JRvzBQx1ssf12K97gJPE00Hw8zrLIea7W?=
 =?us-ascii?Q?VxBNXCmJ92wv1Nnr2BCV4vaxVvz0pMx7SLwWCROE2AA060NvI1YMopgxmo2C?=
 =?us-ascii?Q?XGJpl4KTKFZQjn9qO2W150tm/6yMvpuDAap6mjTdN8CIT/swiHUjj4C9Md4d?=
 =?us-ascii?Q?DNG4sevxH/qT7tHE04sB7iI4935Dj+uomb5cnZr0pzFWMuupiWIbKhWt12DR?=
 =?us-ascii?Q?WL5IS58JP+JFkpvv9ooe9Tif+wGs5ewwXrKwEEg9wwMS8s2PPbAupBhgXuOD?=
 =?us-ascii?Q?7CBZWeBTJ0i6OAF7pFslU/T1jeSEF26Ua9twoxQeHe81oD3Me5CE3Vw9GvHS?=
 =?us-ascii?Q?gXcEnhef5JKD/4QvofwDQOkrnROS/h/m+wsuSpQ2CQfYMhcDHWXzTPSFPDsg?=
 =?us-ascii?Q?y3xEqaq6AHITZfKNWfWWB9HA29eKJPfwlkzCle+KdPKBRWK5R7H5FwY8YNGg?=
 =?us-ascii?Q?AZADZ8TtI3vUlTyzPVdWdgqOzb+7AhZfUD3PrAqLLpDw+q+SOXHiHsBV3BU+?=
 =?us-ascii?Q?shB7EqXCod4SmrdNXmiFcxi4uRdM1CY2MGEtQRRmCqGM0yOUeq3Y2LU+thck?=
 =?us-ascii?Q?i63Afs2MJ+8n8wvdSESHHDKeE878U3gEULVy6gmFWtVJ4D2UpK2uU6sMQuOP?=
 =?us-ascii?Q?32pmsk3saEV09Fp0jZ4olGcUECfJeNsgk9FNkhYc9RtEoCxqs7gDuPf7CxTW?=
 =?us-ascii?Q?zpDdy1BAbwQEBfJIfH29/dvWFueNHPlUMrZzvZsRjfAjhb91nB+97h2Oxf4t?=
 =?us-ascii?Q?HInUUhPPexhhx96jKMSp6wLmRK8jnMpmWdHCKhrNOQtFKWH40RI29uAS4cHO?=
 =?us-ascii?Q?QjPJ6iKDj4B159yQHGhVS2LtWXcheqJTPnd8jH5qLga316LlZFVEQi8RB6P/?=
 =?us-ascii?Q?7dT6ji0c5/iwTirASNovAwH4bnQ4UZGiiRlNlUJoAEkKwnsFKSfiWmtA0sJw?=
 =?us-ascii?Q?RI8mIXqUgzkbBMH22leitl4sNgEeUsnYmqO5jx8Bf4YOPnrQluz4hjMY0v+L?=
 =?us-ascii?Q?Pl8U2b2os4vG6YPsiZwkZeqx8cW5hqlolbh/9olscGBpQL1qYBgfaefjVlr7?=
 =?us-ascii?Q?8YhRk953YIEZpdOUgYOl94qgsAje3s8kM9CetJ1rljXsqENjNX1pt6w0/F0t?=
 =?us-ascii?Q?1kW9BCnL8+M1GCGShY1nCdxQsJ/HWaF1wbq00AEKPiuHevUrFXRZDJmaV1da?=
 =?us-ascii?Q?iSDx8JswkOZKl5856Gb0bMcoA4oLtpUnSm9y8DvOo68w9p5brI4/ScjF3ZSI?=
 =?us-ascii?Q?hJSBcu8xrryv2yFu6bnyj8NPGURjSL21eRu83QlnU+X2/Te8ezEhCCJjUupz?=
 =?us-ascii?Q?PXOpgQ4qyoVWBvD+sE5HW8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d56cdd-691c-4a1f-6bd2-08da02aa5120
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 15:26:15.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFYchM3CNvmsX1EaGH9A8jFsMFcao9BpDR7qEmTnbE8OD/fVtBkhTjCa7VvpU+YZJ53ETjY5lZIhgyGs1b9gnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Thursday, March 10, 2022 03:56
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; open list:PCI SUBSYSTEM <linux-
> pci@vger.kernel.org>; Mehta, Sanju <Sanju.Mehta@amd.com>; Rafael J.
> Wysocki <rafael.j.wysocki@intel.com>
> Subject: Re: [PATCH] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
>=20
> +Rafael
>=20
> On Wed, Mar 09, 2022 at 04:43:02PM -0600, Mario Limonciello wrote:
> > The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for=
 a
> > bridge to be able to wakeup from D3.
> >
> > This however is static information in the ACPI table at BIOS compilatio=
n
> > time and on some platforms it's possible to configure the firmware at b=
oot
> > up such that `_S0W` will not return "0" indicating the inability to wak=
e
> > up the system from D3.
>=20
> Ideally the BIOS should not allow this to happen in the first place but
> yeah we've seen all kinds of weird behaviour in the past so just need
> to deal with it :/
>=20
> I wonder if it makes sense to log this situation?
>=20

We double checked how Windows handles these circumstances and this
change makes it match how Windows handles it too.

> > To fix these situations explicitly check that the ACPI device claims th=
e
> > system can be awoken in `acpi_pci_bridge_d3`.
> >
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fuefi.
> org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F07_Power_and_Performance
> _Mgmt%2Fdevice-power-management-
> objects.html%3Fhighlight%3Ds0w%23s0w-s0-device-wake-
> state&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7Cde80f5d9ce
> 484b608b0c08da027c84d3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637825031070157114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> p;sdata=3DmD6EJTcL5V0syIkscYe5kmmbyg3zDqEQBwP8zCAO5h4%3D&amp;res
> erved=3D0
> > Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs
> .microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-
> for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-
> d3&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7Cde80f5d9ce48
> 4b608b0c08da027c84d3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C637825031070157114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s
> data=3DS2JtOwrUHOb5VXNV3BepBS2VxlF0s9FW4DTMHC54ULU%3D&amp;res
> erved=3D0
> > Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug
> ports")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>=20
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20

Thanks!

> > ---
> >  drivers/pci/pci-acpi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..9f8f55ed09d9 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >  	if (!adev)
> >  		return false;
> >
> > +	if (!adev->wakeup.flags.valid)
> > +		return false;
> > +
> >  	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
> >  				   ACPI_TYPE_INTEGER, &obj) < 0)
> >  		return false;
> > --
> > 2.34.1
