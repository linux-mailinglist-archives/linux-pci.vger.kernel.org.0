Return-Path: <linux-pci+bounces-44472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EEDD10FC7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35169304A8E7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19E3382F1;
	Mon, 12 Jan 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJMgws2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EE238C03;
	Mon, 12 Jan 2026 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204393; cv=none; b=JAyzmnVHLG1W98KQzhN5+vCvIEUd/tnYZ+Zhco/zGCtjZtr8E51A2R8Fv85J8shmnspVVKo5mIlHp64PkvgGviBodswXvTaVdae4AdpaZht1eKwkVuaDBGSTgevibj9wXmlE2IqTGB5eSuy6NPMluduFq0GuLCfDZyHYC5F19ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204393; c=relaxed/simple;
	bh=zP8EQaG8X8QyLdt7IzM2faLKiNBvW9+va0nL5ZeWmw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra04SbDkvJ9tzh+vOwcLXv121xHjh+OG0ieIUMi+whFaWww+tgPNGEt8y57RbxdHTDJ4aPD8+CXlM2VybKG7TStxKNtfQbMFYdbXwgZ0/grZyzA3RU+fw1PFg8alHYTAYq9fSwC7eK1U9Jv4o3+NL5dw533QOLZPjsbHJu0N+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJMgws2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87969C116D0;
	Mon, 12 Jan 2026 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768204392;
	bh=zP8EQaG8X8QyLdt7IzM2faLKiNBvW9+va0nL5ZeWmw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJMgws2KVJvH67HPWlEd283jP6WRenzThTQfLp8zw4Ry/BuaR8xqdlsa8hQUbkjn7
	 skb9C+lRngt/YzvG10ORy+awI4EjAECQ5Lfy9MrLvhVsuDtYYIkVdCWXhqfxFWorH6
	 ZJR2EbnsczkRftd9x1grbB+0mPx6C+RVrFMH1td4CgRJtsiO05cfFZl57zDG0Ar1af
	 d+3p9q99AOOmMaAQGTSoSD2ZUIL3xGp5tAt9MvvTG4VgfPMnsGzY93vtUxaAdNgGH0
	 3K5zBI+zssMCWG3Q+sOLlGzVQqZFlEqazUrObd+kXhL1IK5Bdf56tuPHWrLSBdjjVZ
	 rnLyabDo3QPFA==
Date: Mon, 12 Jan 2026 13:23:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <smxp3g5pveepvub3j2p7kvftnaza5ptuehmlvanhdamt46ugrb@hszfopsdzkgz>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <20260112033132.GA696007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112033132.GA696007@bhelgaas>

On Sun, Jan 11, 2026 at 09:31:32PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 05, 2026 at 07:25:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > This series provides a major rework for the PCI power control (pwrctrl)
> > framework to enable the pwrctrl devices to be controlled by the PCI controller
> > drivers.
> 
> I pushed a pci/pwrctrl-v5 that incorporates some of the comments I
> sent.  If it's useful, you can use it as a basis for a v6; if not, no
> worries.
> 

Thanks for making the changes, they look good to me. Do you expect me to send v6
or you intend to merge this pwrctrl-v5 branch to pci/next?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

