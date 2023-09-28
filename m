Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A087B2784
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjI1V2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 17:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjI1V2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 17:28:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6BC19F;
        Thu, 28 Sep 2023 14:28:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2ECC433C9;
        Thu, 28 Sep 2023 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695936479;
        bh=oG15rWzQuTMZwy4r8BMtMTNBgXeakzWaG3G44Ogz5Hc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ecqYzacMYlsoPCYeyLSvWbRz716bMYzbrykMgjLb91xMxBr8Q47uh9OV63Ecy7NVY
         gIzXuIXUhrcOab3gRokbAFp8Ru5JYjBaESHZaENryhazYAelYRkhLCI0bqrsL6VMDj
         Eoh1b7CGagctEFpdNiGBn84lVXS/dN3BOG7/GNfVn0FAggGpEy7fBdED3C6ukO+6uO
         dZihjoWT9JCpbcrnAVhTN9PKTVvhM0FJSuSJHHj8mSSxB2uPASjn/O0uV17RhV/N5I
         xxV/1+ShYwpQgzHvWrZHpxTche5qmJJXOfA1gnYQURwa3YOj43XWBIYVz3qHOfDI7N
         P4bKMFGvTIKpQ==
Date:   Thu, 28 Sep 2023 16:27:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH v3 2/3] PCI: qcom-ep: Make use of PCIE_SPEED2MBS_ENC()
 macro for encoding link speed
Message-ID: <20230928212757.GA502911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928184808.GA12574@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 28, 2023 at 08:48:08PM +0200, Manivannan Sadhasivam wrote:
> On Wed, Sep 27, 2023 at 12:55:42PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 27, 2023 at 05:46:02PM +0200, Manivannan Sadhasivam wrote:
> > > Instead of hardcoding the link speed in MBps, let's make use of the
> > > existing PCIE_SPEED2MBS_ENC() macro that does the encoding of the
> > > link speed for us. Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW()
> > > macro to do the conversion to ICC speed.

> > > -	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
> > > +	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> > 
> > "1" is not very informative here.  Maybe PCIE_SPEED_2_5GT?  (I didn't
> > completely verify that this is equivalent.)
> 
> No. PCIE_SPEED_2_5GT is defined as 0x14 in pci.h. And I do not want to add a
> macro for just "1" here.

Is there no other existing macro that contains the 2.5GT/s hint?
