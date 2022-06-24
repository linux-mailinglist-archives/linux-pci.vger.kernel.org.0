Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429D0558F73
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFXEC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiFXECv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:02:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884756387;
        Thu, 23 Jun 2022 21:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656043366; x=1687579366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mea8kr24RG6Fx3EaTWX947UhUcTd4w96fc0w87lQVLs=;
  b=DMQqyCRZY5LUROAQ070HRy7M7zlg4IaUTiHq3/kKLoWHqL0ikQvKaW7j
   l8VoF5jO7q6By0oh1kOmmVB8fSSm9dFvIlCkx6nkn+fgEMLwC3tvPvdx+
   P+wMeTtiUcpUV6Rtiw41RBt6UAtnvwYwEE+biIdFIRW2O4LJwKuZp/p8z
   A7b3tqHY8djKwfqL2XuCyrDgNnnjXTXtNOb8eG3iUop0vjIm2aEQqoG6K
   DJq7ll/ycH3cIKmLIMdFQ7pGAhN1LxUjEDmaysWHSui1Vn+Kb3MX7xYOa
   x3zlS7+8UwsqKadkVZHpG4CeFl1jhqJdliu2VSIEuEa10bj7st8CC1wrF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367235555"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="367235555"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="563713216"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2022 21:02:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 21:02:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 21:02:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 21:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw2+++SuezYwNanFgMzPvh9SgnXn3P8Czmqf+aHgjK+iLElNcfFnSlz0+ft8M0zhZasKJVZZzrKOlTCvd8vMPj7SUfSOYGcWWWqqZeyz/4ETc/EJ4PGAoIi+DUoDvhDYYndz/7EZX9DuAeEN5u969Mdvksyf3tiezu8lZkeLe2qKiurDMom2LCuNfk6oyx3jL3uKuXKcG+UQWiQ4xrGatAE0zjAJXDMvfIeYTI8SYgm415mS/ndSqHVQp+NRPftQ+oBgAvZ0LDJiYrZJrORU3afQUi2bxCzzp2rGCgiJ/KbWqwWXZ7sgUwwKJxq3xYCHHPDRG8zw63LUQLjejuNHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mea8kr24RG6Fx3EaTWX947UhUcTd4w96fc0w87lQVLs=;
 b=cIR4pevXTtpZ9AE4WHYyLO6M+ZEPgxtXBI/c1EKNS9pUAGJQWpmYhRZ2+HixIH262b01UasibLdHmTLZposwcuwuJIWC0Rj7up7K8y+7Mg3lRsLNrfHcRNEShu1ONzbm+r/P+HWXhwpl5RxZues21nZhhkCTc7vRQ/yQArXm+ZM4vfBtJCadKRjz4nbNFa4tMBKoiE8Q6XAfwA0Iyho+RdOxq5h43A45b8JHub862JRLbaTUFYcd7Dkrvf7kwyuZQJ/7aksPkQ0VlqI9VBz10Zdnq4zcYB2jCY+y1Rl4o4wRIQ5LOa21PsB7ZLBkWeMqWSMnr35b/B8ikm69muYNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4492.namprd11.prod.outlook.com (2603:10b6:5:201::31)
 by CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Fri, 24 Jun
 2022 04:02:35 +0000
