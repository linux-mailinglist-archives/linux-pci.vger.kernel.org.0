Return-Path: <linux-pci+bounces-44464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB45D107D6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 04:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73B153051AE3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5392C21F8;
	Mon, 12 Jan 2026 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNs3vx4u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF71E51EE;
	Mon, 12 Jan 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188694; cv=none; b=PmNd7OAXuHbZklD6jE248xDnjfPjQC3U7grhcsrvLEO5kamFlsi2qLn/amkamBA9XWSIQ8aNVHbdQyQUiJYA1haUEG9hVULz5R15b9jMYdH4rgK3DCvI+78Y/HYZlrLBPSgcqeiQOEQxMrOx9ze74DOrLTS2MURl/A02xcVebxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188694; c=relaxed/simple;
	bh=5zRnw8qy9EVFkovIMnQ6/hMfleFrN9Z4/yTaiwb/CWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MlxE9Qflemo5A2/uxqska2NiAgU/eNFF/RsRDFEl8bxn1OJarym91ElhBXVTeRfuScBO4ucjiA0SfGlKzGbyPn7vs2qnXlR4meWwnOSHMSCcUJfTqtmJuCepsnyyuTVFN0t5tTMRdd3fkEdxVRv5fLvcVmVrid0mIeuAII7q92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNs3vx4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CBFC116D0;
	Mon, 12 Jan 2026 03:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768188693;
	bh=5zRnw8qy9EVFkovIMnQ6/hMfleFrN9Z4/yTaiwb/CWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JNs3vx4uhVwu9KE+aQfeCwT5PoPh8WPiuZyCbMf8MfZtaSsDADRzu5zWWCci6xKmh
	 BLvb+OzE7hbiVUicPQfDxzcYkPTKHXS3NtKoq3VP2GBj/7I9uT1nQqW3F8F2B3YlSB
	 u4D7BHRgJ3zH0XjrHtN+E5hn21q1cQWsUqoTsPGZ/HM7rA+cN/DH8fnc6flgyEODOA
	 vAuA0l0NCoWoqKksaTp8FUWGLkuCPG7oId0HGPZ55ufrbo9OZhLB30krAxRdOzU1oX
	 jjOhXNxyM7sSScirFjdRJdNInbIAa18OqHTmbo5tEYE+LhJzVHdhkBb5lUxIKkkqK8
	 JMsqkG5AHh2rw==
Date: Sun, 11 Jan 2026 21:31:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <20260112033132.GA696007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>

On Mon, Jan 05, 2026 at 07:25:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series provides a major rework for the PCI power control (pwrctrl)
> framework to enable the pwrctrl devices to be controlled by the PCI controller
> drivers.

I pushed a pci/pwrctrl-v5 that incorporates some of the comments I
sent.  If it's useful, you can use it as a basis for a v6; if not, no
worries.

Bjorn

