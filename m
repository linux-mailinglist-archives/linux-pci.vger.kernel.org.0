Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0952E9FD7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhADWL0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 17:11:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:40889 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbhADWL0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 17:11:26 -0500
IronPort-SDR: fcI6+r/vdmppLkazp8Q24HDekdla60ss9eDYbWhnO/Lw6JMq7wehKSntGBkFRg9GJXHbwTd3p9
 0C7oIQr7lnUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="195542589"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="195542589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 14:10:44 -0800
IronPort-SDR: /itqp7Nlf9dfGZi+rBUxqeCUV+8Q9W95rEL8NQp13iEMipJ3GbjS794Mc7wZGsXO9d26Ihyt46
 zY0p9LnFcRKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="421527081"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2021 14:10:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 14:10:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 14:10:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 14:10:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYWaT7BCGmjzKNZWqWQ093bHH23mb532RQYxtW3d20vq4SFtlDuuZCiYjIbtEwud70UBQaiSyNGKTehi6ZVRRiqVbPjK5GFd7g26Qki6Kh/HnKPrSi2lwC5wAOwe2SXS5y+uzel2Oi/e2BMEeFTSgRe4ABlOIOR7KfY6swoc5OiIvj2Uh0nGCAXfy8l2NOYmvIsEPRgsBm0buiSXAecS3Gp9RSmn/LFdB8fbEZzzvAkFlRG2DaQgjgmVfGmEcaaFLGcclTJgLDbMq3CFQBN7nrliFBIzzUfV4dFxkZkMZy7jcTdhtMsLqqFyRoOpyUanNvTUldlOkbbFAbmbeMPucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXyRv4rvTz44PAVxBv3IwERmPWq4Tm//tmnKi5v9MFM=;
 b=X7hiiYjdItkcjOYeihYz2grPe0iuvwjtmgdENyJm5TyJ19kpK6S+9Ej/alMmatus4M6b3k8yaY10cj1bnd29aC9pA6WgFmRi7yIy3eauaE6o9lEUImHxKObLUnYgEatbBcPnlxARgRcF2YzbTcZYmt81HEvJ9TTs9qSioCCuZw8uO8nog2KPmq6iZUL1rha4C4FRnG5V6LrJ0Tjbima3XVh5M477JahRgX7l2pz/LuvJWtSjAW5ZEYJdJYh1L5LwtDlARMr2WcdrvDb/wOWP7smfVfg6wAKUUrIGm/tPCid6pENQ05q+mGPEtGbB8IqQX32HhNX5axNtTtP1+F/v1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXyRv4rvTz44PAVxBv3IwERmPWq4Tm//tmnKi5v9MFM=;
 b=R1cah5HstSYMTH/e71FqyFS80aBUDSzsP+cvyCIXx6v57awN2Gf7krxn++1YJcDdeJGKL0XeIxoE1FXRQkOPrJLSLzH7g0NfFjsnvESBQUayPkUXSapuY9je5FFTBoYVxXDQtpwuQ0OER7WYw1t4DepHVqtuN4QBmHr95iO9IjI=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 22:10:41 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf%3]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 22:10:41 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/AER: Actually get the root port
Thread-Topic: [PATCH 2/3] PCI/AER: Actually get the root port
Thread-Index: AQHW1JhOrRzR6Vc1NEaEbAjSo/oS9qoX6aWAgAA4l4CAAAF0gA==
Date:   Mon, 4 Jan 2021 22:10:41 +0000
Message-ID: <8A0A57B5-233A-4300-A1A6-EF3F9D5159DA@intel.com>
References: <20201217171431.502030-1-kbusch@kernel.org>
 <20201217171431.502030-2-kbusch@kernel.org>
 <F5E3C1CC-4420-4EA2-9770-8AEBDE0CEACA@intel.com>
 <20210104220529.GF1024941@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210104220529.GF1024941@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c78e1a49-be79-41f7-878c-08d8b0fd934e
