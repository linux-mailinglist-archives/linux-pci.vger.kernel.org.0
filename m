Return-Path: <linux-pci+bounces-44109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E8CF89B5
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 14:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F0A303D161
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507F255F57;
	Tue,  6 Jan 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diDUsp3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58A2DEA70
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707162; cv=none; b=df/BUAB45QxCkmTz+zf3SXyjOYmXP9DcHKR7wWer2H5PmI0JCSlWOLZA9IWK7jtUGSB1f9YGatD4I9HXwH52dSm1KyjKhP/ZPxyeW1Lg2kXdnmsek/Ka4nrOorPnfHoCvrRicZKx06VUVzEwkygGzIB/OJtdGKKB/+RWEev3MMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707162; c=relaxed/simple;
	bh=vzdhfJRb/NEWPe9OQNZEg2hhlzRzCS/z3grDJ9+322Q=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1MjCM/JMkaKI+oYgnHuMMrgOc1smQ67hSPp+RalLz/upLy9W/vQgc87AhWAUh7zQO6hQO3iR7/+FkNCQGAm69XQmM1HSgkw3l+TAXiXZQue1SIrRfozLH+Bh8nZegRJLVwXE87gmiE5mdvMknjqnLxVkufJWBPSFgqgEex++dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diDUsp3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E3C19424
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767707161;
	bh=vzdhfJRb/NEWPe9OQNZEg2hhlzRzCS/z3grDJ9+322Q=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=diDUsp3f/+GnKMIZJssBcC6y5P8CHBwoCqJ6vbS2EHZ7D2J16wFBKand/ldnhJtfT
	 tXz+LPndVZU3bJl+ESzYp5NOkJyAWYBwOR9TFW/vsmmcuoSkK9pTZjSnZe3gXgfIJL
	 t5LcVv3V6oal2HgbKbIfcotGZtcV4/OihJ+octy+7I6OIPNFb5I3UmfxZv8DmniZbt
	 wzmgjOyNfi7t0+zA1iC9Fc8avaApEO6nJu3iwlv4YHVMc7t0HScNYb9lBX4OH1cs8V
	 etml84UrQjs3Dl2Zx7Uoo+6/2K/JhesCbeNb7Z7iTNT8M/vZfAxjirzJ4MgWdbfJvk
	 2il5u3PBUoA3g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b679cff1fso392814e87.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 05:46:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpr6LsyfC90qOZDX42b/xnaH+aJrTljVmxwJlFCy+B/waf53P7hmoTHPjDpcvQ1k6vEO6xYL89QRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83c9XAd8HGvorlkLZWF01ayLqN1yFPwkjp/M2FxIpGbEYWtyD
	sslMZqCbbNlnIA/fZaEOPprVEnr0yqv4HWpuO6+7qz+jGZnUwzhUYXI2EN84GKqX3dVOCFQG0p+
	hBp4GG9SGzTgTf++vztGkCiR+Nap3MTHFsdQQgBB5oQ==
X-Google-Smtp-Source: AGHT+IFuUBVzJhOvSBkhabTnRfCSxq9y4IZWaB8hriE4vmSSMkEBXOCUH+U1B+LTH/VhedFco9Pzr9/bl4SisPkcfgY=
X-Received: by 2002:a05:6512:32ca:b0:598:de1b:40e4 with SMTP id
 2adb3069b0e04-59b652b4065mr1055700e87.30.1767707160533; Tue, 06 Jan 2026
 05:46:00 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 07:45:59 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 07:45:59 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-2-6d41a7a49789@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com> <20260105-pci-pwrctrl-rework-v4-2-6d41a7a49789@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 07:45:59 -0600
X-Gmail-Original-Message-ID: <CAMRc=MeoZ-JdBBiy9Ddrx78NB3Bm+xfBqjqB--GXBR5+i_WBGw@mail.gmail.com>
X-Gm-Features: AQt7F2r19m_p9_pap1FMud7aAZPr1pnfDKx1w_5p9K05axcHgBG3gCo255deyOQ
Message-ID: <CAMRc=MeoZ-JdBBiy9Ddrx78NB3Bm+xfBqjqB--GXBR5+i_WBGw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}'
 callbacks
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jan 2026 14:55:42 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> To allow the pwrctrl core to control the power on/off sequences of the
> pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
> populate them in the respective pwrctrl drivers.
>
> The pwrctrl drivers still power on the resources on their own now. So there
> is no functional change.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

