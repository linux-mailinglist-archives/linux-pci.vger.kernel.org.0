Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBF7BB791
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjJFM3u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJFM3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 08:29:49 -0400
X-Greylist: delayed 1313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 05:29:47 PDT
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB7BC2;
        Fri,  6 Oct 2023 05:29:47 -0700 (PDT)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 396AZEx5027724;
        Fri, 6 Oct 2023 05:07:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint20171006; bh=Q0Y+W7UecbsCNiI2yzqMJOeNw3bSC2y20H7giP1sE
        EA=; b=R6TuzLqK5EbDZLs8KfA+XG5+fZxLQ7ld3mPrOn6ZGSHf9qnyDKMmnG4ax
        IeMBLBkNcDXwj2f5E/LW82IlfyssipIbCDemVxkzlpw9XJqT2j6sFCjTLHe9+Zrk
        dapoSofLwS9A/rNdt+D/AuPBiFryJDLWem28QG8q5FSF4AfatddFupiCe2epV1rc
        e3zd09jXFrJp/7s+2M7ePMguXdavH/uh0suCKAhWnpMhQT7+QeQQOKYwRPsLBeg2
        939I2J//bXIKn9TA9y3Tflx7/tvK3PBm7d0jGA4i/KvbdvLSjVwerkTuttz/91No
        A4adzQvAPAFqiF7D4FQWaqggn9wsQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tehsfnux5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 05:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLuPmN5qwqolqq0QJFIRNeUNL2/0u6Q0yaLpErQbHvDhet3XfEmFPGkL2dVm9ScGhRhE02bPsue6hNl5XZMZNLiGAtVufIoRfUm6u8APGSgwVZatDH7jtwqeAe/aUesztK6tBIg4PTzEK6vt/h+EUrFYbns/bs+W6mAU6zpAVs5Zr+tkanTcFEvzQmDL8fzB++2hgv/fI3Ioo2t60B6H/fpgqdE9YqVeHH9UIeTL8OtdbCSD9IfwXxDbD8/78yQZfrsRCAntSjJt406BTDmBFO5X8FxQ4g9rEzYOrT80CFizcOFRVnCwafSj8K1ONjmX4e1JxQr4rM112v7viyDvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0Y+W7UecbsCNiI2yzqMJOeNw3bSC2y20H7giP1sEEA=;
 b=AE4cfzVLrdMR5uEuBJgw2tEq/O9xhntl3n5GMaUut2rnqcoMx5yJnGExw4Q8R3dgsSxysD9ZVmXC9vbNaQQ468SSuDqrLVljbsJF0WpY0+uGjWVCTyWtlYfgYbP3b2hL1dBQasJlPeRCbkqRtwHfiLmvIIH41HGW9rpdcI29iuHooQOHyhAertIovvyiZ6Tuj6/C/RxqYRE/OCryWxmRDgZ97+CBXkBSu4Eavb5mD65+DVPk0aijdNTd9UlinyoGcVZM6SgPvwVIBJT8C5x+acrN64DQIAFLy4uhJIa8C8KW+N3PPwFFrQ54rJ7yqFiUFabVArmvSx6/rLJHjN4Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0Y+W7UecbsCNiI2yzqMJOeNw3bSC2y20H7giP1sEEA=;
 b=dGBYhImHoQIc2l18wTcERk1OaQBYAn9PAMP3LQKaVxYMuojTT1UvecTsX1MIZMaK2OVzY/AI/iaN5cIh0KnVPjqT0k3NkXB7CBbpQgy0BRsGf7eaBqaVUimwl7VRJabj6ter8I/jG4lup+8TtCkRPKwcB7rSRCiGFnsA6lG+UT+JS9IxQSTir5I5Q7qNmTzkKirQxz2mXtDpcBNV3y6iQ8Q4dvufd2L0PMmnSxX8PkGL1abahTCJyRxk7gtp2b6HpU3etlw2dGA4+tTgLmWVV0H8aEt4YkjsGFkd297P2vsTMMInMTRiviFOzYChuaoJbm/TDWlFY3WbsLGuSzxG/w==
