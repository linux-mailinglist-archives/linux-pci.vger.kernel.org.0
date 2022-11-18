Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7B62F022
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiKRIxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiKRIxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:53:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02510C6;
        Fri, 18 Nov 2022 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668761592; x=1700297592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A1qIAU9idrRErM97lUYIdzC+Mi4WSEP5u9fIZEdwKTw=;
  b=MsjazxTE7glmF+qgb26uh9zsj7LBOJ5Oh1w0XwzRgAkMkQPe59P8xLWu
   pW1YMbw/nUQwShF0XV5hjbzvqI6bno+52nqy5UgJb0zTlRNHTqmMfXdlY
   GZ1nNT6AAt58nmOBMtVsFQDab/Jh1RSiglaU5wKLkWQ80EZFwafRMp5BD
   rZTkGzRLAUwngbLNh31Ri36xY7PYFmsFn+kpY2Q/zMatAsnAbofAD5O0C
   rvhlIrHHNh/X6eb6tq4XNeal1IiJDQaoLqtXr5SecfYJFRaNWtUIC2kBl
   oYWwN9feZcw63HNXKpLeatqi1JOjl4Cce75CWSeCFS2zEveo4J9QPaBLF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="310722383"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="310722383"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="885228284"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="885228284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2022 00:53:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:53:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 00:53:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 00:53:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCCzL0u+drzP8/Yh+THLm+9bx1NNzVakynJUuXvL5n5BS8b6xOzdq6HOn8y4gqFzLAhzRDe5RUtr+48Y0Jb4toekiaRtVkSH1yLJ+cF1XoqB9irlRQ9rmX+5DnMJcelmFb4hgRxDZ9WyjYEI5AxprXhHRw1xKptzCTFnnjMgBwLtCY4Fef//uEriCxFchPsrVN2gM152qa+YDa466O94ph5NXxQNxQq82ExrqfK7SWb8/4pKSgjlc2aSoVHtDNPEtUjFqykckuBdJbEUzrKcEUhzXY+/IUmz95dogbSJRDgmDtBC3B7HIBfPqwgYtyY3Yhv43dViyGebESbQnmhynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1qIAU9idrRErM97lUYIdzC+Mi4WSEP5u9fIZEdwKTw=;
 b=IX9QK6wxmMqe1A3o81Z4fG1Yk5tQ3poHkU6qwHnuAnSifxkT8+lZUkfA4aaxQwHJFk5QZ+21JcXj2dmufsfpv6XZEbgVFJ7s8GMJ/EIdvXxcmhIHGrdWJl1TgntVKL35gkAIvAfSTVTJyhOdIr62xplY2URCGUdFWgcWtrezKAvcDyvNzHWyKnuGJFoCQbYyWe82micWZjICp7/4sEKz7rdBKvdcDtC3YyEUXecf2FbPLK6pMDD5Gt/PENTGoDKkJ3E/UfPxZ073YzlR4WjMrNG2hT7srVOWq/X3vdJM6e0L8kMYKHoJGE2N/apcjvwrlaw9bSS7wREj/U9/Z9l2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 08:53:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:53:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 17/20] platform-msi: Switch to the domain id aware MSI
 interfaces
Thread-Topic: [patch 17/20] platform-msi: Switch to the domain id aware MSI
 interfaces
