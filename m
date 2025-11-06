Return-Path: <linux-pci+bounces-40470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D042C3996F
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 09:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0D63BA011
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693E23054C7;
	Thu,  6 Nov 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkrFpF8R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0330274E;
	Thu,  6 Nov 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417818; cv=none; b=FWkfhfBXzS8Q5Gx3ZpIuOLBDlcCPwKk0fdPHdhnJGeUxRClogVbNj3V+tLU3eJuTzj5l9cPkNB8m1fLQ7Z8SGhycPY/8WK4IGSE9g2E2Ed8TRCNqJoZzcOCmx1eQ25ta2pLahH+NYsdwRkKPV8iUxCYVXjKBhdg3Wws7IP6FfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417818; c=relaxed/simple;
	bh=Ftrv5VuX0KTJ6Y75vcl+0ke3OVFcYfWC+jWlBD5cdk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzermgh2zEoKPtzgUrDbOcD1Sud2nN+eoewlR46tb52OXrX2/MCklP2fOs3M36zaHfjiwwB+DpJqh8Pk/mAsGl2nOKS4psaSIuvuDvopYJcm1pR/DtvEDR5dT1LhDDJq1uYiSaSnND83WWxUVByIuR+0zK/bxUUa9mMJkQ3c/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkrFpF8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E05C4CEFB;
	Thu,  6 Nov 2025 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762417818;
	bh=Ftrv5VuX0KTJ6Y75vcl+0ke3OVFcYfWC+jWlBD5cdk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkrFpF8RzslCd2MrwxHGpTvWokWV3g8YYoCwZcjZgf0kS6PJhA+2eHZdbxcAPFJH/
	 E/DZ0Icl49dYFQYzMEyEK+XdS/2IBasr2V+HWN3M6V15PU/+ljUwZ9r4ripGhRVPnW
	 ysDXPiepUiHXtAMlNJ0uX3ubKVaeI/c2mPSPgVvdPMSZXEyQjqUNxSSZIXMOBnraQR
	 OGX5zkycAUa1moTk5DdfuXxqfkKcHNCpMZ97Av2qQYfEbMi/yx0I4o3y4JtlvelqOQ
	 rjzt5sYuuLN/+y7HP6FWK8GWZUt1ROoWu7KQPX9ghGqS6gNy19Bbg2ZUl0VJfLlVHO
	 Y0YJGREKbvcYg==
Date: Thu, 6 Nov 2025 09:30:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>, 
	Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Andrew Murray <amurray@thegoodpenguin.co.uk>, Jingoo Han <jingoohan1@gmail.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
Message-ID: <20251106-positive-attractive-tiger-ec9c1c@kuoka>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
 <31271df3-73e1-4eea-9bba-9e5b3bf85409@linaro.org>
 <rguwscxck7vel3hjdd2hlkypzdbwdvafdryxtz5benweduh4eg@sny4rr2nx5aq>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rguwscxck7vel3hjdd2hlkypzdbwdvafdryxtz5benweduh4eg@sny4rr2nx5aq>

On Mon, Nov 03, 2025 at 03:42:58PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 03, 2025 at 10:47:36AM +0100, Neil Armstrong wrote:
> > Hi Mani,
> > 
> > On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> > > Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
> > > have region for DWC controllers as it has the Root Port and controller
> > > specific registers, while ELBI has optional registers.
> > > 
> > > Hence, fix the binding. Though this is an ABI break, this change is needed
> > > to accurately describe the PCI memory map.
> > 
> > Not fan of this ABI break, the current bindings should be marked as deprecated instead.
> > 
> 
> Fair enough. Will make it as deprecated.

The true question is what value was being passed as that item (ELBI)?
Because if this was always DBI - device has DBI there - then what
deprecation would change?

Best regards,
Krzysztof


