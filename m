Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225254606A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348404AbiFJIts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348405AbiFJIt3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:49:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92619C3B8;
        Fri, 10 Jun 2022 01:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOK2BvJEyuR27bNAQ2g64WUYhm+Hd0TiPhsjUy/3f85/rKpBkEUyxNwcUvB77rUSqUOZQ3R2ckBPpkIXYSbmgBkivj765gnWn1g0/ZNAxBnIf7lgNwFIwxOHhJFlNpjpzIhnnbwC+66rw5PLMvIm/XgfGugoWrZ8xy3EXi3O2H2iTMbPw3E65aKeWap8OvnEswUriczudTyayMZYrprF/+aIzoizUNEJqMa6zIAeerdkbxcJlKkuq/Gidx/2M2vlRIJVRLs4NVIpK5EKZuC/XCE+wGHwE4/OoHTSAzP3N2l7YHRQZBKHxyjMUF/o8pjOtG49U8rbzdpvRdzJsU32DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZHn+SvmZpadTBq8fX1ppytivY/1f8oJh/ajZ2+D6xU=;
 b=oN1jMw+7f0bDRD8AbnmoVo2Vn/Fde/tETQTM0Jryr11W+D3Ghvzbu5TVs1+RwDe/uFYHyPHbcYB5ApAxLZYb3ZIIGYBV8yzKgrmjCECtku36MhHxgiPcMqnwT07f3ticggGelGG6oG5uVjpOjuTgAxXgbEBJHVf7Q+AtWt7K15PdTc4P2jhOl7a+AcrydPS12rp8eEy1Ssh/gLOcfws/vqtJlnpg4ucBOJms1SuCGnIWBWaKzUqEPwA6gKgFX0QmJHvxJYJJTVeeoslcyMgvVDLdSAhtdywcdYGqMBLe1zUT+yCOPa3mrV8lyjbrUzobRJ45c6ZMBkGJfEKnA8XqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZHn+SvmZpadTBq8fX1ppytivY/1f8oJh/ajZ2+D6xU=;
 b=tavNKgRh4vq2a4Z4RmZb/s2u1/Q1UPs3QbpVvli2GsaOjRoHs8SG34xy+xB7Q4nRkR3xFWXUwQQkJl+Ql/Ipe139AqSm8l+K6WYq4f9TPDVD2E++edx8+Az65mj+Xj4wx51fccBBbh3LiHBgGxBZHGBRWzDrBXn8ioPDkXdLjtM=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by CO6PR02MB7825.namprd02.prod.outlook.com (2603:10b6:303:b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 08:49:26 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 08:49:26 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Index: AQHYe1aa0KIWTujVEEyCPx8mQaEs/q1F4U+AgADVmwCAAKAQgIABABHg
Date:   Fri, 10 Jun 2022 08:49:26 +0000
Message-ID: <BY5PR02MB6947C5B34801AD5F289127ABA5A69@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <a403b92d-00f1-885f-7d1b-0fce82b50993@xilinx.com>
 <20220609173201.GA519962@bhelgaas>
In-Reply-To: <20220609173201.GA519962@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 639ea556-293f-49b0-c732-08da4abe1fb2
x-ms-traffictypediagnostic: CO6PR02MB7825:EE_
x-microsoft-antispam-prvs: <CO6PR02MB78253EAFD9222B0F96B0CF4AA5A69@CO6PR02MB7825.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0SRVWgPvWEEMDW7kbgsqJg6N1DjtqhyuRSjBuYJVZXZQn6GNB3XgYPQ6Gh/kQFhyO3q2IPUc9Ral6OiWchnJer7lwMITFAEpC5x1U6lEPiHT0OPLPkD9sMiD3I3RuTRCU3JxWY4J6JJ170+G+X2caq3SNOclRHcGPDM7wFkx8IFcga59AR7uulYxSCQL/9jpvGIEDfCmQgepuCrFJDXZ77+bkMfoH5Ub0rYWh/OTC4MvdIlohRCK0nS457eK7rLAm0PXoIXoRbwsbRhjOfaJ8ilO1rR5+gPYtmmYqCkW0LhrzpRR0Zm6CkJOlW5Y3E+4XfjyaeNeGwUhj9S1ZuWyeief1IxwIi4M1cVzkaBRXtmCokuojS64OblNrPK1LLj41AGm7a6LZSvpnOr2BQ+TJfAW3XuoOeb0iEC22opXzir8a82WlhALbUs2qfSlvTpQxaxXiJ95xe8mf9lKY8xaY0x1CHFEwzFEcGVzQYc8nAo/ssd8+Pw/GYHhn2Xtmv1d5yrD6QCeQLGe+sKn7cwSPB/dJHKjsEpX3a/YqJXVcqrRmRZ/vWqrwRS2fD5Qt8FuMpRj5iO2mx62HPJgI46UmjmROdB8fOGNF+k3mIG3+CHyGPAjlO87+bepawiyL9NILjOI5hjXxotZW7w3ZYO9rJ71InSvqwJlEvbrKLRRaxPIuRvj84IY3fsS6qzSy0GN2agRGvrdXBBBbn0VZ5rsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(55016003)(52536014)(508600001)(122000001)(2906002)(71200400001)(38100700002)(38070700005)(86362001)(26005)(186003)(83380400001)(9686003)(66946007)(76116006)(4326008)(64756008)(8676002)(66476007)(54906003)(66556008)(6636002)(110136005)(55236004)(33656002)(53546011)(66446008)(7696005)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?COSiOlhZjddyprCzNkw6jg2JL2EBkUakLtKpMYPJgwh1mroD+ZbiX0jled1B?=
 =?us-ascii?Q?zAObWpivHmVi10DwMMv1MuZrMpbqx60efAjz6i5EPGstXixSg2kRepRnpzMW?=
 =?us-ascii?Q?ONrynQZQOvm1eVwYvxzBBaWIxJTygK5I9VOsCPeBu+vLnPG/nNLscX0D3+Rc?=
 =?us-ascii?Q?6pX6a1UErK4UBS+Xqfe6O2gO0LndfG1fp1zFLM1w1mRrDx0eoRZOU3suk9NZ?=
 =?us-ascii?Q?jHFhL/mN4sfcr9IgjwGRpqilKg2ZL8UVcnEKI3UjtcRAZ5ephf/9DyLPhxJA?=
 =?us-ascii?Q?LsFuN48eYYrf5Ulc9lZ9bPdBvYenCiApcFaK9iZHdOEub+W4LuQ6zx0y0RN/?=
 =?us-ascii?Q?zY8rNm5VOXQH8enVcK/IdTHne5J73AB2JxwacAP83jZh6fqyoW10IiIrHyZw?=
 =?us-ascii?Q?UcvaaLiHffDsp/D0oMe3lCJm+PNLjKA5sLJqi5hynxSKkRurBAMBuj5qnjgM?=
 =?us-ascii?Q?bW2Gxi5q1GM28Y35mzJYhUK1RQ99mZ0tojnnOWDzXk1b5jpdB0UzvAGJ3BPz?=
 =?us-ascii?Q?9WOSoGYRYJoc6eLiEH789GGpPPIvd3tGq+JI5axDw/NawQ1pNV92WTTBerRm?=
 =?us-ascii?Q?I1vZtNR9yW6aTjFwSvppVBTtAMukW4SMKeEnVt9PM7gnS/ukPyISdLn0grJD?=
 =?us-ascii?Q?eHdXaaWmMZz9QnA3jnRdIL25qGEEzBpoDkXVmsqqZOBAcWb3qrL2WRNylTkl?=
 =?us-ascii?Q?L1QiEnpErtsCUgyRuxtZ2eNLuygoNlM5hZ5B1RMMm0rQuL0FKSdRtqn/fojp?=
 =?us-ascii?Q?jcJBwH+t5UGVEGKRDXUyraqGCWFsxshaomnf/CGvER5zdLhURS5owb+YhmWs?=
 =?us-ascii?Q?bl4vHmsYKnMp9nY5oF0P4wewbRz+Qz2v1ulSdDQ41oC1esfxhCUExMaYRrhV?=
 =?us-ascii?Q?jS9aFL7E9CxhOcXsWAw6ELnkX7euhkaOw2UWxniSGRdCP9HMWSSPuODMTvSE?=
 =?us-ascii?Q?u8M8hM03JXDcFaOzv+U/SRXyl21N4CCP6AtTS6Z/8Ff9CkrtTvWiDcrybVsA?=
 =?us-ascii?Q?qkWetl/aCi512VHgGW6vaBHFBC/jnaLracbAov5VQpm9RugeaGo4n0b0Wm3K?=
 =?us-ascii?Q?qTvnNOhMMPFudMp1Hjye44Ik8kVNnHjOTEb5/c1cyXTaoXl+ntCqRxGGdw8T?=
 =?us-ascii?Q?fG2qW4E5WtcBAVJD8YnLckm1VlAsCxLLA1gmGKtfwwubtUxipVPthAqzT1zn?=
 =?us-ascii?Q?81J/tToMuTDPcuC6EyFa1bcbt1EUub+pRXabnzGYHHTo4T7KJuYtzCkdMBZr?=
 =?us-ascii?Q?4dFtXC7nePVG/jw22PsaNtwgGGy50n4Ls9zzKpekGWE1KXwtbgShcOOX4gNH?=
 =?us-ascii?Q?sLPy7qeBeXfc3yFNTxn3ISp7evIlhJ/xA7vDHIydFgoK0/TLNc9ZhWmrymc2?=
 =?us-ascii?Q?4VbPmSycDSBbWDx0FpEJb1ykJxJIHAS6MAXYdU7AvV1R61A6dMX44Et21OTr?=
 =?us-ascii?Q?huiinGwuzXk6Jzkc7kegGECxi/e2oMm52R57YRKropmPXz/0o2WODQMOD/cz?=
 =?us-ascii?Q?LRBLrt4uBAPIYR5H1/xaDlmz5ILwIreRiG3m1q7kH6/BujI+whK4wpDetk9/?=
 =?us-ascii?Q?dCAc4I2Wz0VuK/BAN3LfzbkhtBygnmY5HuAyBAN5px3TzXyOy9FjIvnOXWqJ?=
 =?us-ascii?Q?ZirWdCoUfNxLK9lCNQ7GOLV6AmSKPYQ1Tpad27G0aLSJGcml7P+z/JA6BrXw?=
 =?us-ascii?Q?/Q6KiSuh633aL6VWnBxibCVBpo+sazrnu6fejn2ll9I0Qvr2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639ea556-293f-49b0-c732-08da4abe1fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 08:49:26.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LD+xaf/fS74In74O6KelUhlvP+oIIN864R4izvXfrwritKpJSA5M72hprpqik1RrmM9J4dqhxZyDLrJzyMMwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7825
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> On Thu, Jun 09, 2022 at 09:59:08AM +0200, Michal Simek wrote:
> > On 6/8/22 21:14, Bjorn Helgaas wrote:
> > > On Wed, Jun 08, 2022 at 10:10:46PM +0530, Bharat Kumar Gogada wrote:
> > > > Xilinx Versal Premium series has CPM5 block which supports Root
> > > > Port functioning at Gen5 speed.
> > > >
> > > > Xilinx Versal CPM5 has few changes with existing CPM block.
> > > > - CPM5 has dedicated register space for control and status register=
s.
> > > > - CPM5 legacy interrupt handling needs additional register bit
> > > >    to enable and handle legacy interrupts.
> > > >
> > > > Signed-off-by: Bharat Kumar Gogada
> > > > <bharat.kumar.gogada@xilinx.com>
> > > > ---
> > > >   drivers/pci/controller/pcie-xilinx-cpm.c | 33
> +++++++++++++++++++++++-
> > > >   1 file changed, 32 insertions(+), 1 deletion(-)
> > >
> > > Per MAINTAINERS, xilinx-cpm lacks a maintainer.  Can we get one?
> >
> > Bharat should become maintainer for this driver.
> >
> > My fragment should cover xilinx things in general in case Bharat is
> > not available.
>=20
> Great!  Can one of you post a patch to show exactly what you have in mind=
?
>=20
Thanks,  will send patch.

Regards,
Bharat
