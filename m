Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97326876E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgINIqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 04:46:01 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:56333 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgINIp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 04:45:59 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: +52Xi0nxjsSJEKHnFE2/nj+oEaKsxFWw1maWrGwBNyzHU6ifkL5Y5fKvh2ytn
        w9/RGnQCmLsaaHKYDQQHNflzLDHBfX+tHeGk5wXdc5DVDXdUdFApqB2IGBeVdEXHOj6q3P5
        7cb7O9MlYOIjFf4fTSJxTvaoD6ob6536cZkppxam0AZ810MQp24YGMeEU06i7YJTUxE6z/m
        q0pGP6LUrCV2YwNP7htzRb36/QizzMdVqMDO2A1jmhNMrpv4rvydizKqtKWLnmIeWpD/q5u
        qRWfIZZUkJTaqd6OMuV6A7+Mw7PQaJw4bUAuzuPwKPWylhxW53Rh7QJu4RB+U3K/LfgJUtg
        C7g87uPFzWKdp5s+NqTlP/vSIv+wg==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.48.120
X-QQ-STYLE: 
X-QQ-mid: logic508t1600073142t775655
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?VGllemh1IFlhbmc=?=" <yangtiezhu@loongson.cn>,
        "=?utf-8?B?Qmpvcm4gSGVsZ2Fhcw==?=" <bhelgaas@google.com>
Cc:     "=?utf-8?B?bGludXgtcGNp?=" <linux-pci@vger.kernel.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?UmFmYWVsIEouIFd5c29ja2k=?=" <rafael.j.wysocki@intel.com>,
        "=?utf-8?B?S29uc3RhbnRpbiBLaGxlYm5pa292?=" <khlebnikov@openvz.org>,
        "=?utf-8?B?S2hhbGlkIEF6aXo=?=" <khalid.aziz@oracle.com>,
        "=?utf-8?B?Vml2ZWsgR295YWw=?=" <vgoyal@redhat.com>,
        "=?utf-8?B?THVrYXMgV3VubmVy?=" <lukas@wunner.de>,
        "=?utf-8?B?T2xpdmVyIE8nSGFsbG9yYW4=?=" <oohall@gmail.com>,
        "=?utf-8?B?SmlheHVuIFlhbmc=?=" <jiaxun.yang@flygoat.com>,
        "=?utf-8?B?WHVlZmVuZyBMaQ==?=" <lixuefeng@loongson.cn>
