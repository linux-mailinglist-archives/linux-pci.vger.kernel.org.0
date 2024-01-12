Return-Path: <linux-pci+bounces-2079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1582BAC7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 06:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5581C24A13
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86035B5C0;
	Fri, 12 Jan 2024 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjBTAxtf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA4107A0;
	Fri, 12 Jan 2024 05:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B6C433C7;
	Fri, 12 Jan 2024 05:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036927;
	bh=ifdN4B+pmqVR9krEwjy+TBCKjrl03UbEPUOBKS60g8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjBTAxtfWw7YBVOK1kv7KGL+QojD+ZNNCfC50w9eDcqVISWxkKeUIO/eq4MqR8JKt
	 gGjEmlIt7WfoB5i48Yu85BgHIaWNQAlDEnmcQO0RN5D/NBR7NqF0Wpgl/8PDxjVZ8Z
	 b54vJVCXLqTGL8p1gMjXy335qXHDlItngySHzaDARbPL2h9/LBifT2qLrGHVrPoqQl
	 YgjhZkvkCgF0cqPwUwxDtOFfJDhDog23WOoNdLYCX9kDvc1cj6Jj33sKso7WrmpiRT
	 8zk6qgS9v1+86y5zGD7QQyiJr9Uxv+xqrLWl6KUdzg/V/NvTEK+mjELAjlU9acxdPx
	 auskB0TjZypQA==
Date: Fri, 12 Jan 2024 10:52:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix kernel-doc issues
Message-ID: <20240112052200.GA2970@thinkpad>
References: <20240111162850.2177655-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111162850.2177655-1-helgaas@kernel.org>

On Thu, Jan 11, 2024 at 10:28:50AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix kernel-doc issues reported by
> "find include -name \*pci\* | xargs scripts/kernel-doc -none":
> 
>   include/linux/pci.h:731: warning: Function parameter or member 'pdev' not described in 'pci_is_vga'
>   include/linux/pci-epc.h:154: warning: Function parameter or member 'list_lock' not described in 'pci_epc'
>   include/linux/pci-epf.h:83: warning: expecting prototype for struct pci_epf_event_ops. Prototype was for struct pci_epc_event_ops instead
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  include/linux/pci-epc.h | 2 +-
>  include/linux/pci-epf.h | 2 +-
>  include/linux/pci.h     | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb694031072..bfe41b03b70c 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -122,7 +122,7 @@ struct pci_epc_mem {
>   * struct pci_epc - represents the PCI EPC device
>   * @dev: PCI EPC device
>   * @pci_epf: list of endpoint functions present in this EPC device
> - * list_lock: Mutex for protecting pci_epf list
> + * @list_lock: Mutex for protecting pci_epf list
>   * @ops: function pointers for performing endpoint operations
>   * @windows: array of address space of the endpoint controller
>   * @mem: first window of the endpoint controller, which corresponds to
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 3f44b6aec477..92d0b71d33d7 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -68,7 +68,7 @@ struct pci_epf_ops {
>  };
>  
>  /**
> - * struct pci_epf_event_ops - Callbacks for capturing the EPC events
> + * struct pci_epc_event_ops - Callbacks for capturing the EPC events
>   * @core_init: Callback for the EPC initialization complete event
>   * @link_up: Callback for the EPC link up event
>   * @link_down: Callback for the EPC link down event
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a89dc66f89a..eb45087d7e00 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -715,6 +715,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  
>  /**
>   * pci_is_vga - check if the PCI device is a VGA device
> + * @pdev: PCI device
>   *
>   * The PCI Code and ID Assignment spec, r1.15, secs 1.4 and 1.1, define
>   * VGA Base Class and Sub-Classes:
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

