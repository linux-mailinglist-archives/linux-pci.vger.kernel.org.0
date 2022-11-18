Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3510B62EEA5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 08:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbiKRHu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 02:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiKRHu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 02:50:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8A12D3E;
        Thu, 17 Nov 2022 23:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668757826; x=1700293826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uwRPtsGCmlg8qy8s5YuipBL4tvbP2X2vveWEMKDnjL8=;
  b=XqxGnDRBNO9Qjjz8Wxa/QToAAoZPC4YEhjKiwFHxJYA1E0v9apZEmM8c
   5QcwGacyOPfgPkjI4HOWstyspCwGws4ZmOA5NSC/+IQHMiasS41exQkYt
   y30WPkm7uv779tOctAs5Pny8VsB+9/syE4Wjkncrr8ze9zYqrkIcWymxw
   cyIAXTfAZlN0/2cEkosmTA/L5FVFSAxoMcR230y4csI0l7bKrLAS6ak8t
   EG9dPl6Pz26MqRmM+IPIpbUlObEbIQR4IEg8AMhPW1UKg7LZ+RdRFGWD+
   dAwHrsGYtMV/CQjx1+XAKl40TTGqY5SxNKCH9rwEeK1zKP2GwSVSlBlvm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296443436"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="296443436"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="673117268"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="673117268"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2022 23:50:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 23:50:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 23:50:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 23:50:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 23:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXsuiZm34sEVHeDui60TT8RwhkDG531Isv03jNZiprSBYAfFWtvkJn5AnrlgxF99upsDcs2S4VAVSEevhBy8UjKsR7I7IG8IUwa3P5cvKOyRdpaLiBvzITCXB1O0G6K8p+/LCKmFL1hDqZk0B9trnAgF8lPYOFC/VVu2GVe940GZUMzGYczNEAPusfZVTBjpTD4wapqLrhFAckFV5jbm22J2KHmARppe8kCceq4BxHnQk2fn/PlSpPSXYSU2e0ujmwGvBlUgkVm2BI87hRpNTy8tViSfOc0OTjNWQdtQvA4A5lx3ww/G6ABkkHsXXcADgKlsvxL4RNJFBX0g/cGk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwRPtsGCmlg8qy8s5YuipBL4tvbP2X2vveWEMKDnjL8=;
 b=ia+06/Fa0+0cR53kh5oKdF24RxNujiV2/sY3xENAwd/Ysw2avMtvW3DoonOyshvIxRyJAxlNnTDMSPEPNOmHIfAbzn7192BHd0bE/SYj/RftDolt4i3SSN7IJ0H6T6w+DGJt+33JUyfFiNsYxAJTNNKaTVTc0e3D7gRxjs1zxO/jZ/PK+YyuG7xXpMqMYuMEyufdUn8jcnjXYWzQcHtvw7CNsUw41d26M3cutU/mnwziDmFzErnSeUq1+uTBBGnDzCxnfvq0GTwENngRlMNuFLto7Q22GYx/VIZJLmKxul+W/IEWRv6Z20pTiimFy6HRY7iZHmrGcfmzr9VqePtpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 07:50:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 07:50:17 +0000
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 06/20] genirq/msi: Check for invalid MSI parent domain
 usage
Thread-Topic: [patch 06/20] genirq/msi: Check for invalid MSI parent domain
 usage
