Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E682752C0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIWIEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 04:04:02 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58506 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWIEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 04:04:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08N7hUjo017219;
        Wed, 23 Sep 2020 00:43:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=4Vm4xWYupmR4QS+uA/bRrQC9rvIXm1po4r/sca4sfZg=;
 b=E9e5NpCSDGpQKI/borBMHksof4/CbjHXK9IzDTUEsIbofFeU3bd6LTNr1t8VQ4PLkHfE
 7EBSizGo6vy1LrOGZKORSAjc2QBdww4tIW+2mkEz5bN29poURnh7gXg2typyN3lL9RwB
 SW+hbqJFgH1Mr/p/BIGbT8/Q72oIFXvUFyMCj8kTGrxJs2daMSjlh2sy4G254BJm0CE5
 oK+Q73+k5xYAw9QuuxpUPaWfgYrfhkjvC7LZLRAwKdfYLb6n8cVDzIpJ9/jKAPxd4kHl
 mnC0QKkutE7NJ0oGUnUxnWHwKQnoBtiidSmbqdcsLx565grjTU/HTO2cznd47WOng2rV lA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33nehxvutf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 00:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImIIEgphpYzj09ZN4JxnRx0qKN1WP8CkyXZt3hYR+Cq0CQvn44yaDAI1R/TVyg8VEH5XaphB0tP38kgEsiaQLJ4KukH5FkFuiJV4KpsHvIg6GC0VuY9kdTZmxh3UxttMomIENO+mUHBDcX75oxPVDx/oZTfcOWgsAhWSHuPJ4dbqjHh5jfJkUZ4GUe/Ut7hduP23wnc6MFb73ORLjc5MbfG9nUKdjsu+NTrOt4EplYSryESZi9bBwSqjIJMqRiyxkn4g9im6h0k3wxEoY4fRJcNR6xRRs2aMd8w/Mk5tnNSu92rya7YWJmZMPeG97sCeFYb1WSZv8CWVF0Gr4vafUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vm4xWYupmR4QS+uA/bRrQC9rvIXm1po4r/sca4sfZg=;
 b=OnUqi2E00Wc/LCSppmU6yC4CwH5wYuHWXpQRnFRKTEl1BX/piwiTJM4FwSEzC6/QjMzp50E7je7zpRCHMvpNI1IGu4wJWPjipssYc4xxywrj1GL7kfTFMrULkEaauC1XMmoGryMdQIWLGmemVukhOJKD4uSntlspnSW815RhmN3kbN4LCrBgLWURg8SbOhALpjy2acNSqKI7mWGHtOju2eyfV/of6XsjrPeBS0VRV3ugma2bUCSVA9uSUCXGfhXdKoxf5JaYOX+9LEsyBCyEShMlH+txJ1yjwwLy+4I//tJduqzl4IjNDvGUWwbSZ+ptuomMypPn6mD9TCdptT4J+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vm4xWYupmR4QS+uA/bRrQC9rvIXm1po4r/sca4sfZg=;
 b=6MnHmV182JpRiQRP8M2EW3J8uQ0rOk9aXeHXHRpyYSv5tHDu0TyaaAVWg3p6ek94+QV5+Oaqr8hJUbPUNSeVx54dvqbZAWmlRQoBCg/xSX/qtEuJMLENNA7C8hiVSo+FSvfETgbi8p5Bxlg9HlG9Dx1/zy4vF5HowgpZXvBB1oQ=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SN6PR07MB4351.namprd07.prod.outlook.com (2603:10b6:805:53::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 07:43:24 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::9506:77c:74e4:caf8%11]) with mapi id 15.20.3391.024; Wed, 23 Sep 2020
 07:43:24 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Topic: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
Thread-Index: AQHWjadRF1RM9N6Jak2UZqsZJXWh76l08uIAgADrsaA=
Date:   Wed, 23 Sep 2020 07:43:24 +0000
Message-ID: <SN2PR07MB2557EE82D65DF06B59F5010FD8380@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200918103429.4769-1-nadeem@cadence.com>
 <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
