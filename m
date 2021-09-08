Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1524B403EBC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhIHR6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 13:58:21 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:51808
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232430AbhIHR6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 13:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV+P5gS3HWmAb4d610YQLI6JGo+xBBkUmH+uNH/KJmHGOLkc5K5G1CfCj1NZQer9S60HlsNofM1oT2XKPHsG60CvcXLFuto2fiZuyL9AmLhpt1k6JEcLOgYhSywRMqGkZLVXPOZ4gDFgTcLYg8aNPVhFw8kXBSqvFu8aBnyepWb6DdyZIvRH6JiZhP71A5vMQlg0kAF8BlylWKxiesdyzcsXJWqoEpgxkyEds8FHm4VCenqoqHJ7dENCh94siJ5FPFu0DuyibMfxylg8UhrVrepblyr/Q2sg5v8mC7f4ysswPcfmrMzJyA9dmzo5bzsZBUDVD+XzRzl0ZteKKpp0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eNrlopprrWtryRxWlPI8OogCWsJ35Ej8jgZog7mzXPQ=;
 b=QcYzdw/WqAke6k2wQxEOCmOSNMXbIKr7aJqJqtrg4NP0fuhmK3U+agVm4XqcrMRw9I8wd4FVXxPAtvtJ2Z8DvaBpkEC2xHXuFiWzW/0nDXNIoBOQA/eVtpJ201TmBHNamhlGm2SzxmtA7ROuMopKRdWaUOHMR2aQyppTvQDL+QcMgHM98L8YzCEWkCY0gMP/6zVFoOE5Bz0ghfjTR18x5fOR5px3qp+OycKqLRKbO+8pjp0QlomlVPRB7KL2w9EtMVQhRMv5XQSGfsqhW7lgMt/Bi5lCSrbNKj+70WEWHgKLXaLrNE0TJl3zb5H9uAeEOSBXQ1976xn4rWZ8m8TAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNrlopprrWtryRxWlPI8OogCWsJ35Ej8jgZog7mzXPQ=;
 b=b08HdCjvbyBoLJb//0AGHgMoROMidamZ1V83KlwjJ8Qi9QX1CyParm4iKhllKF18tpj2w5jd/dlBo792eZEYERAPLE7BWj6TV4BgByzz73+btlnrEiQkv1mo8k7xq4L02/NvIxITwQFgqRO/ERGH8//1moJhCkOgHqw1b68bL58=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 17:57:11 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::9dd5:3098:565e:d3db]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::9dd5:3098:565e:d3db%9]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 17:57:11 +0000
From:   "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Cornwall, Jay" <Jay.Cornwall@amd.com>
Subject: RE: crash observed with pci_enable_atomic_ops_to_root on VF devices.
Thread-Topic: crash observed with pci_enable_atomic_ops_to_root on VF devices.
Thread-Index: AQHXpMsQwhBu+EKzdEW6u0maaR/l0quaWHog
Date:   Wed, 8 Sep 2021 17:57:10 +0000
Message-ID: <DM6PR12MB5534AE1A9B6EF22D44F651BDF4D49@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210908155145.GA867184@bjorn-Precision-5520>
 <978872c2-f2c7-dcc3-14d5-799755cf0726@amd.com>
