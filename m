Return-Path: <linux-pci+bounces-11109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1497C944EA1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 16:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF10B23300
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866211A8C11;
	Thu,  1 Aug 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1wttnFR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4EF1A7F79;
	Thu,  1 Aug 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524338; cv=none; b=s3rVjmsf12yu4skQLhcdOtM+tfMNTqnANTZJCn51dwhaSq6t78SxX7w2+6wkUHz8nBiHjCPiOWJn4tp3feeB9qUsfOc3nDE8XuFFCMgyxXTGbPiDqGMG341CawaWa03+CLlidFzJtlZBZd86Oqp6Bly8/2C0Z0SEf6M1u0/sNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524338; c=relaxed/simple;
	bh=2aVa91T+2Bhd01yKq/9iIArrj32ELNiQVFNbzJuHcew=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=PJKpIVyyS0WCb3kE3eapddP/5/0INY2EIgN4bBHR/Y+/cf7p1uMX2okKFbnI4GJ0MlfBEoZtwNNa7p6Ip/7steMzfFpttVBMK/Gnr19IXsYhzXcL5/JAAEcjEbkASwycTaRVJkYllYuQ8aDhWYSizqLLkK+bPDPy4eLeR/lEJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1wttnFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10860C32786;
	Thu,  1 Aug 2024 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524337;
	bh=2aVa91T+2Bhd01yKq/9iIArrj32ELNiQVFNbzJuHcew=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f1wttnFRqoCwAEv+9XgHY+evSauI9ldKDbB+z8uitnBOuJS62b+msjuZTmGrPkIzU
	 2YlyE13xLFGeBMumOmYFkdRFzZXWAHtRK9NqOPl/4QlZOaRCVg5ldnipbyMhb1XSIj
	 2uAPc1rc3c4d0aFSNLfseuau7bpusRjDJsfIcqER4Z0dHBNH2Rfzhm39wgazbCTJK5
	 BoBxXWfftUTjtx+ZzP9K/4lq0NXeAiePgo9PaMLCx7cSsmu4KV4ngol8yhMOeIC+2q
	 aOhqYSfdvxM8Fp6mmAiq+9OiGCDkHkxvL1y8ZQuvtJfouaIASy9Pu0TsNRqs9j6TVp
	 wsCXPaqDc6+vw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: use unmanaged PCI functions in
 ath9k_pci_owl_loader
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com>
References: <3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-actions@lists.infradead.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172252433405.2450489.14559813280701855158.kvalo@kernel.org>
Date: Thu,  1 Aug 2024 14:58:55 +0000 (UTC)

Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Only managed PCI resource in the driver is the iomapped bar. However the bar
> is unmapped in the same function. Therefore using the device-managed
> versions just causes overhead, w/o any benefit. Once this is switched to the
> non-managed versions, there's nothing left to be managed for
> pcim_enable_device(). Therefore we can reduce overhead here too and switch to
> the non-managed version as well. This includes removing the no longer needed
> call to pcim_pin_device().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

aa0d7643c8dd wifi: ath9k: use unmanaged PCI functions in ath9k_pci_owl_loader

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3b46f6c7-4372-4cc9-9a7c-2c1c06d29324@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


