Return-Path: <linux-pci+bounces-18816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA19F860D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB385189221C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813211B85D3;
	Thu, 19 Dec 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="jTrcT0h6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8B1C1F15;
	Thu, 19 Dec 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640682; cv=none; b=WvswW2YQmzyDkpPfeY7ZeppELXnHVrS04LU0LMv3wG+1RAebWKaeYs91ZmtHFBrE5OYrhxaTtvDuLFWloTLcexoqd9lPu/kP65zUvqIBz5PZmUAsHXb/cQFRuXRkqvcixcg4TyYz9uSvdqVBFMbIsNxD1YNHjhihQQBXlVGzZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640682; c=relaxed/simple;
	bh=FEnaOwVQrkTc6L6pkdi0G9x7Taz7LOoQ4NsMeOGf0t4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=kl01DoN+fX9gOiOZNcEu9YR+CXml3+ZdvN9tf1z7PRQ+1GL0jsh9jRU8eMLAHZh9t0L1rU+YrLM5ajtuPwaoNLeRfpLvGQMEaZGTTmjsJVFF+/frgJ98+0JhBMgMxvbBVhYx3S3QJanKJEt2HVd/rDgK3t9BTcaBMm4sRb9eYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=jTrcT0h6; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4YDj6Y6T4qz4T8S;
	Thu, 19 Dec 2024 15:37:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734640679; bh=FEnaOwVQrkTc6L6pkdi0G9x7Taz7LOoQ4NsMeOGf0t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jTrcT0h6gmKlu23s8VsN1s/49NpPZYhlxBKobAYvLCEagdG/4IxuTAqIbFw8NBd4H
	 Ffx/uwuNCt9P849SZgaQ9w5gpqAtNgmKYEFebK3fRt7+jiZYd3+1zRDHfWFD6To7SV
	 yk0rx/XHpaYtYmZ5i1BxzzhbHzsXA6VNDyXBs948=
Content-Type: multipart/mixed; boundary="------------XETfFMsvRHrtHU1hk5awnmMv"
Message-ID: <7ad6b642-b31e-438c-97fb-840542740499@panix.com>
Date: Thu, 19 Dec 2024 12:37:56 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: david.e.box@linux.intel.com, rafael@kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 Nirmal Patel <nirmal.patel@linux.ntel.com>, Kenneth Crudup <kenny@panix.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20241213230214.GA3434438@bhelgaas>
 <ffeae6a38215df37d8c109c16fd8b6713687ba77.camel@linux.intel.com>
 <28fd68e1-f76f-40a9-89a8-a24d693209c1@panix.com>
 <2ed90445e8e39a76e58a37712ca75ba40d121c15.camel@linux.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <2ed90445e8e39a76e58a37712ca75ba40d121c15.camel@linux.intel.com>

This is a multi-part message in MIME format.
--------------XETfFMsvRHrtHU1hk5awnmMv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Or, just use (some version of) the attached patch (against Linus' recent 
master) that enables VMD ASPM this for us "automatically" if there's a 
detected VMD ?

I'd prefer a scalpel to a bludgeon (and have been trying to get some 
version of these fixes into mainline for a while).

-Kenny

On 12/19/24 11:52, David E. Box wrote:

