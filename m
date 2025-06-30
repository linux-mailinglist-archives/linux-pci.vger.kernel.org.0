Return-Path: <linux-pci+bounces-31059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33085AED5A4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BF43A51AE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475521B9F5;
	Mon, 30 Jun 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAC1e2gL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183372192E5;
	Mon, 30 Jun 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268630; cv=none; b=qzyHaG/SCUgXQ9OcshFODUrEPf3SbnBli2K0rC5EWuLY16HihyQXNq5TjjtpOlwJmq+LN1387ZAsZCgkgUW+OWL4F9Q/D6+wrE5gJCJB9zlCdHNJbryarR3TNhoCSFNuPgKnooKl618nzVL6kJ1a+bdT9ERmq+VWWvLr2YQtCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268630; c=relaxed/simple;
	bh=+W++RPlYJEyAeuhS3hRC53KAjTd0o4yYfaYBlxSa/zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAHoqRRA/M+mkGVeXV4E0tYkTvLUKl7e/fPXpnc7KkeCaiD81kaEo0jWFZUQVI/Ilt9meUq6qncKmzx5cVm/B7H9uwyHZvlXnuI9uIUQ7fbreb735XP0dyQbrRXg4rW48s6RGXlWL+1C4Lcrqh97h/IrZ86tnfKBM26qZ2srNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAC1e2gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E810AC4CEF2;
	Mon, 30 Jun 2025 07:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751268629;
	bh=+W++RPlYJEyAeuhS3hRC53KAjTd0o4yYfaYBlxSa/zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAC1e2gLG7Df7mfRBYmNwG6e6iHLGCh+oVWTpyAYbdn3N/WC0KEt1U8m4VzEJeqT3
	 O13ZFjZLLcPCegp0S15d0IvwXJ3s/pCOQ+3YPEa7DNsuFoSPBNctHpuwSlQLAHnFsl
	 zG3W50+2cLWtxIbJlGz4Ko51w6S1w/acU67vl02gmVm7/29t/75UhfnscOME4WsasH
	 kSutFgDcoVS+Um4UQ43LHcL9sN7VDjcMIkk3SC0c8XEsFGh6HamnTpw2d787yLfuGT
	 1o44BUSbuTQLrbV5XFSurXgj4Z+VI6VgCNglgLVSkqE3tlrP9PUUNeslXBQQSiN1Nw
	 CX/thVImS8hnw==
Date: Mon, 30 Jun 2025 09:30:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible
 for new RP configuration
Message-ID: <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-2-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-2-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:15:48PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Document the compatible property for HPA (High Performance Architecture)
> PCIe controller RP configuration.

I don't see Conor's comment addressed:

https://lore.kernel.org/linux-devicetree/20250424-elm-magma-b791798477ab@spud/

You cannot just send someone's work and bypassing the review feedback.

> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>

SoB.

Best regards,
Krzysztof


