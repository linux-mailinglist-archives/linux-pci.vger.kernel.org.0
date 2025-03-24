Return-Path: <linux-pci+bounces-24490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D0A6D565
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28993AA58A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805425A2D6;
	Mon, 24 Mar 2025 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0tyseSF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DC25A2B0;
	Mon, 24 Mar 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802461; cv=none; b=i3GYazYzCdodkkcJ9hgCt8h04+1KsS1skNkz63C5tHc9nAjo9KuExGSCJLheAo8OVLCLtDi19/HGISmsW6rduZf6C/y7IbqyMTKdC73SuSvnY+qOXPATmVBRjNUNB+Z74FGOYkYYMyWYz/fYe0ktcFnxpndq99QLpeTSsP4nPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802461; c=relaxed/simple;
	bh=6SxKcj4gUIOYK9hOLL2QqT3WFOWrHJL1z+V3xAU4HWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIN9u1AqD19Bs5SdamlOdp+wuJB/ZwKF6seMf0zjmlpzCQWpogS8wcXjmspPSaeJA8nSMxgz3NMhR5Lk7IqtS97d1eeD+20jj9It1O0D7BHoLeCuvncUUpRDwzv4I0f5bfzvB+Aqpe0yNWIpKX+m5EjvQwMRfazu+Zve7M582CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0tyseSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27FDC4CEDD;
	Mon, 24 Mar 2025 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742802459;
	bh=6SxKcj4gUIOYK9hOLL2QqT3WFOWrHJL1z+V3xAU4HWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0tyseSFxU48myJcXGHrQB2TW2AnkXD2C/jDngzz5RL/CNYsjCJnGs57CZNZ34y5q
	 /I2syGM1xIJ3kXqKyUCe9ITk9r69JaTQZisUvY3nm8tE1mKmjNyy75RDgeHeMAzQoC
	 DQ416BwJ4gUyFp2J2WKlmjf4kUw3P5K/x8CIgZt1/4cIhamVL4iFzQDA9AKmJIUdJ+
	 JFuJHbtc/NK0kF3A3nu9bqdRDTD0+qbsd06WEZAAp17AJmUeDsz1XxUwU+s/AMIj24
	 c10wvpKsyPMQ8y0dBSQvSBqDwMlZUz6DPCGTPB5bMGzPcdAGV/5wAzeB3uVpidCGuH
	 LsvdFyPrtK/gg==
Date: Mon, 24 Mar 2025 08:47:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nitheesh Sekar <quic_nsekar@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	20250317100029.881286-2-quic_varada@quicinc.com, Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 0/6] Enable IPQ5018 PCI support
Message-ID: <20250324-shrew-of-total-philosophy-4fddc2@krzk-bin>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>

On Fri, Mar 21, 2025 at 04:14:38PM +0400, George Moussalem wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling PCI gen2 support
> on IPQ5018. IPQ5018 has two phys and two controllers, 
> one dual-lane and one single-lane.
> 
> Last patch series (v3) submitted dates back to August 30, 2024.
> As I've worked to add IPQ5018 platform support in OpenWrt, I'm
> continuing the efforts to add Linux kernel support.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> Changes in v6:
> - Fixed issues reported by 'make dt_bindings_check' as per Rob's bot
> - Removed Krzysztof's Ack-tag on  

Why?

Again, I cannot compare this serie:

  b4 diff '20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com'
  Grabbing thread from lore.kernel.org/all/20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com/t.mbox.gz
  Checking for older revisions
  Grabbing search results from lore.kernel.org
  Nothing matching that query.
  ---
  Analyzing 12 messages in the thread
  Could not find lower series to compare against.



