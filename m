Return-Path: <linux-pci+bounces-27516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38800AB19EE
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1BB1C61595
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFF23185D;
	Fri,  9 May 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuLO9BN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BE225405;
	Fri,  9 May 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806721; cv=none; b=jhrRqgJAg3IdNts2uy21m7F0n9TE3QlBGjWhPKUCIAyCjEdX2TUb8cCZHsDT4cxrPoKsBVUQ95O6HCCcQRAneHs+nD6Sc70OLRAqQnILQm+f2ExXxNwzflxiddknFd+7DyX55d6hL05iEZkglz1K/8Y2A15Wgnyx9F7o5INxwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806721; c=relaxed/simple;
	bh=fgmE2lSWRp3xQK4nXVrNGoXNlko1o4t2k3KcTl0PTSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZhjOCMLkhK4WiLTDgGIWbD/x3uJaAazGv3rQQ7/2P2ZnpFC9QWZid/RNHjkCh0fFzkdfm6f5ELBS6a6MgijJrdfq/kroFIZw9lcGoB8ZF3u1codfxZxMn5xF0lRS79O6TALomVgTPjfu+3nzIt0/viSPJl8xeUgf7EyYXFi+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuLO9BN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB8C4CEE4;
	Fri,  9 May 2025 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806721;
	bh=fgmE2lSWRp3xQK4nXVrNGoXNlko1o4t2k3KcTl0PTSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AuLO9BN6v0QDMYHcRmiy0ShqCljLVgb2wqvW55mW22Vowt5wqZxtDKgZ0V20Wbz4T
	 vyzTZ3w1MfjUlbtPRBiMllNuJA3tlonZibaj9/HrPC3N3XqQPKwskdBh6YFXin/GCh
	 JDuAClam/ZXCBZu11yjeP5Bsv3fS8yNO7LaQO6SXsZTPgbSclAWUVLjhlEQ5CxVxDO
	 aMDlpP5/QINjlkCQ8wXWzuSuSsIc8RQsD7N8Bh81Kj69AcMQzQwlHvWPhPD7oPWIyo
	 6DaxaqnvNfWoTB7T5p3jxEn+4FrnsRBqszq20YQo2be831GM8Tsq04+f65m8QI2XTx
	 qkMpjT0bY09qQ==
Date: Fri, 9 May 2025 11:05:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	devicetree@vger.kernel.org, Joyce Ooi <joyce.ooi@intel.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: Move altr,msi-controller to
 interrupt-controller directory
Message-ID: <174680671826.3585128.11425667470369770991.robh@kernel.org>
References: <20250507154253.1593870-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507154253.1593870-1-robh@kernel.org>


On Wed, 07 May 2025 10:42:53 -0500, Rob Herring (Arm) wrote:
> While altr,msi-controller is used with PCI, it is not a PCI host bridge
> and is just an MSI provider. Move it with other MSI providers in the
> 'interrupt-controller' directory.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../{pci => interrupt-controller}/altr,msi-controller.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{pci => interrupt-controller}/altr,msi-controller.yaml (94%)
> 

Applied, thanks!


