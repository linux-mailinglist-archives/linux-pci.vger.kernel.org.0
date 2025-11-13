Return-Path: <linux-pci+bounces-41074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38759C56AC1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882AA3B7DC3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67422C327A;
	Thu, 13 Nov 2025 09:39:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE226B96A;
	Thu, 13 Nov 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026789; cv=none; b=YGf78Q86z7SwRxnM7jFNpf0wlmkRSIraCTq10o3M6wB+flY7uBDArxUM/JOFcKxcFbidljZf3hP0tTEtCmABIltuAsbBZyNLeTF7t/7GgaPNnQf7iEY4bLmWfp0eXoYXL2MnvNuZ9wesGmkWJ8gM3yb8KVG2PWh0Gr3ZwuPArAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026789; c=relaxed/simple;
	bh=JyOs83ES5xDEb+WWNZwFA2NK/2lJXpxI/KUuI3yL6Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adXQO5n6WZI1hIa2JpoawleSfj29k0AoWManjpxSjmyN0OhMeNxohn+keKflpLYe/DuQ/KwOAVjbtxLGi/cVvMyiyQ6S51bNoXLKYKulj5uSHTm2GOsTvStTm/ATyV/rbohh4e/o+ztbvfYu6Y1nsGUQyOLS4gEsdDnwXumkkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AE61C20083DA;
	Thu, 13 Nov 2025 10:39:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A8CDB1217A; Thu, 13 Nov 2025 10:39:44 +0100 (CET)
Date: Thu, 13 Nov 2025 10:39:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Johnny Chang <Johnny-CC.Chang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Digits_Upstream_Group@mediatek.com
Subject: Re: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Message-ID: <aRWnYCI6Ax14XNJq@wunner.de>
References: <20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com>

On Thu, Nov 13, 2025 at 04:44:06PM +0800, Johnny Chang wrote:
> Nvidia GB10 PCIe hosts will encounter problem occasionally
> after SBR(secondary bus reset) is applied.

Could you elaborate what kinds of problems occur, how often they occur, etc?

Thanks,

Lukas

