Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8229664F38
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 23:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAJW5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 17:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjAJW5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 17:57:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7DFFF4;
        Tue, 10 Jan 2023 14:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673391430; x=1704927430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3vxuoJy+yKQ/ZdtTEwH1hD1eTV3cH23zSf7mgJWbKQk=;
  b=R7nbMstyxqL5hFCc05HixycO8EPZNRlE143e2mkWi8RnOODp4KAkXDGi
   Xr1zkiZ8E+xZYDZVGf7ICjpevlgxPxqmBC9qDGr2GB5bfcR/lLWoCjJ7W
   sh4ybOXlT0Lhr5dYwN80MiBWnrqzp0BS57OwvgsexoTVcuuBsmACoGdEk
   da09yQwZmc0VRjf9b+p9SJxNGAQv44LB4YFt1eJCdK4+oqqFyDGt8+VJJ
   PQyYWhAv3F2AYfkyTjBTxLPE3mvoCROL9s07XxOyqKutZ7xPANmzkprUk
   /e1p0n7efXjuG61oM2OMJCvo9GXOwR++Nt+qHeRTUjsRITlOVHKheHzsp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303649106"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303649106"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687720268"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687720268"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2023 14:57:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 14:57:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 14:57:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 14:57:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 14:57:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcR4DEOAzmPxfyxb75bIoAjpYzNsioJYw66fX1TlZf4TpXQpOnL4xnt1vz+zJT6uxor8hD/WL8TI073LtTdoCXEZFdzSqkCDT6PXKo3FY0X+gtzVR0i7fL5czwlypsJD40Ooje5fxqUWFbmy1yrUf8Hou7GlGrFstrbdCZaMbT9M8j+53N7g25PMaLVTvVC9yY0lOI6xv4fRIDtb4SWq561GgbcZmEiLhI6TtAf0L6xB/GqiFTPdU0hVyaHdwYvJLRbi7ZW2rE2KzaBIMCkK8agOBO9W54h9E69ZNRfgNZAmQCbSCZjrDaDQE9WeoP6b9dxvTGd5+QUPN5vtnkZVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vxuoJy+yKQ/ZdtTEwH1hD1eTV3cH23zSf7mgJWbKQk=;
 b=KcjAW0IKzB4JdyO9D8Agm7/+fiCxwHmcDk1j5hN+HhtVZy9/luWHEdG8Nf71i9K4WWG/NoOro4R/53cVkiCJgg2DtR7YZ6on0UkrgM9LInlabT47UUzKg2xNX5gzPpmclGcniBYT4maQNHGQ9IIPUloFpHM+bhMussJI10U08QlK2BQvHXVz+TXmlrawOASOni4Ygcyj/+qqKVgu0tBo6aEP3IbMfKkQar1xds+Wyrj22hTMEfYan3US2ij4wVFo7DryCyyuU+MzZDE6Jc7hHplNTtiqm+c5zAa/dwnRV6NCDLt352xb4wn/yf0KxQhxab7Bg2uDaTCSPlnttPuHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB6889.namprd11.prod.outlook.com (2603:10b6:930:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 22:57:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 22:57:06 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        =?iso-8859-1?Q?Benoit_Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 0/2] PCI: Fix extended config space regression
