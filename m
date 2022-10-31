Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A52613985
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 15:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiJaO7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 10:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiJaO6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 10:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C461007E;
        Mon, 31 Oct 2022 07:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F40D6129A;
        Mon, 31 Oct 2022 14:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE66AC433C1;
        Mon, 31 Oct 2022 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667228331;
        bh=VaFf9tn+Bj0AffYRxXpHKMYUAVZ3jvNp9khf7/eIj24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m0oC/WdNyXKCfl5xqM9xBJt4vJJCJgosb4xIb2MtWYcGkD5Vl6DyhRrbydzdy8s0i
         2WyNWIKZfbyJp0rPGezfb0vw9uNyaxXGC1OK2TNIWizYuVq/gt/q3o0Yuj9r91KS1b
         mpRCSsjseZkDNVoTj2WCAAd3VvaN1QlHx4EFnz4wIQgTMgxW9pLnFRIPtCRRc50eps
         9F5KEE/qW+l6JOTz5mchHA8Yp8hU3EHTNomiuRUomlK+ijrzqnukluBei5idJglt6I
         jcJTHy/VocDhRFT9yEW1PagzyA85LOBrxUGrOCqiTN4PyqVzfeY+Ni1dFrobCcYXRN
         G3S5Ybm76hTMw==
Date:   Mon, 31 Oct 2022 09:58:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
Message-ID: <20221031145849.GA1094273@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4b4099.3628.1842d4c7cc5.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 05:08:18PM +0800, Slark Xiao wrote:
> At 2022-10-29 00:06:21, "Bjorn Helgaas" <helgaas@kernel.org> wrote:

> >I think the best thing here would be two patches.  One patch would add
> >PCI_VENDOR_ID_THALES to pci_ids.h and also add a use of it in the MHI
> >driver.  The second patch would do the same for PCI_VENDOR_ID_QUECTEL.
> >
> >Then each one is logically self-contained.
>
> I must make sure these ids are applied, then I could commit the
> changes in MHI driver side. Otherwise it will cause build error.
>
> So I combine QUECTEL with THALES as a single patch. Shall I separate
> it from each other? 1 for PCI IDs, and another for MHI change. It
> would be better, I think.

Make two patches:

  - A single patch that adds PCI_VENDOR_ID_THALES to pci_ids.h and
    also adds a use of it in the MHI driver.

  - A single patch that adds PCI_VENDOR_ID_QUECTEL to pci_ids.h and
    also adds a use of it in the MHI driver.

That way there's no possibility of build error and no need to
coordinate patches.

Similar previous work:

  https://git.kernel.org/linus/fae74feacd2d ("hisi_acc_qm: Move VF PCI device IDs to common header")
  https://git.kernel.org/linus/d3826a95222c ("nfp: add support for NFP3800/NFP3803 PCIe devices")
  https://git.kernel.org/linus/4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")
