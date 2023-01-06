Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2618365F813
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjAFAWU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 19:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjAFAWS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 19:22:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614A3D5DE;
        Thu,  5 Jan 2023 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672964536; x=1704500536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n2UnXNTeSg5NHuhVCdPANDvuQMxRaInY4rvI/kxWHLE=;
  b=Q2qgNWvIYjZ8Qkc6/1ggXbPG6GRIlrXwFgtIp7+vGjO/CD9ivJAIfY8G
   PCpBrl2pqftv4xgkarP4zuwm7HhnJQnFLYnlQVXv/gB0qP/R62JL9oFpq
   lqX4IOvdDWSsqGKvn9AxdDfIjdxnI088xWvUdJkHjsF5kpPtj53bjy7dI
   E8M2YiZbpPZqAl0xgk9FDc/QHyaABo6QGAZLdbyBBDFZQcToFHAXEiCv0
   eU0DGd84jl0NWOagITsfKjFqGBfIa7reaCWu2uCcvCTy4hwTFZJywDNC/
   iycnTtldTahDuJ4J5MhbftLmsbpuzNpcOqf1FkclgrWl8CZQ0GJAlXpu+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="310150768"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="310150768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 16:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="657721660"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="657721660"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jan 2023 16:22:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 16:22:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 16:22:14 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 16:22:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM1SgmCvruLRm/rMQDFqjcK/5p3JufQoe2k1q75Ksi2bccn0QxyPiDRwi7Fw29uivQ0YkHfNkFgDcAnQspSoaagFLVjBddRWKqLvxZ/dgAiWBW5WcGDVNiXl14ey68uuFhXRb+P7AdvX+EyaigyUKlykS3f0YPOsSSXL8DQxxp9NQkUIjCtkg6NiYc0w4WiHrnSYFyMnw/dSFSBNu5AvxwR84UAkkMr0Vo1z5cCzIbD30KVpexrtRhocsMjjDibRSKCKo5y1/OPRzr+oizS8rbI2ISJm1Mj/QOerGwHjHqNbB7ZfGMVwcpjZfLt9gkWDL1xghIW5h5s40Dlg7V2t6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fh46UTV0en2jVojz1rCh6Asj8eH/0G9zkkwWD4H4zw=;
 b=jDvMbzpuYT1IqcBVC4hCixk8AGyuY1+pv2FNGQ5UWu5D9//B7KgKJgfzOfFv7F8guNc2LbtKG5uVymcVVLcHq99SLUu4ZZthwnQCVga5Pw8D0v0y8TQk23Qubk6pN+XqoE69GB+Iczt9i3aV+0uKw58IfUzUNFoOiyZgGyT918fxxFCDV63vKgXgSApt+qcOYI7DdUA7xVf50eTBAGpVKQzKFaZz0XISmmVV6pkjBfkn9D2a87S2fyKIw4x0KGuW6xZDxfEzx3HgRizwWe9N/MVzsl3hq7JtDwqDYTa7NBQ6DqtSiqlU6TkLbfbeIc2GwlBej6RVPOrdZXCcOsStpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 00:22:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 00:22:10 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
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
        "Sun, Yunying" <yunying.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: Bug report: the extended PCI config space is missed with 6.2-rc2
Thread-Topic: Bug report: the extended PCI config space is missed with 6.2-rc2
Thread-Index: AQHZIVW2m6xt6ZXjPka32M949hA9Q66QewIAgAALXHA=
Date:   Fri, 6 Jan 2023 00:22:09 +0000
Message-ID: <SJ1PR11MB6083D724817B96F3B5EBA714FCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ac2693d8-8ba3-72e0-5b66-b3ae008d539d@linux.intel.com>
 <20230105223257.GA1177387@bhelgaas>
 <63b75f8083b79_c81f02949b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63b75f8083b79_c81f02949b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6618:EE_
