Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D856D4C0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGKGcM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGKGcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 02:32:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211DC9FDE;
        Sun, 10 Jul 2022 23:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEK9+PB0a0xwYDu3Y2pDWcxM7d6EdFu/f/9/1TnM2+QYWaQck6cdY3qzCm2BO2Z3BNMtpnzOhkOOEauPoj/d6NXwyLUZL2UuEwJuFqCIHI2ivLatwPRZAMQULTF3rLZOmWxbAXugaqfupXjZ05BFiZr2yctVYDoIgXw5yXLGFe54uA3In3ZX+pRzIPcL2jINuhJL9msXqUnX70ge3S3MN8IgpLxmsdB6CtHZjjlhXOuWMTWxz7iH3fjKAbw6x8OFaYDFiPa8mnc8SOu7b1UhwvrjiK02vrrNvPZuGTRkHggpXfIjerbTZMR3Ot11uNaYO5Jy6Y9Bx+LBqpf09Alwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wRS5ZKZGwMNmkz0XCxtcJVV41+oJWJ2FSD9/NTv3L4=;
 b=MbaFjKBdpv8nFrLmnrljVAIatAEEosgCK1Rrd4G/+y1sqN0K2GeJk/72r9YHkyrsZYvQyTctn0m0R1fm1AR57xOmYUUc5qCi470TizBPhAzjsoBwNCOdNm5BCUhbiBfXU5huZzhuxpWChgfpLilWfPCDVsAGofhTLyJot51JutwlYbvG/pogkegJeG+hMqw1cXAvHwwI4zAdzXBXIF0G7lQ5pW06B2TfWKM8M1TDXfHFgppsIfVsYjUKixemyFVO53LKbWdidKIsr07JS1J5OSmVlIc8e4gKP7q1CiXAaPf13reazPL9BVBiOi8wpsnQmehUf996TXcCsD1jP3IKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wRS5ZKZGwMNmkz0XCxtcJVV41+oJWJ2FSD9/NTv3L4=;
 b=oV1/V1dx8pshsBPrjQQvbMFeIOq7cTwQgrKiIQY1mrQe+yxynpDrlalqwHc6u9tDW02Q2lMg+Z8Kh9K5CUsxUjYrleTdo8sCt58e11V1DLpNAhO69k/vNKScP9rlDiDJIG8owHg9Mxmx/N8wDUXAkCxoSwIuSiN7eItGN6z8qYA=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB4790.namprd05.prod.outlook.com (2603:10b6:a03:46::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.10; Mon, 11 Jul
 2022 06:31:58 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f04f:38dd:7a3d:e6ae]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f04f:38dd:7a3d:e6ae%4]) with mapi id 15.20.5438.010; Mon, 11 Jul 2022
 06:31:58 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Nadav Amit <namit@vmware.com>, Matthew Wilcox <willy@infradead.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Thread-Topic: [PATCH] MMIO should have more priority then IO
Thread-Index: AQHYiw9MIzjUV7s8202eNjeTozcWMq1lHkCAgA9GoQCAABllAIAAP7sAgAATwQCAAAs0AIAAAjUAgAASWICABDRogA==
Date:   Mon, 11 Jul 2022 06:31:58 +0000
Message-ID: <4E0E503E-64E1-4B0A-B96A-0CD554A67107@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
 <85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com>
