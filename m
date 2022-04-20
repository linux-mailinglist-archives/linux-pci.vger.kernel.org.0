Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27475080E4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 08:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiDTGR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 02:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiDTGR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 02:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935283914F;
        Tue, 19 Apr 2022 23:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A62F617B1;
        Wed, 20 Apr 2022 06:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA24C385A0;
        Wed, 20 Apr 2022 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650435281;
        bh=AzW2KIqt1TOZ3fJCJ2Qqg0c7UdQiexQ4mM1Brh5WZcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM518wF3K2I2N8/3dzm2b92zKZ/1gWeSPX21dePC//u82/sP5v74676cvktRn+MiV
         SSH5GtpRrRpuy4aSkBdw+JVzysGOhiG178kTI2ZbnRJWFBlylI7tl+zJGN+RoEX+N8
         Jum+KwTHyja8CnguAQKWlBhR8MdJtCJKjalICUIw=
Date:   Wed, 20 Apr 2022 08:14:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <Yl+kzdPG2EvAGCFG@kroah.com>
References: <20220412224348.1038613-1-tansuresh@google.com>
 <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALVARr6GNk=LCLaeaW87=UKPz+LtJFnuXbARkH44R+vs3E3S-Q@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 19, 2022 at 03:35:47PM -0700, Tanjore Suresh wrote:
> Hey,
> 
> I did not hear any comments on this v2 version. Please help me with your
> comments and approval so that this can be prepared for checkin.

Wait, there was comments, that you seem to have ignored.  Why?

