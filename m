Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADF5EB7D4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 04:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiI0Ckr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiI0Ckq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 22:40:46 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C89C996F;
        Mon, 26 Sep 2022 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1664246444; i=@lenovo.com;
        bh=sD5ilzhIXxfoU+8ao5WlIF2ighjLkpC5RwRQmburb84=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=xPTGbBk8kDq83RK2Ge0PhaE4mW1HIH1KcQ1HZfsTApiWvZKzPSrvOCIe0Y/6qn6HC
         pXyPVji/hQu30Gvqz9//mO1JH8lDAAinRkxQ7g4bj2dA6xtmCd4ORBfE1mS86bslih
         ZNoVu9vO+6AA/Guu/PU1vjvP2Cep1Uv4CH2G6QTCFT/pd0QPdyHkHUcvIW887cTTg4
         qQ6dt6jM4jJncZOQAL0AzKDd2cEVZgxj0rsW8sYdRFLzIPWcjBvs+EK7LsgTahJO9H
         SNl9poaLcm/NT1RhKui9hEbNeSwCxknYSnBRqErbHAyCMGkm/26FrmdY9LJVpE99bj
         CNGVHLjUnw/rA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELsWRWlGSWpSXmKPExsWSoS+Vobs6ySj
  ZYMcHJoslTRkWr86sZbNY2fKQ2eJs9zVGi4ae36wWl3fNYbM4O+84m8XO873sFq+aH7FZtPxp
  YbG4vFDH4v+eHewOPB6LV0xh9ViwqdRj8Z6XTB6bVnWyeTy5Mp3JY2HDVGaPeScDPbpn/2Px+
  LxJLoAzijUzLym/IoE1Y+LXyywFy8Ur/nfvYWpgnCHSxcjFwSiwlFni+KslbBDOIlaJi/ObGC
  GcDYwS3b8+gzlCAvOZJKZP38gO4dxllDjUOYW1i5GTg01AS2LGwT9ACQ4OEQE1ia72UJAaZoG
  5LBKtD+azg9QIC6RJPGz7zAZiiwikS0zp/sUOYTtJHP48gwnEZhFQlZh+7T5YDa9ArETThGYm
  iGVNjBI/Hm8EW8YpYCDRfn0iI4jNKCAm8f3UGrBmZgFxiVtP5oPZEgICEkv2nGeGsEUlXj7+x
  wpRXyJx6+V6Noi4rMSl+d2MELa9xPT9M6FsX4lLM3tYIGw5iVW9D6FseYlpi96zQ9gyEg9ubA
  cHmITAEnaJwx3PmCCcRywSF+e0QG0wkJj37QhU1TwBiZ1zt7JBnKojsWD3JyhbW2LZwtfMExi
  1ZyH5YhaSsllIymaBg0ZQ4uTMJywLGFlWMVonFWWmZ5TkJmbm6BoaGOgaGprompnqGloa6yVW
  6SbqlRbrpiYWl+ga6SWWF+ulFhfrFVfmJuek6OWllmxiBCbIlCLHgzsYD636qXeIUZKDSUmUV
  z3IKFmILyk/pTIjsTgjvqg0J7X4EKMMB4eSBK9VFFBOsCg1PbUiLTMHmKxh0hIcPEoivPpxQG
  ne4oLE3OLMdIjUKUZvjivb9u5l5ji/cz+QfHDiJJA8fe0KkLy2fsE+Zo6ps//tZxZiycvPS5U
  S562PBxohADIiozQPbgEs61xilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMyrBHIIT2ZeCdwd
  r4BOZAI60Y5PH+TEkkSElFQDk7W244Gn1gdyZ36N7tuWKmiT+6zq75dgIc+zlwRVVrls275jf
  ooKY8lZ8YY+ucnLl1VtVtypr/GFJ9Oia9GJyPgzFYrhJvXP4zl2d87kCN5pYdvFz8HtNiH8Jp
  /j2SeHu9zXT22y7NAsuxc97/b5PP2t60y12DsXd39bo9u1ePGhIz/efygryKv23Hu3N8OIW5y
  3uH2N7uL9dvzMXGFTf3p0Hntxzv2IntrlKq6k0unL1dP5XO++uPxv4Y1NPwpPPPT9P+frd/bU
  82I3/Art03mKMn4/vPFG60kZzwduUd1SqTCPRsuijrcLet6a6Lru4ToTbPtt/3n7KBfZZ0U+A
  pJsExu63r7c87D1t8FVJZbijERDLeai4kQAFYzBv7UEAAA=
