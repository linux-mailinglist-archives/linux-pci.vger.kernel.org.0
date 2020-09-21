Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA4272C56
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIUQbd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 12:31:33 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:27394
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728074AbgIUQbc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 12:31:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxdGqWUTxwcLBcxse7gw07dfuasiy8NgFESAtRoHjHKjhJQP8M8sVE8XCx0ReVtBYCdcxFueNRL93t1rYAUcFx9Abd7QnMfdbeu0BfyYAHLf730fvM2HOo4Mpk+XjbNnNpVGDk3noXi8zZKMYn2Wk1hdrkF6tH+N4BMx5blnt8Mfh1TOwUGDlrtm2tCoEIBJJgt89a0ivxgPZOtaRFgDoBM6A7NjfyODNVnlB7Przx0AsJ74aFeiXQ5M/O0l4Qw0374krZXrgkgfbV80OIV/3cjRFANHwKyRuRd/hFpws5y9bXomVGnoz9tZ/ASmim2nMWULazeK04fMIC0HiqpTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGISP1jZow5lXLiM2fiBkNFmu9nHsM23OWr+LhDpc9w=;
 b=lUklVFae4SbXbbMu5C4eoGkbuJtVOvuj0VnM77NlFn/bP6P+0H3oAYMor62xE46+CHbx8cDQSDem46qjm1QY+7OqjkIQg9lhdiSSHfRFjM9yAHoqR3Ggb7DHqZqiNAcwqxStETRLeSxW8UW54iroTTxKIyv05v3aA3SDSDR9FPQdvkUfwqfFSog9sxWWnqFim2EAx60nbOqMLwgsRCANGye064q0nmiITy1pEWxKyWjHNBoiYkSgo87pk9OdEumqr0/6ipALdbH4aCvrk9fvoN/DOn089xMUlMw7kpqSxEpLC7myoBHkPD9y5dT42eQB27j23zxsXvWcJRMjXk87iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGISP1jZow5lXLiM2fiBkNFmu9nHsM23OWr+LhDpc9w=;
 b=gTyNcgaUyxW6X0/xBAHaaBU5GabI+uv/0kcRAm0xdt9EfNBkDScs1w5GS0XVr95/wCPG5SzIZwyifuMLf7+0WGYm7arScbTHi+kur4zbs18a1wrlgX8Q8GTRlyuLvNLrfJlZLL8CZx/eFwaz3WDfEzHGa1ry26uWIUVFIHNQpLs=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.21; Mon, 21 Sep
 2020 16:31:27 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 16:31:27 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: RE: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Topic: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Thread-Index: AQHWi+0seUdQCD5Vd0CU4riR8OTpR6lruCmAgAJdkFCAAEYSAIAE2Hkg
