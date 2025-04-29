Return-Path: <linux-pci+bounces-27011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93386AA10F6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B943C5A00A9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FA23D2A3;
	Tue, 29 Apr 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HCmfRlt4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2E23E32B;
	Tue, 29 Apr 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941909; cv=none; b=YvTSYmrFSDaxR7KzAsEa1x70deum98EcBNPgkkBpw3aL621ULpgFfRukJSfysX3iO+JajBEXjNgetP7k7KG2An/RDodA8OYFJ2WjIl3jrdJS1MqMoormcnS9PtYRF4U8SLdoe/QF6wSCJJNg5dQQyXa5Ykl7UcMIJYx5W67E9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941909; c=relaxed/simple;
	bh=DnTNSFiQMa982txtTGvepKRlDKUMmvvPua/94CABBlI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PqdoTR4h/TDKZ0vBO+67ynqB8Pb5ruBoieeZIh1vnyanhTzKaycPrb+DBu8redAS5ouqH8nGJ/+ZZSiH6YMaKwMx+QHTc/z/BKjmUF0a+0Ch2oY1u8JNtCcAGAxrF5DzejTe8FMfh5w2+M0+4XcsLLj3LcdmnEArcO55bISytk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HCmfRlt4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745941586; x=1746546386; i=markus.elfring@web.de;
	bh=DnTNSFiQMa982txtTGvepKRlDKUMmvvPua/94CABBlI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HCmfRlt4okoAETCbUqxka3c2+UkhgqQ0TwiXQG5oN1EQcsBBNgpRJ1LWVnBJFYYZ
	 TmAV9LiflNKPn/z7h+vOFHM6Bmsgi6wXSf/mppmlKG9Hl1HMD5oSUiE8gKq9YB4uk
	 sbptxTnbsxW3WnV1HyV7v/iVeO0kdxyqlveGK1kpU46l3YNCZfh8NkTvawfX3lJdr
	 2MJ3x0ri81pyVjKu/xCDiARUeYsVjNV3OWIacmglqBUebfvcwRBK0zrbXxoEwn/9J
	 LjbV7dFfp93HkBUiG3IV1Z9ZRQqpHPdIP3Frm6jY0izFl4BBcB55blKbUphRw/E5N
	 h+Wmgo07v7TyXaY6nA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.57]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1uYySc3Ccm-00PDIc; Tue, 29
 Apr 2025 17:46:26 +0200
Message-ID: <b3876ccc-8446-433a-a2e9-caf6faaf1995@web.de>
Date: Tue, 29 Apr 2025 17:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhe Qiao <qiaozhe@iscas.ac.cn>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>, Will Deacon <will@kernel.org>
References: <20250429091051.249911-1-qiaozhe@iscas.ac.cn>
Subject: Re: [PATCH v2] ACPI: PCI: Release excess memory usage.
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250429091051.249911-1-qiaozhe@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzKXQKM8YUun6Mb1+1KnJXUqQVWv4oVsPPY372eaUISzFJlypNh
 fjpIGoUMkmhn6rWA7lKakYsGsV+f/e3tGzLKqBLnVs+HlXVjb8lAHygimUtjqAj01I5o/Ny
 ufv+0iT8F//QfQ0oafQmZpS6lmmM+INXc0Bgpevf4aRYtStShelBrGyI+mp60FLrAm7uea5
 rZFSTqQYmOhqc22HJfljA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y3c6w/2B9OY=;RMe9UwOCM+FSFzFIluYM7Rg0hhx
 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
 g==

=E2=80=A6
> the allocated memory should be released to avoid memory occupation.

Will an imperative wording be more desirable for an improved change descri=
ption?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.15-rc4#n94

Do you propose to complete the exception handling?


How will development interests grow for the application of the attribute =
=E2=80=9C__free=E2=80=9D?
https://elixir.bootlin.com/linux/v6.15-rc4/source/include/linux/slab.h#L47=
6

Regards,
Markus

