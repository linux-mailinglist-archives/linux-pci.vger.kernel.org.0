Return-Path: <linux-pci+bounces-32069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9BB03FBA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB4016E347
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EE3255F56;
	Mon, 14 Jul 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsDmcoNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD024EA8F;
	Mon, 14 Jul 2025 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499345; cv=none; b=IEoRvyYKh2wN6E8+92yI51E+TtHHvG8NqjBRFvQzZ5WuDOWVPr/ohClEIycTGhWddlmKZq5kIJXOSkg71tp89MUBfzuh5G5od3aEuciUaT8I27gph/WRYPEKk39VIVUQChfBiofh959+rko0FtE6LJ0nCzPXtH12eocUaEkY9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499345; c=relaxed/simple;
	bh=bpBCFjoNvMeiJzCR4wwoil9X/vK9DGvXorTznsyyOWg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RDBEEFkVbroIPob+vHmJhFol6CtfYLsHOiQSzyX7Ad9a7VfkNqqSoqnvylqFTqMXLqbm/IzwD2XsfP/Jo/SWfBSLCZ28gR5Stn1XQ0REP6N374pMlnIFEZwShv6RyVJZeZbZm+loPDXL9jx8uUaWnR1DmQxr166LANAi6zV4sBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsDmcoNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652FCC4CEED;
	Mon, 14 Jul 2025 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752499344;
	bh=bpBCFjoNvMeiJzCR4wwoil9X/vK9DGvXorTznsyyOWg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ZsDmcoNkt2PVQaXji7ww3gCpzZzJ6Jj9wpnojfjHvx566/r2Q+1jAxPpoTSCLr67C
	 ZjsjPh0QPJ4czQz1ivsmLgcrDg+HzFeuJwkyCyWizFwy4+q8muc42kE9PO20+TKf9g
	 AoKqKoIq2XNdOinOzynpgT0f1mQmpYU2kx4DOv+P9MZg89gJv3cBrFBe1oa8Jzj4vb
	 PPIhJv9msqvMmPlQLU2d3xUlYa//zE25xqRXcMTQgVRa99Cga3L5OFrLICpvpb1fqq
	 bOguDxLof6JpTydrhKFQo6MrBnWsFRiPOHMTRpxchS6COR9CLRlwRLvUC/iVztW0Lc
	 IxsTZtqSspdWg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 15:22:17 +0200
Message-Id: <DBBT61D7DXVB.3S37NO2UW5RI7@kernel.org>
Subject: Re: [PATCH v4 0/3] rust: Build PHY device tables by using
 module_device_table macro
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <alex.gaynor@gmail.com>,
 <gregkh@linuxfoundation.org>, <ojeda@kernel.org>, <saravanak@google.com>,
 <tmgross@umich.edu>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <david.m.ertman@intel.com>, <devicetree@vger.kernel.org>,
 <gary@garyguo.net>, <ira.weiny@intel.com>, <kwilczynski@kernel.org>,
 <lenb@kernel.org>, <leon@kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <lossin@kernel.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: <rafael@kernel.org>, <robh@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250711040947.1252162-1-fujita.tomonori@gmail.com>

On Fri Jul 11, 2025 at 6:09 AM CEST, FUJITA Tomonori wrote:
> Build PHY device tables by using module_device_table macro.

Rafael, Rob: Unless there are any concerns from your end, I'll pick this up
soon.

