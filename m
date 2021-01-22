Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E822FFC63
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 06:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbhAVF7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 00:59:04 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54626 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbhAVF7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 00:59:03 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10M5abBp027086;
        Thu, 21 Jan 2021 21:57:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=n9evRdPfWF0nxGKWX3+hNAEKZ0NKWPLBcsO7phpGxkc=;
 b=CwyF4jy9FdVHQ2m7SHlsaqwUqQfo3vpQMD/FphKcFyOxvKnbyjhnTr9GIsetzpV/0SAf
 0S7buC9nHDpadZtC2z05ImKHsDjDp1YTZgCeKglIWEC9IcxXhUp1phlNKm7MlVBFQ8Or
 L4T57xnrIla1cl35etgjDu+iA95WS2n2Fxcs/bU2kgzmaDtD/4yJAlwthRNhJx5wQX6t
 Y0+Bc4uwi4YSXMN3v9VMISAXqrlc0ujnotOTvat5SUeooBbirS6tTl1DvMjNZj2v71MQ
 jqzAn90zhmaC+j0v4SadXbpiKCCLexkfXzXj3nzbHS+0SYbX+WH6TP4NbgIiBiQ3J4zq YQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3668pwh88j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 21:57:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC+AnN2claaPSzdfw+sBiW7+qYKTLTqDjmuiKGY0GxMfxszbgQ6RGKoeU7k1Emv4JTNEgbgY9SRl5XvIapP6SZ0d5sVytiRJNOHrZl8GazdM54sem/Oi1+S+JMK3LNKcRcXVhndRGhJaz8AizCZr5NOFdD/fCoydM0bGP4QGp/E2NxqXty/7Dc6MMx05l4bqFxkBjh2UcDDgfw0qpRT00FGIqdXbXVXWdzCMMHDNk1F8FsjLknAdAxy2OlagWNnoLMwIHMHHNsNsKcMeLLzxnizsp0XFTGLzwP2N2Zq96lw/VoxoJJaP0Xg1BOe36ux7zkzL95XQns40O59/U6siTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9evRdPfWF0nxGKWX3+hNAEKZ0NKWPLBcsO7phpGxkc=;
 b=O3t/5ie4g+K94PDHGaKPsl3AfDN6kc9uDwrzI2GQDPbN2J0iLkGhP+iau/CGC+fWA0CTLgZHXgqFW8IPAF4pXuQjJRSiBF8un9N7hXiHC7NGe9bGX37nBe8MDA6G7LO1kx77LC0kISWK6lsiZzURe76V+Z8TbfhOdRx2entPTftl5xhfzTjifH/8hCYFWThdyyhrPp4nlucWlR0NbpiSVa7mC+UXihTvaRWQ6AB6J20l0v7MfV2ED8fJDkWKAPMmyJQGx0fLvNw0sUzR0bu3mkAp8CdTaQQ4B8CnbPJ6PdcXmIrDPuiyjWFXB4v37TOdj7Nw3bIUmg0MOqOnkPJOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9evRdPfWF0nxGKWX3+hNAEKZ0NKWPLBcsO7phpGxkc=;
 b=ZOsbwsINIuXyVEUX1gv9gdNQb6OM1dPAg/tUE5G7jU+ITTzct5NXcIdkKV1fo8oGm9ODpv4TlhPTVEbChCVB8jUc8Xr0qho0tmd5nj7Fx8K30A8pKbhDMoHnAKiSLj/gfN6cDUHxSeNZAKJHEgK6H0zmctmvKRmM7ur5dDKUmwc=
