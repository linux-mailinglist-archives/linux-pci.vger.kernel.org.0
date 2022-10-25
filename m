Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E793D60C131
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiJYBm3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJYBmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:42:16 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1FF593;
        Mon, 24 Oct 2022 18:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+Pzhp1riyBHsiCKzUL0UOxaaddr84ijHaEhSFZsSstI1LCuzKrGdf/O8W8NRbfjb7TSfy05RkNFcUFPe39uae6rnelTcTbXZGpurr3tt7RHWSAzArq/ruz2U+ZAJGCkuvialdN0H9z44N08PKx/3+pkIs7cZvexNlgHV+jTvK1qRbL1w6tsTnZtjEyidQRnXUbBGPUSVtWyDWE1y6xA+Te8luAeny1NmyLKWCpeX/ypIs/SCIhS7b6qwHTScUVszEP12lKL+Lp0X12k9J+b0/j1KCagfKMrXEiIqsp2Vp+Pf6vIvgVhVxrZ8f1Z4yKIB4noNrFczkie42o1HDNqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbNuHVzZnKRBXNb8pDxaxxNfLb1WpcxJ198Z6hbYiiM=;
 b=obci0LtnIkhH+HlIpG4ZpXHpst9NT8841NFJLmPrpHnjiea0uMtPgM6gAduEREkP7/QFYzweHLmnmElznTNoNeB9e2/5U9EKCCAGcEHMDNxjGpSywGZAR6qBpgWhm6pYhBehIz8FA/vIP4ah1waNx5RhHvuGMz5p1ZE2xoSir8VwDRM5iOxfrU6zl1n/pCeHNmVLaUIQ8G71J7yJl5yuZYlEExhT6Kl1hIUvVhGKyW/Ofa3i9uRbpdSvaEoc8bEz8aAiPnt0A/T7obajWFxnyvZa6M63MdQ4L+PFBqb1ky/u/JImIrdkRUg4h9rk6ccX0n1HLlIdF3Er7hRmvmUWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbNuHVzZnKRBXNb8pDxaxxNfLb1WpcxJ198Z6hbYiiM=;
 b=pvMmJ9g6phJctpA2yhJ2ITLzr+g8PJTdLWp5qXwFnzozwcN4CyxtyVIa7jdFVWtzdWjSJ9KrMl9SKZ3/6Ok2U/nxECq+p9cN9M/mIXrFAqGRyCeDpaXpy/sCavBuwBQFIb6zn+nXMlpC5ZTxnlCOFMYfaApojUvVbXpgEY5eGyS5SjrXGKvIZ/ozhdy2M6TLAxn8m+ztX/Z5OKe8deu6KPEXL9DIvrgI8yKXocSL25BoxGXpIEnKj1nuXfnKkxyFmvdmNolnfSWB+wGOgzcJaN8QUy9udKZaIGZW0uXcNCGeei16VhkcVwEMTzDkxp8C+WGFB1ORmbJp7hLaO8oA/Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 01:23:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:23:21 +0000
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
Thread-Index: AQHY5XRgWKJ5x6FvqE2inQmSnDSnaq4eVaKA
Date:   Tue, 25 Oct 2022 01:23:21 +0000
Message-ID: <f2995bf6-66c9-ea22-bd94-9efb87682a49@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 272c30ec-47ee-4276-32ef-08dab6278146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwyyCs2DGBcas7gRsH6+cW9/8tFiRL6B5UZAhPi1gnZyrEteaGmB/PQeNr8471MxwrT9IwHzzCZzHfcyXkTuswGq3fuf1w19GwSrlHMs2hweSLiGcoMPNIrQTSG8quYOe99ldvJFebCBoXuTyD04baDcWdS0k0G/OoHUShN5t3JOOfeeVnjlEgVbwKFads1e++OHVB4/5wG+rD+4sXmeCK6WJA859GUg+KWL45ofc/ECY0Od0sP7Fuk9N1iTsCesEktIOCYMzNeWT4KrAenNlLxYZUGK4PgTtny9RCWqRVQrX9s327kyw+qVXjNf++nQwzvR527FitonDjgC2glQDSaaF9egd5g2OKLurG1MIcKXPcVi32orZhJXv1nnuCUI4jWduNK7HkklVcRul9dtcV5QlqlfnJyy4Qk27htZcWOBSUZQTzgoBuw991xJnDe9KmmjswqUD42z7WaiX4Wpl33dDi5h40EG3exP34DP/rerUZOqTEYttlrUUJEEUE0ajZlENoZycXSYtodKlqGwM4/R1Pupb39YUS6QvleZPcR1WWFNjIJA7/GB/JNIMt9XAsOZCIDS+bqtegOxmkJ0y7uvOwFfQ26mVg7QivwjVGe1xDkpm0zZbKpX9C68MkV1PyxFWX8doaGSF7yMwyzClt7dmJ53vvFlRWvBxGBE8s/p8OOXNqMk4h1XP/E+6JidDQahBJE+Lx0R2YDZWmyfaHceep0NgUja4SSOk+k8aBijcN70Y0GKwbIVyGidzbM31atqVnIgj6+88MpoRYpot2WOhlj+/YbOT2fmNe983mzpdAs5holsZVBwBTD7lbWrcpvk0CEcc7I5hUszl3FOeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(31686004)(36756003)(38070700005)(8936002)(5660300002)(2906002)(4744005)(38100700002)(122000001)(86362001)(31696002)(83380400001)(7416002)(186003)(6512007)(316002)(110136005)(6486002)(2616005)(41300700001)(66946007)(478600001)(91956017)(66476007)(71200400001)(54906003)(76116006)(4326008)(66556008)(66446008)(64756008)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWY4bFlJTEp4enZTMFZ1dlAxWE1PbVZ1bXJUV3VrTnhDR2NtSkQxNCtFTEJi?=
 =?utf-8?B?QjBKZCttY1FMVXZacHhzZTVrVFVoSHZReEY4RnQ3OTV4aDRWWDRKYU11NG1O?=
 =?utf-8?B?QTkxRHpERzAzWjM3RXRGdzBYdXdUV0ppWVJ6dXlIdzF5WDhGY080aTJkajNw?=
 =?utf-8?B?VVFFMUdPR0cycmxFQTBRbGV2ays0aGZhNFZmN2tBWmZMZEwzRGh3dHVTN0t5?=
 =?utf-8?B?TWdrQ1M0REp2a2JheUxFMHZuZWhDWXJMTFRTRW1CV3owWFlGSHRVd1pPc0xu?=
 =?utf-8?B?QlMvaGllYVpPdmxxWXVlOUdjRlhlRlpaWHlZY2pKUk9lVHAwWXhsa0NrLzhy?=
 =?utf-8?B?WEZSakRpMzR2UXpMUUhxcjQyd2kzeDIyekhoS3FRa2RiazJwSEVEUnFSRVpR?=
 =?utf-8?B?a1o0SWVtOFNoRWZDS2lPVFlFR0djWXRNcUFPWU1FcktyeUpHSjVCUVB6eDNW?=
 =?utf-8?B?aFVQcHo1UXN4K1NlSlV6WEZTN1JGbDU4R2RuQm1McElWRTFaTnBLVUxrcFlM?=
 =?utf-8?B?MWp6eWxyeDR6OTE4SmxCZkx0WWxWcVFVWVM5WFc2UWR4djQvSjZvZG5WaFBn?=
 =?utf-8?B?aTV0NENFUlRybmZTNzRlUG5XM1NlVkpPQi9xa2FVTW5oSzdqTEtBOVNCdjhw?=
 =?utf-8?B?bjdrcEFSS0IrZUw1bG9ycU43eEZzalZ2UkUxbzRxdEV3SzBTcnJDaFpmL2ky?=
 =?utf-8?B?Ri90NkZNVXN0ZVdOUW51Q09KcEVGcTlJeEpzbWdLSkhhaWhKRzFzS2JEaWtH?=
 =?utf-8?B?Y2JqMU4rbEh6bkszdHY0YVlDV2JUdkV3Q1NlakNvcHE0T3RDcFU1a3lJcWEx?=
 =?utf-8?B?OFVOeVFRRms3akc5dU9Fbk5FNU4yaU9WdnY0bUx4Qmx1cDc3VU81bFlVeEgv?=
 =?utf-8?B?TzBKRndGUzlqZkcyK0lKcXdlQy9MTkdidEQ2cFBoYW5RcXl0MS9pWHpkRnlm?=
 =?utf-8?B?R3ltYzFvQktRb2U1SEJPOFo1YlNneXh6dG5kaXJOVlY5bFF5Z0kxU04yb3VN?=
 =?utf-8?B?MXRPOFU3d0E2Y2Zjby9tN3ZLN2pWS1RFYjREcmcyTjRpTmpqbkxoSkRwR2Rn?=
 =?utf-8?B?bXVXMTFqWnlIbUp0cnVwTHpzL2FXWndNTU5PTDRaZDdyeUpQYmtNbHNqV0ds?=
 =?utf-8?B?S0lMRldXTW5nSTIwUE9rbkZHR2wzc1hBTzIzOFI0a1RueW92S0Ura0hjcWNM?=
 =?utf-8?B?MC9oWGR0QTNmWngwQ3NTNnk1azNjR1o2V3cwR1Q5SkN3eks5OWtDazkwd256?=
 =?utf-8?B?blIzdGtHSE9EK2k3b1d6OWwydkJtSWFtanVuQkZ3UDlmbDdLT0U2TTJBN2U4?=
 =?utf-8?B?UEswNEhMSGdWMi9wRXpsSHE1Ni9xQkgwdWw5RlA3OE5ra1duQkVqb1hMdENn?=
 =?utf-8?B?NEZqK2dBYXRYb1dWZU1HeHc0N1hDd080ZGlFSFJrVm50b0NhRFpTdXhSZlRF?=
 =?utf-8?B?Yng1MXNYbWhhY3JxVWRGQ2hxMnIxZFhRU3o3cUJ0THVBSkd4TlFTN1JkbVY2?=
 =?utf-8?B?M0ZqTWxrL3RHbjg3MHUzMUc3bTZ3Q1Y2S1h1MU5LcXB0UFRiMFBKMzl0bFJV?=
 =?utf-8?B?WGQzYzlrdUFMRUxBM1hhTGYxTFFEYTJhUCttcDRTRGduV0hjY1pyclRMT1Fy?=
 =?utf-8?B?WG5zQ2VFK296cVpWYVZkMGMxZXVkNlVzUW45c0N5bFpkY3dVaUU2K0QzTU5h?=
 =?utf-8?B?alk2MnVpQ2plcUJoOEhKWkJOU3h4ZUszeE03NmRTYWlYdEEwV2ZtbHJ2Z1ZS?=
 =?utf-8?B?dC83R0xER0kwVnBaMUV5ZFNuZmZ0V1N5NmFRVnN1bkx3NXBxUlVvNVZNQXBX?=
 =?utf-8?B?NDFlWld3NDEydUw2eS8xR3A1Y29wNkpWOGZhN3V2b3dBYUp4eVI5dFR4NzJE?=
 =?utf-8?B?MHdya29wdjFjdHVnS3orbTFHRjRRNTFoQTFzOEc5TUVPZk5abTZUSGM0eUcv?=
 =?utf-8?B?Sm1QakF2YldDUnA0MysvY1lGY29pRUYxREVHeFBKcGFXaVQzcXJ2a0tJK041?=
 =?utf-8?B?SXpFalVQUWp6VWhMZEpaVDV6MW5uUFVTcERTUi9XOGRIandISVd5b2xTUnVl?=
 =?utf-8?B?Wk03WUdVUWwyK0hxQXhhZC9SVVJSblFBeUlvZXI1bkc0NGdQaU5XYW1lS2FM?=
 =?utf-8?B?ZnR4YjhuYkw5akJpdXdEeWdLOFl5elRqbk0xMWgwcitOTjdLclRRRGtHTGlM?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15BB1003F3EEAE45889ED75D08050D0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272c30ec-47ee-4276-32ef-08dab6278146
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:23:21.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7FfHFTXm2CLqHS/LvDp4mu3o71Rh2WvGPvAyRzjPrOSScc4QOyXzlToZFn+oyg90ZMjd/8P67fRAu+oya5ZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LyoNCj4gICAJICogRWFjaCBzZWdtZW50IGluIHRoZSBpb3YgaXMgcmVxdWlyZWQgdG8gYmUgYSBi
bG9jayBzaXplIG11bHRpcGxlLg0KPiAgIAkgKiBIb3dldmVyLCB3ZSBtYXkgbm90IGJlIGFibGUg
dG8gZ2V0IHRoZSBlbnRpcmUgc2VnbWVudCBpZiBpdCBzcGFucw0KPiBAQCAtMTIxNyw4ICsxMjIx
LDkgQEAgc3RhdGljIGludCBfX2Jpb19pb3ZfaXRlcl9nZXRfcGFnZXMoc3RydWN0IGJpbyAqYmlv
LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQo+ICAgCSAqIHJlc3VsdCB0byBlbnN1cmUgdGhlIGJp
bydzIHRvdGFsIHNpemUgaXMgY29ycmVjdC4gVGhlIHJlbWFpbmRlciBvZg0KPiAgIAkgKiB0aGUg
aW92IGRhdGEgd2lsbCBiZSBwaWNrZWQgdXAgaW4gdGhlIG5leHQgYmlvIGl0ZXJhdGlvbi4NCj4g
ICAJICovDQo+IC0Jc2l6ZSA9IGlvdl9pdGVyX2dldF9wYWdlczIoaXRlciwgcGFnZXMsIFVJTlRf
TUFYIC0gYmlvLT5iaV9pdGVyLmJpX3NpemUsDQo+IC0JCQkJICBucl9wYWdlcywgJm9mZnNldCk7
DQo+ICsJc2l6ZSA9IGlvdl9pdGVyX2dldF9wYWdlcyhpdGVyLCBwYWdlcywNCj4gKwkJCQkgIFVJ
TlRfTUFYIC0gYmlvLT5iaV9pdGVyLmJpX3NpemUsDQo+ICsJCQkJICBucl9wYWdlcywgJm9mZnNl
dCwgZ3VwX2ZsYWdzKTsNCg0Kbml0LCAzcmQgcGFyYW0gaW4gYWJvdmUgY2FsbCBmaXRzIG9uIHRo
ZSBmaXJzdCBsaW5lID8gcGx6IGNoZWNrIDotDQoNCmlvdl9pdGVyX2dldF9wYWdlcyhpdGVyLCBw
YWdlcywgVUlOVF9NQVggLSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZSwNCiAgICAgICAgICAgICAgICAg
ICAgbnJfcGFnZXMsICZvZmZzZXQsIGd1cF9mbGFncyk7DQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
