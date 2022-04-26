Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49450EF84
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 06:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiDZEH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 00:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiDZEHz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 00:07:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387415838;
        Mon, 25 Apr 2022 21:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goDG1Bdv8P2MzzjgG9ShGxhfH9jmP7wY+fvvc0XqAWpPVWrOYzCj3zZiaPb9vKWdIdzoz4Ybr0h1XmaOjLGciIPlaA8ZpZlnGXpEH5/heeAK1X6yJOBPRamEmobWov0zIXU82Yc8hC1ULKT//PfCpQ2nD9AOUVjKydENmDJiU6byGRtK2KORTjSb5Hkmb/HLnOaozpaS7ffQoEKApM0FzOmJXpEF+H/+19iWf8ov0V3N93giSiIhB2+pFoMwK20+nFebHm1Q2jBFHHZhXYyjC8ey47DUGoqLrjwCtfYPSDjVnXT1RcDxKbHEOqM3lV8BZrlKT1oVUaS0+/QmiHHiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO/EBd4yD0DdTvuPUPbejn3xs96QXJgYQoUNf3UdIag=;
 b=NQ3cmehpKFc+Efv0DE/a6HxzP6qNJlLxsBegJ0tTPy9urAsANcBqUsamJBoDrhkZ8wM6MWDfVfQmoexDVFdf3TA4K96EEMXigzcHWD6bfiOq7G92wpMVrQbZDcriQ0iHjKKiVdMHu19uN6clXoVRwZh84O1J7i6uJr6GEdF8bSEvYFnOwfEe320d7yCZS2ptXbyCIs1VL7tCflQoOt/UcudZfslu1rLt1ZIeBK3StdQSbfrQEZ+VcrIo/EzSRcK/Cx+KDwONZtg9uSkuKNAd8JQtDymiIpOcIR2kcdx2mlE4yFGK70BUr+KqJhGiP6VC6j6KpRk6pkIY2uSBHSa2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO/EBd4yD0DdTvuPUPbejn3xs96QXJgYQoUNf3UdIag=;
 b=qjeg6SYQcgDCP7zAq7VI37gIMtooyCg9fl9hBUopkmy08TPP2Zx9o3vF99kVqqufggxROTIvch3TqAcNXEXGlWE5iEgOjWGsBxmXeGTFLSP9Lmwc63GGDvIm/05aUC56qvUs9NFphVKO1FeB0GvxeqwSen0zeMIUyh9z/XeQ8pY=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by DM6PR02MB5580.namprd02.prod.outlook.com (2603:10b6:5:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Tue, 26 Apr
 2022 04:04:45 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::c855:d17b:5648:9bda]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::c855:d17b:5648:9bda%8]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 04:04:45 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
Thread-Topic: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
Thread-Index: AQHYT+E9/sV+4/r6Vk6Qc10RFN72kqzvW4qAgABCswCABwmPgIAAp44AgApWUZA=
Date:   Tue, 26 Apr 2022 04:04:45 +0000
Message-ID: <BY5PR02MB6947AE68AD2FB3C56E8619DCA5FB9@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <91ef84f9-4cac-c0aa-c717-7f1b3bc566fb@xilinx.com>
 <20220414164508.GA753109@bhelgaas>
 <CH2PR02MB6952D1D0E6FA89ED25110AFFA5F29@CH2PR02MB6952.namprd02.prod.outlook.com>
 <CAL_JsqJynvpmdF2cBFDQ3og4zgrx9UFtj4NkGUV20f61yc+YtA@mail.gmail.com>
