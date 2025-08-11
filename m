Return-Path: <linux-pci+bounces-33720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F209CB206BE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2900C188C96D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FC2BE643;
	Mon, 11 Aug 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPx084Hy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38B2BE63F;
	Mon, 11 Aug 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910134; cv=none; b=DCRhvogXt8Y2i4Oi9910dTOqkNyd4khHIu9EdjB/o7diOpHQQEft49ctrItycHcGKGzMjqQpsw7NY+xbNMBpgQLCn9BMeyv7xMVuDeR+fhoPsAAcOc2pjp3MVc7SOICTfpWMyn6U8iqhoFUDF0MBSGf+VF0L6aMpZ5F6pBR7snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910134; c=relaxed/simple;
	bh=BPqTEIEi19uUvsZ3UKFemRzcPtUUh7NqCO5h9wS+W5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ahsyVAas4laKi4Y7rbt2nUSGG+5qYvpwom1twuk9HYk75d15ZXGLatetQqT7Bxjb10K+hCEnLQgYB/JFtBDzGxFl1qGXfNZn7vICrpxgqirB/gL/Oqt0ddxMoMctKqCUFLwAT1PZ7TzQAX9HA6ONJ4ejGClNBgZfKGBd07fw0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPx084Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F93BC4CEED;
	Mon, 11 Aug 2025 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754910134;
	bh=BPqTEIEi19uUvsZ3UKFemRzcPtUUh7NqCO5h9wS+W5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FPx084HykHkUTv35hbsedzLzIy1lQHXv9Mk0RLLFYL7OiL3h4HcXNECaOcOF9dyAs
	 vnoL6c7cGmmK2yaDAFxiYoKfJKJ1KFuHGx3FXu956cIGY48yeUfQqi8Ly8k+lcZv3T
	 Ibs8Ce30iF/f4ZUML5mWlyepL6aeYNq2j0zNSTtG9G7BVrOmAc/P3T0mfq5ACIZErR
	 0OAs1gRJe3U960HL2B2ijS10kVeCwY3Nzah3idNxRyaNe4fSIGWh2C1+Twcm10Fedq
	 qZczv4xfo610PcT0bpmpLY9kyYqaW/Ydq1shEmFmTfIIcNYoYD/waBGysbs8FwU9i0
	 NYVTrU2PM2HTg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Toan Le <toan@os.amperecomputing.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aIzCbVd93ivPinne@stanley.mountain>
References: <aIzCbVd93ivPinne@stanley.mountain>
Subject: Re: [PATCH next] PCI: xgene-msi: Return negative -EINVAL in
 xgene_msi_handler_setup()
Message-Id: <175491013091.15602.16180444795907652699.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:32:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 01 Aug 2025 16:34:37 +0300, Dan Carpenter wrote:
> There is a typo so we accidentally return positive EINVAL instead of
> negative -EINVAL.  Add the missing '-' character.
> 
> 

Applied, thanks!

[1/1] PCI: xgene-msi: Return negative -EINVAL in xgene_msi_handler_setup()
      commit: b26fc701a25195134ff0327709a0421767c4c7b2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


