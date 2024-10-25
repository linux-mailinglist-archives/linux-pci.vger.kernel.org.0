Return-Path: <linux-pci+bounces-15313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA869B0520
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EE51C21537
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A81B394C;
	Fri, 25 Oct 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKqFICCZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE270815;
	Fri, 25 Oct 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865323; cv=none; b=Qf+B5saP1dmcLCq4U0CxoxXAPGvUwGhm2HiLNY4xfME+isl/X5kPE3J/Y+a/i8/WeGhDWw7i338V4NoBl5QjAmYCUZmnLbw6HlHAB1wybII9x5mrPKClqDymza8sBC6+Lb6hsRZczM8PuRIxZll8surw0BgPprL1MMDxBUmSEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865323; c=relaxed/simple;
	bh=UAhvGKQMZlcxZYweANcgZFVrALev3+1WlKHnBYS7k3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKK9Ot8shgA7qQIwnBQj8VAGW81kCREOGT/HwjFbdBW80Cuhy6VD7nSfjwh51TLFBPYCLUVLWq4VPIelAQ+uIzKxwUJcw8NHhBuV32k0engfiCXGg5LHw29xTTO3eFqrBynqX8IwG7+kXE6/oj8M8yN62pmQkJ6mJZbkTHLi3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKqFICCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7019C4CEC3;
	Fri, 25 Oct 2024 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729865323;
	bh=UAhvGKQMZlcxZYweANcgZFVrALev3+1WlKHnBYS7k3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKqFICCZWx0mw2CpNzBm/oM2WUJc8PCl2UjDMwHyPEqMpWTZUJ2Z00LirgG8CG+FI
	 cPI11i31kiYQDevCurmv7OZNVbbl+dg+PJoGBUpGYpKR3bQRcCXrcKYUpZgbb+RrJt
	 9EzI3vZkNgT2MtcvdDAaG9+uInxui892/SgYoWjyYyWFKvHevuv3CLdpkvzchrIN0L
	 hpH+l6zP+i06phfviIXiCp2RS4hoxFzmZ95oxFZXLMWoob3rSvQkdivXR6gLCuwcmS
	 QN6JPVYSDrIy5leqdIN4KZMVojLOfYKw5ClTCC3lZrNeitoAuRrvG+zr2EElhMq6gf
	 XARMdTJLZ4W0A==
Date: Fri, 25 Oct 2024 09:08:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux-kernel@vger.kernel.org, edumazet@google.com,
	xiaoning.wang@nxp.com, imx@lists.linux.dev,
	christophe.leroy@csgroup.eu, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alexander.stein@ew.tq-group.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, davem@davemloft.net,
	vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk, Frank.Li@nxp.com, claudiu.manoil@nxp.com,
	conor+dt@kernel.org
Subject: Re: [PATCH v5 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <172986532146.2064042.10356681291273456543.robh@kernel.org>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-4-wei.fang@nxp.com>


On Thu, 24 Oct 2024 14:53:18 +0800, Wei Fang wrote:
> Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
> 64KB registers, integrated endpoint register block (IERB) and privileged
> register block (PRB). IERB is used for pre-boot initialization for all
> NETC devices, such as ENETC, Timer, EMDIO and so on. And PRB controls
> global reset and global error handling for NETC. Moreover, for the i.MX
> platform, there is also a NETCMIX block for link configuration, such as
> MII protocol, PCS protocol, etc.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Rephrase the commit message.
> 2. Change unevaluatedProperties to additionalProperties.
> 3. Remove the useless lables from examples.
> v3 changes:
> 1. Remove the items from clocks and clock-names, add maxItems to clocks
> and rename the clock.
> v4 changes:
> 1. Reorder the required properties.
> 2. Add assigned-clocks, assigned-clock-parents and assigned-clock-rates.
> v5 changes:
> 1. Remove assigned-clocks, assigned-clock-parents and assigned-clock-rates
> 2. Remove minItems from reg and reg-names
> 3. Rename the node in the examples to be more general
> ---
>  .../bindings/net/nxp,netc-blk-ctrl.yaml       | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


