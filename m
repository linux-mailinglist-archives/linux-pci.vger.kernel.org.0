Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46E60F7CE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiJ0Mpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiJ0Mpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 08:45:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1394F1A4;
        Thu, 27 Oct 2022 05:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A19CB825F5;
        Thu, 27 Oct 2022 12:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9655C433D7;
        Thu, 27 Oct 2022 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666874736;
        bh=RJKE7M5dZC88TU9qJJxzSW1KS6RBxmQrxZKkbCKINqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppi3eYjvIw8KrDaLRQqt5z6jJzhffW6A/u0hioVzzjv7VSgO/YkDPFM6S06U6iPGt
         hU89/Fxk85aAQjzbOo0h0zNyEG99aRKPagbBQqQmiUCGhF5TpFdIYzvrp6uKFQR/pG
         wbEyHkZ6M7LMAvLx7EPa8bs66vMFrXwuwkDKl9WnOu8S0q2SSsUIJbM6AlwWJ4qJYW
         9JQMeFdIaNJWmJWrlPPlX1qN2KckAuNPfO8+uwxSoJEZze8jchMp22Aq9iJ2NICglo
         8OMSMzHm2EsvylOJND9jar8gqDG+nANIALHFyJMIWF9Mf+pm10zBnbFHACu3rXAUFL
         i7528wNKbuDPA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     robh@kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        bhelgaas@google.com, kw@linux.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, sagar.tv@gmail.com,
        mmaddireddy@nvidia.com, linux-pci@vger.kernel.org,
        kthota@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 0/2] Disable PTM for endpoint mode
Date:   Thu, 27 Oct 2022 14:45:28 +0200
Message-Id: <166687471266.840928.362042718229372032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919143340.4527-1-vidyas@nvidia.com>
References: <20220919143340.4527-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Sep 2022 20:03:38 +0530, Vidya Sagar wrote:
> This patch series contains patches to disable PTM for endpoint mode
> as the PCIe compliance tool requires the PTM be disabled for the endpoint
> mode.
> 
> Vidya Sagar (2):
>   PCI: Add PCI_PTM_CAP_RES macro
>   PCI: designware-ep: Disable PTM capabilities for EP mode
> 
> [...]

Applied to pci/dwc, thanks!

[1/2] PCI: Add PCI_PTM_CAP_RES macro
      https://git.kernel.org/lpieralisi/pci/c/e32e1e26c409
[2/2] PCI: designware-ep: Disable PTM capabilities for EP mode
      https://git.kernel.org/lpieralisi/pci/c/442ae919e6ca

Thanks,
Lorenzo
