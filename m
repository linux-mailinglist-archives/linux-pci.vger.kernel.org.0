Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3519A590CF9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiHLH4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiHLH4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 03:56:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A0389834;
        Fri, 12 Aug 2022 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660290957; x=1691826957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SjIklEgkfB0/p+eI4wjYG6fgOsd0lXrNoCdLu4WgGqU=;
  b=OPmyznzJwEIyY8MFaivDDctWc1tlQHYlWcxxIw5BY5JIpr2SiK098uBS
   /pT3Kaz9au2rvmDp1gvdcPJW+2ewxyiQV5bB8su3Tg75UF1zD8P+p5Gv5
   fJU28RnkdZ/QsVWkXKTmgL8hsSq+DhY0jdwS7tfmFwI+PBlQFluTo+SDU
   9AGZnrcC6Li+BFwWjdEPPRhyzjzhEhI5kt3K5cmgUDnjMTrFdWkKHeWqX
   7xRA/s6EmzUmpSEHJcjK5RiYiQw3g/kEKkz5lwrfa8k1qzCAPXstY+pgy
   W5rh6up1ZokoU+cqqHXMRPUklq9aloJR68wGZztma8u4uQOoxBSlKITBc
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="172142500"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 00:55:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 12 Aug 2022 00:55:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 00:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIYzgg4Fwk5Hg0y2CnQrgugA0/rug58HTL+ZZPWZpedMhyZpnyY/Bt+61PukTyYBqFBhZW3W71NG4Rz+i9qCWxICaji7xODdRec2cM8dFiG+U1Q6aHifo8Ax/UcvSW+49j612H3YNutLyCcmAY4W43m2o0bB465x3oq/0qgV+zbv5A033dvHBUVXuQbMQxEbzX45lHCT2Glka3GbGifbQN4dmEIWupbGokb/8to3UsdRevHNzbAInM4KuAURZ9U7sR1nnqrQOgWVHgIs2FRZZlXWcMk3n7kRdWWM5uPjWVCh07wAPz4GOKufFZXBDE7OHhJiKWQiAxX/I9Zzcy+q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjIklEgkfB0/p+eI4wjYG6fgOsd0lXrNoCdLu4WgGqU=;
 b=MN3W9rhq/WMJ25g/1ahW52/aGmIjoKgYSrySWijNphlvwfWdwsk0g9SzhjXlbEJ2I0KvPEI6W/piCrHQmgC4f1UVgaHNjWV9tfdDXlOrnfMtE1klI+O6M/24XbnAvLPPr5V49UKuB2D2HAeQe/r59UnDhqsgRn614G0COmTyTSQWKadVDT++Jv9lWJuE8TYTiyZ7GjYQNUlR1H/c/sP33dPodylIswNDahbAmb0IcD5t4YPu0i3H37xy8Ww7dr7OGZM9qS0O15DkC1GqoNl7biVr9bP8XA4MABcaRaBw2h3vGMfMqpvXUAQSs1Aqo7RsbjThMoeKau33yBaUs8i0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjIklEgkfB0/p+eI4wjYG6fgOsd0lXrNoCdLu4WgGqU=;
 b=nKlhkAFiTgwHJMohWOP67H7EwESCgRxRGfRFB65zNkBtBM31JGh3dtJjdko8yHyXo0m8A3kZ1ZoV1ltLshckqHxgno5b7ZCeCsst9KXDlFC2sqW3s04iV1tRzNa4vGTGbR6TABLdOMMTJN2ci3kcZEn2gjliWEMIdTtOl5wxzzM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3734.namprd11.prod.outlook.com (2603:10b6:a03:fe::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 07:55:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:55:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 3/4] dt-bindings: PCI: microchip,pcie-host: fix incorrect
 child node name
Thread-Topic: [PATCH 3/4] dt-bindings: PCI: microchip,pcie-host: fix incorrect
 child node name
Thread-Index: AQHYrcGmPPWvz8b1R0CJioNPNiP+dq2q4qEAgAADqQA=
Date:   Fri, 12 Aug 2022 07:55:50 +0000
Message-ID: <272557c5-3e30-a873-40af-16a65c3043b2@microchip.com>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-4-mail@conchuod.ie>
 <721ccb76-c162-30ee-68cc-3316a2d62554@linaro.org>
