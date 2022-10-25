Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2260C133
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiJYBm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJYBmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:42:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6E639E;
        Mon, 24 Oct 2022 18:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDtyLDIxa1GA7XtB7wcsUJideJWiKuDdBMmhheOFsEBCFdDrv4FfHiio7qdtnfmqbRwTOH/URTlbNkR3fnyDWXm/jrrB4WUkq14ZIzx6izif7q2W2OkaLBFemueEjM7nNeu9+F5ip9+80UWJ4anj/J978PP1nv+yq9s4ouz4Be5FZkNBJ4G0Gfe1D1yPhtX8qBCGNvPtGGAAM7T9Pe3qq1KxtAN62hXXspKPwdgra7fg5mz/WZmQDUMp6O4bPBiQjRCQrPbMKxIfl1y5EQaAZcf4Qkxqu/vRQNwMGejSh1GssyqXLIKBNi5Md9w8VgqOGSyketNOTXEcrqNBe/mRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMRymFnPGFhs5cMAemHeQYfoViL6X7IA+p7WVkIMeCI=;
 b=PLcxgro8+oTr2G9/ExCYCdf4PNbVaZUIbNIhsqq7LS5r8Nd1rvBCXtzoGB6s93pU4tTH1miB/tHR6T6Asv7zhdzKNMFXiQemm2k/al/9kORsHwhbALQEhXciNQfQkSuuEAauM0FCJQlDyW+49oPF3KhdWUMjcFHcWj0YV32H/CnKy0ZY6KzsD2wBj/i73uxbS/FoaKNf5toAebBm7rwll8f5ltjgY8QtsG0EEkb2vSo4cMY9wKIaNUt8hOCve5SXhJUKkYJHI4V39lULj9obyaF1RNzLjEGJgSg0OIx09VnHo+nIwXSmTcdNx9wZjLtQgeLaLdS+y/ywFLSfkAh6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMRymFnPGFhs5cMAemHeQYfoViL6X7IA+p7WVkIMeCI=;
 b=BM+giu0VupgWUEOysB5DhtE4qxruLKtDEDDw/exSjD1MgRG4yuQf+QLCr9bcHTsZnYrRCotxuoFCQmlYSTwdhCB0G1b0pYlZMwEU/yomIC7WAQ2JQsrW2MD5BXKWya36JkSmDCSCpE/tTKwWBU+hQsegD49ko0f5UkreyOo2BQF/Sb0wIQKu8rEsZixfAUqpQ0Q+d+w3duidd/13IyODLXIm4q/QgZjRayF2MAyR5y0FASSSPTIznhfxBCx5azHQmOAsBIpw0j15fcttasW9PzrHM5doqunyQfp7RwnSNQiMGgoAU5reoru4NtNdPNphz8VBXO5W6rwMkumUpJeWzQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 01:25:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:25:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v11 6/9] block: set FOLL_PCI_P2PDMA in
 __bio_iov_iter_get_pages()
Thread-Topic: [PATCH v11 6/9] block: set FOLL_PCI_P2PDMA in
 __bio_iov_iter_get_pages()
