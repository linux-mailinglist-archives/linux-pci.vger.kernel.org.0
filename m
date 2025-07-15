Return-Path: <linux-pci+bounces-32116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91275B05022
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 06:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A903A80FB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327FB2D3733;
	Tue, 15 Jul 2025 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K99vDCBP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B72D3728;
	Tue, 15 Jul 2025 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552323; cv=none; b=TrIxbQED8tLh0fVudxFhe9cFCJOHt8S+jPoud2wUpVAPg8y+hd4ttbZJzcwUktBzjgQqNdb8ncwzvYr/WfFjuj+VP0dI3Mu4JkLT+9aoHVkhAgvRqlQgIZ2BhkTNltIPx1Ip0s/mQX5by3Tz9FyFSFr9V8jXi4dOc7AZ33dt/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552323; c=relaxed/simple;
	bh=iFMMfPSoD1n2DPXVFl8J1DaftpkELhHD3mIta9r3dVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMCmXIi/kq4IqXK5Yj6LMBwamYED1UVLhUuPUtItnN5AkbEA6NV5aaCLY9OFIy9RRxHKLZhhS8cQoXkpybAfqW/ZWgbHO/F6llUDQ7zMOZ1nMiKwkj90Q0SQTvJr48UcjmikVyz42X/ql8iJA+hnEV0QN7YPzEleanMF517ljZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K99vDCBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1610C4CEE3;
	Tue, 15 Jul 2025 04:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552322;
	bh=iFMMfPSoD1n2DPXVFl8J1DaftpkELhHD3mIta9r3dVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K99vDCBP68Y7f4gY89Ja9IwjR44n70m9iYI+MsHPNuXlgvRIwAVPwTkDGhioksC15
	 LZ9LdNzHqBGmb4tD8aVNd3mjb2ZxZ352azgCyWwJ+lQldUxw3Oa8NZHNkB5TehghZD
	 FBoZA+zskf73JtiRcWpCudG2mpA/FaEaCPMrwFcfjARpjlGQ/TN+20pW7KJ0lrMl2A
	 2jCgajvWC1G4vblAUFmQoozlaSF1fpy2C6Bnuhgp9NqI4pn7BEDArk03G+WNZ2BG0K
	 Vceb1kdyb0a+Pmzvsun1oh8Ou3fVTZjoS0dbTPt1plqCV5WvaArXEbwobeFtSW+YEr
	 jQjR7mnkbZ2LA==
Date: Mon, 14 Jul 2025 23:05:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Toan Le <toan@os.amperecomputing.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 apm,xgene1-msi to DT schema
Message-ID: <175255232106.43576.10425019978348638150.robh@kernel.org>
References: <20250710180757.2970583-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710180757.2970583-1-robh@kernel.org>


On Thu, 10 Jul 2025 13:07:55 -0500, Rob Herring (Arm) wrote:
> Convert the Applied Micro X-Gene MSI controller binding to DT schema
> format. MSI controllers go in interrupt-controller directory so move the
> schema there.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../interrupt-controller/apm,xgene1-msi.yaml  | 54 +++++++++++++++
>  .../devicetree/bindings/pci/xgene-pci-msi.txt | 68 -------------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 55 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apm,xgene1-msi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> 

Applied, thanks!


