Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00801636FA1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 02:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKXBLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 20:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXBK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 20:10:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011FD9BBC;
        Wed, 23 Nov 2022 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669252259; x=1700788259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V3X5jI8zp3d72G+xOsXV8gkMOrGS48J+DF+tsMhu1To=;
  b=KouqH+PSl7qhBNNLtKUvOp+FEBgkN4pJWbkSFpznJkU/DWLeuz04/qgP
   doNBaFXhhBnbb2v3hF5WL+gzcPVJ1Mgthd5Ll0DcnzBEMdS6uheMRaaYZ
   ny98iWH3VMeq9MHhj1WBDRRXIsEyUNk2GvwczsjTkesh08SdV+NQKeyvJ
   D8qHjVyTD0fEZ919eW3+RlNMUU4LIK/l41vFNaqss5B3JAU1dKz9oUeop
   PngwU4ftUrygw7WXt5UBS250RIJOQnMSC7D9T1e1JTYc59tipqLlkc8xi
   Ik8IZNtV/CAqhV2YqAbWMRTn/Lev3n/Pcv8XCHzXsNpiojJePtnCvUhEZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="400481978"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="400481978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 17:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="673061630"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="673061630"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 17:10:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:10:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 17:10:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 17:10:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+u20bYVVpHe9vJNA1zI0NnByzPbenJL2OrSztTNU/IGbmCtat1bQaSMIYsjiOOpB0EIQRYyY8UGO0TK1VgeqArGZKgpdocnsiifdhANHt07GAvbvihdccI/gGcaS46Jep/D2WmzZeUjq+Gx6hZdoAGsK6E2/cI0g5E1t7KAnCA4dXryO6B9lxHRjGd5wEa8kbWKE+VK856luKgVoAsAandnVf45i3LBH8JAlsELxmbUvbQhRSSr2OoQ96iE0L+hi8gtn1eSfAmpCqtNUxSXtLZTFs0zX7cUmd8PbEsfi5eS+2jGj6Pi50q6w5suAl0GQx9fg6ot7ZkJi1h0M2W2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3X5jI8zp3d72G+xOsXV8gkMOrGS48J+DF+tsMhu1To=;
 b=l2N0qLZL4LLjHJ1GZYVlO77s4wUrg7Tnlu4n5hD9WNrYGmS2iJzzfLL7EpI8o6m2JpAXb8eJsV7fvfkti1kSD9/MH+G5n+XXhcxTiKD+uQlYF6Dc0gl+3jLaxMWYMAgiVAdlQD+JqO0xK8j11NxF/LsANDWaowpcmPyxwnkOo3ga3pyWco4FiwKFZ9+5uhERV0pJ34rJHrr0L6P0LVED3C6kJBAUA7EtwPVrnfVzXM+6Q46rSHQg3F+7QxHvp0EQlpfdo+OCRkfhMPtwrTtpXFStxehKdSmLcNUmOxUjuxJiZxE8Bwda8A6ogxh6u5x/hHSSkEdIEKNW2DTnL4ZNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 01:10:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 01:10:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 13/33] x86/apic/vector: Provide MSI parent domain
Thread-Topic: [patch V2 13/33] x86/apic/vector: Provide MSI parent domain
Thread-Index: AQHY/bbt5YvI6UGKMkmsvSCG3w5Tb65MHIMggABq1ACAAL/ZsA==
Date:   Thu, 24 Nov 2022 01:10:55 +0000
Message-ID: <BN9PR11MB5276F1F9198119DCC97E2F868C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.217466288@linutronix.de>
 <BN9PR11MB5276223A2114DD96420C7B1D8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87tu2peqj1.ffs@tglx>
