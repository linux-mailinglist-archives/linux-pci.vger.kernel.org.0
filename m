Return-Path: <linux-pci+bounces-43229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B2CC9033
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8824E307C1B0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824FB34889A;
	Wed, 17 Dec 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML+CcBdF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27980348896;
	Wed, 17 Dec 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991194; cv=none; b=rWyUjP7DP6Ah/Hg4bYcttN8pIiVOtMoGobofLjZa7wUozX9ALfCTL2F+PtOVbc619Y2D0tl6cKa+vdoWXDBAJHBTATDoOZE3rq74sQcxLI2js75t12ZpEpHt2qloG0WH6/BmRuSrnZT3fv4Utm7VA0X3VszCwZ2L6HTzsTieZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991194; c=relaxed/simple;
	bh=sAKwC4gRtNNK3TQbO9Yjipabjn0Jwdl68jqOa48Qlj8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=h0lHfiHWr4FvmUHflrqSVvgxMB1DtLSt0K4GJnkhEDJUbz25OBX5HXw8xlIfWdgPPJwQE7q4PJzc3/8/CMB6rINmmsF73Lm9fJjdiUV4yHUlhRQknxgvXv9pf4AW0FEnfZJw0C6YoYMbFhS02bi+kTfEYe0klQQh0hTmyFyf33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML+CcBdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E0FC4CEF5;
	Wed, 17 Dec 2025 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765991193;
	bh=sAKwC4gRtNNK3TQbO9Yjipabjn0Jwdl68jqOa48Qlj8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ML+CcBdFRwdHU+z/84Sq27+Qn8X/SxjJP6YdXPFRh5LRNgQ+34L0WxrMkjqluTwN0
	 s18GEahFsCvrMLzWk+UmfejAx788pOnTK1INFMSd2FzWWn9K1UcUHFGyuSHDtWipYV
	 jE+emwOv2f84qW7m2wUD09tmTrubZ7+P3OfKUv8QAyOQ4zy8lmZC3SmlB2jIv426TC
	 proRDqL0HaSEPd7oq5XY4YkC8cCmjj5TFqB2FWL3cOiDSuY4L393rwJ+IcXJN8IUo0
	 jlkW9ZDbsISOOHpOeK9E/BsU9aTCTfiIRR6YhDCalvA1BFpgcDxIKtz8tWdI0MiK4H
	 xwBJ9aXtaVaRw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Dec 2025 18:06:30 +0100
Message-Id: <DF0NMOXC5D1E.1B5TGROYDOVW3@kernel.org>
Subject: Re: [PATCH 1/2] rust: pci: document Bar's endianness conversion
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <miguel.ojeda.sandonis@gmail.com>, <dirk.behme@de.bosch.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Marko Turk" <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251210112503.62925-1-mt@markoturk.info>
In-Reply-To: <20251210112503.62925-1-mt@markoturk.info>

On Wed Dec 10, 2025 at 12:25 PM CET, Marko Turk wrote:
> Document that the Bar's MMIO backend always assumes little-endian
> devices and that its operations automatically convert to CPU endianness.
>
> Signed-off-by: Marko Turk <mt@markoturk.info>
> Link: https://lore.kernel.org/lkml/DE7F6RR1NAKW.3DJYO44O73941@kernel.org/

Applied to driver-core-testing, thanks!

    [ Drop unrelated spelling fix. - Danilo ]

