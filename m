Return-Path: <linux-pci+bounces-21478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241ACA3628B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F6E3B07D3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615482676CD;
	Fri, 14 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruDAGkPu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDA2676C5;
	Fri, 14 Feb 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548659; cv=none; b=uT/xCRHL7nZV2oT8hwRUoo5U/548nO9Q7ZV8pUKhMZe3e9anL2bJnUIHrv6uCR73mCcdH3m43GaZgxCOzjvS+7v2hF867IGjeynKUVQvm6ahD9GkDDAluMSx4TXz1k6vqQp3t8F9pRbebjnPW02eYFNMUeqTmBNNJ6UlUSa+dHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548659; c=relaxed/simple;
	bh=k10pvCmmHysowNYWxzueRHt8N58k2IAsGCBI2j82cfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBSUhQEwFsOH6hmip32Bumkq5CfpXZKCMxfu3LuOKeW3VnxEOwysi5iWWs/oNV0YLzgEwbQrC43JT1JD9zE0fXp9X1Mw8I8LNfZ4bqG/0jAC/e3W48CwycjcXshL0kv+JT74cN5o7g9HK3JARsqD+kowt8oXcGoQznfwhYfMTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruDAGkPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5313C4CED1;
	Fri, 14 Feb 2025 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548658;
	bh=k10pvCmmHysowNYWxzueRHt8N58k2IAsGCBI2j82cfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruDAGkPup3uA9Ik8IdZwo73H2VQYKkhwrgnZz7hGgcxo8aWX5epCL2b5Fve6ivI4E
	 SuOAshQ5sdAqaKKXDskhV18cs1wK/E77YyecTIKyMWZIMNFEF3KDJX03AH/oXuElFn
	 Rw+YC3TlGPzuMrioj/Ar3S5Ry3tFCOQ+PkmrXzUwUhrmGzFH1RibPYynzOUSLF1HWU
	 e2Kdi59e4GZ4JFywu2Gm4INGZDEszJ25K3DMZcb6fT0NdpwE8fgpu8iAmX8fieKQTj
	 Lxh/XKnjsYylN5n+yQ8rv6J0To9SbWcEU9YDGvs0R8BsaWZsmojywjDOEDY7/d5ovg
	 5b4KCAwWBrZxA==
Date: Fri, 14 Feb 2025 21:27:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214155725.jpkd4vtcycav4yrc@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
 <20250214132115.fpiqq65tqtowl2wa@thinkpad>
 <332ec463-ebd9-477c-8b10-157887343225@163.com>
 <20250214153103.4cjlawksw4xobc2l@thinkpad>
 <3d3d8772-08ba-4e5a-bf1f-71821cf056e7@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d3d8772-08ba-4e5a-bf1f-71821cf056e7@163.com>

On Fri, Feb 14, 2025 at 11:48:16PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/2/14 23:31, Manivannan Sadhasivam wrote:
> > On Fri, Feb 14, 2025 at 10:28:11PM +0800, Hans Zhang wrote:
> > > Sorry Mani, I shouldn't have spread this SOC bug. This is a bug in RTL
> > > design, the WSTRB signal of AXI bus is not connected correctly, so the first
> > > generation SOC cannot send message, because we mainly use RC mode, and we
> > > cannot send PME_Turn_OFF, that is, our SOC does not support L2. I have no
> > > choice about this, I entered the company relatively late, and our SOC has
> > > already TO.
> > 
> > Ok. Just to clear my head, this patch is needed irrespective of the hw issue,
> > right? And with or without this patch, first revision hw cannot send any MSG
> > TLPs?
> 
> Yes, that was a problem with our own SOC design, the Cadence RTL bug.	
> 
> > If so, it is fine. But is there a way we could detect those first generation IPs
> > and flag it to users about broken MSG TLP support? Atleast, that would make the
> > users aware of broken hw.
> 
> I don't know how to do it, but here are the questions that were actually
> tested.
> 

Not related to this patch, but please check if it is possible to detect those
controllers.

> > > 
> > > This patch is to solve the Cadence common code bug, and does not conform to
> > > Cadence documentation.
> > 
> > you mean 'does'?
> > 
> 
> What I mean is that common code bit16=1 is to send a message without data,
> while Cadence's development document says that bit16=0 is to send a message
> without data. This is not consistent with the documentation description, and
> the final verification results, the development documentation described is
> correct.
> 

Ok, makes sense now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

