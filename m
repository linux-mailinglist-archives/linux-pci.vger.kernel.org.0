Return-Path: <linux-pci+bounces-8680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A8905A5A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 20:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559B1B20DB3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632681822F3;
	Wed, 12 Jun 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vGmSgnE7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620117DE0F;
	Wed, 12 Jun 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215704; cv=none; b=EIGQe55hQ2VDLlwGWX2lMhVWAwZuOANmnUGbCxix7GsnupQcfdubKV6RUEkBWJ+NgPCOcw0ib2yKRC2YPh7WSVbJHfNtMSB+Q34msyoUa1U/6Ykdx1oHJCWEJpxTHDwbQH+kR1s5fIv2cz7rp25cA1An2tvTjJ6p9MlF9C5htOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215704; c=relaxed/simple;
	bh=+upB2qwjfiYh/h4iqILkWX9TtN2BUxazXbJYqgaJFwU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rXF33auCbRBG0flsVP3tw/lw3F8BoimfYIgvw4MwBUZje95S6wSVrvIEYx6I1HjhRu57V+uYh6tD5ZbXUeT5ooVg8r+BpcUJSpgthev/XucBxgcGIrnWWoRUZZ80+RLZX0ruynSI6lEjB8IXvcivp5rMFVKhkjIhv7xJUu9Mk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vGmSgnE7; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718215688; x=1718820488; i=markus.elfring@web.de;
	bh=vR1DLMpeZId+aNSKRhK1IPZHvpJqGmjpsDvOr4TyoSw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vGmSgnE7KNFaaX50dHu4QgjuTFa1UNZKTJ73DLJVwXQqNTBvKW3QWPrkrehohXaw
	 qSWCOXbzw0BKaoC3MGuH8hUZ0UJmIDxHoEpaB6zrfHemuARQDJpq2zsbZsNQxW89z
	 MH8vV+QuM/N/xjn8JvJ33g9FkryJr5SF1Xk9zwVWw0YMKEkXARHxVqmILoPoOMMxM
	 8qREhN6s/WfN35OLt6wts5zXzufGvDycT6gTCNW7xMy2PqQXg8dWKH77SDOvoARc0
	 gfWGNegVeYSHLPZuJ6aPmcEALmom/Ua8ApffhaO18xfhsazbPXIihDWwRgrIhGP+n
	 bo11IHtBlwqeBSa/6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1seMZA0zSO-012ymy; Wed, 12
 Jun 2024 20:08:08 +0200
Message-ID: <9bf241c5-68af-4471-a159-1c673243d80d@web.de>
Date: Wed, 12 Jun 2024 20:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hongchen Zhang <zhanghongchen@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, linux-pci@vger.kernel.org,
 loongarch@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240605075419.3973256-1-zhanghongchen@loongson.cn>
Subject: Re: [PATCH v2] PCI: use local_pci_probe when best selected cpu is
 offline
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240605075419.3973256-1-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9f//JL/SkQ4XCesVEpYNO1oXTOIW7yIhuBMzW/ZwJiC5PbBIHZ
 jGaK1lryYCkyWlbYdR/H9NQiYKJ0rWYdQS2r7F2pdSxJluAmVmfg5+CwljOecKDXyHG3ZD/
 rwLRIDRJd7iTv2CMk9rrdX/r+yzM34yWTSZezzo2tnubf/rk5F+CTfkF/lShTX0TetNFuTs
 nWULOH+YX1KshtFg1X0rA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VzkNTr5/WFk=;Neu03KRfGdmlYDdTwUZUknHgAxm
 yBHsmeapQ9/PZx9CLdBka0+SdAFM3QBDDn64NJ29blxmy/Sb+I5qHlQpMb7c5xehkKup0VzDF
 AseCGQVa1YHeK11Dgj2pJ9kZof4AH9WBtDMNLZBMA057yGO8Z5bBdh+H9ME7qXmbs0h+iCnS6
 LzO4BhFbF6ftjidhy1YXVsfOf5cx+eb4XJcpjt+aJ0r2TX29l2msAovwIfIBspdgfwUrM4f97
 82+scXnURXjVm8aPWJgINS5w+oe7EFCIXFTbe1qULVodV/rDIjs+ZSpR5AeVLjizS0BJrQXV0
 9AUefSfvLXXWJiLguZgBS7K4jCP7d5HFx0NZzd9zTCUKpwPvx6zWZZp7rXHddMzH+h530XPTV
 R8V3ltV3baiGqdRc32WMqC5hh3adcwMwCKZ9h+TVoBeU9sfGLyqgRC04fyciNGtEMbMWfwlyh
 tyJ2DzmV6/+Ggxnd9mbefGPgw+38DW2NV/zywTlEZEB4xM4EXM2WQgnINHcVS7YuoflTq2JwX
 sqaDzwVGJvY5kSSrwCWf/BThhEjXooKwDUzsCgZ2/QGKOvZifudPUGx6TJYElfN3HkuXYBcFe
 /mvseqKvUguVJjBf8qKcHGxVi0UI6oeP406ntbwwtJyZlOp6SMzIqqzFL31vaDuHt059MS7OB
 r7e+beZEzJLoHqYMjO5D/H7PRSqur4kKO2oVWl2wsiImZaCklHMOBvY+xnsRExjgWsalxNB6v
 JMQLX6Pr6bDLU9xDE6NfpnED33IG0T6LuCf6jeVhP1pZIH23mvb3ZTb56QcDBu5m+hvm6TzV+
 i9Q1jDT1EOqPxm+xE2e63u1J4hnliR45Fy7CZSz8yH99s=

=E2=80=A6
> This can be happen if a node is online while all its CPUs are offline
> (we can use "maxcpus=3D1" without "nr_cpus=3D1" to reproduce it), Theref=
ore,
> in this case, we should call local_pci_probe() instead of work_on_cpu().

* Please take text layout concerns a bit better into account also accordin=
g to
  the usage of paragraphs.
  https://elixir.bootlin.com/linux/v6.10-rc3/source/Documentation/process/=
maintainer-tip.rst#L128

* Please improve the change description with an imperative wording.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc3#n94

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?

* How do you think about to specify the name of the affected function
  in the summary phrase?


Regards,
Markus

