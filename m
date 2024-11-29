Return-Path: <linux-pci+bounces-17473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9A9DEC75
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6FB16349F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF514D430;
	Fri, 29 Nov 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofG7zYDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105E1E489;
	Fri, 29 Nov 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908812; cv=none; b=lYuF/Boanf0HSDzs7Iq05b9sZhVDzQ0N3ztnpvGG+jPcxKXb0tppnGXC2NtQ9rBFxb6w+MeuRIcZ62FFP1vCtO8GRTIR2R5/uJ1ns1yQT+GDD4pMmQI9BQ9F6xlhd9kLzSTX/CMjLwrbu1KR+cYpkYwjZbMBOqCEIlboo0WWgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908812; c=relaxed/simple;
	bh=YdVH/+LTNu3Zk1VbyIBQ1Lm9jD9+Us5Wa9cfEaZxXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ct6mEZIiLmV9Xvxc/fdblj7TOKAvmfGyMeDuaPNB//SCeAYcmzKygnwm7C10bF0iIKlXmoQ1LTrjl/N9eo9NuvQ5UV3qPeKLzUcPqgGYlwFxWcYeHEmwNTgdmRtScbaTtJKvaX9vQCeItCzVy4MYcxCYGsmg/5J+UyLtoogjDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofG7zYDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBB2C4CECF;
	Fri, 29 Nov 2024 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732908812;
	bh=YdVH/+LTNu3Zk1VbyIBQ1Lm9jD9+Us5Wa9cfEaZxXWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ofG7zYDG1CXizqQ7HkyqAPCtuu8IuPmTYPLhY4w/HDhhWC3g/ROM19xJ3J8/u1+jO
	 GGgXY3gO7Nigfnhqb/zGihvd2vgshQumgI22XvLcsYNom7cKBTFAtC762getOFddq/
	 scRGkU9dFlUwMCUNRllQg3dtWRp633HgLB/Lnu2Wc7qhRR/pL2xql1fLio4YGiHvBc
	 82K8x9NcY1mRD/5a2iRuUMUyKPx8DbFic4NaFNzOnuCuyE9v73iJW2B5CzXzLurf2m
	 0HtQ2q0qmCMfMjmVtpZ9tUavmHZYqlWr9E5h/9Ht/iyzPPKUlmzxBBKS7q+1qvA/Wk
	 QyEDvc+GaBlow==
Date: Fri, 29 Nov 2024 13:33:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
	lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
	neil.armstrong@linaro.org, andersson@kernel.org,
	konradybcio@kernel.org, quic_tsoni@quicinc.com,
	quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
	quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
	quic_aiquny@quicinc.com, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/8] pci: qcom: Add QCS8300 PCIe support
Message-ID: <20241129193330.GA2769318@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128081056.1361739-1-quic_ziyuzhan@quicinc.com>

On Thu, Nov 28, 2024 at 04:10:48PM +0800, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS8300.
> The series depend on the following devicetree.

> base-commit: eb6a0b56032c62351a59a12915a89428bce68d1d

Also, this commit doesn't appear in upstream or linux-next, so we need
some hint about where to get it.  The most recent -rc1 tag is a good
default unless the series depends on something not included there.

