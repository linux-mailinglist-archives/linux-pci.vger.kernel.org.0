Return-Path: <linux-pci+bounces-27013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85FAA110D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E8E3B7362
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA1227BA2;
	Tue, 29 Apr 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mkSdYvRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863602192FE;
	Tue, 29 Apr 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942195; cv=none; b=Jb1bwN6pveqNZ7oOalDsd8I8JYChrV+jtL138vrubNhrbLMG8N49hBq1pp/sPJMW55YBam0IFvxjG4S9Xam3mia/gFF4oDgAe7vZxVXugjt85BOMqXQE9N6YwsdQIWVBbLX59i45QY/CrWFhmCMvsXpMdyX2x64CrRuZeUfQmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942195; c=relaxed/simple;
	bh=8nlWf1HiNlIJd2ze8hcxNAQkxKpTVs533PFedLOHUI8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=f1NMtuITuLQj92zUXlnFvRUkSvF0X8W757bndhzuKfZY4kS37RhQ6eBVELBAKVkM4VRqJK48XNkgqCW2PFBbd/g7Dph/2s30BHPb7OkxLkpguLat50SyY9q76NvHVuTgdytCLHWbUyL7+1gLYnBjzAIg5LQ2w1Ikewfj6KBrNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mkSdYvRc; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745942185; x=1746546985; i=markus.elfring@web.de;
	bh=oXEa4kcM/OxrUbCCm71kggBOZqNhYe6zTRrmMA6LR9c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mkSdYvRc5q8XQPy2rglf6mE7+fF8RpPs3fKhs7Mxdm8e14BeyCeJN9J6cg04e76H
	 bDxgjy6hcuuP8mXM4sF2SWYnmrLT5zxawOkACUUmxQxjllFnZ2peUFfxaFlw4rmg/
	 tMjLFfoLzBOU/6d8Nb/z/IclyaAc9SotU1ztFp4p8jvJyWPANiu/iZNQ6nonEgt69
	 dpx7ZrIBtKp5vus1lEviQSJ1NkTdtGozTimcspknbKwsaENVQShIOs1XOpL/jp1sj
	 ZiYwOMjJ2AdcNixnhVkEZY/fO1Cw2EWVj/A9Mwk9GwOwSox7M+s4RYpz162zuzjBI
	 HASXQK69oWjuwkooOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.57]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1v6NNn03Wg-00vXHR; Tue, 29
 Apr 2025 17:56:25 +0200
Message-ID: <538f8456-1b28-4e7b-83ae-71b4c4ebcf8b@web.de>
Date: Tue, 29 Apr 2025 17:56:21 +0200
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
Subject: Re: [PATCH v2] ACPI: PCI: Release excess memory usage
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250429091051.249911-1-qiaozhe@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o/qCyeBpAqJ/Qi5y6kGMZKGPYMvfM09TnPWAo9TxJd+Ot0t1n4W
 WrURYnKeCJm7MXAbeuwWhYVaAH19k3UabKbiQWoWJnpHQD12t1B4s8C1ftJ1Gwf6R+/fVfs
 +CPMXFSVfpfi4mUCHCDZbh0gxK9BrRzkb2NLzX0Es80mRK6KRhN2DEnSvwPspj4HWPSkY5J
 WoF1odvkkiO+RFpvPTh4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pqb6i9LD+xE=;sHj5mo69ZGJrWrfDJ2ElWp9mhkZ
 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
 wEv61jEU9eTz0=

=E2=80=A6
> +++ b/drivers/pci/pci-acpi.c
> @@ -1677,15 +1677,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_p=
ci_root *root)
> =20
>  	root_ops =3D kzalloc(sizeof(*root_ops), GFP_KERNEL);
>  	if (!root_ops) {
> -		kfree(ri);
> -		return NULL;
> +		goto free_ri;
>  	}

Would you like to omit curly brackets around a single statement?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.15-rc4#n197

Regards,
Markus

