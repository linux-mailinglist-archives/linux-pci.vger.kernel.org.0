Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B3D05B6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 04:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfJICv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 22:51:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50482 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbfJICv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 22:51:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x992pJNF028143;
        Tue, 8 Oct 2019 19:51:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=rJqWGT1UE7+ULl/vaiLDGWiMv5YaoKbyxjTxvNFxAOU=;
 b=ofXGLBO2nBmtfDarV1CZnQzplHmSbqMex0YtxKJzx/qEHFYt/fArgd99x7COyByI3iO/
 fIrupnGpyQKolQ/deCHnHYqHuj1s7GaVAXKfHCgRajukVJ3uKPr510rG2jBAqlB59x9Q
 PVTsXhNRYM3gJ8Nrs54dKBlDejycVcN+DT5uwHnkOLFi2w8ISb9Gbfs5KDxTh+DWdzfQ
 BlCMxLSwmK1balzl1yfDuhR4cL5TcBCJD85UWdwTbCihyHyYTYD66dcFDXjJ/mKWMjMW
 0MzpheW9wflyI7m1Z26kpUQHCuSLLpq+mL6nB0dtQuuU0db7eCGsceD1l86yXv6babXB WA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vetpn5473-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 19:51:18 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 8 Oct
 2019 19:51:17 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 8 Oct 2019 19:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMRTkXKfnyTjpYkhzX4RbPCCwwEIkpdL8PNrb4D5rRa7slrXiTc5v9FKmhXLoT6684iJm2MFWoeXn9vQMBBmjt3uVTwbW7uXKsVH6DJJenQ+OwZqkaNSnWAF5cuyYGkzlcMKLl3Dmnynnku4ppdwSUeQHA9FztKiWarPC7VgMOb6EXMEI6znztK7URJDpJ0w4WKJIiPOaH2OIQ8I4SYHtQyKpyL3mZQZQ1aLL6DdvdKtclY+/GRALBzF7AVQI45L4Id85XDN3VCAULUlj2RLlnfy0DzoStCUBL7IP0oDtPIZsv3yrexjdbO+ZD0zHdBJvgFyqdqk8+JryWY8mn/5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJqWGT1UE7+ULl/vaiLDGWiMv5YaoKbyxjTxvNFxAOU=;
 b=ZobkBUX+ckq8pnkkS8Pn6iZ8fo9e+nkZYVpJx7CPW4Th06UsncQsIG3TYSsxhC2AR40XaizDdOz7u6kRNvbO9nH5+n4/5nk1k2hIXpbZajBZOOJXPzrxWYuecr7RoqCDLWsb03NJcrZEIh+u7bc4jsF1Wwz5puuldt/+b8DPbE0Mxsh/oXx2flm6lNUwg+JiOKCuo+uFJrOmazp3EOAPSuECpyZIdx1uLWVC1TOky6Fb+o3xr400FRuKNCNAjoa76HO8Ny5CJn+QXd+QS3dRPLnnwfeIRFT3BIHz2k/qGWsOaGVpJP8CYH5zvquIBxrpYkDrXqJRy3C2zNQ4E5Mw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJqWGT1UE7+ULl/vaiLDGWiMv5YaoKbyxjTxvNFxAOU=;
 b=hveykKmMnpCfupQXsMY8cWHGxk/d/fHoww9sJ+7kYZ8SDC6DSyQS7ry6y63iAU5fxdgA0SM1u6XT4vXp9dl7mIIkxMvf2/lkgfkQUZtOYwhJL64ae4EsTJnxJ/X/oGEunlAmDB+K8i2PFx0Xja1wO9Eeoeu6Knq4I/eLZUAP+ng=
