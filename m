Return-Path: <linux-pci+bounces-42123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D1C8A69D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 15:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A0BC358B8B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E3303A20;
	Wed, 26 Nov 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ssx6gYoB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63309302CDF;
	Wed, 26 Nov 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168251; cv=none; b=D7K1kUMy2xVGiOaEWMOdFwE6z2VzLDdezaLXe2U/QGgFvqJg6WOPaM3v3oNT0gUEYtb/9nvPka7Jyyqc+IPNYxwTTYOYjwbT+7QrQY8kRB8FfM3SFVEhfsJNl6RqH+jPTlq8XVOgt3xw0CLkmnI5uk5ssTuAAVX18tO0aPrWj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168251; c=relaxed/simple;
	bh=CaXdK+vzZdACfgHpBANqiwt7O2iyXlQl5re8FsK88co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dBmJVFrcmOV0pg0/aWfTSZHnqWD/ZWGE3DQrOosCQziADs1Sat36on9v8qYAsPWDHcWusdkyuLVNloeugkm45vJfy+6GsgXDL/5w4nK9yZhFZ8anlUVjZ+ttUWwCEKf6+Ji8KuBv9MtWW/IbYVii6V090e5/b1SBtA88NUjbSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ssx6gYoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B8C4CEF7;
	Wed, 26 Nov 2025 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764168250;
	bh=CaXdK+vzZdACfgHpBANqiwt7O2iyXlQl5re8FsK88co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ssx6gYoBmcnMtyX1VwaoNqJ/PBMS9NEkbNm8RP2uOl0B6VQhn+duPP8p7OziVpHEH
	 /vGRvFBUrt850rzDHIUGr80SxUGHpLsDxFAoRPPhpUohkCcKPY6PTqUR6dHTvcKMJ1
	 LWqc7Ss/wSHgp4ffrVoTfYeCXo/Gj7CbRMJw56n+4vY1GZHXYtK/etbsRKR5kFepXG
	 zKERq7Bgc0TK9Narnaap9m6f4r+U+xKsEVt+GP8IPQ1uZtXZQVdehIDGDRWWRzMgMW
	 OyS+BRsc1fdQOJIEtq/keFqx1RVT/kPV5Vwv7CrzGwKusHR1myhZHVwnp0QZnHlqFH
	 65HLeFzy03sIA==
Date: Wed, 26 Nov 2025 08:44:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, mani@kernel.org, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
	lukas@wunner.de
Subject: Re: [PATCH v3] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <20251126144409.GA2825768@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126103112.838549-1-krishna.chundru@oss.qualcomm.com>

On Wed, Nov 26, 2025 at 04:01:12PM +0530, Krishna Chaitanya Chundru wrote:
> From PCIe r7, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> minimum amount of time(in us) that each component must wait in L1.2.Exit
> after sampling CLKREQ# asserted before actively driving the interface to
> ensure no device is ever actively driving into an unpowered component and
> these values are based on the components and AC coupling capacitors used
> in the connection linking the two components.
> 
> This property should be used to indicate the T_POWER_ON and drivers using
> this property are responsible for parsing both the scale and the value of
> T_POWER_ON to comply with the PCIe specification.

Add space before open "(" above and in description below.

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v2:
> - Move the property to pci-device.yaml so that it will be applicable to
>   endpoint devices also (Mani).
> - Use latest spec (Lukas)
> - Link to v2: https://lore.kernel.org/all/20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com/
> Changes in v1:
> - Updated the commiit text (Mani).
> - Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t
> 
>  dtschema/schemas/pci/pci-device.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-device.yaml b/dtschema/schemas/pci/pci-device.yaml
> index ca094a0..4baab71 100644
> --- a/dtschema/schemas/pci/pci-device.yaml
> +++ b/dtschema/schemas/pci/pci-device.yaml
> @@ -63,6 +63,15 @@ properties:
>      description: GPIO controlled connection to WAKE# signal
>      maxItems: 1
>  
> +  t-power-on-us:
> +    description:
> +      The minimum amount of time that each component must wait in
> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
> +      the interface to ensure no device is ever actively driving into an
> +      unpowered component. This value is based on the components and AC
> +      coupling capacitors used in the connection linking the two
> +      components(PCIe r7.0, sec 5.5.4).
> +
>  required:
>    - reg
>  
> -- 
> 2.34.1
> 

