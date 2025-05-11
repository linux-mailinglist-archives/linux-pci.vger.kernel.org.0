Return-Path: <linux-pci+bounces-27559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B197AB2AE6
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 22:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF77C7A485D
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD351A304A;
	Sun, 11 May 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="e9f0mwSl"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277419E7D0;
	Sun, 11 May 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746995425; cv=none; b=S/Pf++HIYWge0IXqwd1n2F2Ixbe4o64iYwpmicu8Zm84swa0hVLtpMyGkZYubMCa61SOwV3r74HApzfId91itgS5EbyD8sJ8BO6n1ELhU2xBhC2S0Y0XRvety+3pEwANJOSomRUtNwjRJgk1Lhlb+/rH8IKFLIJNJHcxGIgbhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746995425; c=relaxed/simple;
	bh=dko0hlc59DADvevFuApFKLXukjCJqFTu+nVdEA3DQMs=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VkStQhx4+5awKwvITmA4DBEBQimiMQnFzMAJDa0z83SzX+WfyrPm8zJStmUwLKSSoAiEZFj3/oF0/CbDKqS55wvmOKWNJkjb9A+BcF3muKAWh63HgyMNWMMDLkbgIXoLmwoJVo/OVZTo5ZJM9pMuNR9BFFS8xNeTgjn8q6JyzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=e9f0mwSl; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4ZwYky1lfnzDRm;
	Sun, 11 May 2025 16:10:34 -0400 (EDT)
Received: from xps-9320 (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4ZwYkp0xm4z1CtP;
	Sun, 11 May 2025 16:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1746994227; bh=dko0hlc59DADvevFuApFKLXukjCJqFTu+nVdEA3DQMs=;
	h=Date:From:Reply-To:To:cc:Subject;
	b=e9f0mwSlSSg8X8hLPiyAk4BkmVl4ND1Gfzskfblydaf4wDfQ0h9hnPjTVkTfdDyQH
	 p6Emmc6OaN6TK+4kSAz1s0Dtpc7CWfGBZmYaAc7m/ZRYN+T2ZPrJv2H9wjOtfrrzBQ
	 UshiE2nePhhEdS3HoMtvJsr9DdVo7fPNuDGnSCR4=
Date: Sun, 11 May 2025 13:10:24 -0700 (PDT)
From: "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To: rafael@kernel.org, linux-pm@vger.kernel.org
cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, 
    Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Andrea Righi <andrea.righi@canonical.com>, 
    You-Sheng Yang <vicamo.yang@canonical.com>, linux-pci@vger.kernel.org, 
    "Kenneth R. Crudup" <kenny@panix.com>
Subject: Raphael, I'd like your help upstreaming this VMD power-saving patch,
 please
Message-ID: <0b166ece-eeec-ba5d-2212-50d995611cef@panix.com>
Errors-To: kenny@panix.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-351450562-1746994227=:150664"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-351450562-1746994227=:150664
Content-Type: text/plain; charset=US-ASCII


Hello Raphael,

For almost two years now, I've been trying to get patches from Ubuntu that
enable ASPM for devices behind Intel's VMD, necessary to get full lower-power
states (including very-reduced power usage during s0ix sleep) on my Alderlake
(et al.) laptop, upstreamed into mainline.

One such thread: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/

Since the original set of patches on this, most of the work has been pushed
upstream, with only this last patch required to get fully into the "CPU%LPI"
and "SYS%LPI" (names according to "turbostat") states.

I'm surprised that with the number of VMD-enabled laptops out there (which I
had to keep on so I could dual-boot into Win11 (the disk geometry changes if
I disable it, rendering the Win11 partition useless)), that there haven't been
many reports of excessive power usage in Linux during sleep; perhaps because
many installations are running stock Ubuntu kernels (where I assume variants
of this patch remain) it isn't an issue, but I do believe having this upstreamed
is still valuable.

I don't have the resources you've got to test this fully for regressions, nor
the expertise getting a patch into the kernel, so I'd like to again bring this
up for discussion (hence the phone-book of a CC: here).

If there's anything I can do to help get this done, please let me know.

Thank you,

-Kenneth Crudup

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
--8323329-351450562-1746994227=:150664
Content-Type: text/x-diff; name=0001-PCI-ASPM-Fixup-ASPM-for-VMD-bridges.patch
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=0001-PCI-ASPM-Fixup-ASPM-for-VMD-bridges.patch

