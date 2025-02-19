Return-Path: <linux-pci+bounces-21837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA5A3C912
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A147178867
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164222B8A2;
	Wed, 19 Feb 2025 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoYl5k9l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E01ADC86;
	Wed, 19 Feb 2025 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994565; cv=none; b=hNKtOAOL7qB+9qkB0mJwpgY1VGgFJqqwdFhqeLmhxoDcjC4aXMdRDMIxNmxFUw5MxvT9T/8p5KqoatftYpmxs3A+lrlHBQKOZYjMyZFalPjUx2qCxm+Kmol4taLgGu+qGR8xKK/zYGBlWtkIljvI9wAbqAortSAxUD2oVUplwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994565; c=relaxed/simple;
	bh=UYy/lu0qQ2sbGAMvLTq/G1MIeAdrMLKHu1KjRZuiZK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRGAS1Vpm4IcN5TjUDZ7o9xSoLTi9m/OT/90k+iFRYN1sueL1ghyKv6vwuYKrOZ75sbKHN6Wd/h0UfIaXBmpAP4/oTEGrNt+FA5AI9HTrj69458Agt0k1CsizUP89uuMwtBeDEagnLjCRX9IyFlbj/ODskyYocP6JyvB1I8t+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoYl5k9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2D4C4CED1;
	Wed, 19 Feb 2025 19:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739994565;
	bh=UYy/lu0qQ2sbGAMvLTq/G1MIeAdrMLKHu1KjRZuiZK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoYl5k9l2SDx44RekQuCJla114E3wfs6aYeD6rwHHgZtsjRe/9gxcKjKEqmqrzJXB
	 8neAg8ezfGb4OJyLGxOPOBsj6TTjq7EXlrnbrvImAs27D3UCfS4iQY58V9K1iPksXK
	 jQzJXMg5S5dbRX24Ws9ls9RdSlUNr7Qz/q3HFD0yvorBUyUoV1YalZO6B4ppru1MmH
	 Y9moeE0KUc5n1l9OPMM9aEWPZpU+PObBrSJj1sGQcPOgo5iBa1EhL9JsK2APaqA7EZ
	 OalRrjsOI4cf+L78KuEL3QflG0U1BabWgoAchX9IYy1AdMwH0voeU57ROxpgDjf7fm
	 pcbJpyISf6GuA==
Date: Wed, 19 Feb 2025 13:49:23 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, dmitry.baryshkov@linaro.org,
	manivannan.sadhasivam@linaro.org, krzk@kernel.org,
	helgaas@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH V3 0/2] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and N_FTS
Message-ID: <20250219194923.GA2776564-robh@kernel.org>
References: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216014510.3990613-1-krishna.chundru@oss.qualcomm.com>

On Sun, Feb 16, 2025 at 07:15:08AM +0530, Krishna Chaitanya Chundru wrote:
> Some controllers and endpoints provide provision to program the entry
> delays of L0s & L1 which will allow the link to enter L0s & L1 more
> aggressively to save power.
> 
> Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
> captures the N_FTS value it receives.  Per 4.2.5.6, when
> transitioning the Link from L0s to L0, it must transmit N_FTS Fast
> Training Sequences to enable the receiver to obtain bit and Symbol
> lock.
> 
> Components may have device-specific ways to configure N_FTS values
> to advertise during Link training.  Define an n-fts array with an
> entry for each supported data rate.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> changes in v3:-
> - Update the description to specfify about entries of the array (rob)
> changes in v2:-
> - Split N_FTS & L1 and L0s entry delay in two patches (bjorn)
> - Update the commit text, description (bjorn)
> 
> Krishna Chaitanya Chundru (2):
>   schemas: pci: bridge: Document PCI L0s & L1 entry delay
>   schemas: pci: bridge: Document PCIe N_FTS
> 
>  dtschema/schemas/pci/pci-bus-common.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

Rob