Thread-Index: AQHY9dWDKC7bX1kJYkW+2YkiV/i4l65EaQ8Q
Date:   Fri, 18 Nov 2022 08:53:07 +0000
Message-ID: <BN9PR11MB5276453E63A0C02A4BB386F58C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132707.005001510@linutronix.de>
In-Reply-To: <20221111132707.005001510@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4594:EE_
x-ms-office365-filtering-correlation-id: aa62aea1-32e5-426f-3216-08dac9424ffd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CayKkIwIpgErkUV8+z5tGUvsmvjQ7zVii40UsxwcclfW+j2b4kmrfiSg1ngMtw3eXvjob6YXB4aKVFGSrLjcy0PJJMXnPIfqLYLWfxQySbAM04F9PvxmLy7u60XZoiba0HYL1ejWryVQDdmTRFzzyt0HB9LI8r47LmRviB6pBPUQqu8SkgaiIfXnmRe5BR2Tf+dBmO++6QCQGMHTkaWKnvvtiJJGLDJjnTdyB09s/2IzBX855piYXFmyhMJBEtDGCCs/dh4pRH+bEH1txV7ixs1c8vQO5PLxjxvJeO3tskCxJH/JRfiAcHzJPWgaUyfI9/KNsMPeMQPKQAoMmwz7vjfdyu+WUwKgi+TU42dxJ/fBnkP2T7y7cBO/1XGHCr1XrDh8MDwdMD4+6gECL281KtTFb5YG8MSD5/cXHRxfX2++Y9gKf+SRSSea1g8JkiBxUyZRjNFvkm7zLi62vemOxrV4CJ9UY7rGo/exiaoz7FSGCobTSIfpVADm7a/LZFu9na/tEOtSwsFZ/Ty/I/o3axaRpUym7jjR31bDZ6HRjgLr7yRXqa95kjLeY0oKIJbLNo/zhyhlDjQqSAm7/5GUmDhHmxp9WooDZkBHvNWmELFFoJgLMLfpZpAWWxPW8BC4rlSf2NU/MCEAMhFwGX+dHlj2RR6nE5UvF4Eyxm2Zao2OJ/VbRP7mOHayCzhg/ztW2XxoiOvXvxCKMfwLW/QuEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(38100700002)(33656002)(122000001)(478600001)(71200400001)(38070700005)(83380400001)(7696005)(86362001)(7416002)(8936002)(5660300002)(4744005)(2906002)(82960400001)(66476007)(66446008)(52536014)(64756008)(6506007)(107886003)(8676002)(66946007)(110136005)(76116006)(55016003)(4326008)(186003)(9686003)(66556008)(41300700001)(26005)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVd4SFZLZGNVakJjTlg3SFVGa1R1dnZXbnBtNUJUcm5uaUlQc2d4b3BSWmxL?=
 =?utf-8?B?UXRna0h6RzN1bThSbVBTaUFMZHdjbTlaNU5TUGJvWCs2RStDUWZySDJUTndJ?=
 =?utf-8?B?WlRaUVlRRWdXZG53L3JZWHo3SU9hVGdudVlEbE1mL0ZYUmRtN2dwWHhuWUpF?=
 =?utf-8?B?TnBGWEFVM1RYd0ZNSVRtSHJnT0VkNkV0dGVHZCtTWFI0cWdHMlVWYXFVR01p?=
 =?utf-8?B?TXBOQ3M3QjJVRUpYQXcvN0hCWG4raEt6TjBFa1FheGFTdHFRRzd6ZVVnbFp3?=
 =?utf-8?B?STlQNGVBdm8vYUVGUmNTTTg0d0pXdjBWdGhSRkxpLzV3V2FDOTIzRzVRZXRz?=
 =?utf-8?B?cHdnYjJTRVgrMzZ6dWo0Q1Q1Uk9VWkNSWXdqOUhkSnJEMzMrek1jSXpzZ0l1?=
 =?utf-8?B?R2FmU2F6YTRGcUt3VHlSelJBOWx0ZVoxalRlQ2dRM1huUUZxVHE2OWs4UWd5?=
 =?utf-8?B?Ump4NEJ5cy9mcW5VMXB6bmxway96RTU0QWhPS2M2ZXNBbktwdFlSSHNUdW5i?=
 =?utf-8?B?SU53WFBhdGhGVHdxMnpKOTV1bUJaT1ZDd3ZjOHg5YkUrWjRKeG9ocXdpamFn?=
 =?utf-8?B?RTEwV0ttdHBCdllhNkdtRCtDaUFac1djeG9zeWMwQTR5UlBEdGs3UGg1NXBF?=
 =?utf-8?B?SHk4ZURBSTVzTzR1dno5MytvaUN0ZUhMYzRYN2dyUEhMSVd4MVh5UUlDYUQ3?=
 =?utf-8?B?VmRMMnRhQ0N1Zks5Wk1Da1pTZ2Q4OW9BekdrSVc1dUM5TzVtcm00YnYrRW9G?=
 =?utf-8?B?b0FkWmw1UUdHVU1ibnNqbmV1dXg3aWhkemVuTnlUbU16NW9FT1lZWDFYOG1T?=
 =?utf-8?B?U3NwS3BkNWdRc2wvRjc3aElxeDhraTNuZU9kdXZwcjJIZTQ4bTdZVTNKZ01B?=
 =?utf-8?B?V3oxU3RWNk84N2x6RGtHWlpzVVJSQTNuWFAyYjF4eDdNT3BGL1ZqcTFVanhL?=
 =?utf-8?B?VXdyZ25kMHdsekFQS3VJb0ZwUHk0RGVLa1lnbzhici9Ddm4rMEFIUmpHeWFy?=
 =?utf-8?B?TldWWVF2TmtGeHhlZU50RnN3L2JjKzJJdzNERG0zOFVhU1J5VmYvK2RhL1cr?=
 =?utf-8?B?WWw3SlJ0U3RxQUx3cU9JaFZXeUd6WmxaOXRhVlRuUVRRZnl6ajJJOWo2bHZK?=
 =?utf-8?B?MklXQnBYN2I4TnZJV2tST2JuMUFyejg3NEszd1R3RVhPaWduWHorSXEvZVNE?=
 =?utf-8?B?OHpuTDlKQXczczFsRHMrNkJTdDhoMGlYN2oweTUwVDhCTEFxM3RFZjdiQ2ts?=
 =?utf-8?B?QVdBL1lreFB4cU9DS09sWk1aUU5TcGx6b21xbjhKTDM4L2pIbDZPOFdDaWJF?=
 =?utf-8?B?UHl4VjRleXNsM200a0puaXJBRWFUa0VUaE5HTWxiKzdSMnhpMFN6U1ltZ1gy?=
 =?utf-8?B?THVCTHVvN0JOeGNpeE03N3o5L3YwajNaWU11cjZkV09nODUrZ0Q4TkpobmJG?=
 =?utf-8?B?SkdiMy9keVNZY2kxTno3aUd1ZCt3R0lab3NEdFpDU3lQRzExTVNOUlhVbVly?=
 =?utf-8?B?UlFFc2NiL21pSC9Id2pxQzd6NHZGRnMrZFBmNVRHQlJEUXdKdWVKcmV5L3Rn?=
 =?utf-8?B?bVBwb3k5N2lEcWJqdEs0Y0dDNmtXTnNkc1FCYmEzY1h2cVlyT1VMR1lDTnk1?=
 =?utf-8?B?dVdHY081bGxMZHFLcmZSNG5MeTNMaUdoenlPUEVFeDd1bExUVGtHcUUvRFVT?=
 =?utf-8?B?VHZkemtHTUhCUmJ4bVI3eitqSXRrclhNRXdyMnJDUUtZRWc3dVFKVlg4enFj?=
 =?utf-8?B?bjJDWDdHVnVQdkxKUEsxdklWWmpyaDZwK3gyN3d0citaY2MyeTNEeTdGRWZQ?=
 =?utf-8?B?RzZIcWM3MHNBbzBZUG93d29VMFRCVng1MUxBUDlCdm1ielM4NG5xMmx5eWYz?=
 =?utf-8?B?a2R4MTRUckNpbGFTYlZsV0xyQmdRby8zWU5oUThvaVFKdGw0TDlIQnJ2YjRw?=
 =?utf-8?B?aE5ZQ0k5dG1PR3hYUXc3Q2hpVkRPV3FBeHVQdFl2ZE9ZclN4UGhseG5adnAw?=
 =?utf-8?B?cGNnSEg3dHVWdWhXSnBVT2orZFZKRm03RjlLYkU0TTkzV0NhbnQ1OGxZZXNm?=
 =?utf-8?B?S2FMTjY4YTVvRmJPbERiSXpyZlh5MjJjV3krZkwvOGRQSFA2ZzhENW15Yk5i?=
 =?utf-8?Q?AmIZeyxQgZbkrNwbypFgKUdMx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa62aea1-32e5-426f-3216-08dac9424ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:53:07.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVlGwpzEbLQK/WEbktBoA4fMs3eklcZ+SKFjtngHtzvlELzJoUdK8n63PTE/QnRtB5ffcZIBYE7Z996JOGOMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiBGcm9tOiBBaG1lZCBTLiBEYXJ3
