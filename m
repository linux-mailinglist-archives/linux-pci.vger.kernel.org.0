Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B95AB98B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIBUnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIBUnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 16:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5A1F2CB;
        Fri,  2 Sep 2022 13:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 979C861128;
        Fri,  2 Sep 2022 20:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D9FC433C1;
        Fri,  2 Sep 2022 20:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662151403;
        bh=sFgwkZAnwk7QAgBhvDKCIIByUMBmnTm9+Fc7N749K5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MgweByj5kxsiVit5F6RC8zyow6hXyNld89sh8GcHeoz3MHAPCD7Q64Q2ArSkPse5g
         YRsn8z4bRW4iqo9nUTq4q7UcBHkwlXUeqiXh0ZStKvy+7K5VQbFr6sMR3/TgITNBgw
         EZLN08zaKR49/Ug2Lgj9JyaH1GsKZ0h77dc3w5N1FiBDaa111YE1VhSDCfu2rs5u0a
         Ix5hpyg/kRIq3w0Ct4mKWDcVYWg5v+LuChnLH402CKyAFflreL0dEtslm1Jocs5k4o
         CpR+1Z5jtnRYLQb7IXoMYzj1nQHzxyArtXNb3ZaDAximrgUn10KtiG5s9dpRTeKX/Q
         +rdKiSiAWdUnQ==
Date:   Fri, 2 Sep 2022 15:43:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, clement.leger@bootlin.com,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com, trix@redhat.com
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Message-ID: <20220902204321.GA374266@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 02:43:35PM -0700, Lizhi Hou wrote:

> Clément Léger (1):
>   of: dynamic: add of_node_alloc()
> 
> Lizhi Hou (1):
>   pci: create device tree node for selected devices

Please capitalize both subject lines to match previous history of the
files involved.
