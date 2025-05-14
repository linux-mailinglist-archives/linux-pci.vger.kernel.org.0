Return-Path: <linux-pci+bounces-27749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01EAB7213
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F085189468C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647F1AC458;
	Wed, 14 May 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spwcclRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC92AE6C;
	Wed, 14 May 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242060; cv=none; b=nMewiVDHFHt1PbJiIN8igmo6AhFewv6zFcWUaDyI/TqgSIsi4HOAuXbBXQQGhwOk1IVQ2XZ1jbKIbRsKE2SCkeSIOWfE4YeSMpHAh53kSU1jf/ICJVSgdzIYVuBZy3i6CA2Lwtz1VQGXcznMZWdZ/HcUZrbDNP+t52BGVX19Nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242060; c=relaxed/simple;
	bh=7Ak+Wheya2VnhH7ofNVLt4IDAXhgUZEcfCdg2PZIMgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzPKfO7CI1Z1fMNhpO3ais/NJMHnUA1TXdRgwhIHWB1vw1voRPxB8lz9a/kOPCK2ovO4Dlls/HIAOTf9D3xa5pKYRa/edVFh+B1+j2f5TeUnO2ONWh1rrEGFWRjkark83RTPh5aQ6dA2p0OWSq1ZIHM++zAdEXKH+VVb7tLwKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spwcclRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66208C4CEE3;
	Wed, 14 May 2025 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747242059;
	bh=7Ak+Wheya2VnhH7ofNVLt4IDAXhgUZEcfCdg2PZIMgo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=spwcclRfWxfGuZ5lHYqAantrlpXHw/lUHFTE9GEkUZXmW5A0vfxSvPg/iTiXQDihd
	 YbYXFW/WbPDkxSB82IfjE15cTg04zU+Z6nWCxs6udOiF9+PEcobJOJmwVfB7TnCOn6
	 p6WCqp42IAajGWsDyGcUyzMFxqJVo+UddyCzBVyNxHXyewLv24ryVX45Xk463AlC8V
	 sN4arF7c4n4biaKw3FXXPwfUmOh/QMurjZKNCiwrVDzS+oW0TJowvtY52gi6E1Xjx7
	 HUWIP72FuIgHFSxK/SL5VoE/UpmTmsPT6l6puLx65OvPTxqWKWJsJQU+XoRIgPzjhl
	 dKO/2lHo7X2KA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Non-empty add_list/realloc_head does not warrant BUG_ON()
Date: Wed, 14 May 2025 17:00:57 +0000
Message-ID: <174724030409.16612.15891288907635598133.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511215223.7131-1-ilpo.jarvinen@linux.intel.com>
References: <20250511215223.7131-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> Resource fitting/assignment code checks if there's a remainder in
> add_list (aka. realloc_head in the inner functions) using BUG_ON().
> This problem typically results in a mere PCI device resource assignment
> failure which does not warrant using BUG_ON(). The machine could well
> come up usable even if this condition occurs because the realloc_head
> relates to resources which are optional anyway.
> 
> [...]

Applied to misc, thank you!

[1/1] PCI: Non-empty add_list/realloc_head does not warrant BUG_ON()
      https://git.kernel.org/pci/pci/c/9b388104e87b

	Krzysztof

