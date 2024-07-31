Return-Path: <linux-pci+bounces-11070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F29436A1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 21:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268591F21EBB
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00981607B0;
	Wed, 31 Jul 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkRWj59W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77451607A5;
	Wed, 31 Jul 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454960; cv=none; b=Ik4bbQSBrl8VnwiFVlmTn60kefvfKRtmFM5q2AO/9/lAH/yoSHiLl2eaqa7/HG4U27+kMeWMftAvPu8HQu9nGMO3K6nk5X51NezrhrOOQk6kL5ivvJeHyjNJsf0Y0Sefo0pav0yz8VHK8fORWN5M0Xm3UyFc3JGvYsa6E8Qazl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454960; c=relaxed/simple;
	bh=tAO8QCi4eo9UUT6fp7htXBmwR3UKsPSt0znIo0kDNVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YsrVVdDitB3dIeFuhOPSF5aKDUWUeU1NJc4RW4EVpUaebpelDvuF5TFnT9afijLqEK5wbAoKHJiDB9iPzc5s529SVRCujmKqAi+JCYpB1dUxUdYQjCf5HKeovoKF1mFg+kDFOqH/UYL9GMmuhWtLFZKl6SUIbxZjgNqT5TUKFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkRWj59W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D30C4AF09;
	Wed, 31 Jul 2024 19:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722454960;
	bh=tAO8QCi4eo9UUT6fp7htXBmwR3UKsPSt0znIo0kDNVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fkRWj59WPz/ugrjjP7itECGAQZQydbP7r8yUrpS54y0rJDh2Q9KMJwOCYEe+U3CkB
	 7RM4vr5QdcbWVAFjwhoUNBxtSfDPixf3YzTSZvA0uyroXQHgisCFzBBVhBVMQnlYgC
	 0fiZZiZh+NDq5tIr6iAYS2HM45GP+utRVuYtPvtQSueBnFAfpxB9qPYaupeXk4WNi7
	 Uvpvkn+2YjE2XJLn/Hc3zS3wPpcPaS+ygWn9Oou7SOKSuIAaiktlJRinFAsA0MAZKc
	 irJqZO7PaHYIuoNA4UeuxxTZdHn589V2VSnkUaZ/8b8P7MY97C/oT8y6Q7WGwd8t3S
	 VIgdLjTEcVmgg==
Date: Wed, 31 Jul 2024 14:42:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v7 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <20240731194238.GA78014@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729142241.733357-4-sunilvl@ventanamicro.com>

On Mon, Jul 29, 2024 at 07:52:25PM +0530, Sunil V L wrote:
> Add a new function for RISC-V to do architecture specific initialization
> similar to acpi_arm_init(). Some of the ACPI tables are architecture
> specific and there is no reason trying to find them on other
> architectures.

Maybe mention the RISC-V function name as well as acpi_arm_init()?

> +++ b/drivers/acpi/riscv/init.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023-2024, Ventana Micro Systems Inc
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + *

Spurious blank line.

> + */

