Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C37F46DD46
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 21:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhLHUyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 15:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHUyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 15:54:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68666C061746
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 12:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05525B822BA
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 20:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E394C00446;
        Wed,  8 Dec 2021 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638996649;
        bh=cgGLauJN3WSyMttADxJC4UysVrmx7b6+FQJ2qOGZRX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r69E++mU1pI8Xd3veo2bc1L6mG2Ti5ny/ulxtYVWDLXrbMp2gbaLLGMGas7hQSvk6
         kudk/S2GYu+RtgdX8v627WQzDIF5+CR6eY+3bbfNxueq2KO9N00S3pVtAQvKfzN8eQ
         V/B8XVaJwnwIHmh9D/M/siOcTbNYIkPPJSMCWR7+1NzfaQ1G3bsWyvNqDTnkO1M3Wt
         kCcrKigr7+JhD7LJhPCo7letseiqoLklEuQkrJyzgCTH9kgHc9xGSRCCOebam5QKEY
         0jKfErqVy6yAX8B3BSGt7OyTqGUnQ4fbnlMNwrj9Yjxoal0/oBJn0YI7Uf8VlcWdtC
         abWghJhrUoc1A==
Date:   Wed, 8 Dec 2021 14:50:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/7] PCI: Prefer of_device_get_match_data() over
 of_match_device()
Message-ID: <20211208205047.GA153767@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 04:37:55PM +0100, Fan Fei wrote:
> Some drivers use of_match_device() in probe(), which returns a 
> "struct of_device_id *". They need only the of_device_id.data member, so 
> replace of_device_get_match_data() with of_match_device().
> 
> Fan Fei (7):
>   PCI: altera: Prefer of_device_get_match_data() over of_match_device()
>   PCI: cadence: Prefer of_device_get_match_data() over of_match_device()
>   PCI: kirin: Prefer of_device_get_match_data() over of_match_device()
>   PCI: dra7xx: Prefer of_device_get_match_data() over of_match_device()
>   PCI: keystone: Prefer of_device_get_match_data() over
>     of_match_device()
>   PCI: artpec6: Prefer of_device_get_match_data() over of_match_device()
>   PCI: dwc: Prefer of_device_get_match_data() over of_device_device()
> 
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 6 ++----
>  drivers/pci/controller/dwc/pci-dra7xx.c            | 6 ++----
>  drivers/pci/controller/dwc/pci-keystone.c          | 4 +---
>  drivers/pci/controller/dwc/pcie-artpec6.c          | 6 ++----
>  drivers/pci/controller/dwc/pcie-designware-plat.c  | 6 ++----
>  drivers/pci/controller/dwc/pcie-kirin.c            | 6 ++----
>  drivers/pci/controller/pcie-altera.c               | 8 ++++----
>  7 files changed, 15 insertions(+), 27 deletions(-)

Applied to pci/driver-cleanup for v5.17, thank you, Fan!
