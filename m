Return-Path: <linux-pci+bounces-1323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD8781D6B6
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A52028223E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB4171BE;
	Sat, 23 Dec 2023 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JE+Rf86o"
X-Original-To: linux-pci@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4866171A7;
	Sat, 23 Dec 2023 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E499A7DA;
	Sat, 23 Dec 2023 22:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E499A7DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703369394; bh=OXOIVnxtmX39z47YuVWgbI8eYICUPrpgSK3IgT0gudM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JE+Rf86ooM+2gjN6Ba9hufEzLnh2j13L/+CVudlo0CT5NNyeiqX1VqO/eebNz9MkH
	 LW+hXfqdbRb/WkErsh6BEEYFcymkEL1FRhJwfCal9BsavPeVVpyUej13bVeBnA250O
	 UcBPLuCuEMeUvitGQ7fs+B3+7JGJh2+Tpd855mHWy1FkuLVzEGfj6Y3C4Ld7ehiYJu
	 IpzezmjHpn/iyLl+jQA8jpMlaxqJTGmdo+2mN2RQOJyPVRvdlQpsMOzKJQgmQFy1A7
	 TXZLSOe3ntINdlKr5cVvImLG66fsaIYwfSA+guNEjhFdMi8HpYzLwa7zL3j7iCpsNH
	 JOvBIOk9Bm97g==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, attreyee-muk
 <tintinm2017@gmail.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/PCI: fix spelling mistake in boot-interrupts
In-Reply-To: <6026d9b5-dd6f-43f8-acc7-9cc77bdb3df3@infradead.org>
References: <20231223184412.25598-1-tintinm2017@gmail.com>
 <6026d9b5-dd6f-43f8-acc7-9cc77bdb3df3@infradead.org>
Date: Sat, 23 Dec 2023 15:09:53 -0700
Message-ID: <87jzp4605q.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> On 12/23/23 10:44, attreyee-muk wrote:
>> Correct to =E2=80=9Cre-enabled=E2=80=9D from =E2=80=9Creenabled=E2=80=9D.
>>=20
>> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
>
> Is "reenabled" confusing? I don't have a problem with it, but
> one web page [1] says that it's OK to use "re-" if not having
> the hyphen can be confusing.
>
> [1] https://www.grammarbook.com/blog/hyphens/hyphens-with-the-prefix-re/
>
> OTOH, some web sites say the "reenable" is OK, at least as an
> alternative spelling.

Either is probably fine; so I'm not quite sure why this is worth
changing?

Thanks,

jon

