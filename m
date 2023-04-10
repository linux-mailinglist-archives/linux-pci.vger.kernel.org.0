Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F16DC3AF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 08:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDJGuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDJGuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 02:50:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416F359C
        for <linux-pci@vger.kernel.org>; Sun,  9 Apr 2023 23:50:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681109421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxH5az8ZcZbr4cxtmxv7AYVV5tnKtAP05nuY2o53Ka4=;
        b=PToI8+Bi6beJUUj+45b1LIgSKykfxy5NC5gq8I3F1FvpJVHMeJHQqCBrDy8hSM0WCbzqMc
        u0ifWbnHj6SEYkiomp8Idxuuoww7jGC1V5H1ZSfXqunvLVidBN6qof5lOXGPuVvP5rnH8R
        sQh0ky+7kRKgdo/aFLsPPKfsXGiwekkS/+922CqD7FNLsSNfLTv55zqfVxl+79LbS98fhv
        9eRrZDpeRHLmFJPQHFEhSdj5B14EtwQSfJVN0DUESv1BLVrYZ2/RQYsPc8Vh/bVgEmv2lS
        tlyg5v9UQp7BeH1rZmayMfG3AFlP3h6hNmPmr3iC0gceN2X/5rKWsfsjFJV9Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681109421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxH5az8ZcZbr4cxtmxv7AYVV5tnKtAP05nuY2o53Ka4=;
        b=6BxUtbe46+UJjHY3XV2jRANpwC4khayD1ACl4fiFhaFY8KReN3qrf4sKBhEEuyufwgjlWa
        TyaMg+wX+OsjogDQ==
To:     David Laight <David.Laight@ACULAB.COM>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe cycle sequence when updating the msi-x table
In-Reply-To: <ed0017284c324cf68f05a20ac86b7b35@AcuMS.aculab.com>
References: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
 <87edovtqki.ffs@tglx> <ed0017284c324cf68f05a20ac86b7b35@AcuMS.aculab.com>
Date:   Mon, 10 Apr 2023 08:50:20 +0200
Message-ID: <875ya4temr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 07 2023 at 22:06, David Laight wrote:
> From: Thomas Gleixner
>> Sent: 07 April 2023 20:56
>> So the devices gets:
>> 
>>    1) write to control register with MASKBIT set
>>    2) write to LOWER_ADDRESS
>>    3) write to UPPER_ADDRESS
>>    4) write to ENTRY_DATA
>>    5) write to control register with MASKBIT cleared
>> 
>> #1 disables the vector and the device is not allowed to use the msg data
>> from the table entry until the mask bit is cleared again.
>> 
>> If the device gets that wrong then that's a bug in the device and not a
>> kernel problem.
>
> Maybe, but the kernel isn't making it easy for a device
> state-engine that has to do four separate reads of an
> internal 32-bit memory area.
> Adding a short delay between #4 and #5 is likely to avoid
> some very hard to debug issues if the hardware reads the
> values 'mask last', if it reads them 'mask first' you need
> a short delay between #1 and #2.

Whatever order this reads does not matter. The point is:

  "Mask Bit - When this bit is Set, the Function is prohibited from
   sending a message using this MSI-X Table entry."

So you cannot make this read order dependent at all.

> Anything fpga based is likely to be using a 32bit memory
> block for the MSI-X data (possibly even 16bit).

It's trivial enough to latch the message on unmask into a shadow
register set and let the state engine work from there.

And no, we are not adding random delays to that code just because.

Thanks,

        tglx
