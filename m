Return-Path: <linux-pci+bounces-21475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F7A3622C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94A33B247D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FF267382;
	Fri, 14 Feb 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQnbNgfP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87159266F19;
	Fri, 14 Feb 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547953; cv=none; b=Y5bpzB+MI1rQ4bgMaprNHHVulUboLasNNZsZ6rFAIEr9VTCM3vWuTiEcI7CYom9wC8AfBiIGBVGZEF/TCIKvPmL6i/3+hBPLYwEUV8xb6TVQuWkVwe8k4ZmM6ODP0oAQ9tYsRlIwILVeBR+UQk76WSzQSkrYcLrMdYLxU7tF5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547953; c=relaxed/simple;
	bh=9JgdACbhkpAouEWMMO/S2geqxFPM40RbgjRRU/HIkmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdeX7SooZVWHz8PQN8iVAewPHkXdRzFzRtGXpgS83kb8rgxSJ2Xx0UNnPAo4pZqpCQmTd3bUSijFU0qXPoA+5CDRFwVzwks6vGH40JXp1+Ikgdnwkye66RC/mvCVdCBhA0xSt+R7kXW72b0OuBZE81saRAbzhgPyrhzUliQ1yeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQnbNgfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A55C4CED1;
	Fri, 14 Feb 2025 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547953;
	bh=9JgdACbhkpAouEWMMO/S2geqxFPM40RbgjRRU/HIkmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQnbNgfPvxfzFLltrMfaOcr1qGRnTclWmD9PTEJ61L3bixWGfushyl5Ok1kVuCnOU
	 U0PmLntEhS5DlThl7JNh1WjoGK/aMG613SnKl7saNXAUSLNNLjS8EnJHzWdRLcwMSH
	 P1zKRq/BpESwaBAo6zdPk2QamXe/vRQ6T2o9sC0CqF2TJr+5Y3fvdqrS2UUE+7Cyqv
	 oaVmkB49bTxmINM6ih83v38QZLN199uZiUEc0sVVl/36B08FIsUCeNgxIVenXMcDoA
	 lzH+cAc8l9zNwRtJCPrYe8S5hhDMfohOcY1/eWbUgwoPF02bpl+A42DmnEl7MAntnV
	 GmvK8pup29Fwg==
Date: Fri, 14 Feb 2025 21:15:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5NC Versal Net host
Message-ID: <20250214154539.jqbjkms32ew5zpd2@thinkpad>
References: <20250212055059.346452-1-thippeswamy.havalige@amd.com>
 <20250212055059.346452-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212055059.346452-2-thippeswamy.havalige@amd.com>

On Wed, Feb 12, 2025 at 11:20:58AM +0530, Thippeswamy Havalige wrote:
> The Xilinx Versal Net series has Coherency and PCIe Gen5 Module
> Next-Generation compact (CPM5NC) block which supports Root Port
> controller functionality at Gen5 speed.
> 
> Error interrupts are handled CPM5NC specific interrupt line and
> INTx interrupt is not support.

supported?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

