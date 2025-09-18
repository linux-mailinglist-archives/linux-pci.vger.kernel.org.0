Return-Path: <linux-pci+bounces-36450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BEB87519
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 01:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF747AC17E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855D271A6D;
	Thu, 18 Sep 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnGr+HDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F62F2E;
	Thu, 18 Sep 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236791; cv=none; b=R7akSY3bkl1N3nydCwxbUl6b/oe5C8X4mIFCVhtbFhP79eTkToklBMRg4ecCcJbBmgsDv+qwbWQwZmahDCGH7kjLP2kq7ovYB0CVsth9KSxgWgfsfNYTD81C2O2QSgYE8wgtJWy4xCYZCl2IO0ConoX+7YUhMXJl/Y/HzeGXdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236791; c=relaxed/simple;
	bh=oIrPsfnqE/E3gaydHEh+RHEcCyXRToY+dk6bDvCuTns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B8vJg5bII5QirqTi/7elKn++25O3P+iAPyqB+bf3xXMIrXwBmeBbPe/Z7CLyFhce5pcXT1YPknOhykdgl4KQnaKK4ozkux8THzXM4CW0qJOWCqPZctNtlOKWllA3sBfI2/uhTX7u5WWWgXgA2e/1pepXWcD2oFR90MpVSAJwSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnGr+HDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CCFC4CEE7;
	Thu, 18 Sep 2025 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236791;
	bh=oIrPsfnqE/E3gaydHEh+RHEcCyXRToY+dk6bDvCuTns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FnGr+HDVq7lpr5U3yTowya5aGw2aD9wqDhsfQN7zSwzdJSNMLlduY6vkVAVwz0pQq
	 iq6TrTpvxlxlKKKvW/Bkx/EoDZLbFvA387JzHz93WDdNqrRKtXgqW/OHV+7MsH+5xS
	 hatZ1EBlQciQ6DTVSiOCNCfP56ApbiBHn+cvozjx46xAHGHayg+V8NWteiJDJQV4kr
	 Fa5+IeiqToqeLee8oDZB7ILlZL1AruZh06F+HUUv2zqI6+XCsFZxskcwuv1ALsoTe4
	 KpCACO4ZOE9kDQq4Ti8vbNDvPttDco8bn3h/rZm8A5EPIjzja0CSZQjh1LTY/Tt7Ik
	 T12fZ3VPG717w==
Date: Thu, 18 Sep 2025 18:06:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	mattc@purestorage.com, Jonathan.Cameron@huawei.com,
	bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
	anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
	peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 0/2] add PCI hotplug and PCIe link tracepoint
Message-ID: <20250918230629.GA1928363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723033108.61587-1-xueshuai@linux.alibaba.com>

On Wed, Jul 23, 2025 at 11:31:06AM +0800, Shuai Xue wrote:
> changes since v8:
> - rewrite commit log from Bjorn
> - move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
> - rename hotplug event strings per Bjorn and Lukas
> - add PCIe link tracepoint per Bjorn, Lukas, and Ilpo
> 
> Hotplug events are critical indicators for analyzing hardware health, and
> surprise link downs can significantly impact system performance and reliability.
> In addition, PCIe link speed degradation directly impacts system performance and
> often indicates hardware issues such as faulty devices, physical layer problems,
> or configuration errors.
> 
> This patch set add PCI hotplug and PCIe link tracepoint to help analyze PCI
> hotplug events and PCIe link speed degradation.
> 
> Shuai Xue (2):
>   PCI: trace: Add a generic RAS tracepoint for hotplug event
>   PCI: trace: Add a RAS tracepoint to monitor link speed changes
> 
>  drivers/pci/hotplug/pciehp_ctrl.c |  33 +++++++--
>  drivers/pci/hotplug/pciehp_hpc.c  |   5 +-
>  drivers/pci/pci.c                 |   2 +-
>  drivers/pci/pci.h                 |  12 ++-
>  drivers/pci/pcie/bwctrl.c         |   4 +-
>  drivers/pci/probe.c               |  10 ++-
>  include/linux/pci.h               |   1 +
>  include/trace/events/pci.h        | 119 ++++++++++++++++++++++++++++++
>  include/uapi/linux/pci.h          |   7 ++
>  9 files changed, 177 insertions(+), 16 deletions(-)
>  create mode 100644 include/trace/events/pci.h

Hi Shuai,

I lost track of what happened with this series.  It seemed like we
were pretty close but there were some trivial issues, and I don't
think we ever merged it.  Did I miss something, or are you waiting on
me?

Bjorn

