Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6F6370B1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 03:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKXC6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 21:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXC6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 21:58:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD95CD28;
        Wed, 23 Nov 2022 18:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669258722; x=1700794722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GGuxLCxBy6/I94cpz6lK1bS6xDzu1VwbTq0H0a4n8z8=;
  b=eHTslOAkSFLtgPhB45hEMEc0r4LA7HYO0XqfM1OgDXSwtUIwDftQfBTV
   WMnV1+vsvr+zSc5jtsiQu4gP4ORtaZ6z6T4LIfZZA61dqvESOFIi/LSkW
   ymwe1wgql8KlTNHIGiW4VDC7Pni0SEI+/MQGYZizNJ/MG6cK5AxI+q9fq
   horBm+Dx0Q5G8M7r8gvvo1+n+zU/Nm3FgSHQ7IGZbFp4kyP7bUdwX1ZyC
   LV8HJwLbSMcMGUN9AZ2CF5WZABRpiCOyiR7EXfb3LxCes9kvMa+mYh8AK
   HZxdRk0W4gcSKw4tvwWsWRdPi5MF9uCK9V90noOMzWi1DD6PFXqMmCzIv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312903321"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="312903321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 18:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="766934343"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="766934343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 18:58:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 23 Nov 2022 18:58:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 18:58:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 23 Nov 2022 18:58:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 18:58:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6H3PuDddMk8uML6Vt0izvnyTumLyWORyp+xmNZyAUCO4VINw7mnTqV0Ui0Uv0ukpLcCY04kvwJzPkU8BSe8qWtW2gPAIVIqywA5BUq540nHSjEZeSR7hGKjvE2Vkvmk8bdXK0+mFiumG/kvrg/EDueU5Hbj8EuDOJmnfM8xonnuRu28TTc89wFfUXUUOJhckK/1gzu6/1RlXwyiH7BB7B7F3cJU5H9+DzG+PHmR/5U+6etsp4GMSA4hDNcZdO7YQw36FgV9lWUiU7D+oQ2noPATVZvPNo6l5mQL96+hBjblyoOMz/UdKIATeNG3YGX2Qv8AIDVl9745HQid5/ApeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGuxLCxBy6/I94cpz6lK1bS6xDzu1VwbTq0H0a4n8z8=;
 b=HnhEPE5Q16qyg0EGxFgP2FEF9KHB3xvWkvosW0mGjLwpWGzhJQp3VeoEvi49r8maa2GPca4CijMDuUBr8E5va2aQZbEm2ZUg0qtS3LrxPVpD2oZy6jw1QFQDRSMzCEb3FHZpq+XxdNYx3lxzZ+Ko5H+2pew0uAM6MBW7POVDHv7cQGG1WMSymRQoywAiJg7RpwcdmIaH/Uiww5ReAB0i2UcLAWtl8AkRbZ3HSkJ5Q7i33j3uXmvL1l9+X/iH1prCrvATyX7n0jaqRu+IctuDZQf41ILJOMOcJwP2F9GUb7OGQjhGrYz1iWLCydw1gK3uP2F9OQCQMMleoT9WSCDnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Thu, 24 Nov
 2022 02:58:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 02:58:38 +0000
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
Subject: RE: [patch V2 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
Thread-Topic: [patch V2 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
Thread-Index: AQHY/bbtFxCOpPjo80emqF3PmRNPf65NVNpw
Date:   Thu, 24 Nov 2022 02:58:38 +0000
Message-ID: <BN9PR11MB527668DB0B5B9C8D8C36C95F8C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.869774994@linutronix.de>
In-Reply-To: <20221121091327.869774994@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5768:EE_
x-ms-office365-filtering-correlation-id: 8bb7d3c0-e4b0-4d15-fe19-08dacdc7c90b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5EVrY78+vUz65FCZMx3bvEj6xlWD5V+x016Vmq7H+KwbcLVBz30xbuhB60ee9RcECNZHwXCs7YkP8OkA+JAsq1e/5WUaq0KdBPgqx3nNAarRf2lXSyLctVe5ITbQACJQTZnDK4Bm1ivAvmKyOwTWRRmRrLBCi2tP2zY4lS0GB93bEHaoFRSDPuyfp95CrfRjcNxIsAHLWItijoTceFN38nrGeIyF1a6ZoyJKORLcR+VgqnznpjkzkaPO7UKwuULNR6gu6ppPSTDpA5zE9RmKzZ4cvBzcHQoEeW3KuXd1hJKej0Xti/B7tBb5w5sa5OJuKl3SOTUpEMh5J84l+LEwoHYfXeg4Lmj2+Sguy/IiUgtpKijE1xl0QSDEDzg4w02u90DaSqy1DPHakJU5HDS44Ps/HNNJA/YUiQmRMZLlkbXaPuxNa9vVi1lnoJSoAUnxUxLkH/JAfm+MN1bV7NdJ3z/Gjp1CFYYqDtmrLaMWOJpLupdG/HsywOG3QAJVw1mrFeoD8LwES7DngCnZKHN6pMzaZPX+OikXbRjedeJvijUorZVM3qutyGFHZ1tfyUhiFZ+FU1+J1o0epGobjCCxLH97BLHgEPBw4z3GkWHwX3cPfMosAjQvvEToR9Y2fHkuII2GVcwD1ACPCZPz/O6OGgiEj6xOjrwrMsgIS+EW2SVpzKsuVWlr6gCoZ3jsU4UxNIAOzbM319gQVRJDRtpEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(86362001)(2906002)(71200400001)(76116006)(4326008)(64756008)(66556008)(9686003)(66946007)(54906003)(66476007)(316002)(7696005)(8676002)(110136005)(7416002)(26005)(6506007)(33656002)(66446008)(478600001)(5660300002)(38100700002)(38070700005)(55016003)(82960400001)(41300700001)(186003)(8936002)(122000001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWxNZC9SVG1aWG1ZU25yT2hvaENUc05iaDZXZ3ZJN1hiK2E2U1RNNDd3dDl5?=
 =?utf-8?B?eDZHY0QvTHJrYWFiOVAzQ211VHBCb1hIN2kvTVBWZkZqS3h6WDNFS2tHY20w?=
 =?utf-8?B?NGZPWURDNGJYT3RMUUVKeUdEclZIbG11Z0VkRGJVU09qREpSaDdYNi9FVU9w?=
 =?utf-8?B?bHI3VUVETEU3YTdaaU1qYk5NWHpFSkc3cDRRNGRCT2xMMy8rRWZZb21sQjJ0?=
 =?utf-8?B?TzBEaTZtc29DdGJ1MExwSE8wYmxsZ0toZXZ2Tklhd1BpeFJxMHgxYllFd2xp?=
 =?utf-8?B?eHNIWkY1dC9Ec2d3dS9CZmtXTHdwejRNOXZia2pUUlJmU2g0YkxwcXhwb0Qz?=
 =?utf-8?B?WmY1YU83VzJydzB0azc0UzNwdXdKc0g0RHpFYS9sS3NWU0FhK1Z1dFdOZjNV?=
 =?utf-8?B?ampTWFY2TkIrS1hJWkRES1JBcjNYeTZQTkx3RFFNQzkrdndlblBGUUFBMjZ6?=
 =?utf-8?B?L0VTeTZwdVp5K0VtSkJuamNXVHFoRmxJeUpNM3lJK1gya3pOOEJLRmxMOFA5?=
 =?utf-8?B?b1pvV0Vlc0prRDhDNDl5UkVyVGRPeUw4c1o5eUdLWVRGYXR2bUdxLzJnLyth?=
 =?utf-8?B?YW9iMm5DZlhsTEYycFc4cjA1TXQ1eEJOalZTcmRzMldMR2hNS05EYnFObjA3?=
 =?utf-8?B?c21kYUFsZzRuVU5pbVNaNG0xUTNRaEpVOS96SDhQSEJ3WkdlZmYxUlVINU1E?=
 =?utf-8?B?UjkrWnAycG9KUDl0YVg1TjZLVmYzNElxQlh5RHA2WTQ3Sk5ZTWNNazVHcnZJ?=
 =?utf-8?B?Vng3MEtTN2ROdy8xcXl4YnFiZkVINFZndk1mVDZ5M2tkc2tSclZHbDl6TkNP?=
 =?utf-8?B?RWRpRWdwSloxUDZBMGZhZjg5bDhsclJIYm01S2luSDdkdFBsZkc4OHoxSzM1?=
 =?utf-8?B?SlZOM3NLb01HUzQxM2thb0lHNTlZM3hQNnFnalNmSS9OSlhkK3dIbTJxMTZZ?=
 =?utf-8?B?MnJDbGsrNFoxY29mb3EzdTBiS0dzM2xSeENUU0UwNjBCZkdxeGZ4M0tvdGI5?=
 =?utf-8?B?Q3cyWCtrNmYvSjRXVlhPVS9wMU5velpGbGNBcFRzelAwS2J0dytVSU9XOENQ?=
 =?utf-8?B?YTF0OGpvdFhBbXFSOGN5NXM1ZWQxUkJQUVFVYm16bXlEZkJZc3MwWHJLZjVj?=
 =?utf-8?B?bFN0KzVaSkJFZU8vRHdvZTZwY0NSWHJabmoweE1hK2wrTEZXUXNzenJONmtk?=
 =?utf-8?B?ZjYxUDZjalNIT1dZQnkwbXRxWEFOcC8rNFdGUXJSakpmRFNlZXd3a09kaElz?=
 =?utf-8?B?enZHa0ZLVlRqb001OHBMZ2dkU2U1bjV4bFQranVSOFAxeEZEaXJ4ZFVYRElu?=
 =?utf-8?B?TUR4T3IxYURBOW1VVGF5bFlBcjNOei9wZmdudzVQb0JJY2M1RWQ5eFdJblpQ?=
 =?utf-8?B?SEV0RElJZERrc0VpcDRqUW9CZGtIWjMxQ1QvYnptRU5sTk5YN3poVVJSY2pi?=
 =?utf-8?B?aHR2eG53YlFZWi9adzNlNXVnMEFWMnhZbktVVEUwcWdhMnE1Z2tRVFpMK09a?=
 =?utf-8?B?REJnRUxROFRKb0NCZmZhQ2JIaS9JaWMyL3JxWVhzNlZCMzVwWVdQUlFHNity?=
 =?utf-8?B?VlRnSWpFb3AvZndsR2xoeXY0MkxJdEM2RUVpTFpRbVJmZi9ZMndrTlpYNWV6?=
 =?utf-8?B?VVFJcm1vV2tvWGRZNmlZV01SZ2UyNFR4OEZ5VE1pdUwvSHRjYjJWMmdhUTZ1?=
 =?utf-8?B?QnlsNFlOYmR3aHh6ZW16Sko1MDFoVG4rQjI4QlJMVlpMYVZ5YmR1WUdDTFB5?=
 =?utf-8?B?Q1JiYUtka2p2b3NUNnBCWEVCbE9tSHh4UFQyMjdXcDJnR3ROcm14ZExRa082?=
 =?utf-8?B?NGYwMDBpZ2gxbWpWU05TekV6R1phbmwxeERQNnVZM051Vnl0dVRoaXUxV0Qw?=
 =?utf-8?B?aVh5d0xEcHZKc0pUNzhEQ3VRaVlvRFZ3dG9ob0ZKeHo3dzNCSTExR0JEZ0ll?=
 =?utf-8?B?TTdiSFY3eS9sOEFLUndDanNhQkFrUVNzaUZEdUx3bnduSTRaM1BtVUNYbTdv?=
 =?utf-8?B?SDM3bzcyYnRDL1JmUEpxSE52TzEzY3MwT2FCTGJ2NEo2SzF5QVI5SXZCdEVU?=
 =?utf-8?B?SHorS0V6RnhkeTJMUyt3VHREVUdYMjZjWXpNTk84Uk1QSGNnUm4xZ1o4Q3kv?=
 =?utf-8?Q?0TtWuizVhkeUCqVoL5CkMs8cf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb7d3c0-e4b0-4d15-fe19-08dacdc7c90b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 02:58:38.1382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMDfpLuQeW/uAnxp+ppQnO5UYYyDgdUQEmPXgUqpc2JBWP0xW2LmDs5RONGWo2qOQ2x3Eig1t06lYfjkCP7Umw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gKy8qKg0KPiArICogcGNpX21z
aXhfYWxsb2NfaXJxX2F0IC0gQWxsb2NhdGUgYW4gTVNJLVggaW50ZXJydXB0IGFmdGVyIGVuYWJs
aW5nIE1TSS1YDQo+ICsgKgkJCSAgIGF0IGEgZ2l2ZW4gTVNJLVggdmVjdG9yIGluZGV4IG9yIGFu
eSBmcmVlIHZlY3Rvcg0KPiBpbmRleA0KPiArICoNCj4gKyAqIEBkZXY6CVBDSSBkZXZpY2UgdG8g
b3BlcmF0ZSBvbg0KPiArICogQGluZGV4OglJbmRleCB0byBhbGxvY2F0ZS4gSWYgQGluZGV4ID09
IE1TSV9BTllfSU5ERVggdGhpcyBhbGxvY2F0ZXMNCj4gKyAqCQl0aGUgbmV4dCBmcmVlIGluZGV4
IGluIHRoZSBNU0ktWCB0YWJsZQ0KDQolTVNJX0FOWV9JTkRFWCBhcyBkb25lIGluIG90aGVyIHBs
YWNlcy4NCg0KPiArDQo+ICsvKioNCj4gKyAqIHBjaV9tc2l4X2ZyZWVfaXJxIC0gRnJlZSBhbiBp
bnRlcnJ1cHQgb24gYSBQQ0kvTVNJWCBpbnRlcnJ1cHQgZG9tYWluDQo+ICsgKgkJICAgICAgd2hp
Y2ggd2FzIGFsbG9jYXRlZCB2aWEgcGNpX21zaXhfYWxsb2NfaXJxX2F0KCkNCj4gKyAqDQo+ICsg
KiBAZGV2OglUaGUgUENJIGRldmljZSB0byBvcGVyYXRlIG9uDQo+ICsgKiBAbWFwOglBIHN0cnVj
dCBtc2lfbWFwIGRlc2NyaWJpbmcgdGhlIGludGVycnVwdCB0byBmcmVlDQo+ICsgKgkJYXMgcmV0
dXJuZWQgZnJvbSB0aGUgYWxsb2NhdGlvbiBmdW5jdGlvbi4NCj4gKyAqLw0KDQpDYW4gdGhpcyBi
ZSB1c2VkIG9uIHByZWFsbG9jYXRlZCBkZXNjcmlwdG9ycz8gSWYgbm90IGFueSBndWFyZCByZXF1
aXJlZA0Kb3IganVzdCB0cmVhdCBpdCBhcyBhIGRyaXZlciByZXNwb25zaWJpbGl0eSB0byBub3Qg
bWlzdXNlPw0KDQo+ICt2b2lkIHBjaV9tc2l4X2ZyZWVfaXJxKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IHN0cnVjdCBtc2lfbWFwIG1hcCkNCj4gK3sNCj4gKwlpZiAoV0FSTl9PTl9PTkNFKG1hcC5pbmRl
eCA8IDAgfHwgbWFwLnZpcnEgPD0gMCkpDQoNCm1hcC52aXJxIGNhbm5vdCBiZSBuZWdhdGl2ZS4N
Cg==
