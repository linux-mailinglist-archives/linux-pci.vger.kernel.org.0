Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAA72CD4A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjFLRzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbjFLRzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 13:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C2134;
        Mon, 12 Jun 2023 10:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8F3623CF;
        Mon, 12 Jun 2023 17:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E585C4339E;
        Mon, 12 Jun 2023 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686592499;
        bh=Jxl4+pECrENNqefc129HxAm2rf1KjXkr/7bagYZpCbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YtjQlf/iUGGrI+k42+iVl3nWY1hQW5qcPGwAmz0h63uCG4Zj+xt6jhMd0ZoYdDMBD
         MTM//gSXiXWq5BVE+QQk1ulXSvXBIcbrPJqbIhat9fNN+uqxt66eBb53tlHad7EAEU
         jtVBa6m/jsNifdOG59PfaM9rB5to0fHvDI73uCVLlkgSCDGno/J0JGNB95r00cVZSg
         B9AOu6tvctU3UvuU6Pdxg/ollz4TSW8jvUnbx+1II4Oi6932b9u7Y4u4A4yMeyMB+L
         OGomH/IPhp3mk0Ayud6ngDTtKUuYYPkkv0XCTnGmpGukBU9+UBEAwD1AQG5rCpP89a
         pRARAPmbHUijg==
Date:   Mon, 12 Jun 2023 12:54:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 0/2] PCI: pciehp: Add support for native AER and DPC
 handling on async remove
Message-ID: <20230612175457.GA1342613@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf1d75d-feb0-c31f-a0cc-3c1c8ad99146@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 09, 2023 at 01:58:37PM -0700, Smita Koralahalli wrote:
> Hi,
> 
> Could I please get review comments on my patch set? I had re-based
> it on latest tree in v2 as I did not hear back on my questions in
> v1.

Thanks for persevering.  It looks like there may still be some ongoing
discussion with Lukas?  And a few of his comments that you plan to
address?  Thanks for looking into the 10-bit tag issue.  I know those
tag widths are non-trivial to handle correctly and it would be good to
clean them up.

Bjorn
