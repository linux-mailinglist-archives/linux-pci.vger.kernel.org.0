Return-Path: <linux-pci+bounces-25959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD24BA8A995
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 22:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC1C17FD11
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660D256C8F;
	Tue, 15 Apr 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8p5OHZ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B51DB34E;
	Tue, 15 Apr 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750028; cv=none; b=WydLRxDrgs4sBLS1ma0Pq+z4wEazB7ZAtxdJLhPm3VLLs2hx9KJ+vGw6zL/BKx5qOITcv1NkXI+a2FhsNXp8ytriNprQYryzhBSVuka6XPb23tMt14W8fwtcHgWK7OswtJFMROLqGbrXMZrSpw97TBv/lHxt0sLv1qd8rxYTJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750028; c=relaxed/simple;
	bh=NM3NTCfQKXOu+maLNoeBI0wRtD8RKBHlIxJ0rLLbkmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i663/AwetKkC6idJH+HPMwudOhlnarY/iSJN5rmJlyNMFbsRPtbvkuMle6hpJnCZSihEVYbS23KF6VMZRrk9G/6lTY0BAKJKmMIvCV90hVZ41KIsdhmxHT/wTaT26OWbbFPxIv+sbs2ZZXy3pzfKasfp7I7ATQdsjOjdvgatkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8p5OHZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ADBC4CEE7;
	Tue, 15 Apr 2025 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744750027;
	bh=NM3NTCfQKXOu+maLNoeBI0wRtD8RKBHlIxJ0rLLbkmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z8p5OHZ0wQmeqyj907IsYur8ATEcS4bIob+uB8Mct74d7Lr+sBagW0K8BY3yGXreU
	 CeeCJVdLZ9FTkCPX3VhzLjOFa963XQtIXmco17PEDUwysYA6IlyZRd/Mc/ipd2mS8B
	 K4B6Pq619rtLFDfX0anlburRpaULdsfZTAcpAKlptE/5SyZz378VW3NrVYl4o9cBC8
	 ZdIOcR+VlAQuJ6gU4SJp+8MIotNCykLc8DbVzGUubwRrJ4d/DzvFCLL5vj8ZKL3Qwk
	 agmLQlOzPQOk+THvSWgjZUxRLx/bNgYNFYogj1l+3IlWUMMafnX/FnmYxsClRlswXK
	 yGNswiXTr7OyQ==
Date: Tue, 15 Apr 2025 15:47:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] rust: device: implement device context for Device
Message-ID: <20250415204705.GA35108@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413173758.12068-4-dakr@kernel.org>

On Sun, Apr 13, 2025 at 07:36:58PM +0200, Danilo Krummrich wrote:
> Analogous to bus specific device, implement the DeviceContext generic
> for generic devices.
> 
> This is used for APIs that work with generic devices (such as Devres) to
> evaluate the device' context.

Looks like a stray ', but maybe it's some rust thing I don't know
about.

