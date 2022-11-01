Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337C6144D5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 07:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKAGxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 02:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAGxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 02:53:32 -0400
Received: from m13101.mail.163.com (m13101.mail.163.com [220.181.13.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 736A59FD9;
        Mon, 31 Oct 2022 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=SlNnA
        lvkTnpWtXAcanjAnOnlx54H97bCSGPvzO7gD4w=; b=dmJiOHo9WgJid7mNQlID0
        Bd1H8EOaJwwOVRk9j91veiXbkbqiWhrHR8J1JPAzqbXZumZSIWuSVJXhp2+FUj1p
        Pje1vfuCK4uZWAGGJhSPQIwr0PCg7pSC7Do2LZuvwviZhihJjZGg8DIDdO9Io2d/
        IQeFZbW4xna6pENWSoOBqI=
Received: from slark_xiao$163.com ( [223.104.68.52] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Tue, 1 Nov 2022 14:52:45 +0800 (CST)
X-Originating-IP: [223.104.68.52]
Date:   Tue, 1 Nov 2022 14:52:45 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>
Cc:     quic_hemantk@quicinc.com, bhelgaas@google.com,
        loic.poulain@linaro.org, dnlplm@gmail.com, yonglin.tan@outlook.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re:Re: Re: [PATCH v3] PCI: Add vendor ID for QUECTEL
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y2C7uhzVorUrfQA2@kroah.com>
References: <20221101021052.7532-1-slark_xiao@163.com>
 <Y2Ckm79PgcTcVVne@kroah.com>
 <3af61b4.1f11.18431cf918d.Coremail.slark_xiao@163.com>
 <Y2C7uhzVorUrfQA2@kroah.com>
X-NTES-SC: AL_QuydBf6Tuk0t4yWeYekWkkcRjuo+UMC0vfgh249fPJs0vSvT2hIyXEBmBnbczcOLNBy0jye6fzZP1MJWdpt/Qr0R5RNYGIvi6+HwhoAdEeAe
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <69942131.48d4.18431f6c080.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowAAnLag9wmBjYHWRAA--.41938W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQysZGBbGAAviwACs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CgoKCgpBdCAyMDIyLTExLTAxIDE0OjI0OjU4LCAiR3JlZyBLSCIgPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToKPk9uIFR1ZSwgTm92IDAxLCAyMDIyIGF0IDAyOjA5OjU3UE0gKzA4
MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+IAo+PiAKPj4gQXQgMjAyMi0xMS0wMSAxMjo0NjoxOSwg
IkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+ID5PbiBUdWUs
IE5vdiAwMSwgMjAyMiBhdCAxMDoxMDo1MkFNICswODAwLCBTbGFyayBYaWFvIHdyb3RlOgo+PiA+
PiBuIE1ISSBkcml2ZXIsIHRoZXJlIGFyZSBzb21lIGNvbXBhbmllcycgcHJvZHVjdCBzdGlsbCBk
byBub3QgaGF2ZSB0aGVpcgo+PiA+PiBvd24gUENJIHZlbmRvciBtYWNyby4gU28gd2UgYWRkIGl0
IGhlcmUgdG8gbWFrZSB0aGUgY29kZSBuZWF0LiBSZWYgSUQKPj4gPj4gY291bGQgYmUgZm91bmQg
aW4gbGluayBodHRwczovL3BjaXNpZy5jb20vbWVtYmVyc2hpcC9tZW1iZXItY29tcGFuaWVzLgo+
PiA+PiAKPj4gPj4gU2lnbmVkLW9mZi1ieTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29t
Pgo+PiA+PiAtLS0KPj4gPj4gdjM6IFNlcGFyYXRlIGRpZmZlcmVudCB2ZW5kb3JzIGludG8gZGlm
ZmVyZW50IHBhdGNoLgo+PiA+PiAKPj4gPj4gdjI6IFVwZGF0ZSB2ZW5kb3IgSUQgdG8gdGhlIHJp
Z2h0IGxvY2F0aW9uIHNvcnRlZCBieSBudW1lcmljIHZhbHVlLgo+PiA+PiAtLS0KPj4gPj4gIGRy
aXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMgfCA2ICsrKy0tLQo+PiA+PiAgaW5jbHVk
ZS9saW51eC9wY2lfaWRzLmggICAgICAgICAgICB8IDIgKysKPj4gPj4gIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+PiA+PiAKPj4gPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMgYi9kcml2ZXJzL2J1cy9taGkv
aG9zdC9wY2lfZ2VuZXJpYy5jCj4+ID4+IGluZGV4IGNhYTRjZTI4Y2Y5ZS4uODFhZTljNDljZTJh
IDEwMDY0NAo+PiA+PiAtLS0gYS9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+
ID4+ICsrKyBiL2RyaXZlcnMvYnVzL21oaS9ob3N0L3BjaV9nZW5lcmljLmMKPj4gPj4gQEAgLTU1
NSwxMSArNTU1LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBtaGlfcGNp
X2lkX3RhYmxlW10gPSB7Cj4+ID4+ICAJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkg
Jm1oaV90ZWxpdF9mbjk5MF9pbmZvIH0sCj4+ID4+ICAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1Jf
SURfUUNPTSwgMHgwMzA4KSwKPj4gPj4gIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190
KSAmbWhpX3Fjb21fc2R4NjVfaW5mbyB9LAo+PiA+PiAtCXsgUENJX0RFVklDRSgweDFlYWMsIDB4
MTAwMSksIC8qIEVNMTIwUi1HTCAoc2R4MjQpICovCj4+ID4+ICsJeyBQQ0lfREVWSUNFKFBDSV9W
RU5ET1JfSURfUVVFQ1RFTCwgMHgxMDAxKSwgLyogRU0xMjBSLUdMIChzZHgyNCkgKi8KPj4gPj4g
IAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5m
byB9LAo+PiA+PiAtCXsgUENJX0RFVklDRSgweDFlYWMsIDB4MTAwMiksIC8qIEVNMTYwUi1HTCAo
c2R4MjQpICovCj4+ID4+ICsJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfUVVFQ1RFTCwgMHgx
MDAyKSwgLyogRU0xNjBSLUdMIChzZHgyNCkgKi8KPj4gPj4gIAkJLmRyaXZlcl9kYXRhID0gKGtl
cm5lbF91bG9uZ190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5mbyB9LAo+PiA+PiAtCXsgUENJX0RF
VklDRSgweDFlYWMsIDB4MjAwMSksIC8qIEVNMTIwUi1HTCBmb3IgRkNDTCAoc2R4MjQpICovCj4+
ID4+ICsJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfUVVFQ1RFTCwgMHgyMDAxKSwgLyogRU0x
MjBSLUdMIGZvciBGQ0NMIChzZHgyNCkgKi8KPj4gPj4gIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5l
bF91bG9uZ190KSAmbWhpX3F1ZWN0ZWxfZW0xeHhfaW5mbyB9LAo+PiA+PiAgCS8qIFQ5OVcxNzUg
KHNkeDU1KSwgQm90aCBmb3IgZVNJTSBhbmQgTm9uLWVTSU0gKi8KPj4gPj4gIAl7IFBDSV9ERVZJ
Q0UoUENJX1ZFTkRPUl9JRF9GT1hDT05OLCAweGUwYWIpLAo+PiA+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9wY2lfaWRzLmggYi9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAo+PiA+PiBpbmRl
eCBiMzYyZDkwZWI5YjAuLjNjOTE0NjFiY2ZlNCAxMDA2NDQKPj4gPj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9wY2lfaWRzLmgKPj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgKPj4gPj4g
QEAgLTI1ODUsNiArMjU4NSw4IEBACj4+ID4+ICAjZGVmaW5lIFBDSV9WRU5ET1JfSURfVEVLUkFN
CQkweDFkZTEKPj4gPj4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9URUtSQU1fREMyOTAJMHhkYzI5
Cj4+ID4+ICAKPj4gPj4gKyNkZWZpbmUgUENJX1ZFTkRPUl9JRF9RVUVDVEVMCQkweDFlYWMKPj4g
Pgo+PiA+V2h5IGRpZCB5b3UgaWdub3JlIHRoZSBjb21tZW50IGF0IHRoZSB0b3Agb2YgdGhpcyBm
aWxlIHNheWluZyB0aGF0IG5ldwo+PiA+ZW50cmllcyBhcmUgbm90IG5lZWRlZCB0byBiZSBhZGRl
ZCwgZXNwZWNpYWxseSBmb3IganVzdCBvbmUgdXNlcj8KPj4gPgo+PiA+dGhhbmtzLAo+PiA+Cj4+
ID5ncmVnIGstaAo+PiBIaSBHcmVnLAo+PiAgQWN0dWFsbHkgSSBkaWRuJ3Qgc2VlIHRoaXMgbm90
aWNlIGJlZm9yZSBjb21taXR0aW5nIHRoaXMgcGF0Y2guIEkgZXZlbiBkaXNjdXNzZWQgCj4+IGl0
IHdpdGggdGhlIG1haW50YWluZXIgZm9yIHNldmVyYWwgdGltZXMgYW5kIG5vYm9keSBzaG93IG1l
IHRoaXMgcnVsZS4KPj4gSSBoYXZlIGEgY29uY2Vybiwgc29tZSBJT1QgbW9kdWxlIHZlbmRvcnMs
IGxpa2UgUVVFQ1RFTCwgQ0lOVEVSSU9OKFRIQUxFUyksCj4+IFNJRVJSQSxST0xMSU5HIGFuZCBz
byBvbiwgdGhleSBvbmx5IHByb2R1Y2UgSU9UIG1vZHVsZXMgd2l0aG91dCBvdGhlciAKPj4gaGFy
ZHdhcmUgd2l0aCBQQ0llICBpbnRlcmZhY2UsIGFuZCB0aGV5IGFwcGxpZWQgZm9yIHRoZWlyIG93
biBWSUQuIEJ1dCB0aGV5Cj4+IGNhbid0IGdldCBhIHRoZWlyIG93biBWRU5ET1IgTUFSQ08/IFRo
aXMgc2VlbXMgdW5yZWFzb25hYmxlLgo+PiBUaGlzIGNoYW5nZSBzaG91bGQgYmUgaGFybWxlc3Mg
YW5kICBtYWtlIHRoZSBjb2RlIG5lYXQuCj4+IFRoaXMgaXMgbXkgb3Bpbmlvbi4KPgo+SXQgY2F1
c2VzIGEgX0xPVF8gb2YgY2h1cm4gYW5kIG1lcmdlIGlzc3VlcyB3aGVuIGV2ZXJ5b25lIGlzIGFk
ZGluZyBuZXcKPmVudHJpZXMgdG8gYSBzaW5nbGUgZmlsZS4gIFdoaWNoIGlzIHdoeSwgMTUrIHll
YXJzIGFnbywgd2UgbWFkZSB0aGUKPmRlY2lzaW9uIHRoYXQgaWYgYSB2ZW5kb3Igb3IgZGV2aWNl
IGlkIGlzIG9ubHkgbmVlZGVkIGluIG9uZSBmaWxlLCB0aGVuCj5pdCBzaG91bGQgbm90IGJlIGFk
ZGVkIHRvIHRoZSBwY2lfaWRzLmggZmlsZS4KPgo+Tm8gbmVlZCB0byBjaGFuZ2UgdGhhdCBub3cs
IHBsZWFzZSBqdXN0IHB1dCB0aGUgdmVuZG9yIGlkIGluIHRoZSBzaW5nbGUKPmRyaXZlciB0aGF0
IGl0IGlzIG5lZWRlZCBpbi4KPgo+dGhhbmtzLAo+Cj5ncmVnIGstaApIaSBHcmVnLApUaGFua3Mg
Zm9yIHlvdXIgZXhwbGFuYXRpb24uIAoKSGkgTWFuaSwKICBJcyB0aGVyZSBhIG5lZWQgdG8gdXBk
YXRlIHRoZXNlIHZlbmRvciBpZHMgYXMgbWFjcm8gaW4KcGNpX2dlbmVyaWMuYz8KClRoYW5rcy4K

