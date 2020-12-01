Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2609B2CA6CC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbgLAPQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 10:16:55 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54470 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389082AbgLAPQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 10:16:55 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B1FCI8G013116;
        Tue, 1 Dec 2020 07:15:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Y1NeWdMyaXNAgZNfMF9+QaPDoc4RZl40/OlQK0sNZMw=;
 b=B57blHZTRugsGtYwR/WSk72fV5UnbzsxkyQNSDvwu4SkyHoifAc/NZEGJi8woT5a/Kv5
 vcDItN0aJrl5nJmK54r/eia+sFHuc4NwvpfAjQ4T2F8cqOqQdFKSdAbLzAE1horDAUK2
 8e2zSAaAykTr/wi08VBpaODWXOwrCq3WkqAIBAAEVjlVN9iV1xQxBtvsAHekDzlpJ4KA
 zHJbYav065tNEdisTSpzONcHQlTCfTlCtUqkOftdDuo1vbdrKe7Fwrw4xz9tCU97U0zQ
 QWPbT7FsCpRqNsPQ+FPHLPP/DQ7vHoDGrIgvoUm3670G3s8X7mApwuiHJ6ZRm0mfh2pf Lg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m031ycu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 07:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lwzi+CtQpW5RtPILdxK43ovU74IT0xfha2JS9cYlJqMHN6nfT1P6FtVGJtHBb7CBayWfW3STFLDYOOcdmZjYBCrz+ypn60tpE0O/xO4y3CMrjchG244IvtipVJtJcEacg7HnZsEEzq85LB8Ki4PPbzfAln8XAiQSnCn7M8Tf92v9oBOdMr3qsSQDL/1gIM2E371Iw3Idedd7jn88kPeeRu81RP9rjYZ8fHZy4Rjfd1vc4hbP8yjWJ6B7A0t/OrpC7U/DQPZ00HV/4aHPIGJI2imlbrGKO70em96VZYmMqG0yZyuH+xf+mcCunL7CwosTJx2YBARQrBc+6/YuHDSzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1NeWdMyaXNAgZNfMF9+QaPDoc4RZl40/OlQK0sNZMw=;
 b=RW/wNcUEcbD4iizESb3LDsCW5G6v3zzYXEsFyjQjSgWu+SYXijOjMNbZDJxulQ4J58WQdnarE78Wfs/+rLYqDRxPwkmt4rDDujNolEFw8lNJkHDYKmZIBNaffCwSMVHEMjhyKXZ4V3unB+Y1kS02NdZthk/tBr5n2zoQPhZF7Ai10DWaaX4PF7Tn2zSG+ARQqRo44mDsvne84mkwXM2KHcNYGd41N+I/fAskU7rbKkOUBZ22ibH8Ry1S8RnMCJzC1JWnUCrWfKPBwYF3cRlR7kCyl2kTOdr8TKsylcG9SNfxzwODC6bW2vPTyb1Xx9WczD9+EK9wQM6Xq5Had5jcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1NeWdMyaXNAgZNfMF9+QaPDoc4RZl40/OlQK0sNZMw=;
 b=CcnoxCKrdiWAtJ/dQW+pxYVBwH+FfMCdzeEhTBfC2HudVB5UXxe7xJGuirgNsUB1e0kEDQbV0y6oKdqqAp0P4gUyeI0TaAwLzQ6l68j/HQOy921p0u5aG7C0k8A3JstEED0r0U7XVE+XmFYALqMfLCrjLv8aE62e3/M3Kb4nppU=
