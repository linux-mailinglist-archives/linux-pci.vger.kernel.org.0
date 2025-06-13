Return-Path: <linux-pci+bounces-29754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4C5AD9231
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAD7AD451
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A920E330;
	Fri, 13 Jun 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb2gSlz4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA71FFC5D;
	Fri, 13 Jun 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830335; cv=none; b=gHP9JBNtKQjsFtWowvMzQRPhp8EQSrqCPd9v8+0sMmB8YqI+008ImL3AbpM9D6ytrA/9K8A5/sXcRcWxQugMN66T9E+OrmQlIrbDVlOv5S8HRyIHXmBwDDzx4VS1HOv88Lg8Z8umh2LYzfUnf9DRDh7NCyUyhBZOnEgcHHZnr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830335; c=relaxed/simple;
	bh=ubx0aSPirWzdiPRt3UtSIssQRIZ/h985GJfW7cPAiJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=igQJIYtYuyNwntW6j2ZUM/c7WNx6AnP3SKsEHdcVLQqkCYmjq5Z7ifsVR+vJ4BuBaI2zNo44EMCLoWUil5ABIOLtiLFgdaI09ZrHGq7r3dSdXWAX50hyngqpVxkg+KxtrBt8vcqiQaLWyTPBItvC4koKeavTQ93l+GvTduJRnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb2gSlz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B51C4CEE3;
	Fri, 13 Jun 2025 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830334;
	bh=ubx0aSPirWzdiPRt3UtSIssQRIZ/h985GJfW7cPAiJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Cb2gSlz42q4+9rckZbHNm9mmnaMRvUkvnKuTABMYiq84cfWP92JqlnKt4mc/n1poM
	 T1TVcBG64hgiXnN1aHOB/gmT48zyQJZyMuDYETaY5RHNIjn6CXyB0f5jMv+qNx8OoK
	 G2wnFuAqX6HtyA5hVjSFwbyd9k58RoaA+uERxSXQFNexM+5+E+YvraktV0HOcCYw+u
	 fzC/lxxv9xfphyGnR6gtAC8Of00o1jYtLjo/lL95F/0SKU3b6ob3iwvx57JLO+hoGw
	 hdtymaQhdLgvfyR0uQzoUfJDQErdB8E/NcxpoZN50++35IjeEINdfnkpPoGoPclMxL
	 RRUepl/Ha9XoA==
Date: Fri, 13 Jun 2025 10:58:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	vkoul@kernel.org, kishon@kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, elbadrym@google.com, romlem@google.com,
	anhphan@google.com, wak@google.com, yuxiaozhang@google.com,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH 2/7] dt-bindings: pci: Add document for ASPEED PCIe Config
Message-ID: <20250613155853.GA962329@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613033001.3153637-3-jacky_chou@aspeedtech.com>

On Fri, Jun 13, 2025 at 11:29:56AM +0800, Jacky Chou wrote:
> Add device tree binding documentation for the ASPEED AST2600/AST2700 PCIe
> configuration syscon block. This shared register space is used by multiple
> PCIe-related devices to coordinate and manage common PCIe settings.
> The binding describes the required compatible strings and register space
> for the configuration node.

Make your subject match style of:

  git log --oneline Documentation/devicetree/bindings/pci/

s/Add document for/Add/

