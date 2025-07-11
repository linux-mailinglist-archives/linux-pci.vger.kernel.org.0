Return-Path: <linux-pci+bounces-31959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72516B02664
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205064E37C7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C922D7AA;
	Fri, 11 Jul 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IggaAPoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED232288E3;
	Fri, 11 Jul 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269393; cv=none; b=qsnL+RDg+Sr0LDG7IA4PD6BEEj6QKZZ3FOTlMhG185V1MgqLgLr3J9WRGeScOt/p1xLVc8jzLGmzfDjBafe7dC7roIdTJPmTxCpcqb59vtbldP6a2OMtD4NFl7kIieaXP2nxjIol3LMSJ8LBBKZnjVM2KgsqwYYxvaP0XJrOPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269393; c=relaxed/simple;
	bh=ibAPHTfDkkiDBSvj4LMehyyAm2RUtgYdLgLWKQky8rg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iRX9wbeD9/zrGx511MuZUO9emGDdEhREqZKiV66/NW1Vhpc8JCeEHZEv4iJ36OBs1URXx1EMqlZEs+PXPTVTM2IayEt0t00MUC9rXMlx0V7Zh0eDS0E8HpxHlNbQ7uYf5l0jCS7pcYjG0Dtzcl3YeqHMZNlBxkWO5votWpGEh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IggaAPoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED08C4CEED;
	Fri, 11 Jul 2025 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752269393;
	bh=ibAPHTfDkkiDBSvj4LMehyyAm2RUtgYdLgLWKQky8rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IggaAPoQMRlwpsh8jIo0AYU3XJwQulFIQJEQ3ZpCaBuf2mhN01Ksj6WVs1FFYvoG3
	 LCP4gUN3zot5vMpLo0eDtiAp3SFvkZDVoOpH20Dqj03eGwHVGdNoSI6zYLuk+G8hOj
	 eiv6dtO/gFSyswt+lssP5mZyDWHNm9zIMSTum5chnBQELGVGyuxX3nJXDOfMLi7tl9
	 XvuEtFLIss0frhi/0rv8O4EYr4NXbsMPYceY1gEytWYciXqHSQgM6/ANIE1wc912XU
	 mI34+NepD6PGUtB4Ch0quEyTTdgD2er6N5ey2J6p/DPHoSQTsjdztW5Gd/EzAAumvk
	 58UFmRQfSKPvQ==
Date: Fri, 11 Jul 2025 16:29:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 08/11] PCI: qcom: Add support for PCIe
 pre/post_link_speed_change()
Message-ID: <20250711212952.GA2308100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-mhi_bw_up-v4-8-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:29PM +0530, Krishna Chaitanya Chundru wrote:
> QCOM PCIe controllers need to disable ASPM before initiating link
> re-train. So as part of pre_link_speed_change() disable ASPM and as
> part of post_link_speed_change() enable ASPM back.

Is this a QCOM defect?  Or is there something in the PCIe spec about
needing to disable ASPM during retrain?  What about
pcie_retrain_link()?  Does that work on QCOM?

> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -276,10 +276,16 @@ struct qcom_pcie {
>  	struct dentry *debugfs;
>  	bool suspended;
>  	bool use_pm_opp;
> +	int aspm_state; /* Store ASPM state used in pre & post link speed change */

Whatever this is, it's definitely not an int.  Some kind of unsigned
thing of specified size, at least.

