Return-Path: <linux-pci+bounces-35925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E4B53A62
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7725A4543
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE34340D8C;
	Thu, 11 Sep 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEubeFRD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5533EAFD
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611729; cv=none; b=chqJuZA0eRIcfFDbCAFZtljqJtc+/C6lBtHYJo1vXxLvIxVjEGvm6UzbOhaCrWAfFYK0gozFRJ6AnIC5uKTNjaK+YzD7VEwD4PH+pwzBGnmlOGPbUfTTYfy5sJaJOrXsvvOLBc4ikmF/8X/L8XI5cXSskXru1TRIL4/a2L8SKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611729; c=relaxed/simple;
	bh=rIk3j0KCgwjj2LQIqDprxIITG998h+ByGcOPWCY9YrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lI/JiZZAhxk+mKvZAAw6+Z4Ae5o1WAsHzct881b5H7aJa871xqgBsdFEe9ZwjpeVs/IDyH0UaBDKhjNkVEigJX726HftTb1CM+mNGjQsgWO7UfenjdMsseI2dRXHIDoS9dZYEEvVQqbEeR4XRfkdr8wauIADsplUmKABKxvAAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEubeFRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5693FC4CEF0;
	Thu, 11 Sep 2025 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757611728;
	bh=rIk3j0KCgwjj2LQIqDprxIITG998h+ByGcOPWCY9YrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oEubeFRDaSa1cGJcXSP09yW7uaD2Ht0bJ1c9/fQfAGkqvvq2pLAqmM9h9A4roz5iI
	 0YGxxfIjB0uf7QjWrQnfEnmTOq073YpXqjP3AGEr9y2EHaGqJ/MrS1wPrwv1TvQh+K
	 3Dbqgf7of03IyEG0TnjwF32hNMk8cz9ZrHEZS+POCH66nnrSJXpOX8ocd3FBvh8V35
	 ZA91lW5NO0wBbuD9eM4vitABAqGH939hlNGLmkr+I2b//8eSOdCjksJ1Ff7MVt60up
	 q1yd9uh5K7glYHOPkdg6+LpUrvmE3RkI8R2+MQf/1j06canTcOgLKjZ9v6ZCh19CbB
	 +YvQxgfylmB0g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20250908161942.534799-2-cassel@kernel.org>
References: <20250908161942.534799-2-cassel@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix doorbell test support
Message-Id: <175761172599.2539381.4149547568845053745.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 22:58:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 18:19:42 +0200, Niklas Cassel wrote:
> The doorbell feature temporarily overrides the inbound translation to
> point to the address stored in epf_test->db_bar.phys_addr.
> (I.e. it calls set_bar() twice, without ever calling clear_bar(), as
> calling clear_bar() would clear the BAR's PCI address assigned by the
> host).
> 
> Thus, when disabling the doorbell, restore the inbound translation to
> point to the memory allocated for the BAR.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: Fix doorbell test support
      commit: 54a8c34df746c979037c907ad7fe42c52a58b532

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


