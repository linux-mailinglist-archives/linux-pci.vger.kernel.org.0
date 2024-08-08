Return-Path: <linux-pci+bounces-11506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36594C3AB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2EB22795
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A9A190692;
	Thu,  8 Aug 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw2zoPCC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AB1F19A;
	Thu,  8 Aug 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138007; cv=none; b=TqqXHtvzyNl/DJqSYIRx1RCxU3p9LF2/bD1zxT/ytiQ3LpNaTu6uh0ivTPF87p4VMZAhvuxNKIRfeDhRLAW0ZE7YMeRVqNRknPq91lphyNvgEhzswOY3qcZ/P4vxyic5sRmbH98z7QS3Y0NOhg/OtQDl7Gbn6fhzkUk8qL6bn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138007; c=relaxed/simple;
	bh=68Q7kplWWYQOen2jvz5hogPlfWfd7eX8Oo5qpVowOW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gSuqKugUI3FUqXwO177GcIJuA8DOhMIzZKH9mEpai5P93cVlLMVTU6UyX0+6IsDsEBTPO13cqnpo7kZEWdut9RvU3UKs8fEZIQFXYyiN5gOoZvHa7rSNNPTG+miq7RO6tLaN0q5LGqu/PlmqkOwYUhR7aqtqERpTu2GoOv3rBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw2zoPCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7CAC32782;
	Thu,  8 Aug 2024 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723138006;
	bh=68Q7kplWWYQOen2jvz5hogPlfWfd7eX8Oo5qpVowOW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rw2zoPCC7cnSA1H387TJT3sUQMrxJ2X7mcS+AvL9xze3RMFcU8YIEAmG+Y7Nlcg7K
	 RqMyaCcd2TUT3vBEIGqaJkwKnrKoyXhJWt+Nyf0+4NpJsi/qnx9Ly6IR1qjbJZVWBd
	 LQKUCu3G+Os3EZ8YbrYXyy8OsAq7SXq8JOwj4YCVudWs+Qs7vn+/1nFNRObtZTzdwi
	 6jwmTn3Niw6mJMEzFGAA37hWU15C5I9J6Oqv6dxIFsFjM8W6lpOYDj0I8JiF6nfMG9
	 3EroRjByUxyMKtPv+ya6TfvRvHuEGUHC2z5HQ3aYwGTNT1Y6RP1rf+WGmKuKmh9Jk5
	 xvb+HFv3TnI8A==
Date: Thu, 8 Aug 2024 12:26:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/4] PCI: mobiveil: Drop layerscape-gen4 support
Message-ID: <20240808172644.GA151261@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-mobivel_cleanup-v1-3-f4f6ea5b16de@nxp.com>

On Thu, Aug 08, 2024 at 12:02:16PM -0400, Frank Li wrote:
> Only lx2160 rev1 use mobiveil PCIe controller. Rev2 switch to designware
> PCIe controller. Rev2 is mass production chip and Rev1 will be not
> supported. So drop related code.

I'd love to drop this, but only if you're confident that no Rev 1
controllers are in the field with people using them.  The explanation
above doesn't go quite that far.  It's not enough that Mobiveil
doesn't want to support Rev 1.  If we know that all Rev 1 controllers
have been destroyed, that would be perfect and useful to include here.

Bjorn

