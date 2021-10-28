Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF243E78F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 19:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhJ1R71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 13:59:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:53210 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1R70 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 13:59:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217651768"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="217651768"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 10:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="487243162"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 28 Oct 2021 10:56:59 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 28 Oct 2021 10:56:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 28 Oct 2021 10:56:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 28 Oct 2021 10:56:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 28 Oct 2021 10:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC1/zOjgCPtqqARp0tEHfvKtzRzejSQC+NAqqfzD8Em7LQHVhgPWyRSw9cVM28w5ZbQKCW19y02XODJXeSaDm6y1Az/a7Nz8+wT3qxCw4Y+OWuPJ49WEN4pBZzy+0lAVJQfg4lEXedLHrsEfzF4Q+RU784T1mtLB7bur3+Myz+q29xa2uBNKLScrt0M678ztdR4mPIv34A0Wct5E/NPkKs2z1lNaeTrfkN8OtpwUg9sIJetAs0lA12DA2ZwJg1SC6yPoLegJsv8rSucMBAcRXsSM++N9aDPX9blB/ljGQqdnZwFWRxPoxmiUJ45qHlGMk1BLiRt8F1IBih1wtfXxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EZzaNTbI54J9xL2W70zmpfwDaiGhMiCup/vWZNfm7o=;
 b=iD4x4sQx6EHE6N8ffEU4GrW+qg847DW5JO3AeIkpHR3F7+1OsvbQkoSmCNZVl7rXH2WLryjZZ5Z0gOXGkwCIC617/vgfxrs8KW4M94CJAKTI3wJ+YpkzwYqap89v4ziJIg32g/VI8HWixl0d4MEZGMMomKc7O2llrGdDTeTx9nxi0QUBSEGdxMHn3sr8yLKkOMatRNTLxEz32sAsEfh8FHgbjtzmvgBJawfstEqUxQslG9xL6TughtDWw5XLL84tHtCLDJPGnAy5zQxswJASC5COErGaVBV8H4JtSBRUoVs4xSKMPVr2Jq+BZhxtWoJaH6u1Ihvv/R75aZ0ruatHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EZzaNTbI54J9xL2W70zmpfwDaiGhMiCup/vWZNfm7o=;
 b=iVlLM479q3129856gKN94YedguBMBzNlGYOplUGryWOg16p4oOQm8VLiQOsxkiz/U0J4iJEo6I85zvK62htra363XSxw0jVtOANYp/OcuxR73KmKjiX/C+cqdayYe/zLGIcd0MOZ6C9M9IAORR/ogyvN2AwcHqi49m+7/hFVyJU=
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MWHPR1101MB2079.namprd11.prod.outlook.com (2603:10b6:301:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:56:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::1c41:b47d:6152:d72]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::1c41:b47d:6152:d72%4]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 17:56:42 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v7 1/2] ice: reduce time to read Option ROM CIVD data
Thread-Topic: [PATCH v7 1/2] ice: reduce time to read Option ROM CIVD data
Thread-Index: AQHXy4mxPbawBSzaa0O4JxSUh05ybavn9xgAgAC6bBA=
Date:   Thu, 28 Oct 2021 17:56:41 +0000
Message-ID: <CO1PR11MB5089365FA06C9EBEE67291B3D6869@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20211027232255.669167-1-jacob.e.keller@intel.com>
 <a9ab1f26-69f6-9f31-8ffb-14a7bfa21505@molgen.mpg.de>
