Return-Path: <linux-pci+bounces-30665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8160AE90D1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCF3BD904
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C689926E6F0;
	Wed, 25 Jun 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXAoUDov"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170B26E6E6
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889440; cv=none; b=E5tmoDgeIqyNusKwzkcsQP8Gdq38awwY1GtOI1TQCe1+7AVVBhDSMIIl6zle7dfMuGXKLuc4yOifje80oXTpKYgqYOJnLDDc/Hl72dyiJR+sxTTM8ROJOXwRnu12lRbDVdklAPhSSIE+rxdsvTo1fjAys4vu1UNLjpDesYfsvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889440; c=relaxed/simple;
	bh=iEOfpyhrZau/LTAC6DMZMLu5SokkcqAUXz3XAwcpf6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qinaUN9TFins8Ga4eMB1uPK5ZNhwftp7LlvGQQRguL1dwlYgibCy9eqLdEe6krppr97wCSoHgODJjgBg6Y1tZlmfI3M9fh+GuB3SGD8vQPwiKCnpKUUiRD61hRl7rVhYsm5A7tbbC9ZgD/6T9fLnKRg1XMwbliSL63GfGImOIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXAoUDov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB2C4CEEA;
	Wed, 25 Jun 2025 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889438;
	bh=iEOfpyhrZau/LTAC6DMZMLu5SokkcqAUXz3XAwcpf6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oXAoUDovanNWEwxDLKR/jeGb16Nm9pLcC7TnV5nGWguhYfJ/qiWWWsq19FphJcToi
	 MZmGq7xtTOml7KcuuTS3fPkFZuiYccIda1a/M5/aAh/7xRw4meSwOG9zhClZqFOiCs
	 PtL1EMm7ZPpQtCgqnod9zy/Vpk/AlInnmbKbm3vjAMBT71Dn14r25dQmBGlreZuZaT
	 LTDyEJphEw2bM3QkcMl0M2CLgcUfKndJ6gE+lRE5exH4KwZwze5bK9Yi+10LPp7400
	 txRPgtWtjHPbGhvlNmztsjHc+x7YGnIEYHuaXo91k/jdpHK0cRQn67abJemDiozjZB
	 27QpPeyN3W0DQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
In-Reply-To: <20250624114544.342159-1-dlemoal@kernel.org>
References: <20250624114544.342159-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/2] Fix EPF configfs attribute group removal
Message-Id: <175088943642.35267.18082641117885459492.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 16:10:36 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 24 Jun 2025 20:45:42 +0900, Damien Le Moal wrote:
> A couple of patches to fix removal of configfs attribute groups of a PCI
> endpoint function driver.
> 
> Changes from v2:
>  - Use list_del() instead of list_del_init() in patch 2
>  - Added Niklas' review tags
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: Fix configfs group list head handling
      commit: d79123d79a8154b4318529b7b2ff7e15806f480b
[2/2] PCI: endpoint: Fix configfs group removal on driver teardown
      commit: 910bdb8197f9322790c738bb32feaa11dba26909

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


