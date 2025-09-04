Return-Path: <linux-pci+bounces-35461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C148EB4427A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800051897C51
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6071D63F7;
	Thu,  4 Sep 2025 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOytbBFP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A527713;
	Thu,  4 Sep 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002629; cv=none; b=A1jJkWFOTHKeayPGWPK5L1gAMvXL7A38dm8uvKOVs/uqUzJyehnQmCnmbrlZcqgnncm3uTFWizRJi/8+NqerTGWJRYk52fW+U1MIjDNE4h/rTBvjiF2OYB1IoyWDoYzGBkwoPR7mxzXem5tsGzEhJySqyg4VipfQkfyDiJ13yNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002629; c=relaxed/simple;
	bh=kMEh60br9LzSzqFcFHdSCGeQFfw5Y/5AEaz/h73Frvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=szKJc+gsMBJzoSkIqx3suCAsKA5EkdiZUZjwbJAP0KvGsRgYCDnDYp8EnTT6gCU6oj+2onZPBR/i3zKUQSziYSQEqtoUnXtjQVqYaJ4eOkN0T2PWgm6mj1IL8xGmrTGkakll2Lqapin/PNBaL9w3DFQxV6xixU6zPErhgblbJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOytbBFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73743C4CEF0;
	Thu,  4 Sep 2025 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002628;
	bh=kMEh60br9LzSzqFcFHdSCGeQFfw5Y/5AEaz/h73Frvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IOytbBFPIsOca+/MXV537lUnp0nEEYwr1DDK4VhyN+Io/EgWbeMGXtIv5sNacnY5J
	 TN3td5nXVAUUzDTi2IdEfuwG4Y7hrLQwvswULTSrDDmFYBqdkS+vwQyBlHfWePFrjd
	 SDAhGIPxAfpntpRU295jhVs5oZFYraA2k4HH8/eBgaoPIMTTQ+uxYlvAT+aN29gnaC
	 UlfvJBQtFCPOt45URsf001P3Xo8GMHFl/74JVqSFRfJhfhZe2TgEifmJkdAwyKx/xJ
	 XSrrdAX6Qki1J18v2QqLvFJFPyXlfWDVClSDf/ysXT1+ONY13vPQiXJTzTS+Etbnl0
	 qXPW27pz+XEAg==
Date: Thu, 4 Sep 2025 11:17:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] PCI: qcom: fix macro typo for CURSOR
Message-ID: <20250904161707.GA1265471@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904065225.1762793-3-ziyue.zhang@oss.qualcomm.com>

On Thu, Sep 04, 2025 at 02:52:24PM +0800, Ziyue Zhang wrote:
> Corrected a typo in the macro name GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA and
> GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA to ensure consistency and avoid
> potential issues.

In subject, s/fix macro/Fix macro/ to follow precedent.

s/Corrected/Correct/ for imperative mood.

I'd stop after GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA.  Pointless to go on
and talk about consistency and issues.  It's a simple typo fix.

No need to repost for this.

> -#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
> -#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
> +#define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
> +#define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)

