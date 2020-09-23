Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A32758D8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgIWNgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 09:36:08 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:50852 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWNgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 09:36:07 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NDR9Sg007108;
        Wed, 23 Sep 2020 09:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ED4nuKR3wDWbU1c+3fm3YOm8Gb+E4+sNPe3riQSBbJg=;
 b=IMk+MhK5aNg3styjfxxco3PuvNW2KSUSp2dkidjQGY5jR5CyLFTG1OcCwYwIqynGX2FQ
 fsdEYPXG6Q9gu+PHqxE61J4YVSiOTEPaqxeffaCUaY8jROhusbFcwIg8BgM+oxAunl9Z
 6adnsEH+nWYSIiRG/l9q35eEc8up6O36vlls3UywTVSIR8smYtEvr9MptnySSCcjF4ru
 1A5yIL6o8BV4e1OxvHsgc6CzBpdFJKEA7DXH49OolzhXgDluRG1sYkuuTSDnvsrIZBct
 aOB5q7Z6gC9hRezPh5NB4MqIqptyf4Mktpd+UeaWcvbNYgV/DwnVchxwT2Yd9EtsK0xR tw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 33qk3fvddm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 09:36:00 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NDVOHC063996;
        Wed, 23 Sep 2020 09:35:59 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00154901.pphosted.com with ESMTP id 33qdnv72f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 09:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsnP3NrkXEbRUfIFOIuopdMRBOgPkwEyGd55Hx3zfN27iCrRXQ3Il57cn3UG56zvY0q+R5dDn/4hLPygFP6pkOqNxvrAUzevea5bhKoy2E8a+APh2Blq+ZWAFLGuliSYkBtmONBsz3zu0RDSZcNgZsSeIMaeZaS7t3cHuSSAof+OHw7nxGsEZwxRQOduWcupC5/wtKUM0VR8mx18ASrssnGKJXUSHMVKfN6hN8wDlGCu5Zlqeg3I+3vxFESIyp21uOh44/LzkQsWUsCd0V++iFXsBCtP71ASpxHjm5aEa4iSOYpVIoosYgAv/2O+6M/FWN35dKEB9YD07XswSy6xDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED4nuKR3wDWbU1c+3fm3YOm8Gb+E4+sNPe3riQSBbJg=;
 b=ndArco09c1LJ2wB9Oj+TLsH3cKRlzs2uqnyropO/t44XddT/p0KlTuQQOJ1XhjWTr/tCLRRE760Ub1lWk/E7n1LWKs30EVkN0UxB1VYS9ZKwW2A5cUQkfJyOs5/SvLIbM+BM6AQfT1A59cj4xbgy/qs3nYI21xS2wmpAgQ589zS+Mbv/nLyxOpFMmzxxBGpwakEx4aEwmU6WlnZmWnRj6STikrjeUVyKytlaU52kiD5Em8FANpjrji8/zpXfW7vRYtWc6qboTZcAduj3taRJz2VU6RGm57MaP9pSRPJ8p1YuMl///kYWBtsZ86Hpi/pa6OyJUzfz/rPFpI8eF4QUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED4nuKR3wDWbU1c+3fm3YOm8Gb+E4+sNPe3riQSBbJg=;
 b=Ke+dLEK6mZBjRh9qZNsIonkXz8sd7jEOW+kHLQKb6t2yGFBgZf2oxCsJ+X3g2pwH8Y8Get+eOjzqVkCrMcZccldwUsrO8rY3LcKBQbZLUsAkYMsox6tGSaMArSgSopuki/fcw5Cndg3hK7V2WpT0i3zbDHdnraj7NSxcPx9rD1k=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DS7PR19MB4421.namprd19.prod.outlook.com (2603:10b6:5:2c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 23 Sep
 2020 13:35:56 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 13:35:56 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: Enabling d3 support on hotplug bridges
Thread-Topic: Enabling d3 support on hotplug bridges
Thread-Index: AQHWkaM6uqLu5ahpiUuDVx0BdbyG5Kl2KoAAgAAMh0A=
Date:   Wed, 23 Sep 2020 13:35:56 +0000
Message-ID: <DM6PR19MB26363CA2BF6760B3BB4CBB00FA380@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <CADnq5_PoDdSeOxGgr5TzVwTTJmLb7BapXyG0KDs92P=wXzTNfg@mail.gmail.com>
 <20200922065434.GA19668@wunner.de>
 <CADnq5_MfkojHbquHq4Le6ioSFOY9XdaNBapAEmyOgf0CGMTaUg@mail.gmail.com>
 <20200923121509.GA25329@wunner.de>
 <CAJZ5v0j_ZMSLyQWxw2R2SJqssptOwLpKQ7a3eLR4TFiB_s0L_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0j_ZMSLyQWxw2R2SJqssptOwLpKQ7a3eLR4TFiB_s0L_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-23T13:34:27.3724839Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=eb44ed4a-7aa0-4ee2-b201-6236a654dfe4;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f0a9f00-9624-442c-eec7-08d85fc599bb
x-ms-traffictypediagnostic: DS7PR19MB4421:
x-microsoft-antispam-prvs: <DS7PR19MB4421896627AA227F405AC2CAFA380@DS7PR19MB4421.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/H5NLfDfs3MD+etuOXgVw/4CngEHHxBO9+do3tCCWVGztZ2jxZxQyOjlxxIM2Q3rj4GfAIL4y+uaOaAn2iKbTb/qeml1EI4vDwEWF+/BpGPDAGeD3Rphh0XoqqK5mpLvmGbKQ02/HkKtwA0tDY/b390UbXtEgOB0z4CTffPCcspEI3BuiOYpgfELhBXh9o07JSgKmYh1w2nWPA2fkg2o3uazceP47qANJUfNL85eKW4NY21HUSmg58zle02Y8u00+cTOcLBlgOcKB0JJ4Q3dnSwMmpj7aSZ07SvZEmsJKMXMBYNRb1loC9kSFXeC4ZavtjKnDACSPFAVFaNEM6CMtS7hP4FHuOQ+NKL5ekVvIhtT2/sxt2C6JvINiweW0p4nRWLFhtzc34PhD8jpftWc6YzPpLV8tHzrgSzLvBM96BerOYCE1Eq3IK2b6TrXMR5LQyctwaOaHi30lOfrSbphg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(55016002)(86362001)(6506007)(53546011)(9686003)(71200400001)(7696005)(5660300002)(19627235002)(66556008)(66946007)(186003)(66476007)(4326008)(8676002)(26005)(76116006)(786003)(8936002)(316002)(2906002)(110136005)(52536014)(33656002)(66446008)(64756008)(54906003)(45080400002)(966005)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PyrZPhRFGK/k0jSWdZJkOp0O7LImfsG1LdWdB+IN2QnnHWhMjEWy7bRkqHuMwlT5Ob3YFw/dlW4CO7WnoDpGd3HVZ+wRV4Dl4rW7lXGq3NIbl5yvYe/qbksDJIvw+F+HwqoQIAG66MtkJEAMNea6q60+4xAXbYpbkzOCmAT/2bhiSVpSzP/ekekRfUnIfYD7Tbs4zQA+zBvv7I4GOY8xodN/sqQpO8o6uqML2YtKwlInlMCbjxqNFRqKd6xRs7uh9MlPRKViDH4XAJWkthlHaIPCcDZ/0NiMMtaSs+Mt8l23tWEOzwWnBX+3K8LX4ZtPUbyVVKAzBBJqhoDCNZQ3+3d+ioNICwXPRaTk9N/pM4nsVhaChT1+lm+14Hjnp4wfi1S1goVLycDtu1HXckL6kHf1h016DCFsYdd7/sN+fFRFTMfQFjGz55HSQZHdlDSBtQbuYj5gJ3PuL8X7+noY3fe4eazScJn9M4Jr+ZjzIy9wI3GTKR8b5n9kgclnRooTQD59n7rSQBKnxQJAmg3vXyN/jh/6gZxuutxldqkQdLwc6wdyUeIdwLa42LTfXopxbo6J6hB/n3rs4i67BV4V6udx5xdl31rix/ZhoW99B60kZEh3u17XH5qEV3tlCeO0/tNpkhTgGUcomrTF4gkAhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0a9f00-9624-442c-eec7-08d85fc599bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 13:35:56.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlL8h/rJuL67DiDHU+Z426zOXhtCKXYz+lIFfzvY2peEjSJCJAEz9UTe/5QQCtbwpN9jM5Qkciqhw08oEqBEii0zBoPNb+vVWfamOpHoHOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_09:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230107
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230107
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIzLCAyMDIw
IDc6NDINCj4gVG86IEx1a2FzIFd1bm5lcjsgQWxleCBEZXVjaGVyDQo+IENjOiBMaW51eCBQQ0k7
IEJqb3JuIEhlbGdhYXM7IFJhZmFlbCBKLiBXeXNvY2tpOyBNaWthIFdlc3RlcmJlcmc7IExpbW9u
Y2llbGxvLA0KPiBNYXJpbw0KPiBTdWJqZWN0OiBSZTogRW5hYmxpbmcgZDMgc3VwcG9ydCBvbiBo
b3RwbHVnIGJyaWRnZXMNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBPbiBXZWQs
IFNlcCAyMywgMjAyMCBhdCAyOjE1IFBNIEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPiB3
cm90ZToNCj4gPg0KPiA+IFtjYyArPSBNYXJpbyBMaW1vbmNpZWxsbyBAIERlbGxdDQo+ID4NCj4g
PiBPbiBUdWUsIFNlcCAyMiwgMjAyMCBhdCAxMDozOToxN0FNIC0wNDAwLCBBbGV4IERldWNoZXIg
d3JvdGU6DQo+ID4gPiBPbiBUdWUsIFNlcCAyMiwgMjAyMCBhdCAyOjU0IEFNIEx1a2FzIFd1bm5l
ciA8bHVrYXNAd3VubmVyLmRlPiB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCBTZXAgMjEsIDIwMjAg
YXQgMDc6MTA6NTVQTSAtMDQwMCwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiA+ID4gPiA+IFJlY2Vu
dCBBTUQgbGFwdG9wcyB3aGljaCBoYXZlIGlHUFUgKyBkR1BVIGhhdmUgYmVlbiBub24tZnVuY3Rp
b25hbCBvbg0KPiA+ID4gPiA+IExpbnV4LiAgVGhlIGlzc3VlIGlzIHRoYXQgdGhlIGxhcHRvcHMg
cmVseSBvbiBBQ1BJIHRvIGNvbnRyb2wgdGhlIGRHUFUNCj4gPiA+ID4gPiBwb3dlciBhbmQgdGhh
dCBpcyBub3QgaGFwcGVuaW5nIGJlY2F1c2UgdGhlIGJyaWRnZXMgYXJlIGhvdHBsdWcNCj4gPiA+
ID4gPiBjYXBhYmxlLCBhbmQgdGhlIGN1cnJlbnQgcGNpIGNvZGUgZG9lcyBub3QgYWxsb3cgcnVu
dGltZSBwbSBvbiBob3RwbHVnDQo+ID4gPiA+ID4gY2FwYWJsZSBicmlkZ2VzLiAgVGhpcyB3b3Jr
ZWQgb24gcHJldmlvdXMgbGFwdG9wcyBwcmVzdW1hYmx5IGJlY2F1c2UNCj4gPiA+ID4gPiB0aGUg
YnJpZGdlcyBkaWQgbm90IHN1cHBvcnQgaG90cGx1ZyBvciB0aGV5IGhpdCBvbmUgb2YgdGhlIGFs
bG93ZWQNCj4gPiA+ID4gPiBjYXNlcy4gIFRoZSBkcml2ZXIgZW5hYmxlcyBydW50aW1lIHBvd2Vy
IG1hbmFnZW1lbnQsIGJ1dCBzaW5jZSB0aGUNCj4gPiA+ID4gPiBkR1BVIGRvZXMgbm90IGFjdHVh
bGx5IGdldCBwb3dlcmVkIGRvd24gdmlhIHRoZSBwbGF0Zm9ybSBBQ1BJDQo+ID4gPiA+ID4gY29u
dHJvbHMsIG5vIHBvd2VyIGlzIHNhdmVkLCBhbmQgdGhpbmdzIGZhbGwgYXBhcnQgb24gcmVzdW1l
IGxlYWRpbmcNCj4gPiA+ID4gPiB0byBhbiB1bnVzYWJsZSBHUFUgb3IgYSBzeXN0ZW0gaGFuZy4g
IFRvIHdvcmsgYXJvdW5kIHRoaXMgdXNlcnMgY2FuDQo+ID4gPiA+ID4gY3VycmVudGx5IGRpc2Fi
bGUgcnVudGltZSBwbSBpbiB0aGUgR1BVIGRyaXZlciBvciBzcGVjaWZ5DQo+ID4gPiA+ID4gcGNp
ZV9wb3J0X3BtPWZvcmNlIHRvIGZvcmNlIGQzIG9uIGJyaWRnZXMuICBJJ20gbm90IHN1cmUgd2hh
dCB0aGUgYmVzdA0KPiA+ID4gPiA+IHNvbHV0aW9uIGZvciB0aGlzIGlzLiAgSSdkIHJhdGhlciBu
b3QgaGF2ZSB0byBhZGQgZGV2aWNlIElEcyB0byBhDQo+ID4gPiA+ID4gd2hpdGVsaXN0IGV2ZXJ5
IHRpbWUgd2UgcmVsZWFzZSBhIG5ldyBwbGF0Zm9ybS4gIFN1Z2dlc3Rpb25zPyAgV2hhdA0KPiA+
ID4gPiA+IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoZSBhdHRhY2hlZCBwYXRjaCB3b3JrPw0KPiA+
ID4gPg0KPiA+ID4gPiBXaGF0IGlzIFdpbmRvd3MgZG9pbmcgb24gdGhlc2UgbWFjaGluZXM/ICBN
aWNyb3NvZnQgY2FtZSB1cCB3aXRoIGFuDQo+ID4gPiA+IEFDUEkgX0RTRCBwcm9wZXJ0eSB0byB0
ZWxsIE9TUE0gdGhhdCBpdCdzIHNhZmUgdG8gc3VzcGVuZCBhIGhvdHBsdWcNCj4gPiA+ID4gcG9y
dCB0byBEMzoNCj4gPiA+ID4NCj4gPiA+ID4gaHR0cHM6Ly9kb2NzLm1pY3Jvc29mdC5jb20vZW4t
dXMvd2luZG93cy1oYXJkd2FyZS9kcml2ZXJzL3BjaS9kc2QtZm9yLQ0KPiBwY2llLXJvb3QtcG9y
dHMjaWRlbnRpZnlpbmctcGNpZS1yb290LXBvcnRzLXN1cHBvcnRpbmctaG90LXBsdWctaW4tZDMN
Cj4gPg0KPiA+IEkndmUganVzdCB0YWtlbiBhIGxvb2sgYXQgdGhlIEFDUEkgZHVtcHMgcHJvdmlk
ZWQgYnkgTWljaGFsIFJvc3RlY2tpDQo+ID4gYW5kIEFydGh1ciBCb3JzYm9vbSBpbiB0aGUgR2l0
bGFiIGJ1Z3MgbGlua2VkIGJlbG93LiAgVGhlIHRvcG9sb2d5DQo+ID4gbG9va3MgbGlrZSB0aGlz
Og0KPiA+DQo+ID4gMDA6MDEuMSAgICAgICAgUm9vdCBQb3J0ICAgICAgICAgW1xfU0IuUENJMC5H
UFAwXQ0KPiA+ICAgMDE6MDAuMCAgICAgIFN3aXRjaCBVcHN0cmVhbSAgIFtcX1NCLlBDSTAuR1BQ
MC5TV1VTXQ0KPiA+ICAgICAwMjowMC4wICAgIFN3aXRjaCBEb3duc3RyZWFtIFtcX1NCLlBDSTAu
R1BQMC5TV1VTLlNXRFNdDQo+ID4gICAgICAgMDM6MDAuMCAgZEdQVSAgICAgICAgICAgICAgW1xf
U0IuUENJMC5HUFAwLlNXVVMuU1dEUy5WR0FdDQo+ID4gICAgICAgMDM6MDAuMSAgZEdQVSBBdWRp
byAgICAgICAgW1xfU0IuUENJMC5HUFAwLlNXVVMuU1dEUy5IREFVXQ0KPiA+DQo+ID4gVGhlIFJv
b3QgUG9ydCBpcyBob3RwbHVnLWNhcGFibGUgYnV0IGlzIG5vdCBzdXNwZW5kZWQgYmVjYXVzZSB3
ZSBvbmx5DQo+ID4gYWxsb3cgdGhhdCBmb3IgVGh1bmRlcmJvbHQgaG90cGx1ZyBwb3J0cyBvciBy
b290IHBvcnRzIHdpdGggTWljcm9zb2Z0J3MNCj4gPiBIb3RQbHVnU3VwcG9ydEluRDMgX0RTRCBw
cm9wZXJ0eS4gIEhvd2V2ZXIsIHRoYXQgX0RTRCBpcyBub3QgcHJlc2VudA0KPiA+IGluIHRoZSBB
Q1BJIGR1bXBzIGFuZCB0aGUgUm9vdCBQb3J0IGlzIG9idmlvdXNseSBub3QgYSBUaHVuZGVyYm9s
dA0KPiA+IHBvcnQgZWl0aGVyLg0KPiA+DQo+ID4gQWdhaW4sIGl0IHdvdWxkIGJlIGdvb2QgdG8g
a25vdyB3aHkgaXQncyB3b3JraW5nIG9uIFdpbmRvd3MuDQo+IA0KPiBBZ3JlZWQuDQo+IA0KPiA+
IENvdWxkIHlvdSBhc2sgQU1EIFdpbmRvd3MgZHJpdmVyIGZvbGtzPyAgVGhlIEFDUEkgdGFibGVz
IGxvb2sgdmVyeQ0KPiA+IHNpbWlsYXIgZXZlbiB0aG91Z2ggdGhleSdyZSBmcm9tIGRpZmZlcmVu
dCB2ZW5kb3JzIChEZWxsIGFuZCBNU0kpLA0KPiA+IHNvIHRoZXkgd2VyZSBwcm9iYWJseSBzdXBw
bGllZCBieSBBTUQgdG8gdGhvc2UgT0VNcy4NCj4gPg0KPiA+IEl0J3MgcXVpdGUgcG9zc2libGUg
dGhhdCBXaW5kb3dzIGlzIG5vdyB1c2luZyBhIEJJT1MgY3V0LW9mZiBhbmQNCj4gPiBhbGxvd3Mg
RDMgYnkgZGVmYXVsdCBvbiBuZXdlciBCSU9TZXMsIHNvIEknbSBub3Qgb3Bwb3NlZCB0byB5b3Vy
IHBhdGNoLg0KPiANCj4gSSB3b3VsZCByZW9yZGVyIHRoaXMgZnVuY3Rpb24sIHRob3VnaCwgdG8g
YXZvaWQgY2FsbGluZw0KPiBkbWlfZ2V0X2Jpb3NfeWVhcigpIHR3aWNlLg0KDQpJIGhhdmUgYSBn
ZW5lcmFsIGNvbmNlcm4gb24gcmVseWluZyB1cG9uIHRoZSBETUkgQklPUyBkYXRlLiAgTWFudWZh
Y3R1cmVycw0KU3RpbGwgdHJlYXQgb2xkZXIgbWFjaGluZXMgYXMgc3VzdGFpbmluZy4gVGhlc2Ug
Y2FuIHJlY2VpdmUgdXBkYXRlZCBCSU9TIHJlbGVhc2VzDQpmb3Igc2VjdXJpdHkgdnVsbmVyYWJp
bGl0aWVzLCBidXQgZ2VuZXJhbGx5IGNoYW5nZXMgbGlrZSBtb2RpZnlpbmcgaG93IGhvdHBsdWcg
YnJpZGdlcw0Kd29yayB3aWxsIG5vdCBiZSBhcHBsaWVkIGluIHN1Y2ggcmVsZWFzZS4NCg0KSSBj
YW4gdW5kZXJzdGFuZCBpdCdzIG5vdCBkZXNpcmFibGUgdG8gaGFyZGNvZGUgYSBiaWcgbGlzdCBv
ZiBzeXN0ZW1zIHRob3VnaCwgc28NCmhlcmUgYXJlIHNvbWUgb3RoZXIgaGV1cmlzdGljIHRob3Vn
aHRzIHRoYXQgbWlnaHQgYmUgdXNlZnVsIHRvIHVzZToNCiogU01CSU9TIENoYXNzaXMgdHlwZSB0
byBtYWtlIHN1cmUgaXQncyBhIGxhcHRvcA0KKiBCYXR0ZXJ5IG1hbnVmYWN0dXJpbmcgZGF0ZSAo
d2hpY2ggaXMgYXZhaWxhYmxlIGluIFNNQklPUyBkYXRhKQ0KKiBLbm93biBBTUQgZEdQVXMgZnJv
bSAyMDE4IG9yIGVhcmxpZXIgKHNob3VsZCBiZSBhIGZpeGVkIHNldCBvZiBpbmZvcm1hdGlvbikN
Cg0KPiANCj4gVGhlIGJsYWNrbGlzdCBjYW4gYmUgY2hlY2tlZCBiZWZvcmUgaXNfaG90cGx1Z19i
cmlkZ2UsIHNvIEkgd291bGQganVzdA0KPiBtYWtlIHRoZSBjdXQtb2ZmIGRhdGUgZGVwZW5kIG9u
IHRoZSBsYXR0ZXIuDQo+IA0KPiA+IEJ1dCBpdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUgc29tZSBr
aW5kIG9mIGNvbmZpcm1hdGlvbiBiZWZvcmUgd2Ugcmlzaw0KPiA+IHJlZ3Jlc3NpbmcgbWFjaGlu
ZXMgd2hpY2ggZG8gbm90IHN1cHBvcnQgRDMgb24gaG90cGx1Zy1jYXBhYmxlIFJvb3QgUG9ydHMu
DQo+IA0KPiBDZXJ0YWlubHkgLSBpZiBwb3NzaWJsZS4NCj4gDQo+IENoZWVycyENCj4gDQo+IA0K
PiA+ID4gPiA+IEZyb20gM2EwOGNiNmFjMzhjNDdiOTIxYjhiNmYzMWIwM2ZjZDhmMTNjNDAxOCBN
b24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gPiA+ID4gPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiA+ID4gRGF0ZTogTW9uLCAyMSBTZXAgMjAy
MCAxODowNzoyNyAtMDQwMA0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gcGNpOiBhbGxvdyBk
MyBvbiBob3RwbHVnIGJyaWRnZXMgYWZ0ZXIgMjAxOA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTmV3
ZXIgQU1EIGxhcHRvcHMgaGF2ZSBob3RwbHVnIGNhcGFiZSBicmlkZ2VzIHdpdGggZEdQVXMgYmVo
aW5kIHRoZW0uDQo+ID4gPiA+ID4gSWYgZDMgaXMgZGlzYWJsZWQgb24gdGhlIGJyaWRnZSwgdGhl
IGRHUFUgaXMgbmV2ZXIgcG93ZXJlZCBkb3duIGV2ZW4NCj4gPiA+ID4gPiB0aG91Z2ggdGhlIGRH
UFUgZHJpdmVyIG1heSB0aGluayBpdCBpcyBiZWNhdXNlIHBvd2VyIGlzIGhhbmRsZWQgYnkNCj4g
PiA+ID4gPiB0aGUgcGNpIGNvcmUuICBUaGluZ3MgZmFsbCBhcGFydCB3aGVuIHRoZSBkcml2ZXIg
YXR0ZW1wdHMgdG8gcmVzdW1lDQo+ID4gPiA+ID4gYSBkR1BVIHRoYXQgd2FzIG5vdCBwcm9wZXJs
eSBwb3dlcmVkIGRvd24gd2hpY2ggbGVhZHMgdG8gaGFuZ3MuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBCdWc6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzEy
NTINCj4gPiA+ID4gPiBCdWc6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1k
Ly0vaXNzdWVzLzEyMjINCj4gPiA+ID4gPiBCdWc6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9kcm0vYW1kLy0vaXNzdWVzLzEzMDQNCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gIGRyaXZlcnMvcGNpL3BjaS5jIHwgMiArLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jDQo+ID4gPiA+
ID4gaW5kZXggYTQ1OGM0NmQ3ZTM5Li4xMjkyN2Q1ZGY0YjkgMTAwNjQ0DQo+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy9wY2kvcGNpLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuYw0K
PiA+ID4gPiA+IEBAIC0yODU2LDcgKzI4NTYsNyBAQCBib29sIHBjaV9icmlkZ2VfZDNfcG9zc2li
bGUoc3RydWN0IHBjaV9kZXYNCj4gKmJyaWRnZSkNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAq
IGJ5IHZlbmRvcnMgZm9yIHJ1bnRpbWUgRDMgYXQgbGVhc3QgdW50aWwgMjAxOCBiZWNhdXNlDQo+
IHRoZXJlDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgKiB3YXMgbm8gT1Mgc3VwcG9ydC4NCj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAqLw0KPiA+ID4gPiA+IC0gICAgICAgICAgICAgaWYgKGJy
aWRnZS0+aXNfaG90cGx1Z19icmlkZ2UpDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAoYnJp
ZGdlLT5pc19ob3RwbHVnX2JyaWRnZSAmJiAoZG1pX2dldF9iaW9zX3llYXIoKSA8PQ0KPiAyMDE4
KSkNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gICAgICAgICAgICAgICBpZiAoZG1pX2NoZWNrX3N5c3RlbShicmlkZ2Vf
ZDNfYmxhY2tsaXN0KSkNCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMjUuNA0KPiA+ID4gPiA+
DQo=