Received: from DM6PR11MB4492.namprd11.prod.outlook.com
 ([fe80::5d41:84f3:d25e:98de]) by DM6PR11MB4492.namprd11.prod.outlook.com
 ([fe80::5d41:84f3:d25e:98de%4]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 04:02:35 +0000
From:   "Dandamudi, Priyanka" <priyanka.dandamudi@intel.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Sergei Miroshnichenko" <s.miroshnichenko@yadro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Auld, Matthew" <matthew.auld@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Thread-Topic: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Thread-Index: AQHYgZUIOaZ/fJgwj0C+pkNu6V29oq1TRm+AgACrAoCAAB46AIAAD0CAgAEqJgCACLF6kA==
Date:   Fri, 24 Jun 2022 04:02:34 +0000
Message-ID: <DM6PR11MB4492AEEEDB2CC5E6B861B93F8DB49@DM6PR11MB4492.namprd11.prod.outlook.com>
References: <20220617184441.7kbs4al7gmpxjuuy@ldmartin-desk2>
 <20220617203252.GA1203491@bhelgaas>
 <20220617212727.h5r2o3schvl73bbk@ldmartin-desk2>
 <21bce72a-3537-0ff2-2553-4d62cc86ffbd@amd.com>
In-Reply-To: <21bce72a-3537-0ff2-2553-4d62cc86ffbd@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: lucas.demarchi@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9092d02-479f-4877-5bc7-08da55965ec8
x-ms-traffictypediagnostic: CY4PR11MB0071:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JqvCWkWMMOYqLmOu+sngGGq+sSZIQTSZOhLdZ9ubCVbLMo3+geD1UeYL51WCvHCaUUg11ra2DdRHKmkbISs2Lsj++u1kYHnu9bOG/IAaNSp3Bsjcp7EmK4t9L9gbty/ZXw01gxShnR3L0/Z5A892TZ+bZM1+K6KWYkh7jcrMcEj8PEDBs3IjEy8dv6wJFjKTxVSZllEX5Y9oZe3GDjUWzgbR8Ptd9wmTS7OZyZe4Yo+j4DY/P+2t+rNIrFKIsTozQQV7IJQ9CUsUSYXTy4Ndomkjysui1m0sOL70zDv476+O8NAp+F6dUiVwtCQV2H1p/PxbogUbZ+F++ukSTH2AJKCdoonQuDxFXR8Gm5Px56y7/CZ8K1RkXkVs4aDhw0GxzkScY8fHL+yMAbr5CcgMcSJWrnUUxQB5AK0xSlHBIoEBQlAzxzRQ6fu642rWPuHImkuBLtjH854g8UnrO0Cyv0UoW9/ReuebWiww9m4pMagurcqPyLDA58i8jJbDsfiM/2nSVR9VGH3E4SbzE4EBxqgQ7cMODLWzZge6gtAPSayMsZJ2W0OwIY869e4Uiu9JJFcOwyPF+20butFGIdSvTf+vQrCE8rOLRrrcKkvNiXu5NeYxui13yplcBYJMyErqZCIBqO9ufXtVW6J9m0LsJ2Gb4ZIWZphTrDHevZdStGjqcE0DtCj96EG0Np5M7z4KEiXp7zrGcNt/0uAW35LpHImA6qZ3o40dNR27OV6/Usd0Fi9a8hGmGnFFCmaVwlicMO2j3EPcr4q0SZTlxuJ+vJ6tnrPXHPPop8Sga/E7GzXwWdt0ZnRzJjD1AWocGsd53NJ8+boL+72Vhtjj+hsjVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4492.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(366004)(396003)(39860400002)(38070700005)(122000001)(76116006)(66574015)(66446008)(8936002)(33656002)(71200400001)(5660300002)(45080400002)(41300700001)(52536014)(86362001)(7696005)(66556008)(8676002)(186003)(66946007)(4326008)(54906003)(2906002)(38100700002)(26005)(83380400001)(55016003)(316002)(966005)(53546011)(9686003)(64756008)(82960400001)(478600001)(66476007)(110136005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THBRSGN3MzNwdjdkdEJRNjhrdnJIaXROVEIwZlBQK0w5ejVMNzlDaWZodFFQ?=
 =?utf-8?B?aVpWemxvYXYrSVFDMW5hL0xzblZsVldpdUtyMTlQL2w0dnFXaG9pQ1hRVkJH?=
 =?utf-8?B?TXFCYUs2YmdWdUErN3hUV1dEdlZBeEwzY1VxWE1sY0hReHNmVytkNjUrUHR1?=
 =?utf-8?B?VWRaU0NJMEZxRE4xZWNCWTRXR2REYnM1dXRUcllYV2lMOFhBcTZYeGY3bTZ2?=
 =?utf-8?B?TExEdk9RNFBnZDZSL1pZeUJ6cWZYenVTdmtSZUdMYWsyQTVPZ3N6c1g1M3o5?=
 =?utf-8?B?K1Evckh1NCtiY2FmWTJXWlJIdERtd294OTZkaHIzYkRkQlFMWnU2OG51SXhn?=
 =?utf-8?B?M0JoVXNqUnRyZ251dGVybVBQNDZvM1dKNnBjKzR2cytVSTEyZHBVSnlOR1Ru?=
 =?utf-8?B?SytiMmttM09CNWRlMHQzcFUzOEJlU3orQXM3ckJTU01QTlIvS2ZyYm1EaWtV?=
 =?utf-8?B?RWJqbzVHdTBDa0xKWTlTcmhNQ0hvZDgyd1NkM3VvZnlFSXdwdS9RVmtLR2du?=
 =?utf-8?B?eW5MQzVkdVlCalVkVHBPQ2VhL3BWQnBsOXl1R1pMWXF0STRLMVRlRERvblln?=
 =?utf-8?B?K21ZaXFSR3VUUldzblo4bURjZVQrdHAwNDBpNnR6bG4wY01teVRxeXBrcTI5?=
 =?utf-8?B?VzlnQXhrdWEwWmVudnYwZWhqdWlmckhxRWpkWGw0UkJ5MUZPQXNLOUpxN1VR?=
 =?utf-8?B?bzVqbENyN3J1d2hvY2VSRW9aTHh5L21qZjlDbTQ1VnFFWUVBTHZsaHp3a0lR?=
 =?utf-8?B?cXhUS3lGMi9rQU5BNXdUcmQ0NmJScFEwNnlKMFNldytBZC9pS3FVc1N4TXFB?=
 =?utf-8?B?bDAvb2JhUUtwbFBZekhWOGtTV2lIbm5nSmluZnEvbjc2ZlJaSWZ4SVhzUG9W?=
 =?utf-8?B?NmR3YkIySVcveFZIQVR4ZGFaRXk0YmdnTFRmWDhFKzhMUFErOG1ZNWh4Ukty?=
 =?utf-8?B?QkQwU0ZJd1NYQnUyMnV5WldBSEpGeEdTTlNKUm56MVkrY2RvQWcrZEZVeGJR?=
 =?utf-8?B?NVlWU3R0cHRGYkFtbVYvbHRjWm5sWlM5eGVONnFab3NKeDZzSTZRZVhnWFdH?=
 =?utf-8?B?dXM2aWE3VGNRT08xbjF3dlY1UXpJWGwweWxBb0U4dUVpYjllVEFGVXVGUHlU?=
 =?utf-8?B?RC9aSmIrWEhaeE9weCsvOUhKZ2drSXcwc05sT3RPODJ5aitIUERQSnpIRDVz?=
 =?utf-8?B?aXFMeksrV0hMbjlISTJKdy82Tm5WdjdpZ01NN2JFZjYrcFkySUthS1JzZE9F?=
 =?utf-8?B?Uk1xVUg0MTZONDJhREVGNFJjdjBrV1VTNlFjRm04TnZXUitkQVNwVXlJcnk1?=
 =?utf-8?B?UUNYMWxCY2F3WHFyTVRHZUhOL01mc3BxZ0tpRStoZFJCa2JSbDNSeFBJYlpT?=
 =?utf-8?B?cSszd3RTTlBvZnlscUl1QVk2OHFkSWxJeGZpN2oxWDVQS3pFM1RGemNKem1q?=
 =?utf-8?B?dlJzcmNIWXUxYmF4c04yWit2OTdBNVcrUStqUlBBdis2MTlBdmRUeEtZQmVX?=
 =?utf-8?B?NStpc3BURExIN1Z6dXlkM2EwSE1oZVBwSDhXdXJNRS9FN1Z3a2RrMWtoZHdI?=
 =?utf-8?B?bjRZWHlYY3ZYT0t1cTNRZWQzT3BQclgzREdEOG10b29FbThVTFFLYm5pbkMy?=
 =?utf-8?B?ZVV5SVBXYldORkxIWFEzMTBSaFQyd3J0cWY5ZnQzeGo3S05EZHFvdS9FbEN6?=
 =?utf-8?B?NFVxWDV6MVdGRHVLcHYrSkJVZWQydlVPZ0doVXFvNEZuV2VkbmdkM25pTDQy?=
 =?utf-8?B?bDdOZ0hZMGVTdlZjVzVEcnBzOFhWNTZOZk1KUlFDMkI5YnVXOThnQmpTNXlL?=
 =?utf-8?B?bEwyUEVCR2UvT0hJUElGWVh3cVpiNzVpaXdET1FYejFCcDFnc0JhY3I4NXh0?=
 =?utf-8?B?K0VhTEdPNDV1UndpdVRDeWVQcnptQkIyS2M3em9oRlA0Q05FUjRHUnUxNUNO?=
 =?utf-8?B?L1ZyVkVMVzU2UG4vSmVMNkZSSWMxb2tIRjBIY2xXRGNXSEVibzZnSGNNaW13?=
 =?utf-8?B?TE1yVktWeHdlWWpXbENuZE0rYkFHMXVDNDBuV0pNWWY2U0w5V1Z5c1Bra3Az?=
 =?utf-8?B?UnNKRWdzcllGTE9OVkFSSlVVVkJyaGM5czg5VEtGL014M2ZSbXQ4R3VIUWNZ?=
 =?utf-8?B?S3NVMkxHeHNxTCttNVB5QmVuWENVVGtVTEFsdTl3Um9SRHlIOWVkTWpEWEo0?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9092d02-479f-4877-5bc7-08da55965ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 04:02:34.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5twRW8RVQycIgI7K14AJCkENJsQtRJghmc7efacbJvFu/Rzaf/CqZx1osIHCUxMiDVIrmh7aQq8a4juG3KINmuuqBypqJBmOb6PqChrWLnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0071
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiAxOCBKdW5lIDIwMjIgMDg6NDUg
UE0NCj4gVG86IERlIE1hcmNoaSwgTHVjYXMgPGx1Y2FzLmRlbWFyY2hpQGludGVsLmNvbT47IEJq
b3JuIEhlbGdhYXMNCj4gPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNlcmdlaQ0KPiBN
aXJvc2huaWNoZW5rbyA8cy5taXJvc2huaWNoZW5rb0B5YWRyby5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgRGFuZGFtdWRpLCBQcml5YW5rYQ0KPiA8cHJpeWFua2EuZGFu
ZGFtdWRpQGludGVsLmNvbT47IEF1bGQsIE1hdHRoZXcNCj4gPG1hdHRoZXcuYXVsZEBpbnRlbC5j
b20+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTog
W0ludGVsLWdmeF0gW1BBVENIIDEvMl0gZHJtL2k5MTU6IEFkZCBzdXBwb3J0IGZvciBMTUVNIFBD
SWUNCj4gcmVzaXphYmxlIGJhcg0KPiANCj4gQW0gMTcuMDYuMjIgdW0gMjM6Mjcgc2NocmllYiBM
dWNhcyBEZSBNYXJjaGk6DQo+ID4gT24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMDM6MzI6NTJQTSAt
MDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPj4gWytjYyBDaHJpc3RpYW4sIGF1dGhvciBv
ZiBwY2lfcmVzaXplX3Jlc291cmNlKCksIFNlcmdlaSwgYXV0aG9yIG9mDQo+ID4+IHJlYmFsYW5j
aW5nIHBhdGNoZXNdDQo+ID4+DQo+ID4+IEhpIEx1Y2FzLA0KPiA+Pg0KPiA+PiBPbiBGcmksIEp1
biAxNywgMjAyMiBhdCAxMTo0NDo0MUFNIC0wNzAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6DQo+
ID4+PiBDYydpbmcgaW50ZWwtcGNpLCBsa21sLCBCam9ybg0KPiA+Pj4NCj4gPj4+IE9uIEZyaSwg
SnVuIDE3LCAyMDIyIGF0IDExOjMyOjM3QU0gKzAzMDAsIEphbmkgTmlrdWxhIHdyb3RlOg0KPiA+
Pj4gPiBPbiBUaHUsIDE2IEp1biAyMDIyLCBwcml5YW5rYS5kYW5kYW11ZGlAaW50ZWwuY29tIHdy
b3RlOg0KPiA+Pj4gPiA+IEZyb206IEFrZWVtIEcgQWJvZHVucmluIDxha2VlbS5nLmFib2R1bnJp
bkBpbnRlbC5jb20+DQo+ID4+PiA+ID4NCj4gPj4+ID4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIGxv
Y2FsIG1lbW9yeSBQSUNlIHJlc2l6YWJsZSBiYXIsIHNvIHRoYXQNCj4gPj4+ID4gPiBsb2NhbCBt
ZW1vcnkgY2FuIGJlIHJlc2l6ZWQgdG8gdGhlIG1heGltdW0gc2l6ZSBzdXBwb3J0ZWQgYnkgdGhl
DQo+ID4+PiBkZXZpY2UsDQo+ID4+PiA+ID4gYW5kIG1hcHBlZCBjb3JyZWN0bHkgdG8gdGhlIFBD
SWUgbWVtb3J5IGJhci4gSXQgaXMgdXN1YWwgdGhhdA0KPiA+Pj4gPiA+IEdQVSBkZXZpY2VzIGV4
cG9zZSBvbmx5IDI1Nk1CIEJBUnMgcHJpbWFyaWx5IHRvIGJlIGNvbXBhdGlibGUNCj4gPj4+ID4g
PiB3aXRoDQo+ID4+PiAzMi1iaXQNCj4gPj4+ID4gPiBzeXN0ZW1zLiBTbywgdGhvc2UgZGV2aWNl
cyBjYW5ub3QgY2xhaW0gbGFyZ2VyIG1lbW9yeSBCQVINCj4gPj4+IHdpbmRvd3Mgc2l6ZSBkdWUN
Cj4gPj4+ID4gPiB0byB0aGUgc3lzdGVtIEJJT1MgbGltaXRhdGlvbi4gV2l0aCB0aGlzIGNoYW5n
ZSwgaXQgd291bGQgYmUNCj4gPj4+IHBvc3NpYmxlIHRvDQo+ID4+PiA+ID4gcmVwcm9ncmFtIHRo
ZSB3aW5kb3dzIG9mIHRoZSBicmlkZ2UgZGlyZWN0bHkgYWJvdmUgdGhlDQo+ID4+PiByZXF1ZXN0
aW5nIGRldmljZQ0KPiA+Pj4gPiA+IG9uIHRoZSBzYW1lIEJBUiB0eXBlLg0KPiA+Pj4NCj4gPj4+
IFRoZXJlIGlzIGEgYmlnIGNhdmVhdCBoZXJlIHRoYXQgdGhpcyBtYXkgYmUgdG9vIGxhdGUgYXMg
b3RoZXINCj4gPj4+IGRyaXZlcnMgbWF5IGhhdmUgYWxyZWFkeSBtYXBwZWQgdGhlaXIgQkFScyAt
IHNvIHByb2JhYmx5IHRvbyBsYXRlIGluDQo+ID4+PiB0aGUgcGNpIHNjYW4gZm9yIGl0IHRvIGJl
IGVmZmVjdGl2ZS4gSW4gZmFjdCwgYWZ0ZXIgdXNpbmcgdGhpcyBmb3IgYQ0KPiA+Pj4gd2hpbGUs
IGl0IHNlZW1zIHRvIGZhaWwgdG9vIG9mdGVuLCBwYXJ0aWN1bGFybHkgb24gQ0ZMIHN5c3RlbXMu
DQo+ID4+DQo+ID4+IEhlbHAgbWUgdW5kZXJzdGFuZCB0aGUgInRvbyBsYXRlIiBwYXJ0LsKgIERv
IHlvdSBtZWFuIHRoYXQgdGhlcmUgaXMNCj4gPj4gZW5vdWdoIGF2YWlsYWJsZSBzcGFjZSBmb3Ig
dGhlIG1heCBCQVIgc2l6ZSwgYnV0IGl0J3MgZnJhZ21lbnRlZCBhbmQNCj4gPj4gdGhlcmVmb3Jl
IG5vdCB1c2FibGU/wqAgQW5kIHRoYXQgaWYgd2UgY291bGQgZG8gc29tZXRoaW5nIGVhcmxpZXIs
DQo+ID4+IGJlZm9yZSBkcml2ZXJzIGhhdmUgY2xhaW1lZCB0aGVpciBkZXZpY2VzLCB3ZSBtaWdo
dCBiZSBhYmxlIHRvDQo+ID4+IGNvbXBhY3QgdGhlIEJBUnMgb2Ygb3RoZXIgZGV2aWNlcyB0byBt
YWtlIGEgbGFyZ2VyIGNvbnRpZ3VvdXMgYXZhaWxhYmxlDQo+IHNwYWNlPw0KPiA+DQo+ID4geWVz
LiBJIHdpbGwgZGlnIHNvbWUgbG9ncyBJIGhhZCBpbiB0aGUgcGFzdCB0byBjb25maXJtLg0KPiA+
DQo+ID4NCj4gPj4gVGhhdCBpcyB0aGVvcmV0aWNhbGx5IHBvc3NpYmxlLCBidXQgSSB0aGluayB0
aGUgY3VycmVudA0KPiA+PiBwY2lfcmVzaXplX3Jlc291cmNlKCkgb25seSBzdXBwb3J0cyByZXNp
emluZyBvZiB0aGUgc3BlY2lmaWVkIEJBUiBhbmQNCj4gPj4gYW55IHVwc3RyZWFtIGJyaWRnZSB3
aW5kb3dzLsKgIEkgZG9uJ3QgdGhpbmsgaXQgc3VwcG9ydHMgbW92aW5nIEJBUnMNCj4gPj4gb2Yg
b3RoZXIgZGV2aWNlcy4NCj4gPj4NCj4gPj4gU2VyZ2VpIGRpZCBzb21lIG5pY2Ugd29yayB0aGF0
IG1pZ2h0IGhlbHAgd2l0aCB0aGlzIHNpdHVhdGlvbiBiZWNhdXNlDQo+ID4+IGl0IGNhbiBtb3Zl
IEJBUnMgYXJvdW5kIG1vcmUgZ2VuZXJhbGx5LsKgIEl0IGhhc24ndCBxdWl0ZSBhY2hpZXZlZA0K
PiA+PiBjcml0aWNhbCBtYXNzIHlldCwgYnV0IG1heWJlIHRoaXMgd291bGQgaGVscCBnZXQgdGhl
cmU6DQo+ID4+DQo+ID4+DQo+ID4+DQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcg0KPiA+PiBlLmtlcm5lbC5vcmcl
MkZsaW51eC1wY2klMkYyMDIwMTIxODE3NDAxMS4zNDA1MTQtMS0NCj4gcy5taXJvc2huaWNoZW5r
byU0DQo+ID4+DQo+IDB5YWRyby5jb20lMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2NocmlzdGlhbi5r
b2VuaWclNDBhbWQuY29tJTdDOA0KPiAwOTYwMjcNCj4gPj4NCj4gZjY4NDg0ZDA2NTZiMTA4ZGE1
MGE4MmU3ZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDDQo+IDAlN0MwJQ0K
PiA+Pg0KPiA3QzYzNzkxMDk4MDUwOTE5OTM4OCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpX
SWpvaU1DNHdMakENCj4gd01EQWlMQ0pRDQo+ID4+DQo+IElqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wOw0KPiBzZGF0YT0NCj4gPj4N
Cj4gJTJGZm50RTJGVFE4d21Mbno0d256azk0UjBHTUxFd1ZzN01qMTglMkI5UTZQSmslM0QmYW1w
O3Jlc2VyDQo+IHZlZD0wDQo+ID4+DQo+ID4NCj4gPiBvaC4uLiBJIGhhZG4ndCB0aG91Z2h0IGFi
b3V0IHBhdXNlL2lvcmVtYXAvdW5wYXVzZS4gVGhhdCBsb29rcyByYWQgOikuDQo+ID4gU28gaXQg
c2VlbXMgdGhpcyB3b3VsZCBpbnRlZ3JhdGUgbmVhdGx5IHdpdGgNCj4gPiBwY2lfcmVzaXplX3Jl
c291cmNlKCkgKHdoYXQgdGhpcyBwYXRjaCBpcyBkb2luZyksIGFzIGxvbmcgYXMgZHJpdmVycw0K
PiA+IGZvciBkZXZpY2VzIGFmZmVjdGVkIGltcGxlbWVudA0KPiA+IC5iYXJfZml4ZWQoKS8ucmVz
Y2FuX3ByZXBhcmUoKS8ucmVzY2FuX2RvbmUoKS4gVGhhdCBzZWVtcyBpdCB3b3VsZA0KPiA+IHNv
bHZlIG91ciBpc3N1ZXMgdG9vLg0KPiANCj4gV2VsbCB3ZSBuZXZlciByYW4gaW50byBhbnkgb2Yg
dGhlIGlzc3VlcyB5b3UgZGVzY3JpYmUgd2l0aCBQQ0llIEJBUiByZXNpemUNCj4gZm9yIEdQVXMg
c28gdGhlcmUgbXVzdCBiZSBzb21ldGhpbmcgeW91IGRvIGRpZmZlcmVudGx5IHRvIEFNRCBoYXJk
d2FyZQ0KPiByZWdhcmRpbmcgdGhpcy4NCj4gDQo+IEFkZGl0aW9uYWwgdG8gdGhhdCBrZWVwIGlu
IG1pbmQgdGhhdCB5b3UgY2FuJ3QgcmVzaXplIHRoZSBCQVIgYmVmb3JlIGtpY2tpbmcNCj4gb3V0
IHZnYWNvbi9lZmlmYiBvciBvdGhlcndpc2UgaXQgY2FuIGhhcHBlbiB0aGF0IHRoZSBqdXN0IHJl
bGVhc2VkIDI1Nk1pQg0KPiB3aW5kb3cgaXMgc3RpbGwgdXNlZCB3aGlsZSB5b3UgdHJ5IHRvIHJl
c2l6ZSBpdC4gV2hlbiB5b3UgZG8gdGhhdCB5b3UgdXN1YWxseQ0KPiBlbmQgdXAgd2l0aCBhIGhh
cmQgbG9ja3VwIG9mIHRoZSBzeXN0ZW0uDQo+IA0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+
IA0KPiA+DQo+ID4gdGhhbmtzDQo+ID4gTHVjYXMgRGUgTWFyY2hpDQo+ID4NCj4gPj4NCj4gPj4g
SWYgSSB1bmRlcnN0YW5kIFNlcmdlaSdzIHNlcmllcyBjb3JyZWN0bHksIHRoaXMgcmViYWxhbmNp
bmcgYWN0dWFsbHkNCj4gPj4gY2Fubm90IGJlIGRvbmUgZHVyaW5nIGVudW1lcmF0aW9uIGJlY2F1
c2Ugd2Ugb25seSBtb3ZlIEJBUnMgaWYgYQ0KPiA+PiBkcml2ZXIgZm9yIHRoZSBkZXZpY2UgaW5k
aWNhdGVzIHRoYXQgaXQgc3VwcG9ydHMgaXQsIHNvIHRoZXJlIHdvdWxkDQo+ID4+IGJlIG5vIHJl
cXVpcmVtZW50IHRvIGRvIHRoaXMgZWFybHkuDQo+ID4+DQo+ID4+PiBEbyB3ZSBoYXZlIGFueSBh
bHRlcm5hdGl2ZSB0byBiZSBkb25lIGluIHRoZSBQQ0kgc3Vic3lzdGVtIGR1cmluZw0KPiA+Pj4g
dGhlIHNjYW4/wqAgVGhlcmUgaXMgb3RoZXIgd29yayBpbiBwcm9ncmVzcyB0byBhbGxvdyBpOTE1
IHRvIHVzZSB0aGUNCj4gPj4+IHJlc3Qgb2YgdGhlIGRldmljZSBtZW1vcnkgZXZlbiB3aXRoIGEg
c21hbGxlciBCQVIsIGJ1dCBpdCB3b3VsZCBiZQ0KPiA+Pj4gYmV0dGVyIGlmIHdlIGNhbiBpbXBy
b3ZlIG91ciBjaGFuY2VzIG9mIHN1Y2NlZWRpbmcgdGhlIHJlc2l6ZS4NCj4gPj4NCj4gPj4+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBBa2VlbSBHIEFib2R1bnJpbiA8YWtlZW0uZy5hYm9kdW5yaW5AaW50
ZWwuY29tPg0KPiA+Pj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgV2luaWFyc2tpIDxtaWNo
YWwud2luaWFyc2tpQGludGVsLmNvbT4NCj4gPj4+ID4gPiBDYzogU3R1YXJ0IFN1bW1lcnMgPHN0
dWFydC5zdW1tZXJzQGludGVsLmNvbT4NCj4gPj4+ID4gPiBDYzogTWljaGFlbCBKIFJ1aGwgPG1p
Y2hhZWwuai5ydWhsQGludGVsLmNvbT4NCj4gPj4+ID4gPiBDYzogUHJhdGhhcCBLdW1hciBWYWxz
YW4gPHByYXRoYXAua3VtYXIudmFsc2FuQGludGVsLmNvbT4NCj4gPj4+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBQcml5YW5rYSBEYW5kYW11ZGkNCj4gPHByaXlhbmthLmRhbmRhbXVkaUBpbnRlbC5jb20+
DQo+ID4+PiA+ID4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVs
LmNvbT4NCj4gPj4+ID4NCj4gPj4+ID4gUGxlYXNlIHNlZQ0KPiA+Pj4NCj4gaHR0cHM6Ly9uYW0x
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG8N
Cj4gPj4+DQo+IHJlLmtlcm5lbC5vcmclMkZyJTJGODdwbWo4dmVzbS5mc2YlNDBpbnRlbC5jb20m
YW1wO2RhdGE9MDUlN0MwMSU3Qw0KPiBjaA0KPiA+Pj4NCj4gcmlzdGlhbi5rb2VuaWclNDBhbWQu
Y29tJTdDODA5NjAyN2Y2ODQ4NGQwNjU2YjEwOGRhNTBhODJlN2QlN0MzZA0KPiBkODk2DQo+ID4+
Pg0KPiAxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3OTEwOTgwNTA5MTk5
Mzg4JTdDVW5rDQo+IG5vd24lN0MNCj4gPj4+DQo+IFRXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xq
QXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMDQo+IENKWA0KPiA+Pj4NCj4g
VkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPWQ0Y2Y3SFE2dDd5MVhvYndqZHQ4
aW0lDQo+IDJGaDBFNUlaDQo+ID4+PiBzWGd6UURwc0IydkNVNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiA+Pj4gPg0KPiA+Pj4gPiA+IC0tLQ0KPiA+Pj4gPiA+wqAgZHJpdmVycy9ncHUvZHJtL2k5MTUv
aTkxNV9kcml2ZXIuYyB8IDkyDQo+ID4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPj4+ID4gPsKgIDEgZmlsZSBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspDQo+ID4+PiA+ID4N
Cj4gPj4+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcml2ZXIu
Yw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X2RyaXZlci5jDQo+ID4+PiA+ID4g
aW5kZXggZDI2ZGNjYTdlNjU0Li40YmRiNDcxY2IyZTIgMTAwNjQ0DQo+ID4+PiA+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcml2ZXIuYw0KPiA+Pj4gPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2k5MTVfZHJpdmVyLmMNCj4gPj4+ID4gPiBAQCAtMzAzLDYgKzMwMyw5
NSBAQCBzdGF0aWMgdm9pZCBzYW5pdGl6ZV9ncHUoc3RydWN0DQo+ID4+PiBkcm1faTkxNV9wcml2
YXRlICppOTE1KQ0KPiA+Pj4gPiA+wqDCoMKgwqDCoMKgwqDCoMKgIF9faW50ZWxfZ3RfcmVzZXQo
dG9fZ3QoaTkxNSksIEFMTF9FTkdJTkVTKTsNCj4gPj4+ID4gPsKgIH0NCj4gPj4+ID4gPg0KPiA+
Pj4gPiA+ICtzdGF0aWMgdm9pZCBfX3JlbGVhc2VfYmFycyhzdHJ1Y3QgcGNpX2RldiAqcGRldikg
ew0KPiA+Pj4gPiA+ICvCoMKgwqAgaW50IHJlc25vOw0KPiA+Pj4gPiA+ICsNCj4gPj4+ID4gPiAr
wqDCoMKgIGZvciAocmVzbm8gPSBQQ0lfU1REX1JFU09VUkNFUzsgcmVzbm8gPA0KPiA+Pj4gUENJ
X1NURF9SRVNPVVJDRV9FTkQ7IHJlc25vKyspIHsNCj4gPj4+ID4gPiArwqDCoMKgwqDCoMKgwqAg
aWYgKHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgcmVzbm8pKQ0KPiA+Pj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHBjaV9yZWxlYXNlX3Jlc291cmNlKHBkZXYsIHJlc25vKTsNCj4gPj4+ID4g
PiArwqDCoMKgIH0NCj4gPj4+ID4gPiArfQ0KPiA+Pj4gPiA+ICsNCj4gPj4+ID4gPiArc3RhdGlj
IHZvaWQNCj4gPj4+ID4gPiArX19yZXNpemVfYmFyKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICpp
OTE1LCBpbnQgcmVzbm8sDQo+ID4+PiByZXNvdXJjZV9zaXplX3Qgc2l6ZSkNCj4gPj4+ID4gPiAr
ew0KPiA+Pj4gPiA+ICvCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGk5
MTUtPmRybS5kZXYpOw0KPiA+Pj4gPiA+ICvCoMKgwqAgaW50IGJhcl9zaXplID0gcGNpX3JlYmFy
X2J5dGVzX3RvX3NpemUoc2l6ZSk7DQo+ID4+PiA+ID4gK8KgwqDCoCBpbnQgcmV0Ow0KPiA+Pj4g
PiA+ICsNCj4gPj4+ID4gPiArwqDCoMKgIF9fcmVsZWFzZV9iYXJzKHBkZXYpOw0KPiA+Pj4gPiA+
ICsNCj4gPj4+ID4gPiArwqDCoMKgIHJldCA9IHBjaV9yZXNpemVfcmVzb3VyY2UocGRldiwgcmVz
bm8sIGJhcl9zaXplKTsNCj4gPj4+ID4gPiArwqDCoMKgIGlmIChyZXQpIHsNCj4gPj4+ID4gPiAr
wqDCoMKgwqDCoMKgwqAgZHJtX2luZm8oJmk5MTUtPmRybSwgIkZhaWxlZCB0byByZXNpemUgQkFS
JWQgdG8gJWRNDQo+ID4+PiAoJXBlKVxuIiwNCj4gPj4+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJlc25vLCAxIDw8IGJhcl9zaXplLCBFUlJfUFRSKHJldCkpOw0KPiA+Pj4gPiA+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4+PiA+ID4gK8KgwqDCoCB9DQo+ID4+PiA+ID4gKw0K
PiA+Pj4gPiA+ICvCoMKgwqAgZHJtX2luZm8oJmk5MTUtPmRybSwgIkJBUiVkIHJlc2l6ZWQgdG8g
JWRNXG4iLCByZXNubywgMSA8PA0KPiA+Pj4gYmFyX3NpemUpOw0KPiA+Pj4gPiA+ICt9DQo+ID4+
PiA+ID4gKw0KPiA+Pj4gPiA+ICsvKiBCQVIgc2l6ZSBzdGFydHMgZnJvbSAxTUIgLSAyXjIwICov
ICNkZWZpbmUgQkFSX1NJWkVfU0hJRlQgMjANCj4gPj4+ID4gPiArc3RhdGljIHJlc291cmNlX3Np
emVfdCBfX2xtZW1fcmViYXJfc2l6ZShzdHJ1Y3QNCj4gPj4+ID4gPiArZHJtX2k5MTVfcHJpdmF0
ZSAqaTkxNSwgaW50IHJlc25vKSB7DQo+ID4+PiA+ID4gK8KgwqDCoCBzdHJ1Y3QgcGNpX2RldiAq
cGRldiA9IHRvX3BjaV9kZXYoaTkxNS0+ZHJtLmRldik7DQo+ID4+PiA+ID4gK8KgwqDCoCB1MzIg
cmViYXIgPSBwY2lfcmViYXJfZ2V0X3Bvc3NpYmxlX3NpemVzKHBkZXYsIHJlc25vKTsNCj4gPj4+
ID4gPiArwqDCoMKgIHJlc291cmNlX3NpemVfdCBzaXplOw0KPiA+Pj4gPiA+ICsNCj4gPj4+ID4g
PiArwqDCoMKgIGlmICghcmViYXIpDQo+ID4+PiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAw
Ow0KPiA+Pj4gPiA+ICsNCj4gPj4+ID4gPiArwqDCoMKgIHNpemUgPSAxVUxMIDw8IChfX2Zscyhy
ZWJhcikgKyBCQVJfU0laRV9TSElGVCk7DQo+ID4+PiA+ID4gKw0KPiA+Pj4gPiA+ICvCoMKgwqAg
aWYgKHNpemUgPD0gcGNpX3Jlc291cmNlX2xlbihwZGV2LCByZXNubykpDQo+ID4+PiA+ID4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+Pj4gPiA+ICsNCj4gPj4+ID4gPiArwqDCoMKgIHJl
dHVybiBzaXplOw0KPiA+Pj4gPiA+ICt9DQo+ID4+PiA+ID4gKw0KPiA+Pj4gPiA+ICsjZGVmaW5l
IExNRU1fQkFSX05VTSAyDQo+ID4+PiA+ID4gK3N0YXRpYyB2b2lkIGk5MTVfcmVzaXplX2xtZW1f
YmFyKHN0cnVjdCBkcm1faTkxNV9wcml2YXRlICppOTE1KQ0KPiA+Pj4gPiA+ICt7DQo+ID4+PiA+
ID4gK8KgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoaTkxNS0+ZHJtLmRl
dik7DQo+ID4+PiA+ID4gK8KgwqDCoCBzdHJ1Y3QgcGNpX2J1cyAqcm9vdCA9IHBkZXYtPmJ1czsN
Cj4gPj4+ID4gPiArwqDCoMKgIHN0cnVjdCByZXNvdXJjZSAqcm9vdF9yZXM7DQo+ID4+PiA+ID4g
K8KgwqDCoCByZXNvdXJjZV9zaXplX3QgcmViYXJfc2l6ZSA9IF9fbG1lbV9yZWJhcl9zaXplKGk5
MTUsDQo+ID4+PiBMTUVNX0JBUl9OVU0pOw0KPiA+Pj4gPiA+ICvCoMKgwqAgdTMyIHBjaV9jbWQ7
DQo+ID4+PiA+ID4gK8KgwqDCoCBpbnQgaTsNCj4gPj4+ID4gPiArDQo+ID4+PiA+ID4gK8KgwqDC
oCBpZiAoIXJlYmFyX3NpemUpDQo+ID4+PiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4g
Pj4+ID4gPiArDQo+ID4+PiA+ID4gK8KgwqDCoCAvKiBGaW5kIG91dCBpZiByb290IGJ1cyBjb250
YWlucyA2NGJpdCBtZW1vcnkgYWRkcmVzc2luZyAqLw0KPiA+Pj4gPiA+ICvCoMKgwqAgd2hpbGUg
KHJvb3QtPnBhcmVudCkNCj4gPj4+ID4gPiArwqDCoMKgwqDCoMKgwqAgcm9vdCA9IHJvb3QtPnBh
cmVudDsNCj4gPj4+ID4gPiArDQo+ID4+PiA+ID4gK8KgwqDCoCBwY2lfYnVzX2Zvcl9lYWNoX3Jl
c291cmNlKHJvb3QsIHJvb3RfcmVzLCBpKSB7DQo+ID4+PiA+ID4gK8KgwqDCoMKgwqDCoMKgIGlm
IChyb290X3JlcyAmJiByb290X3Jlcy0+ZmxhZ3MgJiAoSU9SRVNPVVJDRV9NRU0gfA0KPiA+Pj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJT1JFU09VUkNFX01F
TV82NCkgJiYgcm9vdF9yZXMtPnN0YXJ0ID4NCj4gPj4+IDB4MTAwMDAwMDAwdWxsKQ0KPiA+Pj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+Pj4gPiA+ICvCoMKgwqAgfQ0K
PiA+Pj4gPiA+ICsNCj4gPj4+ID4gPiArwqDCoMKgIC8qIHBjaV9yZXNpemVfcmVzb3VyY2Ugd2ls
bCBmYWlsIGFueXdheXMgKi8NCj4gPj4+ID4gPiArwqDCoMKgIGlmICghcm9vdF9yZXMpIHsNCj4g
Pj4+ID4gPiArwqDCoMKgwqDCoMKgwqAgZHJtX2luZm8oJmk5MTUtPmRybSwgIkNhbid0IHJlc2l6
ZSBMTUVNIEJBUiAtIHBsYXRmb3JtDQo+ID4+PiBzdXBwb3J0IGlzIG1pc3NpbmdcbiIpOw0KPiA+
Pj4gPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4+PiA+ID4gK8KgwqDCoCB9DQo+ID4+
PiA+ID4gKw0KPiA+Pj4gPiA+ICvCoMKgwqAgLyogRmlyc3QgZGlzYWJsZSBQQ0kgbWVtb3J5IGRl
Y29kaW5nIHJlZmVyZW5jZXMgKi8NCj4gPj4+ID4gPiArwqDCoMKgIHBjaV9yZWFkX2NvbmZpZ19k
d29yZChwZGV2LCBQQ0lfQ09NTUFORCwgJnBjaV9jbWQpOw0KPiA+Pj4gPiA+ICvCoMKgwqAgcGNp
X3dyaXRlX2NvbmZpZ19kd29yZChwZGV2LCBQQ0lfQ09NTUFORCwNCj4gPj4+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9jbWQgJiB+UENJX0NPTU1BTkRfTUVN
T1JZKTsNCj4gPj4+ID4gPiArDQo+ID4+PiA+ID4gK8KgwqDCoCBfX3Jlc2l6ZV9iYXIoaTkxNSwg
TE1FTV9CQVJfTlVNLCByZWJhcl9zaXplKTsNCj4gPj4+ID4gPiArDQo+ID4+PiA+ID4gKyBwY2lf
YXNzaWduX3VuYXNzaWduZWRfYnVzX3Jlc291cmNlcyhwZGV2LT5idXMpOw0KPiA+Pj4gPiA+ICvC
oMKgwqAgcGNpX3dyaXRlX2NvbmZpZ19kd29yZChwZGV2LCBQQ0lfQ09NTUFORCwgcGNpX2NtZCk7
IH0NCj4gPj4+ID4gPiArDQo+ID4+PiA+ID7CoCAvKioNCj4gPj4+ID4gPsKgwqAgKiBpOTE1X2Ry
aXZlcl9lYXJseV9wcm9iZSAtIHNldHVwIHN0YXRlIG5vdCByZXF1aXJpbmcgZGV2aWNlDQo+ID4+
PiBhY2Nlc3MNCj4gPj4+ID4gPsKgwqAgKiBAZGV2X3ByaXY6IGRldmljZSBwcml2YXRlDQo+ID4+
PiA+ID4gQEAgLTg1Miw2ICs5NDEsOSBAQCBpbnQgaTkxNV9kcml2ZXJfcHJvYmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsDQo+ID4+PiBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KQ0KPiA+
Pj4gPiA+DQo+ID4+PiA+ID4gZGlzYWJsZV9ycG1fd2FrZXJlZl9hc3NlcnRzKCZpOTE1LT5ydW50
aW1lX3BtKTsNCj4gPj4+ID4gPg0KPiA+Pj4gPiA+ICvCoMKgwqAgaWYgKEhBU19MTUVNKGk5MTUp
KQ0KPiA+Pj4gPiA+ICvCoMKgwqDCoMKgwqDCoCBpOTE1X3Jlc2l6ZV9sbWVtX2JhcihpOTE1KTsN
Cj4gPj4+ID4gPiArDQo+ID4+PiA+ID7CoMKgwqDCoMKgIGludGVsX3ZncHVfZGV0ZWN0KGk5MTUp
Ow0KPiA+Pj4gPiA+DQo+ID4+PiA+ID7CoMKgwqDCoMKgIHJldCA9IGludGVsX2d0X3Byb2JlX2Fs
bChpOTE1KTsNCj4gPj4+ID4NCj4gPj4+ID4gLS0NCj4gPj4+ID4gSmFuaSBOaWt1bGEsIEludGVs
IE9wZW4gU291cmNlIEdyYXBoaWNzIENlbnRlcg0KDQpbRGFuZGFtdWRpLCBQcml5YW5rYV0gDQpA
RGUgTWFyY2hpLCBMdWNhcw0KQ2FuIEkgcHJvY2VlZCB3aXRoIHRoZSBjdXJyZW50IGFwcHJvYWNo
IG9yIGlzIHRoZXJlIGFueXRoaW5nIEkgbmVlZCB0byBhZGQgdG8gaXQ/DQo=
