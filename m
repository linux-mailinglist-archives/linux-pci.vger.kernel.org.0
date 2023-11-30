Return-Path: <linux-pci+bounces-302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FEE7FF971
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 19:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E9282057
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50B48CD8;
	Thu, 30 Nov 2023 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvXPQNey"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12935A0F5
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 18:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFDC433C7;
	Thu, 30 Nov 2023 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701369307;
	bh=1KLmnXj3oH57djjg5RXbttA8qHBNJ7pmAovpuDi+A9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FvXPQNeyANpdmDNj5C/xy3Or4/5l8FHT4OClrcmkIXl+IxeILBCmrYKMT/ITT2Vd7
	 WBUKG7691rCWWVy0fuIUU5av1YqoToCl8SJQ09wF44UlcbPry22JAQv8DTgK/hWqr/
	 sd6y+3qCGKh/e0NOwr7b+PFT6vrmHAwtlzPNVF5C+IzFQ59e2QLY+zhJKQbj0NS2nB
	 yYcVu/0EiQSLL66ltpF92a4eDtClUrxhRN/vbsI5riJmgHUb82ylPOohbY/AYK/5Zp
	 D4ENY0bTlquG7xTJpDXs8aOKLVBMmXRFitDd9X8QwbN+3HvTRx3wxA2PYbDPYaWqFN
	 nYFsAuY8e0wHQ==
Date: Thu, 30 Nov 2023 12:35:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mason.huo@starfivetech.com,
	leyfoon.tan@starfivetech.com, minda.chen@starfivetech.com
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Message-ID: <20231130183504.GA487377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0844a59-7534-4195-b656-eb51586cbff6@starfivetech.com>

On Thu, Nov 30, 2023 at 06:03:55PM +0800, Kevin Xie wrote:
> On 2023/11/30 7:21, Bjorn Helgaas wrote:
> > On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
> >> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
> >> time between sending the first configuration request to the device and
> >> exit from a conventional reset (or after link training completes).
> > 
> > s/marco/macro/
> > 
> > List the first event before the second one, i.e., the delay is from
> > exit from reset to the config request.
> 
> OK，I will use "from A to B" instead of "between A and B".

That's not my point.

My point was you said "between B (config request) and A (exit from
reset)".  "A" happens first, so it should be mentioned first.

> > I assume there are follow-on patches that actually use this?  Can we
> > make this the first patch in a series so we know we don't have an
> > unused macro lying around?
> 
> Yes, we will use the marco in the next version of our PCIe controller patches.
> Here is the link of current version patch series:
> https://lore.kernel.org/lkml/20231115114912.71448-20-minda.chen@starfivetech.com/T/#u 
> 
> Do you mean that I should put this patch back to the above series as
> one of the separate patches?

Yes, please.  Handling them as a group is less overhead and helps
avoid merge issues (if they're all in a series there's no possibility
that the user gets merged before the macro itself).

Bjorn

