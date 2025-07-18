Return-Path: <linux-pci+bounces-32519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07DB0A048
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1CD5A45BA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9B29C339;
	Fri, 18 Jul 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY9wjtEG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D41EEA55;
	Fri, 18 Jul 2025 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832956; cv=none; b=rJr4lJBu3WfrHLPnMN0OIrnE7aj3kYTC6g+vkVrfhjBvXukEHYWyYKdVz1fVJ2ncnRnLXMbUk2eH5rHbJ3qpqTblYPqWASh8RTmkfHFOs4YaJLpn0b3AQtt5AfSf7RZ0SIlXxJrzzlwZ+N6DgTzF1yRJksGZY90tP3xeknKcePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832956; c=relaxed/simple;
	bh=izVYd/HMFuUxuo/j8GTZPX0Fyh4bT8qBFKIOCQk8DJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHsCdv77s9KB0RfdmgoZyuRWqsQFngL5tNYrVPFNXoIz/b+ZGMXFT3vSqecbw0JgUZpEQvCjIqR6itvBGI+RQQpzOC5BPTsQgC+jdm67DY4tb4nUQSVg5+yzduQW6/EvzES+wvbdLUYHoL90Qz5rGwcpdCarJYc78gc04UGM1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY9wjtEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACD1C4CEF0;
	Fri, 18 Jul 2025 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752832955;
	bh=izVYd/HMFuUxuo/j8GTZPX0Fyh4bT8qBFKIOCQk8DJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mY9wjtEGcEzMQ9cN6ycT6j8D5qSq38VD0Kt4BmIJ7F860VNIuQBRrS2txenS6Hlpb
	 iDO3hx23VVOZRGWp88iUyR7BzRiB7uW8xBTgizMDVr6gAh6ukqrMIXKm0jbAouHmky
	 hMo0WPMwFfA8djZRXAAtnV4AvyP5AewHoGiOa3J5zdtIr/bjv9t5rm+1iICs1qdgzX
	 IRMEro02V3lG7O3/MIrea35X4Olh08mn4f/C3DoG/4p5MZJiBDlpOrqFSnCikZ4ztw
	 jbnqoshSQNFfO30hxnwZ9ckhij88vm5iYpKdS/udEjqb27l3Og24ALejkzYyMf5dGR
	 cGqvZJXJ6owfA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uchv9-000000007sr-3Unq;
	Fri, 18 Jul 2025 12:02:27 +0200
Date: Fri, 18 Jul 2025 12:02:27 +0200
From: Johan Hovold <johan@kernel.org>
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
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: sa8775p: add link_down reset
 for pcie
Message-ID: <aHobs30ZI-I8xLAD@hovoldconsulting.com>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-5-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081718.390790-5-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 18, 2025 at 04:17:18PM +0800, Ziyue Zhang wrote:
> SA8775p supports 'link_down' reset on hardware, so add it for both pcie0
> and pcie1, which can provide a better user experience.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

