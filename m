Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591E933A78A
	for <lists+linux-pci@lfdr.de>; Sun, 14 Mar 2021 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhCNS5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Mar 2021 14:57:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11910 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229870AbhCNS5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Mar 2021 14:57:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12EIt5Fp008860;
        Sun, 14 Mar 2021 11:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=mzVYqpCGxXPQ75k7h36vNzkS/ZIXBS4jCp1tiJCTMlk=;
 b=o7HE7u/T5U7/8DojLiH/28upSWuKlltT7kcI+biUOBVUXy/tRs2qjdMw6/162yBkQcfS
 a8bHRlHzNakbRK2OejoXN49jjsIhxm40x211kUn/H29cpf67DjXDggSoMN0hWPgH3Ll6
 H+aKjCKAdB94/IAed0J4TXmBCEzhdia1a1hzfhpT/CN4bX2+yeFwIMCekkPd4R5WyJ+m
 Yq4OoPM49Zm3hy9EpkVlN+Txqv0C+awr5kyZZX7yXJLf5oV3hkXvoNbUJ9oAKVu1UcRA
 gHdXVhYV3ZuqntuCJucHQDJ3GOswsduAgrsm5BRY/N/U82iZl7/dxyuS4DcnOOTqbtvI 0A== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2br6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 11:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/jcZhU8yRsVaLuaOke9QUd5B+zS2kQjgrbnYSC8AqHkMEMCHjOfbOonYeBu65nFWdzA75pdHUj/XYc8VTSSP3Or+g8VayuX9lAetK5XAXo+ZH0IhB91UZFb5Fu5d7WAefN6fjCcZAAhsM8cutGq4fGFc8hH0L7UpJGxME5+u9m2P7ZNtQw+QAET6YefFz+aTxEcXivRRxORoR2SR208C1CcZRbaUxQoqLjXWbdBnYosS45HdqgNtGG8Cn2eOzLTMPcmjd+nSwc/n1kcAJICbUYAP+VL3lUd6qGczY5M2yMDf8Ijg04rprIh+ymh66KN85rYdZxfvHOfHDQvlZjTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzVYqpCGxXPQ75k7h36vNzkS/ZIXBS4jCp1tiJCTMlk=;
 b=jqzwtCVjb83awhAAabe6BhEFV3ntB7F/N7M69x7ZtQgw3/sGgiYh+SN9vW6v7K72xJoN9CZCuNKN3XUtaxiHB5G63WQJFtIwhx592hsGx0fYJj8+Rh7sX03riZ8ZiTiLHFJDsna8xban/nq25wTz7O0TDm3DB2REDY5nQU0fyVXJE9o6bDyvsClhOGb6k2dzInzjhue1j6hdFeownqeh6/Pk860vv8Gsn7zUY1piy4ypOmaenL1lveseWY88Qxx34NTnVTRgVVe/ZOjuql6WepD/SSfaVmyKVOkEtuY3AonKweQjNbryWUJO6K0ftOSYu0QcRduYGE238NR61J9Oaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzVYqpCGxXPQ75k7h36vNzkS/ZIXBS4jCp1tiJCTMlk=;
 b=j2no2uRJSxbqr1+JxO4ojkZpTAoWAouNoFUtlgRKTpcp2uNFth8jAjaQGIJKGOmaMXE9ka5wvzdtPDk2X3id8429HcAaHXN4eZYGgOsOmIU/9E/VEff1A2Ppk1+d2zGIpLsNkaYzht+wOw6emKb+AQjfnyPdWXsyioi5bJvqE8s=