Date:   Mon, 21 Sep 2020 16:31:27 +0000
Message-ID: <HE1PR0402MB33712A16B4A894BE6CD4D3A9843A0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200918124710.GA1800067@bjorn-Precision-5520>
In-Reply-To: <20200918124710.GA1800067@bjorn-Precision-5520>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89950ac1-ccc4-49ce-f5fb-08d85e4bca01
x-ms-traffictypediagnostic: HE1PR0402MB3369:
x-microsoft-antispam-prvs: <HE1PR0402MB33697EC19C7F26C24357B36A843A0@HE1PR0402MB3369.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYIlkhWU33zyUoVb4KdJnv/dCU92JVs1lyrn/PjaRxWjdf9Fx9qV1D9P8oUw6Xv1Ft0ZcxzD7ZXewXZ7P5CglJOkAu+oO7UC+ZWBv6HK5vrp7hh3DTNG5a2ZbbMgnFB1QDpXE4e79gUa0F8aNCqB960yB3smxlfUcECiQYz0TQgjFyiPPSPvjcR9rAs/cfVEyyRqUqsQi3ZmoBpEJ9sWNJjOGa84bRKfn3jD/nJI/iLbdj/1S7wr+jaGJofXwjC28ilABMM/W6EHmtAuSa0cZdii3BJseNg0QG1WrTxUPmHOYkQDp1F5GhC+aKrL5cpb/pHCufEW/Tzxoinrpi1aUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(478600001)(7696005)(53546011)(186003)(33656002)(6506007)(4326008)(8936002)(8676002)(2906002)(83380400001)(54906003)(316002)(66946007)(66556008)(66476007)(64756008)(66446008)(76116006)(52536014)(71200400001)(9686003)(26005)(55016002)(5660300002)(86362001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nbDb47veCPkaf8GnxiTt4AVOKd39moiW9FLyOcstRJkCOIO7AHxbba7zh3trdDYcVGcIyVeXOQ97/FIUU0z69bpNtfa15NNtxTgmyWEWv5KGOmyRhWrIUAhN2jQh4Vfd+w7YM0zRhVhrSa1OoiWqwcwv4K3JfK5keP0CKvUsvqcRMzadZ0O6nxh1xevaFXmdvo5f+bomQceU9hhrsFTP10vQYIduXc24piPcsO9UyvPeiZMVCDqLpkekD0qX6JLlx0owVM4epY+1pds1NrYooNASXACDzVqc2iYr7XgdOLsyJmTSm9Ryut18qVfD5ia1F/bsqeaBj9zZBmikMbceB4P76y0kNxLIBJl0MOzJjC1ice+FjOylDLbvS4ojMYY9xP9L8FoEjmaHrXYzQZGRhiZ/ysMFKwLVtlVovYUg7LZfOrD+sMYPZvF5SsjbSX6v8gJj9LFgrYsW83OO/pZNJl9FvVU1lWRFQiSAeMTRXwfmqlYHRmVdcfYaCm1TFPHMfiBJWq9cOCxbV+8eTm28bL+mkeu+EQTzlwnefOwiHMwME64qkFyqsTUqa4bDQ6mxSn0QJOLyWzZ/BGQNfxENvGfBjiziJE2M96tpgZ4mfGvcp/lmmW9YEaqPQPjkudWuytv9/OP8a5/ix1t5z7j4tg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89950ac1-ccc4-49ce-f5fb-08d85e4bca01
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 16:31:27.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DcIFM0fgEgRLJOXQmY0SApEZJ54hK5tb41zeoJEkvrW8mQsxwCVoXdXQI0dO2yBm+wZUFJ7qgZhqq385g9+VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jnUwjE4yNUgMjA6NDcNCj4gVG86IFoucS4gSG91IDx6aGlx
aWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQQ0kNCj4gPGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47DQo+
IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBHdXN0YXZvIFBpbWVudGVsDQo+
IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxA
d2FsbGUuY2M+Ow0KPiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBQQ0k6IGR3YzogQWRkZWQgbGluayB1cCBjaGVjayBpbiBtYXBfYnVzIG9m
DQo+IGR3X2NoaWxkX3BjaWVfb3BzDQo+IA0KPiBPbiBGcmksIFNlcCAxOCwgMjAyMCBhdCAxMTow
MjowN0FNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gDQo+ID4gQnV0IG5vdyB0aGUgU0Vycm9y
IGlzIGV4YWN0bHkgY2F1c2VkIGJ5IHRoZSBmaXJzdCBhY2Nlc3Mgb2YgdGhlDQo+ID4gbm9uLWV4
aXN0ZW50IGZ1bmN0aW9uLCBJIGR1ZyBpbnRvIHRoZSBrZXJuZWwgZW51bWVyYXRpb24gY29kZSBh
bmQNCj4gPiBmb3VuZCBpdCB3aWxsIGZpcmUgYSA0Qnl0ZSBDRkcgcmVhZCB0cmFuc2FjdGlvbiB0
byByZWFkIHRoZSBWZW5kb3IgSUQNCj4gPiBhbmQgRGV2aWNlIElEIHRvZ2V0aGVyLCBzbyBJIHN1
c3BlY3QgdGhlIHJvb3QgY2F1c2UgaXMgYWNjZXNzIHRoZQ0KPiA+IERldmljZSBJRCBvZiBhIG5v
bi1leGlzdGVudCBmdW5jdGlvbiB0cmlnZ2VycyBTRXJyb3IuDQo+ID4NCj4gPiBTbyB0aGUgYWx0
ZXJuYXRpdmUgc29sdXRpb24gc2VlbXMgdG8gY29ycmVjdCB0aGUgUENJZSBlbnVtZXJhdGlvbiwg
SQ0KPiA+IHdpbGwgc3VibWl0IGEgcGF0Y2ggdG8gbGV0IHRoZSBmaXJzdCBhY2Nlc3Mgb25seSBy
ZWFkIHRoZSBWZW5kb3IgSUQuDQo+IA0KPiBJZiBpdCBpcyBpbmNvcnJlY3QgZm9yIHRoZSBmaXJz
dCBhY2Nlc3MgdG8gYmUgYSAzMi1iaXQgcmVhZCBvZiBib3RoIHRoZSBWZW5kb3INCj4gYW5kIHRo
ZSBEZXZpY2UgSUQsIHBsZWFzZSBjaXRlIHRoZSByZWxldmFudCBzZWN0aW9uIG9mIHRoZSBzcGVj
IGluIHlvdXIgcGF0Y2guDQo+IA0KPiBJIGRvbid0IGxpa2UgdG8gbWFrZSBjaGFuZ2VzIHRvIGdl
bmVyaWMgY29kZSB0byBhY2NvbW1vZGF0ZSBzcGVjaWZpYyBwaWVjZXMNCj4gb2YgaGFyZHdhcmUg
YmVjYXVzZSB0aGVuIHdlIHJlc3RyaWN0IGZ1dHVyZSBjaGFuZ2VzIGJhc2VkIG9uIHNvbWUgZGV2
aWNlDQo+IHRoYXQgd2lsbCBzb29uIGJlIG9ic29sZXRlIGFuZCBmb3Jnb3R0ZW4uDQo+IA0KPiBJ
J20gcHJldHR5IHN1cmUgdGhlIHNwZWMgbGFuZ3VhZ2UgYWJvdXQgQ1JTIGhhbmRsaW5nIGlzIGNh
cmVmdWwgdG8gdGFsayBhYm91dA0KPiAicmVhZHMgdGhhdCAqaW5jbHVkZSogVmVuZG9yIElEIiwg
bm90IGp1c3QgInJlYWRzIG9mIFZlbmRvciBJRCIsIHNvIHRoZQ0KPiBpbXBsaWNhdGlvbiBpcyB0
aGF0IGl0IGNvdmVycyAzMi1iaXQgcmVhZHMgYXMgd2VsbCBhcyAxNi1iaXQgcmVhZHMuDQo+IA0K
DQpZZXMsIEkgYWdyZWUgd2l0aCB5b3UgdGhhdCB3ZSBtdXN0IGJlIGNhcmZ1bCB3aXRoIHRoZSBn
ZW5lcmljIGNvZGUuDQpOWFAgTGF5ZXJzY2FwZSBTRXJyb3IgYXNpZGUsIGl0IHR1cm5zIG91dCB0
byBiZSBtb3JlIGNvbXBsZXgsIGxpbWl0aW5nIHRoZSBmaXJzdCBDRkcgYWNjZXNzIHRvIDE2LWJp
dCBWZW5kb3IgSUQgYWxzbyBjYXVzZXMgU0Vycm9yLCB0aGUgaGFyZHdhcmUgYmVoYXZpb3Igc2Vl
bXMgbm90IHRoZSBzYW1lIGFzIHRoZSBkZXNjcmliZWQgb2YgdGhlIHJlZ2lzdGVyIFBDSUVfQUJT
RVJSLg0KDQpGb3IgdGhlIFBDSWUgZW51bWVyYXRpb24sIEkgZm91bmQgdGhlIGRlc2NyaXB0aW9u
cyBvZiBWZW5kb3IgSUQgYW5kIERldmljZSBJRCBpbiB0aGUgUENJIEV4cHJlc3MgQmFzZSBTcGVj
aWZpY2F0aW9uLCBSZXYuIDQuMCBWZXJzaW9uIDEuMCAocGFzdGVkIGJlbG93KSwgaXQgcmVjb21t
ZW5kcyB0byByZWFkIFZlbmRvciBJRCB0byBkZXRlcm1pbmUgdGhlIHByZXNlbnRlbmNlIG9mIGEg
ZnVuY3Rpb24gYW5kIHVzZSB0aGUgRGV2aWNlIElEICh3aXRoIFZlbmRvciBJRCBhbmQgUmV2aXNp
b24gSUQpIHRvIGRldGVybWluZSB0aGUgZHJpdmVyIG5lZWRlZC4gQnV0IGluIHNlY3Rpb24gMi4z
LjIgQ29tcGxldGlvbiBIYW5kbGluZyBSdWxlcywgaXQgc2VlbXMsIGFzIHlvdSBzYWlkLCBub3Qg
bGltaXQgdG8gMTYtYml0IFZlbmRvciBJRCwgc28gSSB3YW50IHRvIGhlYXIgeW91ciBhbmQgUm9i
J3Mgc3VnZ2VzdGlvbiBvbiB0aGlzIGNoYW5nZS4gDQoNCjcuNS4xLjEuMSBWZW5kb3IgSUQgUmVn
aXN0ZXIgKE9mZnNldCAwMGgpDQpUaGUgVmVuZG9yIElEIHJlZ2lzdGVyIGlzIEh3SW5pdCBhbmQg
dGhlIHZhbHVlIGluIHRoaXMgcmVnaXN0ZXIgaWRlbnRpZmllcyB0aGUgbWFudWZhY3R1cmVyIG9m
IHRoZQ0KRnVuY3Rpb24uIEluIGtlZXBpbmcgd2l0aCBQQ0ktU0lHIHByb2NlZHVyZXMsIHZhbGlk
IHZlbmRvciBpZGVudGlmaWVycyBtdXN0IGJlIGFsbG9jYXRlZCBieSB0aGUNClBDSS1TSUcgdG8g
ZW5zdXJlIHVuaXF1ZW5lc3MuIEVhY2ggdmVuZG9yIG11c3QgaGF2ZSBhdCBsZWFzdCBvbmUgVmVu
ZG9yIElELiBJdCBpcyByZWNvbW1lbmRlZA0KdGhhdCBzb2Z0d2FyZSByZWFkIHRoZSBWZW5kb3Ig
SUQgcmVnaXN0ZXIgdG8gZGV0ZXJtaW5lIGlmIGEgRnVuY3Rpb24gaXMgcHJlc2VudCwgd2hlcmUg
YSB2YWx1ZSBvZg0KRkZGRmggaW5kaWNhdGVzIHRoYXQgbm8gRnVuY3Rpb24gaXMgcHJlc2VudC4N
CjcuNS4xLjEuMiBEZXZpY2UgSUQgUmVnaXN0ZXIgKE9mZnNldCAwMmgpDQpUaGUgRGV2aWNlIElE
IHJlZ2lzdGVyIGlzIEh3SW5pdCBhbmQgdGhlIHZhbHVlIGluIHRoaXMgcmVnaXN0ZXIgaWRlbnRp
ZmllcyB0aGUgcGFydGljdWxhciBGdW5jdGlvbi4NClRoZSBEZXZpY2UgSUQgbXVzdCBiZSBhbGxv
Y2F0ZWQgYnkgdGhlIHZlbmRvci4gVGhlIERldmljZSBJRCwgaW4gY29uanVuY3Rpb24gd2l0aCB0
aGUgVmVuZG9yIElEDQphbmQgUmV2aXNpb24gSUQsIGFyZSB1c2VkIGFzIG9uZSBtZWNoYW5pc20g
Zm9yIHNvZnR3YXJlIHRvIGRldGVybWluZSB3aGljaCBkcml2ZXIgc2hvdWxkIGJlDQpsb2FkZWQu
IFRoZSB2ZW5kb3IgbXVzdCBlbnN1cmUgdGhhdCB0aGUgY2hvc2VuIHZhbHVlcyBkbyBub3QgcmVz
dWx0IGluIHRoZSB1c2Ugb2YgYW4gaW5jb21wYXRpYmxlDQpkZXZpY2UgZHJpdmVyLg0KDQpSZWdh
cmRzLA0KWmhpcWlhbmcNCg0KPiBCam9ybg0K
