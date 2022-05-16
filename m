Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C215293A2
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 00:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiEPWcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 18:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEPWcD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 18:32:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE21D0DC;
        Mon, 16 May 2022 15:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2U6IlJ0hRDrYD+M61K9l65cTrBOKfKD9NBJFhuZwjWubgOTjdNAINXxIz/MazyE7DdSOaZQaypkbYP0IvU21e7sV3zvKhhF8gSTtYstmNjgJroAWUKfY9sisJH34uC4VV7tp7zW6e8XsFuH+UqRPdTgkTQVqaXuaWwdYceN/liu8pZ7dWF4EjV1ngHHzwYskFyECyAcBHlGUMS4AOA+6a+UrSh1daml3zGdMkHsdf8rh/JOWHSB6TTty4A8Hfas7Kf0NixP00KRCzF6htOkXXqqRpPL9YxwW3tpWvPp4Z1D2wnnun/RzGvFe2I+E4pQEMBYP66HmHxPz+vQETD42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/mQAKM6bqHMbXRZYF+pPXQM9Bf9DECqM5WqW2z1dV4=;
 b=fXrsgs2GReeZL3bKjTwlevQYQZbFFsf/HxnD7voProD3v4O/7EwN6sIgvUWve+Y0FAMxRZzFPXB50h+Vh6oyD3ICBZywWBoORHCPUbg2w/40E8s3IwdWOZT7rq6z06ijyuLiFXnpS4+8LThOFDZSMrV5w8p6TJdz71MiUMiLGYE0m2+sgjyPvHV/J5kdV/FaQpulHd4rSsSqRuMTCxzYvR7lpLzhcHQNSk5iD3v4YdtPsVty3TWYH4lNtCRQiqmX+ge3RnNSissbQJGhGYL2cBWp1s2ghw5Brafqz+DsfOuKwppwv29p43idC5hU/98svizOocm51+EXvSIqaEjzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/mQAKM6bqHMbXRZYF+pPXQM9Bf9DECqM5WqW2z1dV4=;
 b=XKD9/nP8lVGx2UkiGckq4Pb/XYBYaSxNHkelXjQcQxrhqX2jwpphXgvnA4+/nMEmZXQZRCW9RePlqBec/9hDEgLzSZA0oug88QFj/dtldrSDPE75Ee4ySdIsSwsNWvRctoQbkyolXrhOfTeMZDuojKYdCDr0B20mBkS+v2xk+pGWQ/3eGKOv/DeB4H5S6iq07z5OVYecFGkTZE9eN9RYv1kQhDoGjC157eCkNi2UDs/qpEPYpnZE5e5i744DAeJWk8PV0p6MUnBjzjIN34iN159EDQHA/49uDRaE3hKACpK4MpwoaMXWEtXF6ftxg0c/ZB/WfbM4JN8Ih6D+Th09Cg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 16 May
 2022 22:31:59 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 22:31:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v6 00/21] Userspace P2PDMA with O_DIRECT NVMe devices
