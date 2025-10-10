Return-Path: <linux-pci+bounces-37788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8149BCBF63
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 09:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2BA1A615B4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A81274FF5;
	Fri, 10 Oct 2025 07:42:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C75275111;
	Fri, 10 Oct 2025 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082173; cv=none; b=UEc86A0E1p7yrcVRlDcc+cewjKkS6LIbeVDRqfwuOED0M8AJYHfyACDulB9UADELm6/78VhZzk892X7ncEzgOqdFU+swZctYfSEew4FIUrrn0ol/N5muC9jRtnEDyJHSWtngDDeSRWQQUedgsQsWfgqZ3rOW6y4SdRBhgnzA2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082173; c=relaxed/simple;
	bh=zAdLYs+e0zcjVEpfMCmDpTPCvUUFUgoWDnRZ9jiqzn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIaYaSooxJq6fpai1O/GZDk4V+LDW5LZnDFKe20A1jRF2ltXzbt59FbHa3RpRGws6XW47SooAqBXlyqaX7sc/8GwpaefHEYdjjwkstyV6huEdVLKHUaJE9UsqQibKWCoR/AznSHB2tXi6G9jS06Z9TZeBC62k4lQVY8TF2KhD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 70CCB20083D0;
	Fri, 10 Oct 2025 09:42:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 68BD35FC4DD; Fri, 10 Oct 2025 09:42:41 +0200 (CEST)
Date: Fri, 10 Oct 2025 09:42:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	helgaas@kernel.org, mani@kernel.org, robh@kernel.org,
	sashal@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: cadence-ep: Fix incorrect MSI capability ID
Message-ID: <aOi48Vt_hfNvwA6t@wunner.de>
References: <20251009161011.11235-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161011.11235-1-18255117159@163.com>

On Fri, Oct 10, 2025 at 12:10:11AM +0800, Hans Zhang wrote:
> In a previous change, the MSIX capability ID (PCI_CAP_ID_MSIX)
> was mistakenly used when trying to locate the MSI capability in
> cdns_pcie_ep_get_msi(). Thisis incorrect as the function handles
> MSI functionality, not MSIX.
> 
> Fix this by replacing PCI_CAP_ID_MSIX with the correct MSI capability
> ID(PCI_CAP_ID_MSI) when calling cdns_pcie_find_capability(). This
> ensures theMSI capability is properly located, allowing MSI functionality
> to work asintended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Fixes: 907912c1daa7 ("PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/r/aOfMk9BW8BH2P30V@laps/

This is material for the "pci/for-linus" branch.

