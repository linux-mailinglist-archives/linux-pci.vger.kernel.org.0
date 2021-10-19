Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B12433431
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhJSLCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 07:02:19 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:17782 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235409AbhJSLCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 07:02:02 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19J9CIiV018495;
        Tue, 19 Oct 2021 03:59:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=WH59AC2hvRmSu7iN0mSbVky8eRw6+S5oJPQPHlWU+I8=;
 b=IF5C7OH8Ec4i+b4URBESzLVeXufMi6464p+rpZor+XMuId1UYpgSCtz1x2XzquyqZCu+
 vTY6WkII9fGhanoqWj/UefOjEeQEtlC3fJoJidcpYw0Vuw5xa6CAElnZQxs8kclxCGzZ
 OudQ+dIfQdRwLAaNDQMtqU03SEUFhl+hJvMnwXKFXEjLGU/wyY44FLmNaURLy8jtR7ib
 1++jAvqiJUQUrTXKNbctL4wBuZGwh1fPvwYbID5eFzyEAW4lx4miI/ntpqE89JXXWxyF
 VtZEGkjQNLeatB1h8X5LmpiSq9GDBClymKBQ0Eh88FZB3bH/yCiTk31xx2N+G/FYKjYw SQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bsab70t70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 03:59:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHi4Te2sB/MpubGaQcYGmNe8oK2tIdQP2EvPsOa/1prn5tBtF3akzULPspHSRXlCe2l1vDArUI5ZCXNML6r7kBhNtAdWBYOFgGehRVe7VtieQseayCRp551q1VH18d4+HYCKrQ8iacBRYpVQQfDdUXm2AK317VeYM2WSP0mCYzBJ0DP+DBn3PN+YeF9JRkVmvNOFoeBBMOS/13545T3iHhQFGZlyibK6UhHECiFS3Spc+ksj0LTOIXQErVkBD0G9NdGrUK1xlX7Zd+Xsxj9X4vCuYp9ICk26udj8jMU9yHCOb7Y7lYvvXdOOg/ipD9PWQdis6Qxdj7CJGjmuQ9iNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH59AC2hvRmSu7iN0mSbVky8eRw6+S5oJPQPHlWU+I8=;
 b=A9J/6Os3LCMbAXqEPr1Bmp6Spsu/ZyKEvTrlDVaC9sG1Od1PYR+N8FUhZaB8LIRGXAaxYOAvmAe2i6/OPdcTsfhaM65yG2WTrPSVb5pr/FN+40xDIlFIvQH7l2DPlbQo08lw2TTw1O74ko1w0foRpbdSrbaWWste43WhNYgaHIEdbvOjeWkSs1yK/yBLuB9LhHOnx+bYCZDZ05/RzWtxQPMgWA6E/b925NxcV1behcXJEhsKw4mwDsmRo6QWV08D8dMXIU1oCwfVl8UVzZi9wX/nNaos1kVM6Gp8yp8AKAnMwXcpG3qaJUn28VewVhn4gwEtrBLLrfdToMqeBHi/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 10:59:28 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c11a:b99e:67ce:4a14]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c11a:b99e:67ce:4a14%8]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 10:59:28 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] pci: pcie-rcar: add regulators support
Thread-Topic: [PATCH] pci: pcie-rcar: add regulators support
Thread-Index: AQHXxNAIHsv96zTejkeNKLTX0Iuv4qvaHAyAgAAIsRA=
Date:   Tue, 19 Oct 2021 10:59:27 +0000
Message-ID: <PH0PR11MB519149EA25F1C911C5ADA5FFF1BD9@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20211019095858.21316-1-Meng.Li@windriver.com>
 <CAMuHMdUJ4nzz169=LG_q6rx7naKVdk-VUrxiQ9VzS=fxjCQ2WA@mail.gmail.com>