Thread-Topic: [PATCH 0/2] PCI: Fix extended config space regression
Thread-Index: AQHZJR3XoVhUUFpFbk23r8VU7FyOQq6YQz8g
Date:   Tue, 10 Jan 2023 22:57:06 +0000
Message-ID: <SJ1PR11MB60836158A54C9F24F83AC4F9FCFF9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230110180243.1590045-1-helgaas@kernel.org>
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB6889:EE_
x-ms-office365-filtering-correlation-id: 91a5d991-da5a-4bf4-004a-08daf35dfeea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qegIIPMO3pNbnZPy1TmXKET+lD44xhunE9r0xn5kAKuGmgRsTGYQCbfREacM/ztGcNF5bYSQpuLZq1S6DavPFBOXlIPFLcV10Cs9zHvxBehxQbJnfIC4CUtf7k/xgImkAQw9r4BmirscJdme3e26eObVCgVaIk1ZGLt9SWLoKWkAa/eizxLWvlz44amceykafw9PMkXN/EuGha8Sp0591xHiuJbg/2gJIeXMcLBGeklyyn5a8mHYllaQeR7ixVTxSCiFxrFLDzq1LNOLiu5ccnT5iOTFw/CfRfHJliX4m8ULMQjuFlafniPxMHdIf14UEzaELMyEE+tufk8S5vrnDX5z1kOsgbfNMQRjAQ01Mj8S/n+NER0QkMYGHCjVvxWQgUh3nV/oCUs50XqbgxQ3D2Lv7F0LdkGh0JtswAJS/FzcKJGYVQYH1l9v1SH4Igr70tlkjdMLeTbDguxFIZ77JVd+U7VmCodjxiCGsBj7YxosMHGCbiTkkkjjg2cJCjarEugKPki3EWZ383UUZ14ZCRf38MdSfG/5lISFM5/MtjoezC0ru7Rl4Ugd2n7ArTWyohdFrlR01GRIYDt8sY3oc5kbm8INSvFpGakPUeRk+1zNdZvUXev6oEh7GKx74S2JVQUoKoy43oljg3vRORjzT37mWyhxZXyardWX86XCFoBGJrvPRCBnHkAmSEsPAAZ6P3Y8l+fa5TAoRKwNuhvkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(66556008)(52536014)(7416002)(2906002)(5660300002)(8936002)(41300700001)(66446008)(66946007)(64756008)(8676002)(66476007)(76116006)(71200400001)(316002)(7696005)(4326008)(54906003)(110136005)(6506007)(558084003)(478600001)(26005)(186003)(9686003)(33656002)(55016003)(86362001)(82960400001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hj/TAlT+58RX8J7Q+T/T6nZDpPc4kr1Cn1S5kTlf3mQKKXQFn8wiSR1jWj?=
 =?iso-8859-1?Q?jp5HqSwEVZJbzFA5QIMk2CiI9pZN02HCtZ6lW6goXTIs0S46qivlEwPPqA?=
 =?iso-8859-1?Q?5qLF1LPfLmerzHxky1YofOXJmO8pk5z8Cgd6XQBeEHcovy7tNpZ4dYOobo?=
 =?iso-8859-1?Q?ve2kLLIUrFXkT9E2zC8bei5z8VtX9bhTVimz2TGsy6xaZDInwt3o0z/TO3?=
 =?iso-8859-1?Q?lm+7M19xDRhDnbv/GVbpBc6jHfuBGe09tX9Y0Q+E3j7h3K99owFPDTXbNJ?=
 =?iso-8859-1?Q?9jtz0h+HndUWgaNowgifa/8LaTKmEvE/g6EkwojTtanhNQ2+by97ZRLki/?=
 =?iso-8859-1?Q?OCOCcfsbuNGktX12CtWChXDXQyLdD+ssF2NyoZ1TsRx+vUxHfFnMDx4rzR?=
 =?iso-8859-1?Q?DmcYomV8fnEU93pFc9Zf9pcpFln0RaasSPq/u2IltbCZfnh4vTIqbzJ+dN?=
 =?iso-8859-1?Q?2wJ7GulDfgr7/BCh6L3cJGTw8lY58zQnt1JV03bxMC/J3LxsLm8pOXf/K/?=
 =?iso-8859-1?Q?mvNOrwdwnbhWKk5oeoiwEO7frQ4TtJ4SJ1aNuqlotL8gt5ODt7oegblVi4?=
 =?iso-8859-1?Q?ekquW9OvmwI3OZ5HdT5Eu+TXBv8CqotVt8s+S3bQv7+CBWbCK4fIOz5u8k?=
 =?iso-8859-1?Q?4TBpFwp9tVn2WNqqu5jyC5JWdWJsqEQBH21wmqHBYkjWQRSqnQha/X0elj?=
 =?iso-8859-1?Q?/lMavOSLXJ4yuahQSggz7jYMIo9Kw5DNppkJFwHxL01DmUoYdEjput0+NM?=
 =?iso-8859-1?Q?INEOnQ94eZZTwAjrd7FTTyUzW35qZo1B+JHHxgegJi9chgAZM64HsexL2x?=
 =?iso-8859-1?Q?ULvAT1BRrI+xEvC2RIavTiCDWmTTkR3V/by+2In1031Yt/XJuB9r3fEfCG?=
 =?iso-8859-1?Q?CWNqvkBAS24qYVrGkoygq4uXK3GxKCJlbiTLdLmpPTPIR6vz4GGl93gmoh?=
 =?iso-8859-1?Q?25LN2pWwVfsFhZocXeC9FMlNYQmDguyfJmTPiSA7n1qlAZFSJ+HUrMU9Wz?=
 =?iso-8859-1?Q?Ctqj7DqmqNasRKoPcCGh0u9mEjKEOxBxNfj0Akb1iWYU5IwfDL24eN66lu?=
 =?iso-8859-1?Q?baOpW5DCCA4/S27Xtb5isPagv41W5ewYlg9G1JmSM9k+eI8ADW9SKLTOE2?=
 =?iso-8859-1?Q?VrLZcyN1rVQcR/Dkppuh+qvv1F5JP4U3DNEpCze3cta52DTYWn5ZH8w7BV?=
 =?iso-8859-1?Q?FRli3RQ33FToOoAq4sFtqNK/8OdPVqjo0UASoWobLInsqvgeibeGEqXd/b?=
 =?iso-8859-1?Q?h/95wXP1/Fa0ta8xgGABMNZqlXgRGOHhYFSPhbjLqCKb4tf+z+5dWqCs/p?=
 =?iso-8859-1?Q?vMpcxDlmzXF1TV8OqAJyv5q1KJaPgdoOOD2pXd6CXSnYU6JesHNG1qcpHn?=
 =?iso-8859-1?Q?AW35kva8EY47fgoUVHg2B4t6OuG9Y8WgPBEM41md4wTQTL3ysrnbcT8Kfd?=
 =?iso-8859-1?Q?7bfWt0SPXxOb/JEn27Ut1f4+j7P89JmcAG/m2VOnCl2FIbbRgbZPt1i7Ob?=
 =?iso-8859-1?Q?5XoeK+Hg0WwFj8yjtH/vhzf08wHaPX2Cjm5rHLFvkmhZ10MZ789wxM7m5S?=
 =?iso-8859-1?Q?GpY1bJgst6PTPkr4XqeYXrmret9wP3qk7kUozQdDywI4NYe3q9Xt9i2KEe?=
 =?iso-8859-1?Q?uYy4QejdTmFysCGKfvyWv6dxW7QuAO+Oqw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a5d991-da5a-4bf4-004a-08daf35dfeea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 22:57:06.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0X16szy07eh7lXFUrHPSBeKUrFlKosts4nwncHzabXouJ/nji7fTLJUyLN9a8vtchhHkSSV0QuNdr1HAhtdblg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> This broke drivers that use things in extended config space, e.g., perf,
> VSEC telemetry, EDAC, QAT, etc.

For the EDAC on Broadwell case I reported:

Tested-by: Tony Luck <tony.luck@intel.com>

