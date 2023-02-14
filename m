Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26A4695FAA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjBNJru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 04:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjBNJrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 04:47:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4C233FA;
        Tue, 14 Feb 2023 01:46:53 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E9Vl4s013303;
        Tue, 14 Feb 2023 09:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3BwhYW1mi3zJ9K7xkh/wVb9maY6Izz7H9lqGYYfFGj4=;
 b=BSNSzZ3DASlVWfp3UPNv+Y/mDjwh3WKAxus1foqlRUSRXzBQab2zn21709wuc36WApzz
 epedupj5RhZOrq2iMBZ/KeBgLo5tzGEBMPUaHWPqZb8DL47tXacYto4ScXdbN0Y4Z7sO
 V7wgXMTGXpapAu3ykefW8QGPWamjqVBcmoKZChIo4rrW4ww95KIBBo9kMyxrXtWjYjOv
 KCpb86w1UZIbmPG91TgOsUAU+A/w6aGTPSE0zRogptOs+sq3pDtIhpe6EV7RJuYqD4SP
 op2MLoaaAUuM1Um8neytPmXymk45WZdztJ0RO4Xks7WdCYcPvtgP45WL2XiF2uHWgVc2 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nr7rg8dh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 09:46:52 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31E9Vm7L013357;
        Tue, 14 Feb 2023 09:46:51 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nr7rg8dgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 09:46:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E66Oqu017578;
        Tue, 14 Feb 2023 09:46:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6kt3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 09:46:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31E9kksO51380694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 09:46:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 598DA20043;
        Tue, 14 Feb 2023 09:46:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A88920040;
        Tue, 14 Feb 2023 09:46:46 +0000 (GMT)
Received: from [9.152.212.201] (unknown [9.152.212.201])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 09:46:45 +0000 (GMT)
Message-ID: <bce832f7305a132fc2e2b47fc668292234820465.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: s390: Fix use-after-free of PCI bus resources with
 s390 per-function hotplug
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
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
Date:   Tue, 14 Feb 2023 10:46:45 +0100
In-Reply-To: <20230203114807.3461308-1-schnelle@linux.ibm.com>
References: <20230203114807.3461308-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r0M2-p5mWNs7zLAcc5uyAKqRLElh8ahG
X-Proofpoint-ORIG-GUID: bS19lyX0amj30DC6H-oY2KHk0LoxwEM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 mlxlogscore=533 impostorscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
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

SGkgTmlrbGFzLAoKd2hlbiBjb21wYXJpbmcgcGNpX2J1c19yZW1vdmVfcmVzb3VyY2Ugd2l0aCBw
Y2lfYnVzX3JlbW92ZV9yZXNvdXJjZXMsCkkgZmluZCB0aGF0IHRoZSAic2luZ2xlLXJlc291cmNl
IiB2YXJpYW50IG1pZ2h0IGJlIGVuZGluZyB0b28gZWFybHkuCgpPbiBGcmksIDIwMjMtMDItMDMg
YXQgMTI6NDggKzAxMDAsIE5pa2xhcyBTY2huZWxsZSB3cm90ZToKPiArdm9pZCBwY2lfYnVzX3Jl
bW92ZV9yZXNvdXJjZShzdHJ1Y3QgcGNpX2J1cyAqYnVzLCBzdHJ1Y3QgcmVzb3VyY2UKPiAqcmVz
KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHBjaV9idXNfcmVzb3VyY2UgKmJ1c19yZXMs
ICp0bXA7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGZvciAo
aSA9IDA7IGkgPCBQQ0lfQlJJREdFX1JFU09VUkNFX05VTTsgaSsrKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChidXMtPnJlc291cmNlW2ldID09IHJlcykgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVzLT5yZXNvdXJjZVtp
XSA9IE5VTEw7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm47CiAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXgpEaWQgeW91IG1lYW4g
dG8gImJyZWFrIiBoZXJlLCByYXRoZXIgdGhhbiBlbmQgdGhlIHJvdXRpbmU/Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDC
oMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShidXNfcmVzLCB0bXAsICZidXMtPnJlc291
cmNlcywgbGlzdCkKPiB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChidXNf
cmVzLT5yZXMgPT0gcmVzKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBsaXN0X2RlbCgmYnVzX3Jlcy0+bGlzdCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrZnJlZShidXNfcmVzKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXl5eXl5eCkhlcmUgImJyZWFrIiBhbmQgInJldHVybiIgaGF2ZSB0aGUg
c2FtZSBlZmZlY3QsIGJ1dCAiYnJlYWsiIHdvdWxkIGJlCiJzeW1tZXRyaWMiLgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICvCoMKgwqDCoMKg
wqDCoHJldHVybjsKPiArCj4gK30KCldoaWxlIHRoaXMgbWlnaHQgYmUgYSBuaXQsIEknZCBsaWtl
IHRvIGJldHRlciBzZXBhcmF0ZSB0aGUgInNpbmdsZS0KcmVzb3VyY2UiIHZhcmlhbnQncyBuYW1l
LiBIb3cgYWJvdXQgcGNpX2J1c19yZW1vdmVfb25lX3Jlc291cmNlIC0gSQprbm93IGl0J3MgZ2V0
dGluZyBsb25nLi4uCgpUaGFua3MsCkdlcmQK

