Return-Path: <linux-pci+bounces-1720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F782571A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E961F218D9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBD2E647;
	Fri,  5 Jan 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLhiE6Mf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF262E634;
	Fri,  5 Jan 2024 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBD1C433CA;
	Fri,  5 Jan 2024 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704469862;
	bh=n231lDFtC1PQZJ6m2SX0PpmC/fNZapwiRnhDq0AcIcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uLhiE6MfNuVf6SHhUxaQVY2mw+jq0fPsfzb6nmD7w/qPgUasARdwHMR6wWizw4IFB
	 UN4o7prHaliVIhiQLo0n0ZVhiEqxbl+DppSYDdtRZVsHypb2FVmMzolmzpnB7r+3c8
	 4xO+APtPR8i/f9XWAlY39TzDghGimHZGMo+KtDYIT0aKCJQKxEzbyU4sM8cX0Nmo6X
	 5MwrVWlUtu+cuzKUTXq6iDDDxVcwVAJe4BRJPXCOjo8NNfmglq2cH/Rvh6p9FSq78P
	 S6gvMIZzrWfzq1bcgZt1rmg/GGEsHdbMfWIbKEMFecMY6FN+RhTBqVNzSYT3Snjgx6
	 fOVxmkZShRH2g==
Date: Fri, 5 Jan 2024 09:51:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Schaller <michael@5challer.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, macro@orcam.me.uk,
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	gregkh@linuxfoundation.org, hkallweit1@gmail.com,
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Message-ID: <20240105155100.GA1861423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954f0b86-dd9e-4d84-8d67-fba7e80bc94e@5challer.de>

On Fri, Jan 05, 2024 at 12:18:32PM +0100, Michael Schaller wrote:
> On 05.01.24 04:25, Kai-Heng Feng wrote:
> > Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?
> 
> Yes, `echo 0 | sudo tee /sys/power/pm_async` does indeed also result in a
> working resume. I've tested this on kernel 6.6.9 (which still has commit
> 08d0cc5f3426). I've also attached the relevant dmesg output of the
> suspend/resume cycle in case this helps.

Thanks for testing that!

> Furthermore does this mean that commit 08d0cc5f3426 isn't at fault but
> rather that we are dealing with a timing issue?

PCI does have a few software timing requirements, mostly related to
reset and power state (D0/D3cold).  ASPM has some timing parameters,
too, but I think they're all requirements on the hardware, not on
software.

Adding an arbitrary delay anywhere shouldn't break anything, and other
than those few required situations, it shouldn't fix anything either.

Bjorn