Thread-Index: AQHY5XRgWKJ5x6FvqE2inQmSnDSnaq4eVmCA
Date:   Tue, 25 Oct 2022 01:25:20 +0000
Message-ID: <39267016-fa34-099c-01b7-37fb730e6e87@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-7-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-7-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6090:EE_
x-ms-office365-filtering-correlation-id: 6328a205-12a7-4910-b220-08dab627c7f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKL3AaTImsQs8bw4LiEvdzjF8tbQrdPMNsh07LfHtPT7JAx5bSwb3t+X3eZdZ65ae8z2u9jc5lxczxapAW/1WRkwQ/8Hk0HLFwjbect+robv5S2n93dQFXCr1cBOBCK1gJFY3QyROzaLIA+T3C9u1qpm02U+CMtUMxZyXUiQffBZ+gh2eL3rEivnvJmYx585j2pDXvSRdyM2TB80ytunQrwRP9oL9fDg0gQdKbDtqJgW2RMq3WidglAhd9HVOnO00s6dDkaSjFzqppymuGCY8nq+D2BOKJCCIAs9hOzhAhrStkvFBnAqYKoC2f3U615PhonG5PY39FkPwjKQYwnvK8caDFBitfkQmryhSB4jrHKt92TA2evJCehkOujM9cuSF82CXy6oVdNEyygQ0EpdZkGtpRGprRPDumDAwNqt81/ppPDiDnNySaClOo9ZlP3KRqFye/c5fYvFFeKkMmhD1UnRecUhTn0/6oKbjGs5JLJzfXdYHcYkZM/dESrIBPW1LY243YwZs958q46l2LaGyqAbXSfuil5bp48EJpdXUzor5tdRyJ3tZbd6yT8POSHOaoz2SKicCz1dhbyZQMIr98MW2xkIzhirkL+gXxqSoqixX9yzrscxdeRdJYyKLDpZE+fEOU5i9t+7jbRe/BtS9TjIIsoh4NbyS4/ZCXAYk5SU+kj/R+UTBnMTZ4AFstJY0G5CgtxeBTij9odQig+azxP6NfKXGbG0qAcMDmDoPnDsXM2NTLb20OElCPSawak1BPOZyBqjVbudsft/LigORGdUpmw1e043uGyNLLWVpEDktb6puwCxPPcOEt9y6LhUE3W37ixjJ3GN3L1HjxhNog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(31686004)(36756003)(38070700005)(8936002)(5660300002)(2906002)(4744005)(38100700002)(122000001)(86362001)(31696002)(83380400001)(7416002)(186003)(6512007)(316002)(110136005)(6486002)(2616005)(41300700001)(66946007)(478600001)(91956017)(66476007)(71200400001)(54906003)(76116006)(4326008)(66556008)(66446008)(64756008)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGc2aVpYTkxEQmlya1hQRklZTkdFVW1pcllEUG5USEFzWGc0K2w2SEhBS0xY?=
 =?utf-8?B?L3M3dGtxLzk3UFBjREQ3UUlkWUJmeVZhakFTWHA1NVZPUm5raGVMYjl6VjhT?=
 =?utf-8?B?c3d2bVRKWFdSa2h0TGVTMkE4TXQ0UUc3cyt6V3k0QmpVMXVVYWxnclhWM1E4?=
 =?utf-8?B?YUJOUU9nNjdRMFNWcWdhV3BXZFpiU0lCZUxnM3drZ3hiS1ZkQ0JrRnd4dHR1?=
 =?utf-8?B?enZZV2NJb29SdEZtNS9wLzhtYTF0QzJtUFI0Y2FtTEhKRm5xdzRySUtZK01o?=
 =?utf-8?B?cS8zK1NoSmxPMUpJdGdKTXVQVHJET3pzSVZzMnJreHhWc2ZNLzBDZ2NnT0cx?=
 =?utf-8?B?a1lVaUR4eHp2eXI4NDJGQ3dEWUNJeXN2L3JiTFZPOHp4anVOZmlpWHVhTVBM?=
 =?utf-8?B?ZFNaRmdsWW9Rc3lhL0pERWxQYTBQazBYYnVWbkpKZ1pDUXQrNnVSbDRUTlFr?=
 =?utf-8?B?L0tXRi94VUNFUDhPanU2VFBXWWFxSTV4U1FIZnkvOCthSC9RdW11bGZIZFZC?=
 =?utf-8?B?TUVEdWFXcVk5SXJMd2htVmhPZHJOa3NsQ0RtVjVhTmN4b2hwb1N4eWd5dU5J?=
 =?utf-8?B?RUdVaXhFR3lzSFo4cVJhSmRjdURKT3NQNjM1QkdNRy9OdkpRcm1lUUQvU3V1?=
 =?utf-8?B?M2dnamR5WFluV2ZqMDNoTWE0RkpabHlpRDRESThtMEVoYmJsejIvQkUrS2Zo?=
 =?utf-8?B?NENoZ2hpbzFGQWN1N2I1VVhDTldyKzF4NVh2MzhqU2NrNWNUVkZMNTJZbis5?=
 =?utf-8?B?dTU2TkVnN2JWbTZJUXU3cjdOS3lxRnZ4L1NrWUFxaVRqeTFJbzI5Wkl2dWhD?=
 =?utf-8?B?MTdpVEFrdERWZmVTd2tOcUZwU0JkbUxleTdXMjhIbW1jcDlHQlFBNE1zTmto?=
 =?utf-8?B?MjVjdll3RkRHMGk2SGtLZG5LTE1QUERiQStXdGhpVldkRms0RktOaVphMVNO?=
 =?utf-8?B?aUJiWkthK01Nb0xadi9zODhvYmt4T2E2Y01NOW15MFF5TTlBeVNGdSswQlJX?=
 =?utf-8?B?YnFMRmpWVVd1YXhkLzltWXdJMkRzYi94amEvbC90NW03WC8remtWeVNmNlZn?=
 =?utf-8?B?Nk9USjdkRjFMQURlbUlacjkyaHByNjNXdFlKZjBpd0lyTDJBeDlENE9wUXlx?=
 =?utf-8?B?YUxWWTFYNmluQnlQb1NETm1LajZhUG9zaVJnNFliUStYeGlnLzhud3A5dzZX?=
 =?utf-8?B?R2tXWFlyZmM0Q0J2ZG5xdUVGSnJ0NlFnTml5d09OM0tFYUVLT0F1YWtIRDZ5?=
 =?utf-8?B?Q2h5aXJUNm9CT3M5NTJneER3QzZaajhPcDEvK3pIdFZBZ3E3a0gyVmlYODkw?=
 =?utf-8?B?OTBKTnQvUlN2cUxJV2QxZUxHZlNyRE1TYnc2VERFWVFFVkpiWE4xQmkweGhS?=
 =?utf-8?B?VEhqQ3ZMaXNmOXBYK051Y0NaMkdlOHJyL0hPQ2Jha2xSSzBBU2xkd2ZKbzlG?=
 =?utf-8?B?eCtiY20yaGRvUjhCWFZLcFhoaG1MN2U1bjBIWjVxb09QVU9FT1FRbkp3Y1lL?=
 =?utf-8?B?V2t1ZXEwVXdtV2NmNDYrdEUySUNNOE1HRERwYlo3M3dkWkxyRnlwWHNFZnNr?=
 =?utf-8?B?OE1TeVQrVUxTazJPakw0WDk1NTBBcHRpUGhRWjBUaVBETmlRT0QxWU4wL0VV?=
 =?utf-8?B?ZG9lWkpHMjZVWmhteHRrd0F6aHp0dDM0aFJBQ2tzU2VvcDM4ZmFYUG84a3lT?=
 =?utf-8?B?VkxZWGYwbmc4cEMrb0hmNk5WR25JQTFHVHJNdUVqSUlyRnJYcjVBeUVnQitE?=
 =?utf-8?B?bmp2RzlnOG5FcjRpWXFjT0xLVVZRa0k0OVZMRTkwZ2tCdE02NFVISGpuQS90?=
 =?utf-8?B?SWt5bnBQRmN3K0l2dEFaWlVUQmhnWFBMb2lDSUtFSnZTWXdBeithZHJZYXBF?=
 =?utf-8?B?RlYrZmlnY3hvVnU0Szl6S016VDZUN3dud3ZKQWNzVDJYTEoxVmpWbEMxc0hq?=
 =?utf-8?B?VW55L3JCSnVyNEMrQ2p0Wis2bXY1UTRsZ3dIU2pKbDN5N1ljNHlYQVd6MXFs?=
 =?utf-8?B?YXNodVh6c1FkUUdFZzdrUUd6b2MwV1FtaGlPRGN0WHFWOG8wMElDNE9QZWs2?=
 =?utf-8?B?c2Zqem0yWVIremIrUkZDRWVVUUxmT2tPU3B3NXY3eWdPZ0RNV2UvS3FTS2Ja?=
 =?utf-8?B?dUhlVDZLa1dlYWIxRUs2ZmxZaVhJZ3dsWDBzejJLVlVkbHRndXoybWV3SUgw?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76B15A18D348714C92DE9584B883A55A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6328a205-12a7-4910-b220-08dab627c7f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:25:20.0585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDC0uM8uYq4/Ny+O462TE0TedGcm9fDV5eKaEDLjnLHowfpTHHeNsnoK/WaNlDyMfNThLTHB4CjRcCknSFDZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ICAqIEVhY2ggc2VnbWVudCBpbiB0aGUgaW92IGlzIHJlcXVpcmVkIHRvIGJlIGEgYmxvY2sgc2l6
