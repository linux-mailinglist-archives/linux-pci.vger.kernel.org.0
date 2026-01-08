Return-Path: <linux-pci+bounces-44270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603AD03C79
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECBCC306B7A4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A833C1FE9;
	Thu,  8 Jan 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwGl/lQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB53C26DD;
	Thu,  8 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865275; cv=none; b=GuYZ9GdtnDPbrR63bUJztYcZwXR+q3LHsgtVQLv+BMaKdwSLmsOKVBO8B/PmiJzBYX1OjbxTF4qgV1BizDFHtvELQw4BuA5AMVii/crDiyMbXpEJq27w3ZI74n0o6m8kK2iBeJzFImBh67tfb+XtV7E/mPQJAIxJ9+Z8zauMZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865275; c=relaxed/simple;
	bh=UEaIQfRq82d68MoxCK3eZ2F/3OU0Q+vcRrHpzPPA6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOrrnRcXH60f9D/CU9+DovLYvjxmlX+YgWuwS02EmFC9qCWSHfaYA58FeVBOddFBbJkfVr3HtRu4kVRHbmbRxvtBmk+mwpwuo4sT5GxNCXtVR4OBHsOvviEl90n5DHmXKfZucPRZnB+ZELRg0xhmSs0Iw/m3aYvvBpzMRdBs2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwGl/lQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E8BC116C6;
	Thu,  8 Jan 2026 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767865274;
	bh=UEaIQfRq82d68MoxCK3eZ2F/3OU0Q+vcRrHpzPPA6VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwGl/lQhKitXy13aE9fSGLrPxFVJfyltMqldZArq6sNltJFhpZXO2prlgdap+1umG
	 cYs13LmbEDwx1KVmOLe5kuSnAIZS/Vzg/WMwQh2qofg8DWUXJcoR4obG6c64ftbkrG
	 +wHqUCABzC4jluOiArHl4pL2luB5vKCmJiGXTdhp9FnOeN4Q1gWmxbXYJoZRQnJIM8
	 /WJ0fNXs7GSfGimETwgDoz97Ke4tOzCKMdkZv8nSvo9w4VmgxGMlHS14yFR1p5tmCM
	 RbgCrj3aYJ8HWPmnQGUsjiT+qY0VXrSHytaElV4409IiI3mACaYhdM+jvF9z4xtWsO
	 X6UTxLs4lPofg==
Date: Thu, 8 Jan 2026 10:41:09 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <aV97tR3AKxBVCBHr@ryzen>
References: <20260108044148.2352800-1-den@valinux.co.jp>
 <20260108044148.2352800-2-den@valinux.co.jp>
 <aV9638ebwqc4bsbd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9638ebwqc4bsbd@ryzen>

On Thu, Jan 08, 2026 at 10:37:35AM +0100, Niklas Cassel wrote:
> @@ -596,6 +596,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	if (!epc_features)
>  		return -EINVAL;
>  
> +	if (epf_bar->flags && !epc_features->subrange_mapping)
> +		return -EINVAL;

This should of course have been:

	if (epf_bar->use_submap && !epc_features->subrange_mapping)
		return -EINVAL;


(I simply used flags in order to compile test without applying your series.)


Kind regards,
Niklas

