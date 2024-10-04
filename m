Return-Path: <linux-pci+bounces-13876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBAD9912E3
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 01:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D80C1C224DB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140214B061;
	Fri,  4 Oct 2024 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMErnZwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1381130ADA
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083970; cv=none; b=U7ZJqvSGNdhDKTvfbEMPDXCrcjXeg+PMJCcFeXXeo/Waa3fx8ns4T5TTJ6H3AStNWIa77vGAr3krJGoF827CsMOG8dAiSsxMuOGXAOqdPxc7AyZz0FGFsA5jfbvM6dCpGuFLYOSmnLPBX1ZsiFQRBkIZAXC+5WYTUJqhsf+nCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083970; c=relaxed/simple;
	bh=V+7hthLRpyIDZQ/dwJIGJDGglqlQDWuoK8iWKcWwtDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GkIgb3T28VPY68QS+TzyOUv0afu5Wt+wxtTPlSo1ik7XllY5G5+McYeyvJoiVfn0jWHdEj3pSq0Q1R7q7gL828sKwVo7PBrn0ATg2mgA2zz319OyNSYBVOhwJQ48/0IYscucOW0tERiyZYqkxaoR5W/evXttf9xHpiMjuCNlVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMErnZwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB0AC4CEC6;
	Fri,  4 Oct 2024 23:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728083970;
	bh=V+7hthLRpyIDZQ/dwJIGJDGglqlQDWuoK8iWKcWwtDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GMErnZweqHTQeLtJ+TCfThFwYAeJHlfF1TGmPtxwFWlPgir2qdZSaV8IGhXp5GGpe
	 P6fNsKXZbTuJt49qlmF5gV4FKvokfh+XLKECl22eMvjXWwQaFXGOjPJblgs66OgUNm
	 k1yOGidULYPttzIMPndjkWzDLWMrwUrIsolaxvzgakNdvXlTlSE6hi5ZBcVfcm6ifw
	 1lP9uxBlRUjDabpMrH4O6V3pA91A6mMXoZKg3JTUMHB83/pzcoVLEe5mSMn88TEA0u
	 hTmFEmEoL+LDOLZC94avBsxAdDjng6IMz1gEkBCk6uX4/qSV3hvrycO6GjTzxvVwum
	 kO1CQmp3ZMn4A==
Date: Fri, 4 Oct 2024 18:19:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <20241004231928.GA366846@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003132503.2279433-1-ajayagarwal@google.com>

On Thu, Oct 03, 2024 at 06:55:03PM +0530, Ajay Agarwal wrote:
> The current sequence in the driver for L1ss update is as follows.
> 
> Disable L1ss
> Disable L1
> Enable L1ss as required
> Enable L1 if required
> 
> With this sequence, a bus hang is observed during the L1ss
> disable sequence when the RC CPU attempts to clear the RC L1ss
> register after clearing the EP L1ss register. It looks like the
> RC attempts to enter L1ss again and at the same time, access to
> RC L1ss register fails because aux clk is still not active.
>
> PCIe spec r6.2, section 5.5.4, recommends that setting either
> or both of the enable bits for ASPM L1 PM Substates must be done
> while ASPM L1 is disabled. My interpretation here is that
> clearing L1ss should also be done when L1 is disabled. Thereby,
> change the sequence as follows.
> 
> Disable L1
> Disable L1ss
> Enable L1ss as required
> Enable L1 if required

I think we also write the L1.2 enable bits in PCI_L1SS_CTL1 in
aspm_calc_l12_info() when ASPM L1 may be enabled:

  pcie_aspm_init_link_state
    pcie_aspm_cap_init
      pcie_capability_read_word(PCI_EXP_LNKCTL)
      aspm_l1ss_init
        aspm_calc_l12_info
          pci_clear_and_set_config_dword(PCI_L1SS_CTL1, PCI_L1SS_CTL1_L1_2_MASK)

That looks like another path where we should make a similar change.
What do you think?

Bjorn

