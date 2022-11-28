Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1A63A0AD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 05:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK1Eqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 23:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK1Eqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 23:46:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFBB27E;
        Sun, 27 Nov 2022 20:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669610796; x=1701146796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hS6BW9kjyMK7JbjYWtEGIoSX6vjaBp/k/hPkS8UXT9c=;
  b=kDzkrU/mckRhxKl4xm6lg9vJJ890U4ecWZW+mymso9FopeMmCxFZndPq
   7iq9o4KHIpiQJK3bfyr2L0y/SZ7dH45eniAKzq4LyjYzIUnxPwHh4RbgM
   1voDe8Z3UtjjfgCA+s/W9Dx/q/b1CFRKlfc1tvdjTvsziYzfzbKAop2jG
   OKKxobGGN2tiy6qXmvb5WTGybFO7zguACyzhopdJrqvq/seqtEIDbCxUt
   wroVxEAZ2D0XHZOtQE9dIJUE9DCj2gc7sHHTfid9pcf7N/VJJceyQ3pLW
   KxBMIo49R4g7Q4z0QX0ycSXEvQ/ja4FUej4FdSOKVYuT8c9cR7AjAD7EL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="313442155"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="313442155"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 20:46:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="711821504"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="711821504"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 27 Nov 2022 20:46:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 20:46:35 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 20:46:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 20:46:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 20:46:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HObm/5X0Sf1WquzqdRlD0R6LNZk1qLX44CYgq7edUPjjFcafRh5YMUlq3ZL1WtIbqNen4SqqGKIcA6cGelPmFCElePUcm5Yeb0rvLQbdQlOAc9L24CAOgcUgyZ/6A5PHh4PS/sdOw5QHgGgOC7arreWHAwiVO+OkN89qGEq/uiU5OUz/EtildbHWljUTx+yNeeLqJ/vJfgkl/X2dwhvwrIYji3IBLmb2w+Olq0sY7+iEdfxJudgotgUHdO1bLaLaRAfB8p8eb1DIfYQ8vU6D0dzNkWzbUpGGXgCxojzJuhHBrU5xDOK2ANEPEX0plXFrLAG7Up8fjuY7EHLaer3YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS6BW9kjyMK7JbjYWtEGIoSX6vjaBp/k/hPkS8UXT9c=;
 b=gFKcptCsxqnZQFF7yIvQkTkZenMc3nhJzYOOdHXV90Gt26Skr/Jd2EbGQ9MUtHNyFDtJOvTfq0vjHHOzfyGL7qVtpuuOLp+4Qjm6E9fgBXLoxvip7IyWJ08q59HSWhHCkH5iHg+Ms8Uh6z0SYZSRO8XKeH2020sI10RbBwlJSXpZ843K2q+f9B46kzqe0iGwxZZMneIrbwgfdvhoPLVL4WTMhL/w7Qq3x9mkMGv2w8pAjeJSfhiKi3Cw2ENNcIqSC/ugLjLXiw3gXgcR66U1oJneSL5A+T1SlkBqX6IpP+xXs8z6UdcBW3uJZCTM+F4PPeCua9WLfJYMczCuWwtUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 04:46:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 04:46:27 +0000
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: RE: [patch V3 12/33] PCI/MSI: Add support for per device MSI[X]
 domains
Thread-Topic: [patch V3 12/33] PCI/MSI: Add support for per device MSI[X]
 domains
