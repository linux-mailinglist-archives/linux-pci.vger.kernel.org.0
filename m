Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F784ECAE5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbiC3Rmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbiC3Rmh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 13:42:37 -0400
X-Greylist: delayed 12482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 10:40:49 PDT
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99348F4613;
        Wed, 30 Mar 2022 10:40:49 -0700 (PDT)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22UB8Ivw021407;
        Wed, 30 Mar 2022 10:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Skw3Th1LtJQtNBurO/FgKhsAym7SqsBbxX9TuXKw2+8=;
 b=LAO7C+a5Vo2MOVmboYKBVUCzY2CzH1WwfxtkfmUsVOlizO1AIC7nuWl8RTi+WEOO2e4C
 aIp53TzJQ5Vip+Hx2v9Qy1Qe0xPZWfjPoxbYSLjiYF+bfYkX+E4C2cD6972sfrYj2Afx
 YyByGsYG0J9+4+D9EETWV5StWi0JjaOU5JqOh1fzMuo6E/OdObzIYdgmos6xPiokSvSd
 eZqB20t9/VzUx7ECU3dpoXtug+Ux4hN1vgsUHua2F/krGM7kYfBMBp42ZnknLV1Zl6Tm
 u6uGLHedzQFvkpnp0fgHhVUPwiq0New2mqA0GIdeWsHzJR5S5646F5I0WsCjuBGdcbTG XA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3f1ygp9vt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 10:12:21 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22UE6dJg010169;
        Wed, 30 Mar 2022 10:12:21 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3f3xxat0ma-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 10:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMpChTstsY2k+wskSW9MaOGWJnyl0iWXToNfe1HkqpSDa/XZzrnfHFdZhrxmI1C0clYqqPlF5V5YyuOYkqw4KEQVqwXmAhks6P/rYoXtZQdAhgXV384YnieeYySX18e3eqBdKmlCGeziVnyxf1TzXmqQPxYuOmVBVzhdAKbPNeh6+bZjRbjnXlzssM89KD9sihpZ9LJr0csXWwnftNcYoo0MesTmMVCqO/15cGcXSf6oMSbDUmn6p47efq72VRz2VPUwM8ZFJ3saHlIX/3gcHZhyqCWOtDytw+BJ7aZ6M04IXyfx637ckfxoAVAkj3GolXV6Zznd4woagsVWSHoVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skw3Th1LtJQtNBurO/FgKhsAym7SqsBbxX9TuXKw2+8=;
 b=YOAWC+E0PYNG9J+8Fnb72XHKoSkV7yfGefO65a0V44NI6YHpeFi2H4ZzBxCsOmMhuRA7wu6zjEfYZp1P+I9by+qQ5ib5E/5g2FklYGiLyn7f2Zd9s9nmVSp2ePY/g/QxcLkDGWwTzfeTDEYhrmu3+PWGGVw8eAu11yaeqle6acXQ5oQgvThk1rWgKuWNVu1ktUV3y5OHVle8I/+jcstJQBJPRp1ra8O/XcuObW2WoMN4fiDYj3616IRGN/ESK9FX+gJxdxZ5tzAp45rADO7eccoPhVfHAUs4Q+7XtyXVRCgDgLxj0p+xX/rG7bxRuA64S0qlou8IOpt4pOZ50LiseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 14:12:18 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c6b:dc8e:9cc7:51d7]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c6b:dc8e:9cc7:51d7%9]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:12:18 +0000
From:   "Belanger, Martin" <Martin.Belanger@dell.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Tanjore Suresh <tansuresh@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
Thread-Topic: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
Thread-Index: AQHYQvg1a4UNL75cPUaNZ3JjCi5nlKzVf2aAgAJ2+rA=
Date:   Wed, 30 Mar 2022 14:12:18 +0000
Message-ID: <SJ0PR19MB4544C3854D2C68853A6E8EA8F21F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220328230008.3587975-1-tansuresh@google.com>
 <20220328230008.3587975-2-tansuresh@google.com>
 <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
