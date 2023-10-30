Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17CA7DBF9F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJ3STc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjJ3STc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 14:19:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE698;
        Mon, 30 Oct 2023 11:19:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C231DC433C7;
        Mon, 30 Oct 2023 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698689969;
        bh=5GtnFYV8Mb6DhUTgqlJ5wPItxp7J5N0wGspvp9t5BJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QAXxk0e6C+CdyqyyGVNKLToY1jBNTNz2EMkp0XlwXRXV13xXz7N50L6oYNp+JLrgL
         aVfNgMmNOuXbHIuj6mHSXWQwet58Gq1bB6kub82ug2toudzl24AUPGkLlWiC0qzRRm
         ewn4gAsTEbRfTVqS4OAg9elTkegiC6SwTknuxnhuekAX10hQmI9f+nGEIIPLEZmzqf
         x/HYgDMQqk3Ph9QtoLNWKft8LDiaDFwQ4StLsaHJ7+1t9gF0feZu5QGLgy/xn1Qt4v
         IyouIIcda5LPpi1GJnG2PKePclJkaDK5eLvfNn/kEBBhZGzVW4rhy/m8WiR4A6gSVY
         nZ2ZpYZjvdFWA==
Date:   Mon, 30 Oct 2023 13:19:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: IOVA address range
Message-ID: <20231030181622.GA1878727@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQPn8uAWqR+0Qpk+Ua8gria06xx99ge5MnCGi4MwPOZNaXBvw@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc folks from ./scripts/get_maintainer.pl -f drivers/iommu]

On Fri, Oct 27, 2023 at 12:17:17PM -0700, Eric Pilmore wrote:
> Need a little IOVA/IOMMU help.
> 
> Is it correct that the IOVA address range for a device goes from
> address 0x0 up to the dma-mask of the respective device?
> 
> Is it correct to assume that the base of the IOVA address space for a
> device will always be zero (0x0)? Is there any reason to think that
> this has changed in some newer iteration of the kernel, perhaps 5.10,
> and that the base could be non-zero?
> 
> I realize an IOVA itself can be non-zero. I'm trying to verify what
> the base address is of the IOVA space as a whole on a per device
> basis.
> 
> Thanks,
> Eric Pilmore
