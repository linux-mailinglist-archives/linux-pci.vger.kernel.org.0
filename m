Return-Path: <linux-pci+bounces-702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93380AAEC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC04C2814B9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F653B296;
	Fri,  8 Dec 2023 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTwcJWCd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAE3B28F;
	Fri,  8 Dec 2023 17:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46BEC433C8;
	Fri,  8 Dec 2023 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702057173;
	bh=Z1QJunFWmvP8Ozi9c83wdN1Wu0Ksv55A8wwkLTDgsxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KTwcJWCdXdJkedS9sruBSnLdKvns4uoenFlFRNHT1IyXZ5UgV0/e24pFD2gurpl7V
	 qptyZ0rYWcTH+qGwzVFCUzyZrCXNDoeQO9L4TOFWt05no7tFPjjSTSfXiCdydoXe24
	 vmRgbwSZe2pyyoyB+rxHAvHib8HH5b8jGy3hBgimblIcWnpmqjkoX2l9QzMWG6wX6I
	 Ix2iyoOlfS1LdZYMo/xrjVVVW7ylOcB7O5l7pG9SGl7SISnbNIt0CePsjL4c06Fujt
	 HXWxLIkH3Lqu9AoIT/zO/mkFvLT7RcHLPFrtnjPxnHXvX1M32Cjr8fudI0KI5Fs7WF
	 lfGmJcBeC4eCg==
Date: Fri, 8 Dec 2023 11:39:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michael Bottini <michael.a.bottini@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231208173932.GA798089@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXLNONZRafTkOk9U@hovoldconsulting.com>

On Fri, Dec 08, 2023 at 09:00:56AM +0100, Johan Hovold wrote:
> On Thu, Dec 07, 2023 at 02:47:16PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> > > Add a helper for enabling link states that can be used in contexts where
> > > a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> > > 
> > > This helper will be used to fix a couple of potential deadlocks where
> > > the current helper is called with the lock already held, hence the CC
> > > stable tag.
> 
> > As far as I can see, we end up with pci_enable_link_state() defined
> > but never called and pci_enable_link_state_locked() being called only
> > by pcie-qcom.c and vmd.c.
> 
> Correct, I mentioned this in the cover letter.

Ah, right.  I really don't like these exported locked/unlocked
interfaces because pci_bus_sem is internal to the PCI core, and the
caller shouldn't need to know or be able to specify whether it is held
or not.  They exist for now, but I think we should try to get rid of
them.

> > Can we just rename pci_enable_link_state() to
> > pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
> > we don't end up with a function that's never used?
> 
> That would work too. I went with adding a new helper to facilitate
> stable backports and to mirror pci_disable_link_state(). The variants
> are simple wrappers around the implementation so there's no real cost to
> having the unused one.

Makes good sense.  There's no real machine cost to the unused one; I'm
more concerned about the human cost here.

> But it seems like you think there will never be a need to call this
> helper outside of pci_walk_bus() and if so we can drop the unlocked
> variant right away.
> 
> Would you prefer basically squashing the first three patches and mark
> the result for stable even though that patch will fail to apply to older
> kernels as the Qualcomm bits went into -rc1?
> 
> Or should I send a follow-on patch removing the unused helper after
> merging this series?

I think you did the right thing.

Bjorn