RnJvbSBlZTM2MThhNTk4YTI2MWJiYzhhODc1NTU3ZDQyZDZkYmJiYzRjZGQw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogIktlbm5ldGggUi4g
Q3J1ZHVwIiA8a2VubnlAcGFuaXguY29tPg0KRGF0ZTogRnJpLCAxMyBEZWMg
MjAyNCAxNToyODo0MiAtMDgwMA0KU3ViamVjdDogW1BBVENIXSBQQ0kvQVNQ
TTogRml4dXAgQVNQTSBmb3IgVk1EIGJyaWRnZXMNCg0KRWZmZWN0aXZlbHkg
YSBzcXVhc2hlZCBjb21taXQgb2Y6DQpVQlVOVFU6IFNBVUNFOiBQQ0kvQVNQ
TTogRW5hYmxlIEFTUE0gZm9yIGxpbmtzIHVuZGVyIFZNRCBkb21haW4NClVC
VU5UVTogU0FVQ0U6IFBDSS9BU1BNOiBFbmFibGUgTFRSIGZvciBlbmRwb2lu
dHMgYmVoaW5kIFZNRA0KVUJVTlRVOiBTQVVDRTogdm1kOiBmaXh1cCBicmlk
Z2UgQVNQTSBieSBkcml2ZXIgbmFtZSBpbnN0ZWFkDQotLS0NCiBkcml2ZXJz
L3BjaS9wY2llL2FzcG0uYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9h
c3BtLmMgYi9kcml2ZXJzL3BjaS9wY2llL2FzcG0uYw0KaW5kZXggMjlmY2Iw
Njg5YTkxLi5mZGMxY2UyNzU1ZmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bj
aS9wY2llL2FzcG0uYw0KKysrIGIvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMN
CkBAIC03ODgsNiArNzg4LDMxIEBAIHN0YXRpYyB2b2lkIGFzcG1fbDFzc19p
bml0KHN0cnVjdCBwY2llX2xpbmtfc3RhdGUgKmxpbmspDQogCQlhc3BtX2Nh
bGNfbDEyX2luZm8obGluaywgcGFyZW50X2wxc3NfY2FwLCBjaGlsZF9sMXNz
X2NhcCk7DQogfQ0KIA0KKy8qDQorICogQklPUyBtYXkgbm90IGJlIGFibGUg
dG8gYWNjZXNzIGNvbmZpZyBzcGFjZSBvZiBkZXZpY2VzIHVuZGVyIFZNRCBk
b21haW4sIHNvDQorICogaXQgcmVsaWVzIG9uIHNvZnR3YXJlIHRvIGVuYWJs
ZSBBU1BNIGZvciBsaW5rcyB1bmRlciBWTUQuDQorICovDQorc3RhdGljIGJv
b2wgcGNpX2ZpeHVwX3ZtZF9icmlkZ2VfZW5hYmxlX2FzcG0oc3RydWN0IHBj
aV9kZXYgKnBkZXYpDQorew0KKyAgICAgICBzdHJ1Y3QgcGNpX2J1cyAqYnVz
ID0gcGRldi0+YnVzOw0KKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7DQor
ICAgICAgIHN0cnVjdCBwY2lfZHJpdmVyICpwZHJ2Ow0KKw0KKyAgICAgICBp
ZiAoIXBjaV9pc19yb290X2J1cyhidXMpKQ0KKyAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCisNCisgICAgICAgZGV2ID0gYnVzLT5icmlkZ2UtPnBh
cmVudDsNCisgICAgICAgaWYgKGRldiA9PSBOVUxMKQ0KKyAgICAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCisNCisgICAgICAgcGRydiA9IHBjaV9kZXZf
ZHJpdmVyKHRvX3BjaV9kZXYoZGV2KSk7DQorICAgICAgIGlmIChwZHJ2ID09
IE5VTEwgfHwgc3RyY21wKCJ2bWQiLCBwZHJ2LT5uYW1lKSkNCisgICAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQorDQorICAgICAgIHBjaV9pbmZvKHBk
ZXYsICJlbmFibGUgQVNQTSBmb3IgcGNpIGJyaWRnZSBiZWhpbmQgdm1kIik7
DQorICAgICAgIHJldHVybiB0cnVlOw0KK30NCisNCiBzdGF0aWMgdm9pZCBw
Y2llX2FzcG1fY2FwX2luaXQoc3RydWN0IHBjaWVfbGlua19zdGF0ZSAqbGlu
aywgaW50IGJsYWNrbGlzdCkNCiB7DQogCXN0cnVjdCBwY2lfZGV2ICpjaGls
ZCA9IGxpbmstPmRvd25zdHJlYW0sICpwYXJlbnQgPSBsaW5rLT5wZGV2Ow0K
QEAgLTg2Niw3ICs4OTEsOCBAQCBzdGF0aWMgdm9pZCBwY2llX2FzcG1fY2Fw
X2luaXQoc3RydWN0IHBjaWVfbGlua19zdGF0ZSAqbGluaywgaW50IGJsYWNr
bGlzdCkNCiAJfQ0KIA0KIAkvKiBTYXZlIGRlZmF1bHQgc3RhdGUgKi8NCi0J
bGluay0+YXNwbV9kZWZhdWx0ID0gbGluay0+YXNwbV9lbmFibGVkOw0KKwls
aW5rLT5hc3BtX2RlZmF1bHQgPSBwY2lfZml4dXBfdm1kX2JyaWRnZV9lbmFi
bGVfYXNwbShwYXJlbnQpID8NCisJCVBDSUVfTElOS19TVEFURV9BU1BNX0FM
TCA6IGxpbmstPmFzcG1fZW5hYmxlZDsNCiANCiAJLyogU2V0dXAgaW5pdGlh
bCBjYXBhYmxlIHN0YXRlLiBXaWxsIGJlIHVwZGF0ZWQgbGF0ZXIgKi8NCiAJ
bGluay0+YXNwbV9jYXBhYmxlID0gbGluay0+YXNwbV9zdXBwb3J0Ow0KLS0g
DQoyLjQ4LjENCg0K

--8323329-351450562-1746994227=:150664--

