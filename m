Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98D4100965
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfKRQoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 11:44:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRQoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 11:44:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so9912475pgn.0;
        Mon, 18 Nov 2019 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=sPTnvw1WbYRhIrGpavVrRzdbbEWRjFd3Ff2Gm/eZo5k=;
        b=cByUOsmP1SEnE1mLONIddYTUSV9TXSCY5W8BnLVx1RRSMMXThPuMpaZ+cDoWUSM4MC
         ldnZBJMQNH+jDAdF69rqMCGcnOZLSfjbZ1X02nzJ0HWDa1ZGzsDjoB//V07+zVLfjh14
         XblrV8MCwcrkd3Oeq9gpG/rhiycO2Mk8OJH+hU5Ph5g+RZDoK+af6NVG9EbOEZI073r6
         IZKsYyRH3RgKgsfo+RmCWxiwsVi/5+WBnzdiOPERTvzjra9myRK3y1t9puV5Ews4vGsx
         Y+so2+7IIehQEUKVDLYM4PuPJ3g/W3REIROu5TsFm+yx5xBdP3E0NzCDsUaQOF8BeTbU
         irdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=sPTnvw1WbYRhIrGpavVrRzdbbEWRjFd3Ff2Gm/eZo5k=;
        b=jUaXuulbK8iGuwOlNpPtxJI7w8yFsvsXc4FijEZOhfUMqh5UaetE1OP2rsPi8WiYup
         3rYHT3ZqLKPXAOPLv+8+EDzjGaX32/AzZt2ZBaULMunj0Ze6Bq1wNObkQlEdrO4TaMUk
         cOu8u2HeTiHQiGz24ynbYINlT17S9pleW0/LB46qtIPJdgMdkgYaq6QR8w92K8iGsr7m
         bzeB/aa495StDzztNXFRFfgOF8EJv0u3qGiAt36Fzd8olhL5K5tWubv655Gc8RX8LiOR
         I7JzoyGBczoy4EyeBuwsheGrUnDv/r3hJR+jXMJQ2uBl0pCdSpK/98/XVJZL139uP+N3
         oP6Q==
X-Gm-Message-State: APjAAAX3L/se+gkda3U0IIJjVeta8YNs67r/78JbH5rxSja3s8r/hozM
        vqNepguigFMa1RQgYRNVhgsX2hlw
X-Google-Smtp-Source: APXvYqwPKNXjpmt3ah6ZXo6KaiIuLQRgHioiTTibjNm2Y8kmvyAJ+Zu1JQJfvH7mVMhI5xw4n7ta9g==
X-Received: by 2002:aa7:9639:: with SMTP id r25mr205028pfg.17.1574095444542;
        Mon, 18 Nov 2019 08:44:04 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id s66sm24927564pfb.38.2019.11.18.08.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:44:03 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 0/4] Add support to defer core initialization
