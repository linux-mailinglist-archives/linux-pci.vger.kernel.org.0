Return-Path: <linux-pci+bounces-8618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723A90475F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D10928634B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90031156980;
	Tue, 11 Jun 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEPS95Vp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159A155A5D;
	Tue, 11 Jun 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146599; cv=none; b=n4DfGtTTJpWyhqn3f3ah8zK30S4Zzhxfyv1DFi/FMiggQYn7TW8DEX2Udxzv5pTCNeKvTb3BD86nA5VMJxSSs2q5zqlEOm9rGMNdWEFU6JOWysoRRXYokXUz4yIn+IyhcciR6OV/LmlWf/IIrBRX81npfVqKYInWKbgtjSdBp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146599; c=relaxed/simple;
	bh=fTTmy82roNHgpHAIircnr4I4sFYZNjPs3kLCDpI1ztE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gt8rWC43nXGDh5Fxdv47ErYz4lSCCfIQvJVWifv7tZWf4HpuG6sdwHsb7dREGjnhjokbg+GwwyiH6+JiLBOueZXNSu/fhBwLHHDRjo9+8Y/KiGhlVANvYjB3pXgqZvLIP+Bb+NRrh30eRYgOD1vUdac0AYDebeUYU8U+JVJvNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEPS95Vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A8FC3277B;
	Tue, 11 Jun 2024 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146599;
	bh=fTTmy82roNHgpHAIircnr4I4sFYZNjPs3kLCDpI1ztE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oEPS95VptOeiB1acpH1GE+ebcl2vKNI2aPXlHGGBxogzerUzv4LasE1Sssg9UskoH
	 Qv9gl1YoLzDIQwKXyBI5DlmQ+dpttpicGgKUvOEGB3T/lEHAqSeIu1QXPqA8PxIUW9
	 QzvHTaFml4rhw/Tlq/vwsedAxaGIJ1bU3YFamBZOXnU2FQkuSIQeGvt9dT4nTT2PWF
	 lm3I2QJF5yF1JzzgpPPF7lLZc7hdrmIKc80kYyol9cZn1s350kzC5uXwQeDFy1Y08M
	 yyH3EtpAkyLHcpCwIwGFD928yyBIQ1VNrIW2n5jc0Bux851JF/QN8iqD6vXw4y1VIG
	 ihNf06lncAslw==
Date: Tue, 11 Jun 2024 17:56:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 15/17] PCI/pwrctl: add PCI power control core code
Message-ID: <20240611225637.GA1005953@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McKD=ZhGzRUeLezT3oKfreDWQeKBvuousf8zsQjJb1QMA@mail.gmail.com>

On Wed, Jun 05, 2024 at 08:05:06PM +0200, Bartosz Golaszewski wrote:
> On Wed, Jun 5, 2024 at 7:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, May 28, 2024 at 09:03:23PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Some PCI devices must be powered-on before they can be detected on the
> > > bus. Introduce a simple framework reusing the existing PCI OF
> > > infrastructure.
> > >
> > > The way this works is: a DT node representing a PCI device connected to
> > > the port can be matched against its power control platform driver. If
> > > the match succeeds, the driver is responsible for powering-up the device
> > > and calling pcie_pwrctl_device_set_ready() which will trigger a PCI bus
> >
> > s/pcie_pwrctl_device_set_ready/pci_pwrctl_device_set_ready/
> >
> 
> Ah that's a leftover from when it was PCIe specific. Thanks.

With that typo fixed and s/add PCI/Add/ in subject,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> > > rescan as well as subscribe to PCI bus notifications.
> > >
> > > When the device is detected and created, we'll make it consume the same
> > > DT node that the platform device did. When the device is bound, we'll
> > > create a device link between it and the parent power control device.