Received: from DM6PR18MB2940.namprd18.prod.outlook.com (20.179.52.160) by
 DM6PR18MB3339.namprd18.prod.outlook.com (10.255.174.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 02:51:15 +0000
Received: from DM6PR18MB2940.namprd18.prod.outlook.com
 ([fe80::1194:17a3:56fe:40bc]) by DM6PR18MB2940.namprd18.prod.outlook.com
 ([fe80::1194:17a3:56fe:40bc%7]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 02:51:15 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Robert Richter <rrichter@marvell.com>
CC:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: Re: [EXT] Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Topic: [EXT] Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Index: AQHVfbHuntU6lDeHqUOVhDMEV1IoaadRRHuAgABY8gA=
Date:   Wed, 9 Oct 2019 02:51:15 +0000
Message-ID: <de9d84e3-bbfe-e81a-1110-e3ef42a06018@marvell.com>
References: <20191008213251.GA229610@google.com>
In-Reply-To: <20191008213251.GA229610@google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To DM6PR18MB2940.namprd18.prod.outlook.com
 (2603:10b6:5:172::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea5d492-5004-4bc4-33fa-08d74c638d63
x-ms-traffictypediagnostic: DM6PR18MB3339:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB333946C90FF3D2335F85AF55C5950@DM6PR18MB3339.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:275;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(366004)(376002)(396003)(136003)(199004)(189003)(7736002)(71190400001)(99286004)(256004)(478600001)(71200400001)(316002)(81156014)(8676002)(110136005)(54906003)(81166006)(966005)(2906002)(31686004)(25786009)(31696002)(86362001)(8936002)(6636002)(305945005)(3846002)(6116002)(14454004)(66066001)(76176011)(5660300002)(6512007)(486006)(6436002)(6306002)(26005)(11346002)(6506007)(476003)(446003)(2616005)(386003)(66446008)(36756003)(66946007)(64756008)(66556008)(66476007)(229853002)(107886003)(186003)(52116002)(4326008)(6486002)(53546011)(6246003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB3339;H:DM6PR18MB2940.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSup4lFWUzZW7PbY2+WHoihBHxuHb1MzXvCv5QGF2I+A0fpLunAx+SuJNVHezhsHhXbVzHUtLlOWcq92izrsJGWGOX5drowjVgfpvfJqyUW4a5UXAU5nXqasigZaguF1Fr0XRgByBv0vj6tHIhloGVB8YAUw9E2pE4/eMI7GWwgM3L3y0GWdx2cDlY5kq8Ss8jV9Hvr3B/VGS8nqzJhDrMXVwabadS7+eCw9TyvC1YtdDI9VDP1NQpvPiyU4nGbbteB7cVV6eD38mCmhoyLz7TevFG8ztKJPYu3I7yZagbatbNoDA+Orgt8n0dcpjYFx8k2J9wMaqZB8N1+Bz95/eoAG6c1xtCDQjNXgKdEEwcUie6Lci8v57YUV9++w42E7tX5FFa+jKwDAHmikcjL5kY5gdoNQh0TJERK1NfcnaxrDBNfw4FOoiB3joTRafQHQnLUhEKU9CPgCJQT2Kgw6Pw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <29AF5E0AE6E01242832DD2043B79AC16@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dea5d492-5004-4bc4-33fa-08d74c638d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 02:51:15.6924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEXXRwEM8ncUGgmZVrx/98e1vCtx3bX1Qp7dVswk2uRVceKTxPsGtb04xfDDpP8mQMsY4qeJuCem8MtpScRltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3339
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_01:2019-10-08,2019-10-09 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSBJIHdhcyBvZmYgZm9yIGNvdXBs
ZSBvZiBkYXlzLg0KDQpPbiAxMC84LzE5IDI6MzIgUE0sIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+
IEV4dGVybmFsIEVtYWlsDQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gT24gVHVlLCBPY3QgMDgsIDIw
MTkgYXQgMDg6MjU6MjNBTSArMDAwMCwgUm9iZXJ0IFJpY2h0ZXIgd3JvdGU6DQo+PiBPbiAwNC4x
MC4xOSAxNDo0ODoxMywgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4+PiBjb21taXQgMzdiMjJmYmZl
YzJkDQo+Pj4gQXV0aG9yOiBHZW9yZ2UgQ2hlcmlhbiA8Z2VvcmdlLmNoZXJpYW5AbWFydmVsbC5j
b20+DQo+Pj4gRGF0ZTogICBUaHUgU2VwIDE5IDAyOjQzOjM0IDIwMTkgKzAwMDANCj4+Pg0KPj4+
ICAgICAgUENJOiBBcHBseSBDYXZpdW0gQUNTIHF1aXJrIHRvIENOOTl4eCBhbmQgQ04xMXh4eCBS
b290IFBvcnRzDQo+Pj4gICAgICANCj4+PiAgICAgIEFkZCBhbiBhcnJheSBvZiBDYXZpdW0gUm9v
dCBQb3J0IGRldmljZSBJRHMgYW5kIGFwcGx5IHRoZSBxdWlyayBvbmx5IHRvIHRoZQ0KPj4+ICAg
ICAgbGlzdGVkIGRldmljZXMuDQo+Pj4gICAgICANCj4+PiAgICAgIEluc3RlYWQgb2YgYXBwbHlp
bmcgdGhlIHF1aXJrIHRvIGFsbCBSb290IFBvcnRzIHdoZXJlDQo+Pj4gICAgICAiKGRldi0+ZGV2
aWNlICYgMHhmODAwKSA9PSAweGEwMDAiLCBhcHBseSBpdCBvbmx5IHRvIENOODh4eCAweGExODAg
YW5kDQo+Pj4gICAgICAweGExNzAgUm9vdCBQb3J0cy4NCg0KQWxsIHRoZSByb290IHBvcnRzIG9m
IENOODh4eCBzZXJpZXMgd2lsbCBoYXZlIGRldmljZSBpZCdzIDB4YTE4MCBhbmQgMHhhMTcwLg0K
DQpUaGlzIHBhdGNoIGN1cnJlbnRseSB0YXJnZXRzIG9ubHkgQ044OHh4IHNlcmllcyBhbmQgbm90
IGFsbCBvZiB0aGUgQ044eHh4Lg0KDQpGb3IgZWc6LSA4M3h4IGRldmljZXMgZG9uJ3Qgd29udCB0
aGUgcXVpcmsgdG8gYmUgYXBwbGllZCBhcyBvZiB0b2RheS4gDQpUaGUgcXVpcmsNCg0KbmVlZHMg
dG8gYmUgYXBwbGllZCBvbmx5IGZvciBUWDEgc2VyaWVzIGFuZCBub3Qgb25jdGVvbi10eDEgc2Vy
aWVzLg0KDQo+PiBObywgdGhpcyBjYW4ndCBiZSByZW1vdmVkLiBJdCBpcyBhIG1hdGNoIGFsbCBm
b3IgYWxsIENOOHh4eCB2YXJpYW50cw0KPj4gKG5vdGUgdGhlIDMgJ3gnLCBhbGwgVFgxIGNvcmVz
KS4gU28gYWxsIGRldmljZSBpZHMgZnJvbSAweGEwMDAgdG8NCj4+IDB4YTdGRiBhcmUgYWZmZWN0
ZWQgaGVyZSBhbmQgbmVlZCB0aGUgcXVpcmsuDQo+IE9LLCBJJ2xsIGRyb3AgdGhlIHBhdGNoIGFu
ZCB3YWl0IGZvciBhIG5ldyBvbmUuICBNYXliZSB3aGF0IHdhcyBuZWVkZWQNCj4gd2FzIHRvIGtl
ZXAgdGhlICIoZGV2LT5kZXZpY2UgJiAweGY4MDApID09IDB4YTAwMCIgcGFydCBhbmQgYWRkIHRo
ZQ0KPiBwY2lfcXVpcmtfY2F2aXVtX2Fjc19pZHNbXSBhcnJheSBpbiBhZGRpdGlvbj8NCj4NCj4+
PiAgICAgIEFsc28gYXBwbHkgdGhlIHF1aXJrIHRvIENOOTl4eCAoMHhhZjg0KSBhbmQgQ04xMXh4
eCAoMHhiODg0KSBSb290IFBvcnRzLg0KDQpUaGUgZGV2aWNlIGlkJ3MgZm9yIGFsbCB2YXJpYW50
cyBvZiBDTjk5eHggaXMgMHhhZjg0IGFuZCBDTjExeHh4IHdpbGwgYmUgDQoweGI4ODQuDQoNClNv
IHRoaXMgcGF0Y2ggaG9sZHMgZ29vZCBmb3IgVFgyIGFzIHdlbGwgYXMgVFgzIHNlcmllcyBvZiBw
cm9jZXNzb3JzLg0KDQoNCj4+IEkgdGhvdWdodCB0aGUgcXVpcmsgaXMgQ044eHh4IHNwZWNpZmlj
LCBidXQgSSBjb3VsZCBiZSB3cm9uZyBoZXJlLg0KPj4NCj4+IC1Sb2JlcnQNCj4+DQo+Pj4gICAg
ICANCj4+PiAgICAgIExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91
cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX3JfMjAxOTA5MTkwMjQzMTkuR0E4NzkyLTQw
ZGM1LTJEZW9kbG54MDUubWFydmVsbC5jb20mZD1Ed0lCQWcmYz1uS2pXZWMyYjZSMG1PeVBhejd4
dGZRJnI9OHZLT3BDMjZOWkd6UVBBTWlJbGlteHlFR0NSU0ppcS1qOHl5alBKNlZaNCZtPVZtbWwt
cngzdDYzWmJiWFowWGFFU0FNOXlBbGV4RTI5Ui1naVRiY2o0UWsmcz01N2pLSWo4QkF5ZGJMcGZ0
THQ1U3N2YTd2RDZHdW9DYUlwalRpLXNCNWtVJmU9DQo+Pj4gICAgICBGaXhlczogZjJkZGFmOGRm
ZDRhICgiUENJOiBBcHBseSBDYXZpdW0gVGh1bmRlclggQUNTIHF1aXJrIHRvIG1vcmUgUm9vdCBQ
b3J0cyIpDQo+Pj4gICAgICBGaXhlczogYjQwNGJjZmJmMDM1ICgiUENJOiBBZGQgQUNTIHF1aXJr
IGZvciBhbGwgQ2F2aXVtIGRldmljZXMiKQ0KPj4+ICAgICAgU2lnbmVkLW9mZi1ieTogR2Vvcmdl
IENoZXJpYW4gPGdlb3JnZS5jaGVyaWFuQG1hcnZlbGwuY29tPg0KPj4+ICAgICAgU2lnbmVkLW9m
Zi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4+PiAgICAgIENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnICAgICAgIyB2NC4xMisNCj4+Pg0KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+Pj4gaW5kZXgg
MzIwMjU1ZTVlOGY4Li40ZTUwNDhjYjVlYzYgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9wY2kv
cXVpcmtzLmMNCj4+PiArKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPj4+IEBAIC00MzExLDE3
ICs0MzExLDI0IEBAIHN0YXRpYyBpbnQgcGNpX3F1aXJrX2FtZF9zYl9hY3Moc3RydWN0IHBjaV9k
ZXYgKmRldiwgdTE2IGFjc19mbGFncykNCj4+PiAgICNlbmRpZg0KPj4+ICAgfQ0KPj4+ICAgDQo+
Pj4gK3N0YXRpYyBjb25zdCB1MTYgcGNpX3F1aXJrX2Nhdml1bV9hY3NfaWRzW10gPSB7DQo+Pj4g
KwkweGExODAsIDB4YTE3MCwJCS8qIENOODh4eCBmYW1pbHkgb2YgZGV2aWNlcyAqLw0KPj4+ICsJ
MHhhZjg0LAkJCS8qIENOOTl4eCBmYW1pbHkgb2YgZGV2aWNlcyAqLw0KPj4+ICsJMHhiODg0LAkJ
CS8qIENOMTF4eHggZmFtaWx5IG9mIGRldmljZXMgKi8NCj4+PiArfTsNCj4+PiArDQo+Pj4gICBz
dGF0aWMgYm9vbCBwY2lfcXVpcmtfY2F2aXVtX2Fjc19tYXRjaChzdHJ1Y3QgcGNpX2RldiAqZGV2
KQ0KPj4+ICAgew0KPj4+IC0JLyoNCj4+PiAtCSAqIEVmZmVjdGl2ZWx5IHNlbGVjdHMgYWxsIGRv
d25zdHJlYW0gcG9ydHMgZm9yIHdob2xlIFRodW5kZXJYIDENCj4+PiAtCSAqIGZhbWlseSBieSAw
eGY4MDAgbWFzayAod2hpY2ggcmVwcmVzZW50cyA4IFNvQ3MpLCB3aGlsZSB0aGUgbG93ZXINCj4+
PiAtCSAqIGJpdHMgb2YgZGV2aWNlIElEIGFyZSB1c2VkIHRvIGluZGljYXRlIHdoaWNoIHN1YmRl
dmljZSBpcyB1c2VkDQo+Pj4gLQkgKiB3aXRoaW4gdGhlIFNvQy4NCj4+PiAtCSAqLw0KPj4+IC0J
cmV0dXJuIChwY2lfaXNfcGNpZShkZXYpICYmDQo+Pj4gLQkJKHBjaV9wY2llX3R5cGUoZGV2KSA9
PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUKSAmJg0KPj4+IC0JCSgoZGV2LT5kZXZpY2UgJiAweGY4
MDApID09IDB4YTAwMCkpOw0KPj4+ICsJaW50IGk7DQo+Pj4gKw0KPj4+ICsJaWYgKCFwY2lfaXNf
cGNpZShkZXYpIHx8IHBjaV9wY2llX3R5cGUoZGV2KSAhPSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JU
KQ0KPj4+ICsJCXJldHVybiBmYWxzZTsNCj4+PiArDQo+Pj4gKwlmb3IgKGkgPSAwOyBpIDwgQVJS
QVlfU0laRShwY2lfcXVpcmtfY2F2aXVtX2Fjc19pZHMpOyBpKyspDQo+Pj4gKwkJaWYgKHBjaV9x
dWlya19jYXZpdW1fYWNzX2lkc1tpXSA9PSBkZXYtPmRldmljZSkNCj4+PiArCQkJcmV0dXJuIHRy
dWU7DQo+Pj4gKw0KPj4+ICsJcmV0dXJuIGZhbHNlOw0KPj4+ICAgfQ0KPj4+ICAgDQo+Pj4gICBz
dGF0aWMgaW50IHBjaV9xdWlya19jYXZpdW1fYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBh
Y3NfZmxhZ3MpDQo=
