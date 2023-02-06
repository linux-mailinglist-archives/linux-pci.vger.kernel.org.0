Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB51168B4D6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 05:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBFE2n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Feb 2023 23:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFE2m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Feb 2023 23:28:42 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156D4199F2;
        Sun,  5 Feb 2023 20:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675657721; x=1707193721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RxCb6jwugiBK4189n3DfjfnWMy9a14FzTL9VT6hHFBA=;
  b=NGXhGMAGkSgA6eFA2mOxY3HwJNDmY9YOkWBV23YQWeicLaQ5WODFgq4d
   f++lZyteMg/10fgdDZyKOM4/UOEvI/7URWZl2Wg/28PSd6/6MKf5Gii+u
   YM+8rp6x/olGBD+DN4hMMDPQ/ZkzI03m+w9zaJH1jkym+VJ+8D7d1j3It
   quyMYznG2Z1ewBayHNAYXJoIuUwO+JDD8AZgD6crMwws1IeWxC/A/GL2n
   mQGvBsSdGSW5WKVdrIxmaqTZWjK6izJlLMG7R5OnxIKKzakwZMY/BKd7r
   bg4NbKGsSTIjk8lfENaQ8rs5auH6398O30GYPv25iDsNMyfxblQ4m23sE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="329142759"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329142759"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 20:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="808993117"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="808993117"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2023 20:28:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 20:28:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 20:28:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 20:28:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpyMPnWjrp7w8jQv4mbbZYBNkONMLivzncKEz7wYepoNvC//b3rAdfYkvNrD3kDWFfjowaZ2619FTjyz8r+qomPJKzaRRgZu3BHP3zcKKiBCzxwabAeggpiVDlUonKJo0raXZZ4Spl/r5/yF8EXb7p8uGr6l4/wkx0L7lewm0X/xuqr5ffy4gP1/VP0g1snv4RH+rOON2eJxEz0S6O/FlESt3dJ3tF0zXhPjE+iug7ANyn1uSDxY5HWPc9jVwlo5+Ko0eHx5wJghMNuuHRoXHw35CIx9BqtUf/6Et8rITmgxRV4y4S4FUT0wriQxXUCKZReFQ7X11UUyIepPZw17fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxCb6jwugiBK4189n3DfjfnWMy9a14FzTL9VT6hHFBA=;
 b=fTgUeoxoZZRJjnMhdtvGfzPau8ID6/O3zk7OMN5TEzaev4sYZemgsNcvHowaWun0ido4ZLlOAXUsqQBoxJSjpPI/uIkD4FQEP5vK86npGqDF/hsVVL6+Cb+yTjvDoSuCHQkx7U6xOeZ/QI/WwMpOTgXxfxiTMVqDMbfBsA65gl+5Hf2/Yfot9Q15eeIyDiC0kX7dlmafCBC1FriRD05NUq/spc4KctjnKN4TuJhWVmDrrWuDnaPaYGLYGm4DhcQzf37BlZTXd0bfI2Oq9hciU6VfyHJza+oAvpWlZPKHLOK57FTLGD/dGr5BV+1e7X7hUsfC+5dD3aul/EQVqEfCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7924.namprd11.prod.outlook.com (2603:10b6:930:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 04:28:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 04:28:15 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alex Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Thread-Topic: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Thread-Index: AQHZJ+u/izID69X8S0CIgNghGwY+ma6ymkmAgAKRIACAAjjAAIABKhiAgAHe0wCAAKpPgIABHjaAgAAJBICAAWoCgIAACOYAgAPE1dA=
Date:   Mon, 6 Feb 2023 04:28:15 +0000
Message-ID: <BN9PR11MB5276FA24C99DB1E268211ACF8CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <Y9wg0Znc0tRWj4O9@nvidia.com> <20230203182045.GA1972366@bhelgaas>
 <Y91X9MeCOsa67CC6@nvidia.com>
In-Reply-To: <Y91X9MeCOsa67CC6@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7924:EE_
x-ms-office365-filtering-correlation-id: 20fdc07c-1ec5-4277-9085-08db07fa90be
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDJvgnlxrT9aO+sFlrban2Y++f4KdLYd/g8lxF+ttNZIqv+Hnn2mXR2kwO07cXP7gXzhI1nMWUIpmscftLAqlfciCkH+4FpLedYuJE0tOlYFMzgzJiubOE0VSsnEvppcLSKEJmCQOKNyGGw1LyzpEts9AiylvfM4ivQHR5lsxOoklxzAquOlJ0WebEP1CDoRp5Kp5o+RTuu3DwHbNxDMBBMQCo4oSxoRAi/TBGRefRXROdq69R5BhjlshnURNq/0eNGxvMkogEml+4oU+ekdMD/IBVvBPH9o/xzRkxAQRxug2ATkw79uNzoNq1zuYOHnHmJKTlyC+ZJ2kXIAqi2Jxs4Sg0KOKsJ6jGMhEFbsfnhyNJIoVkqYK4AxyjK+TwsOKPjIz6cfpc1Cv0VzmdQsN1293lwlYg31VHv+vxFrMSlEOYePDSZt37zlkNjRLnVc6Ox17LBFE+coW97AfYIaqdT6Fxf1IRVOhA9KTpvNyY91Uz7XTZLIKLRoVJynZRxxqsRekZQ2LYW1B6fJa/gi1H/Gls5ZoSFAkdQKzeDWqLpJxEoA6lqen2HhMzN2kxoZpmLDQDfCZFcKL2pKFuuIPN3XkLOzAnKbmuBANAsAdvCdvG4e0t4hZ1UZKfsmvIg+DbV2R6V1r/TQCPNR2JY+pHoPJX9jfYZif2HvE/tREFP5r2AOTOK46nywhTI5YJm9PSnd1t3pvyn9HzIRLtftUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199018)(33656002)(38100700002)(4744005)(122000001)(110136005)(5660300002)(7416002)(52536014)(316002)(54906003)(38070700005)(82960400001)(86362001)(55016003)(2906002)(71200400001)(66476007)(26005)(9686003)(186003)(76116006)(478600001)(8676002)(4326008)(66946007)(66446008)(66556008)(8936002)(64756008)(6506007)(7696005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JLMQ4tLAQnqgoU1mqk5xQVLSOW/3JcvhwtbynTOpLk4yaBcRrHoHFsehIc?=
 =?iso-8859-1?Q?uMjsptJjmmuGPUUKwwH4NgFGpy8abq/MbWyfBNJnNplAfV+wHigDmEQeBN?=
 =?iso-8859-1?Q?nh9uY/Ou9VDVCqF7b2+GyhO+/87LFvL5MboHSD3Yt+lrsQSousi8a+U5Mw?=
 =?iso-8859-1?Q?aPV0Fe5xUHloQtbC9d8bEClkvgzylP9NjqhExOfoXbcq36LDJdH2SH0eVl?=
 =?iso-8859-1?Q?AV9aflbUPbBZqp4IgSaI3fma1+hLFb6bvk7h59BhdHJe1kXJANPiJPHmAt?=
 =?iso-8859-1?Q?t5LAxV2a9bVarUhk7UlosRPVNeUSw9qRlmG5Knt9Fs+SobEVSOznAIJagd?=
 =?iso-8859-1?Q?jRmbF6Yo0zFl+QXU9sRAREX/SiJaaCj3vJf2GkuG6AqWp9GaoID8OO2AmR?=
 =?iso-8859-1?Q?BXl2Jvzy85qb9BoYgI62g6QGyn2LtYZnqJnPBsO87Y3d5CZPQmw7uDkAUY?=
 =?iso-8859-1?Q?2R2kq/sq9evPmfucJDy5unAnAFw81Znt2pxThm8TKpqVj4HBSDfjnQ/DNZ?=
 =?iso-8859-1?Q?XP+gyAB/Pga8aWFigrzhtTP0ksMyCzKeONRVokGZzzDiT9PVqPawWi1iqB?=
 =?iso-8859-1?Q?4TWXeeuRFqpAno4Vs/WobrLEAGcQoynT7oj+EGO8nL2vmwir3zkDnz+oTH?=
 =?iso-8859-1?Q?xAy3/UATseiSnd/EfMGp4Irm0Lurhk4+HUjzByQRnp+LCRtGnsCAn+QmQX?=
 =?iso-8859-1?Q?DJQO+5PNChqM2LXQRALgMy2DEwl/hSBwidvhV9KGRIvDAujEjqptfYF4KC?=
 =?iso-8859-1?Q?rrnUDxl+wizo2LG6yv6CTRPn4oqZ6K+lyha2A27Gf719RwaEr3B+PYgnEE?=
 =?iso-8859-1?Q?cB+a6OiqRljpn5PK16mEYAfLdbtXotg1TvF9YxBBDA89+Z18hL4Vz+kDU3?=
 =?iso-8859-1?Q?QS796EmvXduld+B3T3roIOnOmaqKODrn8MiJ89xRSO4IueNMnWFVgg2RKI?=
 =?iso-8859-1?Q?DSenmMeCVupKGzYjY33n2G1qc3Ret5B376eKVHAsEVMNenJCKSPn/4YGbv?=
 =?iso-8859-1?Q?LzmFIclSwky8xNkUKThikb07u5scbTmWvEKavfDpTNb/6WvmX6Za8GjZDu?=
 =?iso-8859-1?Q?rLrWi2rAaPuTb1XA8/lRrCDzDvrahhb/PWA9ANEATeMG/NSnszHY/tA4DX?=
 =?iso-8859-1?Q?LGjvu5ls8aDlg8YRNWQsoZdHRv/HJuNFmhbnN2XRTFQ51ME4WWJ4i/4LRF?=
 =?iso-8859-1?Q?u1mdy1952/Ml0beRpUdYMmURu2W6eDiCZ8w4EFhvYEggswyeQCJgKmZPO8?=
 =?iso-8859-1?Q?9v3uV2Ot9f2BRVcWf+ep0XOrq9cExO+seYoQKtWutvpjTGzOxCNWKQZDM5?=
 =?iso-8859-1?Q?zIh70K45lSQzZUuZO2lI1ji9phScbxthNZQ0hc2L/Yl1sfzqURrZXYRfEi?=
 =?iso-8859-1?Q?WimFHXM9d8TDfcE8L43awHGzZZv2IpLjwY7J0Us4Ao6icIOl5stWvt24Lr?=
 =?iso-8859-1?Q?QvpetBYhLj63G5BmM7FtuQmMQdhlhz4kIC+lorkQvq3Uj78A7CgYmVy+gM?=
 =?iso-8859-1?Q?QEwOSVRez5l0bMEZcOtZRpWjH5KIJT2Lk5sWnonxNR5oyZboVsWJyoJFEs?=
 =?iso-8859-1?Q?sFcMIPa7AmbNjDGRvV4ZSIH72k+vcnVn4oHzRQ88fsyLIdFmYXPnx8tQtu?=
 =?iso-8859-1?Q?GuJLunNtrMYgq2bNIJM9izbI0uDUK9S+00?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fdc07c-1ec5-4277-9085-08db07fa90be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 04:28:15.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkjkRk9WN1SaEWy+DUlB3JAvQOO2YuKb+G3BXu7/LtoNivMFzvRj+9HNTB+4WpJO/qM3Xk4oJ/hPh0Ej4JCEJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7924
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 4, 2023 2:53 AM
>
> The AMD defect is some BIOS's on some of their SOC's don't report ACS
> for the MFD, even though it does presumably implement ACS.
>=20

If that is the case looks AMD driver should implement a pci quirk so
pci_dev_specific_acs_enabled() can correctly report to meet pci
core requirement.
