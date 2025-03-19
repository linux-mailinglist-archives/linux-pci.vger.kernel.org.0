Return-Path: <linux-pci+bounces-24156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825CBA69904
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4894A4853A4
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855452153FE;
	Wed, 19 Mar 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozfzaQT7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605092153D4
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411744; cv=none; b=ETiDKchgTby8If6gxUEr5jEHX5dRTxK8HG1QQ5+TYNcK4+orvufdxiJFv0z3WTY4yv+etyrkMU9g2kIRDgd1qi6UtzoKb3lcPk++gzOwsA1GSOd5yomm0/+mrc3UNvHoI2EjIqS8qo2AnwVTMN2Y/vjp1wnOCqeOWHX0ydNU+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411744; c=relaxed/simple;
	bh=LajZyBiYKEmFeuBv487w2Ezk8UJaoR3tnh/nJ5CUF7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UON5mPbfL7h3IuagrRABZrSO237lLKksvjHkH08PwPwMoqoDYhhE1k9v72Gk5ZfpjNwKeYjCQDZ6ywRQ+Zdz4QmhacepRFfkqu6kITiPmNRJtOkyAKJsyt14viqUGHqQy7e8dBt65qU+ujlg13Sfgv5rpInBFzjq+7LU/9vcV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozfzaQT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1552C4CEED;
	Wed, 19 Mar 2025 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411743;
	bh=LajZyBiYKEmFeuBv487w2Ezk8UJaoR3tnh/nJ5CUF7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ozfzaQT7J162encrATM4HiccB1X6+naINgIKMyO/l7t0F0CzZxnYV/vL/vLUmonm7
	 Gm0wLMtoIMtJ8d//k4kYEhn0UXFCX/pbAgL2Zo18zm0H6eFER0YbZGbbD8nBiLqZGr
	 UMfUWKuIP98Kr24wvz7o3d9lv7L9mr75/UAXLfHk7g0lHWCtTLJOkuYpwQVJPINPED
	 bHC1xDsgA6ehP1A81zow8lS5/8M1oICqMSEOkTNaZ1Tg5bkK/gsUnd1jEqSzaRqsr6
	 D1ZGoSSAUjtE7bjbUADUtgNwLODs4u4k7Gb5BPY5CU5uki/XzoAOe7W+PbYGFvlsYU
	 TEdkZkGPiiWAg==
Date: Wed, 19 Mar 2025 14:15:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Query Regarding PCI Configuration Space Mapping and BAR
 Programming
Message-ID: <20250319191542.GA1053142@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+ibkpwJ4vduDGC+n7Pjp=4ZbtkVmvQFoFXgZYV+TcDWXQ@mail.gmail.com>

On Wed, Mar 19, 2025 at 11:27:07PM +0530, Muni Sekhar wrote:
> Dear Linux-PCI Maintainers,
> 
> I have a few questions regarding PCI configuration space and Base
> Address Register (BAR) programming:
> 
> PCI Configuration Space Mapping:
> PCI devices have standard registers (Device ID, Vendor ID, Status,
> Command, etc.) in their configuration space.
> These registers are mapped to memory locations. 

In general, config registers are not mapped to memory locations.

Some systems use the ECAM mechanism for config access, which is
basically memory-mapped I/O that converts CPU memory accesses to PCI
config accesses.  This mechanism is hidden inside the Linux config
accessors (pci_read_config_word(), etc), and drivers should not use
ECAM directly.

> How can we determine
> the exact memory location where these configuration space registers
> are mapped?

Drivers use pci_read_config_word() and similar interfaces to access
config registers.  Userspace can use the setpci utility.

> Base Address Registers (BARs) Programming:
> How are BAR registers programmed, and what ensures they do not
> conflict with other devices mapped memory in the system?
> If a BAR mapping clashes with another device’s memory range, how does
> the system handle this?
> 
> Does the BIOS/firmware allocate BAR addresses, or does the OS have a
> role in reconfiguring them during device initialization?

On x86 systems, the BIOS generally assigns BAR addresses.  Linux
doesn't change these unless they are invalid.  Some firmware does not
assign BARs, and generally firmware does not assign BARs for hot-added
devices.  In those cases, Linux assigns them.

If Linux notices a conflict, it tries to reassign BARs to avoid the
conflict.

> If you could provide any source code references from the Linux kernel
> that handle these aspects, it would be greatly appreciated.

Here's the function that reads BARs when Linux enumerates a device:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=v6.13#n176

