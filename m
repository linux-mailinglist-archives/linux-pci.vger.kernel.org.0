Return-Path: <linux-pci+bounces-32599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74504B0B676
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EE21894E11
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967220B7E1;
	Sun, 20 Jul 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1x2dGra"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92A3FFD;
	Sun, 20 Jul 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022026; cv=none; b=OTr8QPpcIyxwnJeNPVjSWsSZfyiFGpZKO0+GAMkPlqp5z5NB0wkB28m3IlTDgjXzm6R96C/6gE7r6h1deu+NQTq6MS667+CHfsVHD5/VJURQy/wD+7rXmYyzvaI5CNQOTxlDjtTwpzrd2OIEDmZzA3M5RH62xue/Q/cjbj803ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022026; c=relaxed/simple;
	bh=GD1u2qOgXW62+IQa9PaK4pPCvAbLxB7NgCQp0EbBPtI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D5PawR8m73ARU/qZH8NAnWYhtQ10TxKm7HcUx5Cs294Y/K4jhyrr+SZbF2g46olrzKRMYC1QVTrEdeCW3b9aH3UC/AiHbVGJFqhlKfu2vkiySroS5bQpJlX0jftZUCgQeJ8k22PHyl3dIB4DkEUoIJKKKxWIl6wFm5ZZxo/nmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1x2dGra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8B3C4CEE7;
	Sun, 20 Jul 2025 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753022025;
	bh=GD1u2qOgXW62+IQa9PaK4pPCvAbLxB7NgCQp0EbBPtI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=P1x2dGra8tMOdCRyDNlGy3Obec3yywmwHWcPYj0tBgc8mPU9ID/DtcxE/uxadiB7u
	 87LZdIjm3EYxST9y/FlAmXicHEf+zXwcoYlevqQlzvraF0x6BfvaeGbU9B91QDSncE
	 6NXfl1MkHFPcT5ahWnaZHDZEShfQdSZ0JkI6gk60Uks6+BK//HIU6ANduw4YRXLvt2
	 ZNmuqRqvYJW7Tpq7bf7rG5FTbECtmFOPe3Tjasnt3vskMxiAb5b8qTUXTlKyb1MfsF
	 9vEyJtI8E+YBsyIkFkM1J+3+g6shY7E1bl/ydBNN4b0sueA9jOR0cvTLSjNU/NPTux
	 MADrOa/swk4+Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jul 2025 16:33:39 +0200
Message-Id: <DBGYFY5IFQ24.57509R84DUS7@kernel.org>
Subject: Re: [PATCH v2 0/5] dma::Device trait and DMA mask
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250716150354.51081-1-dakr@kernel.org>
In-Reply-To: <20250716150354.51081-1-dakr@kernel.org>

On Wed Jul 16, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
> This patch series adds the dma::Device trait to be implemented by bus dev=
ices on
> DMA capable busses.

Applied to driver-core-testing, thanks!

