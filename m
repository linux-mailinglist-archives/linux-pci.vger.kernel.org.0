Return-Path: <linux-pci+bounces-38735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC8BF0E2B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B09D18A39C3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44362301495;
	Mon, 20 Oct 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwpHqtyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869E301703;
	Mon, 20 Oct 2025 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960382; cv=none; b=pTentYSUNPTwl0tfR4dY2s/LkAgp/8Mc0UD1xkRjHmTf68u46dtQad5/aR3b1FKsGlQQLdzCjOPufspuEMgqXaMTLQVI/Ryy/ZkWV3Ma+dfqK/XC+UnE86YkB5dszqXdYd0KZemUq5MLL0wPwLk5TdL0JsNritoRliKis7Sn5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960382; c=relaxed/simple;
	bh=9gTTmWlzY6GrWRl3n5+DPUpimMJxJ59hE2eRIhEVyyw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=RbNqAB38M1zywoqCfLrTq5KwJ+oVTDteLqL/5r93TZ5ZSPS+836vkJImm/MNCjqLn1pjzR2OH7nMcF5ALO+Hr8inm6aoG8xmMp+WSP26tCsgfl8wIsIUVXYM6K+aE7vVZnt7dYAenKKiE3Ki6F3pFZVDBBZxGdQL3S1XSC1E4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwpHqtyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2924C4CEF9;
	Mon, 20 Oct 2025 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760960381;
	bh=9gTTmWlzY6GrWRl3n5+DPUpimMJxJ59hE2eRIhEVyyw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=hwpHqtyE5mnnW9lK+SwQo69k5HYroEaktZQcqfB96Xko+lOcSX+wAPDOURKad2sHY
	 1M9wKxFo0cwCCd1wFN6gBdLwxSdLlHWzXUwDp/HoWIvtRyLKbfdXon3/iBWD8iNWxC
	 /RiLIdwFQpgQMcEj697HIB1pSZcZjC1qi9rbvXPqbCcIWFPIF35LiZtlmSScVfeIFf
	 h6suCKyub6AoTXkS590GZX+VtSIUP5Ae0lVPrcbzf6F33MUy3kAbxTYliXdoV7q0SJ
	 VKwHvX6XoZZOdcOcLG2usRbproVLMAIMZIkgeanjVtzrvEttOCg9q6fK9B2cd+fFVA
	 ID2av17zSiFHQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 13:39:37 +0200
Message-Id: <DDN4CT994FVL.1K6ZLHVNX8RVE@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/3] Rust PCI housekeeping
References: <20251015182118.106604-1-dakr@kernel.org>
In-Reply-To: <20251015182118.106604-1-dakr@kernel.org>

On Wed Oct 15, 2025 at 8:14 PM CEST, Danilo Krummrich wrote:
> Danilo Krummrich (3):
>   rust: pci: implement TryInto<IrqRequest<'a>> for IrqVector<'a>
>   rust: pci: move I/O infrastructure to separate file
>   rust: pci: move IRQ infrastructure to separate file

Applied to driver-core-testing, thanks!

