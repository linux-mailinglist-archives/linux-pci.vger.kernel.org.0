Return-Path: <linux-pci+bounces-29774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338E2AD9612
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978BD3A711A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEABD243379;
	Fri, 13 Jun 2025 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+jzNVqz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6238230BD2;
	Fri, 13 Jun 2025 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845745; cv=none; b=nPY+575Y9FwN6aXF2cN/Oz7xjS9xhORegWkL+x5GVN0cmayGXhfREYurcyQHuH56R9rUsvfmzZ/8iSg6xpu7CYvgsHQB1HJGRAzlK0oLFt6nZDXmYoh58xg+hS4S61Zr4GoXPYC7hI1Iyc5kkOGpVn2RqhyF8SZyxyIU15k/j2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845745; c=relaxed/simple;
	bh=BxIOv+q5sxxjZyf80LYLCzxauGtrUO/Zi6PqDpr67h0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MowJAtYaM8yky27mMpEn0jaj3ltkjjdZwAS6ruAh6ZXHipPfurkU7F8Kqh89emvLnpps9gut8SJ+uFEgz1QzY4rzQ8Lb314sCtPJX6hOnVHtMBjDjpqpcXWVvOKqFCO0MKbalOiDS9eQVWvzsL/uu9st1002xFQ4/RLajPgiY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+jzNVqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA52C4CEE3;
	Fri, 13 Jun 2025 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845745;
	bh=BxIOv+q5sxxjZyf80LYLCzxauGtrUO/Zi6PqDpr67h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o+jzNVqz6u6TfgD6nrqxLsvy4t8NSCF4OBdOTo+K7x7eSUAyfsEE4xcA54VHFfJW3
	 Z9okaMokUjeXkcLo6mXFci1sMNLH7sG+KM/ismwkQcTS44Kd4uciEuUXqE6jZYq9sP
	 jz5RH3kv1nNAxajxABKGdcmMzpV151s9KfyHQGvEVqw6BwQNWZDkgjOyAASOMGUspY
	 fH4eSKB7Ik0qxhkXZj+7ck3Z6LYx8auCe+jE6MRhfqAIe4Eub1izXKxFd1tgrUXZks
	 Jz6iAAS67THUxGLfGZk4qBvisehhM+bd8o4kTQFRqJlJwtCX5dUrvO8bFSNern5DcN
	 JqKbwp65lN7xw==
Date: Fri, 13 Jun 2025 15:15:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 3/5] PCI: rockchip: Set Target Link Speed
 before retraining
Message-ID: <20250613201543.GA974034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <affaa12fedbb6e34696242d1f2f2dc5634b72005.1749827015.git.geraldogabriel@gmail.com>

On Fri, Jun 13, 2025 at 12:06:00PM -0300, Geraldo Nascimento wrote:
> Current code may fail Gen2 retraining if Target Link Speed
> is set to 2.5 GT/s in Link Control and Status Register 2.
> Set it to 5.0 GT/s accordingly.

Nit: I don't know what "Gen2" means (and the spec warns against
assuming spec rev maps one-to-one to a speed), so try to use the
actual speed instead of "GenX".

Bjorn

