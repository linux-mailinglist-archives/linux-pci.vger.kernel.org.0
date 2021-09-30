Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6E41D298
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 07:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhI3FHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 01:07:48 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:3841
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229918AbhI3FHs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 01:07:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq2NR55RtAcAZ9nD8fYXv8wWYQWhcDN/SJXpp3QMqsXieKLoPYMcGUbxR4aU/5s21VBYyzHa6Wq0JACIvYkPhu0B0msnZqDRl2suiD2zrPuJmhegxq+MHkl2fKUKczIYwthmECOgLbQVMrfxZY2yviYtuf9a4k/HbggOHkCPV6IWt4RlRU4Y7kRMZumrfaB1B279kMogKVJ7VGwB22+gaIstEPQ/DMLW6wTu8xEYHKRcyog58tHsQUwaE0cIS2jOWPidRJNkq4rQf44hA4JsONARW6aaEUggNIl/rVLC9XMTDpSdToQr5Q8QB2tcqdC7gM55TqJnVrcESgriYbIXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n4apOFsF6g5BVOtw89xtPAjefBg3Zju1qz1MqxDBEXc=;
 b=OW8Pra4iA7uXUA0jSrw7GRVw4de0VyQInaaXW/8n78vNM1KgfcpLM3hTbwQjYRiapc6g6I9bCw35Js7DXlw6ODJHyC0RByfBy5EJCWL8h8AUiaAxBAIolnXBGOPdROUHNBKUVB91ZRQmD4wwjNJOzpo2mzNTeiHMQ7TF+8htw65FKm2x8HUlUz1ukgtGEBeK1ePOZFo+n+H28XUSULA7PLCNVYfH0K7KEJZ4LNB6yYzYQH3sQJJKffKogARnjkjOwDz/6QxzSlMJdlr7zzDObTokXAstTIfSiHZx1ExjHOAFA5jF3e+ILAM2LMiFaLgQ/mtdefQ3+JFM0aggee3Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4apOFsF6g5BVOtw89xtPAjefBg3Zju1qz1MqxDBEXc=;
 b=l9Px9BdZ0EH0PuGsTcwRRWavVViKqAalEQIM0VBwEXsBmYKwwDeAKAAFnzr4ybxy2r0rGR7wANkcUSLTGWyeC0Xam+W4edMDijpoNqgMnZ3mLi8lfUc1qQHV2ql3ps1mZr9PxzIK+1np7p7PR6HlTEQV0Wl3ILRep06bvtFS9KYQ/M77jgcIQ4WT9uN4TpzwqQT8tOafYCE/ToGfgvjK7uHHBFntr2RkXanM/1x5+bX5c2y/4F0VnFi+fY4ugPIetWXeTCrgJfQ4OvfCmzsUUuBe/jVUtE8cLvcfXrSm2q3FVKbCyqlQ5qqFu95idLZGzDO1HqwzcU/Sga07cHGEMA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 05:06:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 05:06:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 09/20] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
