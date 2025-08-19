Return-Path: <linux-pci+bounces-34307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F285B2C74F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA90585CCE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C082765C5;
	Tue, 19 Aug 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD/2BRXZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4127602E;
	Tue, 19 Aug 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614228; cv=none; b=O7jE0Pw/kSYf91WYyv0+1zFUbVHUWtrvjWz95QmWEk9QQzTfBr/uyhQ9pMH36us/o6ymF3v0j/vnVDCRvRIKXYJdnECmjexHUAlNgKUMDhBEwc8qjS8vNep2XTNotneRrNj8eEVlumUhHn/wJy5YSC9307ZsLSZWwNfHreFmKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614228; c=relaxed/simple;
	bh=aZSj54aByG6mSlw6bfuWZN/4ePTQj9IrjVwHH3nYOsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LbBGuMXhPGRKJcMJv5zNVO6NpsNp9kIPiG8CoBfE0kh0FQI4jgS4ojSHJN4bqXn40gbKBCnTYt/lMkEvCC2YoSohjpmTIEZYEIjgHeM6mhtwEnf1s0Y0TbWrFmPfgkKyWtaqvDwdg/dHvc5ohK6IrC3lkn42rCHx9tokTIYUJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD/2BRXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B6AC4CEF1;
	Tue, 19 Aug 2025 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614228;
	bh=aZSj54aByG6mSlw6bfuWZN/4ePTQj9IrjVwHH3nYOsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iD/2BRXZ4T/jKUg7tQ997lJ7azM1VrGJNnJ+qXZyVmdUhO3RcBAUSIYat8btn9nw+
	 3jRbfFYtHrsENNrHiRpRORvxNLu/dOv21SkKxhYaZL2YC7JHKJ9H/L2LEpk+F1gPT4
	 1O0cM58h7DG0Fxfc10+pj6d2tYoYwKgCVRkmNE+nmLfeZ5zCjC0xmpe2C24NXR3tJV
	 YuRxmdxQoeHIIgRWNnIw3VcnvtPPHY3PMXmAoZmi5XvdpjqxcUCS6CSmbktfqi42yR
	 qyll/n6gz4q26T0kw/Xrl+5vr9XaC5YKdadQJgWC1VXKnTHgAOwBf01m32nPClZnBv
	 7z7G4ZW8EG7IA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: jianjun.wang@mediatek.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ryder.lee@mediatek.com, bhelgaas@google.com, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
References: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 0/3] mediatek-gen3: Add support for MT8196/MT6991
Message-Id: <175561422286.13472.6948461219213166201.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 20:07:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 03 Jul 2025 14:08:44 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>  - bindings: Removed useless minItems in reset
>  - bindings: Defined reset-names items
> 
> This series adds (at least partial) support for the MediaTek MT8196
> Chromebook SoC and for the MT6991 Dimensity 9400 Smartphone SoC's
> PCI-Express controller.
> 
> [...]

Applied, thanks!

[1/3] PCI: mediatek-gen3: Implement sys clock ready time setting
      commit: a895dc47ceba63feb711905440585cf2b16e9ce2
[2/3] dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196
      commit: 0106b6c114cf8b77d801d9e280b221f8b4d5595b
[3/3] PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC
      commit: 81fedb39a9f0da301a11c7a3b81d91c3b9024462

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


