Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33F5EAFDD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIZS2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIZS1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:27:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2982E2E;
        Mon, 26 Sep 2022 11:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 632CDB80ACC;
        Mon, 26 Sep 2022 18:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89EEC433C1;
        Mon, 26 Sep 2022 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664216832;
        bh=h2Ceidh4tSheNB/iFG8vH+y4KkoBbzZ0Sz2+DSuNFes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EFwaq5e6kyYxw7NdRVhdeAoIoeUBhIC8dEO5QjM7ma9xwZglgTLAZVyBdrRMIDB4O
         i66g3Bl2DYYQROl4eU3RFKFT/rruZhTod5VQCTpAD2XUjTtq9HJfXHg+dMO8VJhenw
         nfXNGTjx1zNGrWOzFyZ5DZsosA/8VzL88H22+TFC/ZHncEyVAthohiOfppCJnk178h
         qwqFXwjf54siBevVXAcqpPXMXL13C5YPBjE5SB2GawA4HvikZz+vx5TBk7APtnSC8+
         887G58bOCXC8YGTV4CjhvmvmrRT5jVla3m4P6GBg2OrxLcPlI93rLvVG6PLHOKJyC/
         n5mjXoI+7wNPA==
Date:   Mon, 26 Sep 2022 13:27:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Add standard PCI Config Address macros
Message-ID: <20220926182710.GA1613197@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924092404.31776-2-pali@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 at 11:24:02AM +0200, Pali Rohár wrote:
> Lot of PCI and PCIe controllers are using standard Config Address for PCI
> Configuration Mechanism #1 (as defined in PCI Local Bus Specification) or
> its extended version.
> 
> So introduce new macros PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() in
> include file drivers/pci/pci.h which can be suitable for PCI and PCIe
> controllers which uses this type of access to PCI config space.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
> +#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
> +#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
> +
> +#define PCI_CONF1_BUS_MASK	0xff
> +#define PCI_CONF1_DEV_MASK	0x1f
> +#define PCI_CONF1_FUNC_MASK	0x7
> +#define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */

Since all the above are used only in the macros below, I personally
don't think they're really necessary and I would find it easier to
read if they were just open-coded, e.g.,

  +#define PCI_CONF1_BUS(x)     (((x) & 0xff) << 16)
  +#define PCI_CONF1_DEV(x)	(((x) & 0x1f) << 11)
  +#define PCI_CONF1_FUNC(x)	(((x) & 0x07) <<  8)
  +#define PCI_CONF1_REG(x)     ( (x) & 0xfc)

> +#define PCI_CONF1_ENABLE	BIT(31)
> +#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
> +#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
> +#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
> +#define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
