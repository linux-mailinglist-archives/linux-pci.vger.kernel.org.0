Return-Path: <linux-pci+bounces-21818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96229A3C67A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F237F7A2A8A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4D2147E0;
	Wed, 19 Feb 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGopIMVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D99126BFA;
	Wed, 19 Feb 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987161; cv=none; b=KcDB5LBd2GBk5Ze/qRPb4q3Y3BojuOIJwKfiW17LgtEHHClP0lqByXVWcLR//PF/sHrRaM0DP6mhtI4iUNcoCBf+cOfPW7NsB8Dkria5KNUY6uwNhRKenynAHzDPwG3qRBgo+stmX0BydsXSu00A7+wdnlPoavV4yc8TSiReWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987161; c=relaxed/simple;
	bh=mHRhEBvpD1bsnQdjjXq4vxjKV6dJIAdVYqioCYQWdyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSluttai/npMnGDHi8INjq2JFjpEQc0SQElBVYZTOo1pMr3zgO7BMlLoWSh5aeY4gLxEyf5bMBaHpFs8lFpQ/aydtMGZT0k0JhIFPAIlkiGCIyiaT5zdmm81aQ8M5DgNjTrHFSBWgMv4ld2PD6PV67bQkVv+3MDbxuCgDz5/Ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGopIMVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527FAC4CEDD;
	Wed, 19 Feb 2025 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987160;
	bh=mHRhEBvpD1bsnQdjjXq4vxjKV6dJIAdVYqioCYQWdyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGopIMVqS5Hk9p5JoJ2VnAeelIeuwL0T5ZZZ+OkyawwkgMyV41CXKh2RHOcjkEZU7
	 9BD1Lq2lA73TEJgzm/8g/CEZcJkSk1uhnujkiek4N1+8QmXiAH3xS4HIX8DPF+Isoa
	 ofNFjOWLWRTH7lomxG+p2mXde8A9Y3njeyMneknlj0yQW9lvOlP7ov/9czYG1938nA
	 2uDHy2yCZ+WODYErVWjnx7FyPgB1rG52ztSKzHZM3XzYmgF2eQbv/azEgQI10REXd/
	 RA3xe+lXrFbD1eOxSJ69byBA34/rR1Blb9oVS6BHJKBR/e3083/uQVVZ2Yk/eGV/fd
	 mZfnZP+r2Xqeg==
Date: Wed, 19 Feb 2025 18:45:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v3] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <Z7YY0-oaK_WZwx17@ryzen>
References: <20250214144618.176028-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214144618.176028-1-18255117159@163.com>

On Fri, Feb 14, 2025 at 10:46:18PM +0800, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the root port device.
> 
>   /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---

FWIW:
Tested-by: Niklas Cassel <cassel@kernel.org>