In-Reply-To: <CAMuHMdUJ4nzz169=LG_q6rx7naKVdk-VUrxiQ9VzS=fxjCQ2WA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62de4a80-4125-43e7-a861-08d992ef8545
x-ms-traffictypediagnostic: PH0PR11MB5046:
x-microsoft-antispam-prvs: <PH0PR11MB5046E0FBD9D018AEE8A52D5BF1BD9@PH0PR11MB5046.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z97kzReD/BH6jDUicGjBhV4BTYyJ3SLGlUFmNLhKb5RJYzhUx8NPDOr4k69ilh5lqr6Yqo8p4viewW9I/beBnF/8UdAv7Ol+ohe8uoK4Sj+N7g69rNvnoyZeEvEgaqnCUa+CWtIUvTjLbThx9T89zr234hcYCHSGbeOhzAq9WQW8iirFYv58S46t5mV5IgWWCJ3gXrEmahX8AdRtzkNbM3rJJSPL2uVn7OjjqdHTKMKB9NnfIHk9T/OfJ/AQ8hC/gwN0ttRqnB7S+sI7OeEUDvV+BaM7maVYuB4AceT0EvYOIBEZmSb92hpF4+kxGA0EXXu/jNNnVwAR+kOJb8OLf58O42Er1Ku02l7AHgKW3EQ8JNfg9wKC99RRjEwq/W0Hdy6G8aln3hPr0LfvXPZOSPyT6ZwkQe72cbqe97ra/jfge4K2g5uKf0BCtB5yh2wfeyZMkEaItYritvJTBAzLAE54fNJi5wiB2QSzDt0EN9l+gVOSjyZuifToo8zZQ5KveAOO8+H2I00aJSw8f3FltNGQFJp50bsvDv6jq+tOIKYZ+Hj5qt184Ah9IPmvZ90+elGH4pHhypnL6833dtVK1AtFPUO96SodxT8W57YtzsBpNbsM1RSId73mLpsVTEBDl6xcpVmUdkwSnChN9ebGD/RW6Qmrb/jYAGULBDSfE8GGsC09eIfEF5jwFXRWxSjEAADZyB9KClo42cud3ZXoBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66574015)(9686003)(508600001)(4326008)(316002)(54906003)(55016002)(186003)(52536014)(5660300002)(6506007)(6916009)(122000001)(7416002)(2906002)(64756008)(66476007)(33656002)(66946007)(71200400001)(8936002)(66446008)(38070700005)(86362001)(38100700002)(66556008)(76116006)(8676002)(7696005)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDRzSWtqN1dmYVhnUDVGQ20rY3dLZHhQREszOEhzR0dPNzdjdyt0Z0Z3ZVQ2?=
 =?utf-8?B?eFM0a0tMVnQyckljK0JJY3Zib1VianovcHNiRFgxbU1ScDhWRE5FNmswT0FB?=
 =?utf-8?B?eU9wdFN5YzJORks0VENsbkVIMnhrTEMwQ1dXRkZMTUdLNzVuUDBZUjh3b2F0?=
 =?utf-8?B?UmhiMUlEdFBXZFZPRzNmWkxNalJmUUtSYXhyaFcvbXhFWDI3VjlvT2pMLzJm?=
 =?utf-8?B?WG5uMTEzUHNzWkV5RnhJZEZJZlhlQ2ZuSGFFVm1Od25iYzU5eG9KVW1Td3Ey?=
 =?utf-8?B?SXpSMjNNYmJiM3lJMUpGSFdwM2RBbGVRdlFZMHhOS0FVOXIrM3hsR3lZcFhs?=
 =?utf-8?B?NVg2VnpHK2NwakJTOW9FdWxDQnJPMzJ1ZlAxNnNPN1I3UHVWWktGaUlKc1Zq?=
 =?utf-8?B?VUx4T3J5SWR6Q1hIc3NKS0hTT0wxZUR4WThqV1VRRVI3UGdIVVBkdzBmTkNm?=
 =?utf-8?B?OXBEUGJCbWZYU1RMS2FJVk1uUjRIMFRieUZUeXJiVzU0VEQyMHhPU2Rpdnph?=
 =?utf-8?B?YWs0bjQzbVZPNkh3L2NMWHcwSFFQK05xeFF3SStRYUhtN2l4UWdRWTZVM3JY?=
 =?utf-8?B?NG9qdFBiMktiRUgrU01CQ0tnempHandMRnRySFZMcGt4MEhtVHhXa0VsV3RS?=
 =?utf-8?B?THBhbmZKd25qbTRWekNTalVac0pPVE5OSmlrRVFablN6ZE1PdjB3TmM1RVFo?=
 =?utf-8?B?UzV4QTRSRDF0eGltUXZ3NDNuNEdCTloxRVdXMFhLc0xRQ2JubHNKWVlKWjI1?=
 =?utf-8?B?RkNHWjkrZHlwUkREYTNDbXhkY2ZYYXNldjNjSDhpMXZBM3M3VEdLcEFMSnhN?=
 =?utf-8?B?QkRnVG9pMTN6VWZ1eW0xSkFkVDBtMS84MzZmeWR1d3UyR3BFWWlJZEpBMVkr?=
 =?utf-8?B?VkpSRGpWbnRrSzc0Q3RiNWl6TmhaRVdURENFMzM5Wm1VRlgra2ZJTEtCNEdP?=
 =?utf-8?B?VDNvdzUvM2ZnTDI3VGRuKy84Y210QXFvam5iYTkvbjBmMG5BdU5tSWFSeEtV?=
 =?utf-8?B?WEhiWlYzWklISDZ2VGxIUW5jSXJEellCaUV5dUU4K3g1UVdsM1E0amlQdmhz?=
 =?utf-8?B?R0plUk84aE5hRU12K0FseWRjeGRaazNhSy9YN0JUaW5kZVh0Q1NBY3NnL0I5?=
 =?utf-8?B?Z1JMZXB6MUFFY2JRNXVnTXZoMnZmV2FSb0trRW9WdkVBbFE0V1VEbHpRZ3lM?=
 =?utf-8?B?T3ZyL2poUDFva3R6UWdIS1RVNE9lb2RJV3cxWnI5ZGpOUVV2ZDVHdzg2d2ZO?=
 =?utf-8?B?Uk1GYm1EYllPZytqbHlXcC9VQTBqcVZHSTlxMUExbXNLNFR3RmkxSmtHUThm?=
 =?utf-8?B?VTdsbzM3K1ROV0NlclhEdnNwRWMzaThsMmdmSThtbHlJSE9kZ0plOGJxRzlH?=
 =?utf-8?B?ZEZjT1diUldyajg4TEI4S3VLV1RZVytPTHZXcVU1dkgvZ3FDZE9uQTEwY2R4?=
 =?utf-8?B?U1owZi93YVQ0YUVmT2QrL3RvNU56aGpIOFY3L1pLZzRpTUY0eE5WRWw0NzZU?=
 =?utf-8?B?NjdLMUN0QkJhdk1lYVpYMklqN1Y0aVh5Wkh0eEo1VG9UVjJmWXNFUWNLKytp?=
 =?utf-8?B?N2hHOWVSNjFnVElpWE1INVR6Y2JOQUFQeTVPQURzRjhqUWVJNDhScXRycGk4?=
 =?utf-8?B?UGhNaElVUktGR3Zxa3RwcGk2R0JJbDFqNWJtZ2FpeVROckNYZURXbDdSc2VN?=
 =?utf-8?B?cGI5QzhROElaSGQzSE12MXU3a2NmZVN5aUJLVVdycjdzWHhCMXRoSGxQRzJ6?=
 =?utf-8?Q?xVYWbjaJzFGyzrN8c8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62de4a80-4125-43e7-a861-08d992ef8545
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 10:59:27.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uShTXmFNvh+8xRxM9T+JDrHATg/LFb5Gith/QzlVcsr4G10SvaL2oHeg2qHsKbBjRluJmEupKSvFd/tZkJuE0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-Proofpoint-GUID: sz2WyVG-EWTsQ-EhY25-td54JhWdqzYl
X-Proofpoint-ORIG-GUID: sz2WyVG-EWTsQ-EhY25-td54JhWdqzYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_10,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190067
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxOSwg
MjAyMSA2OjIwIFBNDQo+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiBD
YzogTWFnbnVzIERhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxy
b2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BnbWFp
bC5jb20+Ow0KPiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNh
cy5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47
IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsgQmpvcm4NCj4gSGVsZ2FhcyA8
YmhlbGdhYXNAZ29vZ2xlLmNvbT47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+
Ow0KPiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBMaW51eC1SZW5lc2FzIDxsaW51
eC1yZW5lc2FzLQ0KPiBzb2NAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdB
UkUgQU5EIEZMQVRURU5FRCBERVZJQ0UNCj4gVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgbGludXgtcGNpIDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBwY2k6IHBjaWUtcmNhcjogYWRkIHJlZ3VsYXRvcnMgc3Vw
cG9ydA0KPiANCj4gW1BsZWFzZSBub3RlOiBUaGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFM
IGUtbWFpbCBhZGRyZXNzXQ0KPiANCj4gSGkgTWVuZywNCj4gDQo+IE9uIFR1ZSwgT2N0IDE5LCAy
MDIxIGF0IDExOjU5IEFNIE1lbmcgTGkgPE1lbmcuTGlAd2luZHJpdmVyLmNvbT4gd3JvdGU6DQo+
ID4gRnJvbTogQW5kcmV5IEd1c2Frb3YgPGFuZHJleS5ndXNha292QGNvZ2VudGVtYmVkZGVkLmNv
bT4NCj4gPg0KPiA+IEFkZCBQQ0llIHJlZ3VsYXRvcnMgZm9yIEtpbmdGaXNoZXIgYm9hcmQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+
IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRz
L3JlbmVzYXMvdWxjYi1rZi5kdHNpIHwgNDcgKysrKysrKysrKysrKysrKysNCj4gPiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtcmNhci1ob3N0LmMgIHwgNjQgKysrKysrKysrKysrKysrKysr
KysrKysrDQo+IA0KPiBQbGVhc2Ugc3BsaXQgcGF0Y2hlcyB0b3VjaGluZyBib3RoIERUIGFuZCBk
cml2ZXIgc291cmNlcy4NCj4gDQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2Fz
L3VsY2Ita2YuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy91bGNi
LWtmLmR0c2kNCj4gDQo+ID4gQEAgLTI1OSw2ICszMDMsOSBAQA0KPiA+DQo+ID4gICZwY2llYzEg
ew0KPiA+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsNCj4gPiArICAgICAgIHBjaWUz
djMtc3VwcGx5ID0gPCZtcGNpZV8zdjM+Ow0KPiA+ICsgICAgICAgcGNpZTF2OC1zdXBwbHkgPSA8
Jm1wY2llXzF2OD47DQo+IA0KPiBUaGlzIG5lZWRzIGFuIHVwZGF0ZSB0byB0aGUgUi1DYXIgUENJ
ZSBEVCBiaW5kaW5ncyBmaXJzdC4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLXJjYXItaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LXJjYXItaG9zdC5jDQo+IA0KPiA+IEBAIC04OTMsNiArODk2LDM2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+IHJjYXJfcGNpZV9vZl9tYXRjaFtdID0gew0KPiA+ICAgICAg
ICAge30sDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGludCByY2FyX3BjaWVfc2V0X3ZwY2ll
KHN0cnVjdCByY2FyX3BjaWVfaG9zdCAqaG9zdCkgew0KPiA+ICsgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gaG9zdC0+cGNpZS5kZXY7DQo+ID4gKyAgICAgICBpbnQgZXJyOw0KPiA+ICsNCj4g
PiArICAgICAgIGlmICghSVNfRVJSKGhvc3QtPnBjaWUzdjMpKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIGVyciA9IHJlZ3VsYXRvcl9lbmFibGUoaG9zdC0+cGNpZTN2Myk7DQo+IA0KPiBUaGlzIHdp
bGwgY3Jhc2ggaWYgaG9zdC0+cGNpZTN2MyBpcyBOVUxMIChvcHRpb25hbCByZWd1bGF0b3Igbm90
IHByZXNlbnQpLg0KPiBQcm9iYWJseSB5b3UganVzdCB3YW50IHRvIGNoZWNrIGZvciBub24tTlVM
TCAoc2VlIGJlbG93KS4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChlcnIpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWwgdG8gZW5hYmxlIHZwY2ll
M3YzIHJlZ3VsYXRvclxuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJf
b3V0Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgaWYgKCFJU19FUlIoaG9zdC0+cGNpZTF2OCkpIHsNCj4gPiArICAgICAgICAgICAgICAg
ZXJyID0gcmVndWxhdG9yX2VuYWJsZShob3N0LT5wY2llMXY4KTsNCj4gDQo+IExpa2V3aXNlLg0K
PiANCj4gPiArICAgICAgICAgICAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbCB0byBlbmFibGUgdnBjaWUxdjggcmVndWxhdG9yXG4i
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9kaXNhYmxlXzN2MzsNCj4g
PiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJl
dHVybiAwOw0KPiA+ICsNCj4gPiArZXJyX2Rpc2FibGVfM3YzOg0KPiA+ICsgICAgICAgaWYgKCFJ
U19FUlIoaG9zdC0+cGNpZTN2MykpDQo+IA0KPiBMaWtld2lzZS4NCj4gDQo+ID4gKyAgICAgICAg
ICAgICAgIHJlZ3VsYXRvcl9kaXNhYmxlKGhvc3QtPnBjaWUzdjMpOw0KPiA+ICtlcnJfb3V0Og0K
PiA+ICsgICAgICAgcmV0dXJuIGVycjsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBy
Y2FyX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiAgICAg
ICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7IEBAIC05MTEsNiArOTQ0LDMxIEBA
IHN0YXRpYw0KPiA+IGludCByY2FyX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPiAgICAgICAgIHBjaWUtPmRldiA9IGRldjsNCj4gPiAgICAgICAgIHBsYXRmb3Jt
X3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOw0KPiA+DQo+ID4gKyAgICAgICBob3N0LT5wY2llM3Yz
ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKGRldiwgInBjaWUzdjMiKTsNCj4gPiArICAg
ICAgIGlmIChJU19FUlIoaG9zdC0+cGNpZTN2MykpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYg
KFBUUl9FUlIoaG9zdC0+cGNpZTN2MykgPT0gLUVQUk9CRV9ERUZFUikgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHBjaV9mcmVlX2hvc3RfYnJpZGdlKGJyaWRnZSk7DQo+IA0KPiBQbGVh
c2UgZHJvcCB0aGlzLiAgQXMgdGhlIGJyaWRnZSB3YXMgYWxsb2NhdGVkIHVzaW5nDQo+IGRldm1f
cGNpX2FsbG9jX2hvc3RfYnJpZGdlKCksIGZyZWVpbmcgaXQgbWFudWFsbHkgd2lsbCBjYXVzZSBh
IGRvdWJsZSBmcmVlLg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVQ
Uk9CRV9ERUZFUjsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICBk
ZXZfaW5mbyhkZXYsICJubyBwY2llM3YzIHJlZ3VsYXRvciBmb3VuZFxuIik7DQo+IA0KPiBkZXZt
X3JlZ3VsYXRvcl9nZXRfb3B0aW9uYWwoKSByZXR1cm5zIE5VTEwgaWYgdGhlIHJlZ3VsYXRvciB3
YXMgbm90IGZvdW5kLg0KPiBIZW5jZSBpZiBJU19FUlIoKSBpcyB0cnVlLCB0aGlzIGluZGljYXRl
cyBhIHJlYWwgZXJyb3IsIHdoaWNoIHlvdSBzaG91bGQgaGFuZGxlOg0KPiANCj4gICAgIGlmIChJ
U19FUlIoaG9zdC0+cGNpZTN2MykpDQo+ICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGhvc3Qt
PnBjaWUzdjMpOw0KPiANCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBob3N0LT5w
Y2llMXY4ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKGRldiwgInBjaWUxdjgiKTsNCj4g
PiArICAgICAgIGlmIChJU19FUlIoaG9zdC0+cGNpZTF2OCkpIHsNCj4gPiArICAgICAgICAgICAg
ICAgaWYgKFBUUl9FUlIoaG9zdC0+cGNpZTF2OCkgPT0gLUVQUk9CRV9ERUZFUikgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHBjaV9mcmVlX2hvc3RfYnJpZGdlKGJyaWRnZSk7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FUFJPQkVfREVGRVI7DQo+ID4gKyAgICAg
ICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAibm8gcGNpZTF2
OCByZWd1bGF0b3IgZm91bmRcbiIpOw0KPiANCj4gTGlrZXdpc2UuDQo+IA0KPiA+ICsgICAgICAg
fQ0KPiA+ICsNCj4gPiArICAgICAgIGVyciA9IHJjYXJfcGNpZV9zZXRfdnBjaWUoaG9zdCk7DQo+
ID4gKyAgICAgICBpZiAoZXJyKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAi
ZmFpbGVkIHRvIHNldCBwY2llIHJlZ3VsYXRvcnNcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICBw
Y2lfZnJlZV9ob3N0X2JyaWRnZShicmlkZ2UpOw0KPiANCj4gUGxlYXNlIGRyb3AgdGhpcyB0byBh
dm9pZCBkb3VibGUgZnJlZS4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+
ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgcG1fcnVudGltZV9lbmFibGUocGNpZS0+
ZGV2KTsNCj4gPiAgICAgICAgIGVyciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMocGNpZS0+ZGV2KTsN
Cj4gPiAgICAgICAgIGlmIChlcnIgPCAwKSB7DQo+ID4gQEAgLTk4NSw2ICsxMDQzLDEyIEBAIHN0
YXRpYyBpbnQgcmNhcl9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ID4gICAgICAgICBpcnFfZGlzcG9zZV9tYXBwaW5nKGhvc3QtPm1zaS5pcnExKTsNCj4gPg0K
PiA+ICBlcnJfcG1fcHV0Og0KPiA+ICsgICAgICAgaWYoIUlTX0VSUihob3N0LT5wY2llM3YzKSkN
Cj4gDQo+IGlmIChob3N0LT5wY2llM3YzKQ0KPiANCj4gPiArICAgICAgICAgICAgICAgaWYgKHJl
Z3VsYXRvcl9pc19lbmFibGVkKGhvc3QtPnBjaWUzdjMpKQ0KPiANCj4gSWYgeW91IGdldCBoZXJl
LCB0aGUgcmVndWxhdG9yIHNob3VsZCBiZSBlbmFibGVkPw0KPiANCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICByZWd1bGF0b3JfZGlzYWJsZShob3N0LT5wY2llM3YzKTsNCj4gPiArICAgICAg
IGlmKCFJU19FUlIoaG9zdC0+cGNpZTF2OCkpDQo+IA0KPiBpZiAoaG9zdC0+cGNpZTF2OCkNCj4g
DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZWd1bGF0b3JfaXNfZW5hYmxlZChob3N0LT5wY2ll
MXY4KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWd1bGF0b3JfZGlzYWJsZShob3N0
LT5wY2llMXY4KTsNCj4gDQo+IFBsZWFzZSBtb3ZlIHRoaXMgYmVsb3cgdGhlIGNhbGwgdG8gcG1f
cnVudGltZV9kaXNhYmxlKCksIHRvIHByZXNlcnZlDQo+IHN5bW1ldHJ5Lg0KPiANCj4gPiAgICAg
ICAgIHBtX3J1bnRpbWVfcHV0KGRldik7DQo+ID4gICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUo
ZGV2KTsNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCg0KVGhhbmtzIGZvciB5b3VyIHBy
b2Zlc3Npb25hbCBzdWdnZXN0Lg0KSSB3aWxsIGltcHJvdmUgcGF0Y2hlcyBhbmQgc2VuZCB2MiBp
biBsYXRlcg0KDQpUaGFua3MsDQpMaW1lbmcNCg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBH
ZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBl
cnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxm
IGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qg
c2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
