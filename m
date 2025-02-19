Return-Path: <linux-pci+bounces-21817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE2A3C678
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DB2188EB85
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893481714B2;
	Wed, 19 Feb 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBJq3tT+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603021F61C;
	Wed, 19 Feb 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987156; cv=none; b=j5RhzpE/kT5W4Zu9JnnACkDZ11VA6IrV16gZp68ouWaUMZoNYLwW3TNkOel2JLyvlpVPGWLev7Y5tfPS+ykEP5uqk4a+yfbYQ7w3OGCFBAp/AeFkY2KnLwCndkGAxl6WF8ev1Bu3FjTdBqwEbikKuxpFxrOjE3KAnjlXb3pnN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987156; c=relaxed/simple;
	bh=OoQAimFA7R4sw2wy3Xb8P7B/ZeQ9EXQikBds9cRlDpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRsymumqnoWSpeEpyI0Nrp1KSLbrX1FpFFXnt8/ddoZNg1Z20lKZBl2sBUM1c3BsZS1a7SdZBC3zjOmUGPI9r066lbf3aknYjfg6M7werCBh18FW2nrIkwxeDY/suzEgYCWUhk9SB1buq0fbTCRR3idSQFy2iiOss+XNLHcvnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBJq3tT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B9C4CED1;
	Wed, 19 Feb 2025 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987155;
	bh=OoQAimFA7R4sw2wy3Xb8P7B/ZeQ9EXQikBds9cRlDpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBJq3tT+ep9ojdjKhW+ra0Tar8VThKkamqTYbtZCPdKcCfuEv4uYczXgI9EHPzSO0
	 e6oyAnWt0v5yQNAlz/UlVQBq8aIxV+5pFRl6+tEIjCnYbgYTXrK8phe78HT1mpsZ3Q
	 zLZMG7uIFGiu0LMqwsHZWTLC7RbLmgHBEDmNqFgtVRhzyHWxXmUKIvx/WAptmcOXjD
	 oaYyTJie7hH8HhsKgUe/GE5d0G4wdcWKqcsmJP9qEoT7jy9LxO9qNmHyrrmRlmr7vO
	 QMAme0n/gEqKxXOaqpMT+Zo56gLEgURrUQiGuCYSmIFiApf5J4aeOzfPzwBsa3I1p6
	 rxqFJg5MxS03Q==
Date: Wed, 19 Feb 2025 18:45:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, 18255117159@163.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 0/4] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <Z7YYzdN-MboQKIt-@ryzen>
References: <CGME20250214105330epcas5p13b0d5bef72b012d71e850c9454015880@epcas5p1.samsung.com>
 <20250214105007.97582-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214105007.97582-1-shradha.t@samsung.com>

On Fri, Feb 14, 2025 at 04:20:03PM +0530, Shradha Todi wrote:
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

FWIW, for the series:
Tested-by: Niklas Cassel <cassel@kernel.org>

