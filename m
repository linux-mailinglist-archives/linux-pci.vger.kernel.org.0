Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1A6723BE1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 10:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjFFIdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 04:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjFFIdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 04:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5D10CF;
        Tue,  6 Jun 2023 01:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C39F462EB2;
        Tue,  6 Jun 2023 08:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F83C433D2;
        Tue,  6 Jun 2023 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686040390;
        bh=CdJanuObyG6+eqgZzEAO/tzXt5ffnMV7P2BI90Gcpvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDdLrmSV9LfBnHd6snA/yb5534Bi1rCnmciko+Wv+s54pvS01FOSuG8oGomb3XEjF
         o6VGAziPMDOLOqRZ0DcvPZp3DoRNa2+n5Px2fAZXp5CxsPR/VzvDjGKfRju/nwcOKR
         m8ME+enGbPrSbizmMatlEpanUWerodvKKre5xb/eFFvAe2YdMe1c0YAWosYQG6a7gP
         nUsEdgkTx+GBYi1hkyd7Xg0Bsem6vJR2pdGH8KnbPwyiQtU3uscr4cYsm1i/rZmQtN
         k5JsfuVPa7m4hfifY78MqNZdAo+YUkgbZdgNmzUNHXr4gr04iARmhZ5pJDI15UWV3o
         QZBgFaCqUtV5Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kw@linux.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: epf-mhi: Fix the outbound window offset handling
Date:   Tue,  6 Jun 2023 10:33:04 +0200
Message-Id: <168604028639.57025.13332670969969616995.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606074657.31622-1-manivannan.sadhasivam@linaro.org>
References: <20230606074657.31622-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 06 Jun 2023 13:16:57 +0530, Manivannan Sadhasivam wrote:
> __pci_epf_mhi_alloc_map() allocates and maps the PCI outbound window memory
> to endpoint local memory. For taking care of alignment restrictions, the
> caller needs to specify the address alignment offset. Currently, this
> offset is not added to the allocated physical and virtual addresses before
> returning from the function.
> 
> But __pci_epf_mhi_unmap_free() function substracts the offset before
> unmapping and freeing the memory, leading to incorrect unmap and free.
> 
> [...]

Squashed it with the commit it was fixing.

Thanks,
Lorenzo
