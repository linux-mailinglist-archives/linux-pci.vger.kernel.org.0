Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55E25B854
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 03:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgICBcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 21:32:55 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:46049
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbgICBcy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 21:32:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM2H6ALseUBSpYmMYj/SVwcZeA1ppjKqetXP3cGkNrMqUgCTLKE4v7FGRQa4ESXtxY51CAw0jWTgo3Zgkp/PlwHjU8tmZo0C3AH3zNTdpLWxSE4M/bzAiRZlazK4ryy9ayi+bgduOVwl/9yqJ14NFhFPTtTOeGzqXMcTPxxmgyJJ05mmGABToIntSZEGWnTQS3n3gahqZBztawDsPc6ZoGKZCOpEZfeHyVAjGfymCjhIbuo7kBP8MLYCEnYcjuITFzEYgNqTGtr+RYX+sz7hP48ND5R21xDK8PhZu4pLarD54lD1XRX2iTI1igti49dktXRxaYYfLE+gLWOLdZV3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmek/PDw32JYCR1MmmgstXRSzJ/cCuShjhVzD8klsMs=;
 b=KnwhaIeyf7+QXoB3gz94bCef+7p1xteAsWeSfXaGVHdaNHlyUmQiZf57FFGc+9XkOCwCVlW20fgUBU3MwfAn8aP0jkmlewWJ5xQOi7hcc+mLsRX0f/tAT9APVz1d2Qe5JvIEwjI69jqPjPmN4FS4KInpbGDtLNlWqADJj7WcyA7rh3EoxFHWhJUdQ+aXLoJW6xgkZ+4f53VkE1c3BBmHoCRTO72ZIVlIRZ2EQ94S4FcoAOzQ5ZusHHln7+yIlbhc9L7bRaKADBwA4xe8o35VeKmgDHHoiqsixa1PpFjfdL+HJHbz+/BHxtZtJHVdfigE3FvVcmNiMDPqZ2j1krP4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmek/PDw32JYCR1MmmgstXRSzJ/cCuShjhVzD8klsMs=;
 b=S0Aztd1FrplGTTxTHF/d0Tr+XkeRClrNEc8JiC0ejq0bkSqLnoAO065/qryZ9WplcnPc+cIDiN1gTz9OyLXGRT1eGN5sB/Bu/Wb7ySiLjvSZLsLUSh8hw/C14xJ4KrNN7cUyGKScCRFCLagE4bU2oeyjbvh1Wtvu5eSFhrC56OM=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR1201MB0010.namprd12.prod.outlook.com (2603:10b6:3:e3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Thu, 3 Sep 2020 01:32:49 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 01:32:49 +0000
From:   "Li, Dennis" <Dennis.Li@amd.com>
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Das, Nirmoy" <Nirmoy.Das@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: RE: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
Thread-Topic: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
Thread-Index: AQHWgVjWCRPQDj2DlEejzC07GxNWHqlWHzxg
Date:   Thu, 3 Sep 2020 01:32:49 +0000
Message-ID: <DM5PR12MB2533B29C96B7FEA22FC55097ED2C0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-03T01:32:42Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=17886d74-2f27-4a01-a778-68034949421c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e22f838d-7eea-49c4-092d-08d84fa944c9
x-ms-traffictypediagnostic: DM5PR1201MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0010744A111F88B288760D00ED2C0@DM5PR1201MB0010.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1X3SSVDLgc7/aSzliFGDNR0lkz/iymQx8eJuYzjqQ5wsAdBt0eYjxmHonwk4WPptKvU4iiPJa6csxHBnyiTUabLdYH6UAmRiZxzQjeU9qIWflje0oWUHmcJNs79PmkIKEJ7XTJ9ZTWCan1/rGhu4LhgU3swwYvby4nXqgCmBY5NEALZ2AtppbPcZ72GjH9x/MNa++SKbxEEOVzZ3rMUXTB5qPUmhU/d6+fLW7lmw8PFXOhS1VYFClNtzYZFqiJ37FUZPCY0yhUbc5FvyB6ErKdqGCexQp0uPsYGieZtFloA4oCTDaplApQ1rtShqI1VojFrCbn5+rGY65UZVTT58Rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(6506007)(53546011)(66946007)(7696005)(71200400001)(52536014)(15650500001)(316002)(9686003)(478600001)(2906002)(66556008)(110136005)(66476007)(186003)(86362001)(83380400001)(26005)(64756008)(5660300002)(55016002)(8676002)(4326008)(66446008)(76116006)(54906003)(8936002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DaPrFrrvte7UfnPfwaB1w3kjEzy3RiVpIMUCakFYCluU7l7cjz6aGrK+MGF5z04YfBKaZHG6w4LgTA7SAfRU9dKtvmc0d+a+owa6LYicSqu3FS6YlubTzrm89ZvWseCxwwt484WMO5M7pAaMEZWWxi7pPIApyyPRtvdDX4r2R6NVFSlCT5ruVluAA7dbcGiKyxyxPP/8BUecBJoJvc5GD3aXXPMgZWjgaydK7c4EdO2ishHdPae2RdfEYfSl0FnnzguAX+CmAaHvt3NroTrQ/uvvm7Lltv9F3O1A7GOpYk2OwL+dqOFm0dd1kXU0nAU0lUv96wrW1eJRzdrgNaCVPQZ3MfhRWJuccWUbxRSvU+DiWyGKjH8FQFSgMz8AMLaiCmrFieGAoD3BvFXVb5FZp+/5VHXpxentg0zwGOTc/8BUfAFfIfzt2IPTI54D7jA8mqfjz8Tcc+dz476G7HTHTjC5kUxXsL/EkjPpwUCvFwVmOqGpnepjghT/wf0J5Vz44Oe3MCK5OwX+VyF9WnYcGJF77i04tGEwRWslzRQmxfwXuPMgppm6frYKEM+oK+y9a/YcCK1mUZsa2WvQ2LfH7L6HbhTEPCNYU6rkrVjZm7a0by8jyhN2QQPNyXZCoUS+6zlZAQIN2OGs8oWBf2DkRw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f838d-7eea-49c4-092d-08d84fa944c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 01:32:49.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7SJOo/WfJgHHv13GOj/pOdEo2Cshw+vvQr7SVs5GsCP49fcOi5JCTtms0eYwIaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0010
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgYW5kcmV5DQoNCkRpZCB5b3Ugd2FudCB0byB1c2UgYWRldi0+aW5fcGNpX2Vycl9yZWNvdmVy
eSB0byBhdm9pZCBoYXJkd2FyZSBhY2Nlc3NlZCBieSBvdGhlciB0aHJlYWRzIHdoZW4gZG9pbmcg
UENJIHJlY292ZXJ5PyBJZiBzbywgaXQgaXMgYmV0dGVyIHRvIGNoYW5nZSB0byB1c2UgbG9jayBw
cm90ZWN0IHRoZW0uIFRoaXMgcGF0Y2ggY2FuJ3Qgc29sdmUgeW91ciBpc3N1ZSBjb21wbGV0ZWx5
LiANCg0KQmVzdCBSZWdhcmRzDQpEZW5uaXMgTGkNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4gDQpT
ZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDMsIDIwMjAgMjo0MiBBTQ0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRl
bC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBEYXMsIE5pcm1veSA8TmlybW95LkRhc0BhbWQu
Y29tPjsgTGksIERlbm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFt
ZC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5H
cm9kem92c2t5QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjQgMS84XSBkcm0vYW1kZ3B1OiBB
dm9pZCBhY2Nlc3NpbmcgSFcgd2hlbiBzdXNwZW5kaW5nIFNXIHN0YXRlDQoNCkF0IHRoaXMgcG9p
bnQgdGhlIEFTSUMgaXMgYWxyZWFkeSBwb3N0IHJlc2V0IGJ5IHRoZSBIVy9QU1Agc28gdGhlIEhX
IG5vdCBpbiBwcm9wZXIgc3RhdGUgdG8gYmUgY29uZmlndXJlZCBmb3Igc3VzcGVuc2lvbiwgc29t
ZSBibG9ja3MgbWlnaHQgYmUgZXZlbiBnYXRlZCBhbmQgc28gYmVzdCBpcyB0byBhdm9pZCB0b3Vj
aGluZyBpdC4NCg0KdjI6IFJlbmFtZSBpbl9kcGMgdG8gbW9yZSBtZWFuaW5nZnVsIG5hbWUNCg0K
U2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5j
b20+DQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgIHwgIDEg
Kw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDM4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZnguYyAgICB8ICA2ICsrKysrDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jICAgIHwgIDYgKysrKysNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYyAgICAgfCAxOCArKysrKysrKy0tLS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jICAgICB8ICAzICsrKw0KIDYgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgN
CmluZGV4IGMzMTFhM2MuLmIyMDM1NGYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmgNCkBAIC05OTIsNiArOTkyLDcgQEAgc3RydWN0IGFtZGdwdV9kZXZpY2Ugew0KIAlhdG9taWNf
dAkJCXRocm90dGxpbmdfbG9nZ2luZ19lbmFibGVkOw0KIAlzdHJ1Y3QgcmF0ZWxpbWl0X3N0YXRl
CQl0aHJvdHRsaW5nX2xvZ2dpbmdfcnM7DQogCXVpbnQzMl90CQkJcmFzX2ZlYXR1cmVzOw0KKwli
b29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluX3BjaV9lcnJfcmVjb3Zlcnk7DQogfTsN
CiANCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNlICpkcm1fdG9fYWRldihzdHJ1
Y3QgZHJtX2RldmljZSAqZGRldikgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KaW5kZXggNzRhMWMwMy4uMWZiZjhhMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQpAQCAtMzE5LDYgKzMxOSw5IEBAIHVpbnQzMl90IGFt
ZGdwdV9tbV9ycmVnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCByZWcsICB7
DQogCXVpbnQzMl90IHJldDsNCiANCisJaWYgKGFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQor
CQlyZXR1cm4gMDsNCisNCiAJaWYgKCEoYWNjX2ZsYWdzICYgQU1ER1BVX1JFR1NfTk9fS0lRKSAm
JiBhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSkNCiAJCXJldHVybiBhbWRncHVfa2lxX3JyZWco
YWRldiwgcmVnKTsNCiANCkBAIC0zNTEsNiArMzU0LDkgQEAgdWludDMyX3QgYW1kZ3B1X21tX3Jy
ZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJlZywNCiAgKiBSZXR1cm5z
IHRoZSA4IGJpdCB2YWx1ZSBmcm9tIHRoZSBvZmZzZXQgc3BlY2lmaWVkLg0KICAqLw0KIHVpbnQ4
X3QgYW1kZ3B1X21tX3JyZWc4KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCBv
ZmZzZXQpIHsNCisJaWYgKGFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQorCQlyZXR1cm4gMDsN
CisNCiAJaWYgKG9mZnNldCA8IGFkZXYtPnJtbWlvX3NpemUpDQogCQlyZXR1cm4gKHJlYWRiKGFk
ZXYtPnJtbWlvICsgb2Zmc2V0KSk7DQogCUJVRygpOw0KQEAgLTM3Miw2ICszNzgsOSBAQCB1aW50
OF90IGFtZGdwdV9tbV9ycmVnOChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qg
b2Zmc2V0KSB7DQogICogV3JpdGVzIHRoZSB2YWx1ZSBzcGVjaWZpZWQgdG8gdGhlIG9mZnNldCBz
cGVjaWZpZWQuDQogICovDQogdm9pZCBhbWRncHVfbW1fd3JlZzgoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHVpbnQzMl90IG9mZnNldCwgdWludDhfdCB2YWx1ZSkgew0KKwlpZiAoYWRldi0+
aW5fcGNpX2Vycl9yZWNvdmVyeSkNCisJCXJldHVybjsNCisNCiAJaWYgKG9mZnNldCA8IGFkZXYt
PnJtbWlvX3NpemUpDQogCQl3cml0ZWIodmFsdWUsIGFkZXYtPnJtbWlvICsgb2Zmc2V0KTsNCiAJ
ZWxzZQ0KQEAgLTM4Miw2ICszOTEsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYW1kZ3B1X21tX3dy
ZWdfbW1pbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJCQkJICAgICAgIHVpbnQzMl90
IHJlZywgdWludDMyX3QgdiwNCiAJCQkJICAgICAgIHVpbnQzMl90IGFjY19mbGFncykNCiB7DQor
CWlmIChhZGV2LT5pbl9wY2lfZXJyX3JlY292ZXJ5KQ0KKwkJcmV0dXJuOw0KKw0KIAl0cmFjZV9h
bWRncHVfbW1fd3JlZyhhZGV2LT5wZGV2LT5kZXZpY2UsIHJlZywgdik7DQogDQogCWlmICgocmVn
ICogNCkgPCBhZGV2LT5ybW1pb19zaXplKQ0KQEAgLTQwOSw2ICs0MjEsOSBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgYW1kZ3B1X21tX3dyZWdfbW1pbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
IHZvaWQgYW1kZ3B1X21tX3dyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90
IHJlZywgdWludDMyX3QgdiwNCiAJCSAgICB1aW50MzJfdCBhY2NfZmxhZ3MpDQogew0KKwlpZiAo
YWRldi0+aW5fcGNpX2Vycl9yZWNvdmVyeSkNCisJCXJldHVybjsNCisNCiAJaWYgKCEoYWNjX2Zs
YWdzICYgQU1ER1BVX1JFR1NfTk9fS0lRKSAmJiBhbWRncHVfc3Jpb3ZfcnVudGltZShhZGV2KSkN
CiAJCXJldHVybiBhbWRncHVfa2lxX3dyZWcoYWRldiwgcmVnLCB2KTsNCiANCkBAIC00MjMsNiAr
NDM4LDkgQEAgdm9pZCBhbWRncHVfbW1fd3JlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2LCAgdm9pZCBhbWRncHVfbW1fd3JlZ19tbWlvX3JsYyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2LA0KIAkJ
ICAgIHVpbnQzMl90IGFjY19mbGFncykNCiB7DQorCWlmIChhZGV2LT5pbl9wY2lfZXJyX3JlY292
ZXJ5KQ0KKwkJcmV0dXJuOw0KKw0KIAlpZiAoYW1kZ3B1X3NyaW92X2Z1bGxhY2Nlc3MoYWRldikg
JiYNCiAJCWFkZXYtPmdmeC5ybGMuZnVuY3MgJiYNCiAJCWFkZXYtPmdmeC5ybGMuZnVuY3MtPmlz
X3JsY2dfYWNjZXNzX3JhbmdlKSB7IEBAIC00NDQsNiArNDYyLDkgQEAgdm9pZCBhbWRncHVfbW1f
d3JlZ19tbWlvX3JsYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1
aW50MzJfdA0KICAqLw0KIHUzMiBhbWRncHVfaW9fcnJlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdTMyIHJlZykgIHsNCisJaWYgKGFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQorCQly
ZXR1cm4gMDsNCisNCiAJaWYgKChyZWcgKiA0KSA8IGFkZXYtPnJpb19tZW1fc2l6ZSkNCiAJCXJl
dHVybiBpb3JlYWQzMihhZGV2LT5yaW9fbWVtICsgKHJlZyAqIDQpKTsNCiAJZWxzZSB7DQpAQCAt
NDYzLDYgKzQ4NCw5IEBAIHUzMiBhbWRncHVfaW9fcnJlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdTMyIHJlZykNCiAgKi8NCiB2b2lkIGFtZGdwdV9pb193cmVnKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1MzIgcmVnLCB1MzIgdikgIHsNCisJaWYgKGFkZXYtPmluX3BjaV9lcnJf
cmVjb3ZlcnkpDQorCQlyZXR1cm47DQorDQogCWlmICgocmVnICogNCkgPCBhZGV2LT5yaW9fbWVt
X3NpemUpDQogCQlpb3dyaXRlMzIodiwgYWRldi0+cmlvX21lbSArIChyZWcgKiA0KSk7DQogCWVs
c2Ugew0KQEAgLTQ4Miw2ICs1MDYsOSBAQCB2b2lkIGFtZGdwdV9pb193cmVnKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCB1MzIgcmVnLCB1MzIgdikNCiAgKi8NCiB1MzIgYW1kZ3B1X21tX3Jk
b29yYmVsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGluZGV4KSAgew0KKwlpZiAo
YWRldi0+aW5fcGNpX2Vycl9yZWNvdmVyeSkNCisJCXJldHVybiAwOw0KKw0KIAlpZiAoaW5kZXgg
PCBhZGV2LT5kb29yYmVsbC5udW1fZG9vcmJlbGxzKSB7DQogCQlyZXR1cm4gcmVhZGwoYWRldi0+
ZG9vcmJlbGwucHRyICsgaW5kZXgpOw0KIAl9IGVsc2Ugew0KQEAgLTUwMiw2ICs1MjksOSBAQCB1
MzIgYW1kZ3B1X21tX3Jkb29yYmVsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGlu
ZGV4KQ0KICAqLw0KIHZvaWQgYW1kZ3B1X21tX3dkb29yYmVsbChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgdTMyIGluZGV4LCB1MzIgdikgIHsNCisJaWYgKGFkZXYtPmluX3BjaV9lcnJfcmVj
b3ZlcnkpDQorCQlyZXR1cm47DQorDQogCWlmIChpbmRleCA8IGFkZXYtPmRvb3JiZWxsLm51bV9k
b29yYmVsbHMpIHsNCiAJCXdyaXRlbCh2LCBhZGV2LT5kb29yYmVsbC5wdHIgKyBpbmRleCk7DQog
CX0gZWxzZSB7DQpAQCAtNTIwLDYgKzU1MCw5IEBAIHZvaWQgYW1kZ3B1X21tX3dkb29yYmVsbChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGluZGV4LCB1MzIgdikNCiAgKi8NCiB1NjQg
YW1kZ3B1X21tX3Jkb29yYmVsbDY0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgaW5k
ZXgpICB7DQorCWlmIChhZGV2LT5pbl9wY2lfZXJyX3JlY292ZXJ5KQ0KKwkJcmV0dXJuIDA7DQor
DQogCWlmIChpbmRleCA8IGFkZXYtPmRvb3JiZWxsLm51bV9kb29yYmVsbHMpIHsNCiAJCXJldHVy
biBhdG9taWM2NF9yZWFkKChhdG9taWM2NF90ICopKGFkZXYtPmRvb3JiZWxsLnB0ciArIGluZGV4
KSk7DQogCX0gZWxzZSB7DQpAQCAtNTQwLDYgKzU3Myw5IEBAIHU2NCBhbWRncHVfbW1fcmRvb3Ji
ZWxsNjQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBpbmRleCkNCiAgKi8NCiB2b2lk
IGFtZGdwdV9tbV93ZG9vcmJlbGw2NChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGlu
ZGV4LCB1NjQgdikgIHsNCisJaWYgKGFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQorCQlyZXR1
cm47DQorDQogCWlmIChpbmRleCA8IGFkZXYtPmRvb3JiZWxsLm51bV9kb29yYmVsbHMpIHsNCiAJ
CWF0b21pYzY0X3NldCgoYXRvbWljNjRfdCAqKShhZGV2LT5kb29yYmVsbC5wdHIgKyBpbmRleCks
IHYpOw0KIAl9IGVsc2Ugew0KQEAgLTQ3NzMsNyArNDgwOSw5IEBAIHBjaV9lcnNfcmVzdWx0X3Qg
YW1kZ3B1X3BjaV9zbG90X3Jlc2V0KHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KIA0KIAlwY2lfcmVz
dG9yZV9zdGF0ZShwZGV2KTsNCiANCisJYWRldi0+aW5fcGNpX2Vycl9yZWNvdmVyeSA9IHRydWU7
DQogCXIgPSBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmQoYWRldik7DQorCWFkZXYtPmluX3BjaV9l
cnJfcmVjb3ZlcnkgPSBmYWxzZTsNCiAJaWYgKHIpDQogCQlnb3RvIG91dDsNCiANCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCmluZGV4IGQ2OTgxNDIuLjhjOWJhY2YgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KQEAgLTY5Myw2ICs2OTMs
OSBAQCB1aW50MzJfdCBhbWRncHVfa2lxX3JyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVpbnQzMl90IHJlZykNCiAJc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5nZngua2lx
Ow0KIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAma2lxLT5yaW5nOw0KIA0KKwlpZiAoYWRl
di0+aW5fcGNpX2Vycl9yZWNvdmVyeSkNCisJCXJldHVybiAwOw0KKw0KIAlCVUdfT04oIXJpbmct
PmZ1bmNzLT5lbWl0X3JyZWcpOw0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgma2lxLT5yaW5nX2xv
Y2ssIGZsYWdzKTsgQEAgLTc1Nyw2ICs3NjAsOSBAQCB2b2lkIGFtZGdwdV9raXFfd3JlZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2KQ0KIA0KIAlC
VUdfT04oIXJpbmctPmZ1bmNzLT5lbWl0X3dyZWcpOw0KIA0KKwlpZiAoYWRldi0+aW5fcGNpX2Vy
cl9yZWNvdmVyeSkNCisJCXJldHVybjsNCisNCiAJc3Bpbl9sb2NrX2lycXNhdmUoJmtpcS0+cmlu
Z19sb2NrLCBmbGFncyk7DQogCWFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIDMyKTsNCiAJYW1kZ3B1
X3JpbmdfZW1pdF93cmVnKHJpbmcsIHJlZywgdik7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jDQppbmRleCBkNmMzOGUyLi5hNzc3MWFhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCkBAIC0yMTksNiArMjE5LDkgQEAgaW50IHBzcF93YWl0
X2ZvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgdWludDMyX3QgcmVnX2luZGV4LA0KIAlpbnQg
aTsNCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7DQogDQorCWlmIChw
c3AtPmFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQorCQlyZXR1cm4gMDsNCisNCiAJZm9yIChp
ID0gMDsgaSA8IGFkZXYtPnVzZWNfdGltZW91dDsgaSsrKSB7DQogCQl2YWwgPSBSUkVHMzIocmVn
X2luZGV4KTsNCiAJCWlmIChjaGVja19jaGFuZ2VkKSB7DQpAQCAtMjQ1LDYgKzI0OCw5IEBAIHBz
cF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwNCiAJYm9vbCByYXNfaW50
ciA9IGZhbHNlOw0KIAlib29sIHNraXBfdW5zdXBwb3J0ID0gZmFsc2U7DQogDQorCWlmIChwc3At
PmFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQorCQlyZXR1cm4gMDsNCisNCiAJbXV0ZXhfbG9j
aygmcHNwLT5tdXRleCk7DQogDQogCW1lbXNldChwc3AtPmNtZF9idWZfbWVtLCAwLCBQU1BfQ01E
X0JVRkZFUl9TSVpFKTsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCmluZGV4
IDJkYjE5NWUuLmNjZjA5NmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMNCkBAIC02OTgwLDE1ICs2OTgwLDE5IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2h3X2Zpbmko
dm9pZCAqaGFuZGxlKQ0KIA0KIAlhbWRncHVfaXJxX3B1dChhZGV2LCAmYWRldi0+Z2Z4LnByaXZf
cmVnX2lycSwgMCk7DQogCWFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nZngucHJpdl9pbnN0
X2lycSwgMCk7DQorDQorCWlmICghYWRldi0+aW5fcGNpX2Vycl9yZWNvdmVyeSkgew0KICNpZm5k
ZWYgQlJJTkdfVVBfREVCVUcNCi0JaWYgKGFtZGdwdV9hc3luY19nZnhfcmluZykgew0KLQkJciA9
IGdmeF92MTBfMF9raXFfZGlzYWJsZV9rZ3EoYWRldik7DQotCQlpZiAocikNCi0JCQlEUk1fRVJS
T1IoIktHUSBkaXNhYmxlIGZhaWxlZFxuIik7DQotCX0NCisJCWlmIChhbWRncHVfYXN5bmNfZ2Z4
X3JpbmcpIHsNCisJCQlyID0gZ2Z4X3YxMF8wX2tpcV9kaXNhYmxlX2tncShhZGV2KTsNCisJCQlp
ZiAocikNCisJCQkJRFJNX0VSUk9SKCJLR1EgZGlzYWJsZSBmYWlsZWRcbiIpOw0KKwkJfQ0KICNl
bmRpZg0KLQlpZiAoYW1kZ3B1X2dmeF9kaXNhYmxlX2tjcShhZGV2KSkNCi0JCURSTV9FUlJPUigi
S0NRIGRpc2FibGUgZmFpbGVkXG4iKTsNCisJCWlmIChhbWRncHVfZ2Z4X2Rpc2FibGVfa2NxKGFk
ZXYpKQ0KKwkJCURSTV9FUlJPUigiS0NRIGRpc2FibGUgZmFpbGVkXG4iKTsNCisJfQ0KKw0KIAlp
ZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQogCQlnZnhfdjEwXzBfY3BfZ2Z4X2VuYWJsZShh
ZGV2LCBmYWxzZSk7DQogCQkvKiBQcm9ncmFtIEtJUSBwb3NpdGlvbiBvZiBSTENfQ1BfU0NIRURV
TEVSUyBkdXJpbmcgZGVzdHJveSAqLyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXVfY21uLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4u
Yw0KaW5kZXggYTU4ZWEwOC4uOTdhYTcyYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdV9jbW4uYw0KQEAgLTExMiw2ICsxMTIsOSBAQCBpbnQgc211X2Ntbl9zZW5kX3NtY19tc2df
d2l0aF9wYXJhbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCiAJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBzbXUtPmFkZXY7DQogCWludCByZXQgPSAwLCBpbmRleCA9IDA7DQogDQorCWlm
IChzbXUtPmFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkpDQorCQlyZXR1cm4gMDsNCisNCiAJaW5k
ZXggPSBzbXVfY21uX3RvX2FzaWNfc3BlY2lmaWNfaW5kZXgoc211LA0KIAkJCQkJICAgICAgIENN
TjJBU0lDX01BUFBJTkdfTVNHLA0KIAkJCQkJICAgICAgIG1zZyk7DQotLQ0KMi43LjQNCg==