Subject: Re:[RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec reboot and connected PCI devices
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 14 Sep 2020 16:45:42 +0800
X-Priority: 3
Message-ID: <tencent_39F3D56E0E67327D239C8067@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
X-QQ-ReplyHash: 1976346135
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Mon, 14 Sep 2020 16:45:44 +0800 (CST)
Feedback-ID: logic:lemote.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIFRpZXpodSwNCg0KSG93IGRvIHlvdSB0ZXN0IGtleGVjPyBrZXhlYyAtZSBvciBzeXN0
ZW1jdGwga2V4ZWM/IE9yIGJvdGg/DQoNCkh1YWNhaQ0KDQrpmYjljY7miY3msZ/oi4/oiKrl
pKnpvpnmoqbkv6Hmga/mioDmnK/mnInpmZDlhazlj7gv56CU5Y+R5Lit5b+DL+i9r+S7tumD
qCAgIC0tLS0tLS0tLS0tLS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS1Gcm9t
OiAgIlRpZXpodSBZYW5nIjx5YW5ndGllemh1QGxvb25nc29uLmNuPjtEYXRlOiAgTW9uLCBT
ZXAgMTQsIDIwMjAgMDM6NTcgUE1UbzogICJCam9ybiBIZWxnYWFzIjxiaGVsZ2Fhc0Bnb29n
bGUuY29tPjsgQ2M6ICAibGludXgtcGNpIjxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsg
ImxpbnV4LWtlcm5lbCI8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47ICJSYWZhZWwg
Si4gV3lzb2NraSI8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyAiS29uc3RhbnRpbiBL
aGxlYm5pa292IjxraGxlYm5pa292QG9wZW52ei5vcmc+OyAiS2hhbGlkIEF6aXoiPGtoYWxp
ZC5heml6QG9yYWNsZS5jb20+OyAiVml2ZWsgR295YWwiPHZnb3lhbEByZWRoYXQuY29tPjsg
Ikx1a2FzIFd1bm5lciI8bHVrYXNAd3VubmVyLmRlPjsgIk9saXZlciBPJ0hhbGxvcmFuIjxv
b2hhbGxAZ21haWwuY29tPjsgIkh1YWNhaSBDaGVuIjxjaGVuaGNAbGVtb3RlLmNvbT47ICJK
aWF4dW4gWWFuZyI8amlheHVuLnlhbmdAZmx5Z29hdC5jb20+OyAiWHVlZmVuZyBMaSI8bGl4
dWVmZW5nQGxvb25nc29uLmNuPjsgU3ViamVjdDogIFtSRkMgUEFUQ0ggdjNdIFBDSS9wb3J0
ZHJ2OiBPbmx5IGRpc2FibGUgQnVzIE1hc3RlciBvbiBrZXhlYyByZWJvb3QgYW5kIGNvbm5l
Y3RlZCBQQ0kgZGV2aWNlcyBBZnRlciBjb21taXQgNzQ1YmUyZTcwMGNkICgiUENJZTogcG9y
dGRydjogY2FsbCBwY2lfZGlzYWJsZV9kZXZpY2UNCmR1cmluZyByZW1vdmUiKSBhbmQgY29t
bWl0IGNjMjdiNzM1YWQzYSAoIlBDSS9wb3J0ZHJ2OiBUdXJuIG9mZiBQQ0llDQpzZXJ2aWNl
cyBkdXJpbmcgc2h1dGRvd24iKSwgaXQgYWxzbyBjYWxscyBwY2lfZGlzYWJsZV9kZXZpY2Uo
KSBkdXJpbmcNCnNodXRkb3duLCB0aGlzIGxlYWRzIHRvIHNodXRkb3duIG9yIHJlYm9vdCBm
YWlsdXJlIG9jY2FzaW9uYWxseSBkdWUgdG8NCmNsZWFyIFBDSV9DT01NQU5EX01BU1RFUiBv
biB0aGUgZGV2aWNlIGluIGRvX3BjaV9kaXNhYmxlX2RldmljZSgpLg0KDQpkcml2ZXJzL3Bj
aS9wY2kuYw0Kc3RhdGljIHZvaWQgZG9fcGNpX2Rpc2FibGVfZGV2aWNlKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpDQp7DQogICAgICAgIHUxNiBwY2lfY29tbWFuZDsNCg0KICAgICAgICBwY2lf
cmVhZF9jb25maWdfd29yZChkZXYsIFBDSV9DT01NQU5ELCAmcGNpX2NvbW1hbmQpOw0KICAg
ICAgICBpZiAocGNpX2NvbW1hbmQgJiBQQ0lfQ09NTUFORF9NQVNURVIpIHsNCiAgICAgICAg
ICAgICAgICBwY2lfY29tbWFuZCAmPSB+UENJX0NPTU1BTkRfTUFTVEVSOw0KICAgICAgICAg
ICAgICAgIHBjaV93cml0ZV9jb25maWdfd29yZChkZXYsIFBDSV9DT01NQU5ELCBwY2lfY29t
bWFuZCk7DQogICAgICAgIH0NCg0KICAgICAgICBwY2liaW9zX2Rpc2FibGVfZGV2aWNlKGRl
dik7DQp9DQoNCldoZW4gcmVtb3ZlICJwY2lfY29tbWFuZCAmPSB+UENJX0NPTU1BTkRfTUFT
VEVSOyIsIGl0IGNhbiB3b3JrIHdlbGwgd2hlbg0Kc2h1dGRvd24gb3IgcmVib290Lg0KDQpB
cyBPbGl2ZXIgTydIYWxsb3JhbiBzYWlkLCBubyBuZWVkIHRvIGNhbGwgcGNpX2Rpc2FibGVf
ZGV2aWNlKCkgd2hlbg0KYWN0dWFsbHkgc2h1dHRpbmcgZG93biwgYnV0IHdlIHNob3VsZCBj
YWxsIHBjaV9kaXNhYmxlX2RldmljZSgpIGJlZm9yZQ0KaGFuZGluZyBvdmVyIHRvIHRoZSBu
ZXcga2VybmVsIG9uIGtleGVjIHJlYm9vdCwgc28gd2UgY2FuIGRvIHNvbWUNCmNvbmRpdGlv
biBjaGVja3Mgd2hpY2ggYXJlIGFscmVhZHkgZXhlY3V0ZWQgYWZ0ZXJ3YXJkcyBieSB0aGUg
ZnVuY3Rpb24NCnBjaV9kZXZpY2Vfc2h1dGRvd24oKSwgdGhpcyBpcyBkb25lIGJ5IGNvbW1p
dCA0ZmM5YmJmOThmZDYgKCJQQ0k6IERpc2FibGUNCkJ1cyBNYXN0ZXIgb25seSBvbiBrZXhl
YyByZWJvb3QiKSBhbmQgY29tbWl0IDZlMGVkYTNjMzg5OCAoIlBDSTogRG9uJ3QgdHJ5DQp0
byBkaXNhYmxlIEJ1cyBNYXN0ZXIgb24gZGlzY29ubmVjdGVkIFBDSSBkZXZpY2VzIikuDQoN
CmRyaXZlcnMvcGNpL3BjaS1kcml2ZXIuYw0Kc3RhdGljIHZvaWQgcGNpX2RldmljZV9zaHV0
ZG93bihzdHJ1Y3QgZGV2aWNlICpkZXYpDQp7DQogLi4uDQogICAgICAgIGlmIChkcnYgJiYg
ZHJ2LT5zaHV0ZG93bikNCiAgICAgICAgICAgICAgICBkcnYtPnNodXRkb3duKHBjaV9kZXYp
Ow0KDQogICAgICAgIC8qDQogICAgICAgICAqIElmIHRoaXMgaXMgYSBrZXhlYyByZWJvb3Qs
IHR1cm4gb2ZmIEJ1cyBNYXN0ZXIgYml0IG9uIHRoZQ0KICAgICAgICAgKiBkZXZpY2UgdG8g
dGVsbCBpdCB0byBub3QgY29udGludWUgdG8gZG8gRE1BLiBEb24ndCB0b3VjaA0KICAgICAg
ICAgKiBkZXZpY2VzIGluIEQzY29sZCBvciB1bmtub3duIHN0YXRlcy4NCiAgICAgICAgICog
SWYgaXQgaXMgbm90IGEga2V4ZWMgcmVib290LCBmaXJtd2FyZSB3aWxsIGhpdCB0aGUgUENJ
DQogICAgICAgICAqIGRldmljZXMgd2l0aCBiaWcgaGFtbWVyIGFuZCBzdG9wIHRoZWlyIERN
QSBhbnkgd2F5Lg0KICAgICAgICAgKi8NCiAgICAgICAgaWYgKGtleGVjX2luX3Byb2dyZXNz
ICYmIChwY2lfZGV2LT5jdXJyZW50X3N0YXRlIDw9IFBDSV9EM2hvdCkpDQogICAgICAgICAg
ICAgICAgcGNpX2NsZWFyX21hc3RlcihwY2lfZGV2KTsNCn0NCg0KWyAgIDM2LjE1OTQ0Nl0g
Q2FsbCBUcmFjZToNClsgICAzNi4yNDE2ODhdIFs8ZmZmZmZmZmY4MDIxMTQzND5dIHNob3df
c3RhY2srMHg5Yy8weDEzMA0KWyAgIDM2LjMyNjYxOV0gWzxmZmZmZmZmZjgwNjYxYjcwPl0g
ZHVtcF9zdGFjaysweGIwLzB4ZjANClsgICAzNi40MTA0MDNdIFs8ZmZmZmZmZmY4MDZhODI0
MD5dIHBjaWVfcG9ydGRydl9zaHV0ZG93bisweDE4LzB4NzgNClsgICAzNi40OTUzMDJdIFs8
ZmZmZmZmZmY4MDY5YzZiND5dIHBjaV9kZXZpY2Vfc2h1dGRvd24rMHg0NC8weDkwDQpbICAg
MzYuNTgwMDI3XSBbPGZmZmZmZmZmODA3YWFjOTA+XSBkZXZpY2Vfc2h1dGRvd24rMHgxMzAv
MHgyOTANClsgICAzNi42NjQ0ODZdIFs8ZmZmZmZmZmY4MDI2NTQ0OD5dIGtlcm5lbF9wb3dl
cl9vZmYrMHgzOC8weDgwDQpbICAgMzYuNzQ4MjcyXSBbPGZmZmZmZmZmODAyNjU2MzQ+XSBf
X2RvX3N5c19yZWJvb3QrMHgxYTQvMHgyNTgNClsgICAzNi44MzE5ODVdIFs8ZmZmZmZmZmY4
MDIxOGI5MD5dIHN5c2NhbGxfY29tbW9uKzB4MzQvMHg1OA0KDQpTaWduZWQtb2ZmLWJ5OiBU
aWV6aHUgWWFuZyA8eWFuZ3RpZXpodUBsb29uZ3Nvbi5jbj4NCi0tLQ0KIGRyaXZlcnMvcGNp
L3BjaWUvcG9ydGRydl9jb3JlLmMgfCAgMSAtDQogZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2
X3BjaS5jICB8IDE0ICsrKysrKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
cGNpZS9wb3J0ZHJ2X2NvcmUuYyBiL2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydl9jb3JlLmMN
CmluZGV4IDUwYTk1MjIuLjE5OTFhY2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9wY2ll
L3BvcnRkcnZfY29yZS5jDQorKysgYi9kcml2ZXJzL3BjaS9wY2llL3BvcnRkcnZfY29yZS5j
DQpAQCAtNDkxLDcgKzQ5MSw2IEBAIHZvaWQgcGNpZV9wb3J0X2RldmljZV9yZW1vdmUoc3Ry
dWN0IHBjaV9kZXYgKmRldikNCiB7DQogCWRldmljZV9mb3JfZWFjaF9jaGlsZCgmZGV2LT5k
ZXYsIE5VTEwsIHJlbW92ZV9pdGVyKTsNCiAJcGNpX2ZyZWVfaXJxX3ZlY3RvcnMoZGV2KTsN
Ci0JcGNpX2Rpc2FibGVfZGV2aWNlKGRldik7DQogfQ0KIA0KIC8qKg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL3BjaWUvcG9ydGRydl9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaWUvcG9y
dGRydl9wY2kuYw0KaW5kZXggM2EzY2U0MC4uY2FiMzdhOCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvcGNpL3BjaWUvcG9ydGRydl9wY2kuYw0KKysrIGIvZHJpdmVycy9wY2kvcGNpZS9wb3J0
ZHJ2X3BjaS5jDQpAQCAtMTQzLDYgKzE0MywxOCBAQCBzdGF0aWMgdm9pZCBwY2llX3BvcnRk
cnZfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQogCX0NCiANCiAJcGNpZV9wb3J0X2Rl
dmljZV9yZW1vdmUoZGV2KTsNCisJcGNpX2Rpc2FibGVfZGV2aWNlKGRldik7DQorfQ0KKw0K
K3N0YXRpYyB2b2lkIHBjaWVfcG9ydGRydl9zaHV0ZG93bihzdHJ1Y3QgcGNpX2RldiAqZGV2
KQ0KK3sNCisJaWYgKHBjaV9icmlkZ2VfZDNfcG9zc2libGUoZGV2KSkgew0KKwkJcG1fcnVu
dGltZV9mb3JiaWQoJmRldi0+ZGV2KTsNCisJCXBtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKCZk
ZXYtPmRldik7DQorCQlwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNwZW5kKCZkZXYtPmRl
dik7DQorCX0NCisNCisJcGNpZV9wb3J0X2RldmljZV9yZW1vdmUoZGV2KTsNCiB9DQogDQog
c3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9wb3J0ZHJ2X2Vycm9yX2RldGVjdGVkKHN0
cnVjdCBwY2lfZGV2ICpkZXYsDQpAQCAtMjExLDcgKzIyMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cGNpX2RyaXZlciBwY2llX3BvcnRkcml2ZXIgPSB7DQogDQogCS5wcm9iZQkJPSBwY2llX3Bv
cnRkcnZfcHJvYmUsDQogCS5yZW1vdmUJCT0gcGNpZV9wb3J0ZHJ2X3JlbW92ZSwNCi0JLnNo
dXRkb3duCT0gcGNpZV9wb3J0ZHJ2X3JlbW92ZSwNCisJLnNodXRkb3duCT0gcGNpZV9wb3J0
ZHJ2X3NodXRkb3duLA0KIA0KIAkuZXJyX2hhbmRsZXIJPSAmcGNpZV9wb3J0ZHJ2X2Vycl9o
YW5kbGVyLA0KIA0KLS0gDQoyLjEuMA==



