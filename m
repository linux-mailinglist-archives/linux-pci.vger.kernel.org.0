Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5E7E42EE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjKGPLN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjKGPLG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:11:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0228271;
        Tue,  7 Nov 2023 07:03:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFEBC433C7;
        Tue,  7 Nov 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699369424;
        bh=J1vNjNieRJr3E7Lwg+K5Qxx5RI7TJ2qHL+YZr26NfxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pig9iQ0Vys09BIZmgBew6LN8vDcKe3GcGGIYTJJamHEEyxFXbP8Z7/2+gny8+h69u
         JCOgtmzAJ9J3SmfckMcRshTFehtjlWsZYVAQ4FUGXXgPAj3EVkCqCnlV+ZzFwppRUK
         iGRB1Olbq8qnf74R3xu1kkHrEPRLJ/57LKdoRVZ6SlhZmu1O0sblJexmJZFuesvNFm
         maqY4J5PBrozHw5JtfG62ZJp/7Cc93h8FPxVAmvZbN7Qo3DBVM70TcaEl7LjoHd1ok
         JfHWgCtuWizD+GGiaQuTJ1SAieXGrLlYA2k9FT+wjnIaJbQPPwYiwfapI0BBhOTSme
         js6E1Ac/iWm8Q==
Date:   Tue, 7 Nov 2023 09:03:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     kaishen@linux.alibaba.com, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 3/5] PCI: move pci_clear_and_set_dword helper to pci
 header
Message-ID: <20231107150342.GA288219@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104133216.42056-4-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 04, 2023 at 09:32:14PM +0800, Shuai Xue wrote:
> The clear and set pattern is commonly used for accessing pci config,
> move the helper pci_clear_and_set_dword from aspm.c into pci header.

s/move/Move/ (in subject, capitalize first word)
s/pci/PCI/ (capitalize in English text)
s/pci_clear_and_set_dword/pci_clear_and_set_dword()/ (add parens to
function names, also in subject)

With the fixes here and below:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/pci/access.c    | 12 ++++++++++++
>  drivers/pci/pcie/aspm.c | 11 -----------
>  include/linux/pci.h     |  2 ++
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 6554a2e89d36..526360481d99 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_write_config_dword);
> +
> +void pci_clear_and_set_dword(const struct pci_dev *dev, int pos,
> +				    u32 clear, u32 set)

Rename to pci_clear_and_set_config_dword() to retain the "config"
information and match the other accessors.

Align "u32 clear" under "const struct ...".  pci_write_config_dword()
above is an anomaly.

> +{
> +	u32 val;
> +
> +	pci_read_config_dword(dev, pos, &val);
> +	val &= ~clear;
> +	val |= set;
> +	pci_write_config_dword(dev, pos, val);
> +}
> +EXPORT_SYMBOL(pci_clear_and_set_dword);
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 1bf630059264..f4e64fedc048 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -423,17 +423,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	}
>  }
>  
> -static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
> -				    u32 clear, u32 set)
> -{
> -	u32 val;
> -
> -	pci_read_config_dword(pdev, pos, &val);
> -	val &= ~clear;
> -	val |= set;
> -	pci_write_config_dword(pdev, pos, val);
> -}
> -
>  /* Calculate L1.2 PM substate timing parameters */
>  static void aspm_calc_l12_info(struct pcie_link_state *link,
>  				u32 parent_l1ss_cap, u32 child_l1ss_cap)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8c7c2c3c6c65..271f30fd7ca4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1213,6 +1213,8 @@ int pci_read_config_dword(const struct pci_dev *dev, int where, u32 *val);
>  int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
>  int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
>  int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
> +void pci_clear_and_set_dword(const struct pci_dev *dev, int pos,
> +				    u32 clear, u32 set);

Align "u32 clear" again.

>  int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
>  int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
> -- 
> 2.39.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
