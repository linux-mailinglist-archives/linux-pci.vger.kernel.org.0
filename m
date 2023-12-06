Return-Path: <linux-pci+bounces-535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A6806372
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 01:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96301F2170C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 00:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF635361;
	Wed,  6 Dec 2023 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGZeVHNq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F191C38
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 00:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D7C433C7;
	Wed,  6 Dec 2023 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701822674;
	bh=tIFx2XxJ5bvW9JQGHgDBOs+eDppl3xUZugwLevpr3qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JGZeVHNquOWVPkK1aHSw/EuPSMasgAqQbNWWuuXTKejfvlT9d/LpO4dUaOKhD+vQv
	 PRgi3JxovXJWfyBJpahmLjDVZTSN9D7KniXtQwqMIgYG+jX+tLvwlLCzVZTE01UNMX
	 vU+YMWiLECw7lfLjDoec7fbinreJoOgSaNJhluBkSOayqV+Jz27mJwk94Cgc6rWEVw
	 Bk7p/3dgn0dhkXLtbSroeIuV93pYCivcXPgeyxvaV5Ex+Wp55ZKiEgtreC4HSegkBo
	 TCaLHE9iah0To6+YWxDPYLxuIABEoBv98h6kt+jIODxq7NKgYQVn49OcVGkU/47xWH
	 eFrIp1QeP2o+A==
Date: Tue, 5 Dec 2023 18:31:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/7] PCI: Log device type during enumeration
Message-ID: <20231206003112.GA696026@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205171119.680358-2-helgaas@kernel.org>

On Tue, Dec 05, 2023 at 11:11:13AM -0600, Bjorn Helgaas wrote:
> +		"PCIe Upstream Switch Port",
> +		"PCIe Downstream Switch Port",

Nit: I think I would change these to "PCIe Switch Upstream Port" and
"PCIe Switch Downstream Port" because that's the usual usage in the
spec.

