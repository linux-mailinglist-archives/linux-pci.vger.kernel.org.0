Return-Path: <linux-pci+bounces-36390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F2B82262
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7591C80CE3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3330CDA6;
	Wed, 17 Sep 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FscnWqJ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636EA55;
	Wed, 17 Sep 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147838; cv=none; b=AIcxS8001dorJj6bFu/Rt7oL9iznrb01FSqAlQxnU70P+fKpkci/80ukOtyUBrS3PJbl3R8meep2Hm2kz2eNe6e1qQjqsdHhKdCWh7plUnOC+frXIwIPHEjC3NeAJ8UnzdZWVu+0bFZah3Sif3lV2RPHyk9wjRIa3zuRsRuTeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147838; c=relaxed/simple;
	bh=UnGcqVgS4GD/7L0fDg931OMlNpuv6k722YO8GEx8cqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DKgB/rxaWOKQ0MC/d9lxHrOXPyiFJbRJzAxbtit+GZBNJlZ0lECDY6C5W2wI2CcumHKFbrQbkbxVltvgcQ3xuSH/K3thKRWpReFskPLxpx/dTENMM3GJFb7u5eMo6pG9rzEMuruHskSnjZzELvypt4xFWGySe/piqA6Gjhr6bdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FscnWqJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD618C4CEE7;
	Wed, 17 Sep 2025 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147838;
	bh=UnGcqVgS4GD/7L0fDg931OMlNpuv6k722YO8GEx8cqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FscnWqJ9AamopYzEys8/f8cfqCwSnkZMxdUlYjDRJrUENMYwk9TZD/ySS+hqZK6qb
	 zXtzx0R0Vbs176BSgMdIm3es4SHf8lKbT9d95iBS23JJFixlpAM9nYTx0DNrS+vNla
	 rpraXAObjE0eOTtLZmTfa24eaOqBaSgU3rBTCY3ogNWpoDEOO3XTqs0LtQRZALXwcE
	 bG7v0Wfz/2XkFbuKVqtuO2sWW6rJjGVTdO/wrwOumeDzouAjjEkddtQaAwZ4GWG/qQ
	 XyHMEjTT13N7fXH3xfeLMoGWxDo7cKsR+VEjeNa+hOePBnXg/+3kf/PoReZD3LCB0u
	 5DXf6T+YnmBnw==
Date: Wed, 17 Sep 2025 17:23:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <20250917222356.GA1879221@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917093751.1520050-3-hongxing.zhu@nxp.com>

On Wed, Sep 17, 2025 at 05:37:51PM +0800, Richard Zhu wrote:
> The CLKREQ# is an open drain, active low signal that is driven low by
> the card to request reference clock.
> 
> But the CLKREQ# maybe reserved on some old device, compliant with CEM
> r3.0 or before. Thus, this signal wouldn't be driven low by these old
> devices.

Can you include a citation to a relevant section in the CEM spec?
Maybe the point is that CLKREQ# is an optional signal added in PCIe
CEM r4.0, sec 2?

If that's accurate, we can add it when applying, no need to repost for
that.

> Since the reference clock controlled by CLKREQ# may be required by i.MX
> PCIe host too. To make sure this clock is ready even when the CLKREQ#
> isn't driven low by the card(e.x old cards described above), force
> CLKREQ# override active low for i.MX PCIe host during initialization.
> 
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card in this case.

