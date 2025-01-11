Return-Path: <linux-pci+bounces-19646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB9A0A48A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 17:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998081693BA
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065333FD;
	Sat, 11 Jan 2025 16:00:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B050EC0;
	Sat, 11 Jan 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736611251; cv=none; b=oDWVy7xgzPHBUeyopA9tEH4JlAKrtvOTN2mx2N03hJtzgrQFbqa/T1q3eEFxjgBZQHEKhSHrdkbdSRaweZvaZfMX5TieooB+g7PJwuPGeX2Yp+rnsJTY4v2Htn+NSMOOb0PTm5K+MFFFX2HlHU2MJC0yCGrK166JQJFWvx/LfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736611251; c=relaxed/simple;
	bh=kH8kvz7P5odSg5TZI8fKX3Ovk/Qt+0LLgRtZbE/wcqY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T1PJnr672rfc2nnSNgKStZvEP9xZ8zwbdgrBQZR4CnYcSU/OMRpbccGFspJcmntMpBrCwj8Mv1drPNmWUOQA+1oJ7TBaXrJa2Iv47CxAkFW7ZCdolQc9Nw3tmQx7E43jC4QJKmyqIFT2uwdpo9pZVhGctDXB6ZDN4HWVaU/SZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C840992009C; Sat, 11 Jan 2025 17:00:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C1FF192009B;
	Sat, 11 Jan 2025 16:00:40 +0000 (GMT)
Date: Sat, 11 Jan 2025 16:00:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiwei Sun <jiwei.sun.bj@qq.com>
cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    guojinhui.liam@bytedance.com, helgaas@kernel.org, lukas@wunner.de, 
    ahuang12@lenovo.com, sunjw10@lenovo.com
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during
 hotplug testing
In-Reply-To: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
Message-ID: <alpine.DEB.2.21.2501111543050.18889@angie.orcam.me.uk>
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jan 2025, Jiwei Sun wrote:

> In order to fix the issue, don't do the retraining work except ASMedia
> ASM2824.

 I yet need to go through all of your submission in detail, but this 
assumption defeats the purpose of the workaround, as the current 
understanding of the origin of the training failure and the reason to 
retrain by hand with the speed limited to 2.5GT/s is the *downstream* 
device rather than the ASMedia ASM2824 switch.

 It is also why the quirk has been wired to run everywhere rather than
having been keyed by VID:DID, and the VID:DID of the switch is only 
listed, conservatively, because it seems safe with the switch to lift the 
speed restriction once the link has successfully completed training.

 Overall I think we need to get your problem sorted differently, because I 
suppose in principle your hot-plug scenario could also happen with the 
ASMedia ASM2824 switch as the upstream device and your NVMe storage 
element as the downstream device.  Perhaps the speed restriction could be 
always lifted, and then the bandwidth controller infrastructure used for 
that, so that it doesn't have to happen within `pcie_failed_link_retrain'?

  Maciej

