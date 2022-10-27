Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE460F5DB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiJ0LDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiJ0LDY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 07:03:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB57D2CF7
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 04:03:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so1032665pgc.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gfjSKorD+JpWUrkLdIO6Gmq1wfUKMg3BKpb3Fqtrl1A=;
        b=DaIsOYvWr/SW43ZSzs0tzVEdeKVybotiPfkw8dc7++/uhB0DBsH5RcBTreHj2F0b61
         u4mfnRLDwM0fMMfse6ImuMk3Kg0MxgnAmeKULMIHc3HnCc8KqC1VAmDFBioeBz+Lc8rn
         UGWxo7beG3Uwx2e4eJTwVxL/Vp56V8JYDB3RvyOApWulyiCDwK8OauX+grsQveyuJOnF
         GgnM8mZFpoZ6XeXTyM7yesl6gOpm7pLp2AH970wBptWHrFDAvyH1YXQxw7SEViVlN9QS
         yfOlNSdkj+9+iBinTpK7bRl41e8XPz567OS9l3OHH5a57J4MPBIsCqPz57YH8LJAJTdn
         59fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfjSKorD+JpWUrkLdIO6Gmq1wfUKMg3BKpb3Fqtrl1A=;
        b=jlb/0xBUG2r7UK3t2V6o6tdp8p6pq8qOTlzTfyghzQYX37PkgUn5eAbmiwiugb8tH7
         2ME3T9aYOyHGR2prQCBUxJ/1wjYWm+WRhtDEmSs8Vle8X7RPw7dP24DCL/mbs1G0Fdm0
         2dyedlsEn16NVleTVrWyRQozXaxYEIZG7B/nMcdAeYn4ZCzrtpBNz+8htG2ufPV05QRC
         GvIrHvc4aQMsQOsG+2hMM7K6eiROf1+I09sprGjW8G6kbNNh3WcZ3sOlYVH3Yo6JqJjN
         +ioXVxjkEc0zTVO/51V61HJEkSoo1YV7EdzhZjndlxG7kQrdTFHPE8lOkoOGWon3pnSf
         i+aA==
X-Gm-Message-State: ACrzQf2/pJ3HMyrC5Ei92ex4kKk8phtklbTJmY9NIgcMiNZBo/GM5i7R
        ceLvvq5kZYp9bT3n9Qx6G0/v
X-Google-Smtp-Source: AMsMyM4WciTiq9lWYxb+b0z06PCnnG2i3z6EXQh+vsgwgnDlZpAsB/p8cGH9rtNdKFTIP3jzKD62eQ==
X-Received: by 2002:a63:6a03:0:b0:43a:18ce:7473 with SMTP id f3-20020a636a03000000b0043a18ce7473mr43457431pgc.616.1666868603589;
        Thu, 27 Oct 2022 04:03:23 -0700 (PDT)
Received: from thinkpad ([117.202.186.162])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0018696c5d61esm954826plh.151.2022.10.27.04.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:03:22 -0700 (PDT)
Date:   Thu, 27 Oct 2022 16:33:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <treding@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20221027110316.GA76627@thinkpad>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <CAL_JsqLbr4O_BHb8s-Px4S0OOY23qhFkN32cKBctc_BFakSBzA@mail.gmail.com>
 <Y1pRtoLdWsDONsok@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1pRtoLdWsDONsok@lpieralisi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 11:39:02AM +0200, Lorenzo Pieralisi wrote:
> On Thu, Sep 15, 2022 at 09:16:27AM -0500, Rob Herring wrote:
> > On Wed, Sep 14, 2022 at 1:24 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 03:07:46PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> > > > > On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> > > > > > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > > > > > not having an endpoint connected to the slot is not an error.
> > > > > > > So, changing the macro from dev_err to dev_info to log the event.
> > > > > >
> > > > > > But the link up not happening is an actual error and -ETIMEDOUT is being
> > > > > > returned. So I don't think the log severity should be changed.
> > > > >
> > > > > Yes it is an error in the sense it is a timeout, but reporting an error
> > > > > because nothing is attached to a PCI slot seems a bit noisy. Please note
> > > > > that a similar change was made by the following commit and it also seems
> > > > > appropriate here ...
> > > > >
> > > > > commit 4b16a8227907118e011fb396022da671a52b2272
> > > > > Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > > Date:   Tue Jun 18 23:32:06 2019 +0530
> > > > >
> > > > >     PCI: tegra: Change link retry log level to debug
> > > > >
> > > > >
> > > > > BTW, we check for error messages in the dmesg output and this is a new error
> > > > > seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> > > > > error, but in this case it seem more appropriate to make this a info or
> > > > > debug level print.
> > > >
> > > > Can you tell whether there's a device present, e.g., via Slot Status
> > > > Presence Detect?  If there's nothing in the slot, I don't know why we
> > > > would print anything at all.  If a card is present but there's no
> > > > link, that's probably worthy of dev_info() or even dev_err().
> > > >
> > >
> > > I don't think all form factors allow for the PRSNT pin to be wired up,
> > > so we cannot know if the device is actually present in the slot or not all
> > > the time. Maybe we should do if the form factor supports it?
> > >
> > > > I guess if you can tell the slot is empty, there's no point in even
> > > > trying to start the link, so you could avoid both the message and the
> > > > timeout by not even calling dw_pcie_wait_for_link().
> > >
> > > Right. There is an overhead of waiting for ~1ms during boot.
> > 
> > Async probe should mitigate that, right? Saravana is working toward
> > making that the default instead of opt in, but you could opt in now.
> 
> I read this as "trying to bring the link up is mandatory because
> we can't detect an empty slot, therefore ~1ms delay during boot
> is unavoidable" and on that Rob's suggestion applies.
> 

Right. Rob's suggestion came as areply to my worry on waiting for link up
during boot.

> Just to understand where this thread is going. The suggestion
> above does not change the aim of this patch, that seems reasonable
> to me and it makes sense even if/when what Rob is suggesting is
> implemented.
> 
> Is that correct ?
> 

Yes, Rob's suggestion makes sense to me. And it has to be implemented as a
separate patch but this patch itself is required to demote the error log to
debug.

Thanks,
Mani

> Thanks,
> Lorenzo

-- 
மணிவண்ணன் சதாசிவம்