Thread-Index: AQHY9dV85diQeUzFKUeDMA2jmYaE+K5EKEEw
Date:   Fri, 18 Nov 2022 07:50:17 +0000
Message-ID: <BN9PR11MB52761A0C8124248D78076B3F8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.388892782@linutronix.de>
In-Reply-To: <20221111132706.388892782@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7039:EE_
x-ms-office365-filtering-correlation-id: a91de031-2c69-423d-6515-08dac93988c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghszrQaCij6OzVnhSbH1jl501nwMs1l1mIHHUc7i4c6GLyYlTwy1VROv0KI8cnu80GdQ/SFz67NZy+quwtEaQXZ6kEyaiy/WwNJCCIAtVihe7hqA1fcIse0Kab527jmv/s+EMcEAiOZKbLq0j5GadTngSEM5pnZKlziso8WI6KqqNCyUoTI9j19l2dLsDnseBtWTE9VkrIqUX9O8HWu1zTXZiMK31AirlpgiRGrZzMO2mTU/BcxZx28Qj8exVdUcGeLtMLJqJo9DPHtdE4b/iXeojV3MAl9Fw4mO7PKGymbRpXuEl2VXdVpO5ZLr0th0NqTeSMNPHMZUUWti5o83AJqP79Ap9EFOfAwNxy1hvTiRV0c7Ouw4cYX+TX7FJQH4voWAUVEhbxUaWwmV2VT3ioWGcBvPsS/FhydYHFPhb/+stKlRh7MbT9bEF65wvyTfvWGc+0VQ1PkUrA8NbeHK71TUf8+4sjZD+jzqoYVK83rpv2k827E7b/ldLgZGDR2apnG/D4+dwjaT3mFEaleYd8TNFqTJ2Biu2F4EmYXxUc+LwAQeHwo9n8d7mmU7ZFFUZtGtmqEGwUDc8HhOQMnvlqoovYQXHdrkVTt+qTjqBeqlqAlWgsqwdVh3v8fsTkRprTCDctG7WJcHwIq+WMZG9uxI5y6F7reLhBYLDN8VwU0lV+di+3zS++H628daG5swmDJautDNHfJERO6BZG+Ehg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(86362001)(33656002)(122000001)(38100700002)(55016003)(38070700005)(82960400001)(316002)(71200400001)(26005)(9686003)(110136005)(7696005)(107886003)(6506007)(54906003)(2906002)(64756008)(478600001)(4744005)(83380400001)(76116006)(41300700001)(8676002)(66946007)(66476007)(66556008)(66446008)(8936002)(4326008)(52536014)(7416002)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGYzbkhuRXJHQjg0WjBkTGdXcjlrTytNcW5YajBZbDRJZE1sVWVWakNZL2FT?=
 =?utf-8?B?U1R5amlQemlpUkhqY3JJWkJYVkxwWk1MejJ6dmFINWVUL1NtVTVXeXNJMHow?=
 =?utf-8?B?WTJZcWhwOXMvdkt3eFNWTU1GWjNFQTcxSGd1Q21rcGNPWFVoYmlncjMzM2FI?=
 =?utf-8?B?aFlhQ0NOQnlIZFlnRDJJOS84Ym02T3lCNzM5UUVRcFZUZisyNHp2cnVreEFv?=
 =?utf-8?B?SjZkOFBOTTl0bkJub3loYTQzTnk5QlpOcDh2NUM5MVRydndWTFlzd01idXJD?=
 =?utf-8?B?RVZLSWRidjB3eHBsZVF5QlVrb3l4SkdMZXRFYlcrVVAxOGhLTEVhekE3TWR2?=
 =?utf-8?B?djFCWmt3OCtWbU5KbXlFcEN6OWJ3dGcyRVhuUFIyRDVrWUU4VmVTcGFuRWtz?=
 =?utf-8?B?KytydlNGT1VpQUZDZ2EvOWN5RDZKS251RlB6ZHJDbUtxZEZ0NXBOb3BnNjg5?=
 =?utf-8?B?aEhsOFJNQjA4MG1nSTNlU3BTdXpJVUJkQWtJc0F3T3g5N0tyem1KMThld1Va?=
 =?utf-8?B?SU8ydlhmT2E0MlF1OHNKcEgzcDc3T052M2JFWE1jSDNlVGZzSmFIajlIcy9m?=
 =?utf-8?B?RjVCbmgxc0Yyb2JpNStYYmREcGxwZ25oYmVEWWlxV2JwQUFiYVVpQ0FLSjYw?=
 =?utf-8?B?VEo4TlRsYUZYKzVySkxqdHR0Y1lBdlhQVGN6bS9nWG5PR0xZTEdrUnRRdjdl?=
 =?utf-8?B?UWlISXVKdWh5Y2tRNjdobFkxYXdLSlpDNTFjSFF1Y1M2MXVzMFMvZkkzKzFs?=
 =?utf-8?B?L3VPdkM1ajV4REtFNlorRy9KVEpjdlFWanhpL0h5V21WSkFya3hYT0JTVXBI?=
 =?utf-8?B?a0JMZGVzK2JXMEt4b0VJMHdJTUtBTGxOUnpxWmdpeitFMjNsUmVWcTJHcncz?=
 =?utf-8?B?Zk9NVEtKRnVDNnVjRVNCODhneTk4NERZTkZPdHlSVXpjREdmOExLV1MvaWxa?=
 =?utf-8?B?Qk1zRmlXWDU0NWZHVndSMklpSWl5N1AwQ2N6dXkva29NNEIvTWVoWEMrbUVt?=
 =?utf-8?B?dkREak9VS21PNHZiSkgzYm80OUp1SWRYZjh3eGR0QVg0UHNRanpBSnZpbXlH?=
 =?utf-8?B?bUpBM0NQemhQK3dPVVBxNmY4aENJSDJtVjVsVU55YnBOQkpxeG81aEtsWHRt?=
 =?utf-8?B?ODZkUnhmejBjRElIL0FCN0NqTkRhVHJweHo2Zm1QUjJzK2tadE1SRTFTMldz?=
 =?utf-8?B?b0tzbmxneU1pRUZNL3ZyU0ZYQlNWbTVxNVhDcHcvcXFkS3hWWjhCUXIwVitM?=
 =?utf-8?B?ZW8wYUw0MFR1aHFjMHdEYy9ITmZnR21iMXRwZ1ZMR0ZleUtFaUlZd1pBV2kz?=
 =?utf-8?B?TFVtcXlSU3pxMXl1QnBGMWFmWm1aK1NOWk1JZHMrL3BoZXVZaXYvYWZ1dUJt?=
 =?utf-8?B?WC95UnlGU2Y5a3BqMmNzQlZNZlZUcVo3VXo3TEl0aUJqdDlOMnlaVUxVVWlY?=
 =?utf-8?B?SmpJZnljdGxOWkExZ0ZOZFlnK1daTndLWHZxZldEUUlKeldPQkhyMmphV2xD?=
 =?utf-8?B?V2tpREp4aUNzWkNQWHp2M05CWmV3ZmNnNWxnWWRoY012Q2o1eUFJZ0Q4OEVm?=
 =?utf-8?B?ekFLaEFQZVcxemkxdlFqSmkweG5hK2daNlpveDEyVU80OTluZ0YyMnB6cG5N?=
 =?utf-8?B?aGhxbjd1VndEM2JsbU90Mk50WFhyeWZqKyt0dzl6Yi90K005TVpyQ0pxZHEr?=
 =?utf-8?B?SDk2NnVSdnhJOGgwdmt0MVRNR2w2Y3dVL0VPeENnWGRNSFoxKzVDbUhFQnRP?=
 =?utf-8?B?K3kyV21ITFlsdHlBUTFiVmxRY1JiTytSS1VJbzhpejVwQThzbzFmcEJwaTkx?=
 =?utf-8?B?a0RkNm1JL2JmSStTdnJhRUdqbEdBRHAzUFBaeE8xRmF6ZkczRVZpMUFqVnZh?=
 =?utf-8?B?eWYwR2xSNktCN1U2SEpJQ3hHTWxCWlNRMHJQS0tReXBORTJsZ3JmWGFJenEx?=
 =?utf-8?B?QzRMZGZTSFcyN2tQYU9PblJaK0V5VkNqZUNhLytJL0QrV0ZwV3NZNDkreEZS?=
 =?utf-8?B?UEV1UjczbmNsQTRvRjFOL1V6a3lKNllVQXMxS2F4YWR2WDJGS3VXUDgreklG?=
 =?utf-8?B?TTJmMmVZTk9vYkRzdWZFQ2EyOGdqMFkwVXdsOUpENkd2Q3Y1bkhQMmJFZ00r?=
 =?utf-8?Q?7+w9Z1pvSRpbw/RscLZ62LbCm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91de031-2c69-423d-6515-08dac93988c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 07:50:17.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ue7ydkhRxVasx4rlO1+3LCA9Bact7f1TMW1CTL+RRG7AQHt0oIDHtp+RqGqO/aoC3NStt5lY0EX7IpIHihGhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiBAQCAtOTM3LDEzICs5MzcsMjEg
