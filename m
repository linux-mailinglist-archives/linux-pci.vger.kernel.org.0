Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BEC1FC9FA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgFQJhi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 05:37:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgFQJhi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 05:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592386656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hQXnvUHXJXPvepBf7ywq9CRGBzneqKE9hf77vrkoSDo=;
        b=A0F6DjKTzu1ET/ytG9vc2X5NZfA5i7ezZeNoQle3lrD25J83KvILcSvfTWgkegnVJ2BeFM
        9iqJN2xTc+DVh+Ca7c3vNLoQSYGJk/NpQZtLiQwU/gTmfhZUmJ3L5PjXlPRW2C9UKivoKB
        dhRPbUrmyjkCFfgwUg/RthI4yhKE/ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-A6VUPTEaN4WkGTE4zq-pnQ-1; Wed, 17 Jun 2020 05:37:34 -0400
X-MC-Unique: A6VUPTEaN4WkGTE4zq-pnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEA641009618;
        Wed, 17 Jun 2020 09:37:32 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB4025C1C3;
        Wed, 17 Jun 2020 09:37:26 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 0/2] genirq: take device NUMA node into account for managed IRQs
Date:   Wed, 17 Jun 2020 10:37:23 +0100
Message-Id: <20200617093725.1725569-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGV2aWNlcyB3aXRoIGEgc21hbGwgbnVtYmVyIG9mIG1hbmFnZWQgSVJRcyBkbyBub3QgYmVuZWZp
dCBmcm9tIHNwcmVhZGluZw0KYWNyb3NzIGFsbCBDUFVzLiBJbnN0ZWFkIHRoZXkgYmVuZWZpdCBm
cm9tIE5VTUEgbm9kZSBhZmZpbml0eSBzbyB0aGF0IElSUXMgYXJlDQpoYW5kbGVkIG9uIHRoZSBk
ZXZpY2UncyBOVU1BIG5vZGUuDQoNCkZvciBleGFtcGxlLCBoZXJlIGlzIGEgbWFjaGluZSB3aXRo
IGEgdmlydGlvLWJsayBQQ0kgZGV2aWNlIG9uIE5VTUEgbm9kZSAxOg0KDQogICMgbHN0b3BvLW5v
LWdyYXBoaWNzDQogIE1hY2hpbmUgKDk1OE1CIHRvdGFsKQ0KICAgIFBhY2thZ2UgTCMwDQogICAg
ICBOVU1BTm9kZSBMIzAgKFAjMCA0OTFNQikNCiAgICAgIEwzIEwjMCAoMTZNQikgKyBMMiBMIzAg
KDQwOTZLQikgKyBMMWQgTCMwICgzMktCKSArIEwxaSBMIzAgKDMyS0IpICsgQ29yPQ0KZSBMIzAg
KyBQVSBMIzAgKFAjMCkNCiAgICBQYWNrYWdlIEwjMQ0KICAgICAgTlVNQU5vZGUgTCMxIChQIzEg
NDY2TUIpDQogICAgICBMMyBMIzEgKDE2TUIpICsgTDIgTCMxICg0MDk2S0IpICsgTDFkIEwjMSAo
MzJLQikgKyBMMWkgTCMxICgzMktCKSArIENvcj0NCmUgTCMxICsgUFUgTCMxIChQIzEpDQogICAg
ICBIb3N0QnJpZGdlDQogICAgICAgIFBDSUJyaWRnZQ0KICAgICAgICAgIFBDSSBjOTowMC4wIChT
Q1NJKQ0KICAgICAgICAgICAgQmxvY2sgInZkYiINCiAgICBIb3N0QnJpZGdlDQogICAgICBQQ0lC
cmlkZ2UNCiAgICAgICAgUENJIDAyOjAwLjAgKEV0aGVybmV0KQ0KICAgICAgICAgIE5ldCAiZW5w
MnMwIg0KICAgICAgUENJQnJpZGdlDQogICAgICAgIFBDSSAwNTowMC4wIChTQ1NJKQ0KICAgICAg
ICAgIEJsb2NrICJ2ZGEiDQogICAgICBQQ0kgMDA6MWYuMiAoU0FUQSkNCg0KQ3VycmVudGx5IHRo
ZSB2aXJ0aW81LXJlcS4wIElSUSBmb3IgdGhlIHZkYiBkZXZpY2UgZ2V0cyBhc3NpZ25lZCB0byBD
UFUgMDoNCg0KICAjIGNhdCAvcHJvYy9pbnRlcnJ1cHRzDQogICAgICAgICAgICAgQ1BVMCAgICAg
ICBDUFUxDQogIC4uLg0KICAgMzY6ICAgICAgICAgIDAgICAgICAgICAgMCAgIFBDSS1NU0kgMTA1
MzgxODg4LWVkZ2UgICAgICB2aXJ0aW81LWNvbmZpZw0KICAgMzc6ICAgICAgICAgODEgICAgICAg
ICAgMCAgIFBDSS1NU0kgMTA1MzgxODg5LWVkZ2UgICAgICB2aXJ0aW81LXJlcS4wDQoNCklmIG1h
bmFnZWQgSVJRIGFzc2lnbm1lbnQgdGFrZXMgdGhlIGRldmljZSdzIE5VTUEgbm9kZSBpbnRvIGFj
Y291bnQgdGhlbiBDUFUgMQ0Kd2lsbCBiZSB1c2VkIGluc3RlYWQ6DQoNCiAgIyBjYXQgL3Byb2Mv
aW50ZXJydXB0cw0KICAgICAgICAgICAgIENQVTAgICAgICAgQ1BVMQ0KICAuLi4NCiAgIDM2OiAg
ICAgICAgICAwICAgICAgICAgIDAgICBQQ0ktTVNJIDEwNTM4MTg4OC1lZGdlICAgICAgdmlydGlv
NS1jb25maWcNCiAgIDM3OiAgICAgICAgICAwICAgICAgICAgOTIgICBQQ0ktTVNJIDEwNTM4MTg4
OS1lZGdlICAgICAgdmlydGlvNS1yZXEuMA0KDQpUaGUgZmlvIGJlbmNobWFyayB3aXRoIDRLQiBy
YW5kb20gcmVhZCBydW5uaW5nIG9uIENQVSAxIGluY3JlYXNlcyBJT1BTIGJ5IDU4JToNCg0KICBO
YW1lICAgICAgICAgICAgICBJT1BTICAgRXJyb3INCiAgQmVmb3JlICAgICAgICAyNjcyMC41OSA9
QzI9QjEgMC4yOCUNCiAgQWZ0ZXIgICAgICAgICA0MjM3My43OSA9QzI9QjEgMC41NCUNCg0KTm93
IG1vc3Qgb2YgdGhpcyBpbXByb3ZlbWVudCBpcyBub3QgZHVlIHRvIE5VTUEgYnV0IGp1c3QgYmVj
YXVzZSB0aGUgcmVxdWVzdHMNCmNvbXBsZXRlIG9uIHRoZSBzYW1lIENQVSB3aGVyZSB0aGV5IHdl
cmUgc3VibWl0dGVkLiBIb3dldmVyLCBpZiB0aGUgSVJRIGlzIG9uDQpDUFUgMCBhbmQgZmlvIGFs
c28gcnVucyBvbiBDUFUgMCBvbmx5IDM5NjAwIElPUFMgaXMgYWNoaWV2ZWQsIG5vdCB0aGUgZnVs
bA0KNDIzNzMgSU9QUyB0aGF0IHdlIGdldCB3aGVuIE5VTUEgYWZmaW5pdHkgaXMgaG9ub3JlZC4g
U28gaXQgaXMgd29ydGggdGFraW5nDQpOVU1BIGludG8gYWNjb3VudCB0byBhY2hpZXZlIG1heGlt
dW0gcGVyZm9ybWFuY2UuDQoNClRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBhcmUgYSBoYWNrIHRoYXQg
dXNlcyB0aGUgZGV2aWNlJ3MgTlVNQSBub2RlIHdoZW4NCmFzc2lnbmluZyBtYW5hZ2VkIElSUXMu
IFRoZXkgYXJlIG5vdCBtZXJnZWFibGUgYnV0IEkgaG9wZSB0aGV5IHdpbGwgaGVscCBzdGFydA0K
dGhlIGRpc2N1c3Npb24uIE9uZSBidWcgaXMgdGhhdCB0aGV5IGFmZmVjdCBhbGwgbWFuYWdlZCBJ
UlFzLCBldmVuIGZvciBkZXZpY2VzDQp3aXRoIG1hbnkgSVJRcyB3aGVyZSBzcHJlYWRpbmcgYWNy
b3NzIGFsbCBDUFVzIGlzIGEgZ29vZCBwb2xpY3kuDQoNClBsZWFzZSBsZXQgbWUga25vdyB3aGF0
IHlvdSB0aGluazoNCg0KMS4gSXMgdGhlcmUgYSByZWFzb24gd2h5IG1hbmFnZWQgSVJRcyBzaG91
bGQgKm5vdCogdGFrZSBOVU1BIGludG8gYWNjb3VudCB0aGF0DQogICBJJ3ZlIG1pc3NlZD8NCg0K
Mi4gSXMgdGhlcmUgYSBiZXR0ZXIgcGxhY2UgdG8gaW1wbGVtZW50IHRoaXMgbG9naWM/IEZvciBl
eGFtcGxlLA0KICAgcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5KCkgd2hlcmUgdGhlIGNw
dW1hc2tzIGFyZSBjYWxjdWxhdGVkLg0KDQpBbnkgc3VnZ2VzdGlvbnMgb24gaG93IHRvIHByb2Nl
ZWQgd291bGQgYmUgYXBwcmVjaWF0ZWQuIFRoYW5rcyENCg0KU3RlZmFuIEhham5vY3ppICgyKToN
CiAgZ2VuaXJxOiBob25vciBkZXZpY2UgTlVNQSBub2RlIHdoZW4gYWxsb2NhdGluZyBkZXNjcw0K
ICBnZW5pcnEvbWF0cml4OiB0YWtlIE5VTUEgaW50byBhY2NvdW50IGZvciBtYW5hZ2VkIElSUXMN
Cg0KIGluY2x1ZGUvbGludXgvaXJxLmggICAgICAgICAgIHwgIDIgKy0NCiBhcmNoL3g4Ni9rZXJu
ZWwvYXBpYy92ZWN0b3IuYyB8ICAzICsrLQ0KIGtlcm5lbC9pcnEvaXJxZGVzYy5jICAgICAgICAg
IHwgIDMgKystDQoga2VybmVsL2lycS9tYXRyaXguYyAgICAgICAgICAgfCAxNiArKysrKysrKysr
KystLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KDQotLT0yMA0KMi4yNi4yDQoNCg==

