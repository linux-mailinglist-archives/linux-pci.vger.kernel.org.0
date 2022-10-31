Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32913613C11
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiJaRXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJaRXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 13:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757513CD0;
        Mon, 31 Oct 2022 10:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F4D612B9;
        Mon, 31 Oct 2022 17:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC01C433C1;
        Mon, 31 Oct 2022 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667236983;
        bh=ScmmdwyqiQdKLoZ92qL0bWKIrLvraTkM/QJFOyeSmMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tFaXU/MiVvQnB+lGzG09terOKYtCHEbLksJ/UE3mc3Zwn1knmu3fUbP5Yy0OWgXb7
         xQk6RnB/YDeK7lASGEWQv5WE7YKqDlOOyrzzHaWufqPCaYEAuB+hPty+iV9Eb0B5AN
         VkUSDIcG7pWo13iLARxxUzgEOVHukuUCGUdtMtl0PUJeVDdK7vY+93Q2OW4tGX5e7k
         UORj22uoftym0YFax6QP+tIs2wL2z3v9gVc34yQDELXiPAQsO+kIOg6xByGEnHYlkH
         0jpT6wWe4QBwoCPM/Sbut4y+gx4pd658IOFUqFl+1iz02RrcavJCz5ff+Lrrb5p7qQ
         7i5eEyqP4s6lg==
Date:   Mon, 31 Oct 2022 12:23:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "sr@denx.de" <sr@denx.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ECRC configuration if AER is owned by the firmware
Message-ID: <20221031172301.GA1198954@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b3b790-dbad-0cee-bf45-fb2eefb947ab@nvidia.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 10:35:40PM +0530, Vidya Sagar wrote:
> Hi,
> With the top of the tree codebase, pcie_set_ecrc_checking() is called from
> pci_aer_init().
> This flow doesn't really take into account the ownership of the AER
> registers, and it makes sense in the case of the Linux kernel owning the
> AER.
> But, if the owner of AER is firmware and not OS, then, ideally, any
> register/fields (including ECRC bits) are not supposed to be touched by the
> OS.
> Is my understanding correct?
> If so, then, isn't the current code violating that rule?
> Could you please comment on it?

I think you are correct and the current code violates the rule.

Bjorn

P.S.  Your message was a multi-part message that will likely be
rejected by the vger mailing lists:
http://vger.kernel.org/majordomo-info.html

