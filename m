Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCE63A0AF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiK1Erv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK1Ers (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:47:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02002AEC;
        Sun, 27 Nov 2022 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669610865; x=1701146865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r9m50x9T9EQz1SieoGISMBaPt5cQ4ecaZRyHP7SxZ7s=;
  b=Lhg1mY3BsZI3lWkUdDuuKjeOfY7DnzOPAFkuJMTTYTYLCt9AWBHfKjxd
   YR3bSZafFKWSSfGBUk/JEAzQc3LJk1+AMNsdGl/q5fAaRDkiMf6mPgvRq
   NFxkkP2eV5IBTEzxqxhUjn0YzSJpe4j3fzjE9iCJJnCTCfVvocH5bB7T3
   zFII2oTolksuZnfzLM7hS/Sf1JHF/27A/Qb6KyGdaAcEPxJXaPn5fkwrj
   RKJ+4pY6z7JqN7IkJoDKMMw/2cmX2SVnr5kOSvIzPpVNxDiafNneDbC4S
   q3XnHhGT79HGe0IUfPvPrvHbkAWK5M+7mdt1nkaRgtMRwhf9UR0lVBMFn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="341657472"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="341657472"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817685204"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="817685204"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2022 20:47:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 20:47:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 20:47:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 20:47:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 20:47:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i06circ+ZQyfhQ+AIYXlI2Axl81l7YjPvQIbpuSbPQ75AEbeCuo9k5V/I30c7rkJW8N/MxTztaHvDWAc2MYZZZYuGKWHeCuUxPEfgliOG0maJoBJGoV7YfU5nYXQ9SJyaIdOKq60yfHMU3Qw+cmEoQmpwhvi3kQzGEBIp5DDccHN0knMvo/tYCutXt23ozd1LhnZ9AtR2Pi9DjfVXUthJ1XFz1wqGHRas85l8TLF+rB9go4/ch9Etkh3bYtcZPk1XX0xfyQ6gRX8cpt9uFfxrp5XlCFYk+pltAtJo6IG8O+Lrs8h6zNb/q8JUvoTUQgpb+YO7aCTmwsQc1EB58OnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9m50x9T9EQz1SieoGISMBaPt5cQ4ecaZRyHP7SxZ7s=;
 b=W2QCyfXQ86ya9bUDzk73temZu5vPRaWOFrYxTAM4/xGqorhXm1gcNzfwrDhYJDvjQ7Gl3/McbK59Y8pbVzzX86C0VFcsjqHkryEenM+SfHGSFOfOwjOaCfidPcgSin1gnlo8sn8XStqoHWqfeTRzFQMJik8B1MYMDWucw9cPqhmza/oqVIEdmqCehUx92dyp6Lu7mWdIkV+trfnsOOUl2CXakV3Pc6y5CDfcPIdQInQ3Y3tuxfWAKp14CrA2KthQe4x1H5zQ47Yk1vOLSqVQS6yF3mXE0w0vhx7rFTdqUBjdMAA57oec3LSl5H7cNf3wBdlPqXfETh0rudB4bA+ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 04:47:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 04:47:42 +0000
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
Subject: RE: [patch V3 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
Thread-Topic: [patch V3 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
Thread-Index: AQHZAFw2ZUio7g95tU23Q13FaE+QEK5TyAtw
Date:   Mon, 28 Nov 2022 04:47:42 +0000
Message-ID: <BN9PR11MB52769C45692D70021099966D8C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.961711347@linutronix.de>
In-Reply-To: <20221124232326.961711347@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4673:EE_
x-ms-office365-filtering-correlation-id: cbb3b191-26f7-4983-e451-08dad0fbaf55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iu8rKujvH7pUtjIJMgNaIrEG5tAGNWMwFgYjM2ItOrIc6cWXMq1ivjJXDl4/PMSA96pxxRd/plArsXkt9IxtOJ9f9QfZCO+jRu8OwlgZidK8P79FBJrd9KO9ovHmtDGVujj7r2oIVIe/nbIuSx0UFH0+4qI1M+OsaSc87xHc8mGqEkgNAyHtl6ylO0gqhLX9mokyfMOLJKmeVaXVPXFBjnn7Fssth5RFR5xTsx5sRWqC22ZSXhn//3Ji5pL1FsAZNpzDSG3Sz12CLh1XNdLpKyn5K31A3sM+7RmWZ7yVrqzt0hr3Zh/+LLoiPvfwH6hmUVkxBZ+YIUogIshgj+1soDPHg8rieN6CqnfLWuytdapsiw90AXuj1XkpRyRI9uk4ahhNYscJa3ybeyqW3V8+KX41dNbnVenmG2dNwRM+CJSFqm/IfC4QrXgyI23ope6tAMjhhGFFxatUweL9FUrP4QKkNPCC+ah8+LCTxOuUKjnjpUFB998CcRaLwcacLFG54iSFpJY8zzUaDX0+b+jaMq7/W4OkcO1G3BCrcDOcRXvYPj9tMQSWDzpD5QghnOZru9kku9Y8a31nUgp6mIrBwFTKRCM8hyfqNXzCACrjRhaMTWIsf+BCcnNmANaon9qCj7JVc4gJNc9L3+tlEl6Tdmv4ajNKT0staXkS1V+4wOgahjDBMsmnq4YRhQoxx19gHbmyqAWArrMsES7wHh+UTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(2906002)(38070700005)(478600001)(8936002)(5660300002)(52536014)(186003)(4744005)(7416002)(86362001)(26005)(6506007)(316002)(9686003)(7696005)(41300700001)(82960400001)(38100700002)(71200400001)(55016003)(33656002)(54906003)(110136005)(66446008)(122000001)(4326008)(66556008)(8676002)(76116006)(66476007)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2ZtMy9Ic1Q1QTQ2eEF0Rk5nU3JiZXNnb3BwWXo1a2JiNGF0Z3RWOFJoZTJX?=
 =?utf-8?B?Qk80QVlWSGNVVkZVb0JsWGRrbk1Ydm5MZDB4OUs0QjNacThwNzZLUE01QnBm?=
 =?utf-8?B?S0NKVVY3NXRIVm1weFdobzdkTWJQMWNDOXNqWWF1eTlUV3ZGRHYydS9QdTJP?=
 =?utf-8?B?OTg0SDMxbGVja1pwWkFhV0NrWlR1TTNZa2JMLzR3ZkVyYWFKaFpYSGNxZ1Jm?=
 =?utf-8?B?S3BYS09BMlFTVjU5dGlnbi9tcEJUKzZaN2NncjJBT0puZjlIR3NQeFhCMGUz?=
 =?utf-8?B?RWZLdldUbnA4cTgrNFk4aDdiMFlwamtlVDlCdWNIZjcxazZSb0NTeStPRnFs?=
 =?utf-8?B?c0h3dE5GTm1zMG4zQzhyZ29weXg3UjV4QWFiY3EwRHBnb2FsL3ZyRkVydHJt?=
 =?utf-8?B?dDdYTURkcmRUQmo2VGphb2M0eUxOTlU3WGRRWGQyRG8ydjJpU2xsV1pWNm5P?=
 =?utf-8?B?MmdYU2FnWjhJTEdTQ0dhcVRQQWZ0dE1nZVNML1FDUUZqa2U4b3paYWI1cUxp?=
 =?utf-8?B?ek5sYlVCUmRTVWpRY2NTaXdPeGw4amZFTXhWNHVPMk5DbFVKUU1Dc2xOTG4v?=
 =?utf-8?B?SmVxMFVIa2xjRlVDZ2cxZFFYaVhJZUtnTmN0MGFVRk5JVzZlZG95c0tIQjRI?=
 =?utf-8?B?R1k1eEVKT3huMW5vSktVUEg3c3hjMGlMc01QOTlWV2pBNFM3SWloZ2t5Vi8z?=
 =?utf-8?B?ZFJJNStYa0h4QmhFaXBnU0k1MXY5b0NzazFob2dVOEcrMGhqbE9KNjdsUmtu?=
 =?utf-8?B?eG53dkJzYmVvOHJWRFNaaWhLNkdUd2JiV1B5TThRdWlHdWFzTUFYcGVTdnVr?=
 =?utf-8?B?MW9ZSThNa0ZFd096WUVETjNaczVhaDM1QVowUU53bXpnejJDMlUyTjl4aG9T?=
 =?utf-8?B?SHJjQjU5cjU2RXkxUXR1bWkrNk8zR1RubmdKaVFHMVZkZnh4YjlDWTJlUnRH?=
 =?utf-8?B?bnR1N3Z3Wmg5d3ZKa2M3YzBXcHJlblBXK0JCYjVrMkpiVWRtazF4ZE9lT1JM?=
 =?utf-8?B?M00rSy9ldFFWRjdGTmx2eGlPTUcyMExMWTMyZHZlNndnRTJuLzBDaE5WZGpn?=
 =?utf-8?B?Q0ZHQVZscjM0SmlxSm9KT2x3M2l0UndpNVFqM3pzRXlHUzNFcmZua29oWG1y?=
 =?utf-8?B?RFlSRnhQYmFleGFxMGVoSWs3NDNmaFJha0xFQm56ZXlibDMxcUlYaUp1RzY5?=
 =?utf-8?B?bmdNQjcwQ29aRW1DKzVmd2JDaXRrbDZ3Q1BKeDExOGhzdWM4bFFucmcrdkNU?=
 =?utf-8?B?Qlo2SDNhK1haTnRzazBCSytkYlhZNzQxVnJGN0U3Y1JPSC9UUGR6THhIVEYz?=
 =?utf-8?B?aHZ6Kyt2QnJxZjRiVDJTMjdZUzJwY1lubjZXU01mRWdVa20rb0JhMUorbktW?=
 =?utf-8?B?bXFyRnB0UldWZlpsZmxsRGIvd3R4bUFjTVJJOTR6WHJmZFJidDlTVVkwd1lR?=
 =?utf-8?B?SzBwcUhTSHg3WklVbzJhdFJMZFVmOGdpYXR1ZXVBUElnc3BtL2cvK2Q3RjI2?=
 =?utf-8?B?elVjSlh1SWs0dTdMcWVERFNVYWtvY3NOMFpJdUxqZE5pU1Mzd3NTbm9INVZI?=
 =?utf-8?B?VnRXUFJwSEFjMkZKRWtZWFRNWDJnRUt5TFBkMkMwUVdwVVVROWp4bU5KUDk2?=
 =?utf-8?B?M1dvM3MwbmZOQVVNV2JxVzZEYkJWYTc4ZU9oQ0hYdm1IQUIvZi9iVXh5bnNC?=
 =?utf-8?B?NDNOVjg2VldVODZuVDAyeDdJVDBBdEYvZTBmbVVCSGdPVzFkbEVqem1nVnc2?=
 =?utf-8?B?RnhsK05Hd3M4RUJ0Vlo0aGlDQWN4SzRMdDdDTEVsU1B0RCthTTZmWi9icHVk?=
 =?utf-8?B?N2t4aXp5Lzl3VDFLcUcwWFRtRkg4MnZrYTBCZnRBZVNWeXAyZmFYQ2tmWUtZ?=
 =?utf-8?B?NktMVE4wRTRFZVdZK3pzM1IveXc2Uy9OU005STVybDhXMkd2a29YU1pLMzhM?=
 =?utf-8?B?SWNsQS9rSG1DVUQreW9HYU8zQWFEdHAvOXdDM0N3a05GSnVKdm4weUZnVjVP?=
 =?utf-8?B?UWdFSW13a2cxWkRpckpEeWY0OW8rMWN2cWNqUWhJUlJWcGs4ZVpRdk02L3Q2?=
 =?utf-8?B?NFJCeTl0NkZhQXBPdUh4YklYTW1mNURRT2VmaktaZGxTZC9GUlJyVnU5VHhm?=
 =?utf-8?Q?+vhjwdDzLO6LARQ6CQ9KEcnFK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb3b191-26f7-4983-e451-08dad0fbaf55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 04:47:42.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: keV7aJA/4FyuXdeyU+iNz/tzBpV+6uZ9P5jMR53DLL6w3QHixxRNoOZE9FdQwqSDvFAVJPc51pf5BpiDpzMYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAyNSwgMjAyMiA3OjI3IEFNDQo+ICsvKioNCj4gKyAqIHBjaV9pbXNfZnJl
ZV9pcnEgLSBBbGxvY2F0ZSBhbiBpbnRlcnJ1cHQgb24gYSBQQ0kvSU1TIGludGVycnVwdCBkb21h
aW4NCj4gKyAqCQkgICAgICB3aGljaCB3YXMgYWxsb2NhdGVkIHZpYSBwY2lfaW1zX2FsbG9jX2ly
cSgpDQo+ICsgKiBAZGV2OglUaGUgUENJIGRldmljZSB0byBvcGVyYXRlIG9uDQo+ICsgKiBAbWFw
OglBIHN0cnVjdCBtc2lfbWFwIGRlc2NyaWJpbmcgdGhlIGludGVycnVwdCB0byBmcmVlIGFzDQo+
ICsgKgkJcmV0dXJuZWQgZnJvbSBwY2lfaW1zX2FsbG9jX2lycSgpDQo+ICsgKi8NCj4gK3ZvaWQg
cGNpX2ltc19mcmVlX2lycShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBzdHJ1Y3QgbXNpX21hcCBtYXAp
DQo+ICt7DQo+ICsJaWYgKFdBUk5fT05fT05DRShtYXAuaW5kZXggPCAwIHx8ICFtYXAudmlycSkp
DQo+ICsJCXJldHVybjsNCg0KIm1hcC52aXJxIDw9IDAiDQo=