In-Reply-To: <87tu2peqj1.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: 26c26999-21de-4e3f-47a7-08dacdb8bd23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/uaBhyJVPY2vtOjVPQgSshEXvF4ipPBZwAOfMQFfQXSUTwAmq3envbCup+mA/4qTKuqzJNtaIrtleVcGdHZy46ztVcapEOxoAVeEfQyl56zhpMGJSOT7K41YdbonO+uWR23FoLa6XMURZp07JMgqirRJoIyXn7zwk3B4057JRVUk6aLi8NuZEr82678x7S2wiJiYGO/gSBQymNBXIuJcsLWG7pYKWqRPkLOexuPAqK7UEu0d+wWWAiTVD+6+EKcfRhN3SvVknGUkg1Er60J45QlL11sLwwgt226D3Pu1TGrpfLeRB7hSMi/QKAa4b9dTDO3EMa4UthVb9QYlNe0Jph4NDiNe0stJSNoMH7WnOkdoS8rN4tLFggRu265XbWIoyC7rXFytT/KwdsfXpdBDKjUY0RpQ3CT9i8maTvIAkmCM5dYnnmbD5YO1Ck2BIEF2HF3+7T+wEYr2K2nAYyim5p4SUqSbC7kjX2ls/pKMatFYu6g+rISxybSzcnwPCpY6VvAQi+Zvx9tqxG2cUfG+HjFOJD76uPKK4R4bx4yx/XZjODMIdfAIJ53mHrNhq0W/fz1556BL6rrlHy5RmKoghPZIU8jzO4ih0TlqTetqKzxBiqZgNddJPN5iDrbcx+1YYTE17G2dPytHtg7ln9hrMaxYNocoLYFtnm987F+9z47JJarEA0oRYTCyZjhRjKKMdt1idWptkAVQmjSRtnMSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(9686003)(478600001)(55016003)(38070700005)(6506007)(71200400001)(186003)(26005)(5660300002)(52536014)(86362001)(8936002)(7696005)(41300700001)(2906002)(82960400001)(38100700002)(122000001)(33656002)(54906003)(7416002)(110136005)(66476007)(76116006)(4326008)(8676002)(66446008)(66556008)(66946007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzYwS0taUHFTQ0dPUVhZOHBXZ0s0RVg3SEZlU3BYT05tRGlzbi9qZVhOTEE3?=
 =?utf-8?B?cC9aSWo2V2tHQ2ZzUDZvcW12VlBhYVFJU3djZ2grdW05dGNZdlpVbE02NndD?=
 =?utf-8?B?RkNkS3NxbFVxeWl1OTU4SEkzNlVhb1NtQk9jaCtTRS9EKzd2SjdqUmlrTEIw?=
 =?utf-8?B?VHJwbklrREp4eDRNM0JSUDEvcExiVUpVYkkyeE50dzkyYjhvK2tkaXRaSkZU?=
 =?utf-8?B?bUE2azVzaVpFZEc0ZndyU0I1ZG1sSFVUVEw2OGJ4bjNzNFJhc3dtWVl6SmZj?=
 =?utf-8?B?YXE3enViWEVmWDh1SEpaWE1ROW1YektiUUs0SE5wdmhlZmNQTTFOQ200bHRr?=
 =?utf-8?B?SHk2NFJQMDd1elM4UTNlRDdzRGttS0x6blBpUmtpZVlxK3ZKNHJaS0p3S0U2?=
 =?utf-8?B?WUk1aDJkSVdiNzliaFBOWVFOb1RvZDFoNGVyUjVnVm1rcjczazRlbkpIZGtB?=
 =?utf-8?B?R3VDR2JBU2FwNlNqUkFXV0NwNWlrTjUrVjZJbzRpQ0lxUHoxTmlZQTVTdlV0?=
 =?utf-8?B?eUtPMzlhbXRRMCtxYWJjbHdmMmc0OUUyOGQzcFl4SmVERUJ6ZWE3cHJFR1Jn?=
 =?utf-8?B?K1l4SFltNGx2cUNwOE9JT1ZGYVBBaXYzM053WStNVndoY1dMQXJwRFFOWXVM?=
 =?utf-8?B?Nmd3Q09aTXpjN2h3dkQ5ZjI4a3ZCWTJ5elNPSFkrUngwZWV3NEpEWkJEWVhQ?=
 =?utf-8?B?eWQ3S3pvNjJ3UkY1NlFLUFhwUnduamZXcWF2aGhucXliTlY4Z2NwUVdsdGlW?=
 =?utf-8?B?aWM1QnRBVDVxKzdNSGd4eUJtUWRqcFJrb2FacGo1d2VTcXJObndJc3Y1M2ZF?=
 =?utf-8?B?eEVENk5JQ0hNOTFDeGNzSmZjVkY0SWFtUWUyZHBsWThheXM0RUs2RU8zVWhG?=
 =?utf-8?B?a29xVWR2SDljcHBuSUMxZk8xejJHZlFsbGFjRXQ0RFdzQVVGaWR2ay9ML2pL?=
 =?utf-8?B?NmVNRWxMdW43SVh4VGdCSURmRGVKSHd1WFRqNlhaamJWTmpwWmtpRS9oR3lW?=
 =?utf-8?B?My95YUlRRW9YSmsvYlhGanhKMGZuTm0xd1NOenhUM3JYSzAwNTBXbEF5VXFF?=
 =?utf-8?B?T2YwdG0zNWNkQnVnL1F3QzMzRmpuNFRLSDd4MjhmS0huZm5OeVZRd3hBVy9S?=
 =?utf-8?B?Vng2L0xYV2lMYzF6TkFKMC9xNHVuN0ZONUhhVllLekpncHBsRFF2SXMrZlVi?=
 =?utf-8?B?NUxtdjFsUkVROEVPTllUWk51U3ZWbzhja3dCZ0pQeTZuUTNWRzc0SFJTa3lz?=
 =?utf-8?B?Ty9aS2cvcmd1NlgzMkxUQ1FlUHo5cnRqaGk4L3hUN3dQZXhBVjRBZGUxK2pa?=
 =?utf-8?B?OUxFZDJEa016VzdjR01vVWdVRFV4TXQ5ZExtOUpDMHBkZUplb09DM3RHTk55?=
 =?utf-8?B?dDdaUmJkbk9NZ3dpMlJLYjhtWU1zOW9waVZodksrQmpic25YaE9kZWx6emVa?=
 =?utf-8?B?N1JMbWE5Z3ZnT01Ba3luS2VQaHRJd29GMGk1L1o3Nm8yWHNmWjBIOVAvS0Z1?=
 =?utf-8?B?L2loV2ZuWFo1dWZPVk5zN1lTYUxncUt3bE1aWGFSUjB1WW40c2ZEeXY1d0Z0?=
 =?utf-8?B?RVliQjZWVllBbWJBd3dUTW93SFMyaWRqdjNvNEtPSHZhWTF5Y3UveTdxQVQ3?=
 =?utf-8?B?ZkZITmYxaGFGNHRCVXlIVTdmUFM4UXVaR1A5NXYwc1dWUnBYTGdxU3RQanBT?=
 =?utf-8?B?K0wwckVCMzI4OFd4MGIybkIrRE1ydStpSmNCRC9wWEZNeWdKOThaU0Y5R0xh?=
 =?utf-8?B?VjZsZC9idUplaWlnWUJ6VHB0RVZEcUxodHdTQXZzd1k1VUJzMU1jZzhnellv?=
 =?utf-8?B?dlRrdk8vUmJsSkF5SzErMTNuajRkaFlBNW0wVzdVL3ZDUmxMQ2RoTGw5Ym1K?=
 =?utf-8?B?R0VxaU1mQmlPNytMQUUwN0ljVWxoYnF1bUNZbGZMWFIrZGZ6YnNkUWVsT2s0?=
 =?utf-8?B?Y1Q4eExJaHFrNWh0cHNxQlpFaEE2YjQzNFZIRFpLZkg0R2hhaElWanQ3R0J2?=
 =?utf-8?B?dWJqdmQ0STJiam9oUm10d3kwQVRONmJHYTd4bnlTS1ZiZjAwRUF2SE5kaTBn?=
 =?utf-8?B?cU0zNHdLdytjWDFtYnBRVHN5bDE5QVoxdVI1VldMZE5QOUVqK1B5L1plOVJW?=
 =?utf-8?Q?2Ot3FMmDzgPZF+afYiXsjaq1d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c26999-21de-4e3f-47a7-08dacdb8bd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:10:55.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKXfGFO1sAapUiZifdHhZuCD75dnza3ATqgN0xFuHYTXtLo/iDnPbn6INSRqCH72xDEAswzbujq7rl6j0uYi1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBOb3ZlbWJlciAyMywgMjAyMiA5OjQyIFBNDQo+IA0KPiBPbiBXZWQsIE5vdiAyMyAy
MDIyIGF0IDA4OjE2LCBLZXZpbiBUaWFuIHdyb3RlOg0KPiA+PiBGcm9tOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyMSwg
MjAyMiAxMDozOCBQTQ0KPiA+PiArDQo+ID4+ICsJLyoNCj4gPj4gKwkgKiBNYXNrIG91dCB0aGUg
ZG9tYWluIHNwZWNpZmljIE1TSSBmZWF0dXJlIGZsYWdzIHdoaWNoIGFyZSBub3QNCj4gPj4gKwkg
KiBzdXBwb3J0ZWQgYnkgdGhlIHJlYWwgcGFyZW50Lg0KPiA+PiArCSAqLw0KPiA+PiArCWluZm8t
PmZsYWdzCQkJJj0gcG9wcy0+c3VwcG9ydGVkX2ZsYWdzOw0KPiA+PiArCS8qIEVuZm9yY2UgdGhl
IHJlcXVpcmVkIGZsYWdzICovDQo+ID4+ICsJaW5mby0+ZmxhZ3MJCQl8PQ0KPiA+PiBYODZfVkVD
VE9SX01TSV9GTEFHU19SRVFVSVJFRDsNCj4gPj4gKw0KPiA+PiArCS8qIFRoaXMgaXMgYWx3YXlz
IGludm9rZWQgZnJvbSB0aGUgdG9wIGxldmVsIE1TSSBkb21haW4hICovDQo+ID4+ICsJaW5mby0+
b3BzLT5tc2lfcHJlcGFyZQkJPSB4ODZfbXNpX3ByZXBhcmU7DQo+ID4+ICsNCj4gPj4gKwlpbmZv
LT5jaGlwLT5pcnFfYWNrCQk9IGlycV9jaGlwX2Fja19wYXJlbnQ7DQo+ID4+ICsJaW5mby0+Y2hp
cC0+aXJxX3JldHJpZ2dlcgk9IGlycV9jaGlwX3JldHJpZ2dlcl9oaWVyYXJjaHk7DQo+ID4+ICsJ
aW5mby0+Y2hpcC0+ZmxhZ3MJCXw9IElSUUNISVBfU0tJUF9TRVRfV0FLRSB8DQo+ID4+ICsJCQkJ
CSAgIElSUUNISVBfQUZGSU5JVFlfUFJFX1NUQVJUVVA7DQo+ID4NCj4gPiBBYm92ZSBhcmUgZXhl
Y3V0ZWQgdHdpY2UgZm9yIGJvdGggSVIgYW5kIHZlY3RvciBhZnRlciBuZXh0IHBhdGNoIGNvbWVz
Lg0KPiA+IENvdWxkIHNraXAgaXQgZm9yIElSLg0KPiANCj4gSG93IHNvPw0KPiANCj4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgbXNpX3BhcmVudF9vcHMgZG1hcl9tc2lfcGFyZW50X29wcyA9IHsNCj4g
Kwkuc3VwcG9ydGVkX2ZsYWdzCT0gWDg2X1ZFQ1RPUl9NU0lfRkxBR1NfU1VQUE9SVEVEIHwNCj4g
TVNJX0ZMQUdfTVVMVElfUENJX01TSSwNCj4gKwkucHJlZml4CQkJPSAiSVItIiwNCj4gKwkuaW5p
dF9kZXZfbXNpX2luZm8JPSBtc2lfcGFyZW50X2luaXRfZGV2X21zaV9pbmZvLA0KPiArfTsNCj4g
DQo+IElSIGRlbGVnYXRlcyB0aGUgaW5pdCB0byBpdHMgcGFyZW50IGRvbWFpbiwgaS5lLiB0aGUg
dmVjdG9yIGRvbWFpbi4gU28NCj4gdGhlcmUgaXMgbm8gZG91YmxlIGludm9jYXRpb24uDQo+IA0K
DQpvb3BzLiBIb3cgY29tZSBJIHJlYWQgbXNpX3BhcmVudF9pbml0X2Rldl9tc2lfaW5mbygpIGFz
DQp4ODZfaW5pdF9kZXZfbXNpX2luZm8oKS4g8J+Yig0K
