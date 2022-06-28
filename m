Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449055E810
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiF1O4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiF1O4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:56:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D410418349;
        Tue, 28 Jun 2022 07:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83DA7B81E1B;
        Tue, 28 Jun 2022 14:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0142C3411D;
        Tue, 28 Jun 2022 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656428180;
        bh=mVzzMEAfWq4CSbWzqcGpKfCdP78RtQQxz+oi0B4fEXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YsBP98h4ZsHg+V7MTibcOYA61KaNwLT1dT0TwkbiVcSyFSFG+4sfStolVypYzFiTv
         fFS1bQmREgmnqRj3HPBEcKAn7A6U6goZP6hmXT0nnNav3Pn/mQBB5HvmqJlT8nr1Qa
         KnmffLDr15bNbgInfifu6GOT438FE/d3kKbYw6eu+HLR3V9+u7WbFGP7G57H7ov3kL
         N72uo9ds5lo8rxtZ9Vj1eDeLX1S+MzI4MHAq9HlqLd2EgFNMgQNWVXVg8RrqV35CuQ
         e1iDW+PF4duOvQ26+JwpI0pQzQaBDeOQnK9LMstGJbDKVQrdNXHxj3lAYsC5zFXsi+
         +VjVSLvzLvY2w==
Date:   Tue, 28 Jun 2022 09:56:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <20220628145618.GA1837416@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628151626.00001c0f@Huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:16:26PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:21 -0700
> ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > +	/* Abort has timed out and the MB is dead */
> > +	pci_err(pdev, "[%x] ABORT timed out\n", offset);
> 
> Does this print mention it's a DOE somewhere? 

It does because of this earlier mention:

> > +#define dev_fmt(fmt) "DOE: " fmt

