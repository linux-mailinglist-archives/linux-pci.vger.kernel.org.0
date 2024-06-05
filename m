Return-Path: <linux-pci+bounces-8275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC08FC18D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 04:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1851B21B2F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 02:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B360269;
	Wed,  5 Jun 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q03Z8iZE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3728379;
	Wed,  5 Jun 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553629; cv=none; b=fpbsUTalx9GhqQ3+snXjKxt0U4dpg+ANbPow8aeIp3XH6vKmMBk+wDkSdhCKFK3gpjn88Yc1Gm2CiwYlMiYiNItby8K02EPs73xqELiKIq0dK01Hl8TW8ouX4/fzDRu9gVV8Va5A+h8lRgt1u3misefOiR+8jhADhlwzmbVHm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553629; c=relaxed/simple;
	bh=xaa7l1NfnZNvrR1Y11Ee4Az8s1RlaLtd+KTNnjfYqG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VLVS4SE5uS3KcTAcIVd7bFSGRCCgBs9A7xF+b7tOajUMt+n6SCiuuxkmEaxIS4j17oM98VPK3ZFtnrApfSKCqCXsutpZX+B9/K4vX2uU6lcjec6ORp558G18Uk45AiDU3MZFox1+NAXinx5l0DnMJ2MBVd7g22hRutbLu9XXaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q03Z8iZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A75CC2BBFC;
	Wed,  5 Jun 2024 02:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717553628;
	bh=xaa7l1NfnZNvrR1Y11Ee4Az8s1RlaLtd+KTNnjfYqG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q03Z8iZEAuY+QpAQHiYOYDag25Z34ERDCiAYcBkiKQdauJxt5+QKHpAgoc8HAD8IF
	 dD/nXOcaTCagWd/1XZXh8gzjyqR5OtebZ2lNNGU9a+SoyRVKfJ8cVBxiUwNwPHruKT
	 Q+7IugR43QmE4UrgtdS2LdWlyfCnrzCizKvWzFyTLqqsNVW+kwhZwehbx7zvfljAU4
	 ZLr/yL5pnsAh//MMHcnQnrkXaDnxnxbKvBEQBoxbvQqgiAaaO73CgbyeBAc5Xx80mk
	 1EilMt/qEfeXAjM0hBw1bsbOcS2glyUzslXYlj0apDfdpLZUeP/3hoKSjIgQcVlyqZ
	 84+Oi2MPblg7w==
Date: Tue, 4 Jun 2024 21:13:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
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
Message-ID: <20240605021346.GA746121@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpomPLQmQbW8w3_ms_NMKHoSPcqBa7f2OhNTTOUSdB+9Eg@mail.gmail.com>

On Wed, Jun 05, 2024 at 02:34:52AM +0300, Dmitry Baryshkov wrote:
> On Wed, 5 Jun 2024 at 02:23, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, May 28, 2024 at 09:03:24PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add a PCI power control driver that's capable of correctly powering up
> > > devices using the power sequencing subsystem. The first users of this
> > > driver are the ath11k module on QCA6390 and ath12k on WCN7850.

> > > +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
> > > +     {
> > > +             /* ATH11K in QCA6390 package. */
> > > +             .compatible = "pci17cb,1101",
> > > +             .data = "wlan",
> > > +     },
> > > +     {
> > > +             /* ATH12K in WCN7850 package. */
> > > +             .compatible = "pci17cb,1107",
> > > +             .data = "wlan",
> > > +     },
> >
> > IIUC, "pci17cb,1101" and "pci17cb,1107" exist partly so we can check
> > that a DTS conforms to the schema, e.g., a "pci17cb,1101" node
> > contains all the required regulators.  For that use, we obviously need
> > a very specific "compatible" string.
> >
> > Is there any opportunity to add a more generic "compatible" string in
> > addition to those so this list doesn't have to be updated for every
> > PMU?  The .data here is "wlan" in both cases, and for this purpose, we
> > don't care whether it's "pci17cb,1101" or "pci17cb,1107".
> 
> These two devices have different set of regulators and different
> requirements to power them on.

Right, but I don't think pci_pwrctl_pwrseq_probe() knows about those
different sets.  It basically looks like:

  pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
  {
    struct pci_pwrctl_pwrseq_data *data;
    struct device *dev = &pdev->dev;

    data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
    pwrseq_power_on(data->pwrseq);
    data->ctx.dev = dev;
    devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
  }

I think of_device_get_match_data(dev) will return "wlan" for both
"pci17cb,1101" and "pci17cb,1107", so devm_pwrseq_get(),
pwrseq_power_on(), and devm_pci_pwrctl_device_set_ready() don't see
the distinction between them.

Of course, they also get "dev", so they can find the device-specifc
stuff that way, but I think that's on the drivers/power/sequencing/
side, not in this pci-pwrctl-pwrseq driver itself.

So what if there were a more generic "compatible" string, e.g., if the
DT contained something like this:

  wifi@0 {
    compatible = "pci17cb,1101", "wlan-pwrseq";
    ...
  }

and pci_pwrctl_pwrseq_of_match[] had this:

  { .compatible = "wlan-pwrseq", .data = "wlan", }

Wouldn't this pci-pwrctl-pwrseq driver work the same?  I'm not a DT
whiz, so likely I'm missing something, but it would be nice if we
didn't have to update this very generic-looking driver to add every
device that needs it.

Bjorn

