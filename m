Return-Path: <linux-pci+bounces-12813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A496CFE4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 09:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBFE285ED5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EB1925A9;
	Thu,  5 Sep 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOkme3lk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F5154BFB;
	Thu,  5 Sep 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519630; cv=none; b=nsD91xx12DkaF7OkEplSP9rrUxf/vVSzyJ9f5M47E8l7dyJqDfvFdboitdwTZ5ZyefI1+xQy/3QXNUQenmHel6f+VT+Mk1+fYZgL0JGzDqWmJ49FxswqyZ8PUw0dO5VpvD/LBmNpqt8uXTitf6u03cWutK04DQO17w4II5raV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519630; c=relaxed/simple;
	bh=cxJzulP0I1m28tX/d7DSG9fCcQCtNCP2j2cxrrw71dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaRmAMxSFu499Kw3pCFjL8MVQhpQLSQOS0VDty7OLwuIbZrYahdTqNsjwQr6OflfEheFDSy8wDJZJApIxFsHr+B62Pioc1jQwYQNJxC//L//DxKj2FxNyvtkgqatH9EuiPKMxkoWrv/WI3MHzMLAfdnSuivvYidiHsyi36+c2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOkme3lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47D8C4CEC4;
	Thu,  5 Sep 2024 07:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725519629;
	bh=cxJzulP0I1m28tX/d7DSG9fCcQCtNCP2j2cxrrw71dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOkme3lkwVcsq3alssjiZHraWoPVX2EQjki50BYZqyZXjz+SAU9C9Ddv4MTP9rP/P
	 NcMmbeDdXZ/KGWAL+tfmAliCV8FsE0jH8qSi0o2eHJ9gPmosVfKkk+NFKjp8i82gvt
	 AkMo3nd5/dJQgXjlLaGO56fDqQ5PPbl2Y3ZnrtF+naFUfObXKNo1yi1FYXdLJc8Mmu
	 2YOq+MTjvtVLOU3xHZZm0Po9RCOr5uAz0yy1yDS24aTI+m3F00U6IyWvAIrf6SuxL0
	 /Sf7BpaMd87psmRH9CdR9wo8/ppRrbnmOVoinZRhTxIjzfjd9N8yo7sZl6Fm3qAKfQ
	 lHKplJYvpxwog==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sm6U3-000000001WM-1neH;
	Thu, 05 Sep 2024 09:00:47 +0200
Date: Thu, 5 Sep 2024 09:00:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org
Subject: Re: [PATCH v6 4/4] PCI: qcom: Add RX margining settings for 16.0 GT/s
Message-ID: <ZtlXH5yNe8LbZts-@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-4-ec39f7ae3f62@linaro.org>
 <ZtguJs128O-N07Eg@hovoldconsulting.com>
 <20240904160422.gcyrdrzgc47w7pbd@thinkpad>
 <195b4937-dfba-4ef9-8381-0ba2bdbd6e4c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195b4937-dfba-4ef9-8381-0ba2bdbd6e4c@quicinc.com>

On Wed, Sep 04, 2024 at 01:48:09PM -0700, Shashank Babu Chinta Venkata wrote:
> On 9/4/24 09:04, Manivannan Sadhasivam wrote:
> > On Wed, Sep 04, 2024 at 11:53:42AM +0200, Johan Hovold wrote:
> >> On Wed, Sep 04, 2024 at 12:42:00PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> >>> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

> >>> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
> >>
> >> I'd try to find a shorter symbol name here, "settings" seems redundant
> >> after "set". Perhaps just
> >>
> >> 	qcom_pcie_common_enable_lane_margining()
> >>
> >> or
> >>
> >> 	qcom_pcie_common_enable_16gt_lane_margining()?
> >>
> > 
> > This one looks better. Since lane margining is implemented in the receiver, we
> > don't really need 'rx' in the function name.
> > 
> >> if these settings are indeed specific to 16 GT/s. But perhaps it's
> >> better to let the helper honour pci->max_link_speed if different
> >> settings will later be needed for higher speeds:
> >>
> >> 	if (pcie_link_speed[pci->max_link_speed] >= PCIE_SPEED_16_0GT)
> >> 		qcom_pcie_common_enable_lane_margining(pci)
> >>
> > 
> > I did thought about it during the review, but this setting claims to be for 16
> > GT/s only. So I wouldn't recommend applying it to other speeds without checking 
> > with Qcom.

Yeah, this was more an example of what the code may look like eventually
since IIUC anything above Gen4 will need lane margining.

> > Unfortunately, I'm on vacation for 2 weeks and have limited access to Qcom
> > internal docs/chat. So won't be able to check it soon. If Shashank could check
> > it, it is fine. But on the conservative side, let's stick to 16 GT/s only?

> Yes Mani I think we have to stick to 16 GT/s only for now as we
> haven't characterized 32 GT/s yet.

Sounds good. We can always generalise or rename these functions later
(e.g. when adding support for higher speeds).

> >>>  void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> >>> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);

Perhaps just dropping "_settings" (and replacing "_rx") is enough for
now? So something like:

	qcom_pcie_common_set_16gt_equalization()
	qcom_pcie_common_set_16gt_lane_margining()

A bit shorter and pretty self-explaining.

Johan

