Return-Path: <linux-pci+bounces-25499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF5A80F50
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BAA4A6987
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6021D6DC8;
	Tue,  8 Apr 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nls8soHG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AF1D5CCD
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124785; cv=none; b=p/kLAY3BM8bPVPiYx+aOMO4v3bifuY2XQWBH0yju6qwCPqSlpF7FEkHWuasd8ps2BSD3C6rX9pw7Der9iQaceCfdUwUO2dmTXe9Kmhlhtpn1MNS3JhnYwFjz3o69K+cLOc3+blwpyxyfkJxyJm4ZsgV0ReKUR4RQWsgrKMKrwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124785; c=relaxed/simple;
	bh=QSy+M2nplL4n+jfh9GvcaQtWxG6iwKX+hUAw8yIdc/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hRNN/t2mKRcJYOUFCCjCNpScgVc7/ho8Xf+g9tQ6hdjAi9alDVW4oBJ+IeQ82UqvoCxvW7qtfc7sm+8jBVAmmx89XQkjXz8xmn4HSZ4E8P0IW8GjFgjwmJoADcqS1jvo3crcOkxdgNHTSKE6IbOJkrG4J4s5sR+sDu5T8Zz/L3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nls8soHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E3C4CEE5;
	Tue,  8 Apr 2025 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124785;
	bh=QSy+M2nplL4n+jfh9GvcaQtWxG6iwKX+hUAw8yIdc/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nls8soHGzlUr+MbGb/vaBSrTvFQ8b77nXJ1xpPRa1v0pgrI/Y313fSm8wSdrcXPQp
	 eZ8KpLhh46Iy9TAjKWNLnyp2piOVbO/DMp39IOl9WKn4JMoHz16cmzmIWOzgtJ4ruK
	 Of27A3HL9CQ79eGWnLIje4HlFwmiexz4nvqOThfirVgIWa51eLHzOLaU2or6JL7Ypz
	 xVxlP+LZvCOrRN28l4PbB3xXMmDdkzx25h3CPwBCe+uMmYfr7KKrnt7kxPi7ZIm9Fr
	 2k8Y5xh/WyUTDsYn8LyPHZzAr1XgUbKjev/m69D3NArLUfxBtVh/EUhVxLXSJk2v4P
	 DNZ4NrJcEuvuA==
Date: Tue, 8 Apr 2025 10:06:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damir Chanyshev <conflict342@gmail.com>
Cc: linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: Re: P2PDMA support status for the sappire rapids+
Message-ID: <20250408150623.GA232275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUwoOjXGzaTQ4Dbx3wcMOiy484Sjd4Vv1=ZDiVrYvCEaNiRcA@mail.gmail.com>

[+cc Logan, Michael]

On Tue, Apr 08, 2025 at 05:48:16PM +0300, Damir Chanyshev wrote:
> Hello experts!
> First thank you so much for everything.
> 
> I have a question regarding p2pdma support, I am not an expert in the
> kernel subsystems, please pardon my stupidity.
> While investigating performance opportunities, I stumbled with dma
> between cpu root complex and pcie switch root complex. And found white
> list for the Intel platforms [1]
> 
> Typical topology looks like this rdma nic<>cpu<>pcie switch<>gpu/xpu,
> for each socket.
> Questions:
> List not updated because new hardware doesn't support this feature?
> (For example abandoned for the CXL3+ )
> Or just not tested for the new platforms?
> 
> [1]
> https://lore.kernel.org/all/20220209162801.7647-1-michael.j.ruhl@intel.com/T/#m3f4e4194770274c2873a130ad684a74469038585

The pci_p2pdma_whitelist[] is only updated when somebody tests a
platform and determines that its RC can route peer-to-peer
transactions between separate Root Ports.  This routing is not
required by the PCIe spec, so we can't assume that all platforms
support it.

From PCIe r6.0, sec 1.3.1:

  The capability to route peer-to-peer transactions between hierarchy
  domains through an RC is optional and implementation dependent.

Bjorn