In-Reply-To: <CAOSf1CHnaKrSH0XwKMBuUmMAuc2q6MaHaZPqVoUia9MYqMjgGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-03-30T14:11:53Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=291fc1d8-2e29-4620-9542-3aa0ecddad95;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec1ef4e-44e7-4c35-1140-08da12574ce9
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_
x-microsoft-antispam-prvs: <DM6PR19MB35646DFB8A3BAA2341154CAFF21F9@DM6PR19MB3564.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A93g1aumSm6sWEUHlunNt1oPB4ucGtmiQ7YEIqoTVss2swN3kKSXV1JPOKWoaIMfJEhb6rMI0j9gEgF/qGYiagrg5sVl9/IkzccdS4CSKprgWeizOv+JW+/gZKFCK71Llb5xTMKarqCg0euG0hlCxcfZNIf4PD0RvmPpFeHkjLNTNsMDIgsuIP2xSqVRNHp2sRZizvd/sujNssPfvprvWr4TOI0bk+vJgYjV/PS9Os8T36gSjuvTXfWK6erpFY5QkxK8LGQxJbf/kq2vNNRsA136bvsrhmSUqcCq0U1lexNc3zFDl+DpioRDsqMEsGoPRq0MpBn8LZUOJNPio+/hMpEEH0HF4IrsKtOMo6c+pP7EFpWpy52/6gZSk7gR0vL4DeSApZSvtkPZK0QVOdMUd8bxRC1J44L0MA/jmnR4bfSCUygUhzgyp6TCzKwhMUGPefXihc1cfoevU/GOdE++DmGOaOadY3TtIJcLldvDP5HRwYqOZbsWkki8bccdtCoH7iPa4OMEpO3bZposD5tqG6vijeVBJfSVK9TEQhU9bEvB3CzPzEgJXOfo+0i+3YhDYfKLAK0Vw1URVILKYp6GYRhy2X40i8JgWMLNfswG66vFWoa0CYAX70mkZ7GXNfxcz2ECDBUmp4UC67asWVT94uKqEtI5B94WCyRQUp3LlwD1REyy4xIOra59aYRLjfrBlmPqpJ2b1ulGzEgFhnIS6ig7lcOLrypPaxybJYHMtUzN1ItQgxwNKPijWyVedT1TA8TxucX1mZMNHPzbgWHaG8PbA/081IR6xH+7SyxF03Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(122000001)(38100700002)(7416002)(5660300002)(8676002)(9686003)(4326008)(82960400001)(8936002)(71200400001)(52536014)(33656002)(83380400001)(53546011)(76116006)(7696005)(186003)(6506007)(26005)(966005)(55016003)(786003)(110136005)(38070700005)(66556008)(66476007)(508600001)(316002)(66446008)(54906003)(2906002)(66946007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHI2d0lmYm1ZRm5CekFKRTcvU00vbE5Sa2V5cDYrZytzNWFEbjYzM1NDSlht?=
 =?utf-8?B?SzBibnZkdENhWUx0THlTNlhGcjBLcUkyYXlWODUxVm1XbnBVQkYyek16Zmxr?=
 =?utf-8?B?STFqNzdHWjc4OHI5NkErOStEV1Q3anJ1QmpkL09PdU9jNW5qeVdINUpBMith?=
 =?utf-8?B?SEllSzFadVp2NmR2R0hyWVlNN2dDU0g4VW9wS1c2b1JRUzliQytmeWwyZWZk?=
 =?utf-8?B?Q2ExWldsTWswcS80d28ySzUrNUYyUG0wU3NPZ3lFQVAydHVtRERhZzE3S1Za?=
 =?utf-8?B?OUU1dzE0bkR5c3plTTVHYzdXWXNvY3UrSW9nMVlwU3N3OCttYmdEMDd4dG0z?=
 =?utf-8?B?Sk4zaS9hS0RscWhmcjNndDI3WGV0TlYyRHJwK2ZCVVk2WkM3aXdUaVVGeEJm?=
 =?utf-8?B?alYyN2hYZ3ZxRGhwRFhZdW9nRmRzcjRVcFAyRGlVbVZCS2Y4VFBHUlVQUjFx?=
 =?utf-8?B?K3ZVT2MrK2lhelN6d2hsMlFyait5dTQ2eDVlcjdYdFZtZ1JkQnEzVmdXUkpz?=
 =?utf-8?B?SWZSMFNCS2EwN3BENTdncGNhNUlUclRFRENoZ25yckNyY0p4QzJJOGNTbEJx?=
 =?utf-8?B?VllFVVdKV0dGdDcwcjJrb2s2MS9NSDR5OTQzS201TGdRajY0dUFmbkx0TmQ0?=
 =?utf-8?B?SE4rbDFTQ3dNQXZEWnp0RWFYTWl6dndSRzU3THdVWTA3cElqaUlWOUVWTzY1?=
 =?utf-8?B?eEF2VkROUVJ1cTZ6UmpER3V0MWs4SDN6OEhLb0w2RUZrbTEzVXdMaUl3NUN4?=
 =?utf-8?B?R2UxTXljZkxLMS9ORVFISHlveWUzeDN5aHdOWk1oMTFicVErbXVSSTlSQUJs?=
 =?utf-8?B?MXZwMHJjTytoZGFiM0ZzaWtFdWIrYm43VFV1dTZLYk9BSE5LbjM4N2R4NTBN?=
 =?utf-8?B?QVA3aTBxQ0ZNUmNjUjhqdXhwOHFkNDYvRzhoa1paLzVQQUpkZWg3ZXhvejhl?=
 =?utf-8?B?R3MxOXhFUjZGVWdkMTBVdnBFOThTaCtFWGpqZDkwK1NJc3k2b0JtOWlGaGxq?=
 =?utf-8?B?cXdoMHNVaC81Y0ZOZkszSnZkN1BBNmI3WUxiUDI5WG5Hem5vN0ZVVThjbzdC?=
 =?utf-8?B?Y0t1TWJqbGpyRDBuV09PWWZxRld3RFdYU3pRZHcxSDdoYWIxZGQ1TFlxNzZN?=
 =?utf-8?B?U0o0eEU2aS9ZWEJ6K2VoWVlHVklTWk1UVzNOcGtIRjFXdHBZak1rR0Y2eXRR?=
 =?utf-8?B?Unhqa2pLd2NLZU5oWERvcWtqbFhlNzlpQ1ZxUlZaY1BjWWREcUlxQTl4ejRu?=
 =?utf-8?B?QnA4VnZ4QTZ6bWFITkNDd1ViWHg3c2hVRWgvdEc0Zys2S3hXTzJreVR4TnRt?=
 =?utf-8?B?RldBTjVaaDNRYVlVekZhcXN5Rmh5SzdLcmhOMUhRZHN4RFJKTVBKeExaekND?=
 =?utf-8?B?NjZEOUdFMi9LcktZL3hqa1ZTaE44bzYrSDZKVU0xZjkrdmhUcFZJQTZHdE5K?=
 =?utf-8?B?dzhJNU1GR2xUN2N0dUVMUnV5QlJJTU9QZWx3WXluczVxME1HTUtGdW12TVB0?=
 =?utf-8?B?NzBTdkVJeVJzWnhET25kbVp1RGdoQ2NYY2hBV0JNdXpUd01uWGxOQ3p2QW0w?=
 =?utf-8?B?NVc3ZGFkTklYYTBkeXBLZ0h2Y0hCemlKTlhJY2FKZ0Y1Z0k1Y01oRWF5bUMr?=
 =?utf-8?B?YUhTeU1RTCtFZzROZHhPcDNMamJxTGw4emNEODlFMjRiRWJaRW5COFRhV3hD?=
 =?utf-8?B?azQwWXlkcnIrcUF4UldmeVZxbk5CcnRwSkdvNUlydnltYlRXMEdwQ0liSmll?=
 =?utf-8?B?TUpqMWFjelFuL2hVaWhZSGZBT0UzOWJ4UFdpWXllVmlGanQvM1Z0QWlVSXE2?=
 =?utf-8?B?QWtnbkliZHdXMG15eDFtWmQwNVpraDdqOUxrM0ZCL01rSVBwc0V3NnVna2pK?=
 =?utf-8?B?ZlBLTGk1YjJTK3owbUQ4Um1mOUVTdG1ZV1p6R3dha0dVaUxWWHc1UklKZEZr?=
 =?utf-8?B?STJyZEpOcTZ6TzBvdmNxRG1mRFlaWnA5dlJjUTlxT2pIck82eFc1NnRQalJv?=
 =?utf-8?B?dDRrK0x4U3dibkZVYkp4VWlOR0VtZmk2cm5mTUIrcWJ4NWNISzg0Z1ptNVU4?=
 =?utf-8?B?VmN1blRRNmEveVNPYVphM1RPYTV0Ujc3bHp1Z2hmNVJrUW5NNVUvemFRVVBs?=
 =?utf-8?B?dXd0WkJsYWtaTWFNQ0ZXNGxmMlg5VyszelZQTDlSeGNQVGViZFpjTGFWT2wy?=
 =?utf-8?B?VkxpVTJwTlR0RWpCNHN0R0FKYW5ZQWlEVHNWakhPc0tZK0h4aEVFMi95ek5B?=
 =?utf-8?B?TlNWWTEzc0JMVU9NL0xhUGJxa0tkUk5YeGJQdE5sRURWZ0xBT3pmRVR6TDZs?=
 =?utf-8?B?Q05mejExMktEUzdsYWNnZU03TUJSaHRiWWQrK2F0YjVyeUdCSUd4ekxBR2Jp?=
 =?utf-8?Q?eQKCxe9jF4xpLRhQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec1ef4e-44e7-4c35-1140-08da12574ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 14:12:18.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvUYcCDNm5mJvC/QOYPkgTFHfhxIvhHEWPH1cafPYKNp+Sr5uzO/2NAmcsFGbIRojVpwKnz/IPzUF2qT/EVY99lYkScn9BLomYCb/BBI5gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_04,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300070
X-Proofpoint-ORIG-GUID: DMftiR91b9B6Ic-Tnu8Cb8KkT9FcBLab
X-Proofpoint-GUID: DMftiR91b9B6Ic-Tnu8Cb8KkT9FcBLab
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBMaW51eC1udm1lIDxsaW51eC1udm1lLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9y
Zz4gT24gQmVoYWxmIE9mDQo+IE9saXZlciBPJ0hhbGxvcmFuDQo+IFNlbnQ6IE1vbmRheSwgTWFy
Y2ggMjgsIDIwMjIgODoyMCBQTQ0KPiBUbzogVGFuam9yZSBTdXJlc2gNCj4gQ2M6IEdyZWcgS3Jv
YWgtSGFydG1hbjsgUmFmYWVsIEogLiBXeXNvY2tpOyBDaHJpc3RvcGggSGVsbHdpZzsgU2FnaSBH
cmltYmVyZzsNCj4gQmpvcm4gSGVsZ2FhczsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdDsgbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcGNpDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMS8zXSBkcml2ZXIgY29yZTogU3VwcG9ydCBhc3luY2hyb25vdXMgZHJpdmVy
IHNodXRkb3duDQo+IA0KPiANCj4gT24gVHVlLCBNYXIgMjksIDIwMjIgYXQgMTA6MzUgQU0gVGFu
am9yZSBTdXJlc2ggPHRhbnN1cmVzaEBnb29nbGUuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRo
aXMgY2hhbmdlcyB0aGUgYnVzIGRyaXZlciBpbnRlcmZhY2Ugd2l0aCBhZGRpdGlvbmFsIGVudHJ5
IHBvaW50cyB0bw0KPiA+IGVuYWJsZSBkZXZpY2VzIHRvIGltcGxlbWVudCBhc3luY2hyb25vdXMg
c2h1dGRvd24uIFRoZSBleGlzdGluZw0KPiA+IHN5bmNocm9ub3VzIGludGVyZmFjZSB0byBzaHV0
ZG93biBpcyB1bm1vZGlmaWVkIGFuZCByZXRhaW5lZCBmb3INCj4gPiBiYWNrd2FyZCBjb21wYXRp
YmlsaXR5Lg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2VzIHRoZSBjb21tb24gZGV2aWNlIHNodXRkb3du
IGNvZGUgdG8gZW5hYmxlIGRldmljZXMgdG8NCj4gPiBwYXJ0aWNpcGF0ZSBpbiBhc3luY2hyb25v
dXMgc2h1dGRvd24gaW1wbGVtZW50YXRpb24uDQo+IA0KPiBuaWNlIHRvIHNlZSBzb21lb25lIGxv
b2tpbmcgYXQgaW1wcm92aW5nIHRoZSBzaHV0ZG93biBwYXRoDQoNCkFncmVlZCENCg0KSSBrbm93
IHRoaXMgcGF0Y2ggaXMgbWFpbmx5IGZvciBQQ0kgZGV2aWNlcywgaG93ZXZlciwgTlZNZSBvdmVy
IEZhYnJpY3MgDQpkZXZpY2VzIGNhbiBzdWZmZXIgZXZlbiBsb25nZXIgc2h1dGRvd25zLiBMYXN0
IFNlcHRlbWJlciwgSSByZXBvcnRlZCANCnRoYXQgc2h1dHRpbmcgZG93biBhbiBOVk1lLW9GIFRD
UCBjb25uZWN0aW9uIHdoaWxlIHRoZSBuZXR3b3JrIGlzIGRvd24gDQp3aWxsIHJlc3VsdCBpbiBh
IDEtbWludXRlIGRlYWRsb2NrLiBUaGF0J3MgYmVjYXVzZSB0aGUgZHJpdmVyIHRyaWVzIHRvIHBl
cmZvcm0gDQphIHByb3BlciBzaHV0ZG93biBieSBzZW5kaW5nIGNvbW1hbmRzIHRvIHRoZSByZW1v
dGUgdGFyZ2V0IGFuZCB0aGUgDQp0aW1lb3V0IGZvciB1bmFuc3dlcmVkIGNvbW1hbmRzIGlzIDEt
bWludXRlLiBJZiBvbmUgbmVlZHMgdG8gc2h1dCBkb3duIA0Kc2V2ZXJhbCBOVk1lLW9GIGNvbm5l
Y3Rpb25zLCBlYWNoIGNvbm5lY3Rpb24gd2lsbCBiZSBzaHV0IGRvd24gc2VxdWVudGlhbGx5IA0K
dGFraW5nIGVhY2ggMSBtaW51dGUuIFRyeSBydW5uaW5nICJudm1lIGRpc2Nvbm5lY3QtYWxsIiB3
aGlsZSB0aGUgbmV0d29yayANCmlzIGRvd24gYW5kIHlvdSdsbCBzZWUgd2hhdCBJIG1lYW4uIE9m
IGNvdXJzZSwgdGhlIEtBVE8gaXMgc3VwcG9zZWQgdG8gDQpkZXRlY3Qgd2hlbiBjb25uZWN0aXZp
dHkgaXMgbG9zdCwgYnV0IGlmIHlvdSBoYXZlIGEgbG9uZyBLQVRPIChlLmcuIDIgbWludXRlcykN
CnlvdSB3aWxsIG1vc3QgbGlrZWx5IGhpdCB0aGlzIGNvbmRpdGlvbi4NCg0KSGVyZSdzIHRoZSBw
YXRjaCBJIHByb3Bvc2VkIGluIFNlcHRlbWJlciwgd2hpY2ggc2hvcnRlbnMgdGhlIHRpbWVvdXQg
dG8gDQo1IHNlYyBvbiBhIGRpc2Nvbm5lY3QuDQoNCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L3BpcGVybWFpbC9saW51eC1udm1lLzIwMjEtU2VwdGVtYmVyLzAyNzg2Ny5odG1sDQoNClJlZ2Fy
ZHMsDQpNYXJ0aW4gQmVsYW5nZXINCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW5qb3JlIFN1
cmVzaCA8dGFuc3VyZXNoQGdvb2dsZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmFzZS9j
b3JlLmMgICAgICAgIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gPiAgaW5jbHVkZS9saW51eC9kZXZpY2UvYnVzLmggfCAxMCArKysrKysrKysrDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9jb3JlLmMgYi9kcml2ZXJzL2Jhc2UvY29yZS5jIGlu
ZGV4DQo+ID4gM2Q2NDMwZWIwYzZhLi4zNTllNzA2N2U4YjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9iYXNlL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9jb3JlLmMNCj4gPiBAQCAt
NDQ3OSw2ICs0NDc5LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZGV2aWNlX2NoYW5nZV9vd25lcik7
DQo+ID4gKnNuaXAqDQo+IA0KPiBUaGlzIGFsbCBzZWVtcyBhIGJpdCBkYW5nZXJvdXMgYW5kIEkn
bSB3b25kZXJpbmcgd2hhdCBzeXN0ZW1zIHlvdSd2ZSB0ZXN0ZWQNCj4gdGhlc2UgY2hhbmdlcyB3
aXRoLiBJIGhhZCBhIGxvb2sgYXQgaW1wbGVtZW50aW5nIHNvbWV0aGluZyBzaW1pbGFyIGEgZmV3
IHllYXJzDQo+IGFnbyBhbmQgb25lIGNhc2UgdGhhdCBhbHdheXMgY29uY2VybmVkIG1lIHdhcyBl
bWJlZGRlZCBzeXN0ZW1zIHdoZXJlIHRoZQ0KPiBQQ0llIHJvb3QgY29tcGxleCBhbHNvIGhhcyBh
IGRyaXZlciBib3VuZC4NCj4gU2F5IHlvdSd2ZSBnb3QgdGhlIGZvbGxvd2luZyBQQ0llIHRvcG9s
b2d5Og0KPiANCj4gMDA6MDAuMCAtIHJvb3QgcG9ydA0KPiAwMTowMC4wIC0gbnZtZSBkcml2ZQ0K
PiANCj4gV2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBkZXZpY2Vfc2h1dGRvd24o
KSB3ZSBjYW4gZ3VhcmFudGVlIHRoYXQNCj4gdGhlIGNoaWxkIGRldmljZSAodGhlIG52bWUpIGlz
IHNodXQgZG93biBiZWZvcmUgd2Ugc3RhcnQgdHJ5aW5nIHRvIHNodXQgZG93biB0aGUNCj4gcGFy
ZW50IGRldmljZSAodGhlIHJvb3QgY29tcGxleCkgc28gdGhlcmUncyBubyBwb3NzaWJpbGl0eSBv
ZiBkZWFkbG9ja3MgYW5kDQo+IG90aGVyIGRlcGVuZGVuY3kgaGVhZGFjaGVzLiBXaXRoIHRoaXMg
aW1wbGVtZW50YXRpb24gb2YgYXN5bmMgc2h1dGRvd24gd2UNCj4gbG9zZSB0aGF0IGd1YXJhbnRl
ZSBhbmQgSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGNvbnNlcXVlbmNlcyBhcmUuIFBlcnNvbmFsbHkg
SQ0KPiB3YXMgbmV2ZXIgYWJsZSB0byBjb252aW5jZSBteXNlbGYgaXQgd2FzIHNhZmUsIGJ1dCBt
YXliZSB5b3UncmUgYnJhdmVyIHRoYW4gSQ0KPiBhbSA6KQ0KPiANCj4gVGhhdCBhbGwgc2FpZCwg
dGhlcmUncyBwcm9iYWJseSBvbmx5IGEgZmV3IGtpbmRzIG9mIGRldmljZSB0aGF0IHdpbGwgcmVh
bGx5IHdhbnQgdG8NCj4gaW1wbGVtZW50IGFzeW5jIHNodXRkb3duIHN1cHBvcnQgc28gbWF5YmUg
eW91IGNhbiByZXN0cmljdCBpdCB0byBsZWFmIGRldmljZXMNCj4gYW5kIGZsaXAgdGhlIG9yZGVy
aW5nIGFyb3VuZCB0byBzb21ldGhpbmcNCj4gbGlrZToNCj4gDQo+IGZvcl9lYWNoX2RldmljZShk
ZXYpIHsNCj4gICAgaWYgKGNhbl9hc3luYyhkZXYpICYmIGhhc19ub19jaGlsZHJlbihkZXYpKQ0K
PiAgICAgICBzdGFydF9hc3luY19zaHV0ZG93bihkZXYpDQo+IH0NCj4gd2FpdF9mb3JfYWxsX2Fz
eW5jX3NodXRkb3duc190b19maW5pc2goKQ0KPiANCj4gLy8gdGVhciBkb3duIHRoZSByZW1haW5p
bmcgc3lzdGVtIGRldmljZXMgc3luY2hyb25vdXNseQ0KPiBmb3JfZWFjaF9kZXZpY2UoZGV2KQ0K
PiAgICBkb19zeW5jX3NodXRkb3duKGRldikNCj4gDQo+ID4gIC8qDQo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvZGV2aWNlL2J1cy5oIGIvaW5jbHVkZS9saW51eC9kZXZpY2UvYnVzLmgN
Cj4gPiBpbmRleCBhMDM5YWI4MDk3NTMuLmUyNjE4MTk2MDFlOSAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2RldmljZS9idXMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZGV2aWNl
L2J1cy5oDQo+ID4gQEAgLTkzLDYgKzEwMSw4IEBAIHN0cnVjdCBidXNfdHlwZSB7DQo+ID4gICAg
ICAgICB2b2lkICgqc3luY19zdGF0ZSkoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgICAgICAg
IHZvaWQgKCpyZW1vdmUpKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gICAgICAgICB2b2lkICgq
c2h1dGRvd24pKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gKyAgICAgICB2b2lkICgqc2h1dGRv
d25fcHJlKShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICsgICAgICAgdm9pZCAoKnNodXRkb3du
X3Bvc3QpKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IA0KPiBDYWxsIHRoZW0gc2h1dGRvd25fYXN5
bmNfc3RhcnQoKSAvIHNodXRkb3duX2FzeW5jX2VuZCgpIG9yIHNvbWV0aGluZyBJTU8uDQo+IFRo
ZXNlIG5hbWVzIGFyZSBub3QgYXQgYWxsIGhlbHBmdWwgYW5kIHRoZXkncmUgZWFzeSB0byBtaXgg
dXAgdGhlaXIgcm9sZSB3aXRoDQo+IHRoZSBjbGFzcyBiYXNlZCBzaHV0ZG93bl9wcmUgLyBfcG9z
dA0KDQo=
