Return-Path: <linux-pci+bounces-36207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E8B5873D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4444C3773
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687432C0285;
	Mon, 15 Sep 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2K+xsvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BF2BF3DB;
	Mon, 15 Sep 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974470; cv=none; b=s6OQG1gEPU6YuD4GYIlJirbNmxYThRntX1xsByJ3RZXNKVrU41CafopLDwkY7JRGCKDLgJCbbIuv2Lgay9ZvOwUO2J6qPHl9Zrv5Tj3Ko6C0ODIRJ1MXZNBZypcXyO9KygQQC0+IukgbFmbUWk/6pCJxmZZPhNIaZHh0srfC+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974470; c=relaxed/simple;
	bh=G9QFydMno78vIMuERvD1vHylGlQknikWMWrdzEAvphE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y43bVGbTZBDCRfpbgvT3n8UgduJV/prK6z/qXHNzUdPPnqRkaeeDoQHBcJDUXrPKDPkhMWjxhKFpw0/F5fen/Q4mMfdKDXM1uTbhNvngGZxtsI5EBRQjqdh65p1XIXt1K6USNDZKglFsCpQqCFJNZLFj7jJi3fD1lKP2bLQ0JR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2K+xsvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ED6C4CEF1;
	Mon, 15 Sep 2025 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757974468;
	bh=G9QFydMno78vIMuERvD1vHylGlQknikWMWrdzEAvphE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a2K+xsvYt99GxNvx53oREW2flSS5B/oWnhlSedBBqkQyNkOpOYUkijS8Ac7J/wxFa
	 0RpNRK4zJ8dco2MUj5VkftPYJ1gHub4wycRv9eV24wEKk5HQC2I3dpJuN3eO8VxMzd
	 +H9d94pJFqcUxiU02aJKR0aBSwFVu1HtXKWFWez2QwAIcqvsoY+mAqnoa9hfWCHNtS
	 UnIcuB8Qb+9Gkvtm+wKrh1rK7AmOHGcdVPXLm8oteWfmxlJR/DXGhpBKrvb+quUOdt
	 wWVxc9Dsl5s0RYfO04P7RlCNB10LhIgMNYwQMOsyOW+5opWq02mjM0Loep7StkjUTv
	 ol5P4Rdn03PsQ==
Date: Mon, 15 Sep 2025 17:14:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v8 5/5] PCI: qcom: Add support for ECAM feature
Message-ID: <20250915221427.GA1765361@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d12e002b-e99e-4963-a732-4873e13c5419@oss.qualcomm.com>

On Mon, Sep 15, 2025 at 12:48:06PM +0530, Krishna Chaitanya Chundru wrote:
> On 9/13/2025 2:37 AM, Bjorn Helgaas wrote:
> > On Wed, Sep 03, 2025 at 02:57:21PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Aug 28, 2025 at 01:04:26PM +0530, Krishna Chaitanya Chundru wrote:

> > And IIUC, this series adds support for ECAM whenever the DT 'config'
> > range is sufficiently aligned.  In this new ECAM support, it looks
> > like we look for and pay attention to 'bus-range' in this path:
> > 
> >    qcom_pcie_probe
> >      dw_pcie_host_init
> >        devm_pci_alloc_host_bridge
> >          devm_of_pci_bridge_init
> >            pci_parse_request_of_pci_ranges
> >              devm_of_pci_get_host_bridge_resources
> >                of_pci_parse_bus_range
> >                  of_property_read_u32_array(node, "bus-range", ...)
> >        dw_pcie_host_get_resources
> >          res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config")
> >          pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res)
> > 
> > Since qcom_pci_config_ecam() doesn't look at the root bus number at
> > all, is this also an implicit restriction that the root bus must be
> > bus 0?  Does qcom support root buses other than 0?
> > 
> QCOM supports only bus 0.

Since of_pci_parse_bus_range() reads the bus range from DT, is there a
place that validates that the root bus is 0?

> > > >   static int qcom_pcie_start_link(struct dw_pcie *pci)
> > > >   {
> > > >   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > > @@ -326,6 +383,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
> > > >   		qcom_pcie_common_set_16gt_lane_margining(pci);
> > > >   	}
> > > > +	if (pci->pp.ecam_enabled)
> > > > +		qcom_pci_config_ecam(&pci->pp);
> > 
> > qcom_pcie_start_link() seems like a strange place to do this
> > ECAM-related iATU configuration.  ECAM is a function of the host
> > bridge, not of any particular Root Port or link.
> > 
> There is no API in pci-qcom.c related to the host bridge configuration
> currently, as we want to configure before enumeration starts we added
> it here, we can move this to qcom_pcie_host_init() if you are ok with
> it.

Sounds like a better place to me.

Bjorn

