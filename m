Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2E78064
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfG1QKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 12:10:35 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:35618 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfG1QKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 12:10:35 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6SGAQMQ003000;
        Sun, 28 Jul 2019 12:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=IPm6kpAMyQ21g1BE7u8bb6DBdTLrLLx/c/N4HoSfwdo=;
 b=LNl3yPAetRNXHk8gpUrUR66j4M+9fly4MR4pBDL4f2jM0e9yeTae5/jT3gng4GHErihD
 +jked3KPZ1nGq259tOIrPlPLQjA82fdN8uvsCaLfFFHi/S00zxjFO0lcpe5LeS2tf1YP
 F/lVauka4QosVDZQwbl2xmnhwQTRN/pVWpL7eNi7cfji9wjeq7+vYL0RP4bwXm3Eiic2
 nFXsN93nTVIpZEX4JOeuz1frwOMCwcCqd8xJTQznwqLcgkjByRtb6coro+SdNuiUSlMA
 CtfBpjSt0po5U3+2Fn53wCbXP1bdkw1ZsPT02IdsPqtIJrCgPYyrxtHhwP1Q91tbViXG 3A== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2u0hp3v542-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 12:10:33 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6SG8xYp115061;
        Sun, 28 Jul 2019 12:10:32 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2u19e8tt6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Jul 2019 12:10:32 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="353806993"
From:   <Huong.Nguyen@dell.com>
To:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>
Subject: RE: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Thread-Topic: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Thread-Index: AQHVRAqUlCXNmneL4UeVy6KBySWnPabgNYgA
Date:   Sun, 28 Jul 2019 16:10:30 +0000
Message-ID: <4896673b83c8401187b6983dffc47ba8@ausx13mps323.AMER.DELL.COM>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190726215311.GA8720@localhost.localdomain>
 <683fffda-7116-a67b-02ab-503c0efc6853@linux.intel.com>
In-Reply-To: <683fffda-7116-a67b-02ab-503c0efc6853@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907280201
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907280202
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBzYXRoeWFuYXJheWFuYW4ga3Vw
cHVzd2FteSA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPiANClNl
bnQ6IEZyaWRheSwgSnVseSAyNiwgMjAxOSA2OjMxIFBNDQpUbzogS2VpdGggQnVzY2gNCkNjOiBi
aGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBhc2hvay5yYWpAaW50ZWwuY29tOyBrZWl0aC5idXNjaEBpbnRl
bC5jb207IEJvbGVuLCBBdXN0aW47IE5ndXllbiwgSHVvbmcNClN1YmplY3Q6IFJlOiBbUEFUQ0gg
djYgMC85XSBBZGQgRXJyb3IgRGlzY29ubmVjdCBSZWNvdmVyIChFRFIpIHN1cHBvcnQNCg0KDQpb
RVhURVJOQUwgRU1BSUxdIA0KDQorQXVzdGluICwgSHVvbmcNCg0KT24gNy8yNi8xOSAyOjUzIFBN
LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gRnJpLCBKdWwgMjYsIDIwMTkgYXQgMDI6NDM6MTBQ
TSAtMDcwMCwgc2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tIHdyb3Rl
Og0KPj4gRnJvbTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gDQo+PiA8c2F0aHlhbmFyYXlh
bmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2hzZXQgYWRk
cyBzdXBwb3J0IGZvciBmb2xsb3dpbmcgZmVhdHVyZXM6DQo+Pg0KPj4gMS4gRXJyb3IgRGlzY29u
bmVjdCBSZWNvdmVyIChFRFIpIHN1cHBvcnQuDQo+PiAyLiBfT1NDIGJhc2VkIG5lZ290aWF0aW9u
IHN1cHBvcnQgZm9yIERQQy4NCj4+DQo+PiBZb3UgY2FuIGZpbmQgRURSIHNwZWMgaW4gdGhlIGZv
bGxvd2luZyBsaW5rLg0KPj4NCj4+IGh0dHBzOi8vbWVtYmVycy5wY2lzaWcuY29tL3dnL1BDSS1T
SUcvZG9jdW1lbnQvMTI2MTQNCj4gVGhhbmsgeW91IGZvciBzdGlja2luZyB3aXRoIHRoaXMuIEkn
dmUgcmV2aWV3ZWQgdGhlIHNlcmllcyBhbmQgSSB0aGluayANCj4gdGhpcyBsb29rcyBnb29kIGZv
ciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuDQo+DQo+IEFja2VkLWJ5OiBLZWl0aCBCdXNjaCA8a2Vp
dGguYnVzY2hAaW50ZWwuY29tPg0KDQpUZXN0ZWQgb24gYSBEUEMtZW5hYmxlZCBQQ0llIHN3aXRj
aCAoQnJvYWRjb20gUEVYOTczMykgaW4gYSBEZWxsIFBvd2VyRWRnZSBSNzQweGQuICBJbmplY3Rl
ZCBmYXRhbCBhbmQgbm9uLWZhdGFsIGVycm9ycyBvbiBhbiBOVk1lIGVuZHBvaW50IGJlbG93IHRo
ZSBzd2l0Y2ggYW5kIG9uIHRoZSBzd2l0Y2ggZG93bnN0cmVhbSBwb3J0IGl0c2VsZiBhbmQgdmVy
aWZpZWQgZXJyb3JzIHdlcmUgY29udGFpbmVkIGFuZCB0aGVuIHJlY292ZXJlZCBhdCB0aGUgUENJ
ZSBsZXZlbC4NCg0KVGVzdGVkLWJ5OiBIdW9uZyBOZ3V5ZW4gPGh1b25nLm5ndXllbkBkZWxsLmNv
beKAjj4NCj4NCi0tDQpTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KTGludXgga2VybmVsIGRl
dmVsb3Blcg0KDQo=
