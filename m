Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3D75282D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjGMQSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGMQS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 12:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFB52726;
        Thu, 13 Jul 2023 09:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0748160A70;
        Thu, 13 Jul 2023 16:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214DC433C8;
        Thu, 13 Jul 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689265104;
        bh=M5KNkk7y8WRgRwNkixhnaGSx2aVsqh4lnrhxGKhe8mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lOyqGAr/LKuO0I7KVPy5t5cFIU2CVAi1pJixGngkGfDTAy1nbCGXfUUxp5ny3Z2wq
         etnzslBN1vsOYYw4n00a1ACFW+ZUlcg8bHrBT3ty1UDExp2750/CxehRYiTlnSTKVr
         HRMGMXSsflhd0L+82+0qWqY4ookgyK5pccLTxsl4ctx0JHrU9nMtfV3zLqAhh4pGtY
         4CWRZLOlEiLSrViTx3hLqbu1u7Ba00DAeZlou8hMIpRhhpD9pAJLhi2wxUN6VkTPqn
         Y+qkmsVM73/9QGntMQbBs2XJum1IRyjEboJSF3OVzN/g6LyA8RShq9toiIZ6jbUHzb
         C37Au2fkQ2ymA==
Date:   Thu, 13 Jul 2023 11:18:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
        Oliver O'Halloran <oohall@gmail.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Remove/unexport error reporting
 enable/disable
Message-ID: <20230713161822.GA320898@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710232136.233034-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 10, 2023 at 06:21:34PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_disable_pcie_error_reporting() is unused; remove it.
> pci_enable_pcie_error_reporting() is used only inside aer.c; make it
> static.
> 
> Bjorn Helgaas (2):
>   PCI/AER: Drop unused pci_disable_pcie_error_reporting()
>   PCI/AER: Unexport pci_enable_pcie_error_reporting()
> 
>  drivers/pci/pcie/aer.c | 15 +--------------
>  include/linux/aer.h    | 11 -----------
>  2 files changed, 1 insertion(+), 25 deletions(-)

Applied to pci/aer for v6.6, thanks Christoph and Sathy!
