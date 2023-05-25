Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B6711876
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 22:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEYUwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 16:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEYUwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 16:52:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B0D3
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 13:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqTlNtoX29dfTNIYDm92hhqO3cTOvD3hEWO533c7EM38IO3aznVDs9bs8nxNFclIUg8CL3HCEW2oKFd8o6x03E344o+YtuuTspUUn7X1valyFMCXS6Z4EV45W4QCLLQeAP1lWMw7xwhX/th3ZnSoSC7u3THIIJ1WupL9rcMHmu/ZpUkkW7hCW5VHB5sMCwp0lFr5UXY4HdwuCQmN5xuec7NOA3xHuF2d35xamTOahf/nfUWoJlMcRiFdGCjG9m3Kc4tTIvf+O6Zc7KMZaJc1pZlPBkpRQAm3VCrc4NEQ7gpufBcLpCpkGziBUh5jhG7xYHfGCqPnLOM1MyYWc79fWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caWNHDnAD6f0KdjXJvnZSe6bG106tlGqa7HftcDu5p0=;
 b=XOATxOZcR8CTwMJO5ry3l7TLzeI/CgOjp9WK0Clu9zgkNQtT18YV4bJKXNV5QMmOwUgPXjal+B9zi+Dy6+yYEUwE3J8vAMtr2XXOE+6Tvq7KqUPBwcGwmJy7VIfNwLktwn5r/T+bAYMcoNvzq8tLahT2TSVfwn5shf2LF3ZPRutlIox9V6Dc/A+RJN18RwtCSXZt+mmd2/Ys0J6t6g1HbKTNfhH5Z5NBhZ3sgyKrTTOBM0xRRt70zs6wkE+wPl9pabqZYHuO/TjBeQKpzSWIDcgZXW6KmMwycFPthkeckpGJmjX6nsF72vLI4Ikr6UOg1Q93ay64c1hoCtfJE551aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caWNHDnAD6f0KdjXJvnZSe6bG106tlGqa7HftcDu5p0=;
 b=SS/7qxBx8CgKohFKAY3ZcONcxA5HWshYRz6FvgobwUZs3nfMy4fa/xNjil40JCKlNpWnzZ7Z4OW3B5Be7YnupqwIJDw1lLtksNClTEF94j21hNCQcT3TpUIeemK9Sbn+pmD21Y9Qs7ScEVMy44LP/uP6zb3hK/S3SzwWEbky1xU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 20:52:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 20:52:06 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Zhang, Morris" <Shiwu.Zhang@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: add the accelerator pcie class
Thread-Topic: [PATCH] drm/amdgpu: add the accelerator pcie class
Thread-Index: AQHZjSt1vL33XREOB0eQ13Ys7/aLOq9nZ6QAgAB8dACAAt0igIAAuM6w
Date:   Thu, 25 May 2023 20:52:06 +0000
Message-ID: <BL1PR12MB5144DDA502D52040945DFC4BF7469@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
 <ZGxfEklioAu6orvo@infradead.org>
 <CADnq5_Pnob2+NPyf6GEcsCExC26qg_QvTri_CQLT=ArPibSxSA@mail.gmail.com>
 <ZG8ud4JWpF7BXJ7c@infradead.org>