Thread-Index: AQHZAFwqDGqoaCBvlUqBCqWTGlsnlK5TxsgQ
Date:   Mon, 28 Nov 2022 04:46:27 +0000
Message-ID: <BN9PR11MB52769C12572F8AF846138BD18C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.975388241@linutronix.de>
In-Reply-To: <20221124232325.975388241@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4673:EE_
x-ms-office365-filtering-correlation-id: 4ae10cd0-725a-41e8-0a01-08dad0fb82f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzqHlG2XjIb7uY0SI4HZsuxgPtlt+d4dB0v7vTTYhdKh4CNvsnndMRQCXKbpLpaahiEliZDGZuTcZKUiN+FnlwdcCS3034Mm1p2iJlLbW2RJqbcmtN1hnmmr/xt52dlbkdBmV6Rmyd06nQTJmCDaqVwT7MpWmaCYtuWaOHQzm9ZnyBpMcBxaXqFKN29MYMFFuPTenRBrQFK0dtVClksNOYR6CAwglol8uiqs6D8wQNAQMaJVp5QarhPSBVmCqQb3z3XkZkOQPPm42DxCv+iZatPOqMBIAbpGZTVddf97Vytnhs6EScsnOqsNzjp6LOg/yEyszwxM80gPs18a+2ZTJO+yHlvr9fPSq9fWRQO0qJDWFPOpnyxoqVGgGNbhKUCuvlVzXHj26qqto7lgdRdkobOd2faDVrXElXTItQ1DaVdQZIrOersIJi96nzAJpH0Kky7Ax4C1E6GTIVorBLifoyAjqQ7cZYl4u7Web9JzceQhasRuzhT7SB+jYstGt6gyD97iT4iXiZdsI3X5YZZ0lRTtD++15cImAYs0nKaI7ZmHk5o8xnHHWfVSIlIG1ayJ5TED7IhewW6vs6QMPSu/+myvzJPQ7jwhSTqrV56+8PJWNM5ovcUL83w6V+rOwWluVtx6kwgUzUhujWDcv4S5gMCcrK+3+p5i5HXCoQ4NPGPVcNXaLfNuNxlHi9D4M/fH4xMYYKG53Qaglm3CpqeJ+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(2906002)(38070700005)(478600001)(8936002)(5660300002)(52536014)(186003)(4744005)(7416002)(86362001)(26005)(6506007)(316002)(9686003)(7696005)(41300700001)(82960400001)(38100700002)(71200400001)(55016003)(33656002)(54906003)(110136005)(66446008)(122000001)(4326008)(66556008)(8676002)(76116006)(66476007)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzFLdzhTMm5wcjlUM3dmSGlsS0tzNTNLMTVqQ3JPS080UzdXSXFQTmhJSzE4?=
 =?utf-8?B?QUFWTVhXQ01TT0NVVW42cG9aS1JHcG5xUUc0RnlROVJwM2pIdUhZZ2daMGg4?=
 =?utf-8?B?cXJNVUtaV1ZMb0FmMnFRVVFhTnNHK3JLaVQwWktzMFU4dUl0UkpVZGFFeDh6?=
 =?utf-8?B?TWR5KzNrK1Z4UG9Bc1ZJbnV4WFJVaTBkeUFMWTNjTnY3NTFEOWsrZ0NkakFw?=
 =?utf-8?B?emtBSHVtZjlRWXdoZEpacDY4NE5HV0xNeEJEVVF3a0xYMS9MaUpOYWpCMFIy?=
 =?utf-8?B?WEE1a1ltTzFPMUpyenFZVkw5ZDNoVTJqZmZia3BHZXlMS1BuMnhQODVMUkZx?=
 =?utf-8?B?WHpyR2VLVXFyRGVEcFRuV1d2QkVWMWhCNlhkelNmckp0dW1BMWtaZHdvcXpT?=
 =?utf-8?B?Z2ptemJHVURGL3czMGxWTkpHTTJTSGJXcEk1MURVSXVvNVh4eGE0NjlsMG9o?=
 =?utf-8?B?c0V2bkFUblRwbm9QYXdYNUdyTnpyNENacUtrMEtMeld2WnZvTGR2OTVDdncz?=
 =?utf-8?B?TEpNVlRWcUVUa3oxSm5XS1cwc2xwbWI3dkJoaXE4dUNWOCtrMzdUc0tuZjQw?=
 =?utf-8?B?VlF0R2NFMzJiUWpLSEJzQ09LTldnaU01a2x4alJCekd3VmtNNU9hN0p6aDI2?=
 =?utf-8?B?eXFZV0R6RXRTWFlRU2hPUTR3RGZVTU5SZ1FybkNwN3NRUXhUTEhCclM1blNa?=
 =?utf-8?B?M0tmUjdzNTRqRlBxQ0RDeVNYM0lJTEE1VjVRRTNKRFVkb0JlOFhWdFZzMmNi?=
 =?utf-8?B?VU5aZjJ3Z0tuM3FrUVYvbzdvUmJ5SC9WMngrSTNtRlE5VmZHdkpkelg4ZnhX?=
 =?utf-8?B?M0pIRWJSUHhWVVRmbm1rdDlmUFdFZzBNYWk3emxNa1NPTmRKRStQRDk1TkdY?=
 =?utf-8?B?S1pGeUlQVXBaV0RiSG44ek1LMWxMNzVhaVd4cThDYzhDbVZtNjRwamhGZFQ2?=
 =?utf-8?B?VzdhWUttdElBRmRWL1RIUXkraTlzMzdQN2ozMHFYd1IrOTdySzRhUmhhNktN?=
 =?utf-8?B?Y05IcSt5MGZGaldiSWVYTUZtbnFRaDk2THNkdDlULzAvMnUzRWM0eitra0o3?=
 =?utf-8?B?U2NvTm5wbjNzVUdnemRBdlZvMWw0VUNoYmZmYjJiRkRMQkU4aCtkU2tNU2tI?=
 =?utf-8?B?TmJYYUkwWWhYamFMYWs1NEZPTHljd0Z4QVV5K1ZpWU5sRmUxQitJYnEzaTd5?=
 =?utf-8?B?ejRxMUJzeDk3TzJqK3BTU2lQVlNtL3BsblF3U3greWZHN0g5Y0JGN0d1NVMy?=
 =?utf-8?B?cEtBZjcxSndNK1p1R1puRy9iU3ZZalNueCt0Z00xNmJJQTRnMzdyVUI3NFh0?=
 =?utf-8?B?ZEFINjVRM2VMQUp3ajVGRitlbUk2elplazU3bzFUVnFneVEvRlg4OUxxUnVO?=
 =?utf-8?B?MWNuMzluOWNSZURZRUh5SVJmblI4TmpjQkxmVEk4ZU1GMXhkcU9TcnV1U0gx?=
 =?utf-8?B?MXE4ckMweVFhd25BYlQ4TE9ncVRyd2pFQ2dMMkxZSXlFRkpnRmhIaHBSVDIr?=
 =?utf-8?B?anlBczRXNTVOZnFzUnBoaHBGS1RNWEdYVVZ2aHNNbURKZ0VuU0c1T25Xcnkx?=
 =?utf-8?B?VlBCb29aYmZjNkhtUE9DNGlKMlllblhjcFhDR1U3bGlyYlpGV1ZaMTNXWTU5?=
 =?utf-8?B?b2ZucXA3MzEzRUJkUWRpZTkyS0hNcTZNRGxwdmZSWmwwR0ZXQ0x6eVFWN0NT?=
 =?utf-8?B?VVhoMFlJbGRBSTZ1WkphaGFGR2pXeFZFVzlpTUMzNzNhQ2VnM3ZxRWtyYm96?=
 =?utf-8?B?TUVsSTRLYkdWOVVMRWVYWmhzVkRETTBmVUx6bzBaSlV2ZkZITVRRRzJiOU9B?=
 =?utf-8?B?L0hVUUROYW9ZaHFQZFdGRmdNbXVXWjlyNnpqL1JIT0RhdE5MUFZKWTNhVWpL?=
 =?utf-8?B?d085YzhIRzhIendUaTRFcTYwdXdRTU1MeWcrU3FKN3VUMlVLaTZOYnArQ1dZ?=
 =?utf-8?B?UGdPQWlEY0tkdmlpYTQyQi96KzlWYjhoS3pGa3VvUzEzV2NIYlkwTjRBTlNJ?=
 =?utf-8?B?bFpGZFlUSFB3aStlR2xURSt3M2VmME5WMkNvd1pYQ3hOUWl5UWd2Yk9TaU5h?=
 =?utf-8?B?dmdVZUFBNitGQS94RmY2dzhLMSt1alBtNkJwRlhIK1Ixb1FTYVV1ZGZPd0Uz?=
 =?utf-8?Q?RCu6okj7hcBnYJslZ7R6mncEV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae10cd0-725a-41e8-0a01-08dad0fb82f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 04:46:27.7991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CDYFxJLV/UT2mcBerTnj4sC5S63thZYNh8z649PgvTmXZwm4574V+sYZlI5CSBbxz6zDT2ivAX2280OYv7RxCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAyNSwgMjAyMiA3OjI2IEFNDQo+ICsNCj4gKwlpZiAoIWlycV9kb21haW5f
