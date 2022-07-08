Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE456C447
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiGHTt3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiGHTt2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 15:49:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB428734F;
        Fri,  8 Jul 2022 12:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL7eC7qG3BH7kJSlRA1pn3xFgZrfdIcDlmWhoyeDrRkslfkZ0AtCJerIntXOK+U2WwzA8mSueIOTpTP06DOCgCSEwwqoZr2cu9kQYyrx7uaiqTupZ5Z6cqBT0gW9eRPxHoYren8TlWULV7Gzbx1P5ZcpEYILWUrIc1jexC7c+0kwS2+RQjXXiYmcs15X9ZepnOcUcThc0bGNZaW502atstcT0LKb1Oaa796DNmqa84iIYTYCXRr14fpNfCJe4RK+MnB8h7+hnDIZ4Ftt9rNNqMRluoDP/EkaLOqvrp1LHIIxreMYchxIsoN98XNAEpXGralFlBiBouHuFeN+3rhRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEE9aUzFze7uv1ehjp1VnMiNmgbP2YgmfSYVP/oAUAY=;
 b=O3KtbMo8wtCd2CKX3mhvJYxG/KnV0A2c+pXbIi8CqJNMssBWe26VBV3RZ3VpMAK0RqwzkexM0EpeNbow872gvF4hHMm7yEBMKvI3j7D+Miwt6B8J80BI+zg1Kzw5WAOJUj0AV3lS6IiwGeukZlosL3wMdbYNp9IZ1SI0qqkhdvlnNUaAqy4EwrBPghv5Usy6CZ6qrMIUvKAFnjIDeebyh4Jg3UlcZ8JGDUBb8xcOLeNgddEAFLQ2cdhF6MFhEWfOkZhK7pUBC+1ObxIbGuHLlRGy0FmS057SFvlonWtGE0EnaL3wq6mkaEAP+YyxRLni7qXj/BFf629r7ymwZgSKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEE9aUzFze7uv1ehjp1VnMiNmgbP2YgmfSYVP/oAUAY=;
 b=gq6uywkGZWzToSRsAghxdRoZ8qNr/A9bPReV2ExData95yWzjzZwc/rrh77RNmoJkjcXbpdxoaEg1j0kN/JSIsd0m6owRh/4naTzBHNxE2P0ZZNrl4HKKShSaqn/gpspWJUombDKv0ix/SvpRD/KNnQtnWypieulUuPvaZfeLFY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN7PR05MB5731.namprd05.prod.outlook.com (2603:10b6:408:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 19:49:22 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 19:49:21 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Ajay Kaher <akaher@vmware.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
Thread-Index: AQHYiw9NzqWSNRsR1kyxPrXhcjObWa1lHkCAgA7qdoCAAHWQAIAAP7qAgAATwgCAAAszgIAAAjYAgAASVwA=
Date:   Fri, 8 Jul 2022 19:49:21 +0000
Message-ID: <85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
In-Reply-To: <Ysh63kRVGMFJMNfG@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e5a1b8-f748-48d5-b541-08da611af41d
x-ms-traffictypediagnostic: BN7PR05MB5731:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?TUczRENWWTZRT2Uwd2Zlb0tOOE1iY2JmMXYydWNJbk9OVVlUYTJhd0dhempG?=
 =?utf-8?B?cHJFemVkNkhNOGtUbDIxY2JZYlRJWW5JRk04bCtlbHlORHVoTFF4dHpvUzBm?=
 =?utf-8?B?bVZsMXJDdGRxbXdJYlpCa3VQMGIxUWxldE12UXRLdUsxZ0szbFV2RGFWdTBN?=
 =?utf-8?B?b1BZQ0pLZ3F5OVE3T2x2UXNJWDJMNFJFMzBmc0RUZVBweSswUUdZNW5jZ1lK?=
 =?utf-8?B?dG9vUCtQa3RyeG5sbEtTTFJhVUhzSWEvdGtXRzV1WS80N1h6dDZnNTJibXBK?=
 =?utf-8?B?ZjZnaUNqVWZMQzc5aVVVUEorWldOOGdJREZNT2srb0h5RWkwYUtBVGN0K1Bv?=
 =?utf-8?B?eXJiVjBkR25jY3Q0bmtDWmN2Q3o1dTB3Y0h1ZHIrTytDM3FWVzVJRWdGbWNB?=
 =?utf-8?B?d0krKytkWGovL1FZdjBHRjRISXZ5YnNQeS9pcThXU0d4VlNCNEs4LzF5NW4y?=
 =?utf-8?B?NTJjNE9hRDB2R1VDcHlLSFdJNENETFo5M2M1QW9HODl5OGhRTnNuZlJydkFB?=
 =?utf-8?B?MHlQRXhTN3dkREt2UG9MdDhuWU5yRXo2SjJRS3RRTjJQbW8wMDNialpibm02?=
 =?utf-8?B?WDZRdXovbE0yT21TbEtxVEdqUEd3ZGZXdU1Xa2hQcmVlNVBWZ2ZjcTdnT0hx?=
 =?utf-8?B?WGdxWk5TS1FpbUIwelRhcnBmanZqbHBJTUZFdkhQOHFWa0xJQWV2MkpCbXRm?=
 =?utf-8?B?UFlQVzZPNUNlamwwNDRSWFQrTVpBS1RBS1NFMDNZRWpnd1k1SWhVaE0rRlpW?=
 =?utf-8?B?RFRaa3hqa08reGV4NEpOdVpQM21YOFZpVXU3VEtiYlFjbTFML3ZUeCt4ekZI?=
 =?utf-8?B?N25INmVJalBsWno2VER1WUZHWURsNEhNclV6T1lsSHVmbnAvcmlydkVhcWt3?=
 =?utf-8?B?b29adGY5Zi8zenFMZUtTcHZ5SjNzQU9pVlB0K0lsb3BzT0I5NHNzc1hUTFhz?=
 =?utf-8?B?dkxWSUtnbnZhUW1jelBxTUZ3UXJwWTNvSkhocitWcURCVGNnQS9acUFSWnpU?=
 =?utf-8?B?alpaUE1ucGdMQjJNZnExWXVmY0FLMEF0ZEVEbWJ4VlMwaHhJcVJUL1lUTHZQ?=
 =?utf-8?B?SlM1WXlQMFFrcnluRnZIOTVoUzR1eklQSjlWUGh6QjBpb3JwMWlnbjMyNElN?=
 =?utf-8?B?RWVpSjAzSklFSWp0clYwOFA5ZGtHK1pvaGo2NnpHdWFyOU9ZK29xLzZRWWh5?=
 =?utf-8?B?eDdnb2tuN0t3djdnc2Z5dXdNRWhrNFZDeGpXL1MzWkRUVGRuVVJEQkNXc1BU?=
 =?utf-8?B?RFh1U1pRRzR4N0RTSmF3RzJTcVNWVmx0VFNrZXBoRDlIZGFJUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(38100700002)(8676002)(5660300002)(66946007)(7416002)(66446008)(83380400001)(66476007)(64756008)(4326008)(66556008)(76116006)(122000001)(186003)(53546011)(38070700005)(6506007)(6916009)(54906003)(316002)(2616005)(478600001)(2906002)(33656002)(71200400001)(41300700001)(86362001)(6512007)(26005)(36756003)(8936002)(6486002)(45080400002)(556444004)(31884004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enU1K25KSGcwRWVQZmk1Wlk1UXdXQXJWejlBNFVzRXZ3aWJCZ2lFZUxJYm5p?=
 =?utf-8?B?WUEvc25mUmNjNGhvWVVvd3l6bW9EUlhBelhsTXRmUEVMTys4emtIZUVNdWl2?=
 =?utf-8?B?U211Y3VDRHdQVXBTUDQzNU1aQXlDUjFrMlhJQXV1YVRvVDFZcklqMXVTVUdT?=
 =?utf-8?B?cHZWbDV3czZiSzZZemsrWlRtM2N3MTd3VkNkZDhMdzBnaTVmaDJrTWIyamhy?=
 =?utf-8?B?b0VhZk0vZ3dvUGJBdTRwVzhVMTc5NDBaNjg2TkNvRXhNeDBzamQ5SnlFaUZi?=
 =?utf-8?B?S0wxNStDU0ZMRTlqU3RMM0xidDlxUU9CaGNibzQwNENsNURORjlEdFVaWEEx?=
 =?utf-8?B?UEQxVVIzT0RNWEh0RGpoM2Y5WUJHQ3AxZnJQZG5tbUN5cFltVmdPNVI0WVIv?=
 =?utf-8?B?RkdYMjdLSzV3QW9LbkZkZm90K0pBVTNncnIwbVltcFBFZWtaeWNNaDZyR0xJ?=
 =?utf-8?B?Z2Jyc2R4YkJ3L0tGSXdYVlNNUzFpMERuWlVrd0tlczNrMVdtOFFkV1Jja3Fr?=
 =?utf-8?B?Ly83TzA3TEUxcVRwdGRjSFFnSlRtSzl0eklhYTc4a0JjdnlwU05WWHdxL21H?=
 =?utf-8?B?VTJQeVF4M0Zob2Fxb3ZIY0grd2YyQW0wdkNrcEpZbVFZc1ZkWXBqQjZCQUc1?=
 =?utf-8?B?K0RTUk9vSTF3L2hWU3haODNHa1orSnluUGJjckF6MlF0a2VxUzYvamlIWExZ?=
 =?utf-8?B?WkRLY0tKSkUrNDNHSzdxdjZlNXVhTGhzZURzRmtyTitEVllRQjJkYjRQL1Rx?=
 =?utf-8?B?V1RET2plTUc3d3NkYXNDL3pCbEZlejdUak90bVlOUkNlRCtzTk85YUl4N1RJ?=
 =?utf-8?B?M0E0eEIwMmxMNktsWVVFTUZKNWFQQ3RId2h0UDZLdEhlcTJCRExvZVRvOVFW?=
 =?utf-8?B?WlJxVGsxeW5LemNHZkhxajM2N05WaGoyclBCQWRicGxxaHc2cmRqRy9qUjY0?=
 =?utf-8?B?UXdkZWVrT0ExL2x1WnNJVy8ybk0rdHEyQ0xLRk5UZ2RNVTFaaGtzb0YzSFQv?=
 =?utf-8?B?RXVDSlpjc3QvVHVtdTNXQmR6eUE5dnFmT09ROU5EVVptREs0T1hvSWNsUFlU?=
 =?utf-8?B?dVFtOERaSmxHV0YvWnhlREVjR0x5cHZwdmhVQmJhRVYyL1hPQ2VVWllsTm52?=
 =?utf-8?B?a0x6b3lWdDFxNmhGUG5MQkg4QnJWTlFCVWhZeS82bldtK0tNbDVOWU9sZTZV?=
 =?utf-8?B?dFdOell4RTNaN0dnVlZCbysxMHdtb3JiSEE0ZlRTajlLVW1zNUtVaGt6VjFG?=
 =?utf-8?B?Q01uOE8zYmNaQ0Y2MXhWRXBwWERGSzREcitYWmc5MEUrQzAwdW9ZUGdaUERN?=
 =?utf-8?B?dWxFdEV2MTJKM1U1clVLdzJQOXVjN1g3YkVPSVkzRHFJMVN6MUlISVJkbHFF?=
 =?utf-8?B?QWJiT3dpWTh2VTRuUG1JQzNFRXRMcmRPcDZqcUM3Q1lYZ1NybTdqVFdrK010?=
 =?utf-8?B?WjlucGlwV3BmOHdKNlNQQUE5TjJpc1BENncvMDdIa0F4UW5HVnI2MlgyUUdI?=
 =?utf-8?B?VXkrMVBUVHdlNGRBNk9FRXdXczU0VFJPTVhtL2NOcWZPOHlqejFZeXJoMHRZ?=
 =?utf-8?B?RjVVYUhSSmpZZ2hSWUpsL0NoOTNBUDNwTVNzOWhwOFpTTlNhUFlndWNwaFZr?=
 =?utf-8?B?U0JQZjcyZDVabFI3LzFiTkg1VnZjSENhQkZvSkcrRUdJTnRUcTMreDdyaW1n?=
 =?utf-8?B?d0ZGQlVFVVdRNlB1Q0cwSWl3a3REbjFQNjNwZVZiQzhLSldZUFh6ckpFc3hQ?=
 =?utf-8?B?bUVEclhsd1dCRVBmRjhkWENGbWxPRGV5NGFtWFZKVjRwWVdZUStkZjQzMHFP?=
 =?utf-8?B?ZVh6cWZNd1VaQWd1d1RDc2o0WnliS3JlZVIwbExNc1VhOExvU2paL29VNnND?=
 =?utf-8?B?aDFKOTAwZ2MzUEdqT1RFdnVXK3RLUXJqWE8xQWhyM0tPalZ4SEJ4RVNVSVN3?=
 =?utf-8?B?SEh4aUx5SEEzbzY2aVJBa1c3Ylhpdmc0Zko2VnRYcXB5SS8wZFR1cGtwUHRw?=
 =?utf-8?B?dE9xaEV5akwzUkN3bzUwZ05qTzB5YXV5djlKMkh1Z2FsZ0YwekRLczZvNXM5?=
 =?utf-8?B?WVJoTnRZZ2cxV09vZDlxWXpiZ0dvQXRtVHlDTHE5Z3ZaNjlZSFV0YnZaTHAv?=
 =?utf-8?Q?AstVfLRxmrtyuo9AibfoKAvMp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE1BC45A5A10054C81182E010B71FED1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e5a1b8-f748-48d5-b541-08da611af41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 19:49:21.8665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdEzFx2jkpv93JH5J6zoLDHKM1S3AuP2txAsnuSyF8X9KNjqJ8EN7PrKiG7/9YeKLnJKp/qkaiP6MIU9HR3jQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB5731
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDExOjQzIEFNLCBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiBGcmksIEp1
bCAwOCwgMjAyMiBhdCAwNjozNTo0OFBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gT24g
SnVsIDgsIDIwMjIsIGF0IDEwOjU1IEFNLCBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFk
Lm9yZz4gd3JvdGU6DQo+PiANCj4+PiDimqAgRXh0ZXJuYWwgRW1haWwNCj4+PiANCj4+PiBPbiBG
cmksIEp1bCAwOCwgMjAyMiBhdCAwNDo0NTowMFBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0K
Pj4+PiBPbiBKdWwgOCwgMjAyMiwgYXQgNTo1NiBBTSwgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+PiANCj4+Pj4+IEFuZCBsb29raW5nIGF0IHRoZSByZXN1
bHRzIGFib3ZlLCBpdCdzIG5vdCBzbyBtdWNoIHRoZSBQSU8gdnMgTU1JTw0KPj4+Pj4gdGhhdCBt
YWtlcyBhIGRpZmZlcmVuY2UsIGl0J3MgdGhlIHZpcnR1YWxpc2F0aW9uLiBBIG1taW8gYWNjZXNz
IGdvZXMNCj4+Pj4+IGZyb20gMjY5bnMgdG8gODV1cy4gUmF0aGVyIHRoYW4gbWVzc2luZyBhcm91
bmQgd2l0aCBwcmVmZXJyaW5nIE1NSU8NCj4+Pj4+IG92ZXIgUElPIGZvciBjb25maWcgc3BhY2Us
IGhhdmluZyBhbiAiZW5saWdodGVubWVudCIgdG8gZG8gY29uZmlnDQo+Pj4+PiBzcGFjZSBhY2Nl
c3NlcyB3b3VsZCBiZSBhIG1vcmUgcHJvZml0YWJsZSBwYXRoLg0KPj4+PiANCj4+Pj4gSSBhbSB1
bmZhbWlsaWFyIHdpdGggdGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgcGF0Y2gsIGJ1dCBJIGp1c3Qg
d2FudGVkIHRvDQo+Pj4+IGJyaWVmbHkgcmVnYXJkIHRoZSBhZHZpY2UgYWJvdXQgZW5saWdodG1l
bnRzLg0KPj4+PiANCj4+Pj4g4oCcZW5saWdodGVubWVudOKAnSwgQUZBSUssIGlzIE1pY3Jvc29m
dOKAmXMgdGVybSBmb3IgInBhcmEtdmlydHVhbGl6YXRpb24iLCBzbw0KPj4+PiBsZXTigJlzIHJl
Z2FyZCB0aGUgZ2VuZXJpYyB0ZXJtLiBJIHRoaW5rIHRoYXQgeW91IGNvbnNpZGVyIHRoZSBiYXJl
LW1ldGFsDQo+Pj4+IHJlc3VsdHMgYXMgdGhlIHBvc3NpYmxlIHJlc3VsdHMgZnJvbSBhIHBhcmF2
aXJ0dWFsIG1hY2hpbmUsIHdoaWNoIGlzIG1vc3RseQ0KPj4+PiB3cm9uZy4gUGFyYS12aXJ0dWFs
aXphdGlvbiB1c3VhbGx5IHN0aWxsIHJlcXVpcmVzIGEgVk0tZXhpdCBhbmQgZm9yIHRoZSBtb3N0
DQo+Pj4+IHBhcnQgdGhlIGh5cGVydmlzb3IvaG9zdCBydW5zIHNpbWlsYXIgY29kZSBmb3IgTU1J
Ty9oeXBlcmNhbGwgKGNvbmNlcHR1YWxseTsNCj4+Pj4gdGhlIGNvZGUgb2YgcGFyYXZpcnR1YWwg
YW5kIGZ1bGx5LXZpcnR1YWwgZGV2aWNlcyBpcyBvZnRlbiBkaWZmZXJlbnQsIGJ1dA0KPj4+PiBJ
SVVDLCB0aGlzIGlzIG5vdCB3aGF0IEFqYXkgbWVhc3VyZWQpLg0KPj4+PiANCj4+Pj4gUGFyYS12
aXJ0dWFsaXphdGlvbiBjb3VsZCBoYXZlICpwZXJoYXBzKiBoZWxwZWQgdG8gcmVkdWNlIHRoZSBu
dW1iZXIgb2YNCj4+Pj4gUElPL01NSU8gYW5kIGltcHJvdmUgcGVyZm9ybWFuY2UgdGhpcyB3YXku
IElmLCBmb3IgaW5zdGFuY2UsIGFsbCB0aGUNCj4+Pj4gUElPL01NSU8gYXJlIGRvbmUgZHVyaW5n
IGluaXRpYWxpemF0aW9uLCBhIHBhcmF2aXJ0dWFsIGludGVyZmFjZSBjYW4gYmUgdXNlDQo+Pj4+
IHRvIGJhdGNoIHRoZW0gdG9nZXRoZXIsIGFuZCB0aGF0IHdvdWxkIGhlbHAuIEJ1dCBpdCBpcyBt
b3JlIGNvbXBsaWNhdGVkIHRvDQo+Pj4+IGdldCBhIHBlcmZvcm1hbmNlIGJlbmVmaXQgZnJvbSBw
YXJhdmlydHVhbGl6YXRpb24gaWYgdGhlIFBJTy9NTUlPIGFjY2Vzc2VzDQo+Pj4+IGFyZSDigJxz
cHJlYWTigJ0sIGZvciBpbnN0YW5jZSwgZG9uZSBhZnRlciBlYWNoIGludGVycnVwdC4NCj4+PiAN
Cj4+PiBXaGF0IGtpbmQgb2YgbG91c3kgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlIHJlcXVpcmVzIHlv
dSB0byBkbyBhIGNvbmZpZw0KPj4+IHNwYWNlIGFjY2VzcyBhZnRlciBldmVyeSBpbnRlcnJ1cHQ/
IFRoaXMgaXMgbG9vbmV5LXR1bmVzLg0KPj4gDQo+PiBXaWxkIGV4YW1wbGUsIGhlbmNlIHRoZSDi
gJxmb3IgaW5zdGFuY2XigJ0uDQo+IA0KPiBTdHVwaWQgZXhhbXBsZSB0aGF0IGRvZXNuJ3QgaGVs
cC4NCj4gDQo+Pj4gWW91J3ZlIHVzZWQgYSBsb3Qgb2Ygd29yZHMgdG8gbm90IGFuc3dlciB0aGUg
cXVlc3Rpb24gdGhhdCB3YXMgc28NCj4+PiBpbXBvcnRhbnQgdGhhdCBJIGFza2VkIGl0IHR3aWNl
LiBXaGF0J3MgdGhlIHVzZSBjYXNlLCB3aGF0J3MgdGhlDQo+Pj4gd29ya2xvYWQgdGhhdCB3b3Vs
ZCBiZW5lZml0IGZyb20gdGhpcyBwYXRjaD8NCj4+IA0KPj4gV2VsbCwgeW91IHVzZWQgYSBsb3Qg
b2Ygd29yZHMgdG8gc2F5IOKAnGl0IGNhdXNlcyBwcm9ibGVtc+KAnSB3aXRob3V0IHNheWluZw0K
Pj4gd2hpY2guIEl0IGFwcGVhcmVkIHlvdSBoYXZlIG1pc2NvbmNlcHRpb25zIGFib3V0IHBhcmF2
aXJ0dWFsaXphdGlvbiB0aGF0DQo+PiBJIHdhbnRlZCB0byBjb3JyZWN0Lg0KPiANCj4gV2VsbCBu
b3csIHRoYXQncyBzb21lIGJ1bGxzaGl0LiBJIGRpZCBteSBmdWNraW5nIHJlc2VhcmNoLiBJIHdl
bnQNCj4gYmFjayAxNCsgeWVhcnMgaW4gaGlzdG9yeSB0byBmaWd1cmUgb3V0IHdoYXQgd2FzIGdv
aW5nIG9uIGJhY2sgdGhlbi4NCj4gSSBjaXRlZCBjb21taXQgSURzLiBZb3UncmUganVzdCB0b3Nz
aW5nIG9mZiBzb21lIG9waW5pb25zLg0KPiANCj4gSSBoYXZlIG5vIG1pc2NvbmNlcHRpb25zIGFi
b3V0IHdoYXRldmVyIHlvdSB3YW50IHRvIGNhbGwgdGhlIG1lY2hhbmlzbQ0KPiBmb3IgY29tbXVu
aWNhdGluZyB3aXRoIHRoZSBoeXBlcnZpc29yIGF0IGEgaGlnaGVyIGxldmVsIHRoYW4gInByb2Qg
dGhpcw0KPiBieXRlIi4gRm9yIGV4YW1wbGUsIG9uZSBvZiB0aGUgbW9yZSBpbnRlbnNpdmUgdGhp
bmdzIHdlIHVzZSBjb25maWcNCj4gc3BhY2UgZm9yIGlzIHNpemluZyBCQVJzLiBJZiB3ZSBoYWQg
YSBoeXBlcmNhbGwgdG8gc2l6IGEgQkFSLCB0aGF0DQo+IHdvdWxkIGVsaW1pbmF0ZToNCj4gDQo+
IC0gUmVhZCBjdXJyZW50IHZhbHVlIGZyb20gQkFSDQo+IC0gV3JpdGUgYWxsLW9uZXMgdG8gQkFS
DQo+IC0gUmVhZCBuZXcgdmFsdWUgZnJvbSBCQVINCj4gLSBXcml0ZSBvcmlnaW5hbCB2YWx1ZSBi
YWNrIHRvIEJBUg0KPiANCj4gQmluZ28sIG9uZSBoeXBlcmNhbGwgaW5zdGVhZCBvZiA0IE1NSU8g
b3IgOCBQSU8gYWNjZXNzZXMuDQo+IA0KPiBKdXN0IGJlY2F1c2UgSSBkb24ndCB1c2UgeW91ciB0
ZXJtaW5vbG9neSwgeW91IHRoaW5rIEkgaGF2ZQ0KPiAibWlzY29uY2VwdGlvbnMiPyBGdWNrIHlv
dSwgeW91IGNvbmRlc2NlbmRpbmcgcGllY2Ugb2Ygc2hpdC4NCg0KTWF0dGhldywNCg0KSSBkaWQg
bm90IG1lYW4gdG8gc291bmQgY29uZGVzY2VuZGluZyBhbmQgSSBhcG9sb2dpemUgaWYgSSBkaWQu
IFlvdSBoYXZlIG15DQoqZnVsbCogcmVzcGVjdCBmb3IgeW91ciBjb2RpbmcvZGVzaWduIHNraWxs
cy4NCg0KT3V0IG9mIG15IHJlc3BlY3QgdG8geW91LCBJIGFtIGdpdmluZyB5b3UgYSBwYXNzIG9u
IHlvdXIgY29uZHVjdCB0aGlzIHRpbWUNCmFuZCAqdGhpcyB0aW1lIG9ubHkqLiBEbyBub3QgdXNl
IHN1Y2ggbGFuZ3VhZ2Ugd2l0aCBtZSBvciBteSBjb2xsZWFndWVzDQphZ2Fpbi4gVGhlIG9ubHkg
cmVhc29uIEkgZ290IGludm9sdmVkIGluIHRoaXMgZGlzY3Vzc2lvbiBpcyB0aGF0IEkgZmVlbCB0
aGF0DQpteSBjb2xsZWFndWVzIGhhdmUgY29uY2VybnMgYWJvdXQga2VybmVsIHRveGljIGVudmly
b25tZW50Lg0KDQpCYWNrIHRvIHRoZSBpc3N1ZSBhdCBoYW5kOiBJIHRoaW5rIHRoYXQgYSBuZXcg
cGFyYXZpcnR1YWwgaW50ZXJmYWNlIGlzIGENCnBvc3NpYmxlIHNvbHV0aW9uLCB3aXRoIHNvbWUg
c2VyaW91cyBkcmF3YmFja3MuIFhlbiBkaWQgc29tZXRoaW5nIHNpbWlsYXIsDQpJSVJDLCB0byBh
IGNlcnRhaW4gZXh0ZW50Lg0KDQpNb3JlIHJlYXNvbmFibGUsIEkgdGhpbmssIGJhc2VkIG9uIHdo
YXQgeW91IHNhaWQgYmVmb3JlLCBpcyB0byBjaGVjayBpZiB3ZQ0KcnVuIG9uIGEgaHlwZXJ2aXNv
ciwgYW5kIHVwZGF0ZSByYXdfcGNpX29wcyBhY2NvcmRpbmdseS4gVGhlcmUgaXMgYW4gaXNzdWUN
Cm9mIHdoZXRoZXIgaHlwZXJ2aXNvciBkZXRlY3Rpb24gbWlnaHQgdGFrZSBwbGFjZSB0b28gbGF0
ZSwgYnV0IEkgdGhpbmsgdGhpcw0KY2FuIGJlIHJlbGF0aXZlbHkgZWFzaWx5IHJlc29sdmVkLiBU
aGUgcXVlc3Rpb24gaXMgd2hldGhlciBhc3NpZ25lZCBkZXZpY2VzDQptaWdodCBzdGlsbCBiZSBi
cm9rZW4uIEJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiB0aGF0IHlvdSBwcm92aWRlZCAtIEkgZG8g
bm90DQprbm93Lg0KDQpJZiB5b3UgY2FuIGFuc3dlciB0aGlzIHF1ZXN0aW9uLCB0aGF0IHdvdWxk
IGJlIGhlbHBmdWwuIExldOKAmXMgYWxzbyB3YWl0IGZvcg0KQWpheSB0byBnaXZlIHNvbWUgbnVt
YmVycyBhYm91dCBib290IHRpbWUgd2l0aCB0aGlzIGNoYW5nZS4NCg0K
