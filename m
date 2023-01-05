Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2565F4DE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 20:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjAET6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 14:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjAET6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 14:58:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77AA186CE;
        Thu,  5 Jan 2023 11:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672948732; x=1704484732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cg/ngkdwTjUcY3EKp3A2rQ8pPgEdV+nrKoGMhncOxTM=;
  b=AmqyjGLZk1NxrBnUAkrmWXganOcg0X9kde4R3d4vgXnAI6yZImIqPNcW
   PJb9h4BIoxw2nzNWBfmNdBzN0m6dQ4O8kO91rQ6rhunZbZL2j9ULrncYS
   ibgywSYRXVtYuC/b/v8Z/UnJXb810AarfbrS4zgOr2I77Bdiob2Zn/WXP
   H0SUFbZV6wiJYtgrV8BDQH0uOxcPa6+jODFRD8ka2uoFGliMXGju6yVOP
   eTE37dTD2zfdX2LcR+sAzQASksSwQoYk3Np2vTffq4l+Hltr6AekjwEx5
   V07IjYNA7phzqi39tlr7dE8rE5Nv5vQCuVBh6hstrwa0xgFTcr9YesPf4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302677608"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="302677608"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 11:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605663709"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="605663709"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2023 11:58:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 11:58:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 11:58:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 11:58:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 11:58:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvm+/FA/Agg27ZCU6GHQNIVkh9z1As37t8BhwNe29X+xK/tBv4hLumJrE9MGYkiLA1qMbYWww6GuZGVmbk99u151wi7zPmwrCp1xKNvExIikUuyGSa/XvODWOhoE8uJZnLaVQEYXjcj5PhPRAABIotzCei5x6fdw8obVTr2+lzMBptWhuxe4SNEpOp4OwGUhfJq0sh520/2utPqT/zCa1vjj+kwPnyV6wo3LjE0Tp3A7rMJnXzx45bsWP3XGDKJ4gxExnZ4iJvGCosqSACLuetLjCCHrcqukZpFnWe7AmF0LTeFIw4/awwVs+hX0WvcDh79qe61wc+owp091H3Co/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OsxlTHvV+XntyRBIk8xVWGNI3po/asY0ooi3KXef8c=;
 b=K7EEmbkYhI3d/CHPcWwO8pfowBfrWPR6W/Lohy6lAo1MVxDpp5WZ/o+9t/beA8j8joF4Vv6hyqXg8DKFspTdtcpmjajFsxrW77+BerZ6p5Mn2tlRmh9Q/OL+iW6SMppEwj+skNglK0SBIfyVnPLxijpfk8jd/J8LIPb/kK4P/yOykC6+/15nzdBgFcLo2M/R0+vNPChKzq+nZ8HUf29O0c1QeuBk0/ZcWOauEqUb7wfiaojoWkUZ9NWd2VbREVtN8g0IDT05qWyWnOaT42c+9rO+e4ejN+mJk0xhhJbGAkkXs84zdNf9EdB9+ZxIrO0aaD0fPNXv2Adoj/IK/RKuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:58:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:58:47 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: RE: Bug report: the extended PCI config space is missed with 6.2-rc2
Thread-Topic: Bug report: the extended PCI config space is missed with 6.2-rc2
Thread-Index: AQHZIS5W8o9BItAAdUOkB8l+e5XlU66QHQ6QgAAH+QCAABTaAIAAAkWA
Date:   Thu, 5 Jan 2023 19:58:47 +0000
Message-ID: <SJ1PR11MB608347C8A95717A8BEE3BF2DFCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083C504335B2DE1B31C440CFCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230105182950.GA1158496@bhelgaas>
 <63b7289cb7439_5174129445@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63b7289cb7439_5174129445@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6213:EE_
