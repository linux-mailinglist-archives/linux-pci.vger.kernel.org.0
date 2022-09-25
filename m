Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956C65E91F0
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiIYJwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 05:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiIYJw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 05:52:29 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F86390;
        Sun, 25 Sep 2022 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1664099547; i=@lenovo.com;
        bh=xD5gZlwWsvZKmvkX23WnaL+7as7dzG+RLvZKtuqWmEw=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=YEblsgcuPU3YWGWVWCKRa/g8+gge+5ErxVmAfLmQn2lYS5w3IkPc4KCNQmr3/9kgt
         sLb2hjtHGDH/WKJN8c7V5PAhfINz7ki2fpshzHd653hLkciggIWrPJN93axSMtPIMS
         QGjYKuFG5GPvaYOsgcFUYhgqm9OwW+8/LkBHR01IHYIhirXq3iVp5U4B4dsqCjGy96
         sJF3SLLsul+kETm+5RlXLxhVWGDWA0xMrHcVrghJ4BTteZEfyAeDMWbnupoEdmxzID
         qpO+Th5CMzBSdDbV+tq+fkoN7Pya9p5I/1StCGUWMS/efgg00WV4ZNi6F1qvarxTwp
         JthJkEFPbwNxg==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjHeXvX9mCUnQXGa/khqVtkSktRY25
  zG8uSaffDDPhjcw6nVzjaLuUgvYK4aVKBGWyVEIMOKKvl14aMhdoN+SFQZKCUhbAAQcdWkR+T
  gMxFWWAg63btVcf+ee7zPN/v+9zzvnlfDBHXCiUYlW+g9DSpkwqCUE2ChJb9/LwiXVHRFELUF
  WiIy0VTCDFkHgeE8exjPjHaUSUghqw3BUT78DkhsVA4LSCK1otQYrQ6nvins034+jPK2oYyvt
  LmyFXWds7zlI7GMwLl7NgXPGW18QKitLpSlGaLB1UuOWKSAw/xtbQqO/8oX1NVVYHmfLkn33z
  WghpBgcIEgjCA1yOw3F0HuKSGD2sWiwVcYgfQvLbkU8S4lQdrLd/yucQN4C/GJdQEAjEBvh2W
  X18XejkMdwG4OPmq14Tg4zy40O7wCaF4Jpw6vSTgTGpYZl7zL9gJz8/0Ay+j+AvQdMeEeFmEH
  4am1VG+l8U4Db+2P/StDWT9zmK3rw7w5+DKYBPPywgeASdmL/kY4jis6xxGOA6H8zMev98AJ+
  abBVw9Go5cMgOOk+B6Z7mQ4wPw/NV7/noMbDw3hXK8BV6s+cPviYJ3b7f6zgjipUJYMlcIuOR
  3FLpvzPpdCmhd7vO7rDg0zl5HuVHjoe3aIwHHO+BX1feRUrCjcsMuKjfYKjfYKn0nswm6KmZR
  G0AbwV6VXqvWGLJIrU6WqFDIEhN3s99dssTdcvJTGSnPZWTHKMYg2yknjzFyimHkzPGsdF2Gn
  KYMDsDexQy9OqQNrJWsynvBZownDRe9OJGQLg5RZWcc15CM5og+V0cxvSAKw6RQdDFWkS7epK
  fUVH6mVsfe6CcyxIKlYaJShJVFTA6ZxWjVnDQIUrCxq11dCDbc7mTj3QEXG8ebbd0IdsHicSK
  Yo9vUg2BnnGwUo3Q2TUkiRL9J2Ua4t5Eml376mydvZwRES0JFICAgQBycQ+mztIb/6wsgAgPS
  UNHYVrZLsJY2PJ1mgR2Uxw76WkiCd1AD+Z8kMfKuzL0r39u9+YZdvuUDW1rzQUlXXs/K8n7Jn
  d7PHsTOSBfDjvb1NZOun9aSCxC8v91lCRqoFaRl0fV//vpSfLhN8kjV8djDeydl5d5bokn3ia
  buVpfM6ZmhWqbj4Jt/ZfMHdqH2qH7hiTe+i7STw+q2humAofaEj3XZc8vO9yb3OZn0zwc++uH
  A5LaS9+sb5yobIsSxw4XflBUnDbpXy8deOQjpvKW/j6Q+ME9PXCm2JKs6n70Wba6Tl3oi97d0
  FMV9/+HyjzWuk7aeocx4Y+utNWGCvkWVmrJnZlvr8sPxgFRQ8vbhwbSbkafvjxyKu1xV/smtU
  6e2vrzvpCqpJC/Gbr1NSFFGQyZuR/QM+S+2mrmVtgQAAA==
