Return-Path: <linux-pci+bounces-38883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E69CBF67A2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A3D4652FC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0AA32E743;
	Tue, 21 Oct 2025 12:35:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1532D0C2
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050146; cv=none; b=Z3Jr6vvDHsCDCCF5wC4/OBoVGj2NHgQPFPhtQ+gmXLoyEbsV3IC97cFncnKA0m2KPC+GknXZNjxQ4AFs8x28hA3eu97GStCHOU20Ymsk0pmff0ULNgqyGUcibOZxAP2ALtt8nY338/hNJ2IrqusrZtKctDOjFKIiXGu/ygUfyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050146; c=relaxed/simple;
	bh=15aaBSnzhNfV6E7escSwJU7f9UjDMWInw9j6iZkiQXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUhd1MLvnDlbjH3B09l1MHHkmQapAzfBMsOE7Ui4fQueN8RJWp8DmWmm5YFVlJai2kUjfChtKJSICANR6RwwdGyeOSpHd7pt6a8b1WnqkC7TFZqMbWK5Dam6FVH6WkhgAWPaDuFTgoGfhMj/ed78Yy0F0P3aWO5deEOIK2GjCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2DD5D2C02B84;
	Tue, 21 Oct 2025 14:35:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E0FCF4A12; Tue, 21 Oct 2025 14:35:35 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:35:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <aPd-Fx_mq4Jyso0w@wunner.de>
References: <20251021104833.3729120-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021104833.3729120-1-mika.westerberg@linux.intel.com>

On Tue, Oct 21, 2025 at 12:48:33PM +0200, Mika Westerberg wrote:
> It is not advisable to enable PTM solely based on the fact that the
> capability exists. Instead there are separate bits in the capability
> register that need to be set for the feature to be enabled for a given
> component (this is suggestion from Intel PCIe folks):
[...]
>   - PCIe Switch Upstream Port that has PTM capability must declare
>     both requester and responder capable

PCIe r7.0 Figure 6-21 (on page 909, the lowest of the three images)
shows an example where the Switch Upstream Port is Responder only.

So enforcing that it must be a Requester as well seems too strict.

Patch otherwise LGTM.

Thanks,

Lukas

