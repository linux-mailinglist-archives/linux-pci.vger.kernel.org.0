Return-Path: <linux-pci+bounces-14586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB699F7E5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43BA284011
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572051F582E;
	Tue, 15 Oct 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSVxLUjO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E51B3936;
	Tue, 15 Oct 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023102; cv=none; b=nhE/DZ07fc2r6n/09w5RE9a9dyVvHLK2v+UgzARaMPaPJyGm8xR5ZiKE0VGZt3GkJ/L/NJ/Rm8xCnu9et7NJiZtmF780/XZdhTEn9maLdiToAeial6hCvS68qj1tUlJ5ICeTZaq6bVkfY9sHvwFLW+clGZZQ0YnTcjWZRhJKMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023102; c=relaxed/simple;
	bh=ch+bU3YCeAL9AGC+OR03PPFSLvIjMObE1/y1gqTqgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bySBxFQuVypVo4Iw0/H5/4T8l4GQoJ7v7eDkK4X6LiO8uUFnxPBlzcrN8GRWaw3j18//3MVBCA15CXPey+wKWpOSqVIG7csiBylyxl+KgS0XTc5FVsa6PYMgW5eBbyEHot0JezUxhbQS733GKYxDhCovW8a8G4r7bktNsOE438o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSVxLUjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A02C4CEC6;
	Tue, 15 Oct 2024 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729023101;
	bh=ch+bU3YCeAL9AGC+OR03PPFSLvIjMObE1/y1gqTqgWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSVxLUjO5MT7Aro1Wr0ura4irHKfPboHSiKqyOHXoCK244uHQEeUNPNbReEGwD4Zk
	 2kRt8/kW2sWtNjKCd/zr06e9kn0nmT1kVnLcFSr4dfnkVAWp2HFjNcMwiHfEM9UYRi
	 XJ6E1Vq28LqsE+5r1PK/dOmfUyBEzL+IRFFxg7RL/kpMBNptnbBwAtS+tR/BORKV0X
	 uCXePKO8UfFVbMaQUIFebFM9ORBQws/657/ktitvK3xOBotlKPfoem6xoL/WLY8b1T
	 ok6kWPnBDE/HflRGWoVlK0NEdLMdJgRCeN48wzQ20KbfB8+vs9HAVn30yCfkYNk8R/
	 cjw2xUkE7Jlpw==
Date: Tue, 15 Oct 2024 15:11:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	devicetree@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	linux-kernel@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 01/11] dt-bindings: interrupt-controller: Add bcm2712
 MSI-X DT bindings
Message-ID: <172902309954.1771543.1322600375013063730.robh@kernel.org>
References: <20241014130710.413-1-svarbanov@suse.de>
 <20241014130710.413-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130710.413-2-svarbanov@suse.de>


On Mon, 14 Oct 2024 16:07:00 +0300, Stanimir Varbanov wrote:
> Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v2 -> v3:
>  - dropped '>' from the description entry (Rob)
>  - dropped interrupt-controller and interrupt-cells properties (Rob)
>  - dropped msi-controller and use 'unevaluatedProperties' (Rob)
>  - use const: 0 in msi-cells (Rob)
>  - dropped msi-ranges property (Rob)
>  - re-introduce brcm,msi-offset private property,
>    which looks unavoidable at that time
> 
> .../brcm,bcm2712-msix.yaml                    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


