Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D784780656
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 09:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358198AbjHRH21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358229AbjHRH1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 03:27:47 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 00:27:43 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B833D30F1;
        Fri, 18 Aug 2023 00:27:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="87750283"
From:   =?gb2312?B?u8bJ2bKo?= <huangshaobo3@xiaomi.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?gb2312?B?wO6438X0?= <chenwei29@xiaomi.com>,
        =?gb2312?B?wbrOsMX0?= <weipengliang@xiaomi.com>,
        =?gb2312?B?zsy98LfJ?= <wengjinfei@xiaomi.com>,
        =?gb2312?B?0NzBwQ==?= <xiongliang@xiaomi.com>
Subject: Subject: [PATCH] pci/msi: remove redundant calculation in
 msi_setup_msi_desc
Thread-Topic: Subject: [PATCH] pci/msi: remove redundant calculation in
 msi_setup_msi_desc
Thread-Index: AdnRpKW3tDXXI46aR/+qEejYHxfxLQ==
Date:   Fri, 18 Aug 2023 07:26:38 +0000
Message-ID: <3ebf5d8032ad418da4f24516cd23406e@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

V2hldGhlciB0byBzdXBwb3J0IDY0LWJpdCBhZGRyZXNzIHN0YXR1cyBoYXMgYmVlbiBjYWxjdWxh
dGVkIGJlZm9yZSwNCmFuZCB0aGUgY2FsY3VsYXRpb24gcmVzdWx0IGNhbiBiZSB1c2VkIGRpcmVj
dGx5IGFmdGVyd2FyZHMsIHNvIHVzZQ0KbXNpX2F0dHJpYi5pc182NCB0byBhdm9pZCBkb3VibGUg
Y2FsY3VsYXRpb24uDQoNClN1Z2dlc3RlZC1ieTogd2VpcGVuZ2xpYW5nIDx3ZWlwZW5nbGlhbmdA
eGlhb21pLmNvbT4NClNpZ25lZC1vZmYtYnk6IHNwYXJraHVhbmcgPGh1YW5nc2hhb2JvM0B4aWFv
bWkuY29tPg0KLS0tDQogZHJpdmVycy9wY2kvbXNpL21zaS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvbXNpL21zaS5jIGIvZHJpdmVycy9wY2kvbXNpL21zaS5jDQppbmRleCBlZjFkODg1Li4z
MDRlODg5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvbXNpL21zaS5jDQorKysgYi9kcml2ZXJz
L3BjaS9tc2kvbXNpLmMNCkBAIC0zMDMsNyArMzAzLDcgQEAgc3RhdGljIGludCBtc2lfc2V0dXBf
bXNpX2Rlc2Moc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IG52ZWMsDQogICAgICAgIGRlc2MucGNp
Lm1zaV9hdHRyaWIubXVsdGlwbGUgICAgPSBpbG9nMihfX3JvdW5kdXBfcG93X29mX3R3byhudmVj
KSk7DQogICAgICAgIGRlc2MuYWZmaW5pdHkgICAgICAgICAgICAgICAgICAgPSBtYXNrczsNCg0K
LSAgICAgICBpZiAoY29udHJvbCAmIFBDSV9NU0lfRkxBR1NfNjRCSVQpDQorICAgICAgIGlmIChk
ZXNjLnBjaS5tc2lfYXR0cmliLmlzXzY0KQ0KICAgICAgICAgICAgICAgIGRlc2MucGNpLm1hc2tf
cG9zID0gZGV2LT5tc2lfY2FwICsgUENJX01TSV9NQVNLXzY0Ow0KICAgICAgICBlbHNlDQogICAg
ICAgICAgICAgICAgZGVzYy5wY2kubWFza19wb3MgPSBkZXYtPm1zaV9jYXAgKyBQQ0lfTVNJX01B
U0tfMzI7DQotLQ0KMi43LjQNCg0KIy8qKioqKiqxvtPKvP68sMbkuL28/rqs09DQocPXuavLvrXE
saPD3NDFz6KjrL32z97T2reiy824+MnPw+a12Na31tDB0LP2tcS49sjLu/LIutfpoaO9+9a5yM66
zsbky/vIy9LUyM66ztDOyr3KudPDo6iw/MCotauyu8/e09rIq7K/u/Kyv7fWtdjQucK2oaK4tNbG
oaK78smit6KjqbG+08q8/tbQtcTQxc+ioaPI57n7xPq07crVwcuxvtPKvP6jrMfrxPrBory0tee7
sLvy08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP6joSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFj
aG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGlj
aCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNz
IGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhl
cmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3Ig
cGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBl
cnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQu
IElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiov
Iw0K
