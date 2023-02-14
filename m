Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7C696027
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 11:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjBNKDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 05:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjBNKCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 05:02:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A3326855;
        Tue, 14 Feb 2023 02:01:01 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E8kAp9020869;
        Tue, 14 Feb 2023 10:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eb628+htzG73yejcx5OD1jG2x2hC8CTEkBH5Mrbt2/0=;
 b=OfpTTTeKcYvtjh7D6qcEReGq+1sgAz/2ElsDcTcnr9+Y935eyZslpOFxlZxjCizaVV9L
 js9FcQtZl9XHFmJ7u+AKgCDt6gdISmPXzKqLEXK0Oket27DWaP+HAvFS5LRRXGy9WzjI
 ciVbu1MhnrdhUvTA4CptNX1oVieQyxTgF2iYoOK7vYst+LD20Bs6x9tZj4Aj3+iGvfTx
 Qv+gMlF+of+jDxpmwQDx5teSoeBtpjrAk5RVckYVJ/nXfSvXfVa0ZArDJK4mpwr/Z0Fe
 TLOvWzf9t1EdKTOh9J4soCc4owFIHV3Sg37g7NU5xmHw3m3Ic+QGD8+QIgbsn6lexBoN Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nr72y1ndc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 10:01:00 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31E9L9du027786;
        Tue, 14 Feb 2023 10:01:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nr72y1ncq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 10:00:59 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E65w0Z017640;
        Tue, 14 Feb 2023 10:00:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6ktjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 10:00:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31EA0sNu48628074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 10:00:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FDB520043;
        Tue, 14 Feb 2023 10:00:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD37F20040;
        Tue, 14 Feb 2023 10:00:53 +0000 (GMT)
Received: from [9.155.211.163] (unknown [9.155.211.163])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 10:00:53 +0000 (GMT)
Message-ID: <198c6f7f19d77b8471bd609767b3d359a989b9ca.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: s390: Fix use-after-free of PCI bus resources with
 s390 per-function hotplug
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Date:   Tue, 14 Feb 2023 11:00:53 +0100
In-Reply-To: <bce832f7305a132fc2e2b47fc668292234820465.camel@linux.ibm.com>
References: <20230203114807.3461308-1-schnelle@linux.ibm.com>
         <bce832f7305a132fc2e2b47fc668292234820465.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3JyrfL9OZm3S4xXqdYD2JE74eRsCN2En
X-Proofpoint-GUID: jzB93slPWQTBXAWcda5KTxVvEWnEC8wC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=496
 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDEwOjQ2ICswMTAwLCBHZXJkIEJheWVyIHdyb3RlOgo+IEhp
IE5pa2xhcywKPiAKPiB3aGVuIGNvbXBhcmluZyBwY2lfYnVzX3JlbW92ZV9yZXNvdXJjZSB3aXRo
IHBjaV9idXNfcmVtb3ZlX3Jlc291cmNlcywKPiBJIGZpbmQgdGhhdCB0aGUgInNpbmdsZS1yZXNv
dXJjZSIgdmFyaWFudCBtaWdodCBiZSBlbmRpbmcgdG9vIGVhcmx5Lgo+IAo+IE9uIEZyaSwgMjAy
My0wMi0wMyBhdCAxMjo0OCArMDEwMCwgTmlrbGFzIFNjaG5lbGxlIHdyb3RlOgo+ID4gK3ZvaWQg
cGNpX2J1c19yZW1vdmVfcmVzb3VyY2Uoc3RydWN0IHBjaV9idXMgKmJ1cywgc3RydWN0IHJlc291
cmNlCj4gPiAqcmVzKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwY2lfYnVzX3Jl
c291cmNlICpidXNfcmVzLCAqdG1wOwo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IGk7Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgUENJX0JSSURHRV9SRVNPVVJDRV9OVU07
IGkrKykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChidXMtPnJlc291
cmNlW2ldID09IHJlcykgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBidXMtPnJlc291cmNlW2ldID0gTlVMTDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXl5eXl5eXgo+IERpZCB5b3UgbWVhbiB0byAiYnJlYWsiIGhlcmUsIHJhdGhlciB0
aGFuIGVuZCB0aGUgcm91dGluZT8KCk5vIHRoZSByZXR1cm4gaXMgaW50ZW5kZWQuIFdlJ3JlIGxv
b2tpbmcgdG8gcmVtb3ZlIGEgc2luZ2xlIHJlc291cmNlCmFuZCBpZiBJIHVuZGVyc3RhbmQgdGhp
bmdzIGNvcnJlY3RseSB0aGVuIHRoYXQgcmVzb3VyY2UgY2FuIGVpdGhlciBiZQppbiBidXMtPnJl
c291cmNlW10gKHgpb3IgaW4gYnVzLT5yZXNvdXJjZXMgZGVwZW5kaW5nIG9uIHdoZXRoZXIgaXQg
aXMgYQpQQ0kgYnJpZGdlIHJlc291cmNlLiBFaXRoZXIgd2F5IG9uY2UgZm91bmQgYW5kIHJlbW92
ZWQgZnJvbSB0aGUKcmVzcGVjdGl2ZSBhcnJheS9saXN0IHdlJ3JlIGRvbmUgYW5kIGNhbiB0aHVz
IHJldHVybiBpbW1lZGlhdGVseS4KCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
fQo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9zYWZlKGJ1c19yZXMsIHRtcCwgJmJ1cy0+cmVzb3VyY2VzLCBsaXN0KQo+ID4g
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChidXNfcmVzLT5yZXMgPT0g
cmVzKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGxpc3RfZGVsKCZidXNfcmVzLT5saXN0KTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKga2ZyZWUoYnVzX3Jlcyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5eXl5eXl4KPiBIZXJlICJicmVhayIgYW5kICJyZXR1cm4iIGhhdmUgdGhlIHNh
bWUgZWZmZWN0LCBidXQgImJyZWFrIiB3b3VsZCBiZQo+ICJzeW1tZXRyaWMiLgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKg
wqDCoMKgwqDCoHJldHVybjsKPiA+ICsKPiA+ICt9Cj4gCj4gV2hpbGUgdGhpcyBtaWdodCBiZSBh
IG5pdCwgSSdkIGxpa2UgdG8gYmV0dGVyIHNlcGFyYXRlIHRoZSAic2luZ2xlLQo+IHJlc291cmNl
IiB2YXJpYW50J3MgbmFtZS4gSG93IGFib3V0IHBjaV9idXNfcmVtb3ZlX29uZV9yZXNvdXJjZSAt
IEkKPiBrbm93IGl0J3MgZ2V0dGluZyBsb25nLi4uCj4gCj4gVGhhbmtzLAo+IEdlcmQKCkkgaGF2
ZSBubyBzdHJvbmcgZmVlbGluZ3Mgb24gdGhlIG5hbWUuCgo=

