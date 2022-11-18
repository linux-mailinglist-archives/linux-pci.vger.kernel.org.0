Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2662EA8C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 01:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiKRAuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 19:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKRAuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 19:50:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE074CE1;
        Thu, 17 Nov 2022 16:50:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7518B82259;
        Fri, 18 Nov 2022 00:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D8C433D6;
        Fri, 18 Nov 2022 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668732607;
        bh=YB0VTDTLdeMcVGmJnbUJT6TnuUos5PpaqgZkkvIjgAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=phYzzgW2g18bK0oC9PzOKmLPG8BhBhE48z9G5pD3tUOP6B/OaeViCXhEuGSpRjuYr
         /YBPHMY2D6KZPwM3EXukpmiNn0CJV0RHtF35vvJGkMvwcvgCogOLUu3uR2r8/FT4l9
         r03h9MrfVPa9TF+IYjJiqY7e94OVRHX0DlFpWfNk4ZW9w2xhUDkKyREH51GUFYT/Wo
         2fb6Gg8eDqVzyK8ZkYtRluBCNkH5J/1zcC7DB+DQzgHng5g9ktyxkP+u5+A63nhTqo
         3CK5T0c2FzP7fC17YCdBB2yKZTLoDFb/ddDE1JtuzByl6BEmo6XViST6/7qgoB988f
         Bxkee+hGlkDbg==
Date:   Thu, 17 Nov 2022 18:50:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <20221118005005.GA1234446@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3bM1NkVUhCe6/Vo@iweiny-mobl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 04:07:48PM -0800, Ira Weiny wrote:
> On Thu, Nov 17, 2022 at 04:05:24PM -0800, Ira wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> 
> Sorry about the extra pre-patches listed below.  They are not needed.
> ...

> > base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
> 
> This is correct.
> 
> > prerequisite-patch-id: dfea657e07f37aa9d7c3d477d68b07f64fe78721
> > prerequisite-patch-id: e27264e76e637214ee50cdab0e5854b223d44b4e
> 
> These are not needed...
> 
> Sorry, should I resend?

No worries, no need to resend it!

Bjorn