X-Env-Sender: lixc17@lenovo.com
X-Msg-Ref: server-7.tower-715.messagelabs.com!1664246441!87771!1
X-Originating-IP: [104.47.26.104]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20390 invoked from network); 27 Sep 2022 02:40:42 -0000
Received: from mail-sgaapc01lp2104.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.104)
  by server-7.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Sep 2022 02:40:42 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUVo66ZtJRD/v1ZD07u7nKP1ZOYTpc35/7ufQ0AjaAxWY4ozSb3tJ184ooqld9/rxUiMXFGyssb5/3VnUGCdgdn7vUs0lQ5j4hFN4zVTZcw6LAvaBLmuGy0rFt4T932zVPWfkS0N86e4X422+ApRRxw+jlnC1HH+YeiZLe29jRaRiKDO/LGCwiNquP3iuhHYoionP7HMS3xZX29JI30aGxK310SnzXP6cDo0dftRamW0SIMKA5j4/isfajQxQ/1JpnCahl24+r9D9sjG4MBE7gme2oFq9573fDpNrmsNiVueZdcln8N6q53uGwyJJoG5ywb9DptJ6fnyg0i17rU0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD5ilzhIXxfoU+8ao5WlIF2ighjLkpC5RwRQmburb84=;
 b=nM2pegiI2qZr0A3o0PRH2uBVKZbsXmH3igLblb3Oan1oXzmrN4W1NQBZAbnk/fG/ocluu+XvRcF/sxX5Ac5uS4/EPFYaVuohpWNuNSXR8bi/GQM8jVj9Q5CJVxMCTAB2je8PSYm04yFKGP6ueoYHiSLM8xBAbXOLFjaG9cu9CWt/iq1f69qpM3qlNrE2Fi+adJ0K/3vrZpAzvbtrb62BURK0xMY0qmbwK3RNei9mQS69gnmPoSaeYUpRp25DEYe5tct0LqHCKGqujGQIaTumD7DWjTMZrxXiy3fw7ZSQRBAZEtrxO5Ulv7e4GsDxvvuCGOsTGal+c99ElaCcrkZn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com (2603:1096:101:b8::14)
 by TY2PR03MB3615.apcprd03.prod.outlook.com (2603:1096:404:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 02:40:39 +0000
Received: from SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::193:69d7:60fb:774e]) by SEYPR03MB6877.apcprd03.prod.outlook.com
 ([fe80::193:69d7:60fb:774e%3]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 02:40:39 +0000
From:   Xiaochun XC17 Li <lixc17@lenovo.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Xiaochun Lee <lixiaochun.2888@163.com>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Topic: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Thread-Index: AQHYz2BIWx7Cgru9UkOHmlkYLatCTq3v5wzggAA20gCAAmp/EA==
Date:   Tue, 27 Sep 2022 02:40:39 +0000
Message-ID: <SEYPR03MB6877EF05F0F1320B6EE0B9F9BC559@SEYPR03MB6877.apcprd03.prod.outlook.com>
References: <SEYPR03MB68772E818ECCE020FEF785DBBC539@SEYPR03MB6877.apcprd03.prod.outlook.com>
 <20220925125704.GA1529068@bhelgaas>
In-Reply-To: <20220925125704.GA1529068@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6877:EE_|TY2PR03MB3615:EE_
x-ms-office365-filtering-correlation-id: 94fac486-c6ea-4753-255c-08daa031aa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZ13PCrEtJQbCjiTBL3CWTEaf8vGI4S9WMid5TRPk5yeZD221eK57XWXuM23TC/t8ak+TTg9g/urQfYDF9eXxMFWobCqeW+oK+IzLGfewnS3U5v162RRHe0/P7wtNtqJmIxzGWRi9V/UHnoIwozrtWh8FP9hv7XoCW+QxLEC5Ai3Icvs5SfG1gpYzKPZ+aCaZjEOx1taHD47jzQG7gEm1zdsjlTeigEU6vg8wLCnjPzRrEtdEWf67bIEmbO8/2tdo/uE4qIadlrcoLFJGhfKCIsfAxRlLQr6v2q5NIUeV6SckPQ08lhiG5OOz/FYAo0bbkiQlVO3tuUVl1mo3Mm/15vM+OWZ0O+FQR1VdPE1ADehwLKh2+RIxauMXC/nnFc5ge34Wj4GnUnxIVaXVO10m3HlANnO+GwcDf2d1DueHppGi1zTep/jpdu7WjSwrFcVAO4Gk+Oa2D2RrxiB3+HTXkpoyPHYOmjVU6R5dVo+aOvabx7Kdd95gVCwkx22MMCRV5dm8D8jgsd+2EWg7VDKJP3qX8rQsbC6qTdYruDqMTd28LAjB7UucrDz9Fis2xkbQIG3VEwybup4a134hZdM3RSrIKwwYu8qsvU411uQDsNBcejo4YfAfRNOKGEttrwB+cObsavlsnN58wsFSAhB+k5n/a5J6zwLSyOjQT12u/OY5MHfhh4zvh7ORNrNxpfrItwfdmu+a2A/Czqqpby6RJRmqiPqoTSuUCb741WjGofLv0qOmiAiOfGz6CjDwNZmCr+h/7luqmbQyg0SUCZOsbMol+IFnHtFLVQNn9b7L/h9h/GBwrA5tXoh9VFaRjM4G2ovinUTjvCpOoRQMMheII+22TFMbg0FOXE1sMHDaZQjdAehle8kMHEgAgik7+n5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(966005)(316002)(6916009)(55016003)(478600001)(45080400002)(33656002)(82960400001)(38100700002)(122000001)(83380400001)(5660300002)(38070700005)(186003)(86362001)(71200400001)(7696005)(9686003)(6506007)(26005)(54906003)(53546011)(76116006)(64756008)(4326008)(52536014)(41300700001)(8936002)(7416002)(66476007)(66446008)(2906002)(66946007)(8676002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/pUUmIQ2vU8Z17JAYSEUrBfPchSSHSd6xH1tMpxL4QRh3i2k776Be0KQ9X9N?=
 =?us-ascii?Q?APqtgiRRdyDPKZH0n0bQR3hurqXqi4PiwrUO1RToEK01wDRlQuN6JmSIMJoa?=
 =?us-ascii?Q?c4KXkrT4QcqPfkVkXoEUksdWKgVMhWn7PrK+c5zBIecC9lWib3dce73h3ONY?=
 =?us-ascii?Q?iVxy6rscuTdRuO89RC2Emcmz+BrKJkk0v1b1Uxo7oQF0OneDzx+a3YjvnN5y?=
 =?us-ascii?Q?RpaNfS9UukNA9xw4L3IdL5RsqaHS/im9YWQCHImP5wwjJMIKLIxyyx8Plc/P?=
 =?us-ascii?Q?1RKh2GflOr9OLdOh7rqqD9i5wmba1hudsfyn7qfUFpKDBjL+lbzUB5ypB5gD?=
 =?us-ascii?Q?Jt6IKNsScYeF3+ruu9ATOpAu+P5jsxITEhab2VZSgb3LNQCCcL2WRStuTBLw?=
 =?us-ascii?Q?hJpFyQ9jzdbbsQC1tFQPiYDe1C8aKz9HBizwwLREiGoR1XQVzLg3r9fd7dxS?=
 =?us-ascii?Q?qL1QDb/mMNzd2XurXkQIyVUwtIjcba/dooKH6ZdVKIOsBwrxBGtvhly/vQRK?=
 =?us-ascii?Q?cJzP0LIRj9i+p1SQZfcbDSzkcB2KNeYTHc75aKZ59hXLl2vNEMDjCi7Za0i+?=
 =?us-ascii?Q?0BIxfpxc7Bfs05XPpn0DMsotYrOOHuj5AEpEzEHPoVnNFAFFPSQITPpzWBVr?=
 =?us-ascii?Q?s+Kwf+6QZKNQ3c8ckFsbmmtbk4oSgo+BFqBfxVA/WOGULY/D6LoSQ+Y0zOmI?=
 =?us-ascii?Q?KWNL08QqSrvnoxWz7/Mz6DRhNhnAKDjD/7SVUo/y58a3L4R7wuKOwhP7KZAg?=
 =?us-ascii?Q?bVByrv8qQ2DmyELEbJ3k+u4xBRn685fedoRdZ0PKtyzopaJ94P0WM40JSB6K?=
 =?us-ascii?Q?IGM+zXOJsl3TWytV0idZLFVX67CC1Y4zSzBqFxwMe9cEAtVTeYfCsUrhvU5U?=
 =?us-ascii?Q?Ul1gVJCCnZyrxEHDa+C7S2ROHjvE24/gH4BzFH7bEhF79pgiSZPuSKFda559?=
 =?us-ascii?Q?J3B/3eUCRVRzxlHZ8J85gMzYiAAP3fu6ZlxLhNrKB26p77Pg92W6weYTC6AW?=
 =?us-ascii?Q?zYsOJkFu/EWRRwUBDAo4LQ7NFRxEK/H0xGB9Aju19rqpdRYDqvzVamrzNVNU?=
 =?us-ascii?Q?2zpoeJ7KBmqirEXzd4gacO01ibRpEzYX0a09u6besKKJbq/Q3ltj2vAbw0wa?=
 =?us-ascii?Q?L9S32wf4G/AaVe/WjeFIHdWftR3K5e/jF+bGcg/LxiSE17F877vPdeuCvr0R?=
 =?us-ascii?Q?1t39PQV3cwQhRLuZdkJMMNqAjeGBuMu/lGuAQmZXkeR7Jzas7VjjCXgLBKJu?=
 =?us-ascii?Q?/Nmhk2bdCrb72J8OwbgrrRCCMYfXdrIyTltBkmjp0aK9QRfWyRR80/4lXdf3?=
 =?us-ascii?Q?M7Buq1Xtx5zwxI9qP5H+tbYTUBGpTAkVRyEYusFZB9Hc8KQUJ9W70BjJGi95?=
 =?us-ascii?Q?VEzwau7/j8YwmLoD09VlQp3ucdOo1prcaSL8rhvJOHfLDfkDV36FHCtfMFPJ?=
 =?us-ascii?Q?Opy0reqONiownOJcauEpLTfUbl2tY2kwUKi0Bt+u3oM6NiKQfnMfRhdMomtK?=
 =?us-ascii?Q?Q10jCZMHjqnegcWMkXANqXNfh606BzfMBnjl+aDkQ8yGaOOlVCiu/Ee/WfKG?=
 =?us-ascii?Q?sb2u1U1cxo6TDy3heqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fac486-c6ea-4753-255c-08daa031aa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 02:40:39.6024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbJS1y6/d0Wmigm5Km00xfn/cygFqeadbNgRCdyhYaMNTLAWQvOlUU2tFEBOWqyPDLyJu8K7QNqNJEKPYzGzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3615
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 25, 2022 at 8:57 PM +0800, Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> On Sun, Sep 25, 2022 at 09:52:21AM +0000, Xiaochun XC17 Li wrote:
> > > -----Original Message-----
> > > From: kernel test robot <lkp@intel.com>
> > > Sent: Friday, September 23, 2022 11:21 PM
> > > To: Xiaochun Lee <lixiaochun.2888@163.com>;
> > > nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev
> > > Cc: kbuild-all@lists.01.org; lpieralisi@kernel.org; robh@kernel.org;
> > > kw@linux.com; bhelgaas@google.com; linux-pci@vger.kernel.org;
> linux-
> > > kernel@vger.kernel.org; Xiaochun XC17 Li <lixc17@lenovo.com>
> > > Subject: [External] Re: [PATCH v1] PCI: Set no io resource for
> > > bridges that behind VMD controller
> > >
> > > Hi Xiaochun,
> > >
> > > Thank you for the patch! Yet something to improve:
> > >
> > > [auto build test ERROR on helgaas-pci/next] [also build test ERROR
> > > on linus/master v6.0-rc6 next-20220923] [If your patch is applied to
> > > the wrong git tree, kindly drop us a note.
> > Hi, thanks for your reply, this patch is only expected to be applied
> > on x86 or x64, actually function "is_vmd()" is just defined in
> > arch/x86/include/asm/pci.h, do we need to support it on arch um?
>=20
> Yes, all possible Kconfig configurations must build cleanly.  You may hav=
e
> to add additional ifdef tests or an is_vmd() stub.

Thanks, I'll fix it and complier it base arch um, the patch v2 will be sent=
 out.

>=20
> For future reference, your email reply doesn't follow the usual Linux
> mailing list style, so it is unnecessarily hard to read.  In particular, =
it lacks
> the line that shows what you're responding to.
> It would look something like this:
>=20
>   On Fri, Sep 23, 2022 at 11:21PM +0800, kernel test robot wrote:

OK, thanks!=20
I did a test just now, it seems to meet the format requirements.
I sent emails via outlook, and I've tried to set the reply format,=20
unfortunately, the time zone and date time  are not resolved correctly.

>=20
> Here's a sample:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2FYyGghUdcrOdrR0ep%40smile.fi.intel.com&amp;data=3D05
> %7C01%7Clixc17%40lenovo.com%7C27c59eea4afb46c8e24608da9ef5752d%
> 7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0%7C6379970750209852
> 91%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=3DY8
> O9DzJ%2FW8JlAz0LM8o6LgnQcWUbYlxseM1wWbLvUKI%3D&amp;reserved
> =3D0
>=20
> More background:
> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fen.
> wikipedia.org%2Fwiki%2FPosting_style%23Interleaved_style&amp;data=3D05
> %7C01%7Clixc17%40lenovo.com%7C27c59eea4afb46c8e24608da9ef5752d%
> 7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0%7C6379970750209852
> 91%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=3D3Q
> oamhkXi78AOmFMuCRLnL52Ed8yEZ79Vx72pEpE4cs%3D&amp;reserved=3D0
