Return-Path: <linux-pci+bounces-37015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4FBA0BE3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F9F18977D6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59530BF70;
	Thu, 25 Sep 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upWO0S7b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286B19F40B;
	Thu, 25 Sep 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820007; cv=none; b=rLNg4rogckLfVMcGkqxVtc3GyNWytWLiyMpgUBx2t2ViWsfdeGyoNLc7U0f1RdiVPzWijvCAnNy90mj1AwMOPOliRDJqfc1hYLt9ZY6DJzvjtwHmu7RNWHvUorI3KajysL0VHoP9L/s0k2/bZar24WAQUaLnKBnUVtQgn6EqYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820007; c=relaxed/simple;
	bh=0/lEVkFCh2G2v1BOOAgB1PBGgF4nPu4QaLTafq24y38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lYvjuWLzKKOP1TR24CYBMCjaPQNrTsk9r6/QRmxOm2OkyjJgAbx2inu9V3LZPuRtjpp50GOUNnKQtXo/agzBAFth1ZJRT0XBPurpt804l56Mtj2KULH1LqTPNGWjgXvDZfsctg/GbUal5hTi2cdu9uK0H9BE+6Lfg20NAWmw8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upWO0S7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DBFC4CEF0;
	Thu, 25 Sep 2025 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758820006;
	bh=0/lEVkFCh2G2v1BOOAgB1PBGgF4nPu4QaLTafq24y38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=upWO0S7bR6lOGUVbFT6fNQorUegPsIW2KzRvVSSYxrjXCDBH5BO9geR5os56F0pZb
	 JV1ojavERVX0XO4Ep8TWtr1SpRnSKTcR5XXzz4rBGuVoe5T/9WEXO74GWaF8OJFTjf
	 fKcWtQVfSh8m8CbMhExOhaRlP2XtyIXyuOj9ASXXs5vYx0xv/aEWU8oWsEz9I/vxJ6
	 f4Vu3mXdb/8lV3n509DBU4trOB7+9tuUmwNLLLZ1u6XcOEhFPzPseaLVifEy8sJ+S4
	 J4YINXX3sB5DH2eC0GW6QERlkVqy8XNMNNfykOvQAS0l+64UdbxWWyJ8mob9198qeq
	 Ubhc7j5Hlk4fA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, 
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20250922081057.15209-1-mani@kernel.org>
References: <20250922081057.15209-1-mani@kernel.org>
Subject: Re: [PATCH] PCI: tegra194: Rename variable 'root_bus' to
 'root_port_bus' in tegra_pcie_downstream_dev_to_D0()
Message-Id: <175882000155.393581.9846354008561006249.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 22:36:41 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 22 Sep 2025 13:40:57 +0530, Manivannan Sadhasivam wrote:
> In tegra_pcie_downstream_dev_to_D0(), PCI devices are transitioned to D0
> state. For iterating over the devices, first the downstream bus of the Root
> Port is searched from the Root bus. But the name of the variable that holds
> the Root Port downstream bus is named as 'root_bus', which is wrong.
> 
> So rename the variable to 'root_port_bus'. Also, move the comment on
> 'bringing the devices to D0' to where the state is set exactly.
> 
> [...]

Applied, thanks!

[1/1] PCI: tegra194: Rename variable 'root_bus' to 'root_port_bus' in tegra_pcie_downstream_dev_to_D0()
      commit: d7c0300fea06e3ad43986840ccfbb0f1c449529b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