In-Reply-To: <978872c2-f2c7-dcc3-14d5-799755cf0726@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-08T17:57:08Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=40fd97c0-c83d-4fb9-aa5a-aca35108e85c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de8c96c6-ef0a-418f-0588-08d972f21516
x-ms-traffictypediagnostic: DM4PR12MB5344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB534499C806F0EEE57AEAE7A1F4D49@DM4PR12MB5344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtHgd9CAY4ekLVD3ikwHT9iYGk9k5FI8vQjXFOpvwUXbdDHmvpU4EpwCku5rbFmpOBC67BTkomV0hzFIyJearQGvTDtRr3SOwVaNg2zl5XJggIBImyI/RcE+BchUrbqe1SWUEyRsoVDWlyNBc6ojdIXnpA7XluUKsUdKAnFzq1PSD9qw14w9kj0BSqjAb4y8dpg76QgC5SCkUlYwzjl+82n/AVmwS1gkq+K3y2ALqanbHCIy+W9uRvlUhtQHLHJNjTNziR9WteghKIyfzuZ4rQqBhaR4PxrGV/xC5lCOqdrMxhA4Ud9gq7mIlt5H3KaE33mip68PvQYnKUHgn3vYJrV6FoGcyMx9oORjy6JNTyg3NBhVwFQI5HW1El3dRgKM72YJa4egIcaoxr+DNK4OaahBGajiDq9JmMgnWk5wD7ux65a0t1XLvs2GKSUcOCug7/jywfVDgy0htKiC7ise4JkC3lW9G0jIriVgEU6uiQt7RDWtJUwX7S8/Wiw4m3fB0lCDIuUO+bxl+UDOWHq+ACKMxjZRUcLGWOx14NYH+ONlkaP8xrk7pqgabEJBMe9F1OFONC72xtRnIiYPhCHdbJJi8Xob3Esf+ooZk++mD2VMAo+oKUnRpcUUpGXvNvEwVaELYKQ5KDCX3a2Pxt+iDHNWzVuOqjLhjCFeZdejBb2rizgFcblRpDd12CgkGx9WLi0loovpLXibMYSrs4jkzk9zkK1mE3OQpUtWjOt/TfSjjCYS33n+uAH7xekz2kY1YeYFy0bVjY0bLOlT/db+tTTcl2UIQ1hMCax24vbihOHAcGZImjLzxBRn659z9dfGYEcY5NZ1TAEa/VQDuVmEQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(110136005)(38070700005)(54906003)(122000001)(66556008)(7696005)(64756008)(33656002)(316002)(186003)(66476007)(966005)(8676002)(52536014)(8936002)(478600001)(38100700002)(5660300002)(26005)(86362001)(6506007)(66946007)(4326008)(83380400001)(76116006)(53546011)(71200400001)(9686003)(66446008)(55016002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FaUk1DeDJKWTV1ZXVRTVFpQTk0MGtoTlF0V0lBZlA5UmtLeVh1WUY0OUNW?=
 =?utf-8?B?ckxLZElnSVc2QnlXS2pkVjVocXEvWTVWTFlobWQ0QUJ2bXFLOXRIKzJ1cXRo?=
 =?utf-8?B?SjhhTVRZcGsrYjV1YUVsMW5EYWRqSkd2K0d5b2lsZUhzSGhaSVY2MGV2ay83?=
 =?utf-8?B?OUdCQ2tnYWhHdTAwWmVkbGsvVjFnUUNKNnlpNEJFaFdpaFBGNHJ4UklqUGsw?=
 =?utf-8?B?aGxrUTJURmQ5T29mUE5FKzEvS2NpRDRaaGY4WVBPZm5vSCtXa1VBNFplaVo4?=
 =?utf-8?B?WmR2QStoZndjVGhINmM1eVJVTlVIUEgvRW8rS1ZyaVY0RlNTZ3VKVHdNckV0?=
 =?utf-8?B?bWdRRC9hMHRCcWY0MUMzT3E3bm1PZGp2ZThMT3BUSjNveFdxajBWeFVSeGVB?=
 =?utf-8?B?TTZXM2ljQmVxbFRTbkNMWEk5NW9yUVhzaEVPN0grNWhYaGZ3VFMwNUZSS0R5?=
 =?utf-8?B?a3Y1K0trN1lZakdtaG4yY3hXa2plVFYrZGlpdU0rTlppeGF5eHROVkZZaUFs?=
 =?utf-8?B?MnNwSjd2dmt0ZXNldFFGMkNSeEtQVGg3RHBOdi9hOGdUOURxNWhHcWpqYWcx?=
 =?utf-8?B?VVNYWkJkR3k4MjFpQlhpdlMyNjVEcU5nbjRrMGNCYXRadlowNnl3QWRaWW9K?=
 =?utf-8?B?NTdBdHUweHpSSU40T255dkIrcHQ3Z2pkMDVVaWQwajIxbW9GTVhWTnlwK1NH?=
 =?utf-8?B?K25SQWFXOVVuZ0ljc0dZdnJiMWxOaElyN2VxM0NnaVVjWURIbHZEQnlzcGEz?=
 =?utf-8?B?bkI3Ujk1T3Q5SEFQaVBUR0pOV0laOG5IQVNPQ25VQTRCMEVZeld3dVRvOXBG?=
 =?utf-8?B?dmtMQlF4emNKSVZoMGFQTVIwKzN4NStnMW5TK3BsNGUvakFFL0x1SGpxWXFk?=
 =?utf-8?B?aWhVeFRwQyt3ci9ieU84THZybHVEKzhXaWlVVWtJTDNCWjRpS2JQbkxzenJa?=
 =?utf-8?B?VDFmYTFJR3FKV1pjUHpRNUF6Mi9XTE00S2ZKeFBzc0F5enVBOVQ4YjcyaDFs?=
 =?utf-8?B?SGx2bnd2b0FjbUVMT01YRDlYTDZFNmszTVovdmxRdlNacG1Lb25aYk9KcVgv?=
 =?utf-8?B?Q0F4Zk5aeGdwMjRKRjBPb29zTVB1TlphRTc2dEJ5YWIzK2xVKytGYUdQUFVO?=
 =?utf-8?B?QVlia2F5Qkkwc3E0c2dtRFU3V1RzeDk3bFFacjg0anBTM1VKTkVHeEtUN0NO?=
 =?utf-8?B?RXVCSmgwbWlkZHBVdE9YZGk0UmJoZzcvWElJWlJKbmF2U0l1eGNYem1iaVJD?=
 =?utf-8?B?aXdicjZMMFd6dlBKMEFEcTJ6K1F4SnR6Q3JUWDlES3Nkd2VXc1FzTHNQa0JM?=
 =?utf-8?B?QW9QYjFsL2Y0UjcyNjUvT25ra1p4MEppNzgxYnFYelYweFA4K2FmRzNKOFpO?=
 =?utf-8?B?WktObjNORU9zQ3F0N2dGYXNpV3FBYWRoT0RXLzgxWGd0TG9RNUgwR0dJa2Iy?=
 =?utf-8?B?Q0hVSlRVYVM0NjVsU1piakM3Y3hLa0gzL3BSUTlQSk1KWndFZmxQMVdNWEpa?=
 =?utf-8?B?aitMdzN6WXNOMmxTS2hDeFQ1WE1HVzhwZk9HRGUvcjZyTXJodWR6NjlWd0tS?=
 =?utf-8?B?YlBvdks4V05wWldmQzdJNzd4bkFGcnJwTUZsVDl0VG9CTFJpM0dCN0NEZUlr?=
 =?utf-8?B?TmxiVjJ5bUl1WTdZRWYzWjdpazV6N21NaFdZZDdBSVhrNDdhazExQW0wMExZ?=
 =?utf-8?B?ZUE1TW1Cb01PQmJaQjh5bmIzT01Gc1l5ejUzNGVYTi8wVXlqVHhaSi9LZkxm?=
 =?utf-8?Q?rWeEEFOwwPsEYp7Q94qY2w+5eKPH637jOIeLoaN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8c96c6-ef0a-418f-0588-08d972f21516
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 17:57:10.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw3Wov471VgL/0461CQ0/Diz8YWnN/c9wHlb8/AAjkvbXi/OGCFISJLGFfrdOgKNFV/Y7Glbj1APF15h1MQwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KWWVzICwgYWNjb3JkaW5nIHRvICB0aGUgc3BlYyB0
aGUgIEF0b21pY09wc0N0bCBiaXQgaXMgcmVzZXJ2ZWQgaW4gVkYgd2hpY2ggbWVhbnMgZHJpdmVy
IHNob3VsZG4ndCB0b3VjaCBpdCAuICBUaGUgdGhpbmcgY29uZnVzZWQgdXMgaXMgUEYgdmFsdWUg
YXBwbGllcyB0byBhbGwgYXNzb2NpYXRlIFZGcy4gd2UgYWN0dWFsbHkgZGlkIHNvbWUgZXhwZXJp
bWVudCB0cnkgdG8gcmVhZCBpdCBpbiANClZGIGFuZCB3YW50IHRvIHVzZSBpdCB0byBjaGVjayB3
aGV0aGVyIHRoZSBhdG9taWNPcHMgaXMgZW5hYmxlZCAsd2UgZm91bmQgdGhhdCByZWFkIHRoZSBB
dG9taWNPcHNDdGwgd2lsbCBhbHdheXMgcmV0dXJuIDAgaW4gVmYgIGFsdGhvdWdoICBQRiBhbHJl
YWR5IHNldCBpdC4gIFdlIGFsc28gdmVyaWZpZWQgdGhlIEtGRFRlc3QuYXRvbWljIHRlc3QgcGFz
c2VkIGluIFZGIHdoZW4gdGhlICBQRiBlbmFibGVkIHRoZSBhdG9taWNPcHMuICBTbyB3ZSAgdGhp
bmsgdGhlIFZGIGFscmVhZHkgYXBwbGllZCB0aGUgc2V0dGluZyBidXQgdGhlIHZhbHVlciBjYW4n
dCBiZSByZWFkIC4NCiANCkknbSBwcmVwYXJpbmcgYSBjaGFuZ2UgdGhhdCBmb3IgU1JJT1Ygc2V0
dXAsIHRoZSBndWVzdCBkcml2ZXIgd2lsbCBub3QgdHJ5IHRvIGVuYWJsZSB0aGUgYXRvbWljT3Bz
LCBpdCB3aWxsIHRyeSB0byBnZXQgdGhlIGVuYWJsZSBpbmZvcm1hdGlvbiBmcm9tIGhvc3QgIGVp
dGhlciB0aHJvdWdoIHByaXZhdGUgY29tbXVuaWNhdGlvbiBjaGFubmVsIG9yICBkYXRhIGV4Y2hh
bmdlIHJlZ2lvbiBiZXR3ZWVuICBob3N0IGFuZCBndWVzdC4gIEhvc3QgZHJpdmVyIChmb3IgIHRo
ZSBQRikgd2lsbCB0cnkgdG8gZW5hYmxlIHRoZSBhdG9taWNPcHMgd2l0aCB0aGUgcGNpX2VuYWJs
ZV9hdG9taWNfb3BzX3RvX3Jvb3QgIG9uIEtWTSBvciBpbXBsZW1lbnQgdGhlIHNpbWlsYXIgZnVu
Y3Rpb25hbGl0eSBpZiB0aGUgaG9zdCBPUyBkb2Vzbid0IHN1cHBvcnQgdGhpcy4gDQoNClJlZ2Fy
ZHMNCnNoYW95dW4ubGl1DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1
ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gDQpTZW50OiBXZWRuZXNkYXks
IFNlcHRlbWJlciA4LCAyMDIxIDEyOjAzIFBNDQpUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0Br
ZXJuZWwub3JnPjsgU2VsdmluIFhhdmllciA8c2VsdmluLnhhdmllckBicm9hZGNvbS5jb20+OyBM
aXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpDYzogbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IEphc29uIEd1bnRob3JwZSA8amdn
QHppZXBlLmNhPjsgRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPjsgQW5kcmV3IEdv
c3BvZGFyZWsgPGFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNvbT47IE1pY2hhZWwgQ2hhbiA8
bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IERldmVzaCBTaGFybWEgPGRldmVzaC5zaGFybWFA
YnJvYWRjb20uY29tPjsgQ29ybndhbGwsIEpheSA8SmF5LkNvcm53YWxsQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogY3Jhc2ggb2JzZXJ2ZWQgd2l0aCBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9fcm9v
dCBvbiBWRiBkZXZpY2VzLg0KDQpBbSAyMDIxLTA5LTA4IHVtIDExOjUxIGEubS4gc2NocmllYiBC
am9ybiBIZWxnYWFzOg0KPiBbK2NjIERldmVzaCwgSmF5LCBGZWxpeF0NCj4NCj4gT24gV2VkLCBT
ZXAgMDEsIDIwMjEgYXQgMDY6NDE6NTBQTSArMDUzMCwgU2VsdmluIFhhdmllciB3cm90ZToNCj4+
IEhpIGFsbCwNCj4+DQo+PiBBIHJlY2VudCBwYXRjaCBtZXJnZWQgdG8gNS4xNCBpbiB0aGUgQnJv
YWRjb20gUkRNQSBkcml2ZXIgIHRvIGNhbGwgDQo+PiBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9f
cm9vdCBjcmFzaGVzIHRoZSBob3N0IHdoaWxlIGNyZWF0aW5nIFZGcy4gDQo+PiBUaGUgY3Jhc2gg
aXMgc2VlbiB3aGVuIHBjaV9lbmFibGVfYXRvbWljX29wc190b19yb290IGlzIGNhbGxlZCB3aXRo
IGEgDQo+PiBWRiBwY2kgZGV2aWNlLiAgcGRldi0+YnVzLT5zZWxmIGlzIE5VTEwuICBJcyB0aGlz
IGV4cGVjdGVkIGZvciBWRj8NCj4gU29ycnkgSSBtaXNzZWQgdGhpcyBiZWZvcmUuICBJIHRoaW5r
IHlvdSdyZSByZWZlcnJpbmcgdG8gMzVmNWFjZTVkZWE0DQo+ICgiUkRNQS9ibnh0X3JlOiBFbmFi
bGUgZ2xvYmFsIGF0b21pYyBvcHMgaWYgcGxhdGZvcm0gc3VwcG9ydHMiKSBbMV0sIA0KPiBzbyBJ
IGNjJ2QgRGV2ZXNoICh0aGUgYXV0aG9yKS4NCj4NCj4gSXQgKmlzKiBleHBlY3RlZCB0aGF0IHZp
cnR1YWwgYnVzZXMgYWRkZWQgZm9yIFNSLUlPViBoYXZlDQo+IGJ1cy0+c2VsZiA9PSBOVUxMLCBi
dXQgSSBkb24ndCB0aGluayBhZGRpbmcgYSBjaGVjayBmb3IgdGhhdCBpcw0KPiBzdWZmaWNpZW50
Lg0KPg0KPiBUaGUgQXRvbWljT3AgUmVxdWVzdGVyIEVuYWJsZSBiaXQgaXMgaW4gdGhlIERldmlj
ZSBDb250cm9sIDIgcmVnaXN0ZXIsIA0KPiBhbmQgcGVyIFBDSWUgcjUuMCwgc2VjIDkuMy41LjEw
LCBpdCBpcyByZXNlcnZlZCBpbiBWRnMgYW5kIHRoZSBQRiANCj4gdmFsdWUgYXBwbGllcyB0byBh
bGwgYXNzb2NpYXRlZCBWRnMuDQo+DQo+IHBjaV9lbmFibGVfYXRvbWljX29wc190b19yb290KCkg
ZG9lcyBub3QgYXBwZWFyIHRvIHRha2UgdGhhdCBpbnRvIA0KPiBhY2NvdW50LCBzbyBJIGFsc28g
Y2MnZCBKYXkgYW5kIEZlbGl4LCB0aGUgYXV0aG9ycyBvZiA0MzBhMjM2ODlkZWENCj4gKCJQQ0k6
IEFkZCBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9fcm9vdCgpIikgWzJdLg0KPg0KPiBJdCBsb29r
cyBsaWtlIHdlIG5lZWQgdG8gZW5hYmxlIEF0b21pY09wcyBpbiB0aGUgKlBGKiwgbm90IGluIHRo
ZSBWRi4NCj4gTWF5YmUgdGhhdCBtZWFucyBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9fcm9vdCgp
IHNob3VsZCByZXR1cm4gZmFpbHVyZSANCj4gd2hlbiBjYWxsZWQgb24gYSBWRiwgYW5kIGl0IHNo
b3VsZCBiZSB1cCB0byB0aGUgZHJpdmVyIHRvIGNhbGwgaXQgb24gDQo+IHRoZSBQRiBpbnN0ZWFk
PyAgSSdtIG5vdCBhbiBleHBlcnQgb24gaG93IFZGcyBhcmUgdXNlZCwgYnV0IEkgZG9uJ3QgDQo+
IGxpa2UgdGhlIGlkZWEgb2YgZGV2aWNlIEIgcmVhY2hpbmcgb3V0IHRvIGNoYW5nZSB0aGUgY29u
ZmlndXJhdGlvbiBvZiANCj4gZGV2aWNlIEEsIGVzcGVjaWFsbHkgd2hlbiB0aGUgY2hhbmdlIGFs
c28gYWZmZWN0cyBkZXZpY2VzIEMsIEQsIEUsIC4uLg0KDQpJbnRlcmVzdGluZyB0aW1pbmcuIFsr
U2hhb3l1bl0gaXMganVzdCB3b3JraW5nIG9uIFNSLUlPViBwcm9ibGVtcyB3aXRoIGF0b21pYyBv
cGVyYXRpb25zIHRoZXNlIGRheXMuDQoNCkkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgZm9yIHBjaV9l
bmFibGVfYXRvbWljX29wc190b19yb290IHRvIGZhaWwgb24gVkZzLg0KVGhlIGd1ZXN0IGRyaXZl
ciBlaXRoZXIgaGFzIHRvIHdvcmsgd2l0aG91dCBhdG9taWMgb3BzLCBvciBpdCBoYXMgdG8gcmVs
eSBvbiBzaWRlLWJhbmQgaW5mb3JtYXRpb24gZnJvbSB0aGUgaG9zdCAoUEYpIGRyaXZlciB0byBr
bm93IHdoZXRoZXIgYXRvbWljIG9wcyBhcmUgYXZhaWxhYmxlLg0KDQpSZWdhcmRzLA0KwqAgRmVs
aXgNCg0KDQo+DQo+IEJqb3JuDQo+DQo+IFsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL2xpbnVz
LzM1ZjVhY2U1ZGVhNA0KPiBbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9saW51cy80MzBhMjM2
ODlkZWENCj4NCj4+IEhlcmUgaXMgdGhlIHN0YWNrIHRyYWNlIGZvciB5b3VyIHJlZmVyZW5jZS4N
Cj4+IGNyYXNoPiBidA0KPj4gUElEOiA0NDgxICAgVEFTSzogZmZmZjg5YzY5NDFiMDAwMCAgQ1BV
OiA1MyAgQ09NTUFORDogImJhc2giDQo+PiAgIzAgW2ZmZmY5YTk0ODE3MTM2ZDhdIG1hY2hpbmVf
a2V4ZWMgYXQgZmZmZmZmZmZiOTA2MDFhNA0KPj4gICMxIFtmZmZmOWE5NDgxNzEzNzI4XSBfX2Ny
YXNoX2tleGVjIGF0IGZmZmZmZmZmYjkxOTBkNWQNCj4+ICAjMiBbZmZmZjlhOTQ4MTcxMzdmMF0g
Y3Jhc2hfa2V4ZWMgYXQgZmZmZmZmZmZiOTE5MWM0ZA0KPj4gICMzIFtmZmZmOWE5NDgxNzEzODA4
XSBvb3BzX2VuZCBhdCBmZmZmZmZmZmI5MDI1Y2Q2DQo+PiAgIzQgW2ZmZmY5YTk0ODE3MTM4Mjhd
IHBhZ2VfZmF1bHRfb29wcyBhdCBmZmZmZmZmZmI5MDZlNDE3DQo+PiAgIzUgW2ZmZmY5YTk0ODE3
MTM4ODhdIGV4Y19wYWdlX2ZhdWx0IGF0IGZmZmZmZmZmYjlhMGFkMTQNCj4+ICAjNiBbZmZmZjlh
OTQ4MTcxMzhiMF0gYXNtX2V4Y19wYWdlX2ZhdWx0IGF0IGZmZmZmZmZmYjljMDBhY2UNCj4+ICAg
ICBbZXhjZXB0aW9uIFJJUDogcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQrMjhdDQo+PiAgICAg
UklQOiBmZmZmZmZmZmI5NTJmZDVjICBSU1A6IGZmZmY5YTk0ODE3MTM5NjAgIFJGTEFHUzogMDAw
MTAyNDYNCj4+ICAgICBSQVg6IDAwMDAwMDAwMDAwMDAwMDEgIFJCWDogZmZmZjg5YzZiMTA5NjAw
MCAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+PiAgICAgUkRYOiBmZmZmOWE5NDgxNzEzOTkwICBS
U0k6IDAwMDAwMDAwMDAwMDAwMjQgIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KPj4gICAgIFJCUDog
MDAwMDAwMDAwMDAwMDA4MCAgIFI4OiAwMDAwMDAwMDAwMDAwMDA4ICAgUjk6IGZmZmY4OWM2NDM0
MWEyZjgNCj4+ICAgICBSMTA6IDAwMDAwMDAwMDAwMDAwMDIgIFIxMTogMDAwMDAwMDAwMDAwMDAw
MCAgUjEyOiBmZmZmODljNjQ4YmFiMDAwDQo+PiAgICAgUjEzOiAwMDAwMDAwMDAwMDAwMDAwICBS
MTQ6IDAwMDAwMDAwMDAwMDAwMDAgIFIxNTogZmZmZjg5YzY0OGJhYjBjOA0KPj4gICAgIE9SSUdf
UkFYOiBmZmZmZmZmZmZmZmZmZmZmICBDUzogMDAxMCAgU1M6IDAwMTgNCj4+ICAjNyBbZmZmZjlh
OTQ4MTcxMzk4OF0gcGNpX2VuYWJsZV9hdG9taWNfb3BzX3RvX3Jvb3QgYXQgDQo+PiBmZmZmZmZm
ZmI5NTM1OWE2DQo+PiAgIzggW2ZmZmY5YTk0ODE3MTM5YzBdIGJueHRfcXBsaWJfZGV0ZXJtaW5l
X2F0b21pY3MgYXQNCj4+IGZmZmZmZmZmYzA4YzFhMzMgW2JueHRfcmVdDQo+PiAgIzkgW2ZmZmY5
YTk0ODE3MTM5ZDBdIGJueHRfcmVfZGV2X2luaXQgYXQgZmZmZmZmZmZjMDhiYTJkMSBbYm54dF9y
ZV0NCj4+ICMxMCBbZmZmZjlhOTQ4MTcxM2E3OF0gYm54dF9yZV9uZXRkZXZfZXZlbnQgYXQgZmZm
ZmZmZmZjMDhiYWI4ZiANCj4+IFtibnh0X3JlXQ0KPj4gIzExIFtmZmZmOWE5NDgxNzEzYWE4XSBy
YXdfbm90aWZpZXJfY2FsbF9jaGFpbiBhdCBmZmZmZmZmZmI5MTAyY2JlDQo+PiAjMTIgW2ZmZmY5
YTk0ODE3MTNhZDBdIHJlZ2lzdGVyX25ldGRldmljZSBhdCBmZmZmZmZmZmI5ODAzZmYzDQo+PiAj
MTMgW2ZmZmY5YTk0ODE3MTNiMDhdIHJlZ2lzdGVyX25ldGRldiBhdCBmZmZmZmZmZmI5ODA0MTBh
DQo+PiAjMTQgW2ZmZmY5YTk0ODE3MTNiMThdIGJueHRfaW5pdF9vbmUgYXQgZmZmZmZmZmZjMDM0
OTU3MiBbYm54dF9lbl0NCj4+ICMxNSBbZmZmZjlhOTQ4MTcxM2I3MF0gbG9jYWxfcGNpX3Byb2Jl
IGF0IGZmZmZmZmZmYjk1M2I5MmYNCj4+ICMxNiBbZmZmZjlhOTQ4MTcxM2JhMF0gcGNpX2Rldmlj
ZV9wcm9iZSBhdCBmZmZmZmZmZmI5NTNjZjhmDQo+PiAjMTcgW2ZmZmY5YTk0ODE3MTNiZThdIHJl
YWxseV9wcm9iZSBhdCBmZmZmZmZmZmI5NjU5NjE5DQo+PiAjMTggW2ZmZmY5YTk0ODE3MTNjMDhd
IF9fZHJpdmVyX3Byb2JlX2RldmljZSBhdCBmZmZmZmZmZmI5NjU5OGZiDQo+PiAjMTkgW2ZmZmY5
YTk0ODE3MTNjMjhdIGRyaXZlcl9wcm9iZV9kZXZpY2UgYXQgZmZmZmZmZmZiOTY1OTk4Zg0KPj4g
IzIwIFtmZmZmOWE5NDgxNzEzYzQ4XSBfX2RldmljZV9hdHRhY2hfZHJpdmVyIGF0IGZmZmZmZmZm
Yjk2NTljZDINCj4+ICMyMSBbZmZmZjlhOTQ4MTcxM2M3MF0gYnVzX2Zvcl9lYWNoX2RydiBhdCBm
ZmZmZmZmZmI5NjU3MzA3DQo+PiAjMjIgW2ZmZmY5YTk0ODE3MTNjYThdIF9fZGV2aWNlX2F0dGFj
aCBhdCBmZmZmZmZmZmI5NjU5M2UwDQo+PiAjMjMgW2ZmZmY5YTk0ODE3MTNjZThdIHBjaV9idXNf
YWRkX2RldmljZSBhdCBmZmZmZmZmZmI5NTMwYjdhDQo+PiAjMjQgW2ZmZmY5YTk0ODE3MTNkMDBd
IHBjaV9pb3ZfYWRkX3ZpcnRmbiBhdCBmZmZmZmZmZmI5NTViMWNhDQo+PiAjMjUgW2ZmZmY5YTk0
ODE3MTNkNDBdIHNyaW92X2VuYWJsZSBhdCBmZmZmZmZmZmI5NTViNTRiDQo+PiAjMjYgW2ZmZmY5
YTk0ODE3MTNkOTBdIGJueHRfc3Jpb3ZfY29uZmlndXJlIGF0IGZmZmZmZmZmYzAzNGQ5MTMgDQo+
PiBbYm54dF9lbl0NCj4+ICMyNyBbZmZmZjlhOTQ4MTcxM2RkOF0gc3Jpb3ZfbnVtdmZzX3N0b3Jl
IGF0IGZmZmZmZmZmYjk1NWFjYjQNCj4+ICMyOCBbZmZmZjlhOTQ4MTcxM2UxMF0ga2VybmZzX2Zv
cF93cml0ZV9pdGVyIGF0IGZmZmZmZmZmYjkzZjA5YWQNCj4+ICMyOSBbZmZmZjlhOTQ4MTcxM2U0
OF0gbmV3X3N5bmNfd3JpdGUgYXQgZmZmZmZmZmZiOTMzYjgyYw0KPj4gIzMwIFtmZmZmOWE5NDgx
NzEzZWQwXSB2ZnNfd3JpdGUgYXQgZmZmZmZmZmZiOTMzZGI2NA0KPj4gIzMxIFtmZmZmOWE5NDgx
NzEzZjAwXSBrc3lzX3dyaXRlIGF0IGZmZmZmZmZmYjkzM2RkOTkNCj4+ICMzMiBbZmZmZjlhOTQ4
MTcxM2YzOF0gZG9fc3lzY2FsbF82NCBhdCBmZmZmZmZmZmI5YTA3ODk3DQo+PiAjMzMgW2ZmZmY5
YTk0ODE3MTNmNTBdIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSBhdCBmZmZmZmZmZmI5
YzAwMDdjDQo+PiAgICAgUklQOiAwMDAwN2Y0NTA2MDJmNjQ4ICBSU1A6IDAwMDA3ZmZlODgwODY5
ZTggIFJGTEFHUzogMDAwMDAyNDYNCj4+ICAgICBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgIFJCWDog
MDAwMDAwMDAwMDAwMDAwMiAgUkNYOiAwMDAwN2Y0NTA2MDJmNjQ4DQo+PiAgICAgUkRYOiAwMDAw
MDAwMDAwMDAwMDAyICBSU0k6IDAwMDA1NTVjNTY2YzRhNjAgIFJESTogMDAwMDAwMDAwMDAwMDAw
MQ0KPj4gICAgIFJCUDogMDAwMDU1NWM1NjZjNGE2MCAgIFI4OiAwMDAwMDAwMDAwMDAwMDBhICAg
Ujk6IDAwMDA3ZjQ1MDYwYzI1ODANCj4+ICAgICBSMTA6IDAwMDAwMDAwMDAwMDAwMGEgIFIxMTog
MDAwMDAwMDAwMDAwMDI0NiAgUjEyOiAwMDAwN2Y0NTA2MzAyNmUwDQo+PiAgICAgUjEzOiAwMDAw
MDAwMDAwMDAwMDAyICBSMTQ6IDAwMDA3ZjQ1MDYyZmQ4ODAgIFIxNTogMDAwMDAwMDAwMDAwMDAw
Mg0KPj4gICAgIE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDAxICBDUzogMDAzMyAgU1M6IDAwMmIN
Cj4+DQo+PiBQbGVhc2Ugc3VnZ2VzdCBhIGZpeCBmb3Igc29sdmluZyB0aGlzIGlzc3VlLiBJcyBh
ZGRpbmcgYSBOVUxMIGNoZWNrIA0KPj4gZm9yIGJ1cy0+c2VsZiBzb3VuZHMgb2theT8NCj4+DQo+
PiBUaGFua3MsDQo+PiBTZWx2aW4NCg==
