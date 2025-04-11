Return-Path: <linux-pci+bounces-25693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37919A86713
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 22:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D287ADEC5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F9283CB3;
	Fri, 11 Apr 2025 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH+wtpsi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F3280CE6;
	Fri, 11 Apr 2025 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403120; cv=none; b=rkVez2lRXzk2swhrNAoXI71ToK85xH5LFdKHKMfngcP3v/bfJks+2DEHn4ytK99cOwTFhUvft0h1bIAKViQv/Ydv+SniUcqQFr4jzm2GS4v/2wSZDeKPt9cfG3TlTmjxk6R2t4nl25mPceJDamKMYhRZhwVgg64W4uR5OctZdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403120; c=relaxed/simple;
	bh=nMvw9nh2VziZVm47ERw5+RmcVfGyxpAXKRMizmyOdeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJrYe20xzllk8oyL0sA46Xeu5hBphkwNkjDP5JEXL5wDl8k63D+hLgE84qQJB1iYU7k0P+7J4UxusIWhZw2pyvKZNyqTf+aRtK4egB/52/GYWuBSJWK9S+vJPkVioE+2NFnJ4LW3CtL9xbnBTJvxo+ZXtntx5eJj0f2R8QJq+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH+wtpsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7AEC4CEE2;
	Fri, 11 Apr 2025 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744403120;
	bh=nMvw9nh2VziZVm47ERw5+RmcVfGyxpAXKRMizmyOdeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH+wtpsiYfWhHr28LnjR21v5bQjZQO1ZtAfhmUbeTvX6wNxZUqezgvevU32/0iowS
	 lGA8YxD0OpAN4pgxb8DFtBqBetGLej9PsvCP3TR7k8hnjdUuZdpAVgRg2Rb79jJNJP
	 PvxpASNb7RCvw5McoyndExDJjSZtMmXgNw458aP2YNYQ6vCZ9PAJ8THp/IAYMKq4k/
	 TGl426rtF/soiKu/8Z9ntD0GD4nqAdXEQMWxynSYtHWU/uIUpA21Qjp9kGKWPqcIbV
	 y+TTubFm3IWZnYUu7O8SrntVuF9+cLm9TwXalQ16tmv3loGfZA/ZLk/S8Bnb3ja6HA
	 Knaq1iBw/XmuA==
Date: Fri, 11 Apr 2025 15:25:18 -0500
From: Rob Herring <robh@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: [PATCH v3 6/6] PCI: cadence: Update support for TI J721e boards
Message-ID: <20250411202518.GB3793660-robh@kernel.org>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-7-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411103656.2740517-7-hans.zhang@cixtech.com>

On Fri, Apr 11, 2025 at 06:36:56PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Update the support for TI J721 boards to use the updated Cadence
> PCIe controller code.

Without this patch, you just broke TI. That's not bisectable.

> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

