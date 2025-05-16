Return-Path: <linux-pci+bounces-27863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D748AB9D24
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C116CB64
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4E156CA;
	Fri, 16 May 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQhRs91u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E33171C9;
	Fri, 16 May 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401692; cv=none; b=C2+ZjLut7Li1Sa9YmxVzAuRG4BLz6pJgZnXhkc/vfOkJDqtRHRU1OzwjOpCC89lEhLrYjFTThvIhPHYlAo+88VpSWxseoE3gFrv/HrM2S4/8zMav1VNVWmSHu9xA9S/ZC0CoArwN7FNaTEoA8UYAL95g0dIRlsr6SG6C/9WzVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401692; c=relaxed/simple;
	bh=KgJP61kzz5j2x6iWOD3wK6IYg8bFFYNornXg+YN+f38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd5IgzowXLDP3QfsQNTTgzUdmqqL9q2bzcrAcu7lPpLpdgho9LEMQF86kRNYGTc0c8MYLAFz+mZm02aEYr182hQwkk1QIipYAA8cIVCS+9tsYCv00NqNCN/ovzNazEwxy34zX0UA3PY4WwwikA1L/6Xx2eTvSVASHZDIIUj4FAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQhRs91u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBEAC4CEE4;
	Fri, 16 May 2025 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747401692;
	bh=KgJP61kzz5j2x6iWOD3wK6IYg8bFFYNornXg+YN+f38=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EQhRs91uqzUfWEr70aHrc/lOweCDJmOxbjQ1qB6Q5Dgw4Lj7AjUEhHbnZLoufmRuj
	 apODnil1I0zkl3NkGM4ZJEkn2KhmOtM7i6vUrNIzYu/TsaAyvs5BWvQJNs+GaxMkds
	 UOqJf5vfXeqqqy6PipTFJ5tuhl9epGMwBvd35WGJi6a6OK9LUURgQO+myG0/3c35ka
	 oemf7oSujXk2WdQNhsgO71jtv1EkbPpERG590FcZF5Jrtr9RmQFMsLsmsAZeIiwi3p
	 VJ/kSfxQ07rScKLcvQZSLxMcDsUHLZK5Tbtp8+AHtxjOMQGOORwAM26WCAQeuPycym
	 ePLyQtdFdk2sQ==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Unnecessary linesplit in __pci_setup_bridge()
Date: Fri, 16 May 2025 13:21:28 +0000
Message-ID: <174740168485.69949.10466174549690717649.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com>
References: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> No need to split the line in __pci_setup_bridge() as it is way shorter
> than the limit.
> 
> 

Applied to misc, thank you!

[1/1] PCI: Unnecessary linesplit in __pci_setup_bridge()
      https://git.kernel.org/pci/pci/c/e57eb4f08f5a

	Krzysztof