Thread-Topic: [PATCH v6 00/21] Userspace P2PDMA with O_DIRECT NVMe devices
Thread-Index: AQHYSpcZbtVjcFNJRUCVznPA8fmLma0iVFMA
Date:   Mon, 16 May 2022 22:31:59 +0000
Message-ID: <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
References: <20220407154717.7695-1-logang@deltatee.com>
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca527a2b-6cab-41d3-5995-08da378be409
x-ms-traffictypediagnostic: DS0PR12MB6583:EE_
x-microsoft-antispam-prvs: <DS0PR12MB658300720DC3F69F4F13EF2FA3CF9@DS0PR12MB6583.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: angv3nDG5hI7TK1ntERlpSLuzQESIDH/JDxoOO8iGUo7lhqq63kbpcVhLOdtcBeT/mYnn4jfdjo8Dcol+k/SYQegBU7evXZJtnhFYJiNggTxSWFCASXchlyk9oWwsiv5/wqm7nkYSruO74z2OgSp5kLj8ZLgUETLPMaYwXgd48afegKCs8NhGurR77BOvPD5O0IMdIHW/MyKLJa6mp7Rfv53XceQv78fMjnFB34nEESjGJc3lI15Vio0b6boxkYjs9jQCCOcXMvI+AcGICh3RQe+xwcU6sOsLuVQeCnWGrzE0Mscc7tXMSq2rgWzK3eOHtYUc/Lv5DD5WtPoqlVhyUs0N9XIdD8qnbi+By090rGSnsXZaE5CeQhwnM4L782tw+PDFKnwTXA/GlMETdDTjq+/OILbfxSuLdqkFMqRZPKC/MJXPaajTGQh7wGu+GkA+gaPQ3WNzeWILjp8xWYVHYsWhwhwNzNfBJX8KuskDM8mhXFyhcOCf6D3nhHBwRS4JqEGFjBqB+gk1Elnj5Mqug3rl9YvYRNXLdwwWOtqJ4p+Rk6UI7sRRquzan4QmowNnBhZqvostS+W8Hvfi9W3dAz9uYMBgsVYRq+TWfdJB3yxdqjwp+DFRvB4nYawG0a3OBDynxLTYjf0kQiA3vgHC4+x8IbkJZIPlQ6c7vba0LpKxPW7XClmpxCzOaYwvU5Bh+9Vf8JTXPHO9bHWfQWvxUa3yqFzfHCqw+pHB9e75V+So/k/zq6yso+GE1E+VkyaVuYIBU8bdNZYsqtoSygSRTEAYU4JLuV+vrOmEF2uy6/NqzepWA+5DV2U9GEENQl3G+tlbAABJ1ek8gNixGQwg1dwb4Hvtvm4kBqiIkF7YP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(966005)(6486002)(53546011)(6506007)(66476007)(71200400001)(31696002)(86362001)(508600001)(84970400001)(6916009)(5660300002)(316002)(91956017)(36756003)(8936002)(31686004)(54906003)(38100700002)(6512007)(2616005)(122000001)(186003)(76116006)(38070700005)(83380400001)(4326008)(66446008)(64756008)(8676002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGdHRU1VckRXSUhCbWI0YlU3ek5kOWFNbVZ4dzlmdlNTVjJ3d21vQTY1c2hQ?=
 =?utf-8?B?R3pzZWlqV2lQTUdpWFdKck1sTWROcWR2S09BSVYzZlhYMk1tU0NsSDJvMzhC?=
 =?utf-8?B?MGxBMERwSUdCTGd5a25GRFdvck15RGdrUmNvYVg4cUdtanBhcWpUaVg3VVY5?=
 =?utf-8?B?N0pHTTNCNC9iZlF2Zk04c1l3bW9tZ3JGemxhcGZxem9FOWVJVnQyQ0U0M1Rn?=
 =?utf-8?B?L2JSbzNMeGlPeHpFWXVCUHQ5eDQwYmFGOU1pd01acGlXbFhiWmlkRWlZemt3?=
 =?utf-8?B?RFBCLzVvd0p5UUtwSHJqbjdsLzdaS3k4QUlnemI2c3d4SGZvbUU1dWtmRWdY?=
 =?utf-8?B?S0MzN0drcXJ2aSt0c01aVUd2aVBTeThBL2w5c0doUC9tL3g5NlJzaEM4Y1Bm?=
 =?utf-8?B?SVRxQVFpZElqU1VFYWthd2t2dlVlOW1Ydk1jd2tXeWZUYlVhbE12NGtvOGlR?=
 =?utf-8?B?aVI1QzhoRHRXenVUNUJiQjhIZDdrZnU1OEMwSSs0K3hUQ3NCTDNOVGhJbTU5?=
 =?utf-8?B?UFpua1ZXVHNlckNtOEZmcmlUQ1hodmVoUzh4b09jMWNGcm1HWndDWTdmb2Vh?=
 =?utf-8?B?WEZQdGNjQ2p6M0pQOVpvdHVJUi9mQ2pVNmdRTU9DTmZEY1lYOUp2MnYvMk9C?=
 =?utf-8?B?Szg4M1lZbWI2TE9yRmRraXFubnNhbStVYjdYQTJXZnlqOG1ETWhjR2pTdGQy?=
 =?utf-8?B?VzdWeTg2M0Fsd0hKc25kaURKWHdSSFozQVo4b0tHcTUyeS9kWno1TE1sZzNy?=
 =?utf-8?B?UEVrYnJzWTc4OEo3ZzRIZnUrT2RkUC9yVU16NFZJdmJmRmRCaVQrbWNkRXU3?=
 =?utf-8?B?czAyQkpWbStUaTZiYlVBZWhHYmpyRzFlSmp1SFNzODRRVmRQYkErblIzdkRE?=
 =?utf-8?B?WGpaOXB4d25jV1IrVngxaWwwaHZzdGdOekxpUFd4YkczbjlxaWxmbG5ESlM1?=
 =?utf-8?B?d2lHSXFMNmVQcFJFUXdHeXdHYXZ2VVdvVENYU0dkb3ByWTE0WE4rQkIyQXVi?=
 =?utf-8?B?ZnRudGdmMFlxcFNNcG9mNUtaVjluRDk3SlRZdG9Mb3Z0ZDZjeTI3cmRrRDV4?=
 =?utf-8?B?WU9iazF1a3dmSm5XSzBQZFlqQXJrYUJuMXhXMHhtOVRrWFh1aGRLYytUTm1R?=
 =?utf-8?B?OXorSFdRTE9pTE5vSXNqMU1TcE5ZTFIxdzNkUTFXRWx1NGVnRVdRU2JOZWJq?=
 =?utf-8?B?b2ZmQ0U4TU9IN2RkczJBWWdoTThHN2ZCcUh4QStTUzF0cUtBbFRTVHFFSEtI?=
 =?utf-8?B?dWF5cEJ6YVlUeEU0TXF2TFlheVBhdUFEblV6WXhIR0dwRmpicUVWTWdzalFS?=
 =?utf-8?B?SWtIZE9RdDN4Sllwak1VdXFaR3Y3dFpVMnJjV0tmMnE2NUh3bVR1bExOckIy?=
 =?utf-8?B?Q3BzQXFSQXVGaytUQVJpSlVXdUlDSE1ST2gyNHhVVEF6WTlKQ3Fwc2ZTRXRs?=
 =?utf-8?B?RTJCbmRKK1ZyUEthV3dCNzFKbFhXdDl0bEp0NUVDQWVmZzhsR0lzNUFnaWdi?=
 =?utf-8?B?bEVTT0RzcVBQcXNyR3MwVHNTWFhJemZaLzZRUWlhK0I4YjM3a3dISzVOWEV6?=
 =?utf-8?B?cG5jZmZCN2hhaU4vVnYwS2N1VFJIcnJPcjVWell4RlFLeksxVTdxdnhGWEg5?=
 =?utf-8?B?cStyQ2lybE5jdzVINFFBVUNHd0d1b1cxZFU3amxSdmVCNlNIZ3RHUXd5RXB5?=
 =?utf-8?B?N09MNTZGR1FXdk9rVUtVRWh3b2Z0ZGpIS2NXejVBT3dPdmMwcmRHQ05QYURQ?=
 =?utf-8?B?Z2h3cWtZQXllb2s1cTNlRGpHdXBuR214bWZKT0Y2dCtSUS96SnIyak1RSExR?=
 =?utf-8?B?N213TFk0L1BtVVVaWkVlaTQyKzROSU8yRnFKSm1jTE81amxKSHpSN3M3TWkx?=
 =?utf-8?B?elBCTHdhWUlvMUdBc0lBLzdFNnp0R3E1Vlk2Sk10SVp1djhWeXViQVRqSVpB?=
 =?utf-8?B?VWV0Z25DY2hLUnR3WEc0bnhkMldXdFRkRGx0ZjdYRmhPU2xlR3MyWlB4QmJk?=
 =?utf-8?B?RHZhS3dBMENjbHR2amRBd0lGQUQ0ZUVwTU9DZ0RIbXlhS2gzTUx0ZHhtV1dw?=
 =?utf-8?B?MStVZmQ3Q3VMM1hFc2F3R2ZVSFQ5amNrZ2FlOGFYT2VnUEtESHhyRm5lZ0l5?=
 =?utf-8?B?bisyK1BNQys0Z0kxUW9MYlhEcCtSMnZFY2M3VVRjanllelByQnhiV1M1U3h1?=
 =?utf-8?B?VmJuckE1SU1oZExjTGlMWmVzcGkwUnFVbkd0cDN1R0JCbDZ1YVg3VkFCUmRs?=
 =?utf-8?B?aEh1MHZxbUQvQUZGWDJEZzgrUmd1bmMrMmpZQ29nVnFmQXRBWjFPWnY0QlZU?=
 =?utf-8?B?NzNzRVB2U1BrU0Q3dGQxOEV5RGk3cUlZMitwamVBOXJtYTZaRUZpNXJ4bnV5?=
 =?utf-8?Q?FsZhFEUuXRDb7JXIcMiRw6SdEvGyr1MQNxK1lSN25a4Jb?=
x-ms-exchange-antispam-messagedata-1: G4znfkPT/fg1Jg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D0D0CC4518E5749887B7CF2168EA223@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca527a2b-6cab-41d3-5995-08da378be409
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 22:31:59.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/AT4uIhNYw6JgS/4FRov8Kp1AlKxUB0uBRsokaQS2Q04nt4IbW5L4Eo/XXkCbW8VXIc0lIVmVcV18FmcZgpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gNC83LzIyIDA4OjQ2LCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+IEhpLA0KPiANCj4gVGhp
cyBwYXRjaHNldCBjb250aW51ZXMgbXkgd29yayB0byBhZGQgdXNlcnNwYWNlIFAyUERNQSBhY2Nl
c3MgdXNpbmcNCj4gT19ESVJFQ1QgTlZNZSBkZXZpY2VzLiBUaGlzIHBvc3RpbmcgY29udGFpbnMg
c29tZSBtaW5vciBmaXhlcyBhbmQgYQ0KPiByZWJhc2Ugb250byB2NS4xOC1yYzEgd2hpY2ggY29u
dGFpbnMgY2xlYW51cCBmcm9tIENocmlzdG9waCBhcm91bmQNCj4gZnJlZV96b25lX2RldmljZV9w
YWdlKCkgdGhhdCBoZWxwcyB0byBlbmFibGUgdGhpcyBwYXRjaHNldC4gVGhlDQo+IHByZXZpb3Vz
IHBvc3Rpbmcgd2FzIGhlcmVbMV0uDQo+IA0KPiBUaGUgcGF0Y2hzZXQgZW5hYmxlcyB1c2Vyc3Bh
Y2UgUDJQRE1BIGJ5IGFsbG93aW5nIHVzZXJzcGFjZSB0byBtbWFwKCkNCj4gYWxsb2NhdGVkIGNo
dW5rcyBvZiB0aGUgQ01CLiBUaGUgcmVzdWx0aW5nIFZNQSBjYW4gYmUgcGFzc2VkIG9ubHkNCj4g
dG8gT19ESVJFQ1QgSU8gb24gTlZNZSBiYWNrZWQgZmlsZXMgb3IgYmxvY2sgZGV2aWNlcy4gQSBm
bGFnIGlzIGFkZGVkDQo+IHRvIEdVUCgpIGluIFBhdGNoIDw+LCB0aGVuIFBhdGNoZXMgPD4gdGhy
b3VnaCA8PiB3aXJlIHRoaXMgZmxhZyB1cCBiYXNlZA0KPiBvbiB3aGV0aGVyIHRoZSBibG9jayBx
dWV1ZSBpbmRpY2F0ZXMgUDJQRE1BIHN1cHBvcnQuIFBhdGNoZXMgPD4NCj4gdGhyb3VnaCA8PiBl
bmFibGUgdGhlIENNQiB0byBiZSBtYXBwZWQgaW50byB1c2Vyc3BhY2UgYnkgbW1hcGluZw0KPiB0
aGUgbnZtZSBjaGFyIGRldmljZS4NCj4gDQo+IFRoaXMgaXMgcmVsYXRpdmVseSBzdHJhaWdodGZv
cndhcmQsIGhvd2V2ZXIgdGhlIG9uZSBzaWduaWZpY2FudA0KPiBwcm9ibGVtIGlzIHRoYXQsIHBy
ZXNlbnRseSwgcGNpX3AycGRtYV9tYXBfc2coKSByZXF1aXJlcyBhIGhvbW9nZW5lb3VzDQo+IFNH
TCB3aXRoIGFsbCBQMlBETUEgcGFnZXMgb3IgYWxsIHJlZ3VsYXIgcGFnZXMuIEVuaGFuY2luZyBH
VVAgdG8NCj4gc3VwcG9ydCBlbmZvcmNpbmcgdGhpcyBydWxlIHdvdWxkIHJlcXVpcmUgYSBodWdl
IGhhY2sgdGhhdCBJIGRvbid0DQo+IGV4cGVjdCB3b3VsZCBiZSBhbGwgdGhhdCBwYWxsYXRhYmxl
LiBTbyB0aGUgZmlyc3QgMTMgcGF0Y2hlcyBhZGQNCj4gc3VwcG9ydCBmb3IgUDJQRE1BIHBhZ2Vz
IHRvIGRtYV9tYXBfc2dbdGFibGVdKCkgdG8gdGhlIGRtYS1kaXJlY3QNCj4gYW5kIGRtYS1pb21t
dSBpbXBsZW1lbnRhdGlvbnMuIFRodXMgc3lzdGVtcyB3aXRob3V0IGFuIElPTU1VIHBsdXMNCj4g
SW50ZWwgYW5kIEFNRCBJT01NVXMgYXJlIHN1cHBvcnRlZC4gKE90aGVyIElPTU1VIGltcGxlbWVu
dGF0aW9ucyB3b3VsZA0KPiB0aGVuIGJlIHVuc3VwcG9ydGVkLCBub3RhYmx5IEFSTSBhbmQgUG93
ZXJQQyBidXQgc3VwcG9ydCB3b3VsZCBiZSBhZGRlZA0KPiB3aGVuIHRoZXkgY29udmVydCB0byBk
bWEtaW9tbXUpLg0KPiANCj4gZG1hX21hcF9zZ3RhYmxlKCkgaXMgcHJlZmVycmVkIHdoZW4gZGVh
bGluZyB3aXRoIFAyUERNQSBtZW1vcnkgYXMgaXQNCj4gd2lsbCByZXR1cm4gLUVSRU1PVEVJTyB3
aGVuIHRoZSBETUEgZGV2aWNlIGNhbm5vdCBtYXAgc3BlY2lmaWMgUDJQRE1BDQo+IHBhZ2VzIGJh
c2VkIG9uIHRoZSBleGlzdGluZyBydWxlcyBpbiBjYWxjX21hcF90eXBlX2FuZF9kaXN0KCkuDQo+
IA0KPiBUaGUgb3RoZXIgaXNzdWUgaXMgZG1hX3VubWFwX3NnKCkgbmVlZHMgYSBmbGFnIHRvIGRl
dGVybWluZSB3aGV0aGVyIGENCj4gZ2l2ZW4gZG1hX2FkZHJfdCB3YXMgbWFwcGVkIHJlZ3VsYXJs
eSBvciBhcyBhIFBDSSBidXMgYWRkcmVzcy4gVG8gYWxsb3cNCj4gdGhpcywgYSB0aGlyZCBmbGFn
IGlzIGFkZGVkIHRvIHRoZSBwYWdlX2xpbmsgZmllbGQgaW4gc3RydWN0DQo+IHNjYXR0ZXJsaXN0
LiBUaGlzIGVmZmVjdGl2ZWx5IG1lYW5zIHN1cHBvcnQgZm9yIFAyUERNQSB3aWxsIG5vdyBkZXBl
bmQNCj4gb24gQ09ORklHXzY0QklULg0KPiANCj4gRmVlZGJhY2sgd2VsY29tZS4NCj4gDQo+IFRo
aXMgc2VyaWVzIGlzIGJhc2VkIG9uIHY1LjE4LXJjMS4gQSBnaXQgYnJhbmNoIGlzIGF2YWlsYWJs
ZSBoZXJlOg0KPiANCj4gICAgaHR0cHM6Ly9naXRodWIuY29tL3NiYXRlczEzMDI3Mi9saW51eC1w
MnBtZW0vICBwMnBkbWFfdXNlcl9jbWJfdjYNCj4gDQo+IFRoYW5rcywNCj4gDQo+IExvZ2FuDQo+
IA0KPiBbMV0gbGttbC5rZXJuZWwub3JnL3IvMjAyMjAxMjgwMDI2MTQuNjEzNi0xLWxvZ2FuZ0Bk
ZWx0YXRlZS5jb20NCj4gDQo+IC0tDQoNCg0KRG8geW91IGhhdmUgYW55IHBsYW5zIHRvIHJlLXNw
aW4gdGhpcyA/DQoNCi1jaw0KDQoNCg==
