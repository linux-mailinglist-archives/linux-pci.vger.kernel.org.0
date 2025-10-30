Return-Path: <linux-pci+bounces-39811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84474C203DC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232DF3B6F56
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5F224245;
	Thu, 30 Oct 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXHYbnU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFB207A20;
	Thu, 30 Oct 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831145; cv=none; b=aONMKjWCdfH0CNpXBcPQPxk6YTiSAij7UiN5M4j27o6M4YheZpHQCOYbaKKLHo/+iIeUGDktAQSY6KxBcsaa8PmneTc4OfP/FKM9TPimOLEtmaX+F2kRqOyZ4FWysaHglMRZuWkcg+Vd7ihUBE1bK2a7kLmkZDZoJN2jHJzbETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831145; c=relaxed/simple;
	bh=snfS0RvToNjjO7M2g0HN8naHYIDMd18g7w7hv6lNcwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYm7mObem6QaIGHsntU0Fn7rtTVoKKojPyYGKiMrjw4RzS4q0Wf3C5p3f+oFJZVns+S1IFph25JYRjowqZGNm4PyTiiYpTzWiAm0/+e/5XBvdw2VGMVEtvlitJ+YEN5o8b2kI3uYiAdHDdmKXN65yuYrNtiguXpnMnm+CWkUA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXHYbnU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D97C4CEF1;
	Thu, 30 Oct 2025 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761831144;
	bh=snfS0RvToNjjO7M2g0HN8naHYIDMd18g7w7hv6lNcwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXHYbnU/NyuRTK33WjVmE0vtQzK0g4obffu7lr+7cCftrjlVEKw3UQ04NfdL+OfmR
	 +B1z4hKnLE2fJtJh3VSGSM3VswOezG4HsdulaKn+H4DoGXqOWFRGHN9FBxBzxa+h62
	 jav+lqui/aCIdcz/JAGXpT7czrFZUqXVMG7meuxAjSG6iiHcdDy2ufQ/oo3IjM9rcH
	 5OL5VVH6/xT/d9dKmU/WTSJUt5ckoiXsEnXd8A5CH/4GboXX5ySKPKOWOTu60I13ON
	 oElfd6GMn5apcD1VjdwfxmjarodQIm4RdhGc27zafx7OfDKQkzJMu/9+zLp0NZoEXN
	 fxROtimwAymng==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vESlU-000000002O7-0ZwE;
	Thu, 30 Oct 2025 14:32:32 +0100
Date: Thu, 30 Oct 2025 14:32:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/9] dt-bindings: PCI: qcom: Add missing required
 power-domains and resets
Message-ID: <aQNo8J1zcaeYaJiv@hovoldconsulting.com>
References: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>

On Thu, Oct 30, 2025 at 09:50:43AM +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Add also resets
> - Drop cc-stable tag in the last patch

The patches are identical and my point was that none of them need to be
backported (since they don't fix any bugs, just documentation).

> - Link to v1: https://patch.msgid.link/20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org
> 
> Recent binding changes forgot to make power-domains and resets required.

Johan

