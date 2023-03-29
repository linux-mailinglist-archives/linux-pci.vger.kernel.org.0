Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8065A6CEFB3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjC2Qqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2Qql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 12:46:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B32D55;
        Wed, 29 Mar 2023 09:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi+PTXxEeWJDSivFlKwl1rGlSrpbOP0kNX0MC3hL8LpkfC8/kmCjkh9Y9T7l0yIbrM6l460M+jS5vhnFhu0DymnH45AUxl/LglXIEczX1VucLvCjn2aR4F1I0eQW2smOdOXatbYkGpLQi0ILduuawDtf2Kbp5nqBoDTCFFjWhntEcxj7K63/NOj2JWavqZXbh/210hhpjRjKdgo3wRt+Ktqpr3dP7XSUuvDFzw3wOzd0fD+axYuWYHpvimaSo5in5cyvkXEAxV/T0/gyA6fLMaJRKyRkbgl7cihqhVFHZH2T1JOkBBjSTk2iwmzyezZ4EDMRuvUMD0NDHLTYdOWGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ0HF02JpTI1eRc9vD569lbpgElWyA3vpRJd8BZaq9g=;
 b=ETjM8qNOTVx5VZg8iFD5A6/x0DY1uAV7N+30q1XSfykYZtF+cDXePxjKjEktIuE+zjVWa8PU23Im/jbKwllDHB2XuYEBKIfyl18MMnXazXQRFnGi8KDuK+jp+qe3dpV7WD6eVXPJ2yX1ZMXXi1pLEuItr6GDIVzBXb5mcck5wqdmw316YAUO4e7TtDXJql3j4Jo9HKAb7AXOF4BpyEp1F/PWfzM8kdXjSJk07XsQ1rmmRryCVRum29BMtfKdjBXDcUgv7mpmPv7kHhEj6quCITCvmrrN3ouD6ccVeCSSIikjhTD0b86UUYOY8hyTduJ0/21xP+pHEulX6x/0oaXDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ0HF02JpTI1eRc9vD569lbpgElWyA3vpRJd8BZaq9g=;
 b=nrpFk2lumgc9Yar6HA7r2JH1L7f4Ao3DfiaCM4W6PHy1gVOGBgl2tTfrRip/mo6ocqWqcyPL3WaNvOdhPscBEeqY1k/wU8uT8IbPe2908azyi98QYqDdWqKV1YfxExHVUl80MhFkgOXCiwvKCY9ySc7eb8trk80AHu0XiXVC67M=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 16:46:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.034; Wed, 29 Mar 2023
 16:46:33 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Thread-Topic: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
Thread-Index: AQHZN7bpBm+5RmnRNEW5Iyx9WPW3za69bfSAgAXgoQCAAFlCIIAKMSSAgERzOmA=
Date:   Wed, 29 Mar 2023 16:46:33 +0000
Message-ID: <AM6PR04MB483881DFA2C35F02011FE74D88899@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331EAFF5684D60EC565433688D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjDDEK0NB=BWh00-HGU-p+sC=8TyP-oPdccnZxKxZt9w@mail.gmail.com>
 <HE1PR0401MB2331A8D5C791C34D9C39A62688DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp>
