Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB5786B11
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjHXJEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjHXJEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 05:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516F4199A;
        Thu, 24 Aug 2023 02:04:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692867857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCMjIY4GzgEy46TDr3zke0Rgwv+ZthP+ksbKBkZYF4g=;
        b=0sSAGTftbTYFtXlp20olU+1Gsj8EH7c33ds2hE73tK5EyguAfOUXNItblb8m2CzEc/RIVA
        BTX+evvo5oHYoisahgumcXM79deUxq5Hl6abbFpKMjA5KjPzM3mznz2mRUFZ7+oSJ21R6e
        Gi37VgKhnekPPNGSIMg6u9qVz4PCzUAlENcw+SJq+aH3cta9nE5rp/Yr462qvLRRWyFwVb
        WBoiOyv7GKTmfWSgWFzyT7mV52dtJ7IWh21BcnFsidxb7i+uXrObB0pW5mEvCD4wh8UI1M
        QoaQOQPZT1NqPYOCg0Vh823Fk14Vfnxcczajqsn1cti6EUPHxOsd55ZZ/nk6mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692867857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCMjIY4GzgEy46TDr3zke0Rgwv+ZthP+ksbKBkZYF4g=;
        b=3G7HzwGxWw+wyu1+9cnBlG6vKpSDn0V+IY8uspaJDthWBjJymqqwNQpQ5+n0q7iz1jodX5
        sTlD3Ihzp5n2I2Ag==
To:     huangshaobo3@xiaomi.com
Cc:     bhelgaas@google.com, chenwei29@xiaomi.com, darwi@linutronix.de,
        huangshaobo3@xiaomi.com, jgg@ziepe.ca, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: Subject: [PATCH] pci/msi: remove redundant calculation in
 msi_setup_msi_desc
In-Reply-To: <1692862032-37839-1-git-send-email-huangshaobo3@xiaomi.com>
References: <87bkexetfk.ffs@tglx>
 <1692862032-37839-1-git-send-email-huangshaobo3@xiaomi.com>
Date:   Thu, 24 Aug 2023 11:04:16 +0200
Message-ID: <87o7iwdd67.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24 2023 at 00:27, huangshaobo3@xiaomi.com wrote:
> On Wed, 23 Aug 2023 16:15:27 +0200, Thomas Gleixner wrote:
>> I'm not seeing what this solves:
>
>> > -       if (control & PCI_MSI_FLAGS_64BIT)
>> > +       if (desc.pci.msi_attrib.is_64)
>
>> Both variants resolve to a test of a bit and a conditional instruction
>> on the result. It's exactly zero difference in terms of "calculation".
>
>> So all this does is change the memory location to test. Not more not
>> less. It does not generate better code and does not save anything.
>
> It may not be appropriate to write to eliminate duplicate calculations,
> can it be proposed again with clean code?

What's wrong with the existing code?