In-Reply-To: <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzNjZDgzYjktZmQ3MC0xMWVhLWFlOGMtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDczY2Q4M2JiLWZkNzAtMTFlYS1hZThjLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iNDA3NyIgdD0iMTMyNDUzMjA2MDE5NDEzOTAyIiBoPSJBdkd3RU03N0g0V1VjY3oxTG5tQUZxK0VqWEE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7b8d1cc-6991-4b51-eb39-08d85f945a31
x-ms-traffictypediagnostic: SN6PR07MB4351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR07MB43518E812617D95BBFE15518D8380@SN6PR07MB4351.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8nBtzLu0JGC3sRHDd60Iu9Xzvhn1vwYT18Tsc3h+cglRbmnA+PxFTW1mSNjwck6+AlHa8robeY4VwO+poDC25z4KVp06MngBHL0xj7O1wOhTutY1vZ7+YhCvGrVUr8lDEDAELs8Mf5i+5fpJ4dUFB5s/EtdYzhaUV3a9YixZwELkFfl+keGmeaHPyX4NVSvHQFYuwhxJkFipkrkM4qz5iC7wacY4SVX+F9UOhaHisX/FebAQy+Zy5l8HmXc1iPfvZyc01ghU6YHkvdPR94YThzhcF9bLy4DgLYMRtp3n9EuG+p1tsvecXQDkFa4KkIQFqKsSkiz7I8oCGmOzmWg+Y0Gg42RvY73IqtfRHBJzsc5tbsybZb4q7ViRYML/IWuLW04DJFZm9aznybMfWxaDt3wG151pi08FxUCFkuxTwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(36092001)(316002)(53546011)(6506007)(54906003)(55016002)(478600001)(9686003)(33656002)(86362001)(2906002)(6916009)(83380400001)(5660300002)(8676002)(66446008)(64756008)(66476007)(66946007)(186003)(26005)(8936002)(71200400001)(4326008)(66556008)(7696005)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: s13x/leUZ/eGy0bMuXAeumWdZ1TvNSMWuHUWp5dnCn1QU3w3Rf10p9qW/qC13KwZ8lTSfLX9WNGLpSxFGLwZYGuLtDLIBGeV6REQMXalG4l/fUm7Gpvs6oJHGiJ9vs9jmzk4E6QuvCtQfYSVJuiwGGJbzZmPrtt3kDfg9UihD4LmFjUEKisr5HFRwNeBZc2RydH+fySXZRZDzzXwKEpQMXi7i9QESclb2hxdYpL0i3CDmH19/yFya++6lRZu8am+dG3lGzxcjS7Lu68ddUAzVSNc3uZxd9gNyWHM/vgqmI3dsclqFil3q2VTz8fuhdPdOhyOBV/jR24l6vtOrs+uBcO3TrD1kCVz+Mnrb/YnvtjiPgwbTevDUY14AWNCmmG/TsOhH+TWA47B0Xk4d4kM0T6qZhKurLz/w/3aJjZ49ofwTr1qVZ904WcfwpMN5PZaT9qCe6Cj3uIDa7yRrQyHe20WQUMT0Wc2lSZITk/cKTk+12kZ10cS2ClNyKpA/4qaQ+FloxuaHJ/unDaHYYiSei+ay9Ep2T48sYSqEkMooA/s/WXEm+17uXEYsIr0+OOKh2EV2xAbq93Ykx9z9tw3np7neIs4wLncsfJYY4qL+BOAZdb1X/OH+FMA5z/VeimaX+3KL62ycX/mRMDcbUJzmw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b8d1cc-6991-4b51-eb39-08d85f945a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:43:24.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQYqFvLMWrXfY2P2EQlke8e8rqh2Isz+rzYyB1Tm+RgjkM+xhTEOtpzonpZ90iSHzd2AjdE+XNwM+/jYzvw1eqPBHiCZjfBO9TU6rZYcfYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_03:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230061
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIyLCAyMDIwIDExOjA4
IFBNDQo+IFRvOiBBdGhhbmkgTmFkZWVtIExhZGtoYW4gPG5hZGVlbUBjYWRlbmNlLmNvbT4NCj4g
Q2M6IFRvbSBKb3NlcGggPHRqb3NlcGhAY2FkZW5jZS5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0K
PiA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdv
b2dsZS5jb20+OyBQQ0kNCj4gPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBNaWxpbmQgUGFyYWINCj4gPG1wYXJhYkBjYWRlbmNlLmNvbT47
IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUNCj4gPHNqYWtoYWRlQGNhZGVuY2UuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IENhZGVuY2U6IEFkZCBxdWlyayBmb3IgR2VuMiBjb250
cm9sbGVyIHRvIGRvDQo+IGF1dG9ub21vdXMgc3BlZWQgY2hhbmdlLg0KPiANCj4gRVhURVJOQUwg
TUFJTA0KPiANCj4gDQo+IE9uIEZyaSwgU2VwIDE4LCAyMDIwIGF0IDQ6MzQgQU0gTmFkZWVtIEF0
aGFuaSA8bmFkZWVtQGNhZGVuY2UuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IENhZGVuY2UgY29u
dHJvbGxlciB3aWxsIG5vdCBpbml0aWF0ZSBhdXRvbm9tb3VzIHNwZWVkIGNoYW5nZSBpZg0KPiA+
IHN0cmFwcGVkIGFzIEdlbjIuIFRoZSBSZXRyYWluIGJpdCBpcyBzZXQgYXMgYSBxdWlyayB0byB0
cmlnZ2VyIHRoaXMNCj4gPiBzcGVlZCBjaGFuZ2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
YWRlZW0gQXRoYW5pIDxuYWRlZW1AY2FkZW5jZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jIHwgICAxMyArKysrKysr
KysrKysrDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2Uu
aCAgICAgIHwgICAgNiArKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiA+IGluZGV4IDQ1NTBlMGQu
LjRjYjdmMjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNl
L3BjaWUtY2FkZW5jZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2Nh
ZGVuY2UvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiA+IEBAIC04Myw2ICs4Myw4IEBAIHN0YXRpYyBp
bnQgY2Ruc19wY2llX2hvc3RfaW5pdF9yb290X3BvcnQoc3RydWN0DQo+IGNkbnNfcGNpZV9yYyAq
cmMpDQo+ID4gICAgICAgICBzdHJ1Y3QgY2Ruc19wY2llICpwY2llID0gJnJjLT5wY2llOw0KPiA+
ICAgICAgICAgdTMyIHZhbHVlLCBjdHJsOw0KPiA+ICAgICAgICAgdTMyIGlkOw0KPiA+ICsgICAg
ICAgdTMyIGxpbmtfY2FwID0gQ0ROU19QQ0lFX0xJTktfQ0FQX09GRlNFVDsNCj4gPiArICAgICAg
IHU4IHNscywgbG5rX2N0bDsNCj4gPg0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIFNl
dCB0aGUgcm9vdCBjb21wbGV4IEJBUiBjb25maWd1cmF0aW9uIHJlZ2lzdGVyOg0KPiA+IEBAIC0x
MTEsNiArMTEzLDE3IEBAIHN0YXRpYyBpbnQgY2Ruc19wY2llX2hvc3RfaW5pdF9yb290X3BvcnQo
c3RydWN0DQo+IGNkbnNfcGNpZV9yYyAqcmMpDQo+ID4gICAgICAgICBpZiAocmMtPmRldmljZV9p
ZCAhPSAweGZmZmYpDQo+ID4gICAgICAgICAgICAgICAgIGNkbnNfcGNpZV9ycF93cml0ZXcocGNp
ZSwgUENJX0RFVklDRV9JRCwNCj4gPiByYy0+ZGV2aWNlX2lkKTsNCj4gPg0KPiA+ICsgICAgICAg
LyogUXVpcmsgdG8gZW5hYmxlIGF1dG9ub21vdXMgc3BlZWQgY2hhbmdlIGZvciBHRU4yIGNvbnRy
b2xsZXIgKi8NCj4gPiArICAgICAgIC8qIFJlYWRpbmcgU3VwcG9ydGVkIExpbmsgU3BlZWQgdmFs
dWUgKi8NCj4gPiArICAgICAgIHNscyA9IFBDSV9FWFBfTE5LQ0FQX1NMUyAmDQo+ID4gKyAgICAg
ICAgICAgICAgIGNkbnNfcGNpZV9ycF9yZWFkYihwY2llLCBsaW5rX2NhcCArIFBDSV9FWFBfTE5L
Q0FQKTsNCj4gPiArICAgICAgIGlmIChzbHMgPT0gUENJX0VYUF9MTktDQVBfU0xTXzVfMEdCKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIC8qIFNpbmNlIHRoaXMgYSBHZW4yIGNvbnRyb2xsZXIsIHNl
dCBSZXRyYWluIExpbmsoUkwpIGJpdCAqLw0KPiA+ICsgICAgICAgICAgICAgICBsbmtfY3RsID0g
Y2Ruc19wY2llX3JwX3JlYWRiKHBjaWUsIGxpbmtfY2FwICsgUENJX0VYUF9MTktDVEwpOw0KPiA+
ICsgICAgICAgICAgICAgICBsbmtfY3RsIHw9IFBDSV9FWFBfTE5LQ1RMX1JMOw0KPiA+ICsgICAg
ICAgICAgICAgICBjZG5zX3BjaWVfcnBfd3JpdGViKHBjaWUsIGxpbmtfY2FwICsgUENJX0VYUF9M
TktDVEwsDQo+ID4gKyBsbmtfY3RsKTsNCj4gDQo+IFdoeSB0aGUgYnl0ZSBhY2Nlc3Nlcz8gVGhp
cyBpcyBhIDE2LWJpdCByZWdpc3Rlci4NCj4gVGhpcyBpcyBhIDMyYml0IHJlZ2lzdGVyLiBCdXQg
dGhlIHJlZ2lzdGVyIGZpZWxkIHJlcXVpcmUgaXMgYXQgZmlyc3QgYnl0ZSBvbmx5LiBIZW5jZSB0
aGUgYnl0ZSBhY2Nlc3MuDQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgY2Ruc19w
Y2llX3JwX3dyaXRlYihwY2llLCBQQ0lfQ0xBU1NfUkVWSVNJT04sIDApOw0KPiA+ICAgICAgICAg
Y2Ruc19wY2llX3JwX3dyaXRlYihwY2llLCBQQ0lfQ0xBU1NfUFJPRywgMCk7DQo+ID4gICAgICAg
ICBjZG5zX3BjaWVfcnBfd3JpdGV3KHBjaWUsIFBDSV9DTEFTU19ERVZJQ0UsDQo+ID4gUENJX0NM
QVNTX0JSSURHRV9QQ0kpOyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2NhZGVuY2UvcGNpZS1jYWRlbmNlLmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2Fk
ZW5jZS9wY2llLWNhZGVuY2UuaA0KPiA+IGluZGV4IGZlZWQxZTMuLjA3NWMyNjMgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5oDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5oDQo+
ID4gQEAgLTEyMCw2ICsxMjAsNyBAQA0KPiA+ICAgKi8NCj4gPiAgI2RlZmluZSBDRE5TX1BDSUVf
UlBfQkFTRSAgICAgIDB4MDAyMDAwMDANCj4gPg0KPiA+ICsjZGVmaW5lIENETlNfUENJRV9MSU5L
X0NBUF9PRkZTRVQgMHhDMA0KPiA+DQo+ID4gIC8qDQo+ID4gICAqIEFkZHJlc3MgVHJhbnNsYXRp
b24gUmVnaXN0ZXJzDQo+ID4gQEAgLTQxMyw2ICs0MTQsMTEgQEAgc3RhdGljIGlubGluZSB2b2lk
IGNkbnNfcGNpZV9ycF93cml0ZXcoc3RydWN0DQo+IGNkbnNfcGNpZSAqcGNpZSwNCj4gPiAgICAg
ICAgIGNkbnNfcGNpZV93cml0ZV9zeihhZGRyLCAweDIsIHZhbHVlKTsgIH0NCj4gPg0KPiA+ICtz
dGF0aWMgaW5saW5lIHU4IGNkbnNfcGNpZV9ycF9yZWFkYihzdHJ1Y3QgY2Ruc19wY2llICpwY2ll
LCB1MzIgcmVnKQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1cm4gcmVhZGIocGNpZS0+cmVnX2Jh
c2UgKyBDRE5TX1BDSUVfUlBfQkFTRSArIHJlZyk7IH0NCj4gPiArDQo+ID4gIC8qIEVuZHBvaW50
IEZ1bmN0aW9uIHJlZ2lzdGVyIGFjY2VzcyAqLyAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4gY2Ru
c19wY2llX2VwX2ZuX3dyaXRlYihzdHJ1Y3QgY2Ruc19wY2llICpwY2llLCB1OCBmbiwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgcmVnLCB1OCB2YWx1
ZSkNCj4gPiAtLQ0KPiA+IDEuNy4xDQo+ID4NCg==
