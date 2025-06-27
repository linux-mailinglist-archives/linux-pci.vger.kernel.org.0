Return-Path: <linux-pci+bounces-30903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2231AEB2CE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EE41889DDE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5E258CDA;
	Fri, 27 Jun 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpiuU1J9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440619F10A;
	Fri, 27 Jun 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016126; cv=none; b=Ytn781UDSrGmxFcA3M1zlf8xaVJ7geiqT8GNQsiqqlwMTbGx9x5rwE0CDVLh7CZ6QbbgXduFzvo4SN8vREFmKIkk0PZYBT/X09mZyUsv1diB8PKVeeq8PcGIHiO78bCDUqR3OlBopc9asRlnPJPqK0aqz0qV5scBXRLBKD6kkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016126; c=relaxed/simple;
	bh=jXlUBtQxNPY7aDzqT/HV/kMRIlUMwqKNVFnyvRbDjUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEN2hnWGcInJw+Cbk18o70G0WF0mGQadzAzVLnTt1QGXOYG+vSX1QyQpAayU3/i+6FzNVS17W1qRarz1gvmiup2Ao9rL2qE3UTikiOx2VTSb9Thc+mAYmrMJiCb4osSIWcDTk6nPRALChn+Agx5xZcyhS8WEePzoihMWejHhpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpiuU1J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3DFC4CEE3;
	Fri, 27 Jun 2025 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016126;
	bh=jXlUBtQxNPY7aDzqT/HV/kMRIlUMwqKNVFnyvRbDjUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpiuU1J9yMRi4Nb1Kcuc9LKsPyXFGvOyTuuQB/PwOqyjT+qIe8TfOWZnb3xJeec0m
	 htOAPBEN26PFmq2jdFo9DOzjhmK9Tw7fmvIIt6d6fGHrlL5kyo2/AD3A/lma5VwxZB
	 TjFMF5QE2X41WznQXJCp3/eJuaiaZ8y0sHx1uiVH8wfIhoMihENWjCeA2xfmGYgGYT
	 YWGd55dcIcVxZUCk+SorR3lvZHNI7WCFWl/wguIawmdkrrmQcEHr8vu3NRFg+kmtqJ
	 LB8cPxtg99Jpdh1zU2VNu0JBzmDGO3D357Ycf2zfW13OtMpLVMPOHj/8eWbmsYoBgY
	 NsrCMOae6I1UA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV5Ha-0000000005k-1QUt;
	Fri, 27 Jun 2025 11:22:06 +0200
Date: Fri, 27 Jun 2025 11:22:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for QCS615
Message-ID: <aF5ivn2uNTqOPrmR@hovoldconsulting.com>
References: <20250625063213.1416442-1-quic_ziyuzhan@quicinc.com>
 <20250625063213.1416442-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625063213.1416442-2-quic_ziyuzhan@quicinc.com>

On Wed, Jun 25, 2025 at 02:32:11PM +0800, Ziyue Zhang wrote:
> QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
> ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
> from 6 clocks' list to 5 clocks' list.

Please add a Fixes tag pointing out the commit that erroneously
described the PHY as requiring six clocks.

> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Johan

