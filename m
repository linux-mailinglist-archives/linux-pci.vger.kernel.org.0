Return-Path: <linux-pci+bounces-44123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAACFAEBC
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 21:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24F1730010D3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62DB33A6E4;
	Tue,  6 Jan 2026 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCeKdYVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EF1D47B4;
	Tue,  6 Jan 2026 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731451; cv=none; b=uJutFwHExlPPkdxIoXc5ETfVmwbekJ+SUUJ0r9iPLFxILRCrtspF4scKvJYNroM2oIuY6zTtVc9ieUSzMqCuZBh3MqVyFHI9ndPXfH6AndG2Ew1iyveCiX5gHXLNfQt4umfer4OS2hO8E12gw7KFdqmQknqFp2rklVNAEQLkX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731451; c=relaxed/simple;
	bh=RRifSnY8WdN1qgt8WBQFWRheQB7REonJVux3jwqRJPw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tDf/3sw8UHBeoxTW0c0vJM8YkBqN2B2NqxjtSp1WEaXbcyq8jofPAIbyPp8m6XvljZVjAq5lO7l25X462Rz+TGOHEnWLclJ+tHiyA2Ekw3cyRNGp85r4nK5NSAUD0hvuscD5z9dfvpmCQhBEvwwciqg4K/hBH7h8ZwL+bnjUk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCeKdYVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BCFC116C6;
	Tue,  6 Jan 2026 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767731451;
	bh=RRifSnY8WdN1qgt8WBQFWRheQB7REonJVux3jwqRJPw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=bCeKdYVC/svGmnAw+LE89TM+vcKIpzk8REiphnjCyk1EzfG/pjF8wX/qKCCfXTxMB
	 WvIBHTLJP6hFY7+ZoXsTjiR19xyhz6eVe1cxbDkW5fyTlmwXq7lztfO5/+04SjKJIN
	 q3oKXQc0fcOyjIVvQZjb+PDxFpSL/sMSQK8rNJkt0qO2y76/6/303eVSnbY4dqQm/T
	 I5BnW2+AejW0voZX6kBU0EppoVMzezM0dab9E+UnTVPR7Z0UfDS89OCSPa43nNbtqD
	 6zTO9v6XOSYu5H0JUCvLlLzWVqEQxakl0r5jciXWu/QY1bR03F/qggBjq6ZEj+qqaP
	 FH3e1UyZ+EeEw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 21:30:48 +0100
Message-Id: <DFHSI0NVEIJK.2GI87NHVYABZW@kernel.org>
Cc: <dirk.behme@de.bosch.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Marko Turk" <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: pci: fix typos in Bar struct's comments
References: <20260105213726.73000-1-mt@markoturk.info>
 <20260105213726.73000-2-mt@markoturk.info>
In-Reply-To: <20260105213726.73000-2-mt@markoturk.info>

On Mon Jan 5, 2026 at 10:37 PM CET, Marko Turk wrote:
> Fix a typo in the doc-comment of the Bar structure: 'inststance ->
> instance'.
>
> Add also 'is' to the comment inside Bar's `new()` function (suggested
> by Dirk):
> // `pdev` is valid by the invariants of `Device`.
>
> Fixes: bf9651f84b4e ("rust: pci: implement I/O mappable `pci::Bar`")
> Suggested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Marko Turk <mt@markoturk.info>

Applied to driver-core-linus, thanks!