aXNfbXNpX3BhcmVudChkb21haW4pKSB7DQo+ICsJCS8qDQo+ICsJCSAqIEZvciAiZ2xvYmFsIiBQ
Q0kvTVNJIGludGVycnVwdCBkb21haW5zIHRoZSBhc3NvY2lhdGVkDQo+ICsJCSAqIG1zaV9kb21h
aW5faW5mbzo6ZmxhZ3MgaXMgdGhlIGF1dGhvcml0aXZlIHNvdXJjZSBvZg0KPiArCQkgKiBpbmZv
cm1hdGlvbi4NCj4gKwkJICovDQo+ICsJCWluZm8gPSBkb21haW4tPmhvc3RfZGF0YTsNCj4gKwkJ
c3VwcG9ydGVkID0gaW5mby0+ZmxhZ3M7DQo+ICsJfSBlbHNlIHsNCj4gKwkJLyoNCj4gKwkJICog
Rm9yIE1TSSBwYXJlbnQgZG9tYWlucyB0aGUgc3VwcG9ydGVkIGZlYXR1cmUgc2V0DQo+ICsJCSAq
IGlzIGF2YWxpYWJsZSBpbiB0aGUgcGFyZW50IG9wcy4gVGhpcyBtYWtlcyBjaGVja3MNCj4gKwkJ
ICogcG9zc2libGUgYmVmb3JlIGFjdHVhbGx5IGluc3RhbnRpYXRpbmcgdGhlDQo+ICsJCSAqIHBl
ciBkZXZpY2UgZG9tYWluIGJlY2F1c2UgdGhlIHBhcmVudCBpcyBuZXZlcg0KPiArCQkgKiBleHBh
bmRpbmcgdGhlIFBDSS9NU0kgZnVuY3Rpb25hbGl0eS4NCj4gKwkJICovDQo+ICsJCXN1cHBvcnRl
ZCA9IGRvbWFpbi0+bXNpX3BhcmVudF9vcHMtPnN1cHBvcnRlZF9mbGFnczsNCj4gKwl9DQoNCkFz
IGRpc2N1c3NlZCBpbiB2MiBpdCdzIHByb2JhYmx5IGNsZWFyZXIgdG8gYWxzbyBtYXJrIG91dCB0
aGF0IGl0J3MgYWx3YXlzDQp0aGUgZGlyZWN0IHBhcmVudCBwdXR0aW5nIHJlc3RyaWN0aW9ucyBv
biBhbGwgZXhpc3RpbmcgYXJjaGl0ZWN0dXJlcy4gVGhhdA0KaXMgd2h5IGNoZWNraW5nIGRpcmVj
dCBwYXJlbnQgaXMgc3VmZmljaWVudCBoZXJlLg0K
