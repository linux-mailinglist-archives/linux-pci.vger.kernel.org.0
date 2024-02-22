Return-Path: <linux-pci+bounces-3902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B260B86073D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 00:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E41C21B93
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BE9140372;
	Thu, 22 Feb 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwVwDGWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9C140362;
	Thu, 22 Feb 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646206; cv=none; b=beAas/wX7DQYyqSvWehvRRNSZ1gyGvKLWKoa7A0kIE/qiEtft69vV3kCESrhOE/xQ/sl31cGNZZXxBYZi5wrdFsVepDYRiesAyZ9W1eMnUdeOvVl5H6X/mdq/eKsD3Wo8EuH25lWF/m1LPrsjx5Pzr6BNM2eWPr1O+7e7hGHw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646206; c=relaxed/simple;
	bh=LT7juKYEp/f9qDdcPqJbGxaoih0K5Y+y46uk9wz7+VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5f6ML4zKljqf3oY9ES1XlBlWi8Nyj2Is6yt7IMd/pajQHuL+NAFubbptuH2yI/7bmXlkOndbEvyxBfLdsUahWYMJMJUUJtmoOlatPZz+xvafpd0N4kRo/Gkhscn3zziQmffzhU1MClRPAUpLRkVvooGXQnCQ1gXlenvl/yuwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwVwDGWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C2AC433F1;
	Thu, 22 Feb 2024 23:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646206;
	bh=LT7juKYEp/f9qDdcPqJbGxaoih0K5Y+y46uk9wz7+VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwVwDGWIlGDmjoUCNCnCFjCexY9JD7sAHDcwAtfbLFz/EfjD4Dl7h8NdQCK9HF6mm
	 WhoyA8k+H+L9QUxdt1OIbqcKsqhnbommtNHEnyitbUj56o2OnxuWqZlEa9wclisnJ0
	 IGjdNMZexcOyHDpi32KWAqKbN1H3rhJe7I8e7/NZ0Be6SPEtLrTkvVoHC0buJQy8Tj
	 ei5CO8qRI5ijGU/ATAl7SfnYIvqxoT3/hjpi/Xyde8bwQMtoGD1PZZlgO3WWbMy/Ur
	 FUte7UJKB5pU8XI0WfH0bfoE0OEeKaE1jPVkYTMohF1FiO6v9lxlsl1gusSdJTLFy1
	 sYfmPdRpgPiuw==
Date: Thu, 22 Feb 2024 16:56:42 -0700
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 06/18] dt-bindings: new: wireless: describe the ath12k
 PCI module
Message-ID: <20240222235642.GA3830828-robh@kernel.org>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-7-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216203215.40870-7-brgl@bgdev.pl>

On Fri, Feb 16, 2024 at 09:32:03PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

s/new/net/ in the subject.

> 
> Add device-tree bindings for the ATH12K module found in the WCN7850
> package.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../net/wireless/qcom,ath12k-pci.yaml         | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml

