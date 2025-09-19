Return-Path: <linux-pci+bounces-36472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34323B88BD9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6153162611E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FE423E32B;
	Fri, 19 Sep 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX1F89su"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB32264C0;
	Fri, 19 Sep 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276040; cv=none; b=MIABZzanZBJgQKHy1aPq/B7x97oYz1utjd3+1kSASLEjIUOZvEbFzebDhs10UAbTOyfflcP+B1HOTE1rydjxbYnj6zVG0ne9By7mbZI8c3+0Jw4+GVU77e97IWnWOrMadI//GHGLHR4XKi4GqxiIPVThSDK6CoDQumHJEutrWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276040; c=relaxed/simple;
	bh=YTJgexDyUPZARcdNN5n1Rh3wR2Moa3LhQxpJ9ovNIgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC8r/JLMPtOqS5+suGU5N3JptvmFrzVaxK3PlKCsg/7tIxpcOAWcN1J9ou9xkeXCSG1tzDVmwE8DxpVNNufXDpoBkcEuq+KIrP83l8B5INUhen+ggfBZ4p84celdzXshuEepH3Voj922CEszXjpgClhqtqBbY6f85bPxjtCizy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX1F89su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8987AC4CEF0;
	Fri, 19 Sep 2025 10:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276039;
	bh=YTJgexDyUPZARcdNN5n1Rh3wR2Moa3LhQxpJ9ovNIgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KX1F89su1/o7ycWJJR3Nrbd6g+ZLwbUMFxZMxSllf4zAuA8D4gm6pSmlL4QfjnorA
	 VM1LwSqERlXXAweGYgR+IAOzgCbdyKlLEMZ9tvMIYR9akYFYjag0UNLraexDdfAOC+
	 m4KPFqok9veAyzYRRWMVjtx8PJOZGmypMvlaQgXBIc5r3inc3fovImTexLFi+zIOUq
	 udtC2hAbWt+BX5mr0hb2OsbezM7NtthMsxkscQw4+8w+xB8N4mZslvFya1Nv5fNjhQ
	 4Pcn5TMUfkvO8by2hhN3KrXHfmS9oJJAN8CIC90d9FmcBsDQMLIZ0hjutqHadDNicE
	 qXbzCunkIzpcQ==
Date: Fri, 19 Sep 2025 19:00:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
Message-ID: <20250919100038.GA3918632@rocinante>
References: <20250918231253.189906-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918231253.189906-1-marek.vasut+renesas@mailbox.org>

Hello,

[...]
> Because it is the controller driver which can determine whether or not the
> controller is in HSC domain based on its compatible string, add the missing
> delay into the controller driver.
> 
> This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
> whether S4 is affected as well. This patch does apply the extra delay on
> R-Car S4 as well.

[...]
> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> +		fsleep(1000);
> +	}

Would it be a prudent thing to do here to add a comment over the fsleep()
or over the if-statement to document briefly (and for posterity) why we
sleep here?

Otherwise, looks good! Thank you for fixing this potential issue.

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you,

	Krzysztof

