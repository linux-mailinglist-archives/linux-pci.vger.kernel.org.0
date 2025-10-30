Return-Path: <linux-pci+bounces-39844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C699BC21B03
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA66E463A42
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5EF2F3C20;
	Thu, 30 Oct 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOBfqnku"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE022868B0;
	Thu, 30 Oct 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847710; cv=none; b=QyH9sQMa19d76qYOqsZ08+/5cilYRkGfhK4ylsQu2J4EOnF4nk3ymcU2fNG+n4pQt12NjTbAy8p2W5RzTOR74BzcLnNS3r4F7dGLaxnAGTBd7xxW6Hnqu5UPq6jGa8ul6uAltq9h1Ls3c+UIAt2cNn95HqHjrjzuM0+X+CBKk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847710; c=relaxed/simple;
	bh=6NBqGEyIKXsDEC70trCS2FNCzv3oKxwoniTgmbfYXQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUinZLd/6szoO0ZQdIjUIc7XXjV29ji+eTW99o/pV3IqY7srtbQSorUskRt8ZsVjk6iTJj2+lW0C1YW45jeBlDwZ/u9XpWjEJhm/4PZRgi26i0nDwQ08wgBR0Xja5TGBljzsa75vJfcrH/2uRcegVwSJFjvsGuZFtBw402X6wFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOBfqnku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77563C19421;
	Thu, 30 Oct 2025 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847710;
	bh=6NBqGEyIKXsDEC70trCS2FNCzv3oKxwoniTgmbfYXQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOBfqnku1sZvD5ZsXyFGso2P0DTH9hWTtw7jGdwJPOLRpC7xppWpu54ekM16qI9jU
	 bhyQAjP2ASJAcGboFHlXNe7e9LDrQ8u78VTsMOS6oDDMDo1S2zIZHa086gmZR+9MsP
	 er8W4m1bwJQ0UEHQX92Kot1F/G9OOyBAf9G/fqipjUUyQOTUEM3BxeWx4NkqL62uw+
	 03efc511z5uV7ykmAFuuO5ssR/RqKEEo734rzYgo+bLjoILDa0MePKGXMvit8OiXaG
	 OM9ixcwJisiSt4UhRc8zr6T34y4wqBirNtrLFGnYPrdUlXL0ZmaJJijcoPw2pZpzr4
	 he8qZcDibL/gw==
Date: Thu, 30 Oct 2025 13:08:27 -0500
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Message-ID: <20251030180827.GA110725-robh@kernel.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
 <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
 <aQJE5kkOGh76dLvf@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJE5kkOGh76dLvf@hovoldconsulting.com>

On Wed, Oct 29, 2025 at 05:46:30PM +0100, Johan Hovold wrote:
> On Wed, Oct 29, 2025 at 04:40:46PM +0100, Krzysztof Kozlowski wrote:
> > Power domains should be required for PCI, so the proper SoC supplies are
> > turned on.
> > 
> > Cc: <stable@vger.kernel.org>
> 
> I have a feeling I've pointed this out before, but these kind of binding
> patches really does not seem to qualify for stable backporting (e.g.
> does not "fix a real bug that bothers people").

Presumably if someone omits power-domain and the driver doesn't work, 
then it's a bug affecting them.

I'm fine with dropping the stable tag because it will still most likely 
get picked up with the Fixes tag. :)

Rob
 