In-Reply-To: <796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB9351:EE_
x-ms-office365-filtering-correlation-id: 2452a26c-4f26-45ab-089c-08db30752793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLWvan4D3RtUGjttrj2cil6cTKS5T/rggKF3G8dL6ycIEhNCipVkYFsGzKPYJIoArBlQbw1Zmiu4OkbKakl4ILEXAtl8AR8dOy/n/iB9ejbwL2miRq/raRhqEuqP/uSJKGun+RzbyrkUxdTLdX1/Q+qUXYQvvVfUSDu0hxu+79IryXROoNAvYDmd2i9sOHtq/ifVbrzZkehNila0l2e2criiU4pYHfqYCR7jHSO7wQXX4JdHb9C5VWXZabAoUA3w+2DMe30XMgAlx2LGK9oW2P0I/IfAsf0aydLyRtvEGS29T9TpFkG9hghleg/XKKUcaT4THeQ7DjMpgW0yWf2DRbb3iY4c0G4mp97WCMKENvSER29crkUQdnPFHcNKFnJf30M0cfy+1ZIKcsUT9zP3hvql9T2TOf7ZTkjY9H+jjjLFg6Ja3gFXQNBy3uOTHi7/Q9uqlDMmMoU+QGu+em3aBN4VuCjmqwHdIy4zOkjNo8Kt1d+iFBEkVEMkdCCuob650EIbr7uaW7HBqrcgg2SyGZBoq0sn6NIwbvFGcfw1ugoDWvZGUVMizfZCl3S/RJRnmj9GJ7GSsjdS0Zls6payCjiWycIQ+VqDGVBqMhtUKOdX0aMGXJtSGPxzZfqKsJF1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(558084003)(86362001)(38070700005)(122000001)(5660300002)(55236004)(186003)(53546011)(83380400001)(33656002)(9686003)(26005)(6506007)(44832011)(7416002)(52536014)(8936002)(41300700001)(55016003)(71200400001)(76116006)(4326008)(7696005)(6916009)(66556008)(8676002)(2906002)(38100700002)(54906003)(66946007)(316002)(66446008)(66476007)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?JdhVldSVsA/h4GCnYCa1D3nc1R96TTMkK0MNgcbCFEZF+BCXBCtxTnj8Lo?=
 =?iso-8859-2?Q?qve1hNLpz9Ltzgn/n/RCBb+BmAqx46O55EHN5C+amWp+3qO8KK7GAOLznT?=
 =?iso-8859-2?Q?LEVrZm6glYcjIJnvk2fUJOEaMeF9pxOsbfoveYtIzLwUSwsiMBvSfdcJ/w?=
 =?iso-8859-2?Q?fsw0NnYiLi2e3zDdHjGuxVclK8Jr+9dsfHt6+Ilk8LVWbeF4fj3dFmp4Dn?=
 =?iso-8859-2?Q?7CX3Bp7sta2itTdjBLaROl74Ql1aEWvTvrTfEiIdgd8qV0RQgGrRmEWQ2J?=
 =?iso-8859-2?Q?CA/nbvahmlFWV1tpgTjHO370Qh6GYZ8gTzza7H4X7UtzkKAeSOZJYiXORm?=
 =?iso-8859-2?Q?NzIZiM6SnRC/GPElvsq6i9RJbwXRIyyuLHXosIJvM+SLAGlpjzw0ItvroA?=
 =?iso-8859-2?Q?KYvUbCVHjHnd1rzndB3PIWfiHDRNWT586ncmdnY61z4xAhtoPq3k+bHYsQ?=
 =?iso-8859-2?Q?1nBUd/VMhXxWkMa9Cb7oMr3EkkDeniit9QqsHBUmmNlnlmxTkBf/4RyY/W?=
 =?iso-8859-2?Q?JP5dV3TloCvjxnFk4RQr0uX8T3mkG66SHG2+mvBBdyXuWYTZXSghASpxk5?=
 =?iso-8859-2?Q?AcW+a/Gme5XEkbu0JCUh4OihMTuh+Dgu71OO4V8OXaHxE8b4+EKyzyPURF?=
 =?iso-8859-2?Q?QtHAH2U3dO7IW/PgvXKmlDMFEOm8y7qjhwix8UyILgWF9j6t6z3BuF4tQi?=
 =?iso-8859-2?Q?CRqGldLVzmpZyRAkzZJE70NrD1emETpy85iS1GvbZQy+mcmE6288dW4uXd?=
 =?iso-8859-2?Q?blnDJbusWcUCC9rWlhPoQ1/ybVMH16A/VHX69e96i5i9109BIAq8TWfGT5?=
 =?iso-8859-2?Q?mrmOcZnPODcjIq+HdW4FA4O2v8gnp8maJamlY2PDH8U/q34MXXRXlSss63?=
 =?iso-8859-2?Q?FwbViyIlNqDw5orhwPtZ7bpvWQ1mtstAqGN69G0W1gGWQqDWYCUQ6QBGtD?=
 =?iso-8859-2?Q?phl93AmRFjzg7tBAViQ2Z22z7HHLvDdl5ZOo+1TyEMPEy17R8CG8uY2st8?=
 =?iso-8859-2?Q?jUsEnjXMgiYwENasy+3KFG/Qw+k88bTgDcM8WjdSI7knQOWc2K2vgWRZJ2?=
 =?iso-8859-2?Q?5Q+j5/UOAZH/uBDpT5yRysln+SOUh/Oe74OM0kgUnWRoyXiaxdHrzvOH9k?=
 =?iso-8859-2?Q?g+1CukepH2SRPy0hpUICt6Tse1qTcJYuOGnz2XBFFDdpgDYelOGcq222md?=
 =?iso-8859-2?Q?hgi8+i+omcd9NRvQuH9hE1hNE/j8GOlOeSLqKVd6uGUXCTt5GBmS9AVyAJ?=
 =?iso-8859-2?Q?Q6iWd1tJ5OdWokY+U+LfTpaeUVcFtyHMB9Xo24THCcCtHET+XxMBKxranB?=
 =?iso-8859-2?Q?ns2DrSyic/7AknywXSfuHKyX4L50IxfmlTbfAXPqzjfAQ3hbl0X9+e3Wkp?=
 =?iso-8859-2?Q?yEtd6dMDj/o44y9NHuKHoempQ2vtTJ9XPUr5PfJ9uKag9jZ0XPiNPT3hPp?=
 =?iso-8859-2?Q?m9oSPvsM/3MP5+19I2d10zRHE1cdaKonZ/5PCKp1MIF1NEPrZGf2eP2SNU?=
 =?iso-8859-2?Q?wCck0TXO2lQkBXGlBZtmA7FPlVYPLsi9Ot/CkG6CpY4CZ5VvBnl/QXVPuE?=
 =?iso-8859-2?Q?slEbqLGoXlbkmKIWIBEAau4BVKqoB8qwoi9i0jejFsSEx2FJDSYkfIm6cg?=
 =?iso-8859-2?Q?qATc8v6cHMfhk=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2452a26c-4f26-45ab-089c-08db30752793
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 16:46:33.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUKHH2uje2OPd2UronKofHczEVrA2uev1KXLj68jZsls9/CFF0ohRuQKnw7hLqv3lxfhSTA7Zp81ev18/VATsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


>=20
> On 2023/02/08 1:02, Frank Li wrote:

Did you have chance to improve this?=20

Best regards
Frank Li=20
