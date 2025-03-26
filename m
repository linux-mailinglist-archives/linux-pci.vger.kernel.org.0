Return-Path: <linux-pci+bounces-24748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FCCA7128F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C60A17241C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D919DFB4;
	Wed, 26 Mar 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlEIm6Gn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D384A29;
	Wed, 26 Mar 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977358; cv=none; b=W2xdwaOexmGO641lHAFzVr5K2e4svkofGcoU1iWfxykW8dQ+bJQ+o0Zky4buD0F8jOBsZY7r/tF4mb0+IALeTvbcvG+EZRWfj+tjzvFEFe01nZLVrgrxXHZibawRWR0QcKsrSdbKwAFwuUtmjqMbTDdgfkwyLQ7BCmIu7TrC4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977358; c=relaxed/simple;
	bh=QWbLLbvcQpGd/UilCHoFcr/MmixBk1FagIujt7Jqq1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou9COXvciCa3I5HLb06G0QPA1s5eEIb3QS9CSzgiXUHUWUSPO+e9l5U1ts3iTw8I2GRynaNtrXk5zpLWB8kqv0qTfKAIQg47G3zM0kXPZbKD8Y3VL1un8IGuOlOc7vEyS+ujtpjVQjuFssXZdtYGzN3EQ4//ELgLDC22720CDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlEIm6Gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A96C4CEE2;
	Wed, 26 Mar 2025 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742977358;
	bh=QWbLLbvcQpGd/UilCHoFcr/MmixBk1FagIujt7Jqq1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlEIm6Gnl6QzzaHHrnW/3XsSy0AefbFwmjbQr4FZgv2DwCzdHIVWtONdTo10ez+Zi
	 G42Z4bAN/B8rt9VaSPoygDzXcT453pFVQdrddxM4ZBy5crh0wb1PCK8IYd/gLTzhrG
	 aWpHR1EWuoRiBqbgZQlR3BoOMiD2dm/gKWvwW8ROW8yrJdZkZN6AVewTJU+oj67SmE
	 4QjMvKLU4b1/UIzEXiGeVEZrs0dFtSZbeELwHx0wrNTK5d/KeMe+l5F6g+TlHOPOoO
	 MvwfdOuvAoP9lt+i7g/Lwkynl6ZA/pvLFfHUGw2npsKh9b76FTml9Ogcle8XmR3rh8
	 yNkAa9/jjmQNw==
Date: Wed, 26 Mar 2025 09:22:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, bharat.kumar.gogada@amd.com, 
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: amd-mdb: Add reset-gpios property
 to handle PCIe RP PERST#
Message-ID: <20250326-abstract-axiomatic-marmot-5f2f9c@krzk-bin>
References: <20250326041507.98232-1-sai.krishna.musham@amd.com>
 <20250326041507.98232-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326041507.98232-2-sai.krishna.musham@amd.com>

On Wed, Mar 26, 2025 at 09:45:06AM +0530, Sai Krishna Musham wrote:
> Add `reset-gpios` property to enable TCA6416 I2C GPIO expander based
> handling of the PCIe PERST# signal.

Hm? Where? You just updated example, did not add anything to the
binding. Assuming that is what you wanted, then fix subject and commit
msg to say that you make example complete.

Best regards,
Krzysztof


