Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5354811CF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 11:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbhL2K7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 05:59:02 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:41009 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbhL2K7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 05:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1640775541; x=1641380341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5C+hPju6ThpFjxeXlrMzyaHLFCt1TmaNJCcMWcjud3Q=;
  b=HLIBN2FuYiprRYVSeOBuwl/zxmWpah3XdSBGJdg5Gaq9XPUcW/34r30C
   IN/Iz3gSHEOMYOLHFvHBhj5SRkkIOWBaaUmlG9hs1ril66cy83IUyUUNr
   dEaz9g/Aj3/VDjQDipwVY+WuHPtZkmxIhVy57B6pMCi7eBRzfl4o/O44A
   s=;
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 10:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD4n6wp78Cj2epTkPXSgJqAT9qijvfhUqCrkIRDZ43YO75PdR5oyH4YGnlXzXAIUL5frSpL41b64yEanSJFSNv+5x81isF3Gz54kYK86NpBtdtJCiGiKGp8sO4DUjrXG48OnBAwSQzbDx1dbl93+H45NCh/cNfgZe/qinMxhjLq98gApzG1zWP5Qm5RsEDUC8Jv9V3lUNvIjeCoAY1JFfOy41iO7sr1rRm5rTqVi9FEbcI+Y7kewnSi8sy0fT2i9xcCPD0b3zinfLEg/Fv0+sAM6agrP9kzPO2nFIiHJircxrC8MXQv14ky614+dV0qi7evDAMLaa5c9PW6AOSeWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C+hPju6ThpFjxeXlrMzyaHLFCt1TmaNJCcMWcjud3Q=;
 b=hEAJt+LXt2hRotObn8ygFRxWRDbWWWAqtGBg6IMnfN1o9QZsJHX6MjR8D4CKK9n4k510W3cAhZ+YQdlnMFzDP0c0Jw9JCJ6aUdMeP5BU4eqAyQqGeGBkwjzaoKYt3wn3fNTT2PjQHCZie5komRQLq19IyRygOl03dc3OqfCzdWNUvJGb7HptD2BgdLZi7YgEwDce0+y7+089+Td1AqRkwJu9SKzrEdncf71QFLbCejttu7PKGXypAqk3vxiPAfudH/v62RhLEIuy7os3b5FWZfakHlDoJhr4OPcw+PEGvB3EuyPFET9MatZdA2h0Pcw7HGQqq7qHAgQ+mRotes3R8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8537.namprd02.prod.outlook.com (2603:10b6:303:158::14)
 by MWHPR02MB2336.namprd02.prod.outlook.com (2603:10b6:300:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 29 Dec
 2021 10:58:44 +0000
Received: from CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::d15b:2e22:671d:feeb]) by CO1PR02MB8537.namprd02.prod.outlook.com
 ([fe80::d15b:2e22:671d:feeb%5]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 10:58:43 +0000
From:   "Prasad Malisetty (Temp)" <pmaliset@qti.qualcomm.com>
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        Prasad Malisetty <quic_c_pmaliset@quicinc.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        quic_vbadigan <quic_vbadigan@quicinc.com>,
        "Rama Krishna (QUIC)" <quic_ramkri@quicinc.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        quic_pmaliset <quic_pmaliset@quicinc.com>,
        quic_skananth <quic_skananth@quicinc.com>
Subject: RE: [PATCH v1] PCI: qcom: Add system PM support
Thread-Topic: [PATCH v1] PCI: qcom: Add system PM support
Thread-Index: AQHX904c0XuY6eged0i782rFmyvrfqxAMNMAgAkeqZA=
Date:   Wed, 29 Dec 2021 10:58:43 +0000
Message-ID: <CO1PR02MB85374269B7CA824BA4AC27ACE9449@CO1PR02MB8537.namprd02.prod.outlook.com>
References: <1640189262-9699-1-git-send-email-quic_c_pmaliset@quicinc.com>
 <CAA8EJpoq1xPj3nkZfjjviCQdLq-LcMVThTK6HzrW7AdmfebuhA@mail.gmail.com>
In-Reply-To: <CAA8EJpoq1xPj3nkZfjjviCQdLq-LcMVThTK6HzrW7AdmfebuhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ced28d-a324-46b2-279c-08d9caba2e55
x-ms-traffictypediagnostic: MWHPR02MB2336:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB23366C6C2C89C7F5510C0316E9449@MWHPR02MB2336.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUAWzicZBtE5SkfDtGstFJO5QrnRAvmzm0U3fmVJQBFCMWyR5+lJYkaZU7L19c7705hX1XTZRrep5uPbo4MPwwSuPv/IkGZvbTsb0EU5evOcPWqos+lnfW7MqFu/zxxoNMRZPX9T7aeFtLnezpYlZTIYkmyHbBhFa/jtsLq00zikfvETpguY+b9BmHNn5xxueCYroVoTgYPXo5FMrYZAAltdfCLGfDuk3Umve/4YmtV4awm1m7+lEOgJQbpEBZ4LTusfjUQvbGCteCpbo/M3lSgDsPltoQN7TsAdND+7Vj9TsMdT4KleAtk0f6EHg7+VOx1PC1qVqwaoulPibMBjWI6ZuVIb36D8jAtJWYcmuVIGpYRMyYv0TF/4tRc3gVLaSHJcdTMPKD5EQJEKP9qFI6ClNT6Z5VT6j32PQEG33gAEgM222DoFRgmuaqD1KWv1ys5p30oUUiO5zoI/W8d+ih3aiTwOipZfCbs5CnCWOyJhXgq8J+hdDu87gDZxAcEamKoeYM7KXZhSMPnKIoIcqgOUc8H91k5qM36fBZakVDOicMS9uVQm9ceteXmlMuRxuh+1ZeyjIXDZAGpLymzvA7b5vGz9VfbpZAp4BAyTO+XObYWgoUN+/dqM4j4U0dzL5seWx9/PvVAdrennmY8bnNGV9B6/F51u3DVIcjMjPtfbWvKVWX2CdIn3Ps+QhGmbv3AoIQhUBDdl1PrdE51vaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8537.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(66476007)(83380400001)(66446008)(107886003)(7696005)(71200400001)(53546011)(66946007)(33656002)(7416002)(508600001)(6506007)(38100700002)(122000001)(186003)(2906002)(38070700005)(5660300002)(110136005)(86362001)(66556008)(64756008)(8936002)(8676002)(316002)(9686003)(76116006)(55016003)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3cwNGxlSkRsd1ZCd0RWSXNCZHc5MkQ3VWRkMHpnb1BJUzVvWGQrSVFGdmxY?=
 =?utf-8?B?RE9uQ1FkaTlVSnIxek8wcWtvY2FyaW9ENkM0eXFBNDlYeFhNSlRTTjJ3Ry9y?=
 =?utf-8?B?bktwSm9mMER5c2RWemxMSXFqaXRwc3lQdXRZaGJsZ3N1SEo4U1ZaMng3N01I?=
 =?utf-8?B?dFJOZitncXlxaXpyazJFY0lGaGJVQ28walIzc0x3Sk8yV2lzYk9hVm95VSsr?=
 =?utf-8?B?eU5XOFRMZjhodklDUEVCQzFDeS9uTDJCdXhCV0ZRTzJwVHdCTGZORkRXRWZE?=
 =?utf-8?B?VmVJdzJNNFIrTStrQ2VycWttUkFIYVlyQ2tGN1JWZTdueHhwMWVCdHVrRHZ0?=
 =?utf-8?B?dzBKWG1wUXBIVGw2VXpTVEtUaUJEQjB4U05yU2tEU0cyU3ZtTXp3TmdhT2hv?=
 =?utf-8?B?S3RiakRhM1JEWUR6NGRTZHRNYlgzRG16M1BoSDVXRmNNYko1TkQ0SzF3MXds?=
 =?utf-8?B?cGIyT2NDL05UR2lWcVBNZlNwdkY3blNVWHp4Sko2cldMQ2g5SVY0U3lQM3Yr?=
 =?utf-8?B?Q3lNazFMRUI5VXBxRnFZZXVmMGZCcEdPWnU2NEJ5UVFBV1MvbnEwcXJKZzly?=
 =?utf-8?B?RkFhWElxdUM2MUNxTHF3dVo0dUVFRUdJMlh5VUZ5YVFkd0hwc29TdkNSbks1?=
 =?utf-8?B?YWhUSlBGeldlMUJ1T2piV2R4ZlJzbmNHTEEyNkNvNXVEdDNjc3lkUmFWK2U3?=
 =?utf-8?B?YVFrRVJUVlZvWW1OeUliN2ZDTlRlZEJCbnIxNis2bWcwZ09QMTVKejJwTHhp?=
 =?utf-8?B?TDJGb0NhelhUMUhrYVFVTXZPRjNhU3NYdUVIQnZpeWVFY3FzbmdNNFN2bXFp?=
 =?utf-8?B?OTJ4ZWtFdW5IVTF5THJQRWMyaVV3V2QrODFTZXVUaGZLMU16aGZhbmhlWnNx?=
 =?utf-8?B?cFdEeFNIamwyamxwTVdiNWlWbEZ2Uk05WkszeU5ueTVXTFB5Tlh4a0M5ZTFX?=
 =?utf-8?B?Y2JvOVFKL0JYdVU1TmFoVU5iTGU0b05VVTMwVkpOWlZnM0RjVzlER1RCRVd6?=
 =?utf-8?B?Sk5iNS9LeVVHd1krek1wWGRYelF0dTNseVRLKzdFaGVVKzQvbEVhdCsxZ3Na?=
 =?utf-8?B?OG8zMHBZRDVSSzgwVXVsODl3djZZQTZyVncyRzJZU0VZSEJVYlcrelBYa1Zw?=
 =?utf-8?B?K2lNbnM0bllRVDBHb29DSTZMTHR5ZXYzVFZPTVpneGZsWE1SVjd6QVdUNmM3?=
 =?utf-8?B?WWEzMlJ5NzhIL2pKZU5kREdrbG5ubGIrVElFWVFZRkM2MFNxMStRRWtHMGMy?=
 =?utf-8?B?d3lwRXJ1U3R3cllUd1FRNmlTM2I3bzdxT2pVTGMxQUtUN1hhbEx4eGx0d0tK?=
 =?utf-8?B?TUFEdHY1SWRvZWxRMjUrZTJPby9Zd1piaDVJakgzM2Z6NEFkRW4rOGZyZHo4?=
 =?utf-8?B?Sm8zbWpncGxzTGJ0TEFZdmhoRmZhejVURGR0ZDg4aXRuY1dPSHdUMzhxcFVI?=
 =?utf-8?B?N1IxTkVOdG44NHlEb3ZSbTgzNDV4dVQ1ZXBDR05uVDJUcnltVU1YQklXY2Fj?=
 =?utf-8?B?MHlGbFp1V1dzZ3lHclc3UEM4eWtkeHN0ZUdxWEVFR1hnYXJ3cFd1b1dVazFT?=
 =?utf-8?B?N2xqQ1RmdUtHSTB4eEFJdXNiZDBjVWhkUGRqTC82ZG5ORjZQZjBhc3c5eW1R?=
 =?utf-8?B?ZUhWaVNpM05ITnlHeHVxQ1NCZWVnSXczcjlRRHp4dUpRRUdqT0JndmNLRm9R?=
 =?utf-8?B?Sngva2hrcm9GMHVoS21ZMFZHMGJwUE9mRHYzaHdsNm5NVDlIajUzbnMrN0lJ?=
 =?utf-8?B?ekU3KzV2UGx0SnlEbXBlcjFVSU1XNDVkSERUeDk5MUxiaW0xOTBXWHFhMW5C?=
 =?utf-8?B?T0NsVzN1bURvVnU5SnE2NGJoVnJEcWU2cm0zb2RweXltbzBxOUthSWZoOWZB?=
 =?utf-8?B?TlJGd1lPQnVPNFBUMzc3dnFXZGh0bTY3STFPdm1Wb3A3enE2VjFEVWROckZK?=
 =?utf-8?B?c0gzTHdEd0J0SnQxMG5oZktHVytnRmNYSEJFYzcxaG41eERiVkcxcXA1TVRO?=
 =?utf-8?B?MjRJRktBcUxQMkh6UGl2ZWZBZ0RYWVhWcUtFdmhJcnF0YTM2LytpaENuajMy?=
 =?utf-8?B?elhreDBpcU5QOWhWbzNqQnVHbmVaMnU5b0RSdGdMajgrNnhycElram5nSjdj?=
 =?utf-8?B?eWVHKzlhMWF5aWUxdVQxeW9FNjFtL3FmSHg2dmllam5XSCtEdlZRNlFmdlIy?=
 =?utf-8?B?ckVjSW9xQmx3UFFpbVBjMkRDdXkzSWpwM056WU80bkNWeTd5NnF4Y1JoaEVs?=
 =?utf-8?B?ampvTEQ1Z0E1Y2NmQlVyWmVwL3NNS2xTdEhnWWc0Qmh4Y0MzSmRsamxFMnhM?=
 =?utf-8?B?cWlFdnNHQlRtTGZDa0NnMlE3em9iNkNKZTdyUG1zc2t5SUJJZkxWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8537.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ced28d-a324-46b2-279c-08d9caba2e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 10:58:43.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DaPBGu5nBa3PxL3iWYgEMB2fcHth3lQgkKzPxUHizAD109b75EIqhNtu0KJAGP50ZzN5T4mAtYcVBtjzw5+H0cKMWTvfFvK0M+pIQRCWbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2336
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIGNvbW1lbnRzLiANCg0KUGxl
YXNlIGZpbmQgdGhlIHJlc3BvbnNlIGlubGluZS4NCg0KVGhhbmtzDQotUHJhc2FkIA0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRG1pdHJ5IEJhcnlzaGtvdiA8ZG1pdHJ5LmJh
cnlzaGtvdkBsaW5hcm8ub3JnPiANClNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyMywgMjAyMSA4
OjQ0IFBNDQpUbzogUHJhc2FkIE1hbGlzZXR0eSA8cXVpY19jX3BtYWxpc2V0QHF1aWNpbmMuY29t
Pg0KQ2M6IGFncm9zc0BrZXJuZWwub3JnOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207IGJo
ZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1t
c21Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBxdWljX3Zi
YWRpZ2FuIDxxdWljX3ZiYWRpZ2FuQHF1aWNpbmMuY29tPjsgUmFtYSBLcmlzaG5hIChRVUlDKSA8
cXVpY19yYW1rcmlAcXVpY2luYy5jb20+OyBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9y
Zzsgc3dib3lkQGNocm9taXVtLm9yZzsgcXVpY19wbWFsaXNldCA8cXVpY19wbWFsaXNldEBxdWlj
aW5jLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIFBDSTogcWNvbTogQWRkIHN5c3RlbSBQ
TSBzdXBwb3J0DQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywg
YW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KDQpPbiBXZWQsIDIyIERlYyAyMDIxIGF0IDE5OjA4
LCBQcmFzYWQgTWFsaXNldHR5IDxxdWljX2NfcG1hbGlzZXRAcXVpY2luYy5jb20+IHdyb3RlOg0K
Pg0KPiBGcm9tOiBQcmFzYWQgTWFsaXNldHR5IDxxdWljX3BtYWxpc2V0QHF1aWNpbmMuY29tPg0K
Pg0KPiBBZGQgc3VzcGVuZF9ub2lycSBhbmQgcmVzdW1lX25vaXJxIGNhbGxiYWNrcyB0byBoYW5k
bGUgU3lzdGVtIHN1c3BlbmQgDQo+IGFuZCByZXN1bWUgaW4gZHdjIHBjaWUgY29udHJvbGxlciBk
cml2ZXIuDQo+DQo+IFdoZW4gc3lzdGVtIHN1c3BlbmRzLCBzZW5kIFBNRSB0dXJub2ZmIG1lc3Nh
Z2UgdG8gZW50ZXIgbGluayBpbnRvIEwyIA0KPiBzdGF0ZS4gQWxvbmcgd2l0aCBwb3dlcmRvd24g
dGhlIFBIWSwgZGlzYWJsZSBwaXBlIGNsb2NrLCBzd2l0Y2ggDQo+IGdjY19wY2llXzFfcGlwZV9j
bGtfc3JjIHRvIFhPIGlmIG11eCBpcyBzdXBwb3J0ZWQgYW5kIGRpc2FibGUgdGhlIHBjaWUgDQo+
IGNsb2NrcywgcmVndWxhdG9ycy4NCg0KVGhlIEdEU0Mgc3RheXMgb24sIGlmIEknbSBub3QgbWlz
dGFrZW4uIElzIHRoaXMgYW4gZXhwZWN0ZWQgYmVoYXZpb3VyIGZvciB0aGUgc3VzcGVuZCBwcm9j
ZWR1cmU/DQoNCj4+IE5vLCBHRFNDIHdpbGwgYmUgZGlzYWJsZWQgYXMgcGFydCBvZiBzeXN0ZW0g
c3VzcGVuZC4gV2UgYXJlIHN3aXRjaGluZyBnY2NfcGNpZV8xX2Nsa19zcmMgdG8gWE8gYXMgR0RT
QyBzaG91bGQgYmUgZW5hYmxlIGluIHJlc3VtZSBwYXRoLg0KDQpBbHNvIGFzIGEgc2lkZSBub3Rl
LCB0aGUgcWNvbS1wY2llIGRyaXZlciBzdXBwb3J0cyBhIHZhcmlldHkgb2YgU29DcyBmcm9tIGRp
ZmZlcmVudCBnZW5lcmF0aW9ucy4gV2hpY2ggcGxhdGZvcm1zIHdlcmUgcmVhbGx5IHRlc3RlZD8N
Ckp1ZGdpbmcgZnJvbSB5b3VyIHBhdGNoIEkgc3VwcG9zZSB0aGF0IHlvdSBkaWQgbm90IHRlc3Qg
dGhpcyBvbiBhbnkgbm9uLXJlY2VudCBwbGF0Zm9ybS4NCg0KPj4gV2UgaGF2ZSB0ZXN0ZWQgb24g
U0M3MjgwIFNvQyB3aGljaCBpcyByZWNlbnRseSBhZGRlZC4NCg0KPiBXaGVuIHN5c3RlbSByZXN1
bWVzLCBQQ0llIGxpbmsgd2lsbCBiZSByZS1lc3RhYmxpc2hlZCBhbmQgc2V0dXAgcmMgDQo+IHNl
dHRpbmdzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzYWQgTWFsaXNldHR5IDxxdWljX3BtYWxp
c2V0QHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtcWNvbS5jIHwgMTAzIA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMgDQo+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1xY29tLmMNCj4gaW5kZXggYzE5Y2Q1MDYuLjI0ZGNmNWEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+IEBAIC03Myw2ICs3Myw4
IEBADQo+DQo+ICAjZGVmaW5lIFBDSUUyMF9QQVJGX1EyQV9GTFVTSCAgICAgICAgICAgICAgICAg
IDB4MUFDDQo+DQo+ICsjZGVmaW5lIFBDSUUyMF9QQVJGX1BNX1NUVFMgICAgICAgICAgICAgICAg
ICAgICAweDI0DQo+ICsNCj4gICNkZWZpbmUgUENJRTIwX01JU0NfQ09OVFJPTF8xX1JFRyAgICAg
ICAgICAgICAgMHg4QkMNCj4gICNkZWZpbmUgREJJX1JPX1dSX0VOICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMQ0KPg0KPiBAQCAtMTYxNiw2ICsxNjE4LDEwNyBAQCBzdGF0aWMgaW50IHFjb21f
cGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIHJldHVy
biByZXQ7DQo+ICB9DQo+DQo+ICtzdGF0aWMgaW50IHFjb21fcGNpZV9zZW5kX3BtZV90dXJub2Zm
X21zZyhzdHJ1Y3QgcWNvbV9wY2llICpwY2llKSB7DQo+ICsgICAgICAgaW50IHJldCA9IDA7DQo+
ICsgICAgICAgdTMyIHZhbCA9IDAsIHBvbGxfdmFsID0gMDsNCj4gKyAgICAgICB1aW50NjRfdCBs
MjNfcmR5X3BvbGxfdGltZW91dCA9IDEwMDAwMDsNCj4gKyAgICAgICBzdHJ1Y3QgZHdfcGNpZSAq
cGNpID0gcGNpZS0+cGNpOw0KPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2
Ow0KPiArDQo+ICsgICAgICAgdmFsID0gcmVhZGwocGNpZS0+ZWxiaSArIFBDSUUyMF9FTEJJX1NZ
U19DVFJMKTsNCj4gKyAgICAgICB2YWwgfD0gQklUKDQpOw0KPiArICAgICAgIHdyaXRlbCh2YWws
IHBjaWUtPmVsYmkgKyBQQ0lFMjBfRUxCSV9TWVNfQ1RSTCk7DQo+ICsNCj4gKyAgICAgICByZXQg
PSByZWFkbF9wb2xsX3RpbWVvdXQoKHBjaWUtPnBhcmYgKyBQQ0lFMjBfUEFSRl9QTV9TVFRTKSwg
cG9sbF92YWwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIChwb2xsX3ZhbCAmIEJJVCg1KSks
IDEwMDAwLCBsMjNfcmR5X3BvbGxfdGltZW91dCk7DQo+ICsgICAgICAgaWYgKCFyZXQpDQo+ICsg
ICAgICAgICAgICAgICBkZXZfZGJnKGRldiwgIlBDSWU6IFBNX0VudGVyX0wyMyBpcyByZWNlaXZl
ZFxuIik7DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJQ
TV9FbnRlcl9MMjMgaXMgTk9UIHJlY2VpdmVkLlBBUkZfUE1fU1RUUyAweCV4XG4iLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICByZWFkbF9yZWxheGVkKHBjaWUtPnBhcmYgKyANCj4gKyBQQ0lF
MjBfUEFSRl9QTV9TVFRTKSk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgdm9pZCBxY29tX3BjaWVfaG9zdF9kaXNhYmxlKHN0cnVjdCBxY29tX3BjaWUg
KnBjaWUpIHsNCj4gKyAgICAgICBzdHJ1Y3QgcWNvbV9wY2llX3Jlc291cmNlc18yXzdfMCAqcmVz
ID0gJnBjaWUtPnJlcy52Ml83XzA7DQo+ICsNCj4gKyAgICAgICAvKkFzc2VydCB0aGUgcmVzZXQg
b2YgZW5kcG9pbnQgKi8NCj4gKyAgICAgICBxY29tX2VwX3Jlc2V0X2Fzc2VydChwY2llKTsNCj4g
Kw0KPiArICAgICAgIC8qIFB1dCBQSFkgaW50byBQT1dFUiBET1dOIHN0YXRlICovDQo+ICsgICAg
ICAgcGh5X3Bvd2VyX29mZihwY2llLT5waHkpOw0KPiArDQo+ICsgICAgICAgd3JpdGVsKDEsIHBj
aWUtPnBhcmYgKyBQQ0lFMjBfUEFSRl9QSFlfQ1RSTCk7DQo+ICsNCj4gKyAgICAgICAvKiBEaXNh
YmxlIHBpcGUgY2xvY2sgKi8NCj4gKyAgICAgICBwY2llLT5vcHMtPnBvc3RfZGVpbml0KHBjaWUp
Ow0KPiArDQo+ICsgICAgICAgLyogQ2hhbmdlIEdDQ19QQ0lFXzFfUElQRV9NVVhSIHJlZ2lzdGVy
IHRvIDB4MiBmb3IgWE8gYXMgcGFyZW50ICovDQo+ICsgICAgICAgaWYgKHBjaWUtPnBpcGVfY2xr
X25lZWRfbXV4aW5nKQ0KPiArICAgICAgICAgICAgICAgY2xrX3NldF9wYXJlbnQocmVzLT5waXBl
X2Nsa19zcmMsIHJlcy0+cmVmX2Nsa19zcmMpOw0KPiArDQo+ICsgICAgICAgLyogRGlzYWJsZSBQ
Q0llIGNsb2NrcyBhbmQgcmVndWxhdG9ycyovDQo+ICsgICAgICAgcGNpZS0+b3BzLT5kZWluaXQo
cGNpZSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgcWNvbV9wY2ll
X3BtX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZSANCj4gKypkZXYpIHsNCj4gKyAgICAgICBp
bnQgcmV0ID0gMDsNCj4gKyAgICAgICBzdHJ1Y3QgcWNvbV9wY2llICpwY2llID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ICsgICAgICAgc3RydWN0IGR3X3BjaWUgKnBjaSA9IHBjaWUtPnBjaTsN
Cj4gKw0KPiArICAgICAgIGlmICghZHdfcGNpZV9saW5rX3VwKHBjaSkpIHsNCj4gKyAgICAgICAg
ICAgICAgIGRldl9lcnIoZGV2LCAiUG93ZXIgaGFzIGJlZW4gdHVybmVkIG9mZiBhbHJlYWR5XG4i
KTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsg
ICAgICAgLyogU2VuZCBQTUUgdHVybm9mZiBtc2cgKi8NCj4gKyAgICAgICByZXQgPSBxY29tX3Bj
aWVfc2VuZF9wbWVfdHVybm9mZl9tc2cocGNpZSk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAg
ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gKyAgICAgICAvKiBQb3dlciBkb3duIHRo
ZSBQSFksIGRpc2FibGUgY2xvY2sgYW5kIHJlZ3VsYXRvcnMgKi8NCj4gKyAgICAgICBxY29tX3Bj
aWVfaG9zdF9kaXNhYmxlKHBjaWUpOw0KPiArDQo+ICsgICAgICAgZGV2X2luZm8oZGV2LCAiUE06
IFBDSSBpcyBzdXNwZW5kZWRcbiIpOw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsN
Cj4gKy8qIFJlc3VtZSB0aGUgUENJZSBsaW5rICovDQo+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIHFjb21fcGNpZV9wbV9yZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSANCj4gKypkZXYpIHsN
Cj4gKyAgICAgICBpbnQgcmV0ID0gMDsNCj4gKyAgICAgICBzdHJ1Y3QgcWNvbV9wY2llICpwY2ll
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsgICAgICAgc3RydWN0IGR3X3BjaWUgKnBjaSA9
IHBjaWUtPnBjaTsNCj4gKyAgICAgICBzdHJ1Y3QgcGNpZV9wb3J0ICpwcCA9ICZwY2ktPnBwOw0K
PiArDQo+ICsgICAgICAgZGV2X2luZm8oZGV2LCAiUE06IFJlc3VtaW5nXG4iKTsNCj4gKw0KPiAr
ICAgICAgIC8qIEluaXRpYWxpemUgUENJZSBob3N0ICovDQo+ICsgICAgICAgcmV0ID0gcWNvbV9w
Y2llX2hvc3RfaW5pdChwcCk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAg
IGRldl9lcnIoZGV2LCAiY2Fubm90IGluaXRpYWxpemUgaG9zdFxuIik7DQo+ICsNCj4gKyAgICAg
ICBkd19wY2llX2lhdHVfZGV0ZWN0KHBjaSk7DQo+ICsgICAgICAgZHdfcGNpZV9zZXR1cF9yYyhw
cCk7DQo+ICsNCj4gKyAgICAgICAvKiBTdGFydCB0aGUgUENJZSBsaW5rICovDQo+ICsgICAgICAg
cWNvbV9wY2llX3N0YXJ0X2xpbmsocGNpKTsNCj4gKw0KPiArICAgICAgIHJldCA9IGR3X3BjaWVf
d2FpdF9mb3JfbGluayhwY2kpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAg
ICBkZXZfZXJyKGRldiwgIkxpbmsgbmV2ZXIgY2FtZSB1cCwgUmVzdW1lIGZhaWxlZFxuIik7DQo+
ICsNCj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGRldl9wbV9vcHMgcWNvbV9wY2llX3BtX29wcyA9IHsNCj4gKyAgICAgICBTRVRfTk9JUlFf
U1lTVEVNX1NMRUVQX1BNX09QUyhxY29tX3BjaWVfcG1fc3VzcGVuZF9ub2lycSwgDQo+ICtxY29t
X3BjaWVfcG1fcmVzdW1lX25vaXJxKSB9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBxY29tX3BjaWVfbWF0Y2hbXSA9IHsNCj4gICAgICAgICB7IC5jb21wYXRpYmxl
ID0gInFjb20scGNpZS1hcHE4MDg0IiwgLmRhdGEgPSAmYXBxODA4NF9jZmcgfSwNCj4gICAgICAg
ICB7IC5jb21wYXRpYmxlID0gInFjb20scGNpZS1pcHE4MDY0IiwgLmRhdGEgPSAmaXBxODA2NF9j
ZmcgfSwNCj4gLS0NCj4gUVVBTENPTU0gSU5ESUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5v
dmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIA0KPiBtZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0s
IGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbg0KPg0KDQoNCi0tDQpXaXRoIGJlc3Qgd2lz
aGVzDQpEbWl0cnkNCg==