Thread-Topic: [PATCH 0/4] Add support to defer core initialization
Thread-Index: AXN2NDEwt0jI2UK4iL+vyiA0RDB5BTBhZDUywszrN0c=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Mon, 18 Nov 2019 16:43:58 +0000
Message-ID: <SL2P216MB0105D49E39194C827D60B032AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <108c9f42-a595-515e-5ed6-e745a55efe70@nvidia.com>
In-Reply-To: <108c9f42-a595-515e-5ed6-e745a55efe70@nvidia.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCu+7v09uIDExLzE4LzE5LCAxOjU1IEFNLCBWaWR5YSBTYWdhciB3cm90ZToNCj4gDQo+IE9u
IDExLzEzLzIwMTkgMjozOCBQTSwgVmlkeWEgU2FnYXIgd3JvdGU6DQo+ID4gRVBDL0Rlc2lnbldh
cmUgY29yZSBlbmRwb2ludCBzdWJzeXN0ZW1zIGFzc3VtZSB0aGF0IHRoZSBjb3JlIHJlZ2lzdGVy
cyBhcmUNCj4gPiBhdmFpbGFibGUgYWx3YXlzIGZvciBTVyB0byBpbml0aWFsaXplLiBCdXQsIHRo
YXQgbWF5IG5vdCBiZSB0aGUgY2FzZSBhbHdheXMuDQo+ID4gRm9yIGV4YW1wbGUsIFRlZ3JhMTk0
IGhhcmR3YXJlIGhhcyB0aGUgY29yZSBydW5uaW5nIG9uIGEgY2xvY2sgdGhhdCBpcyBkZXJpdmVk
DQo+ID4gZnJvbSByZWZlcmVuY2UgY2xvY2sgdGhhdCBpcyBjb21pbmcgaW50byB0aGUgZW5kcG9p
bnQgc3lzdGVtIGZyb20gaG9zdC4NCj4gPiBIZW5jZSBjb3JlIGlzIG1hZGUgYXZhaWxhYmxlIGFz
eW5jaHJvbm91c2x5IGJhc2VkIG9uIHdoZW4gaG9zdCBzeXN0ZW0gaXMgZ29pbmcNCj4gPiBmb3Ig
ZW51bWVyYXRpb24gb2YgZGV2aWNlcy4gVG8gYWNjb21tb2RhdGUgdGhpcyBraW5kIG9mIGhhcmR3
YXJlcywgc3VwcG9ydCBpcw0KPiA+IHJlcXVpcmVkIHRvIGRlZmVyIHRoZSBjb3JlIGluaXRpYWxp
emF0aW9uIHVudGlsIHRoZSByZXNwZWN0aXZlIHBsYXRmb3JtIGRyaXZlcg0KPiA+IGluZm9ybXMg
dGhlIEVQQy9EV0MgZW5kcG9pbnQgc3ViLXN5c3RlbXMgdGhhdCB0aGUgY29yZSBpcyBpbmRlZWQg
YXZhaWxhYmxlIGZvcg0KPiA+IGluaXRpYWl6YXRpb24uIFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGF0
dGVtcHRpbmcgdG8gYWRkIHByZWNpc2VseSB0aGF0Lg0KPiA+IFRoaXMgc2VyaWVzIGlzIGJhc2Vk
IG9uIEtpc2hvbidzIHBhdGNoIHRoYXQgYWRkcyBub3RpZmljYXRpb24gbWVjaGFuaXNtDQo+ID4g
c3VwcG9ydCBmcm9tIEVQQyB0byBFUEYgQCBodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0
Y2gvMTEwOTg4NC8NCj4gPiANCj4gPiBWaWR5YSBTYWdhciAoNCk6DQo+ID4gICAgUENJOiBkd2M6
IEFkZCBuZXcgZmVhdHVyZSB0byBza2lwIGNvcmUgaW5pdGlhbGl6YXRpb24NCj4gPiAgICBQQ0k6
IGVuZHBvaW50OiBBZGQgbm90aWZpY2F0aW9uIGZvciBjb3JlIGluaXQgY29tcGxldGlvbg0KPiA+
ICAgIFBDSTogZHdjOiBBZGQgQVBJIHRvIG5vdGlmeSBjb3JlIGluaXRpYWxpemF0aW9uIGNvbXBs
ZXRpb24NCj4gPiAgICBQQ0k6IHBjaS1lcGYtdGVzdDogQWRkIHN1cHBvcnQgdG8gZGVmZXIgY29y
ZSBpbml0aWFsaXphdGlvbg0KPiA+IA0KPiA+ICAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUtZXAuYyAgIHwgIDc5ICsrKysrKystLS0tLQ0KPiA+ICAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggIHwgIDExICsrDQo+ID4gICBkcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi10ZXN0LmMgfCAxMTQgKysrKysrKysrKysr
LS0tLS0tDQo+ID4gICBkcml2ZXJzL3BjaS9lbmRwb2ludC9wY2ktZXBjLWNvcmUuYyAgICAgICAg
ICAgfCAgMTkgKystDQo+ID4gICBpbmNsdWRlL2xpbnV4L3BjaS1lcGMuaCAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9wY2ktZXBmLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgICA1ICsNCj4gPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTY0IGluc2VydGlv
bnMoKyksIDY2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPg0KPiBIaSBLaXNob24gLyBHdXN0YXZvIC8g
SmluZ29vLA0KPiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoaXMgcGF0Y2ggc2Vy
aWVzPw0KDQpZb3UgbmVlZCBhIEFjayBmcm9tIEtpc2hvbiwgYmVjYXVzZSBoZSBtYWRlIEVQIGNv
ZGUuDQoNCg0KPiAtIFZpZHlhIFNhZ2FyDQo=
