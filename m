Return-Path: <linux-pci+bounces-34475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36947B30001
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BBA7B6372
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653342DE6FC;
	Thu, 21 Aug 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Zl0crzTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FAD531;
	Thu, 21 Aug 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793724; cv=none; b=DfbF81JuE3owNUY94wmI0IM09qS9qV4fXlJzaoLxrTkgXVNzEeBPUwQuLYI9AKIqpqNILvLxufY9ortmhttyIehtJeuR62sF+3CC5MpowOVgZIT6glPYD2qkT1YNTFOXVJLJuYajgd0RSJlNxvGi+g1QosXLxZASEbIFvJYSnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793724; c=relaxed/simple;
	bh=JfN8TfAsyHLHOGMuyTjHdkvdm59TUSIUpHOUS6OfRTs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OhProDHLGpTUk/g1pRLKdkHhdeCE7NmMBsom7BTLry7w5pzbUHMDUEDcoD09Qaxkl6/pgeH9BmK8lIJ1G0lZ+DBURJW88Z333atV6q3CxA+0etf9nq8vochBcCoVJ4LIAVWKE53feaLHgrhB3cazvxgPqBxR9iZwDkZX5czoP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Zl0crzTy; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755793696; x=1756398496; i=markus.elfring@web.de;
	bh=6LltK9z+nCNBEFNTg2yyniOSi1uYpMwAe1Nicq+ev70=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zl0crzTyUovjV/NccYNGuGKqkmiyRMiqh2lwJ2U5vpnKlMiA3VtJiqK7CIfXd8ry
	 /JRwivKNkBwVB7PzSMcGbUiOXL8I2c5zRmtonB08Kv/0te1sEdiqXz5mTa/hxTU2M
	 +2lnOPxulsnZ1oyFDeLpoiYJtENuOYhISRZjRg1Ng1XLEtGuTOPBbK+Ee3O2PnMNQ
	 ZWXrGCRWYTKqDLMzXTmkTczaXO0HwWBIGTQENJis0kdcZsPh5I44kKZf7ttNdAnxM
	 YwKjD3SCG7LAGn32iiKw1QQKZm3SG/lHoiCSX3KUDb/+AIMfD7tgUGVi3oA+X5MER
	 Ud9sb5LpOlQFGe42BQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QQD-1uU4YX2Qdp-014k95; Thu, 21
 Aug 2025 18:28:16 +0200
Message-ID: <8e9936e5-d720-4ded-8961-b9475aeb2ac7@web.de>
Date: Thu, 21 Aug 2025 18:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org, tudor.ambarus@linaro.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rio Liu <rio@r26.me>
References: <20250630142641.3516-2-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250630142641.3516-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HaKdWwNlulyboQI/pkApWr/ExEd1Y349nlGm3GQKQ+lw9Bj6Inj
 ttcKnmNP2GNAhrB/6lSYfoAGJE2SiSiW/AL/Te71SmYOASXanUtEzwLnZgpNu7Yn+MMmB4c
 RRnkAPm2PULIbnnEp/YV1kqC8XVzi6bp4YrEYa4plmHMjdJ0ACognRS6IR/FZvrYbSVNvgF
 ev7+hZgaKSj0aQ1wYJhHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JcGtOXNErk8=;wfrWdYUjEENO9quxak0kYXNBIP7
 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

=E2=80=A6
> Ensure min_align is not increased by the relaxed tail alignment.
=E2=80=A6


=E2=80=A6
+++ b/drivers/pci/setup-bus.c
=E2=80=A6
@@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsign=
ed long mask,
 		if (bus->self && size1 &&
 		    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, typ=
e,
 						   size1, add_align)) {
-			min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
-			min_align =3D max(min_align, win_align);
+			relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
+			relaxed_align =3D max(min_align, win_align);
=E2=80=A6

I wonder why a variable content would be overwritten here
without using the previous value.
https://cwe.mitre.org/data/definitions/563.html

Regards,
Markus

