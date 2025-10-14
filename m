Return-Path: <linux-pci+bounces-38063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26407BDA20A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CE21883DA4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B422FF15B;
	Tue, 14 Oct 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERhq6RRI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024E30147F;
	Tue, 14 Oct 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452870; cv=none; b=fSUlQGvd7gbnW1Rw9RSUNeTUgkbnim9p5pqSW5JuRvHsgCOLT+LUkZDZTPRonfTAm1AAa3r91j17DyGCPidzjawlajAh09vPsAaR+DSzBK4kGj80nghTqElfCAoF7g+WmRAoV98ftIlN+zg6ihuOGoyo6783i717qIFua6hyETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452870; c=relaxed/simple;
	bh=bzXzVGoX6Soh/go+uDrQi2kQPxtg+NUe8G2AQ2W5LuA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wv4I0NcO0EZfsbC5SWW5Y03mFckry1rHI2fpMRjnsVDeZtsRoMJeqQDmySiniVqzAC56EZ95Ll8LR/ZGcIqcKGX2U5dGjailCsNH/m+O8qlozhyNGbwkVtHaiU5QNydlHDlvQH5D3jUuQVVdv8wqRKHtriH2SYO48w6vZNRrSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERhq6RRI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760452868; x=1791988868;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bzXzVGoX6Soh/go+uDrQi2kQPxtg+NUe8G2AQ2W5LuA=;
  b=ERhq6RRIgr4CCaB9QL3xKKMrR91sRxR8Spx/nXTNzIZ/AoVrhV+I6CUd
   tySlr1w9KJX2DVwfbmNILpqodVRNJHufJW5wSN4Z6dpqKQOUwrWNcZ3sy
   jVqg/tlFvf/gjl9ifbp/ry9ne0CI2Nx2whlP6TG4oDlA8XEaxbrsVSSAJ
   m5uJ2YcNZclpoM48xFrFsi6UhNwGm5d3TxNWnhZi2XMRDFi8JykHyKcL6
   4n0nYQPAPQQmZ4AXeA1cq7VfdiLjJFADdTcVbnUepa44JLWB2c0PMlXGa
   6bDt0ll+pP0h6G8qGw5qREHlEUWsOg7S1vc9Sy7hVss5dfGsypC9uNIQF
   Q==;
X-CSE-ConnectionGUID: QSc3pEGPR2yStoe8rHCUOw==
X-CSE-MsgGUID: 7wAnVZLLQZWgxwcKYi5R2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62319485"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="62319485"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:41:07 -0700
X-CSE-ConnectionGUID: 3ulb3REWRsyEgBFO1He+uA==
X-CSE-MsgGUID: LKZYOFdXSha35f1JqLHp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="187205148"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:40:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 17:40:56 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    helgaas@kernel.org, mattc@purestorage.com, Jonathan.Cameron@huawei.com, 
    bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v12 3/3] Documentation: tracing: Add documentation about
 PCI tracepoints
In-Reply-To: <20251014123159.57764-4-xueshuai@linux.alibaba.com>
Message-ID: <cf4d3079-2d1b-dfa4-aa5f-e018962131bd@linux.intel.com>
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com> <20251014123159.57764-4-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-19756653-1760452856=:925"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-19756653-1760452856=:925
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Oct 2025, Shuai Xue wrote:

> The PCI tracing system provides tracepoints to monitor critical hardware
> events that can impact system performance and reliability. Add
> documentation about it.
>=20
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  Documentation/trace/events-pci.rst | 74 ++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/trace/events-pci.rst
>=20
> diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/eve=
nts-pci.rst
> new file mode 100644
> index 000000000000..500b27713224
> --- /dev/null
> +++ b/Documentation/trace/events-pci.rst
> @@ -0,0 +1,74 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Subsystem Trace Points: PCI
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +The PCI tracing system provides tracepoints to monitor critical hardware=
 events
> +that can impact system performance and reliability. These events normall=
y show
> +up here:
> +
> +=09/sys/kernel/tracing/events/pci
> +
> +Cf. include/trace/events/pci.h for the events definitions.
> +
> +Available Tracepoints
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +pci_hp_event
> +------------
> +
> +Monitors PCI hotplug events including card insertion/removal and link
> +state changes.
> +::
> +
> +    pci_hp_event  "%s slot:%s, event:%s\n"
> +
> +**Event Types**:
> +
> +* ``LINK_UP`` - PCIe link established
> +* ``LINK_DOWN`` - PCIe link lost
> +* ``CARD_PRESENT`` - Card detected in slot
> +* ``CARD_NOT_PRESENT`` - Card removed from slot
> +
> +**Example Usage**:
> +
> +    # Enable the tracepoint
> +    echo 1> /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> +
> +    # Monitor events (the following output is generated when a device is=
 hotplugged)
> +    cat /sys/kernel/debug/tracing/trace_pipe
> +       irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 000=
0:00:02.0 slot:10, event:CARD_PRESENT
> +
> +       irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 000=
0:00:02.0 slot:10, event:LINK_UP
> +
> +pcie_link_event
> +---------------
> +
> +Monitors PCIe link speed changes and provides detailed link status infor=
mation.
> +::
> +
> +    pcie_link_event  "%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_s=
peed:%s, width:%u, flit_mode:%u, status:%s\n"
> +
> +**Parameters**:
> +
> +* ``type`` - PCIe device type (4=3DRoot Port, etc.)
> +* ``reason`` - Reason for link change:
> +
> +  - ``0`` - Link retrain
> +  - ``1`` - Bus enumeration
> +  - ``2`` - Bandwidth controller enable
> +  - ``3`` - Bandwidth controller IRQ

Maybe these two should be called "Bandwidth notification" as that's the=20
name of the underlying mechanism.

For the entire series,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> +  - ``4`` - Hotplug event
> +
> +
> +**Example Usage**:
> +
> +    # Enable the tracepoint
> +    echo1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
> +
> +    # Monitor events (the following output is generated when a device is=
 hotplugged)
> +    cat /sys/kernel/debug/tracing/trace_pipe
> +       irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: =
0000:00:02.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:1=
6.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA
>=20

--=20
 i.

--8323328-19756653-1760452856=:925--

