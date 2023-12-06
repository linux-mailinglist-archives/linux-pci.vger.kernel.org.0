Return-Path: <linux-pci+bounces-599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFF807C12
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 00:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397A71F21944
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 23:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E562DF88;
	Wed,  6 Dec 2023 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeM3t9qF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFD7096A;
	Wed,  6 Dec 2023 23:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A01C433C7;
	Wed,  6 Dec 2023 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701904121;
	bh=AO1ty7D6PaKp6YDUkB6GcaoW3ZWSgt+tWyq663+Pm1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YeM3t9qF4gO99MzKrXKOOaZSPdSn/RA80k5Anw846HM1ng+H7TvW6Ve27idk2Wcl7
	 QkAxlobS+pcETYJbQSJF3epD1OzwL7IhBfgbyRsfsG+7pqfPgwRB3Lzt6mXP145rd1
	 4omKqqli/+EuDT1yh/2YZT9p+LEVINP7aqySAzp2uwqubJCBolDIVQnXih1pn8z2Nm
	 Py+n5MRhtqs2zPi5NVB3qWIbpGPjlPZvC6MpSmtFCvLWPnTD5hDZpvy39W8NHI7rrn
	 J45fhSVhQtZWWq5HloDYZkuHBw4pWR9N1NHlrhuwT2Py9Zln+XS7nR/zP0Mnqcs9W/
	 u3Cc7xlccykqg==
Date: Wed, 6 Dec 2023 17:08:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20231206230840.GA733691@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115091612.580685-4-LeoLiu-oc@zhaoxin.com>

On Wed, Nov 15, 2023 at 05:16:12PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Call the func pci_acpi_program_hest_aer_params() for every PCIe device.
> Extracting register value from HEST PCIe AER structures and programming
> them into AER Capabilities are implemented in this function.
> The implementation of the function is an effective supplement to _HPP/_HPX
> method when the Firmware does not support the _HPP/_HPX method and can be
> specially configured for the AER register of the specific device.

Rewrap into a single paragraph or add blank lines between.

If this is needed to make some machine work correctly, please include
that information here.

Based on Rafael's comment about getting the actbl1.h change merged via
ACPICA first, I assume this entire series is will wait for that ACPICA
update.

Bjorn