Received: from SN2PR07MB2557.namprd07.prod.outlook.com (2603:10b6:804:12::9)
 by SA0PR07MB7644.namprd07.prod.outlook.com (2603:10b6:806:b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 15:15:42 +0000
Received: from SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a]) by SN2PR07MB2557.namprd07.prod.outlook.com
 ([fe80::e164:6aec:aed1:1e2a%8]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 15:15:41 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Thread-Topic: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
Thread-Index: AQHWl1Z6N6ovEDY5sUuQSkxKtmQChqmegrmAgADESICABZ2xAIAFhtYAgDBeM4CAB/CEwA==
Date:   Tue, 1 Dec 2020 15:15:41 +0000
Message-ID: <SN2PR07MB2557592958FBF80DFAFD6D97D8F40@SN2PR07MB2557.namprd07.prod.outlook.com>
References: <20200930182105.9752-1-nadeem@cadence.com>
 <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
 <SN2PR07MB255715C886C2DC5B9044BC01D81E0@SN2PR07MB2557.namprd07.prod.outlook.com>
 <d2aa5519-e207-c3e5-9d81-14209d856b54@ti.com>
 <CAL_JsqKdAzi4zu=U=DPF_VBjTt9287gsTR1hgDWriMKdsx+MNA@mail.gmail.com>
 <fd972d22-7bf5-c87d-9612-4ff684ffe625@ti.com>
In-Reply-To: <fd972d22-7bf5-c87d-9612-4ff684ffe625@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTBkZDZjOGEtMzNlOC0xMWViLWFlOTItZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDEwZGQ2YzhjLTMzZTgtMTFlYi1hZTkyLWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iMjA0MyIgdD0iMTMyNTEzMDkzMzgzNTAxMDU0IiBoPSJaWjZiZDNjZlZrTmdHSnlmK2ZiYmd0WjYzYXc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b959c3c6-5f65-4728-8d89-08d8960bf7c7
x-ms-traffictypediagnostic: SA0PR07MB7644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR07MB7644F687EF6FCE8EC4F978AFD8F40@SA0PR07MB7644.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TI5aVAtakIG/v7sqkrJsOV7Dx3KfUPjsvzrJv1b46jFbGiGwCzNZbb425y2bnwLWOxWLtyOa0OM6jA/KZCVRfYEq/Ya88yFB26Ezman5sQsA3S6LiP+8xzKr3XVCtlisanQnfWhwjQSx007vSdCqRbDafIitT7uH8g5ZzLj2Rlp3xcFXWO8LjAogkeSkiEuYZJ/VNabDbEkQV8Lpz4QbcDXjzuvcDxw+RoMRZRRS8WDOhHbBR4CKaJxlYkjRgIavLBELCpzikefNedxlSaDh5HomQCJfMN4bET2LRVgIXU7mopQ5EIpUrkMVRS3D3QA2E0Ha4SHfxlnRR6jz51NvWG7JIktVEDQhVXj5sITesysJtATlo5fNWezr1nTZx0Cy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR07MB2557.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(36092001)(9686003)(6506007)(8676002)(186003)(26005)(83380400001)(478600001)(86362001)(54906003)(7696005)(110136005)(33656002)(316002)(8936002)(53546011)(66446008)(107886003)(52536014)(5660300002)(55016002)(71200400001)(76116006)(66556008)(66946007)(66476007)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YnNMK0tIN1RVaGlTL20waGNvMUxEemUyclVhYkxLbTk4bXpUVnZnSTNrWmdP?=
 =?utf-8?B?b3NJcE1iSk5FaHNQcDJsaWtydGJ5U3hiSWFFR3FiZVc2Z2tnRXJvcjJ0WlVl?=
 =?utf-8?B?eTNPeDA4M0cwNExDaURNWGRwM3ZCaEtOT3JzZXFjKzkvZ2pKMG8xdXpHZENw?=
 =?utf-8?B?alRIOThYL3RuQnlWUGIwQ256ZC9xWENrZ0tSMUlMRitRVUhhTDJIVFUzek51?=
 =?utf-8?B?SWdJSm1mVHJEUURTejhCaUE2QUVlbnRXdDBhczAyUFFTR0ZGdWhMVVRYZnY3?=
 =?utf-8?B?Q29wdHZVd1A5R3dlRFVNUStBN1Qwak5NWTZVYy94OEUycENJa1JEblh3NzJ6?=
 =?utf-8?B?QnYveFE5cENienluUDBadVlPYkdCaENDQjY5OGRVdE9nR25reXJQL21kVjg0?=
 =?utf-8?B?V0FUL2c4bkFmMTIvT1k4SXJVeC9kQncxM29OU3pqOTNhNGFWOFc1anVmbXhX?=
 =?utf-8?B?RXFreTRiNytGUUxoSWE1ZGh4N1RXYUovRFhRZUJTdjZldC8rcVh5ZkkzRXlR?=
 =?utf-8?B?WW1aVlI2YjdsODFqb3dPU085dWtuZDgzSVBjTEJ6VFIwTC9xY1kvSkQ0S0tF?=
 =?utf-8?B?OHVCUjBnUmRaWURQYUtvTk1FZm1MakNJeDhzR2FJZnE3Y2V1b2tiUkNZL3Ro?=
 =?utf-8?B?YmY0QW5qL1YyTnBLWXJsL28rY2h4QUJFZ1lleXhzMlN1aHFhZE96bG1QMGkv?=
 =?utf-8?B?Q01vMUNLN1A4MlpOZmZTa2VUeFNVRHZlWXBVbCtLZGFiWkt6amhwa0J5c1hI?=
 =?utf-8?B?NXd3TDhPRTJXU0IwTE1EbThaOUtidGh4SWFFTE53UytueVFOL2hEZm9keVFi?=
 =?utf-8?B?U2p2ZjBBOEtzWm0rMkh1enRpeGloMUU3WnZoRUUvZUJ2bEpaWTl0SVdmWkU2?=
 =?utf-8?B?R3lGTnVRUjVteU1XWlR2UEp0UmxhSU5CVHRUVi9DNnlySjBqUHptaXZvRnFo?=
 =?utf-8?B?WEdRSmJpTWZnWXIveUZCNHc3WkJUd2laZHZLMllkRnc1M0R0OXk1eDZDejRI?=
 =?utf-8?B?MWVRUWZFeDhiL1FKLzhtVExYdHUxUnBEdlNjU2lHNzduNXozTVhYZW1wcGRN?=
 =?utf-8?B?VUdmYkRRT3RDQ25pRjlOWktxK0FDY25IUGhHVWRURlFyVHQvSXlTN2hxcmNt?=
 =?utf-8?B?NTVUOG5NMmtVdDFld041Q0IyK094L3BNRkgxN1IzVHJHcVpJcHpDQ295MnJh?=
 =?utf-8?B?MW9sN3pkVk4rZW4va2s0SjNyeU1tT2FNNUxFSFFXSHExODdjYnZrZVZHU054?=
 =?utf-8?B?cnYvK0VMb3J0OS9GbUgwRTNMYjRvZTFzQ3FWb1ZKdWVXYUFHdE8zUE5EODd3?=
 =?utf-8?Q?fHw7RkkMFwiRw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR07MB2557.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b959c3c6-5f65-4728-8d89-08d8960bf7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 15:15:41.7322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35+n5eVCJ5L4LdEmHaTrixBmnEgZ5h0/zQAdRwweUOaOuo7xwwCY6FVDMLVFJdinrYiY0+JeRT8OQA3DtvsTaKBz4qFowAQ1JxDKus29690=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_07:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=715
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010098
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3Zl
bWJlciAyNiwgMjAyMCA3OjI4IFBNDQo+IFRvOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
Pg0KPiBDYzogQXRoYW5pIE5hZGVlbSBMYWRraGFuIDxuYWRlZW1AY2FkZW5jZS5jb20+Ow0KPiBs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC0NCj4g
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVG9tIEpv
c2VwaA0KPiA8dGpvc2VwaEBjYWRlbmNlLmNvbT47IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUN
Cj4gPHNqYWtoYWRlQGNhZGVuY2UuY29tPjsgTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIFBDSTogY2FkZW5jZTogUmV0cmFpbiBMaW5r
IHRvIHdvcmsgYXJvdW5kIEdlbjINCj4gdHJhaW5pbmcgZGVmZWN0Lg0KPiANCj4gRVhURVJOQUwg
TUFJTA0KPiANCj4gDQo+IEhpIFRvbSwgTmFkZWVtLA0KPiANCj4gT24gMjcvMTAvMjAgMTI6NTAg
YW0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDE6NTcg
QU0gS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gd3JvdGU6DQo+ID4+
DQo+ID4+IEhpIE5hZGVlbSwNCj4gPj4NCj4gPj4gT24gMTkvMTAvMjAgMTA6NDggcG0sIEF0aGFu
aSBOYWRlZW0gTGFka2hhbiB3cm90ZToNCj4gPj4+IEhpIEtpc2hvbiwNCj4gPj4+DQo+ID4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBLaXNob24gVmlqYXkgQWJy
YWhhbSBJIDxraXNob25AdGkuY29tPg0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxOSwg
MjAyMCAxMDo1OSBBTQ0KPiA+Pj4+IFRvOiBBdGhhbmkgTmFkZWVtIExhZGtoYW4gPG5hZGVlbUBj
YWRlbmNlLmNvbT47DQo+ID4+Pj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+Pj4+IGxpbnV4LSBwY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUb20NCj4gPj4+PiBKb3NlcGgg
PHRqb3NlcGhAY2FkZW5jZS5jb20+DQo+ID4+Pj4gQ2M6IFN3YXBuaWwgS2FzaGluYXRoIEpha2hh
ZGUgPHNqYWtoYWRlQGNhZGVuY2UuY29tPjsgTWlsaW5kIFBhcmFiDQo+ID4+Pj4gPG1wYXJhYkBj
YWRlbmNlLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBQQ0k6IGNhZGVuY2U6
IFJldHJhaW4gTGluayB0byB3b3JrIGFyb3VuZA0KPiA+Pj4+IEdlbjIgdHJhaW5pbmcgZGVmZWN0
Lg0KPiA+Pj4+DQo+ID4+Pj4gRVhURVJOQUwgTUFJTA0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBI
aSBOYWRlZW0sDQo+ID4+Pj4NCj4gPj4+PiBPbiAzMC8wOS8yMCAxMTo1MSBwbSwgTmFkZWVtIEF0
aGFuaSB3cm90ZToNCj4gPj4+Pj4gQ2FkZW5jZSBjb250cm9sbGVyIHdpbGwgbm90IGluaXRpYXRl
IGF1dG9ub21vdXMgc3BlZWQgY2hhbmdlIGlmDQo+ID4+Pj4+IHN0cmFwcGVkIGFzIEdlbjIuIFRo
ZSBSZXRyYWluIExpbmsgYml0IGlzIHNldCBhcyBxdWlyayB0byBlbmFibGUNCj4gPj4+Pj4gdGhp
cyBzcGVlZA0KPiA+Pj4+IGNoYW5nZS4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTog
TmFkZWVtIEF0aGFuaSA8bmFkZWVtQGNhZGVuY2UuY29tPg0KPiANCj4gRG8geW91IGhhdmUgYSBm
b2xsb3ctdXAgcGF0Y2ggZml4aW5nIHRoZSByZXZpZXcgY29tbWVudHM/DQpXZSBwbGFubmVkIHRv
IGZpeCB0aGlzIGluIGNvbWluZyAzIHdlZWtzLg0KPiANCj4gVGhhbmtzDQo+IEtpc2hvbg0K