In-Reply-To: <85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.61.22050700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e48a6995-ea07-4835-7f29-08da63070e3b
x-ms-traffictypediagnostic: BYAPR05MB4790:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2c8Q6CwQ3r8XO9rtc9Mjj+XaLvO2ivwb/K7TW5a+a2YVVBCsmwaye3Oa27BsNb/Sh8c+xWuAaxBR6DrHGRILRW1lJ7pbte7Wt7jRdvzaiQk+MihAsbFVjYLEG9rrnn7aFBIpPGrEQy1IuRI85QcRICZSXmwsIoACkB0eraC1BCjYVzkmBNMo9kXsSNK8eZkX/7h9YICdF8FmgVDhfTYdjW6s2Cojacp+WQtEUyTsUagzegb7K4gUAb8QgURjQ8gdBXoQ+ibUH2zuuQhMxt+2gTLDMLv4rsngWd5pLPovDDw4gnz5Pz7oV30XND6wedvs3UCb14QWCiA7bacEkR75wX1YacXyD8FvZnzPhag6k9RY7Oqeke7deNiYar7cONnlbHufTMfFJSkuCevFMHLLmiO/tQIn0/OLaSd7s5aAlhFWtEjqHTJyJ2wTav3v1cW/ncN3DbSgKnHtwwS+XkxgDANRtp7DsEHvVVK4HEkQka34WDNX6H8cyBZ0X5E5BJy2DMDJ1y7p3wV4UeB6hJcp/M6MLlgSuYm2TfJrn1MtX3QZ45MYs+U0XXLwxSDy34lyOz5Ydxb6NMxSI7486y7c4Z90XGfrV2PUNyDwsP+1iRRptOOw2YuPPJCOEM1OZt6YXLKdz1ITXzYZJyFES+/Myey8aHNyRZvK29+NLZodDuHkLtzycNP5DC3GG/yavOUHlqMg+Y0lvMwpHHAl9ZDA9Gnd9zKVq1/O6eq/6Uots0N9okyE2baz8XzhQZtev7pU9vM4x82dBVkddKhaeL+hM+rEKzOE9N2vdxtEHmz5GkZ5UBAuUIApFxWDnjSMlL7/Lt5fPn4pCy0QWo0qdNLU984tDmy7CxGy7opkxrEZyMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(71200400001)(6512007)(41300700001)(86362001)(8936002)(91956017)(4326008)(26005)(64756008)(66476007)(8676002)(66946007)(83380400001)(76116006)(66446008)(66556008)(55236004)(6506007)(53546011)(122000001)(478600001)(2906002)(110136005)(38100700002)(36756003)(54906003)(6486002)(2616005)(5660300002)(33656002)(316002)(38070700005)(186003)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME1jREsxcVp1NmdlR2htcGNyYzV1dHF2Z2RDYkEva2poTjFTdzVoTGc4RkF4?=
 =?utf-8?B?a25HbkNuWUNicnptMGVwRTcxcXBseXFjdmtlb09QeEpnN2c2TGd0SDRUcnFr?=
 =?utf-8?B?UDJ2ais1Qm5vWnl4cEduK3hTOG0xRW54MlpKSy8yS2lOTEd1NFFwM0VjMDhk?=
 =?utf-8?B?U2w4SmJFSnk4UDJlOFQ1ZGZEL1E2WlE0aWtMNlFyUnZ2dnBXSHA5OWV6YWFL?=
 =?utf-8?B?UUVJUTkvWE96YjZ1NGQwOWJLcXR4MjlNaWZsQ0xhNUx0Z01xV3lsQ0tjdU1S?=
 =?utf-8?B?MUVScDJPNVRWYUFSdFNSbTBJZDNrQ3pEMUI4eThSVHhuWEJHamxOa0RqNmQ3?=
 =?utf-8?B?OXl4TTQwb2IrVHFLaVdqL285L2lBZ3dCS1NQOVY3eElVUUE5bERGR2FXU2tU?=
 =?utf-8?B?TUpyUkZyY0JFUHc2bnFjWXJ2UnA2ejJwVzFaYTBEVFJpSzFzOEVhUUVqaTA2?=
 =?utf-8?B?Uk5JKy9KZFYzQ2UxM2pnR0YzV2xHSWFTODBwdDJGOXB2S3NCbEduWEZjbVRu?=
 =?utf-8?B?bzNRR21wakk5MEl6RHBvektjbmdlVmw0N2RSekJpcHA4enJLWjFma2RMZEF3?=
 =?utf-8?B?eGdFQXFIR3BNMmhzcE8vdWNKTFZnU01wU095aVdYTEJwak9weUlMbmdBeG5k?=
 =?utf-8?B?YzhuMERYSGlNbmZIWmNRR0I1Tm5aS01hWWhNcVVkZlpod0laQllYSlpnZjA1?=
 =?utf-8?B?R3NjNnVRUkNRNUc2aU0rckh0cHZPRGgzUHlsWndVQk85TG1GS0xRb0dvNnNH?=
 =?utf-8?B?eTEzS3RqRi81T0I3Z29xRzhQczJPT3RkY25VZkV5eHJFYlgxRmszVTF6VjJC?=
 =?utf-8?B?WFBDUTNoZ09WRzIrdC96TG9vWHRmS3FpRFEwdUxpWFNhb3pZWTZ4UGtGTC9z?=
 =?utf-8?B?T3VNaUVuTzMxZVlCZFY4eFYrODA5RGI4TVRSZFhudkRBRDkxWlJXdngxSTdF?=
 =?utf-8?B?UXQrdHRUclhndTUxL1RpQUpwQ1VDUHhOU0YzdUJKTk04YXhQUWRlSDI3TE45?=
 =?utf-8?B?VkZQVzlISXo1a3hhT1psVSs3eE1RR0dQY1N1N3VreEFvRVc3bjM4eGVpRitW?=
 =?utf-8?B?ODkxaHlmc3AwS0RLNTd0UnN4UWR6a251eXN0dm5uSFVQeXR4emttRmhvbisz?=
 =?utf-8?B?NFNvTUpKblgwemVtL0VWSzRFWEQ0NGRrakZFaS9CWkZVM1pKSlhSbUF4Qk9H?=
 =?utf-8?B?NkxrRE0wL3NKY2hkNGZFdXpHeDV2K3VVWGVvZVdKUDZaQXFsYUtrSkIzb0tv?=
 =?utf-8?B?WDVWODJ2MkhVZi94d1VreEpQemd0ai9LZFM3a3djUUZiNlAyeDBmVy9FTmIv?=
 =?utf-8?B?MnBwbm51Vzc0RmFJbE5iY1VlbGFTSWlQelNLRnJtS1NVUStHZEJFeDhteVlU?=
 =?utf-8?B?bHEza1hkaXVUeU9rQ2xXZXdVRFlFRS9MV3BiN1MyNzVoTnNjTVliRDlsVHpQ?=
 =?utf-8?B?SnhOQmFCSHVpTVJQbk1jRk5wNXJVb3AzN3RzYWxHWldvSkY0K0FSOXI1NlBq?=
 =?utf-8?B?OWV5QmcraG1iSS92Ykc2blc0WmNHNTJDWCtzNEV4WWNoRm5WUUVDODVMTXRh?=
 =?utf-8?B?Vm1aNzAzVXhHeDlMYlpDSThmMG0yU3dIZ3BmdnB0QVFXY3I2Z1Y3dXVCNmpn?=
 =?utf-8?B?RjFhVkkrTTY0OGJ4UlYrNDBYMkRaKzNXSnVVVm1nSmtIaHVLelFiSGVWVzRx?=
 =?utf-8?B?WGpBSHdKTTNkckdYSTNJdTNBSHVteFRKS2dVYXZINmZ2Q2RRRHFHZkdJMnhM?=
 =?utf-8?B?aWNjTHJ5Z1FBUmtFRk1zU0pRUXJZT3R0WUo1UUNiYUZQTWJqSzlSUVhETGZ5?=
 =?utf-8?B?YTllM1cxWkhTOVZuVnpJL2FKcnlVbHZKM2JFcFlRblQzdEc1V0x2cTR1QStj?=
 =?utf-8?B?eUlZVDVDUmZEK3laVGFVOHFGTVJyQnhoZTNRWUlLYm1NNG5aMXRKVFhMZzJj?=
 =?utf-8?B?WDF3dm5EN01YQWFCbjkwV2pZTjk5RDhPQUNUaXpTNkFseEJvWEdYeitjRFFU?=
 =?utf-8?B?R003MjdzQU8wRlhDeGtQTm5BdHh1V2h6Vlg4eWprRGxjaUZ0S0lBc1h3Nm11?=
 =?utf-8?B?T3ljOHNBUUVETFRyY1MyNndoTXRhb1A0Z1U1eG8wNEswOXZYMjMxRGJWNFN0?=
 =?utf-8?B?S0VXV0pwYzBxaG5zM0JkVE1sc1dFbGNEMHAwUTZyTGo1ditsQWYwenFQZ3Iy?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5748997C3EBB1B4E9BD557DD467056CC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48a6995-ea07-4835-7f29-08da63070e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 06:31:58.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R95RK7njMlyf4nSDneDQx4oHXpTznzDSk3BS4FX73+vr/gTZHYC+pRn0cVNQ+Dd1lkTI4oNctnowM1Gdu2NlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4790
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMDkvMDcvMjIsIDE6MTkgQU0sICJOYWRhdiBBbWl0IiA8bmFtaXRAdm13YXJlLmNvbT4gd3Jv
dGU6DQoNCj4gT24gSnVsIDgsIDIwMjIsIGF0IDExOjQzIEFNLCBNYXR0aGV3IFdpbGNveCA8d2ls
bHlAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQoNCj4+IEkgaGF2ZSBubyBtaXNjb25jZXB0aW9ucyBh
Ym91dCB3aGF0ZXZlciB5b3Ugd2FudCB0byBjYWxsIHRoZSBtZWNoYW5pc20NCj4+IGZvciBjb21t
dW5pY2F0aW5nIHdpdGggdGhlIGh5cGVydmlzb3IgYXQgYSBoaWdoZXIgbGV2ZWwgdGhhbiAicHJv
ZCB0aGlzDQo+PiBieXRlIi4gRm9yIGV4YW1wbGUsIG9uZSBvZiB0aGUgbW9yZSBpbnRlbnNpdmUg
dGhpbmdzIHdlIHVzZSBjb25maWcNCj4+IHNwYWNlIGZvciBpcyBzaXppbmcgQkFScy4gSWYgd2Ug
aGFkIGEgaHlwZXJjYWxsIHRvIHNpeiBhIEJBUiwgdGhhdA0KPj4gd291bGQgZWxpbWluYXRlOg0K
Pj4NCj4+IC0gUmVhZCBjdXJyZW50IHZhbHVlIGZyb20gQkFSDQo+PiAtIFdyaXRlIGFsbC1vbmVz
IHRvIEJBUg0KPj4gLSBSZWFkIG5ldyB2YWx1ZSBmcm9tIEJBUg0KPj4gLSBXcml0ZSBvcmlnaW5h
bCB2YWx1ZSBiYWNrIHRvIEJBUg0KPj4NCj4+IEJpbmdvLCBvbmUgaHlwZXJjYWxsIGluc3RlYWQg
b2YgNCBNTUlPIG9yIDggUElPIGFjY2Vzc2VzLg0KDQpUbyBpbXByb3ZlIGZ1cnRoZXIgd2UgY2Fu
IGhhdmUgZm9sbG93aW5nIG1lY2hhbmlzbToNCk1hcCAoYXMgcmVhZCBvbmx5KSB0aGUgJ3ZpcnR1
YWwgZGV2aWNlIGNvbmZpZyBpLmUuIDRLQiBFQ0FNJyB0bw0KVk0gTU1JTy4gVk0gd2lsbCBoYXZl
IGRpcmVjdCByZWFkIGFjY2VzcyB1c2luZyBNTUlPIGJ1dA0Kbm90IHVzaW5nIFBJTy4NCg0KVmly
dHVhbCBNYWNoaW5lIHRlc3QgcmVzdWx0IHdpdGggYWJvdmUgbWVjaGFuaXNtOg0KMSBodW5kcmVk
IHRob3VzYW5kIHJlYWQgdXNpbmcgcmF3X3BjaV9yZWFkKCkgdG9vazoNClBJTzogMTIuODA5IFNl
Yy4NCk1NSU86IDAuMDEwIFNlYy4NCg0KQW5kIHdoaWxlIFZNIGJvb3RpbmcsIFBDSSBzY2FuIGFu
ZCBpbml0aWFsaXphdGlvbiB0aW1lIGhhdmUgYmVlbg0KcmVkdWNlZCBieSB+NjUlLiBJbiBvdXIg
Y2FzZSBpdCByZWR1Y2VkIHRvIH4xOCBtU2VjIGZyb20gfjU1IG1TZWMuDQoNClRoYW5rcyBNYXR0
aGV3LCBmb3Igc2hhcmluZyBoaXN0b3J5IGFuZCB5b3VyIHZpZXdzIG9uIHRoaXMgcGF0Y2guDQoN
CkFzIHlvdSBtZW50aW9uZWQgb3JkZXJpbmcgY2hhbmdlIG1heSBpbXBhY3Qgc29tZSBIYXJkd2Fy
ZSwgc28NCml0J3MgYmV0dGVyIHRvIGhhdmUgdGhpcyBjaGFuZ2UgZm9yIFZNd2FyZSBoeXBlcnZp
c29yIG9yIGdlbmVyaWMgdG8NCmFsbCBoeXBlcnZpc29yLg0KDQotIEFqYXkNCg0KPiBCYWNrIHRv
IHRoZSBpc3N1ZSBhdCBoYW5kOiBJIHRoaW5rIHRoYXQgYSBuZXcgcGFyYXZpcnR1YWwgaW50ZXJm
YWNlIGlzIGENCj4gcG9zc2libGUgc29sdXRpb24sIHdpdGggc29tZSBzZXJpb3VzIGRyYXdiYWNr
cy4gWGVuIGRpZCBzb21ldGhpbmcgc2ltaWxhciwNCj4gSUlSQywgdG8gYSBjZXJ0YWluIGV4dGVu
dC4NCj4NCj4gTW9yZSByZWFzb25hYmxlLCBJIHRoaW5rLCBiYXNlZCBvbiB3aGF0IHlvdSBzYWlk
IGJlZm9yZSwgaXMgdG8gY2hlY2sgaWYgd2UNCj4gcnVuIG9uIGEgaHlwZXJ2aXNvciwgYW5kIHVw
ZGF0ZSByYXdfcGNpX29wcyBhY2NvcmRpbmdseS4gVGhlcmUgaXMgYW4gaXNzdWUNCj4gb2Ygd2hl
dGhlciBoeXBlcnZpc29yIGRldGVjdGlvbiBtaWdodCB0YWtlIHBsYWNlIHRvbyBsYXRlLCBidXQg
SSB0aGluayB0aGlzDQo+IGNhbiBiZSByZWxhdGl2ZWx5IGVhc2lseSByZXNvbHZlZC4gVGhlIHF1
ZXN0aW9uIGlzIHdoZXRoZXIgYXNzaWduZWQgZGV2aWNlcw0KPiBtaWdodCBzdGlsbCBiZSBicm9r
ZW4uIEJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiB0aGF0IHlvdSBwcm92aWRlZCAtIEkgZG8gbm90
DQo+IGtub3cuDQo+DQo+IElmIHlvdSBjYW4gYW5zd2VyIHRoaXMgcXVlc3Rpb24sIHRoYXQgd291
bGQgYmUgaGVscGZ1bC4gTGV04oCZcyBhbHNvIHdhaXQgZm9yDQo+IEFqYXkgdG8gZ2l2ZSBzb21l
IG51bWJlcnMgYWJvdXQgYm9vdCB0aW1lIHdpdGggdGhpcyBjaGFuZ2UuDQoNCg==