Thread-Topic: [PATCH v3 09/20] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
Thread-Index: AQHXq1RfNFWZGZ0XhUyLU5ISdBtHSKu8GxKA
Date:   Thu, 30 Sep 2021 05:06:03 +0000
Message-ID: <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-10-logang@deltatee.com>
In-Reply-To: <20210916234100.122368-10-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 777e5a4f-a1f2-4c79-5cf4-08d983d000ee
x-ms-traffictypediagnostic: MWHPR12MB1199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB119923677811C4266C81079EA3AA9@MWHPR12MB1199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjgYc7HlMPZV+h+4lXXyq0FpimubPsv/g7EwewUvRE5Mkb8DJTGb2B00RZKY31GvPGuz1jTM837woGlfOlcNq6PT59eYCNTBkJ6uElLl3uGcUfsOj1QCqRlvipEBdhE3HVKTAgomQAvsk1+I/GhNzVEjz9Hfbba+per6PP+GpHoSrsd3GTFpN1kS67VSRlZ6wj50vPf5+3eIKk70llYZoWpWR7MbiJ5I7N9f9w1ud/TztEnd+ddTR54b9ARaCWYeWIj24EvUbaTWNfijNHMUh/kfvLCf7cSEfqruZ/978RG3EgoywJlqAjVyWCyEVBIlsgVD5SgsxEj3eYI/V3AbW7C7t4jGcYqhgR6kDQBmXVr9KliFcVDCvr23P2DrdXtxQLRvrwPaOqUV0w7NpGj4GT4VU18mrhyhSaC5duC2Sc6kxr5Ga0eaV8R8z3ZSyYJyzcgMeEm0yhQbSgW2NUYIS45tP+t4ucHJ0z/G8vnN9MZWSGhKJvYpCAtv/fsI15JdogGEOBpZ6y5td0yBK8s8c/jte/XNvgSwfbiw6Zw/4dKBbthviLyVjCYHlBUE7vEExkc7z53Dps4TSziZBsU2NUqj+a+7NUpmp28lecZXknIwk02LnKVklV/Ef7FvbSXjrwOJ9qo2PAhlHb0asH+3lgq5mThRXgCYGJ5ncJn0bhHmh+q2KtHYCxqy4bwAdmsckTV120IZdhj5wM7rjamoAHWH8a3NwXSTDWlGm/BINon+vVvqiBIU0czeGjSWtQlmUhiyEpUeWjK2gqnFTFRZ8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(86362001)(5660300002)(7416002)(508600001)(26005)(122000001)(2906002)(36756003)(54906003)(186003)(4326008)(66946007)(6512007)(31696002)(110136005)(316002)(71200400001)(38070700005)(6506007)(31686004)(66476007)(83380400001)(76116006)(2616005)(8676002)(8936002)(91956017)(6486002)(64756008)(66446008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlRmc0V0UEJGUWZQa1FsY21vdUQweUpFYU4zdGhlNU1tblltRnk3WVc3aC9U?=
 =?utf-8?B?ZTlMR080MnNQV2VWR0tjWEY5aXpzVG1RZ1JTZ3hvWG53OXFQakxUNVBHZHJE?=
 =?utf-8?B?czdpcXBSakpEMWRUMFFZdzZsQlFVNVFhT2VVaWRDeWFQMGFycWNQRVJxRjFO?=
 =?utf-8?B?Z3ExY3pUd2dPRmwxOXRLUURYeTAvNFJDM1dPMGFhMkZNKzV1VTRHUWc2THdK?=
 =?utf-8?B?R1RndzBqV0tsVWtvMTlDRTFTYzRYeVZJNDRkODEyK0I2MUs1Umt2MTR5U1dv?=
 =?utf-8?B?SXVmcTNTdWd0R2JsZ0ttVWNGblBmcGJRZXdvS1NoUHc5MUtFbzVuZmRmMWNF?=
 =?utf-8?B?QnUrdTFvcmpKV05uSDdua1ZQam5Oenh6Y0hDTEhyb2tQdU12N0h6ZHRJblMz?=
 =?utf-8?B?WnpBcUJ6OVM0LytNcTB4TzZXcDNtblV4azJHUkx3SkFTY3cvL3djOXdudDBL?=
 =?utf-8?B?NmlNQm5nQXFqVHlWVnRHdVVhOVU5Y1N4WmJxSisvcnpWUmx2Wks2SHZxQ3JI?=
 =?utf-8?B?UDQ2VHJ5NFFTTEZOK0NxVDBKdDlwaUVieE5SYWJqYkxSQzdabFBKVi9YNlg3?=
 =?utf-8?B?M1ZFZjdzSlhwT0NGK3BZU2NvcmVLSGpnMHozL1dDQ2dzeUpST1c4M1lDYWNu?=
 =?utf-8?B?emFwU3h5blJFQmo3VGp4N2R5dE5haHpRQjRSRXkyRzd3TGxEeFBWbE40K29J?=
 =?utf-8?B?NFNwdm9tRzU0QUh6dU83QXdUM2RPVm9hbnJ1MDZ2b1hWYlBuaDdNNDl3TlF4?=
 =?utf-8?B?TlgrckgvWFZqTzQ3czBORzhGeDNrT0JWTUltSHZtSkcyK3VRQlVubEI1YVk0?=
 =?utf-8?B?OEcramFnazJrZEtTTWlUbU16NUJTL2NTeURSZm9IOEdxMDVOd1VQK3YyOCsr?=
 =?utf-8?B?d0xKM1lXY0lRZCtRSHZxSVpPakVHRG95K3k2VFhlVngyWmxnSXRKSEtWSUoz?=
 =?utf-8?B?cTR1Z0ZDb0FwbVZHNDBJVmlHMk5idDU5N1JiOWtHcUppWkYrY1psOWFFQmp2?=
 =?utf-8?B?TSs5TFlRSzJqTlV4Y1Jpb3dteXFHbkNVa1IxRm1VRG83dXRjTytESHE1SkZH?=
 =?utf-8?B?OXRPR1VKOUhYVGV4c1dGem1DVDYxMVd4SWxzYnRXRXl6Qi9ja2wrZVJnSiti?=
 =?utf-8?B?QTRKNURITGtHQ0NVTElFSHFXSkJqSVI0K0VLMzRRekErRDcxdzhaaVdTamxL?=
 =?utf-8?B?Rk9tc1NKU1hOMm5PRkdpNHYxVG9OdWx1L2hqQnpsTWFIeHVhK25WQXY4ZWF0?=
 =?utf-8?B?bzF4ZzRGdGNYMTJzZEVFU1pab3FRLzRKOGlyenZiTHZBZFQ4UktkeGY4Znpt?=
 =?utf-8?B?bERCRUhwM09EQ050MDlMam9BYkxlQk91NW16K095TkJTblVWeWVjWXluNTF3?=
 =?utf-8?B?L21Nbnh5eWc1U0EyeWtpcXN3Q0I2aGkrclRzaERqSHlsenFPOEFCQndOc3Vp?=
 =?utf-8?B?NW82d1VJb1pENTV5akdzUlpwSHRCNlJrQTR4Q1NQN3RlY1Z4ci94SjU1M25S?=
 =?utf-8?B?eGM3TElMNklCNnlrUTQrT0tSbTk2ZTFTNzJsY2Q3cktDbHY3bXFGNHlBd0o1?=
 =?utf-8?B?bGs2cWVzN2pTUUovaEI3OGkrNG5pS0g4ZU9pK0ZEaWlRWkFraDY2SWxGS0Qv?=
 =?utf-8?B?NzFSeG1mcFE5WkdNYXJURjh6b3dUN252MW5BZ1l3d3haMENtVHd5LzdQTTBn?=
 =?utf-8?B?QjlYMlRHMUVuR3cyLzYzdlZ4SGFOOWpIaVhCQWs1T1NRODc4ZVdqMmM1Q3Z0?=
 =?utf-8?Q?sArylWtH+P1cDrKmGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FF28D33A5C7914D8479462BA157C132@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777e5a4f-a1f2-4c79-5cf4-08d983d000ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 05:06:03.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fvCR/4ED2Ayi6HSchUtjcYuvhr9IO6JHd9fgplg1magDGfGHaOxut5ftTUJf+itmnK7p6phJvgkcwyjKdqkxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TG9nYW4sDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBpbmRleCA3ZWZiMzFiODdmMzcuLjkxNjc1MGE1NGY2MCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYw0KPiBAQCAtMzc3MSw3ICszNzcxLDggQEAgc3RhdGljIHZvaWQgbnZt
ZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLA0KPiAgICAg
ICAgICAgICAgICAgIGJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1NUQUJMRV9XUklURVMs
IG5zLT5xdWV1ZSk7DQo+IA0KPiAgICAgICAgICBibGtfcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxB
R19OT05ST1QsIG5zLT5xdWV1ZSk7DQo+IC0gICAgICAgaWYgKGN0cmwtPm9wcy0+ZmxhZ3MgJiBO
Vk1FX0ZfUENJX1AyUERNQSkNCj4gKyAgICAgICBpZiAoY3RybC0+b3BzLT5zdXBwb3J0c19wY2lf
cDJwZG1hICYmDQo+ICsgICAgICAgICAgIGN0cmwtPm9wcy0+c3VwcG9ydHNfcGNpX3AycGRtYShj
dHJsKSkNCj4gICAgICAgICAgICAgICAgICBibGtfcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19Q
Q0lfUDJQRE1BLCBucy0+cXVldWUpOw0KPiANCj4gICAgICAgICAgbnMtPmN0cmwgPSBjdHJsOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hv
c3QvbnZtZS5oDQo+IGluZGV4IDk4NzFjMGM5Mzc0Yy4uZmI5YmZjNTJhNmQ3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3Qv
bnZtZS5oDQo+IEBAIC00NzcsNyArNDc3LDYgQEAgc3RydWN0IG52bWVfY3RybF9vcHMgew0KPiAg
ICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3M7DQo+ICAgI2RlZmluZSBOVk1FX0ZfRkFCUklDUyAg
ICAgICAgICAgICAgICAgKDEgPDwgMCkNCj4gICAjZGVmaW5lIE5WTUVfRl9NRVRBREFUQV9TVVBQ
T1JURUQgICAgICAoMSA8PCAxKQ0KPiAtI2RlZmluZSBOVk1FX0ZfUENJX1AyUERNQSAgICAgICAg
ICAgICAgKDEgPDwgMikNCj4gICAgICAgICAgaW50ICgqcmVnX3JlYWQzMikoc3RydWN0IG52bWVf
Y3RybCAqY3RybCwgdTMyIG9mZiwgdTMyICp2YWwpOw0KPiAgICAgICAgICBpbnQgKCpyZWdfd3Jp
dGUzMikoc3RydWN0IG52bWVfY3RybCAqY3RybCwgdTMyIG9mZiwgdTMyIHZhbCk7DQo+ICAgICAg
ICAgIGludCAoKnJlZ19yZWFkNjQpKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHUzMiBvZmYsIHU2
NCAqdmFsKTsNCj4gQEAgLTQ4NSw2ICs0ODQsNyBAQCBzdHJ1Y3QgbnZtZV9jdHJsX29wcyB7DQo+
ICAgICAgICAgIHZvaWQgKCpzdWJtaXRfYXN5bmNfZXZlbnQpKHN0cnVjdCBudm1lX2N0cmwgKmN0
cmwpOw0KPiAgICAgICAgICB2b2lkICgqZGVsZXRlX2N0cmwpKHN0cnVjdCBudm1lX2N0cmwgKmN0
cmwpOw0KPiAgICAgICAgICBpbnQgKCpnZXRfYWRkcmVzcykoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwgY2hhciAqYnVmLCBpbnQgc2l6ZSk7DQo+ICsgICAgICAgYm9vbCAoKnN1cHBvcnRzX3BjaV9w
MnBkbWEpKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpOw0KPiAgIH07DQo+IA0KDQpJcyB0aGlzIG5l
dyBvcHMgb25seSBuZWVkZWQgZm9yIHRoZSBQQ0llIHRyYW5zcG9ydCA/IG9yIGRvIHlvdSBoYXZl
IA0KZm9sbG93aW5nIHBhdGNoZXMgdG8gdXNlIHRoaXMgb3AgZm9yIHRoZSBvdGhlciB0cmFuc3Bv
cnRzID8NCg0KSWYgaXQgaXMgb25seSBuZWVkZWQgZm9yIHRoZSBQQ0llIHRoZW4gd2UgbmVlZCB0
byBmaW5kIGEgd2F5IHRvDQpub3QgYWRkIHRoaXMgc29tZWhvdy4uLg0KDQo=
