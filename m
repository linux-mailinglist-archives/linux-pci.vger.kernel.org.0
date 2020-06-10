Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD31F4F72
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFJHqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgFJHqp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 03:46:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE35C03E96B
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 00:46:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so1092467wrp.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Awbgv42OMXGb6ctOD7E4FBtvK9ls7UGron4i9/J0u1w=;
        b=BptUjTfvTvB5LiiymmCDDSbS8OMNpZTb6zRCZtjzKJEyulu4PyOPyHpvfNYbD0fJBa
         SKgfne31eOEXdfN1GV/veMWiYl+cHbGK8Hy8oNUN54Br2HERl4B9nZMtawM3IBLcyWWy
         BuLB2yDdUkPCWL4zHD5C9x8YJjIQid97OrN/bIUPE6TUFaDCeYRc1RdQr3H+W3FW3St8
         SUGpW0OxDcSSLIdiBmUW6Nx4DZzrKTs4VDbxzBCEk59zUIFLD+Pv+PLA4g+8HuCFs21/
         QsauO9rl/YnIBk1eqhThpNCidjlBQVC7rV0oB614eZ+QEtCdI3JIbQCauFQIm4mfXoQV
         WcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Awbgv42OMXGb6ctOD7E4FBtvK9ls7UGron4i9/J0u1w=;
        b=FIYSoJuYip54WL7IfdT9dYMbY+DQPSN2zWq7hTxl+fL7mz8sRQs2XLs4uVGtNK8Qh1
         EagAlNwlnPl3xNub0SftetJ7UBNNgj7D8CEvHZMop2zVCX1wr37FMSPlux+uUoej3z4K
         mooIB6AyAuMmPL8rf8kLQd0gTSXqTFIYA7L0EEQsp/YnSgjqYuus0A+Ihvv130Tc8Ewj
         ipil+tyWJxsZOo7YAVXHb7xm0Ap1+TOZbf//bUivOQYU+r80faKS2SLMZyBBbFQ6xEHy
         4XLmfBrdiFzjxIAnmGUnAqS5YKvPmatkLoIIbLRgn4Is7Eey3gN8jmhDHt/GCiE6b5QG
         Jazg==
X-Gm-Message-State: AOAM533grEgYyicaXz1TdDxUJXk73NHRLNo9/Xn3abNxQvArLDx1cF2Y
        23mX/66/eYZnsMMj8En979/Jqw==
X-Google-Smtp-Source: ABdhPJzkV9QPPpMLfpxD7CIlFFiHZCG/SnoIDk6DQokkgAFu5bO6biRCrF7dhJ/EXug3tzFjbGxgqg==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr2129295wrp.370.1591775204095;
        Wed, 10 Jun 2020 00:46:44 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d5sm6908771wrb.14.2020.06.10.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:46:43 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:46:33 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kenneth-lee-2012@foxmail.com,
        Wangzhou <wangzhou1@hisilicon.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
Message-ID: <20200610074633.GA6844@myrica>
References: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 12:18:14PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI and have PCI cfg space,
> but are actually on the AMBA bus.
> They can support PASID via smmu stall feature, but does not
> support tlp since they are not real pci devices.
> So remove tlp as a PASID dependency.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/pci/ats.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f..8e31278 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
>  
> -	if (!pdev->eetlp_prefix_path)
> -		return -EINVAL;
> -

This check is useful, and follows the PCI specification (4.0r1.0
2.2.10.2 End-End TLP Prefix Processing: "Software should ensure that TLPs
containing End-End TLP Prefixes are not sent to components that do not
support them.")

Why not set the eetlp_prefix_path bit from a PCI quirk?  Unlike the stall
problem from the other thread, this one looks like a simple design mistake
that can be fixed easily in future iterations of the platform: just set
the "End-End TLP Prefix Supported" bit in the Device Capability 2 Register
of all bridges.

Thanks,
Jean
