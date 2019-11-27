Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5F10ACD4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 10:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfK0Jsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 04:48:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK0Jsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 04:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P/yUKvXVbQkE33SlewRoaK2e7mxmW3hqYImnmOVQTMY=; b=nnf/Dbqtyj/YKaXQc9zwfbcXT
        fYQkrY7TWnYTbcYlq8kmwqWaBuLTFhEPhEVKOakSb87v9aO3PyyDQmfbauQ0PY+L8pl0UcltCkDSl
        YrzIOXfxnl5MC9pofSy5LUch4BKNXlkOkaZDJ87irhNSqb5w0ZG2SQv/N56cF3o1jvDk6KGczNr4y
        /yfAcby9eY7zR0Bndxb8sEROZ6jAOG3Z96f4LgZ7DZi7HhRhp1QIeCQC5ThuDbIX6e/lUj0NANUvQ
        s8Dp6ePSDnTsxWF1Ycm5CPb/oayT6G0zgibpPd3+uTug98BOMc2VmttRSazO7k9vMtQGKo6n9vTjC
        wGWqZ2VJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZtwC-0006qV-2H; Wed, 27 Nov 2019 09:48:44 +0000
Date:   Wed, 27 Nov 2019 01:48:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        bhelgaas@google.com, kishon@ti.com, thierry.reding@gmail.com,
        Jisheng.Zhang@synaptics.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 1/4] PCI: dwc: Add new feature to skip core initialization
Message-ID: <20191127094844.GA21122@infradead.org>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113090851.26345-2-vidyas@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 02:38:48PM +0530, Vidya Sagar wrote:
> +	if (ep->ops->get_features) {
> +		epc_features = ep->ops->get_features(ep);
> +		if (epc_features->skip_core_init)
> +			return 0;
>  	}
>  
> +	return dw_pcie_ep_init_complete(ep);

This calling convention is strange.  Just split the early part of
dw_pcie_ep_init into an dw_pcie_ep_early and either add a tiny
wrapper like:

int dw_pcie_ep_init(struct dw_pcie_ep *ep)
{
	int error;

	error = dw_pcie_ep_init_early(ep);
	if (error)
		return error;
	return dw_pcie_ep_init_late(ep);
}

or just open code that in the few callers.  That keeps the calling
conventions much simpler and avoids relying on a callback and flag.