x-ms-office365-filtering-correlation-id: 192ff7f3-6f10-4eee-741e-08daef574201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTm6DTbJV9YR9wxdRfJwuk5yjaJrhao25oGzKB+Dyo7l46AWf8lOA5C2cVzihhzIW4T0ASgqz7xKKKme0BciexLOFmdLHmaG7PP1cldN0uw7gtvMOqzw9qQB7cvwAbJT9uBTviN3b5JqT/D2RghFIRHDKgk9qmHqGRpvymf/MYMYVVo0RgjN8smBnPC1s1NTN+mPWGia2g4dF9cMFMMN3OAypYILxTKAVf0xcqCJquxsfoHLcDM6+W7Zt9YTmTawffDaZN1kMxTGlvvtfbW6suoT7eX+oYSFdyARXvbDrl+QnStqoY+wgBM74Eb5uZkFChXa9/MyUNdHz0vvUGqaJGos4ZsiiHm1JENEcwWQHFuUi9nhJlzSmh/QAuFws4Y6M0IngIWdEVLORHTnMwVWIY0IjfcHpm0yhG2vh7nQJ4zHpeEf4+wFkw2Ks9lPM1ly0SrKOh39tbnLbTW14JF9I4TTGzKcFTtnfwETMEZ5EPWKZd4SZLnzyNTsA/do1d0t1CkSL1tmT2ZehVZ6E0Vux469c11Rh844tSVQrVJparWvOzZE+w28ggi6pvMGRKqLutNfwil7H9F4lTLPz2FOpKo7LVQV+PZYSgxPshNkx0BfR6Ek/z0VXC1Q1CxDwjP6GMS07ksCHOzUqxzJRCbsNW6z7Ex3QOtiOwDTpQrQpnK3yOi/jBk+r9v+Lq0Kb420qcfEdUalzkC4isNOJQnKlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199015)(26005)(9686003)(186003)(38070700005)(38100700002)(82960400001)(86362001)(4744005)(122000001)(55016003)(52536014)(316002)(8936002)(41300700001)(7416002)(66476007)(64756008)(8676002)(4326008)(5660300002)(66446008)(76116006)(66556008)(66946007)(6506007)(478600001)(7696005)(71200400001)(54906003)(110136005)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eoUynHebrSSdLz4IOEVo4jhIhQBNCuBUsPrXq1uL0D7pBQwCrPMjXnhqL2KT?=
 =?us-ascii?Q?hDGl/8U9gudn4lqmFMgzrWHf889q/plwkKwuMY3SYqO2bumul2Ehhat/pgwW?=
 =?us-ascii?Q?gOfsk0vEE9YtyTfeS/agHktxzkgg5fxDkJmgmIhbY8zJy71MKBzFqDZ4m6KF?=
 =?us-ascii?Q?0Q1DZSVGltz7xkieN52VNCL4MMuLJnJZcjztdW35UWFsxFDbCeOHkBgd/U0H?=
 =?us-ascii?Q?zvON7cqp1cYu56vDFad+bSo+T+YvPN2jGFf7CbcAcYb1Zdn2s/P6/HIFcFYw?=
 =?us-ascii?Q?7LE2UXN3A5BgzqEXFx5nPBTnkn437vH/wi/ZD9EzQPDkxWspP7LYHxi5Nbd1?=
 =?us-ascii?Q?+cYKKGf2FQ7KUrYChlVP/qq04C6cB/xXPyNuf+9o4Y90QzWrQVd6E7D04AgM?=
 =?us-ascii?Q?DN0vpIDok3j6NdcB/Tmu5pz29UaIWtBGQar8bFd4bJHOP1P3+YtAUgikJe4d?=
 =?us-ascii?Q?VBTUuQE8KHe8W/E41n+/N00sANATzzrSMw4Gp3rW7Dzu9nnl0JDFkTrHnU29?=
 =?us-ascii?Q?7RyxgULdquu9aUyj8EOIvGhbW1tFxCEm+XOX3/uejQ2yPLqtci+5fk9HDW8C?=
 =?us-ascii?Q?h03cwhpWtT5/7+KGkyY3aajyCE7n1AB5+fxi+c8GY44avr+bJ+cFL+42xJ5d?=
 =?us-ascii?Q?EVnoE4MABAPDPmdknfa8ZeTVj6zCdRfBOyzv38ybTrJ3Tf/P7OzpImPajurO?=
 =?us-ascii?Q?EsEzI6gFTL3vDUgbOU+xN4D3fJwmvkcN69OUrsw31PSTzMDUVw+yMsRTb6zc?=
 =?us-ascii?Q?qCbDY59LIKEn/Y3wRAE+giMfTmMxnjJOvlymblIPQtfo+RCri0CJ4hdm/bSy?=
 =?us-ascii?Q?bUeGh5D/pzA/4ldv0OPIAbZsBqJiLlyzV30tF0BcSFOqLrELyD6+zJfsLNA7?=
 =?us-ascii?Q?CMB0UHdaAvZ725R1ftXGle/n9OWj99KrqZKuOVP2Ui+TN3cHoYhYVyqCNYK4?=
 =?us-ascii?Q?VFdLLk/YtH5iU64hG9qLrxbTGNyf4U2bMqhcdlT8r9png0O8XFGFMEt0h1qX?=
 =?us-ascii?Q?fAA3xgOSOu3D2xmjSxsor0pXKwm4t+Y9VBZUQQOumRhCoFmrl5Sc0IBKmXb7?=
 =?us-ascii?Q?oXGqYZOKlaTq8CozSOadzID2puVdU7COUjFi9kbKsaft/NJHq8QcFSHd/IdK?=
 =?us-ascii?Q?HiwWz7Qgz+7rVTRA0ZsJ8a4i6bXRJY7Ha5DODQ3Fie0Ays5n+8Q/p0VSWMA6?=
 =?us-ascii?Q?9DkZ1YZ74Br0sPL9T10haBhCKDJ7e1N09FhqU2tJGSHQqwdyjxfMp1Kj4udP?=
 =?us-ascii?Q?gT3f4/V5/H6vMFxK69QN1M6Nlwwh8Iphyjh2mwf/0LNO1z47FVPWUE5mBfHR?=
 =?us-ascii?Q?kIkaYFLDqmYYFCY+PemAtPu5xgMwgfgh4VueEb+RAZhaPujOgXiA5quT+bpe?=
 =?us-ascii?Q?CQMjSlUL+YFczwxYv2HXIQ9RjMO5pWBpVQCWN+tV3hlG3T9jjDw6rKtu4fCj?=
 =?us-ascii?Q?Xcv6j3n/vTAHC21AyTG9ifH4NpMiWiyTQxf8DCxUKCHrgnzWtBoNuSYNNhCn?=
 =?us-ascii?Q?Z9l2pLHzUG2nRFGeTgh5pEUnlhGpJ66GkJyxBS3v0d9LkevivbUsHeZZ/tzu?=
 =?us-ascii?Q?W/SH+AZNhQjQk9X7KUc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192ff7f3-6f10-4eee-741e-08daef574201
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:58:47.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET/wDxS9yidgRAHgquCirUDtn2Hf/cXLnZVg0lOvx4eUeSm6sDX5Rj6DBrMmbWXFQ34IfU3pTgaBjK3gi9dLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Definitely an ambiguity / conflict, but not sure it is a bug when you
> look at from the perspective of how would an EFI runtime service use
> ECAM/MMCONFIG space?=20
>
> Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> Memory Type Usage after ExitBootServices()"?
>
> s/This memory is not used by the OS./This memory is not used by the OS,
> unless ACPI declares it for another purpose./

In the case of the EDAC driver there isn't any ACPI declaration.  It just d=
oes
pci_get_device() to find the devices it needs to use with a lookup based on
vendor-id and device-id.

and then uses	pci_read_config_dword() to read various offsets from config
space, some of which are in PCIe extended config space.

-Tony
