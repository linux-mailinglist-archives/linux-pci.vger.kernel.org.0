Return-Path: <linux-pci+bounces-44125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1FCCFB008
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 21:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8288630022D9
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803E62E6116;
	Tue,  6 Jan 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fni6o9Lt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16633019C5;
	Tue,  6 Jan 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732592; cv=none; b=Fz6CdejmglJCOO5/qlYx2oMpbSUiKe0Qx/UhFD896Gz4ZF/+6q4Xp5RaUipPCNgZVKdGZ0JxS2onLkKFj+dJo56KnhpjRt7Yl9yiH4mD7MzAe2ooF2052C+KxI8Hr6Z3f5JnYXjY8ODKl72pWv6mD7iLeWlwu34iQzWjT6jCbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732592; c=relaxed/simple;
	bh=JCysqp+8nvqzTVKvjivpYoQDD/Yp4m0X5Po9yGstyGY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=kEhWeRCtPaaWwxO0ixeNAOhd1hqqTjsDTL5+zo08TTBM/ckr59H6NYw54rlTxSKLKxPZWVAf4pSQ3LPCFpOh8J5suTxtWLImMXhrWaxz69t8gPt55AvOYT1qlB/XwoqmeJWs6Oaqh4PQRPgPZuE0pcSwSsOiVRYIrDb0kmkPYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fni6o9Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFEC116C6;
	Tue,  6 Jan 2026 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767732592;
	bh=JCysqp+8nvqzTVKvjivpYoQDD/Yp4m0X5Po9yGstyGY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Fni6o9LtP4PBm+F/T4QyNKXarzCg6cXrOPMe70Wk+uzNiRTcs8eJbns8TSergT9EZ
	 NWhSZLXBXLra+fh6xKRdCClCOKM/XW4S5YmnUWokHMtwTvfjNWLIQW+4HPLeCf7GDu
	 wFtrgWFrA5S1aXKtPKRu5K6q/KBrDEykrC68MfBujzsgyyJ9t8/X5D697v9gJdsDB6
	 TiRUfl4F5rrQA9qfX50Hj1UYALbT1JsRWi07ecxtJobvDEyKFjs62b5dgSeqmt3f27
	 k1fZ+c/i+3wyjFPH/PYUPRBI75jyFNt2Gh759GZx3tVFNAjUS5g2YUqKyDckN0eIRD
	 ntFibHjtHpbqg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 21:49:49 +0100
Message-Id: <DFHSWKFGP0I7.2V55SO9GLVX90@kernel.org>
Cc: <dirk.behme@de.bosch.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Marko Turk" <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: io: remove square brackets from pci::Bar
 reference
References: <20260105213726.73000-1-mt@markoturk.info>
In-Reply-To: <20260105213726.73000-1-mt@markoturk.info>

On Mon Jan 5, 2026 at 10:37 PM CET, Marko Turk wrote:
> Remove square brackets since this section is not a part of doc-comment
> so the reference will not be converted to a link in the generated docs.
>
> Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Marko Turk <mt@markoturk.info>

Applied to driver-core-testing, thanks!

