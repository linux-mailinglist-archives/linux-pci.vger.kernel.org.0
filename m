Return-Path: <linux-pci+bounces-12633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 732AF968EEC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157341F23459
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1F1A4E9E;
	Mon,  2 Sep 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7E6mmhv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF61A4E7E;
	Mon,  2 Sep 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309934; cv=none; b=gPbqdoY/nuZ+7iBGGCLeELnoHz72Xmf7qGmp52CySQEDG7yhr2PBKWuEg9Nl/ADlnWVV7hez4w2RjYBFKKPs9KhFBQ6ysYFoS+KS21pu1imOvprpZo9iEyhqUi3shHYta3adFanfT/q1O2D+1P2HRCgb+lnqaGV48v5wdTlEIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309934; c=relaxed/simple;
	bh=Ff/z3qhnWcm7zLGLAOapgZII/W5Vo0cU9a5nmORcnu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YLlNy1+hiVU+jIWYA6PERzTxawLwDM2MY7H5YfNtUH4HRxL0irlrq0eylYAiSGt8A+20uHJcgq6MN8pXtcU/x9KmH0wd18XWcxk4KdTIyCH9S3QT/XZEpXLsJDlrwQlPiESuXNaZVR6C6ERagQkKmkN575l4TDmxGMPtZradAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7E6mmhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F298DC4CEC2;
	Mon,  2 Sep 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725309934;
	bh=Ff/z3qhnWcm7zLGLAOapgZII/W5Vo0cU9a5nmORcnu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X7E6mmhvnLiRwEX8jOwv9uaNA7WFssCE4DwyDFFIqhRALpLTadMvXSgSxOK412WuC
	 IQ8Mdjbfbsh4/3PamCXI5Tugrkp9HLlzt/3k1/0NENDWrmiarECR3Y0IZAMPZc/JYI
	 y2yy0JjUGpMykY3+UBJEQGJdDl94KsWTHi8cAYlkVRWiCchcjgOKh2Y+t9A6S9n8ka
	 B5KlsH3A2uZz3NufegrCENlEZeE3j6LgngOZmu4rbvm09/NcYjUTowRAd5krNGWZ1X
	 KyM8Iu5aOy88ON4GhGIhMFjKp/vkM6h/LeB9JHzP98tp8hrSEdgSsHN8yLQhsTaVej
	 5lfKgzpA7aPXg==
Date: Mon, 2 Sep 2024 15:45:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 10/13] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
Message-ID: <20240902204532.GA227089@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815225731.40276-11-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:23PM -0400, Jim Quinlan wrote:
> Provide support for new chips with multiple inbound windows while
> keeping the legacy support for the older chips.
> 
> In existing chips there are three inbound windows with fixed purposes: the
> first was for mapping SoC internal registers, the second was for memory,
> and the third was for memory but with the endian swapped.  Typically, only
> one window was used.
> 
> Complicating the inbound window usage was the fact that the PCIe HW would
> do a baroque internal mapping of system memory, and concatenate the regions
> of multiple memory controllers.
> 
> Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
> drop the internal mapping while providing for multiple inbound windows.
> This works in concert with the dma-ranges property, where each provided
> range becomes an inbound window.

Krzysztof, can you touch this up on your branch to s/SOCs/SoCs/ to
match other usage above, and ...

> +	 * The HW registers (and PCIe) use order-1 numbering for BARs. As
> +	 * such, we have inbound_wins[0] unused and BAR1 starts at inbound_wins[1].

Rewrap this to fit in 80 columns like (most of) the rest of the file
instead of 83?  I don't think we gain anything by being wider here.