In-Reply-To: <721ccb76-c162-30ee-68cc-3316a2d62554@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b92a0b8-c8d7-4e98-353a-08da7c3812bd
x-ms-traffictypediagnostic: BYAPR11MB3734:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xna1oKEJg2caH81/LUEhg51Jjj8RUCVOQqB6vhkPBxnkGq7U81G/ur8h/qX17GrU+QSfqtLAPa/Wx4qGi38Laug64o4HVMCRxLed321oeRBVG7oa+9vza64df7hHgRsasqZdBjub+OxZXZJWI3Rd/DSqViP0jgMBB6U0vobuZx0x9M9FdzoJuyW7gAUBWnDW+OXQPlCNsWcn+ieH8nGHkDn0UkM+tO9bkm6hGCzE9DbqyHeSKqS5r5JnPgB7xPk/fiQ30eb4BS17SIx7UsNcD9W2eHat8lFOhyKYVIPe/nkALTdYRerX0MqIEAjyrR6EN9psNwfhdDM5ZAqdPgh8SIn9CwHz3IgH3NdbbKfZBxw7xVATUjdkDn+0BL5vqUafuGBhz/ALMY0Ur1T8DeHG11GmZ2iUNOSG4OJIQ/ENR7obM8w7XM/7UseQ/8/VzcZGuWWve5+HGS+TY6gQnAGwOl3rtdXGFn2oADMlw8Nvp0G5jqfZYGhIkBbH3uLIFLKNjOVODYaHyrgfCpaF49lNTPY+Rsr/cH8ausVF6D4sI4FiakB02k1qZkOPZ1pTSNmTs3yFmb+WWYx1p51xE4COkL88sBndS2UxKdVja8CIGFYogdUjS6DDYASUYsAcLpXxatIaVdMe/ibIXBV5MjUmkk5QMndVDQY2VNNUgtWyatT4V8zFIAQF0JSNj3Zeyo+rk6jmFlzfDa+0Td5pKx6mjtwTnA0eHf7bgjpmDv3pRbGWXFik5K2/T5Ph290JT/bUAzLjlhOpXZ0x7kqDZERYhcMN89h4HDK1t8pK0PF5+5RQSN41r1mrjuNiUuWlOxq//zhoda9C9+qlBi+aiI4dHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(966005)(316002)(64756008)(38100700002)(4326008)(8676002)(66556008)(83380400001)(478600001)(36756003)(31686004)(54906003)(76116006)(91956017)(66446008)(110136005)(66946007)(6486002)(26005)(31696002)(86362001)(2906002)(5660300002)(921005)(8936002)(7416002)(6512007)(6506007)(41300700001)(71200400001)(122000001)(38070700005)(2616005)(66476007)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGxSdWlRTGJRdCtZZkorTDZRdnpwdVczK3JqY0hpbit2TlNQR1ZRTFNTWmpm?=
 =?utf-8?B?SCtzamFFQnYwdVl0cnphT2hRVllrV2hwdGtQVmZHck4xQWY5RWR1OVJ1QmJi?=
 =?utf-8?B?ZTFMR1kyMjVuMmFOSWtnWlVFNHNaNHBDMmJTcFZ6YWRoeFR3a1pXTDN5dnVO?=
 =?utf-8?B?MkdBL2ZMV1pNOGdwblZNOEExSzViL1RJazF4MDJNeTVkb2FhSFAwQXQveVlF?=
 =?utf-8?B?akFQK0dGY0hGNHgyM3hqSU9INTRCQTUrNEUrdUNHU3o3NmtMZWRLaENUNzc3?=
 =?utf-8?B?MVNoaHd0U2s2MlpFKzdXTVd1Yy84V1JWTDZoNXJUNlFoWGhGT2JFcW50WmxR?=
 =?utf-8?B?dDNKbjZ6YjY2S1RMOGV5V0JGNHd2M01oMG1VcXFVRDBueWpvUm5aam5EOXBl?=
 =?utf-8?B?QXpER0FyN0NrdktPOS93QTJjSTJIWDVON1RrRFFEajFpSm10MFM3Nkd0Nzg5?=
 =?utf-8?B?a0dDSE5lTzdWcjdnM0FLcXR0MnFOK1A4TENuby9pQWdjMEY4VFE4VWk3b09U?=
 =?utf-8?B?Y1Bnc0FId0k2cU5hYnVpSy8rbjdnRGhGcnpZT1l2MFllRmZUWExuTGZsYUpS?=
 =?utf-8?B?MmJhZi9yTEFpaVRac09SeHErYWtBOTkzb1pCYWIzRWpaN2pacWZTdFBhODha?=
 =?utf-8?B?QjJjVjlvOFRlRjBTZVU1Y08vUHNYZGo3aCtXQmF6a0tialR4cFpqWGJwT1ZU?=
 =?utf-8?B?eU15K2l6NXd5Wjl1YnpOZGVNTldhMi9qSmhrRTJEdzladDBpakpZYVFRMkRk?=
 =?utf-8?B?cEh4ZEJpcG9oTEt1U05zRmNjTTk5eTdwbGpvRUQwbjZHZWRTNDN1MHRMMVNu?=
 =?utf-8?B?TVFKM3V2UkFPYkFjT0x6RXFvSGpqaWF2cUdmT2xYV0sxVHVENGppS21kRnNP?=
 =?utf-8?B?VWVobUc1TUF0VXppeFYvTWZuQ1Q4Y1ByUjVHb1ZlNmZFZ1Z3eE9Ya0pKWlhl?=
 =?utf-8?B?aW83YVNVanpRN0VTSG5uQmJYMnN1YWdpRUhCYWg4UGtnOEswTU5YUFk1RlVa?=
 =?utf-8?B?eUFVMlJSSTFySk90bEhURkVXYVNNSkRxMnFGWDVuT2wvdm1KcXpOOHFpbUMz?=
 =?utf-8?B?a3A3QVZWUnkwSzh6ZDB0Y0lrMHBaRzFTM3hlVzNaTCsyV2dpK2E5S2l1WkZj?=
 =?utf-8?B?NzVqRmFja2RWSDB3QjBxSmdmcDdGOWRvMGZYaG1SR1pYYnZ3NWEzNHFkbHVF?=
 =?utf-8?B?NGxTdzRTYkp0U0NHNEdicjlCUHNYMmU2QWQyZEVHdUJRc0diZFBNNFlXUjdK?=
 =?utf-8?B?T3FOaDdrQkFXMkV0QU56V2lIYzkwU2lCRytKcUNsdHQvM1AycHBQOTRBV1Vt?=
 =?utf-8?B?VDJocmlsVFpEU0pubitvaUxTbG84QWthQVNoNi9SZ3lsQ3N4dlhvQ1dFTzds?=
 =?utf-8?B?WVdXbXNXYlNmUlkxeW9iNmNTUHlUaHFHUUNVbUx1dzkwKzRFVnhZOW56Nmtt?=
 =?utf-8?B?MjRNQTJybHZPTkQrVjh3VDN4YWtGcGRPQ2d2ckY1SnhvNVVpSExFK3VlKzE4?=
 =?utf-8?B?cUx3Mk9OcGJYSnFacjBYZFB5OWlIc1FBS25IOTUwcVdhOC9LWVVVMHRsWUNn?=
 =?utf-8?B?QmRRWnl1OTFVMTAvaGxFenFhSEN1c1hGcGxlVWhnL0ZhWkZ6cVY4YzR5Z0dR?=
 =?utf-8?B?ZGhqM3dqaG5XWjFMRHAxVUwxMWtKZzdkL3NJWVBHd2g2ak9wbjN0ZHhWaDJt?=
 =?utf-8?B?cXd3TDVMUnlyc3RObzN0UmVkYXdoN1MxVHQyL1ZTa2RIajYvbVB2dmswQVRM?=
 =?utf-8?B?TWpBMW1BaGlLSnFuWGhmOHQrWFlldG1lVHV5MTl2VEZaTVREaklYeExobktv?=
 =?utf-8?B?azlmdStQOGl6Q2JmRDhjb3VLbGF5dFJDcVA2aU9SckxPUUhzQW9QWTRjTUcx?=
 =?utf-8?B?NDB2eVRWUzNVallFdStOMGxpT2l5NGFXdS9mR2FkWnhBdHFKNHlkMU9TZTVP?=
 =?utf-8?B?bnVTOTBUVWtFNUFBRVdhbENteVQ2MlB4WDJybG5QTmNIdjhBTUFxRXJVamFN?=
 =?utf-8?B?V0FmQlBjU0s5K3hhNW5WaDJMcXVmdUtoZS9VRWlQR0M4YjB0MmdlNGRyeGp6?=
 =?utf-8?B?UnU3STRUMGJkeHBQbzcvZ3RPZ3FnZ3V3SCt4TFFVNmE3TkJFMzZqdHVSWW0w?=
 =?utf-8?Q?fs8gCoBE6wtW6xP2LWnBsHQ23?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3131DE56252FC946B89B85145A5DCC37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b92a0b8-c8d7-4e98-353a-08da7c3812bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 07:55:50.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDpfRc1JsIpU/MMp7wKy1Z7JZq1aWjkL81COEPN7IOq9/TWGjQKVRrg08qJC4ymGtHGXlvhQx3YSzga+4XS4iD7KZKk1lyOxR/rI030yrRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3734
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTIvMDgvMjAyMiAwODo0MiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMS8wOC8yMDIyIDIzOjMzLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IHYyMDIyLjA4IG9mIGR0LXNjaGVtYSBpbXByb3ZlZCBjaGVj
a2luZyBvZiB1bmV2YWx1YXRlZFByb3BlcnRpZXMsIGFuZA0KPj4gZXhwb3NlZCBhIHByZXZpb3Vz
bHkgdW5zZWVuIHdhcm5pbmcgZm9yIHRoZSBQQ0llIGNvbnRyb2xsZXIncyBpbnRlcnJ1cHQNCj4+
IGNvbnRyb2xsZXIgbm9kZSBuYW1lOg0KPj4NCj4+IGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9j
aGlwL21wZnMtaWNpY2xlLWtpdC5kdGI6IHBjaWVAMjAwMDAwMDAwMDogVW5ldmFsdWF0ZWQgcHJv
cGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdjbG9jay1uYW1lcycsICdjbG9ja3MnLCAnbGVnYWN5
LWludGVycnVwdC1jb250cm9sbGVyJywgJ21pY3JvY2hpcCxheGktbS1hdHIwJyB3ZXJlIHVuZXhw
ZWN0ZWQpDQo+PiAgICAgICAgICBGcm9tIHNjaGVtYTogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCj4+DQo+PiBNYWtlIHRoZSBw
cm9wZXJ0eSBpbiB0aGUgYmluZGluZyBtYXRjaCB0aGUgbm9kZSBuYW1lIGFjdHVhbGx5IHVzZWQg
aW4NCj4+IHRoZSBkdHMuDQo+Pg0KPj4gRml4ZXM6IGRjZDQ5Njc5ZmIzYSAoImR0LWJpbmRpbmdz
OiBQQ0k6IEZpeCAndW5ldmFsdWF0ZWRQcm9wZXJ0aWVzJyB3YXJuaW5ncyIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4gLS0t
DQo+PiBUaGlzIGlzIGFub3RoZXIgb25lIFJvYiB3aGVyZSBJIGZlZWwgbGlrZSBJJ20gZG9pbmcg
dGhlIHdyb25nIHRoaW5nLg0KPj4gVGhlIExpbnV4IGRyaXZlciBnZXRzIHRoZSBjaGlsZCBub2Rl
IHdpdGhvdXQgdXNpbmcgdGhlIG5hbWUsIGJ1dA0KPj4gYW5vdGhlciBPUyBldGMgY291bGQgaW4g
dGhlb3J5IChvciByZWFsaXR5KSwgcmlnaHQ/DQo+IA0KPiBZZXMgYW5kIHdlIGhhZCBzdWNoIGNh
c2VzIHdoZW4gcmVuYW1pbmcgZGV2aWNlIG5vZGVzIGNhdXNlZCByZWdyZXNzaW9uLg0KPiBNeSBp
bnRlcnByZXRhdGlvbiBpcyB0aGF0IG5vZGUgbmFtZSBpcyBub3QgcGFydCBvZiBBQkksIHNvIGFu
eW9uZQ0KPiBkZXBlbmRpbmcgb24gaXQgbWFkZSBhIG1pc3Rha2UgYW5kIHRoZXkgbmVlZCB0byBm
aXggdGhlaXIgc3R1ZmYuIEkgdGhpbmsNCj4gYWN0dWFsbHkgdGhhdCBpcyByZWFsbHkgcG9vciBj
b2RpbmcgYW5kIHBvb3Igc29sdXRpb24gdG8gcGFyc2UgZGV2aWNlDQo+IG5vZGUgbmFtZXMgYW5k
IGV4cGVjdCBzcGVjaWZpYyBuYW1lLg0KPiANCj4gT3RoZXIgZm9sa3MgaW50ZXJwcmV0YXRpb24g
aXMgdGhhdCB3ZSBuZXZlciBicmVhayB0aGUgdXNlcnMgb2Yga2VybmVsLA0KPiByZWdhcmRsZXNz
IHdoYXQgaXMgZG9jdW1lbnRlZCBpbiB0aGUgQUJJLi4uIHNvIGl0IGRlcGVuZHMuIDopDQo+IA0K
PiBIZXJlIGhvd2V2ZXIgaXQgaXMgbm90IGEgZGV2aWNlIG5vZGUgbmFtZSwgYnV0IGEgcHJvcGVy
dHkgbmFtZSAoYWx0aG91Z2gNCj4gc3RpbGwgYSBub2RlKS4gQmluZGluZ3MgcmVxdWlyZSB0aGVz
ZSB0byBiZSBzcGVjaWZpYywgdGh1cyBzdWNoIG5hbWUgaXMNCj4gYSBwYXJ0IG9mIEFCSS4NCg0K
WXVwLCBwcmV0dHkgbXVjaCBhbGlnbmVkIHRvIG15IHRob3VnaHRzIG9uIHRoaXMuDQoNCj4gRm9y
IHlvdXIgY2FzZSwgSSB3b25kZXIgd2h5IGl0IHdhcyBjYWxsZWQgImxlZ2FjeS1pbnRlcnJ1cHQt
Y29udHJvbGxlciINCj4gaW4gdGhlIGZpcnN0IHBsYWNlPyBOb2RlIG5hbWVzIC0gYWxzbyBmb3Ig
cHJvcGVydGllcyAtIHNob3VsZCBiZQ0KPiBnZW5lcmljLCBzbyBnZW5lcmljIG5hbWUgaXMganVz
dCAiaW50ZXJydXB0LWNvbnRyb2xsZXIiLg0KDQpJIGRvbid0IGtub3cuIEl0J3Mgd2hhdCB3ZSBo
YWQgaW4gb3VyIGludGVybmFsIHRyZWUgcHJpb3IgdG8gdXBzdHJlYW1pbmcuDQoiV2UiIGRvbid0
IHJlbHkgb24gdGhlIG5hbWUgZm9yIHRoZSBMaW51eCBkcml2ZXIsIHNvIEkgYW0gbm90IHJlYWxs
eSB0aGF0DQpib3RoZXJlZCBpZiB3ZSBjaGFuZ2UgdGhlIGJpbmRpbmcgb3IgdGhlIGR0cy4NCg0K
PiANCj4+IC0tLQ0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBj
aWUtaG9zdC55YW1sICAgICAgICAgIHwgNCArKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0
LnlhbWwNCj4+IGluZGV4IDJhMjE2NmYwOWUyYy4uOWIxMjNiY2QwMzRjIDEwMDY0NA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1o
b3N0LnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+PiBAQCAtNzEsNyArNzEsNyBAQCBwcm9wZXJ0aWVz
Og0KPj4gICAgIG1zaS1wYXJlbnQ6DQo+PiAgICAgICBkZXNjcmlwdGlvbjogTVNJIGNvbnRyb2xs
ZXIgdGhlIGRldmljZSBpcyBjYXBhYmxlIG9mIHVzaW5nLg0KPj4NCj4+IC0gIGludGVycnVwdC1j
b250cm9sbGVyOg0KPj4gKyAgbGVnYWN5LWludGVycnVwdC1jb250cm9sbGVyOg0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4g
bGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2DQoNCg==
