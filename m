Return-Path: <linux-pci+bounces-21833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165CA3C797
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7164D189EAB5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A447215791;
	Wed, 19 Feb 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM/7VpTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819B214A6A;
	Wed, 19 Feb 2025 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989670; cv=none; b=qODU49u3dl2S/iYUztOhb8evHcRnd5ROsi70okXmMGi1qdJR/DyW8EDbulvD+gCx9UlW/TfTAl2nuJcomtr+Y+yyH28n3B8Y24070eUEdmqsbm+ZCyCoYtN1tTFCEtrt9aZvjNEeHFjCE99g8jyRsHh2MW2T6X9BLbdq1hk5TkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989670; c=relaxed/simple;
	bh=UIoAHLKhxXMvwRVPNUAgVWM1OzHt8bv2gL9HuSb4s8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eLgMYV9q68jDu0wQlycp0pc/Y8CgwltTQBGk+plKUTBrE60SMpu3QxXclh0vgmX1Kafk2Y3cZnR1PRqqAcBHDVg8GvdMFc28Dc1WrUe+X6H5b6U8sEBM26wY50jWAmat4yl1GrsI8HmRuRYFVQZc4OvkUsrGAUF+ckzLldMRt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM/7VpTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B6FC4CED1;
	Wed, 19 Feb 2025 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989670;
	bh=UIoAHLKhxXMvwRVPNUAgVWM1OzHt8bv2gL9HuSb4s8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oM/7VpTzi/qHrQlMXfwp1C2byH05D8tZNakXeSfti2tjiRVCusvRpVWuFJUofaKjZ
	 n2MkVMuuW4wNzNLERxr0VDX6bPR6a91Lo8/ONo9SmrsqvFChLUO1MTM4VwTLopoYB3
	 23XJT+Dnbarq/Ci0AYvXIPn2vNFu/a9FdcLD/KdzwdcAeeCyylSLoMe5mRLVctMfO1
	 QCcvib6Am/JwMH7sZvNuQHgfNTSfJmwSwGUsHD2UUvPIQEhRIVT0s11Iy4/93TksRK
	 2XMkZ3frjmXUteUMicgESwd8+nYmUp9e7fd7V6lZL8Ex/9otJIxLJ0DBtoVa5wtW/o
	 fIVXvX6Pk78jA==
Date: Wed, 19 Feb 2025 12:27:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, quic_jjohnson@quicinc.com,
	quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 4/8] PCI: dwc: qcom: Update ICC & OPP votes based upon
 the requested speed
Message-ID: <20250219182746.GA226108@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e5efb7-8ea0-a064-21e4-6d7596b1a9ae@oss.qualcomm.com>

On Wed, Feb 19, 2025 at 11:28:47PM +0530, Krishna Chaitanya Chundru wrote:
> On 2/19/2025 3:37 AM, Bjorn Helgaas wrote:
> > On Mon, Feb 17, 2025 at 12:04:11PM +0530, Krishna Chaitanya Chundru wrote:
> > > QCOM PCIe controllers needs to disable ASPM before initiating link
> > > re-train. So as part of pre_bw_scale() disable ASPM and as part of
> > > post_scale_bus_bw() enable ASPM back.
> > 
> > s/needs/need/
> > 
> > Why does Qcom need to disable ASPM?  Is there a PCIe spec restriction
> > about this that should be applied to all PCIe host bridges?  Or is
> > this a Qcom defect?
> > 
> It is QCOM controller issue, PCIe spec doesn't mention to disable ASPM.

OK.  I'm a little concerned that disabling/enabling
PCIE_LINK_STATE_ALL might clobber preferences set by drivers of
downstream devices, but I guess ...

Maybe we could add a comment in the code about this being done to work
around some Qcom issue so that browsers of
pci_enable_link_state_locked() don't get the idea that this needs to
be done generically.

Bjorn

