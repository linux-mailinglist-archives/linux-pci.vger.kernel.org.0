Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A744CFEF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 03:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhKKCT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 21:19:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:13943 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233745AbhKKCT5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 21:19:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="231553366"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="231553366"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 18:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602442167"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2021 18:17:02 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 18:17:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 18:17:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 18:17:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 10 Nov 2021 18:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0u3opf0tpEYpFzi1+pKz5uyNqZNqL4dy0r5xjq8CJ8bbqZXBYRXFmemfq0pSgdpGE5RPRaPWTQWlEHvI2mndxoz5nPaJFt/xnyq2TLQzYCZpAmV6FdkuAeJyJn10iFls7LyYrGQfAFzBKHbeV00BLPp4v/hvRdgcOOm4mkVrJjh1L8skr8Yz7BAqAtARfTshzYo6HgGQ4mtbWQ9bbhjnm6xgFQdcjhlCo3fd3n+fnfVb8rod7Lm2100jtRXk+2enVm7zMZO1OjyS26rKZUyW10gZ4mP+7Qt0I2awW9I4xSmmBZD6/B8c2jfAEqusjCBF6LwRn5sm3xPxNM9awpmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUbC9S47jybMLfNwi/f1oYM42o5iDCru89aK7cUXYSA=;
 b=dP8tv2F4CYycfnshS+TNYCGJlewPzgInPRk6svhOoaUjb1jCiwGZlmWTrR69GynUQlia5CVuRpTQOR5ax6rsla3rLHALZkwdgrgdCExOM+iiO/Gvc9gApaMOVI3QG3VMGdvob4Eibn08oXSBgl4RMZYJJTuoIhQ3tqaY6i2RhW/cOWk5ozJlbXF1+rGgvqs+huawFb9fIk1qKi6bwUUUm8jspkqd9PKUVOo1NNR3WeipGSJ/BYgd8zp+1VTUrP3Ihe7Azas05ZAGZIRV06f5cIE+znG0QZ8QRWPMrlrQjcONvLeVfC1FJKh/DI/aQpIibOjUfue8t0SGafmnRs8AQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUbC9S47jybMLfNwi/f1oYM42o5iDCru89aK7cUXYSA=;
 b=RpLbkYCxmUf/OQDN/Ea13g1kvibz+/aPnFMc7Gln6HME5joEhcLMKTerDfTYCev//JNoM9WicZ4RoxcPIAsHugoBvDmGf5Arxhbl83aijosKPuK+541/NqJd5TA0hCI0COtG2DzWgMsYZaKuSPnWe65MHy1miuLzQ9sNIgbofXU=
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Thu, 11 Nov 2021 02:16:57 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::b924:10fa:2545:d849%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 02:16:57 +0000
From:   "Bao, Joseph" <joseph.bao@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: RE: HW power fault defect cause system hang on kernel 5.4.y
Thread-Topic: HW power fault defect cause system hang on kernel 5.4.y
Thread-Index: AdfPm0b60GGT2vlORua28HBxsdiYnQAnnSiAAUFzF9AAD8bKgABIu/sQ
Date:   Thu, 11 Nov 2021 02:16:57 +0000
Message-ID: <DM8PR11MB57020F3491E508A334469E2186949@DM8PR11MB5702.namprd11.prod.outlook.com>
References: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211109152951.GA1146992@bhelgaas>
In-Reply-To: <20211109152951.GA1146992@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8db1cfdf-6c17-4760-c87c-08d9a4b95694
x-ms-traffictypediagnostic: DM4PR11MB5309:
x-microsoft-antispam-prvs: <DM4PR11MB5309A28C272B8D45DC9A3B9486949@DM4PR11MB5309.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysxZ/Y6nsbnlHzQBEM8u/oVW+dpD/jlPdIENPRMB4Qybonv2WqCm2qalpx0EjSb299ZZvb4B97dKV89763ve/FPiBqkPCkReisKaVikEhD1j3Uj5DV+Wzg6UuPmjk3G3/7WChykLuha1cetxYVoiSmIgs6XtEkd/i3vZsYNewGWwEQNvbiGl1dJEuqsmqNEOeq2HtQGIo0jhAF4k2U2y+dJiBdy6uilGpZ5LtP2m31rQhYFIbUgxaxhOEaUX4egTbd0qTwSRlCQvHF8opTdANdBLqXruJz0fDz9sqJVEez3LNez7gM4Gg06Evjga9saI82RP4TTl3sohbUjfmYPFv1dZjoyUUAMrfPbntm5Qkcc5BdRK+WlIMHc8Df3cZf1jj8VMoQ8R14GK7tE8mkHE6cQqIw55BPQvWUg6VyDoWL5avwnUwQ9ga+HPWN03JrTH3VQa8mSA4eMe+04FR5y0Ew/ZeU9bzgOdVmjTMOZb/1FQOdDDtUyw8u4U87AJr8BaUthMA1Z3ZNAJ9pQwLrBkMygmhUbpZ6clXENGtH15tl3l0q2An0j1SidoDVciC72SQSMHyrGmasXiLFrQ0z+rNqy5A25ix1Q4JxqinTK4t9YbMiJ1xACnCX1u6+4EUjECeSMOIYPMaeYs5V3v7MMaTbuqppOThUCsdbyrN8d3s9CMDV8EKlaWtdhVmGXvSNRbuyiy8mx+zm/7J+ev/Rm7S04IWXjoFD5nFNyeC5AF42el1T67jd9BYawN8tG1e9osd/ZV9U0DpOIvopBlyHOMqKp8MrDMPQ3UOoQNG8BEseQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(66946007)(8676002)(52536014)(122000001)(6916009)(966005)(33656002)(54906003)(508600001)(64756008)(66446008)(66476007)(71200400001)(66556008)(55016002)(26005)(9686003)(186003)(8936002)(316002)(38100700002)(86362001)(83380400001)(38070700005)(7696005)(76116006)(6506007)(82960400001)(53546011)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qWhYD5uD741ffgMP3KtWNQDwPVzpRyA7EVP7Wllp4H5b1CoMGpSm0l7e6psO?=
 =?us-ascii?Q?W5ZZYbmxHZLk94JnMQ8MmCMzqtBau6hyzHUqWwJ6Qt0l18q1on0xZKH0raQY?=
 =?us-ascii?Q?nzYItDv0MK+GWntTorRc6eWLYAepgG/HkliWDV2Yg5WT7iLdj8quuQ3Y6tmv?=
 =?us-ascii?Q?K/3UrrwYzROq1oSrwCaYdrUwKswrWWStFdjR9u0IkyZjE9JTdLVcddCu7rm0?=
 =?us-ascii?Q?CIRybuBkyzwCHUZgpzZQCH4TQM1XxL7cQxpE7MjlJkV4AT4dvH2cWQZ1Ct+1?=
 =?us-ascii?Q?xDWh7uvU9q4YpUt9BSR9w5V+f3wzFxiQVblwk53ezOO5b7/+lseW6ojKXW9q?=
 =?us-ascii?Q?AoNGUFwO5qzEN40raIsm+gLe2rrReYuKys/Tu7xqZDNLxUDQM+ND5olqdTRw?=
 =?us-ascii?Q?DprF5l4cBEn4q0y0CabHsNeJmjwA2F7n4D6mGd2Mm2FxtS6Kx8YynZ24g5ud?=
 =?us-ascii?Q?4bwrE1aVVdOqS17ZUZ9+q3fnI25u5y9WCwB9VJtrgJBlCYLLDMk6fKLs0et4?=
 =?us-ascii?Q?LDkjSN2IU4itIbbcfw1kzYQfj+ZQOdZAJlLv7UODBT1EtsacRk8Gu9FetiA6?=
 =?us-ascii?Q?Xg1OHn1lSCLNVQ57B5PhuYfBPJ3PFmBRlx69DkGoJLdDm6yXfOSMk5GS3qup?=
 =?us-ascii?Q?JfXOjBmwb5QHJHI+K32+3o/lX8bSFPsCJIuIOfvR6llIYZ5/vTkF6QkwB14u?=
 =?us-ascii?Q?KTHOOTJC8TbFO4aMzv10oOtDLOl7s6sNHuyk0WKfiqbWq8Inv4hKofQEjf0Z?=
 =?us-ascii?Q?zKaomj50ubeH/4wG4oBgMBqVZFsr0jpyJOPZ7AOHO5LDgkNZmIrnnDP024gr?=
 =?us-ascii?Q?wgUVF2+qcD1TF4c7wjbOhONnjmog8oNtRI470Cmmu6i2TQikws0PPR4rYNot?=
 =?us-ascii?Q?6Obc7yhTT+elErrR/KquqVwqz/i+ei6s+GLhLLnPZmV5/MbbVwVYM56IU9wF?=
 =?us-ascii?Q?zokal7I0dkBTXJeb0/akA1D2yrJHiwV/lQjDU8RJlLJoHGODw5D/4lTjfAWB?=
 =?us-ascii?Q?Bfh9AuAHbGZ90eYg0c9dMIUskTKFWd4sbkOHqZ3wV8LE0d48PkZ8ucd5D67D?=
 =?us-ascii?Q?ycdsNcCtjgt62sLrifQb5ZcFI1/EzoLact2OmXryy/lIOpGXsU+tzqZN9Am8?=
 =?us-ascii?Q?VKSq5wnC50F/E8DnAmsvzoCBN9EEdsPblsO/VMlSXwa/VhzA4Ii1YB3YQFe1?=
 =?us-ascii?Q?49DyjdnfQ62JdwCCdvwFJPDBhgnV2OnEyUIEvoauH7xROYND4LU9JpCrde4d?=
 =?us-ascii?Q?ngE4DbVBfn4sKyiHCUEueqo/DNH1qgpPsV1VggoTyCa/pmEOEjpxLv9pYfOx?=
 =?us-ascii?Q?qV65dwgx3kgKAh0idiIZw/TitP3RaiqVIN02N3BQ6/iX/cTqpQKH9e6KwOe7?=
 =?us-ascii?Q?V/7VQPuPhKWrJ2nNnpsX+rmppEEXokTR9Im0My5TzXLB95Ku75Nlnvgt0NOX?=
 =?us-ascii?Q?3gjXrzpd9HLMp+XOsnI2VFwk34ih6hnKv5gqyaRrTFcPRcdcWPGkz9J+j4A3?=
 =?us-ascii?Q?LBVuUykrwr9jyzGpdrXJGX4+3Hnj4Ja3/neeMGT9L14RZwh8X3LjBWZ7U4A/?=
 =?us-ascii?Q?03wxOcKrit/1pYC4+iP0Y6VON4ohOUHSno7fffrW5QHQAoe26b+Rk9LvRjFM?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db1cfdf-6c17-4760-c87c-08d9a4b95694
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 02:16:57.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Px9jkoTG/IP/KumTnkXU/scltMv4p22WIe5W8P7SKBnFcQm8rTLUU1N+4Chh9Dmp3LQTK+zwo4ef3trRtxBN9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the encouragement! Stuart already helps patch the hang issue, do=
 I still go an open a report at https://bugzilla.kernel.org?=20

Regards
Joseph

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Tuesday, November 9, 2021 11:30 PM
To: Bao, Joseph <joseph.bao@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Stuart Hayes <stuart.w.hayes@gmail.com>; Lukas Wunne=
r <lukas@wunner.de>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y

On Tue, Nov 09, 2021 at 07:59:59AM +0000, Bao, Joseph wrote:
> Hi Lukas/Stuart,
> Want to follow up with you whether the system hang is expected when HW=20
> has a defect keeping PCI_EXP_SLTSTA_PFD always HIGH.

A system hang in response to a hardware defect like this is never the expec=
ted situation.  Worst case we should be able to work around it with a quirk=
.  Far better would be a generic fix that could recognize and deal with the=
 situation even without a quirk.

But I don't know the fix yet.  I'm just responding to encourage you to keep=
 pestering us and not give up :)  In the meantime, it might be worth openin=
g a report at https://bugzilla.kernel.org with a description of how you tri=
gger the problem, and attaching the complete dmesg log and "sudo lspci -vv"=
 output.

Bjorn