X-Env-Sender: lixc17@lenovo.com
X-Msg-Ref: server-2.tower-636.messagelabs.com!1664099543!290496!1
X-Originating-IP: [104.47.26.110]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15779 invoked from network); 25 Sep 2022 09:52:25 -0000
Received: from mail-sgaapc01lp2110.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.110)
  by server-2.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Sep 2022 09:52:25 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h64KybI/YxbRHdrKinUUy+292Y2z/z3SVDhxodNUzbnR+rD3DRdjuMAodD8UzLquMKSx0pZAxS8sA41FJslfPfPKAoD5THFwn9Zr9YK5M8GWARKKpcnypw6tN93iFQRYMQenM4DAkx2xRTco4A4+HKlf7NyMCYfjLT46aR4IIe8XPIwQchAtyIAccqGznYBXADtne/pqFgZzEcw5gWS+nH7Lr0YGtOOf0yLeq929c+9Crcg6aKrg5AYH+clG/J59skR56bMxDYB4thAM7O2eyvB2Nj0kYGYEDcWK7CX6GbNqKkgP71l/fMBj1LpvCWGDjfDak54K4RcYslF2Z33R8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD5gZlwWsvZKmvkX23WnaL+7as7dzG+RLvZKtuqWmEw=;
 b=M7EIgezM3PFyrCZSJgTOj+TNP/yykDkGbofVoIGpoZOno1bQDryKpdC0n/m0BqwsNYMMW/19v9vA51GFA84SEnTxhzHzk21qWtOjCvksgW2HHlSDjiqVagQPsO+8E1ud3o4qBSm4HFjvMYLV9IgMblsiOetwZgWzYk0BzuePvQPZ3CjVgVDuoT3giqYDUZsTxkM69RocVC8HEkcIgwbbIa2CjdWL5HHlWBcs1AzI8i8dGWTQqwEJ+b1XXV6nA9RrHbyzI/+YG1uNQROi47HBvl2oT+JumM3Pn9kxl9ZBD4BXiqX21sghxFfqd03QlYDu5IPl/Q1yKTcACU/3wXNoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by SI2PR03MB5831.apcprd03.prod.outlook.com (2603:1096:4:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.13; Sun, 25 Sep
 2022 09:52:21 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::193:69d7:60fb:774e]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::193:69d7:60fb:774e%3]) with mapi id 15.20.5676.013; Sun, 25 Sep 2022
 09:52:21 +0000
From:   Xiaochun XC17 Li <lixc17@lenovo.com>
To:     kernel test robot <lkp@intel.com>,
        Xiaochun Lee <lixiaochun.2888@163.com>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Topic: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Index: AQHYz2BIWx7Cgru9UkOHmlkYLatCTq3v5wzg
Date:   Sun, 25 Sep 2022 09:52:21 +0000
Message-ID: <SEYPR03MB68772E818ECCE020FEF785DBBC539@SEYPR03MB6877.apcprd03.prod.outlook.com>
References: <1663075485-20591-1-git-send-email-lixiaochun.2888@163.com>
 <202209240714.ronvmf1X-lkp@intel.com>
