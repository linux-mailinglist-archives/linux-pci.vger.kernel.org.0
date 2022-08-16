Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA2595CEB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiHPNM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiHPNM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 09:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F7B2DB1
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 06:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B94C61383
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED01C433C1;
        Tue, 16 Aug 2022 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660655575;
        bh=E1VGLwqZHyYyY/qgeCs2M61wWtiZCgbs/nRnxiFcTP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O14B+Jskb/4RhH+33PJ8UeVoUT2GV9LeRNdvW8z057+P5f8VXv0CskQVURolqI14V
         7PGs5JVHRxok3ESkb5gAzIQXmXH67N71b5llN8K+OEP2EB2i3VNgvkZ1QpoD9W7WZr
         VBZyNFg4XBJgd9ljn9pPuRhatSq8CQ6TFm1LhVin9AKz701X11KE/xNGTU0AKBTeUS
         85/cLgbOlGLe5KvgOirmRytzK7ZzKlKhKe2nKsqZxCZNz3ngQrS5GB1fBxH/6yqb3J
         lwckXlPpkqaBc/do5qNl5TcVOtTOUVyhAIMGcT3T9KauFfnOUnR0ZgnT7GS+vJOR15
         qyLgz358uOrWw==
Date:   Tue, 16 Aug 2022 16:12:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yang Wang <KevinYang.Wang@amd.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI/IOV: export pci_vf_drivers_autoprobe() symbol
Message-ID: <YvuX06cZ29mchQfi@unreal>
References: <20220805085639.1629653-1-KevinYang.Wang@amd.com>
 <Yu4iz9AsaUNcRqud@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu4iz9AsaUNcRqud@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 06, 2022 at 01:14:07AM -0700, Christoph Hellwig wrote:
> On Fri, Aug 05, 2022 at 04:56:39PM +0800, Yang Wang wrote:
> > make pci_vf_drivers_autoprobe() as export symbol.
> > 
> > the external module have no way to control vf autoprobe flag
> > before pf driver call pci_enable_sriov().
> 
> But this does not actually seem to be used by any potentially
> modular driver.

In addition, It is layer violation to control that flag from the driver.

Thanks
