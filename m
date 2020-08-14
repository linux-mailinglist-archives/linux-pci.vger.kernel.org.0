Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8C244B57
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHNOq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 10:46:28 -0400
Received: from mail-co1nam11on2040.outbound.protection.outlook.com ([40.107.220.40]:38657
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbgHNOq1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 10:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzphPAZSTGT0hd9yMjlcD5IumuLP/9o0lNsJR7O5Q49xicHqBshCf7KKZMxiJDP+/weWA8rgbhPG4pfvsaLbQzFjQG0vJfUxNJk2r0q8eWzC8vS5wO9G1ngBu4Zf3xbiPdoNcWwULns+Y+XWOg8ozT65w3uHKMzQCYbkLK/V+I1HFDNA6oU5VClj2indNN2+cGKXwirwzuptk7tAD7JIJQ7e9wapUEWzIcf782kp4P4mrzSm/04deP0QYvVMeH9nw1LYrURORE5AXd7uIcOdfJuG23NgyP2O/FQkt/41T+XBaPV2aQaOY2RSt6f1vWpbY40dJGqnQR55HXoYDT4Oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXGojeYJZEoIBBVs50jzAdQ7H+8q/v/FejNmadnG1kY=;
 b=c3NabTzBV55bBgyLFgmIHqF5jtfTBmqicBYWZ3fVctn9h80uIZfwyNOfvhPx9ubhSk3LoU4bsXB6MJC2zZ0Yo8FCCcsGrJKKgZdS1jTaYoz+38Qkvt80lvMJA60poDXI7f3JhqGVrNeyU3E2kHoxC/EWXNxmu/zXSf5ljbOlmJJyUsEfgdw0/2tSBUnh/tmksWAvaLbsUH/+OncQpu/hh5AQRmNSnnSNWyrTTPgslKn9BCHI/4nUt+ac2+3n8nb9Wq3mnWOq9m8Z5aRQPuzOFGQYag2vVsB9Kmtbg6YVveyyIRvFR3w1dHLWejMsP0a4FP3ehvTOW8MjZLlCAdbc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXGojeYJZEoIBBVs50jzAdQ7H+8q/v/FejNmadnG1kY=;
 b=qKr+6LijlHjSnGpdW841uNqZU29r2z1XXLyAKxKnXiZGEWfghFlqVWofST5dWN6AsKgKJ12kwyzi+aHpJ795zMiJCrHBswzntm3jltzIWunVZvgly9vTEAAlveIKNmzk3ggLrGqV1YbAWV0BYDy5LvM400l/RW7JaDtX4crgg0c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 14:46:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 14:46:21 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Marcos Scriven <marcos@scriven.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Kevin Buettner <kevinb@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Thread-Topic: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Thread-Index: AQHWNG42jRTQBk1do0S3m0V1mtJWrqi8dW2AgACxSICAEeojAIABLcqAgBkNmwCAHHGqAIAAn0qAgAAIpuCAMWHmgIAAYAlw
Date:   Fri, 14 Aug 2020 14:46:21 +0000
Message-ID: <MN2PR12MB4488981CADF682B05DEC6CDEF7400@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <CAAri2DpQnrGH5bnjC==W+HmnD4XMh8gcp9u-_LQ=K-jtrdHwAg@mail.gmail.com>
 <20200713221451.GA285058@bjorn-Precision-5520>
 <MN2PR12MB448830959FDA665230B94FCBF7600@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAAri2Dq2L0MOPeocRE5fF7qzgGbCCi_gYS+CU7mU=EqVe0Y3iw@mail.gmail.com>
In-Reply-To: <CAAri2Dq2L0MOPeocRE5fF7qzgGbCCi_gYS+CU7mU=EqVe0Y3iw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-14T14:45:55Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5828dd35-4ae8-409b-b2cf-0000a931228e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-14T14:45:42Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0ffe2e73-145d-4997-9ff6-00008a3d85a8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-14T14:46:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 57a57007-5254-4529-9144-00006f1204a8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: scriven.org; dkim=none (message not signed)
 header.d=none;scriven.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02bdd30d-6df3-45ec-94a6-08d84060cf67
x-ms-traffictypediagnostic: MN2PR12MB4272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42727CD110D481C1AA56820FF7400@MN2PR12MB4272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNyy+nNVGsftI1LgluJU3OurwAPI+qFELP+tP4IKCS5W19NNIck/Uuqogh7cMtgEVZjbTwKA8AtCSwsjI7qIf+eFXhDJnHF0d3ax2tA1zMOGcuC3mp1sNYsiD1Xludk8iBwNt69jw/MDUxFSKt/LbRfEc88nOHH22kVbjXu8FoRiFqboKwroiEvy7eErUkk48Oqsl7Izisy1rfr/Cu9AXjiilRweyRh1yD/prMb+Pd8bjnzixSkBK9Rg57Z2Gbe1I2PU1k95dNpC1vE35GWpjpujJpOq9pSgWST/+s+4LVsUoclb4yv1Sro+X3mRmM4dtBoWWCXqSVD2+F+TCdp/7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(5660300002)(71200400001)(2906002)(26005)(54906003)(4326008)(66476007)(33656002)(52536014)(53546011)(76116006)(6506007)(478600001)(8936002)(55016002)(66446008)(8676002)(64756008)(9686003)(316002)(7696005)(86362001)(83380400001)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: E9yeCf+RGU4oDVJ8vs4dBY9xUvqtmvMyI1jgqNN+P4cz+tjsDufQDZ7mKEFG4dOe5X3tBe5AMXiBcYUaE3Bj7w1Jep31bwALl/h92rLqHzSxhM4sjvKASwGMxUDgiFTvIer/kna4sjwKSKDQIqMA4Mu7ffGlkAJhDr9ZsfZB0MGbAAL5ijEtmkBcKIvFaxoFJVazfUCFiFaOYhHQmwBg2xxM0mVZ0KXRwK+p+ruipFxbSJDXLYVWpiGKwCrb52T042cAnZdb3rCd6gtzVPjGBXOUdCIFml2ozdK10WILJ38ekdfjIXSIRy0uGwrFaQxFgRuNEED9b/j60+/ULqaZ1WoYTXzIwit08PYxcjhLmrflWOthXrpeCha9gJ1FsgvavxOPicd4iOhuQVOUF8lMeZ5mz234ABeQ7YJD94jIviVOvYkee5xZc7hoolpDZjNAcFVRB8Xn3efV3kQJsQQL5a6ZHesCGT877s+4CJ5o6rV1covC2GdKeHXCuaXbVxCW1cA6yGp+v6CZ4LBbXPUMjQagHkFE5fGN219XbudQQhSz/llvh2yQniqxmbyJ8VGdkG5m9aIWYZMSotTU3YOr/vOCx/OwtukP/yp68g1IQMhGKT7CEd6+lJrm0NjTVY7RbvoLGcR6SxZHOlKx2ot2Qw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bdd30d-6df3-45ec-94a6-08d84060cf67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 14:46:21.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2V6yirggWwMylOji/E4+WRIcUBpCM3o69vpWeLCLqCxRMeTwOwYYM5BTCSz+hztrNzI2vVR5V82K2A2Md69hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBQdWJsaWMgVXNlXQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1hcmNvcyBTY3JpdmVuIDxtYXJjb3NAc2NyaXZlbi5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVn
dXN0IDE0LCAyMDIwIDQ6NTMgQU0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9y
Zz47IFNoYWgsIE5laGFsLWJha3VsY2hhbmRyYSA8TmVoYWwtDQo+IGJha3VsY2hhbmRyYS5TaGFo
QGFtZC5jb20+OyBLZXZpbiBCdWV0dG5lciA8a2V2aW5iQHJlZGhhdC5jb20+Ow0KPiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsg
QWxleA0KPiBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT47IEtvZW5pZywg
Q2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFBDSTogQXZvaWQgRkxSIGZvciBBTUQgU3RhcnNoaXAgVVNCIDMuMA0KPiANCj4gT24g
TW9uLCAxMyBKdWwgMjAyMCBhdCAyMzo0OCwgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtBTUQgUHVibGljIFVzZV0NCj4g
Pg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJqb3JuIEhl
bGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgSnVseSAxMywg
MjAyMCA2OjE1IFBNDQo+ID4gPiBUbzogTWFyY29zIFNjcml2ZW4gPG1hcmNvc0BzY3JpdmVuLm9y
Zz4NCj4gPiA+IENjOiBTaGFoLCBOZWhhbC1iYWt1bGNoYW5kcmEgPE5laGFsLWJha3VsY2hhbmRy
YS5TaGFoQGFtZC5jb20+Ow0KPiA+ID4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgS2V2aW4gQnVldHRuZXINCj4gPiA+IDxrZXZpbmJAcmVkaGF0LmNvbT47
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEJqb3JuIEhlbGdhYXMNCj4gPiA+IDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPjsgQWxleCBXaWxsaWFtc29uDQo+IDxhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbT47DQo+ID4gPiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOiBBdm9pZCBGTFIgZm9yIEFNRCBTdGFy
c2hpcCBVU0IgMy4wDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBKdWwgMTMsIDIwMjAgYXQgMDE6NDQ6
NDRQTSArMDEwMCwgTWFyY29zIFNjcml2ZW4gd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgMjUgSnVu
IDIwMjAgYXQgMTE6MjIsIE1hcmNvcyBTY3JpdmVuIDxtYXJjb3NAc2NyaXZlbi5vcmc+DQo+IHdy
b3RlOg0KPiA+ID4gPiA+IE9uIFR1ZSwgOSBKdW4gMjAyMCBhdCAxMjo0NywgU2hhaCwgTmVoYWwt
YmFrdWxjaGFuZHJhDQo+ID4gPiA+ID4gPG5laGFsLWJha3VsY2hhbmRyYS5zaGFoQGFtZC5jb20+
IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gNi84LzIwMjAgMTE6MTcgUE0sIE1hcmNvcyBTY3JpdmVu
IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBUaHUsIDI4IE1heSAyMDIwIGF0IDA5OjEyLCBNYXJj
b3MgU2NyaXZlbg0KPiA+ID4gPiA+ID4gPiA8bWFyY29zQHNjcml2ZW4ub3JnPg0KPiA+ID4gPiA+
IHdyb3RlOg0KPiA+ID4gPiA+ID4gPj4gT24gV2VkLCAyNyBNYXkgMjAyMCBhdCAyMjo0MiwgRGV1
Y2hlciwgQWxleGFuZGVyDQo+ID4gPiA+ID4gPiA+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+ID4gPiA+Pj4+IEZyb206IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4N
Cj4gPiA+ID4gPiA+ID4+Pj4NCj4gPiA+ID4gPiA+ID4+Pj4gWytjYyBBbGV4IEQsIENocmlzdGlh
biAtLSBkbyB5b3UgZ3V5cyBoYXZlIGFueSBjb250YWN0cw0KPiA+ID4gPiA+ID4gPj4+PiBvciBp
bnNpZ2h0DQo+ID4gPiA+ID4gaW50byB3aHkgd2UNCj4gPiA+ID4gPiA+ID4+Pj4gc3VkZGVubHkg
aGF2ZSB0aHJlZSBuZXcgQU1EIGRldmljZXMgdGhhdCBhZHZlcnRpc2UgRkxSDQo+ID4gPiA+ID4g
PiA+Pj4+IHN1cHBvcnQgYnV0DQo+ID4gPiA+ID4gaXQNCj4gPiA+ID4gPiA+ID4+Pj4gZG9lc24n
dCB3b3JrPyAgQXJlIHdlIGRvaW5nIHNvbWV0aGluZyB3cm9uZyBpbiBMaW51eCwgb3INCj4gPiA+
ID4gPiA+ID4+Pj4gYXJlIHRoZXNlDQo+ID4gPiA+ID4gZGV2aWNlcw0KPiA+ID4gPiA+ID4gPj4+
PiBkZWZlY3RpdmU/DQo+ID4gPiA+ID4gPiA+Pj4gK05laGFsIHdobyBoYW5kbGVzIG91ciBVU0Ig
ZHJpdmVycy4NCj4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPj4+IE5laGFsIGFueSBpZGVh
cyBhYm91dCBGTFIgb3Igd2hldGhlciBpdCBzaG91bGQgYmUgYWR2ZXJ0aXNlZD8NCj4gPiA+ID4g
PiA+ID4+Pg0KPiA+ID4gPiA+ID4gU29ycnkgZm9yIHRoZSBkZWxheS4gV2UgYXJlIGxvb2tpbmcg
aW50byB0aGlzIHdpdGggQklPUyB0ZWFtLg0KPiA+ID4gPiA+ID4gSSBzaGFsbA0KPiA+ID4gPiA+
IHJldmVydCBzb29uIG9uIHRoaXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTb3JyeSB0byBrZWVw
IHBlc3RlcmluZyBhYm91dCB0aGlzLCBidXQgd29uZGVyaW5nIGlmIHRoZXJlJ3MgYW55DQo+ID4g
PiA+ID4gbW92ZW1lbnQgb24gdGhpcz8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElzIGl0IHNvbWV0
aGluZyB0aGF0J3MgbGlrZWx5IHRvIGJlIGZpeGVkIGFuZCBhY3R1YWxseSByb2xsZWQNCj4gPiA+
ID4gPiBvdXQgYnkgbW90aGVyYm9hcmQgbWFudWZhY3R1cmVycz8NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRoZXJlJ3MgYmVlbiBzb21lIGdydW1ibGluZ3MgaW4gdGhlIGNvbW11bml0eSBhYm91dCBh
ZGRpbmcNCj4gPiA+ID4gPiB3b3JrYXJvdW5kcyByYXRoZXIgdGhhbiBmaXhpbmcsIHNvIGl0IHdv
dWxkIGJlIGdvb2QgdG8gcGFzcyBvbg0KPiA+ID4gZXhwZWN0YXRpb25zIGhlcmUuDQo+ID4gPiA+
DQo+ID4gPiA+IEFueSB3b3JkIG9uIHRoaXMgcGxlYXNlPyBXb3VsZCBiZSBrZWVuIHRvIGtub3cg
aWYgdGhlIEJJT1MgY2FuIGJlDQo+ID4gPiA+IGZpeGVkLCBhbmQgdGhpcyB3b3JrYXJvdW5kIGNh
biBldmVudHVhbGx5IGJlIGRyb3BwZWQuDQo+ID4gPg0KPiA+ID4gSnVzdCB0byBjbGFyaWZ5IHdo
YXQgdGhlIHBvc3NpYmxlIG91dGNvbWVzIGFyZToNCj4gPiA+DQo+ID4gPiAgIDEpIElmIHRoZXNl
IEFNRCBkZXZpY2VzIGFyZSBkZWZlY3RpdmUsIGJ1dCBmdXR1cmUgb25lcyBhcmUgZml4ZWQsIHdl
DQo+ID4gPiAgIGtlZXAgdGhlIHF1aXJrLg0KPiA+ID4NCj4gPiA+ICAgMikgSWYgdGhlc2UgQU1E
IGRldmljZXMgYXJlIGRlZmVjdGl2ZSAqYW5kKiBmdXR1cmUgb25lcyBhcmUgYWxzbw0KPiA+ID4g
ICBkZWZlY3RpdmUsIHdlIGtlZXAgdGhlIHF1aXJrIGFuZCBrZWVwIGFkZGluZyBkZXZpY2UgSURz
IHRvIGl0Lg0KPiA+ID4NCj4gPiA+ICAgMykgSWYgdGhlIEJJT1MgaXMgZGVmZWN0aXZlLCB3ZSBr
ZWVwIHRoZSBxdWlyay4gIElmIGFueWJvZHkgY2FyZXMNCj4gPiA+ICAgYWJvdXQgRkxSIGVub3Vn
aCwgdGhleSBjYW4gbWFrZSB0aGUgcXVpcmsgc21hcnQgZW5vdWdoIHRvIGlkZW50aWZ5DQo+ID4g
PiAgIGZpeGVkIEJJT1MgdmVyc2lvbnMgYW5kIGVuYWJsZSBGTFIuDQo+ID4gPg0KPiA+ID4gICA0
KSBJZiBMaW51eCBpcyBkZWZlY3RpdmUsIHdlIGNhbiBmaXggTGludXggYW5kIGRyb3AgdGhlIHF1
aXJrLg0KPiA+ID4NCj4gPiA+IFRoZSBpZGVhbCBvdXRjb21lIHdvdWxkIGJlIDQpLCBidXQgd2Ug
ZG9uJ3QgaGF2ZSBhbnkgaW5kaWNhdGlvbiB0aGF0DQo+ID4gPiBMaW51eCBpcyBkb2luZyBzb21l
dGhpbmcgd3JvbmcuDQo+ID4gPg0KPiA+ID4gV2hhdCB3ZSdyZSByZWFsbHkgdHJ5aW5nIHRvIGF2
b2lkIGlzIDIpIGJlY2F1c2UgdGhhdCBtZWFucyBuZXcNCj4gPiA+IGRldmljZXMgd2lsbCBicmVh
ayBMaW51eCB1bnRpbCBzb21lYm9keSBmaWd1cmVzIG91dCB0aGUgcHJvYmxlbQ0KPiA+ID4gYWdh
aW4sIHVwZGF0ZXMgdGhlIHF1aXJrLCBhbmQgZ2V0cyB0aGUgdXBkYXRlIGludG8gZGlzdHJvIGtl
cm5lbHMuDQo+ID4gPg0KPiA+ID4gSW4gY2FzZSAzKSwgd2UgZG9uJ3QgZHJvcCB0aGUgcXVpcmsg
YmVjYXVzZSB0aGF0IGZvcmNlcyBwZW9wbGUgdG8NCj4gPiA+IHVwZ3JhZGUgdGhlaXIgQklPUywg
YW5kIG1vc3QgcGVvcGxlIHdpbGwgbm90LiAgV2UgY2FuJ3QgZHJvcCB0aGUNCj4gPiA+IHF1aXJr
LCByZWludHJvZHVjZSB0aGUgcHJvYmxlbSBvbiBvbGQgQklPU2VzLCBhbmQgaGlkZSBiZWhpbmQg
dGhlDQo+ID4gPiBleGN1c2Ugb2YgInlvdSBuZWVkIHRvIHVwZ3JhZGUgdGhlIEJJT1MuIiAgVGhh
dCB3YXN0ZXMgdGhlIHVzZXIncyB0aW1lDQo+IGFuZCBvdXIgdGltZS4NCj4gPiA+DQo+ID4NCj4g
PiBVbmRlcnN0b29kLiAgSnVzdCB0cnlpbmcgdG8gZmluZCB0aGUgcmlnaHQgcGVvcGxlIGludGVy
bmFsbHkgdG8gdW5kZXJzdGFuZA0KPiB3aGF0IGhhcyBiZWVuIHZhbGlkYXRlZCBhbmQgcHJvZHVj
dGl6ZWQgd2l0aCByZXNwZWN0IHRvIEZMUiBvbiB2YXJpb3VzDQo+IHBlcmlwaGVyYWxzLg0KPiA+
DQo+ID4gQWxleA0KPiA+DQo+IA0KPiBIaSBBbGV4DQo+IA0KPiBTb3JyeSB0byBrZWVwIGJ1Z2dp
bmcgLSB3b25kZXJpbmcgaWYgeW91J2QgaGFkIGFueSBzdWNjZXNzIGZpbmRpbmcgdGhlDQo+IHBl
b3BsZSBpbnRlcm5hbGx5IHRvIGxvb2sgYXQgdGhpcz8NCg0KU29ycnksIEkgaGF2ZSBub3QuDQoN
Cj4gDQo+IE15IG1haW4gcGVyc29uYWwgY29uY2VybiBpcyB0aGF0IEkgZmFjZWQgc29tZSBjcml0
aWNpc20gZnJvbSB1c2VycyBpbg0KPiBzdWJtaXR0aW5nIHRoZSBxdWlyaywgYXMgcGVvcGxlIGZl
bHQgdGhhdCB0b29rIHRoZSBwcmVzc3VyZSBvZmYgQU1EIHRvIGZpeC4NCg0KVGhlcmUgaXMgaGFy
ZHdhcmUgb3V0IHRoZXJlIHRoYXQgYXBwYXJlbnRseSBuZWVkcyB0aGUgcXVpcmsgc28gZXZlbiBp
ZiBpdCB3ZXJlIGEgYmlvcyBpc3N1ZSBvciBzb21ldGhpbmcgbGlrZSB0aGF0LCB0aGF0IGRvZXNu
J3QgaGVscCB0aGUgaGFyZHdhcmUgdGhhdCBpcyBhbHJlYWR5IG91dCBpbiB0aGUgd2lsZC4gIElm
IHRoZXJlIGlzIHVsdGltYXRlbHkgc29tZSBwcm9ncmFtbWluZyBmaXgsIHdlIGNhbiBhbHdheXMg
cmV2ZXJ0IHRoZSBwYXRjaCBvbmNlIHRoYXQgaXMgYXZhaWxhYmxlLiAgSWYgRkxSIGlzIGFjdHVh
bGx5IGJyb2tlbiwgdGhlbiB0aGVyZSBpcyBub3RoaW5nIHRvIGZpeCwgdGhlIHF1aXJrIGlzIGNv
cnJlY3QuDQoNCkFsZXgNCg0KPiANCj4gVGhhbmtzDQo+IA0KPiBNYXJjb3MNCj4gDQo+ID4gPiA+
ID4gPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3Bj
aS9xdWlya3MuYw0KPiA+ID4gPiA+ID4gPj4+Pj4gaW5kZXggNDNhMGMyY2U2MzVlLi5iMWRiNThk
MDBkMmIgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL3BjaS9xdWlya3Mu
Yw0KPiA+ID4gPiA+ID4gPj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiA+ID4g
PiA+ID4+Pj4+IEBAIC01MTMzLDYgKzUxMzMsNyBAQA0KPiA+ID4gPiA+ID4gPj4+PiBERUNMQVJF
X1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDQ0MywNCj4gPiA+ID4gPiA+
ID4+Pj4gcXVpcmtfaW50ZWxfcWF0X3ZmX2NhcCk7DQo+ID4gPiA+ID4gPiA+Pj4+PiAgICogRkxS
IG1heSBjYXVzZSB0aGUgZm9sbG93aW5nIHRvIGRldmljZXMgdG8gaGFuZzoNCj4gPiA+ID4gPiA+
ID4+Pj4+ICAgKg0KPiA+ID4gPiA+ID4gPj4+Pj4gICAqIEFNRCBTdGFyc2hpcC9NYXRpc3NlIEhE
IEF1ZGlvIENvbnRyb2xsZXIgMHgxNDg3DQo+ID4gPiA+ID4gPiA+Pj4+PiArICogQU1EIFN0YXJz
aGlwIFVTQiAzLjAgSG9zdCBDb250cm9sbGVyIDB4MTQ4Yw0KPiA+ID4gPiA+ID4gPj4+Pj4gICAq
IEFNRCBNYXRpc3NlIFVTQiAzLjAgSG9zdCBDb250cm9sbGVyIDB4MTQ5Yw0KPiA+ID4gPiA+ID4g
Pj4+Pj4gICAqIEludGVsIDgyNTc5TE0gR2lnYWJpdCBFdGhlcm5ldCBDb250cm9sbGVyIDB4MTUw
Mg0KPiA+ID4gPiA+ID4gPj4+Pj4gICAqIEludGVsIDgyNTc5ViBHaWdhYml0IEV0aGVybmV0IENv
bnRyb2xsZXIgMHgxNTAzIEBADQo+ID4gPiA+ID4gPiA+Pj4+PiAtNTE0Myw2DQo+ID4gPiA+ID4g
KzUxNDQsNw0KPiA+ID4gPiA+ID4gPj4+Pj4gQEAgc3RhdGljIHZvaWQgcXVpcmtfbm9fZmxyKHN0
cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gPiA+ID4gPiA+Pj4+PiAgICAgZGV2LT5kZXZfZmxhZ3Mg
fD0gUENJX0RFVl9GTEFHU19OT19GTFJfUkVTRVQ7ICB9DQo+ID4gPiA+ID4gPiA+Pj4+PiBERUNM
QVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVORE9SX0lEX0FNRCwgMHgxNDg3LA0KPiA+ID4gPiA+
ID4gPj4+Pj4gcXVpcmtfbm9fZmxyKTsNCj4gPiA+ID4gPiA+ID4+Pj4+ICtERUNMQVJFX1BDSV9G
SVhVUF9FQVJMWShQQ0lfVkVORE9SX0lEX0FNRCwNCj4gMHgxNDhjLA0KPiA+ID4gPiA+ID4gPj4+
PiBxdWlya19ub19mbHIpOw0KPiA+ID4gPiA+ID4gPj4+Pj4gIERFQ0xBUkVfUENJX0ZJWFVQX0VB
UkxZKFBDSV9WRU5ET1JfSURfQU1ELA0KPiAweDE0OWMsDQo+ID4gPiA+ID4gPiA+Pj4+IHF1aXJr
X25vX2Zscik7DQo+ID4gPiA+ID4gPiA+Pj4+PiBERUNMQVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lf
VkVORE9SX0lEX0lOVEVMLA0KPiAweDE1MDIsDQo+ID4gPiA+ID4gPiA+Pj4+IHF1aXJrX25vX2Zs
cik7DQo+ID4gPiA+ID4gPiA+Pj4+PiBERUNMQVJFX1BDSV9GSVhVUF9FQVJMWShQQ0lfVkVORE9S
X0lEX0lOVEVMLA0KPiAweDE1MDMsDQo+ID4gPiA+ID4gPiA+Pj4+IHF1aXJrX25vX2Zscik7DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gUmVnYXJkDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
TmVoYWwgU2hhaA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0K
