Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F87A192E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjIOIuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 04:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOIuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 04:50:39 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6381B0;
        Fri, 15 Sep 2023 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694767831; x=1726303831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tGymobsCsdR4TnZjxeNZEHcmyWsEKO/2DxUm4IOX80w=;
  b=f3+Xyoj3dgrVmaqSVPmapgBrSbEMqms7WepKGx9aXlhYhYfA/X5RRsvI
   5Kvb3XoXxrYOVZ75kYV8EukHFPFDTouVb4/GjWMQsGxqrFoP/sG3eMJOB
   C869noIQ/mMwMpLv81GLl8gFEDKlvofsA/vK6QfCBBA9He7PtrcL7Cq0Y
   NOPR1VGPCpBqFogBACAYujzLmuGd3s9mJD2yWILV238opQQydir0o0wSQ
   82FD2RKESckuN9YfzteEWVkR//kCWYA82HIzpBrwCE0Fm4ngoSWABvBvJ
   azgMHUSJHjs8khaC6mWNoHRIXoh79UvoUwpSNrmGH30J7CRx8Hxy/MW43
   w==;
X-CSE-ConnectionGUID: 8wbD03kqRDixTbinPhS1Rw==
X-CSE-MsgGUID: Iik0RCzNSWKZIql/ukmAJg==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="244045556"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 16:50:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItWdER7GsWZZR3x0Sfu7OwWWLPTsQvsQ45FihIN6UbmdOFuKICkpAE5bgFlydUKMejM5Kzs1p5DEdIUjrjrB0Zm834RUmcFvHC5qHNPkfVRTpRJylcC1fX+tjRHTx/QMHdhSeEnPAddDv9GwrDs1fg32jFKqKn2lxiy31Nqqgok1P07y+QJXegSCDdY8tIaul5T7MkKP47ykpjAdRPFl/teowhaoddRPRyqpuiKCjGwTRN34iAl1TV/517TwnslNgyLj4Es3qbpmUJ1w1YaTDumdlTK1erBhb6xvb0m1iR65CPfWabqTkz5sbuY21qfIla86d4QRHmWg0Kr1esHCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGymobsCsdR4TnZjxeNZEHcmyWsEKO/2DxUm4IOX80w=;
 b=i+Rwq9lhGrVdDuK5NpGFbzmyDQIUVq4u13z/W27xyogUVB8tA/FhowVzEH/drzSFhcWKbmztl5/Zc06Bp0Dx5oFuD6/xaPelWSjZbB84e9SchjO0JgFZic7Woj0gZSNcgNWzxy8/RB3tYs8EdpghV6KXv36YOhF31z4QOCffNUJdneaiR/2qBqt8t9MQAgL8bn93I6EyyokVS3fKPhwsifJvReXfQf93pNNKuTWPgpFH2mf1vPkPQMBZIsa8VfrgaF613KCo93tqIWlMxl3dq7frT3rbqp91mJ+KCgYuzLVL+NRA8toPTQ8GNoZmo26md1g9v/exRp0uWSqfJSO8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGymobsCsdR4TnZjxeNZEHcmyWsEKO/2DxUm4IOX80w=;
 b=BcF+qtglA1eYlUw1HULhl93d/Hs1nAfkvN1lZYaeV1xz04sxzYKGeRe1cJw7k95ovcF7RELJquEea7gCxC8ZGAYzXv/G6Qgdj5rjX6c8kmtQUMGqc1C45ilt0QtTbzPPYH+yYTd4KMolFMDuIPx8cYJK/DR/Lx0ehvdJqznKD0U=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB8042.namprd04.prod.outlook.com (2603:10b6:208:345::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 08:50:28 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6813.007; Fri, 15 Sep 2023
 08:50:27 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     David Gow <david@davidgow.net>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Thread-Topic: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Thread-Index: AQHZ5lSnupdrJGnYN0eHoLtrJK7xDbAbOvsAgAAnCgCAABQ3gIAAIHCA
Date:   Fri, 15 Sep 2023 08:50:26 +0000
Message-ID: <ZQQa0QRhm1BuI5IT@x1-carbon>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
 <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
 <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
 <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
In-Reply-To: <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB8042:EE_
x-ms-office365-filtering-correlation-id: 195ad035-5b5a-4b83-f5c7-08dbb5c8cebf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDj/eA2PAsfLKD17bnLq3hrs6qyPLZGNDnEIHlio1aI8veOEejW4deZZiKmfrACOo454ttTLTM9nM8lLNJuLhfJNQ3L2Ug7E1mdIdMpA66ki319zpVkTti58h3txNIkTWfUOORmjCfHH93X2dGv7ij3GkEeTti+0qFf1Et22H7VIvP29vGplkR5iWmrFJFSkKFTVvp3EVAOM+c++aDR+uNmQ4QffA04UBDiijXU8bXy5nOmqSh5S4Na/EZHDjyXhhXySUQnug91lC01EXbopKYXcMH6nZAsT81FLGxwwW5bPzSn6BNOOreQ6NUwCx5CtGBG/FuZhx6Vy/0wyQB/wzXWd4KRmaSF9ZwiYB8rEN8sGS3RSvFwi/XXMgZ54W/PqQ+DTj554Enhu5J6svrezQMfpw4AafsHgJ1MLCbQDqBjnKeLWbL8pwQcF54O+aWOTOEofjfLZMtd+74FHGJ0sJPiuTrBfKq8/+QTsB1xDVS6oCgqNqRcvVOf8400pu/gh7zlWl4hSDWRHej9bBwyVSGOkh2rZFWslE0UHyt4tM6o5+PAd32QWccaldL/P8IDZ8UfcbZjSggBEN5nxfzLWpD7fazG+c4E7YkU3xHfaLRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(186009)(451199024)(1800799009)(38070700005)(38100700002)(86362001)(33716001)(66899024)(966005)(478600001)(26005)(41300700001)(66574015)(66556008)(5660300002)(6486002)(53546011)(66476007)(91956017)(64756008)(66446008)(54906003)(6916009)(6506007)(66946007)(316002)(6512007)(76116006)(8936002)(9686003)(4326008)(71200400001)(8676002)(2906002)(122000001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVhWMjBlc2dKMkNmVm8zUUxmU01HU1R2L0tkS01MeUlPcmdPQUJKanJjTy9J?=
 =?utf-8?B?eXhHSWdDNCsvTXBISlRZempYWFR5dlBITjU4NUQ1YVErM3k3QmI3cVN4azBr?=
 =?utf-8?B?SEFxYkhYdVRZRi9ReHMrVUZNa0RNZCsrVi94MzVhYUJWNjQyd0lrbHNEWjhZ?=
 =?utf-8?B?MFpXblVTSVVsbVJTcHVFSHJBYTZHTkNUK3pJSy9MZ1o5cjNnNVdPTFFEdVVL?=
 =?utf-8?B?RXJyV3BTSmRERUY0M2lnUzZiR3J2ZnhLeitDdDBBWUpuVG5RMkdXK2oycC9o?=
 =?utf-8?B?MzlpcW1Pb01mNGdReVRKM0JVMjNBenhva1QwMmgvbDA4c21lS2MwazJQeHBG?=
 =?utf-8?B?b0JZOTlMR2tyaTNUdVBQNHFlanIzZDdHQ0QyczJVTWZuOG5BMSsybTNEeWV4?=
 =?utf-8?B?QzZCZjlpMkRoN2lCaml1L2Z5bERzNkpabDVEZkVEVXhYVVVwK2VISndxeU1n?=
 =?utf-8?B?N2NMcm51aGxTM2RvVkFHR05hTGozYWVQWk9xak5zQ0JNTThFbURZdmhtbStL?=
 =?utf-8?B?T1dPZkVwdmM3YmVvbE8vTis4amRJR1IzNHlFdkVkKzlWWjZ2aUlITERMRjRZ?=
 =?utf-8?B?Q1E4Vk44V2pjZVVPSTZQWHlZREh0Uit4aHJjNVB5ZUFOWTJQaUtFeDBabk1M?=
 =?utf-8?B?NEIycVFTMWJScVNsUkdGREhzNmdka3lPa0pJWFFKRHB1Z2F0TlFXS0FiSlFK?=
 =?utf-8?B?T2puRzJvOWRQRjAxVHYweXFmKzFCb2t6OFBCME5oMkU4OWRVM09pYm40WVoz?=
 =?utf-8?B?WmdjOHAxMVJHRkptUS9Uckh0VTR5WHpQRHhYc25GdVQyWU5YY1p3N1plTEFi?=
 =?utf-8?B?SjhZNnFPcFlpczlTUm5KSnFoZkNOR3RKOUJBRWJkZXllaEp3Vjdyckt6Q3Nm?=
 =?utf-8?B?Z3ozZndxY3pEUHU1NlRoNitxNkpHa2FTaDRlYVB2Uk5hTUY3aFM4QXZBZkhl?=
 =?utf-8?B?MUlWZllJTjlMZmZjTkhFcWNJN3Bpc2EySnZ3L3pOdTJQdVRnYVl5Rkl5R0h6?=
 =?utf-8?B?SU9xRVZsbVdGVXNBdmxUckZLMjRVUnQ0QUlTVjVJa1ArVmVzM1ErSFpjN2JZ?=
 =?utf-8?B?UXQ5dTVXZFJ5QUFiaVVZRWp4bldocXBEOEhiUUdLekxvREJhWFdmeXZyQlNx?=
 =?utf-8?B?ZElIa25zdllXaHVrSElpaFZkaVFpZkJpU0JrQjVPWmNiMkN2cWFZNjFCYUgx?=
 =?utf-8?B?ZDhkNWFUbU42ZVhKM3U2a3V1eHBVUmRkQnFxUTA0TUkrRTNFakJZOXh3WGpi?=
 =?utf-8?B?UzhYM2FwUCtMV1JXdGxrQWloNFkzUnRleFRQMzZMSGVpaHlUalF3MFJFSWhw?=
 =?utf-8?B?U0h4UDlEYWxPdk5VV0RBVlpjT0NOWHJPU1NpREp4VVVuekp4aVc4UVJycnJM?=
 =?utf-8?B?Q1Y2OU4zMzF6VmVNdS9xRGVaZG1tS0RlV3pLQWtFN2FhOW5sbXJSbnorN2cr?=
 =?utf-8?B?OWNKSG5KaThzd2FpdGlsYi9JSnlTOWFxS3dHZTdvUjh3UEhOTkRYUDNYRmN2?=
 =?utf-8?B?cU1ubG9Xb0hQY21XUjBYdlFhNVB3QnJMZEx0aS9CeEdOcUJ1RHY3U0ZLd01W?=
 =?utf-8?B?bExwNEttaWNFdlVaallRUUN5K0FyTGdnWkhCSkE4bmlEN0dhZU5yNlVzMDgv?=
 =?utf-8?B?TGZneGlNMTc2MGJyaWt1WFBZVWdCbkpHYmdnbExLZjlOb2F4dmJuL1hMOXRs?=
 =?utf-8?B?a0tnYmZnODZNSCtuSXJCdURrZzZCRmRvTWdjQStNNEdURnhLTHdrSlJ6Y21X?=
 =?utf-8?B?cllueExQTk9DSjh5aDRxaHVtRVBwRC9TbTMxU0F4N3M4SzJPU2duSUNXMTB5?=
 =?utf-8?B?RlQ2MlhuVjlCMWt1RTEzZHcxeDFFcEJDN3RQRU1TbDcxbVNGamY4K3dlZUwx?=
 =?utf-8?B?N2R1NTJTbkRKb1VwbmJyYmdiSE1ZY2xSeXJVbndWZWFFdEtYTDJod3Bpem52?=
 =?utf-8?B?YzcrSi9JTWRrR1cwRzNOeWxYUjlNWS9pVGgrUFZnOUN0YXlXQjdNSGRHemtk?=
 =?utf-8?B?Y0FnY2RVRW5iYmoyYlkzOUJHOXdnRXpsK21tb1hyZzlUTUpNTk5iSXRNeXZL?=
 =?utf-8?B?cFpZWHN3ZjJOVmovUkRmUVBjN3BQNzgyQjE3anQ4UXY3VjJkR0l1SUVmTFVv?=
 =?utf-8?B?eVQzS2I1N1hzUnlSaVRKYU1KMmlJZ1RVR2xNeElySGcrWnkraFlBTEIxVnVs?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27485072C3598145908E52ED33637B33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2t2VHd6WU01b3VueFB4bmlFY3I0Y0FMTGpkUjZjaUZyaTloKzlnOGN0QWE3?=
 =?utf-8?B?WC80c3pGMi9UZkVEZStEdE1iaWswNUZTN3U0SUJ1b2lqdEUyU3RQUll1M2NU?=
 =?utf-8?B?RmZ1WTk5SDRXUHdJdHYxbU5QMjV4SjZPMitEa1M4bUFBd0xlcnRKcGh6Um9C?=
 =?utf-8?B?Wk9KU3pOWHcrckRYMkZ1S0kxekxTRnBlMlVTa2hIMjAwN0tTZUxReVNiZXFC?=
 =?utf-8?B?ZXYydEJLR1l3YXZYbDBlT2FxQzRNcEVyUVVLSlFNbFpOUFZoSk81UXc2WEU2?=
 =?utf-8?B?bG1pRCsvNzkxMFpMcytnV3Z3cEZrbWtoV0p3RUpzQWpDU0drSUNyek5WRHpI?=
 =?utf-8?B?bmFNNjhlc0xLeTVDKzZ6UTJpdVgxRGRNQzUxYmhhQ0hNTklqbU9tYWpraWlQ?=
 =?utf-8?B?Q0RwbE9PSU1JZzY0RUJCK3BvWDA0akJQVWFvVEtxVkRCd3hLbkpVU1ZuYlQz?=
 =?utf-8?B?SmNnRGxybytKYzVjd1FKT0UwZXVEdzZTdHM4TjBxZXlmNnJoVmdibVBhOHJT?=
 =?utf-8?B?MnpKR1l4WmdUS2VoVG5xYSsvTC9uWjlUVXdFSVRmeHBvSG5RT2t1d0pWUHhn?=
 =?utf-8?B?Z1RGSWZvZXIyVzRJMXBrenlmdTFnR3VlQk5RK3I2UzdQb3RuWWg1dlFnbm5S?=
 =?utf-8?B?MHBEdUNIcDRjRS9ITmhPSTFTMXhvM2QxN291R241aWw3MDhQRS95bHhuU3JO?=
 =?utf-8?B?MUdORnVNYUZKaEphNWU4RHJ4ZlJndFlreHdnR3lEbjcxVE4rQTZiNmtvWjVP?=
 =?utf-8?B?Ri9sNDJQaXBCVG1NMHVUSU1rY1FyOFhyVXhXcGpQUkhOZ0FVeWlUd214azdH?=
 =?utf-8?B?RnNVbUJFMEJWcUtUNlhXK2E4bFdTSmRvdExBY1RTc0h1eENxTGw1NWR0S2Mz?=
 =?utf-8?B?dEZIOERTMEMvbjZScHo5Q09jTEZ1WGZnZVNuVjdWTENsUytKVWV6Kyt0VktI?=
 =?utf-8?B?cXp2SXZWQnVZRnlBc0l1ZjlGQURJUHFhWlZKdXlCVVZPaERoWk5QV2dFeWR6?=
 =?utf-8?B?M1hBdjhQT2FacjB2WFk2RHZZMEtUamNBdXlZc05lWFFaQ1h3M2dJTlAzNVJN?=
 =?utf-8?B?eTlXWDUvRGFYZDFxNjNBNERZWEJXSmhpdFhDU2E5MHdxOVBoRVhUQXFGU1k3?=
 =?utf-8?B?RVdSV1I3YXhXaGNkeEZ0cG9YdlRPRUNyV0Y0TWI5RjN5anFRWDZLMVp3YUNY?=
 =?utf-8?B?dUNMSXIwa0tSZ3lscGQ4cnVuZ2hkOHE0Mmo0K1hmelBLUUZYNy85NzE3RUk1?=
 =?utf-8?B?UTR3Z1UxakdNbGRCNjhYcWpzMmJKYS9wdHFvNkxna1dTK0ZyZ09GblRoRVpH?=
 =?utf-8?Q?t3E+DRVr1nh8o=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ad035-5b5a-4b83-f5c7-08dbb5c8cebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:50:26.9458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PR5fxvKgxu04L8cf4KooRIbu7+Azcj2cA4liyR1zInp6/oDo9B7r+wtUfchf2xjvbvpRCilQQytyUBk0jVRbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCBTZXAgMTUsIDIwMjMgYXQgMDI6NTQ6MTlQTSArMDgwMCwgRGF2aWQgR293IHdyb3Rl
Og0KPiBMZSAyMDIzLzA5LzE1IMOgIDEzOjQxLCBEYW1pZW4gTGUgTW9hbCBhIMOpY3JpdMKgOg0K
PiA+IE9uIDkvMTUvMjMgMTI6MjIsIERhdmlkIEdvdyB3cm90ZToNCj4gPiA+IExlIDIwMjMvMDkv
MTMgw6AgMjM6MTIsIE5pa2xhcyBDYXNzZWwgYSDDqWNyaXTCoDoNCj4gPiA+ID4gT24gV2VkLCBT
ZXAgMTMsIDIwMjMgYXQgMDY6MjU6MzFQTSArMDcwMCwgQmFnYXMgU2FuamF5YSB3cm90ZToNCj4g
PiA+ID4gPiBIaSwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIG5vdGljZSBhIHJlZ3Jlc3Npb24g
cmVwb3J0IG9uIEJ1Z3ppbGxhIFsxXS4gUXVvdGluZyBmcm9tIGl0Og0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gQWZ0ZXIgdXBncmFkaW5nIHRvIDYuNS4yIGZyb20gNi40LjEyIEkga2VlcCBnZXR0
aW5nIHRoZSBmb2xsb3dpbmcga2VybmVsIG1lc3NhZ2VzIGFyb3VuZCB0aHJlZSB0aW1lcyBwZXIg
c2Vjb25kOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBbIDk2ODMuMjY5ODMwXSBhdGExNjog
U0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApDQo+ID4gPiA+
ID4gPiBbIDk2ODMuMjcwMzk5XSBhdGExNi4wMDogY29uZmlndXJlZCBmb3IgVURNQS82Ng0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTbyBJJ3ZlIHRyYWNrZWQgdGhlIG9mZmVuZGluZyBkZXZp
Y2U6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGxsIC9zeXMvY2xhc3MvYXRhX3BvcnQvYXRh
MTYNCj4gPiA+ID4gPiA+IGxyd3hyd3hyd3ggMSByb290IHJvb3QgMCBTZXAgMTAgMjE6NTEgL3N5
cy9jbGFzcy9hdGFfcG9ydC9hdGExNiAtPiAuLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxYy43LzAwMDA6MGE6MDAuMC9hdGExNi9hdGFfcG9ydC9hdGExNg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBjYXQgL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowYTowMC4wL3VldmVudA0K
PiA+ID4gPiA+ID4gRFJJVkVSPWFoY2kNCj4gPiA+ID4gPiA+IFBDSV9DTEFTUz0xMDYwMQ0KPiA+
ID4gPiA+ID4gUENJX0lEPTFCNEI6OTEzMA0KPiA+ID4gPiA+ID4gUENJX1NVQlNZU19JRD0xMDQz
Ojg0MzgNCj4gPiA+ID4gPiA+IFBDSV9TTE9UX05BTUU9MDAwMDowYTowMC4wDQo+ID4gPiA+ID4g
PiBNT0RBTElBUz1wY2k6djAwMDAxQjRCZDAwMDA5MTMwc3YwMDAwMTA0M3NkMDAwMDg0MzhiYzAx
c2MwNmkwMQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBsc3BjaSB8IGdyZXAgMGE6MDAuMA0K
PiA+ID4gPiA+ID4gMGE6MDAuMCBTQVRBIGNvbnRyb2xsZXI6IE1hcnZlbGwgVGVjaG5vbG9neSBH
cm91cCBMdGQuIDg4U0U5MTI4IFBDSWUgU0FUQSA2IEdiL3MgUkFJRCBjb250cm9sbGVyIHdpdGgg
SHlwZXJEdW8gKHJldiAxMSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSSBhbSBub3QgdXNp
bmcgdGhlIDg4U0U5MTI4LCBzbyBJIGhhdmUgbm8gd2F5IG9mIGtub3dpbmcgd2hldGhlciBpdCB3
b3JrcyBvciBub3QuIEl0IG1heSBzaW1wbHkgYmUgZ2V0dGluZyByZXNldCBhIGNvdXBsZSBvZiB0
aW1lcyBwZXIgc2Vjb25kIG9yIGl0IG1heSBub3QgZnVuY3Rpb24gYXQgYWxsLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFNlZSBCdWd6aWxsYSBmb3IgdGhlIGZ1bGwgdGhyZWFkLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IHBhdGVudGVuZzogSSBoYXZlIGFza2VkIHlvdSB0byBiaXNlY3QgdGhpcyBy
ZWdyZXNzaW9uLiBBbnkgY29uY2x1c2lvbj8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBbnl3YXks
IEknbSBhZGRpbmcgdGhpcyByZWdyZXNzaW9uIHRvIHJlZ3pib3Q6DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gI3JlZ3pib3Q6IGludHJvZHVjZWQ6IHY2LjQuLnY2LjUgaHR0cHM6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc5MDINCj4gPiA+ID4gDQo+ID4gPiA+IEhlbGxv
IEJhZ2FzLCBwYXRlbnRlbmcsDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gRllJLCB0aGUg
cHJpbnRzOg0KPiA+ID4gPiBbIDk2ODMuMjY5ODMwXSBhdGExNjogU0FUQSBsaW5rIHVwIDEuNSBH
YnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApDQo+ID4gPiA+IFsgOTY4My4yNzAzOTldIGF0
YTE2LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzY2DQo+ID4gPiA+IA0KPiA+ID4gPiBKdXN0IHNo
b3cgdGhhdCBBVEEgZXJyb3IgaGFuZGxlciBoYXMgYmVlbiBpbnZva2VkLg0KPiA+ID4gPiBUaGVy
ZSB3YXMgbm8gcmVzZXQgcGVyZm9ybWVkLg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgdGhlcmUgd2Fz
IGEgcmVzZXQsIHlvdSB3b3VsZCBoYXZlIHNlZW4gc29tZXRoaW5nIGxpa2U6DQo+ID4gPiA+IFsg
ICAgMS40NDEzMjZdIGF0YTg6IFNBVEEgbGluayB1cCAzLjAgR2JwcyAoU1N0YXR1cyAxMjMgU0Nv
bnRyb2wgMzAwKQ0KPiA+ID4gPiBbICAgIDEuNTQxMjUwXSBhdGE4LjAwOiBjb25maWd1cmVkIGZv
ciBVRE1BLzEzMw0KPiA+ID4gPiBbICAgIDEuNTQxNDExXSBhdGE4OiBoYXJkIHJlc2V0dGluZyBs
aW5rDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQ291bGQgeW91IHBsZWFzZSB0cnkgdGhp
cyBwYXRjaCBhbmQgc2VlIGlmIGl0IGltcHJvdmVzIHRoaW5ncyBmb3IgeW91Og0KPiA+ID4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pZGUvMjAyMzA5MTMxNTA0NDMuMTIwMDc5MC0x
LW5rc0BmbGF3ZnVsLm9yZy9ULyN1DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBGV0lXLCBJJ20g
c2VlaW5nIGEgdmVyeSBzaW1pbGFyIGlzc3VlIGJvdGggaW4gNi41LjIgYW5kIGluIGdpdCBtYXN0
ZXINCj4gPiA+IFthZWQ4YWVlMTExMzAgKCJNZXJnZSB0YWcgJ3BtZG9tYWluLXY2LjYtcmMxJyBv
Zg0KPiA+ID4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Vs
ZmgvbGludXgtcG0iKSB3aXRoIHRoYXQNCj4gPiA+IHBhdGNoIGFwcGxpZWQuDQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gVGhlIGxvZyBpcyBzaW1pbGFyICh0aGUgbGFzdCB0d28gbGluZXMgcmVwZWF0
IHNldmVyYWwgdGltZXMgYSBzZWNvbmQpOg0KPiA+ID4gWyAgICAwLjM2OTYzMl0gYXRhMTQ6IFNB
VEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhmN2MxMDAwMCBwb3J0DQo+ID4gPiAweGY3YzEw
NDgwIGlycSAzMw0KPiA+ID4gWyAgICAwLjY4MzY5M10gYXRhMTQ6IFNBVEEgbGluayB1cCAxLjUg
R2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQ0KPiA+ID4gWyAgICAxLjAzMTY2Ml0gYXRh
MTQuMDA6IEFUQVBJOiBNQVJWRUxMIFZJUlRVQUxMLCAxLjA5LCBtYXggVURNQS82Ng0KPiA+ID4g
WyAgICAxLjAzMTg1Ml0gYXRhMTQuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvNjYNCj4gPiA+IFsg
ICAgMS40MTQxNDVdIGF0YTE0OiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFND
b250cm9sIDMwMCkNCj4gPiA+IFsgICAgMS40MTQ1MDVdIGF0YTE0LjAwOiBjb25maWd1cmVkIGZv
ciBVRE1BLzY2DQo+ID4gPiBbICAgIDEuNzQ0MDk0XSBhdGExNDogU0FUQSBsaW5rIHVwIDEuNSBH
YnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApDQo+ID4gPiBbICAgIDEuNzQ0MzY4XSBhdGEx
NC4wMDogY29uZmlndXJlZCBmb3IgVURNQS82Ng0KPiA+ID4gWyAgICAyLjA3MzkxNl0gYXRhMTQ6
IFNBVEEgbGluayB1cCAxLjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQ0KPiA+ID4g
WyAgICAyLjA3NDI3Nl0gYXRhMTQuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvNjYNCj4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBsc3BjaSBzaG93czoNCj4gPiA+IDA5OjAwLjAgU0FUQSBjb250cm9sbGVy
OiBNYXJ2ZWxsIFRlY2hub2xvZ3kgR3JvdXAgTHRkLiA4OFNFOTIzMCBQQ0llIDIuMA0KPiA+ID4g
eDIgNC1wb3J0IFNBVEEgNiBHYi9zIFJBSUQgQ29udHJvbGxlciAocmV2IDEwKSAocHJvZy1pZiAw
MSBbQUhDSSAxLjBdKQ0KPiA+ID4gICAgICAgICAgIFN1YnN5c3RlbTogR2lnYWJ5dGUgVGVjaG5v
bG9neSBDby4sIEx0ZCBEZXZpY2UgYjAwMA0KPiA+ID4gICAgICAgICAgIENvbnRyb2w6IEkvTysg
TWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtDQo+ID4gPiBQYXJF
cnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4Kw0KPiA+ID4gICAgICAgICAgIFN0
YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtDQo+ID4gPiA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtDQo+ID4gPiAg
ICAgICAgICAgTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcw0KPiA+ID4gICAg
ICAgICAgIEludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAzMw0KPiA+ID4gICAgICAgICAg
IFJlZ2lvbiAwOiBJL08gcG9ydHMgYXQgYjA1MCBbc2l6ZT04XQ0KPiA+ID4gICAgICAgICAgIFJl
Z2lvbiAxOiBJL08gcG9ydHMgYXQgYjA0MCBbc2l6ZT00XQ0KPiA+ID4gICAgICAgICAgIFJlZ2lv
biAyOiBJL08gcG9ydHMgYXQgYjAzMCBbc2l6ZT04XQ0KPiA+ID4gICAgICAgICAgIFJlZ2lvbiAz
OiBJL08gcG9ydHMgYXQgYjAyMCBbc2l6ZT00XQ0KPiA+ID4gICAgICAgICAgIFJlZ2lvbiA0OiBJ
L08gcG9ydHMgYXQgYjAwMCBbc2l6ZT0zMl0NCj4gPiA+ICAgICAgICAgICBSZWdpb24gNTogTWVt
b3J5IGF0IGY3YzEwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJLXQ0KPiA+
ID4gICAgICAgICAgIEV4cGFuc2lvbiBST00gYXQgZjdjMDAwMDAgW2Rpc2FibGVkXSBbc2l6ZT02
NEtdDQo+ID4gPiAgICAgICAgICAgQ2FwYWJpbGl0aWVzOiA8YWNjZXNzIGRlbmllZD4NCj4gPiA+
ICAgICAgICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogYWhjaQ0KPiA+ID4gDQo+ID4gPiBUaGUg
Y29udHJvbGxlciBpbiBxdWVzdGlvbiBsaXZlcyBvbiBhIEdpZ2FieXRlIFo4N1gtVUQ1SC1DRiBt
b3RoZXJib2FyZC4NCj4gPiA+IEknbSB1c2luZyB0aGUgY29udHJvbGxlciBmb3Igc2V2ZXJhbCBk
cml2ZXMsIGFuZCBpdCdzIHdvcmtpbmcsIGl0J3MganVzdA0KPiA+ID4gc3BhbW15LiAoQXQgd29y
c3QsIHRoZXJlJ3Mgc29tZSBwZXJmb3JtYW5jZSBoaXRjaGluZywgYnV0IHRoYXQgbWlnaHQNCj4g
PiA+IGp1c3QgYmUgam91cm5hbGQgcm90YXRpbmcgbG9ncyBhcyB0aGV5IGZpbGwgdXAgd2l0aCB0
aGUgbWVzc2FnZSkuDQo+ID4gPiANCj4gPiA+IEkgaGF2ZW4ndCBoYWQgYSBjaGFuY2UgdG8gYmlz
ZWN0IHlldCAodGhpcyBpcyBhIHNsaWdodGx5IGF3a3dhcmQgbWFjaGluZQ0KPiA+ID4gZm9yIG1l
IHRvIGluc3RhbGwgdGVzdCBrZXJuZWxzIG9uKSwgYnV0IGNhbiBhbHNvIGNvbmZpcm0gaXQgd29y
a2VkIHdpdGgNCj4gPiA+IDYuNC4xMi4NCj4gPiA+IA0KPiA+ID4gSG9wZWZ1bGx5IHRoYXQncyB1
c2VmdWwuIEknbGwgZ2V0IGJhY2sgdG8geW91IGlmIEkgbWFuYWdlIHRvIGJpc2VjdCBpdC4NCj4g
PiANCj4gPiBCaXNlY3Qgd2lsbCBkZWZpbml0ZWx5IGJlIHdlbGNvbWUuIEJ1dCBmaXJzdCwgcGxl
YXNlIHRyeSBhZGRpbmcgdGhlIHBhdGNoIHRoYXQNCj4gPiBOaWtsYXMgbWVudGlvbmVkIGFib3Zl
Og0KPiA+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlkZS8yMDIzMDkxMzE1
MDQ0My4xMjAwNzkwLTEtbmtzQGZsYXdmdWwub3JnL1QvI3UNCj4gPiANCj4gPiBJZiB0aGF0IGZp
eGVzIHRoZSBpc3N1ZSwgd2Uga25vdyB0aGUgY3VscHJpdCA6KQ0KPiA+IA0KPiANCj4gDQo+IFNv
cnJ5OiBJIHdhc24ndCBjbGVhci4gSSBkaWQgdHJ5IHdpdGggdGhhdCBwYXRjaCAoYXBwbGllZCBv
biB0b3Agb2YNCj4gdG9ydmFsZHMvbWFzdGVyKSwgYW5kIHRoZSBpc3N1ZSByZW1haW5lZC4NCj4g
DQo+IEkndmUgc3RhcnRlZCBiaXNlY3RpbmcsIGJ1dCBmZWFyIGl0J2xsIHRha2UgYSB3aGlsZS4N
Cg0KSSBjYW4gcmVjb21tZW5kIHVzaW5nIFFFTVUgYW5kIFBDSSBwYXNzdGhyb3VnaCB0byBiaXNl
Y3QsIGFzIGl0IGlzIG11Y2gNCmZhc3RlciB0byBib290IGEga2VybmVsIHVzaW5nIFFFTVUgd2l0
aCBLVk0gdGhhbiB0byBkbyBhIHJlYWwgcmVib290Lg0KDQpJdCB0YWtlcyBhIHdoaWxlIHRvIHNl
dCB1cCB0aGUgZmlyc3QgdGltZSwgYnV0IHlvdSBrbm93IHdoYXQgdGhleSBzYXk6DQoiZ2l2ZSBh
IG1hbiBhIGZpc2ggYW5kIHlvdSBmZWVkIGhpbSBmb3IgYSBkYXk7DQp0ZWFjaCBhIG1hbiB0byBm
aXNoIGFuZCB5b3UgZmVlZCBoaW0gZm9yIGEgbGlmZXRpbWUiLg0KDQpUaGVyZSBhcmUgbWFueSB3
YXlzIHRvIGRvIGl0LCBidXQgaGVyZSBpcyBhbiBleGFtcGxlIGd1aWRlOg0KaHR0cHM6Ly9naXRo
dWIuY29tL2Zsb2F0aW91cy9xZW11LWJpc2VjdC1kb2MNCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWts
YXM=