In-Reply-To: <ZG8ud4JWpF7BXJ7c@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-25T20:52:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e8b57e38-81da-483a-971a-57d2f6ba75af;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-25T20:52:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ac16eec1-307a-4752-882b-bb70ead7ebc9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH8PR12MB6916:EE_
x-ms-office365-filtering-correlation-id: 23795f89-f0dd-4133-d73f-08db5d61e659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1W4AkAjgpTGhFfeOxa0nEg/AIugkY6ROLYDhCAGGl/0uq02Hq8wzbhYgsUv8HdPFBzCDU9Kv3hHe3s4qlh+hifBi0docmCKqUpz6T8kJVofYaPQZuPTP3yIODx14QApWQAXZE0mU2apr7uoSl2WSjCV7klS2UaoVtYr51eGwF0vQiVDXeWwdOGAgxep64tb2uxsqYyXRZRCUCDkDku3iOoZDw81XNw8HRQvcH3IZpgaOyqzTDHGVx5BLPwfC8zdq85+MzcDxwOO2yet5ziMCIkb3D1NdzDY3Z3gKPWWkGcVpYF5AHwx6vGPX9CRkXz//Uw49RWzXpsQYux4P3OmDY+siJZnT7eNE2Gw+wvQDHVQtRPBIxe7WARG8p0Vl7av+vU2bdvrSyiAuqcpWcjIMt0hqCDSbvGjjjpqQvJoc9MW5345yZp8lPSLpWG8XawFVZQbZ2wCVbwz3f3o0PG5cFITh7VONFNMxr8MX5lO7yhPXJ+TWZXziZ11U73toG619vlRo8EOGuO3faX1SdWVvkYQSV74+olZ8eIgBem5Xw6UYL3nyqZVKfo7tYgF4bZCj+NdqiEaxZGQjNpz8VXoNqBeQj201uCyi+fb08N3FctA34QDtw2p9NaQt04X+xpt+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(38070700005)(86362001)(33656002)(55016003)(186003)(2906002)(83380400001)(316002)(71200400001)(76116006)(66446008)(4326008)(64756008)(66556008)(110136005)(8936002)(54906003)(66476007)(66946007)(52536014)(5660300002)(478600001)(26005)(9686003)(53546011)(6506007)(41300700001)(7696005)(38100700002)(8676002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0E4dGd3SzQzelVwZkYwck1UVjloYW8vd2RnWmJpdEJGZXZJaGVaZWt2SHk1?=
 =?utf-8?B?Ym1aUjVkUFhIZ0VVZ2J4L2VyU1Fub2RDUU9CeTdrZCtlcXpQZDkrNzNldDRO?=
 =?utf-8?B?bUV4L3Yra0ZOa25zK3pVOFJhVVZZVlRNblFuZFdoL1U3NmZ1NHhLTUdldEZz?=
 =?utf-8?B?ak1FUHhvaHVXNE9WUnlaenYzSnBvQUdYSGFZRDRkK25PblZZTS9DRDZRNXBP?=
 =?utf-8?B?OGZJSnJLN2E1WngwWUhBeUJCY2VDSXEyZEQvQTJ5cExoaFowSzk3VEhsS0RT?=
 =?utf-8?B?TU9zSnNQY1VvQ3ZOdGdyMVBsNDJxYVRuck9ydm9LaVJPWjdPR2pQN1VKVWU4?=
 =?utf-8?B?RWxDS0NrVG9STHlKcFFINkMyUzBmN0l0Z21UaVE4U0xJR1FsdEFDRlBLZE9o?=
 =?utf-8?B?OTFsNmpiTk9Eb1FpbDNIbEd4N3g2L0ZoZXF2MS9vb1NUODA2RzAxeWpCSHgv?=
 =?utf-8?B?R0M3WEl1bHhLekhIbEJFbGJsNHhHcnl1Tm9ETkt3M0ZuSUdXWmFVVzhxRkRq?=
 =?utf-8?B?OFh2MUR1OGRuVnRaeW1KTTFGcFg2OURtNnRVWVZKbkljcVQxeUp4MmJqb2lr?=
 =?utf-8?B?SThHZjFIOUl6RW1CdXdQalZCckl6VlBrbG05WUVzcWpza2tPYWcyVWJTc2NV?=
 =?utf-8?B?YWVPeEpuMkdFa3h1TWkydWk3NzcxdDc1dHRxenc3bVEzdm04b1d6eEcxVUps?=
 =?utf-8?B?OEJzNmswTzBsQWpEL2JQRXF6KzNwMWFndTM0M3g5S1hRelpXb3BoN2pVSUZS?=
 =?utf-8?B?YUFNU3cyZW1WcmwyL0t6VzUwT0NrZUNjck1Rc2p5NjZldHYxMkx5L3gyNHB6?=
 =?utf-8?B?NFYxa2o4U3RzeEt6Yi8wNGJKVUcySG92akRmOE5OQ0dmSTJIRmQ0WndnOVJ5?=
 =?utf-8?B?SVRuQ0RrYm9NYXgzNGpMeDB1TWpWM2ZjVC9ndC9wdmlpcm5JQjBOaWR6c0F3?=
 =?utf-8?B?WHd3aWtSbEJaM0o5dVp4bytUQVEvV1o2dHpoQUQ1SWNTR24wM2VQaVh4ZU9a?=
 =?utf-8?B?Yy9rU2VMUGJvS2RGcjVXTm1sdjJzQjZhb0M3VnpCZC9keG5NbXNsZnZaTXpq?=
 =?utf-8?B?bkdROVZLcERhQ2VacHA1UW1xMmVKV2x6aGlhZS9BOHU1ZktyT21yeGFNZVdu?=
 =?utf-8?B?SGxYbjRVUG9iMDdCbXIzRVZnOWdRampDZU5sNDgzSkozQUZJanlNTUR4N2JK?=
 =?utf-8?B?UjAxMXkzRkpvRk0rWmNnNDEzNUVnTmw3MGN1SE0yanVSR0xLcVNXMlFGakNG?=
 =?utf-8?B?V0gyRkFyMmhZanNweEEyTXZ2cVN5K083QzFzc2hLQUkyem0rYThsMjZmTE5G?=
 =?utf-8?B?YTYrSTZHaEJhYm50dE5ZaTg3ZGY0RFkyVnpHSnNsQmpvaGxlbFJ4STJSd0sv?=
 =?utf-8?B?ZVE3MHdaSkpOcHd3NCtydmUzbUdJRWF4TzU5VWx2TjNOYUFGL0daUktKQWd4?=
 =?utf-8?B?ZlljdWxsZmtvcmQ0U0wxdWVQVjFJQWhKekhXb0dtRk5OL1F2aXQvSjJFMXJq?=
 =?utf-8?B?MEFwRWJ4cUJkcFNVTm44QkpvTmNhOHFEcmF0aVdOTHVsV2FmNUp4TTlVa094?=
 =?utf-8?B?eG1xT1B4L3VwdHJQa1ZvN0ppVTAvOVgzUjVnbXJOMU54YjRycXJaQ2Izcmhy?=
 =?utf-8?B?TUJjeTRycjhGYi91NjVRWnBCVVNKRXNGbis3cmxKSFA5cStKT2Y3bGxlQTY0?=
 =?utf-8?B?by91R3VnQ1VRQUtpYVh4YUdobytKN3ROOENBclZzZmdCMWREYkFRdFF2Ym5G?=
 =?utf-8?B?WThtUkUvays0ZEw5c29IVm4zaVk1OHJzU09WcEwzenI4T2tnQXA1NkZoWFhW?=
 =?utf-8?B?eGFXdEdzUnBOdTBFUDR6c2IxUXVuc0lrR29XNk1ieVVReEVrWVlyVGZIdlNJ?=
 =?utf-8?B?UWRGc01zVlRWMklmanV6WER6aEdVYmtQSGtCdHJDWU1lc1RJV2NveHZ1RmtT?=
 =?utf-8?B?QnIvN05BWDMvKzNtSHVDaG9VcThkRU5rWDZkME5XbXM1ZllBbXREMTlKR0pl?=
 =?utf-8?B?dXc2b01aNkIxM3A5anR1WGdSQ256R0NBbFVCWlQ1RC9PbDNZUDhVdmRFdDRX?=
 =?utf-8?B?ekhjUW1XRVdGbzJFK0JYczVJL0ZKODFSUVJzWEFDSCtFMDM4STBwM2VodHUv?=
 =?utf-8?Q?FwRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23795f89-f0dd-4133-d73f-08db5d61e659
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 20:52:06.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1UdW80uOtalis7KTKI1lStvqXMDPy2qHlz9BBFGRfbroaZkiItB7FDEY/i5/yoGDX+wPg7Q5+nCJtrW1gE4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IENocmlzdG9waCBIZWxsd2lnDQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgMjUsIDIwMjMgNTo0NyBBTQ0KPiBUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+DQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFpoYW5nLCBNb3JyaXMgPFNoaXd1LlpoYW5nQGFtZC5jb20+OyBsaW51eC0NCj4gcGNpQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgdGhlIGFj
Y2VsZXJhdG9yIHBjaWUgY2xhc3MNCj4gDQo+IE9uIFR1ZSwgTWF5IDIzLCAyMDIzIGF0IDEwOjAy
OjMyQU0gLTA0MDAsIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gPiBPbiBUdWUsIE1heSAyMywgMjAy
MyBhdCA1OjI14oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPg0KPiB3
cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE1heSAyMywgMjAyMyBhdCAxMjowMjozMlBNICsw
ODAwLCBTaGl3dSBaaGFuZyB3cm90ZToNCj4gPiA+ID4gKyAgICAgeyBQQ0lfREVWSUNFKDB4MTAw
MiwgUENJX0FOWV9JRCksDQo+ID4gPiA+ICsgICAgICAgLmNsYXNzID0gUENJX0NMQVNTX0FDQ0VM
RVJBVE9SX1BST0NFU1NJTkcgPDwgOCwNCj4gPiA+ID4gKyAgICAgICAuY2xhc3NfbWFzayA9IDB4
ZmZmZmZmLA0KPiA+ID4gPiArICAgICAgIC5kcml2ZXJfZGF0YSA9IENISVBfSVBfRElTQ09WRVJZ
IH0sDQo+ID4gPg0KPiA+ID4gUHJvYmluZyBmb3IgZXZlcnkgc2luZ2xlIGRldmljZSBvZiBhIGdp
dmVuIGNsYXNzIGZvciBhIHNpbmdsZSB2ZW5kb3INCj4gPiA+IHRvIGEgZHJpdmVyIGlzIGp1c3Qg
ZnVuZGFtZW50YWx5IHdyb25nLiAgUGxlYXNlIGxpc3QgdGhlIGFjdHVhbCBJRHMNCj4gPiA+IHRo
YXQgdGhlIGRyaXZlciBjYW4gaGFuZGxlLg0KPiA+DQo+ID4gSG93IHNvPyAgVGhlIGRyaXZlciBo
YW5kbGVzIGFsbCBkZXZpY2VzIG9mIHRoYXQgY2xhc3MuICBXZSBhbHJlYWR5IGRvDQo+ID4gdGhh
dCBmb3IgUENJX0NMQVNTX0RJU1BMQVlfVkdBIGFuZCBQQ0lfQ0xBU1NfRElTUExBWV9PVEhFUi4g
IE90aGVyDQo+ID4gZHJpdmVycyBkbyBzaW1pbGFyIHRoaW5ncy4NCj4gDQo+IEhvdyBpcyB0aGF0
IGdvaW5nIHRvIHdvcmsgaW4gdGhlIGxvbmcgcnVuPyAgVGhlIGNoYW5jZXMgb2YgdG90YWxseQ0K
PiBpbmNvbXBhdGJpbGUgZGV2aWNlcyBmcm9tIHRoZSBzYW1lIHZlbmRvciBhcHBlYXJpbmcgaXMg
YWJzb2x1dGVseSBnaXZlbi4NCj4gDQoNCldlIGFscmVhZHkgaGFuZGxlIHRoaXMgdG9kYXkgZm9y
IENMQVNTX0RJU1BMQVkgdmlhIGEgZGF0YSB0YWJsZSBwcm92aWRlZCBvbiBvdXIgaGFyZHdhcmUg
dGhhdCBkZXRhaWxzIHRoZSBjb21wb25lbnRzIG9uIHRoZSBib2FyZC4gIFRoZSBkcml2ZXIgY2Fu
IHRoZW4gZGV0ZXJtaW5lIHdoZXRoZXIgb3Igbm90IHRoYXQgY29tYmluYXRpb24gb2YgY29tcG9u
ZW50cyBpcyBzdXBwb3J0ZWQuICBJZiB0aGUgZGF0YSB0YWJsZSBkb2Vzbid0IGV4aXN0IG9yIGlz
buKAmXQgcGFyc2UtYWJsZSwgb3IgdGhlIGNvbXBvbmVudHMgZW51bWVyYXRlZCBhcmUgbm90IHN1
cHBvcnRlZCwgdGhlIGRyaXZlciBkb2Vzbid0IGxvYWQuDQoNCkFsZXgNCg==
