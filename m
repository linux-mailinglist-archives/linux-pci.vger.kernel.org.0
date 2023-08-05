Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EC7711A8
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHETH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjHETH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 15:07:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A2126;
        Sat,  5 Aug 2023 12:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7G4VO1XvQ/QX+aqgF0aK9ZhjY2dZ/KQG1cTBBCgB+bcY9CsMZ9rwSqEp2Bcxo9HD7vYgGUgpn+ZQ4Q0c99j3FToq0sdqqjlbh0vXxT8C+Ae3qGg0Q+DDxH42lc3nCqrQNjbooUBl2syoeWM91eYfAcZZJ+hsFyMI7+XC1do+6JHFas2WC7EhyXgzwke/bo+JOe0WcND+/dXShcDYh/ToTlMu4rmvCZFghpHWdBO2EntRkkIr8Zd49E1hOhVnn2PP25tL0GtE/ldHT0JCVSHYED3NOD/LARLhJug+i5d5n+vyZaDRCQ8WktKVVfxnkU+RaQYTwd8o9EZyfjW8sS7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR4BwMkUwXzEj13LEZ89I5AB4EG1sVUtWxGltEoZncU=;
 b=KHep58KVEGQ2IM0O3eSAbiNW/yrbb2S8NfzNQAu6X+DxfAiGI9LIztIsbKL8jUeo0Z9Bw4c0DETWsMUETRKURQOI86G7v5+CbxGxa9gzMlNC5Zqnf/BO+46Z8aQaBuIJde6GKrBdUEvL2+YXMuD/hPAq+4EQ1MKRXRII6hS8KciMHBtzge2GPCOg3g1YNPNqqJKyI3po2MfOl7rIBV7IQ0riVjCXvo71aOTNCLGJelx5Ifgx2MLXKSUwcmf25GYbZ8OHlZLmy+AZP/8/XhPwH+Pf2sSupld2akHp0n8MufmJQHy5Y2RF2QBh3jPgENrzsgur5dUI9lP6R8h/wv5emQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR4BwMkUwXzEj13LEZ89I5AB4EG1sVUtWxGltEoZncU=;
 b=WiVVFS7eaSRCrSIf8I4BYVUQ9MQ3nB/XrIxqvxP0e38+tmdslycjh6c/wM6PurEAUN7uYDrYmt73ifXFnmZEw6UNEhNGR2g1Wm74G5SHAczni7n5Qr7b+njn9yVBsCRD/TSjDyq+GJLZiKq9TIb/BTsPTVf49GwqA3cbTZ16Nl8=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 19:07:50 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6631.046; Sat, 5 Aug 2023
 19:07:50 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Thread-Topic: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Thread-Index: AQHZxgC0Rv/C4y9Z90yNvq9wBSG5NK/YyrOAgAD1rFCAAM+wgIABWsZg