Received: from DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) by
 DS0PR02MB9198.namprd02.prod.outlook.com (2603:10b6:8:11d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.38; Fri, 6 Oct 2023 12:07:07 +0000
Received: from DM8PR02MB8005.namprd02.prod.outlook.com
 ([fe80::1f51:b465:1e4e:89d7]) by DM8PR02MB8005.namprd02.prod.outlook.com
 ([fe80::1f51:b465:1e4e:89d7%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 12:07:07 +0000
From:   Thanos Makatos <thanos.makatos@nutanix.com>
To:     Shunsuke Mie <mie@igel.co.jp>,
        Mattias Nissler <mnissler@rivosinc.com>,
        Jagannathan Raman <jag.raman@oracle.com>
CC:     "cz172638@gmail.com" <cz172638@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "kvijayab@amd.com" <kvijayab@amd.com>,
        "kw@linux.com" <kw@linux.com>,
        "levon@movementarian.org" <levon@movementarian.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "vaishnav.a@ti.com" <vaishnav.a@ti.com>,
        Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: RE: [RFC] Proposal of QEMU PCI Endpoint test environment
Thread-Topic: [RFC] Proposal of QEMU PCI Endpoint test environment
Thread-Index: AQHZ9pWAqWelFvnzH0CFLWBAgUqlvrA6ajKAgABcgwCAAeL+AIAAAgAA
Date:   Fri, 6 Oct 2023 12:07:07 +0000
Message-ID: <DM8PR02MB800512C469062A721AC704578BC9A@DM8PR02MB8005.namprd02.prod.outlook.com>
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
 <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
 <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
In-Reply-To: <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8005:EE_|DS0PR02MB9198:EE_
x-ms-office365-filtering-correlation-id: dffb93c9-cbd0-4719-2090-08dbc664c2d9
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P10wt0KYj/nPZS9pKNgUKFx3zH4XpdEBZgwhUVnOWOFcCinWHfhHjR566Yckd3ktlYM0wek4GlxHnqVYHO6S3C9fmUryv8V63alBlYt4I8ablJLF2XB6fh2Dhjg2DB0JNOKGUp0n70cHr5V8UqCy2bEZIeX++Xmam3uucIU+akbIH7pxKDesD4F2XWto2XgJ0PMVCwTizkHvqtLioiejlegvBh6yx/7LyR+YxbnCxop521AItB+JjXNs6hTuTAQsdCYC5y3BQNbGafnqlkW9eCf5K5mTHLOTRIY5qVPH7wBnfDL0ZHYTLwSTqdJt85uhXyr+aGuEqM5150l0d3uiXxTq4yTFcl2d5FwfJrYRZYVAiKrYyaGQqB5SzQKhqUkw8LvZF9G0vxiOUYwos6EMBtTiMsxQ0tIJhMDAN7c220yWpf3wkAViy0y5uxYOFGKQS1+75HRtFNa6T3wO/a/3O0S5LIeJ47Zl/oWQ+bsnty5qsEey4k2Y3ULMKaTgDAICME+oHE3mQ66dirtdAWJlYYVpg8C346H49Z1TZ/CUBgULl2AuOzMXd25OqQ67AsaoO+rEoATwKq26VF0LM4pagkw/gQ0pXovvMLSDLwYr92bQBxKb8lqNnHJBmRLfcJjl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8005.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38100700002)(2906002)(44832011)(7416002)(5660300002)(8676002)(4326008)(52536014)(8936002)(41300700001)(316002)(66556008)(54906003)(64756008)(66946007)(66476007)(66446008)(76116006)(110136005)(55016003)(3613699003)(19627235002)(6506007)(7696005)(71200400001)(26005)(53546011)(33656002)(9686003)(86362001)(122000001)(38070700005)(83380400001)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1R5Y3dBSEdJRnIyYm5adHMwdTFOOUFhVTRiV3NKTWo0OUdvM0dRbE91alNi?=
 =?utf-8?B?YzFWSXR2Z1hjNlR5N3grWE8wYVp4N1dSWDNjWmNoMVB3dnZSdCszamZSVE4r?=
 =?utf-8?B?Z01tY0I4bXJtSm16ak03VzE3bElRRU5EZ1RhT29TWlN5M1ptNDd4a3JjOWFT?=
 =?utf-8?B?ekR3TitWa2lOenprWmxmWkVxcGdpbVA3L21tWHBvSEoxNWlWS3VwSmhCU3lH?=
 =?utf-8?B?cExPUXUvZWlaOThOZ0dic2EzZkRtVmRKd0h5eWpzL0lCRnByUUNub0IvR0p2?=
 =?utf-8?B?SjU3T1ZLbFJqd1RqZVViNmorWFNNVGtvd0U3SnU4SjdGU3ZjY0VqdXliLzhn?=
 =?utf-8?B?RkNKT3NpMjFGMlJNdE92WVE0c2dzY2tvRjJvRlhGaUh2NnFLUHppcVpTbUF6?=
 =?utf-8?B?UHZHRjlCSW9KL21VRm1oV3JhYjRaM2RDZ0J4WVRqemJYYWJzNHJScWNiL0Rx?=
 =?utf-8?B?UWJ2dVJHdWxBcWdFZmFOSHovcUJDN2JUcjV4dkJDUURaMHh4c1RLRU9IWEZE?=
 =?utf-8?B?OTRGRkIvbWE1TnM0MVUvQ0VzVWoveWhUcGRFNG5FSnZZSTI2L2VNSGdmTDJu?=
 =?utf-8?B?SSs2VStoWDlkdnU0WkZKZ1FnNFZWWjBjM2pYakRrd1hqNHlDdVJiaWpOZ0I0?=
 =?utf-8?B?TnB0b3A4V1NIbk1QNU9Tdk15bDRiM0ErYXdXZU12NlFvQTNYT3ZLTHdSOThG?=
 =?utf-8?B?VVNseXpoYTFGb3VGc2lNWkFWL2s3dnN0YU5Lbnl5NjhuTGFBOUoyVm9CQUlM?=
 =?utf-8?B?Q29iREE3RDJRR3BhaTlpM1lhNHQyYVIvc3hsRVIzWkN6K3I1eXkyMjR6Zk9m?=
 =?utf-8?B?R2ZWRGRCVTNtbFhwcU1IbURRQVByb3NmMmlha2UvTnJuTEw0SjBnTUhUYXBa?=
 =?utf-8?B?V3Y1WWVNSnkvUXEvdzI4K2UvSXcrZlZ2VUFzKzNUSFdCR2p0dFlTVVV2ZEhj?=
 =?utf-8?B?SU5BNlkwM0ZuelFzbWp3SVF6YWZRWDdxY2YwN0hQRm1RWHRwTW9ObVFnUFZp?=
 =?utf-8?B?YTRiNXFma3luMUlzK0w0OUg0WTVaVUd0NFJxcmdBTjVva1pqdlhKNU1VWFhH?=
 =?utf-8?B?WGZOdmNvTWtReW1BVnR4NHJKMFNJZU9VdDZuR0dwR2k5UzJoQS9aQXFxZkI3?=
 =?utf-8?B?UFRPTW5FNnhacSsvL3p5NzVqQjdYam05cGY3RThjWUorVnlueER3dnZiUG5C?=
 =?utf-8?B?V1JCMno5OWtEdG5obXF6OEl6TWttL0NnUnYwZFhqNmlmZllwT1d3TGxrUE1i?=
 =?utf-8?B?cjhBUVo5SzQ4cHBjS2prc0phYjNyQXVjU2ZPMVlLd3NqTFk4TGFmMDNpbXp3?=
 =?utf-8?B?RUhZYmNBcGFwY2FTZmdLWVpUYnJKaWFFVXNKRFlyMjhZeW1NOUlFb0RKYnk3?=
 =?utf-8?B?UE5RMlhlVEE2WVNIeUdoTFUzZ0NrbktSVlB3VWJxV1BNZXlYUmZaM3YwWnZ6?=
 =?utf-8?B?YXFFajRPVVBKT1NyL2hKL0Ivek1JNStsY3hrY3BSdHArZ1ZvNVJ4TUxVejFl?=
 =?utf-8?B?UzlQcHhpUVJBR2trT05uc3lyakdDR2NNOU02Q2NGeVBqVTlld2ZGNXhXMkxR?=
 =?utf-8?B?UnI1dzU2OVVJRS84REJEM2ZyZndJa2g3dWZ1ZkUxWU02dHdleUtHcUkrOFF1?=
 =?utf-8?B?Z2cxakI3TjFiMENUa05wb3V0N2N5eWRPRjVmdCthbkNpZU5PbTFwZG5LZ0xm?=
 =?utf-8?B?WS8xcXNFVkQxV0VZeVZLRGlnV1kyRll6K2poR2hFU0M2NUk5Zm1IWHcyeFJ4?=
 =?utf-8?B?K3IxTTVnTjY3UTdJWXcyYjd6UnpvZ0ZzampiVFhBSXFDekkwZEJYY0lnNVMv?=
 =?utf-8?B?b2FTN1hvZ2ZaNkVGdkMydW51UlVGNjJ5cGw2THJKWmFLZnA4VDJGaWZEZWda?=
 =?utf-8?B?QkxHT2ZPZEN0VTB0NTBSS3pXZ21XcXhERVQvZ3d1SW0rRWx6TktSMzZSRVBp?=
 =?utf-8?B?Y04zVE11QUt1akRHaVBVeGdLcVJFUE5LWS90dW45ME04U3M1VnN5dVhSYklW?=
 =?utf-8?B?TG5TMTZuNVJpSVNsd3pLM0ZPUmUyRDhWSThSYStSc2xvMjM4dW4zQ1JwR0wy?=
 =?utf-8?B?MFVpRFpKUGY4S2lWNlM1bEpFWW1mVVhtcCs4b0NpNGpKbUNjNUxJSjFBQnFM?=
 =?utf-8?Q?W48oc67yLhrJlYHSbfOaE4iv3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8005.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffb93c9-cbd0-4719-2090-08dbc664c2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 12:07:07.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5re9OWdeGCkPUf9wHMpNffxlfvdR6fM0w4qIUDRLk4FjONWDIgKvXz4VtlE98n09xpdpcZb8L8vJFW2FyqbE1EgnoSxJuq54aI191CUuO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9198
X-Proofpoint-GUID: 7GjjjPgYZCnJA5a26jjsyUpOSv6knr-x
X-Proofpoint-ORIG-GUID: 7GjjjPgYZCnJA5a26jjsyUpOSv6knr-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaHVuc3VrZSBNaWUgPG1pZUBp
Z2VsLmNvLmpwPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNiwgMjAyMyAxMjo1MSBQTQ0KPiBU
bzogTWF0dGlhcyBOaXNzbGVyIDxtbmlzc2xlckByaXZvc2luYy5jb20+DQo+IENjOiBjejE3MjYz
OEBnbWFpbC5jb207IGJoZWxnYWFzQGdvb2dsZS5jb207IEphZ2FubmF0aGFuIFJhbWFuDQo+IDxq
YWcucmFtYW5Ab3JhY2xlLmNvbT47IGtpc2hvbkBrZXJuZWwub3JnOyBrdmlqYXlhYkBhbWQuY29t
Ow0KPiBrd0BsaW51eC5jb207IGxldm9uQG1vdmVtZW50YXJpYW4ub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgbHBpZXJhbGlz
aUBrZXJuZWwub3JnOyBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsNCj4gTWFyY2Vs
IEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+OyBNaWNoYWVsIFMuIFRzaXJr
aW4NCj4gPG1zdEByZWRoYXQuY29tPjsgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNv
bT47IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IHJvYmhAa2VybmVsLm9yZzsgVGhhbm9zIE1h
a2F0b3MNCj4gPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsgdmFpc2huYXYuYUB0aS5jb207
IFdpbGxpYW0gSGVuZGVyc29uDQo+IDx3aWxsaWFtLmhlbmRlcnNvbkBudXRhbml4LmNvbT4NCj4g
U3ViamVjdDogUmU6IFtSRkNdIFByb3Bvc2FsIG9mIFFFTVUgUENJIEVuZHBvaW50IHRlc3QgZW52
aXJvbm1lbnQNCj4gDQo+IA0KPiBPbiAyMDIzLzEwLzA1IDE2OjAyLCBNYXR0aWFzIE5pc3NsZXIg
d3JvdGU6DQo+ID4gT24gVGh1LCBPY3QgNSwgMjAyMyBhdCAzOjMx4oCvQU0gU2h1bnN1a2UgTWll
IDxtaWVAaWdlbC5jby5qcD4gd3JvdGU6DQo+ID4+IEhpIEppcmksIE1hdHRpYXMgYW5kIGFsbC4N
Cj4gPj4NCj4gPj4gMjAyM+W5tDEw5pyINOaXpSjmsLQpIDE2OjM2IE1hdHRpYXMgTmlzc2xlciA8
bW5pc3NsZXJAcml2b3NpbmMuY29tPjoNCj4gPj4+PiBoaSBzaHVuc3VrZSwgYWxsLA0KPiA+Pj4+
IHdoYXQgYWJvdXQgdmZpby11c2VyICsgcWVtdT8NCj4gPj4gVGhhbmsgeW91IGZvciB0aGUgc3Vn
Z2VzdGlvbi4NCj4gPj4NCj4gPj4+IEZXSVcsIEkgaGF2ZSBoYWQgc29tZSBnb29kIHN1Y2Nlc3Mg
dXNpbmcgVkZJTy11c2VyIHRvIGJyaWRnZSBzb2Z0d2FyZQ0KPiBjb21wb25lbnRzIHRvIGhhcmR3
YXJlIGRlc2lnbnMuIEZvciB0aGUgbW9zdCBwYXJ0LCBJIGhhdmUgYmVlbiBob29raW5nIHVwDQo+
IHNvZnR3YXJlIGVuZHBvaW50IG1vZGVscyB0byBoYXJkd2FyZSBkZXNpZ24gY29tcG9uZW50cyBz
cGVha2luZyB0aGUgUENJZQ0KPiB0cmFuc2FjdGlvbiBsYXllciBwcm90b2NvbC4gVGhlIGNlbnRy
YWwgcGllY2UgeW91IG5lZWQgaXMgYSB3YXkgdG8gdHJhbnNsYXRlDQo+IGJldHdlZW4gdGhlIFZG
SU8tdXNlciBwcm90b2NvbCBhbmQgUENJZSB0cmFuc2FjdGlvbiBsYXllciBtZXNzYWdlcywgYmFz
aWNhbGx5DQo+IGNvbnZlcnRpbmcgRUNBTSBhY2Nlc3NlcywgbWVtb3J5IGFjY2Vzc2VzIChETUEr
TU1JTyksIGFuZCBpbnRlcnJ1cHRzDQo+IGJldHdlZW4gdGhlIHR3byB3b3JsZHMuIEkgaGF2ZSBz
b21lIGNvZGUgd2hpY2ggaW1wbGVtZW50cyB0aGUgYmFzaWNzIG9mIHRoYXQuDQo+IEl0J3MgY2Vy
dGFpbmx5IGZhciBmcm9tIGNvbXBsZXRlIChUTFAgaXMgYSBtYXNzaXZlIHByb3RvY29sKSwgYnV0
IGl0IHdvcmtzIHdlbGwNCj4gZW5vdWdoIGZvciBtZS4gSSBiZWxpZXZlIHdlIHNob3VsZCBiZSBh
YmxlIHRvIG9wZW4tc291cmNlIHRoaXMgaWYgdGhlcmUncyBpbnRlcmVzdCwNCj4gbGV0IG1lIGtu
b3cuDQo+ID4+IEl0IGlzIHdoYXQgSSB3YW50IHRvIGRvLCBidXQgSSdtIG5vdCBmYW1pbGlhciB3
aXRoIHRoZSB2ZmlvIGFuZCB2ZmlvLXVzZXIsIGFuZCBJDQo+IGhhdmUgYSBxdWVzdGlvbi4gUUVN
VSBoYXMgYSBQQ0kgVExQIGNvbW11bmljYXRpb24gaW1wbGVtZW50YXRpb24gZm9yIE11bHRpLQ0K
PiBwcm9jZXNzIFFFTVVbMV0uIEl0IGlzIHNpbWlsYXIgdG8geW91ciBzdWNjZXNzLg0KPiA+IEkn
bSBubyBxZW11IGV4cGVydCwgYnV0IG15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgcGxhbiBp
cyBmb3IgdGhlDQo+ID4gZXhpc3RpbmcgbXVsdGktcHJvY2VzcyBRRU1VIGltcGxlbWVudGF0aW9u
IHRvIGV2ZW50dWFsbHkgYmUNCj4gPiBzdXBlcnNlZGVkL3JlcGxhY2VkIGJ5IHRoZSBWRklPLXVz
ZXIgYmFzZWQgb25lIChxZW11IGZvbGtzLCBwbGVhc2UNCj4gPiBjb3JyZWN0IG1lIGlmIEknbSB3
cm9uZykuIEZyb20gYSBmdW5jdGlvbmFsIHBlcnNwZWN0aXZlIHRoZXkgYXJlIG1vcmUNCj4gPiBv
ciBsZXNzIGVxdWl2YWxlbnQgQUZBSUNULg0KPiA+DQo+IFRoZSBwcm9qZWN0IGlzIHByb21pc2lu
Zy4NCj4gDQo+IEkgZm91bmQgYSBzZXNzaW9uIGFib3V0IHRoZSB2ZmlvIGFkYXB0cyB0byBNdWx0
aS1wcm9jZXNzIFFFTVVbMV0gaW4gS1ZNDQo+IEZvcnVuIDIwMjEsIGJ1dEkgY291bGRuJ3QgZm91
bmQgc29tZSBwb3N0ZWQgcGF0Y2hlcy4NCj4gSWYgYW55b25lIGtub3dzIHN0YXR1cyBvZiB0aGlz
IHByb2plY3QsIGNvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtub3c/DQoNCkFGQUlLIHRoZSBtcC1x
ZW11IGZvbGsgYXJlIHdvcmtpbmcgb24gY29udGludWluZyBKSidzIHdvcmsgdG8gZW5hYmxlIHZm
aW8tdXNlciBjbGllbnQgb24gUUVNVSwgbm90IHN1cmUgYWJvdXQgdGhlIHRpbWVsaW5lLCBKYWcg
Y2FuIHlvdSBjb21tZW50Pw0KDQpZb3UgY2FuIHN0aWxsIHBsYXkgYXJvdW5kIHdpdGggdGhlaXIg
Zm9ya2VkIHZlcnNpb24gb2YgUUVNVSAod2hpY2ggdGhleSB1c2UgdG8gcG9zdCBwYXRjaGVzKSwg
dGhlIGxpYnZmaW8tdXNlciBkb2N1bWVudGF0aW9uIGV4cGxhaW5zIGhvdyB0byB1c2UgaXQuDQoN
Cj4gDQo+IFsxXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0
cHMtDQo+IDNBX193d3cueW91dHViZS5jb21fd2F0Y2gtM0Z2LQ0KPiAzRE5CVDhySW14M1ZFJmQ9
RHdJRGFRJmM9czg4M0dwVUNPQ2hLT0hpb2NZdEdjZyZyPVhUcFlzaDVQczJ6SnZ0DQo+IHc2b2d0
dGk0NmF0azczNlNJNHZnc0ppVUtJeURFJm09bEdiVXJQSFMxempWVlJpMFAtDQo+IHVrWjBUQWFi
Z2VmY2x6MjZRNTZQZ0h6S3c2b3hGcnRxZ3B2MWdfYURGOWhYWmsmcz1FVS0NCj4gS0E2NUdrMmpD
M3poaW1HU1g5Nk1mejNreFpuVTdncUowMEY0RzRETSZlPQ0KPiA+PiBUaGUgbXVsdGktcHJvY2Vz
cyBxZW11IGFsc28gY29tbXVuaWNhdGVzIFRMUCBvdmVyIFVEUy4gQ291bGQgeW91IGxldCBtZQ0K
PiBrbm93IHlvdXIgb3BpbmlvbiBhYm91dCBpdD8NCj4gPiBOb3RlIHRoYXQgbmVpdGhlciBtdWx0
aS1wcm9jZXNzIHFlbXUgbm9yIFZGSU8tdXNlciBhY3R1YWxseSBwYXNzDQo+ID4gYXJvdW5kIFRM
UHMsIGJ1dCByYXRoZXIgaGF2ZSB0aGVpciBvd24gY29tbWFuZCBsYW5ndWFnZSB0byBlbmNvZGUN
Cj4gPiBFQ0FNLCBNTUlPLCBETUEsIGludGVycnVwdHMgZXRjLiBIb3dldmVyLCB0cmFuc2xhdGlv
biBmcm9tL3RvIFRMUCBpcw0KPiA+IHBvc3NpYmxlIGFuZCB3b3JrcyB3ZWxsIGVub3VnaCBpbiBt
eSBleHBlcmllbmNlLg0KPiBJIGFncmVlLg0KPiA+Pj4gT25lIHRoaW5nIHRvIG5vdGUgaXMgdGhh
dCB0aGVyZSBhcmUgY3VycmVudGx5IHNvbWUgbGltaXRzIHRvIGJyaWRnaW5nIFZGSU8tdXNlcg0K
PiAvIFRMUCB0aGF0IEkgaGF2ZW4ndCBmaWd1cmVkIG91dCBhbmQvb3Igd2lsbCBuZWVkIGZ1cnRo
ZXIgd29yazogQWR2YW5jZWQgUENJZQ0KPiBjb25jZXB0cyBsaWtlIFBBU0lELCBBVFMvUFJJLCBT
Ui1JT1YgZXRjLiBtYXkgbGFjayBlcXVpdmFsZW50cyBvbiB0aGUgVkZJTy11c2VyDQo+IHNpZGUg
dGhhdCB3b3VsZCBoYXZlIHRvIGJlIGZpbGxlZCBpbi4gVGhlIGZvbGsgYmVoaW5kIGxpYnZmaW8t
dXNlclsyXSBoYXZlIGJlZW4gdmVyeQ0KPiBhcHByb2FjaGFibGUgYW5kIG9wZW4gdG8gaW1wcm92
ZW1lbnRzIGluIG15IGV4cGVyaWVuY2UgdGhvdWdoLg0KPiA+Pj4NCj4gPj4+IElmIEkgdW5kZXJz
dGFuZCBjb3JyZWN0bHksIHRoZSBzcGVjaWZpYyBnb2FsIGhlcmUgaXMgdGVzdGluZyBQQ0llIGVu
ZHBvaW50DQo+IGRlc2lnbnMgYWdhaW5zdCBhIExpbnV4IGhvc3QuIFdoYXQgeW91J2QgbmVlZCBm
b3IgdGhhdCBpcyBhIFBDSSBob3N0IGNvbnRyb2xsZXIgZm9yDQo+IHRoZSBMaW51eCBzaWRlIHRv
IHRhbGsgdG8gYW5kIHRoZW4gaG9va2luZyB1cCBlbmRwb2ludHMgb24gdGhlIHRyYW5zYWN0aW9u
IGxheWVyLg0KPiBRRU1VIGNhbiBzaW11bGF0ZSBob3N0IGNvbnRyb2xsZXJzIHRoYXQgd29yayB3
aXRoIGV4aXN0aW5nIExpbnV4IGRyaXZlcnMganVzdCBmaW5lLg0KPiBUaGVuIHlvdSBjYW4gcHV0
IGEgdmZpby11c2VyLXBjaSBzdHViIGRldmljZSAoSSBkb24ndCB0aGluayB0aGlzIGhhcyBsYW5k
ZWQgaW4gcWVtdQ0KPiB5ZXQsIGJ1dCB5b3UgY2FuIGZpbmQgdGhlIGNvZGUgYXQgWzFdKSBvbiB0
aGUgc2ltdWxhdGVkIFBDSSBidXMgd2hpY2ggd2lsbCBleHBvc2UNCj4gYW55IHNvZnR3YXJlIGlu
dGVyYWN0aW9ucyB3aXRoIHRoZSBlbmRwb2ludCBhcyBWRklPLXVzZXIgcHJvdG9jb2wgbWVzc2Fn
ZXMgb3Zlcg0KPiB1bml4IGRvbWFpbiBzb2NrZXQuIFRoZSBwaWVjZSB5b3UgbmVlZCB0byBicmlu
ZyBpcyBhIFZGSU8tdXNlciBzZXJ2ZXIgdGhhdA0KPiBoYW5kbGVzIHRoZXNlIG1lc3NhZ2VzLiBJ
dHMgdGFzayBpcyBiYXNpY2FsbHkgdHJhbnNsYXRpbmcgYmV0d2VlbiBWRklPLXVzZXIgYW5kDQo+
IFRMUCBhbmQgdGhlbiBpbmplY3RpbmcgVExQIGludG8geW91ciBoYXJkd2FyZSBkZXNpZ24uDQo+
ID4+IFllcywgSWYgdGhlIHBjaSBob3N0IGNvbnRyb2xsZXIgeW91IHNhaWQgY2FuIGJlIGltcGxl
bWVudGVkLCBJIGNhbiBhY2hpZXZlIG15DQo+IGdvYWwuDQo+ID4gSSBtZWFudCB0byBzYXkgdGhh
dCB0aGUgZXhpc3RpbmcgUENJZSBob3N0IGNvbnRyb2xsZXIgaW1wbGVtZW50YXRpb25zDQo+ID4g
aW4gcWVtdSBjYW4gYmUgdXNlZCBhcyBpcy4NCj4gU29ycnksIEkgbWlzdW5kZXJzdG9vZC4NCj4g
Pj4gVG8gYmVnaW4gd2l0aCwgSSdsbCBpbnZlc3RpZ2F0ZSB0aGUgdmZpbyBhbmQgbGlidmZpby11
c2VyLiAgVGhhbmtzIS4NCj4gPj4NCj4gPj4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0NCj4gM0FfX3d3dy5xZW11Lm9yZ19kb2NzX21hc3Rlcl9z
eXN0ZW1fbXVsdGktDQo+IDJEcHJvY2Vzcy5odG1sJmQ9RHdJRGFRJmM9czg4M0dwVUNPQ2hLT0hp
b2NZdEdjZyZyPVhUcFlzaDVQczJ6SnZ0dw0KPiA2b2d0dGk0NmF0azczNlNJNHZnc0ppVUtJeURF
Jm09bEdiVXJQSFMxempWVlJpMFAtDQo+IHVrWjBUQWFiZ2VmY2x6MjZRNTZQZ0h6S3c2b3hGcnRx
Z3B2MWdfYURGOWhYWmsmcz1RVzVndDJTbEN2R1U4VDIwTDINCj4gUG9QRVhfd2VpZGJHZm54aVlQ
bVZBRW5WUSZlPQ0KPiA+Pg0KPiA+PiBCZXN0LA0KPiA+PiBTaHVuc3VrZQ0KPiA+Pj4NCj4gPj4+
IFsxXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtDQo+
IDNBX19naXRodWIuY29tX29yYWNsZV9xZW11X3RyZWVfdmZpby0yRHVzZXItDQo+IDJEcDMuMSZk
PUR3SURhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1YVHBZc2g1UHMyekp2dHc2b2d0dGk0
Ng0KPiBhdGs3MzZTSTR2Z3NKaVVLSXlERSZtPWxHYlVyUEhTMXpqVlZSaTBQLQ0KPiB1a1owVEFh
YmdlZmNsejI2UTU2UGdIekt3Nm94RnJ0cWdwdjFnX2FERjloWFprJnM9bDhkR1lyTDJvSm1jVW9E
MjJBDQo+IG1RcWJEdWttWTVVQV9JZlNBY21kTXZuUEkmZT0gIC0gSSBiZWxpZXZlIHRoYXQncyB0
aGUgbGF0ZXN0IHZlcnNpb24sDQo+IEphZ2FubmF0aGFuIFJhbWFuIHdpbGwga25vdyBiZXN0DQo+
ID4+PiBbMl0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LQ0KPiAzQV9fZ2l0aHViLmNvbV9udXRhbml4X2xpYnZmaW8tDQo+IDJEdXNlciZkPUR3SURhUSZj
PXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1YVHBZc2g1UHMyekp2dHc2b2d0dGk0NmENCj4gdGs3
MzZTSTR2Z3NKaVVLSXlERSZtPWxHYlVyUEhTMXpqVlZSaTBQLQ0KPiB1a1owVEFhYmdlZmNsejI2
UTU2UGdIekt3Nm94RnJ0cWdwdjFnX2FERjloWFprJnM9TXFLNHlSeEJqT1ZPTHBwbk4NCj4ga19U
WXBnN3A1Z1VnMmcxQ1c1V3Q3NHVwMUUmZT0NCj4gPj4+DQo=
