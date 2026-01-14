Return-Path: <linux-pci+bounces-44876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82BD21A3D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 23:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC023302411E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEADC3AEF37;
	Wed, 14 Jan 2026 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejYhhzQ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77C3AEF29;
	Wed, 14 Jan 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430306; cv=none; b=l/JrtzAJKpk02UGETGE8LVCSBUfuUUeECBCgdiTgjmII+Dgp7HGeprt5NnTOBFVaxUz0fyOKvjY+sO5v//NjFhyP+z7Fr059641Yoeawo3MxvUJxU/ScgPrl1LLkPFkvS0wXGT7O75nj3XCbnVEWrb576O8TI2RK4fZWpZmPWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430306; c=relaxed/simple;
	bh=cjUreU7Imwnb/V/p71wsXmBIsU6q29fyxsmQgAKswj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jJeLrASFmIsqGu4GixJcDj46eKgvsbsMAxHydDCWOp4nepPK8zrGKbKE/Rv7WhG4CSTuRL5mAxoASpcyH77Qxmg4WrklVtwi6qa4narEaUa6PNIZ0x3lFlAaaV2jI89e/B2l1Utc0PsBg3159ljQPGmOF16lrpMp90FVKivQVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejYhhzQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7026C4CEF7;
	Wed, 14 Jan 2026 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768430305;
	bh=cjUreU7Imwnb/V/p71wsXmBIsU6q29fyxsmQgAKswj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ejYhhzQ/9IY1RIRx761IXh2tHdWciV7iUDgJcjf4z9TLB5WyXEC/pPLt3rC+r8D/4
	 P8kqwTviG+NqugNZoKfllfX68oA3zVN7AquXZK/gUdTfai6qKa+9DaQnvNQ8xqorlK
	 OaGXuAIdfvvT5uwaEkj22s9jBIMkkRvF09/XH6ela8nEX7HN3fPZ85t3NoSLixi2re
	 ikGCAshP/jIBMDtbJCE3HL3K6iWIJt/pTwZ36K75/yaitOhHdJbuotfPBJc8qfiqNW
	 wWe4rcwOJqdBudeRELt+GxZwxZDSBkBrlwJeTMDSvtVi6SdPrspEUDEOMixd+HVpCA
	 +GlzaJxRXe/RA==
Date: Wed, 14 Jan 2026 16:38:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
	krzk+dt@kernel.org, robh@kernel.org, bhelgaas@google.com,
	conor+dt@kernel.org, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Subject: Re: [PATCH 07/16] PCI: rzg3s-host: Make configuration reset lines
 optional
Message-ID: <20260114223823.GA838499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114153337.46765-8-john.madieu.xa@bp.renesas.com>

On Wed, Jan 14, 2026 at 04:33:28PM +0100, John Madieu wrote:
> Some SoC variants such as RZ/G3E handles configuration reset control
> through PCIe AXI registers instead of dedicated reset lines. Make cfg_resets
> optional by using devm_reset_control_bulk_get_optional_exclusive() to allow
> SoCs to use alternative or complementaty reset control mechanisms.

s/handles/handle/
s/complementaty/complementary/

