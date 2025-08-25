Return-Path: <linux-pci+bounces-34688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F998B34F2A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 00:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6557AC284
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BA2BE058;
	Mon, 25 Aug 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXk+meCU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25710211A35;
	Mon, 25 Aug 2025 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161797; cv=none; b=S9aRozkSgq5ZLW1mCSuHPdtxxpU4f7ufoltO9T/YYlKj357EURUhnW9QvujMztDLj82GtDfssittl/glmVNXn6nmg0TwRJpXHn9Q1cphW1rHBQMJM5VR9dw9EyJi4zjBKQ9IIURa2VHs7pNY0YXbwWpO5j7NfgPoMmoiHSR76Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161797; c=relaxed/simple;
	bh=AyUN5Vep4hSDJ+K7OG6FuYEpjAcyxu18POCapEOdlpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er+yIb4msbyAHcymGdVqYTqa6JkfcTmwkkAsO9Dn6wDQxXd0UFm/X576Eb7tjPGnKqCMWu/l/joW7NzlquG74HislkSIaEqsT5p7f7rTpSiie1cz9ecWC7mHWrnHQo+rNOzNSzKaaWN0dU1aY1eJbj+GUNbqyIn+Gqyfw8Tqbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXk+meCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0CAC4CEED;
	Mon, 25 Aug 2025 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161796;
	bh=AyUN5Vep4hSDJ+K7OG6FuYEpjAcyxu18POCapEOdlpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXk+meCUXk+f1tu1W8X6jg+IiC79kC1SEjDMvtGbLyy9JvTnSo2E3z2iWiBnF56Y8
	 OBTxoxuixcRUfcL/x1lwT6uk8j7vOmt0ZVuzZXZqzoS3+HEHAWl2AA27p6TOQewaLL
	 YUtFPY8dheCJNidF9h/V7tqEuRwNtNy+y56FgV0ZnS1j1PQFMZ/2kk+Ftgf5YdlU+N
	 SWHDPuE4/Pgjz8jWmFn7DPqHtwyCMiZtYE15Gh7CVr4KECYR3BTosgglplTy5k8MhN
	 ffGqQaOPkIkk3fE1E8zpAFjB+Hsy0O4Wj9pXznvF3IqhovD25RbHI8wGb28RnKTLwY
	 h+X5RSN8jVnDg==
Date: Mon, 25 Aug 2025 17:43:15 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device
 node
Message-ID: <20250825224315.GA771834-robh@kernel.org>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
 <20250822135147.GA3480664-robh@kernel.org>
 <nphfnyl4ps7y76ra4bvlyhl2rwcaal42zyrspzlmeqqksqa5bi@zzpiolboiomp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nphfnyl4ps7y76ra4bvlyhl2rwcaal42zyrspzlmeqqksqa5bi@zzpiolboiomp>

On Fri, Aug 22, 2025 at 07:57:41PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 22, 2025 at 08:51:47AM GMT, Rob Herring wrote:
> > On Tue, Aug 19, 2025 at 12:44:53PM +0530, Manivannan Sadhasivam wrote:
> > > Bus:Device:Function (BDF) numbers are used to uniquely identify a
> > > device/function on a PCI bus. Hence, add an API to get the BDF from the
> > > devicetree node of a device.
> > 
> > For FDT, the bus should always be 0. It doesn't make sense for FDT. The 
> > bus number in DT reflects how firmware configured the PCI buses, but 
> > there's no firmware configuration of PCI for FDT.
> 
> This API is targeted for DT platforms only, where it is used to uniquely
> identify a devfn. What should I do to make it DT specific and not FDT?

I don't understand. There are FDT and OF (actual OpenFirmware) 
platforms. I'm pretty sure you don't care about the latter.

Rob


