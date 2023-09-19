Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4839E7A63B1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjISMuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjISMuC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:50:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFCA99;
        Tue, 19 Sep 2023 05:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C8CC433C7;
        Tue, 19 Sep 2023 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695127797;
        bh=JUAIkivzZFdjelGUSm1sQTkEx/N2qNbb9nGvT13IC/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXwBUh4LoeHqJV4bFo4tzQERSFMfD1BzXyAsNY110PsvvxE856//bXnX0511Lqzxg
         LvmvOtWQQTF6c0FDLXiF13sw+gJuzoNt6j9iGN386/CP6FVoK8Lin5aYu5crlnnBmu
         MorFgaDy5AGCryX+g5x1Rfra1o7sKp8r+4zvYpes=
Date:   Tue, 19 Sep 2023 14:49:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dmitry.baryshkov@linaro.org, stable@vger.kernel.org,
        robimarko@gmail.com
Subject: Re: [PATCH V6] PCI: qcom: Fix broken pcie enumeration for 2_3_3
 configs ops
Message-ID: <2023091931-undermine-lethargic-e1cd@gregkh>
References: <20230919102948.1844909-1-quic_srichara@quicinc.com>
 <20230919121909.GF4732@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919121909.GF4732@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 02:19:09PM +0200, Manivannan Sadhasivam wrote:
> On Tue, Sep 19, 2023 at 03:59:48PM +0530, Sricharan Ramabadhran wrote:
> > PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for qcom_pcie_post_init_2_3_3.
> > PCIe slave address space size register offset is 0x358, but was wrongly
> > changed to 0x16c as a part of commit 39171b33f652 ("PCI: qcom: Remove
> > PCIE20_ prefix from register definitions"). Fixing it, by using the right
> > macro and remove the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> > 
> > Without this access to the registers of slave addr space like iATU etc
> > are broken leading to PCIe enumeration failure on IPQ8074.
> > 
> > Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> > Cc: <Stable@vger.kernel.org>
> 
> Please fix the stable list address: stable@vger.kernel.org

Either works!
