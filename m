Return-Path: <linux-pci+bounces-39901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCEC23D26
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7FC3A2293
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065720013A;
	Fri, 31 Oct 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwLpWJYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805C2DCF5B;
	Fri, 31 Oct 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899340; cv=none; b=s+lBkfDnBl+JwqNNZ0KbN8oLf7/EADw3sdlI4mx+DCPnrQKTnN4aGCyuhzf069d/kYk3NkoFZTqg6+4cIGSWPRoDc5stdEsQJXVItX+4GptSwp1vheA0gyh3Ccl12+L4KqCjkHxeG8jc+kBN4mZj1bk7fGY1Hzs38i3cV80Ls6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899340; c=relaxed/simple;
	bh=afPemIP1lycKeC+SVT8WBtBDzPqYgshUVvDunYHHjfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+hygHPRSsq+7tCAJU0lTFxgTfMn8EgjoJWpA7GS1VzdtOxtoj3/IiwLQZIsvpc5GFYBNY5RVpuA0ELH7vMTdh9QPx9Inn/ouwfdzwFfBge28mX/0Y+GDVOeKV5+2aICdjcRCt63/H+VaTlSXKkkh03P2bToG0xPjQsjaSu6AYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwLpWJYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC00DC4CEF1;
	Fri, 31 Oct 2025 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761899340;
	bh=afPemIP1lycKeC+SVT8WBtBDzPqYgshUVvDunYHHjfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwLpWJYBPs/1DcPMsrVRG7G8n9q5GH4Ud0bgdrs1UNQNT9bI0WTaWoCxOk3hBSTWL
	 d7ez5WxDXb56Bib8T1c4WNr8vyC1yxWIXvHd3tXIH5eKATEzTUebE/H1qk5sBdXz/Z
	 krt8XOLafocZyo01I3fW56Bmnjit/4zrQzXVOW5rcCcLipgbuvY3uJpuJ9vAY51Eoy
	 ssEAuagaFuEuecUEdAxpH0HjEGUT2iGs/e2Cpq0Nb9Y3kla3tOMNOy6evdBFGxAqQX
	 sw319HM+MBtH+jefLtFp6fTZE8oJPEPAxxuRNzS9wLa6952zu/ukGbmPUOIC4q8sQM
	 5+ojvEx3Y+9sg==
Date: Fri, 31 Oct 2025 13:58:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:PCI POWER CONTROL" <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI/pwrctrl: Propagate dev_err_probe return value
Message-ID: <j25yrjd2ximum4lxltlbfkwuv2bbpufkqeaqro36ptpptcwle6@ebjpicjf5ffb>
References: <20251018070221.7872-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018070221.7872-1-linux.amoon@gmail.com>

On Sat, Oct 18, 2025 at 12:32:18PM +0530, Anand Moon wrote:
> Ensure that the return value from dev_err_probe() is consistently assigned
> back to return in all error paths within pci_pwrctrl_slot_probe()
> function. This ensures the original error code are propagation for
> debugging.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/pwrctrl/slot.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 3320494b62d89..36a6282fd222d 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -41,14 +41,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
>  					&slot->supplies);
>  	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
>  	}
>  
>  	slot->num_supplies = ret;
>  	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
>  	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> +		ret = dev_err_probe(dev, ret, "Failed to enable slot regulators\n");

Again a pointless change.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

