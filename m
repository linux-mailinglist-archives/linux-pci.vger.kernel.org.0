Return-Path: <linux-pci+bounces-36385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18CB82150
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 00:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567F57B114D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAAE30E85F;
	Wed, 17 Sep 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls+BvwCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAF261B70;
	Wed, 17 Sep 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146384; cv=none; b=GlKBx7Yr533rMgit/5O4/r1hUaVAQNuFTn81yNc1jn+aLSbBsKnGxW9Tn8wGZgoFhM9d1RMLrni16ooyA4Zru+G5BiOsPi1RGWQVMHVm26Bxb/Nyscp2IZ2Dbr9I63nupRitMNfSS2wyNU55pxHEjF69/BLo4aLj5uZOXDjwMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146384; c=relaxed/simple;
	bh=Ms4zIK3ciyF4BwpMHGeMZVIXlgJkP7aXFnQ2D+V8mU0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cbEO1LH8HOsZjhhBgbyaa4GcSd1WJ9hc1Ij28/+wSQXLSHM2FYkCRzhpTJvKMn1mrivzRCdWp7S4lq61A9x5rFMWHJSjPAGXChkxUMpeyKavcn4zStuQCIAFtRa+fxBmL5EXB/XKcNy+7L+0cuaI4j8HUJvWDC/MI47Z8aB0czc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls+BvwCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C626EC4CEE7;
	Wed, 17 Sep 2025 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758146384;
	bh=Ms4zIK3ciyF4BwpMHGeMZVIXlgJkP7aXFnQ2D+V8mU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ls+BvwCq0KajkMJX+MJcdaNZJeNvvWmelGxPaw0KYIcfi0TR1mG8iBybm6PU/7JDl
	 9hwdxfqo9t8VEHhn3NufnGjQ7KOfkA0R+g5HFl4awduYen4103ZyvbfT21a22u1h25
	 Qsk91Cp7xbexljBnzFdwXdtMDZXEskw567jHbT4f4sC1hKnjV0Z8ehPKkTdPi62mqr
	 CU18Rh9h+AUdRq8sfyA6c/oyU8++9jTMTibx7OJ9cz2sUI/J08IwQQG7LyxeHeGPEm
	 qm/O4761b7qaTRgd/jGUCcpg7d4PZOkKG0plU9tY94tENGkauKV8wqfr5vMaG4Roly
	 tR1XesySusK9A==
Date: Wed, 17 Sep 2025 16:59:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v2 2/5] dt-bindings: Add Andes QiLai PCIe support
Message-ID: <20250917215942.GA1877367@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916100417.3036847-3-randolph@andestech.com>

Suggest following convention for subject lines (run "git log --oneline
Documentation/devicetree/bindings/pci/"), e.g.,

  dt-bindings: PCI: andes: Add Andes QiLai PCIe controller

