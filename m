Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B055C1C8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbiF1GGj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbiF1GGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324B2315F;
        Mon, 27 Jun 2022 23:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A4161861;
        Tue, 28 Jun 2022 06:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1770AC3411D;
        Tue, 28 Jun 2022 06:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656396396;
        bh=Q3rlk/VjGtCIyeHgAcTX+dBcAyjfukbpCkgFdAUNBNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j177mRzNk+QH+cwF05/tUQQiM+MaTW+e8suFIlVwVSDIJNsadptiFKZsLUN3K2iRb
         ha32m5m5Gnon2aPkGA6lXxd932LiNLglFXy4HJEGe5waW18Jg009OOsQTwDNXmgOWp
         jIo8cmE4iO0j3nnvvXVIn4+wpX64pV8IbOkpVJtI=
Date:   Tue, 28 Jun 2022 08:06:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V12 5/9] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Message-ID: <YrqaaYwxdSKeowfz@kroah.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628041527.742333-6-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 09:15:23PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Many binary attributes need to limit access to CAP_SYS_ADMIN only; ie
> many binary attributes specify is_visible with 0400 or 0600.
> 
> Make setting the permissions of such attributes more explicit by
> defining BIN_ATTR_ADMIN_{RO,RW}.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

