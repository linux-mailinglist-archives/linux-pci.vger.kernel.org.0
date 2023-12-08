Return-Path: <linux-pci+bounces-695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A980AAAD
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3B41F210FF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09D39846;
	Fri,  8 Dec 2023 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDI3rt8+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121D38FBE
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 17:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B513AC433C8;
	Fri,  8 Dec 2023 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702056245;
	bh=bxL4oXwkTWZiQvUF7pKvci42A9qb4Z0RuhAIDxiS5uQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lDI3rt8+FutXq45dszh2uDZ8ZDG8k8l1mWoZP41lyuU5sJy9rJz+jlHWaevRBdbFH
	 ClLn1JWqjNFIrpHecB2Ap1ebI+KvXiew6KiiT3kAjS9oscI3kOIBeH5euxPL45KH4j
	 JfC1GwV1lW1qs5amccFVWYklHVfWgfSTGnYUBOvljDpCvr5ZyyZK7ghjMJOMc6MmIx
	 aplCXLbHytsLcM8k9suSoH+J2agPNfpISwFEvTCNKouxuHuaj82yY7ZZY/iKMbPf91
	 E7BKhIcAavkwdkkuN8cQga4z+lZoa6n+tojP+Y2U3vK3y57CbXdcFNk8sGPjDcBB5B
	 LR0hL3PwuijEQ==
Date: Fri, 8 Dec 2023 11:24:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 15/15] pciutils-pcilmr: Add pcilmr man page
Message-ID: <20231208172404.GA797244@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208091734.12225-16-n.proshkin@yadro.com>

I'm not a hardware person, but this looks like interesting work!

On Fri, Dec 08, 2023 at 12:17:34PM +0300, Nikita Proshkin wrote:
> +Turn off PCIE Leaky Bucket Feature, Re-Equalization and Link Degradation;

s/PCIE/PCIe/ to match other uses here.

> +The current Link data rate must be 16.0 GT/s or higher (right now
> +utility supports Gen 4 and 5 Links);

So far, each major PCIe spec revision has added a single new data
rate, but that may not always be true, and the spec always uses
terminology like "16.0 GT/s or higher" instead of terms like "Gen 4".

So "supports 16.0 GT/s and 32.0 GT/s Links" might be clearer.

> +The Gen 5 Specification sets allowed range for Timing Margin from 20%\~UI to 50%\~UI and

Usage in the spec itself would be more like "PCIe Base Spec Revision 5.0"
since it doesn't use "Gen 5".

> +According to spec it's possible for Receiver to margin up to MaxLanes + 1
> +lanes simultaneously, but usually this works bad, so this option is for

s/works bad/works poorly/

> +experiments mostly.

