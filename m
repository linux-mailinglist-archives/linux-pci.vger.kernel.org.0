Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613EC7B21BE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjI1Ptj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjI1Pti (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 11:49:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318351A3
        for <linux-pci@vger.kernel.org>; Thu, 28 Sep 2023 08:49:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B3C433C7;
        Thu, 28 Sep 2023 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695916176;
        bh=bn1qN8pxYdmQwFPJKdPHk7NHOU17SjH43cMRTvcQRE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IqW9uDJ8JhCy5aB7mdava+YhBlNYbEcV6vaJVr8yASaDpNwekJJRhsqZVWoaJDxrd
         H9tBq5W7Bq+/kpYpc7wVEDkBIBBOPHJNnwu9NzaGPm/K6CTX1RevWu0CDhFEPI5QnT
         Uu3OARDjM9LDjrkotJR2R31e0PhuoroLchDet7MhYbOKuxB2Bk3iI1UJjWUiXZLMXx
         pBJ7EJqpRx7y5qQrsCcriMLBNB1OqRnnRBATiexjbESCoKBzilJBbAhIINwsl0lPSa
         hK75FQTnyzVmmi5f6UEZtjqJ4F1cbn6ULm5tPW7HwJ07VLVP3cnbje1Hq+Qo+4/dP0
         b7Avq+ixr4kmA==
Date:   Thu, 28 Sep 2023 10:49:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Kamil Paral <kparal@redhat.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        bhelgaas@google.com, chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20230928154934.GA484133@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928044233.GR3208943@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 28, 2023 at 07:42:33AM +0300, Mika Westerberg wrote:
> ...

> Only thing we are missing now is the result of Kamil's testing to see if
> the real uplug case is working. I would expect so, this is the issue we
> fixed with:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=pm&id=6786c2941fe1788035f99c98c932672138b3fbc5
> 
> If that's true then there is nothing more to be fixed, no hacks need to
> be put anywhere, and this discussion can be ended too.

Do we know how suspend/resume works with Windows in this
configuration?

Bjorn
