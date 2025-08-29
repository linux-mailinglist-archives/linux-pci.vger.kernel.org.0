Return-Path: <linux-pci+bounces-35137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F1AB3C190
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 19:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C811465CC2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD73375B1;
	Fri, 29 Aug 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQwBaTjC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C02222C4;
	Fri, 29 Aug 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487614; cv=none; b=WIM28u4cYvdzeLZFfNXwwq0Xez6bZTJRSllAvuxRcQ9N6YHJSutfLHoGU5qkSqQwNd1M/mZD4hGGjsGh2amH7YAGMio+WsjeO6hhzJC+O2/TkczpvIEBghKFOsGufey6qS/ZSruHRoctGFiQD46EMFwMH2LeoWIg6N6/Klxnaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487614; c=relaxed/simple;
	bh=TDpt43ch3xVFskhEnjng4dGYL5sbO9BabNljtnfMN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlT0xgeRMtRdwdZ/2uEPa4G9ckfaa21wW2K9pYPe4KAm8AEu0vJUtKVgEUYupJk6MkEAoNZeWc0bC7Qjav3GlJ3xz/jarDvlBp4uCLg1hPy+DXrQxhZhHlXJwgjsi4IfM9OTDjheTMCwjFoLI7F55VgnDNkB5Y28K8PDRcI//HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQwBaTjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5A8C4CEF0;
	Fri, 29 Aug 2025 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756487612;
	bh=TDpt43ch3xVFskhEnjng4dGYL5sbO9BabNljtnfMN/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQwBaTjCL6KvIS8b+9WD6cJfEZVYh0GnSyDb+kxAYAu9n3ltNjoi7P+fq0HMWxwbi
	 v87zT06R8+j4T/eRdvDOY7VhricaDjCyvgncYqxAd1nuLhoeCIDbcwz7iVsO9UeEH6
	 1j3BIX3mdIUZxfQ655xmxjMjb9PZbpg62cTvL6eFzuRpgCbA/bi5S75EWU4cg6OqAN
	 J/nbr8nICiMg0YmtI6CsTnQwbpSArhuIY7Im/XW5R31P6MqjBqbrgPtv+1l9LDdEdY
	 AWp9ulPoRQO7nousGvMgM5z/jegWgDQ3YWfRn3GPGHPS3DQvbXVaIGV+NsOS8hfR1H
	 7Nl0NwY+D0ROg==
Date: Fri, 29 Aug 2025 12:13:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: unicorn_wang@outlook.com, tglx@linutronix.de, sophgo@lists.linux.dev,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	bhelgaas@google.com, lpieralisi@kernel.org, alex@ghiti.fr,
	paul.walmsley@sifive.com, kwilczynski@kernel.org,
	xiaoguang.xing@sophgo.com, conor+dt@kernel.org, kishon@kernel.org,
	devicetree@vger.kernel.org, s-vadapalli@ti.com,
	thomas.richard@bootlin.com, linux-kernel@vger.kernel.org,
	sycamoremoon376@gmail.com, palmer@dabbelt.com, bwawrzyn@cisco.com,
	chao.wei@sophgo.com, arnd@arndb.de, 18255117159@163.com,
	fengchun.li@sophgo.com, u.kleine-koenig@baylibre.com,
	krzk+dt@kernel.org, mani@kernel.org, linux-pci@vger.kernel.org,
	rabenda.cn@gmail.com, inochiama@gmail.com
Subject: Re: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <175648760972.1027309.4591259567798589217.robh@kernel.org>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <c9362bb49e4d48647db85d85c06040de8f38cb83.1756344464.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9362bb49e4d48647db85d85c06040de8f38cb83.1756344464.git.unicorn_wang@outlook.com>


On Thu, 28 Aug 2025 10:16:54 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 PCIe host controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


