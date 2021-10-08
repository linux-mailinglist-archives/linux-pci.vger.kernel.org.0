Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC34260ED
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhJHAIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 20:08:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:34887 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhJHAIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 20:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633651583; x=1665187583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g+vbBIPCtPAyFmO9Ej4KRe/T63zLslMEa6aRiKsUzcE=;
  b=JHL4XTeSAz/kiQS4/TWNwAjZmsJOHbZVRMRl7WUnxmvyBsyNgZlmUKbR
   IfbX9EKiYPk9kM2ugCQC1QAGKXTndrTp+q/cfUkbteGDlau0KiLlwdH5k
   C62cubpG3hnPKgF8qBze+Rc6yT+DmvbW7z9bVAWRYWLXy6lrI7ueRhiXp
   q9F2bRf/bdZCUTFaXrZp5Bfc5qETptUTOZBszIeokhNdog3xySftRlsfS
   DReaUlC0ScNnzVD+6c7S7byFX6IPSmP0SNCxzB1d+CGX1L81LE7helWEw
   5pJRk95hBzl0VR6Rj20ND35IicqzlNABg2qS8rfX0i31Qsi2czsW35O7+
   Q==;
IronPort-SDR: zIKdCYoq3uTlciDhoNq+TJKGwy2b/m5BihBW1Fi377Cdo9fpS7NU7JWL0MDzSnNwQepsI4Tn81
 RhiqWhrBf38z10HLxN3NC/aH8WAwe6EkLs5aGoMOcJXlsb6/VxswgRrqX+eCk1QNfZWiPz19tc
 zeiWfuhggzzE9IPWTAEG79JcNKfaTXMs3+Tuo9MvYJSuUQrDUXIZQmEIaPpl6IXH5h3NRolJg+
 3lF7l1iI2EjuKmGlPxRlQc1ZKj/oSjtgepxLOYrvFwaa0Ksq0BfdjLXGMygKgBHpfqD0j6r5c9
 aJ+Ub4dakCcHpjTbsfpZtV0r
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="139468658"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 17:06:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 17:06:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 7 Oct 2021 17:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlgWUKjyab2rsKf9Y93GWf6jBzxzI5sHIxeIJgHXxrY+akP3PpTFRcfUWRBTje0twFbfLsDTTchwLxjXMTJpLnFRWpaoPKRxcf0tm03K/JfdgF+eIcB1nnhww6/+YeIXHFKOV5BuOvJ3CAv1Uo5ooDLav+3PYaKp9Q+GauuQsOtno95GS8ttHdjQ2xfQbWvfsqyPB+oGovVxPMzSrvc76Joku3D00X0bfkRnGHMosPC8dfobkPL+uat43kL8//5JUm0DlAKb6qME/MwW+u7FaM5HvTBNqCdujFYIzLdlGLJW0feYfi0sHZ+OtpmCBiMs+5MJsi6HJwypCEyP7FY6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+vbBIPCtPAyFmO9Ej4KRe/T63zLslMEa6aRiKsUzcE=;
 b=TplfhvWVWUHPAYgbCzJOpTQvvPbUdmBL6/nyTXJHBSajUHmgj9kIyKxOAJjaiaOAn3ovNuTF0DNTJrxAClmpr5rL0LVZuAyBm5ktzhQlWcUarzMQPGN2SamUFZ+dhce0BIfKMQftVUO1CEPRuWcL49NNvOwSX0BEypgExc6xI87IyhuFHJ+wQj8+cc0CLgzb9FKbH0+iBg0xmhlJpn7P2O815qo8M//k5tki76Oi7cdUpd4d81djOpU+aQb3MzK/vZDz7Lx9bbSIrAkeGVRannBluSBUU4ICchWwv0fxGAVMwSnfY1aj7ZxAwkqo8/AaHwu0MGufi16g19zaEtGfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+vbBIPCtPAyFmO9Ej4KRe/T63zLslMEa6aRiKsUzcE=;
 b=GylNnsHzJI2XcM+GtvIghIn2/ijwC8YbR9e4eaVjfCGdfkb4kfjxtn5WoRArVtrI6ka4j3O7PDl90QLpJGWoD+S/n/naYBTHbkVqNRSRdyYFPI5MPUFHqQZBngSeU64VCxMAaGPHLWYFR2nnBON55LaC0kP/5KjagOyw1wHSv3s=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5651.namprd11.prod.outlook.com (2603:10b6:5:356::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 00:06:19 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4587.020; Fri, 8 Oct 2021
 00:06:18 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <kelvincao@outlook.com>,
        <logang@deltatee.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAADAgCAADeugIABAgSAgAODLoCAAYeKgIAASeuAgAAgtACAADaYAIAAjs8AgABOUICAABZuAIAAEp2AgAGRU4CAAC1IgA==
Date:   Fri, 8 Oct 2021 00:06:18 +0000
Message-ID: <37d0615c8a9a5e7c55527f4d478a0e707292c1ec.camel@microchip.com>
References: <20211007212317.GA1268429@bhelgaas>
In-Reply-To: <20211007212317.GA1268429@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6acb6c2b-f2c1-430b-74f4-08d989ef743d
x-ms-traffictypediagnostic: CO6PR11MB5651:
x-microsoft-antispam-prvs: <CO6PR11MB5651B6759F05E086D9EE6AAC8DB29@CO6PR11MB5651.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPaELFEEvMjHVudHV3xs/jxB+L3bxb5+bjMbE2bUzyFpIuthvgmqD9W+AcKdiPPLjUD6OUSgbMKA62ypgjr59BPlJ+VOjywJTuOTFYmUoTTT7cLBYHCIQSd25mAXot3pOv+ofE/NOW0gDWU4nccA4flj3o9fjSjeW6luUrtib5pmTalj0xPA++lyeGfPfnLuT7lGZhl9JChR52rd9S9XFb3LDgSxjjYHJEzQXmWLo8FFK8GjuzEVOKBI5dzVQ9TnVeSKv6jK7k5iZMNZ19rTdJvPnyHKIy5APcjvahUwbGvRkZjLcboVZnBLr9ksm3Cyk1AQrtqv1n1buRcVEjf5haueaZCEBIq50J1Hd4NvR2fbf4VuljCqAi7rfKrRc7yt+aK5veye0yssGZd0B5x2kAusbnI/9V8kC1N8vEoHJtDMHdaV/uPyOQKEJgfUoQ4xO6+HygkddQcPwAGuVdqd9sAhlyTkUZ2Wrli+khBy0wH3uLiqjoNZqtxYP0G2ZuOELfqphHOfxHtiUz1kgNykcNWdZdkxiR8jzJrjcYSexobj5lXhBdkxwaitsfsGXNtpXVZOn9709Fifq8903u4FgOkhSX561iXcpWOt9F097RRqXiczxOJD9SbmdmGTz2x6uPiH21FMkTiTtkMsRRUoQjvNxiBSr4+Zcly5lPD2rVakYeIjFBUuamrpFNdT8/3JG6Y1Tr+1QHn0QQfAieCWmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(508600001)(6512007)(316002)(66556008)(54906003)(38100700002)(66946007)(66476007)(66446008)(64756008)(76116006)(6486002)(2906002)(6916009)(8676002)(6506007)(122000001)(8936002)(83380400001)(2616005)(4326008)(36756003)(86362001)(71200400001)(5660300002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi9xSytvZTN2ZU1NNXFsRlY2REFHWXdDVVBSRUFnbklCMXdqSnBORGIrWDNy?=
 =?utf-8?B?bWxjNC83enRnRitnWmtBYmtSNVNiaUV1T1FDUzBYeXJ1TTVXbG1WaEV2c2R1?=
 =?utf-8?B?Q3VrRU9EaDkrQStqaHRxaHBnc1dUVzd6YWJOaS95Q3FKZUN4SUVVYmhBWmJU?=
 =?utf-8?B?a1ZUeXFZSkRha3RhNHJ6RXJQTFZ5TVhsOHZOS2JOWWVFYno1OTNqTmZXZEdB?=
 =?utf-8?B?L0hOM2hoT0ZCdGtEbzZhZnF5Z2w5b3FsT2hPdXpkVGJwYWJ3YitXZWV3Qk8w?=
 =?utf-8?B?ZUVqbW9aYi9DRmtOTER1NGM2NlNaMjFPUmg5NzBseGl3dzFRMU5JYnNISHVU?=
 =?utf-8?B?M1pYZm1nVGpuUTdROHgzSmJRY0R4eXp4WUFhRnp1cGY2MDE1R3BTUUZEbVBj?=
 =?utf-8?B?dnhTc0J3OVdYVkdDWDJOODVzTkk2d3ZNQkdheTNnWUhTTzlyYVkrTVJoc0JK?=
 =?utf-8?B?M2dkK0NaZElZdnVnT2NsMW9UVjVORUloTWQweVlJZnpUQlNuR2JGWk1scWYr?=
 =?utf-8?B?ZzJNU05PTTVHMlBabUVPU1dRNklwaHBxMzA3UnhQckFGYkF2NnMyZE1vRVJS?=
 =?utf-8?B?cUhscWtBeVM0K3M3ZVpmWWxMa25mTWtzNlQ4UGowWEhmRU0rYzRMWUwrT0hx?=
 =?utf-8?B?V0w3YXE0b2xOalVDR3M5aExIMXA3YWZhN0YrY01JZU83MjdpdElVY2xQZ1VY?=
 =?utf-8?B?bkhWa0RGY29TSEc2dHQydmQ2V2x4eXp3dTZWSFRwUkpMdGQ0bGhrQjhlWnpm?=
 =?utf-8?B?ZUVjTGJxZWl5OTVpSGJTamRyQ0tDUHZVeEVKa0VyVEw0czZjU0Z2NlZ1NVJD?=
 =?utf-8?B?SWxRWEtzZFIwQnBpQzZMY2Y5Mlhmd3UraHVsVVZ4MUlmUDZtVEp2UWsxOC9Q?=
 =?utf-8?B?RlQ5ekVhYjR4QTdiSEE0Tjh2aDNTSDQrY1VtWHM3R1R0M0NFYUpSaDZTYzVB?=
 =?utf-8?B?ajFxclE5MHpXanJiMUVaMG5rQ3djK3E4Tnd2UVVySVZURmxmTnRJM252Tk5R?=
 =?utf-8?B?Qm5IbEJuWWIySmhYc3NONDFCeXJQbDFWUXYrNGNaWFBucjNLdlcycE9WR3lr?=
 =?utf-8?B?MHRqSGJnYlJ5citQNit6UTNpcUxQdHJTV2ptNjFxaHE1c3daR1hJRmQ3Vy9t?=
 =?utf-8?B?ejRHZkYzWHA0Z2hLNm9pSUVib3p2MVBxTUFhSkZadHoyczdyRXcvanVBRVNZ?=
 =?utf-8?B?U1B4NmtJK1V5ejliTGM0WWhCdjNvRThzcWdrK1NlM2JNUU9aWG5oN1FJd1lV?=
 =?utf-8?B?RlpJWlh1cUFqWHFwL2VPVlQ3b1ZnUkc0Rk5ONzZqTytjL3hnK3IrOTYyUVJw?=
 =?utf-8?B?UW4rM0VuL1VmdldqVk82eFUzeHAvTzIraktGV3g2Q2MvTlRnRFd1Y2lKcXZo?=
 =?utf-8?B?NDQwdVZjSGVoenFMWjVJekJMQlNCSGREODRvWGR4dmZGTWp3VUJ1WU4xQXFV?=
 =?utf-8?B?b2lRZ2crRHdYSi9WbTBORG9ibk5NUnd1NVIwNGJPcTc0TEgxSjh2UkUyS2dZ?=
 =?utf-8?B?TUhHUWxHMkgzZ1ltdWpvbzFoRzBxSG5pTUVjNkFPelk0TDhFWitRd2MweENR?=
 =?utf-8?B?Zi9pcFRGNGYrdVRrSDd4KzlJTkpMcWR0czI2ci8wTDltVnRSMDJOcUFQZmhk?=
 =?utf-8?B?bEhVVUZ1dGVsTWVDdzR2b2IzaG1kTXNTY1pDQnNNc1I0ZjRqanNzU21GK1ZQ?=
 =?utf-8?B?YmNzenZEZ0lsR1BMMnJ2OTlpbmRUallRWS9lK25kejlCZTN2VGlJdDRwc3BQ?=
 =?utf-8?B?bWs1NE9ueEJEMzQzb3o3YitTUHFrTFdjWFRxNm1uNHJncGpVVlZubFZFT0t6?=
 =?utf-8?B?d3FIM0duWkltUHVWU2UvZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED79ACCB47CA1842990B9CA3C5F2FDB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acb6c2b-f2c1-430b-74f4-08d989ef743d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 00:06:18.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQ20PEcZrJ6PElKHlbLVb5ZvHL2ZWBVy3dtDhKPmVYI/S+HqEO+BiCoLvd60ifO81wcDaA/qtbCnFpCdipYuWVBO12ttK87XJrG+l2WOOtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5651
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTA3IGF0IDE2OjIzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAwNiwgMjAyMSBhdCAwOToyNzo0OVBNICswMDAwLCBLZWx2aW4uQ2FvQG1p
Y3JvY2hpcC5jb20NCj4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIxLTEwLTA2IGF0IDE1OjIwIC0w
NTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBPY3QgMDYsIDIwMjEgYXQg
MDc6MDA6NTVQTSArMDAwMCwgDQo+ID4gPiBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5jb20NCj4gPiA+
IHdyb3RlOg0KPiA+ID4gU28gd2FpdCwgeW91IG1lYW4geW91IGp1c3QgaW50ZW50aW9uYWxseSBh
c2sgdGhlIGZpcm13YXJlIHRvDQo+ID4gPiByZXNldCwga25vd2luZyB0aGF0IHRoZSBkZXZpY2Ug
d2lsbCBiZSB1bnVzYWJsZSB1bnRpbCB0aGUgdXNlcg0KPiA+ID4gcmVib290cyBvciBkb2VzIGEg
bWFudWFsIHJlc2Nhbj8gIEFuZCB0aGUgd2F5IHRvIGltcHJvdmUgdGhpcyBpcw0KPiA+ID4gZm9y
IHRoZSBkcml2ZXIgdG8gcmVwb3J0IGFuIGVycm9yIHRvIHRoZSB1c2VyIGluc3RlYWQgb2YgaGFu
Z2luZz8NCj4gPiA+IEkgKmd1ZXNzKiB0aGF0IG1pZ2h0IGJlIHNvbWUgc29ydCBvZiBpbXByb3Zl
bWVudCwgYnV0IHNlZW1zIGxpa2UNCj4gPiA+IGENCj4gPiA+IHByZXR0eSBzbWFsbCBvbmUuDQo+
ID4gDQo+ID4gWWVzLCBob3dldmVyLCBJIGJlbGlldmUgaXQncyBzb21ldGhpbmcgb3VyIHVzZXJz
IHJlYWxseSBsaWtlIHRvDQo+ID4gaGF2ZS4uLiAgV2l0aCB0aGlzLCB0aGV5IGNhbiBkbyB0aGVp
ciB1c2VyIHNwYWNlDQo+ID4gcHJvZ3JhbW1pbmcvc2NyaXB0aW5nIG1vcmUgZWFzaWx5IGluIGEg
c3luY2hyb25vdXMgZmFzaGlvbi4NCj4gPiANCj4gPiA+ID4gICAtIFRoZSBmaXJ3bWFyZSBjcmFz
aGVzIGFuZCBkb2Vzbid0IHJlc3BvbmQsIHdoaWNoIG5vcm1hbGx5IGlzDQo+ID4gPiA+ICAgdGhl
IHJlYXNvbiBmb3IgdXNlcnMgdG8gaXNzdWUgYSBmaXJtd2FyZSByZXNldCBjb21tYW5kIHRvIHRy
eQ0KPiA+ID4gPiAgIHRvIHJlY292ZXIgaXQgdmlhIGVpdGhlciB0aGUgZHJpdmVyIG9yIGEgc2lk
ZWJhbmQgaW50ZXJmYWNlLg0KPiA+ID4gPiAgIFRoZSBmaXJtd2FyZSBtYXkgbm90IGJlIGFibGUg
dG8gcmVjb3ZlciBieSBhIHJlc2V0IGluIHNvbWUNCj4gPiA+ID4gICBleHRyZWFtIHNpdHVhdGlv
bnMgbGlrZSBoYXJkd2FyZSBlcnJvcnMsIHNvIHRoYXQgYW4gZXJyb3INCj4gPiA+ID4gICByZXR1
cm4gaXMgcHJvYmFibHkgYWxsIHRoZSB1c2VycyBjYW4gZ2V0IGJlZm9yZSBhbm90aGVyIGxldmVs
DQo+ID4gPiA+ICAgb2YgcmVjb3ZlcnkgaGFwcGVucy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNvIEkn
ZCB0aGluayB0aGlzIHBhdGNoIGlzIHN0aWxsIG1ha2luZyB0aGUgZHJpdmVyIGJldHRlciBpbg0K
PiA+ID4gPiBzb21lIHdheS4NCj4gDQo+IE9LLiAgSSBzdGlsbCB0aGluayB0aGUgZmFjdCB0aGF0
IGFsbCB0aGVzZSBkaWZmZXJlbnQgbWVjaGFuaXNtcyBjYW4NCj4gcmVzZXQgdGhlIGRldmljZSBi
ZWhpbmQgeW91ciBiYWNrIGFuZCBtYWtlIHRoZSBzd2l0Y2ggYW5kIGFueXRoaW5nIG9uDQo+IHRo
ZSBvdGhlciBzaWRlIG9mIGl0IGp1c3Qgc3RvcCB3b3JraW5nIGlzIC4uLiwgd2VsbCwgbGV0J3Mg
anVzdCBzYXkNCj4gaXQncyBxdWl0ZSBzdXJwcmlzaW5nIHRvIG1lLg0KDQpBY3R1YWxseSB0aGVy
ZSdyZSBtZWNoYW5pc21zIGxpa2UgcGVybWlzc2lvbiBjb250cm9sIHRvIGxpbWl0IHdoYXQNCnBl
b3BsZSBjYW4gZG8gaW4gdGhlIGZpcm13YXJlLCBzbyBJIGd1ZXNzIGl0J3Mgbm90IGFzIGJhZCBh
cyBpdCBzb3VuZHMNCmxpa2UuIA0KPiANCj4gV2VsbCwgYXQgbGVhc3QgdGhpcyBpc24ndCBxdWl0
ZSBzbyBtdWNoIGEgbXlzdGVyeSBhbnltb3JlIGFuZCBtYXliZQ0KPiB3ZQ0KPiBjYW4gaW1wcm92
ZSB0aGUgY29tbWl0IGxvZy4gIEUuZy4sIG1heWJlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0K
PiAgIEEgZmlybXdhcmUgaGFyZCByZXNldCBtYXkgYmUgaW5pdGlhdGVkIGJ5IHZhcmlvdXMgbWVj
aGFuaXNtcw0KPiAgIGluY2x1ZGluZyBhIFVBUlQgaW50ZXJmYWNlLCBUV0kgc2lkZWJhbmQgaW50
ZXJmYWNlIGZyb20gQk1DLCBNUlBDDQo+ICAgY29tbWFuZCBmcm9tIHVzZXJzcGFjZSwgZXRjLiAg
VGhlIHN3aXRjaHRlYyBtYW5hZ2VtZW50IGRyaXZlciBpcw0KPiAgIHVuYXdhcmUgb2YgdGhlc2Ug
cmVzZXRzLg0KPiANCj4gICBUaGUgcmVzZXQgY2xlYXJzIFBDSSBzdGF0ZSBpbmNsdWRpbmcgdGhl
IEJBUnMgYW5kIE1lbW9yeSBTcGFjZQ0KPiAgIEVuYWJsZSBiaXRzLCBzbyB0aGUgZGV2aWNlIG5v
IGxvbmdlciByZXNwb25kcyB0byB0aGUgTU1JTyBhY2Nlc3Nlcw0KPiAgIHRoZSBkcml2ZXIgdXNl
cyB0byBvcGVyYXRlIGl0Lg0KPiANCj4gICBNTUlPIHJlYWRzIHRvIHRoZSBkZXZpY2Ugd2lsbCBm
YWlsIHdpdGggYSBQQ0llIGVycm9yLiAgV2hlbiB0aGUNCj4gcm9vdA0KPiAgIGNvbXBsZXggaGFu
ZGxlcyB0aGF0IGVycm9yLCBpdCB0eXBpY2FsbHkgZmFicmljYXRlcyB+MCBkYXRhIHRvDQo+ICAg
Y29tcGxldGUgdGhlIENQVSByZWFkLg0KPiANCj4gICBDaGVjayBmb3IgdGhpcyBzb3J0IG9mIGVy
cm9yIGJ5IHJlYWRpbmcgdGhlIGRldmljZSBJRCBmcm9tIE1NSU8NCj4gICBzcGFjZS4gIFRoaXMg
SUQgY2FuIG5ldmVyIGJlIH4wLCBzbyBpZiB3ZSBzZWUgdGhhdCB2YWx1ZSwgaXQNCj4gICBwcm9i
YWJseSBtZWFucyB0aGUgUENJZSBNZW1vcnkgUmVhZCBmYWlsZWQgYW5kIHdlIHNob3VsZCByZXR1
cm4gYW4NCj4gICBlcnJvciBpbmRpY2F0aW9uIHRvIHRoZSBhcHBsaWNhdGlvbiB1c2luZyB0aGUg
c3dpdGNodGVjIGRyaXZlci4NCg0KSXQgbG9va3MgZ29vZCB0byBtZSwgdGhlIGNvbW1pdCBsb2cg
cmVtb3ZlcyB0aGUgYW1iaWd1aXR5LiBMZXQgbWUga25vdw0KaWYgeW91IHByZWZlciBhIHYyIHBh
dGNoc2V0IHdpdGggdGhlIHVwZGF0ZWQgY29tbWl0IGxvZyBhbmQgbmFtaW5nDQppc3N1ZSBmaXgu
DQoNClRoYW5rIHlvdSBCam9ybiBmb3IgeW91ciBwYXRpZW5jZSBhbmQgdGltZSEgDQoNCktlbHZp
bg0K