aXNoIDxkYXJ3aUBsaW51dHJvbml4LmRlPg0KPiANCj4gU3dpdGNoIHRvIHRoZSBuZXcgZG9tYWlu
IGlkIGF3YXJlIGludGVyZmFjZXMgdG8gcGhhc2Ugb3V0IHRoZSBwcmV2aW91cw0KPiBvbmVzLiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFobWVkIFMuIERhcndp
c2ggPGRhcndpQGxpbnV0cm9uaXguZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvYmFzZS9wbGF0Zm9ybS1t
c2kuYyB8ICAgIDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9wbGF0Zm9ybS1tc2kuYw0KPiAr
KysgYi9kcml2ZXJzL2Jhc2UvcGxhdGZvcm0tbXNpLmMNCj4gQEAgLTIxMyw3ICsyMTMsNyBAQCBp
bnQgcGxhdGZvcm1fbXNpX2RvbWFpbl9hbGxvY19pcnFzKHN0cnVjDQo+ICAJaWYgKGVycikNCj4g
IAkJcmV0dXJuIGVycjsNCj4gDQo+IC0JZXJyID0gbXNpX2RvbWFpbl9hbGxvY19pcnFzKGRldi0+
bXNpLmRvbWFpbiwgZGV2LCBudmVjKTsNCj4gKwllcnIgPSBtc2lfZG9tYWluX2FsbG9jX2lycXNf
cmFuZ2UoZGV2LCBNU0lfREVGQVVMVF9ET01BSU4sIDAsDQo+IG52ZWMgLSAxKTsNCj4gIAlpZiAo
ZXJyKQ0KPiAgCQlwbGF0Zm9ybV9tc2lfZnJlZV9wcml2X2RhdGEoZGV2KTsNCj4gDQoNCk91dCBv
ZiBjdXJpb3NpdHkuIFdoeSBkb24ndCB3ZSBwcm92aWRlIGFuIHVubG9ja2VkIHZlcnNpb24gb2YN
Cm1zaV9kb21haW5fYWxsb2NfaXJxc19hbGwoKT8NCg0K