ZSBtdWx0aXBsZS4NCj4gICAJICogSG93ZXZlciwgd2UgbWF5IG5vdCBiZSBhYmxlIHRvIGdldCB0
aGUgZW50aXJlIHNlZ21lbnQgaWYgaXQgc3BhbnMNCj4gQEAgLTEyMTcsOCArMTIyMSw5IEBAIHN0
YXRpYyBpbnQgX19iaW9faW92X2l0ZXJfZ2V0X3BhZ2VzKHN0cnVjdCBiaW8gKmJpbywgc3RydWN0
IGlvdl9pdGVyICppdGVyKQ0KPiAgIAkgKiByZXN1bHQgdG8gZW5zdXJlIHRoZSBiaW8ncyB0b3Rh
bCBzaXplIGlzIGNvcnJlY3QuIFRoZSByZW1haW5kZXIgb2YNCj4gICAJICogdGhlIGlvdiBkYXRh
IHdpbGwgYmUgcGlja2VkIHVwIGluIHRoZSBuZXh0IGJpbyBpdGVyYXRpb24uDQo+ICAgCSAqLw0K
PiAtCXNpemUgPSBpb3ZfaXRlcl9nZXRfcGFnZXMyKGl0ZXIsIHBhZ2VzLCBVSU5UX01BWCAtIGJp
by0+YmlfaXRlci5iaV9zaXplLA0KPiAtCQkJCSAgbnJfcGFnZXMsICZvZmZzZXQpOw0KPiArCXNp
emUgPSBpb3ZfaXRlcl9nZXRfcGFnZXMoaXRlciwgcGFnZXMsDQo+ICsJCQkJICBVSU5UX01BWCAt
IGJpby0+YmlfaXRlci5iaV9zaXplLA0KPiArCQkJCSAgbnJfcGFnZXMsICZvZmZzZXQsIGd1cF9m
bGFncyk7DQoNCm5pdDotDQozcmQgcGFyYW1ldGVyIGluIHRoZSBhYm92ZSBjYWxsIGZpdHMgb24g
dGhlIDFzdCBsaW5lPyBwbHogY2hlY2sNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