Received: from CO2PR07MB2503.namprd07.prod.outlook.com (2603:10b6:100:1::19)
 by MW4PR07MB8569.namprd07.prod.outlook.com (2603:10b6:303:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sun, 14 Mar
 2021 18:56:53 +0000
Received: from CO2PR07MB2503.namprd07.prod.outlook.com
 ([fe80::d8d9:e81c:18a:33e5]) by CO2PR07MB2503.namprd07.prod.outlook.com
 ([fe80::d8d9:e81c:18a:33e5%11]) with mapi id 15.20.3890.038; Sun, 14 Mar 2021
 18:56:53 +0000
From:   Athani Nadeem Ladkhan <nadeem@cadence.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: RE: [PATCH 1/2] dt-bindings:pci: Set LTSSM Detect.Quiet state delay.
Thread-Topic: [PATCH 1/2] dt-bindings:pci: Set LTSSM Detect.Quiet state delay.
Thread-Index: AQHXFLZJyCgoB7DiFUmLsc9uEE8eZ6p73hUAgAf9yyA=
Date:   Sun, 14 Mar 2021 18:56:53 +0000
Message-ID: <CO2PR07MB25034C1F1ACD54CDC3D465B6D86D9@CO2PR07MB2503.namprd07.prod.outlook.com>
References: <20210309073142.13219-1-nadeem@cadence.com>
 <20210309073142.13219-2-nadeem@cadence.com>
 <CAL_JsqJf1JHNEygoSPOqFocXL4F4M7p-MB-UxOp=D--NKnvTZw@mail.gmail.com>
In-Reply-To: <CAL_JsqJf1JHNEygoSPOqFocXL4F4M7p-MB-UxOp=D--NKnvTZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbmFkZWVtXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDQ5MjJiMmYtODRmNy0xMWViLWFlOTgtZDQ4MWQ3OWExZmRlXGFtZS10ZXN0XDA0OTIyYjMwLTg0ZjctMTFlYi1hZTk4LWQ0ODFkNzlhMWZkZWJvZHkudHh0IiBzej0iMzEwOSIgdD0iMTMyNjAyMjE4MTA5Njc3NTI2IiBoPSJCcDhFbUViTEdwMmVVcjJZZS84cHVZK21HK3M9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a33beed3-3f9e-4637-cba0-08d8e71aeed9
x-ms-traffictypediagnostic: MW4PR07MB8569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR07MB856905FBB141D7508F9C5258D86D9@MW4PR07MB8569.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UX4RZcQ6QlCLvI/3Ez2TDznm6BiP8dFdrownq3xo//VpH+wzdg2zY/oUE+1pMKIBKg4UHxijnL8VimhYHoLETqLXox4bNoP38bijtEcI6ReTkZgqxT65VJfyMIYg1H/dp0CpjXUvB6FerRho9XnHwysb5a3l8HZKV2bC4zC77Am4dYRuMoIF7qhjj0sMfg1ki4lWwX7PUHikSS/g4Cs0ye/lDfcXfgsma5vOhHC7bVd5K21QMe31to6s8h3ogPGczr4RcNF1wtut7wXD7uC7JiximOvQmkJ6QfZAMFDaqWNrl2pdg9/SvoxTCRozdI8ozfKrSzmgXcg/RFMu6er0Iy33tOdkpu2ohuFWanE2MfcGBn0RJUifp5W9OUSQFas+w8ggjohWJUUrplcwuLJF9EDMCHVWItn+FIFjqjFoJoGGUlbvhP9fCYKNr5gnhXYBqVrNt5vily+t7YGEFrGAJSBlXkd7DCS+c3xoK500fYAupgSuIAoN7PO8Cu/R8BVccRdceEspV1MkBXC8wyvp4VavjnCqIWWqUMgeobZ1ne7I470zzbRInuWu8GxxjYwP8tGEl3roq6FtxC8nxUIEw1vV8yIcE+4r5nLA7e8r5i0z+89D4SG6O5xu1zN8fetw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR07MB2503.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(36092001)(71200400001)(33656002)(8936002)(7696005)(6506007)(53546011)(54906003)(4326008)(86362001)(2906002)(5660300002)(8676002)(186003)(55016002)(9686003)(107886003)(478600001)(52536014)(83380400001)(26005)(66556008)(76116006)(64756008)(316002)(66446008)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bXFkQjZXdkR2UFpTUE1uYjVLYTZtcUhaTy9QUkVzWlZZcHdzOWZiM1dGc3VR?=
 =?utf-8?B?SmxuTlYrc1MrVUQ2b0phbURQT2NzRWtkWmMvTTYyZGp3Z3dpcjN2WWRjWVBZ?=
 =?utf-8?B?SytuLzI1M0FFdXlhUXcvN1BBT1RyTWlnNWNqL2VyOGZrU01hMmVIYi9IZHdU?=
 =?utf-8?B?MnJjMnRabDN0UWJBS2diVVREbG1LM3ZtcTJ3bnc1QjJPeGdVNXNVc3lTYkdv?=
 =?utf-8?B?alV0TEF1a2pEQ3B4L2dwZzdaL1B4RzBQaGZtSU1mZU5oWlFqT0ZmUjRWU3Vy?=
 =?utf-8?B?MUpqL2RlZGpDMUp4Y2VjYzd6Z2J2ZzFnMkpNcUlLczlKckRXY21yai9KNTJC?=
 =?utf-8?B?aXg5RUljZDd6VlVwUUZEYStRMU9aWUVCcGc0b244ajEySmkxc3FxZGVISWZ1?=
 =?utf-8?B?THJHa012Y3dCY2xOS0E4L2MyelFYTGdSd2ZTTDN5Rm1xQzMrYVFzT2dTSGdp?=
 =?utf-8?B?akcvOXFTRjFQM0dFQWdPN1Y2ZXFRUG9td3RNVUFkRkxkL3hsK0NOQTZNSUZo?=
 =?utf-8?B?RmRNVjZRdGZDL1E0TlJvcWN6TU5sZUtyeGg5WFpYL2l6UTZCM3kwUVJQMjJD?=
 =?utf-8?B?N3hqVENqVjVmWFNMT0ZVZjlQMnhmNzVScy80OVRVRXJRTUszZFhzNmdCUmtZ?=
 =?utf-8?B?OE9KRmFhYVZGem1VdFI4ZW5KckZrVTR5Rm1JZktuQUlPdXBYanFTb2JBWlBV?=
 =?utf-8?B?NDErMUhGSG1MWGcrVkppTytDUHNpVHRaUWQ1aXJ4RXpiNDh0Tk5hZ2sycFhC?=
 =?utf-8?B?cEFUNlg0dWpsMHFHMy9MY2JuY1BqR215MmVpdklGN0RjZG9CV1ZNL0Q2bFdw?=
 =?utf-8?B?WXo5NHdDMExHODFWeVlKTVFhTDBMVm9XY2Y5WVBURU9kT3l3SW92SVlJUkZD?=
 =?utf-8?B?Um5MeEtqcEJWYk1nQXZjdnZvbml5UFBFM1JiZ1c1a0E3L005ZzNCRGVVSUZU?=
 =?utf-8?B?cUx0NjBJUFVDOXk4RXBnWjkrMzNPOUtCVEpCMFNob2hXRjdhUTFLdTl6T3J5?=
 =?utf-8?B?UXNEcXpxNGJMQWtzZm1yeVc4LzBjeklxdmFMUWxya0lwZlJ2M2FZMWhSNDkx?=
 =?utf-8?B?aUNrcmVqQmhmbEx5cEg3d21hVld1TzNqMXhCNWhxYWlxKzAwNHRCdVBYQklT?=
 =?utf-8?B?bjEyUGFWa1gwM2h1TjhiaHVYM0tYT3o0VFRrV0svY2pQaStFMElOcGRScWl1?=
 =?utf-8?B?eE5GLzg4SUxVVzZoQ3JVY0o3Q3BOQnY4eitEUUxRWjgvOHpLSGk3U1dyZGov?=
 =?utf-8?B?SDh2TTd3ZVIwSHVTbHNkU0dhWjNraDQwK0U0ZDlJc3Bxb1IvalhORU1Sc2JF?=
 =?utf-8?B?NWRMelE2Q1pHbEVUWGhubGdJQnMyV0MvdVFnZkQ2RVdaS1BlQWxrYTF4RWsz?=
 =?utf-8?B?aGlkSGN1RUI4Q2ROZlBuNm84WGZPNUkvYTJpWnBXaitCVmo3eXdldDBuWVFT?=
 =?utf-8?B?REpxUHAyZVZBVFRkbUtBa2t0Y3hOZmJJYmRQOGpvUWc1NGNPbGJTaHFRbXFC?=
 =?utf-8?B?ZnBHbFBmT2pYT1VLZTZIZnBkRnRISzMvaTZKSnpBVW1xeXpsSXYwWTZ5K3kv?=
 =?utf-8?B?V0M4QUo4MVJvbXNIN1d3M2g5azJ1MUNGUmJ3R09TTVNWaWs3N3Q3YUxqWTZ5?=
 =?utf-8?B?aEhVTXRnbWlQUXhlUzNhbFRySkhSVUdVQ3dGQzVwaW9IWjdKeVNXYmhkMjlt?=
 =?utf-8?B?MTlMN3dJYUVmZVdVV2ttaHUydWREWFdWcHpoNFV3VzZUeFpEdVdQYUxGNjZZ?=
 =?utf-8?Q?UxwJrobkN8oRJ1vUoNtkSkZ21F2xkt8wrh7sLCy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO2PR07MB2503.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33beed3-3f9e-4637-cba0-08d8e71aeed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2021 18:56:53.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz2N+UqWjMkmF17PyzzoObJ4SydZjsLRhKqgcmtByeo+I+FHsdr6GsnShxeU+AlrBCiiPPakwvTXeOZKUjr60vUpK12Bjd6l4fGs+e7lrXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8569
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_10:2021-03-12,2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140145
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDksIDIwMjEg
MTA6MTcgUE0NCj4gVG86IEF0aGFuaSBOYWRlZW0gTGFka2hhbiA8bmFkZWVtQGNhZGVuY2UuY29t
Pg0KPiBDYzogVG9tIEpvc2VwaCA8dGpvc2VwaEBjYWRlbmNlLmNvbT47IEJqb3JuIEhlbGdhYXMN
Cj4gPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBQQ0kgPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgTG9yZW56byBQaWVyYWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBL
aXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPjsNCj4gTWlsaW5kIFBhcmFiIDxt
cGFyYWJAY2FkZW5jZS5jb20+OyBTd2FwbmlsIEthc2hpbmF0aCBKYWtoYWRlDQo+IDxzamFraGFk
ZUBjYWRlbmNlLmNvbT47IFBhcnNodXJhbSBSYWp1IFRob21iYXJlDQo+IDxwdGhvbWJhckBjYWRl
bmNlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOnBjaTogU2V0
IExUU1NNIERldGVjdC5RdWlldCBzdGF0ZSBkZWxheS4NCj4gDQo+IEVYVEVSTkFMIE1BSUwNCj4g
DQo+IA0KPiBPbiBUdWUsIE1hciA5LCAyMDIxIGF0IDEyOjMxIEFNIE5hZGVlbSBBdGhhbmkgPG5h
ZGVlbUBjYWRlbmNlLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgcGFyYW1ldGVyIGRldGVj
dC1xdWlldC1taW4tZGVsYXkgY2FuIGJlIHVzZWQgdG8gcHJvZ3JhbSB0aGUNCj4gPiBtaW5pbXVt
IHRpbWUgdGhhdCBMVFNTTSB3YWl0cyBvbiBlbnRlcmluZyBEZXRlY3QuUXVpZXQgc3RhdGUuDQo+
ID4gMDAgOiAwdXMgbWluaW11bSB3YWl0IHRpbWUgaW4gRGV0ZWN0LlF1aWV0IHN0YXRlLg0KPiA+
IDAxIDogMTAwdXMgbWluaW11bSB3YWl0IHRpbWUgaW4gRGV0ZWN0LlF1aWV0IHN0YXRlLg0KPiA+
IDEwIDogMTAwMHVzIG1pbmltdW0gd2FpdCB0aW1lIGluIERldGVjdC5RdWlldCBzdGF0ZS4NCj4g
PiAxMSA6IDIwMDB1cyBtaW5pbXVtIHdhaXQgdGltZSBpbiBEZXRlY3QuUXVpZXQgc3RhdGUuDQo+
IA0KPiBXaGF0IGRldGVybWluZXMgdGhpcyBzZXR0aW5nPyBJcyBpdCBwZXIgYm9hcmQgb3IgU29D
PyBJcyB0aGlzIGEgc3RhbmRhcmQgUENJDQo+IHRpbWluZyB0aGluZz8gV2h5IGRvZXMgdGhpcyBu
ZWVkIHRvIGJlIHR1bmVkIHBlciBwbGF0Zm9ybT8NClRoZSBwY2llIHNwZWMuIHNheXMgdGhpcyBk
ZWxheSB0byBiZSBiZXR3ZWVuIDAgdG8gMW1zLg0KVGhlIGRlZmF1bHQgMCB2YWx1ZSB3b3JrcyBp
biBtb3N0IGNhc2VzLg0KSG93ZXZlciBpdCBoYXMgYmVlbiBmb3VuZCB0aGF0IHNvbWUgU09DIG1h
eSByZXF1aXJlIHRoaXMgZGVsYXkgdG8gYmUgZ3JlYXRlciB0aGFuIDAuDQpUaGlzIGhhcyBiZWVu
IHByb3ZlZCBieSBhbiBpbnRlcm5hbCBzaW11bGF0aW9uIGV4cGVyaW1lbnRzLg0KSGVuY2UgcHJv
dmlkaW5nIHRoaXMgZmVhdHVyZSBpbiBkZXZpY2UgdHJlZSBmb3IgcmVxdWlyZWQgU09DJ3MuDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hZGVlbSBBdGhhbmkgPG5hZGVlbUBjYWRlbmNlLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NkbnMsY2Rucy1wY2ll
LWhvc3QueWFtbCAgICAgICAgfCAxMw0KPiArKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NkbnMsY2Rucy1wY2llLWhvc3QueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9jZG5zLGNkbnMtcGNp
ZS1ob3N0LnlhbWwNCj4gPiBpbmRleCAyOTNiOGVjMzE4YmMuLmExZDU2ZTBiZTQxOSAxMDA2NDQN
Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2NkbnMsY2Ru
cy1wY2llLWhvc3QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvY2RucyxjZG5zLXBjaWUtaG9zdC55YW1sDQo+ID4gQEAgLTI3LDYgKzI3LDE4IEBA
IHByb3BlcnRpZXM6DQo+ID4NCj4gPiAgICBtc2ktcGFyZW50OiB0cnVlDQo+ID4NCj4gPiArICBk
ZXRlY3QtcXVpZXQtbWluLWRlbGF5Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAg
IExUU1NNIERldGVjdC5RdWlldCBzdGF0ZSBtaW5pbXVtIGRlbGF5Lg0KPiA+ICsgICAgICAwMCA6
IDB1cyBtaW5pbXVtIHdhaXQgdGltZQ0KPiA+ICsgICAgICAwMSA6IDEwMHVzIG1pbmltdW0gd2Fp
dCB0aW1lDQo+ID4gKyAgICAgIDEwIDogMTAwMHVzIG1pbmltdW0gd2FpdCB0aW1lDQo+ID4gKyAg
ICAgIDExIDogMjAwMHVzIG1pbmltdW0gd2FpdCB0aW1lDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIG1pbmltdW06IDANCj4g
PiArICAgIG1heGltdW06IDMNCj4gPiArICAgIGRlZmF1bHQ6IDANCj4gPiArDQo+ID4gIHJlcXVp
cmVkOg0KPiA+ICAgIC0gcmVnDQo+ID4gICAgLSByZWctbmFtZXMNCj4gPiBAQCAtNDgsNiArNjAs
NyBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAgICAgbGludXgscGNpLWRvbWFpbiA9IDwwPjsN
Cj4gPiAgICAgICAgICAgICAgdmVuZG9yLWlkID0gPDB4MTdjZD47DQo+ID4gICAgICAgICAgICAg
IGRldmljZS1pZCA9IDwweDAyMDA+Ow0KPiA+ICsgICAgICAgICAgICBkZXRlY3QtcXVpZXQtbWlu
LWRlbGF5ID0gPDA+Ow0KPiA+DQo+ID4gICAgICAgICAgICAgIHJlZyA9IDwweDAgMHhmYjAwMDAw
MCAgMHgwIDB4MDEwMDAwMDA+LA0KPiA+ICAgICAgICAgICAgICAgICAgICA8MHgwIDB4NDEwMDAw
MDAgIDB4MCAweDAwMDAxMDAwPjsNCj4gPiAtLQ0KPiA+IDIuMTUuMA0KPiA+DQo=
