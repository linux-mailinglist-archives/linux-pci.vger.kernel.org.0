Return-Path: <linux-pci+bounces-8258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA618FBAD4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9799B28511E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915E14A601;
	Tue,  4 Jun 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGAt4/9M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAE14A082;
	Tue,  4 Jun 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523009; cv=none; b=uysd7rM8CTwB5JheoT1djvHx/oamTQY4rwekXQhiGKcTCEnZIs6m9F+lwp/o2I+fCpxB3FWfZ9ZzSQa08zeLdGBNsZ27S6vrUUkkLMyqoCG+yaU8FvL4VgvtbD/a64Djnf1xuCaWa9v9LGtOcfoqHeIKitvnUSNRZGfPwrw442w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523009; c=relaxed/simple;
	bh=JcC1v5BWR3/aIlXbMvxiyykfLTUcQNGVWF3/jh+S9iI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=reBy1ebViOMaQljM7KHIgraI0U8rZEo7UwwC151M66REqhmmwGOfA9Nw0nwBE9hIWHCx1cLV02a2DvwOMN4YcAjr54G2l2WasVqjRlxESsSbhrfzGJVI5qPw7u2dqLLEuRb6wJCa9XP0FxGhmAF6VhE9L8zSx8MmQqMLlZB2+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGAt4/9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E4DC2BBFC;
	Tue,  4 Jun 2024 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523008;
	bh=JcC1v5BWR3/aIlXbMvxiyykfLTUcQNGVWF3/jh+S9iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NGAt4/9MoQ3AADgy57S1dDGgOpgjl4uVWGIzgaNz5ReBofop0ijw73bFpo5gR98qF
	 CvPSGCEku+NrJ+LAoiFaG3umsj7ojAuPmVV9mvyMvd53uEtYP6HBT21e034WKZzZo1
	 pT7k7x8Q28EiSk9xj2BxDfduF22g4hjx88kWNxTUUglSMDL5InDtwWdQOZnYfloWlq
	 0MLrrd+8tANmZZXjTPifJU2FtawybtBxhLc5weSA/2jWj1BJtYS65AOYOPutl0u6wy
	 eZ6VEz77CkW+huywzLbt78kvUoDMiDPOQn8Uo7d+X5F/rfFmDMBI+aweIJgWuoo/kw
	 IB2qtzrohV9Kw==
Date: Tue, 4 Jun 2024 12:43:26 -0500
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
Subject: Re: [PATCH v8 10/17] power: sequencing: implement the pwrseq core
Message-ID: <20240604174326.GA733165@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-10-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:18PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Implement the power sequencing subsystem allowing devices to share
> complex powering-up and down procedures. It's split into the consumer
> and provider parts but does not implement any new DT bindings so that
> the actual power sequencing is never revealed in the DT representation.

> +++ b/drivers/power/sequencing/core.c

> + * Unit - a unit is a discreet chunk of a power sequence. For instance one unit

s/discreet/discrete/

> +static struct pwrseq_unit *pwrseq_unit_incref(struct pwrseq_unit *unit)
> +{
> +	kref_get(&unit->ref);
> +
> +	return unit;
> +}
> +
> +static void pwrseq_unit_release(struct kref *ref);
> +
> +static void pwrseq_unit_decref(struct pwrseq_unit *unit)
> +{
> +	kref_put(&unit->ref, pwrseq_unit_release);
> +}

No existing callers of kref_get() and kref_put() use names that
include "incref" or "decref".  Many include "get" and "put", so maybe
there would be some value in using that pattern?

