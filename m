Return-Path: <linux-pci+bounces-25175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F622A78FF2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF7D7A50E4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995623BD09;
	Wed,  2 Apr 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCSiD+8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F71DA5F;
	Wed,  2 Apr 2025 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600720; cv=none; b=DDg11f7UE+ZHLBAmrYbc6wYqs/FsBpnqKIiXMd6pUJHqkwYLujrW5DQvSUq8/u2j2bGoCzD+0AyomKg6L6zM0h7aTj9Pmpf3hzXInvf61JGj5zdfFO4tCTKCSaFuiahcY7XMs0CyOkfKdOXOqpEPGMT+s10wCq7QWbwNMpLVPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600720; c=relaxed/simple;
	bh=HXCreqJAX63x8U6Bhy46j1MYoKRw9NtzzLwUQO7Jr/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhW+2xSYx+W8pm8odFFl1LM/XXesssDlYNEj4W6122BJ8pA35IwfuJVbm9IqaRsblW80RNQ3ORQxO06FvVinlvhmq5ItjLfE6GNn481eN7N66W6UKkKv9Nlquw1+jZ8EeGk94edqgd9RiPAAfmxUhwlmgBnrjdp+/hkGmQvfK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCSiD+8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1B5C4CEDD;
	Wed,  2 Apr 2025 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600719;
	bh=HXCreqJAX63x8U6Bhy46j1MYoKRw9NtzzLwUQO7Jr/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCSiD+8TO/9SSfFvvMRxONjUAicpsAZKDVmz3Nxbc9P3DDZApmtdBpT5j87ZtGF9b
	 FNzJoCPvHXlh4U1lP5LwkIYziGScXZ/+0l2Y6yPdqmfCYqYS0c8Q+XikVnXVhtd8PB
	 9xwHVYBJdOGzuDBYlqoBs9gfiYVrbNENPvRH4Wq3/wsG+clWHoPW4QzVSxcTt5/Pox
	 JbqTHlhgUhCCjQyIAQEqRMGGakc9D7G9wBGrm0+473hpawBgk/HzYZFYaP5vDox7rR
	 aF0QefjpfSZSa7riQ+PiqvM0Kn10EWo2iTxUN5MWzDUvJFb02jaz45ieblqVS+uU2i
	 3see8FW1HgK0w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tzyCK-000000004q3-3BYa;
	Wed, 02 Apr 2025 15:32:04 +0200
Date: Wed, 2 Apr 2025 15:32:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: Kconfig: switch to HAVE_PWRCTRL
Message-ID: <Z-08VFPfepvJPV33@hovoldconsulting.com>
References: <20250402132634.18065-1-johan+linaro@kernel.org>
 <20250402132634.18065-5-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402132634.18065-5-johan+linaro@kernel.org>

On Wed, Apr 02, 2025 at 03:26:34PM +0200, Johan Hovold wrote:
> The HAVE_PWRCTRL symbol has been renamed to reflect the pwrctrl
> framework name. Switch to the non-deprecated symbol.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I forgot to add Mani's and Bartosz's acks here:

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Johan

