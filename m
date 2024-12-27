Return-Path: <linux-pci+bounces-19068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1019FD021
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 05:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2331881EE9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 04:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280214EC55;
	Fri, 27 Dec 2024 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXztEk9G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709214D44D;
	Fri, 27 Dec 2024 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272940; cv=none; b=W1Pm6tx9vWMEk8MeBbHz0kZt0OhpN3Kj+A7ZDOmvPgcCXp4uk8jZa7VNlbNWp3K1aG69e9Hjo4UI6dpE7gOFXkbmAmB197KQQPTsSWoEJVijk4SjznY9YlH+4gR2bmB5aWW1/ZchnrNTk9C0Adg02VtN8S14NTGKQVS1eNjMnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272940; c=relaxed/simple;
	bh=PX2gCVpNov1cAi/I9agfGg8xaQUf7f2dYAyurGCugBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PC2XzJ+QrQY3tnFoxLu+Rjtz4e6pzKvCzygFFrs2X7qQ4TjnmLTvMJCWCh+vcrWGqXtbMJyTyNNlkQRXUTZY4URwztPrrogbiYFrZEshnyn9stYxekEiZZy3faoPq/HKhVhtPvg5eczCZOLoJjvVJyNTYe5I6Rbfexw0E13aeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXztEk9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60A2C4CED4;
	Fri, 27 Dec 2024 04:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735272939;
	bh=PX2gCVpNov1cAi/I9agfGg8xaQUf7f2dYAyurGCugBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXztEk9G0hR3esm4cmZBlEwErDuW/rLM08DzHGcd+SyKqdh81DbyurORkHY7gyI65
	 l0tA+XLQOGbvCG+gaOhScxSDDAsd1KqFQxxvYQ9epCNCbhz+8lr6adLwRuJfwFixkS
	 dG4jZyFoiesD9GaXbit0DKhGdx+CcpMLnBu4b2+cyU7DaEtefAnQ5nSPRVDEmZUqRh
	 rq+I9PewP4FDhJNFZV2EY/HKayaAujaCo1fSZxqILZsYAvIOzFKT0wv6+WQMRplIeD
	 b3LbcsVJr5P+1+BmHjjz4Ftl4OYW4rVP2mZCGzeb8VpJwLm1Qe3ZFgc2ECOWDBpOwX
	 WaHJxd+AqeVMw==
From: Bjorn Andersson <andersson@kernel.org>
To: manivannan.sadhasivam@linaro.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com,
	quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com,
	quic_ramkri@quicinc.com,
	krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Date: Thu, 26 Dec 2024 22:15:27 -0600
Message-ID: <173527291948.1467503.9672408078047236148.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Jul 2023 12:50:14 +0530, Krishna chaitanya chundru wrote:
> Add basic support for managing "pcie-mem" interconnect path by setting
> a low constraint before enabling clocks and updating it after the link
> is up based on link speed and width the device got enumerated.
> 
> changes from v9:
> 	- addressed the comments by mani.
> changes from v8:
>         - Added cpu to pcie path in dtsi and in dtsi binding.
> changes from v7:
>         - setting icc bw to '0' in disable resources as suggested by mani.
> changes from v6:
>         - addressed the comments as suggested by mani.
> changes from v5:
>         - addressed the comments by mani.
> changes from v4:
>         - rebased with linux-next.
>         - Added comments as suggested by mani.
>         - removed the arm: dts: qcom: sdx55: Add interconnect path
>           as that patch is already applied.
> changes from v3:
>         - ran make DT_CHECKER_FLAGS=-m dt_binding_check and fixed
>          errors.
>         - Added macros in the qcom ep driver patch as suggested by Dmitry
> changes from v2:
>         - changed the logic for getting speed and width as suggested
>          by bjorn.
>         - fixed compilation errors.
> 
> [...]

Applied, thanks!

[2/4] arm: dts: qcom: sdx65: Add PCIe EP interconnect path
      commit: 84d2ae7c09d93949fc9e9fe57bdb78a2f3fa24aa
[3/4] arm: dts: qcom: sdx55: Add CPU PCIe EP interconnect path
      commit: 7ec041bd2715df2da4ab19c403c27d58d173c7c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

