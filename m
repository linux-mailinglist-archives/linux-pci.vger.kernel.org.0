Return-Path: <linux-pci+bounces-41796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF1C75084
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2B364BC6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894035FF71;
	Thu, 20 Nov 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biRg2Kjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D335CB81;
	Thu, 20 Nov 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652222; cv=none; b=GR2zh39M0IqHyqnhGVTeUwd523Il+RRcqw63ceyjKFtWlo31ZIfX8zr9FnNvfhCPa2KSqwMRUzHkkc9UYkA60qUKjCX/DqYcwZBun8rCxyPbmTMtm7LtzLK32gWhTB4mhXXynEcbti1yq9f4JoX1JZjdn2o3sbtQw71Q+oyiW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652222; c=relaxed/simple;
	bh=0MNEyCDiMjE2vsbrKi6Sd2Jmx0BtFcSOJN/HQidrjv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ03PDQWQJS6PQFkJgNrrzo+f6fx1jSOa/Q583eq3PpNSt4Cnn53v8MlA+jGMQQpLEtDrcfUfo3g2tcDXePE0ijO8r5F3lMljL8djIntOKMMb7oej/L4HBUTwhgtai8uyJDdlzMlOf5ODQ1Y+5ob5zTMN0yfx9LBs/o8FU+pY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biRg2Kjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338A2C116D0;
	Thu, 20 Nov 2025 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652221;
	bh=0MNEyCDiMjE2vsbrKi6Sd2Jmx0BtFcSOJN/HQidrjv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biRg2KjbGYCiUsqPAXuvHTgF4YX5ZoSPv9h1d4D0oeMQj7/06VDWNGkAEoNo2LBTH
	 qw2JrtQykNbJWU0AkAGZmlr5WbQQIBcQ+bVFLcklUy0cF6sG221e28gQVlS2eOaurB
	 hLTZeFCg6dGqnX4yFnlW6J9+BSmRf9FwTHxEsyMHWmftTO9Po1a6Rpj+siiVbIqL+r
	 gLFjlGph03p2zYFEbg1ICzd4zMCHgJ+7ebnfDqiFJjslw+Bi1KoLKM+GcqQYxUlLsT
	 D8h4AzcgzLloBdvZRSSy7u0ViK/XOT8Id3A96dRgin2lc+WR0e/6zWcWP24/yrU298
	 O/H/iK+Fyo99g==
Date: Thu, 20 Nov 2025 09:23:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ionut.Vicovan@nxp.com, linux-arm-kernel@lists.infradead.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	ciprianmarian.costea@nxp.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, s32@nxp.com,
	ghennadi.procopciuc@oss.nxp.com, imx@lists.linux.dev,
	kwilczynski@kernel.org, jingoohan1@gmail.com, Frank.li@nxp.com,
	larisa.grigore@nxp.com, chester62515@gmail.com, cassel@kernel.org,
	bogdan.hamciuc@nxp.com, devicetree@vger.kernel.org, mani@kernel.org,
	lpieralisi@kernel.org, mbrugger@suse.com, krzk+dt@kernel.org,
	Ghennadi.Procopciuc@nxp.com
Subject: Re: [PATCH 1/4 v5] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <176365221942.1402463.4737452946243069736.robh@kernel.org>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118160238.26265-2-vincent.guittot@linaro.org>


On Tue, 18 Nov 2025 17:02:35 +0100, Vincent Guittot wrote:
> Describe the PCIe host controller available on the S32G platforms.
> 
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