Received: from CO2PR07MB2503.namprd07.prod.outlook.com (2603:10b6:100:1::19)
 by MWHPR07MB2800.namprd07.prod.outlook.com (2603:10b6:300:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Fri, 22 Jan
 2021 05:57:37 +0000
Received: from CO2PR07MB2503.namprd07.prod.outlook.com
 ([fe80::d8d9:e81c:18a:33e5]) by CO2PR07MB2503.namprd07.prod.outlook.com
 ([fe80::d8d9:e81c:18a:33e5%11]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 05:57:36 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Thread-Topic: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
Thread-Index: AQHW3qQOEOO3xLnov0GUSEHX9bvYeqojqDeAgA+hOzA=
Date:   Fri, 22 Jan 2021 05:57:36 +0000
Message-ID: <CO2PR07MB2503DA1FDDAD6970803C9F71D8A09@CO2PR07MB2503.namprd07.prod.outlook.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
 <15abdca0-d1e1-64b7-4a9a-d7549f035e01@ti.com>
In-Reply-To: <15abdca0-d1e1-64b7-4a9a-d7549f035e01@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjg0YTM4NjgtNWM3Ni0xMWViLWFlOTQtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XGI4NGEzODZhLTVjNzYtMTFlYi1hZTk0LWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iMjcwNSIgdD0iMTMyNTU3Njg2NTQyODkzNTI0IiBoPSJ6eXJpZVZqdkJlUlU2UzcyWS9ELzFGSjV2QmM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5976bc-36f8-41cc-5284-08d8be9a9eb3
x-ms-traffictypediagnostic: MWHPR07MB2800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR07MB2800B5D53986B31D1C8EE015D8A00@MWHPR07MB2800.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSUqKHLzTHCmsgMe723jgHA8SDd9GHQJYpYW9WY8lrrfrLHH2RSGd3lmlh3SUVCRHZKqUmV/GI1tFpw8Zs5/nt39jEZpoiVuC1YG1SimXRU4Fwy+VbZndbwPYbN5LJmvH27awmcNqkGyqaSjVgXZTvbdrvrGJ0C5EH4Yr7NZZ9arf68qWX20vfEpwP1XRtcCaweC3hjYPcAp+6dmebpdc3wm5mpqXQLKTd9DAaVT7XkDlMYXn+or0m7zP1neDw3cWYhg8c83BinHDsAM1hXgnVoegqPo79DxWjZg6OMd0WCwJ/r432r+N0Oaw0eS3hqOBeQRWgremRWu9g2tWr/bB1ckfGqANj4Zl/iCzQIXrZlrJBVSBQ29pRzFI98XOisX5YP+J3Fecv5x5jyxZIx3TFPZZDTW9LCIeT/u3LxPaR53obMH/gqVa6sSY8bJdenE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR07MB2503.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(36092001)(107886003)(83380400001)(8936002)(478600001)(54906003)(8676002)(5660300002)(66476007)(316002)(186003)(26005)(66446008)(53546011)(2906002)(64756008)(52536014)(6506007)(7696005)(9686003)(76116006)(66556008)(55016002)(33656002)(66946007)(86362001)(71200400001)(4326008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c1N5bkpIVHRSMHBsVXdXallNNDNSNUI2amwrTjhqS2s4YVEra2Q5Tm40bjBX?=
 =?utf-8?B?TGFUYWYxRkljQU1mNVNna1cwNFBlZUJkbWFTdGwwMDMwS05GTlJLKzVleUlV?=
 =?utf-8?B?V2M4QmpyUWpZTnUvUnhqMEN5bGViQWNFOTl5ZytnK1lTdS8vaFJHcGpVc3lq?=
 =?utf-8?B?dXE4UkgxTjhCNlBFOW5NSkJxUFQvTnZ2Y1V0VnF1RG5LcHNDdXRZdnRHMkkv?=
 =?utf-8?B?RjVCOGVvOWQvYmxxOThRY2tubHFBT3ZDcGJvc29ZaWpZaFlLVytQV001OW5F?=
 =?utf-8?B?MlJOM1Q1Y3RqaWtuL1BxSTlWenBMZGgzMVVkeXVXcGlzZnJMU1pWbFVLSnBw?=
 =?utf-8?B?Mm41dDR1SktLbFpCaFVoMWZYTk1EWnh0eDF6U3ArRmJxcURUL05kdnFObk5l?=
 =?utf-8?B?eGpTLzJxaU9yTENCL0Faa0xWMCtLSVpXbHg1UHhPWHREbEd3SGNTblp1RGtV?=
 =?utf-8?B?aGRSU05qOGlxdFlwUE1yTkhNbVRiUThsbnRXeG9xTHpBTGdiQVZVY05YUEFP?=
 =?utf-8?B?K1R2Z2VVU1o3L2tBUUhwVTBzRklmZytzZE91czNoMmRXTlZxSWc5N3Zpak94?=
 =?utf-8?B?NjJRWms2d2huWGFCdkNUa0psZHFxU2JkMWlONy9xdHYwdHdNNndNMlpRWngy?=
 =?utf-8?B?bEdBYmtWVk90L2RwSmJxdWNFem51N1UrRUJPaVFnVlo4STdITXd2SWRZaWhs?=
 =?utf-8?B?Ty82eGVFZ0dVNUhOdXhkODdGQzRJTmk0VFREb0pHK1pRT3pIMnZkYUFTL0dj?=
 =?utf-8?B?MDVsMExDZjFteHh6OWErM2RVTnI1OXdkZE1taXFWeHAwcXNzdDNwblpUejg0?=
 =?utf-8?B?QXZKdkFKMDlEVytjMkZNNktseU5GRzBDNTlXN21BQWZHVzIxQTZJSWRsc2k0?=
 =?utf-8?B?aVoycDJpUm1qWTdZbndPY0xWY21VNmJDTm8wYUVqT0lBMTl5bWdiV2w0WWZT?=
 =?utf-8?B?WWFNN0QxYytPREorTVdnSGxidk03cnkrRlBaSExuc3d3NGtBbjhxd2FRVDFq?=
 =?utf-8?B?cHp6eGpJMy9JMWNEL0FNcUVMemZQUmsrZVdPZ25hK1J3VURRN21LRG5JaWlT?=
 =?utf-8?B?VHl3Sit4aGU0MGFyTmxMTVcrN2hQbElVQ1lqQ2hZYy9DYlhaL0VMeUFxODIy?=
 =?utf-8?B?WDdYcHN3b3ZPVUQ1UW02ejJKL05YZlp1MWoxdHZ6YkMvVnJVNWhrL0pHUEJp?=
 =?utf-8?B?RUhSRE8wVjVEcjVTUTIwRjkxUEpicGMxSUdubmRwS0R3S1VHRFF0d1p1WjZR?=
 =?utf-8?B?SVdMdEVJTUxuZUJkM21iekMxUURsT2dtRWFEcGFXVHcyNVJsQWkyMVpJTFN1?=
 =?utf-8?Q?9cQe2R+k69nDk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO2PR07MB2503.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5976bc-36f8-41cc-5284-08d8be9a9eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 05:57:36.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MV6poJKEQif0ZWbCXVY5J9nPUL5lMRHUG62wH4i0HA6tp+ZOzLzYpbRoc4F/4YN3T8+bFFqrYubxl4ZOLGyV4iIdpVABXh6BS4i4TSdlEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_02:2021-01-21,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220030
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iIC8gVGhvbWFzLA0KDQpSZXF1ZXN0aW5nIHRvIHByb3ZpZGUgeW91ciByZXZpZXdzLg0K
DQpUaGFua3MgJiBSZWdhcmRzLA0KTmFkZWVtIEF0aGFuaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+
DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTIsIDIwMjEgMTI6NDYgUE0NCj4gVG86IEF0aGFu
aSBOYWRlZW0gTGFka2hhbiA8bmFkZWVtQGNhZGVuY2UuY29tPjsgVG9tIEpvc2VwaA0KPiA8dGpv
c2VwaEBjYWRlbmNlLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVs
Lm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNaWxp
bmQgUGFyYWIgPG1wYXJhYkBjYWRlbmNlLmNvbT47IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUN
Cj4gPHNqYWtoYWRlQGNhZGVuY2UuY29tPjsgUGFyc2h1cmFtIFJhanUgVGhvbWJhcmUNCj4gPHB0
aG9tYmFyQGNhZGVuY2UuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDAvMl0gUENJOiBj
YWRlbmNlOiBSZXRyYWluIExpbmsgdG8gd29yayBhcm91bmQgR2VuMg0KPiANCj4gRVhURVJOQUwg
TUFJTA0KPiANCj4gDQo+IA0KPiANCj4gT24gMzAvMTIvMjAgNTozNSBwbSwgTmFkZWVtIEF0aGFu
aSB3cm90ZToNCj4gPiBDYWRlbmNlIGNvbnRyb2xsZXIgd2lsbCBub3QgaW5pdGlhdGUgYXV0b25v
bW91cyBzcGVlZCBjaGFuZ2UgaWYNCj4gPiBzdHJhcHBlZCBhcyBHZW4yLiBUaGUgUmV0cmFpbiBM
aW5rIGJpdCBpcyBzZXQgYXMgcXVpcmsgdG8gZW5hYmxlIHRoaXMgc3BlZWQNCj4gY2hhbmdlLg0K
PiA+IEFkZGluZyBhIHF1aXJrIGZsYWcgZm9yIGRlZmVjdGl2ZSBJUC4gSW4gZnV0dXJlIElQIHJl
dmlzaW9ucyB0aGlzIHdpbGwNCj4gPiBub3QgYmUgYXBwbGljYWJsZS4NCj4gPg0KPiA+IFZlcnNp
b24gaGlzdG9yeToNCj4gPiBDaGFuZ2VzIGluIHY3Og0KPiA+IC0gQ2hhbmdpbmcgdGhlIGNvbW1p
dCB0aXRsZSBvZiBwYXRjaCAxIGluIHRoaXMgc2VyaWVzLg0KPiA+IC0gQWRkZWQgYSByZXR1cm4g
dmFsdWUgZm9yIGZ1bmN0aW9uIGNkbnNfcGNpZV9yZXRyYWluKCkuDQo+ID4gQ2hhbmdlcyBpbiB2
NjoNCj4gPiAtIE1vdmUgdGhlIHBvc2l0aW9uIG9mIGZ1bmN0aW9uIGNkbnNfcGNpZV9ob3N0X3dh
aXRfZm9yX2xpbmsgdG8gcmVtb3ZlDQo+ID4gICBjb21waWxhdGlvbiBlcnJvci4gTm8gY2hhbmdl
cyBpbiBjb2RlLiBTZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcy4NCj4gPiBDaGFuZ2VzIGluIHY1Og0K
PiA+IC0gUmVtb3ZlIHRoZSBjb21wYXRpYmxlIHN0cmluZyBiYXNlZCBzZXR0aW5nIG9mIHF1aXJr
IGZsYWcuDQo+ID4gLSBSZW1vdmVkIGFkZGl0aW9uYWwgTGluayBVcCBDaGVjaw0KPiA+IC0gUmVt
b3ZlZCBxdWlyayBmcm9tIHBjaWUtY2FkZW5jZS1wbGF0LmMgYW5kIGFkZGVkIGluIHBjaS1qNzIx
ZS5jDQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAtIEFkZGVkIGEgcXVpcmsgZmxhZyBiYXNlZCBv
biBhIG5ldyBjb21wYXRpYmxlIHN0cmluZy4NCj4gPiAtIENoYW5nZSBvZiBhcGkgZm9yIGxpbmsg
dXA6IGNkbnNfcGNpZV9ob3N0X3dhaXRfZm9yX2xpbmsoKS4NCj4gPiBDaGFuZ2VzIGluIHYzOg0K
PiA+IC0gVG8gc2V0IHJldHJhaW4gbGluayBiaXQsY2hlY2tpbmcgZGV2aWNlIGNhcGFiaWxpdHkg
JiBsaW5rIHN0YXR1cy4NCj4gPiAtIDMyYml0IHJlYWQgaW4gcGxhY2Ugb2YgOGJpdC4NCj4gPiAt
IE1pbm9yIGNvcnJlY3Rpb24gaW4gcGF0Y2ggY29tbWVudC4NCj4gPiAtIENoYW5nZSBpbiB2YXJp
YWJsZSAmIG1hY3JvIG5hbWUuDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIDE2Yml0IHJlYWQg
aW4gcGxhY2Ugb2YgOGJpdC4NCj4gDQo+IENvdWxkIGdldCBHRU4yIGNhcmQgZW51bWVyYXRlZCBp
biBHRU4yIG1vZGUgaW4gSjdFUyBFVk0uDQo+IA0KPiBUZXN0ZWQtYnk6IEtpc2hvbiBWaWpheSBB
YnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IA0KPiBUaGFua3MNCj4gS2lzaG9uDQo+ID4NCj4g
PiBOYWRlZW0gQXRoYW5pICgyKToNCj4gPiAgIFBDSTogY2FkZW5jZTogU2hpZnRpbmcgb2YgYSBm
dW5jdGlvbiB0byBzdXBwb3J0IG5ldyBjb2RlLg0KPiA+ICAgUENJOiBjYWRlbmNlOiBSZXRyYWlu
IExpbmsgdG8gd29yayBhcm91bmQgR2VuMiB0cmFpbmluZyBkZWZlY3QuDQo+ID4NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIxZS5jICAgICAgICAgfCAgMyArDQo+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jIHwg
NzANCj4gKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2NhZGVuY2UvcGNpZS1jYWRlbmNlLmggICAgICB8IDExICsrKy0NCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCA2NSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gPg0K
