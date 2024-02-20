Return-Path: <linux-pci+bounces-3750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533385B5A0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 09:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382BD1C2278E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539235CDF5;
	Tue, 20 Feb 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvRrnv1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C585A0E9;
	Tue, 20 Feb 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418540; cv=none; b=HwBMrZAN0bgCLqBZCelZBsEZ20u/EGgYyJoe3rPwpvi0W1ykJBYabHZOMUddQKLO65YLP00KUO3/ni4dhiWj+QIyqIoz1f2F4Pv/HmZv32a5+YAExSgIHEfa3ntJvLQo5gJa6lUGPE+p3KF19ISnfZltjJv5xmfOEQRFP0Bp7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418540; c=relaxed/simple;
	bh=Fs5/rbAElEAfIede4OYqsYTavZtu15762Va+NBHML18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVi/cP5PJESzQk3rTZ6SJEIxw4asrqH/VdWfS3B5f5vUdDXBFACTW6at7ORpKnzsScvMTHcaqg3F3yOm6iMhF+sUH/pSpMOEfpzHXPLw/EvHNlvfJ9RP4AyouQx/BJicmPRriSWDE7Z7UUF4B+71d47w9K4yZCvo1laFyBAN9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvRrnv1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF5DC433C7;
	Tue, 20 Feb 2024 08:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418539;
	bh=Fs5/rbAElEAfIede4OYqsYTavZtu15762Va+NBHML18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvRrnv1vaO93pL8t5tolzacV6QkJ59bPs4hD2Oh/AGFUEGpUHPZ2TLteoVYjFuHgx
	 5jt7uNUw7sPxHv9WGZZU5yzeJafRq1X2P/0TBG4j92vGh0JRDGOZ8upVaR87ftJTkA
	 wS3odx0BJfSZgokJd3vuQcWQQFGh11enM1Y3g0coMcDaBLRQ96Xflv8vv/Qm9MU0Aa
	 JIp/2pQMYb408hVpSvdcKwWhXUvV2g3Nsw0TnZbBJnYoJjsrO7iX6UBiKM7b2RzbWp
	 3vh8bLHoLl4Tg/M561+cjBR191qh3PeIuOnEcsD4AVuc+fHO72v1+GRy9kguEXYIx1
	 Yi+wn4GUT5D3Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcLhh-000000002hC-1gp8;
	Tue, 20 Feb 2024 09:42:18 +0100
Date: Tue, 20 Feb 2024 09:42:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Message-ID: <ZdRl6fzEOQqkXqLt@hovoldconsulting.com>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
 <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
 <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>
 <20240216165406.GD39963@thinkpad>
 <ZdRXpQnbDbojlMkV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdRXpQnbDbojlMkV@hovoldconsulting.com>

On Tue, Feb 20, 2024 at 08:41:25AM +0100, Johan Hovold wrote:
> On Fri, Feb 16, 2024 at 10:24:06PM +0530, Manivannan Sadhasivam wrote:

> > msi-map-mask is definitely needed as it would allow all the devices under the
> > same bus to reuse the MSI identifier. Currently, excluding this property will
> > not cause any issue since there is a single device under each bus. But we cannot
> > assume that is going to be the case on all boards.
> 
> Are you saying that there is never a use case for an identity mapping?
> Just on Qualcomm hardware or in general?
> 
> It looks like we have a fairly large number of mainline devicetrees that
> do use an identity mapping here (i.e. do not specify 'msi-map-mask') and
> the binding document also has an explicit example of this.
> 
> 	Documentation/devicetree/bindings/pci/pci-msi.txt

The above should have said "linear mapping" as the msi-base is not
always identical to the rid-base, but you get the point.

Johan

