Return-Path: <linux-pci+bounces-14336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57599A767
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64661F23F3C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8491946CC;
	Fri, 11 Oct 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9DDIl1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1B194137;
	Fri, 11 Oct 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660017; cv=none; b=pgXTRoqRqQ9vfqkt51lLdrFcN7rS6L0g6+Lbwj4Ii07PcnM3r0gnmDXvAygU7scRtyMKIR+tpmBdXWq/pI3pm2X0Ng/ZnV7l1ZqY/G6DT4F0nRZkmb+e0GnzmjftrabR3kFz44Gba5Tmnp1GyMoO7AV/m6HJ0eM3yxhk8eTyrH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660017; c=relaxed/simple;
	bh=xHdEyOpcI4MHByhmlYQj8lvNZvgUqvMMl5Na9LiJ+Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkVzZR4VdD9VNCGc31/yCxIfh+5C84UMZCQrd9Ths6Xef06BMzY79d4hVmGfxi1yddQJI93PAD3oMyOW3Nq2tb4pVEXWvgQ7Tl2FDdLpescTr3A5HPTq2cylXwiuQKfuJWQ2lOsyWIk2cf6JAHAQX4TbGcgW2KeHQQpEuH0V2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9DDIl1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C11FC4CEC7;
	Fri, 11 Oct 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728660017;
	bh=xHdEyOpcI4MHByhmlYQj8lvNZvgUqvMMl5Na9LiJ+Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9DDIl1MDOrEIeJ22FJw1cwSJLYuYgYDh9j+FTqgF92DxoqVDovjM0qTujfs6ibIV
	 50eYXoxAap0Pi3XYtms0cf0iQR3XdEGEzk97HeoFZqwaU9HBSwHViPVBLOdI+93JLQ
	 PWW/tRUXiELd1yBy8ZyJMw57GxS4xajP9ApCF1kRcKk5JegV42yAt3q75isU+zjFOn
	 ql+aXP7p3SVXnCAdARL+skQtYGoUHWMhGEovxqHqrGQv8YMnO9cVyGB0inVzE9H0jW
	 uXy7tq4yUIImy01y8gokJ7eDxxkGXTZI1PJlEWmDeV/zAMSMhnSLGv1QwEGw8a+851
	 /rfD1FModSiFA==
Date: Fri, 11 Oct 2024 17:20:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] of: Constify DT structs
Message-ID: <nwnf6s6lu5ize3cpxjtl72nqiqma7mhssvnno3jp5x3thiayq7@6ewtirk3thy5>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>

On Thu, Oct 10, 2024 at 11:27:13AM -0500, Rob Herring (Arm) wrote:
> This series constifies many usages of DT structs in the DT core code. 
> Many uses of struct device_node where the node refcount is not 
> changed can be const. Most uses of struct property can also be const.
> 
> The first 2 patches are dependencies. The functions called by the 
> DT core where the fwnode_handle needs to be const to make the containing 
> device_node const.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

I gave reviewes for individual patches, but all look correct except
order between #1 and #2.

Therefore with the order fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


