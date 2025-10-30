Return-Path: <linux-pci+bounces-39867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C674FC228F9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3CB3BCF54
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C033B6CC;
	Thu, 30 Oct 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puFDfHU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA831328D;
	Thu, 30 Oct 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863376; cv=none; b=uSO4zcLVg3NlAph1j+Qfl4U3FYyMEmt7g5zFjwRQUCMy7a6wfjFhZ0QwOzZlzCs54f/keSIUUwSAMR4CAX9lT6IKwtIu4MU0/WpHzh7WlCpAExsv2nUULMcDdMDBbIMOhZprF0zqVrh3o1TkP3gHfuTRukVnunZWMNQ9nmziwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863376; c=relaxed/simple;
	bh=5D1w4rpaGuPyDNqzaNg7EhSyG/ffYAOwPGF+OR1j3J0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gVzzUMKMU+O2V76Ve7aE5J/TAl3fR4uxiXh5mH8SaGqX/2XsVmelkqkA/YZE5a2dj1kj8bS96L9Avjl51R6MZSw7JKa9OUJStNMt+tq4SikZhf9D/c6i4YHO948aaSlzxU+Y7AK8c3O/xdAEJwDNC/riBrz3seFUGESrOCHtJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puFDfHU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFA4C4CEF8;
	Thu, 30 Oct 2025 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863375;
	bh=5D1w4rpaGuPyDNqzaNg7EhSyG/ffYAOwPGF+OR1j3J0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=puFDfHU0kX/VhAi3px4Kj/EQnkuo/ZqfTl2/Vwejw3rmHVHeSnPM8ALb1lbTV750/
	 RDYu2FPrZcI+DjxzPtI8ejzJ4/E/0Sa4JbNSDfG7rsumDFBAjjir34sh5VrrEIWI8A
	 JLngk2mnlPnO/7zkv0IalHysMEgTK6jPPRGySCAjPTHDk7frVzbxtriOxQRlDk1yNO
	 VYgO3QZvk/mmKHxdTZtGaleulXgeLc7L8bInw2zdhzbZPXZracaRVcqXGqd0CPKAbh
	 hVgDlyIK0VP2Gj8H4lBn7mLCtGJXOnhyw9zUG27zneIhE6nJT+hIXbsEU8BOxKAa6V
	 vA/CxnK+Zk3iw==
Date: Thu, 30 Oct 2025 17:29:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: PCI/MSI: Boot issue on X86 Laptop 6.18-rc1
Message-ID: <20251030222934.GA1657337@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net>

On Wed, Oct 15, 2025 at 09:05:11PM +0200, Oliver Hartkopp wrote:
> my Lenovo V17 Gen 2 (i7-1165G7) does not boot since commit
> 
> 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> ...

#regzbot report: https://lore.kernel.org/r/8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net
#regzbot introduced: 54f45a30c0d0
#regzbot fix: e433110eb5bf

54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()") (appeared in v6.18-rc2)