In-Reply-To: <a9ab1f26-69f6-9f31-8ffb-14a7bfa21505@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cccaec1e-5632-41f4-439b-08d99a3c4c7c
x-ms-traffictypediagnostic: MWHPR1101MB2079:
x-microsoft-antispam-prvs: <MWHPR1101MB2079B908B0A0D957BA0BF8EDD6869@MWHPR1101MB2079.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RY3xe9OpDKutBGLcOR0FWiDfBQ+1A48iIwPpSkFa+y3YZFfbPu06xUR2UPH80bb7zeUTb2F5G3quKm25/soReeYSgtSpDgqajS1ReG0zHx7cAkH+DPiwddh0ZQA0kQhMCXvNBD/sZBkHb6dN/RGDnzH0lqVyODsypp2h+FnZUw8i3n3FYSAyjbMHeu4JzzZb7AK09HNnbfS/2DEaJqM+1er70TVVVULlLW/JonMojlI9S1rT6C3fy96ONVmJYt//V32Bqo0X1q9UPY+EmEbNm3vgARvQY427hbNZx3fCP8qhCwxKk2kBWeyNl6y8Hxofm+idmKiQPCl5E5SgesOUhj8u1M6+RO+ODTwpYg6iWvUQ6PdH65PGpew9YCxPSuGyg9eO6Jpl/fNPDw83VRDsrBrzmbD5hp7PAtIQFqcKuFQhZUFua7fXDAROuDk1ioACohsfcLwRVFxFpH/iChgQYEFlwTGRnWtpKbxMqEo951oz9o0hpwSYv9ayby6z3cQqrscJ6bpDeAHeFE4l7cWK4jN6+oSxmnT+HJKKQt3lUKdynAesgEhjuf27pHdyhLrTLaRDK6DeHRjWj09iOeAHBZA1nmfzj6nVzM9TXUyoAEDkUMcelYjeLbFq8++fipcOZKN2ScZrQMZwGCsmYWauRIyF7odATFFun9mUaaEwGVkz35gNRNQD+XRA0xDJm9t3lpEGLZ16/Jmu20ARPAiPkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(508600001)(2906002)(71200400001)(4326008)(76116006)(9686003)(186003)(55016002)(6916009)(5660300002)(8936002)(38100700002)(66946007)(83380400001)(8676002)(6506007)(66476007)(66556008)(64756008)(66446008)(26005)(53546011)(54906003)(33656002)(7696005)(52536014)(122000001)(82960400001)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnBjcjVQWWc2NmFtOFRkV0xUaXREY1N5eFRKNDF6djFUeml3RkFkSUkrNzR0?=
 =?utf-8?B?ejMzOTlYVGNDL0NWVDVjQm5qb1hsTVNvZ3gveThNUWlSQjV4K0xNSmZHdFRG?=
 =?utf-8?B?TW5jb1psanBWSEZXR0ZjTU5jbFUrZ2hURXlSdXl6RHN5UGVTRjJ3amZXU3ha?=
 =?utf-8?B?WGFqZFIrQ1Z6c2hTcWQzMERQU2FJRVdGNlg3NnBueGtINlZ5Smk3dlZWRlhj?=
 =?utf-8?B?QUYvWDBYU2xyZUowKzlVSlM4SXdNWkZqTmVGZHNmZ3FoUDlTbFlza3NhWldV?=
 =?utf-8?B?bnZvV0FBbnhvaXpDdmRKVFhOVUhpQ0VoR0Z0NVgrelg2MWZhSkt4enpVbWhB?=
 =?utf-8?B?dkRTclVvWlB5MDhDQkhYTkpOZENrNEpyUzN1NVQyM1BTRFBFR01yTW1yd1Nl?=
 =?utf-8?B?aUJ3b3pXQ0ZPaXRoRjVqMkpoaFB3UWZVVVZUZTlGRVBnUWR1OUFRQWE3ekR0?=
 =?utf-8?B?bzgxU1pBRVAyUkttbU9SVW5DZWQvVVBaOVJDazR2WitrNGlWeFJvSkt4b1Z6?=
 =?utf-8?B?bzhrVUVQVEhUdVRxdE5EVGlyRmlITmlXaEhDR1krOUU4ZHUxcWIxa1NjdXhw?=
 =?utf-8?B?YzlhVzVubG9kZTRPZzhBbFd4NVZOemZETzRGZzdlK2x6c01UY25YRTh3U2xv?=
 =?utf-8?B?Z3Z4YzdTZEc4aHNpelFpcFVESXF5Yi8zZ0FnRnBZdnN2NmVJOWhGR0lFR2RX?=
 =?utf-8?B?Z2ZOUzQxMTZ2QWhmVTJQM2tvTXpOaXVFc2lQaXh4REdkQjBjMjNGak9BU0tB?=
 =?utf-8?B?RVJIQng3TXhyK3B2ejdESzJ3NXd5dkFmUmxTTGU2MnFEWjlLbXMvSnFLcDZB?=
 =?utf-8?B?ZXlCbm1CQlpjSDgvdXNUNXdKbzhpUndyVXkxaW0rNVZWN1l3VVNWWWFKR0ZF?=
 =?utf-8?B?V1piKy93UFhLY04zWnlnb2VIZkNxY0lKK3JWK3cxYmFob1VOL21GVDExL2hD?=
 =?utf-8?B?RkdjdlE5d2RBTWs2SHZTaitMU2ZyS21CM0JKSDJzd1cvMkhEMWkrb3hCWHh2?=
 =?utf-8?B?SzBMNzFuVTdhWnY5MTVCVDBUUzNYd05RQkNubXRWV0RIbUc5WE8wdnZ2Z1Y3?=
 =?utf-8?B?N2dEVDlNV094NmpTcU9HWjNqdUdjV1AzSWhtbHFkUWV2aXVjWjQxcGU4ZTAr?=
 =?utf-8?B?K05MNHNHM2l5UzFua2kwbkJsOWxXQVBIQ09KUjZPcFBzKzNZVDJheWZhTEVJ?=
 =?utf-8?B?MmFub2hRaFNKeU41MExjV1Bscjd6MXh0SVNyb0NPQmhYMzIwaTZQWHBpWkxm?=
 =?utf-8?B?emptS3BTYTRCNGhRSVVzcS9YT3pkdDQ2d3pEZ0tWaHFTNGg2bTZsVU5kU25m?=
 =?utf-8?B?Um9HRWpMeWdrY1JlUFAra21HWk5RWWhySE1uL1VVV0lQV2pQeHFWTFJYV2U3?=
 =?utf-8?B?b1ZHekFGWGtxajBKUnRvM05IQTNRMnp3akh6QndDVDFqa3d0Mjcza3ZQZjEw?=
 =?utf-8?B?NVhLWTFtV3UvME9SRm1kK0o2ek1VZ1FieWhxRC9LaDVscU40Y2lETWdjeGFs?=
 =?utf-8?B?QlZLNVlNYUVLV3BqY2o5TWpnam4wV2JQSzVHbGVDZzZybmtoaUZkdTNaR2VE?=
 =?utf-8?B?N0ZvUkRrQ1lpd01Tc1hsSTJLa1l5WC9mS2kzMWJYcDZGVGhkaWVrSnhvbkVL?=
 =?utf-8?B?Z3YzR3kyQ1pHMlAzUWRzUzl3dGd4VnZvNVVndkc5VnAzUHlOZ2E5MWVMWEYv?=
 =?utf-8?B?M3RSRzRWTXYramtsWTFpdUVVZHBnUWgwcnZaQW9TbEJ2OWdwdnc4N2VndVV6?=
 =?utf-8?B?VmZIbTBlM0ZVUWh4ZWhpTmtha3QzUnBFL1kzZ2hPNHVBeGNWaHRkd2pVUnVx?=
 =?utf-8?B?cStNazljaitaK2JSOXJ0cUxzdXk3VWpPLzBDYnBJYkNxSURjUFdaVEwyUERi?=
 =?utf-8?B?VnVrWlVNVklLZERrWk5LT0NZK283b3JRTDE4QjVxdkdRNm1NcUN0NlJXMTdq?=
 =?utf-8?B?bDI1ZURsNFNKanBMMmxzQjZzNzZPWEV5cTVWUlZEOUhaS1N6L3VOU3dkR0hx?=
 =?utf-8?B?Z1RKb3Z4MS91NjROdWtuK014UFR5d05ZUGZYUXdVdDZxeis4aHJ5dzA3SjNG?=
 =?utf-8?B?SXMvTUxnNThEOHZLUnJXY3RoV3B1cllhRlBjdytyM1pNQ0RDOUxnOE5yV1kx?=
 =?utf-8?B?cmI2cVJKREE1U3lucWw0MDY0NFRRQ1FTL2N3SzRLNlJzd0d3YmNFV0lSQkxW?=
 =?utf-8?B?UGtqRGtjbTVWRkd4TlZIZS8xUkx1MFl5Zkl5OENrSU5US0NZZVdGUnQ2Tjhj?=
 =?utf-8?B?blZMTnpicUIzNHppLzFoN3Z5VzB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccaec1e-5632-41f4-439b-08d99a3c4c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 17:56:42.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2yk6XeWd5/JXmRCKrooL8Seqe3pprKGiQ0PwHbCAqb9j7uemF6i2r/eS4VL8I2T+7M+mfXafRL8kc0BKaSSr5C4Jaqjzo3aFgrvJS3PajM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2079
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjcsIDIwMjEgMTE6
NDMgUE0NCj4gVG86IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0K
PiBDYzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgaW50
ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMS8yXSBpY2U6IHJlZHVjZSB0aW1lIHRvIHJl
YWQgT3B0aW9uIFJPTSBDSVZEIGRhdGENCj4gDQo+IFtDYzogK2xpbnV4LXBjaSBmb3IgaWRlYXMg
aG93IHRvIHdvcmsgd2l0aCBPcHRpb24gUk9Nc10NCj4gDQo+IERlYXIgSmFjb2IsDQo+IA0KPiAN
Cj4gT24gMjguMTAuMjEgMDE6MjIsIEphY29iIEtlbGxlciB3cm90ZToNCj4gPiBEdXJpbmcgcHJv
YmUgYW5kIGRldmljZSByZXNldCwgdGhlIGljZSBkcml2ZXIgcmVhZHMgc29tZSBkYXRhIGZyb20g
dGhlDQo+ID4gTlZNIGltYWdlIGFzIHBhcnQgb2YgaWNlX2luaXRfbnZtLiBQYXJ0IG9mIHRoaXMg
ZGF0YSBpbmNsdWRlcyBhIHNlY3Rpb24NCj4gPiBvZiB0aGUgT3B0aW9uIFJPTSB3aGljaCBjb250
YWlucyB2ZXJzaW9uIGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gVGhlIGZ1bmN0aW9uIGljZV9nZXRf
b3JvbV9jaXZkX2RhdGEgaXMgdXNlZCB0byBsb2NhdGUgdGhlICckQ0lWJyBkYXRhDQo+ID4gc2Vj
dGlvbiBvZiB0aGUgT3B0aW9uIFJPTS4NCj4gPg0KPiA+IFRpbWluZyBvZiBpY2VfcHJvYmUgYW5k
IGljZV9yZWJ1aWxkIGluZGljYXRlIHRoYXQgdGhlDQo+ID4gaWNlX2dldF9vcm9tX2NpdmRfZGF0
YSBmdW5jdGlvbiB0YWtlcyBhYm91dCAxMCBzZWNvbmRzIHRvIGZpbmlzaA0KPiA+IGV4ZWN1dGlu
Zy4NCj4gPg0KPiA+IFRoZSBmdW5jdGlvbiBsb2NhdGVzIHRoZSBzZWN0aW9uIGJ5IHNjYW5uaW5n
IHRoZSBPcHRpb24gUk9NIGV2ZXJ5IDUxMg0KPiA+IGJ5dGVzLiBUaGlzIHJlcXVpcmVzIGEgc2ln
bmlmaWNhbnQgbnVtYmVyIG9mIE5WTSByZWFkIGFjY2Vzc2VzLCBzaW5jZQ0KPiA+IHRoZSBPcHRp
b24gUk9NIGJhbmsgaXMgNTAwS0IuIEluIHRoZSB3b3JzdCBjYXNlIGl0IHdvdWxkIHRha2UgYWJv
dXQgMTAwMA0KPiA+IHJlYWRzLiBXb3JzZSwgYWxsIFBGcyBzZXJpYWxpemUgdGhpcyBvcGVyYXRp
b24gZHVyaW5nIHJlbG9hZCBiZWNhdXNlIG9mDQo+ID4gYWNxdWlyaW5nIHRoZSBOVk0gc2VtYXBo
b3JlLg0KPiA+DQo+ID4gVGhlIENJVkQgc2VjdGlvbiBpcyBsb2NhdGVkIGF0IHRoZSBlbmQgb2Yg
dGhlIE9wdGlvbiBST00gaW1hZ2UgZGF0YS4NCj4gPiBVbmZvcnR1bmF0ZWx5LCB0aGUgZHJpdmVy
IGhhcyBubyBlYXN5IG1ldGhvZCB0byBkZXRlcm1pbmUgdGhlIG9mZnNldA0KPiA+IG1hbnVhbGx5
LiBQcmFjdGljYWwgZXhwZXJpbWVudHMgaGF2ZSBzaG93biB0aGF0IHRoZSBkYXRhIGNvdWxkIGJl
IGF0DQo+ID4gYSB2YXJpZXR5IG9mIGxvY2F0aW9ucywgc28gc2ltcGx5IHJldmVyc2luZyB0aGUg
c2Nhbm5pbmcgb3JkZXIgaXMgbm90DQo+ID4gc3VmZmljaWVudCB0byByZWR1Y2UgdGhlIG92ZXJh
bGwgcmVhZCB0aW1lLg0KPiA+DQo+ID4gSW5zdGVhZCwgY29weSB0aGUgZW50aXJlIGNvbnRlbnRz
IG9mIHRoZSBPcHRpb24gUk9NIGludG8gbWVtb3J5LiBUaGlzDQo+ID4gYWxsb3dzIHJlYWRpbmcg
dGhlIGRhdGEgdXNpbmcgNEtiIHBhZ2VzIGluc3RlYWQgb2YgNTEyIGJ5dGVzIGF0IGEgdGltZS4N
Cj4gPiBUaGlzIHJlZHVjZXMgdGhlIHRvdGFsIG51bWJlciBvZiBmaXJtd2FyZSBjb21tYW5kcyBi
eSBhIGZhY3RvciBvZiA4LiBJbg0KPiA+IGFkZGl0aW9uLCByZWFkaW5nIHRoZSB3aG9sZSBzZWN0
aW9uIHRvZ2V0aGVyIGF0IG9uY2UgYWxsb3dzIGJldHRlcg0KPiA+IGluZGljYXRpb24gdG8gZmly
bXdhcmUgb2Ygd2hlbiB3ZSdyZSAiZG9uZSIuDQo+ID4NCj4gPiBSZS13cml0ZSBpY2VfZ2V0X29y
b21fY2l2ZF9kYXRhIHRvIGFsbG9jYXRlIHZpcnR1YWwgbWVtb3J5IHRvIHN0b3JlIHRoZQ0KPiA+
IE9wdGlvbiBST00gZGF0YS4gQ29weSB0aGUgZW50aXJlIE9wdGlvblJPTSBjb250ZW50cyBhdCBv
bmNlIHVzaW5nDQo+IA0KPiBPcHRpb24gUk9NDQo+IA0KPiA+IGljZV9yZWFkX2ZsYXNoX21vZHVs
ZS4gRmluYWxseSwgdXNlIHRoaXMgbWVtb3J5IGNvcHkgdG8gc2NhbiBmb3IgdGhlDQo+ID4gJyRD
SVYnIHNlY3Rpb24uDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSBzaWduaWZpY2FudGx5IHJlZHVjZXMg
dGhlIHRpbWUgdG8gcmVhZCB0aGUgT3B0aW9uIFJPTSBDSVZEDQo+ID4gc2VjdGlvbiBmcm9tIH4x
MCBzZWNvbmRzIGRvd24gdG8gfjEgc2Vjb25kLiBUaGlzIGhhcyBhIHNpZ25pZmljYW50DQo+ID4g
aW1wYWN0IG9uIHRoZSB0b3RhbCB0aW1lIHRvIGNvbXBsZXRlIGEgZHJpdmVyIHJlYnVpbGQgb3Ig
cHJvYmUuDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRha2luZyB1cCB0aGUgY2hhbGxlbmdlIGFuZCBs
b29raW5nIGludG8gdGhpcywgYW5kIGZvcg0KPiBkZWNyZWFzaW5nIHRoZSB0aW1lLg0KPiANCj4g
T1Q6IE91dCBvZiBjdXJpb3NpdHksIGhvdyBkb2VzIGl0IHdvcmsgb24gVUVGSSBzeXN0ZW1zIHdp
dGhvdXQgdXNpbmcNCj4gQ29tcGF0aWJpbGl0eSBTeXN0ZW0gTW9kZSAoQ1NNKSBhbmQganVzdCDi
gJxFRkkgZHJpdmVyc+KAnT8NCj4gDQoNCg0KVGhpcyBjb2RlIGlzIGp1c3QgYWJvdXQgYWNjZXNz
aW5nIHRoZSB2ZXJzaW9uIGRhdGEgdGhhdCB3ZSByZXBvcnQgdmlhIGRldmxpbmsgaW5mby4NCg0K
VGhhbmtzLA0KSmFrZQ0KDQo+ID4gICBpY2VfZ2V0X29yb21fY2l2ZF9kYXRhKHN0cnVjdCBpY2Vf
aHcgKmh3LCBlbnVtIGljZV9iYW5rX3NlbGVjdCBiYW5rLA0KPiA+ICAgCQkgICAgICAgc3RydWN0
IGljZV9vcm9tX2NpdmRfaW5mbyAqY2l2ZCkNCj4gPiAgIHsNCj4gPiAtCXN0cnVjdCBpY2Vfb3Jv
bV9jaXZkX2luZm8gdG1wOw0KPiA+ICsJdTggKm9yb21fZGF0YTsNCj4gDQo+IEkga25vdyB0aGUg
ZnVuY3Rpb24gbmFtZXMgdXNlIG9yb20sIGJ1dCBvcHJvbSBpcyBhbHJlYWR5IHVzZWQgaW4gb3Ro
ZXINCj4gc3Vic3lzdGVtcy4NCj4gDQoNClN1cmUsIGJ1dCB0aGVyZSdzIGRvemVucyBvZiBpbnN0
YW5jZXMgaW4gdGhpcyBkcml2ZXIgd2hlcmUgd2UgdXNlIHRoZSBzaG9ydCAnb3JvbScuIE5vdCB3
b3J0aCBjaGFuZ2luZyB0aGF0IGluIHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQo+ID4gICB9DQo+IA0K
PiBQbGVhc2UgZXhjdXNlIG15IGlnbm9yYW5jZS4gSSB3b3VsZCBoYXZlIHRob3VnaCwgdGhhdCB0
aGUgc3lzdGVtDQo+IGZpcm13YXJlIGFscmVhZHkgcHV0IHRoYXQgT3B0aW9uIFJPTSBpbnRvIG1l
bW9yeS4gVGhlcmUgaXMgYSBmdW5jdGlvbg0KPiBgcGNpX21hcF9iaW9zcm9tKClgIGRlY2xhcmVk
IGluIGBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9iZV9yb21zLmhgIGFuZA0KPiBpbXBsZW1lbnRl
ZCBpbiBgYXJjaC94ODYva2VybmVsL3Byb2JlX3JvbXMuY2AsIHdoaWNoIG1pZ2h0IGJlIHVzZWQ/
DQo+IA0KDQpTdXJlLiBUaGlzIGZ1bmN0aW9uIGlzIHVzZWQgdG8gcmVhZCB0aGUgdmVyc2lvbiBk
YXRhIHRoYXQgd2UgcmVwb3J0IGFib3V0IHRoZSBmbGFzaCBjb250ZW50cyB2aWEgZGV2bGluayBp
bmZvLg0KDQpJIGJlbGlldmUgdGhlIHJlYXNvbmluZyB0aGlzIGlzIGRvbmUgZHVyaW5nIHJlYnVp
bGQgaXMgYmVjYXVzZSB0aGVyZSB3YXNuJ3QgYSBuZWVkIHRvIHNjYW4gaXQgb24gZGVtYW5kIHNp
bmNlIGl0IHdvbid0IGNoYW5nZSB1bmxlc3MgeW91IGRvIGEgZmxhc2ggdXBkYXRlLg0KDQpXZSBy
ZWFkIGluZm9ybWF0aW9uIG9uIHRoZSAzIG1ham9yIGNvbXBvbmVudHMgb2YgdGhlIGZsYXNoIGR1
cmluZyBpbml0OiB0aGUgRU1QIGZpcm13YXJlIHZlcnNpb25zLCB0aGUgT3B0aW9uIFJPTSB2ZXJz
aW9uIGRhdGEsIGFuZCBzb21ldGhpbmcgd2UgY2FsbCBuZXRsaXN0IHdoaWNoIEkgdW5kZXJzdGFu
ZCBjb250YWlucyBzb21lIGNvbmZpZ3VyYXRpb24gVExWcw0KDQpUaGUgcG9pbnQgb2YgdGhpcyBz
ZXBhcmF0ZSBmdW5jdGlvbiBpcyB0byBiZSBhYmxlIHRvIHJlcG9ydCBwcmVjaXNlbHkgd2hhdCB2
ZXJzaW9uIG9mIHRoZSBmaXJtd2FyZSBpbWFnZSB0aGF0IHdlIGhhdmUgbG9hZGVkIG9udG8gdGhl
IGRldmljZS4NCg0KVGhpcyBnZXRzIHJlcG9ydGVkIGluIGRldmxpbmsgaW5mbzoNCnBjaS8wMDAw
OmFmOjAwLjE6DQogIGRyaXZlciBpY2UNCiAgc2VyaWFsX251bWJlciAwMC0wMS0wMC1mZi1mZi0w
MC0wMC0wMA0KICB2ZXJzaW9uczoNCiAgICAgIGZpeGVkOg0KICAgICAgICBib2FyZC5pZCBLOTEy
NTgtMDAwDQogICAgICBydW5uaW5nOg0KICAgICAgICBmdy5tZ210IDYuMS41DQogICAgICAgIGZ3
Lm1nbXQuYXBpIDEuNy45DQogICAgICAgIGZ3Lm1nbXQuYnVpbGQgMHg2OTg2YmZkYg0KICAgICAg
ICBmdy51bmRpIDEuMzAyNS4wDQogICAgICAgIGZ3LnBzaWQuYXBpIDMuMTANCiAgICAgICAgZncu
YnVuZGxlX2lkIDB4ODAwMDhlNmENCiAgICAgICAgZncuYXBwLm5hbWUgSUNFIE9TIERlZmF1bHQg
UGFja2FnZQ0KICAgICAgICBmdy5hcHAgMS4zLjI3LjANCiAgICAgICAgZncuYXBwLmJ1bmRsZV9p
ZCAweGMwMDAwMDAxDQogICAgICAgIGZ3Lm5ldGxpc3QgMy4xMC4yMDAwLTMuMWUuMA0KICAgICAg
ICBmdy5uZXRsaXN0LmJ1aWxkIDB4NDE1NGRmYWMNCiAgICAgIHN0b3JlZDoNCiAgICAgICAgZncu
dW5kaSAxLjMwMjUuMA0KICAgICAgICBmdy5wc2lkLmFwaSAzLjEwDQogICAgICAgIGZ3LmJ1bmRs
ZV9pZCAweDgwMDA4ZTZhDQogICAgICAgIGZ3Lm5ldGxpc3QgMy4xMC4yMDAwLTMuMWUuMA0KICAg
ICAgICBmdy5uZXRsaXN0LmJ1aWxkIDB4NDE1NGRmYWMNCg0KU3BlY2lmaWNhbGx5LCBmdy51bmRp
IGNvbnRhaW5zIHRoZSB2ZXJzaW9uIG9mIHRoZSBPcHRpb24gUk9NIGltYWdlLiBXZSByZXBvcnQg
Ym90aCB0aGUgInJ1bm5pbmciIHZlcnNpb24sIGFuZCwgaWYgdGhlcmUgaXMgYSBwZW5kaW5nIGJh
bmsgc3dpdGNoIGR1cmluZyBuZXh0IGZpcm13YXJlIGxvYWQsIHRoZSB2ZXJzaW9uIHN0b3JlZCBp
biB0aGUgaW5hY3RpdmUgZmxhc2ggYmFuayB0aGF0IHdpbGwgYmUgc3dpdGNoZWQgdG8gbmV4dCBs
b2FkLg0KDQpUaGFua3MsDQpKYWtlDQoNCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KDQo=
