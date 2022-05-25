Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD1E533B3A
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiEYLDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 07:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiEYLDg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 07:03:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D5338AC;
        Wed, 25 May 2022 04:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMbZMaVzCk/XZEeQvOtIP14W2efYOaIAJsJl9IkdadsbCo8WU9cZ1gkfGLaeTNMInK4niq1sJJoW6F29z8kzcC/vfLcnxUb3SNK/PkY/yIJHljvheybwZDG0A1oLFy9zTpYJxj3mO/bBKqEUPLzCZohhZuNnRWCiUkSb0iPe+t6ScYsp3KEusoBn/I4wNtvEkPuDF4eGvlQta8P9m3k9KZVoC1vLL9UbMWFQBwSdgPUwlrY1E5CVF2rLzPuhiJDg1MxkrbiWcne8MJK0dRMmTEDsCxgkO2s1bHXZ6GiptWwWmJYEmpFgXsbE2WgEYx6anBvmOZTkZNUkyeeK/XlxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1jD5L3VAYaKpuxITBzzFs7X5sNRA6DLpxXxKRbFpZ0=;
 b=ZjTcawhBF60TZbEto6Bdx9+8HcZ7w7x7MC8EzL3kuE6fCz1ssl+W5F8QYe5qKZs5ORo0p2oSwVQp2kGwTg5r1WPpmmLm76ID+FAXaki5B8RCdrF0TusTdHBlnt8BLa/1NJ/eYUvT4AM9Txp5/wUHu/NaVIvpYSIDsWVEBFSdjOVeHpK/e0caEGklrYpk0NJmgUSc5NHqYszd4PfbP7NVXzUpNq9ZU/AzqE1rJIrOlwTXcO9OcUHGSmBIO44pwBnWoU5jbykzbMWfSTP4t0gwLcn8a4QU2iFlzfLpoVwpGWUp6ZG9LyTqwNKBnpdx1qvM4d/ky1F12TZUZDdWh1u6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1jD5L3VAYaKpuxITBzzFs7X5sNRA6DLpxXxKRbFpZ0=;
 b=ZjR9wM1F+cG0uTM9WMyA+X6Mp58yS8kMdyNs9cZ8+s/U7VTroXiuFvuubB8fJK7a0nvaoTN6tH9DvYNk8DRpJXLsz34O+Mh/MZ+8G2hOCj7NnU76jNaaxaRydVFP69nVwbbQiaEFWT6YRwVumeVghqr7KZnPxW85lYcycnPksMk=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by CH2PR02MB6151.namprd02.prod.outlook.com (2603:10b6:610:d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 11:03:32 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 11:03:32 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Thread-Topic: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Thread-Index: AQHYaQ7VIq93UpHHX0WumtBeKR0BEK0hWviAgA4g4AA=
Date:   Wed, 25 May 2022 11:03:32 +0000
Message-ID: <BY5PR02MB69472D35FC4774C5B49FC19CA5D69@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
 <b9c36db0-fb4f-19d2-68af-25b926cd33b0@xilinx.com>
In-Reply-To: <b9c36db0-fb4f-19d2-68af-25b926cd33b0@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 810e1f21-53bc-47f7-cd13-08da3e3e34e0
x-ms-traffictypediagnostic: CH2PR02MB6151:EE_
x-microsoft-antispam-prvs: <CH2PR02MB61512D75684D4D3A7862B9DBA5D69@CH2PR02MB6151.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gbNBEiO4q+ZF87+1TKW0aNw1WcMnbbeGUaxq9aqu8U0LwC1GWd356gtMatmPmq8CW3y4EjgB1yYLzkRlNy88h7GnzQkCCigxuQPu0j26NflUihcxn0vk/faE7pF0MZ8OzPXgCX0+KthjipMqtz344uEA+qsOMxdKcyjPUeapD5/Dtd0x4s1eTFYGr3ta5wZLyyIO9sDmk/qBqeZVR7yYaLpnW4ISUK/+4puD+CfLkzH8zvxW9ZwdmmYXbU8mPDclPZAojIQVjitMgJ5aMDsskCzcf+ODI/vhINHLWI02sM0F4V/9DpUGCj3NZ069T9Vd2SZMVtNRK9lPqE0TCHx43gtfqC+ONoVBBaUa64sAXnhmUBbXAL9MGXB3a8lyJFw8BQ5s5liS8EJIlCOgXuo9CLEBm2PII+Dzbm29L3Tmr8Wyq9g5wyCcFD+VT0sVu5yI+CsK53/LQkOLF39h3ecTHHq3pH+qOxxGnyREBGBYO9sTwGhfJQToQs00Yyftxz/OHnFpk9T6aSNjiiuIVI8FyleyfL37wg13G/dTExpkNAE/yJvF9H/YeQeBpwZUx8zVqhM4QLKnlBeci3rnZffAKBjU6hrcVZrT0zah8vi7rP1WLkJv7D95gMqBLi+JDDOTR017R6MVCK+XaU56cc52hZLKvW/4DhN2hOGc3uwXK8kgQlWRDyFjhSz64j2XiIfm7XCbltin6dctXpjccs/JRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(83380400001)(9686003)(86362001)(26005)(508600001)(186003)(110136005)(66476007)(53546011)(55236004)(6506007)(316002)(4326008)(54906003)(8676002)(66446008)(38100700002)(8936002)(66946007)(76116006)(66556008)(64756008)(38070700005)(71200400001)(2906002)(5660300002)(33656002)(122000001)(55016003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05SRHNvT0k4Z0UxaWhvblFtM1FnWFBZMndRcUN5eEg0NExIcUsxaUM4QlBa?=
 =?utf-8?B?Z1NPSndkNzFmSnVCd28rS3c0ZUJYN0JJOU1IYWZLRlVXNkxJT1Mvc3RPR00r?=
 =?utf-8?B?bEkzV3FLV09MSUhLVWpYTWRsOWVHSThPd3U2UmpjenB5bWNxdHBIcGxiZ282?=
 =?utf-8?B?UjBDUXovRW5hNFcrRjk1UkNNNVBrbFpvcm5iZERoM2NCQmwxcFROTkhBWHhI?=
 =?utf-8?B?a2NmbHl1QkZzME13bllGQXQ0dTVwWnhpNXcrM0d0MVlNbWZhNGl5WlV6WjVn?=
 =?utf-8?B?N05sQlYxcmMxbS9RNWJnUi90YmJ2bnU4OHFCclpNbmRHVDR3ZjlOSlNQdkpz?=
 =?utf-8?B?c09GT0t6MzlleURRV0NobURDdENEOS92WDVRWUptRUJmV0t0ZW91R0RhZE80?=
 =?utf-8?B?U0ovc0J6WEdUM2FHZFJmRHYzdjZiRzl2WVlDSmtXeG1maUNwcG16ckJoTjVN?=
 =?utf-8?B?Nmt3dFpkRHBkb2lQYWhIY09JRmZwWHpVRzNLSXNzMC80cTZXS09xRHA1c3Yv?=
 =?utf-8?B?YXJSREFpM3FidEJ6NGxORGQ2OERWR3RXTlEwOHlIUVJwL2s4d0IrQ1BIMDl2?=
 =?utf-8?B?QUNKVmROMzFlSVFoRVhPQnBOTzJIK20wWmxySUhNWVV0RlQ5ZHRlVlFRcU0w?=
 =?utf-8?B?Z3pwUEN5S2FVTlU2a0NucVdNNEhiNCs4MHVnbHRkTllGQzM2RE8vRDZyYzNU?=
 =?utf-8?B?WFRlUmVCRUExa0l1bHp4Y29sc09lU2h3MHZmLzFtczVrWjA5eWNSS1dXN1d5?=
 =?utf-8?B?L1BJdDVWOUwzTFZyNHNMSkJCb01HVTB2RmtQY0N6bDUyeWU0S3k0M1ArRVhQ?=
 =?utf-8?B?UXdmdEowanI4RkUvUnpXRE93Zi90L2hlWkdjb2pSUHRmMVRuMzdtb0pJdXQ5?=
 =?utf-8?B?RHRTbmFHWWJ0MkRVbnZra3BlOGZjRkRvVEl0Z1BOWEJYaGFpclZZMkltd0xj?=
 =?utf-8?B?ejFxbFBMWmpHT3pIK25DSWx1NlhWMzdXcUxZcHpwRTRtMnpkUWJ3ZkYzYUhH?=
 =?utf-8?B?Ull3STNjZ1JITnA5NlZzQmJqT3FZbVNYZ0pVYUVVVFpmek1ZYkxpYXJ0eXl3?=
 =?utf-8?B?cmlPd0RybWlKZ0M4NU5hblJnWE4wN3pzOHU4R1BmeHdGWllVQjZyWVdvbEhz?=
 =?utf-8?B?SjRrNTl0Z0tFMzZ1N0VlZjdpZnNUYzFnZnVQd25UQklsdHo5MFZ0dmNyL3RX?=
 =?utf-8?B?b1ZRaWIvZjUzQWcwbzBPSGJFZEpqcmMwTHU2L2F5TzcyTUNVNHExdDRBVGpO?=
 =?utf-8?B?a0IxOTFLTEowbFQ0cTNhbUhwL3pYaU5KRGVoQlA0c3dlZDFYZGNuZlUzVytS?=
 =?utf-8?B?M3JyY25PSFpNRHdQVVJFbFBHWk80Ym1PcDc2Z3NJZjdFYmdTSy9uMGtvZGNs?=
 =?utf-8?B?UUxwa0EvWDBXYzhsOEtWWi94M3lhREZvOHYxanBMeng0RGo3VVNzbWdNeUxP?=
 =?utf-8?B?dUs2RXRzWFI0cTIxNDJ5QndxQ1Vvd0dibXAxOVF3TmpJNzhrS084RUwzSEtr?=
 =?utf-8?B?OWRLRGQvNWprSDFENUlWbUM3RC95WlhrTUhuYmxFVTk3QVhXengvOU05SmJz?=
 =?utf-8?B?MDB4TEs0eDVWSTlDTzFmTTJXNExhME11ZTZXdHFkTXgwZTk0OEF0L01yYVFL?=
 =?utf-8?B?L0NSVkpKRENnUDhNTFNSUUh4RDQ1eWdsbTF4TUd0WS9yWWpkWHhuRk9xdXgw?=
 =?utf-8?B?YVlFdzlhTkdDNEVnSjdML0ZHYU1lRmxrZmw3SnhoOTVoVUhWSmg1RE9RWmxL?=
 =?utf-8?B?YmhOeldodnAvS2NvdU5YT1RHZ1BHTFFQc3piQ1U3ZEJpZ21QRDZwQUpWdWZa?=
 =?utf-8?B?UWVwY0pRa1B6MnBiUzNud0JSWTRlOWNoemdSVjJDUWgrK3BvY1BRSElMM1g1?=
 =?utf-8?B?SUZJUGUwZ2hWb09yT1NZWFVrdlBQSHNGOWUxVkxYZEM1c0grN2lMRTBRSTZK?=
 =?utf-8?B?dXNVNFpGVWFoTlIvd1N6Ty9DRTRRb0ZWblBmem43eTVVOTZFNW5kVkNBb3A3?=
 =?utf-8?B?MzR6OGpYZHk0dzhKR3hkZWl3Rit5V3l2dlo2TVQyaXI1dll6blp1UnlaUmFU?=
 =?utf-8?B?eEhmR1c3L1FKSEJMM3JsemZaOE45Wi9IWWFsWGxtdnNUeDVwRXY3czY2Z2Fj?=
 =?utf-8?B?UjRlMGprRGRaNnJpdE9KeHl1aTNURlYrY205cXdyTlVocEZESStteFMyR0pY?=
 =?utf-8?B?TEQ5akNmUE1TZXdDNFUxM0pjalFQN2lKeU9jOW9kS21wOEJvZDBLbVZvZzhW?=
 =?utf-8?B?UUs3eUZFNFFCeDlMTEYvSjZZc252T0FvdENHK1BYUExlVUFFanhpSGllb1hj?=
 =?utf-8?Q?6qibuuPQAFb93ZlgDm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810e1f21-53bc-47f7-cd13-08da3e3e34e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 11:03:32.1920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKODEhbsq/yHABOpPqucd7kLcVBjblFRKUOi+Rzv4wj7YgqLxYSlSY+q3nczZ8UVfWCAtJnKRzO7N0xeRAmJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6151
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpDYW4geW91IHBsZWFzZSBjaGVjayB0aGlzLg0KDQpSZWdhcmRzLA0KQmhhcmF0
DQoNCj4gDQo+IE9uIDUvMTYvMjIgMTI6MjIsIEJoYXJhdCBLdW1hciBHb2dhZGEgd3JvdGU6DQo+
ID4gQWxsIGV4aXN0aW5nIHZlbmRvciBEVFNlcyBhcmUgdXNpbmcgImNwbV9zbGNyIiByZWcgZm9s
bG93ZWQgYnkgImNmZyIgcmVnLg0KPiA+DQo+ID4gVGhpcyBvcmRlciBpcyBhbHNvIHN1Z2dlc3Rl
ZCBieSBub2RlIG5hbWUgd2hpY2ggaXMgcGNpZUBmY2ExMDAwMCB3aGljaA0KPiA+IHN1Z2dlc3Rz
IHRoYXQgY3BtX3NsY3IgcmVnaXN0ZXIgc2hvdWxkIGJlIHRoZSBmaXJzdC4NCj4gPg0KPiA+IERy
aXZlciBpdHNlbGYgaXMgdXNpbmcgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFt
ZSgpIGZvcg0KPiA+IGJvdGggbmFtZXMgdGhhdCdzIHdoeSB0aGVyZSBpcyBubyBmdW5jdGlvbmFs
IGNoYW5nZSBldmVuIG9uDQo+ID4gZGVzY3JpcHRpb24gd2hpY2ggYXJlIHVzaW5nIGN1cnJlbnQg
b3JkZXIuDQo+ID4NCj4gPiBCdXQgc3RpbGwgcHJlZmVyIHRvIGNoYW5nZSBvcmRlciB0byBjb3Zl
ciBjdXJyZW50bHkgdXNlZCBkZXNjcmlwdGlvbi4NCj4gPiBGaXhlczogZTIyZmFkYjFkMDE0ICgi
UENJOiB4aWxpbngtY3BtOiBBZGQgWUFNTCBzY2hlbWFzIGZvciBWZXJzYWwgQ1BNDQo+ID4gUm9v
dCBQb3J0IikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJoYXJhdCBLdW1hciBHb2dhZGEgPGJo
YXJhdC5rdW1hci5nb2dhZGFAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sICAgICB8IDEwICsrKysrLS0t
LS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL3hpbGlueC12ZXJzYWwtY3BtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGluZGV4IDMy
ZjQ2NDEwODViYy4uY2NhMzk1MzE3YTRjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0u
eWFtbA0KPiA+IEBAIC0xOCwxMyArMTgsMTMgQEAgcHJvcGVydGllczoNCj4gPg0KPiA+ICAgICBy
ZWc6DQo+ID4gICAgICAgaXRlbXM6DQo+ID4gLSAgICAgIC0gZGVzY3JpcHRpb246IENvbmZpZ3Vy
YXRpb24gc3BhY2UgcmVnaW9uIGFuZCBicmlkZ2UgcmVnaXN0ZXJzLg0KPiA+ICAgICAgICAgLSBk
ZXNjcmlwdGlvbjogQ1BNIHN5c3RlbSBsZXZlbCBjb250cm9sIGFuZCBzdGF0dXMgcmVnaXN0ZXJz
Lg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDb25maWd1cmF0aW9uIHNwYWNlIHJlZ2lvbiBh
bmQgYnJpZGdlIHJlZ2lzdGVycy4NCj4gPg0KPiA+ICAgICByZWctbmFtZXM6DQo+ID4gICAgICAg
aXRlbXM6DQo+ID4gLSAgICAgIC0gY29uc3Q6IGNmZw0KPiA+ICAgICAgICAgLSBjb25zdDogY3Bt
X3NsY3INCj4gPiArICAgICAgLSBjb25zdDogY2ZnDQo+ID4NCj4gPiAgICAgaW50ZXJydXB0czoN
Cj4gPiAgICAgICBtYXhJdGVtczogMQ0KPiA+IEBAIC04Niw5ICs4Niw5IEBAIGV4YW1wbGVzOg0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICByYW5nZXMgPSA8MHgwMjAwMDAwMCAweDAgMHhl
MDAwMDAwMCAweDAgMHhlMDAwMDAwMCAweDANCj4gMHgxMDAwMDAwMD4sDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDwweDQzMDAwMDAwIDB4ODAgMHgwMDAwMDAwMCAweDgw
IDB4MDAwMDAwMDAgMHgwDQo+IDB4ODAwMDAwMDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBtc2ktbWFwID0gPDB4MCAmaXRzX2dpYyAweDAgMHgxMDAwMD47DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4NiAweDAwMDAwMDAwIDB4MCAweDEwMDAwMDAwPiwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgwIDB4ZmNhMTAwMDAgMHgwIDB4MTAw
MD47DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImNmZyIsICJjcG1f
c2xjciI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweGZjYTEwMDAw
IDB4MCAweDEwMDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDYgMHgw
MDAwMDAwMCAweDAgMHgxMDAwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVn
LW5hbWVzID0gImNwbV9zbGNyIiwgImNmZyI7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
IHBjaWVfaW50Y18wOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MD47DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsNCj4gDQo+IFJldmll
d2VkLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiANCj4gVGhhbmtz
LA0KPiBNaWNoYWwNCg==
