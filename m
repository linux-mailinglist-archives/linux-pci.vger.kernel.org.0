Return-Path: <linux-pci+bounces-20987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095AA2D07B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 23:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725C11889765
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 22:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E21AF0B6;
	Fri,  7 Feb 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfbRCUSJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC719CD13;
	Fri,  7 Feb 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967323; cv=none; b=ZfugSQwckQI2pcIk5ocUdId60QXNV7skvKh7VSoJxc2ITW6MboKHHLsmGLi3BeUyqhPgKeeQ7IeV8l68ag0dtmpQFzcSXWZtXr56wdI9ZtOV8yCAkdtN7HdqQSsa1dRvwixqvkHUEShIDsE5XmtKckx6DqtYjcTCq9uZDZKYn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967323; c=relaxed/simple;
	bh=y0lMlknWz7h6hi48vGEQ5WXn3IyNTFR6Jsc4G941ZaI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l4+OEXS6vdq4M3h5qAf+CoxC4oq9GgGZ5RSsaWocPs7SZh5JUfpodIdZMuf24RkooTdQ9CqapSg43KN0iA6b15ayo89qYDMpDDayZ+HAePGJgd4Dtr3QZaFC3tAu3HfhLRpR9KaYyRRZi3sToJCJD/hh43NDEonmvlaGeTvQC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfbRCUSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B622C4CED1;
	Fri,  7 Feb 2025 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967322;
	bh=y0lMlknWz7h6hi48vGEQ5WXn3IyNTFR6Jsc4G941ZaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hfbRCUSJVaelL0DjWFz/52IfumhZGHs2WxW8E629XPCB1nBRBLI3SCVnL4dTprfp3
	 g310+jH+owfkPwWDxS/zVVNAmOA4Csgn0GicfnZwcL0h7sORihso9+vDvKKGW6axll
	 TK3+9ESKXhAdjGFEApI2DHkmEZudwUM7gzm8/H8BkNhgwcVWNwni8ipiKaCvgOwkYZ
	 nW3hBn6VA552SAARFyLlJ5hKBSGu6hH4/56HDXz92IU1A72UZuOKN10BjMPmTcFL6h
	 bDw8Twa/uEwIDMCk/Q7BcHIL99sKjaGmoEoSM5mg/GNI4fcRVSHRDqe2L2E4SLg+Tx
	 HfuJBjpsoKUyQ==
Date: Fri, 7 Feb 2025 16:28:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: pci_ids: add INTEL_HDA_PTL_H
Message-ID: <20250207222840.GA1073192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207133736.4591-2-peter.ujfalusi@linux.intel.com>

Please update subject to match the history, e.g.,

  PCI: Add Intel PTL-H audio Device ID

On Fri, Feb 07, 2025 at 03:37:33PM +0200, Peter Ujfalusi wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> More PCI ids for Intel audio.

  Add Intel PTL-H audio Device ID.

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index de5deb1a0118..1a2594a38199 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3134,6 +3134,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
>  #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
> +#define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
>  #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
>  #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
>  #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
> -- 
> 2.48.1
> 