In-Reply-To: <CAL_JsqJynvpmdF2cBFDQ3og4zgrx9UFtj4NkGUV20f61yc+YtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bde8d62-908c-417e-f3ad-08da2739e609
x-ms-traffictypediagnostic: DM6PR02MB5580:EE_
x-microsoft-antispam-prvs: <DM6PR02MB5580EDCA83829427BB0C6717A5FB9@DM6PR02MB5580.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D1A9Vlwp4moAcplYF7BYys+ZyOG+K8+UAL8gXNaXaoOndKBf4DCQAnh3eSLU3YFzo4zranuHUBOXSP8qT/7GFBCWe5EN2WcZqvzVokpOFe8YrbXvu17s5CIZiBOpu2DepMHZpm3mcwhzO4W60PQ7Az3rRRdoky5/vnX35NfxtaU/03OrET/8fAbsLkkk+KgzMlTfOdcB/x0koaLGUm1YvslyXpQyvbw9dGtyvxF6m++zLHEFwq7Iw0WyE2Kgnizjh5J0Do5x3hTf6FpNBUi8eHvSdPmBnWDCp6/t0W7nsqEiwZ67kNeGtLdsaQm9wbBL8I/7fqHCmkl7UCvO9OjBc9AY5acJPung2L0qmqZpSqFz8Ih0DDxMxwbQ/RApasMQ1UqKi/wUQPSTjXOMYNdWLMkhM6V80MxaRZlPZA/o3vVrQT8ybDl0JVUfN7N8VF0ojZN68Vns7goOVT+KKQAxwBZyD6vdsikgwMbU+Q/aw7rA0Iengwn6BfQM4JxRvLW0vd5Ezb6P+Rto1oOYbAgcKt2jXL+ZqLP193AWXGF/CQlvsuVTSyCXr1qAGkJdUFXeNzc02dnJT/aAWjx1VIBQb8sWcwS/envcZDIg3rTjWOqXqfxcd6vBtxBz2j4Z60Id875aB4kyS3k+B9fBea6FXoW+YWnsHiifaFi/fPPwJq+xSjQMt+6QcwNgrYezcXORyQS9YFpzQp9VMgYsw5oeIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(52536014)(33656002)(5660300002)(86362001)(9686003)(26005)(7696005)(2906002)(4744005)(122000001)(38100700002)(38070700005)(508600001)(8936002)(55016003)(186003)(83380400001)(66556008)(64756008)(8676002)(66476007)(66446008)(54906003)(316002)(71200400001)(6916009)(4326008)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNDVjVueVJ4Y2IwTUxJajFna1h5ak52QzV2Q0l0TkFrNXFzdWpLZ0RJUENn?=
 =?utf-8?B?dkdRQVcwbkVTTmJTS1hucmM1NDlxKzN4VDBIZm9sU1R2VXg4TDhGQVJxdncv?=
 =?utf-8?B?K2V6RkMwb2lLWElCNEs4VldSaHh6enorNnJEZGlTV1pjSkZKWjBrR1A2TGpu?=
 =?utf-8?B?eDZPWnA0NnZBT1ZVS2pnSURlU1pZVzQ4VWxHMXNZZ2xHL0czN2xiOURIa3pI?=
 =?utf-8?B?cVlwOEF5UlNjMk1MNXRMMFRVaExydmFqSC85STZkN1piZVlKRlVyNkNhaTJ6?=
 =?utf-8?B?ZVhueUt2VTFJNHZVQXBwSXpMMlIveWxOaFNjWnhqWGxWMW53d0Y4OHlSbWN5?=
 =?utf-8?B?aU0wYUtyc09sbWRuRWdiSTIyQUtlRU1sRHBTL1U2cmVCc29RNkZsODJqdWta?=
 =?utf-8?B?R3FkUndBN1RnV2pHeHR6SHVJQTA3MmIvVjJ4eGxvWlRxck4zelBaS1ZuaTZl?=
 =?utf-8?B?TlZVci9YeUowL3QvbDN0dDVsbmtiVUV3TGdJYnYrMlhIZU11cDRPMS8vZ2xx?=
 =?utf-8?B?b2R1K1o4ZGJuMmF5am1zV2h3U04vR2kzSlhld2szbmlER2JpbFBjdWU3WXlt?=
 =?utf-8?B?MXhhNlBXak90VTNRNVVFMVlDbU9RbWNVcjFBNmVrcVo4NHVRdjBDZVBsVkVx?=
 =?utf-8?B?YjBTczdLU1NSRG13V2l5RWxSaFN3UXFacVl0Tk5rMU0xM0dJN2dtMURQRmIz?=
 =?utf-8?B?Rk1QMjBXR3p4MHM4SEYxYWtKVzZYU1ZBVk1jWVJoVE1velpxMG4yRTlHMk1x?=
 =?utf-8?B?QXQ5aW5ITmY4citLSG9vSmNzeTJiemJOZjlJMGpXeWhNK3FzODQwSmQwMm9N?=
 =?utf-8?B?V2hFS0hMRGxCY09UN1Foc3ZUeWpacEEzMHRRbkc3WndxMnFhWjJHQlJxRmhv?=
 =?utf-8?B?OXdDWXZLVlV6b0NJVEtReU8yYjBjanJDTjJnUWxDVmhtNElqbXVRTGwzdzZF?=
 =?utf-8?B?MlFwWHR3ZEJNdVpZbUZvMkRRS2tMZXE2aXdaa0MrS1l2ZkpmRTAwUWhObG9H?=
 =?utf-8?B?SlVYaXhhMWNLQkFPUk9RRmZNMGdEOENyVzJQTUJmUVdGUVFxdEF5QzE1Z2tF?=
 =?utf-8?B?bHhXM0tBUVZPUjZ3SnRWZ3BFeUVGZlc5KzllSkh1OXZrSDJvSWJtVlZMYTZ3?=
 =?utf-8?B?YnlLRDN2RWp1UWxCYitERnBpU1BKR09CcGlPT1ZDT3NSaG9iUXdCeE1oVUhP?=
 =?utf-8?B?YTNCWWkyT2tSRUZHTFNKKzNzMlAxcEtNRW1SdVpDL3p1aHlWdG9DMy9jNFZu?=
 =?utf-8?B?WGx3Z3pWM3loa0FyOHNqYWhpNVRVYlprQWFGaklxREJZUUoreDRDRGhHOGFo?=
 =?utf-8?B?SFB2eVN6NXNkYzNRVmRaejNVU1A2KzRiWGlBYmhhb2k1VytwWm4rVUJ6ZHpZ?=
 =?utf-8?B?QnFwWHd4dDhkeW1mTHo0aTN5dDBtaWRBQ0pOaDk5MHRZRWVnY3hkYjl6c3pu?=
 =?utf-8?B?emZPZVlwRndTcWRzUjlrOTAxNThhNzViTmhkUGRQTFhVSmlxR3hyVlNyNWho?=
 =?utf-8?B?TWhkaXpEYnRjL1llcGdqamNJcTduRWlLZ255ZUtJeGFhOUQzVE1tZWJYaWdy?=
 =?utf-8?B?aTYyZnVGM1Zac3lNMmZpd0lsYkJzLyt5NEJYbXZaeVNzUWZOc1ErODZVRTJk?=
 =?utf-8?B?V0ZSbGFsVnZ5d2xTdkNtaVQyd2RvZmgvZU03YzNFSG95WUNJOXRaSHNJQjY2?=
 =?utf-8?B?amQ1VW15MUgxWW1UUE5iaDNWYWF6TUVuZzNwdnlzdndwRnZvYnVYcnA2MW8x?=
 =?utf-8?B?OXNNZ2RBQ1JQYTJ0NnBHd0pWWVBSMTVoNHZPNWFxMlI3Y2JVMFJJNU1Dekpw?=
 =?utf-8?B?NWdPTmxLL2VQTmJuRjZtNXBKd290eXBYRURpZFNXQ0o4UlRISjhiRFhSVGJ1?=
 =?utf-8?B?TnpXUzd3QmFXb1l3UFZGWlBGRnJqUlRDNmhpUnNQcW10R1hreUpnSnAvbkFE?=
 =?utf-8?B?cGgyeTljdjF2UlJJdlpEeVZhQ0xzK1FrMmtiOWx1SGR0eHY4TDRHazBlOFN2?=
 =?utf-8?B?N1hQblhyc1JOdDN3NzhYQU4zYm8yWDJaUTZZTVZGbFVEd1BoNXBCcDQ3ZFBi?=
 =?utf-8?B?QTZ1L05vbnBnM0JlSmJTSEtFQUQ4TCttZVhlbU02WXd6WTFjZjdINU4rYVNy?=
 =?utf-8?B?S21TNFlpVzYzQUxMOUwyTVB1Ym91VjVwUlI3b1kvaTlVYzRuS3kvVjB6cGQy?=
 =?utf-8?B?aXhGY2UvWWU2b0lzZ2cybXdHdVpQWm9sdFVFakdqSlBvL2MyQUpObDBLNGNE?=
 =?utf-8?B?YWlNcDI2VlIyQnplMHYycXAvczIrV09COEVHVk9SQWRmcncvaEF0REkwZk1l?=
 =?utf-8?B?c1dVVGJTbUJUMHZwZVF4RTNUVFZDMENjbVM1YVZhZjFTUlM1NWIxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bde8d62-908c-417e-f3ad-08da2739e609
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 04:04:45.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPgrMberAVHCmTfX19XlMFB11NGpjXBQdGnPp/vDdabHFYFvoqCYVK2o9WMQ5rDChmKOKUvwcJLLayhEZm4QMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5580
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IA0KPiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCA3OjIyIEFNIEJoYXJhdCBLdW1hciBHb2dhZGEN
Cj4gPGJoYXJhdGt1QHhpbGlueC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBUaHUsIEFwciAx
NCwgMjAyMiBhdCAwMjo0NjoyNVBNICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+ID4gPiA+
IE9uIDQvMTQvMjIgMTE6MjIsIEJoYXJhdCBLdW1hciBHb2dhZGEgd3JvdGU6DQo+ID4gPiA+ID4g
UmVtb3ZpbmcgdW5uZWNlc3NhcnkgdmVyc2lvbiBudW1iZXIgaW4gY29tcGF0aWJsZSBzdHJpbmcu
DQo+ID4gPiA+DQo+ID4gPiA+IEkgYW0gbWlzc2luZyByZWFzb24gZm9yIHRoaXMgaW4gY29tbWl0
IG1lc3NhZ2UuDQo+ID4gPg0KPiA+ID4gQWdyZWVkLiAgVGhlIGNvbW1pdCBsb2cgZm9yIHRoZSBw
Y2llLXhpbGlueC1jcG0uYyBjaGFuZ2UgYWxzbyBuZWVkcw0KPiA+ID4gdG8gZXhwbGFpbiB3aHkg
cmVtb3ZpbmcgdGhlIHZlcnNpb24gaXMgdXNlZnVsIGFuZCBzYWZlLg0KPiA+DQo+ID4gSEkgQmpv
cm4sIE1pY2hhbCwNCj4gPg0KPiA+IFRoZSBDUE0gYmxvY2sgaXMgaGFyZCBibG9jaywgUm9iIHBv
aW50ZWQgb3V0IHRoYXQgdmVyc2lvbmluZyBoYXMgbm8gdmFsdWUNCj4gaGVyZS4NCj4gPiBXaWxs
IHJlc2VuZCBwYXRjaCB3aXRoIHRoaXMgZGV0YWlsLg0KPiANCj4gSSBkaWQgbm90IHNheSB0byBy
ZW1vdmUgdGhlIGV4aXN0aW5nIHZlcnNpb24gYnJlYWtpbmcgY29tcGF0aWJpbGl0eS4NCj4gSnVz
dCBkb24ndCBjb250aW51ZSB0byBhZGQgbmV3IHZlcnNpb24gbnVtYmVycy4NCj4gDQpUaGFua3Mg
Um9iLg0K