x-ms-traffictypediagnostic: CO1PR11MB5105:
x-microsoft-antispam-prvs: <CO1PR11MB5105767B52960F27D204DE33B2D20@CO1PR11MB5105.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvEHUoTqiF2UXiHLLZpr2CszN1F4UYEPFe3MRcb7G9qNQHhhdzVV4i2oJYQ31vsHEbAZvl01wAP43ujkGaiBnzCjB7oiPZYvNlSgpfazKcWhsbLNXJ7njmvFMuPRwwwynaI71CxfEh1XXpwBN0ILIzkMChfozFkK0LB2IUYt7yMwmfN32C42pI8UURV+yIdI0mANGzQFNrcbbgcCO0PorxeJfHu4D8nWrCgM1f4/A5VbZkz/CVy4lilYpGVmdWq5M+bwotKx0h+pga8toHSwuBQiQyFespUOqMwc85qwB0MXLDBc/7XCCa96fZwXg0VzSfdIp4YcHJiqm1RbPWmUXecdKeZuEah8MuiOBc5inT9ksX3y4YQEzIMVs1VZ2zpVzzUzVLwdRPCDLRIyxUI8q+jc3yLs0b4JF/HknIRn44sPx9T8x2UuFsHfrhQgfGZ4GkLNNYwxiZdOyBUuD6Zd3LFViU3SQKySdD0r2q3zcvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(4326008)(316002)(6486002)(8936002)(26005)(5660300002)(186003)(2906002)(54906003)(33656002)(478600001)(86362001)(4744005)(66476007)(8676002)(66446008)(64756008)(76116006)(53546011)(66946007)(6506007)(2616005)(83380400001)(71200400001)(6512007)(6916009)(36756003)(66556008)(15583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TjBBcmwxOTUyWjlyMXZwRlhuUkN4QWl0UXdyZkhUVTdxaTg2TCs5UXFIcGkr?=
 =?utf-8?B?L052NFBSSFFTbDlFSy9veHoxekJpV0Y4dlNMRXRmclNiSXB4Uzl1VTdxTWtK?=
 =?utf-8?B?SlU5dFBjNkd3UUdSMXM5cWhEVE5kQVVNMitjL213MFRPRC90SEo1a2Z1VzI2?=
 =?utf-8?B?MlhFODhNOUtOT0t4eisrNExoV1o2bEFpRlBpaHBWNkl1U1pJYytHU242RXIv?=
 =?utf-8?B?OXo4TEFVS2Z1YVUvY2tUdTVBdEs3TFM3L2xNS0Y5dExGZGc2b1QybmE0TDBP?=
 =?utf-8?B?cktqRUZCSUVrNzRyTGxGb0ZEMG5aeHBpU0ZrVmJCbkhRUmwyTGdua1RRVUFa?=
 =?utf-8?B?cjY2N2JkQks1Njd2MHc2NlJJS0FSYitZUmdWelZEYkRVczhVSEFOS3RDV3VC?=
 =?utf-8?B?QTBYbVU4M2NpZjdrUDdtK2xHNFNPd0h3LzRSR052V2F5T2F0QkVtL1d5NTd0?=
 =?utf-8?B?cEZoTGdGWE1JMmVrN0l1Y2djQ1l6bGtWSTlxSlIxd3lpRzVDQlBidCszRXZO?=
 =?utf-8?B?TDFFK0hKZ2xJaC9TNmZ4UFgvQ0F0TEI5NlNJdkpuem5xc1Y4MWl5dVRpcHJP?=
 =?utf-8?B?YXVBeXl0Sm9NcmlKeTlrZ3g1Z2JINjRHOGxIM1ZnSFVGMEZ5cEZLdHpndWJs?=
 =?utf-8?B?eFczaDk3ZWxLOXdDREQyY0k2L2lKb1hHeUhOaVhIUFBUSksyaDJ2UUVNS1VT?=
 =?utf-8?B?Q1d1SVBlWDVrZmVidkhnVXpqcStZYmpoM2N5K29Oa3BsQ3BiWWFOeG5aYXBC?=
 =?utf-8?B?UjBkNjh0Z0UyTnhQc29BeFl0bTdZYklMTk1FOXFNOXMrSjNmZHZlMjVMVXBy?=
 =?utf-8?B?VmZmc1ZzckxDL1RDdzJTcktSdTllbEZoR0FsODVJQXo4MVgyS2dnOUlqaUpx?=
 =?utf-8?B?U3djMExOMkxobVo3VU1ncW1mc1NNcGg0SnE5d2JjM2NVY2E0WHgzS1ZSWWZE?=
 =?utf-8?B?bG9Wbm9HcDQyL1JCRVFFS1JrZVVNak4yOHNCYUIrU0RBU2JLeUswV1F3clNq?=
 =?utf-8?B?MHdlZFFGekdEVVRIS0tJdGJiV3dwYS90WUJ2WkFpdStRZlkranZZWEloQ0ti?=
 =?utf-8?B?dGNtZ0dUOUQxLytYSHVmTkFWbmdlS05RSHpzcnhkZlhrTFZtZkpURVdmR0or?=
 =?utf-8?B?TE14b1RBRjM2TGhjL3d1bjJjUXNIUlptTGprZEtzelpRZS8wMG1rQ09tNTI5?=
 =?utf-8?B?WkxmQko4TkwrZDFCaTNsdjRXZWc5d2Fuc3RlbEc0NmxOeWIyT2dPVTNXRFEw?=
 =?utf-8?B?UnErOERSdFUwbTFKVll6b21GRlRKcTQ3RWNBcFdMTGJuTklFa0tPeE95TzRI?=
 =?utf-8?Q?kxH1SDkwqa0gAbvkH9GHrXyYrxKh1boKSX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A2759421C5F747A35541CD48222E0D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78e1a49-be79-41f7-878c-08d8b0fd934e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 22:10:41.6362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDG/IakPE5cGFQ1gzTWFEVW/MH/JjitsEOuOGYKjhIW1E6ffv/MCDi4tQ+NIIYB2yosUgnYJA7/hUoYy73mLgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gT24gSmFuIDQsIDIwMjEsIGF0IDI6MDUgUE0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEphbiAwNCwgMjAyMSBhdCAwNjo0Mjo1OFBN
ICswMDAwLCBLZWxsZXksIFNlYW4gViB3cm90ZToNCj4+PiBPbiBEZWMgMTcsIDIwMjAsIGF0IDk6
MTQgQU0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gCQlyYyA9
IHBjaV9idXNfZXJyb3JfcmVzZXQoZGV2KTsNCj4+PiAtCQlwY2lfaW5mbyhkZXYsICJSb290IFBv
cnQgbGluayBoYXMgYmVlbiByZXNldCAoJWQpXG4iLCByYyk7DQo+Pj4gKwkJcGNpX2luZm8oZGV2
LCAiJXMgUG9ydCBsaW5rIGhhcyBiZWVuIHJlc2V0ICglZClcbiIsIHJjLA0KPj4gDQo+PiBQZXJo
YXBzIOKApiAiJXMlcyBQb3J0DQo+IA0KPiBJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gV2hh
dCBzaG91bGQgdGhlIHNlY29uZCBzdHJpbmcgaW4gdGhpcyBmb3JtYXQNCj4gc2F5Pw0KPiANCj4g
SSBoYXZlIHRvIHJlc2VuZCB0aGlzIHBhdGNoIGFueXdheSBiZWNhdXNlIEkgbWVzc2VkIHVwIHRo
ZSBwYXJtZXRlcg0KPiBvcmRlciBhbmQgYnVpbGQgYm90IGNhdWdodCBtZS4gSSdsbCBzcGxpdCBp
dCBvdXQgZnJvbSB0aGlzIHBhdGNoIHNpbmNlDQo+IGl0IGlzIHJlYWxseSBhIHNlcGFyYXRlIGlz
c3VlLg0KDQpOZXZlciBtaW5kIHlvdSBvbmx5IGhhZCBvbmUgc3RyaW5nLCBpdCB3YXMgdGhlIG9y
ZGVyIGlzc3VlIHRoYXQgdGhlIGJ1aWxlZGJvdCBjYXVnaHQuDQoNClNlYW4NCg0KDQo+IA0KPiAN
Cj4+PiArCQkJcGNpX2lzX3Jvb3RfYnVzKGRldi0+YnVzKSA/ICJSb290IiA6ICJEb3duc3RyZWFt
Iik7DQoNCg==
