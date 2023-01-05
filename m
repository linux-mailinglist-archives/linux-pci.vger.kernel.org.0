Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CAC65F638
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 22:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjAEVvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 16:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjAEVu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 16:50:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218E71FCD;
        Thu,  5 Jan 2023 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672955387; x=1704491387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zOLYApph76U3kRgGsrcT6LXen9om1IB9XabH8qIaceQ=;
  b=kIDZbu7XYvT6Qvp+HDkYsRLRR7BtDYizBLSaFgmgsXVE1THwfGJnxRE9
   4ELI+QW/4+WISOFyk/FiSccChWWziM/buGmv6immlschNLNCiyitoMoW2
   8NyrCh+GjV33b0Rn43SNJXpOu/jpxQaNfxuOBrN0HgqapEDZerQxNMwj7
   RkqAc8qmk8Bh0VczrR8dH7wnI2hru8wSc+wHUNw24bBLp1RDGDS24ZPo2
   EgADSprb82Xhp4OzGmM/JPK1l1Cah2y4qaPw/MIXaxAO8jPdN3ZuaggNG
   ahlqdrXZyBo4mh3m6hP7Crq4GsEb60tTvvRWXb3xiNAaAMQ0+c1n9EjRH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302700528"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="302700528"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:49:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="984459604"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="984459604"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jan 2023 13:49:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 13:49:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 13:49:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 13:49:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 13:49:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9ikdTZABQ11uwfyEITlcGlCFQxyEy8juR2HAYprbcw7p1eYutsV4x69fbGrwBVZi38PC6lXn5Sm9xod1CWShAEVhNHGQALcmjKuWkTZirKLt/HBpWmEDFcyrNXlwn7dTXJI5e6hjKcZ/SZiFyXXTOiVCG1CnZcIHp4agmdVVU3t3WnCyVW2lqWRIJUlS5Kt0EzlnKoQXXnVw/g9Nk4ffhlmUVLao3UXp+IHZKLO1zpMEkSmX1NII6LErI3S9sEEetr92qp5LO+f/QWgvt3WRII2bU6FXQtL56rxsnZl8oObGydMnzH0Ublof714PFl1I8qmGhnDi8HmN6sYip3ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOLYApph76U3kRgGsrcT6LXen9om1IB9XabH8qIaceQ=;
 b=Ch4xMRI3kIks2WhYf+aYi2WNStWuvAYJpb0Y5q+I54pom0UoP1zmAjCTuhgrSwAsuUL4MTCp/xgLGxiIlgCRUjoRhTDjAXq4CVTmQXSr9HpgrbIbDSJgYfg1uDjv4+HOHVBge4eemyIWR4M3wfJVXWW2te5F31Px9TS9/tb+vxmFn4BrUtZUu9h2QcEf0K9O7N2UQVe00d8363xuQOaivEWaVdn9yzSvI4AtEAkbspXa/5X535cvC6i7Cx8lTImAXrT5pp+YK09XCG6dHkeXsrSBlRDvd2qMzareVKj8mVaicSK4k8Ggs20CrFepLss0d/ETUeul9quRdP9TJPjyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 21:49:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 21:49:44 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
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
Thread-Index: AQHZIS5W8o9BItAAdUOkB8l+e5XlU66QHQ6QgAAH+QCAABTaAIAAAkWAgAAMrYCAABNXMA==
Date:   Thu, 5 Jan 2023 21:49:44 +0000
Message-ID: <SJ1PR11MB608376AF8369BE02661C48D7FCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608347C8A95717A8BEE3BF2DFCFA9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230105203757.GA1166631@bhelgaas>
In-Reply-To: <20230105203757.GA1166631@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6358:EE_
x-ms-office365-filtering-correlation-id: 58a215e4-f911-4057-88fd-08daef66c1dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LZr7C96opYWr5S9pKyS+mDDpK5b0lKIXWBh5e82YCihLEG0xIslhKy+Fh2iYJA7SgPb7e4+jhJq+7uUdrR+5+mO9Gd3A7xslFAFaz7gSOhLZNHedfnaR+jySXiQKS7L/XBL/F6RX+w7EgGXCWUsoZw8e9o9zckSbch/9j+l/y5E1eivWQVp/WjtgI1+FvZ+ScdvBF3sn3FiL54URBCa7XA5eT6iqSemNkWp0ug8ba+5fXmQTrltI5gJnS37StChEh21xGBfApLVeZ0Apz+YQ2u08tCZ1cwKt9R+B0V9fM8m6IdQVMte6RFseR4SBRnUifVlVksDvKeZwzjJ5Dqdswl8JaVbHx6osTLOJpzVFsnViGmSgpMvv/w2TzZ3wEcLQuREgjIXTyWfuqTW6wCnKKXyogpIZW66mlNnVqEGu8A40EOd6836PVoBIwE60BbwjzdtvHOulp9YCcruaFs4cMJBI9bus/cCkU5p1WGgUGJ3WBSkCe1KhBo/ME81mKiYpjYLlx/RO96u5cAfX+xbiO4BMjMFNRG1wKUcMZ/M4Ao2nReupCK8g3QjtZvOVQ0AWMT9yZ49CTF6fMRgIYbK6sOoJriiApjofHMgTPMSGVob3B+FYZuP9cRey3AQVRm6qVg1P82oqjqA1t9p4Tx+tnf34y7LSw4C+J8GXq7omWPxvaKihV9bEymtC+HPKY258UIZBzSXfSdq9c2XlStc4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(26005)(9686003)(33656002)(55016003)(6506007)(186003)(7696005)(38070700005)(558084003)(86362001)(122000001)(38100700002)(82960400001)(4326008)(8676002)(41300700001)(7416002)(5660300002)(2906002)(8936002)(478600001)(66556008)(52536014)(71200400001)(76116006)(66946007)(6916009)(54906003)(316002)(64756008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?enh7nm1W/kJ9i5ZTveJhw5tvTr7f7Y7Ok0aV3nwLVD3E1Uy/H/sHO5zzBkF8?=
 =?us-ascii?Q?n+mSkn6vlEfwNZA7Qn6TiNmO/rEbmXbRCB+PbCUYI1R8ndpsC9flrGx/N6/D?=
 =?us-ascii?Q?L+U4SQbuKWb3E8NmWWKFkJM37dF3gK6eT/MQcO6W0v6D34V2gOlspFDll/mH?=
 =?us-ascii?Q?neeoVdqljCtYZVGDwdSOc2BLYznInsWkSA/7tMLzc1S2aDt+ktiUavr+j7ur?=
 =?us-ascii?Q?iFtUAdjyt/HqhgIMqUsFslNJEo6kEdoVFsOnLgpwMtqsOhiheMGXMth9XsGV?=
 =?us-ascii?Q?TyqzZ0z89gLTxQEp95jUYq2HX+JrdvIIaTk0lpbybAan0ahqtg7gd0dyFOd2?=
 =?us-ascii?Q?Wf0zqBUfag4YOtNV4rxjo4iQSDgFUIl/uDH739vFpBqPoTByaYzYZUBfQZC1?=
 =?us-ascii?Q?OsS1TF5FU2G+RyNh6uy+RrJtwyO+7/XKlS/DKg//fqf+slpR5IBGr7w/zCdP?=
 =?us-ascii?Q?qcstJwJqGihKA9wFlzBZl00KUrrRt+CwcMQo7z46L4dRZYciMApbh/SN1r2s?=
 =?us-ascii?Q?IpoT/ez5GF6j3WA3CA8+IKhYm2CHTFM3VEIVSUS/KqyiWdGNKwYiTdF9mPKs?=
 =?us-ascii?Q?6mqn3pH7AebzVvGIlD6LIOSgEhLbQ7DwaBAnroytGCpvfoc0+0Wi+kvC3rXW?=
 =?us-ascii?Q?T/wV8ILDd/Q9ryoCx2EopaCfzcE4B/V+7S3BMJEoabm1Z4U37mxZJ0VmpCSF?=
 =?us-ascii?Q?x/K9RMIqchL6NQ5rNcblhuUcJ+YqOLmrAneBtMKy/lOpQhuW2PgM2RJR9rEo?=
 =?us-ascii?Q?RM/bbeeAaREF6VAfRgmpWmXB4YwvwbsexmceSEgD5gta3t809pykmEmr7jFq?=
 =?us-ascii?Q?kTTS6WXDi8pJFP/kz47mT1ah3jsTwJ5rNk/tksBoWck0RFwSbXIMuQedd1kb?=
 =?us-ascii?Q?R+A+TS6KZ1n4jsbJx+4+jUiH48D22baLx1z+3U0DQzogsvv6C++gymEwQFIa?=
 =?us-ascii?Q?lvUUcmQ2vSRX6F1B2Dfa9+aJAcC9CiSRkgbS5qT8g6osIryfhQOGEKaoIdQj?=
 =?us-ascii?Q?evuQc1wbWUqdP7zj4u/coASHEiHPd7mNTkr0uc6Tolhj/k1hQRi51dQxJBen?=
 =?us-ascii?Q?/0lraQEcXCtTYPOD1X9Y4Pst9pyP6E1RU/AQeAeJ7rYiocL/bKzrJf1CoKha?=
 =?us-ascii?Q?wCo7/L7bq+ALPI2GSQ1XR9tGwERwRKppYwX4Qb7qrI73Gd+aC9GewiaNL3Ez?=
 =?us-ascii?Q?0aNieyEZn1LMle+zhC4lRPxRIEgEPZuDO2Hx9RrXTIItD5w1MH2ScytRD8Gk?=
 =?us-ascii?Q?xLggx1Bbb5c7RZJvGZg4f67x+53oefp2vUMgv4NnKgbYTox+XibS8UHxVXPE?=
 =?us-ascii?Q?eU3x5Vsyn65ChTYtiDOkYMLLV4XGXEpbsq2T05yF5fP2g9m0t/7ihyIWsRcj?=
 =?us-ascii?Q?kvHKfaSNEiDzb8tGJDE4DKk2q15IWXxdjKEPhX0AFn2WuBzwqigpzfyO4MQZ?=
 =?us-ascii?Q?hnjEQrZHykanKdoRQPwM9bQV2Vgx+QoEZuNuhnMwlTt1VZV4Z3vbEC6csibl?=
 =?us-ascii?Q?EDlSPz1UPAIs5ssC2CREHVUEwkWsUL0Ryn/yODyu7aoObaxErIwAQX4C/4CY?=
 =?us-ascii?Q?jM7+9ubU5rDpEovYy9w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a215e4-f911-4057-88fd-08daef66c1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 21:49:44.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdZ3L0dZ0t4jiFNI+98pbYoyOGBMiobmCsbUdF4+Aqlprk0cjbw/CCdT3XcgSQzGKink+MjjXScKRxfUu4vLDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> The EDAC driver wouldn't have any ACPI stuff in it; it's just that
> Linux is looking for ACPI info about the ECAM area.

Is there some way for a driver to know that pci_read_config_dword()
is going to fail for offsets in extended PCIe config space?

-Tony
