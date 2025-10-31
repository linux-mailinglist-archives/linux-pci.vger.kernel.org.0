Return-Path: <linux-pci+bounces-39935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF46C2555C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF0351503
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD7C2550AF;
	Fri, 31 Oct 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="ShO+uEFY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968070814;
	Fri, 31 Oct 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918458; cv=none; b=EsvmV/NzX/LB7yDWDqDI6Er3DuWVkNhrWFE1eIby+xD5CZ7kreeEnxeyG4sr6RUX8bjwXO9UgswnaeCCozhTtbSgWw5UpJ8z3ymi6w0LMnsMciQB6e0UKu3ESJLdCuz/hrPnBTXdQMGsP2ZuQvJAc2HD1YZUrcTsNtqhoBeH4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918458; c=relaxed/simple;
	bh=RGf9cfCIhxuq/vaRuNGbk2qeO2YTTDICUdifwVGN2Ps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pA5+D3qg5+Caf/kcNdSQ3wjog04qXMh0XPVaqWQDMw9WSJ53cU/8uWbc/yXCcvXXr+BNinsu8/NaRcRZUm5TXymwQrOzQZB/vBKI7rYKdwRsqo1qhGqDIbLENC0iSYmBnX8U6G9wjiHlgcs3FiwQw2aSzJRYAY2/FKsqNdruD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=ShO+uEFY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761918441; x=1762523241; i=spasswolf@web.de;
	bh=eEf9FtMftpf7rRdhDbyeVWuCRJ8OhLV37hbp0uqbBD4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ShO+uEFYOmYlOgvsAsuB5M2OswcdOTiSek/gSQkissa60zfCH5rz0Yb0AFxwWYQx
	 zbT8gxIpizohDkhQGHJOlm2sf2O5t7h5mmNeEBfF8QBZUHXEdcxnJqU6oSpNNBZlW
	 H0GXf6y9diutdl7UitbJDgmwXtAxjiiHeB9npZi9YxePYiCoHLjJUPwLpNB9PEWGf
	 Fuy/KYO4XyetNI2Wo2EPlakQjNpwsUwLoSMzpeQMmb98bYMnxtWJSaP4CPATXzpmQ
	 D5JhTg9sOisvEOzgWoAo2CXY9tnglwLJjkXx2PHo5GN+7dhUXdrkqJrqS95xmvA8Q
	 fJh0lUdppUaJpZBcgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1vVOO52iRQ-00Tpm6; Fri, 31
 Oct 2025 14:47:21 +0100
Message-ID: <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Mario
 Limonciello <superm1@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, spasswolf@web.de
Date: Fri, 31 Oct 2025 14:47:20 +0100
In-Reply-To: <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
					 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
					 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
					 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
					 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
		 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
	 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EjRqDMd/Z70FrDVz13IfKacOJSLO+KqbIRk3DhAnL3MhjrI/TPe
 hgag+npBPbfOJsus7sL7uxfamxeJGX78r2y0RV08TjDwY9RbUMx0eV0cLT+HviCHf5bX5ld
 ZarmhKmP7UOEhrN9vI44sDiwAZiDOWNNLitwP/Gm2pGXDFL0hl9GplQdCS8BUyXTCbI2Fop
 MU5nQv5zd+LR53ljbbAJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pzeKkoOKzOQ=;+MX7KvkhiMrJ7amnBNF6vIVRSnJ
 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
 jDYFg==

Upon closer inspection I noticed that the PCIe bandwitdth has been reduced=
:

>=20
> [76621.870884] [    T140] pcieport 0000:01:00.0: Unable to change power =
state from D3cold to D0, device inaccessible
> [76621.870977] [    T140] pcieport 0000:02:00.0: Unable to change power =
state from D3cold to D0, device inaccessible
> [76621.876006] [    T140] pci_bus 0000:03: busn_res: [bus 03] is release=
d
> [76621.878237] [    T140] pci_bus 0000:02: busn_res: [bus 02-03] is rele=
ased
> [76621.879867] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Card p=
resent
> [76621.879873] [    T140] pcieport 0000:00:01.1: pciehp: Slot(0): Link U=
p
> [76622.006565] [    T140] pci 0000:01:00.0: [1002:1478] type 01 class 0x=
060400 PCIe Switch Upstream Port
> [76622.006606] [    T140] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc0=
3fff]
> [76622.006616] [    T140] pci 0000:01:00.0: PCI bridge to [bus 02-03]
> [76622.006630] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfca00=
000-0xfcbfffff]
> [76622.006644] [    T140] pci 0000:01:00.0:   bridge window [mem 0xfc000=
00000-0xfe0fffffff 64bit pref]
> [76622.006772] [    T140] pci 0000:01:00.0: PME# supported from D0 D3hot=
 D3cold

The PCIe band with seems to be have been reduce to PCIe 1.0 (2.5GT/s):

> [76622.006874] [    T140] pci 0000:01:00.0: 16.000 Gb/s available PCIe b=
andwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126=
.024 Gb/s with
> 16.0 GT/s PCIe x8 link)
>=20
> Bert Karwatzki

This is the same message from system startup (here it's PCIe 3.0 (8.0GT/s)=
, which is the PCIe version
of the CPU (AMD Ryzen 7 5800H with Radeon Graphics)):=09
[    0.289221] [      T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.0=
24 Gb/s with
16.0 GT/s PCIe x8 link)

Bert Karwatzki

