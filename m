Return-Path: <linux-pci+bounces-36980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E0B9FD55
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6762E188820B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2A29D279;
	Thu, 25 Sep 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er++w98i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE328641E;
	Thu, 25 Sep 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808714; cv=none; b=QDjZqPTvqjN2b8FtfK9oAqqN2zq46nS98+V5DIVOvudUHgJDbDLHQgXATkOQh1OpqekTGejcFwsKNf2gu1uIiSEjtG37Hvw1t0OaocAcwEnjyeuYFOOgMZOkpECwNjJrFbgF66C5cwRO9U/Gw63gjJHpXukrrF4w4djnmoQLLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808714; c=relaxed/simple;
	bh=xnoV6wlPNkvlSxbWnXdWvM4zVH7V3UY93H+fTN/zUnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DFRfLGvsWfJ9VUqJwOdF6NqID1ISD8ISN5bC9Ue02Dj9wijudS+pX0MHV+H7x0n5dsLSU+40tpgvayxG4nCQzcG8a3l5gbWUSRWJxkENtprCt8ZzbNG2o4I9FzI+OLrDqjt+TIwiW3IhpQya8zS+//gQ1qcNT0MPpzMkXJFypXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er++w98i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52038C2BCB6;
	Thu, 25 Sep 2025 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758808713;
	bh=xnoV6wlPNkvlSxbWnXdWvM4zVH7V3UY93H+fTN/zUnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Er++w98iIL0/aiXKl0iTmpJ8CHU1c/0rnH7l0yUMJq0zp2YTiHJkVu3pIG46NRM2/
	 VYOb8P+60CSllsIM/MlgTDxGYdwIQymgZqfIOeT44I9lSQPrMNVC76KfHm07eD5dVK
	 CQUB5knmE9z7MnC+NGQ4prq3hbdUv1ewKnbXIbzhBANRlCdyzcyyNFDtiyfwShDhdO
	 EBphcp1sH0qNAOKuWBV+y/ZzZI3nc+E26LjMcvaql6cZoCwRXszsK12qDXEN4X/380
	 1PoLvWV5h+WwsqM4R42NA9Si0kRizlHd/GqtY08t1wj7SjMYKeNbV3QwibDxNrGh9R
	 j/9/p+OLCOjtQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>, 
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Marc Zyngier <maz@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
Message-Id: <175880870894.21505.16125464866256198408.b4-ty@kernel.org>
Date: Thu, 25 Sep 2025 19:28:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 09 Sep 2025 18:26:24 +0200, Marek Vasut wrote:
> The pmsr_lock spinlock used to be necessary to synchronize access to the
> PMSR register, because that access could have been triggered from either
> config space access in rcar_pcie_config_access() or an exception handler
> rcar_pcie_aarch32_abort_handler().
> 
> The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
> commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
> which triggered an exception"), which performs more accurate, controlled
> invocation of the exception, and a fixup.
> 
> [...]

Applied, thanks!

[1/2] PCI: rcar-host: Drop PMSR spinlock
      commit: 0a8f173d9dad13930d5888505dc4c4fd6a1d4262
[2/2] PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock
      commit: 945878aa8b574f66ead4ab1844185376c0d0add4

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


