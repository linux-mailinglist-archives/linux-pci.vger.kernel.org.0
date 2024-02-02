Return-Path: <linux-pci+bounces-2968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D96846519
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 01:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86911C243C9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A604C78;
	Fri,  2 Feb 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz1LoouU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2F3C23;
	Fri,  2 Feb 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834455; cv=none; b=LF65N9Nx0t0zF+ixjmnbzhD6ZweO1i0oiEs/MQHRDP/wE3aWPqw5KILv+RYpFK6L2lCyv46/43PgXHoUJRpUvpJLTC+cKcSu7E2cqZsBf3QCsF3ssTtI72iNl71rGlzihAdM63vG/StbfHMy+FtDMrMZA2+N7F5++qzPdCHnJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834455; c=relaxed/simple;
	bh=dLf5cloqiSaHlekbWkAHkgFrqJzKTS7rJSxj4m9pkNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI3xETHSpxpirktKonC4f186YIBKMx+Pewru366XT6MnTjFjyJUZJuMm8oxxgTtRXf37P8H8OdU/35BqTkBEuoMuHwUYw408VKsxK2BQr10DnJOO4HmkVy/SlMCbEEqQjqkd01qOqtGUi62a63Wu30GcNhwVgzTZkbOt0CAHuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz1LoouU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07665C433C7;
	Fri,  2 Feb 2024 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706834454;
	bh=dLf5cloqiSaHlekbWkAHkgFrqJzKTS7rJSxj4m9pkNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oz1LoouUgbOyVQzt99sDj3Ic+NNgrwdyDpyOTD7l77xb4miDPki4x6F9ZILOQ1tr2
	 EYTgfp6ytRYeXdDGPXAqK9+H3TFQDbgXqUvz7ktIe9pNyWzIaz+IHdTN+hox60Kpot
	 mwFTcdcq5zS9g8npvGMhtOMvGreSG2+P67MMjBzDu63iZXtlhuZKLWT3F909SacwCk
	 ZiXhvTWllzwJjXK3EMeD41FRTipnXYR2q+X7L8QqXHn15uctUMheaQ1wAaAP50dtQV
	 tPh1ZF3go10X2JZt9dXMoLQZ2m9exWq8p7gzzj548QxOA4vibe8X2csE5HFx5Hmmmz
	 8cIdJDEhS2j5Q==
Date: Thu, 1 Feb 2024 18:40:50 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 0/9] power: sequencing: implement the subsystem and add
 first users
Message-ID: <xdef5sjo5bvdvgx2ezgubeboos45mkeb2dcua63qhmztqrk6ja@m5ylrmdrwmia>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:23PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 

We now have 3 RFC and 1 PATCH versions of these patches on the list in
under a month. Please at least add a version to your subject...

> I'd like to preface the cover letter by saying right away that this
> series is not complete. It's an RFC that presents my approach and is sent
> to the list for discussion. There are no DT bindings nor docs in
> Documentation/ yet. Please review it as an RFC and not an upstreambound
> series. If the approach is accepted as correct, I'll add missing bits.
> 
> The RFC[1] presenting my proposed device-tree representation of the
> QCA6391 package present on the RB5 board - while not really officially
> accepted - was not outright rejected which is a good sign.
> 
> This series incorporates it and builds a proposed power sequencing
> subsystem together with the first dedicated driver around it. Then it
> adds first two users: the Bluetooth and WLAN modules of the QCA6391.
> 
> The Bluetooth part is pretty straightforward. The WLAN however is a PCIe
> device and as such needs to be powered-up *before* it's detected on the
> PCI bus. To that end, we modify the PCI core to instantiate platform
> devices for existing DT child nodes of the PCIe ports. For those nodes
> for which a power-sequencing driver exists, we bind it and let it probe.
> The driver then triggers a rescan of the PCI bus with the aim of
> detecting the now powered-on device. The device will consume the same DT
> node as the platform, power-sequencing device. We use device links to
> make the latter become the parent of the former.
> 
> The main advantage of the above approach (both for PCI as well as
> generic power sequencers) is that we don't introduce significant changes
> in DT bindings and don't introduce new properties. We merely define new
> resources.
> 

How can we tell? There are still no Documentation/dt-bindings changes in
your series.

Regards,
Bjorn

> [1] https://lore.kernel.org/all/CAMRc=MckG32DQv7b1AQL-mbnYdx4fsdYWtLwCyXc5Ma7EeSAKw@mail.gmail.com/T/#md5dc62007d12f6833d4e51658b14e0493954ba68
> 
> Bartosz Golaszewski (9):
>   of: provide a cleanup helper for OF nodes
>   arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
>   power: sequencing: new subsystem
>   power: pwrseq: add a driver for the QCA6390 PMU module
>   Bluetooth: qca: use the power sequencer for QCA6390
>   PCI: create platform devices for child OF nodes of the port node
>   PCI: hold the rescan mutex when scanning for the first time
>   PCI/pwrctl: add PCI power control core code
>   PCI/pwrctl: add a PCI power control driver for power sequenced devices
> 
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts  | 128 +++++-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi      |  10 +
>  drivers/bluetooth/hci_qca.c               |  30 ++
>  drivers/pci/Kconfig                       |   1 +
>  drivers/pci/Makefile                      |   1 +
>  drivers/pci/bus.c                         |   9 +-
>  drivers/pci/probe.c                       |   2 +
>  drivers/pci/pwrctl/Kconfig                |  17 +
>  drivers/pci/pwrctl/Makefile               |   4 +
>  drivers/pci/pwrctl/core.c                 |  82 ++++
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c    |  83 ++++
>  drivers/pci/remove.c                      |   2 +
>  drivers/power/Kconfig                     |   1 +
>  drivers/power/Makefile                    |   1 +
>  drivers/power/sequencing/Kconfig          |  28 ++
>  drivers/power/sequencing/Makefile         |   6 +
>  drivers/power/sequencing/core.c           | 482 ++++++++++++++++++++++
>  drivers/power/sequencing/pwrseq-qca6390.c | 232 +++++++++++
>  include/linux/of.h                        |   4 +
>  include/linux/pci-pwrctl.h                |  24 ++
>  include/linux/pwrseq/consumer.h           |  53 +++
>  include/linux/pwrseq/provider.h           |  41 ++
>  22 files changed, 1229 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/pci/pwrctl/Kconfig
>  create mode 100644 drivers/pci/pwrctl/Makefile
>  create mode 100644 drivers/pci/pwrctl/core.c
>  create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
>  create mode 100644 drivers/power/sequencing/Kconfig
>  create mode 100644 drivers/power/sequencing/Makefile
>  create mode 100644 drivers/power/sequencing/core.c
>  create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c
>  create mode 100644 include/linux/pci-pwrctl.h
>  create mode 100644 include/linux/pwrseq/consumer.h
>  create mode 100644 include/linux/pwrseq/provider.h
> 
> -- 
> 2.40.1
> 