x-ms-office365-filtering-correlation-id: 95970787-662a-477d-4ee1-08daef7c0d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgufWQwSjSVYIAUV59noXOunv7I8jrj/e9yg6adrMMQ9yEJEVdUqmPx8fOd7qRptNnpk7ABLPuUVyj/2wIK5Et3UEos8gyIAkFCbrNBSG4y7KEGQqe26h1vax9oxZdV/Opo2WakPw7j9KKY3/XMGwVeLpKjiWyo0A5FU0gr3yFWY25HGzNIsbJuDGCxp+1dcewob6e13USF0xI71/GEzChTgR0cn5VIuzoPuiZIHgE/YoBDWIREyQbfyryXZw4EdxwPOEV8qEMrW2UfkWKUfG3KdLNiFWnx5xcTkW9o2AqdIUPxLV7CU/aw828h/Fjt8dJGyTvElbRo2eLu0yEjIzN1baqasdLMwB2T7YIGwhJLN9QW086bV2wo/ZaIaHHUdgB6Zp0AM1ScrR+/3oPDvHXcnKPTX41DOM19psuIGIVS79SyEwFzXKFVVl7ja3BUR0ojQ2PxdV1N+heRJkTcx78/1a+Inaa7/7BFnX5TT+7Gwtng1K9ZwyIMNpb0A5N1f+Mi2eW3ZpVwzJb1zI0cNOeuQsCP4R0OnY6g4RtsIo9V9JuurzBA2A3X5nuWtkMocBgxE8EZZGMPYZ82fCrsMgVjz3/xz728NtTajVHStXfk5v+m62J3pezbMNSrz7ioav+IbL+yUPpdk/8gTAP9T1VsazJSJtnEadS42ujxnAC346djGl3IyzDYTtD9XsU10E1iUuL4/T1ytmaeL6xBZnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(66556008)(7416002)(52536014)(64756008)(66446008)(66946007)(4326008)(76116006)(66476007)(41300700001)(54906003)(5660300002)(8936002)(2906002)(8676002)(316002)(71200400001)(6506007)(478600001)(9686003)(26005)(7696005)(86362001)(83380400001)(33656002)(186003)(110136005)(82960400001)(55016003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kN2vypxYC1+0sfPxHgj0JUUo3DcvlPnSatX4CC5DfaG1WNPfDFjSFbnGiwX8?=
 =?us-ascii?Q?iHRg7LNkD1/zD8QUCLs1GVuljrDSxSEjkMnlxisk8GFlmtMeKYBHR3j/3oAe?=
 =?us-ascii?Q?hmNXZcOLiiJsNqIYCfnBzcZSCRa0yWGiJ73yQ/Tloa888AJhpGduHmE9ZRVK?=
 =?us-ascii?Q?A6vc7pWPdIMiWRTM2TFa+KijBQHMNg8gsU6QLUxecshdleRVzCP3+XuPFiGs?=
 =?us-ascii?Q?z0R1ZlFh0cx5fVYI/23mkC+3KoHXX8xUsTly4d/10XA0jQl8giO/WzsIStcU?=
 =?us-ascii?Q?/0yqHJpM7OatLR/IH0XlbfGYRWbwnfCnu7haBUVAo1tWvTbisrsuSQfvVmD/?=
 =?us-ascii?Q?uNXZ2I4k7jrh85XbkL18APUpPyTxeZ5o+u/SMQ7uukXey8WVkUa6EpFmylkr?=
 =?us-ascii?Q?inwBhYIs9ngyNVVPWFhvanOkei8yJe3VE6E8s/T72Y8pwLrGwLjXBGcpskYu?=
 =?us-ascii?Q?nvAEtT0zHLsD7WJfLkaeJub21pqKhHOsxX7RLTY+Ad7AOYI41Kjt/wgbxiiB?=
 =?us-ascii?Q?iFtJ3ZjZnVeDLZoTEvVBDreVOsZqYJw/kbWrAoWBoJ54hUlZh1XfGPUZ1GBU?=
 =?us-ascii?Q?nFybx2/kDx2FmqNjQ2Pisnxlsky4zBPcFZzY/QFXzBYwGa1hOqLof+fz7RPm?=
 =?us-ascii?Q?GhPSUGq7l9JYeyXqKTCcFXovk1Sior5FLibJHcVLulVIOzRP6ZOox/xhJhS6?=
 =?us-ascii?Q?SUDFGw/yNedAMZQMHUQmsVsSvMnqipBwT5+4i0DC12SLcPJCglKdip7SGGj6?=
 =?us-ascii?Q?0XIl/L+dO9rh8+iYFUh93o8/NCT29Dmz+IsMsd5pT4fxCzG+yq0o6+Bdb1W5?=
 =?us-ascii?Q?UkmUliHiPjXgrQG+cw759i/giRKIYXiB+QSEhxhWyEkeGvrmWCMuXLaO/1j5?=
 =?us-ascii?Q?whhZ+lZCgskofWqJitxu8IYI6SLSBj72RzOxzKKX7v7V3mc2qWPWybqEIjhz?=
 =?us-ascii?Q?o+4FXtYNLBP6lQEEQdfyx+3EBSwHvIESkrZrVloaPbR0R6Y0k0qLcSPt5ZnB?=
 =?us-ascii?Q?8l+Pv00rhq23fIhhx1U11MXldZllAPIzqovXjS+MylpoVL5sKv/I+8Dr/ALi?=
 =?us-ascii?Q?HiqX+GA6Mkd/44Idy3w3676TMZTiPlMqIKEtxwSSCsgryXjQGR44orTn1FEh?=
 =?us-ascii?Q?eKoQULZC7lrzBIfA/YZnDEj36TnoVWMsMyHKCAFwUFPPcLuyJVXzxTG5wkcr?=
 =?us-ascii?Q?KcVXPSspglJvwZ76VtjG2XNwbA2ih4sLQgXGgR3tm28DVf7zXk61AuhNw66Z?=
 =?us-ascii?Q?8kWAvx9aCeV6+1p6jmpRpz9xriuTq1VxS37+ln7i0XqfFhiUEiuuaSY1LEqd?=
 =?us-ascii?Q?v1UHlqNOrLkLN75a/eG05Cv2WDOpx9gujJtCdoyTFWTYMSZp0/iJn/k9GCPr?=
 =?us-ascii?Q?ijJZlb4Ykyu601YMM2FV9zi5oZ5OzEiVdLRm0+3A0mkJA69MTky1YDFr+yP6?=
 =?us-ascii?Q?u/cdMeotLZIMZ4rcvnt9i9TtpN34uETrv+J46rW26Fu7fiJ9LL5/F7JsEmNS?=
 =?us-ascii?Q?iBKSz/YfHB61XZg4ci2Dln3yKE08eZZKc5pgBZFGlg91J2wQZYxzlyRZB9ns?=
 =?us-ascii?Q?+3GetS/9jOZphD+AKq4Mc2FBV/1GUm4t2b8YXlkY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95970787-662a-477d-4ee1-08daef7c0d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 00:22:10.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nwct3VG7SY7zHIJl8k5juvPriFyWrhh2mgazVC8TMgn5rqR4s5Y4VuI8rm8hy9F5UKpXLkVKHfjGxm3IX4Q/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> ...and Dave, who reported that CXL enumeration was busted in -rc2, says
> this patch fixes that. So you can also add:
>
> Tested-by: Dave Jiang <dave.jiang@intel.com>

Also seems good for my Broadwell/EDAC system.

Boot messages mentioning MMCONFIG are:

$ dmesg | grep MMCONFIG
[   12.280360] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
-0x8fffffff] (base 0x80000000)
[   12.291606] PCI: not using MMCONFIG
[   12.873676] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000=
-0x8fffffff] (base 0x80000000)
[   12.893266] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in ACP=
I motherboard resources or EFI
[   12.903601] PCI: MMCONFIG for 0000 [bus00-7f] at [mem 0x80000000-0x87fff=
fff] (base 0x80000000) (size reduced!)
[   13.385616] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge
[   14.115617] acpi PNP0A03:01: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge
[   17.969639] acpi PNP0A08:02: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge
[   18.298640] acpi PNP0A08:03: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge

The EDAC driver works with this patch applied.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
