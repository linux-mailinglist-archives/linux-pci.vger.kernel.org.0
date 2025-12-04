Return-Path: <linux-pci+bounces-42628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE537CA3BC8
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC22C302B32B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71C340A4C;
	Thu,  4 Dec 2025 13:12:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14690340279;
	Thu,  4 Dec 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853979; cv=none; b=FNXad3lm6HRYSSLz46bOfLW+Kl1mcuTD8WruSRy+5TWBYDst2M+PBSzTjV8SJNnK6997Pq1kUxOu324ZlhD7dcEWzLjIpRsfFTbapflyXZ1qFm12qRi5NpkuJFtS63ymf977s+qhJj+5hW3gdxjTpzDPwmTvLwGHCrBc2KW0oQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853979; c=relaxed/simple;
	bh=8UtsfgyvyCarqtNaWmVRyhE/uAT2Vg/FhzJTtdyXEMc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SVyNsq4wuI6zwbHTvuGoNqmjeNLWwZ8qhBdqgulXsQVtZKDFjUiy15RyQGw+NZoqsHSvEXU6xkVFtwCjrv/1Ib9dWxS4lrM0ao9pR0zofXJeD2XqX7uI8KVTszTZ3dwmayPfHnc7hOkIBgfTDxazUmZOm9bLuNevU9rDHcKKc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E700F92009C; Thu,  4 Dec 2025 14:12:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E3FD292009B;
	Thu,  4 Dec 2025 13:12:53 +0000 (GMT)
Date: Thu, 4 Dec 2025 13:12:53 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Correct iATU index increment for MSG TLP
 region
In-Reply-To: <20251203-ecam_io_fix-v1-1-5cc3d3769c18@oss.qualcomm.com>
Message-ID: <alpine.DEB.2.21.2512041311510.49654@angie.orcam.me.uk>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com> <20251203-ecam_io_fix-v1-1-5cc3d3769c18@oss.qualcomm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Dec 2025, Krishna Chaitanya Chundru wrote:

> Fix this by incrementing i before assigning it to msg_atu_index so
> that the MSG TLP region uses a dedicated iATU entry.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

