Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD862EF0D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiKRIR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiKRIR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:17:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8285A36;
        Fri, 18 Nov 2022 00:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668759447; x=1700295447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N4fq03XfdCg5vlKftDqAg6dB+sWaO43QbVLHaWyFvfI=;
  b=fLW3rc12esBt/tazi7eSmF+T3ZiIM8dmwO89/5TYrfz0RCnSW4+voF18
   EoyBc5kMqlWIOWs2TrhvyfrXwvd5OispnH4La723CNws6VKjZbLZujY0I
   ujyZ4lddCbqdSr4b446Z/fmCUlVuYX594mZFQxEaz+Nhikjq0xCXWfs4V
   O8QsCrZvLa1a06+btAfzr0jxw/Ws67J9xt5ULIDRau+E61ENTKZQ08drn
   PpLWU7HkuTtetKaMCgjNjfDvTEU1W8L8ju+rssa2c7N+hhByLe9xsex+3
   Xy5O6HKPNhC72K7dZBae+dwubuTRBnPn5UB76Hn0rHz6H0Ee/AWPU9FwN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311788590"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="311788590"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="729148429"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="729148429"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2022 00:17:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:17:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 00:17:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 00:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqY65/edanNPtW5mUqWs+aUghgvnf93bVdISFXpPqDULxjfBJSrZg+xKCxt9IP+oXs4pnJuNtodZ13f1f/vsypR3WR6Xfe1PLJHHusSuD8v6Lxc9hoq5T0fY5AJzmDBrIxt/9V/ZscM8gRIaGI/qxdOsc5DCvgNySOtn+LTAJsojhcLakj7D28jgY2wTOmopHHLZu0Wv/fR6tZdmhydeuj75yquXzqvNF+2QE4QVmczV5oWp0A608UlB4AooGiGPwyuu7mZp0XSbB+sePG/eEWGzn+rKV0tHmxIiM5mn/D0Am7VfspjKulhgDo08jc/0hEvdvK/d+DSi7tEF1CcJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4fq03XfdCg5vlKftDqAg6dB+sWaO43QbVLHaWyFvfI=;
 b=cfYDSswhF76RymmQ1LM3JZ5Rv++qhDTNs8IP5aVTTou7hbuMGG3/+m84dED5hA3K1SMAMqP6yiuwHF5cruDyAD5DqV81lZaSYT/mvMz/iauD+EOvj0zFtvkv9BnlPVmYYpmvBZq8UKivHYRKZ44+jC/AVHRQMliUQuBgH1kd6xPCtj9O88o7jO+8X8bZkbUT3nwutUtm/MnT/kkOHucykyAvuv3K8G3BlpdD10zLf/3zdjbNzaH1zrv2cESqQVv2a2woCnYDZKUgDuY+HEiVQyr64KL36mLxKGh1DmidH71DVC67CuREbAN4nvJBQELo/CuHMKAU9xGoWnAGklaR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 08:17:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:17:23 +0000
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
Subject: RE: [patch 12/20] genirq/msi: Make descriptor freeing domain aware
Thread-Topic: [patch 12/20] genirq/msi: Make descriptor freeing domain aware
Thread-Index: AQHY9dV915E7vdUqR0mdCp9CmLKUDa5EMpjg
Date:   Fri, 18 Nov 2022 08:17:23 +0000
Message-ID: <BN9PR11MB52762A0081F7A1679850142A8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.726275059@linutronix.de>
In-Reply-To: <20221111132706.726275059@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6154:EE_
x-ms-office365-filtering-correlation-id: 8415be43-cef0-4e1f-abb2-08dac93d51f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9NSJdi908xqkJc195WZOnhWNM/bQI85omBhJR7glQ6FtxmuzVNf+NmClsp/XahCi5W++FNNYLPPYzosVYgEy+YbZMMhAO4EDq7hS5lYdKQ7MC9O186F7TJNPfmVVjCRggzB6OND+1P/m5YVBcUSk/kYvxaGv5xuQF+TriVNB/5/Z8uG/8f1f5msAIsLN+SfWJmKo3u5WDYevjpgHrLHGVNiIaah/9V6gjEhegmqe1nST4syAtzbOAFC5YfdHCsp1ykP/znLreeqTGG5+/hBWfX5T7Nu6CyEU+XRl0CXA406zUy8bODbUALupqGYdTRIiXnXVIhVnunT39dx4ExZYkmRvkc4xKW10s5iIUhvfPZ0Qy5XNwVJVfwFiaYQ8lgjxYWPpzWAwQFYxU2eoPAFDlqvmoUK/1xOIqKrdv8PwI4j2bks86YNLlcU0GzHh2tdoZLg+IDjjO+ygy2tLnju9AyNcGBzhk5ANedub4fpyMLCzbTarK/ahrC12YWLHEZFulsbEnkPs9SpvWH1KoJL8F3KG34DxmGP81hu5PTMZepu8zY8tc/Rh/tUxAP4DprsLgDgF8dZHk9fzZ+NAowwP/nYEDsPEUoF7GGhUKOPEC11orGGN1wwlOG8ISjihWwmCjU7gQG0u5Wf1rrA1v45aFF+1HJVQ2iSSQWxnznfEu5XZLTvzCi+mFnh3dutfa25/DpZAzPlSLe2xR1XmGI07Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(316002)(107886003)(6506007)(2906002)(41300700001)(54906003)(9686003)(71200400001)(7696005)(110136005)(66446008)(64756008)(76116006)(66556008)(66476007)(66946007)(186003)(4326008)(52536014)(8936002)(5660300002)(8676002)(26005)(478600001)(7416002)(83380400001)(86362001)(55016003)(38070700005)(33656002)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2l5ZDNJMTNGR08yOEd1WUE3S0tGeFVkaElXdk1Ma0ZNUHhiM0htZDJTUnFN?=
 =?utf-8?B?WjdTZUtuMHNNSjdPeDJ5UytQckduaTZkZGpRTldlTEJ3OXdQM2ZPbExpaDQ3?=
 =?utf-8?B?c2NJQ0MzenUxZGJJM3FIcytPOUN6OEovV0tOYnpabjNURm8vUzZudGJQS295?=
 =?utf-8?B?aytXU3Z0a2s0QWpIOGVVOWo2ZjhqK1hURkVLRGVGMnVXVzRRK2RuVlN2TkVW?=
 =?utf-8?B?dm5kcjI0NGZDV2V6WWFPT1ZmU3NMUWdvNkZCYmJoNnc0bml1K1NtTmVOZVkr?=
 =?utf-8?B?dTBPYnBWcW9ndk93NlNtN1BGa2ZnNHZtV2RoQll3NVlXWlFjU203cmkrK05N?=
 =?utf-8?B?VjVKZjJzc001QWVrUm0vaWlCZm52RitlSWY5cHFCdWlqWmd4UVVZMnIwQTh2?=
 =?utf-8?B?ZCtMSWp4OGFYU1Z2Vzg4WURLU1dENVkxSVAzSEcvVGY1SmE0cHV1M1BGdTZ6?=
 =?utf-8?B?MGtkNVJJU1dVUUpUVjdKVTJOTTNqNkpSOGJFelVjSm5LU0d3M3N2Y3Fnb0pB?=
 =?utf-8?B?WGxSdTh6SGdjL0g5dDU1THRINHowNlpYbHZnaHVZVjhaZWJtZTBYbjQzNzNF?=
 =?utf-8?B?MnBmZkVhZzFrc1AvVzFMQ1ZhcVNBQy85ZDlFMDluYmc1SkVCbTJ5NTE2eHN3?=
 =?utf-8?B?RXpaRjVSMThvM2M4ekhXbTNUYkk3YUo2SmxicHNiRWZVaGI4eGI2VWJWSlhR?=
 =?utf-8?B?ZEo0Z3c4V0llcnhnNWQyLzZIekFXaXYvK0lmUndUMk5nM2lmT0FEQjIzaHg4?=
 =?utf-8?B?VU5MeStlTHp2cVpMdFB1SFpxTUlhUzNOQkhqem9JVnB5OWJ2c0VtQUpNdDVY?=
 =?utf-8?B?SDdia3FzUlJxS2xqR3ZjMDR1OXQwRDkxNzZOQXpVVjgrQk13VUlKeFpuSHRI?=
 =?utf-8?B?YTJmcDRQN25yU0lRQlVoblU2V2JjMHp5RFIvdGNjaXJDZU8walg5VEUwODFW?=
 =?utf-8?B?UG8zb3R3SkR2dm83Q2VVQUprSktxTk10SWh6Tk1VNkVKWnVoNzc1dHFaNkFC?=
 =?utf-8?B?dXl0K0dJKzdzNTA5YjBBR0NRZ1BFenlucGpqYVFMNzdPdHNiNTFxOEJ5ejFm?=
 =?utf-8?B?aFZBckZCVTFFUyt1Z3B1Wkl2RTBLUzBjSW5GZHcydXFUSXZDRUNkTHJmMnBh?=
 =?utf-8?B?a0JYK1ZqRFdpNGtTcUwwaFZ0U2dYcnR5Ti9aY1k0L09BNWZ6cGVIckk3WGQx?=
 =?utf-8?B?N284YkpXQWFyNlcxcWRQeTRvZy9YRUYyczhVbUtsMU1pOVdjYXhXQVN1YUwv?=
 =?utf-8?B?ZkFkVHlYb3pXNUpVS1hKMks4dWdndDd4M2hwS1dxM3FDRk9QZ2IrTGlvMWRk?=
 =?utf-8?B?eDYvQlA4aHdQby9xMGpKYy9ON0V3ME5yekYwbHJrQ3psUXJwZlFjRXNBem8x?=
 =?utf-8?B?eFRDcWhZVmdkZTZyM3VyLzV1VDE2SnBPU09ZTzZjYWsrVEVzaGZXekJMYWg5?=
 =?utf-8?B?M252OWZjdm9ZM3FIOGNRNEI3LzY1TEVzajhTdHd4T3EyRVdHSVVGSGloQmZ2?=
 =?utf-8?B?NnR3ZWU3WUxNSm5EaEFVaU8wL0pKMTBuN2tZM3ozdjBBVkx5d3FicGEvejFs?=
 =?utf-8?B?ai9kcURZWlF4aFhURGkxdUh2TVg1Rm9zVjdPc2xudm5BSmRyVm5XdXhaN2p1?=
 =?utf-8?B?RnZLcVRXTVdSeEZ2RUxDcU92alNLcmptazYyUWhZanV6UXc5UTZWcndndnUz?=
 =?utf-8?B?dnFJVER6SEpIL2NCeDZva1NhOFhjeWorRjdVOFdyUmFPNXA4Nm9pQ0FUR0s4?=
 =?utf-8?B?SWM2Z3dmeHBXbVloVFA0cnVKa1dCSXRMVWsxZ0F1T3o2eHFvRVZhRDgvM214?=
 =?utf-8?B?MVdYYVhoLzhOSE56a3pTMDFDZ1htMUFVYmRRRkJmR21tM1U0bUFMaWtiWDJ5?=
 =?utf-8?B?VzVzclhhY1JYOHlBSEZXaFVCV3lNb09nWmdyRGk1V0l2dEVqTmoxczRCRWN3?=
 =?utf-8?B?MU96ajdGWlBOMnFzSHhGOFZkUnRpSGNSN2dSTmJZaXBTWDU2U3J3RTNQRUNH?=
 =?utf-8?B?QXc1c05ZWFFmWStGc2kraWtzOEE4Y09vdStrUWdReEdBYk9heUU4OU8xeDYv?=
 =?utf-8?B?R3IvSFd5eVhaRXU4UXpKK2tPVEk5Rm1VUHphNk10bXpYbWRUNGQ5d29tOGZF?=
 =?utf-8?Q?xrAkAKMNdyL7Yu97lZODXh0uU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8415be43-cef0-4e1f-abb2-08dac93d51f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:17:23.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yi1C4Dnp19URC0K+KoktNC8dNPsVvq93ZB2LX4oQMnDFUf7UVH+h8vRL5Lu7mWZbjcsMe5qC9OcvLXTiGfmbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiAgaW50IG1zaV9kb21haW5faW5z
