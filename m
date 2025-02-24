Return-Path: <linux-pci+bounces-22244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C2A42911
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296871888955
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1712260A5B;
	Mon, 24 Feb 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eubje9Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91326244195;
	Mon, 24 Feb 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416913; cv=none; b=BR0jajcUQ5GB9tjtIyOIuEJtchc/bbYLtdR8TTXlwaZYmbmeBjVIi+NS257bbwK48Lrf/4MgbchxB/kZS1kDgPHFqiyqPTboWloHs9zgO/uhDQ1/iKSmap5AsWlMdQe9GZT5/LkJyRxoS9f3PHBmsGsF7ZKbi2/D4fZuArmEEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416913; c=relaxed/simple;
	bh=I5InXa5iPxIUg/XL60LjkpRPCQ4Lls7ukDWRdePp2vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au7EuIKxQTbjL7wVCnxhpkH/tS+rye2Rd9P0+DJFOMJk2bxVCcGSeM0mSoeBlE1E+beRTFpJ9tVWcy+1QPXB2RJC9eiqed9286MGIea/RvvthDy1nZv6Wy2R0ABviDzT1pDIm+QTLDrjEPsN5VYi0BGH9slSCGQOHwrJh3nKXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eubje9Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EA5C4CED6;
	Mon, 24 Feb 2025 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740416913;
	bh=I5InXa5iPxIUg/XL60LjkpRPCQ4Lls7ukDWRdePp2vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eubje9YlzJi0bBqI0AJSqLsQzrWoa05DCF4dgQBTG67+gfFKVSE6L+hh0/t4ZwX+w
	 rnVqn/tMyeSMSBJwS9FEuM7TaD2jxfme7QAgZvFBJO15SathlzjfJGvKPymY9/iSWY
	 XLcJlIPqc9Y2GYkObgbSNBWu5Wpff8xnVxjdKOzue5JmJDWG/Agwp9RbJfT7zC60v8
	 jeYEZze2FbDMF+Of/JG5USwIcNmOZCLhtJrkiG13XUrQdF/xePJhxFUq7CSfkIXRrE
	 X9x8ZpRa90FZlDRgpQqN2k4w+b/RGXWvg9PMxKohOc0yEPuAfykOvnwvAHyicbye/5
	 gwpDw0eztSzVA==
Date: Mon, 24 Feb 2025 18:08:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <Z7yniizCTdBvUBI0@ryzen>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>

Hello Shradha,

On Fri, Feb 21, 2025 at 06:45:43PM +0530, Shradha Todi wrote:
> DesignWare controller provides a vendor specific extended capability
> called RASDES as an IP feature. This extended capability  provides
> hardware information like:
>  - Debug registers to know the state of the link or controller. 
>  - Error injection mechanisms to inject various PCIe errors including
>    sequence number, CRC
>  - Statistical counters to know how many times a particular event
>    occurred
> 
> However, in Linux we do not have any generic or custom support to be
> able to use this feature in an efficient manner. This is the reason we
> are proposing this framework. Debug and bring up time of high-speed IPs
> are highly dependent on costlier hardware analyzers and this solution
> will in some ways help to reduce the HW analyzer usage.
> 
> The debugfs entries can be used to get information about underlying
> hardware and can be shared with user space. Separate debugfs entries has
> been created to cater to all the DES hooks provided by the controller.
> The debugfs entries interacts with the RASDES registers in the required
> sequence and provides the meaningful data to the user. This eases the
> effort to understand and use the register information for debugging.
> 
> This series creates a generic debugfs framework for DesignWare PCIe
> controllers where other debug features apart from RASDES can also be
> added as and when required.
> 
> v7:
>     - Moved the patches to make finding VSEC IDs common from Mani's patchset [1]
>       into this series to remove dependancy as discussed
>     - Addressed style related change requests from v6

I tested this series, and one thing that I noticed:

# for f in /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/counter_enable; do echo 1 > $f; done

# grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Disabled
/sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/ctl_skp_os_parity_err/counter_enable:Counter Disabled
/sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/deskew_uncompleted_err/counter_enable:Counter Disabled
/sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/framing_err_in_l0/counter_enable:Counter Disabled
/sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/margin_crc_parity_err/counter_enable:Counter Disabled
/sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_1st/counter_enable:Counter Disabled
/sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/retimer_parity_err_2nd/counter_enable:Counter Disabled

that there are some events that cannot be enabled when testing on my platform,
rk3588, perhaps this is because my version of the DWC IP does not have these
events.

(Because all the other events can be enabled successfully:
# grep "" /sys/kernel/debug/dwc_pcie_a40000000.pcie/rasdes_event_counter/*/* | grep Enabled | wc -l
29
)


So the question is, how do we want to handle that?

E.g. counter_enable_write() could theoretically read back the
dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
register after doing the
ww_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);

to actually check if it could enable the event.

If counter_enable_write() could not enable the specific event, should it
perhaps return a failure to user space?

Or, do we want to keep the current behavior of just letting counter_enable_write()
return success, even for events that are not supported by the specific DWC PCIe
implementation?


Kind regards,
Niklas



