Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC918A6C6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCRVMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 17:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRVMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 17:12:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD2920409;
        Wed, 18 Mar 2020 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584565931;
        bh=JdPxj7772rqqL4deVazLX6+da+1KtQgThsGQGsgwdR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQz17JFV2M6Fp7E31D3nzmKhWstevjvKMkZK3JA9IYkqFTxJqguHPT1/mr2gzAjkA
         nkspGxEtbEDAwTFFhmdV85l00Ve3Q0tTAVw7npj2NU6UA8npzj5acUzSQIsi2MazJU
         NqLC9smeccOgDMGrBI2kE0vM6Qax0CxEhhnreSlE=
Date:   Wed, 18 Mar 2020 21:12:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: Re: [PATCH v2 1/6] PCI/ATS: Export symbols of PASID functions
Message-ID: <20200318211205.GA8477@willie-the-truck>
References: <20200224165846.345993-2-jean-philippe@linaro.org>
 <20200318183606.GA207832@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318183606.GA207832@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 18, 2020 at 01:36:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Feb 24, 2020 at 05:58:41PM +0100, Jean-Philippe Brucker wrote:
> > The Arm SMMUv3 driver uses pci_{enable,disable}_pasid() and related
> > functions.  Export them to allow the driver to be built as a module.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Cheers, Bjorn. I'll queue this series in the Arm SMMU tree.

Will