ZXJ0X21zaV9kZXNjKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGRvbWlkLA0KPiAg
CQkJICAgICAgIHN0cnVjdCBtc2lfZGVzYyAqaW5pdF9kZXNjKTsNCj4gIC8qKg0KPiAtICogbXNp
X2luc2VydF9tc2lfZGVzYyAtIEFsbG9jYXRlIGFuZCBpbml0aWFsaXplIGEgTVNJIGRlc2NyaXB0
b3IgaW4gdGhlDQo+IGRlZmF1bHQgZG9tYWluDQo+ICsgKiBtc2lfaW5zZXJ0X21zaV9kZXNjIC0g
QWxsb2NhdGUgYW5kIGluaXRpYWxpemUgYSBNU0kgZGVzY3JpcHRvciBpbiB0aGUNCj4gZGVmYXVs
dCBpcnFkb21haW4NCj4gKyAqDQoNCmJlbG9uZyB0byBsYXN0IHBhdGNoDQoNCj4gKy8qKg0KPiAr
ICogc3RydWN0IG1zaV9jdHJsIC0gTVNJIGludGVybmFsIG1hbmFnZW1lbnQgY29udHJvbCBzdHJ1
Y3R1cmUNCj4gKyAqIEBkb21pZDoJSUQgb2YgdGhlIGRvbWFpbiBvbiB3aGljaCBtYW5hZ2VtZW50
IG9wZXJhdGlvbnMgc2hvdWxkDQo+IGJlIGRvbmUNCj4gKyAqIEBmaXJzdDoJRmlyc3QgKGhhcmR3
YXJlKSBzbG90IGluZGV4IHRvIG9wZXJhdGUgb24NCj4gKyAqIEBsYXN0OglMYXN0IChoYXJkd2Fy
ZSkgc2xvdCBpbmRleCB0byBvcGVyYXRlIG9uDQo+ICsgKi8NCj4gK3N0cnVjdCBtc2lfY3RybCB7
DQo+ICsJdW5zaWduZWQgaW50CQkJZG9taWQ7DQo+ICsJdW5zaWduZWQgaW50CQkJZmlyc3Q7DQo+
ICsJdW5zaWduZWQgaW50CQkJbGFzdDsNCj4gK307DQo+ICsNCg0KdGhpcyByZWFsbHkgY29udGFp
bnMgdGhlIHJhbmdlIGluZm9ybWF0aW9uLiB3aGF0IGFib3V0IG1zaV9yYW5nZSBhbmQNCnRoZW4g
bXNpX3JhbmdlX3ZhbGlkKCk/DQoNCj4gK3N0YXRpYyB2b2lkIG1zaV9kb21haW5fZnJlZV9kZXNj
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtc2lfY3RybCAqY3RybCkNCj4gIHsNCj4gIAlz
dHJ1Y3QgeGFycmF5ICp4YSA9ICZkZXYtPm1zaS5kYXRhLT5fX3N0b3JlOw0KPiAgCXN0cnVjdCBt
c2lfZGVzYyAqZGVzYzsNCj4gIAl1bnNpZ25lZCBsb25nIGlkeDsNCj4gKwlpbnQgYmFzZTsNCj4g
Kw0KPiArCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmRldi0+bXNpLmRhdGEtPm11dGV4KTsNCj4gDQo+
IC0JaWYgKFdBUk5fT05fT05DRShmaXJzdF9pbmRleCA+PSBNU0lfTUFYX0lOREVYIHx8IGxhc3Rf
aW5kZXggPj0NCj4gTVNJX01BWF9JTkRFWCkpDQo+ICsJaWYgKCFtc2lfY3RybF92YWxpZChkZXYs
IGN0cmwpKQ0KPiAgCQlyZXR1cm47DQo+IA0KPiAtCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmRldi0+
bXNpLmRhdGEtPm11dGV4KTsNCj4gKwliYXNlID0gbXNpX2dldF9kb21haW5fYmFzZV9pbmRleChk
ZXYsIGN0cmwtPmRvbWlkKTsNCj4gKwlpZiAoYmFzZSA8IDApDQo+ICsJCXJldHVybjsNCg0KV2hh
dCBhYm91dCBwdXR0aW5nIGRvbWlkIGNoZWNrcyBpbiBtc2lfY3RybF92YWxpZCgpIHRoZW4gaGVy
ZSBjb3VsZA0KYmUgYSBzaW1wbGUgY2FsY3VsYXRpb24gb24gZG9taWQgKiBNU0lfWEFfRE9NQUlO
X1NJWkUuDQoNCmRvbWlkIGlzIHBhcnQgb2YgbXNpX2N0cmwuIHRoZW4gaXQgc291bmQgcmVhc29u
YWJsZSB0byB2YWxpZGF0ZSBpdA0KdG9nZXRoZXIgd2l0aCBmaXJzdC9sYXN0Lg0K
