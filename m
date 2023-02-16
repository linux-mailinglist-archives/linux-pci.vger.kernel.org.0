Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233269921F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBPKsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjBPKsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:48:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A396E4C6FC
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:47:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso3836658wms.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6cGhYejmXP7gqB3bw2vF3QoztsjWluwjTHj/jf8Uws=;
        b=PBc6KKJKbZ3iyuRUtK8YCSuz2fE2U0nOOKv4gwc5JAzo9KnzG6+tEIuW22y+Z2h7wp
         O2E9TmpoatjIsTIlnJq61rp4zXDmvAcTsgK40YWkbtzumnoCEzzAzc6/85UxzuTb9x/9
         /BfBOKANovWTBtZXk9OilYAVJ5aGUpoiBn4GM7jtLATZkeOSKi8q37Afn+W2Gyr+rhDf
         y++AW6LIt+arLfjfljiaK00eotTkGNULJn8dHQ7I6HLU/oIntHYrJdn0FRiaIWrofx2E
         7PQ627vGNKgpxZMxvVqNSn6IqfSqo/aKk65aLUZQvNmXTyeKELrBoN/tGX913VtXIGwC
         mD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6cGhYejmXP7gqB3bw2vF3QoztsjWluwjTHj/jf8Uws=;
        b=JzY516axaet20Yud+MXdsbE/8c4urWr+anCgj9mEu6sYoMMpvyKu6FByp+ss54ccIS
         SWm+xDhrIxb64crQTPlubQVxCjVfbYEsEJELDIbvr5wpMTgQk5PROPmqN1pHG/+MHtys
         pv7VijmN/f8qhpOsKAJGWEe8+xcecD3GrffVHJvjRGr5Xv3jWe/IWZrTi4ltSE7pOlUv
         ea3/2bHEkrgxTQ10Jm5P9vwsTrPwCJlKmUmciMudHh4ltuIMO9S9ZrRfgAzSPUOKzxpH
         Ks+3EMypFGOM0GE8KioEf57qsqTgrIwftonL/xWwWK+z246AweOY0EjF6yMjswmtxn3L
         lZDA==
X-Gm-Message-State: AO0yUKVGoReeJqdw832S+fDfcHS73A7w68xRd8zUr3tuskctmMVVosYB
        zq9hZFNPO5Qv//2cVujjvfrpPg==
X-Google-Smtp-Source: AK7set9j+Y/T2zdL7L9ZbqX0E7DPcvdQDA5CDDfLv72oFuHrrUchsK7J4Kv1ONGwlSnoCQ0pPMI9nQ==
X-Received: by 2002:a05:600c:1819:b0:3e0:10d:f1c with SMTP id n25-20020a05600c181900b003e0010d0f1cmr4459563wmp.37.1676544450857;
        Thu, 16 Feb 2023 02:47:30 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c290b00b003e215973a96sm977173wmd.16.2023.02.16.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:47:30 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:47:29 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+4JwV843tZWGxih@myrica>
References: <Y+ksmNWJdWNkGAU9@unreal>
 <20230215205726.GA3213227@bhelgaas>
 <Y+3al/a3HPrvfNgh@unreal>
 <Y+3fa/3HC1vsLRXa@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3fa/3HC1vsLRXa@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 09:46:51AM +0200, Leon Romanovsky wrote:
> On Thu, Feb 16, 2023 at 09:26:15AM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
> > > [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
> > > 
> > > On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
> > > > On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> > > > > As per PCIe specification(section 10.5), If a VF implements an
> > > > > ATS capability, its associated PF must implement an ATS capability.
> > > > > The ATS Capabilities in VFs and their associated PFs are permitted to
> > > > > be enabled independently.
> > > > > Also, it states that the Smallest Translation Unit (STU) for VFs must be
> > > > > hardwired to Zero and the associated PF's value applies to VFs STU.
> > > > > 
> > > > > The current code allows to enable ATS on VFs only if it is already
> > > > > enabled on associated PF, which is not necessary as per the specification.
> > > > > 
> > > > > It is only required to have valid STU programmed on PF to enable
> > > > > ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> > > > > when PFs ATS is not enabled.
> > > >
> > > > Can you please add here quotes from the spec and its version? I don't see
> > > > anything like this in my version of PCIe specification.

In PCIe r6.0, 10.5.1 ATS Extended Capability:

"The ATS Capabilities in VFs and their associated PFs are permitted to be
enabled independently."

> For VFs, this field must be hardwired to Zero. The associated PF's value applies.
> Default value is 0 0000b"

And this sentence indicates that the PF's STU should be configured
appropriately in order to use ATS in the VF.

So a driver is permitted to enable the VF ATS capability without enabling
the PF ATS cap, though the STU value of the PF cap still applies. But the
first sentence is weak ("permitted" instead of "required"), so as Joerg
said, some device implementations may still require to enable the PF cap
in order to enable the VF cap.

Maybe we could have a list of vendor:device IDs which allow enabling the
VF cap independently?

Thanks,
Jean