> If you want to override this behavior, you can try setting pcie_aspm=force on
> the kernel command line.

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------XETfFMsvRHrtHU1hk5awnmMv
Content-Type: text/plain; charset=UTF-8; name="aspm-enable-take-2"
Content-Disposition: attachment; filename="aspm-enable-take-2"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIGIvZHJpdmVycy9wY2kvcGNp
ZS9hc3BtLmMKaW5kZXggMjg1NjdkNDU3NjEzLi5hNWRmNjIzMGNmM2MgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5j
CkBAIC03NjgsNiArNzY4LDMxIEBAIHN0YXRpYyB2b2lkIGFzcG1fbDFzc19pbml0KHN0cnVj
dCBwY2llX2xpbmtfc3RhdGUgKmxpbmspCiAJCWFzcG1fY2FsY19sMTJfaW5mbyhsaW5rLCBw
YXJlbnRfbDFzc19jYXAsIGNoaWxkX2wxc3NfY2FwKTsKIH0KIAorLyoKKyAqIEJJT1MgbWF5
IG5vdCBiZSBhYmxlIHRvIGFjY2VzcyBjb25maWcgc3BhY2Ugb2YgZGV2aWNlcyB1bmRlciBW
TUQgZG9tYWluLCBzbworICogaXQgcmVsaWVzIG9uIHNvZnR3YXJlIHRvIGVuYWJsZSBBU1BN
IGZvciBsaW5rcyB1bmRlciBWTUQuCisgKi8KK3N0YXRpYyBib29sIHBjaV9maXh1cF92bWRf
YnJpZGdlX2VuYWJsZV9hc3BtKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworICAgICAgIHN0
cnVjdCBwY2lfYnVzICpidXMgPSBwZGV2LT5idXM7CisgICAgICAgc3RydWN0IGRldmljZSAq
ZGV2OworICAgICAgIHN0cnVjdCBwY2lfZHJpdmVyICpwZHJ2OworCisgICAgICAgaWYgKCFw
Y2lfaXNfcm9vdF9idXMoYnVzKSkKKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKwor
ICAgICAgIGRldiA9IGJ1cy0+YnJpZGdlLT5wYXJlbnQ7CisgICAgICAgaWYgKGRldiA9PSBO
VUxMKQorICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOworCisgICAgICAgcGRydiA9IHBj
aV9kZXZfZHJpdmVyKHRvX3BjaV9kZXYoZGV2KSk7CisgICAgICAgaWYgKHBkcnYgPT0gTlVM
TCB8fCBzdHJjbXAoInZtZCIsIHBkcnYtPm5hbWUpKQorICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOworCisgICAgICAgcGNpX2luZm8ocGRldiwgImVuYWJsZSBBU1BNIGZvciBwY2kg
YnJpZGdlIGJlaGluZCB2bWQiKTsKKyAgICAgICByZXR1cm4gdHJ1ZTsKK30KKwogc3RhdGlj
IHZvaWQgcGNpZV9hc3BtX2NhcF9pbml0KHN0cnVjdCBwY2llX2xpbmtfc3RhdGUgKmxpbmss
IGludCBibGFja2xpc3QpCiB7CiAJc3RydWN0IHBjaV9kZXYgKmNoaWxkID0gbGluay0+ZG93
bnN0cmVhbSwgKnBhcmVudCA9IGxpbmstPnBkZXY7CkBAIC04NDYsNyArODcxLDggQEAgc3Rh
dGljIHZvaWQgcGNpZV9hc3BtX2NhcF9pbml0KHN0cnVjdCBwY2llX2xpbmtfc3RhdGUgKmxp
bmssIGludCBibGFja2xpc3QpCiAJfQogCiAJLyogU2F2ZSBkZWZhdWx0IHN0YXRlICovCi0J
bGluay0+YXNwbV9kZWZhdWx0ID0gbGluay0+YXNwbV9lbmFibGVkOworCWxpbmstPmFzcG1f
ZGVmYXVsdCA9IHBjaV9maXh1cF92bWRfYnJpZGdlX2VuYWJsZV9hc3BtKHBhcmVudCkgPwor
CQlQQ0lFX0xJTktfU1RBVEVfQVNQTV9BTEwgOiBsaW5rLT5hc3BtX2VuYWJsZWQ7CiAKIAkv
KiBTZXR1cCBpbml0aWFsIGNhcGFibGUgc3RhdGUuIFdpbGwgYmUgdXBkYXRlZCBsYXRlciAq
LwogCWxpbmstPmFzcG1fY2FwYWJsZSA9IGxpbmstPmFzcG1fc3VwcG9ydDsK

--------------XETfFMsvRHrtHU1hk5awnmMv--

