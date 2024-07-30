Return-Path: <linux-pci+bounces-11016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7BE940E81
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 12:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A86A1F2472D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59174198848;
	Tue, 30 Jul 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="cFSTqbwb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A627194A49;
	Tue, 30 Jul 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333611; cv=none; b=Yl5O0etByBEffg5mJQVrOqZ1KkUBOmUzufhzhoXE40iwO46vfKQS83Is0R8S2zDKSiWB++AfInYCcnThyOn6JZr7LH53F73F9qIDa2EXl1o3Xt/CMaAcBeKziQIg33FNC2XxE4RBaN9F6FJ0sEB/MZBHbJm0kL9uBTpmkKcJhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333611; c=relaxed/simple;
	bh=VKVnO8jReJ4Bgh4LNYlqBwyBLVhtI+mxGjxwPRV7z8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R/RwcRQtKc7HkEnRF6TDuZyQwTkX6Gu2FqrqCGDJmPiT8c1K6YoEvjry6r8kFMtsttdpcGA0VsGSnnoAvBP/TPqHCKQgwptGHpyo1x84BYWzVLFBw/HDsLmKlXZa5nTQUJLvzZAxaAXMS00kzDhr4yUdKC60DoKEn57oAUpKu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=cFSTqbwb; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1722333605; bh=VKVnO8jReJ4Bgh4LNYlqBwyBLVhtI+mxGjxwPRV7z8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cFSTqbwbOGllqs/C6AyhNmJUNT8fIJHbdOndiuH51F2686RUEmCZA6gHtFjKxBGDb
	 IY/iWUJjX+nc+CifkSvqMhjjmblcnY3jVahrkmYpAs0LrqKuJvwZBlM5GJ4xF/lANo
	 ub9HkkIw/O3jrtgtT6rQaVFcqyqm9Dw5oM9V9eVInb73ZyA5GTz+XP4blXTSSV/qTv
	 S62I5f4V0euyKGFzVlB8ixctYuXGCOXk6njbzTPOgKmTeLqVsBQdoftXTBe7xamPV+
	 RmXchCtPTrmIofgvjfPhRcMZ9hM8X2Jc/eGW1pSn3IbbHJB/BZDP/D7An47yKG0w92
	 YNodZsFf1FV5A==
To: Heiner Kallweit <hkallweit1@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivami
 <manivannan.sadhasivam@linaro.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] ath9k: use unmanaged PCI functions in
 ath9k_pci_owl_loader
In-Reply-To: <3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com>
References: <3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com>
Date: Tue, 30 Jul 2024 11:59:50 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875xsnp5d5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Only managed PCI resource in the driver is the iomapped bar. However the =
bar
> is unmapped in the same function. Therefore using the device-managed
> versions just causes overhead, w/o any benefit. Once this is switched to =
the
> non-managed versions, there's nothing left to be managed for
> pcim_enable_device(). Therefore we can reduce overhead here too and switc=
h to
> the non-managed version as well. This includes removing the no longer nee=
ded
> call to pcim_pin_device().
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

