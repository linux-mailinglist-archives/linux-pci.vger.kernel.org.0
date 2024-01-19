Return-Path: <linux-pci+bounces-2394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D68330C8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C84B22AFB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794744436D;
	Fri, 19 Jan 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJLMTo9q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C41DDD7;
	Fri, 19 Jan 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703680; cv=none; b=rIshqCdZCDxdciorJHODwvcSL/KJTs5z7UOrx5n2RT/zMox+WGvXGmAJa3TI/9gZpeDHK4W3x6Fr4C0HTZOH4gj0J1yt4C9QVoEdCMge5c2xHndcy+fi+F5vt5q2TzOUTMGeiRXe+HLW4IUHElFfD8Kq+eko962u0Q605lTHbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703680; c=relaxed/simple;
	bh=Tb/IF/3dnB+KD/SYWtRz1VcIoMLT0oJr5xplyBvSeDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4NBpCd8aI/96m7ZNLxeIGr0IqO9oJzxuetNdrrL9G3pKlWdFTWQ5duAAS4qtIQ6yMbk6tDq7Sj1+FQ9gBc2Tro5Pib2MBe+fldEzBHcfndoio8gP/5qzS5kDFCKvoXtl37Wr7J/To5XBZs0o5fmDtQjKX+3po85jAs2hLF3gyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJLMTo9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E509EC433F1;
	Fri, 19 Jan 2024 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705703680;
	bh=Tb/IF/3dnB+KD/SYWtRz1VcIoMLT0oJr5xplyBvSeDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJLMTo9q1wdgV+lwBQQZfmMaHmb+B3Dwm40qcJizh2E0tvM8XDVz6lGc+iQRDLv2c
	 XNIH1IxPk9itUI7VrfrFyqR/r8Iis7FR6mPqEv1INxM9ZU3a0RHppz8/JOhx5Bslrn
	 x83geQtdq2nOc8pKLTyCi08aqDW5++JVubQJ+GRFB0zr/I+8WZ1ok1oa7yGT33frcI
	 ueg0LgzeQ+CRz8CWx9q9RsyJn2GGs8DrBUTt2pUbXhuWmNeHJzofE1fDcPjPcdxPL7
	 jLxZ3HEnIn7MYi9whncFoWK80jhz8Z1Tf48Q8xAsiwEMhkswW5EVpCWrAS6bjzIi6U
	 67fudl0y9QIsQ==
Date: Fri, 19 Jan 2024 16:34:37 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	quic_skananth@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, vireshk@kernel.org,
	Brian Masney <bmasney@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pci@vger.kernel.org,
	quic_nitegupt@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Johan Hovold <johan+linaro@kernel.org>, quic_vbadigan@quicinc.com,
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: PCI: qcom: Add interconnects path as
 required property
Message-ID: <170570367676.1246878.13604821231091886465.robh@kernel.org>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112-opp_support-v6-1-77bbf7d0cc37@quicinc.com>


On Fri, 12 Jan 2024 19:52:00 +0530, Krishna chaitanya chundru wrote:
> Add the interconnects path as required property for sm8450 platform.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