Date:   Sat, 5 Aug 2023 19:07:50 +0000
Message-ID: <SN7PR12MB72018BE0D2DD36ED2B86C2D08B0EA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <SN7PR12MB72014E79448FE6C7A47718E28B09A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20230804195827.GA159466@bhelgaas>
In-Reply-To: <20230804195827.GA159466@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB9102:EE_
x-ms-office365-filtering-correlation-id: 33538b79-a972-4a1e-a024-08db95e74363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/ph4bG8CvVqhiofPr6Da3I6RT4UeT1FPJmVWHrfog1HzqBsow2Zr6hxfydH/7QKCun4xkzIaXXdjve9cIusXD+lt1Pthm3BBvsD6dXg1EvdVabpP22TVpT2JZaLJbFBTsLKFlCJOLeO1Tx1SQJWfPRZEWLeTqkmouiJ9E1WIGHsFfqR9Gv/RaWd6sz6vOxF4bIY/IgAKwLBr/hAayyZBbg4PQKu9TO7cTGgKUKCzKDiy2xGVwSP2ErExSrjeUbwVMSvCQZKlt0QXcAYdiFeLCwiX5jE4iILpWhBd7mO5yxXim/NjN2BcQXC9B4y3xQP43hRay8vo4RSI7CjfNOVRZILlNrT1GRb/jKSHJCbsjM15idy2dmEKN3Q3paTENjs4xgeQYYRVrDAt+1VebQxWFOHkT6yT819Z4v3II+OYcGK92YauF3Fmt1M3/eLw1NXqzVINWk+C3kpe1reeeOsLP6pYJHJtaryYEKfvEgPANeajL6Lj/AjI5X31fOvAZSrFAlob80pdM3xMFAZHoPm8Bamz9AUclDzhs4xqm3aS9tTWWKAk990UqPI0Vv8V4w1ETaARLyN8AYqFkhMI12YVRmvdO7kffyOof/uRM/ekRfe4joXEBV1KGQ3XqW2f9D+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(1800799003)(186006)(55016003)(7696005)(71200400001)(9686003)(33656002)(478600001)(86362001)(122000001)(26005)(6506007)(53546011)(41300700001)(316002)(5660300002)(8936002)(8676002)(52536014)(38070700005)(54906003)(4326008)(2906002)(6916009)(38100700002)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v9gnZ5IZs7QBRbrO12Q39RwZ5nj4nwBfkuecVrKwVCkVTOQyHxhENbBPsSTI?=
 =?us-ascii?Q?33qP+dqxtm/P6Y+ZzU+vMwpVA677fXx6QLTSTD+qbUeOtuiURyC2EsXvnkEI?=
 =?us-ascii?Q?O5ldzex7J7P3Ammb+x8lhtwKrVFKy1LXj+7clOnkrYiwD50uJx2NAeev/cI1?=
 =?us-ascii?Q?NzqKLrOpE0Pt5CBEgjTrtFdFXdNtXgxXqmxvZJ737mGS46eCdj7DxYKSbR25?=
 =?us-ascii?Q?1yAsaGabWK9cUslcKtpNtYA6hy/dCvBsVG73F/9M1mfFcz8Swx5e/05wI1QW?=
 =?us-ascii?Q?lYerctRWWPJpo6x6qnCSZv2qRMa/rcHJKuQLsjegyBpI212P2kPDRAmtuL1e?=
 =?us-ascii?Q?62356xEFcWEyOJBm7qfKUKZfk77iX5tcEzJLpvdWCd9DrCBhxMFmSZ7bOYdR?=
 =?us-ascii?Q?IelOpNwuKyFxQcvd8OTJklL1NwZR+WMIOEdB4nSr9wabmQKi3nlTeM1Q6XI0?=
 =?us-ascii?Q?q7A3vIBE63UdBHQaTrdXVh7qQKaXzhlO3qqyYaJUgr/1p18B64LAErl6ksKN?=
 =?us-ascii?Q?GXbh9vBrqqeYei0xo7cN8MzY1DyAO1KI2s2uZ+UPiWH01A/z1K3JUGtDvZPB?=
 =?us-ascii?Q?qX05s+N3bhCJgeH7SXiSOHRJxXoMlTl/2MF2ozR+9HLqJWWPonybJS0HKQmN?=
 =?us-ascii?Q?VbPW39DhtZk5b31BhAyy9jfWJR6Rybz763/a2tPDdbqmwzNtHC5CvqoogeFf?=
 =?us-ascii?Q?1Ar6NpqC8W75p1ES7A1Qx5XJQvO8KpjCj8/s37/cDD0FyqXxDimkOr87IZWG?=
 =?us-ascii?Q?9Rb27aJ8aIPVzUk7fCpUGlDGL78gAQvG1/HOMZn8VD8bPiblBR7lPqHI9khm?=
 =?us-ascii?Q?9EdmqbpYOMQVXEIMIqzGqHiuePe54T4bDn8mmGQC5rnG/D7tGKKWUuNHAN+W?=
 =?us-ascii?Q?+JZgYMcXpKg1Zp8uwhNR4PF3bqAzG+rh7RG1IAb19+N8DTEriQLb5d+InkeM?=
 =?us-ascii?Q?JKDg0/Po1aakcd2GsMKhFb7m/mR1MWk8jtNRu4TwugZvpDDqgxbdb1Uckzlz?=
 =?us-ascii?Q?S4TcSOpSuq9QNRfsZkuDTrC1YDEJMow1OSqeGfR8ABpbDkzUP3eQTMrKUeKW?=
 =?us-ascii?Q?RNALuG+DFLBPekmcmuyuy60PAyWJzHjB7s+thAccCMbfVUTVIBgO8QGOu9Q8?=
 =?us-ascii?Q?PITH/3ZdSoapxP5srqyfs20v4C9Cgdqw2MS9gm+QcQhrcPGe9gFJKSkg5a31?=
 =?us-ascii?Q?TKlD+xvHHKT1E2U9yDVqIairJDjSzwNEJFx4o/ZJn6nqTsdXBGTa6XcXoa4a?=
 =?us-ascii?Q?jTE/itsC0vnmkj/W9TzNONEVFKRru0TQfMO+Bf17XVLFGC2un671Dly3kD7e?=
 =?us-ascii?Q?+7wRkpbWT22b5O1TJMJp/WhG8jJAQCWoqJNe31tblv4kYOhBsr92xptqp0ed?=
 =?us-ascii?Q?jhvuhovofUI3/YxZng4gqItOetyKZqNuzcfil6a/ogcZVqKUMhVdyqvm/Itc?=
 =?us-ascii?Q?OY2lrkjO9yFWxdNg21+0ZA8lgEVEHeWjzLtNblvHT6iMFYDcv8n5+/YGWO4f?=
 =?us-ascii?Q?C0+1EM7JFjRRTroWFhLWOsM2FG2usY6n75l80iz1L3D3lvmrbDsm3e4pI7Sw?=
 =?us-ascii?Q?QBE6A2XnaDwRaWNcjrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33538b79-a972-4a1e-a024-08db95e74363
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 19:07:50.3244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCSIs1s72AFRa0/Ejydga4zhTKjPZfTIhdPhVZiI50gt86SenrlaMPWTLCX7zH78MDGnkmpG3BULRx+OW7M0Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, August 5, 2023 1:28 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org;
> krzysztof.kozlowski@linaro.org; lpieralisi@kernel.org; Gogada, Bharat Kum=
ar
> <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updatin=
g
> ecam default value.
>=20
> On Fri, Aug 04, 2023 at 07:05:30PM +0000, Havalige, Thippeswamy wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > On Thu, Aug 03, 2023 at 05:20:16PM +0530, Thippeswamy Havalige wrote:
> > > > Remove reduntant code.
> > > > Change NWL_ECAM_VALUE_DEFAULT to 16 to support maximum 256
> > > > buses.
> > >
> > > Remove period from subject line.
> > >
> > > Please mention the most important part first in the subject -- the
> > > ECAM change sounds more important than removing redundant code.
> > >
> > > s/ecam/ECAM/
> > > s/reduntant/redundant/
> > >
> > > Please elaborate on why this code is redundant.  What makes it
> > > redundant?  Apparently the bus number registers default to the correc=
t
> > > values or some other software programs them?
> >
> >  - Yes, The  Primary,Secondary and sub-ordinate bus number registers
> >  are programmed/updated as part of linux enumeration so updating
> >  these registers are redundant.
>=20
> Ah, so the Linux PCI core can handle updating these from whatever the
> power-up values are.  Good material for the revised commit log.
>=20
> > > "ECAM_VALUE" is not a very informative name.  I don't know what an
> > > "ECAM value" would be.  How is the value 16 related to a maximum of
> > > 256 buses?  We only need 8 bits to address 256 buses, so it must be
> > > something else.  The bus number appears at bits 20-27
> > > (PCIE_ECAM_BUS_SHIFT) in a standard ECAM address, so probably not
> the
> > > bit location?
> >
> > Yes, Agreed I'll modify ECAM_VALUE as ECAM_SIZE here and it is not
> > related to a maximum 256 buses.
>=20
> Well, it sounds like this value *does* determine the size of the ECAM
> region, which does constrain the number of buses you can address via
> ECAM.
>=20
- Yes, This ecam_size does determine the number of buses can be addressed v=
ia ECAM.
> > > Does this fix a problem?
> >
> > - Yes, It is fixing a problem. Our controller is expecting ECAM size
> > to be programmed by software.  By programming
> > "NWL_ECAM_VALUE_DEFAULT  12" controller can access upto 16MB ECAM
> > region which is used to detect 16 buses so by updating
> > "NWL_ECAM_VALUE_DEFAULT " to 16 controller can access upto 256 Mb
> > ECAM region to detect 256 buses.
> >
> > 2^(ecam_size_offset+ecam_size)
> >
> > Here (ecam_size_offset=3D12 and ecam_size=3D16) --> 256Mb
>=20
> More good material for the commit log.  (1) Change in ECAM region
> size, (2) previously could only address 16 buses, now can address 256
> buses.
>=20
> Is there any impact on DT from the address map change?
>=20
- Yes. Now device tree ECAM size needs to be modified to 256Mb.
- I'll update device tree changes along with next patch.
> Bjorn

Regards,
Thippeswamy H
