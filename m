Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73B79EC38
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbjIMPMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIMPMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 11:12:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E2B7;
        Wed, 13 Sep 2023 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694617929; x=1726153929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pLs//m6RXv0qKsK0sWBoRoTmMbChDoNgrbCfaNVv/as=;
  b=G1+lNQYnlnM16Ml+Qi5DbvJKftlacgZfc9afyaq3iQTTd10WDlR6Q0NC
   ksYrvLIahZDFNsv/6lsF7yWYpBdANnzYkHmicGKtbBh5t6l6w2LTyKNkF
   G4EOtAitluKehJs1IutYAOWoG9bMvDCO3uUdqs2iyQAECmVczuuHd1JLE
   0nOpP1GsMsWkGkP5cJBKAInOhkP/tPFzOm1swhh4v5AolHj7QPZoA2SSi
   3YTRnrOli+oxFESyKlJE96Cx5kXfeu68wNigHfrDNFf9C+4wrAFPlN7+g
   mPc1RM1VkYlVypQ8jmAusKrWplhUkH3oxt78EB0xZrtAj9XAKVIUHye+A
   A==;
X-CSE-ConnectionGUID: uoWYCPvKQt6KqEksHbKIyg==
X-CSE-MsgGUID: KiTfEgVhQ+2x1JABDn+3KQ==
X-IronPort-AV: E=Sophos;i="6.02,143,1688400000"; 
   d="scan'208";a="243855898"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2023 23:12:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNUSzDYcyZp0Ue9/mdi2kq6eTIygim7aEdvLKjunR787pIYI3QvYgEj9TLUFEnmeVG1R90w12AFSEWM8KqXpisK7uqH/tR7mPA1RdcLzAe6TFpLT0p2W64lvDntsuDGM65EaNBJS3/fbU+SJVOxMXWEkQsfyZKe7Af7FL+y+ZhbCDeCpRaFefzRmitFwGui2nxDY4GDtCU0C78lUnVQRZk41/wUmuEjIJV8Xmba0QnsSjWXAgrFNtVJNxNTDgwP11fkqtqSLDQBs3sSDjpPbwPEPEHhaPtk4+2xBSsoDzhfmCiXH9OQRUwaPUFu4NSx5VcyNEeZH/qLBhLpV3nxTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfpfSJYEc2tS9l0Lp58/S5fZm0gk7dnn4ZlV8s+S/zo=;
 b=dAuYpvxbwk54+vb15276vcBcjZxxYxLLaIFHyOyE+6CEZLNEnzBByX6ADN42Df2ncnEKrQ/UjRo6bCujigyAbaLDW+zK/T72RRB0Z7bDRp7ok0I8OVY5BSOiMA/WKrm01fE3+FhwrRbFOuWxG7MRZWWALbNFuCAsntsG6HYXhm/9jO8pGH96VS1hW/3RZpP+MpyfURnB2Iz+ELorU/ppAVZ+eWlL3f+rkBtrEYAizWIQC5EnCePEbtYTfB8qtr4KE/yrP+V5frDZ1fMzLlI+Cp5JMaEgxgtV308QIxiJ9/Qj2FppJACCKC5/sVZ5Y94IVkXIQCq2Rr0eMUzKnBEP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfpfSJYEc2tS9l0Lp58/S5fZm0gk7dnn4ZlV8s+S/zo=;
 b=M45SUHgq7KG6gwivxsw3d0O+ZREpBV0KKn4PdhQjG92R5iJY5kUfkb/Qqt18hy9ins/jYyVT+B60bOyXcturGAz8EP39xzh0zhbD8Do+wHK0h/8MwaoYFoHm0oDSdd99SMUvHb1QLR5EmXj/52bvN5b7aZ9jM1Ar/8qxftwsDY0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA0PR04MB7273.namprd04.prod.outlook.com (2603:10b6:806:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16; Wed, 13 Sep
 2023 15:12:04 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6792.015; Wed, 13 Sep 2023
 15:12:04 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Thread-Topic: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Thread-Index: AQHZ5lSnupdrJGnYN0eHoLtrJK7xDQ==
Date:   Wed, 13 Sep 2023 15:12:04 +0000
Message-ID: <ZQHRQHAPQdG+Nu1o@x1-carbon>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
In-Reply-To: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA0PR04MB7273:EE_
x-ms-office365-filtering-correlation-id: 23359d55-b0b2-44db-a330-08dbb46bc9a4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbpeiXIjZGleZsJlVYMtoyFlOdXoNUhYo6B8aBNp4YzyNW3RWpWU15kucRk76DLQ5a9ubm2nN10VOtHJ2CeyonbOmp8kFma2pTCVA7onlDXIINm33wg+ue5RKtWZFdbZKM4LPrymCLHikCr2vcUNOP+R+QtJeT3RtzEKX1eKjrpgg1SP4AD0vFgjNJDNVzOkGfG8DpngxiURAZKpwWfsmi6E9syMrXatTVJMYPteLBmVmtV5QVH5YPX9bF6+9eRdwUFDPf9Us3ZA6P7Oh+RXlKumg+nHG/Eu63lh0BiOsNWK3NJ+dMOjwTasfic8AF/ibGQ7shgKN1hW2JBmJd+xuW8nHubl5VVo/EMXLCNi/ryGQ051mDo4BTDgpr9suVztYN8p5crKx4zKb1ArjD4XCkxVAk6ZbEhR3sqEw0WhE2MsmBVD65eo8dgvbLH1W4cZF0er0HWdK9jplPZhiCU08vVS79pD28Im6nFzN8oz4XAQL3ZHiXgEgW+kfYJ5DdiGvmaTyfR/3T5XjTV5kd8IFosm8MRiU+xTV5rMsGhWHJsSTFbBVtvwawNMLU9tHpeYEH0EXOpFXw5tz3BfPfslnafgl9S56kh78BZW7m1Lr5ZSplmnlhunWFWDiTmL2k91
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(396003)(346002)(39860400002)(186009)(451199024)(1800799009)(33716001)(8676002)(2906002)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(5660300002)(316002)(41300700001)(8936002)(478600001)(4326008)(66556008)(83380400001)(66946007)(966005)(26005)(9686003)(6512007)(6486002)(54906003)(6506007)(64756008)(91956017)(66476007)(66446008)(6916009)(71200400001)(76116006)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nvgh5ZC8K4Pmcp1/bUFZUqOORlI4j+bnu25q4eBtr3xZYreSIKreLMHLRmFD?=
 =?us-ascii?Q?/wO2ch8s8LxLPhFlWGd4t1CpcNsaLkrIKC4GJHzsVgvyYM4G6T5+R1XK7BGy?=
 =?us-ascii?Q?SZEiarDnX42v1z8T1HHeDvSRHMTiIHNbsRvGy83KdODciWyHhs4QrY78hggN?=
 =?us-ascii?Q?7RgsAAX18Rv9ORIkTt1iTrwWmRFRax6H2o7B7aGCCROUsScpa6SZ0vA2oR77?=
 =?us-ascii?Q?rEi4lSookR4LueDxRZxE79jHW8i6lyZQMRWGp10g6bfBR7ydRXMLnDt1iqL/?=
 =?us-ascii?Q?nYit+Jcnj4myvQDWQ/V8O0MCphA/g12uEnJ7kS3ZqBEH2SwILJOIoF9ayyWC?=
 =?us-ascii?Q?YGiVtuMla4HpxVVaMyPLM3Ilbgz81WTCXqnxLsrclvIYOawICB4lFb9tTERF?=
 =?us-ascii?Q?4gVuY/it7ExQYHoUZJzxwWZabXrkCKuTudK60C3CFSZM0MsNb3426NYj/rTl?=
 =?us-ascii?Q?tTtEHdhQlEXwrAuR0PhXjOXGYnM1iU81Rkn2fp/izK9GnofkH/HwDIQT8tpJ?=
 =?us-ascii?Q?Hx3CwSohURtIVFyCs72ciluj7zhLa1lTDTfzmAQuc/zsuuKTwfqGOoDnl6fR?=
 =?us-ascii?Q?zhPys2gOAAhqcV3m1TE8CRA6/sp1CAjPpGooLA3Q/U7uj0YFbSkhm/gZ6ILz?=
 =?us-ascii?Q?zYQZcAGDd6W5/hipxYmH+AnsB9b5w3IKcjHqB+PuqetYxipQNFz/yca7KSoe?=
 =?us-ascii?Q?GDKSWhB/aLw0NUqFc7QFE+jJ2jGj3ChoGdjmSE0PbrrpKjoPu/iXxZUXMx5a?=
 =?us-ascii?Q?QIpAvZM0qxpxdtLAsB7wQK8+bmS1/z2kIeAdTeVVxEJN1qbb6uj89CbAQxQw?=
 =?us-ascii?Q?YloNGqIznEwYI/B36PQO7aQ4msTdJRWLUAhcRGcOz9JoOZazFqLm8PdY+O+H?=
 =?us-ascii?Q?VZzVwYFMsHnfFK/zQWzW21++9OeBbTPx/ElcAVMHQrhq9GWpxoxrs+t8roG6?=
 =?us-ascii?Q?2E/sMOeKKZ3xXkEkJ6uGxZ17BCQuiDMik6eHU9Lv8LsJWBoEj5MCPhxBA3Dn?=
 =?us-ascii?Q?On8TfcPDanxr2ttr3wIyPAV1QKPq+pX/qXBWjF9+HgX7+2ZN96zI/6CUARQa?=
 =?us-ascii?Q?SHMplG0T1GL8rKJkE/6EJ4neW05BGri7bijWV9kv9DJZBLkC3/4IXVdjrJDg?=
 =?us-ascii?Q?jEEk649ViB4nisT4zsxzQjOATULwZ+agX2IbAhxFF6b7wGsSh+vKXg1IZ7Jy?=
 =?us-ascii?Q?YFYeILTR0nTy/nnjbYcXYorgdZKNaSrRv/m/bnWOXSjykQ1wtCrPTBL0G5lr?=
 =?us-ascii?Q?ftnI8Cgo3MLp07v02YJAHt7esZ+PAumAb4UJNTt/MVw5rJDYt7OM3kV5Mup4?=
 =?us-ascii?Q?Kec9neFvQXwVERyKK9eULCK3Ze/+TEbCUcN4EuN0Yxn7Zfv0H2ir0as2UBkw?=
 =?us-ascii?Q?EzO4k2VSzgP8ngK8Fwaiez6u1rCOua1njVZsFJSaixq3HhDNrg8WdjcZKnkT?=
 =?us-ascii?Q?nJ+Fnt10RYT1SjvffDEnvQSDovatwcKcOVTq6gHWNN1dyNN2yvl5D6bf1nCB?=
 =?us-ascii?Q?qK6HkP52dltMJQ1XfbgSnnASP7HlysCsMnlyS4rJj3NE2bDX9GuSEAHP4+2t?=
 =?us-ascii?Q?yaNZmZAUCyR6LCNXViLyW8CyAWtASiYV4a5qMbdaPI6US2bl0u9/6hKjY6IV?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B867C76A1D95024CB4A6061E0B62EC3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RoMK2UqgiCyKDZ6dSM8TfwBtckzpwYGsNGNjda+CR41xRv/1AKCVs3CqYtjV?=
 =?us-ascii?Q?bhXBpcFeuUWug0ZQf1vSHTD6uS7cshocxON39zFGf5J8uNcWuHDmy2Smrim4?=
 =?us-ascii?Q?JfN2MhcDLgDNZ/0P9Fw+bJ9kCDR+A5v3VqURgx6e5ZgBXMUITyaurGC2QU2I?=
 =?us-ascii?Q?Id5kY90WG72WeZQBlVgwIJWN/UATCr+q0sLSAi/zFSybL0Kz7VhMzl05fJBk?=
 =?us-ascii?Q?qKwXsIlbxvAIydsomkcP7caYmyonV1grwGD2RtAOADTohLujevkiOkLT+GTL?=
 =?us-ascii?Q?K+a7weiMJIo0V887CfkGJtteLtNDCsw+ZfsMxJ1O+H1VJgw9yTjLCWTt35ZE?=
 =?us-ascii?Q?wcfP7rVS5ffbC1yLnHIWWde6gUliXNI2g9AAbOM0XzwHkZOwG6c2zRSkmYoG?=
 =?us-ascii?Q?WWensyXzelzrPfKPe5tl5BqQnHlnjQd18qPMMMgiU8HRfZGzHans6YIG1ExT?=
 =?us-ascii?Q?KmKUADt+deZtQBXXw2WveGl+RnBm/yj1QTKEsrzWvNRGsrJlC56etDt1/bH2?=
 =?us-ascii?Q?4lX53wGvnY31f9IHJEQBkl+wBiQyoDB6OXQKvtZHLCM+Vf4uLGGi8eN3uXz5?=
 =?us-ascii?Q?NF3p3n1JS+YObCS8r1s5B9uZlJh89XGLnHL3bs4auFQ7pkkBT/7uLEw48SOw?=
 =?us-ascii?Q?pXxOXcY7WvA3UT5EUTODmJWzYt9KWhI1ziu5Qtn1lbcgF3R92v1XSh4RQ6Wk?=
 =?us-ascii?Q?7xx45Ye5lZiT4UoSdMtisV7+jNJauAIUt1OXSfekGa+jDfwaSIBEC4hThYjg?=
 =?us-ascii?Q?bsiey8Y8pPnNGWBKqK6Osh9s58fI7dcZ0Lp44JRnxLVFVIhJaScyOVYS/E9B?=
 =?us-ascii?Q?kQsNx5NZmtc034fL1cmdKjf8O+pig0jF9+3enRtvenqRmRoWgrt6TPOEy6Nj?=
 =?us-ascii?Q?XUk3/kjReLmTt4CRH4kPQieEVlqmWxGjzxqamhaFxkXt7FUxrd3MmKrDpZ7+?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23359d55-b0b2-44db-a330-08dbb46bc9a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 15:12:04.0461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEAWC1NWFt94foC4A75zhm+6DovgeUGdmpnYWmEdaVS6C+BPFPWg0ipozIx5j1JD7+TUsCymwsu3YBZ18YJYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7273
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 06:25:31PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > After upgrading to 6.5.2 from 6.4.12 I keep getting the following kerne=
l messages around three times per second:
> >=20
> > [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [ 9683.270399] ata16.00: configured for UDMA/66
> >=20
> > So I've tracked the offending device:
> >=20
> > ll /sys/class/ata_port/ata16
> > lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../.=
./devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
> >=20
> > cat /sys/bus/pci/devices/0000:0a:00.0/uevent
> > DRIVER=3Dahci
> > PCI_CLASS=3D10601
> > PCI_ID=3D1B4B:9130
> > PCI_SUBSYS_ID=3D1043:8438
> > PCI_SLOT_NAME=3D0000:0a:00.0
> > MODALIAS=3Dpci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
> >=20
> > lspci | grep 0a:00.0
> > 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SA=
TA 6 Gb/s RAID controller with HyperDuo (rev 11)
> >=20
> > I am not using the 88SE9128, so I have no way of knowing whether it wor=
ks or not. It may simply be getting reset a couple of times per second or i=
t may not function at all.
>=20
> See Bugzilla for the full thread.
>=20
> patenteng: I have asked you to bisect this regression. Any conclusion?
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot: introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi=
?id=3D217902

Hello Bagas, patenteng,


FYI, the prints:
[ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 9683.270399] ata16.00: configured for UDMA/66

Just show that ATA error handler has been invoked.
There was no reset performed.

If there was a reset, you would have seen something like:
[    1.441326] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.541250] ata8.00: configured for UDMA/133
[    1.541411] ata8: hard resetting link


Could you please try this patch and see if it improves things for you:
https://lore.kernel.org/linux-ide/20230913150443.1200790-1-nks@flawful.org/=
T/#u


Kind regards,
Niklas=
