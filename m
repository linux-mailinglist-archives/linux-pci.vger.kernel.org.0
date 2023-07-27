Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFD76498B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjG0H47 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 03:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjG0H4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 03:56:30 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E8E47;
        Thu, 27 Jul 2023 00:54:16 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E76993000A380;
        Thu, 27 Jul 2023 09:54:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C597613BBE7; Thu, 27 Jul 2023 09:54:14 +0200 (CEST)
Date:   Thu, 27 Jul 2023 09:54:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Fix destroy_work_on_stack() race
Message-ID: <20230727075414.GA29643@wunner.de>
References: <20230726-doe-fix-v1-1-af07e614d4dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-doe-fix-v1-1-af07e614d4dd@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 11:29:42AM -0700, Ira Weiny wrote:
> The following debug object splat was observed in testing.
[...]
> This occurs because destroy_work_on_stack() was called after signaling
> the completion in the calling thread.  This creates a race between
> destroy_work_on_stack() and the task->work struct going of scope in the
> pci_doe().
> 
> Signal the work complete after destroying the work struct.  This is safe
> because signal_task_complete() is the final thing the work item does and
> the workqueue code is careful not to access the work struct after.
> 
> Fixes: abf04be0e707 ("PCI/DOE: Fix memory leak with CONFIG_DEBUG_OBJECTS=y")
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks for catching this.  The offending commit abf04be0e707 was applied
by Dan.  Not sure if that means he's going to apply this fix as well?
Would require an ack from Bjorn in that case.  Or Bjorn applies it.

Thanks,

Lukas
