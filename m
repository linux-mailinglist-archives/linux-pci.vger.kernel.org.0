Return-Path: <linux-pci+bounces-8345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165C8FD444
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B361C23766
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965D13A26E;
	Wed,  5 Jun 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByLcuP2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541D19D894;
	Wed,  5 Jun 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609636; cv=none; b=UYkbtbugsXwD4sWTNHn+Uall40N3ZHwIpxoG6UDUbJsHbsHfjCtoTOVeFZKciGmmXMi7zl7xWwWUQZ6sLcx47aaia0WTeYsLfXUzZAWvi99tLeIR4cz/XSMCVDbuGWNHbzPcRoltNWVpWpOrZSlvHvIhMYV4wNM8N8BmJaoMMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609636; c=relaxed/simple;
	bh=TquLKd0gVLtuXLEtJC/CPqTotKpWkwDo4bpISXh1os4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eNg6Vwv2WMTM7bciuKwQiwsWeCHpTt0dh3pwjtI1QiOByyBY/6ZPFTI0en1hkbr15YwdKqkfbxVNLT0BdWBXaSgkMtFzWNNOXHYcne5BLLWC04y3tvzvB0/ldRz6apGpDTdCQNMx3S/i9SSeC/X5LM15/e4TdTO+PxNv/31VCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByLcuP2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990ADC2BD11;
	Wed,  5 Jun 2024 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717609635;
	bh=TquLKd0gVLtuXLEtJC/CPqTotKpWkwDo4bpISXh1os4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ByLcuP2UMGfSLhV/gWgXJ82ryuTS1kHeyVL5PHdJ9MrxDAp/gdaVsb1SKLlVBuVd3
	 fq0LpFK9smWEc2THwgiZAWoDCGhkuM8KzBRsH9loW2F/M0MzpkOqRD2sfGue6P/MxA
	 QaEsd4pbfouIw47SbmMmVe5dlPtQVXQGEXgs7WzzaeBb06hrzsg0oUfsfZ941Pq6cN
	 Y00sluayyGEZe86UJWMDtmxP8mxPYOYHUuclqYJRPdTu9shy3nr84VKzZsnAWbTcPc
	 KADXMJK5MyM6Xm7e8uRFSwux6qHIYB9qdjPapN4JWHWjC9ihRa87GxdnD9tkHrfqF4
	 ReQSAnxjbkAlw==
Date: Wed, 5 Jun 2024 12:47:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
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
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
Message-ID: <20240605174713.GA767261@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mckab1QYoBuE3iSv0x+GEjFNBQS5Hw_Mry=r7h5XGHZEQ@mail.gmail.com>

On Wed, Jun 05, 2024 at 10:47:32AM +0200, Bartosz Golaszewski wrote:
> On Wed, Jun 5, 2024 at 4:13 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jun 05, 2024 at 02:34:52AM +0300, Dmitry Baryshkov wrote:
> > > On Wed, 5 Jun 2024 at 02:23, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, May 28, 2024 at 09:03:24PM +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Add a PCI power control driver that's capable of correctly powering up
> > > > > devices using the power sequencing subsystem. The first users of this
> > > > > driver are the ath11k module on QCA6390 and ath12k on WCN7850.
> >
> > > > > +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
> > > > > +     {
> > > > > +             /* ATH11K in QCA6390 package. */
> > > > > +             .compatible = "pci17cb,1101",
> > > > > +             .data = "wlan",
> > > > > +     },
> > > > > +     {
> > > > > +             /* ATH12K in WCN7850 package. */
> > > > > +             .compatible = "pci17cb,1107",
> > > > > +             .data = "wlan",
> > > > > +     },
> > > >
> > > > IIUC, "pci17cb,1101" and "pci17cb,1107" exist partly so we can check
> > > > that a DTS conforms to the schema, e.g., a "pci17cb,1101" node
> > > > contains all the required regulators.  For that use, we obviously need
> > > > a very specific "compatible" string.
> > > >
> > > > Is there any opportunity to add a more generic "compatible" string in
> > > > addition to those so this list doesn't have to be updated for every
> > > > PMU?  The .data here is "wlan" in both cases, and for this purpose, we
> > > > don't care whether it's "pci17cb,1101" or "pci17cb,1107".
> > >
> > > These two devices have different set of regulators and different
> > > requirements to power them on.
> >
> > Right, but I don't think pci_pwrctl_pwrseq_probe() knows about those
> > different sets.  It basically looks like:
> >
> >   pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
> >   {
> >     struct pci_pwrctl_pwrseq_data *data;
> >     struct device *dev = &pdev->dev;
> >
> >     data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
> >     pwrseq_power_on(data->pwrseq);
> >     data->ctx.dev = dev;
> >     devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
> >   }
> >
> > I think of_device_get_match_data(dev) will return "wlan" for both
> > "pci17cb,1101" and "pci17cb,1107", so devm_pwrseq_get(),
> > pwrseq_power_on(), and devm_pci_pwrctl_device_set_ready() don't see
> > the distinction between them.
> 
> These are only the first two users of this generic driver. We may end
> up adding more that will use different targets or even extend the
> match data with additional fields.

If that were the only reason, I would suggest waiting to add the
specific device strings until we need the functionality, but it sounds
like there are other stronger reasons.

> > Of course, they also get "dev", so they can find the device-specifc
> > stuff that way, but I think that's on the drivers/power/sequencing/
> > side, not in this pci-pwrctl-pwrseq driver itself.
> >
> > So what if there were a more generic "compatible" string, e.g., if the
> > DT contained something like this:
> >
> >   wifi@0 {
> >     compatible = "pci17cb,1101", "wlan-pwrseq";
> 
> What even is "pwrseq" in the context of the hardware description? DT
> maintainers would like to have a word with you. :)

There are "compatible" strings like "simple-bus", "simple-mfd", and
"syscon" that allow drivers to bind and provide generic functionality
when they don't need to know the exact hardware.

> > and pci_pwrctl_pwrseq_of_match[] had this:
> >
> >   { .compatible = "wlan-pwrseq", .data = "wlan", }
> >
> > Wouldn't this pci-pwrctl-pwrseq driver work the same?  I'm not a DT
> > whiz, so likely I'm missing something, but it would be nice if we
> > didn't have to update this very generic-looking driver to add every
> > device that needs it.

Do you have any other ideas to reduce the churn in this file?  It just
seems weird to have to add an ID to this file without adding any
actual code or data related to it.

We should probably also add a pattern to MAINTAINERS so
get_maintainers.pl on this file will show you as a maintainer.

Bjorn

