Return-Path: <linux-pci+bounces-25805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC26EA87D01
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ACC174686
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218526E16D;
	Mon, 14 Apr 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnb1SXSd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BB26E16B
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625174; cv=none; b=EIBUMUo3JEZIYBAKI+mgH6wthm4kLUVXLuHvujKnpLRKzuwn5b/ZKeQY0NtIrZI4veJL510z5O4BIdGwgJHIaZ5I2KTLkGXiaTZbA1jIhR7lF2/j3EAOll2IPhQX9VNPu9TU6MuiZTua2/cA8nfB8XVTwNJyfGcrDMwP3l9ehgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625174; c=relaxed/simple;
	bh=i2lYtsZGAS9XdlrMapzUnk0eGNmZJKYqS1yBto1gtek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruM5+SXNOANvV1T08PScCdKMO5YWIAY1flmHnhCYj3fSRxYNBrY16q6DhJsXNvLf6xfSbZX+3CAIg574mCK9GSUwNkXrItOXGbFtELev8fiZ8xdiv/llHn+yxcUslDtHnkEQITlu0FuvyuOCWEMv06ZQ2hjNX4yEWrQGs2fReUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnb1SXSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B25C4CEE2;
	Mon, 14 Apr 2025 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625173;
	bh=i2lYtsZGAS9XdlrMapzUnk0eGNmZJKYqS1yBto1gtek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnb1SXSdLlWm+dU/DMNl+RyKzZc5LSYXzbUMlbKHC/QRtbHQXOFlpDtVLJefjzVgS
	 Y/OfrRTqvgGJmx5mZpAph8cMY23YCapEH30D6U6PatxkEQTfgZzvoNilS9NO5EoxX0
	 asAzr60r9aM1TNTcEiRtn+n0ztMCQ5sUHF2R1tP35VZzpytZ39d9vFjTGHz3LvQCQd
	 BAhqL+X4qdb+0dHY6UuSmwemOfxk5IM5ec4+VSMnqK6N+Pti4XcKV+JuDWF+TXIff+
	 7L2lu80MJLKB2BYozNxjS1fPxG7ZpliI8Pp7q8YIJsLCQU4yyn8p7mF37ptpI93FDT
	 tLFZCZHWcv+SQ==
Date: Mon, 14 Apr 2025 12:06:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
Message-ID: <Z_zeERoDtZ52kW0T@ryzen>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_YwNt6WUuijKTjt@ryzen>
 <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>
 <Z_Y7h1vzVCCEiXK6@ryzen>
 <gogw24yg4lfq77ime7qyurvkef5yvmkkwjxo6xch52fbszibax@diaxredvtcrh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gogw24yg4lfq77ime7qyurvkef5yvmkkwjxo6xch52fbszibax@diaxredvtcrh>

Hello Mani,

On Sun, Apr 13, 2025 at 07:54:28PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 09, 2025 at 11:19:03AM +0200, Niklas Cassel wrote:
> > 
> > It seems like we should really add a warning and a comment in
> > dw_pcie_link_up(), so that others don't get hit by this hard to debug issue!
> > 
> 
> Right. But I'm also wondering if we should use the 'Data Link Layer Link Active'
> bit in PCI Express Capability for checking link up. Qcom driver has been using
> it from the start and there are no reported issues. We could add this as the
> first fallback if the link_up callback is not provided.

Sounds like a good idea, but from looking at:
7.5.3.6 Link Capabilities Register (Offset 0Ch)

"
Data Link Layer Link Active Reporting Capable - For a Downstream Port,
this bit must be hardwired to 1b if the component supports the optional
capability of reporting the DL_Active state of the Data Link Control and
Management State Machine. For a hot-plug capable Downstream Port (as
indicated by the Hot-Plug Capable bit of the Slot Capabilities Register)
or a Downstream Port that supports Link speeds greater than 5.0 GT/s,
this bit must be hardwired to 1b.

For Upstream Ports and components that do not support this optional
capability, this bit must be hardwired to 0b.
"

It sounds like the the 'Data Link Layer Link Active' bit is optional,
or at least optional for Gen1 and Gen2.


Kind regards,
Niklas

