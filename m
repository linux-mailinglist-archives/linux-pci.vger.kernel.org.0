Return-Path: <linux-pci+bounces-17077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44699D297A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EB5B28110
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE31CEABA;
	Tue, 19 Nov 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMOwtL7t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317F1CEAAD
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029568; cv=none; b=Cr/oi72QDtqkFylZrECyU8TEB1cISfr31DD8Kx5RA9B+kj9+eICSKupvJiEdhG7L1AgySlfiVVoW9m6Zs5rLoBotcuxVoMqAbxOONTfcjfQF7opj2QTbM3cIRNwgPgfyeoToCumTeQlafIaBFDQIFCPBekQj1rV4wXyaO//3bL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029568; c=relaxed/simple;
	bh=KyqIRd7Hc8ijk6oTfMbFcibCzN+aVOhNyxKcqcYjs1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Go6Tyi/fwKzndtIursy1u+vOn3ZCS4J7u6TiaZoxuFBBE9tdsrKO+KOcOhjW7dMh7x439PxKW/6K+Vp6IvtG51nlhfQw7Nu8aaolwLQbmYAnAanoS+bc0wudjrKWBgHWS5K05NXW8ivjgeSxe6P5QFVyr9d7IQVx8BeQZizYJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMOwtL7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35DAC4CED0;
	Tue, 19 Nov 2024 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732029568;
	bh=KyqIRd7Hc8ijk6oTfMbFcibCzN+aVOhNyxKcqcYjs1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vMOwtL7tp59W3salulZ8Tj9wQBN+E0PPmHN6BqOSOk7Kg1JsDDGx6BKb14a0FnYta
	 jh1URvgMfUBcPtUNgE9OXivLf175sFRimxtDLEzfN1hwjxTSgbWjiyhzJAKvOySdg1
	 4SQKMRYa+nCWAC214FDcMpz3gB/blP5QF0X7QvZUkJzEpLWw2MMXepzhGnHClkL3lY
	 P4Nd8M9n4XP7ZDraD8sqcwBQWmapISo2JtOK146QKnjpy+DlyzEnm5WPO0kpUqCikP
	 ASlpajkCU9GMhlXXxPzsOxo7G2RjLRL65xBNby4U+EOUWO1evwaPBQVpidyLB9Eznt
	 O/pjBa356y1mQ==
Date: Tue, 19 Nov 2024 09:19:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [pci:controller/rockchip] BUILD SUCCESS
 592aac418ebdf451fe9b146bc2ca6dfc96921af0
Message-ID: <20241119151925.GA2263235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202411180006.ahFN8muC-lkp@intel.com>

On Mon, Nov 18, 2024 at 12:01:12AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
> branch HEAD: 592aac418ebdf451fe9b146bc2ca6dfc96921af0  PCI: rockchip-ep: Handle PERST# signal in endpoint mode

> x86_64                           allyesconfig    clang-19

How can I reproduce this build?  Do you have a packaged clang-19
toolchain?

The x86_64 allyesconfig build succeeded for the robot, but when I
build on x86_64 with gcc-11.4.0, I get an error:

  $ gcc -v
  gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
  $ git checkout 592aac418ebd
  $ make allyesconfig
  $ make drivers/pci/controller/pcie-rockchip-ep.o
    CC      drivers/pci/controller/pcie-rockchip-ep.o
  drivers/pci/controller/pcie-rockchip-ep.c:640:9: error: implicit declaration of function ‘irq_set_irq_type’

irq_set_irq_type() is declared in <linux/irq.h>.  On arm64, where this
driver is used, <linux/irq.h> is included via this path:

  linux/pci.h
    linux/interrupt.h
      linux/hardirq.h
	arch/arm64/include/asm/hardirq.h
	  asm-generic/hardirq.h
	    linux/irq.h

but on x86, arch/x86/include/asm/hardirq.h does not include
asm-generic/hardirq.h and therefore doesn't include <linux/irq.h>.

I'm confused about why the robot reported a successful build with
clang-19.  It seems like that should have the same problem I saw with
gcc, so I'd like to try it manually.

Bjorn