QEAgaW50IG1zaV9kb21haW5fYWxsb2NfaXJxc19kZXNjc19sb2NrZWQocw0KPiANCj4gIAlsb2Nr
ZGVwX2Fzc2VydF9oZWxkKCZkZXYtPm1zaS5kYXRhLT5tdXRleCk7DQo+IA0KPiArCWlmIChXQVJO
X09OX09OQ0UoaXJxX2RvbWFpbl9pc19tc2lfcGFyZW50KGRvbWFpbikpKSB7DQo+ICsJCXJldCA9
IC1FSU5WQUw7DQo+ICsJCWdvdG8gZnJlZTsNCj4gKwl9DQo+ICsNCj4gKwkvKiBGcmVlcyBhbGxv
Y2F0ZWQgZGVzY3JpcHRvcnMgaW4gY2FzZSBvZiBmYWlsdXJlLiAqLw0KPiAgCXJldCA9IG1zaV9k
b21haW5fYWRkX3NpbXBsZV9tc2lfZGVzY3MoaW5mbywgZGV2LCBudmVjKTsNCj4gIAlpZiAocmV0
KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KDQppdCdzIHVudXN1YWwgdG8gc2VlIGEgZGlyZWN0IHJldHVy
biB3aGVuIGVycm9yIHVud2luZCBpcyBhbHJlYWR5IHJlcXVpcmVkDQphdCBhbiBlYXJseSBmYWls
dXJlIHBvaW50LiBpcyBpdCBzb21ldGhpbmcgd2hpY2ggY2FuIGJlIGltcHJvdmVkIGhlcmU/DQo=
