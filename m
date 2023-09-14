Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5143F7A0B1D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjINQ67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjINQ66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 12:58:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5A1FDE;
        Thu, 14 Sep 2023 09:58:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C05C433C8;
        Thu, 14 Sep 2023 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694710734;
        bh=J+t2r+ePzfGQt3fwL5+MyIEONpo2I6s4CW1auZDcROo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iESROMHBOef+QHiL5hRx4ndTrHgHV54+0/DAnTLmcb//i9fqGsHIheUWWXnsP84wD
         c1nR3tEpcYSWcT70pDusNhGEbtXLEmiR5ww3I1vQ+H7dylx81O6z7jw4srpmk5QCjy
         pTGI8lfyKm9dqHssoqc4gpNZ8+4mRtJJV7+a1mLZTQ6eR5VGJPhq47KIj88zks5CLj
         j2vPqBQdnXTOaBhk238sRR7yjzWq+Usp4GdhNMV2QX7DIbB/B2hVU3tpOIKriIfnim
         85m0+jAwEC/VUSLBa5/5SXJU9swF7GIgGqa34DQU2GUvVXdm/S4MXIGaeHzvg8vgp1
         Z/Fp/fDSzv15g==
Date:   Thu, 14 Sep 2023 11:58:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230914165852.GA37731@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-17-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 06:32:16PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe, but this controller has vendor-specific
> registers so that requires initialization code like mode setting
> and retraining and so on.

> +config PCIE_RCAR_GEN4
> +	tristate "Renesas R-Car Gen4 PCIe Host controller"

The config prompt that matches the other drivers would be:

  tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
  
Similarly for the endpoint driver.
