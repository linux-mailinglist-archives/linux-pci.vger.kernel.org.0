Return-Path: <linux-pci+bounces-29235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B59AD2244
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB5316205D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBFE14B959;
	Mon,  9 Jun 2025 15:20:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960792AE6F;
	Mon,  9 Jun 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482446; cv=none; b=V5P80Ncw6jUQDybk/qlPOuGquNgSjXqht0hL2d4g1zJP1gNEigneY55hpZh2NJEtbODmN7OnFvxCFFB1+TuFqViTSZazhmQUnzLoYGeqaRbbAagEPEtxpnB+wNHh0QYt4t8mVqb83n8S2nA7rXPEjCSCiJSZ/aIgGTHpU2QnYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482446; c=relaxed/simple;
	bh=S5MjouzVBEYiroMvzZ+UMTs/GRMi3u/J/p9JiNcVoNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6RV0ZWbNRhrtJ9ny0aZ7NMygao4wfh/1oTxDUujWi+fgHmjcGEPsqSvQAK7knBuF/QWIHPu1qctCFk83AL/aTZEdmEQe4xhm8NOpcDmNHWSjK9a6xKPDLS+Cuj5EAO1atkNU7CsiaulfUE1dOIFAzEMzpezJgY8G3uUfTbUAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 19E932009D01;
	Mon,  9 Jun 2025 17:20:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0618F364197; Mon,  9 Jun 2025 17:20:37 +0200 (CEST)
Date: Mon, 9 Jun 2025 17:20:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	gregkh@linuxfoundation.org, mathias.nyman@intel.com,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/4] Don't make noise about disconnected USB4 devices
Message-ID: <aEb7xcvNl0MX-Tem@wunner.de>
References: <20250609020223.269407-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609020223.269407-1-superm1@kernel.org>

On Sun, Jun 08, 2025 at 08:58:00PM -0500, Mario Limonciello wrote:
> Mario Limonciello (4):
>   PCI: Don't show errors on inaccessible PCI devices
>   PCI: Fix runtime PM usage count underflow
>   usb: xhci: Avoid showing errors during surprise removal
>   usb: xhci: Avoid showing warnings for dying controller

Patches [3/4] and [4/4] (which touch xhci) were only cc'ed to Bjorn.
You may want to resend these two to Mathias and Greg.
You might also want to split the series in two separate ones
for PCI and xhci if/when respinning.

Thanks,

Lukas

