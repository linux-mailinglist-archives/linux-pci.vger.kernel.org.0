Return-Path: <linux-pci+bounces-7884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249D8D12DE
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 05:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9780D1F23B6C
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA413E8BE;
	Tue, 28 May 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms27zq8G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06513E050;
	Tue, 28 May 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867191; cv=none; b=NxwfvlwY05bILeq6+S59kNnL5NMRFFHIzBeMo3VAuaMb0W4w2ARgdIQfY4RMb7rIIGuLYbaXHoIv9qrPVXsHCGAP76MivigTENAHIf89qNEBMfEfOy9B+DlZ6OacWLogur3hg609HOd3j7013l6u4TWSJCZidF5+o+lJcLDaxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867191; c=relaxed/simple;
	bh=Da6ub8AGzK3CfyM3tZdtD9pKrb9IWIIWPX7ocvw+vik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4KHalR0zKzk3SQL7O76oRKIrmtewavTUq7mww48kih9tAF5/5yTAymbpBO/oPWUwucpxNnIu8utZDbSDzCf1z8CwILrCsOSpad/Csby6xEnJL+yPINVA/KFY6Oa/OAbSzAkVowt+nASRJKo8wwD49dbmPbZNcm2i4r53vwE4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms27zq8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F833C3277B;
	Tue, 28 May 2024 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867191;
	bh=Da6ub8AGzK3CfyM3tZdtD9pKrb9IWIIWPX7ocvw+vik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ms27zq8GIb9HDV4AuPq+9EwekKzeGEjiPbHw39S9Vc4oKqB6n9IF8caQWNg/ziQ/H
	 L9SB4ZwHEsQrNLB4V5oiUC/6fFzQ3ind1VI015ZpqsvhIVrYHjWy0Hz0Im0Y5fSdGe
	 go1Mzq46CrymX6cl8CA9rcvSfjvIHQVqPKpwim5vfY0PF2qJgrmHoFkTmMyKBdxSIV
	 istCCiCToG7iFrhq0xkSAsj3vCJEAmmduJIQb5Nf1oZr/zPOmhbvnHiZpffMkN4za0
	 HGIa26xQ1kTdime0b2ZogL9QCLLY6Jb7xJor4RABq6/3X9wO2CiI9of18VIgHjVwPA
	 qv99v1PN9WPRw==
From: Bjorn Andersson <andersson@kernel.org>
To: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date: Mon, 27 May 2024 22:32:30 -0500
Message-ID: <171686715168.523693.9031947967155773855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>
References: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Mar 2024 19:41:34 +0530, Mrinmay Sarkar wrote:
> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that no cache coherency issues exist for
> the addressed memory on the host i.e., memory is not cached. But in
> reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent
      commit: 4b220c6fa9f379cb8803dbca73ae1f4128dfa5c8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

