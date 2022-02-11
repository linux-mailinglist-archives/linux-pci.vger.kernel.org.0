Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DED4B1B3F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 02:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbiBKB3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 20:29:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbiBKB27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 20:28:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6A5582;
        Thu, 10 Feb 2022 17:28:56 -0800 (PST)
X-UUID: a6ec2389a58f4263b294b95e622561b2-20220211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=Lg5kOnGNKSvapUQuB5naaWkxSQNNEeSxqgnbrqpvqTM=;
        b=AerbYxR7urkNPtKvleQipflkgkxmtw0ND9E/w7BXkaPXo/7cYb1ExtUA3TVrq0sWpoiEsKq/L4Oyc4DzDl1iuHQXRJ58HVHva2H1wwknidI+66kckSIScu83j6e3Sh1xuR4Wd6Ljj6hn2QkVGvmAFRhJ6MivqJZ4rPfETxNBMhM=;
X-UUID: a6ec2389a58f4263b294b95e622561b2-20220211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1085269837; Fri, 11 Feb 2022 09:28:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Feb 2022 09:28:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 09:28:51 +0800
Subject: Re: [PATCH v2 4/9] PCI: mark USB4 devices as removable
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
CC:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, <Alexander.Deucher@amd.com>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-5-mario.limonciello@amd.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <b1b47db2-b760-649a-d0e0-79ff22ece8c0@mediatek.com>
Date:   Fri, 11 Feb 2022 09:28:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220210224329.2793-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMi8xMS8yMiA2OjQzIEFNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gVVNCNCBjbGFz
cyBkZXZpY2VzIGFyZSBhbHNvIHJlbW92YWJsZSBsaWtlIEludGVsIFRodW5kZXJib2x0IGRldmlj
ZXMuDQo+IA0KPiBEcml2ZXJzIG9mIGRvd25zdHJlYW0gZGV2aWNlcyB1c2UgdGhpcyBpbmZvcm1h
dGlvbiB0byBkZWNsYXJlIGZ1bmN0aW9uYWwNCj4gZGlmZmVyZW5jZXMgaW4gaG93IHRoZSBkcml2
ZXJzIHBlcmZvcm0gYnkga25vd2luZyB0aGF0IHRoZXkgYXJlIGNvbm5lY3RlZA0KPiB0byBhbiB1
cHN0cmVhbSBUQlQvVVNCNCBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvcGNp
L3Byb2JlLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0K
PiBpbmRleCBlNDE2NTZjZGQ4ZjAuLjczNjczYTgzZWI1ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9wY2kvcHJvYmUuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+IEBAIC0xNjEwLDYg
KzE2MTAsNyBAQCBzdGF0aWMgdm9pZCBwY2lfc2V0X3JlbW92YWJsZShzdHJ1Y3QgcGNpX2RldiAq
ZGV2KQ0KPiAgIAkgKiBleHBvc2VkIGFzICJyZW1vdmFibGUiIHRvIHVzZXJzcGFjZS4NCj4gICAJ
ICovDQo+ICAgCWlmICh2c2VjIHx8DQo+ICsJICAgIGRldi0+Y2xhc3MgPT0gUENJX0NMQVNTX1NF
UklBTF9VU0JfVVNCNCB8fA0KPiAgIAkgICAgKHBhcmVudCAmJg0KPiAgIAkgICAgKHBhcmVudC0+
ZXh0ZXJuYWxfZmFjaW5nIHx8IGRldl9pc19yZW1vdmFibGUoJnBhcmVudC0+ZGV2KSkpKQ0KPiAg
IAkJZGV2X3NldF9yZW1vdmFibGUoJmRldi0+ZGV2LCBERVZJQ0VfUkVNT1ZBQkxFKTsNCj4gDQoN
ClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpU
aGFua3MhDQoNClJlZ2FyZHMsDQpNYWNwYXVsIExpbg==

