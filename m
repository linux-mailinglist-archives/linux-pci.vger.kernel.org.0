Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B9590D49
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiHLIUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 04:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 04:20:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172395B7;
        Fri, 12 Aug 2022 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660292447; x=1691828447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=obDLb1YJi8+TJ7Bj2d9kJ1ybJrwSVEHmUr+90Cuj+2I=;
  b=xAB8ijsuzusQS7Bfn/y6bIKVKv0BCAaHC4EAkEZbf/iDxOtDJ5+QQDoT
   ij0mLPndJtY9bb6HObQhmFopPv9ZwnOTudnRkXnz8GV8btCwSr94PV95P
   MQBh30S9AfzRKmvjr/AhwTyF0IbFb4Rp/3aY3Czo3sPugiqlzZyZjzXlb
   Tiab3Hw6oiv8sUruDdjspcPUyPs2LlS8sKwg38efuCxlUStgxQjfzHIlk
   TTYg+nzNItlCWMYl1+U14/g2+xh7OsVxe75qmf3iL2H1xw1RXCrMyFboM
   jkeeqBvUoMdztuxYQIs7VmjJVAccCiByWGZqR5nF2bh4gMA+jXPKWOGzk
   w==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="176115470"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 01:20:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 12 Aug 2022 01:20:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 01:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2XuDhTPAW05hrwgr3o8cuEsyxuevINeyTxDKTqxo2k3yhKg6rZPFF+IcqnH+yKvurvAictjsDVwtGlxCDfFAt42RRxo0r5Pswa+sXSkCM8YYUbR0fe2C5f+aAv5ULxG/ni/0aut0QRv4yTwzACGrgYhAvfilARzy2D6+tj+fChOErX4+tXcACTuWpe5BxzoBC/Zm2DOqfn+rnoN8MhM1rIAxYSHErTbzv10tpuNt3/LmKJdKPEiR1SwE11/SFNq7dFMHCdxNnhvXN4RczVGulHGW918mkngLRuOV24YMUy+09xBtOuDVeIVDVQptbkyHpS1vWe3fBhhjEzk2spl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obDLb1YJi8+TJ7Bj2d9kJ1ybJrwSVEHmUr+90Cuj+2I=;
 b=e0DhCCTpbunE8DAxWnFPf5G7fmHJpLtAwOgdwf3VTxB/Dr3n2OZpugsKNKmC3GcRV3/ZUVma3Tzx4H88jz3jjs0R7Uppa91WRKSYf0pwpIS/palqou4kRyCjBQdQyxF4uqurWTPVJiq9PRpQQ2P8Ix5K3YdlTP3VeKONwNsVzuCqaWr+C4ijxNeA0GOq/DipGtghZKyDV+vWhnP9jP0a8UdHw/dSgzzx5OaUPeBT4jUSV4RLo+AEONDC4Cmux6qOT3zzaLjBqeArGspGFgW4QhYibJUz0RdCEvBN0BvV0gixlycX4jEuMMn8W1CwJ51aH44O9emk462dFE2XsWWgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obDLb1YJi8+TJ7Bj2d9kJ1ybJrwSVEHmUr+90Cuj+2I=;
 b=G7iD5aiYb+nm5yTBHxg4TCP8R5CuZwy1XbUigVIWUvLt+dt/wPGvX9lD6H++Og+48OfdbYgAsyDuEG3QwVZp/jsFA62KT/frYz+JAApGySnBOfcg7LzPEOEDOdqFDhWHOKqPYJHHnXeKjJU2ms6Ef6qzpHH6UcttRRWOJr3/nwI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB2695.namprd11.prod.outlook.com (2603:10b6:a02:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 08:20:45 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 08:20:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mail@conchuod.ie>,
        <Daire.McNamara@microchip.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 address translation property
Thread-Topic: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 address translation property
Thread-Index: AQHYrcGjcBNK+hyPA02pML5P0onaLa2q5U0AgAAH84A=
Date:   Fri, 12 Aug 2022 08:20:45 +0000
Message-ID: <0dd12c70-70f9-1dc1-c5c8-a3ff15be81f6@microchip.com>
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-5-mail@conchuod.ie>
 <edf3da1b-79dc-4e09-8d3e-73aca09e847f@linaro.org>
In-Reply-To: <edf3da1b-79dc-4e09-8d3e-73aca09e847f@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2fc960e-3770-4df2-1902-08da7c3b8df6
x-ms-traffictypediagnostic: BYAPR11MB2695:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50iJwjvw4x/2WX96AmdREItROOR8STsC/qxW7SFgflqt9YyZyGKcms2Ip+Ec+oIB6yHbve7b3SaoubOZzDSX22TFzTCStoUHEe4ildMQ8lC2P+Fn1EgLVVdrIXll20rWPkJjOdvykx51m1fvU357rcM1qF+bm27duGlSzx0RtTz5IvinXjgcSmkPaYW7INfN3dFCojrbYayVohBvT0yA5fD5WZJT3j/3q3g4XCQ+U+GzbbRDmejtP9Rikadjnn9C8a0CwFyTKU/cwEHU7aLgJyRnaQBbi0Gbqes5DBavOsaYmU4ff6KtFcPziZUvUVR/qpCt+M6Fy7amvw8ROgCSwlFP8aM9AAUu+MJrBcT0GuqzdI7A/CR6L/XHNrQ/sx4qE+VRomUpHLuicd+B8TkBgXLTcMu8CRi10kU5j6g0VkU52l2Q1vsURMFtsDhgZCZ8SvJITV2/iHbMUeaQVuz344Z1nAuhg8E8uZ0e8UIxO8GoI4qeA3tyKfeZJDDakaM8O5Zfkz6QjosaEdOZlhimViaKF/FMgepKAmNQBSgilnoV1aRY3yOKr4Yuww8eZWHT7Byr90W0mhjTDfSMX9Ge6x2EEb/BrN3okHBf5G7oQg2NEvAtldmgJMBnmc3jETf3oaj9QQc37DGBBZqaMd8Ud+9WJQTym4Y61D9q3h2lFxVGByHYaNuBOxc6yaTaV/T+RQiz7EO3QllqY6A4/r8h8MSQVZVeCxUizE6dGVksS5UzAyUz09lEmlxdjzgb3vvJTEVmg9xph8IWB/gFV/q5iloAVLJD9IIQmupeOYTVYEY0/8m7E0LSCkcBIHM56Ok5iCzi13G2wngzGXjTMprfyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(376002)(366004)(346002)(7416002)(5660300002)(38070700005)(54906003)(91956017)(316002)(66556008)(41300700001)(76116006)(31696002)(66476007)(36756003)(86362001)(6506007)(31686004)(4326008)(110136005)(53546011)(66446008)(8936002)(6512007)(2906002)(66946007)(8676002)(64756008)(26005)(83380400001)(921005)(186003)(2616005)(478600001)(966005)(6486002)(71200400001)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akcxSldKYWZ4a1piRzM4eDBvdDFMdnA0cVQyNXZVaWJYTFZBd2dnVGpYNEEy?=
 =?utf-8?B?T0NxSFRqeVJRcWg4cHRpcFc4bXJLUXN3bGpsMFRaeG5lYmFxM2VkRUtSV1dq?=
 =?utf-8?B?dDE0TVVEKytxY2lMdnVkV2lUR1VFTnJWUnVZUTQ5WWlGK1FnSGxBOVZoSnBx?=
 =?utf-8?B?RlYwTE0zdDNzc28yUUNuZ2Vad0FMcllOaitWaER0WkRBbGpIVEUzNEpRbStn?=
 =?utf-8?B?djdpM2hZMW5XVzB4VGpCdW9iUDR3RUlCa0lWSndwQThqVFY1czNXUEY4bXFB?=
 =?utf-8?B?LzFIbVd3Y0FUTHp5ZDlDRExZRlRuL2dwL3pwRVZ3Wi9SenlhdDlmWktoeXlC?=
 =?utf-8?B?SmgxL3dtdGVrWFRpRDlGM2NOS1R5YkxKVHB6NnpqbU1kZStmV0hQU1lkZUNG?=
 =?utf-8?B?V0JvOU1mZjYrSmlIMjJxQUcxVDhZNzZzclNYNXdaSXBobXdoV0xlSTkxTkhZ?=
 =?utf-8?B?VFNCRWtEY1JNS0dXRnR2MitYNkQxNUxIV09lbjFYTjExN3JieFlLd0dHQnc1?=
 =?utf-8?B?VHdhY3YyRHpsQlVjbkZuZmxqRm1FdVlhcEErdG01NCtOOE1kTjdxdU5CNkwx?=
 =?utf-8?B?dGk0MWo5ZjVweS95RDBDYTJ4WDJPT3RmZFZhRzJZcXhmSGxicGNPeG5wc3dn?=
 =?utf-8?B?Q1dTYW1yTDY1c3pocFNrdFRBWmx5MDhFeXZYMldJZW1wUHdLWkVoNTBMQmN4?=
 =?utf-8?B?dFEvVmFiTHYvcU5OZDlLczAyOWRNOTBDTVRxdFFjcmlmS21xc2dzT1pOWGMv?=
 =?utf-8?B?ck1tRFd1eWp5VE5ubHFkZTRQWWN5UTVHTVBYUTg4ZXloVWgwLy9waUxwNTJv?=
 =?utf-8?B?akJEY1Zad3IyUlJvdW1DVUkydmxtWDZGTDZSa3Z0MHlVVnRPR0FVNmszTFBM?=
 =?utf-8?B?RjJrUitoWTc0djVpTDBmMWNzMWpwUnpDSG9SU2NqOFlmWEt5VW1Jd2tQaGJT?=
 =?utf-8?B?Q3ZqSjMybEZOcnVuRnlCRVpjb0tmVVc3cEJRY250cFMwN1daZmtSd0lWRGN5?=
 =?utf-8?B?VlNmM1h1N3g3NTFXdzlmR0NCbXFtZGtjTm1WVjlNTVNZd0JOb204dU5sWk9v?=
 =?utf-8?B?elZkYWpKZHc2eGpydkFtVS9HeERyU2RtZFA0RkZMdmlEK1lNVWR0NElIVWdw?=
 =?utf-8?B?N0RFdFRrdXVwZTEwWlpiWGQ3aTdtalJNeThBSVowUWRTT2NScU1XUFNuWjZh?=
 =?utf-8?B?eWxWUDBFbGQveTM5TlliMUtGMk53TXhlZklUbllNUGYveEpZOElMb2Mxc0pG?=
 =?utf-8?B?cloyblAxanpyTW5rSnlGZHpaMFNybXl3OGlKLytmdWZleFVWZDZOSmtZc2Vq?=
 =?utf-8?B?d2FDRGV0Q1piMnhwK1dyUk05K1J3WCt4YnZDSnNkdHVVczN1YmkrWjZMVnls?=
 =?utf-8?B?bzZTOEZMSDR3Vkk1ZmVGMng2VnhPUVZHb3gwcC9hWXBPbUYrckJVTWxkbjFE?=
 =?utf-8?B?ays4d2t4VzBJUFQ4by81V0l6ZEErWlJEa1VmUFBremU5WngrTFA0OXhZOU5J?=
 =?utf-8?B?VUR4bU9FaHg5Qno5anYyK3VBSUdMTVVZbTFyTTRvZ0JhWFN4aUJqNUFwZnU3?=
 =?utf-8?B?UVVuWEVBSkdLd0E2YUY2UXNrbVQ3QzRqWVhENllMRjVKYUhLbTZLejY5RHMz?=
 =?utf-8?B?dWhDZ2FSSzZONWlqdEMzRzJUclZkOHFvME1IQ3BqNDUxYkhRaHAzUFE5S3c0?=
 =?utf-8?B?SENXMW10Q0lPOTJrTGVwbmtBNmhLNU93cGliNG4rYUo1dFJXc3pZOGtMVFNl?=
 =?utf-8?B?Rm1SblVWVjMyS0h5WEZKTlpka1E4RlBOUGl3RXdUMDVQV2loOEtHRFRHbVdD?=
 =?utf-8?B?WXdESkE2UkxaRklsQk5VclVWNGtieWRnMW5WMFBXV3dnOXlGZzVWc0xaUHB2?=
 =?utf-8?B?Wm50bExKbzVtYUFqN0RqQWQrUW9PK3MyMlRJaWp2SHV1TE1tSVd6TmRIMlpS?=
 =?utf-8?B?c0NxRnJBckJDOTEvL3VVRVU4MjJkeGFRWnJkTG9vR1Q3b0thMjBvTzhiWklQ?=
 =?utf-8?B?ditCck9pdUhyTXRGeWdoTFp0elZaNm1uenJzZERTQkxDZGlZMUtEUUNESlVU?=
 =?utf-8?B?QkRnV1lYR2ZHUlZRakJDNFFuazFGcmJ2YS9wTjF6MnhHWmRPL3V6dm9yaFZV?=
 =?utf-8?Q?PeAQmPnMg9mIxReOva4+Tzu4T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <961215D432DF94439EDECF9F5D4B8507@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fc960e-3770-4df2-1902-08da7c3b8df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 08:20:45.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Lz58XhLdcO5ywV2Gx16MO1G7x5utRWuVUgXNCmrKPRiPIzsduotNl8l35wfpw9uHHXbRXpmP9tIGZmH1kQ0L4qm8TDN1om68JabwTDdZJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2695
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTIvMDgvMjAyMiAwODo1MiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMS8wOC8yMDIyIDIzOjMzLCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IFdoZW4gdGhlIFBDSSBjb250cm9sbGVyIG5vZGUgd2FzIGFk
ZGVkIHRvIHRoZSBQb2xhckZpcmUgU29DIGR0c2ksDQo+PiBkdC1zY2hlbWEgd2FzIG5vdCBhYmxl
IHRvIGRldGVjdCB0aGUgcHJlc2VuY2Ugb2Ygc29tZSB1bmRvY3VtZW50ZWQNCj4+IHByb3BlcnRp
ZXMgZHVlIHRvIGhvdyBpdCBoYW5kbGVkIHVuZXZhbHVhdGVkUHJvcGVydGllcy4gdjIwMjIuMDgN
Cj4+IGludHJvZHVjZXMgYmV0dGVyIHZhbGlkYXRpb24sIHByb2R1Y2luZyB0aGUgZm9sbG93aW5n
IGVycm9yOg0KPj4NCj4+IGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtcG9sYXJi
ZXJyeS5kdGI6IHBjaWVAMjAwMDAwMDAwMDogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90
IGFsbG93ZWQgKCdjbG9jay1uYW1lcycsICdtaWNyb2NoaXAsYXhpLW0tYXRyMCcgd2VyZSB1bmV4
cGVjdGVkKQ0KPj4gICAgICAgICAgRnJvbSBzY2hlbWE6IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+Pg0KPj4gRml4ZXM6IDUy
OGE1YjFmMjU1NiAoInJpc2N2OiBkdHM6IG1pY3JvY2hpcDogYWRkIG5ldyBwZXJpcGhlcmFscyB0
byBpY2ljbGUga2l0IGRldmljZSB0cmVlIikNCj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xl
eSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IEkgZmVlbCBsaWtlIHRo
ZXJlJ3MgYSBwcmV0dHkgZ29vZCBjaGFuY2UgdGhhdCB0aGlzIGlzIG5vdCB0aGUgd2F5IHRoaXMN
Cj4+IHNob3VsZCBoYXZlIGJlZW4gZG9uZSBhbmQgdGhlIHByb3BlcnR5IHNob3VsZCBiZSBtYXJr
ZWQgYXMgZGVwcmVjYXRlZA0KPj4gYnV0IEkgZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgUENJIHRv
IGFuc3dlciB0aGF0Lg0KPiANCj4gSXQgc2VlbXMgYmluZGluZ3Mgd2VyZSBhZGRlZCBpbmNvbXBs
ZXRlIGFuZCBub3cgYmFzZWQgb24gRFRTICh3aGljaCBkaWQNCj4gbm90IG1hdGNoIGJpbmRpbmdz
KSwgd2Uga2VlcCBhZGRpbmcgIm1pc3NpbmciIHByb3BlcnRpZXMuIEkgZG9uJ3QgdGhpbmsNCj4g
aXQgaXMgZ29vZC4gSXQgY3JlYXRlcyBhIHByZWNlZGVuY2Ugd2hlcmUgc29tZW9uZSBtaWdodCBp
bnRlbnRpb25hbGx5DQo+IHNuZWFrIGxpbWl0ZWQgYmluZGluZ3MgKHdpdGhvdXQgY29udHJvdmVy
c2lhbCBwcm9wZXJ0eSkgYW5kIGxhdGVyIGNsYWltDQo+ICJJIGZvcmdvdCB0byBpbmNsdWRlIGZv
byxiYXIiLg0KDQpZdXAsIGFnYWluIHByZXR0eSBtdWNoIHRoZSBzYW1lIHRob3VnaHRzIGFzIG1l
LiBJIGRvbid0IHRoaW5rIHRoYXQsIGV2ZW4NCmlmIHRoZSBwcm9wZXJ0eSBpcyB2YWxpZCwgc2hv
dWxkIGJlIGVpdGhlciBuYW1lZCBhcyBpdCBpcyBvciBvbmx5IHdvcmsNCmZvciB0cmFuc2xhdGlv
biB0YWJsZSAwLg0KDQo+IA0KPiBUaGVyZWZvcmUgdGhlIHByb3BlcnR5IHNob3VsZCBwYXNzIHJl
dmlldyBqdXN0IGxpa2UgaXQgaXMgbmV3bHkgYWRkZWQNCj4gcHJvcGVydHkuDQoNClNHVE0uDQoN
Cj4gDQo+PiAtLS0NCj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxw
Y2llLWhvc3QueWFtbCAgfCAxMSArKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+PiBpbmRl
eCA5YjEyM2JjZDAzNGMuLjlhYzM0YjMzYzRiMiAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2ll
LWhvc3QueWFtbA0KPj4gQEAgLTcxLDYgKzcxLDE3IEBAIHByb3BlcnRpZXM6DQo+PiAgICAgbXNp
LXBhcmVudDoNCj4+ICAgICAgIGRlc2NyaXB0aW9uOiBNU0kgY29udHJvbGxlciB0aGUgZGV2aWNl
IGlzIGNhcGFibGUgb2YgdXNpbmcuDQo+Pg0KPj4gKyAgbWljcm9jaGlwLGF4aS1tLWF0cjA6DQo+
IA0KPiBOYW1lIGlzIG5vdCBoZWxwaW5nLiBJZiBpdCBpcyBvZmZzZXQsIGFkZCBzdWNoIHN1ZmZp
eCAoc2VlDQo+IGJyY20saXByb2MtcGNpZS55YW1sKS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgSSBk
b24ndCBrbm93IFBDSWUgZ29vZCBlbm91Z2ggdG8ganVkZ2Ugd2hldGhlciB0aGUNCj4gcHJvcGVy
dHkgbWFrZXMgYW55IHNlbnNlIG9yIHNvbWUgb3RoZXIgcmFuZ2VzLXN0eWxlIHNob3VsZCBiZSB1
c2VkLg0KDQpZdXAsIEkgdGhpbmsgaXQgaXMgc2ltaWxhciB0byB0aGF0LiBFeGNlcHQgd2UgaGF2
ZSA0IHRhYmxlcyByYXRoZXINCnRoYW4gb25lLg0KDQo+IA0KPj4gKyAgICBkZXNjcmlwdGlvbjog
fA0KPj4gKyAgICAgIERlcGVuZGluZyBvbiB0aGUgRlBHQSBiaXRzdHJlYW0sIHRoZSBBWElNIGFk
ZHJlc3MgdHJhbnNsYXRpb24gdGFibGUgaW4gdGhlDQo+PiArICAgICAgUENJZSBjb250cm9sbGVy
cyBicmlkZ2UgbGF5ZXIgbWF5IG5lZWQgdG8gYmUgY29uZmlndXJlZC4gVXNlIHRoaXMgcHJvcGVy
dHkNCj4+ICsgICAgICB0byBzZXQgdGhlIGFkZHJlc3Mgb2Zmc2V0LiBGb3IgbW9yZSBpbmZvcm1h
dGlvbiwgc2VlIFNlY3Rpb24gMS4zLjMsDQo+PiArICAgICAgIlBDSWUvQVhJNCBBZGRyZXNzIFRy
YW5zbGF0aW9uIiBvZiB0aGUgUG9sYXJGaXJlIFNvQyBQQ0llIFVzZXIgR3VpZGU6DQo+PiArICAg
ICAgaHR0cHM6Ly93d3cubWljcm9zZW1pLmNvbS9kb2N1bWVudC1wb3J0YWwvZG9jX2Rvd25sb2Fk
LzEyNDU4MTItcG9sYXJmaXJlLWZwZ2EtYW5kLXBvbGFyZmlyZS1zb2MtZnBnYS1wY2ktZXhwcmVz
cy11c2VyLWd1aWRlDQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMi1tYXRyaXgNCj4+ICsgICAgbWluSXRlbXM6IDINCj4gDQo+IG1pbkl0ZW1zIHNo
b3VsZCBub3QgYmUgbmVlZGVkLCBidXQgeW91IHNob3VsZCBpbnN0ZWFkIGRlc2NyaWJlIHRoZSBp
dGVtcw0KPiBpbiB0aGUgbWF0cml4Lg0KDQpTR1RNLiBUaGFua3MgS3J6eXN6dG9mLg0KDQo+IA0K
Pj4gKyAgICBtYXhJdGVtczogMg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQoNCg==
