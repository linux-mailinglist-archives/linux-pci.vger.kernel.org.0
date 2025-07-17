Return-Path: <linux-pci+bounces-32352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BA3B084AD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F291A66AF9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550F20FAB6;
	Thu, 17 Jul 2025 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="sTFMr1Aj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA121018A;
	Thu, 17 Jul 2025 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732777; cv=none; b=ZA1bmchQmBeRnvllDb1OIlSkScY9tmAa43n9buf/uw4S8jYjEy1TNIT1wHYU5YApvGq3csmpxvcBvnbJ8gf1/7cll3C6IiUCYO1POFKElgMe7FYavtBrJDlgacAkqJPkaLPnDA7xNRpBF1CAR1mPpzaUK9EBiepj279bxZQRKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732777; c=relaxed/simple;
	bh=iP3yOmXu0xIFAbmQHeLt9NMgG7ONZgbP1Yrpcrwj5EQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R4QaF6QgwWxFKUr8k0fyTz0hkmLJkT0GuHVqz19mpGJjt912t6SfzW1tFsyw5LYnM9uGKBZp7bfhvMRwyaG2VaE7oHUU6Dec+tfTun4sR0QKkZQ8xGbp/rZEMdSkmzgDo/3EgmPLnFJ4kXKLeMZMTjZS23XbWF/Dq3wjoi6GgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=sTFMr1Aj; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from xps-9320 (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4bjMzL2v43zHsy;
	Thu, 17 Jul 2025 02:12:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1752732767; bh=iP3yOmXu0xIFAbmQHeLt9NMgG7ONZgbP1Yrpcrwj5EQ=;
	h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
	b=sTFMr1AjXOJDp674Nc7x3ixENQfkxYDMN4g73FLOm/RggJnj7qcvJjykfDZA9BidI
	 yznelB1y5fKXIZ1OWss8SKfgArc0PQ3swj2vp6qucurbH68hySRNchFTo4eizvbYsO
	 IJIxUoKHKdHbNew6JGCdjLQU6boA4hD6xzszMz/I=
Date: Wed, 16 Jul 2025 23:12:45 -0700 (PDT)
From: "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
    ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
    linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link
 state
In-Reply-To: <20250717004034.2998443-1-david.e.box@linux.intel.com>
Message-ID: <7a229e18-fbfd-8652-ec2e-a3a3273f7fac@panix.com>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
Errors-To: kenny@panix.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Unfortunately, having tested the patch (against Linus' master), it doesn't work.

I don't think the ASPM(?) state is making it to the VMD.

LMK if you need more info.

-Kenny

On Wed, 16 Jul 2025, David E. Box wrote:

> Testing is appreciated as I didn't get a chance to do so yet but plan to.

> Thanks, David
>
> ---
>
> David E. Box (2):
>   PCI/ASPM: Allow drivers to provide ASPM link state via pci_bus
>   PCI: vmd: Provide default ASPM link state for synthetic hierarchy
>
>  drivers/pci/controller/vmd.c |  7 +++++--
>  drivers/pci/pcie/aspm.c      |  5 ++++-
>  include/linux/pci.h          | 12 ++++++++----
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
>
> base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
>

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

