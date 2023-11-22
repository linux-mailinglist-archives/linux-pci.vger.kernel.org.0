Return-Path: <linux-pci+bounces-81-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA207F3C3C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 04:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E13282912
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 03:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCA46BB;
	Wed, 22 Nov 2023 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4/Yf7yS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A223DC
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 03:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529A2C433C7;
	Wed, 22 Nov 2023 03:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700622973;
	bh=ePLe9bgDqiTHGtJaQqESyjhLlYLHPQWdLARWbT1o1Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h4/Yf7yST5ro60gdOVyydNZ92MqefAUbrzmUZFo1l2CUDHyhDeKtTheld79a1L7C1
	 XTpDu5lJCtHKbbK28W76Apwu3Mc/7Es+WsjsqA9Dd9LBr72NYO02BYyUlRKeZItIxR
	 fzTTOa+atqEjApRhRHMvigeKwbgXCOn4QIWUk+wnCtNXpbtPtpAh510pj5Xofez19D
	 rabAPw1b+niWwMLzwvIav1TRUIR2OTQYTdrC7tzSfrRMu/XOlJyl096XMi8wnwVlSW
	 zj3n0GgdbodxCivXYmyiY2Gwnp+IiWsomHe6HYNaMqavJuHECtp+BbMqwMiRPVtCRO
	 Azii4pWV0snMQ==
Date: Tue, 21 Nov 2023 21:16:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Stodden <dns@arista.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] switchtec: Fix stdev_release crash after suprise
 device loss.
Message-ID: <20231122031611.GA268086@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E3D7B584-12D8-4FFD-AF88-226921FCEE52@arista.com>

On Tue, Nov 21, 2023 at 05:02:22PM -0800, Daniel Stodden wrote:
> 
> I apologize for the confusion. 
> 
> Re-starting this thread wasn’t much about adding more reviewer names.
> 
> What I meant was what came out of his review:
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 073d0f7f5e43..b1990bde688c 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1387,6 +1387,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
> 
>  err_put:
>         put_device(&stdev->dev);
> +       pci_dev_put(stdev->pdev);
>         return ERR_PTR(rc);
>  }
> 
> 
> I probably should not’ have put that patch fragment at the far end of my email, past the signature.
> 
> If you prefer a v4, I’ll make a v4.

Yeah, just post a v4 if you don't mind.  Another version is free, and
then there's no confusion about what you intend :)

