Return-Path: <linux-pci+bounces-17794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC39E5CF9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70052815A2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F1218E9D;
	Thu,  5 Dec 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0ziBbO/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AA38C;
	Thu,  5 Dec 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419392; cv=none; b=MNET2RPOl8G23va5WJ5rQIkshwz5KLOQUWZFvv/3hT6ln/GfFiXJ9PHT3qS7Gt1rEoRBU5W7YpzQPikC6snPAIrBDo8eaTvEMjIizXrmEt3JrEjGQ8ohni3GrQ8Z6rC0828o/dwrnsis36ODdcmJBvzehhJE5EgvPQtAExlCpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419392; c=relaxed/simple;
	bh=fi2WY3gBh65WYtY2fRxW1m7CZSc00650cfNmqqUnA18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NEsxErZfJKq6LPZuHXvEchOFCU/4RLAlZw8PZRsLowZvVvruFNEzFyjA/bfiSBKZxadsnD5cenLahfDQmeqLCAjv6PM2sPS3218ynZMh/iXdK7a4FjfuXkzKJk6lYHD2LGB8XTST8P23crnHv0KwsaMymH0enXG+y/jXqvif5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0ziBbO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C484C4CED1;
	Thu,  5 Dec 2024 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733419392;
	bh=fi2WY3gBh65WYtY2fRxW1m7CZSc00650cfNmqqUnA18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N0ziBbO/Al108sgzgpgfqlBHui/9lVvto/OgeBeezQS2smZibRfyFkaN8yazfWTy/
	 cEkEQTw3Fbupk5EJG3IejmoW5HBwAJJFUSc6fW/p9AHQ53kkSDp9wTlZpmD0xdNY1p
	 3cSnOtR/P4D70ZVo9Tu+C72eD4uGGr5co+aG+GpFvXB/vKreQntGU0zE6EOKjQLiX6
	 Y1aWDK8wXTHZsrxqEqFmKZBeWgaoJov5ut0ZtF4cXXgoaCic2mgR3d6Lx6TshMec/f
	 vXNqjKMtAxBa7DyyeNupzOqD8qd8jIeQfjkDhamsBTx8eDzwcPMITuA/7pxI3RrYku
	 zHHlNpSFiy7rA==
Date: Thu, 5 Dec 2024 11:23:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241205172310.GA3055111@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-2-christian.bruel@foss.st.com>

On Tue, Nov 26, 2024 at 04:51:15PM +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode.
> ...

> +        power-domains = <&CLUSTER_PD>;
> +    };
> +

Nit:

  Applying: dt-bindings: PCI: Add STM32MP25 PCIe root complex bindings
  .git/rebase-apply/patch:163: new blank line at EOF.
  +
  warning: 1 line adds whitespace errors.


