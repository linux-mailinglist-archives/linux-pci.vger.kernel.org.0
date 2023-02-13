Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27828694FA7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 19:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBMSqx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 13:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMSqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 13:46:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C2D1C58F;
        Mon, 13 Feb 2023 10:46:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DG/YHFOjMURtXqdamtgmYShJo+wF2f98tUavHFx54+c=;
        b=O2BG4BKLutfEOdkyUTXeYw9wJNERnS+DwHWEQEOGTCgt54RBsR1H+N+U4+SAh3N07LKDDP
        0/OXGBy2CcCNMLy15dJjQ46emmIMQbFnGQ7B/dZsC7+Q8F0tBNlUPy46Xsx3cPN4JI3rOy
        OT4VGS0sNMRNa+o3qfNncFQNBWT39HhO/tcTFSQ+vKlbT9qnYtEmCfl6o4UbBS+R4L6t7V
        kDJb+g9iez8pDhZzYOMmeiFKV3RztFzaGicVWtks/Z9SgRF9y7EnoEJ5zVFqy3G6haE+ZK
        EXbo/7QvxNgQZSS8E/G6ait4Git6RxkrfkbfCJQ0Wze1iKvt/6JlDfDFWs9RNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DG/YHFOjMURtXqdamtgmYShJo+wF2f98tUavHFx54+c=;
        b=YRZdTJTE5M3Ly5D0xBpCAZbhLWPeV5OESOrwz+F9b9Lt+Wpu0n7mZS1is6fyii6VyBho2p
        IenI9nGKgik+LcCA==
To:     ALOK TIWARI <alok.a.tiwari@oracle.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kevin.tian@intel.com, darwi@linutronix.de
Subject: Re: [External] : Re: [PATCH] PCI: Fix build error when
 CONFIG_PCI_MSI disabled
In-Reply-To: <5945f254-0581-093b-168d-8cf2c0a34eab@oracle.com>
References: <158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com>
 <333dee5b-6710-998c-bf3f-2cb1d676a7da@oracle.com>
 <af294def-fff7-469c-b8c6-a245ba641c2c@intel.com>
 <5945f254-0581-093b-168d-8cf2c0a34eab@oracle.com>
Date:   Mon, 13 Feb 2023 19:46:49 +0100
Message-ID: <87cz6dtnc6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alok!

On Sat, Feb 11 2023 at 10:35, ALOK TIWARI wrote:

Please do not top-post and trim your replies.

  https://people.kernel.org/tglx/notes-about-netiquette

> if, new function going to part of #else case . that is absolutely fine.
> but that is not present in given PATCH.

Care to apply the patch and look where the stub functions are placed
instead of making uninformed claims?

Thanks,

        tglx
