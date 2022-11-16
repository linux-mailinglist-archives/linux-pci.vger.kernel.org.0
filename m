Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C162C73C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiKPSHa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPSHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:07:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE57EE1D
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 10:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3547C61F24
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 18:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE5FC433C1;
        Wed, 16 Nov 2022 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668622048;
        bh=NUy14LevLbBMbrFLo807zR9iFP7lXEIjP31jMLA38oY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WHRqjrwUdSFLMSUCahSYKP6FZs7PYfNwXJ5a2vy2Q5pqXHMtlf4qoJ/oOZ5SiNzHW
         2Lr1jG5SJi+m74fYDY2X3WrMoC2CoLmJ2N8DbBU+pE/U+Bsg12ezHB/6FAbNoPEJE6
         vNLFVGP52dcvsOyJRD+aA8t639OPjccVcmq+1XnDeFf7UMP9DfhvlHxT4g8X98Hqif
         NfCzdWmB2Wb+HaYzzuV2qHRS4dz/OCDqrdZalUhwCZ1GspC96nw7+dogc7lcFH90ha
         LWciEiiSCNjJ9Wpx56DyIRFSWP0T8ZANGHOB4JX7v1LTJBj/WXwniKHZhbnBkVq5Tg
         15FF+ErSLBXFA==
Date:   Wed, 16 Nov 2022 12:07:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Ming <ming4.li@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length
 miscalculation
Message-ID: <20221116180726.GA1126266@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116180250.GA1125709@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 12:02:50PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2022 at 09:56:37AM +0800, Li Ming wrote:
> > The value of data object length 0x0 indicates 2^18 dwords being
> > transferred. This patch adjusts the value of data object length for the
> > above case on both sending side and receiving side.
> > 
> > Besides, it is unnecessary to check whether length is greater than
> > SZ_1M while receiving a response data object, because length from LENGTH
> > field of data object header, max value is 2^18.
> > 
> > Signed-off-by: Li Ming <ming4.li@intel.com>
> 
> Applied with Reviewed-by from Jonathan and Lukas, thank you very much
> to all of you!

Oh, I forgot to mention, this is on a pci/doe branch, but if you need
to include this with other CXL work, just let me know, add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

and I'll drop it on my side.

Bjorn
