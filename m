Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAC4B1B49
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 02:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiBKBb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 20:31:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiBKBb6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 20:31:58 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3B273A;
        Thu, 10 Feb 2022 17:31:57 -0800 (PST)
X-UUID: 26d715e8ff1b490a83a18bf2609b5c7f-20220211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=Yy4R1rvCtE33SVD1LuwdXVDIsUZsLmXi1cznTjUjGKA=;
        b=Ril1c+e/cGZ4RqQduu6cP7tRP3PZnVV+Gbo77hpUd+1kVvFzZtIf/9aMPw6XVCPgV7ffBge0Fv5Ux/JoQNThUCw3YiMhj3WFXViYB+LgcyoOOLjdb4ffTLcvSmpgTuzNZf6npGb1UOhBkEvjKJSl5jReDRXyJtHyirIwRXw2o5I=;
X-UUID: 26d715e8ff1b490a83a18bf2609b5c7f-20220211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 829207914; Fri, 11 Feb 2022 09:31:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Feb 2022 09:31:51 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 09:31:51 +0800
Subject: Re: [PATCH v2 5/9] drm/amd: drop the use of
 `pci_is_thunderbolt_attached`
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
 <20220210224329.2793-6-mario.limonciello@amd.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <52acd5d6-6964-464b-3f83-b1fcc3329f1e@mediatek.com>
Date:   Fri, 11 Feb 2022 09:31:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220210224329.2793-6-mario.limonciello@amd.com>
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

T24gMi8xMS8yMiA2OjQzIEFNLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gQ3VycmVudGx5
IGBwY2lfaXNfdGh1bmRlcmJvbHRfYXR0YWNoZWRgIGlzIHVzZWQgdG8gaW5kaWNhdGUgYSBkZXZp
Y2UNCj4gaXMgY29ubmVjdGVkIGV4dGVybmFsbHkuDQo+IA0KPiBUaGUgUENJIGNvcmUgbm93IG1h
cmtzIHN1Y2ggZGV2aWNlcyBhcyByZW1vdmFibGUgYW5kIGRvd25zdHJlYW0gZHJpdmVycw0KPiBj
YW4gdXNlIHRoaXMgaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2ll
bGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmJpb192Ml8zLmMgIHwgMiArLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9rbXMuYw0KPiBpbmRleCAxZWJiOTFkYjIyNzQuLjZkYmY1NzUzYjViZSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiBAQCAtMTYxLDcgKzE2
MSw3IEBAIGludCBhbWRncHVfZHJpdmVyX2xvYWRfa21zKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiAgIAkgICAgKGFtZGdwdV9pc19hdHB4X2h5YnJp
ZCgpIHx8DQo+ICAgCSAgICAgYW1kZ3B1X2hhc19hdHB4X2RncHVfcG93ZXJfY250bCgpKSAmJg0K
PiAgIAkgICAgKChmbGFncyAmIEFNRF9JU19BUFUpID09IDApICYmDQo+IC0JICAgICFwY2lfaXNf
dGh1bmRlcmJvbHRfYXR0YWNoZWQodG9fcGNpX2RldihkZXYtPmRldikpKQ0KPiArCSAgICAhZGV2
X2lzX3JlbW92YWJsZSgmYWRldi0+cGRldi0+ZGV2KSkNCj4gICAJCWZsYWdzIHw9IEFNRF9JU19Q
WDsNCj4gICANCj4gICAJcGFyZW50ID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShhZGV2LT5wZGV2KTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjJfMy5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192Ml8zLmMNCj4gaW5kZXggZWU3Y2FiMzdk
ZmQ1Li4yYzVkNzRkODM2ZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L25iaW9fdjJfMy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9f
djJfMy5jDQo+IEBAIC0zODIsNyArMzgyLDcgQEAgc3RhdGljIHZvaWQgbmJpb192Ml8zX2VuYWJs
ZV9hc3BtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgIA0KPiAgIAkJZGF0YSB8PSBO
QVZJMTBfUENJRV9fTENfTDBTX0lOQUNUSVZJVFlfREVGQVVMVCA8PCBQQ0lFX0xDX0NOVExfX0xD
X0wwU19JTkFDVElWSVRZX19TSElGVDsNCj4gICANCj4gLQkJaWYgKHBjaV9pc190aHVuZGVyYm9s
dF9hdHRhY2hlZChhZGV2LT5wZGV2KSkNCj4gKwkJaWYgKGRldl9pc19yZW1vdmFibGUoJmFkZXYt
PnBkZXYtPmRldikpDQo+ICAgCQkJZGF0YSB8PSBOQVZJMTBfUENJRV9fTENfTDFfSU5BQ1RJVklU
WV9UQlRfREVGQVVMVCAgPDwgUENJRV9MQ19DTlRMX19MQ19MMV9JTkFDVElWSVRZX19TSElGVDsN
Cj4gICAJCWVsc2UNCj4gICAJCQlkYXRhIHw9IE5BVkkxMF9QQ0lFX19MQ19MMV9JTkFDVElWSVRZ
X0RFRkFVTFQgPDwgUENJRV9MQ19DTlRMX19MQ19MMV9JTkFDVElWSVRZX19TSElGVDsNCj4gDQoN
ClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpU
aGFua3MhDQoNClJlZ2FyZHMsDQpNYWNwYXVsIExpbg==

