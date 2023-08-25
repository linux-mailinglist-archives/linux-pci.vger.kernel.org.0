Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96657881A1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjHYIJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 04:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243390AbjHYIJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 04:09:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E71FF9;
        Fri, 25 Aug 2023 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692950963; x=1724486963;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DDYB9hgCGLLt7dGj4L2dfzxCUOAizYUlniAtMkNplVo=;
  b=Kmuh6f5VF7GcD1ggRZEsQPgZZq7sab+TWO+eM6CMmNwG5s4r3Mf+4yP2
   cJOpjXNO9f+OGZO7zX+Hdy94SXbotyONO0onk7D+mFN5CJRE0EYEI1EQ5
   JTf4zTg1EMwHaM+UUSedbf8kQBnIlMeWZqK0+noDUm6W8IaNKMHzJqtWK
   Vr99XOaHLuE8GrJezaZdxRsJ+u1UbjBgkl30INvt/tSEhRR7lCmv3JCWF
   Qi54rieK03pooAyD0xWWRlOsi4UzY0j1l9s/r6oaXrVH41hzMfpaXiRQW
   kGa9tVLcMORUaErwiDSaDmN7J4rQq5NiDBEW3p06ZYk/BlDf8o7WpCT5G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="378446107"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378446107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860998431"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860998431"
Received: from enguerra-mobl.ger.corp.intel.com ([10.251.213.8])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 01:09:21 -0700
Date:   Fri, 25 Aug 2023 11:09:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 12/12] PCI: Simplify pcie_capability_clear_and_set_word()
 control flow
In-Reply-To: <20230824193712.542167-13-helgaas@kernel.org>
Message-ID: <8f5f10be-333a-9d88-7acf-1cbb2b11680@linux.intel.com>
References: <20230824193712.542167-1-helgaas@kernel.org> <20230824193712.542167-13-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1153837569-1692950962=:3206"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1153837569-1692950962=:3206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 24 Aug 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Return early for errors in pcie_capability_clear_and_set_word_unlocked()
> and pcie_capability_clear_and_set_dword() to simplify the control flow.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
>  drivers/pci/access.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 0b2e90d2f04f..6554a2e89d36 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -504,13 +504,12 @@ int pcie_capability_clear_and_set_word_unlocked(struct pci_dev *dev, int pos,
>  	u16 val;
>  
>  	ret = pcie_capability_read_word(dev, pos, &val);
> -	if (!ret) {
> -		val &= ~clear;
> -		val |= set;
> -		ret = pcie_capability_write_word(dev, pos, val);
> -	}
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	val &= ~clear;
> +	val |= set;
> +	return pcie_capability_write_word(dev, pos, val);
>  }
>  EXPORT_SYMBOL(pcie_capability_clear_and_set_word_unlocked);
>  
> @@ -535,13 +534,12 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
>  	u32 val;
>  
>  	ret = pcie_capability_read_dword(dev, pos, &val);
> -	if (!ret) {
> -		val &= ~clear;
> -		val |= set;
> -		ret = pcie_capability_write_dword(dev, pos, val);
> -	}
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	val &= ~clear;
> +	val |= set;
> +	return pcie_capability_write_dword(dev, pos, val);
>  }
>  EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>  
> 
--8323329-1153837569-1692950962=:3206--
