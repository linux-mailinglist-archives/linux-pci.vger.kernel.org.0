Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400586644FC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjAJPez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbjAJPeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:34:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716622616
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 07:34:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB1A61798
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 15:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD1C433D2;
        Tue, 10 Jan 2023 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364876;
        bh=6eMAM8CalZFNY38f3ldCsno9tHpWRfBLPgZ1YfpCMmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jscmkisDJxTebLylCVCm1Pb4G3WCpEwNFs8001RP3PCeo1eOo8bYHl2kVPjDjD7+l
         E5UXDQzwEdvYgZW6lXCJ5NSEDySgm2/FNsfYFwue2rMyslfKibqYdQ+gGr1EQhSRLd
         7RHjUf/O0ig8Fu9oF9evoswPGvrt+W9o99Kwa+x6qjBEGgmSqFf5YcUoTU4qwpUJSw
         3XYaJX5Vp6sVMnD2u61ZGVBqywHNQ02MfZvayXLNwolWaAeLrpZtU5n7NcfyaZVCHA
         az16CVt3ezyajpt8LDI8WAvzEo129fVERifXJYTZiENrHQ/BsJUTEhNI2WaxAWdvoo
         wGCYV5JcgOf9A==
Date:   Tue, 10 Jan 2023 09:34:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, mst@redhat.com
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
Message-ID: <20230110153434.GA1505598@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109080453.1155113-1-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 09, 2023 at 10:04:53AM +0200, Alvaro Karsz wrote:
> Add SolidRun vendor ID to pci_ids.h
> 
> The vendor ID is used in 2 different source files,
> the SNET vDPA driver and PCI quirks.

Nits: wrap to fill 75 columns.

> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b..9a3102e61db 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3092,6 +3092,8 @@
> 
>  #define PCI_VENDOR_ID_3COM_2		0xa727
> 
> +#define PCI_VENDOR_ID_SOLIDRUN          0xd063

This should be indented with tabs instead of spaces so it matches the
rest of the file.

It's helpful if you can send the patches in a series so the individual
patches are replies to the cover letter.  That makes tools and
archives work better:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.1#n342
