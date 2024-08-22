Return-Path: <linux-pci+bounces-12054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD695C01B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4DE284CC2
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348241D0DE4;
	Thu, 22 Aug 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIdAJoFK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33912AD00;
	Thu, 22 Aug 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361219; cv=none; b=rnXXwTpPEedj9sdzkBZGMq2pJoTBBzxevCWiZb6GcBfAa58lFs/gV0KYZgYQantfPIJ6DcNs5i7v8gVPwJeeIStQrlO7Z+9wwyfASZM0n4evIc/rLwVApAsTZeUDnW6m+1WfynST/Ph+hWYD0ufEOT/f/Km4xN94V7TqzH/P0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361219; c=relaxed/simple;
	bh=mTBgG3Ma68htfIo38K+TfYoh4pQFiUyFdbvudorGaXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cuJc9GCBEc6S/60/aFqDzc7T3jfW0d8n/9ESSHLOOAUJiCk2MbvQUVnEERX0KugHNoHpWIjgh8iwDaUEMhag1ACrrlPX1TZOyzHJxQeBuLCjIv6r39vZyjt+fU69HANpkwPTFROK/HeVDzhy0rg4bjTKsojWS5NSRKsjuFoMHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIdAJoFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A7C32782;
	Thu, 22 Aug 2024 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724361218;
	bh=mTBgG3Ma68htfIo38K+TfYoh4pQFiUyFdbvudorGaXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UIdAJoFKyUrY6k1SVSCNgFxRcKhr3Q5ZDOWajIilSTCXlT83kTV/nykP+UuimYLyE
	 zOS7U9Q+s4Y+p3Y2PGIkYlwlx7sW51ny40FP0cLIFpSWYJ7Ynvo665hiRLShDnx1ht
	 b76D3im0Ef+MHz9z2s/X2om/rqCkbXq75YG9OCzClVuT9vIzo0Ar9NepkWq3KYFRaI
	 5PZG1XbgvQ1fCRvBuXiMbVZkTxy0KX6gdlqaFEhodtlPZI8swE3dFYrnz58DvkTApW
	 G/Mz1rtdZXG0wp9fIC2KMjzg6BsOh1FqG+VyHcNtzRvSE3dAahQE3yBcr8PVA+EEsj
	 OVgolAFc7OkgQ==
Date: Thu, 22 Aug 2024 16:13:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent
 pcie hierarchy
Message-ID: <20240822211336.GA349622@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcrrhagqykg6eXXkVJ2dYAm5ViLtwL=VKTn8i72UY12Zg@mail.gmail.com>

On Thu, Aug 22, 2024 at 10:01:04PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 22, 2024 at 9:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Aug 13, 2024 at 09:15:06PM +0200, Bartosz Golaszewski wrote:
> > > On Sat, Aug 3, 2024 at 5:23 AM Krishna chaitanya chundru
> > > <quic_krichai@quicinc.com> wrote:
> > > >
> > > > Currently the pwrctl driver is child of pci-pci bridge driver,
> > > > this will cause issue when suspend resume is introduced in the pwr
> > > > control driver. If the supply is removed to the endpoint in the
> > > > power control driver then the config space access by the
> > > > pci-pci bridge driver can cause issues like Timeouts.
> > > >
> > > > For this reason change the parent to controller from pci-pci bridge.
> > > >
> > > > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > ---
> > >
> > > Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Bjorn,
> > >
> > > I think this should go into v6.11 as it does indeed better represent
> > > the underlying logic.
> >
> > Is this patch independent of the rest?  I don't think the whole series
> > looks like v6.11 material, but if this patch can be applied
> > independently, *and* we can make a case in the commit log for why it
> > is v6.11 material, we can do that.
> >
> > Right now the commit log doesn't tell me enough to justify a
> > post-merge window change.
> 
> Please, apply this patch independently. FYI I have a WiP branch[1]
> with a v3 of the fixes series rebased on top of this one. Manivannan
> and I are working on fixing one last remaining issue and I'll resend
> it. This should go into v6.11.

OK.  I just need to be able to justify *why* we need it in v6.11, so I
can apply it as soon as somebody supplies that kind of text for the
commit log.  I.e., what is broken without this change?  What bad
things happen if we defer it to v6.12?

> [1] https://git.codelinaro.org/bartosz_golaszewski/linux/-/tree/topic/pci-pwrctl-fixes

