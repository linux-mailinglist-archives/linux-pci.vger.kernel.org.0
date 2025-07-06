Return-Path: <linux-pci+bounces-31575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E82AFA2E9
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 06:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADFE1898161
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 04:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0084157A55;
	Sun,  6 Jul 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Xh6af3Gm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82714F9FB
	for <linux-pci@vger.kernel.org>; Sun,  6 Jul 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751774577; cv=none; b=Mg9cEkYeztsasxCbo6H79s9gMt8Tz6REgpPVp77slEXa7LTHc6niz5eBfH3aw87fyqSgUJ9f0im2sBDf0a9UbjdGlM52jv4Iatq7mgOJZoOT/uDvbUOoreFeEqu3k0gqSoAixGKy/WAtbzr5z1NnTKl1bASi8tXKVUPpRldQiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751774577; c=relaxed/simple;
	bh=XUcla0D10S+FckZ5tz4NRtTk78TPjbZ56REYXBR5dfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzEZj9tt3bC6dNp88InB6YiULgC+pcsB3iERZz9VG/Ld216k/NpVEXaMPD5JZ+wmujgRwYzzUvgq13rDplkIyB6fjWVNy8zlqvQSWE5Ox8Kx+Rlz++xoq+kTMmPkzN0vm7KPGBu+bsCKXMlFygjBDNKKmEp9oA4Rl18JC9lPKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Xh6af3Gm; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1751774567; x=1752033767;
	bh=XUcla0D10S+FckZ5tz4NRtTk78TPjbZ56REYXBR5dfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Xh6af3GmW36yM4lBbp46Kezb5/LM8ouSJjQ3u4MGb5E7AddAIMnG0Uf6f9/sCvxFy
	 SGDonGKjugDI/gTpbzhpcThcJfprXhKaI45twJhUVLFU5ohoDDEDk+zElZoIKw1w1w
	 n8P6pcg35i+WAD8cpxCHSkTp67a4Bnx1oasAz5+LyYwG9Hua0POEnhuY/K3SLIB5c8
	 vhUaI5rP6+EdUnx/8AhYCU/llFjBPTJttdHp2pyoY0GOWh+WMekX2QNIbeXRszHuwF
	 rzigVazRpTtQv5W+2ltmy1tzE8O7vGFix50NbZKbJeJFpZMgAlNG/ufnXoRrjoyqSy
	 73umzYYEk5/kA==
Date: Sun, 06 Jul 2025 04:02:41 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
Message-ID: <87seja7yqs.fsf@protonmail.com>
In-Reply-To: <aGkJCix2VPaawyP-@pollux>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com> <aGkJCix2VPaawyP-@pollux>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: eb9a5b0037f81516df17176bb2cf4c90669c86e5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 05 Jul, 2025 13:14:18 +0200 "Danilo Krummrich" <dakr@kernel.org> wr=
ote:
> On Sun, Jun 29, 2025 at 05:57:56AM +0000, Rahul Rameshbabu wrote:
>> Device instances in the pci crate represent a valid struct pci_dev, not =
a struct
>> device.
>>
>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>
> This commit has two checkpatch warnings, can you please fix them, add a '=
Fixes:'
> tag and send a v2?

Sorry about that. I was traveling with a new laptop when I drafted this
patch, so my setup was not correct. Should have run checkpatch either
way before sending this out.

v2: https://lore.kernel.org/rust-for-linux/20250706035944.18442-3-sergeants=
agara@protonmail.com/

Thanks,
Rahul Rameshbabu