In-Reply-To: <202209240714.ronvmf1X-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6877:EE_|SI2PR03MB5831:EE_
x-ms-office365-filtering-correlation-id: 49690291-e6a8-4704-b0de-08da9edba412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3B6PEV4HkaTkd4fhg/Awi5CDyP1gJh72DNvHrKWymjhgxrufC+BSvDtf137PH54PeFPPY8XTPbP7U3GgdgQ/nobTS/G5D0DCZ5i4aCUT6dyTySCLBWwUZLxCAiePM/uViaudkOZ5iVZDCb3ulwNexj6cNYplPhOy4WAGadtrEqEtp08bnniKujCL15B57yuMI1O4OGHE8K9ANTy/kOKkwGz7+2U68xLIZrBTGfCYqOAMOTHNV12jsemISv/8Sd2PpMB8EH5kd1PMoKfy6vThWx48LM1PxQ3gVmCuS5lfZMKonpWjsY+Qah+1QZODi2YxKeZjOB1rnusa6/l3Xw8cACPtCih6IHlIkd76Ng8xYM2AD/Gbz5pP9GQ3fAgQCN/ji2hPNeu6u7cL/8/XMOyYOGjG2qa5CKnEp5jb/w84uMKzRdH5RiYc27GNE6jswioVykzoOUnGI/eCyIBCjqu5Rm3L87YpO45kOK7TU0ubmwjOLetQ1v50yp8xt+oMsmVDkaIke4Kk+tDdVWrrJiFS2VSAzxAJ9J60WDD2UARLPN/Vn/yK0fHViFETu5hkX/QWJbW5uZeNe7c1F9L0+GypMWn/TIaejXuatLWVLAHdRWNT1uGoZ8IT0AYrDWnbhE/XCeZMckM9hnJUSPp7tpgIkSkuvgMKla8XEZ/59LoKXKtCZ5G8RlJOmvRT9ZtTxwsn8xkGwoyzdPKamlnH6Khtb8y/9Qm1lQGbuXUdmRBQnW6PBUC2lmxQm760GTY4OPH5knKPKYeatb3EgJP1Z6Vt3VzRQPIqs2j+6AFmsXWVnj23cBr8IdiQeeRuOVJC4kMps3woSrNINhkFHQFu/qNkn9PSnIITLxWKf6GHSNmkqnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(33656002)(55016003)(38100700002)(122000001)(82960400001)(41300700001)(5660300002)(8676002)(38070700005)(66446008)(66476007)(66556008)(66946007)(4326008)(76116006)(7416002)(52536014)(8936002)(54906003)(86362001)(26005)(316002)(110136005)(45080400002)(966005)(9686003)(7696005)(6506007)(53546011)(71200400001)(83380400001)(2906002)(478600001)(64756008)(186003)(9126006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EgyYetiNmjW5u5UcO2n3E02xCWQkFJsrGdq/61FgzaMztzfpeAFfVcWH+9qC?=
 =?us-ascii?Q?K/bmFRsxhLifo2vL4eTakLD8V7mW5qf0ljBTqj/dcqLKZqa2der2n70zZcul?=
 =?us-ascii?Q?aXYbu1nww08/uB6UTeNkAei9lOpY7TOVIW5XoHCGj/UiJHqegzSCgkKgb41f?=
 =?us-ascii?Q?qa5iCRkIrNUvosPTvdxJFQKZKTsFwEKM80Qp9VFsQFlBbDgLqj6RmelOb1KO?=
 =?us-ascii?Q?D9D+1x+u7JLkCTsFDd4ILNvZifT9vvr+efuEtmXcvGO9EzrbYF75NMAybwFc?=
 =?us-ascii?Q?30HLtltX+nwMyICUFhXZS4rhw05HjSoFOAqAbaIkjzBZtb6bGmA4zAYas7RO?=
 =?us-ascii?Q?MePTL8iFvh3SEOLlft4ZTnrqpH1I/Ipj1BgwzZ6U9I4w3+dybFHGwCO3baqJ?=
 =?us-ascii?Q?saU1+Sgo/uRnmVDMCYubEmAM/lIby2Wqwv4YgvSA47kPsb2UD+k3SjlL1ntp?=
 =?us-ascii?Q?yhj4/uWZfg6aaxqfn1KlK3R4IFcYvruaWKoA/Hp+avsxAiSUlgjicBrP0fzm?=
 =?us-ascii?Q?khPFBGEgDpSUorTfZOcSfTFrj6D0q3ocDwgkvMheVyTfJtPNjfj1dyUzQEzs?=
 =?us-ascii?Q?aaIRqy8TBPysdGRMYJpC+cBZ+IUdIvXTP5M4qTiJL44eM5U6p2EyTVaiKwKh?=
 =?us-ascii?Q?slqhQcbmZrvFxRzN0nnmKyRsvKKaxg8EQ3rkqeRssyCPBojHBziWd9t6rJRn?=
 =?us-ascii?Q?/Ag2/EK2shv9PTekP+bD4GsDkvtk3gkdlC/DdP1Hq0eCrZvr5ZwGGqsJPN2J?=
 =?us-ascii?Q?YsNzmAQvi+RPvn7VSNQNgFha6GeVgscETIpV7LfOxpOwR9PlsuS5HWZWyLgc?=
 =?us-ascii?Q?2WDCtHA1+Wf3V17N8Z4GilAuiuo57/CEl5Ju1VaT7oRjnYT+jU/FmcdfdUuK?=
 =?us-ascii?Q?ogNyQ+JjWDx7/fVP3Ub1hpVHvU8Vv6/PdIN7AZVphIVMEKpF75U754RSuey2?=
 =?us-ascii?Q?0xwnBonCpnFBEd9AUyz7P6YsA9qTUBD2e3Oce/xcEXZd81vXshYuZCjB3M2J?=
 =?us-ascii?Q?ZCEUX6d4a7DNIFspvuWM7sJS3Clu6jPM9TqABqsCpihuux6MgZTbKZLE+Cu6?=
 =?us-ascii?Q?ChBd6WVfgU9QcCd9l1U2oNTK9n2jawukZvzrQfMR0jH37K1bvnNbeA+lnAvx?=
 =?us-ascii?Q?5KAGZ98XgPJ+YgYD9LrPFZNHgUpR5BPxbC/zLZZyPawNmBtQbkI+PaIRQopo?=
 =?us-ascii?Q?CYg6wgdxpPapUBtOmnSBwBDgLltjzBO8G3/2fiG97rzLRDVKJU7Tr4uq8DTz?=
 =?us-ascii?Q?+GcDk4ZS4mRW8eqZaRfrlJR2x86nqg0A3K9ApVTifajV0peIJqtthsCsZ0o3?=
 =?us-ascii?Q?4eaqbVQwlP053prAfcokssHIg2cgJ6R6SrwZGZUmv1DHjDda7Ryd8MKURhr+?=
 =?us-ascii?Q?VsKsuG1IkhhEvinDt30V1J4ShL0EaP2LA6+EAsMMNebfE3EdhjnlG3nc7Unu?=
 =?us-ascii?Q?JCOfooG2ec/q3cu1yqVUzPDLKZoQrRR2+B78sH7ZLoZuiFRgbBHXgBRvHOVf?=
 =?us-ascii?Q?oDWroGBc25Ssa2DN4vhtg8aUq6GPUds1c+SxonCkd3fQ5QskWGQDkDxWONlH?=
 =?us-ascii?Q?ZRpO0sWkGZMBN6ff05Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49690291-e6a8-4704-b0de-08da9edba412
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2022 09:52:21.3905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wre+P3+8Pw0vLhO8nTQT+22qMtzcbGjlkAqga6MefIH5Fk3Fw0KhAKODtPhZqS2kun6rINpOgZKHRz33xjVV0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5831
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Friday, September 23, 2022 11:21 PM
> To: Xiaochun Lee <lixiaochun.2888@163.com>;
> nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev
> Cc: kbuild-all@lists.01.org; lpieralisi@kernel.org; robh@kernel.org;
> kw@linux.com; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Xiaochun XC17 Li <lixc17@lenovo.com>
> Subject: [External] Re: [PATCH v1] PCI: Set no io resource for bridges th=
at
> behind VMD controller
>=20
> Hi Xiaochun,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on helgaas-pci/next] [also build test ERROR on
> linus/master v6.0-rc6 next-20220923] [If your patch is applied to the wro=
ng
> git tree, kindly drop us a note.
Hi, thanks for your reply, this patch is only expected to be applied
on x86 or x64, actually function "is_vmd()" is just defined in
arch/x86/include/asm/pci.h, do we need to support it on arch um?

> And when submitting patch, we suggest to use '--base' as documented in
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit-
> scm.com%2Fdocs%2Fgit-format-
> patch%23_base_tree_information&amp;data=3D05%7C01%7Clixc17%40lenov
> o.com%7C63bd7990b33f4dd9b4bc08da9d77696c%7C5c7d0b28bdf8410caa9
> 34df372b16203%7C0%7C0%7C637995433448231363%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DTGZ2LnHsHCrJLW7WBBMZ
> lFxv8SIaQNmCGC1bEv2BEDE%3D&amp;reserved=3D0]
>=20
> url:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FXiaochun-Lee%2FPCI-Set-
> no-io-resource-for-bridges-that-behind-VMD-controller%2F20220913-
> 213745&amp;data=3D05%7C01%7Clixc17%40lenovo.com%7C63bd7990b33f4d
> d9b4bc08da9d77696c%7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0
> %7C637995433448231363%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3D3NULvkgYg0fWTopgYY5EYHsLIBPdTEcMxbz5Tj12D0E%
> 3D&amp;reserved=3D0
> base:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhelgaas%2Fpci.git&a
> mp;data=3D05%7C01%7Clixc17%40lenovo.com%7C63bd7990b33f4dd9b4bc08
> da9d77696c%7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0%7C63799
> 5433448231363%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> mp;sdata=3DZTZ7kKlwOk7IB3MN0rRwqHaNGGl4OiwrR7AjImBbTqc%3D&amp;
> reserved=3D0 next
> config: um-allmodconfig
> (https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdow
> nload.01.org%2F0day-
> ci%2Farchive%2F20220924%2F202209240714.ronvmf1X-
> lkp%40intel.com%2Fconfig&amp;data=3D05%7C01%7Clixc17%40lenovo.com%
> 7C63bd7990b33f4dd9b4bc08da9d77696c%7C5c7d0b28bdf8410caa934df372
> b16203%7C0%7C0%7C637995433448231363%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&amp;sdata=3D6xMM7Fh9bKGnzBlmeu8kki3yvGGQ
> 2k%2FKCp%2BqvoLt4zU%3D&amp;reserved=3D0)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0 reproduce (this is a W=3D1 buil=
d):
>         #
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fintel-lab-
> lkp%2Flinux%2Fcommit%2Ff97a8ba561d7cf5a755c8f42421138e8b1073cf9&
> amp;data=3D05%7C01%7Clixc17%40lenovo.com%7C63bd7990b33f4dd9b4bc0
> 8da9d77696c%7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0%7C6379
> 95433448387557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> amp;sdata=3D4mjCA86AEbwN9eIiw1%2BLUPlf0%2BV2juqoDo7ojKSMweY%3D
> &amp;reserved=3D0
>         git remote add linux-review
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fintel-lab-
> lkp%2Flinux&amp;data=3D05%7C01%7Clixc17%40lenovo.com%7C63bd7990b3
> 3f4dd9b4bc08da9d77696c%7C5c7d0b28bdf8410caa934df372b16203%7C0%
> 7C0%7C637995433448387557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&amp;sdata=3DYusFni1tvPN89d2e%2B8yADL3jbwjuydLs0RD3NSjj
> 2MA%3D&amp;reserved=3D0
>         git fetch --no-tags linux-review Xiaochun-Lee/PCI-Set-no-io-resou=
rce-
> for-bridges-that-behind-VMD-controller/20220913-213745
>         git checkout f97a8ba561d7cf5a755c8f42421138e8b1073cf9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dum SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/pci/quirks.c: In function 'quirk_vmd_no_iosize':
> >> drivers/pci/quirks.c:5985:13: error: implicit declaration of function
> >> 'is_vmd' [-Werror=3Dimplicit-function-declaration]
>     5985 |         if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) =
{
>          |             ^~~~~~
>    cc1: some warnings being treated as errors
>=20
>=20
> vim +/is_vmd +5985 drivers/pci/quirks.c
>=20
>   5959
>   5960	#if defined(CONFIG_X86_64) || defined(CONFIG_X86)
>   5961	/*
>   5962	 * VMD-enabled root ports use Enhanced Configuration Access
> Mechanism (ECAM)
>   5963	 * access PCI Express configuration space, and offer VMD_CFGBAR
> as
>   5964	 * base of PCI Express configuration space for the bridges behind =
it.
>   5965	 * The configuration space includes IO resources, but these IO
>   5966	 * resources are not actually used on X86, especially the NVMes as
>   5967	 * device connnected on this hot plug bridges, and it can result
>   5968	 * in BAR#13 assign IO resource failed. So we clear IO resources
>   5969	 * by setting an IO base value greater than limit to these bridges=
.
>   5970	 * Hence, append kernel parameter "pci=3Dhpiosize=3D0KB" can avoid
>   5971	 * this BAR#13 failed messages show out.
>   5972	 */
>   5973	static void quirk_vmd_no_iosize(struct pci_dev *bridge)
>   5974	{
>   5975		u8 io_base_lo, io_limit_lo;
>   5976		u16 io_low;
>   5977		u32 io_upper16;
>   5978		unsigned long io_mask,  base, limit;
>   5979
>   5980		io_mask =3D PCI_IO_RANGE_MASK;
>   5981		if (bridge->io_window_1k)
>   5982			io_mask =3D PCI_IO_1K_RANGE_MASK;
>   5983
>   5984		/* VMD Domain */
> > 5985		if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) {
>=20
> --
> 0-DAY CI Kernel Test Service
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F01.or
> g%2Flkp&amp;data=3D05%7C01%7Clixc17%40lenovo.com%7C63bd7990b33f4
> dd9b4bc08da9d77696c%7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0
> %7C637995433448387557%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3D4qYtyE86mw9VyFbB3QKJqtldq6relV2Cunv9STAmmqA
> %3D&amp;reserved=3D0
